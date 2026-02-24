# cc-deadline

Visual progress bar showing remaining context window percentage in the Claude Code statusline.

```
Opus · ███████░░░ 75%
```

Everything is rendered in dim gray — model name, progress bar, and percentage.

## Prerequisites

- [jq](https://jqlang.github.io/jq/) must be installed

## Installation

### Via Plugin Marketplace

```bash
claude plugin marketplace add obsfx/cc-deadline
claude plugin install cc-deadline
```

Or in Claude Code interactive mode:

```
/plugin marketplace add obsfx/cc-deadline
/plugin install cc-deadline
```

### From Source

```bash
git clone https://github.com/obsfx/cc-deadline.git
claude plugin install ./cc-deadline
```

Restart Claude Code after installing. The statusline is automatically configured via a `SessionStart` hook.

## How It Works

The plugin uses a `SessionStart` hook to inject the statusline configuration into `~/.claude/settings.json`. The path is updated on every session start to stay correct across version upgrades.

The statusline script:

1. Receives session JSON from Claude Code on stdin
2. Extracts `model.display_name` and `context_window.remaining_percentage`
3. Renders a 10-block progress bar

Updates automatically after each assistant response.

## License

MIT
