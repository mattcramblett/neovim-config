# Clone
```
git clone https://github.com/mattcramblett/neovim-config.git ~/.config/nvim
```

# Additional setup
- Lazy Git `brew install lazygit`
- Rip Grep `brew install ripgrep`

# Keybindings

leader: `<space>`

| Action       |  Keys          |
| -----------  |  ------------- |
| Find file    |  `<leader>o`   |
| Live Grep    |  `<leader>/`   |
| Buffers      |  `,`           |
| File Tree    |  `<leader>e`   |
| Git          |  `<leader>gg`  |
| Format File  |  `<leader>ff`  |
| Prev. buffer |  `H`           |
| Next buffer  |  `L`           |

# Troubleshooting
### Mason Formatter/Diagnostic Version Mismatch
Sometimes a Mason package may have a version mismatch where none-ls will look for a certain version that is not installed.
This can be resolved by explicitly installing the desired version via Mason.
```
:MasonInstall rubocop@1.65.1
```
