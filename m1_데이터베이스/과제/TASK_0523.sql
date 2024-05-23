--Task1_0523. 
--orders라는 테이블을 생성하고, order_id, customer_id, order_date, amount, status라는 속성을 설정하세요.
--데이터를 5개 입력하세요.
--입력한 데이터 중 2개를 수정하세요.
--수정한 데이터를 취소하기 위해 롤백을 사용하세요.
--3개의 새로운 데이터를 입력하고, 그 중 마지막 데이터 입력만 취소한 후 나머지를 커밋하세요.

DROP TABLE ORDERS;

CREATE TABLE ORDERS(
    ORDER_ID NUMBER PRIMARY KEY,
    CUSTOMER_ID VARCHAR2(30),
    ORDER_DATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(30)
);

DESC ORDERS;

INSERT INTO ORDERS VALUES (1, 'ALICE', SYSDATE, 1, 'ON_GOING');
INSERT INTO ORDERS VALUES (2, 'BOB', SYSDATE, 2, 'ON_GOING');
INSERT INTO ORDERS VALUES (3, 'CHALES', SYSDATE, 1, 'ON_GOING');
INSERT INTO ORDERS VALUES (4, 'DUB', SYSDATE, 3, 'ON_GOING');
INSERT INTO ORDERS VALUES (5, 'ELLIE', SYSDATE, 2, 'ON_GOING');

SELECT *
FROM ORDERS;

DELETE ORDERS;

UPDATE ORDERS
SET amount = 1
WHERE customer_id = 'BOB';

UPDATE ORDERS
SET amount = 2
WHERE customer_id = 'DUB';

SAVEPOINT SP1;

INSERT INTO ORDERS VALUES (6, 'FAL', SYSDATE, 1, 'ON_GOING');
INSERT INTO ORDERS VALUES (7, 'GEOGE', SYSDATE, 2, 'ON_GOING');
INSERT INTO ORDERS VALUES (8, 'HILL', SYSDATE, 1, 'ON_GOING');
