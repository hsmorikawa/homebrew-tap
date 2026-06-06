# Spec 039 (M6) — Homebrew formula テンプレート (prebuilt download 型)。
#
# `scripts/gen-homebrew-formula.sh <version>` が下記 placeholder を Release の
# 実値で置換し、完成 formula を生成する。生成物を tap repo (= 別リポジトリ
# `<owner>/homebrew-<tap>`、本リポジトリ管理外) の `Formula/dev-cockpit.rb` に commit する。
#
# 形態は **prebuilt バイナリ download** (= 利用者環境でコンパイルしない)。Homebrew の
# build sandbox はネットワーク禁止のため、`cargo build` / `pnpm install` を伴う source
# formula は採れない (= research R5)。
#
# placeholder 一覧は specs/039-homebrew-distribution/contracts/release-artifacts.md C6 を参照。
class DevCockpit < Formula
  desc "Web dashboard for tmux sessions, Claude Code jobs, and Obsidian docs"
  homepage "https://github.com/hsmorikawa/homebrew-tap"
  version "0.1.0"
  license "MIT"

  # dev-cockpit の中核機能は tmux セッション監視。git は project status 集約等で使うが
  # 任意運用も可能なため caveats で推奨に留める (= research R9)。
  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.1.0/dev-cockpit-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "d7a192a27e316ee239750d83a9d9b39a5aa6de0d98e998df77b2ca5117278580"
    end
    on_intel do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.1.0/dev-cockpit-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "d9dc6c6d319528ccb0c68e0ea6214aa3b256ff1a4448505962e3928b6d4baba0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.1.0/dev-cockpit-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81d5f702512bd46a38ce599f4015c443df0ffa572a8203ac568cacd1cef00bbb"
    end
    on_intel do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.1.0/dev-cockpit-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8ed44a5bae885cce7f158864a081bd01074ace17f7fa5fc918f692db56b0a934"
    end
  end

  def install
    bin.install "dev-cockpit"
  end

  def caveats
    <<~EOS
      dev-cockpit は tmux セッションを監視します。tmux は依存として導入済みです。
      git があると project の git status 集約が有効になります (推奨)。

      起動:
        dev-cockpit serve
      ヘルプ:
        dev-cockpit --help
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dev-cockpit --version")
  end
end
