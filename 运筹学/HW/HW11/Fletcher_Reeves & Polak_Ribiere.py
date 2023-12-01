import numpy as np
from sympy import symbols, diff
import matplotlib.pyplot as plt


def grad_f(F, the_x, the_y):
    x = the_x
    y = the_y
    d = np.array([
        diff(F, x),
        diff(F, y)
    ])
    return d


def one_d_search(D, X, the_x, the_y):  # 使用Newton法精确搜索
    x = X[0]
    y = X[1]
    dx = D[0]
    dy = D[1]
    t = 0

    the_t = symbols('t')
    the_dx = symbols('dx')
    the_dy = symbols('dy')
    gt = (1 - (the_x + the_t * the_dx))**2 + 2 * ((the_x + the_t * the_dx)**2 - (the_y + the_t * the_dy))**2
    # gt = (1 - (the_x + the_t * the_dx) - (the_y + the_t * the_dy))**2 + 2 * ((the_y + the_t * the_dy) - (the_x + the_t * the_dx)**2)**2
    # gt = (the_x + the_t * the_dx)**2 + 4 * (the_y + the_t * the_dy)**2 - 2 * (the_x + the_t * the_dx) - 8 * (the_y + the_t * the_dy) + 5
    DIFF = diff(gt, the_t)
    DDIFF = diff(DIFF, the_t)

    def first_deriv(t):
        return DIFF.subs([(the_t, t), (the_x, x), (the_y, y), (the_dx, dx), (the_dy, dy)])


    def sec_deriv(t):
        return DDIFF.subs([(the_t, t), (the_x, x), (the_y, y), (the_dx, dx), (the_dy, dy)])

    while abs(first_deriv(t)) >= 1e-10:
        t = t - first_deriv(t) / sec_deriv(t)
    return t


def FR_conjugate_gradient(F, x0, the_x, the_y, tol=1e-4, max_iter=1000):
    x = x0.copy()
    G = grad_f(F, the_x, the_y)
    g = np.array([G[0].subs([(the_x, x[0]), (the_y, x[1])]), G[1].subs([(the_x, x[0]), (the_y, x[1])])]).astype(np.float64)
    d = -g
    alpha = 0
    it = 0
    FR = [x, [], []]
    while np.linalg.norm(g) > tol and it < max_iter:
        t_star = one_d_search(d, x, the_x, the_y)
        # print('t:', t_star)
        FR[1].append(x[0])
        FR[2].append(x[1])
        x = x + t_star * d
        print("inter", it, ":", "x", x)
        g_new = np.array([G[0].subs([(the_x, x[0]), (the_y, x[1])]), G[1].subs([(the_x, x[0]), (the_y, x[1])])]).astype(np.float64)
        alpha = np.dot(g_new, g_new) / np.dot(g, g)
        d = -g_new + alpha * d
        g = g_new
        it += 1
    FR[0] = x
    FR[1].append(x[0])
    FR[2].append(x[1])
    return x, FR


def PR_conjugate_gradient(F, x0, the_x, the_y, tol=1e-4, max_iter=1000):
    x = x0.copy()
    G = grad_f(F, the_x, the_y)
    g = np.array([G[0].subs([(the_x, x[0]), (the_y, x[1])]), G[1].subs([(the_x, x[0]), (the_y, x[1])])]).astype(np.float64)
    d = -g
    alpha = 0
    it = 0
    PR = [x, [], []]
    while np.linalg.norm(g) > tol and it < max_iter:
        t_star = one_d_search(d, x, the_x, the_y)
        PR[1].append(x[0])
        PR[2].append(x[1])
        x = x + t_star * d
        print("inter", it, ":", "x", x)
        g_new = np.array([G[0].subs([(the_x, x[0]), (the_y, x[1])]), G[1].subs([(the_x, x[0]), (the_y, x[1])])]).astype(np.float64)
        alpha = np.dot(g_new, g_new - g) / np.dot(g, g)
        d = -g_new + alpha * d
        g = g_new
        it += 1
    PR[0] = x
    PR[1].append(x[0])
    PR[2].append(x[1])
    return x, PR


def show(R):
    def f(x, y):
        return (1 - x)**2 + 2 * (x**2 - y)**2
        # return (1 - x - y)**2 + 2 * (y - x**2)**2
        # return x**2 + 4 * y**2 - 2 * x - 8 * y + 5

    # 绘图
    dx = 0.01
    dy = 0.01
    x = np.arange(-0.1, 1.2, dx)
    y = np.arange(-0.1, 1.2, dy)
    X, Y = np.meshgrid(x, y)
    C = plt.contour(X, Y, f(X, Y), levels=10, colors='black')  # 生成等值线图
    plt.contourf(X, Y, f(X, Y), 8)
    plt.clabel(C, inline=1, fontsize=10)
    plt.colorbar()
    # 在图上标注点
    points_x = R[1]
    points_y = R[2]
    plt.scatter(points_x, points_y, c='r', marker='o', s=5)
    plt.scatter(R[0][0], R[0][1], c='r', marker='*', s=150)
    plt.plot(points_x, points_y, color='blue')
    plt.show()

    points_x = []
    points_y = []

    for i in range(len(R[1])):
        points_x.append(i)
        points_y.append(f(R[1][i], R[2][i]))

    # 绘制图形
    plt.plot(points_x, points_y, marker='o', linestyle='-', color='b', label='Function Values')

    # 添加标签和标题
    plt.xlabel('i')
    plt.ylabel('value')

    # 显示图例
    plt.legend()

    # 显示图形
    plt.show()


if __name__ == '__main__':
    x = symbols('x')
    y = symbols('y')
    x0 = np.zeros(2)
    # x0 = np.array([9, 3])
    F = (1 - x)**2 + 2 * (x**2 - y)**2
    # F = (1 - x - y)**2 + 2 * (y - x**2)**2
    # F = x**2 + 4 * y**2 - 2 * x - 8 * y + 5

    best_x_FR, FR = FR_conjugate_gradient(F, x0, x, y)
    optimal_value_FR = F.subs([(x, best_x_FR[0]), (y, best_x_FR[1])])
    print('best_x_FR:', best_x_FR, '\noptimal_value_FR:',  optimal_value_FR)
    show(FR)

    print('-------------------------------------------------')

    best_x_PR, PR = PR_conjugate_gradient(F, x0, x, y)
    optimal_value_PR = F.subs([(x, best_x_PR[0]), (y, best_x_PR[1])])
    print('best_x_PR:', best_x_PR, '\noptimal_value_PR:',  optimal_value_PR)
    show(PR)
