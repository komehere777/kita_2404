SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM IMPORTED_BOOK;
SELECT * FROM ORDERS;
SELECT BOOKID,PRICE FROM BOOK;
--중복없이 출력
SELECT DISTINCT PUBLISHER FROM BOOK;

--Q. 가격이 10000원 이상인 도서를 검색
SELECT * FROM BOOK
WHERE PRICE >= 10000;

--Q.가격이 10000원 이상 20000원 이하인 도서를 검색하시오(2가지 방법)
SELECT * FROM BOOK
WHERE PRICE >= 10000 AND PRICE <= 20000;

SELECT * FROM BOOK
WHERE PRICE BETWEEN 10000 AND 20000;

--TASK1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시요. 3가지 방법
SELECT * FROM BOOK
WHERE (PUBLISHER='굿스포츠') OR (PUBLISHER='대한미디어');

--TASK2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시요.
SELECT * FROM BOOK
WHERE NOT ((PUBLISHER='굿스포츠') OR (PUBLISHER='대한미디어'));

--LIKE는 정확히 '축구의 역사'와 일치하는 행만 선택
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '축구의 역사';

--'축구'가 포함된 출판사
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '%축구%';
-- %는 0개 이상의 임의 문자

--도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 같는 도서
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '_구%';
-- _는 정확히 1개의 임의의 문자

--TASK3_0517. 축구에 관한 도서중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT * FROM BOOK
WHERE PRICE >= 20000 AND BOOKNAME LIKE '%축구%';

--ORDER BY: 기본 올림차순 정렬(default)
SELECT * FROM BOOK
ORDER BY BOOKNAME;

SELECT * FROM BOOK
ORDER BY BOOKID;

SELECT * FROM BOOK
ORDER BY PRICE;

--내림차순 정렬
SELECT * FROM BOOK
ORDER BY BOOKNAME DESC;

SELECT * FROM BOOK
ORDER BY BOOKID DESC;

SELECT * FROM BOOK
ORDER BY BOOKID DESC;

--Q.도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
--원하는 순서대로 배열
SELECT * FROM BOOK
ORDER BY PRICE, BOOKNAME; 


SELECT SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
WHERE CUSTID = 2;

--GROUP BY : 데이터를 특정 기준에 따라 그룹화하는데 사용. 이를 통해 집계 함수(SUM, AVG, MAX, MIN, COUNT)를 이용, 계산
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE, 
MIN(SALEPRICE) AS MINIMUM,
MAX(SALEPRICE) AS MAXIMUM
FROM ORDERS;

--총판매액을 CUSTID 기준으로 그룹화
SELECT CUSTID, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
GROUP BY CUSTID;
--BOOKID가 5보다 큰 조건
SELECT CUSTID, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
WHERE BOOKID > 5
GROUP BY CUSTID;
--도서 수량이 2보다 큰 조건 HAVING은 맨 마지막
SELECT CUSTID, COUNT(*) AS 도서수량, SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
WHERE BOOKID > 5 
GROUP BY CUSTID
HAVING COUNT(*) >2;


select name,sum(saleprice) as "총 판매액"
from customer C, orders O
where c.custid = o.custid
group by c.name
order by c.name;


--Q. 고객의 이름과 고개이 주문한 도서의 이름을 구하시요.
select c.name, b.bookname
from customer C, orders O, book B
where c.custid = o.custid and b.bookid = o.bookid;
--박지성	축구의 역사
--박지성	축구아는 여자
--박지성	축구의 이해
--김연아	피겨 교본
--장미란	역도 단계별기술
--추신수	야구의 추억
--추신수	야구를 부탁해
--장미란	야구를 부탁해
--장미란	Olympic Champions
--김연아	Olympic Champions

--inner join 사용
select customer.name, book.bookname
from orders
inner join customer on orders.custid = customer.custid
INNER JOIN book on orders.bookid = book.bookid;

--q.가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시요
select customer.name, book.bookname
from orders
INNER join customer on orders.custid = customer.custid
INNER JOIN book on orders.bookid = book.bookid
where orders.saleprice >= 20000;

SELECT c.name, b.bookname
from book b, customer c, orders o
where c.custid = o.custid and o.bookid=b.bookid and b.price = 20000;

--join은 두개 이상의 테이블을 연결하여 관련된 데이트를 결합할 때 사용
select * from customer;
select * from orders;
--inner join
select customer.name, orders.saleprice
from customer
inner join orders on customer.custid=orders.custid;

--왼쪽 외부 조인 (Left Outer Join) : . 두 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
select customer.name, orders.saleprice
from customer
LEFT OUTER join orders on customer.custid=orders.custid;

