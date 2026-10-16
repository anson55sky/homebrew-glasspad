# brew cask
#
# 为什么要有它：直接下载 DMG 的用户第一次启动一定会被 Gatekeeper 拦
# （自签名、未公证），需要手动点一次「仍要打开」。经 Homebrew 安装则**零摩擦**。
#
# ⚠️ 机制不是「Homebrew 装的 app 没有隔离标记」—— 我一开始就是这么推断的，实测打脸：
#    curl 下载的文件确实不打标记（只有浏览器会），但 Homebrew 在安装时**显式设上**了：
#        浏览器下载   0083;…   没有 0x0100
#        brew 装的  0181;…   多了 0x0100
#    0x0100 = **QTN_NO_TRANSLOCATION**。Homebrew 源码里就是这么干的：
#        Quarantine.toggle_no_translocation_bit → fields[0] |= 0x0100
#        （附 openradar 5022734169931776）
#    触发那句吓人提示的是 **app translocation**（把 app 复制到只读卷再运行），
#    关掉它，提示就不出现。实测进程确实跑在 /Applications 原位，Gatekeeper 未拦截。
#
# 注意：这只解决 Gatekeeper。**完全磁盘访问仍需用户手动授予**，
# 且它绑在签名证书上而不是某个构建上，授予一次之后升级不会失效。
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
