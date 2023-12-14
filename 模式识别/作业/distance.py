import numpy as np


def dis(a, b):
    return np.sqrt((a - b)**2)


x = np.array([-7, -2, -0.5, 0.5, 2.5, 3, 3.5]).astype(np.float64)
dis_x = []

for xi in x:
    dis_xi = []
    for xj in x:
        dis_xi.append(dis(xi, xj))
    dis_x.append(dis_xi)

for i in range(1, len(dis_x) + 1):
    print('dis_x_' + str(i), dis_x[i - 1])
