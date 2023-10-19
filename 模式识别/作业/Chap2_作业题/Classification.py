#!/usr/bin/env python
# coding: utf-8

import numpy as np
from sklearn import datasets, linear_model
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

# import data
n_samples = 300
cancer = datasets.load_breast_cancer()
X,y = cancer['data'], cancer['target']
X = StandardScaler().fit_transform(X)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.3, random_state=42)

# Example: use LogisticRegression and evaluate the model
logreg = linear_model.LogisticRegression(C=1e3, max_iter=10000)
logreg.fit(X_train, y_train)
y_pred = logreg.predict(X_test)
print('precision: ', accuracy_score(y_test, y_pred))

# TODO: Write your own LDA and evaluate it
class LDA():
    def __init__(self):
        self.S_within = None
        self.S_between = None
        self.total_mean = None
        self.class_lens = []
        self.class_means = []
        self.top_eigenvectors = []

    def fit(self, X, y):
        for c in np.unique(y):
            self.class_lens.append(len(X[y == c]))
        num_class = min(self.class_lens[0], self.class_lens[1])
        new_X = np.ndarray(30)
        for c in np.unique(y):
            random_row_indices = np.random.choice(X[y == c].shape[0], num_class, replace=False)
            for random_row_indice in random_row_indices:
                new_X = np.vstack((new_X, X[y == c][random_row_indice]))
        X = new_X[1:]

        new_y = np.ndarray(0)
        for i in range(2):
            for j in range(num_class):
                new_y = np.concatenate((new_y, i), axis=None)
        y = new_y.astype(int)

        # 计算类别的均值
        for c in np.unique(y):
            self.class_means.append(np.mean(X[y == c], axis=0))

        # 计算总体均值
        self.total_mean = np.mean(X, axis=0)

        # 计算类间散布矩阵
        self.S_between = np.zeros((X.shape[1], X.shape[1]))
        for c in np.unique(y):
            diff = self.class_means[c] - self.total_mean
            self.S_between += np.dot(diff.T, diff)

        # 计算类内散布矩阵
        self.S_within = np.zeros((X.shape[1], X.shape[1]))
        for c in np.unique(y):
            class_samples = X[y == c]
            diff = class_samples - self.class_means[c]
            self.S_within += np.dot(diff.T, diff)

        self.top_eigenvectors = np.dot(np.linalg.inv(self.S_within), (self.class_means[0] - self.class_means[1]))
        # # 计算特征向量和特征值
        # eigenvalues, eigenvectors = np.linalg.eig(
        #     np.dot(np.linalg.inv(self.S_within), self.S_between)
        # )
        #
        # min_eig = np.argmin(eigenvalues)
        # counter = 0
        # for eigenvector in eigenvectors:
        #     if not counter == min_eig:
        #         self.top_eigenvectors.append(eigenvectors)
        #     counter += 1

    def predict(self, X):
        # GoZeros = np.dot(self.top_eigenvectors.T, self.class_means[0])
        # GoOnes = np.dot(self.top_eigenvectors.T, self.class_means[1])
        # test_data_num = X.shape[0]
        # y_predicted = np.zeros((test_data_num))
        # for i in range(test_data_num):
        #     test_dis0 = abs(np.dot(X[i], self.top_eigenvectors) - GoZeros)
        #     test_dis1 = abs(np.dot(X[i], self.top_eigenvectors) - GoOnes)
        #     if test_dis0 >= test_dis1 + 0.001:
        #         #若为第0类，是正例，y预测值取1
        #         y_predicted[i] = 1
        #     else:
        #         #若为第一类，是反例，y预测值取0
        #         y_predicted[i] = 0

        logreg.fit(np.dot(X_train, self.top_eigenvectors).reshape(-1, 1), y_train)
        y_predicted = logreg.predict(np.dot(X, self.top_eigenvectors).reshape(-1, 1))
        return y_predicted

lda = LDA()
lda.fit(X_train, y_train)
y_pred = lda.predict(X_test)
print('precision: ', accuracy_score(y_test, y_pred))