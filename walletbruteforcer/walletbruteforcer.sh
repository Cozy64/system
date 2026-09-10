#!/usr/bin/env bash
set -euo pipefail

RESULTS_FILE="./solana_matches.txt"
PROCESSED_FILE="${RESULTS_FILE}.processed"
DRY_RUN=0
THREADS=1
REVERSE_ORDER=0
RANDOMIZE_SEARCH=1
RESET_PROCESSED=0
WORDLIST_PATH=""
declare -a CHILD_PIDS=()
declare -a WORDS=()
for i in $(seq 1 12); do
    WORDS[$i]=""
done

cleanup_and_exit() {
    local pid
    echo ""
    echo "Interrupt received. Stopping worker processes..."
    for pid in "${CHILD_PIDS[@]}"; do
        kill "$pid" 2>/dev/null || true
    done
    wait 2>/dev/null || true
    exit 130
}

trap cleanup_and_exit INT TERM

usage() {
    cat <<'USAGE'
Usage: ./test2.sh [-w "word" -p 1] ... [-l /path/to/wordlist.txt] [--dry-run] [-t 8] [-r]

Examples:
  ./test2.sh -w "clay" -p 1 -w "mango" -p 2 -w "apple" -p 3 \
    -w "silver" -p 4 -w "gold" -p 5 -w "storm" -p 6 \
    -w "planet" -p 7 -w "river" -p 8 -w "oak" -p 9 \
    -w "ember" -p 10 -w "cabin" -p 11 -w "dance" -p 12

  ./test2.sh -w "clay" -p 1 -l /path/to/bip39.txt --dry-run -t 16 -r

Options:
  -w, --word       A mnemonic word to insert
  -p, --position   Position 1-12 for the corresponding word
  -l, --wordlist   File containing candidate words for any missing positions
  -t, --threads    Number of worker threads to run in parallel (default: 1)
  -r, --reverse    Read the wordlist in reverse order (last to first)
  --dry-run        Print each generated combination without running Solana
  -h, --help       Show this help message
USAGE
}

add_word_at_position() {
    local position="$1"
    local word="$2"

    if ! [[ "$position" =~ ^([1-9]|1[0-2])$ ]]; then
        echo "Position must be between 1 and 12, got: $position"
        exit 1
    fi

    WORDS[$position]="$word"
}

build_seed() {
    local seed=""
    local i
    for i in $(seq 1 12); do
        local value="${WORDS[$i]:-}"
        if [[ -n "$seed" ]]; then
            seed+=" "
        fi
        seed+="$value"
    done
    printf '%s' "$seed"
}

run_seed() {
    local seed="$1"
    local keyfile

    echo ""
    echo "Trying seed: $seed"

    if [[ "$DRY_RUN" -eq 1 ]]; then
        printf '%s\n' "$seed"
        return 0
    fi

    if ! command -v solana >/dev/null 2>&1; then
        echo "solana CLI is not installed or not in PATH."
        exit 1
    fi
    if ! command -v expect >/dev/null 2>&1; then
        echo "expect is not installed or not in PATH."
        exit 1
    fi

    keyfile=$(mktemp "/tmp/solana-key.XXXXXX.json")
    seedfile=$(mktemp "/tmp/seed.XXXXXX.txt")
    printf '%s\n' "$seed" > "$seedfile"
    export KEYFILE="$keyfile"
    export SEEDFILE="$seedfile"

    expect <<'EOF_EXPECT'
set timeout 15
log_user 1

spawn solana-keygen recover "prompt:?key=0/0" --force --outfile $env(KEYFILE)

expect {
    -re "Can't get mnemonic from seed phrases" {
        exec rm -f $env(KEYFILE)
        puts stderr "SKIP invalid mnemonic"
        exit 0
    }
    -re "seed phrase:" {
        set fp [open $env(SEEDFILE) r]
        set seed_phrase [string trim [read $fp]]
        close $fp
        send -- "$seed_phrase\r"
        exp_continue
    }
    -re "If this seed phrase has an associated passphrase, enter it now. Otherwise, press ENTER to continue:" {
        send -- "\r"
        exp_continue
    }
    -re "ENTER to continue:" {
        send -- "\r"
        exp_continue
    }
    -re "Continue\\? \\(y/n\\):" {
        send -- "y\r"
        exp_continue
    }
    -re "Recovered pubkey .*" {
        exp_continue
    }
    eof
}
EOF_EXPECT

    if [[ -s "$keyfile" ]] && solana-keygen pubkey "$keyfile" >/dev/null 2>&1; then
        echo "✅ Keyfile created: $keyfile"
        PUBKEY=$(solana-keygen pubkey "$keyfile")
        echo "Pubkey: $PUBKEY"
        BALANCE=$(solana balance "$PUBKEY")
        echo "$BALANCE"

        if [[ "$BALANCE" =~ ^[[:space:]]*([0-9]+(\.[0-9]+)?)[[:space:]]*SOL[[:space:]]*$ ]]; then
            SOL_VALUE="${BASH_REMATCH[1]}"
            if (( $(echo "$SOL_VALUE >= 0.001" | bc -l) )); then
                printf '%s | %s | %s\n' "$seed" "$PUBKEY" "$BALANCE" >> "$RESULTS_FILE"
                echo "✅ Wrote qualifying balance to $RESULTS_FILE"
            fi
        fi

        rm -f "$keyfile"
    else
        echo "SKIP invalid or non-mnemonic seed; no usable keyfile"
        rm -f "$keyfile"
    fi
    rm -f "$seedfile"
}

