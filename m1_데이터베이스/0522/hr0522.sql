select * from employees;

SELECT * FROM COUNTRIES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
SELECT * FROM JOB_HISTORY;
SELECT * FROM JOBS;
SELECT * FROM LOCATIONS;
SELECT * FROM REGIONS;

--Q. ����� 120���� ����� ���, �̸�, ����(JOB_ID), ������(JOB_TITLE)�� ���
SELECT E.EMPLOYEE_ID ��� , E.FIRST_NAME �̸�, E.LAST_NAME ��, E.JOB_ID ����, J.JOB_TITLE ������
FROM EMPLOYEES E
INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE E.EMPLOYEE_ID = 120;

-- FIRST_NAME || ' ' || LAST_NAME AS �̸�: FIRST_NAME �� LAST_NAME�� �������� �����Ͽ� 
-- �ϳ��� ���ڿ��� ��ġ�� , �� ����� ��Ī�� '�̸�'

SELECT
EMPLOYEE_ID ���,
FIRST_NAME || ' ' || LAST_NAME AS �̸�,
J.JOB_ID ����,
J.JOB_TITLE ������
FROM EMPLOYEES E , JOBS J
WHERE E.EMPLOYEE_ID = 120
AND E.JOB_ID = J.JOB_ID;

--Q. 2005�� ��ݱ⿡ �Ի��� ������� �̸�(FULL NAME)�� �Ի��ϸ� ���

SELECT FIRST_NAME || ' ' || LAST_NAME AS "�̸�", HIRE_DATE "�Ի���"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YY/MM') BETWEEN '05/01' AND '05/06';

--�� ���ϵ� ī�尡 �ƴ� ���ڷ� ����ϰ� ������ ESCAPE �ɼ��� ���

SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%\_A%';
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%\_A%'; ESCAPE '\';
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%#_A%'; ESCAPE '#';

-- IN : OR ��� ���

SELECT * FROM EMPLOYEES WHERE MANAGER_ID =101 OR MANAGER_ID=102 OR MANAGER_ID=103;
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IN (101, 102, 103);

--Q. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���

SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');

--IS NULL / IS NOT NULL
--NULL �������� Ȯ���� ��� == �� �����ڸ� ������� �ʰ� IS NULL�� ����Ѵ�

SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

--ORDER BY
--ORDER BY �÷��� [ASC | DESC]

SELECT * FROM EMPLOYEES ORDER BY SALARY ASC;
SELECT * FROM EMPLOYEES ORDER BY SALARY DESC;
SELECT * FROM EMPLOYEES ORDER BY SALARY ASC , LAST_NAME DESC;

--DUAL ���̺�
-- MOD ������
SELECT * FROM EMPLOYEES WHERE MOD( EMPLOYEE_ID, 2 ) = 1;
SELECT MOD( 10, 3) FROM DUAL;

--ROUND()
SELECT ROUND( 355.95555 ) FROM DUAL;
SELECT ROUND( 355.95555, 2 ) FROM DUAL;
SELECT ROUND( 355.95555, -2 ) FROM DUAL;

--TRUNC() �����Լ�. ������ �ڸ��� ���ϸ� ���� ��� ����
SELECT TRUNC( 45.5555, 1 ) FROM DUAL;

-- CEIL() ������ �ø�, �ڸ� ���� ����
SELECT CEIL( 45.111 ) FROM DUAL;

--Q. HR EMPLOYEES ���̺��� �̸�, �޿�, 10% �λ�� �޿��� ����ϼ���.
SELECT LAST_NAME �̸� , SALARY �޿�, SALARY * 1.1 �λ�ȱ޿�
FROM EMPLOYEES;

--Q. EMPLOYEE_ID�� Ȧ���� ������ EMPLOYEE_ID �� LAST_NAME�� ����ϼ���

SELECT EMPLOYEE_ID �����ȣ , LAST_NAME �̸�
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MOD(EMPLOYEE_ID, 2)=1);
--
SELECT EMPLOYEE_ID �����ȣ , LAST_NAME �̸�
FROM EMPLOYEES
WHERE MOD( EMPLOYEE_ID, 2 ) =1;

