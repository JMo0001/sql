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


--20번 부서를 제외한 사원 정보를 조회
select *
from emp
--where deptno !=20
--where deptno <>20
--where deptno ^= 20
--where not deptno = 20
where deptno not in (20)
;

--20번 부서를 제외한 사원 중 comm이 null인 사원 정보를 조회
select *
    from emp
    where deptno != 20 and comm is null
;
--오류 and comm != null, comm = null, comm = is null

--10,20,30번 부서 사원 정보를 조회
select *
    from emp
    --where deptno = 10 or deptno = 20 or deptno = 30
    where deptno in(10,20,30)
;

--10, 20, 30번 부서를 제외한 사원 정보를 조회
select *
    from emp
    --where deptno !=10 and deptno !=20 and deptno !=30
    where deptno not in(10,20,30)
;

-- 'S'로 시작하는 2글자 이상의 이름을 가진 직원의 이름과 급여
select ename, sal
    from emp
    where ename like 'S_%'
;
    
-- '이름의 4번째 글자가 's'인 직원 이름과 급여 조회
select ename, sal
    from emp
    where ename like '____S%'
;
--관리자도 없고 부서배치 받지 않은 직원
select *
    from emp
    where mgr is null
    and edptno is null
    ;
--관리자가 없지만 보너스를 지급받는 직원
select *
    from emp
    where mgr is null
    and comm is not null
    ;
-- 20 30 부서 부서원들 이름, 부서코드, 급여
select ename, deptno, sal
    from emp
    where deptno in(20,30)
    ;
--analyst 또는 salesman 직무인 사원 중 급여를 2500보다 많이 받는 직원의 이름, 급여, 직급코드
select ename, sal, job
    from emp
    where job in('ANALYST','SALESMAN') 
        and sal>2500
    ;
--사원명의 길이와 byte크기를 조회
select length (ename), lengthb(ename)
    from emp
    ;
--select 'a안 녕b', length(' a안 녕 b'), lengthb(' a안 녕b ')
select trim('a안 녕b'), length(trim(' a안 녕 b')), lengthb(trim('    a안 녕b '))
--    from emp
    from dual
--    테이블 dual 은 임시 테이블로 연산이나 간단한 함수 결과값을 조회할 때 사용함. 
    ;
--사원명의 시작부분 S와 끝부분 S 모두 제거해주세요.
select Rtrim(Ltrim(ename, 'S'), 'S') from emp;
--ltrim 예시 > 010 제거

--LPAD / RPAD 채워넣기.
--ename이 총 10자가 되도록 S를 left쪽에 채워주세요.
select Lpad(ename, 10, 'S') from emp;
--ename이 총 10자가 되도록 left쪽에 ' '공백(default)를 채워주세요.
select Lpad(ename, 10) from emp;
--문자열(컬럼) 이어붙이기
select concat(ename, comm) from emp;
select ename||comm from emp;
select concat(sal,'달러') from emp;
-- substr 엄청중요!
-- replace
select replace(ename, 'AM', 'AB') from emp;

--sysdate는 함수는 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수호출과 같이 동작함.
select sysdate from dual;
select hiredate from emp;
select hiredate, add_months(hiredate, 1) from emp;
--2023.07.10 (월)
select sysdate, to_char(sysdate, 'yyyy.mm.dd (dy) hh24:mi:ss') from dual;
select sysdate, to_char(sysdate, 'yyyy.mm.dd (day)') from dual;

alter session set NLS_DATE_FORMAT ='yyyy-mm-dd hh24:mi:ss';
select sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hour 13
select to_date('2023091113', 'yyyymmddhh24') from dual;
select add_months(to_date('2023091113', 'yyyymmddhh24'), 5) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'), 4) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'), '수') from dual;  -- 위와 같음.
--1:일요일 2:월요일 3:화요일 ...
select last_day(to_date('2023091113', 'yyyymmddhh24')) from dual;

-- 오류 (xe버전에서만 돌아감) select next_day('2023091113', 1) from dual;
select to_char(empno, '000000'), '$'||trim(to_char(sal,'999,999,999,999')) from emp;
select to_char(empno, '000000'), to_char(sal,'L999,999,999,999') from emp;

select to_number('123,4567,8901', '999,9999,9999') from dual;
-- 오류 select '123,456,789'*5 from dual;


--직원들의 평균 급여는 얼마인지 조회
select avg(sal) 평균급여 from emp;
select sum(sal) sum from emp;
select max(sal) max from emp;
select min(sal) min from emp;
--부서별 평균 급여 조회
select avg(sal) 평균급여, deptno from emp group by deptno;
select sum(sal) sum , deptno from emp group by deptno;
select max(sal) max , deptno from emp group by deptno;
select min(sal) min , deptno from emp group by deptno;
--job별 평균 급여 조회
select avg(sal) 평균급여, job from emp group by job;
select sum(sal) sum , job from emp group by job;
select max(sal) max , job from emp group by job;
select min(sal) min , job from emp group by job;
select count(sal) count, job from emp group by job;
select count(*) count, job from emp group by job;

--job이 ANALYST 인 직원의 평균 급여 조회
select avg(sal) 평균급여, job
    from emp
    group by job
    having job='ANALYST'
;
select avg(sal) 평균급여  --오류 job
    from emp
    where job='ANALYST'
;

--job이 CLERK 인 직원
select job, deptno, ename
    from emp
    where job='CLERK'
