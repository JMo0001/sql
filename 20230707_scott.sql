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

--20230712
--실습 문항 풀이
--3. 11. GRADE별로 평균급여에 10프로내외의 급여를 받는 사원명을 조회 - 정렬
--grade 별 평균 급여 구한 후 비교하기.
select s.grade, e.ename, e.sal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
    where e.sal >= (select avg(sal)   --(950, 1266, 1550, 2855, 5000) 다중 행 결과물과 >= 비교 불가능.
                        from emp e2 join salgrade s2
                            on e2.sal between s2.losal and s2.hisal
                        where s2.grade = s.grade
                    --group by s2.grade having s2.grade = s.grade
                    )*0.9 and 
        e.sal <= (select avg(sal)   --(950, 1266, 1550, 2855, 5000) 다중 행 결과물과 >= 비교 불가능.
                        from emp e2 join salgrade s2
                            on e2.sal between s2.losal and s2.hisal
                        where s2.grade = s.grade
                    --group by s2.grade having s2.grade = s.grade
                    )*1.1
;
--평균 급여 구해보기
select avg(sal), s.grade
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
    group by s.grade
;
--select 에서 rownum 사용하면 별칭을 꼭 써야한다.
--select 에서 함수를 사용한 경우에도 반드시 별칭을 써야한다.

--with 사용
with abc3 as (select s.grade, e.ename, e.sal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal)   -- emp와 grade가 join 해둔 table.
select *
    from abc3 t1    
    where sal between (select avg(t2.sal) from abc3 t2 where t2.grade = t1.grade)*0.9
    and (select avg(t2.sal) from abc3 t2 where t2.grade = t1.grade)*1.1
;

create or replace view view_emp_salgrade
as
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, s.grade, s.losal, s.hisal
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
;
select  grade, ename "10프로내외"
    from view_emp_salgrade t1
    where sal between(select avg(t2.sal) from view_emp_salgrade t2 where t2.grade = t1.grade)*0.9
        and (select avg(t2.sal) from view_emp_salgrade t2 where t2.grade = t1.grade)*1.1
        order by t1.grade asc, 2 asc
;

--from절 subquery
select grade, ename "10프로내외"
    from emp e join(select floor(avg(e2.sal)*0.9) minsal, floor(avg(e2.sal)*1.1) maxsal, floor(avg(e2.sal)) avgsal, s2.grade
                    e, s2.losal, s2.hisal, s2.grade 
                        from emp e2 join salgrade s2 on e2.sal between s2.losal and s2.hisal
                        group by s2.grade, s2.losal, s2.hisal, s2.grade
                    ) m
                    on e.sal between minsal and maxsal
;
-- group by 사용시
-- select 컬럼명으로는 group by에 사용된 컬럼명 작성 가능. + 그룹함수 사용 가능
select avg(e2.sal)*0.9 minsal, avg(e2.sal)*1.1 maxsal, avg(e2.sal), s2.grade
                    e, s2.losal, s2.hisal --group by에 사용되지 않은 컬럼명이라 select에 작성 불가능. > 작성
                        from emp e2 join salgrade s2 on e2.sal between s2.losal and s2.hisal
                        group by s2.grade,
                                    s2.losal, s2.hisal
;




-- 실습 3. 12
--지역 재난 지원금을 사원들에게 추가 지급
--조건 :
--1. NEW YORK지역은 SAL의 2%, DALLAS지역은 SAL의 5%, CHICAGO지역은 SAL의 3%,
--BOSTON지역은 SAL의 7%
--
--2. 추가지원금이 많은 사람 순으로 정렬
-- case 사용 풀이
select empno, ename, sal, loc,
        sal+case loc    --then 다음에는 화면에 뿌리는 것들이 나옴.
            when 'NEW YORK' then sal*0.02
            when 'DALLAS' then sal*0.05
            when 'CHICAGO' then sal*0.03
            when 'BOSTON' then sal*0.07
            end
                as sal_subsidy
    from emp e
        join dept d using(deptno)
--    where
--    group by
--    having
    order by sal_subsidy-sal desc
;
--decode 사용 풀이
select empno, ename, sal, loc,
        sal+decode(loc, 'NEW YORK',sal*0.02,'DALLAS',sal*0.05,'CHICAGO',sal*0.03,'BOSTON',sal*0.07,0)
            as sal_subsidy
    from emp e
        join dept d using(deptno)
