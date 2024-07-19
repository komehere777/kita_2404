## 중고 핸드폰 구매자를 위한 웹 기반 서비스 플랫폼

1. 서비스 개요
● 서비스 목표 : 안전하고 신뢰할 수 있는 플랫폼에서 원하는 모델을 구매하도록 지원
● 타겟 사용자 : 중고 핸드폰을 구매하고자 하는 소비자
● 서비스 기능 : 검색 및 필터링 기능, 장바구니 시스템

2. 기술적 구현
● 실시간 데이터 정보
● 상품 링크 이동
● 제품 추천
● 모바일 호환성

3. 마케팅 전략
● 타겟 마케팅 : 젊은 층 타겟, 중고폰 매입, 판매업체
● 사용자 유치 전략 : 시각적 콘텐츠, 블로그 리뷰 추천

## 기술 구현
1. 데이터 베이스 설계
● User와 Wishlist: 일대다(One-to-Many) 관계. 
한 사용자는여러개의위시리스트항목을가질수
있습니다.
● Wishlist와 Product: 다대일(Many-to-One) 관계. 
여러위시리스트항목이하나의제품을참조할수
있습니다.

2. 디렉토리 구조 - BluePrint를 이용, 확장성 고려
- D:.
  - .venv
  - apps
    - app.py
    - config.py
    - auth
      - forms.py
      - views.py
      - __init__.py
      - static
        - login.css
        - signup.css
      - templates
        - auth
          - base.html
          - index.html
          - login.html
          - signup.html
    - crud
      - forms.py
      - models.py
      - views.py
      - __init__.py
      - static
        - crud_create.css
        - crud_index.css
        - style.css
      - templates
        - crud
          - base.html
          - create.html
          - edit.html
          - index.html
    - main
      - forms.py
      - models.py
      - views.py
      - __init__.py
      - static
        - style.css
      - templates
        - main
          - index.html
          - product_detail.html
    - personal
      - forms.py
      - models.py
      - views.py
      - __init__.py
      - static
      - templates
        - personal
          - edit_user.html
          - index.html
    - templates
      - base.html
  - migrations


    
- flask shell을 이용한 csv 파일 DB로 Load
- API 주소 변경로직 분석 및 대응법
