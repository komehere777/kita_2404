import random

list1 = [
    "#Q.while 문을 사용해 1부터 1000까지의 정수 중 3의 배수의 합을 구해보세요",
    "#Q. 정수를 입력하면 홀수 짝수를 판별하는 프로그램 작성 while try except 사용",
    """#Q. 두개의 리스트(이름과 성)를 사용하여 각 사람의 전체 이름을 생성하세요.
first_names = ["John", 'Jane', 'Corey', 'Travis']
last_names = ["Doe", "Smith", "Turner", "Williams" ] """,
    """#q. 학생들의 수학과 영어 점수를 각각의 리스트로 받아 평균 점수를 계산하세요.
math_scores =[88,92,79,93,85]
english_scores =[90,92, 85,88,86]""",
    "#Q. 로또번호 6개를 6세트 출력하는 코드를 작성하세요(중복안됨)",
    """#Q. n개 그룹으로 분류하는 코드를 작성하세요.!!
kita = ['김성현','황강민','윤호준','류윤선','이상협','박지환','최환욱','서보선','김한결','김도현','김하준', '김도원','신현진','소지승','이범석','이현석','이명신','박윤경','이도헌','김홍준']
""",
    "#Q. 가위 바위 보 게임을 프로그래밍하세요.",
    """#Task5_0502. 주어진 리스트에서 중복된 요소를 제거하고, 남은 요소만을 포함하는 새 리스트를 반환합니다.
#순서는 유지해야 합니다.  ! for문 사용
input_list = [1, 2, 2, 3, 4, 4, 4, 5, 6, 7, 7 ] """,
    """# Task1_0430. 남녀 파트너 정해주기 프로그램(zip)
# 같은 수의 남녀 모임에서 파트너를 랜덤하게 정해주는 프로그램을 만들어 보세요
male = ['철수','갑돌','로미오','이몽룡','온돌']
female = ['미미','갑순','줄리엣','성춘향','평강']""",
"""Task1_0430. 남녀 파트너 정해주기 프로그램(zip)
같은 수의 남녀 모임에서 파트너를 랜덤하게 정해주는 프로그램을 만들어 보세요
male = ['철수','갑돌','로미오','이몽룡','온돌']
female = ['미미','갑순','줄리엣','성춘향','평강']""",
"Task2_0430. 대문자, 소문자, 숫자를 포함하는 8자리 랜덤 비밀번호를 생성하는 프로그램을 작성하세요.",
    "Task4_0430. 사용자로부터 숫자를 입력받아 해당 숫자의 구구단을 출력하는 프로그램을 작성하세요.",
    "Task5_0430. 사용자로부터 숫자를 입력받아 해당 숫자의 팩토리얼을 계산하세요.",
    "Task6_0430. 0부터 20까지의 숫자 중에서 짝수와 홀수를 분리하여 두 개의 리스트에 저장하세요.",
    """Task7_0430. 주어진 리스트에서 최대값을 찾아 출력하세요.
numbers = [34,78,2,45,99,23]""",
    "Task8_0430. 1부터 10 사이의 임의의 숫자를 맞추는 게임을 만드세요. 사용자가 숫자를 맞출 때까지 입력을 계속 받으며, 정답을 맞추면 게임을 종료하세요. 단, 입력 숫자가 정답보다 큰지 작은지 힌트를 주는 방식으로 코드 작성",
    """Task10_0430. 아래 사항을 반영하여 커피 자판기 프로그램을 작성하세요.
시나리오 : 자판기 커피 재고 5잔, 커피 1잔 가격 300원, 재고 범위내에서 300원 이상 돈을 넣으면 거스름돈과 커피를 주고 그렇지 않으면 반환하며 재고가 소진되면 안내멘트 출력
각 Case별 멘트 출력은 상황에 맞게 창작
while, if ~ elif ~ else 제어문을 사용하여 작성""",
    "Task1_0502. 짝수와 짝수를 입력하면 곱한 값을 출력하고 홀수와 홀수를 입력하면 덧셈 값을 출력하고 그외는 다시 입력하라는 메시지를 출력하세요.",
    """Task4_0502. [ ]을 채워서 아래의 출력과 같이 출력하세요.
numbers = [1,2,3,4,5,6,7,8,9]
output = [[], [], []]
# [[1,4,7],[2,5,8],[3,6,9]]""",
    """Task5_0502. 주어진 리스트에서 중복된 요소를 제거하고, 남은 요소만을 포함하는 새 리스트를 반환합니다. 순서는 유지해야 합니다.
input_list = [1, 2, 2, 3, 4, 4, 4, 5, 6, 7, 7]""",
    """Task6_0502. 주어진 문자열을 모스 코드로 변환하는 함수를 작성하세요. 공백은 무시하고 알파벳만 변환하세요.
input_text = "Hello world"
morse_code = {
        'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 'F': '..-.',
        'G': '--.', 'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 'L': '.-..',
        'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 'R': '.-.',
        'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 'X': '-..-',
        'Y': '-.--', 'Z': '--..'
    }""",
    """Task7_0502. 주어진 비대칭 m×n 매트릭스(2차원 리스트)에서, 모든 대각선 상의 합을 계산하는 함수를 작성하세요. 결과는 각 대각선의 합을 리스트로 반환해야 합니다.
input_matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10, 11, 12]
]""",
    """#Q. d에서 반복문을 사용하여 97 98 99 을 출력하세요
d = {'a':97, 'b':98, 'c':99}""",
    """#Q. 리스트에서 특정값 찾기 for~else문
numbers = [1,2,3,4,5]
target = 6""",
    """#while ~ continue ~ break
#20보다 작은 정수에서 1 3 5 7 9만을 출력""",
    "#Q. 정수 1부터 n까지 더할 때 그 합이 1000보다 커지게 되는 n값과 합을 구하세요 (while ~break) 45 1035",
    "#Q.while 문을 사용해 1부터 1000까지의 정수 중 3의 배수의 합을 구해보세요 166833",
    """#Q. 입력받은 문자열의 각 문자를 그 다음 문자로 변경하여 출력하세요.(ABC -> BCA)
#for ~ else 문""",
    "#Q. 로또번호 6개를 6세트 출력하는 코드를 작성하세요",
    """유효한 변수이름 찾기, identifiers = ["var1", "2things", "variable_name", "time!", "True"]""",
    """Task1_0425. 주어진 숫자 리스트에서 최소값과 최대값을 찾아 출력하세요.
numbers = [58, 45, 69, 19, 4, 87, 29, 13, 39, 15]""",
    """Task3_0425. 주어진 리스트에서 특정 요소가 등장하는 모든 인덱스를 리스트로 만들어 출력하세요.
items = ['apple', 'banana', 'cherry', 'apple', 'cherry', 'apple']
target = 'apple'""",
    """Task4_0425. 주어진 리스트에서 연속해서 반복되는 요소만 제거하고, 결과 리스트를 반환하세요. 단, 처음 등장하는 요소는 유지해야 합니다.
예를 들어, ['a', 'a', 'b', 'c', 'c', 'c', 'd', 'e', 'e']가 입력되면, ['a', 'b', 'c', 'd', 'e']를 출력해야 합니다.""",
    """Task5_0425 주어진 정수 리스트와 회전 횟수 k에 대해 리스트를 오른쪽으로 k만큼 회전시킨 결과를 반환하세요. k가 리스트의 길이보다 클 수 있으며, 이 경우 k를 리스트 길이로 나눈 나머지만큼 실제 회전시키면 됩니다.
예를 들어, [1, 2, 3, 4, 5]와 k=2가 주어지면, 결과는 [4, 5, 1, 2, 3]이 되어야 합니다.""",
    """Task3_0426. 주어진 숫자 리스트에서 특정 값보다 큰 요소가 하나라도 존재하는지 검사하고, 그 결과를 불 값으로 반환하는 함수를 작성하세요.
numbers = [1, 2, 3, 10, 20]
threshold = 15""",
    """Task4_0426. 주어진 문자열이 특정 문자열을 포함하는지 확인하고 결과를 불 값으로 반환하는 함수를 작성하세요.
text = "hello world"
substring = "world""",
    """Task5_0426. 주어진 연도가 윤년인지 판별하는 함수를 작성하세요. 윤년은 다음의 조건을 만족해야 합니다:
4로 나누어 떨어진다.
100으로 나누어 떨어지지 않거나, 400으로 나누어 떨어지면 윤년이다.
year = 2020
True""",
    "Task6_0426. Calculator 클래스를 작성하고 4칙연산을 수행하는 객체 4개를 작성하여 결과를 출력하세요.",
    """Task7_0426. 다음 과제를 수행하세요.

사용자로 부터 텍스트를 입력 받는다.
문자을 단어 단위로 분리 : split()
단어의 빈도수를 저장할 딕셔너리를 생성
각 단어의 빈도 수를 계산(for 문 / if else문)
결과 출력
[ 예시 ]

문장을 입력하세요: I love apple. I love orange. Apple is tasty

{'i': 2, 'love': 2, 'apple.': 1, 'orange.': 1, 'apple': 1, 'is': 1, 'tasty': 1}""",
    """Task1_0429. input_str을 아래와 같이 단어로 분리하여 출력하세요.
input_str = "Hello, world! How are you today? I am fine. Thank you!"

['Hello', 'world', 'How', 'are', 'you', 'today', 'I', 'am', 'fine', 'Thank', 'you', '']""",
    "Task2_0429. 십진수 122를 2진수, 8진수, 16진수로 변경하여 출력하세요.",
    """Task4_0429. 주어진 리스트에서 두 번째 요소를 삭제하고, 마지막에 새로운 요소 'Python'을 추가하세요.
리스트: ['Java', 'C', 'JavaScript']""",
    """Task5_0429. 주어진 문자열에서 처음 세 글자와 마지막 세 글자를 연결하여 새로운 문자열을 만드세요.
문자열: 'Incredible'""",
    """Task6_0429. 사용자의 이름과 이메일을 딕셔너리로 저장하고, 이름을 입력받아 해당하는 이메일을 출력하세요.
사용자 정보: 이름 - 'Alice', 이메일 - 'alice@example.com'""",
    """Task8_Challenge_0429. 다음 요구 사항을 충족하는 프로그램을 작성하세요:

사용자로부터 이름, 나이, 좋아하는 색상을 입력받습니다.
입력받은 정보를 딕셔너리로 저장하고, 모든 사용자 정보를 리스트에 저장합니다.
이름이 'John'인 사용자의 정보만 출력하세요.
전체 사용자의 평균 나이를 계산하고 출력하세요.

사용자 데이터:
이름: John
나이: 28
좋아하는 색상: Blue
사용자 데이터:
이름: Alice
나이: 24
좋아하는 색상: Red
사용자 데이터:
이름: Maria
나이: 32
좋아하는 색상: Green""",
    """
    Task1_0507. 튜플 형태인 strings를 다양한 문자가 포함된 순서로 정렬하세요.

strings = ('a', 'ca', 'bar', 'aaaa', 'ababa')
""",
    """
    Task2_0507. a,b 변수와 연산자를 입력하면 사칙연산을 수행하는 코드를 작성하세요.(eval 사용하는 경우와 안하는 경우)
    """,
    """
    Task3_0507. list1에 대해서 아래와 같이 출력하는 코드를 작성하세요.
list1 = ['김부장', '이차장', '김과장', '이대리', '오사원', '김인턴']
인사평가 1번째 해당자는 김부장입니다. 회의실A로 오시기 바랍니다.\
인사평가 2번째 해당자는 이차장입니다. 회의실A로 오시기 바랍니다.\
인사평가 3번째 해당자는 김과장입니다. 회의실A로 오시기 바랍니다.\
인사평가 4번째 해당자는 이대리입니다. 회의실A로 오시기 바랍니다.\
인사평가 5번째 해당자는 오사원입니다. 회의실A로 오시기 바랍니다.\
인사평가 6번째 해당자는 김인턴입니다. 회의실A로 오시기 바랍니다.
""",
    """
    Task4_0507. 주어진 문자열 리스트의 요소들을 대문자로 변환하세요.
words = ["hello", "world", "python", "map"]
""",
    """"
    Task5_0507. 주어진 리스트에서 'p'로 시작하는 단어만 필터링하세요.

words = ["python", "is", "powerful", "programming", "language", "pandas"]
""",
    """
    Task6_0507. 내장함수를 이용해서 list = [0,1,2,3,4,5,6]에서 2를 삭제 후 출력하세요.(2가지 방법)
    """,
    """
    Task7_0507. 내장함수를 이용하여 동일한 개수로 이루어진 자료형을 화살표 좌측에서 우측으로 변환하세요.

[1,2,3],[4,5,6] -> [(1,4),(2,5),(3,6)]\
[1,2,3],[4,5,6] [7,8,9] -> [(1,4,7),(2,5,8),(3,6,9)]\
('abc','def') -> [('a','d'),('b','e'),('c','f')]
""",
    """
    Task8_0507. url에서 호스트 도메인(news.naver.com)을 추출하여 출력하세요.

url = 'http://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=105&oid=028&aid=0002334601'
"""
    
]
print()
# for i in random.sample(list1, 10):
#     print(f"{i} 번째 문제", end='\n')
#     print()
sample_num = int(len(list1) / 4)
for i, v in enumerate(random.sample(list1, sample_num), start=1):
    print(f"{i} 번째 문제\n", v, end='\n')
    print()

print(len(list1))
