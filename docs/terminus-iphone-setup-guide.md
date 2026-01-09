# Terminus iPhone 设置详细指南

## 前提条件
- ✅ Mac 上 SSH 服务器已启用
- ✅ Tailscale 在 Mac 上已安装并连接
- ✅ SSH 密钥已生成
- 📱 iPhone 需要完成以下设置

---

## 第一步：安装 Tailscale（5 分钟）

### 1.1 下载并安装 Tailscale
1. 在 iPhone 上打开 **App Store**
2. 搜索 **"Tailscale"**
3. 找到官方 Tailscale app（开发者：Tailscale Inc.）
4. 点击 **"获取"** 安装

### 1.2 登录 Tailscale
1. 打开 Tailscale app
2. 点击 **"Get Started"** 或 **"Sign in"**
3. **⚠️ 重要：使用与 Mac 相同的账号登录**
   - 选择你在 Mac 上使用的登录方式：
     - Google
     - GitHub
     - Microsoft
     - Email
4. 在浏览器中完成登录验证
5. 返回 Tailscale app

### 1.3 验证连接
1. Tailscale app 应显示 **"Connected"** 或 **"已连接"**
2. 点击 **"Machines"** 或 **"设备"** 标签
3. 你应该看到：
   ```
   tiankais-macbook-pro
   Online (或 在线)
   100.98.187.39
   ```
4. 如果看到你的 Mac，说明 Tailscale 设置成功！✅

---

## 第二步：传输 SSH 私钥到 iPhone（关键步骤）

### 方法 1：通过 AirDrop（推荐 - 最快）

#### 在 Mac 上：
1. 创建临时文本文件：
   ```bash
   cat ~/.ssh/terminus_iphone_ed25519 > ~/Desktop/macbook_ssh_key.txt
   ```
2. 打开 Finder，找到桌面上的 `macbook_ssh_key.txt`
3. 右键点击 → **共享** → **AirDrop**
4. 选择你的 iPhone
5. 传输完成后，**删除桌面上的文件**：
   ```bash
   rm ~/Desktop/macbook_ssh_key.txt
   ```

#### 在 iPhone 上：
1. 接受 AirDrop 传输
2. 文件会保存到 **文件 app** 的 **下载** 文件夹
3. 记住文件位置，稍后导入到 Terminus

### 方法 2：通过 iCloud Notes（安全）

#### 在 Mac 上：
1. 打开 **备忘录 (Notes)** app
2. 创建新备忘录，标题：`Mac SSH Key - 临时`
3. 复制私钥内容：
   ```bash
   pbcopy < ~/.ssh/terminus_iphone_ed25519
   ```
4. 粘贴到备忘录
5. 等待 iCloud 同步（几秒钟）

#### 在 iPhone 上：
1. 打开 **备忘录** app
2. 找到 `Mac SSH Key - 临时` 备忘录
3. 长按私钥内容，选择 **"全选"** → **"拷贝"**
4. 保留备忘录，稍后导入完成后再删除

### 方法 3：手动复制（最安全但麻烦）

#### 在 Mac 上显示私钥：
```bash
cat ~/.ssh/terminus_iphone_ed25519
```

输出：
```
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACCuWRHZq8z8TwQKI3nr7+dxSfRx48Zlo9aCU6ZPkwDHywAAAKA4f0LhOH9C
4QAAAAtzc2gtZWQyNTUxOQAAACCuWRHZq8z8TwQKI3nr7+dxSfRx48Zlo9aCU6ZPkwDHyw
AAAECzpsMUR8BSP4M4cZZ7BNk4OMylREzKhInZYw4H6ZtY/K5ZEdmrzPxPBAojeevv53FJ
9HHjxmWj1oJTpk+TAMfLAAAAGHRlcm1pbnVzLWlwaG9uZS0yMDI2MDEwOQECAwQF
-----END OPENSSH PRIVATE KEY-----
```

