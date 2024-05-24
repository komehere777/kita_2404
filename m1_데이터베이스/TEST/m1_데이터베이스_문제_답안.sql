������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 24.05.24
- ���� : �輺��
- ���� :

�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.
--Q1. EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
SELECT FIRST_NAME || ' ' || LAST_NAME �̸�, SALARY, SALARY * 1.1 REVISED_SALARY
FROM EMPLOYEES;
    
--Q2. EMPLOYEES ���̺��� 2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
SELECT FIRST_NAME || ' ' || LAST_NAME �̸�, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YY/MM') BETWEEN '05/01' AND '05/06';

--Q3. EMPLOYEES ���̺��� ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
SELECT FIRST_NAME || ' ' || LAST_NAME �̸�, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. EMPLOYEES ���̺��� manager_id �� 101���� 103�� ����� ���
SELECT FIRST_NAME || ' ' || LAST_NAME �̸�, MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN (101, 102, 103);

--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6),2) AS REVISED_DATE
FROM EMPLOYEES;

--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/30) AS W_MONTH
FROM EMPLOYEES
ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/365) AS W_YEAR
FROM EMPLOYEES
ORDER BY W_YEAR DESC;

--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MOD(EMPLOYEE_ID,2) =1);

--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
SELECT EMPLOYEE_ID, LAST_NAME, TO_CHAR(SALARY/12, '99999.99')
FROM EMPLOYEES;

--Q10. employees ���̺��� salary�� 10000�� �̻��� �������� �����ϴ� �� special_employee�� �����ϴ� SQL ��ɹ��� �ۼ��Ͻÿ�.
CREATE  VIEW SPECIAL_EMPLOYEE AS
SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000;


--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
SELECT COUNT(*) AS NULL����
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, '����' POSITION
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J ON e.job_id = J.JOB_ID
WHERE EMPLOYEE_ID = 120;

--Q14. HR EMPLOYEES ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
SELECT FIRST_NAME || ' ' || LAST_NAME NAME
FROM EMPLOYEES;

--Q15. HR EMPLOYEES ���̺��� �ټӱⰣ�� 10�� �̻��� ������ �����ϴ� �並 �����ϼ���.
CREATE VIEW GOINMOOL AS
SELECT *
FROM EMPLOYEES
WHERE TRUNC(SYSDATE - HIRE_DATE)>365* 10;

--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
SELECT JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE '%\_A%' ESCAPE '\';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
SELECT SALARY, LAST_NAME
FROM EMPLOYEES
ORDER BY SALARY, LAST_NAME;
   
--Q18. Seo��� ����� �μ����� ����ϼ���.
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON e.department_id = d.department_id
WHERE e.last_name = 'Seo';

--Q19. JOB ID �� ������� �� �޴��� �� �������� ������ ����� ���ϼ���.

SELECT JOB_ID, 
       TRUNC((SYSDATE - hire_date) / 365) AS ����, 
       AVG(salary) AS ��տ���
FROM 
GROUP BY JOB_ID, TRUNC((SYSDATE - hire_date) / 365)
ORDER BY JOB_ID, ����;


--Q20. HR EMPLOYEES ���̺��� salary�� 20000 �̻��̸� 'a', 10000�� 20000 �̸� ���̸� 'b', �� ���ϸ� 'c'�� ǥ���ϴ� ������ 
--�ۼ��Ͻÿ�.(case)
SELECT SALARY,
CASE WHEN SALARY >= 20000 THEN 'A'
    WHEN SALARY < 20000 AND SALARY > 10000 THEN 'B'
ELSE 'C'
END AS ����
FROM EMPLOYEES;


--Q21. �б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.(20��)
DROP TABLE STUDENT;
DROP TABLE PROFESSOR;
DROP TABLE DEPARTMENT;
DROP TABLE GRADE;
DROP TABLE SUBJECT;
 
CREATE TABLE STUDENT (
    STUDENTNUMBER NUMBER PRIMARY KEY,
    DepartmentID NUMBER,
    name VARCHAR2(20),
    birth DATE,
    SX VARCHAR2(20),
    phone VARCHAR2(20) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID)
);

CREATE TABLE Department (
    DepartmentID NUMBER PRIMARY KEY,
    DepartmentName VARCHAR2(100) NOT NULL,
    GraduationCredits NUMBER
);

