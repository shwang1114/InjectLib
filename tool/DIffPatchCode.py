# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = """
FF 03 02 D1 F6 57 05 A9 F4 4F 06 A9 FD 7B 07 A9 FD C3 01 91 68 25 00 D0 08 09 41 F9 08 01 40 F9 A8 83 1D F8 39 09 0D 94 F4 03 00 AA A8 27 00 90 08 41 0A 91 E8 17 00 F9 75 2B 00 D0 B3 52 45 F9 7B 42 00 94 E2 03 00 AA E0 03 13 AA 64 62 0D 94 FD 03 1D AA 36 09 0D 94 F3 03 00 AA 28 28 00 B0 08 41 23 91 E8 03 03 A9 B5 52 45 F9 68 2C 00 B0 08 01 15 91 00 01 40 F9 79 A2 0D 94 E2 03 00 AA E0 03 15 AA 36 62 0D 94 FD 03 1D AA 28 09 0D 94 F5 03 00 AA E0 23 00 F9 68 2B 00 D0 00 29 45 F9 E2 E3 00 91

FF 03 02 D1 F6 57 05 A9 F4 4F 06 A9 FD 7B 07 A9 FD C3 01 91 68 25 00 F0 08 09 41 F9 08 01 40 F9 A8 83 1D F8 D7 0B 0D 94 F4 03 00 AA A8 27 00 B0 08 81 0D 91 E8 17 00 F9 75 2B 00 F0 B3 7E 45 F9 7B 42 00 94 E2 03 00 AA E0 03 13 AA 0A 65 0D 94 FD 03 1D AA D4 0B 0D 94 F3 03 00 AA 28 28 00 D0 08 81 2A 91 E8 03 03 A9 B5 7E 45 F9 68 2C 00 D0 08 81 16 91 00 01 40 F9 1F A5 0D 94 E2 03 00 AA E0 03 15 AA DC 64 0D 94 FD 03 1D AA C6 0B 0D 94 F5 03 00 AA
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
