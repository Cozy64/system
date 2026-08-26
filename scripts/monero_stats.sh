#!/bin/bash

HASH_CACHE="/tmp/waybar_xmr_last_hash.txt"

# 1. Fetch mining pool data
POOL_DATA=$(curl -s --max-time 5 'https://api.moneroocean.stream/miner/83MjsQx67bRHnugB8EQBUPGBKxnSdBvnsiLJCtycwwvj88G17s7n7wLTmxJDabChzC4JgevZaae9G1R5mPvgDd752JSpQhf/stats')

# Check if data exists and is valid JSON
if [ -z "$POOL_DATA" ] || ! echo "$POOL_DATA" | jq -e . >/dev/null 2>&1 || [ "$(echo "$POOL_DATA" | jq -r '.error // empty')" != "" ]; then
    echo '<span foreground="#888888">None</span>'
    exit 0
fi

AMT_DUE=$(echo "$POOL_DATA" | jq -r 'if .amtDue != null then (.amtDue/1000000000000 | tostring)[0:8] else empty end' 2>/dev/null)
HASH_RATE=$(echo "$POOL_DATA" | jq -r 'if .hash2 != null then (.hash2 | tostring)[0:7] else empty end' 2>/dev/null)

# Fallback to "None" if required fields are missing
if [ -z "$AMT_DUE" ] || [ -z "$HASH_RATE" ]; then
    echo '<span foreground="#888888">None</span>'
    exit 0
fi

# Default colors
DUE_COLOR="#DDDD00"
HASH_COLOR="#888888"

# 2. Process Hash Rate Colors (Previous vs Current)
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

# 3. Output to Waybar
echo "<span foreground=\"$DUE_COLOR\">XMR $AMT_DUE</span> <span foreground=\"$HASH_COLOR\">$HASH_RATE H/s</span>"
