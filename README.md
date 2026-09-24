# Homebrew tap for Microphone Choice

Install the open-source macOS app from source with Homebrew:

```sh
brew install Mahad871/tap/microphone-choice
brew services start microphone-choice
```

The service runs in your user session and starts again when you log in. See the [main project](https://github.com/Mahad871/microphone-choice) for screenshots, the story behind the app, download options, and contribution instructions.

To stop and uninstall:

```sh
brew services stop microphone-choice
brew uninstall microphone-choice
```

This formula builds the universal app from the tagged source archive. It requires macOS 13 or newer and Apple's Command Line Tools. The formula is licensed under the same [MIT License](https://github.com/Mahad871/microphone-choice/blob/main/LICENSE) as the app.
