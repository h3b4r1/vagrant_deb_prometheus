echo "--- debian11-setup.sh - start ---"
apt -y update
apt -y upgrade
apt -y install curl net-tools

cat > /etc/hosts <<EOF
127.0.0.1       localhost
127.0.0.2       bullseye
::1             localhost ip6-localhost ip6-loopback
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters

127.0.1.1       $HOSTNAME $HOSTNAME
10.0.0.16       shepherd
10.0.0.17       herd1
10.0.0.18       herd2
EOF
echo "--- debian11-setup.sh - end ---"
