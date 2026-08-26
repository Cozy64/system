#!/bin/bash

CACHE="/tmp/waybar_crypto.cache"

# 1. Fetch XMR/USD and SOL/USD ticker data from Kraken
read xmr_raw sol_raw <<< $(curl -s "https://api.kraken.com/0/public/Ticker?pair=XMRUSDC,SOLUSDC" | \
  jq -r '
    [
      .result.XMRUSDC.c[0],
      .result.SOLUSDC.c[0]
    ] | @tsv
  ')

# Fallback if curl/API fails
xmr_raw=${xmr_raw:-None}
sol_raw=${sol_raw:-None}

# 2. Read previous prices
prev_xmr=$xmr_raw
prev_sol=$sol_raw

if [ -f "$CACHE" ]; then
  read prev_xmr prev_sol < "$CACHE"
fi

# 3. Compare prices, assign colors, and format display
read c_xmr xmr_disp <<< $(LC_ALL=C awk \
  -v n="$xmr_raw" -v o="$prev_xmr" \
  'BEGIN {
    if(n=="None")
      printf "#888888 None";
    else
      printf "%s $%.0f",
        (n==o ? "#888888" : (n>o ? "#00dd00" : "#dd0000")),
        n
  }')

read c_sol sol_disp <<< $(LC_ALL=C awk \
  -v n="$sol_raw" -v o="$prev_sol" \
  'BEGIN {
    if(n=="None")
      printf "#888888 None";
    else
      printf "%s $%.2f",
        (n==o ? "#888888" : (n>o ? "#00dd00" : "#dd0000")),
        n
  }')

# 4. Save current prices
if [ "$xmr_raw" != "None" ] && [ "$sol_raw" != "None" ]; then
  echo "$xmr_raw $sol_raw" > "$CACHE"
fi

# 5. Output Waybar JSON
printf '{"text":"XMR <span color=\\"%s\\">%s</span> SOL <span color=\\"%s\\">%s</span>", "tooltip":"XMR: %s | SOL: %s", "class":"crypto"}\n' \
  "$c_xmr" "$xmr_disp" \
  "$c_sol" "$sol_disp" \
  "$xmr_disp" "$sol_disp"
