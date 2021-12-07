
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler
import numpy as np

# 取数据 y归一化 数据分割
df = pd.read_csv('/Users/jin/Desktop/ML_data.csv')
X = df[['time', 'BIS', 'HR','SpO2']]
y = df['Conc.'].values.reshape(-1, 1)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=41)

# 归一化
X_normalizer = StandardScaler() # N(0,1)
X_train = X_normalizer.fit_transform(X_train)
X_test = X_normalizer.transform(X_test)

y_normalizer = StandardScaler()
y_train = y_normalizer.fit_transform(y_train)
y_test = y_normalizer.transform(y_test)

# 构建KNN网络
knn = KNeighborsRegressor(n_neighbors=2) #K=2
knn.fit(X_train, y_train.ravel())

#预测结果
y_pred = knn.predict(X_test)
result = y_pred.reshape((132, 1))
y_pred_inv = y_normalizer.inverse_transform(result)
y_test_inv = y_normalizer.inverse_transform(y_test)

# 可视化
plt.scatter(y_pred_inv, y_test_inv)
plt.xlabel('Prediction')
plt.ylabel('Real value')

diagonal = np.linspace(-10, 200, 10)
plt.plot(diagonal, diagonal, '-r')
plt.xlabel('Predicted conc.')
plt.ylabel('Real conc.')
plt.show()

print(y_pred_inv)

