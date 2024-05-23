--Task1_0523. 
--orders��� ���̺��� �����ϰ�, order_id, customer_id, order_date, amount, status��� �Ӽ��� �����ϼ���.
--�����͸� 5�� �Է��ϼ���.
--�Է��� ������ �� 2���� �����ϼ���.
--������ �����͸� ����ϱ� ���� �ѹ��� ����ϼ���.
--3���� ���ο� �����͸� �Է��ϰ�, �� �� ������ ������ �Է¸� ����� �� �������� Ŀ���ϼ���.

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
