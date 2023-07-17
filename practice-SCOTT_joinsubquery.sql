select * from emp;

--Q. 1 아래와 같이 조회
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, s.grade
    from emp e
    join salgrade s on(sal between losal and hisal);
    
--Q. 2 아래와 같이 조회
select e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno, s.grade
    from emp e
    join salgrade s on(sal between losal and hisal)
    where e.deptno !=10
    order by s.grade desc;
    
--Q. 3
--DEPTNO가 20,30인 부서 사람들의 등급별 평균연봉
--조건 :
--1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 계산하도록 한다.
--2. 연봉 계산은 SAL*12+COMM
--3. 순서는 평균연봉이 내림차순으로 정렬한다.
select s.grade, avg(sal*12+nvl(comm,0)) 평균연봉
    from emp e
    join salgrade s on(sal between losal and hisal)
    where e.deptno=20 or e.deptno=30
    group by grade
    order by 평균연봉 desc
;
--Q. 4
--조건 :
--1. DEPTNO가 20,30인 부서 사람들의 평균연봉을 조회
--2. 연봉 계산은 SAL*12+COMM
--3. 순서는 평균연봉이 내림차순으로 정렬한다.
select e.deptno, floor(avg(sal*12+nvl(comm,0))) 평균연봉
    from emp e
    join salgrade s on(sal between losal and hisal)
    where e.deptno = 20 or e.deptno = 30
    group by e.deptno
    order by 평균연봉 desc
;
--Q. 5
--사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
select e1.empno, e1.ename, e1.job, e1.mgr, e2.ename manager 
    from emp e1, emp e2
    where e1.mgr = e2.empno
    order by e1.empno asc
;
--Q. 6
--사원의 MGR의 이름을 아래와 같이 Manager컬럼에 조회 - 정렬
--단, Select 절에 SubQuery를 이용하여 풀이

select e1.empno, e1.ename, e1.job, e1.mgr, (select ename from emp e2 where e1.mgr=e2.empno) manager 
    from emp e1
    order by e1.mgr asc
;
--Q. 7
--MARTIN의 월급보다 많으면서 ALLEN과 같은 부서이거나 20번부서인 사원 조회
select empno, ename, job, mgr, hiredate, sal, comm, deptno
    from emp 
    where sal > (select sal from emp where ename in('MARTIN')) 
        and (deptno=(select deptno from emp where ename in('ALLEN')) or deptno=20)
;
--Q. 8
--‘RESEARCH’부서의 사원 이름과 매니저 이름을 나타내시오.
select e1.ename, e2.ename manager 
    from emp e1, emp e2
    join dept d using (deptno)
    where e1.mgr = e2.empno and d.dname in 'RESEARCH'
;
--Q. 9
--GRADE별로 급여을 가장 작은 사원명을 조회
select s.grade, e.ename 등급별가장작은급여
    from emp e
    join salgrade s on (sal between losal and hisal)
    where sal in (select min(sal) from emp 
                    join salgrade on (sal between losal and hisal) group by s.grade)
;
--Q. 10.
--GRADE별로 가장 많은 급여, 가장 작은 급여, 평균 급여를 조회
select s.grade, min(sal) min_sal, max(sal) max_sal, trunc(avg(sal),2) avg_sal
    from emp e
    join salgrade s on (sal between losal and hisal)
    group by s.grade
;
--Q. 11
--GRADE별로 평균급여에 10프로내외의 급여를 받는 사원명을 조회 - 정렬
select s.grade, ename
    from emp e
    join salgrade s on (sal between losal and hisal)
    where e.sal <= (select avg(sal), s.grade
    from emp  join salgrade 
        on e.sal between s.losal and s.hisal
    )*1.1 
    and e.sal >= (select avg(sal), s.grade
    from emp  join salgrade 
        on e.sal between s.losal and s.hisal
    )*0.9
                       
;
select s.grade, floor(avg(sal))
    from emp e join salgrade s
        on e.sal between s.losal and s.hisal
    group by s.grade
    
;