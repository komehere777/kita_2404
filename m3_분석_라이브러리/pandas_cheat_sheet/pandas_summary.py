frame ,target_variable,dup_ts,ts,long_df,date_list,sns,scaled_df,np,plt,pd,merge_df,cusdf4,customers,grades,tdf, subjects, purchases,df4,st1,st2,arr,grouped_two, sr ,obj ,s ,df1,df5,s2,file_data,df1,df2,df22,df_1,df_2,df_3,df_4,df,columns=0
#인덱스 및 값
idx = sr.index
val = sr.values

#리스트를 시리즈로 변환 - 인덱스는 0부터 숫자로 자동 입력
list_data = ['2019-08-02', 3.14, 'ABC', 100, True]
sr = pd.Series(list_data)

#null항목 찾기
null_mask = obj.isnull()

#null항목 아닌거 찾기
not_null_mask = obj.notnull()

#null항목 원하는 숫자로 채우기
filled_series = obj.fillna(0)

#null항목 다 더하기
obj.isnull().sum()
obj.isna().sum()

#na항목 다 없애기
obj.dropna()

#index 정렬
s_sorted = s.sort_index()
df1_s = df1.sort_index(ascending=False)

#value 기준 정렬
df1_c = df1.sort_values(by='c', ascending=False)

#컬럼은 리스트로 인덱싱 가능
df5[['Name','City']]  

#Series -> dataframe 시리즈를 데이터프레임으로 변경
df_from_series = s2.to_frame(name='Value')#컬럼 이름이 Value

#csv 파일 생성
file_data.to_csv('file_data.csv', index=None)

#csv 파일 읽기
pd.read_csv('file_data.csv')

#Q.df1과 df2를 행방향과 열방향으로 병합하여 출력하세요.
df_3 = pd.concat([df_1, df_2], axis=1)  #행방향
df_4 = pd.concat([df_1, df_2])          #열방향

#인덱스 초기화
df3 = df2.reset_index()
df22 = df3.set_index('index')       #초기화후 인덱스이름 설정

#인덱스 네임 제거
df22.index.name = None             

#Q.df에 r5,r6 2개의 행을 추가하고 값은 0을 적용하여 출력하세요
df.loc['r5'] = 0
df.loc['r6'] = 0

#인덱스 재설정
new_index = ['r0','r1','r2','r3','r4','r5','r6','r7','r8']
df5 = df.reindex(new_index, fill_value=0)

#전치
df1_t = df1.transpose()
df1_t = df1.T

#reindex를 사용하여 특정 날짜 범위로 인덱스를 재설정하여 출력
new_dates = pd.date_range('2024-01-01', periods=6, freq='D')
df_reindexed = df5.reindex(new_dates, fill_value=10)

#Q. 데이터프레임 df6를 전치하고, 전치된 데이터프레임을 정리하여 연도별 판매량 데이터를 제품별로 나열하여 출력하세요.

data = {
    'Year': ['2020', '2021', '2022'],
    'Product_A': [500, 600, 700],
    'Product_B': [400, 500, 600],
    'Product_C': [300, 400, 500]
}
df6 = pd.DataFrame(data)
print(df6)
df6 = df6.set_index('Year')
df6.index.name = None
print(df6)
df6_t = df6.T
df6_t.reset_index(inplace=True)
df6_t.rename(columns={'index':'Product'},inplace=True)

#연산메소드 이용 및 NaN 값을 0으로 대체 후 사칙연산을 수행한 후 결과를 출력
ad = df1.add(df2, fill_value=0)
su = df1.sub(df2, fill_value=0)
mu = df1.mul(df2, fill_value=0)
di = df1.div(df2, fill_value=0)

#주어진 DataFrame의 N열에서 Series s값을 빼고 결과를 새로운 열 O에 저장 후 출력하세요.
df = pd.DataFrame({
    "M": [15, 25, 35, 45, 55],
    "N": [100, 200, 300, 400, 500]
})
s = pd.Series([5, 10, 15, 20, 25])
df['O'] = df['N'] - s

