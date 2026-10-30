#!/bin/bash
set -e

# Ensure Bun is installed and up to date
if command -v bun &>/dev/null; then
  sudo bun upgrade || true
else
  curl -fsSL https://bun.sh/install | bash
fi

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Install omp globally
bun add -g @oh-my-pi/pi-coding-agent

# Ensure PATH in ~/.bashrc
if ! grep -q 'BUN_INSTALL' "$HOME/.bashrc" 2>/dev/null; then
  cat << 'EOF' >> "$HOME/.bashrc"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
EOF
fi

if ! grep -q 'HOME/bin' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "omp installation complete:"
"$HOME/.bun/bin/omp" --version