--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
select customer.name, orders.saleprice
from customer
RIGHT OUTER join orders on customer.custid=orders.custid;

--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
--한쪽을 기준으로 생각해야할때를 고려해서 사용할지 생각
select customer.name, orders.saleprice
from customer
FULL OUTER join orders on customer.custid=orders.custid;

--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성
select customer.name, orders.saleprice
from customer
CROSS join orders ;

--q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오
--(2가지 방법, where, join)

select customer.name, orders.saleprice
from customer
FULL OUTER join orders on customer.custid=orders.custid;
--left outer join orders on customer.custid=orders.custid;

SELECT c.name, o.saleprice
from customer c, orders o
where c.custid = o.custid(+);

--부속질의
select * from customer;
select custid from orders;
--q.도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select name
from customer
where custid in (select custid from orders);

--q. '대한미디어'에서 출판한 도서를 구매한 고객의이름을 보이시오.
select name
from customer, book
where custid in ((select custid from orders)union(select publisher where '대한미디어'));

select name
from customer
inner join orders on orders.custid = customer.custid
WHERE book.publisher = '대한미디어';

--ex 계속 부속질의 들어갈수있다능
select name
from customer
where custid in (select custid from orders
where bookid in (select bookid from book
where publisher = '대한미디어'));

--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select publisher, bookname
from book 
where bookname in (price>avg(book.price));
--where avg(price)<price;
select avg(price)
from book;

--ex
select publisher, b1.bookname
from book b1
where b1.price > (select avg(b2.price)
from book b2
where b2.publisher = b1.publisher);

--내 방법은 전체 책값의 평균이상 책 
select publisher,bookname
from book 
where price > (select avg(price)from book);


--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
select name
from customer
where custid not in (select custid from orders);


--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
select name 고객이름, address 주소
from customer
where custid in (select custid from orders);


--데이터 타입

--숫자형 (Numeric Types)
--NUMBER: 가장 범용적인 숫자 데이터 타입. 정수, 실수, 고정 소수점, 부동 소수점 수를 저장
--NUMBER는 NUMBER(38,0)와 같은 의미로 해석, Precision 38은 자리수 Scale0은 소수점 이하 자릿수 
--NUMBER(10), NUMBER(8,2)-총8자리중 2자리만 소수점

--문자형 (Character Types)
--VARCHAR2(size): 가변 길이 문자열을 저장. size는 최대 문자 길이를 바이트, 혹은 글자수로 지정
--NVARCHAR2(size)의 사이즈를 지정할 때는 바이트 단위 대신 항상 문자 단위로 크기가 지정
--CHAR(size): 고정 길이 문자열을 저장. 지정된 길이보다 짧은 문자열이 입력되면 나머지는 공백으로 채워짐

--날짜 및 시간형 (Date and Time Types)
--DATE: 날짜와 시간을 저장. 데이터 타입은 년, 월, 일, 시, 분, 초를 포함
--TIMESTAMP: 날짜와 시간을 더 상세히 나노초 단위까지 저장
--DATE 타입은 날짜와 시간을 YYYY-MM-DD HH24:MI:SS 형식으로 저장합니다.
--예를 들어, 2024년 5월 20일 오후 3시 45분 30초는 2024-05-20 15:45:30으로 저장

--이진 데이터형 (Binary Data Types)
--BLOB: 대량의 이진 데이터를 저장. 이미지, 오디오 파일 등을 저장하는 데 적합

--대규모 객체형 (Large Object Types)
--CLOB: 대량의 문자 데이터를 저장
--NCLOB: 대량의 국가별 문자 집합 데이터를 저장

--문자 인코딩의 의미
--컴퓨터는 숫자로 이루어진 데이터를 처리. 인코딩을 통해 문자(예: 'A', '가', '?')를 
--숫자(코드 포인트)로 변환하여 컴퓨터가 이해하고 저장할 수 있게 한다.
--예를 들어, ASCII 인코딩에서는 대문자 'A'를 65로, 소문자 'a'를 97로 인코딩. 
--유니코드 인코딩에서는 'A'를 U+0041, 한글 '가'를 U+AC00, 이모티콘 '?'를 U+1F60A로 인코딩
--아스키는 7비트를 사용하여 총 128개의 문자를 표현하는 반면 유니코드는 최대 1,114,112개의 문자를 표현

--ASCII 인코딩:
--문자 'A' -> 65 (10진수) -> 01000001 (2진수)
--문자 'B' -> 66 (10진수) -> 01000010 (2진수)

