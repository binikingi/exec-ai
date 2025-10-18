#!/usr/bin/env bash

# Installation script for exec-ai

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_color() {
    local color=$1
    shift
    echo -e "${color}$*${NC}"
}

print_color "$BLUE" "==================================="
print_color "$BLUE" "AI Command Assistant Installer"
print_color "$BLUE" "==================================="
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SCRIPT_PATH="$SCRIPT_DIR/exec-ai"

# Check if exec-ai exists
if [ ! -f "$SCRIPT_PATH" ]; then
    print_color "$RED" "Error: exec-ai script not found in $SCRIPT_DIR"
    exit 1
fi

# Make executable
chmod +x "$SCRIPT_PATH"
print_color "$GREEN" "Made exec-ai executable"

# Detect shell
detect_shell() {
    local shell_path="$SHELL"
    case "$shell_path" in
        */bash)
            echo "bash"
            ;;
        */zsh)
            echo "zsh"
            ;;
        */fish)
            echo "fish"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

DETECTED_SHELL=$(detect_shell)
print_color "$YELLOW" "Detected shell: $DETECTED_SHELL"
echo ""

# Function to add alias
add_alias() {
    local shell=$1
    local rc_file=$2
    local alias_line="alias \"??\"='$SCRIPT_PATH'"

    # Check if alias already exists
    if grep -q "alias \"??\"=" "$rc_file" 2>/dev/null; then
        print_color "$YELLOW" "Alias already exists in $rc_file"
        return
    fi

    # Add alias
    echo "" >> "$rc_file"
    echo "# AI Command Assistant" >> "$rc_file"
    echo "$alias_line" >> "$rc_file"

    print_color "$GREEN" "Added alias to $rc_file"
}

# Add alias based on shell
case "$DETECTED_SHELL" in
    bash)
        if [ -f "$HOME/.bashrc" ]; then
            add_alias "bash" "$HOME/.bashrc"
        else
            print_color "$YELLOW" "Warning: ~/.bashrc not found. Creating it..."
            touch "$HOME/.bashrc"
            add_alias "bash" "$HOME/.bashrc"
        fi
        ;;
    zsh)
        if [ -f "$HOME/.zshrc" ]; then
            add_alias "zsh" "$HOME/.zshrc"
        else
            print_color "$YELLOW" "Warning: ~/.zshrc not found. Creating it..."
            touch "$HOME/.zshrc"
            add_alias "zsh" "$HOME/.zshrc"
        fi
        ;;
    fish)
        FISH_CONFIG="$HOME/.config/fish/config.fish"
        mkdir -p "$(dirname "$FISH_CONFIG")"
        if [ ! -f "$FISH_CONFIG" ]; then
            touch "$FISH_CONFIG"
        fi

        if grep -q "alias ?? " "$FISH_CONFIG" 2>/dev/null; then
            print_color "$YELLOW" "Alias already exists in $FISH_CONFIG"
        else
            echo "" >> "$FISH_CONFIG"
            echo "# AI Command Assistant" >> "$FISH_CONFIG"
            echo "alias ?? '$SCRIPT_PATH'" >> "$FISH_CONFIG"
            print_color "$GREEN" "Added alias to $FISH_CONFIG"
        fi
        ;;
    *)
        print_color "$YELLOW" "Unknown shell. Please manually add this alias to your shell config:"
        print_color "$BLUE" "  alias \"??\"='$SCRIPT_PATH'"
        ;;
esac

echo ""
print_color "$GREEN" "Installation complete!"
echo ""
print_color "$YELLOW" "Next steps:"
echo "  1. Reload your shell configuration:"

case "$DETECTED_SHELL" in
    bash)
        echo "     source ~/.bashrc"
        ;;
    zsh)
        echo "     source ~/.zshrc"
        ;;
    fish)
        echo "     source ~/.config/fish/config.fish"
        ;;
    *)
        echo "     source <your-shell-config-file>"
        ;;
esac

echo ""
echo "  2. Set up your Anthropic API key:"
echo "     ?? --setup"
echo ""
echo "  3. Try it out:"
echo "     ?? list all running processes"
echo ""
print_color "$BLUE" "Enjoy using AI Command Assistant!"
