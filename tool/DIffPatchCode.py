# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = """
FF 03 02 D1 F6 57 05 A9 F4 4F 06 A9 FD 7B 07 A9 FD C3 01 91 A8 25 00 90 08 09 41 F9 08 01 40 F9 A8 83 1D F8 BA 1A 0D 94 F4 03 00 AA C8 27 00 D0 08 81 0F 91 E8 17 00 F9 B5 2B 00 90 B3 06 46 F9 20 42 00 94 E2 03 00 AA E0 03 13 AA 03 74 0D 94 FD 03 1D AA B7 1A 0D 94 F3 03 00 AA 48 28 00 F0 08 01 35 91 E8 03 03 A9 B5 06 46 F9 88 2C 00 F0 08 61 1A 91 00 01 40 F9 30 B4 0D 94 E2 03 00 AA E0 03 15 AA D5 73 0D 94 FD 03 1D AA A9 1A 0D 94 F5 03 00 AA E0 23 00 F9

FF 03 02 D1 F6 57 05 A9 F4 4F 06 A9 FD 7B 07 A9 FD C3 01 91 ?? 25 00 ?? 08 09 41 F9 08 01 40 F9 A8 83 1D F8 ?? ?? 0D 94 F4 03 00 AA ?? 27 00 ?? 08 ?? ?? 91 E8 17 00 F9 ?? 2B 00 ?? B3 ?? 45 F9 ?? 42 00 94 E2 03 00 AA E0 03 13 AA ?? ?? 0D 94 FD 03 1D AA ?? ?? 0D 94 F3 03 00 AA ?? 28 00 ?? 08 ?? ?? 91 E8 03 03 A9 B5 ?? 45 F9 ?? 2C 00 ?? 08 ?? ?? 91 00 01 40 F9 ?? ?? 0D 94 E2 03 00 AA E0 03 15 AA ?? ?? 0D 94 FD 03 1D AA ?? ?? 0D 94 F5 03 00 AA
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
