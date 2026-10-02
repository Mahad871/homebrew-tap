class MicrophoneChoice < Formula
  desc "Choose Bluetooth microphones and fill windows beside Stage Manager"
  homepage "https://github.com/Mahad871/microphone-choice"
  url "https://github.com/Mahad871/microphone-choice/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "f6e9f2a60cb831bc4df6e4aedc1639b3aa7e5feaa75842745aaedd6136988ef3"
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

      Stage Manager Fill needs Accessibility access to resize other apps'
      windows. Open its settings to check access and open the macOS privacy pane.
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
