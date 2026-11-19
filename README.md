# Homebrew tap

Homebrew casks for [andrewmacheret](https://github.com/andrewmacheret)'s apps.

| Cask | App |
| --- | --- |
| `i5-express` | [I-5 Express for Mac Menu Bar](https://github.com/andrewmacheret/i5-macos-menubar), which shows which way Seattle's I-5 express lanes are open |

## Install

```bash
brew install --cask andrewmacheret/tap/i5-express
```

Homebrew asks you to trust a tap before it runs anything from it. Naming the cask in full, like above, trusts just that cask.

After installing, open **I-5 Express** from Applications. The N or S badge shows up in the menu bar.

## Updates

I-5 Express updates itself, so `brew upgrade` leaves it alone. To have Homebrew reinstall the newest version anyway, run `brew upgrade --cask --greedy i5-express`.

## Why it isn't in Homebrew's main catalog

The app isn't signed with an Apple developer certificate, and since September 2026 Homebrew's main catalog only takes apps that pass Gatekeeper. That's also why the cask clears macOS's download flag after installing. It does the same thing as clicking **Open Anyway** in System Settings, so Gatekeeper doesn't block the first launch. If you'd rather click it yourself, download the DMG from the [releases page](https://github.com/andrewmacheret/i5-macos-menubar/releases/latest) instead.

## How the tap stays current

- **Update casks** runs every 6 hours and points each cask at its app's latest release.
- **Test** installs each cask on a clean GitHub Mac runner, checks the app, then uninstalls it.

GitHub pauses scheduled workflows after 60 days without a commit. If that happens, run **Update casks** from the Actions tab, or just let new installs pick up the old version, which then updates itself.