#주어진 DataFrame의 여러 열에 대해 각기 다른 Series를 더하고, 결과를 새로운 DataFrame으로 반환한 후 각 행의 합계를 계산하여 새로운 열에 추가하여 출력하세요
df = pd.DataFrame({
    "A": [1, 2, 3, 4, 5],
    "B": [10, 20, 30, 40, 50],
    "C": [100, 200, 300, 400, 500]
})
s1 = pd.Series([5, 5, 5, 5, 5])
s2 = pd.Series([10, 10, 10, 10, 10])
s3 = pd.Series([15, 15, 15, 15, 15])
df_new = df.copy()
df_new['A'] = df['A'] + s1
df_new['B'] = df['B'] + s2
df_new['C'] = df['C'] + s3
df_new['Sum'] = df_new.sum(axis=1)
print(df_new)

#df에서 세 열의 값을 더하여 새로운 컬럼을 생성한 후 출력하세요.
df = pd.DataFrame({
    "A": [10, 20, 30, 40, 50],
    "B": [1, 2, 3, 4, 5],
    "C": [5, 10, 15, 20, 25],
    "D": [3, 6, 9, 12, 15],
    "E": [2, 4, 6, 8, 10]
})
df['ABC_sum'] = df['A'] + df['B'] + df['C']
print(df)

#df에서 세 열의 값을 평균하여 새로운 컬럼을 생성 후 출력하세요.
df = pd.DataFrame({
    "A": [100, 200, 300, 400, 500],
    "B": [10, 20, 30, 40, 50],
    "C": [1, 2, 3, 4, 5],
    "D": [7, 8, 9, 10, 11],
    "E": [3, 6, 9, 12, 15]
})
df['ABC_mean'] = df[['A','B','C']].mean(axis=1)
print(df)

#df에서 두 개의 열을 더한 값이 다른 한 개의 열보다 큰 경우에는 1, 작은 경우에는 0으로 값을 정하는 새로운 열을 생성한 후 출력하세요.
df = pd.DataFrame({
    "A": [2, 3, 4, 5, 6],
    "B": [1, 2, 3, 4, 5],
    "C": [3, 4, 5, 6, 7],
    "D": [8, 9, 10, 11, 12],
    "E": [10, 20, 30, 40, 50]
})
df['AB_greater_than_c'] = (df['A'] + df['B'] > df['C']).astype(int)   #두열의 합이 다른 한열보다 큰 경우1, 작거나 같은 경우 0으로 설정하는 새로운 컬럼 생성
print(df)

#주어진 DataFrame에서 'Category'별로 그룹화하여 각 그룹의 'Value' 열의 평균을 계산하세요.
df.groupby('Category')['Value'].mean().reset_index()

#주어진 DataFrame에서 'Category'별로 그룹화하여 각 그룹의 'Value' 열의 누적합을 계산하세요.
df.groupby('Category')['Value'].cumsum()
df.groupby('Category')['Value'].transform('cumsum')

#주어진 DataFrame에서 'Category'별로 그룹화하여 각 그룹의 'Value' 열의 합계, 평균, 최대값, 최소값을 계산하세요
df.groupby('Category')['Value'].agg(['sum','mean','max','min'])

#주어진 df에서 category별로 가장 자주 등장하는 value를 찾아서 새로운 열의 값으로 적용한 후 출력하세요.
df.groupby(by=['Category'])[['Value']].agg(pd.Series.mode)

def most_frequent(x):
    return x.mode().iloc[0] #최빈값이 여러개일 경우 첫번째 값 선택
df['Most_Frequent'] = df.groupby('Category')['Value'].transform(most_frequent)

#누적을 구하는건 expanding
data = [1,2,3,4,5]
s = pd.Series(data)
cum_sum = s.expanding().sum()
cum_mean = s.expanding().mean()

#주어진 데이터프레임에서 각 그룹별로 누적 평균을 계산하여 새로운 열로 추가한 후 출력하세요. 단 누적 평균은 그룹 내에서 각 요소까지의 평균을 계산한 것임
grouped = df.groupby(['Category'])
df['expanding_mean'] = grouped.transform(lambda x: x.expanding().mean())

#주어진 Series의 각 값에 대해 2배로 변환하는 함수를 적용하여 값을 변환하세요.
s_mapped = s.map(lambda x: x * 2)
s_mapped = s.apply(lambda x: x * 2) #간단한 시리즈는 맵으로 apply는 느림

#주어진 DataFrame의 특정 열에 대해 map을 사용하여 등급을 부여하는 함수를 적용하여 변환을 수행하세요.
def allocated_rank(x):
    if x >= 95:
        return 'A'
    elif x >= 90:
        return 'B'
    elif x >= 85:
        return 'C'
    elif x >= 80:
        return 'D'
    else:
        return 'E'
    
