from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    roc_auc_score,
    confusion_matrix,
)


def train_and_evaluate(model, X_train, X_test, y_train, y_test):
    model.fit(X_train, y_train)
    pred = model.predict(X_test)
    pred_proba = model.predict_proba(X_test)[:, 1]

    accuracy = accuracy_score(y_test, pred)
    precision = precision_score(y_test, pred)
    recall = recall_score(y_test, pred)
    f1 = f1_score(y_test, pred)
    roc_auc = roc_auc_score(y_test, pred_proba)
    confusion = confusion_matrix(y_test, pred)

    print(f"오차행렬: \n{confusion}")
    print(
        f"정확도: {accuracy:.4f}, 정밀도: {precision:.4f}, 재현율: {recall:.4f}, F1: {f1:.4f}, AUC: {roc_auc:.4f}"
    )
    print(" ")


def get_clf_eval(y_test, pred, pred_proba):
    from sklearn.metrics import (
        accuracy_score,
        precision_score,
        recall_score,
        f1_score,
        roc_auc_score,
        confusion_matrix,
    )

    confusion = confusion_matrix(y_test, pred)
    accuracy = accuracy_score(y_test, pred)
    precision = precision_score(y_test, pred)
    recall = recall_score(y_test, pred)
    f1 = f1_score(y_test, pred)
    # ROC-AUC 추가
    roc_auc = roc_auc_score(y_test, pred_proba)
    print("오차 행렬")
    print(confusion)
    # ROC-AUC print 추가
    print(
        f"평가 함수 결과 :\n정확도 : {accuracy:.4f}, 정밀도 : {precision:.4f}, 재현율 : {recall:.4f}, F1 : {f1:.4f}, ROC AUC : {roc_auc:.4f}"
    )

# 임계값에 따른 평가 수치 출력 함수
from sklearn.preprocessing import Binarizer

pred_proba_c1 = pred_proba.reshape(-1, 1)


def get_eval_by_threshold(y_test, pred_proba_c1, thresholds):
    # thresholds 리스트 객체내의 값을 차례로 iteration하면서 Evaluation 수행.
    for custom_threshold in thresholds:
        binarizer = Binarizer(threshold=custom_threshold).fit(pred_proba_c1)
        custom_predict = binarizer.transform(pred_proba_c1)
        print("임곗값:", custom_threshold)
        get_clf_eval(y_test, custom_predict, pred_proba_c1)
        print()


from sklearn.preprocessing import LabelEncoder


# Null 처리 함수
def fillna(df):
    df["Age"].fillna(df["Age"].mean(), inplace=True)
    df["Cabin"].fillna("N", inplace=True)
    df["Embarked"].fillna("N", inplace=True)
    df["Fare"].fillna(0, inplace=True)
    return df


# 머신러닝 알고리즘에 불필요한 속성 제거
def drop_features(df):
    df.drop(["PassengerId", "Name", "Ticket"], axis=1, inplace=True)
    return df


# 레이블 인코딩 수행.
def format_features(df):
    df["Cabin"] = df["Cabin"].str[:1]
    features = ["Cabin", "Sex", "Embarked"]
    for feature in features:
        le = LabelEncoder()
        le = le.fit(df[feature])
        df[feature] = le.transform(df[feature])
    return df


# 앞에서 설정한 Data Preprocessing 함수 호출
def transform_features(df):
    df = fillna(df)
    df = drop_features(df)
    df = format_features(df)
    return df


# 사전 데이터 가공 후 학습과 테스트 데이터 세트를 반환하는 함수.
# 데이터를 전처리하는 get_preprocessed_df 함수
def get_train_test_dataset(df=None):
    # 인자로 입력된 DataFrame의 사전 데이터 가공이 완료된 복사 DataFrame 반환
    df_copy = get_preprocessed_df(df)
    # DataFrame의 맨 마지막 컬럼이 레이블, 나머지는 피처들
    X_features = df_copy.iloc[:, :-1]
    y_target = df_copy.iloc[:, -1]
    # train_test_split( )으로 학습과 테스트 데이터 분할. stratify=y_target으로 Stratified 기반 분할
    X_train, X_test, y_train, y_test = train_test_split(
        X_features, y_target, test_size=0.3, random_state=0, stratify=y_target
    )
    # 학습과 테스트 데이터 세트 반환
    return X_train, X_test, y_train, y_test


