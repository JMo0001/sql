select * from employee;
select * from department;
select * from job;
select * from location;
select * from national;
select * from sal_grade;


--급여 3500000보다 많고 6000000보다 적게 받는 직원 이름, 급여 조회
select emp_name, salary
    from employee
    where salary BETWEEN 3500001 and 5999999
    ;
--'전'씨 성을 가진 직원 이름과 급여 조회
select emp_name, salary
    from employee
    where emp_name like '전%'
    ;
--핸드폰의 앞 네자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
select emp_name, phone
    from employee
    where phone like '___7%'
    ;
--email id 중 '_'의 앞이 3자리인 직원 이름, 이메일 조회
select emp_name, email
    from employee
    where email like'___#_%' escape '#'
    ;
--'이'씨 성이 아닌 직원 사번, 이름, 이메일 조회
select emp_id, emp_name, email
    from employee
    where emp_name not like '이%'
    ;
--관리자도 없고 부서 배치도 받지 않은 직원 조회
select emp_name
    from employee
    where manager_id is null and dept_code is null
    ;
--부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
select emp_name
    from employee
    where dept_code is null and bonus is not null
    ;
--D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
select emp_name, dept_code, salary
    from employee
    where dept_code in('D6','D8')
    ;
--J2 또는 J7 직급 코드 중 급여를 2000000보다 많이 받는 직원의 이름, 급여, 직급코드 조회
select emp_name, salary, job_code
    from employee
    where job_code in('J2','J7') and salary >2000000
    ;