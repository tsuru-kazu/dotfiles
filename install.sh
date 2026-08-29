#!/usr/bin/env bash
set -euo pipefail

# ANSI color codes
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

info() {
  printf "${BLUE}==>${NC} %s\n" "$1"
}

success() {
  printf "${GREEN}==>${NC} %s\n" "$1"
}

warn() {
  printf "${YELLOW}==> WARNING:${NC} %s\n" "$1"
}

error() {
  printf "${RED}==> ERROR:${NC} %s\n" "$1" >&2
}

# 1. OS check (macOS only)
if [ "$(uname)" != "Darwin" ]; then
  error "This setup script is only supported on macOS."
  exit 1
fi

info "Starting macOS setup..."

# 2. Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  info "Waiting for Xcode Command Line Tools installation to complete..."
  until xcode-select -p >/dev/null 2>&1; do
    sleep 5
  done
  success "Xcode Command Line Tools installed."
else
  info "Xcode Command Line Tools is already installed."
fi

# 3. Homebrew installation
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Load Homebrew environment for the current script session
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
  error "Homebrew installation failed or brew is not in PATH."
  exit 1
fi
success "Homebrew is ready: $(brew --version | head -n 1)"

# 4. Clone or update dotfiles repository
DOTFILES_DIR="${HOME}/dotfiles"
REPO_URL="https://github.com/tsuru-kazu/dotfiles.git"

if [ -d "${DOTFILES_DIR}/.git" ]; then
  info "Updating existing dotfiles repository in ${DOTFILES_DIR}..."
  git -C "${DOTFILES_DIR}" pull --rebase
else
  info "Cloning dotfiles repository to ${DOTFILES_DIR}..."
  git clone "${REPO_URL}" "${DOTFILES_DIR}"
fi

# 5. Install go-task
if ! command -v task >/dev/null 2>&1; then
  info "Installing Task (go-task)..."
  brew install go-task/tap/go-task
fi
success "Task is ready: $(task --version)"

# 6. Execute task build
info "Building dotfiles via task..."
cd "${DOTFILES_DIR}"
task build

success "All setups completed successfully!"
