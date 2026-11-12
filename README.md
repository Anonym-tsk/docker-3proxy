# 3proxy

![](https://img.shields.io/badge/Alpine-3.8-brightgreen.svg)

HTTP and SOCKS5 proxy in Docker.

Image: `ghcr.io/anonym-tsk/3proxy:latest`

```sh
docker pull ghcr.io/anonym-tsk/3proxy:latest
```

## Environment

| Environment | Default value |
|-------------|---------------|
| USER        | `user` |
| PASSWORD    | `password` (generates a random password) |
| PORT        | unset (HTTP disabled) |
| SOCKS_PORT  | unset (SOCKS5 disabled) |
| DNS1        | `1.1.1.1` |
| DNS2        | `8.8.8.8` |
| DENY        | `* * 127.0.0.1` |

Set at least one of `PORT` or `SOCKS_PORT`. Both services use the same credentials
and access rules.

## Docker Compose

```yaml
services:
  3proxy:
    image: ghcr.io/anonym-tsk/3proxy:latest
    container_name: 3proxy
    restart: unless-stopped
    ports:
      - "3128:3128"
      - "1080:1080"
    environment:
      USER: proxy
      PASSWORD: "change-me"
      PORT: "3128"
      SOCKS_PORT: "1080"
```

Set your own password, save as `compose.yaml`, and run `docker compose up -d`.
Remove `PORT` and its port mapping to disable HTTP, or `SOCKS_PORT` and its
port mapping to disable SOCKS5.
