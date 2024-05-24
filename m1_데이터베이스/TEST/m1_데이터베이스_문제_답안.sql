교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 24.05.24
- 성명 : 김성현
- 점수 :

※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.
--Q1. EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
SELECT FIRST_NAME || ' ' || LAST_NAME 이름, SALARY, SALARY * 1.1 REVISED_SALARY
FROM EMPLOYEES;
    
--Q2. EMPLOYEES 테이블에서 2005년 상반기에 입사한 사람들만 출력	
SELECT FIRST_NAME || ' ' || LAST_NAME 이름, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YY/MM') BETWEEN '05/01' AND '05/06';

--Q3. EMPLOYEES 테이블에서 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
SELECT FIRST_NAME || ' ' || LAST_NAME 이름, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID IN ('SA_MAN', 'IT_PROG', 'ST_MAN');
   
--Q4. EMPLOYEES 테이블에서 manager_id 가 101에서 103인 사람만 출력
SELECT FIRST_NAME || ' ' || LAST_NAME 이름, MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN (101, 102, 103);

--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
SELECT LAST_NAME, HIRE_DATE, NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6),2) AS REVISED_DATE
FROM EMPLOYEES;

--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/30) AS W_MONTH
FROM EMPLOYEES
ORDER BY W_MONTH DESC;

--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, HIRE_DATE, TRUNC((SYSDATE-HIRE_DATE)/365) AS W_YEAR
FROM EMPLOYEES
ORDER BY W_YEAR DESC;

--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE MOD(EMPLOYEE_ID,2) =1);

--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
SELECT EMPLOYEE_ID, LAST_NAME, TO_CHAR(SALARY/12, '99999.99')
FROM EMPLOYEES;

--Q10. employees 테이블에서 salary가 10000원 이상인 직원만을 포함하는 뷰 special_employee를 생성하는 SQL 명령문을 작성하시오.
CREATE  VIEW SPECIAL_EMPLOYEE AS
SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000;


--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
SELECT COUNT(*) AS NULL갯수
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, '신입' POSITION
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, J.JOB_TITLE
FROM EMPLOYEES E
JOIN JOBS J ON e.job_id = J.JOB_ID
WHERE EMPLOYEE_ID = 120;

--Q14. HR EMPLOYEES 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
SELECT FIRST_NAME || ' ' || LAST_NAME NAME
FROM EMPLOYEES;

--Q15. HR EMPLOYEES 테이블에서 근속기간이 10년 이상인 직원을 포함하는 뷰를 생성하세요.
CREATE VIEW GOINMOOL AS
SELECT *
FROM EMPLOYEES
WHERE TRUNC(SYSDATE - HIRE_DATE)>365* 10;

--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
SELECT JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE '%\_A%' ESCAPE '\';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
SELECT SALARY, LAST_NAME
FROM EMPLOYEES
ORDER BY SALARY, LAST_NAME;
   
--Q18. Seo라는 사람의 부서명을 출력하세요.
SELECT DEPARTMENT_NAME
FROM DEPARTMENTS D
JOIN EMPLOYEES E ON e.department_id = d.department_id
WHERE e.last_name = 'Seo';

--Q19. JOB ID 별 몇년차는 얼마 받는지 각 년차별로 샐러리 평균을 구하세요.

SELECT JOB_ID, 
       TRUNC((SYSDATE - hire_date) / 365) AS 년차, 
       AVG(salary) AS 평균연봉
FROM 
GROUP BY JOB_ID, TRUNC((SYSDATE - hire_date) / 365)
ORDER BY JOB_ID, 년차;


--Q20. HR EMPLOYEES 테이블에서 salary가 20000 이상이면 'a', 10000과 20000 미만 사이면 'b', 그 이하면 'c'로 표시하는 쿼리를 
--작성하시오.(case)
SELECT SALARY,
CASE WHEN SALARY >= 20000 THEN 'A'
    WHEN SALARY < 20000 AND SALARY > 10000 THEN 'B'
ELSE 'C'
END AS 구간
FROM EMPLOYEES;


