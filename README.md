# Xray-install-freebsd
Deploy Xray Reality on FreeBSD with ease

## Requirements

Install `xray` and `jq` with `pkg`:
```sh
pkg install xray jq
```

## Usage

```sh
chmod +x ./*.sh

./gen_xray_config.sh # to generate xray inbound config  
doas ./set_mac_port_access.sh # to allow non-privileged xray processes to bind to port 443
doas ./apply_config.sh # to copy generated configs in place
```

## Others

```sh
doas service enable xray # to add xray into system startup
```