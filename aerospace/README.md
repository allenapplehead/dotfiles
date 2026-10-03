# AeroSpace

Config for [AeroSpace](https://nikitabobko.github.io/AeroSpace/), a tiling window manager for macOS. It's based on the official [i3-like config](https://nikitabobko.github.io/AeroSpace/goodies#i3-like-config), remapped to vim motion keys (`hjkl`).

## Install

```sh
./install.sh aerospace   # copies .aerospace.toml to ~/.aerospace.toml
```

Then reload with <kbd>⌥</kbd><kbd>⇧</kbd><kbd>C</kbd>. AeroSpace needs **Accessibility** permission (System Settings → Privacy & Security → Accessibility).

`⌥` is the Option key.

## Main mode

| Keys | Action |
|---|---|
| `⌥ Enter` | Open a new iTerm window |
| `⌥ H / J / K / L` | Focus left / down / up / right (wraps around within the workspace) |
| `⌥⇧ H / J / K / L` | Move window left / down / up / right |
| `⌥ V` | Tile side by side, like vim's `:vsplit` (also exits stacked/tabbed layout) |
| `⌥ S` | Tile top to bottom, like vim's `:split` (also exits stacked/tabbed layout) |
| `⌥ E` | Toggle split orientation |
| `⌥ T` | Stacked layout (vertical accordion) |
| `⌥ W` | Tabbed layout (horizontal accordion) |
| `⌥ F` | Fullscreen the focused window |
| `⌥⇧ F` | Flatten the workspace (clears hidden nested containers when tiling acts strangely) |
| `⌥⇧ Space` | Toggle floating / tiling |
| `⌥ 1–0` | Switch to workspace 1–10 |
| `⌥⇧ 1–0` | Send window to workspace 1–10 |
| `⌥⇧ C` | Reload config |
| `⌥ R` | Enter resize mode |

You still close windows with `⌘W` / `⌘Q` as usual.

## Resize mode (`⌥ R`)

| Keys | Action |
|---|---|
| `H` | Narrower |
| `L` | Wider |
| `J` | Taller |
| `K` | Shorter |
| `Enter` / `Esc` | Back to main mode |

> **Can't type h/j/k/l?** You're probably stuck in resize mode, which captures those keys without Option. Press `Esc`. Check the current mode with `aerospace list-modes --current`; it should print `main`.

> **Every ⌥ shortcut dead except `⌥ Enter`?** An app is holding macOS Secure Input (usually Chrome after a password field), which blocks shortcuts that could type a character. Click away from the password field, or quit the app. To find which app it is: `ioreg -l -w 0 | grep -o 'SecureInputPID"=[0-9]*' | head -1`, then `ps -p <pid>`.

## Multiple monitors

Each monitor shows one workspace, so you move things between screens with the workspace keys.

- **Move between monitors:** `⌥ 1–0` jumps to a workspace. If it's showing on the other monitor, focus moves to that monitor.
- **Move a window to the other monitor:** `⌥⇧` plus the number of a workspace that's on the other monitor.
- **Choose what a monitor shows:** focus that monitor, then press `⌥` plus a number.
- `⌥ H/J/K/L` stay within the current workspace. At the edge, focus wraps around instead of crossing to the next monitor.

### Optional monitor commands (not bound yet)

Add these under `[mode.main.binding]` if you want them. `⌥ Tab` may conflict with window-switcher apps.

```toml
alt-tab       = 'focus-monitor --wrap-around next'              # jump focus to the other monitor
alt-shift-tab = 'move-node-to-monitor --wrap-around next'       # send window to the other monitor
alt-ctrl-tab  = 'move-workspace-to-monitor --wrap-around next'  # move the whole workspace
```

### Workspaces are pinned to monitors

Workspaces stay on the same screen after the Mac sleeps or a display is unplugged. Monitors are counted left to right:

| Workspaces | 4 monitors | 3 monitors | 2 monitors | 1 monitor |
|---|---|---|---|---|
| 1–3 | 1st | Left | Left | Only screen |
| 4–6 | 2nd | Middle | Right | Only screen |
| 7–9 | 3rd | Right | Right | Only screen |
| 10 | 4th | Right | Right | Only screen |

The mapping is the `[workspace-to-monitor-force-assignment]` section at the bottom of `.aerospace.toml`. Run `aerospace list-monitors` to see how AeroSpace numbers your screens.

## Other tips

- AeroSpace doesn't use macOS Spaces. It hides windows by parking them in a screen corner, so a sliver of a window at the edge of the screen is normal.
- The first time you press `⌥ Enter`, allow AeroSpace to control iTerm (System Settings → Privacy & Security → Automation).
- `aerospace list-windows --all` lists every window AeroSpace manages. `aerospace reload-config` reloads the config from a terminal.
