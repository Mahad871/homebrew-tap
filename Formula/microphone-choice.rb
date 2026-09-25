class MicrophoneChoice < Formula
  desc "Choose your microphone when a Bluetooth device connects"
  homepage "https://github.com/Mahad871/microphone-choice"
  url "https://github.com/Mahad871/microphone-choice/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "07dbe806f81dce084b268ca0e323336cbef0dfa8727ec69a18be4fbf81b02369"
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
