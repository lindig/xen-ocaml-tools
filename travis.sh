
docker run --rm -i -v $PWD:/mnt lindig/xen-tools<<-'EOF'
  set -e
  cd /mnt
  umask 0002
  make
EOF

