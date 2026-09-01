#!/usr/bin/env bash
# build.sh
# Packages the Tart Starter Alfred workflow into a distributable .alfredworkflow file
# and copies scripts into the live Alfred workflow folder.

set -euo pipefail

WORKFLOW_NAME="Tart-Starter"
OUTPUT_FILE="${WORKFLOW_NAME}.alfredworkflow"
SCRIPT_FILES=("list_vms.sh" "start_vm.sh" "stop_vm.sh")
REQUIRED_FILES=("info.plist" "${SCRIPT_FILES[@]}")

ALFRED_WORKFLOW_DIR="/Users/uk46088528/Library/CloudStorage/OneDrive-Personal/_SyncFolder/Apps/Alfred v2/Alfred.alfredpreferences/workflows/user.workflow.B22BF09B-1460-471C-9F3A-EC9F2619182B"

# Check all required files are present
for f in "${REQUIRED_FILES[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Error: missing required file: $f"
    [[ "$f" == "info.plist" ]] && echo "Tip: export the workflow from Alfred once to get info.plist, then re-run this script."
    exit 1
  fi
done

# Copy scripts into the live Alfred workflow folder
if [[ -d "$ALFRED_WORKFLOW_DIR" ]]; then
  echo "Copying scripts to Alfred workflow folder…"
  cp "${SCRIPT_FILES[@]}" "$ALFRED_WORKFLOW_DIR/"
  chmod +x "${SCRIPT_FILES[@]/#/$ALFRED_WORKFLOW_DIR/}"
  echo "Done."
else
  echo "Warning: Alfred workflow folder not found, skipping copy."
  echo "  Expected: $ALFRED_WORKFLOW_DIR"
fi

# Remove any previous build
rm -f "$OUTPUT_FILE"

# Package — -j junks paths so files sit at the root of the zip
zip -j "$OUTPUT_FILE" "${REQUIRED_FILES[@]}"

echo "Built: $OUTPUT_FILE"
