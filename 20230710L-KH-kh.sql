select * from employee;
select * from department;
select * from job;
select * from location;
select * from national;
select * from sal_grade;

select * from employee where job_code ='J1';
select emp_name, length(emp_name),length(emp_name)
    from employee;


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
    
--
--select email, instr(email, '@', -1, 1) 위치
--instr - 1부터 시작
--select email, instr(email, '@') 위치
select email, instr(email,'@',2) 위치
    from employee
    ;
-- email 은 @ 이후에 . 1개 이상 있어야 함.
select email, instr(email, '@'), instr(email, '.', instr(email, '@')) 위치
    from employee
    where instr(email, '.', instr(email, '@')) <>0
    ;
--
select instr('AORACLEWELCOME', 'O', 1) from dual;
select instr('AORACLEWELCOME', 'O', 1, 2) from dual;
select instr('AORACLEWELCOME', 'O', 1, 3) from dual;
select instr('ORACLEWELCOMEKEY', 'O', 1, 2) from dual;
select instr('ORACLEWELCOMEKEY', 'O', 1, 3) from dual;

select sysdate
from dual;

--사원들의 남, 여 성별과 함께 이름과 주민번호 조회.
-- DECODE
select emp_name, emp_no, 
--    decode(substr(emp_no, 8,1), 1, '남','여')
    decode(substr(emp_no, 8,1), 2, '여','남')
    as "성 별"
    from employee 
;
select emp_name, emp_no,
    decode(substr(emp_no ,8,1), 2, '여', 4, '여', 1, '남', 3, '남', 'nonbinary')
    as "성 별"
    from employee
;
-- CASE
select emp_name, emp_no,
    case
        when substr(emp_no ,8,1) = 2 then '여'
        when substr(emp_no ,8,1) = 1 then '남'
        when substr(emp_no ,8,1) = 3 then '남'
        when substr(emp_no ,8,1) = 4 then '여'
        else 'nonbinary'
    end
    as "성 별"
    from employee
;
select emp_name, emp_no,
    case substr(emp_no ,8,1)
        when '2' then '여'
        when '1' then '남'
        when '3' then '남'
        when '4' then '여'
        else 'nonbinary'
    end
    as "성 별"
    from employee
;
select emp_name, emp_no,
--ORA-00932: 일관성 없는 데이터 유형: CHAR이(가) 필요하지만 NUMBER임
--00932. 00000 -  "inconsistent datatypes: expected %s got %s"
--to_number 이용해서 string을 number로 바꿔줌.
    case to_number(substr(emp_no ,8,1))
        when 2 then '여'
        when 1 then '남'
        when 3 then '남'
        when 4 then '여'
        else 'nonbinary'
    end
    as "성 별"
    from employee
;

-- java, js 삼항 연산자와 비슷함.
-- String a = (substr(emp,8,1) == 2? "여":"남";
--if(substr(emp,8,1)==2){
--    return "여";
--}else if(substr(emp,8,1))==4){
--    return "여";
--}else if(substr(emp,8,1))==2){
--    return "남";
--}else if(substr(emp,8,1))==2){
--    return "남";
--}else{
--    return "nonbinary";
--}
--switch(substr(emp,8,1)){
--    case 1:
--        return "남"
--    case 2:
--        return "여"
--    case 3:
--        return "남"
--    case 4:
--        return "여"
--    default:
--        return "nonbinary"
--}

select substr(emp_no, 8,3) from employee;

--직원들의 평균 급여는 얼마인지 조회
select (avg(salary)) 평균급여 from employee;
select floor(avg(salary)) 평균급여 from employee;
select round(avg(salary)) 평균급여 from employee;
select ceil(avg(salary)) 평균급여 from employee;
select trunc(avg(salary), 4) 평균급여 from employee;

select count(distinct dept_code) 
    from employee
;
select count(dept_code) 
    from employee
;  --21  count 는 null인 개수는 헤아리지 않는다.
select count(*) 
    from employee
;  --23
select * --count(*)     
    from employee 
    where dept_code is null
;    --2   
--count(*) row 개수
--count는 resultset의 결과물에서 row 값이 null 이라면 count 하지 않는다.
select count(dept_code), count(bonus), count(emp_id), count(manager_id)   
--               0               1             2                0
    from employee 
    where dept_code is null
;    
--distinct >> 중복된것 하나로 세기.
select count (dept_code), count(distinct dept_code)
    from employee
;   --6

select dept_code from employee;
select distinct dept_code from employee;


--EMPLOYEE에서 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의
--평균(정수처리), 인원 수를 조회하고 부서 코드 순으로 정렬
select dept_code, sum(salary), floor(avg(salary)), count(dept_code)
    from employee
    group by dept_code
    order by dept_code
;

--EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고
--부서코드 순으로 정렬
select dept_code, count(bonus)
    from employee
    group by dept_code
    order by dept_code
;

--EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리), 
--급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
select decode(substr(emp_no,8,1),1,'남',2,'여') as 성별, floor(avg(salary)), sum(salary), count(*)
    from employee
    group by decode(substr(emp_no,8,1),1,'남',2,'여')
    order by count(*) desc
; 
--부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
select dept_code, floor(avg(salary))
    from employee
    where salary>=3000000
    group by dept_code 
;
--부서 코드와 급여 평균이 3000000 이상인 그룹 조회
select dept_code, floor(avg(salary))
    from employee
    group by dept_code
    having floor(avg(salary)) >=3000000
;

--사원명,부서번호,부서명,부서위치를 조회
--ORA-00904: "TB3"."NATIONAL_CODE": 부적합한 식별자 >> tb.national_code >> using 사용하면 national_code
--00904. 00000 -  "%s: invalid identifier"
select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, national_code, tb4.national_name
--tb1.emp_name?? > 다른곳에 없어서 tb1 안적어도 됨. > emp_name
--오류 방지를 위해서는 쓰는편이 좋음.
    from employee tb1   
        --join조건에 사용되는 컬럼명이 다르면 using 사용 불가.
        join department tb2 on tb1.dept_code = tb2.dept_id      --tb1과 tb2 join
        join location tb3 on tb2.location_id = tb3.local_code   --tb2와 tb3 join
        join national tb4 using(national_code)                  --tb3과 tb4 join
        
;
select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, tb3.national_code, tb4.national_name
    from employee tb1, department tb2, location tb3, national tb4
    where tb1.dept_code = tb2.dept_id
        and tb2.location_id = tb3.local_code
        and tb3.national_code = tb4.national_code
;

select * from employee;
select * from department;
select * from job;
select * from location;
select * from national;
select * from sal_grade;

select *    -- 두명 사라짐 dept_code > null 이라서.
    from employee e
    join department d on e.dept_code = d.dept_id
;
select *   
    from employee e
    full outer join department d on e.dept_code = d.dept_id     --다 나옴
--    right outer join department d on e.dept_code = d.dept_id  -- department 기준 사원 없는 3개 부서도 나옴
--    left outer join department d on e.dept_code = d.dept_id   --employee 기준 부서 배치 안된 사원 3명 나옴
;
select *
    from employee e, department d
    where e.dept_code = d.dept_id(+)    -- id쪽에 null을 채워주면서 간다. 부서명 null 2명 > +2명 > 23명
;
select *
    from employee e, department d
    where e.dept_code(+) = d.dept_id    -- code 쪽에 null을 채워주면서 간다. 사원수null 3부서> +3명 > 24명
;

--                          SUBQUERY
--단일 행 subquery
--직원 평균 급여보다 높은 급여를 받는 직원 id, 이름, 급여, 이름 정렬
select emp_id, emp_name, job_code, salary
    from employee
    where salary >= (select avg(salary) 
                        from employee)
    order by 2
;
--다중 행
--부서별로 가장 높은 급여를 받는 직원의 이름, 직급, 부서, 급여, 부서 정렬
select emp_name, job_code, dept_code, salary
    from employee
    where salary in(select max(salary) 
                    from employee 
                    group by dept_code)
    order by 3
;

--다중 열
--여자이고 퇴사한 사람과 같은 부서, 직급인 사람의 이름, 직급, 부서, 입사일
select emp_name, job_code, dept_code, hire_date
    from employee
    where(dept_code, job_code)in(select dept_code, job_code 
                                    from employee 
                                    where substr(emp_no,8,1)=2 and ent_yn = 'Y')
;

--다중 행  다중 열
--직급의 최소 급여를 받는 직원의 사번, 이름, 직급, 급여, 직급별 정렬
select emp_id, emp_name, job_code, salary
    from employee
    where (job_code, salary)in(select job_code, min(salary)
                                from employee
                                group by job_code)
    order by 3
;

--inline-view 인라인 뷰 (from절에 서브쿼리 사용한 것)

select rownum, emp_name, salary --급여순으로 5명까지 내림차순 정렬
    from employee
    where rownum <= 5
    order by salary desc
;    

select rownum, emp_name, salary
    from(select * from employee order by salary desc)
    where rownum <= 5
;

--  WITH
--직원들의 이름, 급여 급여순 내림차순 정렬.
with aaa as(select emp_name, salary 
                from employee
                order by salary desc)
select rownum, emp_name, salary
from aaa
;

-- RANK() OVER
--직원들의 이름, 급여 급여순 내림차순 정렬.
select 순위, emp_name, salary
    from(select emp_name, salary, rank() over(order by salary desc) as 순위
            from employee
            order by salary desc)
;