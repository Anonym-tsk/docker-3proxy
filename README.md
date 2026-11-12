![](https://img.shields.io/badge/Alpine-3.8-brightgreen.svg) ![](https://img.shields.io/docker/stars/anonymtsk/3proxy.svg) ![](https://img.shields.io/docker/pulls/anonymtsk/3proxy.svg)

#### Environment:

| Environment | Default value |
|-------------|---------------|
| USER        | user          |
| PASSWORD    | password      |
| PORT        | unset (HTTP disabled) |
| SOCKS_PORT  | unset (SOCKS5 disabled) |
| DNS1        | 1.1.1.1       |
| DNS2        | 8.8.8.8       |
| DENY        | * * 127.0.0.1 |

Set `PORT` to enable HTTP, `SOCKS_PORT` to enable SOCKS5, or both to run both
services with the same credentials and access rules. At least one port is required.
Publish each enabled port with Docker's `-p` option.

For SOCKS5 only, replace `-e PORT=3128` and `-p 3128:3128` below with
`-e SOCKS_PORT=1080` and `-p 1080:1080`. For both, add those SOCKS5 options
alongside the HTTP options.

#### Custom usage:

    docker run \
        -d \
        --name 3proxy \
        -p 3128:3128 \
        -e USER=user \
        -e PASSWORD=password \
        -e PORT=3128 \
        -e DNS1=1.1.1.1 \
        -e DNS2=8.8.8.8 \
        -e DENY="* * 192.168.0.0/24" \
        anonymtsk/3proxy
