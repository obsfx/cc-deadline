#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
REMAINING=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100' | cut -d. -f1)

# Bar dimensions
BAR_WIDTH=10
FILLED=$((REMAINING * BAR_WIDTH / 100))
[ "$REMAINING" -gt 0 ] && [ "$FILLED" -eq 0 ] && FILLED=1
EMPTY=$((BAR_WIDTH - FILLED))

BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '█')
EMPTY_BAR=""
[ "$EMPTY" -gt 0 ] && EMPTY_BAR=$(printf "%${EMPTY}s" | tr ' ' '░')

# Right-align: move cursor far right, then back by content length
CONTENT="${MODEL} · ${BAR}${EMPTY_BAR} ${REMAINING}%"
LEN=${#CONTENT}

printf '\033[999C\033[%dD\033[90m%s · \033[97m%s\033[90m%s %s%%\033[0m' "$LEN" "$MODEL" "$BAR" "$EMPTY_BAR" "$REMAINING"
