
uid="$(id -u)"
gid="$(id -g)"

docker run --rm -u "$uid:$gid" -i -v $PWD:/mnt lindig/xen-tools<<-'EOF'
  set -e
  cd /mnt
  make
EOF