df['allocated_rank'] = df['Score'].map(allocated_rank)

#주어진 DataFrame의 특정 열에 대해 각 요소에 제곱하는 함수를 적용하여 새로운 열을 생성하세요.
df['Numbers'].apply(lambda x : x * x)
df['Numbers'].map(lambda x : x * x)

#apply는 DataFrame의 행이나 열 단위로 함수를 적용할 수 있지만, map은 Series의 각 요소에만 함수를 적용

#Series의 각 요소를 변환하는 간단한 작업에는 map이 적합하고, 더 복잡한 변환이 필요한 경우나 DataFrame 전체를 다룰 때는 apply가 유용

#행(row)단위로 함수적용(각 행의 합을 계산)
df1['Row_Sum'] = df1.apply(lambda row: row.sum(), axis=1)

#열(column)단위 함수적용(각 열의 합을 계산)
df2.loc['Column_Sum'] = df2.apply(lambda row: row.sum(), axis=0)

#'A'열의 각 요소를 제곱
df['A_Squared'] = df['A'].map(lambda x: x **2)  #시리즈에는 맵

#주어진 DataFrame의 여러 열에 대해 각 열의 값을 합하는 함수를 적용하여 새로운 열을 생성한 후 출력하세요.
df['A_plus_B'] = df.apply(lambda row:row['A'] + row['B'], axis=1)

#주어진 DataFrame의 각 요소에 대해 10보다 크면 2배, 그렇지 않으면 원래의 수를 반영하는 함수를 적용하여 값을 변환하세요.
df['Transformed'] = df['Values'].apply(lambda x: x * 2 if x > 10 else x)

#주어진 DataFrame에서 특정 열을 그룹화한 후 각 그룹에 대해 그룹별로 평균 값을 계산하는 함수를 적용하여 새로운 열을 생성하여 출력하세요.
df['Group_mean'] = df.groupby('Category')['Value'].transform('mean')

#주어진 DataFrame의 특정 열에 대해 제곱과 제곱근을 계산하는 함수들을 동시에 적용하여 새로운 열을 생성한 후 출력하세요.
df['Numbers'].apply(lambda x: x**2)
df['Numbers'].apply(lambda x: x**0.5)

def pow(x):
  return x**2

def sqrt(x):
  return np.sqrt(x)

res = df.Numbers.agg([pow, sqrt])
df = pd.concat([df,res], axis=1)

def SQ_SQRT(x):
  return round(x*x,2), round(x**0.5,2)

# Option1
df[['SQ', 'SQRT']] =df['Numbers'].transform(lambda x: pd.Series(SQ_SQRT(x)))  ## Apply나 Transform이나 동일

# Option2
df[['SQ', 'SQRT']] = df['Numbers'].apply(lambda x: (round(x*x,2), round(x**0.5,2))).apply(pd.Series)

#주어진 DataFrame의 각 요소에 대해 제곱하는 함수를 적용하여 값을 변환하세요.
pow_df= df.apply(lambda x: x*x)
pow_df= df.transform(lambda x: x*x)

#주어진 데이터프레임에서 각 그룹별로 Value 열을 표준화하여 새로운 열로 추가하여 출력하세요.(apply, transform 두가지 적용)
def standardize(x):
    return (x - x.mean()) / x.std()

st_series = df.groupby('Category')['Value'].apply(standardize)

#각 열의 평균값으로 대체
for column in columns:
    df[column].fillna(df[column].mean(),inplace=True)

#null값을 각 열의 평균값으로 채우기
df_filled_mean = df.apply(lambda x: x.fillna(x.mean()), axis=0)

#null값을 각 열의 중간값으로 채우기
df_filled_median = df.apply(lambda x: x.fillna(x.median()), axis=0)

#앞 또는 뒤의 값으로 채우기
df_ffill = df.fillna(method='ffill')
df_bfill = df.fillna(method='bfill')

#  replace 메서드를 사용하여 null 값을 0으로 대체, 0이 실수로 들어가는거는 해당 컬럼이 실수이기때문
df_replace_zero = df.replace(np.nan, 0)

#  replace 메서드를 사용하여 null 값을 특정 값으로 대체
df_replace_value = df.replace(np.nan, -1)

