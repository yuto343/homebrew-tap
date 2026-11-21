# 雛形は akapen のリポジトリの apps/mac/packaging/homebrew/akapen.rb.template。
# pnpm release:mac が版と sha256 を埋めて作り、pnpm publish:mac が yuto343/homebrew-tap に置く。直すときは雛形を直す。
cask "akapen" do
  version "0.1.1"
  sha256 "d31ac8420d8170ce884da8b6af197396160d081389a1ea0b6e10fbe66257a4ac"

  url "https://github.com/yuto343/akapen/releases/download/v#{version}/akapen-#{version}.zip"
  name "akapen"
  desc "Frame and comment on the screen, then hand it all to an AI agent"
  homepage "https://github.com/yuto343/akapen"

  livecheck do
    url "https://github.com/yuto343/akapen/releases/latest/download/appcast.xml"
    strategy :sparkle
  end

  # アプリ内の Sparkle が自分で更新する。
  auto_updates true
  depends_on macos: ">= :sequoia"

  app "akapen.app"

  uninstall quit: "com.yuto343.akapen"

  # 画像（FileImageStore）、設定と Sparkle の記録（UserDefaults.standard）、
  # Sparkle の確認とダウンロードで URLSession が作る置き場（キャッシュ・HTTPStorages）。
  zap trash: [
    "~/Library/Caches/akapen",
    "~/Library/Caches/com.yuto343.akapen",
    "~/Library/HTTPStorages/com.yuto343.akapen",
    "~/Library/HTTPStorages/com.yuto343.akapen.binarycookies",
    "~/Library/Preferences/com.yuto343.akapen.plist",
  ]
end
