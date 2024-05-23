--NVL() NULL을 0 또는 다른 값으로 변환하는 함수
SELECT LAST_NAME, MANAGER_ID,
NVL(TO_CHAR(MANAGER_ID), 'CEO') AS REVISED_ID FROM employees;

--DECODE() IF문이나 CASE문과 같이 여러 경우를 선택할 수 있도록 하는 함수
--DECODE 함수는 단순한 조건에 기반하여 값을 반환합니다. 구문은 DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--여기서 expression은 검사할 값을 나타내고, search와 result는 각각 조건과 해당 조건이 참일 때 반환할 값
--default는 모든 search 조건이 거짓일 때 반환할 기본 값 출력

SELECT LAST_NAME, DEPARTMENT_ID,
DECODE(DEPARTMENT_ID,
90, '경영지원실',
60, '프로그래머',
100, '인사부', '기타') 부서
FROM EMPLOYEES;

--Q.EMPLOYEES 테이블에서 COMMISSION_PCT가 NULL이 아닌 경우, 'A' NULL인경우 'N'을 표시하는 쿼리를 작성
SELECT COMMISSION_PCT AS COMMISSION,
    DECODE(COMMISSION_PCT, NULL, 'N','A') AS TRANSFORM
FROM EMPLOYEES
ORDER BY TRANSFORM DESC;

--case()
--decode() 함수와 유사하나 decode() 함수는 단순한 조건 비교에 사용되는 반면
--case() 함수는 다양한 비교연산자로 조건을 제시할 수 있다.
--CASE 문은 조건에 따라 다른 값을 반환하는 데 사용되며, DECODE보다 복잡한 조건을 표현할 수 있다. 
--구문은 CASE WHEN condition THEN result ... ELSE default END이다. 

SELECT LAST_NAME, DEPARTMENT_ID,
CASE WHEN DEPARTMENT_ID=90 THEN '경영지원실'
    WHEN DEPARTMENT_ID=60 THEN '프로그래머'
    WHEN DEPARTMENT_ID=100 THEN '인사부'
ELSE '기타'
END AS 소속
FROM EMPLOYEES;

--Q.EMPLOYEES 테이블에서 SALARY가 20000이상이면 'A', 10000~20000미만 사이면 'B'그 이하면 'C'로 표시하는 쿼리를 작성하시오(CASE)
SELECT LAST_NAME, SALARY,
CASE
WHEN SALARY>=20000 THEN 'A'
WHEN SALARY>10000 AND SALARY < 20000 THEN 'B'
ELSE 'C'
END AS 등급
FROM EMPLOYEES;

--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);

--CONCATENATION: 콤마 대신에 사용하면 문자열이 연결되어 출력된다.
SELECT LAST_NAME, 'IS A ', JOB_ID FROM EMPLOYEES;
SELECT LAST_NAME || 'IS A ' || JOB_ID FROM EMPLOYEES;

--UNION
--UNION 합집합, INTESECT교집합 ,MINUS차집합, UNION ALL겹치는것까지 포함
--두개의 쿼리문을 사용해야한다. 데이터 타입을 일치시켜야 한다.
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

--CREATE VIEW 명령어는 오라클 SQL에서 테이블의 특정 부분이나 조인된 결과를 논리적인 뷰(view)로 만들 때 사용
--뷰는 데이터를 요약하거나 복잡한 조인을 단순화하며, 사용자에게 필요한 데이터만을 보여주는 데 유용
--뷰는 실제 테이블 데이터를 저장하지 않고, 대신 쿼리문 자체를 저장

--뷰의 주요 특징
--쿼리 단순화: 복잡한 쿼리를 뷰로 저장함으로써 사용자는 복잡한 쿼리문을 반복해서 작성할 필요 없이 간단하게 뷰를 참조할 수 있다.
--데이터 추상화: 뷰는 기본 테이블의 구조를 숨기고 사용자에게 필요한 데이터만을 보여줄 수 있어, 데이터 추상화를 제공.
--보안 강화: 뷰를 사용하면 특정 데이터에 대한 접근을 제한할 수 있으며, 사용자가 볼 수 있는 데이터의 범위를 제어할 수 있다.
--데이터 무결성 유지: 뷰를 사용하여 데이터를 수정하더라도, 이 변경사항이 기본 테이블의 데이터 무결성 규칙을 위반하지 않도록 관리할 수 있다.

CREATE VIEW EMPLOYEE_DETAILS AS
SELECT EMPLOYEE_ID , LAST_NAME, DEPARTMENT_ID
FROM EMPLOYEES;

SELECT * FROM employee_details;

--Q.EMPLOYEES테이블에서 SALARY가 10000원 이상인 직원만을 포함하는 뷰 SPECIAL_EMPLOYEE를 생성하는 SQL 명령문을 작성하시오.
CREATE VIEW SPECIAL_EMPLOYEE AS
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 10000;

