![](https://img.shields.io/badge/Alpine-3.8-brightgreen.svg) ![](https://img.shields.io/docker/stars/anonymtsk/3proxy.svg) ![](https://img.shields.io/docker/pulls/anonymtsk/3proxy.svg)

#### Environment:

| Environment | Default value |
|-------------|---------------|
| USER        | user          |
| PASSWORD    | password      |
| PORT        | 3128          |
| DNS1        | 1.1.1.1       |
| DNS2        | 8.8.8.8       |
| DENY        | * * 127.0.0.1 |

#### Custom usage:

    docker run \
        -d \
        --name 3proxy \
        -p 3128:3128 \
        -e USER=user \
        -e PASSWORD=password \
        -e PORT=3128 \
        -e DNS1=1.1.1.1 \
        -e DNS1=8.8.8.8 \
        -e DENY="* * 192.168.0.0/24"
        anonymtsk/transmission