--Q21. 학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.(20점)
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
(202117201, 1, '김정규', '1996-06-13', '남', '010-7777-1234');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117202, 1, '박지민', '1997-08-21', '여', '010-8888-5678');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117203, 1, '이민호', '1995-03-12', '남', '010-9999-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117204, 1, '최유리', '1998-12-25', '여', '010-6666-8765');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117205, 1, '정해인', '1996-09-07', '남', '010-5555-2345');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117206, 1, '홍길동', '1997-04-11', '남', '010-4444-1111');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117207, 1, '이영희', '1996-05-22', '여', '010-3333-2222');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117208, 1, '김철수', '1995-06-17', '남', '010-2222-3333');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117209, 1, '박민지', '1998-07-23', '여', '010-1111-4444');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117210, 1, '최동욱', '1996-08-14', '남', '010-1234-5678');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117211, 1, '한지영', '1997-09-05', '여', '010-8765-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117212, 1, '오승준', '1995-10-15', '남', '010-9876-5432');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117213, 1, '서은지', '1998-11-25', '여', '010-7654-3210');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117214, 1, '유상철', '1996-12-19', '남', '010-6543-2109');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117215, 1, '강미영', '1997-01-29', '여', '010-5432-1098');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117216, 2, '임현수', '1995-02-18', '남', '010-4321-0987');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117217, 2, '정민호', '1996-03-27', '남', '010-3210-9876');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117218, 2, '최은지', '1997-04-14', '여', '010-2109-8765');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117219, 2, '김유정', '1995-05-09', '여', '010-1098-7654');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117220, 2, '박성호', '1996-06-13', '남', '010-0987-6543');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117221, 2, '이정훈', '1997-07-22', '남', '010-9876-5432');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117222, 2, '남지훈', '1996-08-15', '남', '010-5678-1234');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117223, 2, '김하늘', '1997-09-10', '여', '010-8765-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117224, 2, '박세준', '1998-10-20', '남', '010-3456-7890');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117225, 2, '이유미', '1995-11-11', '여', '010-2345-6789');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117226, 2, '최성훈', '1996-12-22', '남', '010-1234-5678');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117227, 2, '한예진', '1997-01-30', '여', '010-8765-4321');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117228, 2, '정지우', '1998-03-15', '여', '010-5678-9101');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117229, 2, '박진호', '1995-05-20', '남', '010-2345-6780');
INSERT INTO STUDENT (STUDENTNUMBER, DepartmentID, NAME, BIRTH, SX, PHONE) VALUES
(202117230, 2, '김다현', '1996-07-25', '여', '010-0987-6543');
SELECT * FROM STUDENT;

--
INSERT INTO DEPARTMENT (DepartmentID, DepartmentName, GraduationCredits) VALUES 
(1, '영어영문학과', 130);
INSERT INTO DEPARTMENT (DepartmentID, DepartmentName, GraduationCredits) VALUES 
(2, '컴퓨터공학과', 130);
SELECT * FROM DEPARTMENT;

--
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(1, '유정훈', 1, 5000);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(2, '김민수', 2, 5200);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(3, '박지영', 1, 4800);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(4, '최영희', 2, 5100);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(5, '이동수', 1, 5300);
INSERT INTO PROFESSOR (ProfessorID, ProfessorName, DepartmentID, Salary) VALUES
(6, '한지훈', 2, 4700);
SELECT * FROM PROFESSOR;

--
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(1,'영문법기초', 3, 1, 1);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(2,'영어학', 3, 2, 1);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(3,'영미문학', 3, 3, 1);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(4,'파이썬', 3, 4, 2);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(5,'데이터베이스', 3, 5, 2);
INSERT INTO SUBJECT (SUBJECTID, SUBJECTNAME, SUBSCORE, PROFESSORID, DEPARTMENTID) VALUES
(6,'인공지능', 3, 6, 2);
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

--각 학과의 학생 수를 조회하는 쿼리
SELECT d.DepartmentName, COUNT(s.STUDENTNUMBER) AS StudentCount
FROM STUDENT s
JOIN Department d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

--각 학생의 학점 평균을 조회하는 쿼리
SELECT s.name, round(AVG(g.GRADE),2) AS AverageGrade
FROM STUDENT s
JOIN GRADE g ON s.STUDENTNUMBER = g.STUDENTNUMBER
GROUP BY s.name;

--각 교수의 강의 과목 수를 조회하는 쿼리
SELECT p.ProfessorName, COUNT(sub.SUBJECTID) AS SubjectCount
FROM Professor p
JOIN SUBJECT sub ON p.ProfessorID = sub.PROFESSORID
GROUP BY p.ProfessorName;

--각 과목별로 수강한 학생 수를 조회하는 쿼리
SELECT sub.SUBJECTNAME, COUNT(g.STUDENTNUMBER) AS StudentCount
FROM SUBJECT sub
JOIN GRADE g ON sub.SUBJECTID = g.SUBJECTID
GROUP BY sub.SUBJECTNAME;

