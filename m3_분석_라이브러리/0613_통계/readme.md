# 0613

## 서설

- 오후에는 구매 데이터가지고 통계 실습
- 내일 오전 판다스, 넘파이, 통계 시험
- 남은게 시각화
- 다음주부터 크롤링, 실습과제
- 끝나고 웹(플라스크)
- 플라스크는 상용화로는 안씀
- 우리는 솔루션 데모용이 필요
- 웹 원리를 알기 좋음
- 플라스크는 하나하나 연결해야해서 연습에 도움이 됨
- 플라스크는 2주
- 끝나면 오전수업, 오후 웹프로젝트 진행
- 주제는 팀별 , 한달동안 프로젝트 진행
- 끝나면 딥러닝, 프로젝트 2개 남은 3개월동안 진행

## 통계

- 밀도그래프 그리기
sns.kdeplot(house, fill=True)
- 도수 분포표 생성

```python
(unique, counts) = np.unique(score, return_counts=True)
frequncy_table = np.asarray((unique, counts)).T
```

- 추세선(오차가 최소화하는 선을 그리면 추세선이 됨)

```python
m, b = np.polyfit(rnd, annual, 1)
plt.plot(rnd, m * rnd + b, 'r')
```

- 평균값 > 중앙값 : 오른쪽으로 치우친 이상치가 존재
- 평균값 < 중앙값 : 왼쪽으로 치우친 이상치가 존재
- 평균과 중앙값차이로 분포가 예측됨
- 긴 꼬리 데이터 생성

```python
- np.random.beta(a=2, b=10, size=1000)  #오른쪽 
- np.random.beta(a=10, b=2, size=1000)   # 왼쪽
```

- 상관계수 계산: np.corrcoef(x,y) =>상관행렬 형태로 리턴
- np.random.normal(평균, 표준편차, 갯수) 표준정규분포랜덤
- 순서를 고려한 모든 가능한 조합 생성

```python
from itertools import product
list(product(dice, repeat=2))
```

- 누적분포함수(CDF):확률변수가 특정 값 이하일 확률, 연속형
  
```python
import scipy.stats as stats
probability = stats.norm.cdf(value, mean, std_dev)
```

- 이산형 확률변수의 경우, 확률질량함수(PMF: Probability Mass Function)를 사용

```python
from scipy.stats import binom
probability = binom.pmf(k, n, p)
```

- 기대값, 분산

```python
expected_value = sum(value * probability for value, probability in zip(values, probabilities))
variance = sum((value - expected_value)**2 * probability for value, probability in zip(values, probabilities))
```
