import numpy as np
from sympy import symbols, diff


def grad_f(F, the_x, the_y):
    x = the_x
    y = the_y
    d = np.array([
        diff(F, the_x),
        diff(F, the_y)
    ])
    return d


def one_d_search(D, X, F, the_x, the_y):  # 使用Newton法精确搜索
    x = X[0]
    y = X[1]
    dx = D[0]
    dy = D[1]
    t = [0, 0]
    DIFF = [diff(F, the_x), diff(F, the_y)]
    DDIFF = [diff(DIFF, the_x), diff(DIFF, the_y)]

    def first_deriv(t):
        return [DIFF[0].subs(the_x, t[0]), DIFF[1].subs(the_y, t[1])]


    def sec_deriv(t):
        return [DDIFF[0].subs(the_x, t[0]), DDIFF[1].subs(the_y, t[1])]

    while abs(first_deriv(t)) >= 1e-10:
        t = t - first_deriv(t) / sec_deriv(t)
    return t


def FR_conjugate_gradient(F, x0, the_x, the_y, tol=1e-4, max_iter=1000):
    x = x0.copy()
    G = grad_f(F, the_x, the_y)
    g = [G.subs(the_x, x[0]), G.subs(the_y, x[1])]
    d = -g
    alpha = 0
    it = 0
    while np.linalg.norm(g) > tol and it < max_iter:
        t_star = one_d_search(d, x, F, the_x, the_y)
        x = x + t_star * d
        print("inter", it, ":", "x", x)
        g_new = [G.subs(the_x, x[0]), G.subs(the_y, x[1])]
        alpha = np.dot(g_new, g_new) / np.dot(g, g)
        d = -g_new + alpha * d
        g = g_new
        it += 1
    return x

if __name__ == '__main__':
    x = symbols('x')
    y = symbols('y')
    x0 = np.zeros(2)
    F = (1 - x)**2 + 2 * (x**2 - y)**2
    print(FR_conjugate_gradient(F, x0, x, y))
