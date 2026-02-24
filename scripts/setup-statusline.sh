#!/bin/bash
# Reads hook input from stdin, resolves CLAUDE_PLUGIN_ROOT to find the statusline script,
# and writes the statusLine config into the user's settings if not already present.

input=$(cat)

SETTINGS_FILE="$HOME/.claude/settings.json"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
STATUSLINE_SCRIPT="$SCRIPT_DIR/statusline.sh"

if [ ! -f "$SETTINGS_FILE" ]; then
  echo "{}" > "$SETTINGS_FILE"
fi

# Check if statusLine is already configured
HAS_STATUSLINE=$(jq 'has("statusLine")' "$SETTINGS_FILE" 2>/dev/null)

if [ "$HAS_STATUSLINE" != "true" ]; then
  jq --arg cmd "$STATUSLINE_SCRIPT" '.statusLine = {"type": "command", "command": $cmd}' "$SETTINGS_FILE" > "${SETTINGS_FILE}.tmp" && mv "${SETTINGS_FILE}.tmp" "$SETTINGS_FILE"
fi
