# 工具与语言运行时

全局版本配置位于 [`home/.config/mise/config.toml`](../home/.config/mise/config.toml)，通过软链接部署到 `~/.config/mise/config.toml`。具体版本以该文件为准。

| 工具 | 配置方式 |
| --- | --- |
| Node.js | 跟随 LTS |
| Go、Java、Corepack | 固定版本 |
| Python、Bun、uv、Starship | 跟随 latest |
| Ruby | 固定版本，仅 macOS 启用 |

## 修改版本

修改全局配置后，运行：

```sh
mise install
```

需要同时应用系统依赖和配置时，运行 `mise bootstrap`。`mise dot apply` 只部署文件。

项目可以通过自身的 `mise.toml` 覆盖全局版本，例如：

```toml
[tools]
node = "24"
java = "zulu-17.68.17.0"
```

在项目目录运行 `mise trust` 和 `mise install`。`.tool-versions` 也可以声明项目版本；当前配置还启用了 `.nvmrc`、`.python-version` 和 `.ruby-version` 等工具版本文件。

## Python 与 uv

配置启用了 uv 虚拟环境自动激活。通过 uv 安装的 Python 可以同步到 mise：

```sh
mise sync python --uv
```

## Java

全局默认使用 Zulu 17，mise 激活时设置 `JAVA_HOME` 和 Java 命令路径。

已有 Homebrew OpenJDK 可能仍被 apktool、jadx 等工具依赖，删除前需要检查它们的依赖关系。

## 检查当前环境

```sh
mise ls
mise doctor
command -v node
command -v java
```

修改 shell 配置后，执行 `exec zsh -l` 加载。若 doctor 提示工具路径未排在前面，检查是否有后加载的配置重新调整了 PATH。
