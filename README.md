# Claude Code Settings Template

Template for `~/.claude/settings.json` with sound hooks and permissions.

Features:
- **SMW sound effects** — each Claude Code event plays a distinct Super Mario World sound
- **VS Code window flash** (WSL) — flashes the right VS Code window when CC finishes or needs permission, useful when running multiple CC sessions side by side

## Setup

1. Copy `settings.json` to `~/.claude/settings.json`
2. Download SMW sounds to `~/.claude/sounds/` (or `scp` from another machine)
3. Replace the audio player command based on your platform:

| Platform        | Player          | Command                                  |
| --------------- | --------------- | ---------------------------------------- |
| macOS           | afplay          | `afplay ~/.claude/sounds/smw_coin.wav &` |
| WSL (with WSLg) | paplay          | `paplay ~/.claude/sounds/smw_coin.wav &` |
| Linux           | paplay or aplay | `paplay ~/.claude/sounds/smw_coin.wav &` |

WSL requires `pulseaudio-utils` and `sound-theme-freedesktop`:
```bash
sudo apt install -y pulseaudio-utils sound-theme-freedesktop
```

## Sound map

| Hook               | Sound            | When                        |
| ------------------ | ---------------- | --------------------------- |
| SessionStart       | power-up         | New conversation begins     |
| UserPromptSubmit   | coin             | You send a message          |
| Stop               | 1-up             | Claude finishes responding  |
| Notification       | message block    | Claude sends a notification |
| PreCompact         | course clear     | Context window compaction   |
| SubagentStart      | vine             | Subagent spawned            |
| SubagentStop       | switch activated | Subagent finished           |
| InstructionsLoaded | pipe             | CLAUDE.md loaded            |
| PermissionRequest  | spin jump        | Claude needs permission     |

## VS Code window flash (WSL only)

`flash-vscode.sh` flashes the correct VS Code window when CC finishes or needs permission. Works across multiple VS Code windows — identifies the right one by workspace name (git root basename → partial window title match).

**Setup:**
1. Copy `flash-vscode.sh` to `~/.claude/flash-vscode.sh` and `chmod +x` it
2. The `Stop` and `PermissionRequest` hooks in `settings.json` already call it
3. WSL only — calls `powershell.exe` to invoke Win32 `FlashWindow`

On macOS, remove the flash hook lines — `afplay` sounds are sufficient.