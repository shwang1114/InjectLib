# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = """
55 48 89 E5 41 57 41 56 41 54 53 49 89 F7 49 89 FC 48 8D 3D 98 01 39 00 E8 43 59 D2 FF 48 8B 40 F8 48 8B 48 40 48 89 C8 E8 43 A2 D2 FF 48 83 C0 0F 48 83 E0 F0 48 29 C4 48 89 E3 48 89 C8 E8 2D A2 D2 FF 48 83 C0 0F 48 83 E0 F0 48 29 C4 49 89 E6 4C 89 F0 4C 89 E7 4C 89 FE 41 FF 57 08 4C 89 F7 48 89 DE 48 8D 15 45 01 39 00 E8 70 1F 00 00 31 FF E8 39 EF FF FF 48 8B 48 F8 48 89 DF BE 01 00 00 00 48 89 C2 FF 51 30 41 89 C6 83 F8 01 74 0F

55 48 89 E5 41 56 41 55 53 50 48 8D 3D EF 65 3A 00 E8 3A D3 D3 FF 48 8B 40 F8 48 8B 48 40 48 89 C8 E8 9A EC D3 FF 48 83 C0 0F 48 83 E0 F0 48 29 C4 48 89 E3 48 89 C8 E8 84 EC D3 FF 48 83 C0 0F 48 83 E0 F0 48 29 C4 49 89 E6 49 8B 45 00
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