#null값이 포함된 행 을 삭제
df_dropped_rows = df.dropna()

#null값이 포함된 열 을 삭제
df_dropped_columns = df.dropna(axis=1)

#df1 데이터 프레임에서 숫자형 데이터 타입을 가진 열들만 선택
for column in df2.select_dtypes(include=[np.number]).columns:
    df1[column].fillna(df2[column].mean(), inplace=True)

#English 점수를 기준으로 내림차순 정렬
df2.sort_values('English',ascending=False)

#학생별 평균구하는 방법 average_scores 타입은 series
average_scores = df3.groupby("Name")["Score"].mean()

#배열로 변경
average_scores.to_numpy()
#딕셔너리로 변경
average_scores.to_dict()
#리스트로 변경
average_scores.tolist()

#특정열 데이터 타입 변환
df4['A'] = df4['A'].astype(int)
df4['B'] = df4['B'].astype(float)
df4['C'] = pd.to_datetime(df4['C']) #datetime형식 변경

#pandas_2_연산

#Q.null값을 0으로 변경하여 결과를 출력하세요
ad = st1.add(st2, fill_value=0)
su = st1.sub(st2, fill_value=0)
mu = st1.mul(st2, fill_value=0)
di = st1.div(st2, fill_value=0)

#계산인자를 뒤집어 계산
df1.rdiv(1) #해당 숫자가 분자로 들어가서 계산
df1.rsub(1)     #안에 숫자 - 항목
df1.radd(1)
df1.rmul(10)

#broadcasting
arr - arr[0]

#그룹 객체를 iteration으로 출력: head()메소드로 첫 5행만을 출력
for key, group in grouped:
    print("* key : ", key)
    print("* number : ", len(group))
    print(group.head())

#연산 메소드 적용
average = grouped.mean()
stat = grouped.max()

#개별 그룹 선택하기
group3 = grouped.get_group('Third')
group3f = grouped_two.get_group(('Third','female')) #튜플로 여러개 그룹 가능

#각 그룹에 대한 모든 열의 표준편차를 집계하여 데이터프레임으로 반환
std_all = grouped.std()  #표준편차- 평균에서 얼마나 벗어나 있나

#그룹 객체에 agg()메소드 적용 - 사용자 정의 함수를 인수로 전달
def min_max(x):     #최대값 - 최소값
    return x.max() - x.min()

agg_minmax = grouped.agg(min_max)

# 모든열에 여러 함수를 매핑 : group객체.agg([함수1,함수2,함수3,…])
agg_all = grouped.agg(['min','max', 'mean'])  
agg_all = grouped.agg(['min','max', min_max, 'mean']) #사용자 정의 함수 따옴표 필요없음

#각 열마다다른 함수를 적용하여 집계
agg_sep = grouped.agg({'fare':['min','max'],'age':'mean'})

#데이터 개수가 200개 이상인 그룹만을 필터링하여 데이터 프레임으로 반환
grouped_filter = grouped.filter(lambda x: len(x) >= 200) #x는 그룹 , 뽑힌 그룹내 데이터 다 포함

#value_counts()
grouped_filter.value_counts('class')

#각 열에 대해 최대값을 구하는 함수 , 열을 판단하려면 행으로 봐야함 axis=0
df_applied_col = df.apply(lambda x: x.max(),axis=0)

#각 행에 대해 합계를 구하는 함수, 행을 판단하기 위해 열로 봐야함 axis=1
df_applied_row = df.apply(lambda x: x.sum(), axis=1)

#applymap함수는 데이터프레임에만 적용되며 각 요소에 함수를 적용
df_applymapped = df.applymap(lambda x: x + 2)

#map함수는 series에만 적용 자리수, 포맷
format = lambda x : '%.2f' %x
frame['e'].map(format)

#series의 최대값과 최소값의 차이를 계산 apply는 시리즈, 데이터프레임 둘다 사용가능
f = lambda x: x.max() - x.min()
frame.apply(f)

#각 로우에 대해서 한 번씩 수행
frame.apply(f, axis= 'columns')

f1 = lambda x: round(x*10)
frame.apply(f1, axis=0)

def f(x):
    return pd.Series([x.min(), x.max()], index=['min','max'])
frame.apply(f)

#applymap 사용
format = lambda x : '%.2f' %x
frame.applymap(format)