--    where
--    group by
--    having
    order by sal_subsidy-sal desc
;


--salesman 들의 급여와 같은 급여를 받는 사원을 조회
select empno, ename, sal
    from emp
    where sal < all (select sal from emp where job='SALESMAN') -- = where sal in (1600,1250,1500)
;

--관리자로 등록되어 있는 사원들을 조회
-- EXISTS
select empno, ename
    from emp e
    where exists (select empno from emp e2 where e.empno = e2.mgr)
;
select * from emp;
select distinct e.empno, e.ename
    from emp e join emp e2
        on e.empno = e2.mgr
;
--join 대비 상관쿼리 사용시 속도 향상
--상관쿼리? > main쿼리, sub쿼리 값을 비교할 때.

--부서 번호가 30인 사원들의 급여와 부서번호를 묶어 메인 쿼리로 전달해 보자.
select *
    from emp
    where (deptno, sal) in(select deptno, sal from emp where deptno=30)
;

--부서별 평균급여와 직원들 정보를 조회해주세요.
select e.*,
        --스칼라 서브쿼리 작성되어야 함.
        (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno) avgsal
    from emp e
;
select e.*, 
    case e.deptno
        when 10 then (select trunc(avg(sal)) from emp e2 where e2.deptno =10)
        end avgsal
        from emp e
;
--직원 정보와 부서번호 부서명 부서위치
select ename, deptno, dname, loc
    from emp join dept using(deptno)
;
select ename, deptno,
            (select dname from dept d where d.deptno = e.deptno) dname,
            (select loc from dept d where d.deptno=e.deptno) loc
            from emp e
;

-- UNION
--salesman과 관리자를 조회해주세요.
select *
    from emp
    where job in ('SALESMAN', 'MANAGER')
;

select empno, ename, job from emp where job = 'SALESMAN'
union
select mgr, ename, job from emp where job = 'MANAGER'
;

--급여가 1000미만인 직원, 2000 미만인 직원 조회 - 중복 포함 결과
select empno, ename, sal from emp where sal<1000
union all
select empno, ename, sal from emp where sal<2000
;

--급여가 1000초과인 직원, 2000 미만인 직원 조회 - intersect
select empno, ename, sal from emp where sal>1000
intersect
select empno, ename, sal from emp where sal<2000
;
--급여가 2000 미만인 직원을 제외하고 조회 -minus
select empno, ename, sal from emp
minus
select empno, ename, sal from emp where sal<2000
;
-- NOT EXISTS
select empno, ename, sal from emp e
    where not exists(select e2.sal from emp e2 where e.sal<2000)
;





-- DDL
--comment
comment on column emp.mgr is '관리자사번';

desc user_constraints;
select * from user_constraints;
select * from user_tables;
select * from user_views;



create table emp_copy1 as select* from emp; -- 새로운 공간에 table 생성 > 컬럼명, 데이터 타입, 값 복사
select * from emp_copy1;                    -- 제약조건은 not null만 복사됨

create view view_emp1 as select * from emp; -- emp 주소값만 가지고 옴
select * from view_emp1;
desc emp;
insert into emp values(8000, 'EJKIM', 'KH', 7788, sysdate, 3000, 700, 40);
commit;

insert into emp_copy1 values(8001, 'EJKIM', 'KH', 7788, sysdate, 3000, 700, 40);
commit;

insert into view_emp1 values(8002, 'EJ2', 'KH', 7788, sysdate, 3000, 700, 40);
commit;

create table emp_copy20 as
select empno, ename 사원명, job, hiredate, sal 
from emp
where deptno=20
;
desc emp_copy20;
select * from user_constraints;


select * from user_constraints;
desc emp;
-- insert into emp( 컬럼명, 컬럼명, ...) values ( 값, 값, ...)
insert into emp(ename, empno, job, mgr, hiredate, deptno) 
    values('EJK2', 8004, 'P', null, to_date('2023-07-12', 'yyyy-mm-dd'), 40);
commit;

update emp
    set mgr=7788
    where ename='EJK2'
    -- update  명령문의 where 절에는 컬럼멍 PK= 깂
    -- where 절에는 컬럼pk=명 ==> resultest는 단일행
    -- where 절에는 컬럼fk명
;   

--20번 부서의 mgr가 smith 7900로 조직개편
update emp
    set mgr=7909
    where deptno=20
