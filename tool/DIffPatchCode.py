# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
FF C3 02 D1 FA 67 06 A9 F8 5F 07 A9 F6 57 08 A9 F4 4F 09 A9 FD 7B 0A A9 FD 83 02 91 F3 03 00 AA BF 83 1B F8 19 01 00 B0 20 2B 43 F9 62 12 40 F9 3B 46 00 94 A2 23 01 D1 01 00 80 52 2C 3F 00 94 C0 00 00 F0 00 60 3D 91 E2 43 01 91 01 00 80 52 21 3F 00 94 A0 83 5B F8 E2 2B 40 F9 81 00 80 52 20 3F 00 94 F5 03 00 AA A0 83 5B F8 C3 3E 00 94 E0 2B 40 F9 C1 3E 00 94 C0 00 00 F0 00 E0 3D 91 E2 43 01 91 01 00 80 52 13 3F 00 94 60 12 40 F9 FB 4A 00 94 FD 03 1D AA F0 3F 00 94 F6 03 00 AA F7 4A 00 94

FF C3 02 D1 FA 67 06 A9 F8 5F 07 A9 F6 57 08 A9 F4 4F 09 A9 FD 7B 0A A9 FD 83 02 91 F3 03 00 AA BF 83 1B F8 19 01 00 B0 20 ?? 43 F9 62 12 40 F9 ?? 46 00 94 A2 23 01 D1 01 00 80 52 ?? 3F 00 94 C0 00 00 F0 00 E0 3C 91 E2 43 01 91 01 00 80 52 ?? ?? 00 94 A0 83 5B F8 E2 2B 40 F9 81 00 80 52 ?? ?? 00 94 F5 03 00 AA A0 83 5B F8 ?? 3E 00 94 E0 2B 40 F9 ?? 3E 00 94 C0 00 00 F0 00 60 3D 91 E2 43 01 91 01 00 80 52
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