test -z $OUT_PATHS ||
exec nix store sign --key-file /etc/nix/key.private $OUT_PATHS
