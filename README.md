# Claude Code Settings Template

Template for `~/.claude/settings.json` with sound hooks and permissions.

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
