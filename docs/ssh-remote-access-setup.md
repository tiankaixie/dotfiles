# SSH 远程访问设置指南

## 概述
通过 Tailscale VPN + SSH 密钥认证，从 iPhone (Terminus app) 安全访问 macOS。

## 系统信息
- **macOS 用户名**: tiankaixie
- **Tailscale IP**: 100.98.187.39
- **机器名**: tiankais-macbook-pro
- **SSH 端口**: 22

## 已完成的配置步骤

### 1. 启用 SSH 服务器
通过系统设置启用：
```
系统设置 → 通用 → 共享 → 远程登录 (打开)
```

验证：
```bash
netstat -an | grep "\.22 " | grep LISTEN
# 应显示 tcp4 和 tcp6 在监听 22 端口
```

### 2. SSH 安全配置
**配置文件位置**: `/etc/ssh/sshd_config.d/99-custom-security.conf`

**配置内容**:
```conf
# 启用公钥认证
PubkeyAuthentication yes

# 禁用 root 登录
PermitRootLogin no

# 只允许特定用户
AllowUsers tiankaixie

# 现代加密算法
KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256
Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256

# 移动设备优化 - 保持连接
ClientAliveInterval 60
ClientAliveCountMax 3

# 详细日志
LogLevel VERBOSE
```

**注意**: 初始配置中密码认证未禁用，测试成功后可以禁用：
```conf
PasswordAuthentication no
KbdInteractiveAuthentication no
ChallengeResponseAuthentication no
```

**应用配置**:
```bash
sudo cp /tmp/99-custom-security.conf /etc/ssh/sshd_config.d/99-custom-security.conf
sudo sshd -t  # 验证配置语法
sudo launchctl kickstart -k system/com.openssh.sshd  # 重启 SSH
```

### 3. SSH 密钥生成
**密钥位置**:
- 私钥: `~/.ssh/terminus_iphone_ed25519`
- 公钥: `~/.ssh/terminus_iphone_ed25519.pub`

**生成命令**:
```bash
ssh-keygen -t ed25519 -C "terminus-iphone-$(date +%Y%m%d)" -f ~/.ssh/terminus_iphone_ed25519 -N ""
chmod 600 ~/.ssh/terminus_iphone_ed25519
chmod 644 ~/.ssh/terminus_iphone_ed25519.pub
cat ~/.ssh/terminus_iphone_ed25519.pub >> ~/.ssh/authorized_keys
chmod 644 ~/.ssh/authorized_keys
```

**获取私钥（传输到 iPhone）**:
```bash
cat ~/.ssh/terminus_iphone_ed25519
# 或复制到剪贴板
pbcopy < ~/.ssh/terminus_iphone_ed25519
```

### 4. Tailscale 安装和配置
**安装**:
```bash
brew install --cask tailscale
```

或访问: https://tailscale.com/download/mac

**启动和认证**:
```bash
sudo tailscale up
# 在浏览器中登录 Tailscale 账号
```

**获取 IP 地址**:
```bash
tailscale ip -4
# 输出: 100.98.187.39

tailscale status
# 查看完整状态
```

**优化设置**:
```bash
sudo tailscale up --accept-routes --accept-dns
```

**在 Tailscale 管理控制台中**:
- 启用 MagicDNS: https://login.tailscale.com/admin/dns
- 禁用密钥过期: https://login.tailscale.com/admin/machines → 选择设备 → Disable key expiry

### 5. 本地测试
```bash
ssh -i ~/.ssh/terminus_iphone_ed25519 tiankaixie@100.98.187.39 "whoami"
# 应输出: tiankaixie
```

### 6. 防火墙配置
```bash
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/sbin/sshd
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /usr/sbin/sshd
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
```

## iPhone 端设置

### 1. 安装 Tailscale
1. App Store 搜索 "Tailscale"
2. 安装并打开
3. **使用与 Mac 相同的账号登录**
4. 确认能看到 Mac (tiankais-macbook-pro)

### 2. 安装和配置 Terminus
1. App Store 搜索 "Terminus"
2. 安装并打开

**添加主机配置**:
```
Host Label: MacBook Pro
Hostname: 100.98.187.39
         或: tiankais-macbook-pro (如启用 MagicDNS)
Port: 22
Username: tiankaixie
Authentication: Key
```

**导入 SSH 密钥**:
1. Terminus → Settings → Keys → "+"
2. 名称: "MacBook Pro Key"
3. 粘贴私钥内容（从 Mac 复制的）
4. 保存

**关联密钥到主机**:
1. 编辑 "MacBook Pro" 主机
2. Authentication → Key → 选择 "MacBook Pro Key"
3. 保存

### 3. 测试连接
1. 确保 Tailscale 在 iPhone 和 Mac 上都已连接
2. 在 Terminus 中点击 "MacBook Pro"
3. 应该自动连接到终端
4. 测试命令: `whoami`, `pwd`, `ls`

## 安全最佳实践

