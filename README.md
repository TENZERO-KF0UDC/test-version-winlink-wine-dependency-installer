# Wine Ham Radio Setup Scripts
**By TENZERO (KF0UDC)**

Scripts to enable Windows-based Winlink applications to run on Linux and macOS via Wine.

> **macOS Users — Known Limitations:**
> - `rmsgw` is only needed if you are running a Winlink gateway station (sysop level) — this is Linux-only and not supported on macOS via Wine
> - The SCS USB Driver is only needed if you are using a physical SCS modem — use `scs-modem-bridge-macos.command` for FTDI-based modems; proprietary chipsets require a Windows VM

---

## Files

| File | Platform |
|------|----------|
| `wine-linux-ham-setup.desktop` | Linux (double-click to run) |
| `wine-macos-ham-setup.command` | macOS (double-click to run) |
| `scs-modem-bridge-macos.command` | macOS — SCS modem bridge for Wine (optional) |
| `wine-linux-ham-setup-code.txt` | Linux — script source code (view only) |
| `wine-macos-ham-setup-code.txt` | macOS — script source code (view only) |
| `scs-modem-bridge-macos-code.txt` | macOS SCS bridge — script source code (view only) |

---

## What Gets Installed

### Windows Environment
- Windows 10 compatibility mode (`win10`)

### .NET Frameworks
- .NET Framework 4.0 (`dotnet40`) — required for EchoLink
- .NET Framework 4.8 (`dotnet48`)
- .NET Desktop Runtime 6 (`dotnetdesktop6`)
- .NET 7 (`dotnet7`)
- .NET 8 (`dotnet8`)

### Visual C++ Runtimes
- Universal C Runtime / UCRT (`ucrtbase2019`) — required for EchoLink
- Visual C++ 2019 (`vcrun2019`)
- Visual C++ 2022 (`vcrun2022`)
- Visual C++ 2015 (`vcrun2015`)
- Visual C++ 2013 (`vcrun2013`)
- Visual C++ 2012 (`vcrun2012`)
- Visual C++ 2010 (`vcrun2010`)
- Visual C++ 2008 (`vcrun2008`)
- Visual C++ 2005 (`vcrun2005`)

### Fonts
- Core Fonts (`corefonts`)
- Liberation Fonts (`liberation-fonts`)
- Tahoma (`tahoma`)

### Legacy Components
- Visual Basic 6 Runtime (`vb6run`) — required for VARA apps
- Microsoft Data Access Components (`mdac28`) — required for VARA apps
- Jet 4.0 Database Engine (`jet40`)
- MSI 2 (`msi2`)

### DirectX & Graphics
- DirectX 9 (`d3dx9`)
- DirectX 10 (`d3dx10`)
- DirectX 11 (`d3dx11`)
- DXVK (`dxvk`)

### Audio
- DirectSound (`dsound`)
- OpenAL (`openal`)

### Scripting & Utilities
- Windows Script Host 5.7 (`wsh57`)
- MSXML 3 (`msxml3`)
- MSXML 4 (`msxml4`)
- MSXML 6 (`msxml6`)

### Database
- SQL Server 2012 Express (`sqlserver2012express`)

### Additional Libraries
- GDI+ (`gdiplus`)
- .NET Framework 3.5 (`dotnetfx35`)

---

## Supported Applications

