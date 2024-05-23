--NVL() NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϴ� �Լ�
SELECT LAST_NAME, MANAGER_ID,
NVL(TO_CHAR(MANAGER_ID), 'CEO') AS REVISED_ID FROM employees;

--DECODE() IF���̳� CASE���� ���� ���� ��츦 ������ �� �ֵ��� �ϴ� �Լ�
--DECODE �Լ��� �ܼ��� ���ǿ� ����Ͽ� ���� ��ȯ�մϴ�. ������ DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--���⼭ expression�� �˻��� ���� ��Ÿ����, search�� result�� ���� ���ǰ� �ش� ������ ���� �� ��ȯ�� ��
--default�� ��� search ������ ������ �� ��ȯ�� �⺻ �� ���

SELECT LAST_NAME, DEPARTMENT_ID,
DECODE(DEPARTMENT_ID,
90, '�濵������',
60, '���α׷���',
100, '�λ��', '��Ÿ') �μ�
FROM EMPLOYEES;

--Q.EMPLOYEES ���̺��� COMMISSION_PCT�� NULL�� �ƴ� ���, 'A' NULL�ΰ�� 'N'�� ǥ���ϴ� ������ �ۼ�
SELECT COMMISSION_PCT AS COMMISSION,
    DECODE(COMMISSION_PCT, NULL, 'N','A') AS TRANSFORM
FROM EMPLOYEES
ORDER BY TRANSFORM DESC;

--case()
--decode() �Լ��� �����ϳ� decode() �Լ��� �ܼ��� ���� �񱳿� ���Ǵ� �ݸ�
--case() �Լ��� �پ��� �񱳿����ڷ� ������ ������ �� �ִ�.
--CASE ���� ���ǿ� ���� �ٸ� ���� ��ȯ�ϴ� �� ���Ǹ�, DECODE���� ������ ������ ǥ���� �� �ִ�. 
--������ CASE WHEN condition THEN result ... ELSE default END�̴�. 

SELECT LAST_NAME, DEPARTMENT_ID,
CASE WHEN DEPARTMENT_ID=90 THEN '�濵������'
    WHEN DEPARTMENT_ID=60 THEN '���α׷���'
    WHEN DEPARTMENT_ID=100 THEN '�λ��'
ELSE '��Ÿ'
END AS �Ҽ�
FROM EMPLOYEES;

--Q.EMPLOYEES ���̺��� SALARY�� 20000�̻��̸� 'A', 10000~20000�̸� ���̸� 'B'�� ���ϸ� 'C'�� ǥ���ϴ� ������ �ۼ��Ͻÿ�(CASE)
SELECT LAST_NAME, SALARY,
CASE
WHEN SALARY>=20000 THEN 'A'
WHEN SALARY>10000 AND SALARY < 20000 THEN 'B'
ELSE 'C'
END AS ���
FROM EMPLOYEES;

--INSERT
--���̺� �����͸� �Է��ϴ� ����� �� ���� ������ ������ �� ���� �� �Ǹ� �Էµȴ�.
--a. INSERT INTO ���̺�� (COLUMN_LIST) VALUES (COLUMN_LIST�� ���� VALUE_LIST);
--b. INSERT INTO ���̺�� VALUES (��ü COLUMN�� ���� VALUE_LIST);

--CONCATENATION: �޸� ��ſ� ����ϸ� ���ڿ��� ����Ǿ� ��µȴ�.
SELECT LAST_NAME, 'IS A ', JOB_ID FROM EMPLOYEES;
SELECT LAST_NAME || 'IS A ' || JOB_ID FROM EMPLOYEES;

--UNION
--UNION ������, INTESECT������ ,MINUS������, UNION ALL��ġ�°ͱ��� ����
--�ΰ��� �������� ����ؾ��Ѵ�. ������ Ÿ���� ��ġ���Ѿ� �Ѵ�.
SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000
UNION
SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000
MINUS
SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000
INTERSECT
SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE SALARY < 5000
UNION ALL
SELECT FIRST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES
WHERE HIRE_DATE < '05/01/01';

--CREATE VIEW ��ɾ�� ����Ŭ SQL���� ���̺��� Ư�� �κ��̳� ���ε� ����� ������ ��(view)�� ���� �� ���
--��� �����͸� ����ϰų� ������ ������ �ܼ�ȭ�ϸ�, ����ڿ��� �ʿ��� �����͸��� �����ִ� �� ����
--��� ���� ���̺� �����͸� �������� �ʰ�, ��� ������ ��ü�� ����

--���� �ֿ� Ư¡
--���� �ܼ�ȭ: ������ ������ ��� ���������ν� ����ڴ� ������ �������� �ݺ��ؼ� �ۼ��� �ʿ� ���� �����ϰ� �並 ������ �� �ִ�.
--������ �߻�ȭ: ��� �⺻ ���̺��� ������ ����� ����ڿ��� �ʿ��� �����͸��� ������ �� �־�, ������ �߻�ȭ�� ����.
--���� ��ȭ: �並 ����ϸ� Ư�� �����Ϳ� ���� ������ ������ �� ������, ����ڰ� �� �� �ִ� �������� ������ ������ �� �ִ�.
--������ ���Ἲ ����: �並 ����Ͽ� �����͸� �����ϴ���, �� ��������� �⺻ ���̺��� ������ ���Ἲ ��Ģ�� �������� �ʵ��� ������ �� �ִ�.

