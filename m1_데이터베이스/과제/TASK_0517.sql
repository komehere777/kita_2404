--TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� ������ �˻��Ͻÿ�. 3���� ���
SELECT * FROM BOOK
WHERE (PUBLISHER='�½�����') OR (PUBLISHER='���ѹ̵��');

--TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��'�� �ƴ� ������ �˻��Ͻÿ�.
SELECT * FROM BOOK
WHERE NOT ((PUBLISHER='�½�����') OR (PUBLISHER='���ѹ̵��'));


--TASK3_0517. �౸�� ���� ������ ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT * FROM BOOK
WHERE PRICE >= 20000 AND BOOKNAME LIKE '%�౸%';


--TASK4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.

SELECT SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
WHERE CUSTID = 2;

--TASK5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
--��, �� �� �̻� ������ ���� ���Ͻÿ�.

SELECT CUSTID, COUNT(*) AS ��������
FROM ORDERS
WHERE SALEPRICE > 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;

--TASK6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.

SELECT CUSTOMER.NAME, CUSTOMER.CUSTID, ORDERS.saleprice
FROM customer
INNER JOIN orders
ON orders.custid = customer.custid;

SELECT CUSTOMER.NAME, ORDERS.saleprice
FROM customer
INNER JOIN orders
ON orders.custid = customer.custid;



--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT CUSTID, SUM(SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
GROUP BY CUSTID;