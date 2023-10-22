#!/bin/sh

cd "${0%/*}" || exit 1
read -p "输入管理员密码: " -r passwd
printf "\r\033[1A%s" "" 1>&2
printf "\r\033[K%s" "" 1>&2
echo "${passwd}" | sudo -S echo "当前是 $(sudo whoami) 用户"

PDFM_DIR="/Applications/Parallels Desktop.app"
PDFM_DISP_DST="${PDFM_DIR}/Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service"
PDFM_DISP_PATCH="${PDFM_DISP_DST}_patched"
PDFM_DISP_BCUP="${PDFM_DISP_DST}_backup"

if [ "$(pgrep -x prl_disp_service)" != "" ] && [ "$(pgrep -x prl_client_app)" != "" ]; then
    open "${PDFM_DIR}"
    exit 0
fi

sudo cp -f "${PDFM_DISP_PATCH}" "${PDFM_DISP_DST}"
open "${PDFM_DIR}"

sleep 2


sudo cp -f "${PDFM_DISP_BCUP}" "${PDFM_DISP_DST}"

file="/etc/hosts"

lines=(
    "127.0.0.1 download.parallels.com"
    "127.0.0.1 update.parallels.com"
    "127.0.0.1 desktop.parallels.com"
    "127.0.0.1 download.parallels.com.cdn.cloudflare.net"
    "127.0.0.1 update.parallels.com.cdn.cloudflare.net"
    "127.0.0.1 desktop.parallels.com.cdn.cloudflare.net"
    "127.0.0.1 www.parallels.cn"
    "127.0.0.1 www.parallels.com"
    "127.0.0.1 www.parallels.de"
    "127.0.0.1 www.parallels.es"
    "127.0.0.1 www.parallels.fr"
    "127.0.0.1 www.parallels.nl"
    "127.0.0.1 www.parallels.pt"
    "127.0.0.1 www.parallels.ru"
    "127.0.0.1 www.parallelskorea.com"
    "127.0.0.1 reportus.parallels.com"
    "127.0.0.1 parallels.cn"
    "127.0.0.1 parallels.com"
    "127.0.0.1 parallels.de"
    "127.0.0.1 parallels.es"
    "127.0.0.1 parallels.fr"
    "127.0.0.1 parallels.nl"
    "127.0.0.1 parallels.pt"
    "127.0.0.1 parallels.ru"
    "127.0.0.1 parallelskorea.com"
    "127.0.0.1 pax-manager.myparallels.com"
    "127.0.0.1 myparallels.com"
    "127.0.0.1 my.parallels.com"
)

if [[ "$(awk 'END {print}' "${file}")" != "" ]]; then
    sudo tee -a "${file}" >/dev/null <<-EOF

EOF
fi
# 循环检查和添加行
for line in "${lines[@]}"; do
    if ! sudo grep -q "^${line}" "${file}"; then
        sudo tee -a "${file}" >/dev/null <<-EOF
${line}
EOF
    fi
done
