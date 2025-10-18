# AI Command Line Assistant

A bash/zsh/fish-compatible tool that uses AI (Claude) to help you write and execute shell commands naturally.

## Features

- **Natural language to commands**: Describe what you want in plain English
- **Interactive approval**: Review commands before execution
- **Shell detection**: Automatically adapts to bash/zsh/fish
- **Command history**: Keep track of AI-generated commands
- **Safe execution**: Always asks for confirmation before running
- **Colorful output**: Easy-to-read colored terminal output

## Installation

### Prerequisites

- curl
- python3 (for JSON parsing)
- An Anthropic API key ([get one here](https://console.anthropic.com/))

### Quick Install

1. **Clone or download this repository**:
   ```bash
   cd /Users/bini/projects/private/exec-ai
   ```

2. **Make the script executable**:
   ```bash
   chmod +x exec-ai
   ```

3. **Create an alias for `??`**:

   For **bash** (add to `~/.bashrc`):
   ```bash
   alias "??"='/Users/bini/projects/private/exec-ai/exec-ai'
   ```

   For **zsh** (add to `~/.zshrc`):
   ```bash
   alias "??"='/Users/bini/projects/private/exec-ai/exec-ai'
   ```

   For **fish** (add to `~/.config/fish/config.fish`):
   ```fish
   alias "??"='/Users/bini/projects/private/exec-ai/exec-ai'
   ```

4. **Reload your shell configuration**:
   ```bash
   source ~/.bashrc  # or ~/.zshrc or ~/.config/fish/config.fish
   ```

5. **Set up your API key**:
   ```bash
   ?? --setup
   ```

   Or set it as an environment variable:
   ```bash
   export ANTHROPIC_API_KEY='your-api-key-here'
   ```

### Alternative: System-wide Installation

To make the tool available system-wide:

```bash
sudo ln -s /Users/bini/projects/private/exec-ai/exec-ai /usr/local/bin/exec-ai
alias ??='exec-ai'
```

## Usage

### Basic Usage

Simply type `??` followed by a description of what you want to do:

```bash
?? list all running docker containers
```

Output:
```
Thinking...

I want to run this command:
  docker ps

Do you approve? [Y]es/[n]o: y

Executing...

CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS   PORTS   NAMES
abc123def456   nginx     ...       ...       ...      ...     webserver

Command completed successfully.
```

### More Examples

**Docker operations**:
```bash
?? help me run pnpm prisma generate inside docker container named server
```

**File operations**:
```bash
?? find all javascript files modified in the last 24 hours
?? compress all log files in /var/log
```

**Git operations**:
```bash
?? create a new git branch named feature-user-auth
?? show me the diff of the last 3 commits
```

**System tasks**:
```bash
?? show me the top 10 processes using the most memory
?? find large files over 100MB in the current directory
```

### Commands

- `?? <description>` - Generate and execute a command
- `?? -y <description>` - Auto-approve and execute without confirmation
- `?? --setup` - Configure your Anthropic API key
- `?? --history` - Show the last 20 commands you've run
- `?? --help` - Show help message
- `?? --version` - Show version information

### Declining Commands

If you don't want to run the suggested command, just type `n` or `no`:

```bash
?? delete all files in current directory

I want to run this command:
  rm -rf *

Do you approve? [Y]es/[n]o: n

Command cancelled.
```

### Auto-Approve with -y Flag

For commands you trust or when using in scripts, use the `-y` flag to skip the approval prompt:

```bash
?? -y show disk usage sorted by size
```

Output:
```
Thinking...

I want to run this command:
  du -sh * | sort -h

Auto-approving with -y flag...

Executing...

4.0K    file1.txt
8.0K    file2.txt
1.2M    directory1

Command completed successfully.
```

**Warning**: Use `-y` with caution. Always ensure you trust the AI's output, especially for destructive operations.

## How It Works

1. You type `??` followed by a natural language description
2. The tool sends your description to Claude AI via the Anthropic API
3. Claude generates the appropriate shell command for your current shell
4. The command is displayed for your review
5. You approve or decline the command
6. If approved, the command is executed and the result is shown

## Configuration

The tool stores configuration in `~/.config/exec-ai/`:
- `config` - Your API key (if set via `--setup`)
- `history` - Command execution history

## Security Notes

- **Always review commands before approving**: The AI is helpful but not perfect
- **API key storage**: Keys are stored in `~/.config/exec-ai/config` with 600 permissions
- **Command history**: All approved commands are logged to `~/.config/exec-ai/history`
- **No automatic execution**: Every command requires your explicit approval

## Troubleshooting

### "No API key found" error
Run `?? --setup` or set the `ANTHROPIC_API_KEY` environment variable.

### "Failed to generate command" error
- Check your internet connection
- Verify your API key is valid
- Check if you have available API credits

### Command not found: ??
Make sure you've:
1. Made the script executable: `chmod +x exec-ai`
2. Added the alias to your shell configuration
3. Reloaded your shell: `source ~/.bashrc` (or equivalent)

### Python3 not found
Install Python 3:
- macOS: `brew install python3`
- Ubuntu/Debian: `sudo apt install python3`
- Fedora: `sudo dnf install python3`

## License

MIT License - feel free to use and modify as needed.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.
