# Homebrew tap

[![Test](https://github.com/andrewmacheret/homebrew-tap/actions/workflows/test.yml/badge.svg)](https://github.com/andrewmacheret/homebrew-tap/actions/workflows/test.yml) [![Update casks](https://github.com/andrewmacheret/homebrew-tap/actions/workflows/update.yml/badge.svg)](https://github.com/andrewmacheret/homebrew-tap/actions/workflows/update.yml) [![License](https://img.shields.io/badge/license-MIT-lightgray.svg)](https://github.com/andrewmacheret/homebrew-tap/blob/main/LICENSE.md)

Homebrew casks and formulae for [andrewmacheret](https://github.com/andrewmacheret)'s apps.

| Name | What it is |
| --- | --- |
| `i5-express` (cask) | [I-5 Express for Mac Menu Bar](https://github.com/andrewmacheret/i5-macos-menubar), which shows which way Seattle's I-5 express lanes are open |
| `ascii-cow` (formula) | [ascii-cow](https://github.com/andrewmacheret/ascii-cow), which turns an image into colorful ASCII art spoken by a cow |

## Install

```bash
brew install --cask andrewmacheret/tap/i5-express
brew install andrewmacheret/tap/ascii-cow
```

Homebrew asks you to trust a tap before it runs anything from it. Naming the cask or formula in full, like above, trusts just that one.

After installing I-5 Express, open **I-5 Express** from Applications. The N or S badge shows up in the menu bar.

To try ascii-cow, run `ascii-cow -f "$(brew --prefix)/share/ascii-cow/example.jpg" -w 80`.

## Updates

I-5 Express updates itself, so `brew upgrade` leaves it alone. To have Homebrew reinstall the newest version anyway, run `brew upgrade --cask --greedy i5-express`.

ascii-cow updates with `brew upgrade` like any other formula.

## Why I-5 Express isn't in Homebrew's main catalog

The app isn't signed with an Apple developer certificate, and since September 2026 Homebrew's main catalog only takes apps that pass Gatekeeper. That's also why the cask clears macOS's download flag after installing. It does the same thing as clicking **Open Anyway** in System Settings, so Gatekeeper doesn't block the first launch. If you'd rather click it yourself, download the DMG from the [releases page](https://github.com/andrewmacheret/i5-macos-menubar/releases/latest) instead.

## How the tap stays current

- **Update casks** runs every 6 hours. It points each cask at its app's latest release, and each formula at its repo's newest `v*` tag.
- **Test** installs each cask and formula on a clean GitHub Mac runner, checks it, then uninstalls it.

To release a new ascii-cow, push a tag like `v1.0.1` to its repo. The next **Update casks** run picks it up.

GitHub pauses scheduled workflows after 60 days without a commit. If that happens, run **Update casks** from the Actions tab. Until then, new installs get the old version. I-5 Express then updates itself, but ascii-cow stays on the old version until the formula is updated.
