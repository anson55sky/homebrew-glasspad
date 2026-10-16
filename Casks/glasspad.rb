# 1.0.361：brew cask
#
# 为什么要有它：实测 `curl` 下载的文件**不带** com.apple.quarantine 隔离标记
# （只有浏览器会打），Homebrew 的 `Quarantine.propagate` 检测不到就什么都不做
# —— 于是经 brew 安装的 app 根本不进 Gatekeeper，**零摩擦**，
# 而直接下载 DMG 的用户第一次启动一定会被拦，需要手动点一次「仍要打开」。
#
# 注意：这只解决 Gatekeeper。**完全磁盘访问仍需用户手动授予**，
# 且它绑在签名证书上而不是某个构建上，所以授予一次之后升级不会失效。
cask "glasspad" do
  version "1.0.310"
  sha256 "de6f629162ceaf535fbe8bda99915a1f77eaff881e5122c59a449d6ebdec9e51"

  url "https://github.com/anson55sky/GlassPad/releases/download/v#{version}/GlassPad-#{version}.dmg",
      verified: "github.com/anson55sky/GlassPad/"
  name "GlassPad"
  desc "A minimal Launchpad-style app launcher for macOS"
  homepage "https://github.com/anson55sky/GlassPad"

  app "GlassPad.app"

  zap trash: [
    "~/Library/Application Support/GlassPad",
    "~/Library/Preferences/com.noval.glasspad.plist",
    "~/Library/Caches/com.noval.glasspad",
    "~/Library/Saved Application State/com.noval.glasspad.savedState",
  ]
end
