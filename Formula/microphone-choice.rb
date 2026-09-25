class MicrophoneChoice < Formula
  desc "Choose your microphone when a Bluetooth device connects"
  homepage "https://github.com/Mahad871/microphone-choice"
  url "https://github.com/Mahad871/microphone-choice/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "cefbb601080fad4d2b71fdf2a0b1a2724e95a8e0299506b0330683301262cd92"
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
    process_type :interactive
    error_log_path var/"log/microphone-choice.log"
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
