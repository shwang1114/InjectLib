# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
FD 7B BF A9 FD 03 00 91 C8 2B 00 90 08 D9 40 F9 1F 05 00 B1 A1 00 00 54

FD 7B BF A9 FD 03 00 91 ?? 2B 00 ?? 08 ?? ?? F9 1F 05 00 B1 A1 00 00 54
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