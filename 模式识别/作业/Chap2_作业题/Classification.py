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
logreg = linear_model.LogisticRegression(C=1e3)
logreg.fit(X_train, y_train)
y_pred = logreg.predict(X_test)
print('precision: ', accuracy_score(y_test, y_pred))

# TODO: Write your own LDA and evaluate it
class LDA():
    def __init__(self):
        pass
    
    def fit(self, X, y):
        pass

    def predict(self, X):
        pass

lda = LDA()
lda.fit(X_train, y_train)
y_pred = lda.predict(X_test)
print('precision: ', accuracy_score(y_test, y_pred))