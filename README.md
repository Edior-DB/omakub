# Omakub

> **Note:** This fork of Omakub is a heavily refactored and extended version of the original [Basecamp Omakub](https://github.com/basecamp/omakub). It is not fully tested and may contain bugs or incomplete features. Use at your own risk and please report issues.

Turn a fresh Ubuntu or Debian installation into a fully-configured, beautiful, and modern web development system by running a single command. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

## Essential Changes from Basecamp's Original Omakub

- **Cross-distro compatibility:** Full support for Ubuntu 24.04+ and Debian 12+ with robust OS detection and package handling.
- **Strict GNOME/GDM3 requirement:** Installer halts if not running under GNOME or GDM3.
- **Core vs. Optional Apps:** Only core terminal tools and GNOME-tweaking scripts are installed by default. All other apps (including Docker, Neovim, Chrome, LibreOffice, etc.) are now optional and can be installed later via the Omakub app or optional scripts.
- **Fastfetch and Alacritty:** Now required and installed early in the process.
- **Flatpak:** Now a required dependency, installed/configured before any app install.
- **Application launchers:** All launchers are safe to source and do not exit the parent process. They check for dependencies and remove launchers if missing.
- **GNOME extension setup:** Improved for cross-distro compatibility, with checks for extension/key existence before configuration.
- **Idempotency and error handling:** All scripts are idempotent, robust, and provide improved error handling and user feedback.
- **Directory structure:** Optional and required scripts are now clearly separated. Obsolete and legacy scripts have been removed.

## Quick Install

You can install Omakub with a single command:

```sh
wget -qO- https://raw.githubusercontent.com/Edior-DB/omakub/master/boot.sh | bash
```

## OS Compatibility and Package Handling

Omakub supports both **Ubuntu 24.04+** and **Debian 12+**. All installer and desktop scripts have been refactored to:
- Use environment variables (`OMAKUB_OS_ID`, `OMAKUB_OS_VERSION_ID`) for robust OS detection.
- Handle missing or non-repo packages (like `eza`, `fastfetch`, `tree-sitter-cli`, `ulauncher`, `typora`, `pinta`, `obsidian`, `rubymine`, etc.) on Debian by downloading binaries or `.deb` files from official GitHub or vendor releases, with idempotent checks to avoid reinstalling if already present.
- Use `libmysqlclient-dev` for MySQL development on Ubuntu, and `libmariadb-dev`/`libmariadb-dev-compat` on Debian.
- All PostgreSQL-related packages (`libpq-dev`, `postgresql-client`, `postgresql-client-common`) are available and installed from standard repos on both Ubuntu and Debian.
- All direct `.deb`/external installs are now idempotent: the script checks if the tool is already installed before downloading/installing.
- Flatpak/Flathub is now a required dependency and is installed/configured before any app install. Some apps (e.g., Pinta on Debian) use Flatpak with automatic remote setup and aliasing for user convenience.
- Improved error handling: failed commands and exit codes are displayed, and the script halts for user review.
- After GNOME installation, the user is prompted to reboot or continue with terminal-only setup, ensuring a smooth first-time experience.
- **Only core terminal tools and GNOME-tweaking desktop scripts are installed by default.** All other apps (including Docker, Neovim, Chrome, LibreOffice, etc.) are now optional and can be installed later via the Omakub app or optional scripts.

### Optional Apps

Omakub now separates core and optional apps. To install optional apps (like Docker, Neovim, Chrome, LibreOffice, etc.), launch the Omakub app after setup, or run the relevant script from the `install/terminal/optional/` or `install/desktop/optional/` directories.

**These changes were contributed by [GitHub Copilot](https://github.com/features/copilot) as part of a comprehensive cross-distro compatibility, idempotency, and robustness refactor (2025).**

## Contributing to the documentation

Please help us improve Omakub's documentation on the [Edior-DB/omakub-site repository](https://github.com/Edior-DB/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
