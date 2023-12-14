import numpy as np


if __name__ == '__main__':
    # x0 = [-7, -2, 0.5]
    # x1 = [-0.5, 2.5, 3, 3.5]
    x0 = [3.4, 3.4, 2]
    x1 = [2, 3.4, 3.4, 3.4]

    avg_x0 = np.sum(x0) / len(x0)
    avg_x1 = np.sum(x1) / len(x1)

    s0 = 0
    for x in x0:
        s0 += (x - avg_x0)**2

    s1 = 0
    for x in x1:
        s1 += (x - avg_x1)**2

    J = (avg_x0 - avg_x1)**2 / (s0 + s1)

    print(avg_x0)
    print(avg_x1)
    print(s0)
    print(s1)
    print(J)
