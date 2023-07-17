--group by -having
--3. group by_having.pdf

--group by - 꼭 지켜져야 하는 룰 : group by에 적힌 컬럼명만 select로 선택 할 수 있음. + 그룹 함수 가능.
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
select dept_code, sum(salary)
    from employee
;

select dept_code, sum(salary)
    from employee
    group by dept_code
;

select dept_code "부서코드", sum(salary) "합계", floor(avg(salary)) "평균", count(*) "인원수"
    from employee
    group by dept_code
    order by dept_code asc
;

select dept_code "부서코드", count(bonus) "인원수" 
    from employee
    where bonus is not null
    group by dept_code
    order by dept_code asc
;

select decode(substr(emp_no,8,1),1,'남',2,'여') "성별", floor(avg(salary)) "평균", 
        sum(salary) "합계", count(*) "인원수"
    from employee
    group by decode(substr(emp_no,8,1),1,'남',2,'여')
    order by 4 desc
;

select dept_code, floor(avg(salary)) "평균"
    from employee
    where salary >= 3000000
    group by dept_code
    order by 1
;

select dept_code, floor(avg(salary)) "평균"
    from employee
    group by dept_code
    having floor(avg(salary)) >= 3000000
    order by dept_code
;
--group by - 꼭 지켜져야 하는 룰 : group by에 적힌 컬럼명만 select로 선택 할 수 있음. + 그룹 함수 가능.
select job_code, sum(salary) samsal, count(*) cnt from employee group by job_code order by 1;
--집계 (전체)
select dept_code, job_code, sum(salary) from employee group by dept_code, job_code order by 1;

-- dept_code 묶인 것이 없음
select dept_code, job_code, sum(salary) from employee group by rollup(job_code, dept_code);

-- job_code 묶인 것이 없음
select dept_code, job_code, sum(salary) from employee group by rollup(dept_code,job_code);

select dept_code, job_code, sum(salary) from employee group by cube(dept_code,job_code);
--위 아래 같은 결과를 나오게 하기 위해서는 cube(c1,c2) = rollup(c1,c2)+rollup(c2,c1) 2개
select dept_code, job_code, sum(salary) from employee group by rollup(dept_code,job_code)
union all
select '', job_code, sum(salary) from employee group by rollup(job_code) order by 1;

select dept_code, job_code, sum(salary) from employee group by cube(dept_code, job_code) order by 1;
select dept_code, job_code, sum(salary),
        case
        --grouping(c1) : c1의 집계부분인지 0,1로 확인됨.
        --0 : 해당 컬럼으로 grouping 안된 상태.
        --1 : 해당 컬럼으로 grouping 된 상태. 
        when grouping(dept_code)=0 and grouping(job_code) = 1   then '부서별 '
        when grouping(dept_code)=1 and grouping(job_code) = 0   then '직급 '
        when grouping(dept_code)=1 and grouping(job_code) = 1   then '총 합계'
        else '그룹별 합계'
        end as 구분
    from employee
    group by cube(dept_code, job_code)
    order by 1;
    
    
select dept_code, job_code, sum(salary),
        case
        --0 : 해당 컬럼으로 grouping 안된 상태.
        --1 : 해당 컬럼으로 grouping 된 상태.
        when grouping(dept_code)=0 and grouping(job_code) = 1   then '부서별 '
        when grouping(dept_code)=1 and grouping(job_code) = 0   then '직급 '
        when grouping(dept_code)=1 and grouping(job_code) = 1   then '총 합계'
        else '그룹별 합계'
        end as 구분
    from employee
    group by rollup(dept_code, job_code)
    order by 1;
--위 grouping과 비교할 것.
select dept_code, sum(salary) from employee group by dept_code;


-- \\\LAG()이전값, ///LEAD()다음값
select emp_name, dept_code, salary,
        lag(salary,1,0) over (order by salary) "이전값",
        --2번째 매개인자 : 몇행 이전인지 나타냄. 1. 이전행, 2. 전전행
        --3번째 매개인자 : 이전행이 없다면 출력할 값을 작성 (이전행 있다면 이전행값)
        --1 : 위의 행 값, 0 : 이전행이 없으면 0 처리함
        lag(salary,1,salary) over (order by salary) "조회2",
        --이전행이 없으면 salary(현재 행의 값) 표기
        lag(salary,1,salary) over (partition by dept_code order by salary) "조회3", salary,
        --부서 그룹 안에서 다음 행 값 출력
        lead(salary,1,0) over (order by salary) "다음값"
    from employee
--    order by dept_code
;



--SQL활용(자체교제).pdf


