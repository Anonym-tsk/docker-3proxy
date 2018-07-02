##################
# Building stage #
##################
FROM alpine:latest as builder

# Install base packages
RUN apk update && apk add tar build-base linux-headers bind-tools

# Download 3proxy
ENV VERSION=0.8.12
ARG URL="https://github.com/z3APA3A/3proxy/archive/$VERSION.tar.gz"
RUN mkdir -p /usr/src/3proxy
WORKDIR /usr/src
RUN wget -O 3proxy.tar.gz $URL && \
    tar -xzf 3proxy.tar.gz -C /usr/src/3proxy --strip-components=1 && \
    rm 3proxy.tar.gz
WORKDIR /usr/src/3proxy

# Compile and install 3proxy
RUN make -f Makefile.Linux && \
    make -f Makefile.Linux install

#########################
# Execution image stage #
#########################
FROM alpine:latest

# Define default ENV values
ENV USER=user
ENV PASSWORD=password
ENV PORT=3128
ENV DNS1=1.1.1.1
ENV DNS2=8.8.8.8

# Install and setup 3proxy files
COPY --from=builder /usr/local/bin/ /usr/local/bin/

RUN apk update && apk add bind-tools bash
WORKDIR /usr/local/etc/3proxy/

ADD 3proxy.cfg.dist /usr/local/etc/3proxy/
ADD entrypoint.sh /usr/local/etc/3proxy/
RUN chmod +x /usr/local/etc/3proxy/entrypoint.sh

EXPOSE $PORT
ENTRYPOINT ["/usr/local/etc/3proxy/entrypoint.sh"]

CMD ["start_proxy"]
