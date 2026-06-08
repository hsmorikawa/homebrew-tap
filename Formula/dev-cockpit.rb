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
  version "0.2.0"
  license "MIT"

  # dev-cockpit の中核機能は tmux セッション監視。git は project status 集約等で使うが
  # 任意運用も可能なため caveats で推奨に留める (= research R9)。
  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.0/dev-cockpit-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "b476006d0d5113e762d9e4273eba5de956204d5161b866d24fcdc977a193e9c7"
    end
    on_intel do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.0/dev-cockpit-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "36c796c0878b557d0500af38fbe5ea59128f5c83d0b742feb6687326d789fb52"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.0/dev-cockpit-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "05818efa8cd12755366453c881620d96e6ebab9f116ca6e83ec8e5a6439f807c"
    end
    on_intel do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.0/dev-cockpit-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e822123c8a1e5280ec73db3aa3a49c6e5ecb5f27f66069d02ee3c813f2b3873d"
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
