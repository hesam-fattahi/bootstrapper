# Bootstrapper

A lightweight, modular system setup tool that bootstraps your Linux machine by installing essential packages, setting system values like hostname and timezone, and optionally customizing your environment. Written in Bash with optional Python and Vagrant support.


## Features

- Installs apt packages from a customizable list
- Optional Snap app installation
- Sets hostname and timezone via config file
- Python CLI (optional) for profile switching or advanced UX
- Vagrant support for testing your setup in a sandboxed VM
- Easily extendable with post-install scripts (aliases, dotfiles, etc.)


## Project Structure

```bash
bootstrapper/
├── bootstrap.sh            # Main Bash script
├── config/
│   ├── packages.txt        # APT package list
│   ├── snap.txt            # Snap package list (optional)
│   └── setup.conf          # Hostname, timezone, etc.
├── scripts/
│   └── post_install.sh     # Optional customizations (dotfiles, aliases)
├── python/
│   └── bootstrap_cli.py    # Optional CLI interface for profile selection
├── Vagrantfile             # Spins up Ubuntu Jammy64 VM by default
├── LICENSE
└── README.md
```

## Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/hesamfattahi/bootstrapper.git
cd bootstrapper
```

### 2. Configure

Edit the files under the `config/` directory to customize your setup:

- **packages.txt** — APT packages to install:
- **snap.txt** *(optional)* — Snap packages to install:
- **setup.conf** — Hostname and timezone configuration:

> If `snap.txt` is missing, Snap install is skipped silently.  
> If `setup.conf` is missing, hostname/timezone remain unchanged.

### 3. Run the Bootstrap Script

Make the script executable and run it:
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

This script will:
- Update the system
- Install APT packages from `packages.txt`
- Optionally install Snap packages
- Apply system settings from `setup.conf`
- Run `scripts/post_install.sh` if it exists

4. (Optional) Use the Python CLI

Call the CLI to select a custom profile:

```bash
python3 python/bootstrap_cli.py --profile dev
```

Example logic in the Python script:

```python
import argparse, shutil
parser = argparse.ArgumentParser()
parser.add_argument("--profile", help="Profile name")
args = parser.parse_args()
shutil.copyfile(f"config/packages-{args.profile}.txt", "config/packages.txt")
```

This lets you dynamically switch to different package lists (e.g. `dev`, `minimal`, `data`) and optionally override configs.

5. (Optional) Test in a Vagrant VM

Spin up an isolated test environment:
```bash
vagrant up
```

The included `Vagrantfile` uses `ubuntu/jammy64` and provisions automatically using `bootstrap.sh`.  

## License

This project is licensed under the [MIT License](./LICENSE).  
You are free to use, modify, and distribute it with proper attribution.

## Contributing

Contributions are welcome and highly appreciated! Whether it’s fixing bugs, suggesting enhancements, or adding new profiles — feel free to fork the repo and open a pull request.