#각 행에 대해 합계를 구하는 함수, 행을 판단하기 위해 열로 봐야함 axis=1
df['f'] = df.apply(lambda x:x.sum(), axis=1)

#고객 정보 데이터프레임과 구매 내역 데이터프레임을 결합하여 각 고객이름(name) 별 총 지출을 계산하여 출력하세요.
pd.merge(customers, purchases, on='customer_id')
pivot_merge_df = merge_df.pivot_table(index='name', columns='purchase_id', values='amount', aggfunc='sum', fill_value=0)
total_spent = merge_df.groupby('name')['amount'].sum().reset_index()

#학생 성적 데이터프레임과 과목 데이터프레임을 결합하여 각 과목별 평균 성적을 계산하여 출력하세요.
merge_df = pd.merge(grades, subjects, on='subject_id', how='inner')
avg_grades = merge_df.groupby('subject_name')['grade'].mean().reset_index()

#고객 데이터프레임에서 age가 30 이상이고 spending이 500 이상인 고객을 찾아 출력하세요
#조건이 길어지면 변수로 처리
con1 = customers['age'] >= 30
con2 = customers['spending'] >= 500
filtered_customers = customers[con1 & con2]

#주어진 titanic3 데이터셋에서 survived 열을 사용하여 생존자와 비생존자의 수를 계산하여 출력하세요.
survival_counts = df.survived.value_counts() 

#주어진 titanic3 데이터셋에서 pclass 열을 기준으로 각 객실 등급의 평균 운임(fare)을 계산하여 출력하세요.
df.groupby('pclass')['fare'].mean()

# titanic3 각 변수의 상관계수를 통해 각 변수와 목표 변수(생존 여부) 간의 관계를 파악하세요.
corr_df = df[['pclass','survived','age', 'fare']]
print(corr_df.corr())

#객실 등급별 평균 요금(mean_fare_by_pclass)이 생존에 미치는 영향을 분석하기 위해 mean_fare_by_pclass라는 파생 변수를 생성하여 출력하세요.
mean_fare_by_pclass = df.groupby('pclass')['fare'].mean().to_dict()
df['mean_fare_by_pclass'] = df['pclass'].map(mean_fare_by_pclass)

#concat
con1 = pd.concat([df1,df2], axis=0, ignore_index=True) #인덱스 정리: ignore_index=True

#merge()를 이용한 결함
pd.merge(df1,df2,on='ind',how='outer') #합집합 , 큰범위 기준으로 생성
pd.merge(df1,df2,on='ind') #교집합, defualt는 inner , 최소기준으로 생성

#join
df3 = df1.join(df2)   #df1의 행 인덱스를 기준으로 결합하는 how=left 기준이 기본 적용, 없는건 Nan으로 표시
df4 = df1.join(df2, how='right')
df4 = df1.join(df2, how='inner')

#인덱스 삭제 방법 : drop(xx.index[i])
df1.drop(df1.index[0])

idx = df1[df1.a > 10].index
df1.drop(idx)       #drop안에 원하는 인덱스 숫자를 넣으면 삭제

#값변경 다른 방법
tdf.gender.replace({'female':1,'male':0}, inplace=True)  #원본에 반영됨

#칼럼 대문자 변경
tdf.rename(str.upper, axis='columns', inplace=True)

#칼럼 소문자 변경
tdf.rename(str.lower, axis='columns', inplace=True)

#컬럼 순서 변경
columns_customed = ['pclass', 'sex', 'age','survived']
df2[columns_customed].head()

#Dtype변경-딕셔너리형태로 특정열만 변경 가능
tdf1 = tdf.astype({'age':'int','ticket':'int'})

#age컬럼의 값 구성 체크
age_counts_sorted = tdf.age.value_counts()
age_counts_sorted.sort_index()

#age컬럼의 고유 구성 요소
tdf.age.unique()

#age범주화 - 파생변수
def get_category(age):  #baby, child, teenager, young adult, adult, Elderly
    if age < 5:
        return 'baby'
    elif 5<= age < 10:
        return 'child'
    elif 10<= age < 18:
        return 'teenager'
    elif 18 <= age < 30:
        return 'young adult'
    elif 30 <= age < 50:
        return 'adult'
    else:
        return 'Elderly'

tdf['age_cat'] = tdf.age.apply(lambda x: get_category(x))

