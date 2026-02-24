#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
REMAINING=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100' | cut -d. -f1)

# Bar dimensions
BAR_WIDTH=10
FILLED=$((REMAINING * BAR_WIDTH / 100))
# Show at least 1 block when context remains
[ "$REMAINING" -gt 0 ] && [ "$FILLED" -eq 0 ] && FILLED=1
EMPTY=$((BAR_WIDTH - FILLED))

# Build bar: white for remaining, gray for used
DIM='\033[90m'
WHITE='\033[97m'
RESET='\033[0m'

BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '█')
EMPTY_BAR=""
[ "$EMPTY" -gt 0 ] && EMPTY_BAR=$(printf "%${EMPTY}s" | tr ' ' '░')

printf "${DIM}%s · ${WHITE}%s${DIM}%s %s%%${RESET}" "$MODEL" "$BAR" "$EMPTY_BAR" "$REMAINING"
