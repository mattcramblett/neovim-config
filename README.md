# Clone
```
git clone https://github.com/mattcramblett/neovim-config.git ~/.config/nvim
```

# Additional setup
- Lazy Git `brew install lazygit`
- Rip Grep `brew install ripgrep`

# Troubleshooting
### Mason Formatter/Diagnostic Version Mismatch
Sometimes a Mason package may have a version mismatch where none-ls will look for a certain version that is not installed.
This can be resolved by explicitly installing the desired version via Mason.
```
:MasonInstall rubocop@1.65.1
```