#cut() 사용
category = ['Baby', 'Child', 'Teenager', 'Young Adult', 'Adult', 'Elderly']
ages = tdf.age.fillna(0).values
tdf['cat'] = pd.cut(ages, bins = [0,1,10,25,35,50,100], labels=category)

#범주형 데이터를 수치형 데이터로 변환
from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
features = ['gender','age']
for feature in features:
    tdf[feature] = le.fit_transform(tdf[feature])

#원핫인코딩
pd.get_dummies(tdf) #클래스별 열 생기고 해당되는 건 True

# hist(): 히스토그램을 생성.
# boxplot(): 박스 플롯을 생성.
# scatter_matrix(): 여러 변수 간의 산점도 행렬을 생성.
# plot.scatter(): 산점도를 생성.
# plot.bar(): 막대 그래프를 생성.
# plot.kde(): 커널 밀도 추정 그래프를 생성.

# 2행 4열의 subplot 설정
fig, axes = plt.subplots(nrows=2, ncols=4, figsize=(20, 10))

# 각 subplot에 산점도 그리기
for i, col in enumerate(columns):
    row, col_idx = divmod(i, 4)
    df.plot(kind='scatter', x=col, y=target, ax=axes[row, col_idx], alpha=0.5)
    axes[row, col_idx].set_title(f'{target} vs {col}')

#표준화
def z_score(x):
    return (x - x.mean()) / x.std()
standize_df = df[['mpg','disp','hp','drat','wt']].transform(z_score)

# 모델 성능 평가 코드
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.metrics import r2_score

# 회귀 모델 구축
X = scaled_df.drop(columns=[target_variable])
y = scaled_df[target_variable]

# 훈련/테스트 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# 선형 회귀 모델 훈련
model = LinearRegression()
model.fit(X_train, y_train)

# 예측
y_pred = model.predict(X_test)

# 모델 성능 평가
mse = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mse)
r2 = r2_score(y_test, y_pred)

print(f"Mean Squared Error: {round(mse,2)}")
print(f"Root Mean Squared Error: {round(rmse,2)}")
print(f"R-squared: {round(r2,2)}")

#탐색적 데이터 분석, 히트맵
plt.figure(figsize=(6,4))
sns.heatmap(df.corr(), annot=True, cmap='coolwarm', center=0)

#주어진 df의 날짜 리스트를 datetime 형식으로 변환하고, 변환된 데이터프레임의 년도, 월, 일 열을 추가하시오.
df = pd.DataFrame(date_list, columns=['date'])
df['date'] = pd.to_datetime(df['date'])
df['year'] = df['date'].dt.year
df['month'] = df['date'].dt.month
df['day'] = df['date'].dt.day
df['day_of_week'] = df['date'].dt.dayofweek

#ex  주어진 월간 데이터를 타임스탬프로 변환하고, 변환된 결과에서 시간을 제외한 날짜만 출력하시오.
period_data = pd.Series(['2023-01', '2023-02', '2023-03'], name='period')
period_data = period_data.astype('period[M]')  # 문자열을 Period로 변환
timestamp_data = period_data.apply(lambda x: x.to_timestamp())  #타임스테프로 변경

#주어진 날짜 데이터 시리즈를 분기로 변환하고, 각 분기별로 데이터의 개수를 출력하세요.
date_series = pd.Series(pd.date_range('2023-01-01', '2023-12-31', freq='M'))
quarter_data = date_series.dt.to_period('Q') #날짜 데이터를 분기로 변환
quarter_counts = quarter_data.value_counts().sort_index()  #각 분기별 데이터 개수 세기

#2023년 1월 1일부터 2023년 12월 31일까지의 날짜 범위를 생성하고, 이 날짜 범위에서 매월 첫 번째 날만 포함하는 데이터프레임을 작성하세요.
dates = pd.date_range('2023-01-01', '2023-12-31', freq='MS')

#2020년부터 2025년까지의 분기별 기간 범위를 생성하고, 각 분기의 시작과 끝 날짜를 포함하는 데이터프레임을 작성하세요.
period_range = pd.period_range('2020', '2025', freq='Q')
df = pd.DataFrame({
    'quarter':period_range,
    'start_date':period_range.start_time.date,
    'end_date':period_range.end_time.date
})

