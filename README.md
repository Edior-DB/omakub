# Omakub

Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. That's the one-line pitch for Omakub. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

## Contributing to the documentation

Please help us improve Omakub's documentation on the [Edior-DB/omakub-site repository](https://github.com/Edior-DB/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)

## OS Compatibility and Package Handling

Omakub now supports both **Ubuntu 24.04+** and **Debian 12+**. All scripts have been refactored to:
- Use environment variables (`OMAKUB_OS_ID`, `OMAKUB_OS_VERSION_ID`) for OS detection.
- Use `gum` for user confirmations.
- Handle missing packages (like `eza`, `fastfetch`, `tree-sitter-cli`, `ulauncher`, `typora`) on Debian by downloading binaries or `.deb` files from official GitHub or vendor releases, with idempotent checks to avoid reinstalling if already present.
- Use `libmysqlclient-dev` for MySQL development on Ubuntu, and `libmariadb-dev`/`libmariadb-dev-compat` on Debian.
- All PostgreSQL-related packages (`libpq-dev`, `postgresql-client`, `postgresql-client-common`) are available and installed from standard repos on both Ubuntu and Debian.
- All direct `.deb`/external installs are now idempotent: the script checks if the tool is already installed before downloading/installing.

**These changes were contributed by [GitHub Copilot](https://github.com/features/copilot) as part of a comprehensive cross-distro compatibility and robustness refactor.**
