# 配置与平台

## 文件组织

| 路径 | 用途 |
| --- | --- |
| [`mise.toml`](../mise.toml) | 系统依赖、Git 身份默认值和文件部署规则 |
| [`home/`](../home/) | 对应用户主目录的配置源文件 |
| [`home/.config/mise/config.toml`](../home/.config/mise/config.toml) | 全局工具版本与 mise 设置 |
| [`home/.zsh/`](../home/.zsh/) | 按文件名前缀顺序加载的 zsh 模块 |
| [`pc/`](../pc/README.md) | 历史 Windows 配置，不参与部署 |

## 文件如何应用

1. 普通配置使用软链接，编辑主目录中的目标文件会直接修改仓库源文件。仓库需要保留在原位置。
2. `~/.zsh` 使用逐文件软链接，目录中的其他文件会保留。Starship 只管理配置文件，缓存不受管理。
3. Git/GPG 配置由 `.tera` 模板生成。应修改源模板，再运行 `mise dot apply`；直接修改生成文件的内容会在下次应用时被覆盖。
4. `pinentry-dispatch` 复制到 `~/.local/bin/` 并设置执行权限，修改源脚本后也需要重新应用。

新增配置时，把文件放入 `home/`，然后在根目录 `mise.toml` 中声明：

```toml
[dotfiles]
"~/.config/example/config.toml" = { source = "home/.config/example/config.toml", mode = "symlink" }
```

运行 `mise dot diff` 核对差异，再运行 `mise dot apply`。这两个命令只处理配置；需要安装工具或系统依赖时使用 `mise bootstrap`。

从其他目录操作仓库时，可以使用：

```sh
mise -C ~/Projects/dotfiles dot diff
mise -C ~/Projects/dotfiles bootstrap
```

## 本机 Git 身份

根目录的 Git 姓名和邮箱默认值分别支持 `NAME`、`EMAIL` 环境变量。需要固定本机身份时，使用已被 Git 忽略的 `mise.local.toml`，其值优先于默认值：

```toml
[vars]
git_name = "Your Name"
git_email = "you@example.com"
```

修改后运行 `mise dot apply` 重新生成 Git 配置。签名密钥的设置见 [GPG 与提交签名](gpg.md)。

## 平台差异

- macOS 支持 Apple Silicon，系统依赖由 mise 安装到 Homebrew 前缀，无需预先安装 Homebrew。首次安装前需要准备好 Xcode Command Line Tools。
- Linux 使用 apt 或 dnf，只安装当前系统对应的依赖；需要权限时会调用 sudo。
- 两个平台都使用 zsh。bash 和 POSIX 登录配置仅提供基本路径。Linux 需要切换默认 shell 时，可运行 `chsh -s "$(command -v zsh)"`。

PNPM 和 Android SDK 的默认路径由 `home/.zsh/10-paths.zsh` 设置：

| 路径 | macOS | Linux |
| --- | --- | --- |
| `PNPM_HOME` | `~/Library/pnpm` | `~/.local/share/pnpm` |
| `ANDROID_HOME` | `~/Library/Android/sdk` | `~/Android/Sdk` |

已有的 `ANDROID_HOME` 会保留。Cargo 路径排在 mise 工具之后，确保同名命令优先使用 mise 管理的版本。
