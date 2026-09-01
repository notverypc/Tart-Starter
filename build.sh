#!/usr/bin/env bash
# build.sh
# Packages the Tart Starter Alfred workflow into a distributable .alfredworkflow file.

set -euo pipefail

WORKFLOW_NAME="Tart-Starter"
OUTPUT_FILE="${WORKFLOW_NAME}.alfredworkflow"
REQUIRED_FILES=("info.plist" "list_vms.sh" "start_vm.sh" "stop_vm.sh")

# Check all required files are present
for f in "${REQUIRED_FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Error: missing required file: $f"
    echo "Tip: export the workflow from Alfred once to get info.plist, then re-run this script."
    exit 1
  fi
done

# Remove any previous build
rm -f "$OUTPUT_FILE"

# Package — -j junks paths so files sit at the root of the zip
zip -j "$OUTPUT_FILE" "${REQUIRED_FILES[@]}"

echo "Built: $OUTPUT_FILE"
