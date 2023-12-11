import pandas as pd
import matplotlib.pyplot as plt

# 读取CSV文件
# file_path = 'D:/大学/University_Junior_Fall/智能传感与检测技术/实验/实验E/ECPPG_2023-10-26_13-33-06.csv'
file_path = 'D:/大学/University_Junior_Fall/智能传感与检测技术/实验/实验E/ECPPG_2023-10-26 lzy.csv'
data = pd.read_csv(file_path)

# 指定横轴和纵轴的列名
x_column = ' Sample Count'
y_column = ' Filtered ECG (mV)'

# 截取数据集的一部分
# start_index = (len(data) + 400) // 2
# end_index = start_index + 500

start_index = (len(data) + 3400) // 2
end_index = start_index + 500
subset_df = data.iloc[start_index:end_index]

# subset_df[x_column] = subset_df[x_column] - 58000

subset_df[x_column] = subset_df[x_column] - 68980
print(start_index)
print(end_index)

# 绘图
plt.plot(subset_df[x_column], subset_df[y_column])
plt.xlabel(x_column)
plt.ylabel(y_column)
plt.title('ECG-LZY')  # 请替换为您的图表标题
plt.grid(True)
plt.xticks(range(int(subset_df[x_column].min()) - 23, int(subset_df[x_column].max()) - 21, 50))
plt.show()