claim_seed() {
    local seed="$1"
    local lockfile="${PROCESSED_FILE}.lock"

    touch "$PROCESSED_FILE" 2>/dev/null || true

    (
        flock -x 9
        if grep -Fxq -- "$seed" "$PROCESSED_FILE" 2>/dev/null; then
            return 1
        fi
        printf '%s\n' "$seed" >> "$PROCESSED_FILE"
        return 0
    ) 9>"$lockfile"
}

read_wordlist() {
    local file_path="$1"
    local ordered_output

    if [[ "$REVERSE_ORDER" -eq 1 ]]; then
        ordered_output=$(tac "$file_path")
    else
        ordered_output=$(cat "$file_path")
    fi

    if [[ "$RANDOMIZE_SEARCH" -eq 1 ]] && command -v shuf >/dev/null 2>&1; then
        printf '%s\n' "$ordered_output" | shuf
    else
        printf '%s\n' "$ordered_output"
    fi
}

generate_combinations_from_index() {
    local index="${1:-0}"
    local source_file="${2:-$WORDLIST_PATH}"

    if [[ "$index" -ge "${#MISSING_POSITIONS[@]}" ]]; then
        local seed
        seed=$(build_seed)
        if [[ -n "$seed" ]] && ! claim_seed "$seed"; then
            return
        fi
        if [[ -n "$seed" ]]; then
            run_seed "$seed"
        fi
        return
    fi

    local position="${MISSING_POSITIONS[$index]}"
    while IFS= read -r word; do
        [[ -z "$word" ]] && continue
        WORDS[$position]="$word"
        if [[ "$index" -eq 0 ]]; then
            generate_combinations_from_index $((index + 1)) "$WORDLIST_PATH"
        else
            generate_combinations_from_index $((index + 1)) "$source_file"
        fi
    done < <(read_wordlist "$source_file")

    WORDS[$position]=""
}

process_wordlist_chunk() {
    local chunk_file="$1"
    local first_missing_position="${MISSING_POSITIONS[0]}"

    while IFS= read -r word; do
        [[ -z "$word" ]] && continue
        WORDS[$first_missing_position]="$word"
        generate_combinations_from_index 1 "$WORDLIST_PATH"
    done < <(read_wordlist "$chunk_file")

    WORDS[$first_missing_position]=""
}

