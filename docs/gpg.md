# GPG 与提交签名

Git 默认启用 GPG 签名。签名密钥在 [`home/.gitconfig.tera`](../home/.gitconfig.tera) 中设置，默认指纹为 `0672CB8176D09B46A823B81C85C836DC516B372C`。

## 导入私钥

私钥不在仓库中，每台机器需要自行导入与签名配置对应的密钥：

```sh
gpg --import /path/to/private-key.asc
gpg --list-secret-keys --keyid-format=long
```

使用其他密钥时，修改模板中的 `signingkey`，再运行：

```sh
mise dot apply
```

Git 姓名和邮箱的设置见 [配置与平台](configuration.md#本机-git-身份)。

## 密码输入方式

`mise bootstrap` 安装 GnuPG、git-lfs 和对应平台的 pinentry。`~/.gnupg/gpg-agent.conf` 指向 `~/.local/bin/pinentry-dispatch`：

- 有终端时，使用 `pinentry-curses`。
- 无终端且安装了 `pinentry-mac` 时，使用 macOS 原生对话框。
- 其他情况下，回退到 `pinentry-tty`。

`~/.gnupg` 的权限为 `0700`，`gpg-agent.conf` 为 `0600`，分发脚本为 `0755`。

## 修改与排查

修改 [`home/.gnupg/gpg-agent.conf.tera`](../home/.gnupg/gpg-agent.conf.tera) 或分发脚本后，重新应用并重启 agent：

```sh
mise dot apply
gpgconf --kill gpg-agent
```

下次使用时 agent 会自动启动。提交失败时，先检查私钥是否已导入，以及 `git config user.signingkey` 是否与之对应。

需要临时跳过签名时：

```sh
git -c commit.gpgsign=false commit
```