SELECT * FROM special_employee WHERE SALARY> 20000;

CREATE VIEW SPECIAL_EMPLOYEE AS
SELECT *
FROM EMPLOYEES
WHERE SALARY >= 10000;

--Q. EMPLOYEES테이블에서 각 부서별 직원 수를 포함흐는 뷰를 생성하세요.
CREATE VIEW DEPARTMENT_COUNT_EMPLOYEE AS
SELECT DEPARTMENT_ID, COUNT(*)AS 직원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT * FROM department_count_employee;

--Q.EMPLOYEES테이블에서 근속기간이 10녀니 이상인 직원를 포함하는 뷰를 생성하세요.
CREATE VIEW LONG_MAN AS
SELECT *
FROM EMPLOYEES
WHERE TRUNC(SYSDATE - HIRE_DATE)>365* 20;

SELECT * FROM long_man;

SELECT LAST_NAME, TRUNC(SYSDATE-HIRE_DATE) AS 근속기간
FROM EMPLOYEES
WHERE ROUND(SYSDATE - HIRE_DATE)>365* 20
ORDER BY 근속기간 DESC;
--ORDER BY는 별칭 사용가능

--TCL (Transaction Control Language)
--COMMIT: 현재 트랜잭션 내에서 수행된 모든 변경(INSERT, UPDATE, DELETE 등)을 데이터베이스에 영구적으로 저장.
--COMMIT 명령을 실행하면, 트랜잭션은 완료되며, 그 이후에는 변경 사항을 되돌릴 수 없다.
--ROLLBACK: 현재 트랜잭션 내에서 수행된 변경들을 취소하고, 데이터베이스를 트랜잭션이 시작하기 전의 상태로 되돌린다. 
--오류가 발생했거나 다른 이유로 트랜잭션을 취소해야 할 경우에 사용된다.
--SAVEPOINT: 트랜잭션 내에서 중간 체크포인트를 생성합니다. 오류가 발생할 경우, ROLLBACK을 사용하여 최근의 SAVEPOINT까지 되돌릴 수 있다.
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)

--MEMBERS 테이블 생성
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

INSERT INTO members (member_id, name, email, join_date, status) VALUES (7, '바비 Brown', '밥@example.com', SYSDATE, 'active');

ROLLBACK TO SP1;
COMMIT;

--Q. DEPARTMENT_ID 비어있는 사람 채워주기

--부서별 급여 현황
--테이블생성, 부서별 급여와 총 급여를 확인 할 수 있음.
--(급여의 합 평균 최솟값 최댓값, 총 직원수, 급여전체총합, 직원평균급여, 부서평균급여)
--table 만들기 부서별 급여를 대략적으로 보기
--사용할 테이블 확인
select * from jobs;
select * from departments;
select * from employees;
select * from job_history;

--부서 목록 확인
SELECT department_id
from employees
group by department_id
order by department_id DESC;
-- 부서 목록 department_id : 10,20,30,40,50,60,70,80,90,100,110 그 외 나머지(120~200등..)는 없고 null 값이 있음.
--department_id 가 null 인 사람은 모두 job_id 에 맞는 department_id 를 부여해주려고함(데이터 무결성)
--1. department_id 가 null 값인 사람 찾기
select *
from employees
where department_id IS NULL;
--한명 밖에 없음. department_id : null, employee_id : 178, Job_id : SA_REP

--2. job_id 가 SA_REP 인 department_id 찾기 (직업에 맞는 부서 찾기)
select job_id, department_id
from job_history
where job_id IN 'SA_REP';
--SA_REP 의 department_id 는 80

--3. 수정 전 savepoint 생성
SAVEPOINT null_to_80;
------------------------SAVEPOINT---------------------------------

--4. 제약조건primary key 인 employee_id 로 찾아서 derpartment_id 를 80으로 수정
UPDATE employees
SET department_id = 80
WHERE employee_id = 178;

select * from employees where employee_id = 178;
--ROLLBACK null_to_80; -- savepoint로 가기
ROLLBACK null_to_80;
--commit;
--수정끝

--X팀구성 및 년차별 샐러리
--각 부서마다 팀원은 몇명이고 어떤 포지션들이 있고 구성은 어떻게 되는지
--ROLLUP은 다차원적인 집계 결과를 도출 : 사용 각 부서 및 직무별 직원 수를 집계
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, NVL(E.JOB_ID, 'TOTAL') JOB_ID , COUNT(*) 직원수
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY ROLLUP((E.DEPARTMENT_ID, d.department_name), E.JOB_ID)
ORDER BY e.department_id;

--JOB_ID별 몇년차는 얼마 받는지 각 년차별로 샐러리 평균
