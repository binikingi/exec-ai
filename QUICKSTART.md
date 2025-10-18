# Quick Start Guide

Get up and running with AI Command Assistant in 2 minutes!

## Step 1: Install

Run the installation script:

```bash
./install.sh
```

## Step 2: Reload Shell

Reload your shell configuration:

```bash
# For bash
source ~/.bashrc

# For zsh
source ~/.zshrc

# For fish
source ~/.config/fish/config.fish
```

## Step 3: Configure API Key

Get your Anthropic API key from [https://console.anthropic.com/](https://console.anthropic.com/), then run:

```bash
?? --setup
```

Paste your API key when prompted.

## Step 4: Try It Out!

```bash
?? list all files sorted by size
```

You'll see:
1. A loading indicator while the AI thinks
2. The proposed command
3. A prompt asking for your approval
4. The command output after you approve

## Common Use Cases

### Docker
```bash
?? show all docker containers including stopped ones
?? run bash inside container named myapp
?? clean up all stopped containers
```

### Git
```bash
?? show the diff of files changed in the last commit
?? create and switch to a new branch named feature-xyz
?? undo the last commit but keep the changes
```

### File Management
```bash
?? find all PDF files in Downloads folder
?? compress the logs directory into a tar.gz file
?? find duplicate files in current directory
```

### System Info
```bash
?? show disk usage of current directory sorted by size
?? check which process is using port 8080
?? show system memory usage
```

## Tips

- **Be specific**: "list docker containers" is better than "docker stuff"
- **Review carefully**: Always check the command before approving
- **Check history**: Use `?? --history` to see past commands
- **Say no when unsure**: Press 'n' if the command doesn't look right
- **Auto-approve**: Use `?? -y <description>` to skip confirmation (use with caution!)

## Troubleshooting

**Command not found: ??**
- Make sure you ran `source ~/.bashrc` (or equivalent)
- Check that the alias was added: `alias | grep ??`

**API errors**
- Verify your API key: `?? --setup`
- Check your internet connection
- Ensure you have API credits at [console.anthropic.com](https://console.anthropic.com/)

## Need Help?

- Full documentation: See [README.md](README.md)
- Show help: `?? --help`
- View history: `?? --history`

Enjoy! 🚀
