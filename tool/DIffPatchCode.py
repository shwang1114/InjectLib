# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
55 48 89 E5 41 57 41 56 41 55 41 54 53 48 83 EC 58 48 89 FB 4C 8D 7D C0 49 C7 07 00 00 00 00 48 8B 3D 5D F8 01 00 48 8B 53 20 48 8B 35 4A F1 01 00 4C 8B 35 DB 98 01 00 41 FF D6 48 89 C7 31 F6 4C 89 FA E8 4B 2B 01 00 48 8D 3D 94 AB 01 00 4C 8D 65 C8 31 F6 4C 89 E2 E8 2A 2B 01 00 49 8B 3F 49 8B 14 24 BE 04 00 00 00 E8 1F 2B 01 00 89 45 BC 49 8B 3F E8 60 2A 01 00 49 8B 3C 24 E8 57 2A 01 00 48 8D 3D 7A AB 01 00 31 F6 4C 89 E2 E8 F4 2A 01 00 48 89 5D B0 48 8B 7B 20 48 8B 1D F9 F5 01 00 48 89 DE

55 48 89 E5 41 57 41 56 41 55 41 54 53 48 83 EC 58 48 89 FB 4C 8D 7D C0 49 C7 07 00 00 00 00 48 8B 3D ?? F7 01 00 48 8B 53 20 48 8B 35 ?? F0 01 00 4C 8B 35 ?? ?? 01 00 41 FF D6 48 89 C7 31 F6 4C 89 FA E8 ?? 2A 01 00 48 8D 3D ?? ?? 01 00 4C 8D 65 C8 31 F6 4C 89 E2 E8 ?? 2A 01 00 49 8B 3F 49 8B 14 24 BE 04 00 00 00 E8 ?? 2A 01 00 89 45 BC 49 8B 3F E8 ?? ?? 01 00 49 8B 3C 24 E8 ?? 29 01 00 48 8D 3D ?? ?? 01 00 31 F6 4C 89 E2 E8 ?? 2A 01 00
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