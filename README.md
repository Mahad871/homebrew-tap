# Homebrew tap for Choice

Install the open-source macOS app from source with Homebrew:

```sh
brew install Mahad871/tap/choice
brew services start choice
```

The service runs in your user session and starts again when you log in. See the [main project](https://github.com/Mahad871/choice) for screenshots, the story behind the app, download options, and contribution instructions.

To stop and uninstall:

```sh
brew services stop choice
brew uninstall choice
```

Choice was called Microphone Choice before 2.0. The tap renames the old `microphone-choice` formula to `choice`, so `brew update` and `brew upgrade` move existing installs over. Stop the old service with `brew services stop microphone-choice`, then start the new one with `brew services start choice`.

This formula builds the universal app from the tagged source archive. It requires macOS 13 or newer and Apple's Command Line Tools. The formula is licensed under the same [MIT License](https://github.com/Mahad871/choice/blob/main/LICENSE) as the app.
