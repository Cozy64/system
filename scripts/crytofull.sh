#!/bin/bash

# 1. Define mints and the cache file
b="cbbtcf3aa214zXHbiAZQwf4122FBYbraNdFqgw4iMij"
e="7vfCXTUXx5WJV5JADk17DUJ4ksgau7utNKj4b963voxs"
s="So11111111111111111111111111111111111111112"
CACHE="/tmp/waybar_crypto.cache"

# 2. Fetch raw data (unrounded so we can detect even fractional cent changes)
# Changed jq fallback from 0 to "None"
read b_raw e_raw s_raw <<< $(curl -s "https://api.jup.ag/price/v3?ids=$b,$e,$s" | \
  jq -r --arg b "$b" --arg e "$e" --arg s "$s" \
  '[ (.[$b].usdPrice // "None"), (.[$e].usdPrice // "None"), (.[$s].usdPrice // "None") ] | @tsv')

# Fallback if curl entirely fails
b_raw=${b_raw:-None}; e_raw=${e_raw:-None}; s_raw=${s_raw:-None}

# 3. Read previous prices if the cache file exists
prev_b=$b_raw; prev_e=$e_raw; prev_s=$s_raw
if [ -f "$CACHE" ]; then
  read prev_b prev_e prev_s < "$CACHE"
fi

# 4. Compare prices, assign colors, and round for display using awk
# Added equality check (n==o) for white, and "None" check
read c_btc btc_disp <<< $(LC_ALL=C awk -v n="$b_raw" -v o="$prev_b" 'BEGIN { if(n=="None") printf "#888888 None"; else printf "%s $%.0f", (n==o?"#888888":(n>o?"#00dd00":"#dd0000")), n }')
read c_eth eth_disp <<< $(LC_ALL=C awk -v n="$e_raw" -v o="$prev_e" 'BEGIN { if(n=="None") printf "#888888 None"; else printf "%s $%.0f", (n==o?"#888888":(n>o?"#00dd00":"#dd0000")), n }')
read c_sol sol_disp <<< $(LC_ALL=C awk -v n="$s_raw" -v o="$prev_s" 'BEGIN { if(n=="None") printf "#888888 None"; else printf "%s $%.4f", (n==o?"#888888":(n>o?"#00dd00":"#dd0000")), n }')

# 5. Save the current raw prices to the cache for the next run (only if valid)
if [ "$b_raw" != "None" ]; then
  echo "$b_raw $e_raw $s_raw" > "$CACHE"
fi

# 6. Output Waybar JSON (removed $ from here since awk provides it now)
printf '{"text":"BTC <span color=\\"%s\\">%s</span> ETH <span color=\\"%s\\">%s</span> SOL <span color=\\"%s\\">%s</span>", "tooltip":"BTC: %s | ETH: %s | SOL: %s", "class":"crypto"}\n' "$c_btc" "$btc_disp" "$c_eth" "$eth_disp" "$c_sol" "$sol_disp" "$btc_disp" "$eth_disp" "$sol_disp"
