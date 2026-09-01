#!/usr/bin/env bash
# list_vms.sh
# Outputs Alfred Script Filter JSON listing all Tart VMs with their running status.

set -uo pipefail

# Ensure we have a valid working directory (Alfred on some machines may not set one)
cd /tmp

# Load user profile to pick up environment variables such as TART_HOME
[[ -f "$HOME/.zprofile" ]] && source "$HOME/.zprofile"

TART_BIN="/opt/homebrew/bin/tart"

if [[ ! -x "$TART_BIN" ]]; then
  echo '{"items":[{"title":"tart not found","subtitle":"Install tart via Homebrew: brew install openai/tap/tart","valid":false}]}'
  exit 0
fi

# tart list outputs lines like: <name>  <source>  <state>
# State is "running" or "stopped"
raw=$("$TART_BIN" list 2>/dev/null) || true

items=""
first=true

while IFS= read -r line; do
  # Skip the header line (starts with "Source") and blank lines
  [[ "$line" =~ ^Source ]] && continue
  [[ -z "$line" ]] && continue

  # tart list columns: Source  Name  Disk  Size  Accessed  State
  name=$(echo "$line" | awk '{print $2}')
  state=$(echo "$line" | awk '{print $NF}')

  if [[ "$state" == "running" ]]; then
    subtitle="Running — ↵ to stop"
    arg_start=""
    arg_stop="$name"
    icon_path=""
  else
    subtitle="Stopped — ↵ to start"
    arg_start="$name"
    arg_stop=""
    icon_path=""
  fi

  item=$(printf '{"title":"%s","subtitle":"%s","arg":"%s","variables":{"vm_name":"%s","vm_state":"%s"}}' \
    "$name" "$subtitle" "$name" "$name" "$state")

  if [[ "$first" == true ]]; then
    items="$item"
    first=false
  else
    items="$items,$item"
  fi

done <<< "$raw"

if [[ -z "$items" ]]; then
  echo '{"items":[{"title":"No VMs found","subtitle":"Create a VM with: tart clone <image> <name>","valid":false}]}'
  exit 0
fi

echo "{\"items\":[$items]}"
