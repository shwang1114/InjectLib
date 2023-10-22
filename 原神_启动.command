#!/bin/sh
cd "${0%/*}" || exit 1
read -p "输入管理员密码: " -r passwd
printf "\r\033[1A%s" "" 1>&2
printf "\r\033[K%s" "" 1>&2
echo "${passwd}" | sudo -S echo "当前是 $(sudo whoami) 用户"
sudo ruby main.rb