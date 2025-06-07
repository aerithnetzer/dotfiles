#!/bin/bash
# Ensure the PATH includes pipx-installed binaries
export PATH="$HOME/.local/bin:$PATH"

# Start papis serve
exec papis serve
