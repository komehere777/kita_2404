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