**在 iPhone 上手动输入**（不推荐，容易出错）

---

## 第三步：安装 Terminus（2 分钟）

### 3.1 下载 Terminus
1. 在 iPhone 上打开 **App Store**
2. 搜索 **"Terminus"**
3. 找到 **Terminus - SSH Shell Console**（开发者：Yang Luo）
4. 点击 **"获取"** 安装（可能是付费 app，也有免费版本）

### 3.2 首次打开
1. 打开 Terminus app
2. 可能会提示权限或引导教程，按提示完成
3. 进入主界面

---

## 第四步：在 Terminus 中导入 SSH 密钥（重要！）

### 4.1 进入密钥管理
1. 在 Terminus app 底部，点击 **"设置"** 或 **"Settings"** 图标（齿轮图标）
2. 找到并点击 **"Keys"** 或 **"密钥"**
3. 点击右上角的 **"+"** 或 **"Add Key"**

### 4.2 添加密钥

#### 如果使用 AirDrop 方法：
1. 密钥类型选择：**"Import from file"** 或 **"从文件导入"**
2. 点击 **"浏览"** 或 **"Browse"**
3. 导航到 **文件 app** → **下载** → 选择 `macbook_ssh_key.txt`
4. 密钥名称输入：`MacBook Pro Key`
5. **不要设置 Passphrase**（我们生成密钥时没设密码）
6. 点击 **"保存"** 或 **"Save"**

#### 如果使用 iCloud Notes 方法：
1. 密钥类型选择：**"Paste private key"** 或 **"粘贴私钥"**
2. 密钥名称输入：`MacBook Pro Key`
3. 在私钥输入框中，长按 → **"粘贴"**（从备忘录复制的内容）
4. 确保完整粘贴，包括：
   ```
   -----BEGIN OPENSSH PRIVATE KEY-----
   （中间的内容）
   -----END OPENSSH PRIVATE KEY-----
   ```
5. **不要设置 Passphrase**
6. 点击 **"保存"** 或 **"Save"**

### 4.3 验证密钥导入成功
- 在 Keys 列表中应该看到：
  ```
  📌 MacBook Pro Key
  Type: ED25519
  ```

### 4.4 清理临时文件（重要！）
- **AirDrop 方法**：删除 iPhone 文件 app 中的 `macbook_ssh_key.txt`
- **iCloud Notes 方法**：删除备忘录 `Mac SSH Key - 临时`

---

## 第五步：添加 SSH 主机配置（5 分钟）

### 5.1 创建新主机
1. 返回 Terminus 主界面
2. 点击右上角的 **"+"** 或 **"Add Host"**

### 5.2 填写主机信息

**必填字段**：

| 字段 | 值 | 说明 |
|------|-----|------|
| **Host Label** / **名称** | `MacBook Pro` | 显示名称，可自定义 |
| **Hostname** / **主机名** | `100.98.187.39` | 你的 Tailscale IP |
| **Port** / **端口** | `22` | SSH 默认端口 |
| **Username** / **用户名** | `tiankaixie` | Mac 用户名 |
| **Authentication** / **认证方式** | `Key` 或 `密钥` | 选择密钥认证 |
| **Key** / **密钥** | `MacBook Pro Key` | 选择刚导入的密钥 |

**可选字段**（可留空或使用默认值）：
- **Description**：`家里的 MacBook Pro`
- **Tag**：`Personal` 或 `个人`
- **Icon**：选择一个喜欢的图标

### 5.3 保存配置
1. 检查所有信息无误
2. 点击右上角 **"保存"** 或 **"Save"**
3. 主机列表中应该出现 **"MacBook Pro"**

---

## 第六步：首次连接测试（激动人心！）

### 6.1 确认前提条件
在连接之前，确保：
- ✅ iPhone 上 Tailscale 显示 **"Connected"**
- ✅ Mac 上 Tailscale 菜单栏图标显示已连接
- ✅ Mac 没有休眠（屏幕可以关闭，但系统不能休眠）