X_train, X_test, y_train, y_test = get_train_test_dataset(card_df)


# 인자로 사이킷런의 Estimator객체와, 학습/테스트 데이터 세트를 입력 받아서 학습/예측/평가 수행.
def get_model_train_eval(
    model, ftr_train=None, ftr_test=None, tgt_train=None, tgt_test=None
):
    model.fit(ftr_train, tgt_train)
    pred = model.predict(ftr_test)
    pred_proba = model.predict_proba(ftr_test)[:, 1]
    get_clf_eval(tgt_test, pred, pred_proba)


from sklearn.preprocessing import StandardScaler


# 사이킷런의 StandardScaler를 이용하여 정규분포 형태로 Amount 피처값 변환하는 로직으로 수정.
def get_preprocessed_df(df=None):
    df_copy = df.copy()
    scaler = StandardScaler()
    amount_n = scaler.fit_transform(df_copy["Amount"].values.reshape(-1, 1))
    # 변환된 Amount를 Amount_Scaled로 피처명 변경후 DataFrame맨 앞 컬럼으로 입력
    df_copy.insert(0, "Amount_Scaled", amount_n)
    # 기존 Time, Amount 피처 삭제
    df_copy.drop(["Time", "Amount"], axis=1, inplace=True)
    return df_copy


# np.log1p 함수를 사용하여 'Amount' 피처를 로그 변환
def get_preprocessed_df(df=None):
    df_copy = df.copy()
    # 넘파이의 log1p( )를 이용하여 Amount를 로그 변환
    amount_n = np.log1p(df_copy["Amount"])
    df_copy.insert(0, "Amount_Scaled", amount_n)
    df_copy.drop(["Time", "Amount"], axis=1, inplace=True)
    return df_copy

# 데이터에서 이상치를 찾는 get_outlier 함수를 정의
import numpy as np


def get_outlier(df=None, column=None, weight=1.5):
    # fraud에 해당하는 column 데이터만 추출, 1/4 분위와 3/4 분위 지점을 np.percentile로 구함.
    fraud = df[df["Class"] == 1][column]
    quantile_25 = np.percentile(fraud.values, 25)
    quantile_75 = np.percentile(fraud.values, 75)
    # IQR을 구하고, IQR에 1.5를 곱하여 최대값과 최소값 지점 구함.
    iqr = quantile_75 - quantile_25
    iqr_weight = iqr * weight
    lowest_val = quantile_25 - iqr_weight
    highest_val = quantile_75 + iqr_weight
    # 최대값 보다 크거나, 최소값 보다 작은 값을 아웃라이어로 설정하고 DataFrame index 반환.
    outlier_index = fraud[(fraud < lowest_val) | (fraud > highest_val)].index
    return outlier_index


# Precision-Recall 커브를 시각화하는 함수

import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from sklearn.metrics import precision_recall_curve


def precision_recall_curve_plot(y_test, pred_proba_c1):
    # threshold ndarray와 이 threshold에 따른 정밀도, 재현율 ndarray 추출.
    precisions, recalls, thresholds = precision_recall_curve(y_test, pred_proba_c1)

    # X축을 threshold값으로, Y축은 정밀도, 재현율 값으로 각각 Plot 수행. 정밀도는 점선으로 표시
    plt.figure(figsize=(8, 6))
    threshold_boundary = thresholds.shape[0]
    plt.plot(
        thresholds, precisions[0:threshold_boundary], linestyle="--", label="precision"
    )
    plt.plot(thresholds, recalls[0:threshold_boundary], label="recall")

    # threshold 값 X 축의 Scale을 0.1 단위로 변경
    start, end = plt.xlim()
    plt.xticks(np.round(np.arange(start, end, 0.1), 2))

    # x축, y축 label과 legend, 그리고 grid 설정
    plt.xlabel("Threshold value")
    plt.ylabel("Precision and Recall value")
    plt.legend()
    plt.grid()
    plt.show()


