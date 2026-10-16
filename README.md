# Homebrew tap for GlassPad

```bash
brew tap anson55sky/glasspad
brew install --cask anson55sky/glasspad/glasspad
```

Installing through Homebrew skips the Gatekeeper prompt: `curl` does **not** set
the `com.apple.quarantine` attribute, and Homebrew's `Quarantine.propagate` only
acts when it detects one. The app therefore launches with no extra step.
