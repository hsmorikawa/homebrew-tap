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
  version "0.2.1"
  license "MIT"

  # dev-cockpit の中核機能は tmux セッション監視。git は project status 集約等で使うが
  # 任意運用も可能なため caveats で推奨に留める (= research R9)。
  depends_on "tmux"

  on_macos do
    on_arm do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.1/dev-cockpit-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "a19de8c4881c14f8a402b770fec49ad6a526e06c71471b57c3a522560f59cb53"
    end
    on_intel do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.1/dev-cockpit-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "03587c96834f4fdbc9f30a301ab4646939bc37419b75ff66dce72e9de2cb7bf1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.1/dev-cockpit-0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "db5f1ff4563aebd036cf89b69b98afbfc5273a0ec128befe6d258d10c8913fe4"
    end
    on_intel do
      url "https://github.com/hsmorikawa/homebrew-tap/releases/download/v0.2.1/dev-cockpit-0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c894565d6599fd4a21834e96ffef512804e5d673559c62993db4a21aee096e80"
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
