# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
55 48 89 E5 41 57 41 56 41 55 41 54 53 48 83 EC 18 48 8D 3D 70 BA 40 00 E8 13 DC F9 FF 48 8B 40 F8 48 8B 40 40 49 89 E7 48 83 C0 0F 48 83 E0 F0 49 29 C7 4C 89 FC 31 FF E8 2D 6C 2D 00 48 89 45 D0 4C 8B 70 F8 49 8B 46 40 49 89 E4 48 83 C0 0F 48 83 E0 F0 49 29 C4 4C 89 E4 48 89 E1 48 29 C1 48 89 4D C8 48 89 CC 48 8B 3D 12 35 3E 00 E8 79 77 2D 00 48 8B 35 6E 1D 3E 00 48 89 C7 E8 7E 75 2D 00 48 89 C7 E8 9A 75 2D 00 48 89 C3 48 8B 35 84 0C 3E 00 48 89 C7 E8 64 75 2D 00 48 89 C7 E8 80 75 2D 00

55 48 89 E5 41 57 41 56 41 55 41 54 53 48 83 EC 18 31 FF E8 92 08 2D 00 48 89 45 C8 48 8B 40 F8 48 89 45 D0 48 8B 40 40 49 89 E5 48 83 C0 0F 48 83 E0 F0 49 29 C5
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