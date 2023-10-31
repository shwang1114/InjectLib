# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
FF C3 00 D1 FD 7B 02 A9 FD 83 00 91 80 C2 00 91 E1 23 00 91 02 00 80 D2 03 00 80 D2 3F 32 05 94 80 C2 40 39 FD 7B 42 A9 FF C3 00 91 C0 03 5F D6 FF 43 01 D1 F6 57 02 A9 F4 4F 03 A9 FD 7B 04 A9 FD 03 01 91 F5 03 00 AA 80 C2 00 91 E1 23 00 91 22 00 80 52 03 00 80 D2 30 32 05 94

FF C3 00 D1 FD 7B 02 A9 FD 83 00 91 80 C2 00 91 E1 23 00 91 02 00 80 D2 03 00 80 D2 B1 31 05 94 80 C2 40 39 FD 7B 42 A9 FF C3 00 91 C0 03 5F D6
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