--특정 학과의 평균 학점을 조회하는 쿼리 (예: 컴퓨터공학과)
SELECT d.DepartmentName, round(AVG(g.GRADE),2) AS AverageGrade
FROM GRADE g
JOIN STUDENT s ON g.STUDENTNUMBER = s.STUDENTNUMBER
JOIN Department d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = '컴퓨터공학과'
GROUP BY d.DepartmentName;

-- 학과별로 평점이 2.5 이하인 학생을 찾기 위한 SQL 쿼리
SELECT d.DepartmentName, s.name, ROUND(AVG(g.GRADE),2) AS AverageGrade
FROM STUDENT s
JOIN GRADE g ON s.STUDENTNUMBER = g.STUDENTNUMBER
JOIN Department d ON s.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName, s.name
HAVING AVG(g.GRADE) <= 2.5;

--각 과목별 상위 3등 학생을 보여주는 쿼리
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

--과목별 꼴찌 학생을 학과, 과목, 이름, 학점으로 보여주는 쿼리
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


--Q22. 다음 실습과제를 수행하세요.(20점)
-- 1. 현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요.
-- 2. 인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요. 

SELECT * FROM COUNTRIES;    --국가 (국가ID , 국가이름 , 지역ID)
SELECT * FROM DEPARTMENTS;  --부서 (부서ID , 부서이름 , MANAGER_ID , LOCATION_ID) 
SELECT * FROM EMPLOYEES;    --직원 (직원ID , 직원이름 , 이메일, 핸드폰번호, 채용일, 직무ID, 연봉, 수수료, MANAGER_ID , 부서ID)
SELECT * FROM JOB_HISTORY;  --직무이력 (직원ID , 시작일, 종료일, 직무ID, 부서ID)
SELECT * FROM JOBS;         --직무 (직무ID, 직업이름, 최소연봉, 최고연봉)
SELECT * FROM LOCATIONS;    --위치 (위치ID, 주소, 우편번호, 도시, 행정구역, 국가ID
SELECT * FROM REGIONS;      --지역 (지역ID, 지역이름)

CREATE TABLE EMPLOYEESATISFACTION (
    SATISFACTIONSCORE NUMBER(3,2) PRIMARY KEY,                 -- 직원 ID
    FIRST_NAME VARCHAR2(50),                     -- 직원 이름
    LAST_NAME VARCHAR2(50),                       -- 직원 이름
    DEPARTMENT_NAME VARCHAR(100),               -- 부서 이름
    EMPLOYEE_ID NUMBER,             -- 만족도 점수 (예: 4.75)            
);

--실습
--현재 hr에 있는 7개 테이블들을 분석해서 인사관리에 의미있는 인사이트 5개 이상을 기술하세요
--인사관리 개선을 위한 KPI 2개를 설정하고 이것들을 테이블들의 데이터에 반영한 후 다시 분석해서 반영 여부를 검증하세요



--입사 년도별 채용인원수 
select extract(year from hire_date) as 고용년도, count(*) as 고용인원수
from employees                  
group by extract(year from hire_date)     --extract : 날짜,시간에서 특정부분 추출
order by extract(year from hire_date);


--입사 햇수 조회
select employee_id, first_name || ' ' || last_name as fullname, hire_date,
       trunc(months_between(sysdate, hire_date) / 12) as 근속연수
from employees;



--재직 20년 이상 
select first_name || ' ' || last_name as 이름 , hire_date as 입사날짜
from employees
where (sysdate - hire_date) / 365 >= 20
order by hire_date;
--
select first_name || ' ' || last_name as 이름, round(sysdate - hire_date) as 근속일수
from employees
where round(sysdate - hire_date) > 365 * 20      --소수점 반올림
order by hire_date;



--부서별 직원 수
select d.department_name, count(e.employee_id) as employee_count
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name
order by employee_count desc;


--현재 날짜와 해당 직원의 입사일 사시의 월 수를 계산, / 12 연 단위로 변환 trunc로 소수점 제거 = 몇년차

--각 부서의 평균 연봉
select d.department_name, avg(e.salary) as 평균연봉
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name;


-- 각 부서별 총 급여 계산
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
-- 전체 총 급여 계산
total_salary AS (
    SELECT 
        SUM(total_salary) AS total_company_salary
    FROM 
        department_salaries
)
-- 각 부서의 총 급여와 전체 총 급여를 사용하여 비율 계산
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
    price NUMBER NOT NULL -- 가격 정보 추가
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

SELECT SUM(PRICE)/5 AS 감가상각비
FROM server_inventory;