#0일부터 10일까지의 시간 범위를 12시간 간격으로 생성하고, 각 간격에 대해 누적 시간을 계산하여 데이터프레임을 작성하세요.
timedelta_range = pd.timedelta_range(start=0, end='10D', freq='12H')
df = pd.DataFrame({
    'timedelta': timedelta_range,
    'cumulative_time':[timedelta.total_seconds() / 3600 for timedelta in timedelta_range] #리스트 컴프리헨션
})

#주어진 df 에서 특정 날짜 이후의 데이터를 필터링하세요.
filtered_df = df[df['date'] > '2022-01-02']

#주어진 df에서 월별로 데이터의 합계를 계산하세요.
monthly_sum = df.resample('M').sum()
monthly_sum = df.groupby('month')['value'].sum().reset_index()

#주어진 데이터프레임에서 주말(토요일과 일요일) 데이터를 필터링하세요.
df['day_of_week'] = df['date'].dt.dayofweek
weekend_df = df[df['day_of_week'] >= 5]  #주말이 5,6

#주어진 df에서 분기별 데이터의 평균을 계산하세요.
df['quarter'] = df['date'].dt.to_period('Q')
quaterly_mean = df.groupby('quarter')['value'].mean().reset_index()

#주어진 df에서 작업 일자(월요일부터 금요일)만 남기고 필터링하세요.
df['day_of_week'] = df['date'].dt.dayofweek
weekend_df = df[df['day_of_week'] < 5]  #주말이 5,6 - 5보다 작은걸 찾기

# csv 파일 읽고 저장하기
df.to_csv('test.csv')  #데이터 프레임 저장
df.to_csv('test.csv', index=None)  #데이터 프레임 저장, Unnamed 생성되는거 막기 위해
df = pd.read_csv('test.csv')  #파일에 있는 인덱스가 컬럼으로 올라감

#json 파일 읽고 쓰기
df1.to_json('test2.json')
df_j = pd.read_json('test2.json')

#바이너리 파일 읽고 쓰기 - 임시저장시 사용, 속도 빠름
df1.to_pickle('test3.pkl')
df1 = pd.read_pickle('test3.pkl')

#문자열 형식의 날짜를 datetime형식으로 변환하여 처리
date_str = '2022-01-01'
date_dt = pd.to_datetime(date_str)
print(date_dt, type(date_dt))#2022-01-01 00:00:00 <class 'pandas._libs.tslibs.timestamps.Timestamp'>
print(date_dt.date())       #날짜만
print(date_dt.time())       #시간만

# [datetime.date(2020, 1, 1), datetime.date(2020, 1, 5), datetime.date(2020, 1, 10)]를 다시 ['2020-01-01','2020-01-05','2020-01-10']의 형태로 출력
dates = ['2020-01-01','2020-01-05','2020-01-10']
date_objects =pd.to_datetime(dates)
date_only_list = [date.strftime('%Y-%m-%d') for date in date_objects]

#pd.date_range함수는 일정한 간격으로 날짜 범위를 생성하는데 사용
date_range = pd.date_range(start='2020-01-01', end='2020-01-10')  #pd.date_range함수는 pandas에서 제공하지만 내부적으로 numpy의 날짜/시간 타입인 datetime64를 사용

#날짜를 인덱스로 설정하여 데이터프레임을 구성하면 날짜를 기준으로 데이터 조작이 용이
data = {'date': ['2020-01-01', '2020-01-02', '2020-01-03'], 'value': [1,2,3]}
df = pd.DataFrame(data)
df['date'] = pd.to_datetime(df['date'])

#날짜를 인덱스로 설정한 데이터프레임에서는 특정 기간의 데이터를 쉽게 인덱싱하고 슬라이싱
print(df.loc['2020-01-02'])  #특정 날짜의 데이터선택
print(df['2020-01-01' : '2020-01-02'])  #날짜 범위 슬라이싱

#pandas는 주어진 주기(일, 월, 분기 등)에 따라 데이터를 리샘플링 할 수 있는 기능을 제공.
date_range = pd.date_range(start='2022-01-01', periods=10, freq='D')
data = {'value': range(10)}
df = pd.DataFrame(data, index=date_range)
monthly_sum = df.resample('M').sum()  #resample메소드를 사용하면 다양한 방법으로 데이터를 집계

