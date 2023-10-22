#!/bin/sh
cd "${0%/*}" || exit 1
read -p "⚙️ 请输入密码(明文)然后回车: " -r passwd
printf "\r\033[1A%s" "" 1>&2
printf "\r\033[K%s" "" 1>&2
echo "${passwd}" | sudo -S echo "⚙️ 当前是 $(sudo -S whoami) 用户"
sudo -S ruby main.rb