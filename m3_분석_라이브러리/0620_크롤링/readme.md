string vs. get_text() vs. text

string - 단일 텍스트 노드만 있는 요소의 텍스트를 추출할 때

get_text() - 요소 내 모든 텍스트를 추출하고, 구분자 및 공백 처리가 필요한 경우

text - 요소 내 모든 텍스트를 단순하게 추출할 때

- 정규 표현식
- 이메일 추출 : email_pattern = re.compile(r'[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+')
- url : url_pattern = re.compile(r'https?://[^\s<>"]+|www\.[^\s<>"]+')
- html 태그내 텍스트 추출 : tag_text = re.findall(r'>([^<]+)<', html)

- 인코딩 에러시 : import chardet 사용

- news_url.format(query): URL 문자열 내의 특정 부분을 query 변수의 값으로 대체
