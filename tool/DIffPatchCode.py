# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
FF 43 04 D1 E9 23 0A 6D FC 6F 0B A9 FA 67 0C A9 F8 5F 0D A9 F6 57 0E A9 F4 4F 0F A9 FD 7B 10 A9 FD 03 04 91 80 02 80 52 0A 95 08 94 F3 03 00 AA C8 17 00 F0 00 09 C0 3D 00 00 80 3D 88 2C 8D 52 88 2E AF 72 08 10 00 B9 9B 22 00 D0 60 13 47 F9 3F 95 08 94 E2 03 13 AA 83 02 80 52 24 00 80 52 4A D8 08 94 F4 03 00 AA E0 03 13 AA 33 94 08 94 E0 03 14 AA 7B 95 08 94 F4 03 00 AA B3 A2 08 94 E1 03 00 AA 20 00 80 92 F3 93 08 94 F3 03 00 AA E0 03 14 AA 6D 95 08 94 E0 01 80 52 ED 94 08 94

FF 43 04 D1 E9 23 0A 6D FC 6F 0B A9 FA 67 0C A9 F8 5F 0D A9 F6 57 0E A9 F4 4F 0F A9 FD 7B 10 A9 FD 03 04 91 80 02 80 52 ?? ?? 08 94 F3 03 00 AA ?? 19 00 ?? 00 ?? ?? 3D
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