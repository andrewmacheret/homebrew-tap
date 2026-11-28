cask "i5-express" do
  version "2.1.0"
  sha256 "751a73384e152bcef93a02ae714c071fa975356806a12dcb164c889595937b8e"

  url "https://github.com/andrewmacheret/i5-macos-menubar/releases/download/v#{version}/I-5-Express-v#{version}.dmg"
  name "I-5 Express"
  desc "Menu bar app showing which way Seattle's I-5 express lanes are open"
  homepage "https://github.com/andrewmacheret/i5-macos-menubar"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "I-5 Express.app"

  # The app isn't signed with an Apple developer certificate, so Gatekeeper would block it on first open.
  # Clearing the download flag does the same as clicking Open Anyway in System Settings.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/I-5 Express.app"],
        writable_paths: ["{{appdir}}/I-5 Express.app"]
  end

  uninstall quit: "com.andrewmacheret.i5"

  zap trash: [
    "~/Library/Caches/com.andrewmacheret.i5",
    "~/Library/HTTPStorages/com.andrewmacheret.i5",
    "~/Library/Preferences/com.andrewmacheret.i5.plist",
  ]
end