CREATE TABLE Professor (
    ProfessorID NUMBER PRIMARY KEY,
    ProfessorName VARCHAR2(100) NOT NULL,
    DepartmentID NUMBER,
    Salary NUMBER,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

CREATE TABLE GRADE (
    GRADEINDEX NUMBER PRIMARY KEY,
    STUDENTNUMBER NUMBER,
    SUBJECTID NUMBER,
    GRADE NUMBER,
    FOREIGN KEY (STUDENTNUMBER) REFERENCES STUDENT(STUDENTNUMBER),
    FOREIGN KEY (SUBJECTID) REFERENCES SUBJECT(SUBJECTID)
);  

CREATE TABLE SUBJECT (
    SUBJECTID NUMBER PRIMARY KEY,
    SUBJECTNAME VARCHAR2(50),
    SUBSCORE NUMBER,
    PROFESSORID NUMBER,
    DEPARTMENTID NUMBER,
    FOREIGN KEY (PROFESSORID) REFERENCES PROFESSOR(ProfessorID),
    FOREIGN KEY (DEPARTMENTID) REFERENCES DEPARTMENT(DepartmentID)
);

INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117201, 1, '������', '1996-06-13', '��', '010-7777-1234');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117202, 1, '������', '1997-08-21', '��', '010-8888-5678');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117203, 1, '�̹�ȣ', '1995-03-12', '��', '010-9999-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117204, 1, '������', '1998-12-25', '��', '010-6666-8765');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117205, 1, '������', '1996-09-07', '��', '010-5555-2345');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117206, 1, 'ȫ�浿', '1997-04-11', '��', '010-4444-1111');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117207, 1, '�̿���', '1996-05-22', '��', '010-3333-2222');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117208, 1, '��ö��', '1995-06-17', '��', '010-2222-3333');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117209, 1, '�ڹ���', '1998-07-23', '��', '010-1111-4444');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117210, 1, '�ֵ���', '1996-08-14', '��', '010-1234-5678');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117211, 1, '������', '1997-09-05', '��', '010-8765-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117212, 1, '������', '1995-10-15', '��', '010-9876-5432');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117213, 1, '������', '1998-11-25', '��', '010-7654-3210');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117214, 1, '����ö', '1996-12-19', '��', '010-6543-2109');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117215, 1, '���̿�', '1997-01-29', '��', '010-5432-1098');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117216, 2, '������', '1995-02-18', '��', '010-4321-0987');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117217, 2, '����ȣ', '1996-03-27', '��', '010-3210-9876');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117218, 2, '������', '1997-04-14', '��', '010-2109-8765');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117219, 2, '������', '1995-05-09', '��', '010-1098-7654');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117220, 2, '�ڼ�ȣ', '1996-06-13', '��', '010-0987-6543');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117221, 2, '������', '1997-07-22', '��', '010-9876-5432');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117222, 2, '������', '1996-08-15', '��', '010-5678-1234');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117223, 2, '���ϴ�', '1997-09-10', '��', '010-8765-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117224, 2, '�ڼ���', '1998-10-20', '��', '010-3456-7890');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117225, 2, '������', '1995-11-11', '��', '010-2345-6789');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117226, 2, '�ּ���', '1996-12-22', '��', '010-1234-5678');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117227, 2, '�ѿ���', '1997-01-30', '��', '010-8765-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117228, 2, '������', '1998-03-15', '��', '010-5678-9101');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117229, 2, '����ȣ', '1995-05-20', '��', '010-2345-6780');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117230, 2, '�����', '1996-07-25', '��', '010-0987-6543');
SELECT * FROM STUDENT;

--
INSERT INTO DEPARTMENT (DepartmentID, DepartmentName, GraduationCredits) VALUES 
(1, '������а�', 130);
INSERT INTO DEPARTMENT (DepartmentID, DepartmentName, GraduationCredits) VALUES 
(2, '��ǻ�Ͱ��а�', 130);
SELECT * FROM DEPARTMENT;

--
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(1, '������', 1, 5000);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(2, '��μ�', 2, 5200);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(3, '������', 1, 4800);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(4, '�ֿ���', 2, 5100);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(5, '�̵���', 1, 5300);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(6, '������', 2, 4700);
SELECT * FROM PROFESSOR;

--
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(1,'����������', 3, 1, 1);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(2,'������', 3, 2, 1);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(3,'���̹���', 3, 3, 1);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(4,'���̽�', 3, 4, 2);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(5,'�����ͺ��̽�', 3, 5, 2);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(6,'�ΰ�����', 3, 6, 2);
SELECT * FROM SUBJECT;

INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(1, 202117201, 1, 3.6); 
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(2, 202117201, 2, 4.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(3, 202117201, 3, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(4, 202117202, 1, 3.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(5, 202117202, 2, 4.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(6, 202117202, 3, 2.3);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(7, 202117203, 1, 3.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(8, 202117203, 2, 2.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(9, 202117203, 3, 4.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(10, 202117204, 1, 4.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(11, 202117204, 2, 3.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(12, 202117204, 3, 2.6);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(13, 202117205, 1, 2.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(14, 202117205, 2, 2.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(15, 202117205, 3, 3.6);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(16, 202117206, 1, 3.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(17, 202117206, 2, 3.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(18, 202117206, 3, 4.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(19, 202117207, 1, 4.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(20, 202117207, 2, 4.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(21, 202117207, 3, 3.6);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(22, 202117208, 1, 3.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(23, 202117208, 2, 3.6);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(24, 202117208, 3, 3.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(25, 202117209, 1, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(26, 202117209, 2, 2.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(27, 202117209, 3, 2.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(28, 202117210, 1, 3.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(29, 202117210, 2, 2.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(30, 202117210, 3, 4.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(31, 202117211, 1, 3.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(32, 202117211, 2, 2.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(33, 202117211, 3, 3.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(34, 202117212, 1, 3.3);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(35, 202117212, 2, 4.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(36, 202117212, 3, 2.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(37, 202117213, 1, 3.9);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(38, 202117213, 2, 2.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(39, 202117213, 3, 3.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(40, 202117214, 1, 3.6);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(41, 202117214, 2, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(42, 202117214, 3, 4.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(43, 202117215, 1, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(44, 202117215, 2, 2.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(45, 202117215, 3, 3.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(46, 202117216, 4, 2.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(47, 202117216, 5, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(48, 202117216, 6, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(49, 202117217, 4, 2.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(50, 202117217, 5, 3.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(51, 202117217, 6, 4.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(52, 202117218, 4, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(53, 202117218, 5, 3.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(54, 202117218, 6, 4.3);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(55, 202117219, 4, 3.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(56, 202117219, 5, 3.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(57, 202117219, 6, 4.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(58, 202117220, 4, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(59, 202117220, 5, 2.9);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(60, 202117220, 6, 2.3);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(61, 202117221, 4, 4.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(62, 202117221, 5, 3.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(63, 202117221, 6, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(64, 202117222, 4, 2.3);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(65, 202117222, 5, 2.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(66, 202117222, 6, 3.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(67, 202117223, 4, 3.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(68, 202117223, 5, 3.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(69, 202117223, 6, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(70, 202117224, 4, 3.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(71, 202117224, 5, 2.2);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(72, 202117224, 6, 3.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(73, 202117225, 4, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(74, 202117225, 5, 4.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(75, 202117225, 6, 2.9);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(76, 202117226, 4, 2.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(77, 202117226, 5, 2.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(78, 202117226, 6, 3.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(79, 202117227, 4, 2.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(80, 202117227, 5, 3.7);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(81, 202117227, 6, 2.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(82, 202117228, 4, 3.5);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(83, 202117228, 5, 3.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(84, 202117228, 6, 4.0);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(85, 202117229, 4, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(86, 202117229, 5, 2.8);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(87, 202117229, 6, 2.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(88, 202117230, 4, 2.4);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(89, 202117230, 5, 4.1);
INSERT INTO GRADE (GRADEINDEX, STUDENTNUMBER, SUBJECTID, GRADE) VALUES
(90, 202117230, 6, 4.0);
select * from grade;

select student.studentnumber, student.name,subject.subjectname, grade.grade
from student
join grade on student.studentnumber = grade.studentnumber
join subject on subject.subjectid = grade.subjectid;

--�� �а��� �л� ���� ��ȸ�ϴ� ����
SELECT d.DepartmentName, COUNT(s.STUDENTNUMBER) AS StudentCount
FROM STUDENT s
JOIN Department d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

--�� �л��� ���� ����� ��ȸ�ϴ� ����
SELECT s.name, round(AVG(g.GRADE),2) AS AverageGrade
FROM STUDENT s
JOIN GRADE g ON s.STUDENTNUMBER = g.STUDENTNUMBER
GROUP BY s.name;

--�� ������ ���� ���� ���� ��ȸ�ϴ� ����
SELECT p.ProfessorName, COUNT(sub.SUBJECTID) AS SubjectCount
FROM Professor p
JOIN SUBJECT sub ON p.ProfessorID = sub.PROFESSORID
GROUP BY p.ProfessorName;

--�� ���񺰷� ������ �л� ���� ��ȸ�ϴ� ����
SELECT sub.SUBJECTNAME, COUNT(g.STUDENTNUMBER) AS StudentCount
FROM SUBJECT sub
JOIN GRADE g ON sub.SUBJECTID = g.SUBJECTID
GROUP BY sub.SUBJECTNAME;

--Ư�� �а��� ��� ������ ��ȸ�ϴ� ���� (��: ��ǻ�Ͱ��а�)
SELECT d.DepartmentName, round(AVG(g.GRADE),2) AS AverageGrade
FROM GRADE g
JOIN STUDENT s ON g.STUDENTNUMBER = s.STUDENTNUMBER
JOIN Department d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = '��ǻ�Ͱ��а�'
GROUP BY d.DepartmentName;

-- �а����� ������ 2.5 ������ �л��� ã�� ���� SQL ����
SELECT d.DepartmentName, s.name, ROUND(AVG(g.GRADE),2) AS AverageGrade
FROM STUDENT s
JOIN GRADE g ON s.STUDENTNUMBER = g.STUDENTNUMBER
JOIN Department d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName, s.name
HAVING AVG(g.GRADE) <= 2.5;

--�� ���� ���� 3�� �л��� �����ִ� ����
WITH RankedGrades AS (
    SELECT 
        g.SUBJECTID,
        g.STUDENTNUMBER,
        g.GRADE,
        ROW_NUMBER() OVER (PARTITION BY g.SUBJECTID ORDER BY g.GRADE DESC) AS Rank
    FROM 
        GRADE g
)
SELECT 
    sub.SUBJECTNAME,
    s.name AS StudentName,
    r.GRADE
FROM 
    RankedGrades r
JOIN 
    STUDENT s ON r.STUDENTNUMBER = s.STUDENTNUMBER
JOIN 
    SUBJECT sub ON r.SUBJECTID = sub.SUBJECTID
WHERE 
    r.Rank <= 3
ORDER BY 
    sub.SUBJECTNAME, r.Rank;

--���� ���� �л��� �а�, ����, �̸�, �������� �����ִ� ����
WITH RankedGrades AS (
    SELECT 
        g.SUBJECTID,
        g.STUDENTNUMBER,
        g.GRADE,
        ROW_NUMBER() OVER (PARTITION BY g.SUBJECTID ORDER BY g.GRADE ASC) AS Rank
    FROM 
        GRADE g
)
SELECT 
    d.DepartmentName,
    sub.SUBJECTNAME,
    s.name AS StudentName,
    r.GRADE
FROM 
    RankedGrades r
JOIN 
    STUDENT s ON r.STUDENTNUMBER = s.STUDENTNUMBER
JOIN 
    SUBJECT sub ON r.SUBJECTID = sub.SUBJECTID
JOIN 
    Department d ON s.DepartmentID = d.DepartmentID
WHERE 
    r.Rank = 1
ORDER BY 
    sub.SUBJECTNAME;


--Q22. ���� �ǽ������� �����ϼ���.(20��)
-- 1. ���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���.
-- 2. �λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���. 

SELECT * FROM COUNTRIES;    --���� (����ID , �����̸� , ����ID)
SELECT * FROM DEPARTMENTS;  --�μ� (�μ�ID , �μ��̸� , MANAGER_ID , LOCATION_ID) 
SELECT * FROM EMPLOYEES;    --���� (����ID , �����̸� , �̸���, �ڵ�����ȣ, ä����, ����ID, ����, ������, MANAGER_ID , �μ�ID)
SELECT * FROM JOB_HISTORY;  --�����̷� (����ID , ������, ������, ����ID, �μ�ID)
SELECT * FROM JOBS;         --���� (����ID, �����̸�, �ּҿ���, �ְ���)
SELECT * FROM LOCATIONS;    --��ġ (��ġID, �ּ�, �����ȣ, ����, ��������, ����ID
SELECT * FROM REGIONS;      --���� (����ID, �����̸�)

CREATE TABLE EMPLOYEESATISFACTION (
    SATISFACTIONSCORE NUMBER(3,2) PRIMARY KEY,                 -- ���� ID
    FIRST_NAME VARCHAR2(50),                     -- ���� �̸�
    LAST_NAME VARCHAR2(50),                       -- ���� �̸�
    DEPARTMENT_NAME VARCHAR(100),               -- �μ� �̸�
    EMPLOYEE_ID NUMBER,             -- ������ ���� (��: 4.75)            
);

--�ǽ�
--���� hr�� �ִ� 7�� ���̺���� �м��ؼ� �λ������ �ǹ��ִ� �λ���Ʈ 5�� �̻��� ����ϼ���
--�λ���� ������ ���� KPI 2���� �����ϰ� �̰͵��� ���̺���� �����Ϳ� �ݿ��� �� �ٽ� �м��ؼ� �ݿ� ���θ� �����ϼ���



--�Ի� �⵵�� ä���ο��� 
select extract(year from hire_date) as ���⵵, count(*) as ����ο���
from employees                  
group by extract(year from hire_date)     --extract : ��¥,�ð����� Ư���κ� ����
order by extract(year from hire_date);


--�Ի� �޼� ��ȸ
select employee_id, first_name || ' ' || last_name as fullname, hire_date,
       trunc(months_between(sysdate, hire_date) / 12) as �ټӿ���
from employees;



--���� 20�� �̻� 
select first_name || ' ' || last_name as �̸� , hire_date as �Ի糯¥
from employees
where (sysdate - hire_date) / 365 >= 20
order by hire_date;
--
select first_name || ' ' || last_name as �̸�, round(sysdate - hire_date) as �ټ��ϼ�
from employees
where round(sysdate - hire_date) > 365 * 20      --�Ҽ��� �ݿø�
order by hire_date;



--�μ��� ���� ��
select d.department_name, count(e.employee_id) as employee_count
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name
order by employee_count desc;


--���� ��¥�� �ش� ������ �Ի��� ����� �� ���� ���, / 12 �� ������ ��ȯ trunc�� �Ҽ��� ���� = �����

--�� �μ��� ��� ����
select d.department_name, avg(e.salary) as ��տ���
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name;


-- �� �μ��� �� �޿� ���
WITH department_salaries AS (
    SELECT 
        d.department_id,
        d.department_name,
        SUM(e.salary) AS total_salary
    FROM 
        employees e
    JOIN 
        departments d ON e.department_id = d.department_id
    GROUP BY 
        d.department_id, d.department_name
),
-- ��ü �� �޿� ���
total_salary AS (
    SELECT 
        SUM(total_salary) AS total_company_salary
    FROM 
        department_salaries
)
-- �� �μ��� �� �޿��� ��ü �� �޿��� ����Ͽ� ���� ���
SELECT 
    ds.department_name,
    ds.total_salary,
    ts.total_company_salary,
    ROUND((ds.total_salary / ts.total_company_salary) * 100, 2) AS salary_percentage
FROM 
    department_salaries ds,
    total_salary ts;


CREATE TABLE server_inventory (
    server_id NUMBER PRIMARY KEY,
    server_name VARCHAR2(100) NOT NULL,
    ip_address VARCHAR2(15) NOT NULL,
    operating_system VARCHAR2(50) NOT NULL,
    memory_size_gb NUMBER NOT NULL,
    cpu_count NUMBER NOT NULL,
    location VARCHAR2(100),
    installation_date DATE,
    inventory_status VARCHAR2(20) NOT NULL, -- e.g., 'In Stock', 'In Use', 'Retired'
    inventory_quantity NUMBER NOT NULL,
    arrival_date DATE,
    price NUMBER NOT NULL -- ���� ���� �߰�
);

DESC server_inventory;

INSERT INTO server_inventory (server_id, server_name, ip_address, operating_system, memory_size_gb, cpu_count, location, installation_date, inventory_status, inventory_quantity, arrival_date, price)
VALUES (1,'Server1', '192.168.1.1', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 150000);


SELECT *
FROM SERVER_INVENTORY;

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (2, 'Server2', '192.168.1.2', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-02', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-02', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (3, 'Server3', '192.168.1.3', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-03', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-03', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (4, 'Server4', '192.168.1.4', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-04', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-04', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (5, 'Server5', '192.168.1.5', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-05', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-05', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (6, 'Server6', '192.168.1.6', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-06', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-06', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (7, 'Server7', '192.168.1.7', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-07', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-07', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (8, 'Server8', '192.168.1.8', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-08', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-08', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (9, 'Server9', '192.168.1.9', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-09', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-09', 'YYYY-MM-DD'), 150000);

INSERT INTO server_inventory (
    server_id, 
    server_name, 
    ip_address, 
    operating_system, 
    memory_size_gb, 
    cpu_count, 
    location, 
    installation_date, 
    inventory_status, 
    inventory_quantity, 
    arrival_date, 
    price
) VALUES (10, 'Server10', '192.168.1.10', 'Linux', 32, 8, 'Data Center 1', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 'In Stock', 1, TO_DATE('2022-01-10', 'YYYY-MM-DD'), 150000);


SELECT *
FROM server_inventory;

SELECT SUM(PRICE)/5 AS �����󰢺�
FROM server_inventory;