#Q. 365일간 일당을 성과에 따라서 50~100달러를 받는다. 월 별 합계를 구하세요.
date_range = pd.date_range(start='2022-01-01', periods=365, freq='D')
data = {'value': np.random.randint(50,100,365)}
df = pd.DataFrame(data, index=date_range)
monthly_sum = df.resample('M').sum()

#인덱스 이용 방법
df1['Date'] = pd.to_datetime(df1['Date'])
df1.set_index('Date', inplace=True)
df1['New_year'] = df1.index.year
df1['New_month'] = df1.index.month
df1['New_day'] = df1.index.day
df1['New_day_of_week'] = df1.index.dayofweek

#dt접근자 이용 방법
df2['Date'] = pd.to_datetime(df2['Date'])
df2.set_index('Date', inplace=True)
df2['New_year'] = df2['Date'].dt.year
df2['New_month'] = df2['Date'].dt.month
df2['New_day'] = df2['Date'].dt.day
df2['New_day_of_week'] = df2['Date'].dt.dayofweek

#인덱스도 소팅 가능
df.sort_index(inplace=True)

#데이터 프레임에 대해 양끝단 포함, 슬라이싱 가능
df_ymd_range = df.loc['2018-06-26': '2018--6-29']

#날짜 데이터로 인식해서 쉽게 표현 가능
df_ym = df.loc['2018-07', 'Start':'High']

#데이트타임 객체 타임스템프로 변환
dt1 = datetime(2011,1,2)
ts1 = pd.Timestamp(dt1)  #Timestamp('2011-01-02 00:00:00')

#datetime으로 변환
ts1 = pd.Timestamp('2011-01-02')
dt1 = ts1.to_pydatetime()  #datetime.datetime(2011, 1, 2, 0, 0)

#truncate 날짜 자르기
print(ts.truncate(before='2011-01-05', after='2011-01-10'))

#date_range에 데이트타임 객체로 범위 생성 가능
from datetime import datetime
from datetime import timedelta
now = datetime.now()
in_two_weeks = now + timedelta(weeks=2)
pd.date_range(datetime.now(), in_two_weeks)

#periods매개변수는 date_range함수에 전달된 시작날짜와 종료날짜를 피리어드 매개변수에 전달된 기준의 수만큼 동일하게 나누어 출력
ts = pd.date_range(start='2023-11-01',end='2023-11-30',periods=10)

#normalize=True 옵션은 함수에서 날짜와 시간을 생성할 때 시간 정보를 제거
pd.date_range('2012-05-02 12:34:11', periods=5, normalize=True)

#1월 데이터만 출력
long_df.loc['2024-01']

#인덱스 중복된거 찾을때 유용
dup_ts.index.is_unique

#오프셋 객체들은 새로운 시간을 계산하거나 시계열 데이터를 조작하는데 사용
from pandas.tseries.offsets import Hour, Minute
Hour(2) + Minute(30)

#Week of month , 매월 세 번째 금요일에 해당하는 날짜를 생성
rng = pd.date_range('2000-01-01','2012-09-01', freq='WOM-3FRI')

#정해진 날짜에 3일후
from pandas.tseries.offsets import Day, MonthEnd
now = datetime(2011,11,17)
now + 3 * Day()

# 현재 날짜를 기준으로 가장 가까운 월말 날짜로 이동
offset = MonthEnd()
print(offset.rollforward(now))

#현재 날짜 기준으로 가장 가까운 이전 월말 날짜로 이동
offset.rollback(now)

#숫자열에 대해 결측값을 각 열의 평균값으로 대체 / 평균값은 숫자형 자료만 가능
for column in columns:
    df2[column].fillna(df2[column].mean(),inplace=True)

#과목별 평균을 해야한는 경우
df3.pivot_table(index='Name',columns='Subject',values='Score',aggfunc='mean')
df3_pivot = df3.pivot_table(index='Name',columns='Subject',values='Score',aggfunc='mean').reset_index()
df3_pivot.columns.name = None       #피봇으로 생기는 subject 컬럼제거
array3 = df3_pivot.to_numpy()  #array
dict3 = df3_pivot.to_dict('list')  #dictionary
list3 = df3_pivot.values.tolist()  #list

# df4에서 특정 열의 데이터 타입을 변환한 후 변환된 타입을 확인하세요.
df4['A'] = df4['A'].astype(int)
df4['B'] = df4['B'].astype(float)
df4['C'] = pd.to_datetime(df4['C'])
print(df4.dtypes)

