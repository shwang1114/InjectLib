#!/bin/bash

# 错误处理函数
handle_error() {
     echo ""
     echo "⚠️ 脚本发生错误!,请检查错误,2分钟后退出..."
     osascript -e 'display notification "自动处理脚本" with title "⚠️脚本发生错误❌~" sound name "Glass"'
     sleep 120
     exit 1
}

# 设置错误处理函数
trap handle_error ERR

# 检查是否为root用户，非root用户可能无法访问某些文件
if [[ $EUID -ne 0 ]]; then
   echo '⚠️ 请使用root权限运行此脚本!'
   echo '⚠️ 若你担心安全问题,请审阅本脚本!'
   exit 1
fi

echo "⚙️ 若你安装过Surge,请确保Surge卸载干净,建议用App Cleaner & Uninstaller工具"
echo '⚙️ 若你有配置文件等信息,请备份到其他目录,都确认无误后输入y,开始纯净安装!'
read flag
if [[ $flag != y ]]; then
     exit 1
fi
flag="" # 重置变量

user=$(whoami)
{
  sudo rm -rf "/Applications/Surge" || true
  sudo rm -rf "/tmp/Surge-5.3.1.zip" || true
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

# wget -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36" -P /tmp "https://ghproxy.com/https://github.com/LanYunDev/InjectLib/releases/download/surge/Surge-5.2.4-2363-22d1e0411e23b507a94ca4dbb86b7d3c.zip"
read -r -t 5 -p "⚙️ 是否(y/n)已安装 Surge-5.3.1-2379 ? 5秒后自动安装." flag || true
echo ""
if [[ $flag != n ]]; then
  curl -k -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3" -o /tmp/Surge-5.3.1.zip "https://ghproxy.com/https://github.com/LanYunDev/InjectLib_bak/releases/download/surge/Surge-5.3.1-2379-7ed7da49bb330d3439be7347c9294a08.zip" || (echo "Surge-5.3.1-2379安装失败☹️,网络原因,请检查网络." && exit 1)
  unzip -qq -o "/tmp/Surge-5.3.1.zip" -d "/Applications" || (echo "解压失败☹️,压缩包可能已损坏.请重新下载." && exit 1)
fi
flag="" # 重置变量
# curl -k -A "Mozilla/5.0 Chrome/58.0.3029.110" -o /tmp/insert_dylib "https://ghproxy.com/https://raw.githubusercontent.com/QiuChenlyOpenSource/InjectLib/main/tool/insert_dylib" || (echo "网络原因,请检查网络." && exit 1)
# curl -k -A "Mozilla/5.0 Chrome/58.0.3029.110" -o /tmp/libInjectLib.dylib "https://ghproxy.com/https://raw.githubusercontent.com/QiuChenlyOpenSource/InjectLib/main/tool/libInjectLib.dylib" || (echo "网络原因,请检查网络." && exit 1)
# sudo chmod +x /tmp/insert_dylib
# sudo cp /tmp/libInjectLib.dylib /Applications/Surge.app/Contents/Frameworks/libInjectLib.dylib
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

helper='/Applications/Surge.app/Contents/Library/LaunchServices/com.nssurge.surge-mac.helper'

# 版本2379
echo a5a3: 6A 01 58 C3 |sudo xxd -r - "$helper" #intel
echo 4172c: 20 00 80 D2 C0 03 5F D6 |sudo xxd -r - "$helper" #arm64

offsets=$(grep -a -b -o "\x3C\x73\x74\x72\x69\x6E\x67\x3E\x61\x6E\x63\x68\x6F\x72" $helper | cut -d: -f1)
sed 's/\x0A/\n/g' <<< "$offsets" | while read -r s; do
  declare -i start=$s
  echo "起始点在 $start,文件已被修改，跳过注入Helper。"
  if [ "$start" -le 0 ]; then
      break
  fi
  # <string> 3C 73 74 72 69 6E 67 3E
  # <string>anchor apple generic and identifier &quot;com.nssurge.surge-mac&quot; and (certificate leaf[field.1.2.840.113635.100.6.1.9] /* exists */ or certificate 1[field.1.2.840.113635.100.6.2.6] /* exists */ and certificate leaf[field.1.2.840.113635.100.6.1.13] /* exists */ and certificate leaf[subject.OU] = &quot;YCKFLA6N72&quot;)</string>
  # 3C 73 74 72 69 6E 67 3E 61 6E 63 68 6F 72 20 61 70 70 6C 65 20 67 65 6E 65 72 69 63 20 61 6E 64 20 69 64 65 6E 74 69 66 69 65 72 20 26 71 75 6F 74 3B 63 6F 6D 2E 6E 73 73 75 72 67 65 2E 73 75 72 67 65 2D 6D 61 63 26 71 75 6F 74 3B 20 61 6E 64 20 28 63 65 72 74 69 66 69 63 61 74 65 20 6C 65 61 66 5B 66 69 65 6C 64 2E 31 2E 32 2E 38 34 30 2E 31 31 33 36 33 35 2E 31 30 30 2E 36 2E 31 2E 39 5D 20 2F 2A 20 65 78 69 73 74 73 20 2A 2F 20 6F 72 20 63 65 72 74 69 66 69 63 61 74 65 20 31 5B 66 69 65 6C 64 2E 31 2E 32 2E 38 34 30 2E 31 31 33 36 33 35 2E 31 30 30 2E 36 2E 32 2E 36 5D 20 2F 2A 20 65 78 69 73 74 73 20 2A 2F 20 61 6E 64 20 63 65 72 74 69 66 69 63 61 74 65 20 6C 65 61 66 5B 66 69 65 6C 64 2E 31 2E 32 2E 38 34 30 2E 31 31 33 36 33 35 2E 31 30 30 2E 36 2E 31 2E 31 33 5D 20 2F 2A 20 65 78 69 73 74 73 20 2A 2F 20 61 6E 64 20 63 65 72 74 69 66 69 63 61 74 65 20 6C 65 61 66 5B 73 75 62 6A 65 63 74 2E 4F 55 5D 20 3D 20 26 71 75 6F 74 3B 59 43 4B 46 4C 41 36 4E 37 32 26 71 75 6F 74 3B 29 3C 2F 73 74 72 69 6E 67 3E
  echo "69 64 65 6E 74 69 66 69 65 72 20 26 71 75 6F 74 3B 63 6F 6D 2E 6E 73 73 75 72 67 65 2E 73 75 72 67 65 2D 6D 61 63 26 71 75 6F 74 3B 3C 2F 73 74 72 69 6E 67 3E" | xxd -r -p | dd of="$helper" bs=1 seek="$((start + 8))" count=53 conv=notrunc
  start_pos=$((start + 53 + 8))
  fill_byte="09"

  for ((i=0;i<341-53-8;i++)); do
    pos=$((start_pos + i))
    echo "$fill_byte" | xxd -r -p | dd bs=1 seek=$pos of="$helper" count=1 conv=notrunc
  done
done

xattr -c '/Applications/Surge.app'
src_info='/Applications/Surge.app/Contents/Info.plist'
/usr/libexec/PlistBuddy -c "Set :SMPrivilegedExecutables:com.nssurge.surge-mac.helper \"identifier \\\"com.nssurge.surge-mac.helper\\\"\"" "$src_info"
# /usr/libexec/PlistBuddy -c 'Print SMPrivilegedExecutables' "$src_info"

codesign -f -s - --all-architectures --deep /Applications/Surge.app/Contents/Library/LaunchServices/com.nssurge.surge-mac.helper
codesign -f -s - --all-architectures --deep /Applications/Surge.app

echo "✅ 完成"
open /Applications/Surge.app



