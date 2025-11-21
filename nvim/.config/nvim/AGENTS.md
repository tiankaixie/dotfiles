# Repository Guidelines

This guide helps contributors enhance the LazyVim configuration in this repo without breaking the daily setup. Review it before proposing changes and keep it close while iterating.

## Project Structure & Module Organization
- `init.lua` bootstraps everything and delegates plugin and option loading to `config.lazy`.
- `lua/config/` holds core behavior: `options.lua` adjusts Neovim defaults, `keymaps.lua` defines custom bindings, `autocmds.lua` wires editor events, and `lazy.lua` sets Lazy.nvim defaults.
- `lua/plugins/` contains Lazy plugin specs grouped by concern (e.g. `lsp-config.lua`, `colorscheme.lua`). Create new specs here instead of inlining them in `init.lua`.
- `lazy-lock.json` pins plugin commits; update it only after verifying a clean `:Lazy sync`. `stylua.toml` stores Lua formatting rules shared across contributors.

## Build, Test, and Development Commands
- `nvim --headless "+Lazy! sync" +qa` installs or updates plugins using the current specs and lockfile.
- `nvim --headless "+Lazy! restore" +qa` resets plugin versions to the committed lockfile if a local upgrade misbehaves.
- `stylua lua ./init.lua` formats Lua sources using the repo’s indentation (2-space, 120-column).

## Coding Style & Naming Conventions
- Follow the Stylua config: spaces only, 2-space indentation, wrap Lua tables at 120 columns.
- Keep module filenames lowercase with hyphen-separated scopes (e.g. `lsp-config.lua`); match the module namespace used in `require`.
- Prefer descriptive keys inside Lazy specs (e.g. `opts`, `config`) and document non-obvious settings with a short Lua comment.

## Testing Guidelines
- Run `nvim --headless "+checkhealth" +qa` to verify Neovim core, LSP, and toolchain integrations before submitting.
- Trigger `:Mason` or `nvim --headless "+MasonUpdate" +qa` when adding language servers to ensure installers resolve cleanly.
- Open Neovim with `nvim --clean +"lua require('config.lazy')"`, confirm new plugins load without warnings, and exercise keymaps relevant to the change.

## Commit & Pull Request Guidelines
- Mirror the existing short, imperative Git history (`update`, `remove …`); describe the primary change in <=60 characters.
- Include follow-up detail in the body if the change spans multiple modules (paths, notable commands, manual steps).
- For PRs, link the motivating issue, list tested commands (see sections above), and attach screenshots when UI-affecting plugins are altered.

## Security & Configuration Tips
- Avoid committing machine-specific secrets; use environment variables referenced in `lua/config/options.lua` for per-user overrides.
- Check for breaking plugin updates by running `:Lazy news` before pin updates, and revert via the lockfile if stability issues appear.
