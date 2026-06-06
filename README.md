# homebrew-tap

[dev-cockpit](https://github.com/hsmorikawa/dev-cockpit) の Homebrew tap (prebuilt バイナリ配布)。

## インストール

```bash
brew tap hsmorikawa/tap
brew install hsmorikawa/tap/dev-cockpit

dev-cockpit --version
dev-cockpit serve
```

- 実行時に **tmux** が必要 (formula が `depends_on "tmux"` で自動導入)。
- **git** があると project の git status 集約が有効 (推奨)。
- 対応: macOS (Apple Silicon / Intel)、Linux (x86_64 / arm64)。

formula は dev-cockpit の `scripts/gen-homebrew-formula.sh <version>` が GitHub Release の
`SHA256SUMS` から生成する。詳細は本体リポジトリの `docs/distribution.md` を参照。
