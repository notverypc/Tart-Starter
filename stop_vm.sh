#!/usr/bin/env bash
# stop_vm.sh
# Stops a running Tart VM by name. Receives the VM name via Alfred's {var:vm_name}.

set -euo pipefail

cd /tmp
[[ -f "$HOME/.zprofile" ]] && source "$HOME/.zprofile"

TART_BIN="/opt/homebrew/bin/tart"
VM_NAME="${vm_name:?vm_name variable is not set}"

if [[ ! -x "$TART_BIN" ]]; then
  echo "Error: tart not found at $TART_BIN"
  exit 1
fi

# Check the VM is actually running before trying to stop it
state=$("$TART_BIN" list 2>/dev/null | awk -v vm="$VM_NAME" '$2 == vm {print $NF}')

if [[ "$state" != "running" ]]; then
  echo "$VM_NAME is not running."
  exit 0
fi

"$TART_BIN" stop "$VM_NAME"

echo "Stopped $VM_NAME."
