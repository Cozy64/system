#!/bin/bash

HASH_CACHE="/tmp/waybar_xmr_last_hash.txt"
WALLET="83MjsQx67bRHnugB8EQBUPGBKxnSdBvnsiLJCtycwwvj88G17s7n7wLTmxJDabChzC4JgevZaae9G1R5mPvgDd752JSpQhf"

# 1. Fetch mining pool data
POOL_DATA=$(curl -s --max-time 5 "https://api.moneroocean.stream/miner/$WALLET/stats")

# Check if pool stats exist and is valid JSON
if [ -z "$POOL_DATA" ] || ! echo "$POOL_DATA" | jq -e . >/dev/null 2>&1 || [ "$(echo "$POOL_DATA" | jq -r '.error // empty')" != "" ]; then
    echo '<span foreground="#888888">None</span>'
    exit 0
fi

AMT_DUE=$(printf "%.6f" "$(echo "$POOL_DATA" | jq -r '.amtDue // 0')e-12" 2>/dev/null)
HASH_RATE=$(echo "$POOL_DATA" | jq -r 'if .hash2 != null then (.hash2 | tostring)[0:7] else empty end' 2>/dev/null)

# Fallback to "None" if required fields are missing
if [ -z "$AMT_DUE" ] || [ -z "$HASH_RATE" ]; then
    echo '<span foreground="#888888">None</span>'
    exit 0
fi

# 2. Fetch worker count (excluding global)
WORKERS_DATA=$(curl -s --max-time 5 "https://api.moneroocean.stream/miner/$WALLET/stats/allWorkers")
WORKER_COUNT=$(echo "$WORKERS_DATA" | jq -r 'if type == "object" then (del(.global) | length) else 0 end' 2>/dev/null)
WORKER_COUNT=${WORKER_COUNT:-0}

# Default colors
DUE_COLOR="#DDDD00"
HASH_COLOR="#888888"
WORKER_COLOR="#DDDDDD"

# 3. Process Hash Rate Colors (Previous vs Current)
if [ -f "$HASH_CACHE" ] && [ -s "$HASH_CACHE" ]; then
    LAST_HASH=$(cat "$HASH_CACHE")
    if [ -n "$LAST_HASH" ]; then
        IS_HASH_GT=$(echo "$HASH_RATE > $LAST_HASH" | bc -l 2>/dev/null)
        IS_HASH_LT=$(echo "$HASH_RATE < $LAST_HASH" | bc -l 2>/dev/null)

        if [ "$IS_HASH_GT" = "1" ]; then HASH_COLOR="#00DD00"; fi # Up -> Green
        if [ "$IS_HASH_LT" = "1" ]; then HASH_COLOR="#DD0000"; fi # Down -> Red
    fi
fi
echo "$HASH_RATE" > "$HASH_CACHE"

# 4. Output to Waybar
echo "<span foreground=\"$DUE_COLOR\">XMR $AMT_DUE</span> <span foreground=\"$HASH_COLOR\">$HASH_RATE H/s</span> <span foreground=\"$WORKER_COLOR\">($WORKER_COUNT W)</span>"
