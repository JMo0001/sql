-- 04_실습_KH_Join및 서브쿼리

--1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
select e.emp_name, e.emp_no, d.dept_title, j.job_name
    from employee e
    join department d on (e.dept_code = d.dept_id)
    join job j using(job_code)
    where (substr(e.emp_no,1,1)='7') 
        and (substr(e.emp_no,8,1)=2) 
        and e.emp_name like '전%'
;

--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
select e.emp_id, e.emp_name, 
        floor((months_between(sysdate, to_date(substr(e.emp_no,1,6),'rrmmdd')))/12) 나이,
        d.dept_title, j.job_name
    from employee e
    join department d on(e.dept_code = d.dept_id)
    join job j using(job_code)
    where substr(emp_no,1,6) in(select max(substr(emp_no,1,6)) from employee)
;

--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
select e.emp_id, e.emp_name, j.job_name
    from employee e
    join job j using(job_code)
    where e.emp_name like '%형' or e.emp_name like '%형' or e.emp_name like'_형%_' 
;

--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
select e.emp_name, j.job_name, e.dept_code, d.dept_title
    from employee e
    join department d on(dept_code = dept_id)
    join job j using (job_code)
    where e.dept_code in('D6', 'D5')
;

--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
select e.emp_name, e.bonus, d.dept_title, l.local_name
    from employee e
    join department d on(dept_id=dept_code)
    join location l on(location_id=local_code)
    where e.bonus is not null
;

--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
select emp_name, job_name, dept_title, local_name
    from (select * from employee e join job j using(job_code))
    join (select * from department d join location loc on (location_id=local_code)) 
    on (dept_code=dept_id)
;

--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
select emp_name, dept_title, local_name, national_name
    from (select * from employee e join department d on(dept_code=dept_id))
    join (select * from location l join national using (national_code))
    on (location_id=local_code)
    where location_id in ('L1','L2')
;

--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select e1.emp_name, e1.dept_code, e2.emp_name   
    from employee e1
    join employee e2 on(e1.dept_code=e2.dept_code)
    where e1.emp_name != e2.emp_name
    order by e1.emp_name
;

--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
select e.emp_name, j.job_name, e.salary
    from employee e
    join job j using(job_code)
    where job_code in('J4', 'J7') and nvl(e.bonus, 0)=0 
;

--10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
select e.emp_id,e.emp_name, e.dept_title, j.job_name, e.hire_date, rownum 
    from (select * from employee e 
            join department d on(dept_code=dept_id) 
            order by salary desc) e
    join job j using(job_code)
    where rownum <=5
;

--11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
select sum(salary)
    from employee e
    group by dept_code
; -- 각 부서별 합계
select sum(salary)*0.2
    from employee
;--전체 급여 총합의 20%

--11-1. JOIN과 HAVING 사용
select d.dept_title, sum(salary)
    from employee e
    join department d on (dept_code=dept_id)
    group by d.dept_title
    having sum(salary) > (select sum(salary)*0.2 from employee)
;
--11-2. 인라인 뷰 사용
select *
    from (select dept_title, sum(salary) ss
            from employee 
            join department 
            on (dept_code=dept_id)
            group by dept_title) 
    where ss> (select sum(salary)*0.2 from employee)
;
--11-3. WITH 사용
with aa as (select dept_title, sum(salary)ss
            from employee 
            join department 
            on (dept_code=dept_id)
            group by dept_title)
select dept_title, ss
    from aa
    where  ss > (select sum(salary)*0.2 from employee);
    
--12. 부서 명과 부서 별 급여 합계 조회
with aa as (select dept_title, sum(salary)ss
            from employee 
            left join department 
            on (dept_code=dept_id)
            group by dept_title)
select dept_title, ss
    from aa
;

--13. WITH를 이용하여 급여 합과 급여 평균 조회
with aa as (select sum(salary) ss, avg(salary) aas from employee)
select ss, aas
    from aa
;