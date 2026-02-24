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

# Right-align using space padding
CONTENT="${MODEL} · ${BAR}${EMPTY_BAR} ${REMAINING}%"
CONTENT_LEN=${#CONTENT}

COLS=$(stty size 2>/dev/null | cut -d' ' -f2)
[ -z "$COLS" ] && COLS=120
# Reserve space for Claude Code's built-in right-side elements
COLS=$((COLS - 40))

PAD=$((COLS - CONTENT_LEN))
[ "$PAD" -lt 0 ] && PAD=0
SPACES=$(printf "%${PAD}s" "")

printf '%s\033[90m%s · \033[97m%s\033[90m%s %s%%\033[0m' "$SPACES" "$MODEL" "$BAR" "$EMPTY_BAR" "$REMAINING"
