#!/usr/bin/env bash
# start_vm.sh
# Starts a Tart VM by name. Receives the VM name via Alfred's {var:vm_name}.

set -euo pipefail

TART_BIN="/opt/homebrew/bin/tart"
VM_NAME="${vm_name:?vm_name variable is not set}"

if [[ ! -x "$TART_BIN" ]]; then
  echo "Error: tart not found at $TART_BIN"
  exit 1
fi

# Check the VM is not already running
state=$("$TART_BIN" list 2>/dev/null | awk -v vm="$VM_NAME" '$2 == vm {print $NF}')

if [[ "$state" == "running" ]]; then
  echo "$VM_NAME is already running."
  exit 0
fi

"$TART_BIN" start "$VM_NAME"

echo "Starting $VM_NAME…"
