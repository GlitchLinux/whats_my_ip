Here's a customized `README.md` for your repository at `https://github.com/GlitchLinux/whats_my_ip`:

# What's My IP - Tor/Clearnet IP Checker

![GitHub](https://img.shields.io/github/license/GlitchLinux/whats_my_ip)
![GitHub last commit](https://img.shields.io/github/last-commit/GlitchLinux/whats_my_ip)

A lightweight Bash script that displays your public IP address and approximate location, working seamlessly on both clearnet and Tor networks.

![Example Screenshot](screenshot.png)

## Features

- Automatic detection of Tor or clearnet connection
- Displays:
  - Current public IP address
  - Approximate geographical location
  - Network type (Tor or clearnet)
- Simple GTK+ GUI using Zenity
- One-click refresh capability
- Privacy-focused design (no persistent logging)

## Installation

### Requirements
- `curl` - For HTTP requests
- `jq` - For JSON parsing
- `zenity` - For GUI dialogs
- `tor` (optional) - For Tor network support

Install dependencies on Debian/Ubuntu:
```bash
sudo apt install curl jq zenity tor
```

### Get the Script
```bash
git clone https://github.com/GlitchLinux/whats_my_ip.git
cd whats_my_ip
chmod +x whats_my_ip.sh
```

## Usage

Basic usage:
```bash
./whats_my_ip.sh
```

With Tor:
```bash
tor & ./whats_my_ip.sh
```

## Command-line Options

| Option | Description |
|--------|-------------|
| `--cli` | Run in command-line mode (no GUI) |
| `--tor` | Force Tor network usage |
| `--help` | Show help message |

## Technical Details

The script uses these services:
- IP detection: `ifconfig.me` and `check.torproject.org`
- Geolocation: `ipapi.co` API
- Tor verification: Tor Project's check service

## FAQ

**Q: Why does my location show as unknown when using Tor?**  
A: Some Tor exit nodes don't provide accurate geolocation data.

**Q: Can I use a different geolocation provider?**  
A: Yes, edit the script and change the `IP_API` variable.

**Q: Is this script tracking my IP?**  
A: No, all requests are made locally and no data is stored.

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

Report issues in the [GitHub Issues](https://github.com/GlitchLinux/whats_my_ip/issues) section.

## License

MIT License - See [LICENSE](LICENSE) file for details.
```
