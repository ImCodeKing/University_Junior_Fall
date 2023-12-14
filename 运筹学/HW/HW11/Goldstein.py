import numpy as np
from sympy import symbols, diff, sin
from sympy.plotting import plot



def minGS(f, x, c, alpha, the_x, d):
    # 设置精度
    format_str = '{:.10f}'
    np.set_printoptions(formatter={'float_kind': format_str.format})

    df = diff(f)  # 一阶导数
    f0 = f.subs(the_x, x)
    df0 = df.subs(the_x, x)

    the_t = symbols('t')
    g = f.subs(the_x, x + the_t * d)

    a = 0
    b = 1000

    t = (a + b) / 2  # 初始探测点

    while True:
        # print('a:', a)
        # print('b:', b)
        # print('t:', t)
        # print("---------------------")
        gt = g.subs(the_t, t)  # 探测点的函数值
        g1 = f0 + c * t * df0 * d  # 可接受函数值上限
        g1_plot = f0 + c * the_t * df0 * d

        if gt <= g1:
            g2 = f0 + (1 - c) * t * df0 * d  # 可接受函数值下限
            g2_plot = f0 + (1 - c) * the_t * df0 * d
            if gt >= g2:
                t_final = t
                break
            else:
                a = t  # 更新极值点所在区间的左端点
                if b < np.inf:
                    t = (a + b) / 2  # 更新探测点
                else:
                    if t == 0:
                        t = 0.0001
                    t = alpha * t
        else:
            b = t  # 更新极值点所在区间的右端点
            t = (a + b) / 2

    print('a:', a)
    print('b:', b)
    print('t:', t)
    min_t = g.subs(the_t, t_final)

    g_p = plot((g, (the_t, 0, 3)), line_color='red', show=False, xlabel='t', ylabel='g(t)')
    g1_p = plot((g1_plot, (the_t, 0, 3)), line_color='blue', show=False, xlabel='t', ylabel='g(t)')
    g2_p = plot((g2_plot, (the_t, 0, 3)), line_color='yellow', show=False, xlabel='t', ylabel='g(t)')
    g_p.extend(g1_p)
    g_p.extend(g2_p)
    g_p.show()

    np.set_printoptions(formatter=None)  # 恢复默认格式
    return t_final, min_t


def f(x):
    return sin(x) + 1/2 * x ** 2


if __name__ == '__main__':
    x = symbols('x')
    f = f(x)

    xk = -np.pi
    fx = -np.inf

    while True:
        d = -diff(f).subs(x, xk)
        t, min_t = minGS(f, xk, 0.3, 2, x, d)
        xk = xk + t * d
        fx_new = f.subs(x, xk)

        print('xk:', xk)
        print('fx:', fx_new)
        print("---------------------")

        if abs(fx_new - fx) < 0.0001:
            break
        fx = fx_new
