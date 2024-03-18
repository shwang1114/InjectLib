
echo "准备自动计算Helper偏移参数..."

cp ./tool/surge_o.sh ./tool/surge.sh

chmod +x ./tool/SearchParttenCode

./tool/SearchParttenCode surge

sh ./tool/surge.sh