--Q. EMPLOYEES ���̺��� COMMISSION_PCT �� NULL�� ������ ����ϼ���

SELECT COUNT(*) FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;

--Q. EMPLOYEES ���̺��� DEPARTMENT_ID �� ���� ������ �����Ͽ� POSITION�� '����'���� ����ϼ��� (POSITION ���� �߰�)
SELECT EMPLOYEE_ID, FIRST_NAME || ' ' || LAST_NAME FULL_NAME, '����' POSITION
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

--Q. MANAGER_ID �� 101���� 103�� ����� ���

SELECT * FROM EMPLOYEES WHERE MANAGER_ID IN (101, 102, 103);

--��¥ ����
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE + 1 FROM DUAL;
SELECT SYSDATE - 1 FROM DUAL;

SELECT * FROM EMPLOYEES;
--�ٹ��� ��¥ ���
SELECT LAST_NAME, SYSDATE, HIRE_DATE, ROUND(SYSDATE-HIRE_DATE) �ٹ��Ⱓ FROM EMPLOYEES;

--ADD_MONTH()                Ư�� ���� ���� ���� ��¥�� ���ϱ�
SELECT LAST_NAME, HIRE_DATE, ADD_MONTHS( HIRE_DATE, 6 ) REVISED_DATE FROM EMPLOYEES;

--LAST_DAY()               �ش� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
SELECT LAST_NAME, HIRE_DATE, LAST_dAY( HIRE_DATE ) FROM EMPLOYEES;
SELECT LAST_NAME, HIRE_DATE, LAST_dAY(ADD_MONTHS(HIRE_DATE, 1)) FROM EMPLOYEES;

--NEXT_DAT()                �ش� ��¥�� �������� ������ ���� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ
--�� ~ ��, 1 ~ 7 �� ǥ������
SELECT HIRE_DATE, NEXT_DAY( HIRE_DATE, '��' ) FROM EMPLOYEES;
SELECT HIRE_DATE, NEXT_DAY( HIRE_DATE, 2 ) FROM EMPLOYEES;

--MONTHS_BETWEEN()         ��¥�� ��¥ ������ �������� ���Ѵ�
SELECT HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) FROM EMPLOYEES;

--�� ��ȯ �Լ� : TO_DATE()                   ���ڿ��� ��¥��
--'2023-01-01'�̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ
SELECT TO_DATE('2024-05-22','YYYY-MM-DD') FROM DUAL;

-- TO CHAR(��¥)                            ��¥�� ���ڷ� ��ȯ
SELECT TO_CHAR( SYSDATE, 'YY/MM/DD HH24:MI DAY' ) FROM DUAL;
SELECT TO_CHAR( SYSDATE, 'yy/mm/dd' ) FROM DUAL;


--����
--YYYY       �� �ڸ� ����
--YY      �� �ڸ� ����
--YEAR      ���� ���� ǥ��
--MM      ���� ���ڷ�
--MON      ���� ���ĺ�����
--DD      ���� ���ڷ�
--DAY      ���� ǥ��
--DY      ���� ��� ǥ��
--D      ���� ���� ǥ��
--AM �Ǵ� PM   ���� ����
--HH �Ǵ� HH12   12�ð�
--HH24      24�ð�
--MI      ��
--SS      ��

--Q. ���� ��¥ (SYSDATE)�� 'YYYY/MM/DD' ������ ���ڿ��� ��ȯ �ϼ���

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') "��¥" FROM DUAL;

--Q. '01-01-2023' �̶�� ���ڿ��� ��¥ Ÿ������ ��ȯ�Ͻÿ�

SELECT TO_DATE('01-01-2023', 'MM-DD-YYYY') FROM DUAL;

--Q. ���� ��¥�� �ð�(SYSDATE)�� 'YYYY-MM-DD HH24:MI:SS' ������ ���ڿ��� ��ȯ�ϼ���
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--Q. '2023-01-01 15:30:00' �̶�� ���ڿ��� ��¥ �� �ð� Ÿ������ ��ȯ�ϼ���

SELECT TO_DATE('2023-01-01 15:30:00', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

--to_char( ���� )   ���ڸ� ���ڷ� ��ȯ
--9      �� �ڸ��� ���� ǥ��      ( 1111, ��99999�� )      1111   
--0      �� �κ��� 0���� ǥ��      ( 1111, ��099999�� )      001111
--$      �޷� ��ȣ�� �տ� ǥ��      ( 1111, ��$99999�� )      $1111
--.      �Ҽ����� ǥ��         ( 1111, ��99999.99�� )      1111.00
--,      Ư�� ��ġ�� , ǥ��      ( 1111, ��99,999�� )      1,111
--MI      �����ʿ� - ��ȣ ǥ��      ( 1111, ��99999MI�� )      1111-
--PR      �������� <>�� ǥ��      ( -1111, ��99999PR�� )      <1111>
--EEEE      ������ ǥ��         ( 1111, ��99.99EEEE�� )      1.11E+03
--V      10�� n�� ���Ѱ����� ǥ��   ( 1111, ��999V99�� )      111100
--B      ������ 0���� ǥ��      ( 1111, ��B9999.99�� )      1111.00
--L      ������ȭ         ( 1111, ��L9999�� )

SELECT SALARY, TO_CHAR( SALARY, '0999999' ) FROM EMPLOYEES;
SELECT SALARY, TO_CHAR( -SALARY, '999999PR' ) FROM EMPLOYEES;
--1111 -> 1.11E+03
SELECT TO_CHAR(-11111, '9.999EEEE' ) FROM DUAL;
SELECT TO_CHAR(-1111111, '9999999MI' ) FROM DUAL;

--WIDTH_BUCKET()                       ������, �ּҰ�, �ִ밪 , BUCKER ����
SELECT WIDTH_BUCKET( 92, 0, 100, 10 ) FROM DUAL;
SELECT WIDTH_BUCKET( 100, 0, 100, 10 ) FROM DUAL;

--q. employees ���̺��� salary�� 5�� ������� ǥ���ϼ���
select salary, width_bucket(salary, 2100, 24001, 5) as grade
from employees;

--�����Լ� character funcrion
--upper() �빮�� ����
select upper('Hello World') from dual;
--lower()
select lower('Hello World') from dual;

--q. last name�� seo�� ������ last_name�� salary�� ���ϼ���(Seo, SEO, seo) ��� ����)
select last_name, salary
from employees
where lower(last_name) = 'seo';

--initcap() ù���ڸ� �빮��
select job_id, initcap(job_id) from employees;

--length() ���ڿ��� ����
select job_id, length(job_id) from employees;

--instr() ���ڿ�, ã�� ����, ã�� ��ġ, ã�� ���� �� ���°
select instr('Hello World', 'o', 3,2) from dual; --sql�� �ε��� 1���� ����
select instr('Hello World', 'l', 1,2) from dual; --sql�� �ε��� 1���� ����
select instr('Hello World', 'l', 1,3) from dual; -- 10
select instr('Hello World', 'o', 1,1) from dual; --5

--substr() ���ڿ�, ������ġ, ����
select substr('Hello World', 3, 3) from dual; --llo
select substr('Hello World', 9, 3) from dual; --rld
select substr('Hello World', -3, 3) from dual; --rld
select substr('Hello World', 5, 3) from dual; --o w

--lpad() ������ ������ ���ʿ� ���ڸ� ä���.
select lpad('Hello World', 20, '#') from dual;

--rpad() ���� ������ �����ʿ� ���ڸ� ä���.
select rpad('Hello World', 20, '#') from dual;

--ltrim()
select ltrim('aaaHello Worldaaa', 'a') from dual;
select ltrim('   Hello World   ') from dual;

--rtrim()
select rtrim('aaaHello Worldaaa', 'a') from dual;
select rtrim('   Hello World   ') from dual;

select last_name from employees;
select last_name as �̸�, ltrim(last_name, 'A') as ��ȯ
from employees;

--trim
select trim('   Hello World   ') from dual;
--�յ��� Ư�� ���� ����
select last_name, trim('A' from last_name) from employees;

--nvl() null�� 0�Ǵ� �ٸ������� ��ȯ�ϴ� �Լ�
select last_name, manager_id,