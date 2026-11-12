cask "glossa" do
  version "0.3.0"
  sha256 "052e3e69c12016c29e4f38e7ad49424289f4a8dc115a16e45ce9078f84992c3d"

  url "https://github.com/pluginslab/glossa/releases/download/v#{version}/Glossa-#{version}.dmg"
  name "Glossa"
  desc "Mac dictation that spells your words right: Whisper on the dictation key"
  homepage "https://github.com/pluginslab/glossa"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma
  depends_on formula: "whisper.cpp"

  app "Glossa.app"
  binary "#{appdir}/Glossa.app/Contents/Resources/install-server.sh", target: "glossa-server"

  caveats <<~EOS
    Start the local Whisper server (a launch agent on 127.0.0.1:8178):
      glossa-server

    Then open Glossa, grant Accessibility and Microphone, and in
    System Settings > Keyboard set "Press Globe key to" to Do Nothing
    and the Dictation shortcut to Off.
  EOS

  zap trash: [
    "~/.config/glossa",
    "~/Library/Logs/glossa.log",
    "~/Library/LaunchAgents/com.pluginslab.whisper-server.plist",
    "~/Library/Logs/whisper-server",
  ]
end
