SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM IMPORTED_BOOK;
SELECT * FROM ORDERS;
SELECT BOOKID,PRICE FROM BOOK;
--�ߺ����� ���
SELECT DISTINCT PUBLISHER FROM BOOK;

--Q. ������ 10000�� �̻��� ������ �˻�
SELECT * FROM BOOK
WHERE PRICE >= 10000;

--Q.������ 10000�� �̻� 20000�� ������ ������ �˻��Ͻÿ�(2���� ���)
SELECT * FROM BOOK
WHERE PRICE >= 10000 AND PRICE <= 20000;

SELECT * FROM BOOK
WHERE PRICE BETWEEN 10000 AND 20000;

--TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�. 3���� ���
SELECT * FROM BOOK
WHERE (PUBLISHER='�½�����') OR (PUBLISHER='���ѹ̵��');

--TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� �ƴ� ������ �˻��Ͻÿ�.
SELECT * FROM BOOK
WHERE NOT ((PUBLISHER='�½�����') OR (PUBLISHER='���ѹ̵��'));

--LIKE�� ��Ȯ�� '�౸�� ����'�� ��ġ�ϴ� �ุ ����
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '�౸�� ����';

--'�౸'�� ���Ե� ���ǻ�
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '%�౸%';
-- %�� 0�� �̻��� ���� ����

--�����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ����
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '_��%';
-- _�� ��Ȯ�� 1���� ������ ����

--TASK3_0517. �౸�� ���� ������ ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT * FROM BOOK
WHERE PRICE >= 20000 AND BOOKNAME LIKE '%�౸%';

--ORDER BY: �⺻ �ø����� ����(default)
SELECT * FROM BOOK
ORDER BY BOOKNAME;

SELECT * FROM BOOK
ORDER BY BOOKID;

SELECT * FROM BOOK
ORDER BY PRICE;

--�������� ����
SELECT * FROM BOOK
ORDER BY BOOKNAME DESC;

SELECT * FROM BOOK
ORDER BY BOOKID DESC;

SELECT * FROM BOOK
ORDER BY BOOKID DESC;

--Q.������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
--���ϴ� ������� �迭
SELECT * FROM BOOK
ORDER BY PRICE, BOOKNAME; 


SELECT SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
WHERE CUSTID = 2;

--GROUP BY : �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴµ� ���. �̸� ���� ���� �Լ�(SUM, AVG, MAX, MIN, COUNT)�� �̿�, ���
SELECT SUM(SALEPRICE) AS TOTAL,
AVG(SALEPRICE) AS AVERAGE, 
MIN(SALEPRICE) AS MINIMUM,
MAX(SALEPRICE) AS MAXIMUM
FROM ORDERS;

--���Ǹž��� CUSTID �������� �׷�ȭ
SELECT CUSTID, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
GROUP BY CUSTID;
--BOOKID�� 5���� ū ����
SELECT CUSTID, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
WHERE BOOKID > 5
GROUP BY CUSTID;
--���� ������ 2���� ū ���� HAVING�� �� ������
SELECT CUSTID, COUNT(*) AS ��������, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
WHERE BOOKID > 5 
GROUP BY CUSTID
HAVING COUNT(*) >2;


select name,sum(saleprice) as "�� �Ǹž�"
from customer C, orders O
where c.custid = o.custid
group by c.name
order by c.name;


--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select c.name, b.bookname
from customer C, orders O, book B
where c.custid = o.custid and b.bookid = o.bookid;
--������	�౸�� ����
--������	�౸�ƴ� ����
--������	�౸�� ����
--�迬��	�ǰ� ����
--��̶�	���� �ܰ躰���
--�߽ż�	�߱��� �߾�
--�߽ż�	�߱��� ��Ź��
--��̶�	�߱��� ��Ź��
--��̶�	Olympic Champions
--�迬��	Olympic Champions

--inner join ���
select customer.name, book.bookname
from orders
inner join customer on orders.custid = customer.custid
INNER JOIN book on orders.bookid = book.bookid;

--q.������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�
select customer.name, book.bookname
from orders
INNER join customer on orders.custid = customer.custid
INNER JOIN book on orders.bookid = book.bookid
where orders.saleprice >= 20000;

SELECT c.name, b.bookname
from book b, customer c, orders o
where c.custid = o.custid and o.bookid=b.bookid and b.price = 20000;

--join�� �ΰ� �̻��� ���̺��� �����Ͽ� ���õ� ����Ʈ�� ������ �� ���
select * from customer;
select * from orders;
--inner join
select customer.name, orders.saleprice
from customer
inner join orders on customer.custid=orders.custid;

--���� �ܺ� ���� (Left Outer Join) : . �� ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
select customer.name, orders.saleprice
from customer
LEFT OUTER join orders on customer.custid=orders.custid;

--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
select customer.name, orders.saleprice
from customer
RIGHT OUTER join orders on customer.custid=orders.custid;

--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
--������ �������� �����ؾ��Ҷ��� ����ؼ� ������� ����
select customer.name, orders.saleprice
from customer
FULL OUTER join orders on customer.custid=orders.custid;

--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ����
select customer.name, orders.saleprice
from customer
CROSS join orders ;

--q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�
--(2���� ���, where, join)

select customer.name, orders.saleprice
from customer
FULL OUTER join orders on customer.custid=orders.custid;
--left outer join orders on customer.custid=orders.custid;

SELECT c.name, o.saleprice
from customer c, orders o
where c.custid = o.custid(+);

