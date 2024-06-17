# 시각화

##  판다스 내장 그래프 도구

Pandas는 Matplotlib 라이브러리의 기능을 일부 내장하고 있어서 별도로 임포트하지 않고 간단히 그래프를 그릴 수 있습니다. 다양한 종류의 그래프를 그릴 수 있으며, 각 그래프는 데이터를 시각화하는 데 유용한 정보를 제공합니다.
- 선 그래프 (Line Plot) :
가장 기본적인 선 그래프를 그리며, 시간에 따른 데이터 변화를 시각화하는 데 유용합니다.
- 막대 그래프 (Bar Plot) :
카테고리형 데이터를 시각화하는 데 유용합니다.
- 수평 막대 그래프 (Horizontal Bar Plot) :
카테고리형 데이터를 수평으로 시각화하며, 누적 옵션과 투명도 적용이 가능합니다.
- 히스토그램 (Histogram) :
데이터의 분포를 시각화하는 데 유용합니다.
- 산점도 (Scatter Plot) :
두 변수 간의 관계를 시각화하며, 상관관계를 확인할 수 있습니다.
- 박스 플롯 (Box Plot) :
데이터의 분포와 분산 정도를 시각화하며, 이상치(outliers)를 확인하는 데 유용합니다.
- 면적 그래프 (Area Plot)
면적 그래프는 시간에 따른 데이터의 변화를 누적하여 시각화하는 데 유용합니다. 여러 시계열 데이터를 하나의 플롯에 그릴 수 있으며, 누적된 값의 변화를 시각적으로 쉽게 파악할 수 있습니다.
- 파이 차트 (Pie Chart) :
카테고리형 데이터의 비율을 시각화하는 데 유용합니다.
- 커널 밀도 추정 그래프 (KDE Plot) :
데이터의 확률 밀도 함수를 시각화하며, 데이터의 분포를 부드럽게 나타냅니다.

```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

np.random.seed(0)
df = pd.DataFrame({
    'A': np.random.randn(1000),
    'B': np.random.randn(1000),
    'C': np.random.rand(1000) * 100,
    'D': np.random.randint(1, 200,1000)  
})

fig, axes = plt.subplots(3, 3, figsize=(10, 6))
#디폴트가 라인 그래프
df['A'].plot(ax=axes[0, 0], title='Line Plot')

df['B'].plot(ax=axes[0, 1], kind='hist', title='Histogram')

df[['A', 'B']].plot(ax=axes[0, 2], kind='box', title='Box Plot')

df.plot(kind='scatter', x='A', y='B', ax=axes[1, 0], title='Scatter Plot')
#면적 그래프(stacket=False 두시리즈가 겹치지 않게 하는 옵션)
df[['A','B']].cumsum().plot(kind='area', ax=axes[1, 1], title='Area Plot', stacked=False)
#막대그래프 상위10개
df['D'].head(10).plot(kind='bar', ax=axes[1,2], title='Bar' )
#파이 그래프
df['D'].value_counts().head(10).plot(kind='pie', ax=axes[2,0], title='Pie Chart')
#커널 밀도 추정 그래프
df['A'].plot(kind='kde', ax=axes[2, 1], title='KDE Plot')
#수평 막대 그래프
df['D'].value_counts().head(10).plot(kind='barh', ax=axes[2,2], title='horizon bar chart') 
#레이아웃 조정
plt.tight_layout()
plt.show()
```

- 평균10, 표준편차2 샘플 10000

```python
from scipy import stats
sample1 = stats.norm.rvs(loc=10, scale=2, size=10000)
```

- matplotlib
histogram : plt.hist(x, bins= )
line plot : plt.plot(x,y)
plt.bar(x,y, width= , color='')
scatter plot : plt.scatter(x, y):

- seaborn
sns.distplot(data, bins=, color=, kde=), histplot, displot으로 변경
sns.boxplot(x, y, data, color)
sns.violinplot(x, y, data, color)
sns.barplot(x, y, data, color)
sns.jointplot(x, y, data, color)
sns.pairplot(data, hue, palette)
sns.lmplot(x,y,data,color)
sns.regplot(x,y,data,fig_reg=False)
sns.heatmap(data,)

- 축에 대한 객체 만들고 .add_subplot .그래프종류

```py
fig = plt.figure(figsize=(10,6))
ax1 = fig.add_subplot(2,2,1)
ax2 = fig.add_subplot(2,2,2)
ax3 = fig.add_subplot(2,2,3)
ax4 = fig.add_subplot(2,2,4)

x = np.arange(1,21,2)
y = np.array([3,4,6,13,30,21,22,29,33,32])
ax1.hist(np.random.randn(100), bins=20, color='k', alpha=0.3)
ax2.hist(np.random.rand(1000), bins=20, color='k', alpha=0.5)
ax3.plot(np.random.randn(50).cumsum(),'k--')
ax4.scatter(np.arange(30), np.arange(30)+3*np.random.randn(30))
```