;
update emp
    set mgr=7908
    where deptno=70
;
rollback;
select * from emp;

--30번 부서의 mgr가 smith 7908로 조직개편
update emp
    set mgr=7908
    where deptno=30
;
select * from emp;


update emp
    set mgr=7902
    where ename='EJK2'
;
--여러 DML 명령어들을 묶어서 하나의 행동(일)처리를 하고자 할 때 commit / rollback 을 적절히 사용.
--1. DML 명령어가 하나의 행동(일) 처리 단위라면 DML - commit;
--2. 2개 이상의 DML 명령어가 하나의 행동(일) 처리 단위라면 DML 모두가 성공해야 -commit;, 그중 일부가 실패했다면 -rollback
--하나의 행동(일) 처리 단위를 transection  트랜잭션 -commit/rollback 명령어가 수행되는 단위
--commit;
--rollback;


commit;

select * from emp;
select * from dept;
--20번 부서에 신입사원 EJ3(8550), EJ4(5006) 을 투입함
insert into emp (ename, empno, deptno) values('EJ3', 8005, 20);
insert into emp (ename, empno, deptno) values('EJ4', 8006, 20);

insert all
    into emp (ename, empno, deptno) values('EJ3', 8005, 20)
    into emp (ename, empno, deptno) values('EJ4', 8006, 20)
select * from dual
;

--새로운 부서 50번이 만들어지고 그 부서에 신입사원 EJ5, EJ6 투입함
insert all
    into dept (deptno) values(newdeptno)
    into emp (ename,empno,deptno) values ('EJ5', (select max(empno) maxempno from emp)+1, newdeptno)
    into emp (ename,empno,deptno) values ('EJ6', (select max(empno) maxempno from emp)+2, newdeptno)
select max(deptno)+10 newdeptno from dept
;

--T2 테이블이 없음에도 view 생성
create or replace force view view_test2
    as select * from t2;
    
create or replace view view_test3
    as select * from t3;
    
create or replace view view_test2
    as select empno from t2;
    
create or replace view view_emp_readonly
    as 
    select * from emp
    with read only
;
--SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
--42399.0000 - "cannot perform a DML operation on a read-only view"
insert into view_emp_readonly (empno, ename, deptno) values ( 8100, 'EJEJ', 30);

create or replace view view_emp_checkoption
    as
    select * from emp
    where deptno = 30
    with check option
;
select * from view_emp_checkoption;
--ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
update view_emp_checkoption set deptno=20 where empno=7499;
update view_emp_checkoption set comm=350 where empno=7499;
update emp set deptno=20 where empno=7499;

create sequence seq_t1;
select seq_t1.currval from dual;
--ORA-08002: 시퀀스 SEQ_T1.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
--08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
--*Cause:    sequence CURRVAL has been selected before sequence NEXTVAL
--*Action:   select NEXTVAL from the sequence before selecting CURRVAL
select seq_t1.nextval from dual;
select seq_t1.currval from dual;
--sequence의 nextval은 unique한 값에 insert 시에 활용됨.
--sequence 이름을 지을때 SEQ_테이블명_컬럼명
-- 예를 들어 emp테이블의 empno에 적용 >> SEQ_EMP_EMPNO
--insert into emp values (seq_emp_empno.nextval, '홍길동', ...);
select * from user_sequences;

select * from user_constraints;
select * from user_cons_columns;
select * from user_indexes;
select * from user_ind_columns;

--함수기반 index
create index idx_emp_sal on emp(sal);
create index idx_emp_sal on emp(sal*12);
--where 절에 sal*12 >5000 처럼 조건문에 사용이 빈번할 때 index를 걸어줌.
create index idx_emp_sal_comm on emp(sal, comm);
--where 절에 sal >5000 and comm 비교하는 사용이 빈번할 때 index를 걸어줌.
select * from emp where sal>2000 and comm is not null;

--bitmap 기반 index - 도메인의 종류가 적을 때 동일한 데이터가 많은 경우. >> gender 남,여
--create bitmap index idx_emp_sal on emp(deptno);
create bitmap index idx_emp_deptno on demp(deptno);

--unique
    -- insert 빠름. << 오류체크 빠름.
--non-unique
alter index pk_emp rebuild;

select * from employee;
--where emp_no > 'O'

-- sys 계정에서 public 으로 만듬.
select * from dept2_public;
--kh 계정에서 grant 해줘야 함.
select * from kh.department;

