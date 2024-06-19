# 크롤링

## css 셀럭터

- #id, .class, tag
  
## xpath

- // : 가장 상위 엘리먼트
- div[@class='class_name'] : class_name 클래스를 가진 div 엘리먼트
- div[@id='id_name'] : id_name 아이디를 가진 div 엘리먼트
  

id wrap안에 id header 추출

```python
header_div = soup.select_one('#wrap #header')
```

## 동적웹 크롤링 - 셀레니움 사용

```python
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time

options = Options()
options.add_argument("--start-maximized")
options.add_experimental_option("detach", True)

driver = webdriver.Chrome(options=options)

# naver 페이지 열기

url = 'https://www.naver.com/'
driver.get(url)

# 페이지 로딩 대기

time.sleep(3)

try:
    newsstand_link = driver.find_element(By.CSS_SELECTOR, '#newsstand > div.ContentHeaderView-module__content_header___nSgPg > div > ul > li:nth-child(1) > span > a:nth-child(1)')
    print(newsstand_link.text)
except Exception as e:
    print(e, 'newsstand link not found')

driver.quit()
```

## xpath 사용

```python
driver.find_element(By.XPATH, '//*[@id="newsstand"]')
```

## header 사용

```python
headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
}

response = requests.get(url, headers=headers)
```