--      분   석   함   수
--급여에 순위 매기기.
select emp_id, emp_name, salary,
        rank() over(order by salary desc) 급여순위
    from employee;
--급여 2300000 이 급여가 많은 값에서 적은 값 순으로 정렬되었을 때 순위
select rank(2300000) within group (order by salary desc) as 순위
    from employee;
--급여 전체에 순위
select emp_name, dept_code, salary,
        rank() over(order by salary desc)"순위1",
        dense_rank() over(order by salary desc)"순위2",
        dense_rank() over(partition by dept_code order by salary desc)"순위3" --그룹 안에서의 순위
    from employee
    order by 2 desc;
--rank를 이용한 top-N 분석 방법
select *
    from(select emp_name, salary, rank() over(order by salary desc)"순위" from employee)
    where 순위 <=5;  --상위 5개의 정보 조회
--급여 적은순(내림차순) 11순위에 해당하는 정보 조회
select *
    from(select emp_name,salary,rank() over(order by salary desc)"순위" from employee)
    where 순위 =11;
--부서코드가 '50'인 직원의 이름, 급여, 누적분산 을 조회
select emp_name, salary, round(cume_dist()over(order by salary),1) 누적분산
    from employee
    where dept_code='D5';
--급여를 4등급으로 분류
select emp_name, salary, ntile(4) over(order by salary) 등급
    from employee;
-- 사번, 이름, 급여, 입사일(빠른순), 순번(급여 높은순)
select emp_id, emp_name, salary, hire_date, 
        row_number() over(order by salary desc, hire_date asc)순번
    from employee;

--      집   계   함   수

--employee 테이블로부터 부서코드가 '60'인 직원들의
--사번, 급여, 해당 부서그룹(윈도우) 의 사번을 오름차순 정렬
--급여의 합계를 첫행부터 마지막행까지 구해서 win1에.
select emp_id, salary,
        sum(salary) over(partition by dept_code order by emp_id 
                            rows between unbounded preceding and unbounded following) "win1",
                    --rows : 윈도우의 크기(여기선 부서그룹)를 물리적인 단위로 행집합 지정.
                    --unbounded preceding : 윈도우의 첫 행
                    --unbounded following : 윈도우의 마지막 행
        sum(salary) over(partition by dept_code order by emp_id 
                            rows between unbounded preceding and current row) "win2",
                    --윈도우의 첫 행부터 현재 위치까지.
        sum(salary) over(partition by dept_code order by emp_id 
                            rows between current row and unbounded following) "win3"
                    --윈도우의 현재 위치부터 마지막 행까지.
    from employee
    where dept_code = 'D5'
;
select emp_id, salary, sum(salary) over(partition by dept_code order by emp_id 
                                            rows between 1 preceding and 1 following)"win1",
                                            --현재 행을 중심으로 이전행부터 다음행의 급여 합계
                       sum(salary) over(partition by dept_code order by emp_id
                                            rows between 1 preceding and current row)"win2",
                                            --이전 행부터 현재 행까지의 급여 합계
                       sum(salary) over(partition by dept_code order by emp_id
                                            rows between current row and 1 following)"win3"
                                            --현재 행을 중심으로 다음 행까지의 급여 합계
    from employee
    where dept_code='D5'
;

--RATIO_TO_REPORT : 해당 구간에서 차지하는 비율

--직원들의 총급여를 20,000,000원 증가 시킬 때, 기존 월급비율을 적용하여 각 직원이 받게 될 급여의 증가액은?
select emp_name, salary, lpad(trunc(ratio_to_report(salary) over() *100,0),5)||'%' 비율,
        to_char(trunc(ratio_to_report(salary) over()*20000000,0),'L00,999,999') "추가로 받게될 급여"
    from employee;
    
--LAG (조회 범위, 이전 위치, 기준 현재 위치) : 지정하는 컬럼의 현재 행을 기준으로 이전 행의 값을 조회함.
select emp_name, dept_code, salary, 
        lag(salary,1,0) over(order by salary) 이전값,
        -- 1 : 위의 행 값,  0 : 이전행이 없으면 0 처리.
        lag(salary,1,salary) over(order by salary) "조회2",
        -- 이전행이 없으면 현재 행의 값을 출력
        lag(salary,1,salary) over(partition by dept_code order by salary) "조회3"
        -- 부서 그룹 안에서의 이전 행 값 출력
    from employee
    order by dept_code;
            
--Lead (조회할 범위, 다음행 수, 0 또는 컬럼명) : 다음 행의 값 조회
select emp_name, dept_code, salary,
        lead(salary,1,0) over(order by salary