--20230717

--over()
--over(partition by A, order by A desc, rows between A and B) 
--over 안 작성 순서 주의.

--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
select deptno, empno, sal
        , sum(sal) sumsal  --그룹함수 사용시 group by 사용해야함. 컬럼명들 그룹으로 묶어야 함.
    from emp;
    

-- winodw - over(partition by ) >> 기존 group by 단점 개선
select deptno, empno, ename, sal
        , sum(sal) over(partition by deptno) sumsal  
    from emp;
-- window - over(order by ) >> 기존 rownum 대비 간결함
select deptno, empno, ename, sal
        ,rank() over(order by sal asc) ranksal  -- 같은 순위 이후 순위만큼 다음 순위가 커짐(1등 1등 1등 4등)
        ,dense_rank() over(order by sal asc) dranksal   -- 같은 순위 이후 다음 순위값이 +1(1등 1등 1등 2등)
        ,row_number() over(order by sal asc) rnsal  -- 기존 rownum과 동일함
        ,rank() over(partition by deptno order by sal asc) dept_sal_rank
    from emp
    order by deptno
;
--rownum (위와 비슷한 결과. 순차적으로 번호를 매김. 같은 값이어도 숫자가 커짐.)
select deptno, empno, ename, sal, rn ranksal
    from (select rownum rn, t1.* 
            from (select deptno, empno, ename, sal from emp order by sal asc) t1);
-- rank(aaa) within group
select rank(2450) within group (order by sal asc) clarksal
    from emp; 


--누적분산 CUM_DIST(), 비율 RATIO_TO_REPORT()
--부서코드가 '30'인 직원의 이름, 급여, 급여에 대한 누적분산을 조회
select ename, sal
            , cume_dist() over(order by sal) sal_cume_dist
            , ratio_to_report(sal) over() sal_ratio
    from emp
    where deptno = 30
;
--부서별 직원의 이름, 급여, 급여에대한 누적분산을 조회
select ename, deptno, sal
            , trunc(cume_dist() over(order by sal),2) sal_cume_dist
            , trunc(ratio_to_report(sal) over(),2) sal_ratio
            , trunc(cume_dist() over(partition by deptno order by sal),2) sal_cume_dist
            , trunc(ratio_to_report(sal) over(partition by deptno)*100,2)||'%' sal_ratio
    from emp
    order by deptno
;


--rows between and
select deptno, ename, sal
        , first_value(ename) over(partition by deptno order by sal desc
--                                  rows unbounded preceding
                                    ) as dept_rich
        , last_value(ename) over(partition by deptno order by sal desc
                                    ) as dept_poor_error -- 오류                                    
        , last_value(ename) over(partition by deptno order by sal desc
-- window 절
-- 생략시 현재 행이 작성되는 내용(값)만 알수 있음. 다음 행에 나올 값은 알지 못함.
-- unbounded preceding : 윈도우의 첫행
-- unbounded following : 윈도우의 마지막행
-- 1 preceding : 현재행의 이전행부터
-- 1 following : 현재행의 다음행까지
                                  rows between current row and unbounded following
                                    ) as dept_poor                                                  
    from emp;
    
    
--20230718
select empno, ename, sal, ntile(4) over(order by sal) from emp;

desc dept;
select * from dept;
insert into dept values(10, 'account', 'new york');
insert into dept values('&deptno', '&부서명', '&지역');
--이전:insert into dept values('&deptno', '&부서명', '&지역')
--신규:insert into dept values('60', 'aaa', 'bbb')
commit;

select * from emp
    where
--    where ename ='%SMITH'
--      ename like '%SMITH'   -abcSMITH
--      comm is null
        ename = '&SMITH'
;
-- 비교 =, !=, <>, ^=, >, <, >=, <=
-- treu false 
--null
select '&뭐라도입력' from dual;
-- '&' - 작은따옴표 안에 & > escape 문자 : 특별한 역할 - 대체문자입력창을 띄워줌. >> where, select 여기저기 쓰임.
-- 검색을 '&_' 로 검색하고 싶다면 : 
-- like '%' / like '_' - escape 문자 > 특별한 역할  - %문자 0개 이상, _문자 1개
-- 검색을 _%로 하고 싶으면 : like '$_$%'escape '$'

set define off;
select '&뭐라도입력' from dual;
insert into dept values(80, 'R%D', 'new york');
set define on;