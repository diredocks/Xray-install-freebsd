echo "security.mac.portacl.rules=uid:$(id -u v2ray):tcp:443" >> /etc/sysctl.conf
echo "net.inet.ip.portrange.reservedhigh=0" >> /etc/sysctl.conf
