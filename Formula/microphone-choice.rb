class MicrophoneChoice < Formula
  desc "Choose your microphone when Bluetooth headphones connect"
  homepage "https://github.com/Mahad871/microphone-choice"
  url "https://github.com/Mahad871/microphone-choice/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "48224c6704999a6ebcf9398646a3966a1733c246b120ef5eaf846e9f6c72ec72"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "scripts/build-app.sh", buildpath/"build"
    prefix.install buildpath/"build/Microphone Choice.app"
  end

  def caveats
    <<~EOS
      Start Microphone Choice now and at login:
        brew services start microphone-choice
    EOS
  end

  service do
    run [opt_prefix/"Microphone Choice.app/Contents/MacOS/MicChoice", "--no-login-item"]
    keep_alive true
  end

  test do
    app = prefix/"Microphone Choice.app"
    assert_path_exists app
    architectures = shell_output("lipo -archs '#{app}/Contents/MacOS/MicChoice'")
    assert_match "arm64", architectures
    assert_match "x86_64", architectures
    system app/"Contents/MacOS/MicChoice", "--probe"
  end
end
