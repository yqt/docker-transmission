# docker-transmission
transmission base on alpine along with sshd and nginx with s6 as the process management.

# tips
1. environment variables available for transmission:
    - `USERNAME` - username for login transmission-web. default is `admin`.
    - `PASSWORD` - password for login transmission-web. default is `password`.
1. `rpc-whitelist-enabled` is `true` for default. You need to access transmission-web through `nginx` by `/transmission`