# Omakub

Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. That's the one-line pitch for Omakub. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

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
- Flatpak/Flathub is used for some apps (e.g., Pinta on Debian) with automatic remote setup and aliasing for user convenience.
- Improved error handling: failed commands and exit codes are displayed, and the script halts for user review.
- After GNOME installation, the user is prompted to reboot or continue with terminal-only setup, ensuring a smooth first-time experience.

**These changes were contributed by [GitHub Copilot](https://github.com/features/copilot) as part of a comprehensive cross-distro compatibility, idempotency, and robustness refactor (2025).**

## Contributing to the documentation

Please help us improve Omakub's documentation on the [Edior-DB/omakub-site repository](https://github.com/Edior-DB/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
