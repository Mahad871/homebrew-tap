class Choice < Formula
  desc "Choose Bluetooth microphones and fill windows beside Stage Manager"
  homepage "https://github.com/Mahad871/choice"
  url "https://github.com/Mahad871/choice/archive/refs/tags/v2.0.1.tar.gz"
  sha256 "d2a7a5eab02eb7ccd6dc263713217c23ddded16db6d70fe521adbd989671a420"
  license "MIT"

  depends_on macos: :ventura

  def install
    system "scripts/build-app.sh", buildpath/"build"
    prefix.install buildpath/"build/Choice.app"
  end

  def caveats
    <<~EOS
      Start Choice now and at login:
        brew services start choice

      Upgrading from microphone-choice? Stop the old service first:
        brew services stop microphone-choice

      Stage Manager Fill needs Accessibility access to resize other apps'
      windows. In its settings, click Open Accessibility Settings and switch
      Choice on. If Choice is already on but access is missing (upgrades from
      versions before 2.0.1), click Repair Access instead. Later upgrades keep
      the permission.
    EOS
  end

  service do
    run [opt_prefix/"Choice.app/Contents/MacOS/Choice", "--no-login-item"]
    keep_alive true
    process_type :interactive
    error_log_path var/"log/choice.log"
  end

  test do
    app = prefix/"Choice.app"
    assert_path_exists app
    architectures = shell_output("lipo -archs '#{app}/Contents/MacOS/Choice'")
    assert_match "arm64", architectures
    assert_match "x86_64", architectures
    system app/"Contents/MacOS/Choice", "--probe"
  end
end