### 已实施的安全措施
- ✅ SSH 仅通过 Tailscale VPN 访问（非公网）
- ✅ 使用 ED25519 密钥认证（现代、安全、高效）
- ✅ 现代加密算法
- ✅ 防火墙已启用
- ✅ 仅允许特定用户访问
- ✅ 禁用 root 登录
- ✅ 连接保活（移动友好）

### 可选的额外安全措施
**禁用密码认证**（测试成功后）:
```bash
sudo nano /etc/ssh/sshd_config.d/99-custom-security.conf
# 取消注释以下行:
# PasswordAuthentication no
# KbdInteractiveAuthentication no
# ChallengeResponseAuthentication no

sudo launchctl kickstart -k system/com.openssh.sshd
```

**防止 Mac 休眠**:
```bash
# 接电源时保持 SSH 连接不休眠
sudo pmset -c ttyskeepawake 1
```

**启用 Tailscale 2FA**:
在 Tailscale 账户设置中启用两步验证

## 维护和检查

### 检查 SSH 连接
```bash
# 查看活动 SSH 连接
sudo lsof -i :22

# 查看最近登录
last -20

# 查看 SSH 日志
sudo log show --predicate 'process == "sshd"' --last 1h --style syslog

# 检查失败的认证尝试
sudo log show --predicate 'process == "sshd"' --last 1h | grep -i "failed"
```

### 检查 Tailscale 状态
```bash
tailscale status
tailscale ip -4
```

### 更新
```bash
# 更新 Tailscale
brew upgrade --cask tailscale

# 检查 macOS 更新
# 系统设置 → 通用 → 软件更新
```

## 故障排查

### "Connection Timed Out"
```bash
# Mac 上检查 SSH 是否运行
sudo launchctl list | grep sshd

# 检查 Tailscale 状态
tailscale status

# iPhone 上确认 Tailscale 已连接（绿色图标）
```

### "Permission Denied (publickey)"
```bash
# 验证公钥在 authorized_keys 中
cat ~/.ssh/authorized_keys | grep terminus-iphone

# 检查权限
chmod 700 ~/.ssh
chmod 644 ~/.ssh/authorized_keys

# 查看详细日志
sudo log show --predicate 'process == "sshd"' --last 5m

# iPhone 上确认:
# - 选择了正确的私钥
# - 用户名是 tiankaixie
```

### 连接断开
```bash
# 检查 Mac 电源设置
pmset -g

# 保持连接
sudo pmset -c ttyskeepawake 1
```

## 备份重要文件

**需要备份的文件**:
```bash
# SSH 私钥（敏感！安全存储）
~/.ssh/terminus_iphone_ed25519

# SSH 配置
~/.ssh/config
~/.ssh/authorized_keys

# SSH 服务器配置
/etc/ssh/sshd_config.d/99-custom-security.conf
```

**创建备份**:
```bash
mkdir -p ~/Backups/ssh-config-$(date +%Y%m%d)
cp -r ~/.ssh ~/Backups/ssh-config-$(date +%Y%m%d)/
sudo cp /etc/ssh/sshd_config.d/99-custom-security.conf ~/Backups/ssh-config-$(date +%Y%m%d)/
tailscale status > ~/Backups/ssh-config-$(date +%Y%m%d)/tailscale-status.txt
```

## 重新安装 macOS 后恢复

1. 启用 Remote Login（系统设置）
2. 安装 Tailscale: `brew install --cask tailscale`
3. 登录 Tailscale（同一账号）
4. 恢复 SSH 配置:
   ```bash
   sudo cp ~/Backups/ssh-config-YYYYMMDD/99-custom-security.conf /etc/ssh/sshd_config.d/
   cp ~/Backups/ssh-config-YYYYMMDD/.ssh/authorized_keys ~/.ssh/
   chmod 700 ~/.ssh
   chmod 644 ~/.ssh/authorized_keys
   sudo launchctl kickstart -k system/com.openssh.sshd
   ```
5. iPhone 上无需改动，自动重新连接

## 为什么选择这个方案？

### Tailscale 优势
- 无需路由器端口转发
- 自动 NAT 穿透
- 不暴露 SSH 到公网
- 免费（个人使用，最多 100 设备）
- 跨平台（iOS、Android、macOS、Windows、Linux）

### ED25519 密钥优势
- 比 RSA 更安全且密钥更短
- 计算速度快（移动设备友好）
- 抗量子计算攻击能力更强

### 安全性
- 端到端加密（Tailscale + SSH）
- 密钥认证（不依赖密码）
- VPN 隔离（非公网访问）
- 现代加密算法

## 相关链接
- Tailscale 文档: https://tailscale.com/kb/
- Tailscale 管理控制台: https://login.tailscale.com/admin/
- OpenSSH 文档: https://www.openssh.com/manual.html
- ED25519 介绍: https://ed25519.cr.yp.to/

---

**创建日期**: 2026-01-09
**最后更新**: 2026-01-09
**适用系统**: macOS (Darwin 25.2.0)