--�μ�����
select * from customer;
select custid from orders;
--q.������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
select name
from customer
where custid in (select custid from orders);

--q. '���ѹ̵��'���� ������ ������ ������ �����̸��� ���̽ÿ�.
select name
from customer, book
where custid in ((select custid from orders)union(select publisher where '���ѹ̵��'));

select name
from customer
inner join orders on orders.custid = customer.custid
WHERE book.publisher = '���ѹ̵��';

--ex ��� �μ����� �����ִٴ�
select name
from customer
where custid in (select custid from orders
where bookid in (select bookid from book
where publisher = '���ѹ̵��'));

--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
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

--�� ����� ��ü å���� ����̻� å 
select publisher,bookname
from book 
where price > (select avg(price)from book);


--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
select name
from customer
where custid not in (select custid from orders);


--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
select name ���̸�, address �ּ�
from customer
where custid in (select custid from orders);


--������ Ÿ��

--������ (Numeric Types)
--NUMBER: ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--NUMBER�� NUMBER(38,0)�� ���� �ǹ̷� �ؼ�, Precision 38�� �ڸ��� Scale0�� �Ҽ��� ���� �ڸ��� 
--NUMBER(10), NUMBER(8,2)-��8�ڸ��� 2�ڸ��� �Ҽ���

--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ, Ȥ�� ���ڼ��� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����

--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����
--DATE Ÿ���� ��¥�� �ð��� YYYY-MM-DD HH24:MI:SS �������� �����մϴ�.
--���� ���, 2024�� 5�� 20�� ���� 3�� 45�� 30�ʴ� 2024-05-20 15:45:30���� ����

--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����

--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����

--���� ���ڵ��� �ǹ�
--��ǻ�ʹ� ���ڷ� �̷���� �����͸� ó��. ���ڵ��� ���� ����(��: 'A', '��', '?')�� 
--����(�ڵ� ����Ʈ)�� ��ȯ�Ͽ� ��ǻ�Ͱ� �����ϰ� ������ �� �ְ� �Ѵ�.
--���� ���, ASCII ���ڵ������� �빮�� 'A'�� 65��, �ҹ��� 'a'�� 97�� ���ڵ�. 
--�����ڵ� ���ڵ������� 'A'�� U+0041, �ѱ� '��'�� U+AC00, �̸�Ƽ�� '?'�� U+1F60A�� ���ڵ�
--�ƽ�Ű�� 7��Ʈ�� ����Ͽ� �� 128���� ���ڸ� ǥ���ϴ� �ݸ� �����ڵ�� �ִ� 1,114,112���� ���ڸ� ǥ��

--ASCII ���ڵ�:
--���� 'A' -> 65 (10����) -> 01000001 (2����)
--���� 'B' -> 66 (10����) -> 01000010 (2����)

--�����ڵ�(UTF-8) ���ڵ�: 
--���� 'A' -> U+0041 -> 41 (16����) -> 01000001 (2����, ASCII�� ����)
--���� '��' -> U+AC00 -> EC 95 80 (16����) -> 11101100 10010101 10000000 (2����)

--CLOB: CLOB�� �Ϲ������� �����ͺ��̽��� �⺻ ���� ����(��: ASCII, LATIN1 ��)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. 
--�� ������ �ַ� ����� ���� ���� ����Ʈ ���ڷ� �̷���� �ؽ�Ʈ�� �����ϴ� �� ���.
--NCLOB: NCLOB�� �����ڵ�(UTF-16)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. ���� �ٱ��� ������ �ʿ��� ��, \
--�� �پ��� ���� ������ �ؽ�Ʈ �����͸� ������ �� ����. �ٱ��� ���ڰ� ���Ե� �����͸� ȿ�������� ó���� �� �ִ�.

--VARCHAR2�� �ΰ��� ������� ���̸� ����: ����Ʈ�� ����
--���� Ȯ�� ���
select *
from v$nls_parameters
where parameter = 'NLS_LENGTH_SEMANTICS';

--�������� : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�.
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEFAULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����

--author ���̺� ����
create table authors (
    id number primary key,
    first_name varchar2(50) not null,
    last_name varchar2(50) not null,
    nationality varchar2(50)
);

drop table authors;

--Q. newbook�̶�� ���̺��� �����ϼ���.

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

--���������� ����� �����ʹ� �Է� �Ұ�
insert into newbook values(3, 978123423422345567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));
--���� �׸� �ٲܷ��� ������ �������
delete from newbook;
alter table newbook modify (isbn varchar2(50));

desc newbook;

--�÷��߰�
alter table newbook add author_id varchar2(10);

--�÷����� ���� �����Ͱ� �־ �������
alter table newbook drop column author_id;

--on delete cascade�ɼ��� �����Ǿ� �־�, newcustomer���̺��� � ���� ���ڵ尡 �����Ǹ�,
--�ش� ���� ��� �ֹ��� neworders���̺����� �ڵ�����

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


--q.10���� �Ӽ����� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� foreign key�� �����Ͽ� ���� ���̺���
--�����͸� ������ �ٸ� ���̺��� ���õǴ� �����͵� ��� �����ǵ��� �ϼ���. (��� ���������� ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� 
--�����Ͽ� ������ ����

--football_player:�̸�,����, ����, Ű, ��, ����,  ����, �۳� ����, ���� ��ý�Ʈ, �λ󿩺�
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
--agency: ��


