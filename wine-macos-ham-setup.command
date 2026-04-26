#!/bin/bash
set -e

# Install Homebrew if missing
command -v brew >/dev/null 2>&1 || \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for Apple Silicon
[[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

brew install --cask --no-quarantine wine-stable || true
brew install winetricks cabextract wget

export WINEPREFIX="$HOME/.wine" WINEARCH=win64
[ -f "$WINEPREFIX/system.reg" ] || wineboot --init

# Windows Environment
winetricks -q win10

# .NET Frameworks
winetricks -q dotnet40 || true
winetricks -q dotnet48
winetricks -q dotnetdesktop6 || true
winetricks -q dotnet7 || true
winetricks -q dotnet8 || true

# Visual C++ Runtimes
winetricks -q ucrtbase2019 || true
winetricks -q vcrun2019
winetricks -q vcrun2022 || true
winetricks -q vcrun2015 || true
winetricks -q vcrun2013 || true
winetricks -q vcrun2012 || true
winetricks -q vcrun2010 || true
winetricks -q vcrun2008 || true
winetricks -q vcrun2005 || true

# Fonts
winetricks -q corefonts
winetricks -q liberation-fonts || true
winetricks -q tahoma || true

# Legacy Components
winetricks -q vb6run
winetricks -q mdac28
winetricks -q jet40 || true
winetricks -q msi2 || true

# DirectX & Graphics
winetricks -q d3dx9 || true
winetricks -q d3dx10 || true
winetricks -q d3dx11 || true
winetricks -q dxvk || true

# Audio
winetricks -q dsound || true
winetricks -q openal || true

# Scripting & Utilities
winetricks -q wsh57 || true
winetricks -q msxml3 || true
winetricks -q msxml4 || true
winetricks -q msxml6 || true

# Database
winetricks -q sqlserver2012express || true

# Additional Libraries
winetricks -q gdiplus || true
winetricks -q dotnetfx35 || true

echo "Done. Press enter to close."; read

# Copyright (C) MADE BY TENZERO KF0UDC
