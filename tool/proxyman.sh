echo "是否全新安装ProxyMan?"
echo "这将删除你的默认配置信息.请先备份配置信息到其他位置."
read -p "(y/n,默认n):" option 
if [ $option = 'y' ];then             #判断用户是否输入，如果未输入则打印error
  # declare user=$(whoami)
  sudo /bin/launchctl unload /Library/LaunchDaemons/com.proxyman.NSProxy.HelperTool.plist
  # sudo /usr/bin/killall -u root -9 com.nssurge.surge-mac.helper
  sudo /bin/rm /Library/LaunchDaemons/com.proxyman.NSProxy.HelperTool.plist
  sudo /bin/rm /Library/PrivilegedHelperTools/com.proxyman.NSProxy.HelperTool
else
  echo "非全新安装,跳过清除。"
fi

echo "大胆！检测到你在用盗版软件，这可能会危害你的设备！甚至被国家安全局和保密处就地正法，请三思！"

helper='/Applications/Proxyman.app/Contents/Library/LaunchServices/com.proxyman.NSProxy.HelperTool'

echo "正在定位你的Mac物理地址...GPS定位中...你跑不掉了! 即将联系开发者发送你的Mac所有信息，你即将被留存侵权数字证据，束手就擒！"

offsets=$(grep -a -b -o "\x3C\x73\x74\x72\x69\x6E\x67\x3E\x61\x6E\x63\x68\x6F\x72\x20\x61\x70\x70\x6C\x65\x20\x67\x65\x6E\x65\x72\x69\x63\x20\x61\x6E\x64\x20\x69\x64\x65\x6E\x74\x69\x66\x69\x65\x72\x20\x22\x63\x6F\x6D\x2E\x70\x72\x6F\x78\x79\x6D\x61\x6E\x2E\x4E\x53\x50\x72\x6F\x78\x79\x22\x20\x61\x6E\x64\x20\x28\x63\x65\x72\x74\x69\x66\x69\x63\x61\x74\x65\x20\x6C\x65\x61\x66\x5B\x66\x69\x65\x6C\x64\x2E\x31\x2E" $helper | cut -d: -f1)
sed 's/\x0A/\n/g' <<< "$offsets" | while read -r s; do
  declare -i start=$s
  if [ "$start" -le 0 ]; then
      echo "起始点在 $start,文件已被修改，跳过注入Helper。"
      break
  fi
  # <string> 3C 73 74 72 69 6E 67 3E
  # <string>anchor apple generic and identifier &quot;com.nssurge.surge-mac&quot; and (certificate leaf[field.1.2.840.113635.100.6.1.9] /* exists */ or certificate 1[field.1.2.840.113635.100.6.2.6] /* exists */ and certificate leaf[field.1.2.840.113635.100.6.1.13] /* exists */ and certificate leaf[subject.OU] = &quot;YCKFLA6N72&quot;)</string>
  # 3C 73 74 72 69 6E 67 3E 61 6E 63 68 6F 72 20 61 70 70 6C 65 20 67 65 6E 65 72 69 63 20 61 6E 64 20 69 64 65 6E 74 69 66 69 65 72 20 26 71 75 6F 74 3B 63 6F 6D 2E 6E 73 73 75 72 67 65 2E 73 75 72 67 65 2D 6D 61 63 26 71 75 6F 74 3B 20 61 6E 64 20 28 63 65 72 74 69 66 69 63 61 74 65 20 6C 65 61 66 5B 66 69 65 6C 64 2E 31 2E 32 2E 38 34 30 2E 31 31 33 36 33 35 2E 31 30 30 2E 36 2E 31 2E 39 5D 20 2F 2A 20 65 78 69 73 74 73 20 2A 2F 20 6F 72 20 63 65 72 74 69 66 69 63 61 74 65 20 31 5B 66 69 65 6C 64 2E 31 2E 32 2E 38 34 30 2E 31 31 33 36 33 35 2E 31 30 30 2E 36 2E 32 2E 36 5D 20 2F 2A 20 65 78 69 73 74 73 20 2A 2F 20 61 6E 64 20 63 65 72 74 69 66 69 63 61 74 65 20 6C 65 61 66 5B 66 69 65 6C 64 2E 31 2E 32 2E 38 34 30 2E 31 31 33 36 33 35 2E 31 30 30 2E 36 2E 31 2E 31 33 5D 20 2F 2A 20 65 78 69 73 74 73 20 2A 2F 20 61 6E 64 20 63 65 72 74 69 66 69 63 61 74 65 20 6C 65 61 66 5B 73 75 62 6A 65 63 74 2E 4F 55 5D 20 3D 20 26 71 75 6F 74 3B 59 43 4B 46 4C 41 36 4E 37 32 26 71 75 6F 74 3B 29 3C 2F 73 74 72 69 6E 67 3E
  echo "69 64 65 6E 74 69 66 69 65 72 20 22 63 6F 6D 2E 70 72 6F 78 79 6D 61 6E 2E 4E 53 50 72 6F 78 79 22 3C 2F 73 74 72 69 6E 67 3E" | xxd -r -p | dd of="$helper" bs=1 seek="$((start + 8))" count=42 conv=notrunc
  start_pos=$((start + 42 + 8))
  fill_byte="09"
  offset1=$((320 - 42 - 8))

  for ((i=0;i<offset1;i++)); do
    pos=$((start_pos + i))
    echo "$fill_byte" | xxd -r -p | dd bs=1 seek=$pos of="$helper" count=1 conv=notrunc
  done
done

echo "定位你的Mac物理地址完成，正在向国家安全局特工发送你的逮捕许可..."

echo "下发逮捕许可完成,即将有人来查你的水表，你别急...海内存知己,天涯若比邻.正在黑进你的Mac,目前已成功骗取到用户root密码."

xattr -c '/Applications/Proxyman.app'
src_info='/Applications/Proxyman.app/Contents/Info.plist'
/usr/libexec/PlistBuddy -c "Set :SMPrivilegedExecutables:com.proxyman.NSProxy.HelperTool \"identifier \\\"com.proxyman.NSProxy.HelperTool\\\"\"" "$src_info"

codesign -f -s - --all-architectures --deep /Applications/Proxyman.app/Contents/Library/LaunchServices/com.proxyman.NSProxy.HelperTool

echo "恭喜你！你的Mac已经被我植入了后门程序,现在即将结束整个进程，特工已经在对面楼中布下天罗地网，请主动自首争取宽大处理(虽然宽大不了几天)，记得下辈子不要用盗版软件🙏。\n"