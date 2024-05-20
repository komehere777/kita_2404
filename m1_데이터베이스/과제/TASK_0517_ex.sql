--TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�. 3���� ���
SELECT *
FROM BOOK
WHERE (PUBLISHER='�½�����') OR (PUBLISHER='���ѹ̵��');

--ex
select *
from book
where publisher in ('�½�����', '���ѹ̵��');

select *
from book
where publisher in '�½�����'
union
select *
from book
where publisher in '���ѹ̵��';



--TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� �ƴ� ������ �˻��Ͻÿ�.
SELECT * 
FROM BOOK
WHERE NOT ((PUBLISHER='�½�����') OR (PUBLISHER='���ѹ̵��'));

--ex
SELECT * 
FROM BOOK
WHERE publisher NOT in ('�½�����','���ѹ̵��');


--TASK3_0517. �౸�� ���� ������ ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT * 
FROM BOOK
WHERE PRICE >= 20000 AND BOOKNAME LIKE '%�౸%';


--TASK4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
-- AS ���� ����
SELECT SUM(SALEPRICE) AS "�� �Ǹž�" 
FROM ORDERS
WHERE CUSTID = 2;
--ex
select customer.name, orders.custid, sum(orders.saleprice) as "�� �Ǹž�"
from orders, customer
where orders.custid = 2 and orders.custid=customer.custid
group by customer.name, orders.custid;
--ex
select customer.name, orders.custid, sum(orders.saleprice) as "�� �Ǹž�"
from orders
inner join customer on orders.custid = customer.custid
where orders.custid = 2
group by customer.name, orders.custid;

--TASK4_0517. 2�� �迬�� ���� �ֹ��� ������ ������ �� �Ǹž��� ���Ͻÿ�.
select customer.name, orders.custid,count(orders.orderid) as ��������,  sum(orders.saleprice) as "�� �Ǹž�"
from orders
inner join customer on orders.custid = customer.custid
where orders.custid = 2
group by customer.name, orders.custid;

--TASK5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;
--having�� �� ������
--ex
SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE >= 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2
order by custid;


--TASK6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT CUSTOMER.NAME, CUSTOMER.CUSTID, ORDERS.saleprice
FROM customer
INNER JOIN orders
ON orders.custid = customer.custid;

SELECT CUSTOMER.NAME, ORDERS.saleprice
FROM customer
INNER JOIN orders
ON orders.custid = customer.custid
order by customer.name;

--ex
select name, saleprice
from customer, orders
where orders.custid = customer.custid;


--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT CUSTID, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
GROUP BY CUSTID
order by "�� �Ǹž�";

--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT CUSTID, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
GROUP BY CUSTID
order by custid