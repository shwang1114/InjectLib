#!/bin/bash

# 错误处理函数
handle_error() {
     echo ""
     echo "⚠️ 脚本发生错误!,请检查错误,5秒后退出..."
     osascript -e 'display notification "自动处理脚本" with title "⚠️脚本发生错误❌~" sound name "Glass"'
     sleep 5
     exit 1
}

# 定义信号处理函数，用于响应 Ctrl+C
function handle_ctrl_c {
  echo ""
    echo "接收到 Ctrl+C，5秒后退出..."
    if [[ ${upload_pace_pid} ]]; then
      kill ${upload_pace_pid} > /dev/null 2>&1
    fi
    sleep 5
    exit 1
}

# 设置信号处理程序，捕捉 SIGINT 信号（Ctrl+C）
trap handle_ctrl_c SIGINT

# 设置错误处理函数
trap handle_error ERR

# 检查是否为root用户，非root用户可能无法访问某些文件
if [[ $EUID -ne 0 ]]; then
   echo '⚠️ 请使用root权限运行此脚本!'
   echo '⚠️ 若你担心安全问题,请审阅本脚本!'
   exit 1
fi

# 获取脚本文件的绝对路径和目录
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname ${SCRIPT_PATH})

echo "⚙️ 若你安装过Surge,请确保Surge卸载干净,建议用App Cleaner & Uninstaller工具"
echo '⚙️ 若你有配置文件等信息,请备份到其他目录,都确认无误后输入y,开始纯净安装!'
read flag
if [[ $flag != y ]]; then
     exit 1
fi
flag="" # 重置变量

version="5.4.0-2467"

user=$(whoami)
{
  sudo rm -rf "/Applications/Surge" || true
  sudo rm -rf "/tmp/Surge-*.zip" || true
  sudo rm -rf "/Users/${user}/Library/Logs/Surge/" || true
  sudo rm -rf "/Users/${user}/Library/Preferences/com.nssurge.surge-mac.plist" || true
  sudo rm -rf "/Users/${user}/Library/Application Support/com.nssurge.surge-mac" || true
  sudo rm -rf "/Users/${user}/Library/HTTPStorages/com.nssurge.surge-mac" || true

  sudo /bin/launchctl unload /Library/LaunchDaemons/com.nssurge.surge-mac.helper.plist || true
  sudo /usr/bin/killall -u root -9 com.nssurge.surge-mac.helper || true
  sudo /bin/rm "/Library/LaunchDaemons/com.nssurge.surge-mac.helper.plist" || true
  sudo /bin/rm "/Library/PrivilegedHelperTools/com.nssurge.surge-mac.helper" || true
  sudo rm -rf "~/Library/Preferences/com.nssurge.surge-mac.plist" || true
  sudo rm -rf "~/Library/Application\ Support/com.nssurge.surge-mac" || true
} > /dev/null 2>&1

read -r -t 5 -p "⚙️ 是否(y/n)已安装 Surge-${version} ? 5秒后自动安装." flag || true
echo ""
if [[ $flag != n ]]; then
  curl -k -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" -o /tmp/Surge-${version}.zip "https://ghproxy.com/https://github.com/LanYunDev/InjectLib_bak/releases/download/surge/Surge-${version}.zip" || (echo "Surge-${version}安装失败☹️,网络原因,请检查网络." && exit 1)
  unzip -qq -o "/tmp/Surge-${version}.zip" -d "/Applications" || (echo "解压失败☹️,压缩包可能已损坏.请重新下载." && exit 1)
fi
flag="" # 重置变量

if [[ ! -e "../tool/insert_dylib" ]]; then
  echo "⚠️ 确保上级tool目录中存在insert_dylib" && exit 1
fi
if [[ ! -e "../tool/libInjectLib.dylib" ]]; then
  echo "⚠️ 确保上级tool目录中存在libInjectLib.dylib" && exit 1
fi

chmod +x "../tool/insert_dylib"
sudo cp -f "../tool/libInjectLib.dylib" "/Applications/Surge.app/Contents/Frameworks/libInjectLib.dylib" || exit 1
sudo cp -f "/Applications/Surge.app/Contents/Frameworks/Bugsnag.framework/Versions/A/Bugsnag" "/Applications/Surge.app/Contents/Frameworks/Bugsnag.framework/Versions/A/Bugsnag_backup" || exit 1
sudo ../tool/insert_dylib "/Applications/Surge.app/Contents/Frameworks/libInjectLib.dylib" "/Applications/Surge.app/Contents/Frameworks/Bugsnag.framework/Versions/A/Bugsnag_backup" "/Applications/Surge.app/Contents/Frameworks/Bugsnag.framework/Versions/A/Bugsnag" || exit 1

cd "${SCRIPT_DIR}/.."
sudo bash ./tool/surgeAgent.sh

codesign -f -s - --all-architectures --deep /Applications/Surge.app/Contents/Library/LaunchServices/com.nssurge.surge-mac.helper
codesign -f -s - --all-architectures --deep /Applications/Surge.app

echo "✅ 完成"
open /Applications/Surge.app



