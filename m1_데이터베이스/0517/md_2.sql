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

--�����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ����
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '_��%';

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

