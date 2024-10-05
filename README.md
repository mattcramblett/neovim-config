# Clone

```
git clone https://github.com/mattcramblett/neovim-config.git ~/.config/nvim
```

# Additional setup

- Lazy Git `brew install lazygit`
- Rip Grep `brew install ripgrep`
- [Git Delta](https://github.com/dandavison/delta) - pretty git diffs
  - Follow instructions in repo:
  - `brew install git-delta`
  - and add the suggested content to your `~/.gitconfig`
  - Add the following yml to your lazygit configuration at `~/Library/Application\ Support/lazygit/config.yml`:
    (or just press `e` in the Status (1) panel to edit the config file of lazygit)
    [see lazygit docs](https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md#delta)
    ```yml
    git:
      paging:
        colorArg: always
        pager: delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format="lazygit-edit://{path}:{line}"
    ```

# Keybindings

leader: `<space>`

| Action         | Keys          |
| -------------- | ------------- |
| Find file      | `<leader>o`   |
| Live Grep      | `<leader>/`   |
| Buffers        | `,`           |
| File Tree      | `<leader>e`   |
| Format File    | `<leader>ff`  |
| Prev. buffer   | `H`           |
| Next buffer    | `L`           |
| Delete buffer  | `<leader>bd`  |
| LazyGit        | `<leader>gg`  |
| Git preview    | `<leader>gp`  |
| Git reset hunk | `<leader<gr>` |
| Git copy link  | `<leader>gy`  |
| Git open link  | `<leader>gY`  |

# Troubleshooting

### Mason Formatter/Diagnostic Version Mismatch

Sometimes a Mason package may have a version mismatch where none-ls will look for a certain version that is not installed.
This can be resolved by explicitly installing the desired version via Mason.

```
:MasonInstall rubocop@1.65.1
```

Troubleshooting performance issues

```
:profile start profile.log
:profile func *
:profile file *
" At this point do slow actions
:profile pause
:noautocmd qall!
```