CREATE VIEW EMPLOYEE_DETAILS AS
SELECT EMPLOYEE_ID , LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES;

SELECT * FROM employee_details;

--Q.EMPLOYEES���̺��� SALARY�� 10000�� �̻��� �������� �����ϴ� �� SPECIAL_EMPLOYEE�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
CREATE VIEW SPECIAL_EMPLOYEE AS
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000;

SELECT * FROM special_employee WHERE SALARY> 20000;

CREATE VIEW SPECIAL_EMPLOYEE AS
SELECT *
FROM EMPLOYEES
WHERE SALARY >= 10000;

--Q. EMPLOYEES���̺��� �� �μ��� ���� ���� ������� �並 �����ϼ���.
CREATE VIEW DEPARTMENT_COUNT_EMPLOYEE AS
SELECT DEPARTMENT_ID, COUNT(*)AS ������
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT * FROM department_count_employee;

--Q.EMPLOYEES���̺��� �ټӱⰣ�� 10��� �̻��� ������ �����ϴ� �並 �����ϼ���.
CREATE VIEW LONG_MAN AS
SELECT *
FROM EMPLOYEES
WHERE TRUNC(SYSDATE - HIRE_DATE)>365* 20;

SELECT * FROM long_man;

SELECT LAST_NAME, TRUNC(SYSDATE-HIRE_DATE) AS �ټӱⰣ
FROM EMPLOYEES
WHERE ROUND(SYSDATE - HIRE_DATE)>365* 20
ORDER BY �ټӱⰣ DESC;
--ORDER BY�� ��Ī ��밡��

--TCL (Transaction Control Language)
--COMMIT: ���� Ʈ����� ������ ����� ��� ����(INSERT, UPDATE, DELETE ��)�� �����ͺ��̽��� ���������� ����.
--COMMIT ����� �����ϸ�, Ʈ������� �Ϸ�Ǹ�, �� ���Ŀ��� ���� ������ �ǵ��� �� ����.
--ROLLBACK: ���� Ʈ����� ������ ����� ������� ����ϰ�, �����ͺ��̽��� Ʈ������� �����ϱ� ���� ���·� �ǵ�����. 
--������ �߻��߰ų� �ٸ� ������ Ʈ������� ����ؾ� �� ��쿡 ���ȴ�.
--SAVEPOINT: Ʈ����� ������ �߰� üũ����Ʈ�� �����մϴ�. ������ �߻��� ���, ROLLBACK�� ����Ͽ� �ֱ��� SAVEPOINT���� �ǵ��� �� �ִ�.
--Ʈ������� ��Ʈ���ϴ� TCL(TRANSACTION CONTROL LANGUAGE)

--MEMBERS ���̺� ����
DROP TABLE MEMBERS;
CREATE TABLE MEMBERS(
    MEMBER_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(100),
    EMAIL VARCHAR2(100),
    JOIN_DATE DATE,
    STATUS VARCHAR2(20)
);

DESC MEMBERS;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');

SELECT * FROM MEMBERS;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

SELECT * FROM MEMBERS;

SAVEPOINT SP1;

INSERT INTO members (member_id, name, email, join_date, status) VALUES (7, '�ٺ� Brown', '��@example.com', SYSDATE, 'active');

ROLLBACK TO SP1;
COMMIT;

--Q. DEPARTMENT_ID ����ִ� ��� ä���ֱ�

--�μ��� �޿� ��Ȳ
--���̺����, �μ��� �޿��� �� �޿��� Ȯ�� �� �� ����.
--(�޿��� �� ��� �ּڰ� �ִ�, �� ������, �޿���ü����, ������ձ޿�, �μ���ձ޿�)
--table ����� �μ��� �޿��� �뷫������ ����
--����� ���̺� Ȯ��
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--�μ� ��� Ȯ��
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- �μ� ��� department_id : 10,20,30,40,50,60,70,80,90,100,110 �� �� ������(120~200��..)�� ���� null ���� ����.
--department_id �� null �� ����� ��� job_id �� �´� department_id �� �ο����ַ�����(������ ���Ἲ)
--1. department_id �� null ���� ��� ã��
select *
from employees
where department_id IS NULL;
--�Ѹ� �ۿ� ����. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id �� SA_REP �� department_id ã�� (������ �´� �μ� ã��)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP �� department_id �� 80

--3. ���� �� savepoint ����
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. ��������primary key �� employee_id �� ã�Ƽ� derpartment_id �� 80���� ����
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint�� ����
ROLLBACK null_to_80;
--commit;
--������

--X������ �� ������ ������
--�� �μ����� ������ ����̰� � �����ǵ��� �ְ� ������ ��� �Ǵ���
--ROLLUP�� ���������� ���� ����� ���� : ��� �� �μ� �� ������ ���� ���� ����
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, NVL(E.JOB_ID, 'TOTAL') JOB_ID , COUNT(*) ������
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY ROLLUP((E.DEPARTMENT_ID, d.department_name), E.JOB_ID)
ORDER BY e.department_id;

--JOB_ID�� ������� �� �޴��� �� �������� ������ ���
