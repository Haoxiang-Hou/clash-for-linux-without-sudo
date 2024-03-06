# clash-for-linux-without-sudo

原仓库使用教程中需要sudo权限，本仓库提供了普通用户如何设置和运行clash的方法

## 克隆仓库

首先，克隆GitHub仓库到本地机器。

```bash
git clone https://github.com/ShengjieJin/clash-for-linux-without-sudo.git
cd clash-for-linux-without-sudo
```


## 编辑配置文件

接下来，你需要根据你的需求编辑Clash的配置文件`conf/config.yaml`。使用你喜欢的文本编辑器打开该文件：

```bash
vim conf/config.yaml
```

以下是一个示例，具体参数请自行修改

```
# 设置HTTP代理端口
port: 7890
# 设置SOCKS5代理端口
socks-port: 7891
# 允许局域网的设备连接
allow-lan: false

proxies:
  - name: "Proxy Server"
    type: {xxx} # trojan等
    server: "{your_site.com}"
    port: 443
    password: "{password}"
    sni: "{your_site.com}" # 通常是您的服务器域名
    skip-cert-verify: false
    alpn:
       - http/1.1
    # network: ws # 使用WebSocket
    # ws-opts:
      # path: "/websocketpath"
      # headers:
        # Host: {your_site.com}

# 代理组配置
proxy-groups:
  - name: "PROXY"
    type: select
    proxies:
      - "Proxy Server"

rules:
  - DOMAIN-SUFFIX,google.com,PROXY
  - DOMAIN-SUFFIX,facebook.com,PROXY
  - GEOIP,CN,DIRECT
  - MATCH,DIRECT

# 日志配置
log-level: debug # 日志级别，info 为一般信息，还有 debug、warning、error 等级别
```

## 设置执行权限

为了确保Clash的执行文件可以运行，你需要给它设置执行权限，根据你的架构选择合适的版本（例如，64位系统的clash-linux-amd64）。：

```bash
chmod +x bin/clash-linux-amd64
```

## 运行Clash

最后，使用以下命令来启动Clash：

```bash
./bin/clash-linux-amd64 -d conf
```

这会启动Clash并使用`conf`目录下的`config.yaml`作为配置文件。

## 自动启动（可选）

你可以使用`tmux`或`screen`来在后台运行Clash，以便它可以在你断开SSH连接后继续运行：

使用`tmux`：

```bash
tmux new-session -d -s clash './bin/clash-linux-amd64 -d conf'
```

或者使用`screen`：

```bash
screen -dmS clash ./bin/clash-linux-amd64 -d conf
```

要重新连接到会话，请分别使用`tmux attach -t clash`或`screen -r clash`。

仓库中提供的start_clash.sh将log保存到`logs/myclash.log`中