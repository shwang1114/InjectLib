# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
FA 67 BB A9 F8 5F 01 A9 F6 57 02 A9 F4 4F 03 A9 FD 7B 04 A9 FD 03 01 91 60 1B 00 90 00 80 15 91 0E 93 FE 97 08 80 5F F8 08 21 40 F9 E9 03 00 91 08 3D 00 91 08 ED 7C 92 34 01 08 CB 9F 02 00 91 00 00 80 D2 83 B6 09 94 F3 03 00 AA 19 80 5F F8 28 23 40 F9 E9 03 00 91 08 3D 00 91 08 ED 7C 92 36 01 08 CB DF 02 00 91 E9 03 00 91 35 01 08 CB BF 02 00 91 88 1A 00 F0 00 B5 40 F9 34 BB 09 94 88 1A 00 90 01 91 41 F9 2B BB 09 94 FD 03 1D AA 3E BB 09 94

FA 67 BB A9 F8 5F 01 A9 F6 57 02 A9 F4 4F 03 A9 FD 7B 04 A9 FD 03 01 91 40 1B 00 D0 00 40 19 91 0E 93 FE 97 08 80 5F F8 08 21 40 F9 E9 03 00 91 08 3D 00 91 08 ED 7C 92 34 01 08 CB 9F 02 00 91 00 00 80 D2 A3 B4 09 94 F3 03 00 AA 19 80 5F F8 28 23 40 F9 E9 03 00 91 08 3D 00 91 08 ED 7C 92 36 01 08 CB DF 02 00 91 E9 03 00 91 35 01 08 CB BF 02 00 91 88 1A 00 B0 00 2D 41 F9 54 B9 09 94 68 1A 00 D0 01 09 42 F9 4B B9 09 94 FD 03 1D AA 5E B9 09 94 F8 03 00 AA 68 1A 00 90
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