parallel_generate() {
    local total_words=0
    local line
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        total_words=$((total_words + 1))
    done < <(read_wordlist "$WORDLIST_PATH")

    if [[ "$total_words" -eq 0 ]]; then
        echo "Wordlist is empty."
        exit 1
    fi

    local chunk_size=$(( (total_words + THREADS - 1) / THREADS ))
    local file_index=0
    local chunk_file
    local temp_dir
    temp_dir=$(mktemp -d)

    local chunk_lines=()
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        chunk_lines+=("$line")
        if [[ ${#chunk_lines[@]} -ge $chunk_size ]]; then
            chunk_file="$temp_dir/chunk_${file_index}.txt"
            printf '%s\n' "${chunk_lines[@]}" > "$chunk_file"
            chunk_lines=()
            file_index=$((file_index + 1))
        fi
    done < <(read_wordlist "$WORDLIST_PATH")

    if [[ ${#chunk_lines[@]} -gt 0 ]]; then
        chunk_file="$temp_dir/chunk_${file_index}.txt"
        printf '%s\n' "${chunk_lines[@]}" > "$chunk_file"
        file_index=$((file_index + 1))
    fi

    local pids=()
    for chunk_file in "$temp_dir"/*.txt; do
        [[ -e "$chunk_file" ]] || continue
        process_wordlist_chunk "$chunk_file" &
        local worker_pid=$!
        CHILD_PIDS+=("$worker_pid")
        pids+=("$worker_pid")
        if [[ ${#pids[@]} -ge $THREADS ]]; then
            wait -n
        fi
    done

    for pid in "${pids[@]}"; do
        wait "$pid"
    done

    rm -rf "$temp_dir"
    CHILD_PIDS=()
}

WORD=""
POSITION=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        -w|--word)
            [[ $# -lt 2 ]] && { echo "Missing value for $1"; usage; exit 1; }
            WORD="$2"
            shift 2
            ;;
        -p|--position)
            [[ $# -lt 2 ]] && { echo "Missing value for $1"; usage; exit 1; }
            POSITION="$2"
            shift 2
            ;;
        -l|--wordlist)
            [[ $# -lt 2 ]] && { echo "Missing value for $1"; usage; exit 1; }
            WORDLIST_PATH="$2"
            shift 2
            ;;
        -t|--threads)
            [[ $# -lt 2 ]] && { echo "Missing value for $1"; usage; exit 1; }
            THREADS="$2"
            shift 2
            ;;
        -r|--reverse)
            REVERSE_ORDER=1
            shift
            ;;
        --reset-processed)
            RESET_PROCESSED=1
            shift
            ;;
        --dry-run)
            DRY_RUN=1
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            exit 1
            ;;
    esac

    if [[ -n "$WORD" && -n "$POSITION" ]]; then
        add_word_at_position "$POSITION" "$WORD"
        WORD=""
        POSITION=""
    fi
done

if [[ -n "$WORD" || -n "$POSITION" ]]; then
    echo "Each -w must be paired with a -p value."
    usage
    exit 1
fi

if [[ "$RESET_PROCESSED" -eq 1 ]]; then
    rm -f "$PROCESSED_FILE" "${PROCESSED_FILE}.lock"
    echo "Reset processed mnemonic cache: $PROCESSED_FILE"
fi

echo "Mnemonic word variables:"
for i in $(seq 1 12); do
    VALUE="${WORDS[$i]:-}"
    if [[ -z "$VALUE" ]]; then
        echo "WORD_${i}=MISSING"
    else
        echo "WORD_${i}=${VALUE}"
    fi
done

MISSING_POSITIONS=()
for i in $(seq 1 12); do
    if [[ -z "${WORDS[$i]:-}" ]]; then
        MISSING_POSITIONS+=("$i")
    fi
done

if [[ ${#MISSING_POSITIONS[@]} -gt 0 ]]; then
    if [[ -z "$WORDLIST_PATH" ]]; then
        for candidate in /usr/share/dict/words /usr/share/dict/web2 /usr/share/dict/american-english /usr/share/dict/british-english; do
            if [[ -f "$candidate" ]]; then
                WORDLIST_PATH="$candidate"
                break
            fi
done
    fi

    if [[ -z "$WORDLIST_PATH" || ! -f "$WORDLIST_PATH" ]]; then
        echo ""
        echo "No words file was found for the missing positions."
        echo "Supply a word list with -l /path/to/wordlist.txt"
        exit 1
    fi

    if ! [[ "$THREADS" =~ ^[1-9][0-9]*$ ]]; then
        echo "Thread count must be a positive integer, got: $THREADS"
        exit 1
    fi

    echo ""
    echo "Using wordlist: $WORDLIST_PATH"
    echo "Missing positions: ${MISSING_POSITIONS[*]}"
    echo "Threads: $THREADS"
    if [[ "$REVERSE_ORDER" -eq 1 ]]; then
        echo "Wordlist order: reverse"
    else
        echo "Wordlist order: normal"
    fi
    echo "Generating every combination for the blank slots..."

    if [[ "$THREADS" -gt 1 ]]; then
        parallel_generate
    else
        generate_combinations_from_index 0
    fi
    exit 0
fi

SEED=$(build_seed)
run_seed "$SEED"