;
--job이 CLERK 인 직원의 평균 급여
select job, deptno, --ename 
    avg(sal)
    from emp
    where job='CLERK'
    group by deptno, job
;
-- ORDER BY
select * from emp
    order by sal desc, ename asc
;
select ename, sal*12+nvl(comm,0)
    from emp
    order by 2 desc, 1 asc
;
-- job 오름차순
select * from emp
--    order by job;
    order by 3;
    
--EMPLOYEE에서 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의
--평균(정수처리), 인원 수를 조회하고 부서 코드 순으로 정렬
select deptno, sum(sal), floor(avg(sal)), count(empno)
    from emp
    group by deptno
    order by deptno
;
--EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고
--부서코드 순으로 정렬
select deptno, count(comm)
    from emp
--    where comm > 0
    group by deptno
    order by deptno
    
;
--EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리), 
--급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
select deptno, floor(avg(sal)), sum(sal), count(empno)
    from emp
    
    group by deptno
    order by count(empno) desc
;
 
--JOIN 
-- 사원명, 부서번호, 부서명, 부서위치를 조회'
select * from dept;
select * from emp;
select *
    from emp
        join dept on emp.deptno = dept.deptno
;
 
select ename, deptno, dname, loc    -- ename, dname, loc는 하나밖에 없음. >> emp.ename 안해도 됨.
    from emp
--        join dept on emp.deptno = dept.deptno
        join dept using (deptno)    -- 같은 이름의 컬럼명일 경우.
;

select ename, dept.deptno, dname, loc    
    from emp, dept
    where emp.deptno =dept.deptno
;

--부서 위치가 DALLAS인 사원명,부서번호,부서명, 위치를 조회
select ename, dept.deptno, dname, loc    
    from emp, dept
    where emp.deptno = dept.deptno
    and loc = 'DALLAS'
;
--부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
select deptno, trunc(avg(sal), 2)
    from emp
    where sal>1500
    group by deptno
;

--부서 코드와 급여 평균이 3000000 이상인 그룹 조회    
select deptno, trunc(avg(sal), 2) aa
    from emp
    group by deptno
    having trunc(avg(sal), 2) >1500
  
;

select empno, loc
    from emp cross join dept
;

select * from emp;
select * from salgrade;
--사원의 이름, 사번, sal, grade 를 조회.

--non_equ join
select e.ename, e.empno, e.sal, s.grade
    from emp e join salgrade s 
        on e.sal between s.losal and s.hisal
    order by s.grade, e.sal
;

--self join
select empno, ename, mgr from emp;

select e.empno, e.ename, e.mgr, m.ename mgrname
    from emp e join emp m
        on e.mgr = m.empno
;
select ename from emp where empno=7566;

--같은 이름 컬럼명이 나타나지 않도록 별칭 사용

select e.empno boss, e.ename, m.empno emp, m.ename emps
    from emp m join emp e
        on e.empno = m.mgr
;


-- 자료형
create table t1(
                c1 char(5), 
                c2 varchar2(5)
                )
;

insert into t1 values('12','12');
insert into t1 values('12345','12345');
insert into t1 values('123456','123456');
--ORA-12899: "SCOTT"."T1"."C1" 열에 대한 값이 너무 큼(실제: 6, 최대값: 5)
commit;
select * from t1;
select length(c1), length(c2) from t1;

desc t1;
desc emp;

-- ERD(entity relationship diagram)
-- UML  - classdiagram, ERD


select rownum, e.* from emp e where deptno in(20,30)
--order by ename asc
;

select rownum, e.* from emp e where deptno in(20,30)
order by ename asc  --rownum으로 순번 매기고 order by로 이름순으로 다시 순서 매김
;

--해결 방법
select rownum, e.* 
    from (select * from emp order by ename asc) e 
    where deptno in(20,30)  --이름순 정렬 후 20,30번 뽑아내
;
select rownum, e.* 
    from (select * from emp where deptno in(20,30) order by ename asc) e --20,30번 중에서 이름순 정렬
;
--1page 1-3
select rownum, e.* 
    from (select * from emp where deptno in(20,30) order by ename asc) e
    where rownum between 1 and 3
;
--2page 4-6
select rownum, e.* --안나온다.
    from (select * from emp where deptno in(20,30) order by ename asc) e
    where rownum between 4 and 6    --rownum은 계속 1. 4~6번이 없어서 아무것도 안나옴.
;
--해결방안 >> page3 참고.
--rownum을 제대로 사용하기 위해서는 "2개의 중첩 subquery(inline-view) 
--             from(inline-view) "수행 순서 1번. -> 다른 곳에 모두 영향을 끼침"
select rownum rnum, e.* 
    from (select * from emp where deptno in(20,30) order by ename asc) e
--    where rnum between 4 and 6  -- select문 수행 전이라 rnum이 뭔질 몰라.  "수행 순서 주의"
;
--3page 7-9
select *
    from (select rownum rnum, e.* 
                from(select * from emp where deptno in(20,30) order by ename asc) e
            )
    where rnum between 7 and 9
;

with abc as(select rownum rnum, e.* 
                from(select * from emp where deptno in(20,30) order by ename asc) e)
select *
    from abc
    where abc.rnum between 7 and 9
-- abc가 마치 새로운 테이블처럼 사용 가능함.
--    and sal > (select avg(sal) from abc)
;

create view view_abc
as
select rownum rnum, e.* 
                from(select * from emp where deptno in(20,30) order by ename asc) e
;
select * from view_abc;

select *
    from view_abc
    where rnum between 7 and 9
;