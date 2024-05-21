--tast1.10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� foreign key�� �����Ͽ� ���� ���̺���
--�����͸� ������ �ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ���. (��� ���������� ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� 
--�����Ͽ� ������ ����
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
--drop table mart; ������ ���� ���ִ� ���̺� ����
--Task1_0520. 10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� FOREIGN KEY�� �����Ͽ� ���� ���̺��� �����͸� ���� �� 
--�ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ���. (��� ���������� ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� ������ ���� 
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- �湮 ��
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- ��������
    , family number -- ���� ������ ��
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '��浿', 32, '��', '010-1234-1234', '���� ����', 5, 1500000, 'N', 3);
insert into mart values(2, '�����', 31, '��', '010-7777-1234', '���� ��õ', 5, 200000000, 'Y', 4);
insert into mart values(3, '�̼���', 57, '��', '010-1592-1234', '�泲 �뿵', 5, 270000, 'N', 1);
insert into mart values(4, '������', 30, '��', '010-0516-1234', '���� ����', 5, 750000000, 'Y', 4);
insert into mart values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- ���� ã�� ����
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- �߷���ŷ ���� ��뿩��
    , rounge varchar2(20) -- vip ����� ��뿩��
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '�����', 31, '��', '010-7777-1234', '���� ��õ', 'LV', 900000000,'','');
insert into department values(2, '������', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(3, '������', 31, '��', '010-7775-1235', '���� ��õ', 'LV', 900000000,'','');
insert into department values(4, '�ڼ���', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;



--dml ����
--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
select * from customer;

UPDATE customer 
SET address = "���ѹα� ����"
where custid = 5;

UPDATE customer 
SET address = (select address from customer where name = '�迬��')
where custid = 5;

--ex
UPDATE customer 
SET address = (select address from customer where name = '�迬��')
where name = '�ڼ���';

--����
UPDATE customer 
SET address = '���ѹα� ����'
where name = '�ڼ���';
select * from customer;


--Task3_0520.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
--�̰� ������ ����
update book
set bookname = replace(bookname, '�߱�', '��');

select bookname, price
from book;

--ex, ��ȸ�Ҷ��� �ٲ��� �����ִ� ��
select bookid, replace(bookname, '�߱�','��') as bookname, publisher,price
from book;
select * from book;

--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
--group by ������ ��Ī�� �ƴ� ǥ���ĸ� ����ؾ���.
select * from customer;

select substr(name,1,1) ��, count(*)
from customer
group by substr(name,1,1);

--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
alter table orders drop column order_finish;
alter table orders add order_finish date;
select * from orders;

update orders
set order_finish = orderdate + 10;

select order_finish as "�ֹ� Ȯ������"
from orders;

--ex
select orderid, orderdate as �ֹ���, orderdate + 10 as Ȯ������
from orders;

--���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
select orderid, orderdate, add_months(orderdate, 2)
from orders;


--Task6_0520.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, 
--����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.

select orderid �ֹ���ȣ, orderdate �ֹ���, custid ����ȣ, bookid ������ȣ
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

--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
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

--join ���
--���������� o2��� ��Ī���� ����, saleprice�� ��հ��� avg_saleprice�� ���
select o1.orderid, o1.saleprice
from orders o1
join (select avg(saleprice) as avg_saleprice from orders) o2  --o2�� �������� ����
on o1.saleprice < o2.avg_saleprice;


--Task8_0520. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
select sum(saleprice) as ���Ǹž�
from orders
where custid in (select custid from customer where address like '%���ѹα�%'); 

select sum(saleprice) as ���Ǹž�
from orders
where custid in (select custid from customer where address like '%���ѹα�%');

