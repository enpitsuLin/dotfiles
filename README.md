# enpitsulin's dotfiles

使用 [mise](https://mise.jdx.dev/dotfiles.html) 管理配置、开发工具和系统依赖。支持 macOS（Apple Silicon）和 Linux（apt/dnf），主 shell 为 zsh。

## 安装

准备好 Git 和 [mise](https://mise.jdx.dev/getting-started.html) 2026.10.9+。macOS 还需要 Xcode Command Line Tools：`xcode-select --install`。

```sh
git clone https://github.com/enpitsulin/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
mise trust
mise bootstrap --dry-run
mise bootstrap
exec zsh -l
```

已有配置发生冲突时，先备份并核对 `mise dot diff`，再使用 `mise bootstrap --force-dotfiles` 替换。

## 日常使用

在仓库目录执行：

| 操作 | 命令 |
| --- | --- |
| 更新 | `git pull --ff-only`，然后 `mise bootstrap` |
| 查看差异 | `mise dot diff` |
| 只应用配置 | `mise dot apply` |
| 查看状态 | `mise dot status` |
| 编辑配置 | `mise dot edit ~/.zshrc` |

普通配置使用软链接，可以直接编辑。Git/GPG 配置由 `.tera` 模板生成，修改模板后运行 `mise dot apply`。

## 自定义

- `home/`：配置源文件。
- `mise.toml`：文件部署规则和系统依赖。
- `home/.config/mise/config.toml`：全局工具版本，修改后运行 `mise install`。

Git 身份可以在仓库的 `mise.local.toml` 中覆盖，该文件已被 Git 忽略：

```toml
[vars]
git_name = "Your Name"
git_email = "you@example.com"
```

## 提交签名

Git 默认启用 GPG 签名。私钥需在每台机器上自行导入：

```sh
gpg --import /path/to/private-key.asc
```

其他密钥设置和密码提示配置见 [GPG 与提交签名](docs/gpg.md)。

## 详细说明

- [配置与平台](docs/configuration.md)：文件管理、自定义与平台路径。
- [工具与语言运行时](docs/runtimes.md)：版本管理、Python/uv 和 Java。
- [GPG 与提交签名](docs/gpg.md)：私钥、密码提示与故障排查。
