# cc-deadline

Visual progress bar showing remaining context window percentage in the Claude Code statusline.

```
Opus · ███████░░░ 75%
```

- Filled blocks (white) = remaining context
- Empty blocks (gray) = used context
- Model name and percentage are dimmed

## Prerequisites

- [jq](https://jqlang.github.io/jq/) must be installed

## Installation

### Option A: Via Plugin Marketplace (Recommended)

```bash
# Add the cc-deadline marketplace
claude plugin marketplace add obsfx/cc-deadline

# Install the plugin
claude plugin install cc-deadline
```

Or in Claude Code interactive mode:

```
/plugin marketplace add obsfx/cc-deadline
/plugin install cc-deadline
```

### Option B: Install from Source

```bash
git clone https://github.com/obsfx/cc-deadline.git
claude plugin install ./cc-deadline
```

## How It Works

The plugin configures a statusline script that:

1. Receives session JSON data from Claude Code on stdin
2. Extracts `model.display_name` and `context_window.remaining_percentage`
3. Renders a 10-block progress bar with ANSI color coding

The statusline updates automatically after each assistant response.

## License

MIT
