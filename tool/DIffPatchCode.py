# QiuChenly 计算数据差值做特征码算法
# 部分网友提供了原始版本 虽然是用的Chatgpt写给我的 但是还是略表谢意
# 提供不定长度的多个十六进制汇编代码段 自动求出差值特征码

data = '''
00 80 7B 28 00 74 4E C7 45 D0 02 00 00 00 C7 45 E4 00 00 00 00
00 80 7B 28 00 74 56 C7 45 C0 02 00 00 00 C7 45 D4 00 00 00 00
00 80 7B 28 00 74 4E C7 45 C8 02 00 00 00 C7 45 DC 00 00 00 00
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