# Tart Starter

An [Alfred](https://www.alfredapp.com) workflow to start and stop [Tart](https://github.com/openai/tart) VMs.

## Usage

1. Open Alfred and type `tart`
2. A list of your Tart VMs will appear with their current state
3. Select a VM and:
   - Press **↵ Enter** to start it
   - Press **⌥↵ Option+Enter** to stop it

## Requirements

- [Alfred](https://www.alfredapp.com) with a Powerpack licence
- [Tart](https://github.com/openai/tart) installed via Homebrew:
  ```
  brew install openai/tap/tart
  ```

## Installation

Download `Tart-Starter.alfredworkflow` and double-click to import it into Alfred.

## Configuration

If you have a custom `TART_HOME` set (e.g. VMs stored on an external drive), add it to your `~/.zprofile`:

```bash
export TART_HOME="/Volumes/YourDisk"
```

The workflow sources `~/.zprofile` automatically so Alfred will pick it up.

## Files

| File | Description |
|---|---|
| `list_vms.sh` | Lists all Tart VMs for the Alfred Script Filter |
| `start_vm.sh` | Starts a selected VM |
| `stop_vm.sh` | Stops a selected VM |
| `build.sh` | Packages the workflow into a distributable `.alfredworkflow` file |
| `info.plist` | Alfred workflow definition (export from Alfred) |
| `icon.png` | Workflow icon |

## Links

- [Alfred Workflows](https://www.alfredapp.com/help/workflows/)
- [Tart on GitHub](https://github.com/openai/tart)
