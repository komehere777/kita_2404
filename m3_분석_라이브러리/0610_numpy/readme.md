- 인덱싱, 슬라이싱
- 배열의 부분집합
- boolean indexing 
- 인덱싱을 이용하여 아래 배열을 내림차순으로 정렬
- np.where(arr != 0)
- np.nonzero(arr)
- 팬시 인덱싱(정수, 부울마스트 , 양자 결함)
- view
- 메모리 효율성, 원본 배열도 반영, 슬라이싱 연산으로 생성, 원본 배열구조는 변함없음
- view() 메소드 : 데이터타입 변경가능
- swapaxes, tanspose
- np.mod, np.remainder - 나머지
- np.reciprocal() - 역수
- np.power() - 승수
- any(), all()
- np.meshgrid(x,y) - 좌표 그리드 생성
- random.randint : 파이썬은 끝자리 포함, 넘파이는 미포함
- ndarray.sort() : 원본 반영, 파이썬, 넘파이 둘다 반영
- sorted() : 원본 미반영 ex. a = sorted(my_list)
- np.argsort(): 원본 행렬 인덱스 필요시
- sort() 후 5%분위수 구하기
- unique, intersect1d, union1d, in1d, set
- np.save, np.load

