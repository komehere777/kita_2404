## 시각화

- 서설
매일 매일 시각화, 데이터 적합 연습, 웹끝나고 바로 머신러닝 들어감, 마지막에 했던 실습자료 계속 사용, 하루에 1~2시간 연습 필요, 원하는 데이터로 연습, 머신러닝전까지 제대로된 자료로 만들것, 3개 인사이트 담을 수 있게 정리, 과제 정의, 적합한 분석용 데이터 만들것, 한달후까지 업로드, 데이터 핸들링 역량을 키워야 함

- 파이차트

```py
plt.pie(sizes, explode=explode, labels=labels, autopct='%1.1f%%',shadow=True, startangle=90)
```

- 나이 범주화(cut, bins), value_counts(index, values)

```py
df['age_group'] = pd.cut(df['age'], bins=[0,10,20, 40,60,np.inf], labels=['teen','young','adult','mature','elder'])
tdf = df['age_group'].value_counts()
labels = tdf.index
sizes = tdf.values
```

- 빈도표
pd.crosstab(), pivot_table(), sns.countplot()-시각화

- 바이올린 플롯: 커널밀도 추정결과 반영, 분산확인가능, 내부는 박스 플롯
sns.violinplot()

- joinplot은 산점도, 추세선, 히스토그램, 오차의 범위 다 나옴,변수간의 관계와 각 변수의 분포를 동시에 탐색할 수 있게 해준다.
sns.joinplot(kind='reg') 회귀까지 반영

- sns.lmplot, sns.regplot
lmplot - 카테고리별 분할, 복잡
regplot - 단순 회귀선 그림