### 6.2 首次连接
1. 在 Terminus 主界面，点击 **"MacBook Pro"**
2. 可能会提示 **"The authenticity of host... can't be established"**
   - 这是正常的首次连接提示
   - 点击 **"Yes"** 或 **"接受"** 信任主机密钥
3. 🎉 **成功！** 你应该看到：
   ```
   tiankaixie@Tiankais-MacBook-Pro ~ %
   ```

### 6.3 测试命令
输入以下命令测试：

```bash
# 确认用户身份
whoami
# 输出: tiankaixie

# 查看当前目录
pwd
# 输出: /Users/tiankaixie

# 列出文件
ls -la

# 查看系统信息
uname -a

# 查看 Tailscale 连接
tailscale status
```

如果所有命令都正常工作，**恭喜你设置成功！**🎉

---

## 常见问题和故障排查

### ❌ 问题 1："Connection Timeout" 或 "连接超时"

**原因**：
- Tailscale 未连接
- Mac 休眠了
- 防火墙阻止了连接

**解决方法**：
1. 检查 iPhone 上 Tailscale 是否显示 "Connected"
2. 检查 Mac 上 Tailscale 菜单栏图标是否正常
3. 在 Mac 上运行：
   ```bash
   tailscale status
   ps aux | grep sshd | grep -v grep
   ```
4. 唤醒 Mac（点击键盘或鼠标）

---

### ❌ 问题 2："Permission denied (publickey)"

**原因**：
- SSH 密钥不匹配
- 密钥未正确导入
- 用户名错误

**解决方法**：
1. **检查 Terminus 中的主机配置**：
   - Username 必须是 `tiankaixie`（不是 `root`）
   - Key 必须选择 `MacBook Pro Key`

2. **重新导入密钥**：
   - 删除 Terminus 中的旧密钥
   - 重新从 Mac 复制私钥
   - 确保包含完整的 `-----BEGIN-----` 和 `-----END-----`

3. **在 Mac 上验证公钥**：
   ```bash
   cat ~/.ssh/authorized_keys | grep terminus-iphone
   ```
   应该能看到对应的公钥

---

### ❌ 问题 3："Host key verification failed"

**原因**：
- Mac 的主机密钥改变了
- 重装了 macOS
- 第一次连接的正常提示

**解决方法**：
1. **如果是首次连接**：点击 **"Yes"** 接受密钥
2. **如果之前能连接，现在不行**：
   - 在 Terminus 中删除该主机
   - 重新添加主机配置

---

### ❌ 问题 4：连接后立即断开

**原因**：
- Mac 防火墙阻止了 SSH
- SSH 配置错误

**解决方法**：
在 Mac 上运行：
```bash
# 检查 SSH 服务状态
sudo launchctl list | grep sshd

# 查看 SSH 日志
sudo log show --predicate 'process == "sshd"' --last 5m

# 重启 SSH 服务
sudo launchctl kickstart -k system/com.openssh.sshd
```

---

### ❌ 问题 5：输入延迟高或卡顿

**原因**：
- 网络延迟
- Tailscale 使用了中继服务器（DERP）而非直连

**解决方法**：
1. 检查 Tailscale 连接类型：
   ```bash
   tailscale status
   ```
   看是否显示 "relay" 或 "direct"

2. 如果是 relay：
   - 确保两台设备都连接到稳定网络
   - 等待几秒，Tailscale 会尝试建立直连

3. 切换网络：
   - 试试 WiFi 和蜂窝数据，看哪个更快

---

## 高级技巧

### 📌 技巧 1：设置快捷命令
在 Terminus 中可以创建 Snippets（代码片段）：
1. Settings → Snippets → "+"
2. 名称：`更新 Homebrew`
3. 命令：`brew update && brew upgrade && brew cleanup`
4. 保存

使用时直接点击该 Snippet 即可执行。

---