--유니코드(UTF-8) 인코딩: 
--문자 'A' -> U+0041 -> 41 (16진수) -> 01000001 (2진수, ASCII와 동일)
--문자 '가' -> U+AC00 -> EC 95 80 (16진수) -> 11101100 10010101 10000000 (2진수)

--CLOB: CLOB은 일반적으로 데이터베이스의 기본 문자 집합(예: ASCII, LATIN1 등)을 사용하여 텍스트 데이터를 저장. 
--이 때문에 주로 영어와 같은 단일 바이트 문자로 이루어진 텍스트를 저장하는 데 사용.
--NCLOB: NCLOB은 유니코드(UTF-16)를 사용하여 텍스트 데이터를 저장. 따라서 다국어 지원이 필요할 때, \
--즉 다양한 언어로 구성된 텍스트 데이터를 저장할 때 적합. 다국어 문자가 포함된 데이터를 효율적으로 처리할 수 있다.

--VARCHAR2는 두가지 방식으로 길이를 정의: 바이트와 문자
--설정 확인 방법
select *
from v$nls_parameters
where parameter = 'NLS_LENGTH_SEMANTICS';

--제약조건 : 
--PRIMARY KEY : 각 행을 고유하게 식별하는 열(또는 열들의 조합). 중복되거나 NULL 값을 허용하지 않는다.
--FOREIGN KEY : 다른 테이블의 기본 키를 참조하는 열. 참조 무결성을 유지
--UNIQUE : 열에 중복된 값이 없어야 함을 지정. NULL값이 허용
--NOT NULL : 열에 NULL 값을 허용하지 않는다.
--CHECK : 열 값이 특정 조건을 만족해야 함을 지정 (예: age > 18)
--DEFAULT : 열에 명시적인 값이 제공되지 않을 경우 사용될 기본값을 지정

--author 테이블 생성
create table authors (
    id number primary key,
    first_name varchar2(50) not null,
    last_name varchar2(50) not null,
    nationality varchar2(50)
);

drop table authors;

--Q. newbook이라는 테이블을 생성하세요.

create table newbook (
    isdn number primary key,
    title varchar2(50) not null,
    author varchar2(50) not null,
    price number,
    publishing_date date
);
drop table newbook;

create table newbook (
    bookid number,
    isbn number(13),
    bookname varchar2(50) not null,
    author varchar2(50) not null,
    publisher varchar2(30) not null,
    price number default 10000 check(price>10000),
    published_date date,
    primary key(bookid)
);

insert into newbook values(1, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));

select *
from newbook;

--제약조건을 벗어나는 데이터는 입력 불가
insert into newbook values(3, 978123423422345567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));
--내부 항목 바꿀려면 데이터 없어야함
delete from newbook;
alter table newbook modify (isbn varchar2(50));

desc newbook;

--컬럼추가
alter table newbook add author_id varchar2(10);

--컬럼제거 기존 데이터가 있어도 상관없음
alter table newbook drop column author_id;

--on delete cascade옵션이 설정되어 있어, newcustomer테이블에서 어떤 고객의 레코드가 삭제되면,
--해당 고객의 모든 주문이 neworders테이블에서도 자동삭제

create table newcustomer(
custid number primary key,
name varchar2(40),
address varchar2(40),
phone varchar2(30));

create table neworders(
orderid number,
custid number not null,
bookid number not null,
saleprice number,
orderdate date,
primary key(orderid),
foreign key(custid) references newcustomer(custid) on delete cascade);
desc neworders;

insert into newcustomer values(1, 'rod', 'kang', '010-1234-1234');
insert into neworders values(10, 1, 100, 1000,  sysdate);
select * from newcustomer;
select * from neworders;
delete from newcustomer;


insert into newcustomer values(1, 'rod', 'kang', '010-1234-1234');
insert into neworders values(10, 1, 100, 1000,  sysdate);
delete from neworders;
select * from newcustomer;
select * from neworders;


--q.10개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 foreign key를 적용하여 한쪽 테이블의
--데이터를 삭제시 다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참조하고 있는 속성을 
--선택하여 데이터 삭제

--football_player:이름,나이, 성별, 키, 팀, 국가,  연봉, 작년 득점, 현재 어시스트, 부상여부
create table football_players(
player_id number primary key
first_name varchar2(50) not null,
last_name varchar2(50) not null,
age number,
gender char(1),
team varchar2(50),
nationality varchar2(50),
salary number(10),
pre_score number(3),
pre_assist number(3),
injure char(1)
);
drop table football_players;
--agency: 총