def get_model_cv_prediction(model, X_data, y_target):
    neg_mse_scores = cross_val_score(
        model, X_data, y_target, scoring="neg_mean_squared_error", cv=5
    )
    rmse_scores = np.sqrt(-1 * neg_mse_scores)
    avg_rmse = np.mean(rmse_scores)
    print("##### ", model.__class__.__name__, " #####")
    print(" 5 교차 검증의 평균 RMSE : {0:.3f} ".format(avg_rmse))


# 상관도가 높은 속성을 PCA로 변환한 뒤 explained_variance_ratio_ 속성으로 확인
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

# BILL_AMT1 ~ BILL_AMT6 까지 6개의 속성명 생성
cols_bill = ["BILL_AMT" + str(i) for i in range(1, 7)]
print("대상 속성명:", cols_bill)

# 6개의 속성을 2개의 컴포넌트로 PCA 변환하고 변동성을 알아보기 위하여 explained_variance_ratio_ 계산
scaler = StandardScaler()
df_cols_scaled = scaler.fit_transform(X_features[cols_bill])
pca = PCA(n_components=2)
pca.fit(df_cols_scaled)
# 2개의 PCA 컴포넌트만으로도 6개 속성의 변동성을 약 95% 이상 설명
print("PCA Component 별 변동성:", pca.explained_variance_ratio_)


import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import TruncatedSVD
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report, roc_auc_score
from sklearn.preprocessing import label_binarize

# 1. 데이터 로드
url = "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
data = pd.read_csv(url, sep=";")

# 특성과 레이블 분리
X = data.drop(columns="quality")
y = data["quality"]

# 품질을 범주형 변수로 변환 (예: 3-5 -> low, 6 -> medium, 7-8 -> high)
y = y.apply(lambda x: "low" if x <= 5 else ("medium" if x == 6 else "high"))

# 2. 데이터 정규화
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# 3. TruncatedSVD를 사용하여 차원 축소
n_components = 5  # 축소할 차원의 수
svd = TruncatedSVD(n_components=n_components)
X_svd = svd.fit_transform(X_scaled)

# 4. 학습 및 테스트 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(
    X_svd, y, test_size=0.2, random_state=42
)

# 5. 로지스틱 회귀 모델 학습
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)


# 평가 사용자 함수 정의
def evaluate_model(model, X_test, y_test):
    # 예측 수행
    y_pred = model.predict(X_test)

    # 정확도 계산
    accuracy = accuracy_score(y_test, y_pred)

    # 분류 보고서 생성
    report = classification_report(y_test, y_pred)

    # ROC AUC 계산
    # 멀티 분류일 경우 label_binarize를 사용하여 각 클래스를 이진화해야 함
    # 클래스 나눠주는 것 유의
    y_test_binarized = label_binarize(y_test, classes=["low", "medium", "high"])
    y_pred_prob = model.predict_proba(X_test)
    # ovr: One-vs-Rest
    roc_auc = roc_auc_score(y_test_binarized, y_pred_prob, multi_class="ovr")

    # 결과 출력
    print(f"Test Accuracy: {accuracy:.4f}")
    print("\nClassification Report:")
    print(report)
    print(f"Test ROC AUC: {roc_auc:.4f}")


# 6. 모델 평가
evaluate_model(model, X_test, y_test)


from sklearn.preprocessing import scale
from sklearn.metrics import silhouette_samples, silhouette_score
from sklearn.datasets import load_iris
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

iris = load_iris()
df_iris = pd.DataFrame(
    data=iris.data,
    columns=["sepal length", "sepal width", "petal length", "petal width"],
)
df_iris = pd.DataFrame(data=iris.data, columns=iris.feature_names)
kmeans = KMeans(n_clusters=3, n_init="auto", max_iter=300, random_state=0).fit(df_iris)
df_iris["cluster"] = kmeans.labels_

score_samples = silhouette_samples(iris.data, df_iris["cluster"])
print(score_samples.shape)
df_iris["silhouette_coeff"] = score_samples
average_score = silhouette_score(iris.data, df_iris["cluster"])
print("score:", average_score)
df_iris.head()
