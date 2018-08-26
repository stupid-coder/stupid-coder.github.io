#!/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt

def generate_spiral_dataset(N, K):
    """
    本函数用来生成螺旋数据集。

    输入：
    n: 生成类别样本数量
    k: 样本的类别种类

    输出：
    螺旋数据集(x,y)，x为样本数据集n*k个，y为对应的样本标签。
    """
    X = np.zeros(((N*K), 2))
    y = np.zeros(N*K, dtype='uint8')
    for j in range(K):
        ix = range(N*j, N*(j+1))
        r = np.linspace(0.0, 1.0, N)  # 极坐标的半径
        t = np.linspace(j*2*np.pi/K, (j+1)*2*np.pi/K, N) + np.random.randn(N)*0.2  # 极坐标的角度
        X[ix, 0] = r*np.sin(t)
        X[ix, 1] = r*np.cos(t)
        y[ix] = j
    return X, y


class LinearClassifier(object):
    def __init__(self, D, K):
        self.W = 0.01 * np.random.randn(D, K)
        self.bias = np.zeros((1, K))

    def score(self, X):
        return np.dot(X, self.W) + self.bias

if __name__ == '__main__':
    X, y = generate_spiral_dataset(100, 3)
    plt.scatter(X[:, 0], X[:, 1], c=y, s=40, cmap=plt.cm.Spectral)
    plt.show()
