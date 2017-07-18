
uid="$(id -u)"
gid="$(id -g)"

docker run --rm -u "$uid:$gid" -i -v $PWD:/mnt xen/ocaml <<-'EOF'
  set -e
  cd /mnt
  test -d jbuilder || git clone https://github.com/janestreet/jbuilder
  make -C jbuilder
  ./jbuilder/_build/install/default/bin/jbuilder build
EOF

