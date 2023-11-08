# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = """
55 48 89 E5 53 50 48 8B 05 BC 00 B9 02 48 8B 00 48 89 45 F0 48 8D 3D 76 D5 3A 02 48 8D 35 AD 53 3A 02 31 DB 31 D2 E8 51 13 72 FF 66 85 C0 74 0D E8 D8 11 FF FF 31 DB 66 85 C0 0F 95 C3 48 8B 05 85 00 B9 02 48 8B 00 48 3B 45 F0 75 0A 0F B7 C3 48 83 C4 08 5B 5D C3 E8 8F 79 0E 02 55 48 89 E5 48 83 EC 10 48 8B 05 5E 00 B9 02 48 8B 00 48 89 45 F8

55 48 89 E5 53 50 48 8B 05 58 F2 B0 02 48 8B 00 48 89 45 F0 48 8D 3D B2 B6 3A 02 48 8D 35 C2 A2 32 02 31 DB 31 D2 E8 C5 6A 72 FF 66 85 C0 74 0D
"""

data1 = []

for i in data.split("\n"):
    if i == "":
        continue
    else:
        data1.append(i)
        if len(data1) > 1:
            res = " ".join(
                [
                    d1 if d1 == d2 else "??"
                    for d1, d2 in zip(data1[0].split(), data1[1].split())
                ]
            )
            data1 = [res]

print(data1[0])
