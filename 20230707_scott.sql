--학습용 scott 명렁어들
SELECT *
FROM EMP
;

SELECT EMPNO, ENAME, SAL
FROM EMP
;

SELECT ENAME, MGR, SAL, DEPTNO
FROM EMP
WHERE DEPTNO=20 OR SAL>1500
;

SELECT ENAME, MGR, SAL, DEPTNO
FROM EMP
--WHERE ENAME='smith'  안보임
WHERE ENAME='SMITH' --"SMITH" 부적합식별자
;

SELECT MGR, ENAME, DEPTNO
FROM EMP
;

select empno, ename, sal
from emp
;

select dname, loc
from dept
;
-- * 을 사용하는 것 보다 속도 빠름. 권장.
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp
;
-- * 보다 컬럼명을 나열하는 것이 속도면에서 좋음.
select * from emp;
select * from dept;
select * from salgrade;
select * from bonus;


-- Q : 사원들명과 연봉과 보너스를 포함한 연봉을 조회
select ename 사원명, sal*12 연봉, sal*12 + nvl(comm, 0) "보너스 포함 연봉"
from emp
;
select ename as name, sal*12 as sal2, sal*12 + nvl(comm, 0) as "salwcomm"
from emp
;
-- null값을 0으로, null값을 100으로
select comm, nvl(comm, 0), nvl(comm, 100)
from emp
;

select '안녕' as hello
from dept
;

select '$' as 달러, sal
from emp
;
-- 중복 제거 distinct
select distinct '$' as 달러, sal
from emp
;

-- 급여를 1500보다 많이 받고 2800보다 적게 받는 직원 이름과 급여 조회
-- between and
-- >= <= 사용
select ename, sal
from emp
where sal between 1500 and 2799
--where sal>=1500 and sal<2800
;
