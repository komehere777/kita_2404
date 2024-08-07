--TASK1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시요. 3가지 방법
SELECT * FROM BOOK
WHERE (PUBLISHER='굿스포츠') OR (PUBLISHER='대한미디어');

--TASK2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시요.
SELECT * FROM BOOK
WHERE NOT ((PUBLISHER='굿스포츠') OR (PUBLISHER='대한미디어'));


--TASK3_0517. 축구에 관한 도서중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT * FROM BOOK
WHERE PRICE >= 20000 AND BOOKNAME LIKE '%축구%';


--TASK4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.

SELECT SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
WHERE CUSTID = 2;

--TASK5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
--단, 두 권 이상 구매한 고객만 구하시오.

SELECT CUSTID, COUNT(*) AS 도서수량
FROM ORDERS
WHERE SALEPRICE > 8000
GROUP BY CUSTID
HAVING COUNT(*) >= 2;

--TASK6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.

SELECT CUSTOMER.NAME, CUSTOMER.CUSTID, ORDERS.saleprice
FROM customer
INNER JOIN orders
ON orders.custid = customer.custid;

SELECT CUSTOMER.NAME, ORDERS.saleprice
FROM customer
INNER JOIN orders
ON orders.custid = customer.custid;



--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT CUSTID, SUM(SALEPRICE) AS "총 판매액"
FROM ORDERS
GROUP BY CUSTID;