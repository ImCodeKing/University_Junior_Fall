import numpy as np
from sympy import symbols, diff, sin
from sympy.plotting import plot
import matplotlib.pyplot as plt

def minGS(f, XMIN, XMAX, sigma1, sigma2, alpha, the_x, eps=1.0e-6):
    # 目标函数 f
    # 搜索最大值 XMAX
    # 可接受系数 1 sigma1
    # 可接受系数 2 sigma2
    # 增大探索点系数 alpha
    # 精度 eps
    # 目标函数取最小值时的自变量值 x
    # 目标函数的最小值 minf

    # 设置精度
    format_str = '{:.10f}'
    np.set_printoptions(formatter={'float_kind': format_str.format})

    if sigma1 <= 0 or sigma1 >= 1:
        print('sigma1 参数不对！')
        x = np.nan
        minf = np.nan
        return x, minf
    elif sigma2 <= sigma1 or sigma2 >= 1:
        print('sigma2 参数不对！')
        x = np.nan
        minf = np.nan
        return x, minf
    elif alpha <= 1:
        print('alpha 参数不对！')
        x = np.nan
        minf = np.nan
        return x, minf

    df = diff(f)  # 一阶导数
    f0 = f.subs(the_x, XMIN)
    df0 = df.subs(the_x, XMIN)
    a = XMIN
    b = XMAX
    k = 0
    t = (a + b) / 2  # 初始探测点

    while True:
        print('a:', a)
        print('b:', b)
        print('t:', t)
        print("---------------------")
        ft = f.subs(the_x, t)  # 探测点的函数值
        f1 = f0 + sigma1 * t * df0  # 可接受函数值上限
        f1_plot = f0 + sigma1 * the_x * df0

        if ft <= f1:
            f2 = f0 + sigma2 * t * df0  # 可接受函数值下限
            f2_plot = f0 + sigma2 * the_x * df0
            if ft >= f2:
                x = t
                break
            else:
                a = t  # 更新极值点所在区间的左端点
                if b < XMAX:
                    t = (a + b) / 2  # 更新探测点
                else:
                    if t == 0:
                        t = 0.0001
                    t = alpha * t
        else:
            b = t  # 更新极值点所在区间的右端点
            t = (a + b) / 2
        k += 1
    minf = f.subs(the_x, x)

    f_p = plot((f, (the_x, XMIN, XMAX)), line_color='red', show=False)
    f1_p = plot((f1_plot, (the_x, XMIN, XMAX)), line_color='blue', show=False)
    f2_p = plot((f2_plot, (the_x, XMIN, XMAX)), line_color='yellow', show=False)
    f_p.extend(f1_p)
    f_p.extend(f2_p)
    f_p.show()

    np.set_printoptions(formatter=None)  # 恢复默认格式
    return x, minf


def f(x):
    return sin(x) + 1/2 * x ** 2


if __name__ == '__main__':
    x = symbols('x')
    f = f(x)
    XMIN = -np.pi
    XMAX = np.pi
    sigma1 = 0.2
    sigma2 = 0.5
    alpha = 2
    x, minf = minGS(f, XMIN, XMAX, sigma1, sigma2, alpha, x)
