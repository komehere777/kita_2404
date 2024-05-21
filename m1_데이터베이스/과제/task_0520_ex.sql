--tast1.10개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 foreign key를 적용하여 한쪽 테이블의
--데이터를 삭제시 다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참조하고 있는 속성을 
--선택하여 데이터 삭제
create table player(
id number PRIMARY KEY,
name varchar2(50) not null,
address varchar2(50),
phone varchar2(30),
registed_date date,
salary number ,
birthday date,
height number,
weight number,
nationality varchar2
)

create table playing_stats(
idx NUMBER,
id foreign
date
goal
assist
foul
shot_on_target
caution
dismissal
enermy_team
);

--ex
--drop table mart; 기존에 있을 수있는 테이블 삭제
--Task1_0520. 10개의 속성으로 구성되는 테이블 2개를 작성하세요. 단 FOREIGN KEY를 적용하여 한쪽 테이블의 데이터를 삭제 시 
--다른 테이블의 관련되는 데이터도 모두 삭제되도록 하세요. (모든 제약조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참조하고 있는 속성을 선택하여 데이터 삭제 
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- 방문 빈도
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- 주차여부
    , family number -- 가족 구성원 수
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '고길동', 32, '남', '010-1234-1234', '서울 강남', 5, 1500000, 'N', 3);
insert into mart values(2, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 5, 200000000, 'Y', 4);
insert into mart values(3, '이순신', 57, '남', '010-1592-1234', '경남 통영', 5, 270000, 'N', 1);
insert into mart values(4, '아이유', 30, '여', '010-0516-1234', '서울 서초', 5, 750000000, 'Y', 4);
insert into mart values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- 자주 찾는 매장
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- 발렛파킹 서비스 사용여부
    , rounge varchar2(20) -- vip 라운지 사용여부
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '손흥민', 31, '남', '010-7777-1234', '강원 춘천', 'LV', 900000000,'','');
insert into department values(2, '아이유', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(3, '박지성', 31, '남', '010-7775-1235', '강원 춘천', 'LV', 900000000,'','');
insert into department values(4, '박세리', 30, '여', '010-0516-1234', '서울 서초', 'GUCCI', 1500000000,'','');
insert into department values(5, '임영웅', 30, '남', '010-0517-1235', '서울 역삼', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;



--dml 연습
--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
select * from customer;

UPDATE customer 
SET address = "대한민국 서울"
where custid = 5;

UPDATE customer 
SET address = (select address from customer where name = '김연아')
where custid = 5;

--ex
UPDATE customer 
SET address = (select address from customer where name = '김연아')
where name = '박세리';

--원복
UPDATE customer 
SET address = '대한민국 대전'
where name = '박세리';
select * from customer;


--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
--이건 데이터 변경
update book
set bookname = replace(bookname, '야구', '농구');

select bookname, price
from book;

--ex, 조회할때만 바껴서 보여주는 것
select bookid, replace(bookname, '야구','농구') as bookname, publisher,price
from book;
select * from book;

--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
--group by 절에서 별칭이 아닌 표현식만 사용해야함.
select * from customer;

select substr(name,1,1) 성, count(*)
from customer
group by substr(name,1,1);

--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
alter table orders drop column order_finish;
alter table orders add order_finish date;
select * from orders;

update orders
set order_finish = orderdate + 10;

select order_finish as "주문 확정일자"
from orders;

--ex
select orderid, orderdate as 주문일, orderdate + 10 as 확정일자
from orders;

--마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
select orderid, orderdate, add_months(orderdate, 2)
from orders;


--Task6_0520.마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 
--고객번호, 도서번호를 모두 보이시오. 
--단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.

select orderid 주문번호, orderdate 주문일, custid 고객번호, bookid 도서번호
from orders
where orderdate = to_date('2020/07/07', 'YYYY-MM-DD') ;

--ex
select orderid, orderdate,to_char(orderdate, 'YYYY-mm-dd day'), custid, bookid
from orders
where orderdate = '2020-07-07';

select orderid, orderdate,to_char(orderdate, 'YYYY-mm-dd day'), custid, bookid
from orders
where orderdate = '20/07/07';

--where orderdate = to_date('24/07/20', 'yy/mm/dd')
--where orderdate = to_date('20/07/24', 'dd/mm/yy')

--Task7_0520. 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
--ex
select orderid, saleprice
from orders
where saleprice < (select avg(saleprice) from orders);

select orderid, o1.salepirce
from orders o1
where o1.saleprice <= (select avg(o2.saleprice)
from orders o2
where b2.publisher = b1.publisher);

select orderid, o1.saleprice
from orders o1
where o1.saleprice <= (select avg(o2.saleprice)
from orders o2);

--join 사용
--서브쿼리를 o2라는 별칭으로 지정, saleprice의 평균값을 avg_saleprice로 계산
select o1.orderid, o1.saleprice
from orders o1
join (select avg(saleprice) as avg_saleprice from orders) o2  --o2는 서브쿼리 내용
on o1.saleprice < o2.avg_saleprice;


--Task8_0520. 대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.
select sum(saleprice) as 총판매액
from orders
where custid in (select custid from customer where address like '%대한민국%'); 

select sum(saleprice) as 총판매액
from orders
where custid in (select custid from customer where address like '%대한민국%');

