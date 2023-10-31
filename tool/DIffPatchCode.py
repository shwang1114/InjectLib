# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
FC 6F BE A9 FD 7B 01 A9 FD 43 00 91 FF 83 1B D1 E8 63 11 91 E9 14 00 B0 29 3D 45 F9 EA 1F 00 D0 4A E1 3F 91 CB 0F 00 F0 6B 7D 2D 91 0C 00 80 D2 ED 1F 00 F0 AD 41 15 91 8E 1C 00 B0 CE 41 05 91 8F 1C 00 D0 EF 01 2E 91 30 1C 00 F0 10 22 35 91 91 1C 00 F0 31 22 22 91 E1 15 00 90 21 80 39 91 E2 14 00 B0 42 F8 46 F9 42 00 40 F9 A2 83 1E F8 E0 FF 01 F9 03 00 80 52 E3 DF 0F 39 E8 E7 01 F9 E9 E3 01 F9 EA DF 01 F9 EB DB 01 F9 EC D7 01 F9 ED D3 01 F9 EE CF 01 F9

FC 6F BE A9 FD 7B 01 A9 FD 43 00 91 FF 83 1B D1 E8 63 11 91 ?? 14 00 ?? 29 3D 45 F9
'''

data1 = []

for i in data.split("\n"):
    if i == '':
        continue
    else:
        data1.append(i)
        if len(data1) > 1:
            res = " ".join([
                d1 if d1 == d2 else "??" for d1, d2 in zip(data1[0].split(), data1[1].split())
            ])
            data1 = [res]

print(data1[0])