### 📌 技巧 2：端口转发（访问本地 Web 服务）
如果 Mac 上运行了 Web 服务（如 `localhost:3000`），可以在 iPhone 上访问：

1. 编辑主机配置
2. 找到 **Port Forwarding** 或**端口转发**
3. 添加规则：
   ```
   Local Port: 3000
   Remote Host: localhost
   Remote Port: 3000
   ```
4. 保存并连接

现在在 iPhone Safari 中访问 `http://localhost:3000` 就能看到 Mac 上的网页了！

---

### 📌 技巧 3：多会话管理
Terminus 支持同时开启多个 SSH 会话：
1. 连接到 Mac 后
2. 从右边缘向左滑动
3. 点击 "+" 创建新会话
4. 可以在不同会话之间切换

用途：
- 一个会话运行长任务（如编译代码）
- 另一个会话查看日志或编辑文件

---

### 📌 技巧 4：自定义外观（NERV 主题）
匹配你的 Mac NERV 主题：
1. Settings → Appearance
2. Background Color: `#0a1612`（深绿色）
3. Foreground Color: `#8fb3a5`（浅绿色）
4. Cursor Color: `#e85d04`（橙色）

---

## 安全提醒

### ⚠️ 重要安全建议

1. **保护 iPhone**：
   - 启用强密码或 Face ID / Touch ID
   - 启用 "查找我的 iPhone"
   - 如果 iPhone 丢失，立即在 Mac 上删除 `~/.ssh/authorized_keys` 中的对应公钥

2. **定期检查授权设备**：
   - 访问 https://login.tailscale.com/admin/machines
   - 检查所有设备都是你认识的
   - 移除不再使用的设备

3. **保护私钥**：
   - 导入到 Terminus 后，删除所有临时副本
   - 不要通过不安全的方式分享私钥（如短信、邮件）
   - 如果怀疑私钥泄露，立即在 Mac 上重新生成新密钥

4. **禁用密码认证**（可选，更安全）：
   在 Mac 上确认密钥登录成功后：
   ```bash
   sudo nano /etc/ssh/sshd_config.d/99-custom-security.conf
   ```
   取消注释这些行：
   ```
   PasswordAuthentication no
   KbdInteractiveAuthentication no
   ChallengeResponseAuthentication no
   ```
   重启 SSH：
   ```bash
   sudo launchctl kickstart -k system/com.openssh.sshd
   ```

---

## 使用场景示例

### 场景 1：在咖啡店紧急修复代码
1. 打开 Terminus，连接到 Mac
2. 导航到项目目录：`cd ~/Projects/my-app`
3. 编辑文件：`vim src/bug.js` 或 `nano src/bug.js`
4. 提交修复：`git add . && git commit -m "Fix bug" && git push`

### 场景 2：检查 Mac 上的长任务进度
1. 早上在 Mac 上启动训练模型：`python train.py`
2. 下午在外面用 iPhone 连接
3. 查看进程：`ps aux | grep python`
4. 查看日志：`tail -f training.log`

### 场景 3：远程重启服务
1. 连接到 Mac
2. 重启 Homebrew 服务：`brew services restart nginx`
3. 检查状态：`brew services list`

### 场景 4：快速传输文件
1. 在 Terminus 中切换到 SFTP 模式
2. 浏览 Mac 文件系统
3. 下载文件到 iPhone 或上传文件到 Mac

---

## 总结

你现在已经设置好了：
✅ Tailscale 安全 VPN 连接
✅ SSH 密钥认证（无需密码）
✅ Terminus 完整配置
✅ 可以从任何地方访问你的 Mac

**连接信息**：
- **Tailscale IP**: `100.98.187.39`
- **用户名**: `tiankaixie`
- **端口**: `22`
- **认证**: SSH 密钥（ED25519）

享受随时随地访问你的 Mac 的便利！🎉

---

**文档版本**: 1.0
**创建日期**: 2026-01-09
**适用于**: Terminus iOS app + macOS SSH Server