All applications available at [downloads.winlink.org](https://downloads.winlink.org):

- Winlink Express
- VARA HF / VARA FM / VARA SAT / VARA Chat / VARA Terminal
- RMS Express / RMS Packet / RMS Relay / RMS Trimode
- EchoLink
- Connection Monitor / RMS Link Test

---

## Linux System Dependencies

The setup script installs the following native packages before configuring Wine:

| Distro | Packages |
|--------|----------|
| Arch/Manjaro | `wine` `wine-mono` `wine-gecko` `winetricks` `lib32-gnutls` `lib32-libpulse` `lib32-alsa-lib` `lib32-alsa-plugins` `lib32-mesa` `lib32-vulkan-icd-loader` `cabextract` `wget` |
| Debian/Ubuntu | `wine` `winetricks` `cabextract` `wget` `libgnutls30:i386` `libpulse0:i386` `libasound2-plugins:i386` (fallback for Ubuntu 24.04+: `wine64` `wine32`) |
| Fedora | `wine` `winetricks` `cabextract` `wget` |
| openSUSE | `wine` `winetricks` `cabextract` `wget` |
| Void Linux | `wine` `winetricks` `cabextract` `wget` |
| Solus | `wine` `winetricks` `cabextract` `wget` |
| Gentoo | `app-emulation/wine-vanilla` `app-emulation/winetricks` `app-arch/cabextract` `net-misc/wget` |
| Alpine | `wine` `winetricks` `cabextract` `wget` |

---

## macOS System Dependencies

The setup script installs the following via Homebrew:

- `wine-stable` (cask)
- `winetricks`
- `cabextract`
- `wget`

Homebrew is installed automatically if not present. Apple Silicon Homebrew PATH is configured automatically.

---

## SCS USB Driver — Linux & macOS

The **SCS USB Driver 2.08.24 WHQL Certified** is a Windows-only kernel driver and is **not supported by Wine**. It cannot be installed via these scripts.

### Linux

**1. Native USB-to-Serial Support**

Most SCS modems appear automatically as `/dev/ttyUSB0`. Verify with:
```bash
lsusb
dmesg | grep tty
```

**2. FTDI Drivers**

If your modem uses an FTDI chip:

| Distro | Command |
|--------|---------|
| Debian/Ubuntu | `sudo apt install ftdi-eeprom` |
| Arch/Manjaro | `sudo pacman -S libftdi` |
| Fedora | `sudo dnf install libftdi` |
| openSUSE | `sudo zypper install libftdi1` |

Load the kernel module if needed:
```bash
sudo modprobe ftdi_sio
```

**3. Ham Radio Software**

- [Pat (Winlink/Pactor)](https://getpat.io)
- [Xastir (APRS)](https://xastir.org)

---

### macOS

**SCS Modem Bridge for Wine/Winlink Express**

The `scs-modem-bridge-macos.command` script enables SCS modems to work with Winlink Express via Wine on macOS without needing the Windows driver.

**Setup Steps:**

1. Run `wine-macos-ham-setup.command` first to set up Wine
2. Plug in the SCS modem
3. Double-click `scs-modem-bridge-macos.command` — it will:
   - Install `socat` if needed
   - Detect the modem automatically
   - Ask which COM port to map to (default COM3)
   - Create the symlink in Wine
4. In Winlink Express, set the TNC/modem port to `COM3` (or whatever you chose)

**Limitations:**

- Only works with FTDI-based SCS modems that macOS recognizes natively as `/dev/cu.usbserial-XXXX`
- Proprietary chipsets that require the Windows SCS driver will not work — use a Windows VM instead

**Manual FTDI Driver Install (if needed):**

```bash
brew install libftdi
```

Or download from [ftdichip.com](https://ftdichip.com/drivers/vcp-drivers/).

**Alternative Ham Radio Software:**

- [Pat (Winlink/Pactor)](https://getpat.io)
- [MacLoggerDX](https://dogparksoftware.com/MacLoggerDX.html)

---

### Virtualization (Linux & macOS)

If native support is insufficient, run Windows in a VM with USB pass-through enabled:

- [VirtualBox](https://www.virtualbox.org)
- [VMware](https://www.vmware.com)

> **Note:** Wine is not recommended for USB kernel drivers. Use a VM instead.

---

## License

MIT License — Copyright (c) 2026 TENZERO (KF0UDC)

This license covers only the setup scripts in this repository. Wine, Winetricks, .NET, and all third-party tools installed by these scripts are subject to their own respective licenses.
