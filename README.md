# enpitsulin's dotfiles

使用 [mise](https://mise.jdx.dev/dotfiles.html) 管理配置、运行时和系统依赖。支持 macOS（Apple Silicon）及 Linux（Debian/Ubuntu、Fedora/RHEL），主 shell 为 zsh。

## 安装

1. 安装 Git 和 [mise](https://mise.jdx.dev/getting-started.html) **2026.10.9 或更新版本**。macOS 先安装 Xcode Command Line Tools：`xcode-select --install`，等待安装完成。
2. 克隆仓库并预览：

   ```sh
   git clone https://github.com/enpitsulin/dotfiles.git ~/Projects/dotfiles
   cd ~/Projects/dotfiles
   mise trust
   mise bootstrap --dry-run
   ```

3. 安装依赖、部署配置和安装运行时，然后重新打开登录 shell：

   ```sh
   mise bootstrap
   ```

macOS 的系统依赖由 mise 安装到 Homebrew 前缀，无需预先安装 Homebrew。Linux 使用 apt/dnf，需要安装系统包时会请求 sudo 权限。Starship 和语言运行时统一由 mise 安装。

如需更改 Git 身份，在仓库中新建 `mise.local.toml`（已忽略，不提交）：

```toml
[vars]
git_name = "Your Name"
git_email = "you@example.com"
```

也可以用 `NAME` / `EMAIL` 环境变量覆盖默认身份。`mise.local.toml` 中的值优先。

## 从 chezmoi 迁移

1. 先用 `chezmoi diff` 检查未保存的本机修改，并备份准备替换的配置，尤其是 `~/.config/mise/config.toml`、`~/.gitconfig` 和 `~/.zsh`。
2. 在本仓库运行 `mise trust`、`mise dot diff`，核对内容。需要把本机改动保留到仓库时，先编辑 `home/` 下的对应文件。
3. 将现有普通文件改为仓库软链接需要显式替换：

   ```sh
   mise bootstrap --force-dotfiles
   ```

迁移后使用下面的 mise 命令维护配置。部署也会删除旧的 `~/.zsh/60-java.zsh`。

## 日常使用

在仓库目录中执行；也可以通过 `mise -C ~/Projects/dotfiles ...` 从其他目录执行。

```sh
# 拉取并部署更新，同时安装新增依赖和运行时
git pull --ff-only
mise bootstrap

# 预览配置差异或只部署配置
mise dot diff
mise dot apply

# 检查部署状态
mise dot status

# 编辑受管理文件的源文件
mise dot edit ~/.zshrc
```

普通配置使用软链接，直接编辑目标文件会修改仓库中的源文件。`~/.zsh` 使用逐文件软链接，保留目录中的其他文件；Starship 缓存也不受管理。

Git/GPG 配置通过 Tera 模板生成，应编辑 `home/.gitconfig.tera` 或 `home/.gnupg/gpg-agent.conf.tera`，然后运行 `mise dot apply`。部署会重新生成这两个目标文件。`pinentry-dispatch` 复制为可执行文件。

新增配置时，将源文件放入 `home/`，在根目录 `mise.toml` 的 `[dotfiles]` 中声明目标路径与源路径。

## 目录与平台差异

- `mise.toml`：系统依赖、Git 身份默认值和 dotfiles 部署规则。
- `home/`：对应用户主目录的配置源文件。
- `home/.config/mise/config.toml`：全局运行时配置，部署到 `~/.config/mise/config.toml`。
- `home/.zsh/`：按顺序加载的 zsh 模块，平台路径由 `$OSTYPE` 判断。
- `pc/`：历史 PowerShell 配置，不参与部署。

修改运行时版本后运行 `mise bootstrap` 或 `mise install`。`mise dot apply` 只部署文件，不安装运行时。

## 语言运行时

mise 管理 Node.js（LTS）、Python、Go、Java、Bun、uv、Corepack，以及仅 macOS 使用的 Ruby。迁移保留现有版本选择。

Java 默认为 Zulu 17，mise 激活时设置 `JAVA_HOME` 和命令路径。项目可以在自身的 `mise.toml` 中覆盖：

```toml
[tools]
java = "zulu-17.68.17.0"
```

项目的 `mise.toml`、`.tool-versions`、`.nvmrc`、`.python-version` 和 `.ruby-version` 可以覆盖全局默认值。Python 使用 uv 集成，现有 uv 项目的虚拟环境可自动激活。通过 uv 安装的 Python 可以用 `mise sync python --uv` 同步到 mise。

已有 Homebrew OpenJDK 可能仍被 apktool、jadx 等工具依赖，删除前请检查依赖关系。

## GPG / 提交签名

Git 默认启用 GPG 签名，密钥为 `0672CB8176D09B46A823B81C85C836DC516B372C`。

- mise 安装 GnuPG、git-lfs 和对应平台的 pinentry。
- `~/.local/bin/pinentry-dispatch` 根据终端环境选择终端提示或 macOS 原生对话框。
- `~/.gnupg` 权限为 `0700`，`gpg-agent.conf` 权限为 `0600`。
- 修改 GPG 配置后执行 `gpgconf --kill gpg-agent`，下次使用时会自动重启。
- 私钥不在仓库内，每台机器需要自行导入：

```sh
gpg --import /path/to/private-key.asc
gpg --list-secret-keys --keyid-format=long
```

导入私钥前提交会失败。如需临时跳过签名，使用 `git -c commit.gpgsign=false commit`。
