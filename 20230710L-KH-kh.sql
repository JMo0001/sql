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
--20230712
--실습 문항 풀이
-- 2. 16. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
select emp_id, emp_no, substr(emp_no,1,7), rpad(substr(emp_no,1,7),14,'*')
    from employee
;


SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY GROUPING SETS((DEPT_CODE, JOB_code, MANAGER_ID),
    (DEPT_CODE, MANAGER_ID), 
    (JOB_CODE, MANAGER_ID))
;
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE, JOB_code, MANAGER_ID
;
desc user_constraints;

create table USER_NOTNULL(
    user_no number not null,
    user_id varchar2(20) 
    -- not null과의 사이에다가 constraints
    not null,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
    );
    
insert into user_notnull values(1, 'usr01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
--insert into user_notnull values(2, null,null,null,null,'010-1234-5678', 'hong123@kh.or.kr');

create table user_unique(
    user_no number,
    user_id varchar2(20) -- 여기에 constraits
    unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phonbe varchar2(30),
    email varchar2(50)
    );

insert into user_unique values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
insert into user_unique values(1, 'user01', 'pass01',null,null,'010-1234-5678', 'hong123@kh.or.kr');

create table user_unique2(
    user_no number,
    user_id varchar2(20),
    usr_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    unique(user_id) -- 테이블 레벨
    );
insert into user_unique2 values(1,'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong@kh.or.kr');
insert into user_unique2 values(1,'user01', 'pass01',null,null,'010-1234-5678','hong@kh.or.kr');
insert into user_unique2 values(1,null,'pass01', '홍길동', '남', '010-1234-5678', 'hong@kh.or.kr');
insert into user_unique2 values(1,null,'pass01', '홍길동', '남', '010-1234-5678', 'hong@kh.or.kr');

create table user_unique3(
    user_no number,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    unique (user_no, user_id)
    );
insert into user_unique3 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
insert into user_unique3 values(2, 'user01', 'pass01', null,null,'010-1234-5678', 'hong123@kh.or.kr');
insert into user_unique3 values(2, 'user02', 'pass02', null,null,'010-1234-5678', 'hong123@kh.or.kr');
insert into user_unique3 values(1, 'user01', 'pass01', null,null,'010-1234-5678', 'hong123@kh.or.kr');

create table user_primarykey(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
    );
insert into user_primarykey values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
insert into user_primarykey values(1, 'user02', 'pass02', '이순신', '남', '010-1234-5678', 'lee123@kh.or.kr');
insert into user_primarykey values(null, 'user03', 'pass03', '유관순', '여', '010-1234-5678', 'yoo123@kh.or.kr');

create table user_primarykey2(
    user_no number,
    user_id varchar2(20),
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    primary key (user_no, user_id)
    );
insert into user_primarykey2 values(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr');
insert into user_primarykey2 values(1, 'user02', 'pass02', '이순신', '남', '010-5678-9012', 'lee123@kh.or.kr');
insert into user_primarykey2 values(2, 'user01', 'pass01', '유관순', '여', '010-3131-3131', 'yoo123@kh.or.kr');
insert into user_primarykey2 values(1, 'user01', 'pass01', '신사임당', '여', '010-1111-1111', 'shin123@kh.or.kr');

drop table user_grade;
create table user_grade(
    grade_code number primary key,
    grade_name varchar2(30) not null
    );
insert into user_grade values(10,'일반회원');
insert into user_grade values(20,'우수회원');
insert into user_grade values(30,'특별회원');
select * from user_grade;

drop table user_foreignkey;
create table user_foreignkey(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    grade_code number,
        -- 여기 constraints 이름 정해주기. >> 디버깅 편함
        -- FK_user_foreignkey_grade_code_user_grade
        -- 자동생성 > sys_000000
    constraint FK_user_foreignkey_grade_code_user_grade1 foreign key (grade_code) 
            references user_grade(grade_code)on delete cascade
    );
insert into user_foreignkey values(1,'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr',10);
insert into user_foreignkey values(2,'user02', 'pass02', '이순신', '남', '010-9012-3456', 'lee123@kh.or.kr',20);
insert into user_foreignkey values(3,'user03', 'pass03', '유관순', '여', '010-3131-3131', 'yoo123@kh.or.kr',30);
insert into user_foreignkey values(4,'user04', 'pass04', '신사임당', '여', '010-1111-1111', 'shin123@kh.or.kr',null);
insert into user_foreignkey values(5,'user05', 'pass05', '안중근', '남', '010-4444-4444', 'ahn123@kh.or.kr',50);

drop table user_foreignkey2;
create table user_foreignkey2(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    grade_code number 
        constraint FK_user_foreignkey2_grade_code_user_grade
        references user_grade(grade_code) 
--    grade_code number references user_grade(grade_code) on delete cascade
    );
insert into user_foreignkey2 values(1,'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@kh.or.kr',10);
insert into user_foreignkey2 values(2,'user02', 'pass02', '이순신', '남', '010-9012-3456', 'lee123@kh.or.kr',20);
insert into user_foreignkey2 values(3,'user03', 'pass03', '유관순', '여', '010-3131-3131', 'yoo123@kh.or.kr',30);
insert into user_foreignkey2 values(4,'user04', 'pass04', '신사임당', '여', '010-1111-1111', 'shin123@kh.or.kr',null);
insert into user_foreignkey2 values(5,'user05', 'pass05', '안중근', '남', '010-4444-4444', 'ahn123@kh.or.kr',50);

delete from user_grade where grade_code=10;
--오류 보고 
--ORA-02292: 무결성 제약조건(KH.SYS_C008424)이 위배되었습니다- 자식 레코드가 발견되었습니다
select * from user_constraints;
select * from user_foreignkey;
select * from user_foreignkey2;



create table user_check(
    user_no number primary key,
    user_id varchar2(20) unique,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10) check(gender in('남', '여')),
    phone varchar2(30),
    email varchar2(50)
--    ,check(gender in('남', '여')) check() 괄호 안에 어떤것이 들어가는지 이미 써져 있다.(gender)
    );
insert into user_check values(1, 'uwer01', 'pass01', '홍길동', '남자', '010-1234-5678', 'hong123@kh.or.kr');

create table employee_copy
    as select emp_id, emp_name, salary, dept_title, job_name
    from employee
    left join department on(dept_code=dept_id)
    left join job using(job_code);
    
insert into employee
values(1,'홍길동','820114-1010101','hong_kd@kh.or.kr','01099998888','D5','J2','S4',3800000,null,'200',sysdate,null,default);

update employee
set emp_id=290
where emp_name='홍길동';

delete from employee
where emp_name='홍길동';

insert into employee(emp_id, emp_name,emp_no,email,phone,dept_code,job_code,sal_level,
                        salary,bonus,manager_id,hire_date,ent_date,ent_yn)
values(900,'장채현','901123-1080503','jang_ch@kh.or.kr','01055569512','D1','J8','S3',4300000,0.2,'200',sysdate,null,default);

create table emp_01(emp_id number,
                    emp_name varchar2(30),
                    dept_title varchar2(20)
                    );
insert into emp_01(
    select emp_id, emp_name, dept_title
    from employee
    left join department on (dept_code = dept_id)
    );
    
create table emp_dept_d1 
    as select emp_id, emp_name, dept_code, hire_date
    from employee
    where 1=0;
create table emp_manager
    as select emp_id, emp_name, manager_id
    from employee
    where 1=0;
    
insert all
into emp_dept_d1 values(emp_id,emp_name,dept_code,hire_date)
into emp_manager values(emp_id,emp_name,manager_id)
    select emp_id, emp_name, dept_code, hire_date, manager_id
    from employee
    where dept_code='D1';
    
create table emp_old
    as select emp_id, emp_name, hire_date, salary
    from employee
    where 1=0;
create table emp_new
    as select emp_id, emp_name, hire_date, salary
    from employee
    where 1=0;
    
insert all
when hire_date < '2000/01/01' then into emp_old values(emp_id, emp_name, hire_date, salary)
when hire_date >='2000/01/01' then into emp_new values(emp_id, emp_name, hire_date, salary)
select emp_id, emp_name, hire_date, salary
from employee;

create table dept_copy
as select * from department;

update dept_copy
    set dept_title = '전략기획팀'
    where dept_id = 'D9';
    
create table emp_salary
    as select emp_id, emp_name, dept_code, salary, bonus
    from employee;
    
select * from emp_salary
    where emp_name in('유재식', '방명수');
    
update emp_salary
set salary = (select salary from emp_salary where emp_name='유재식'),
    bonus = (select bonus from emp_salary where emp_name='유재식')
    where emp_name='방명수';

update emp_salary
    set (salary, bonus) = (select salary, bonus from emp_salary where emp_name = '유재식')
    where emp_name = '방명수';
select * from emp_salary
where emp_name in ('유재식', '방명수');

update emp_salary
    set bonus = 0.3
    where emp_id in (select emp_id from employee 
                        join department on(dept_id = dept_code)
                        join location on(location_id = local_code)
                        where local_name like 'ASIA%');

delete from employee where emp_name = '장채현';
delete from department where dept_id = 'D1';    --ppt 7 > 13page fk오류난다고 나와있으나 지워짐. fk로 안들어갔나?
select * from user_constraints order by table_name desc;    -- 제약조건 확인  > 후에 kh 파일 들어가서 create department 하던 시점 확인
select * from user_cons_columns order by table_name desc;   -- 제약조건 확인

--  ppt7 > 14page 애초에 조건이 없음.
delete from department where dept_id = 'D1';
alter table employee disable constraint emp_deptcode_fk_cascade;

truncate table emp_salary;
select * from emp_salary;
rollback;


-- ppt8 DDL

alter table dept_copy add(cname varchar2(20));
alter table dept_copy add(lname varchar2(40) default '한국');
alter table dept_copy
--    add constraint dcopy_did_pk primary key(dept_id);
--    add constraint dcopy_dtitle_unq unique(dept_title);
    modify lname constraint dcopy_lname_nn not null;
    
select uc.constraint_name, uc.constraint_type, uc.table_name, ucc.column_name, uc.search_condition
        from user_constraints uc
            join user_cons_columns ucc on (uc.constraint_name = ucc.constraint_name)
        where uc.table_name = 'DEPT_COPY';

alter table dept_copy
    modify dept_id char(3)
    modify dept_title varchar(30)
    modify location_id varchar2(2)
    modify cname char(20)
    modify lname default '미국';
alter table dept_copy
    drop column dept_id;

create table tb1(pk number primary key,
                    fk number references tb1,
                    col1 number,
                    check(pk > 0 and col1 > 0)
                    );
alter table tb1
    drop column pk;
alter table tb1
    drop column pk cascade constraints;
    
alter table dept_copy
--    drop constraint dcopy_did_pk
--    drop constraint dcopy_dtitle_unq
    modify lname null;
    
alter table dept_copy
    rename column dept_title to dept_name;
    
alter table user_foreignkey
    rename constraint SYS_C008483 to uf_up_nn;
alter table user_foreignkey
    rename constraint SYS_C008484 to uf_un_pk;
alter table user_foreignkey
    rename constraint SYS_C008485 to uf_ui_uq;
alter table user_foreignkey
    rename constraint FK_USER_FOREIGNKEY_GRADE_CODE_USER_GRADE1 to uf_gc_fk;
    
select uc.constraint_name 이름,
    uc.constraint_type 유형,
    ucc.column_name 컬럼명,
    uc.r_constraint_name 참조,
    uc.delete_rule 삭제규칙
    from user_constraints uc
    join user_cons_columns ucc on (uc.constraint_name = ucc.constraint_name)
    where uc.table_name = 'USER_FOREIGNKEY';
alter table dept_copy
rename to dept_test;

drop table dept_test cascade constraints;

create or replace view v_employee 
    as select emp_id, emp_name, dept_title, national_name
        from employee
        left join department on(dept_id = dept_code)
        left join location on(location_id = local_code)
        left join national using(national_code);
select * from v_employee;


create or replace view v_emp_job(사번,이름,직급,성별,근무년수)
    as select emp_id, emp_name, job_name, 
        decode(substr(emp_no,8,1),1,'남',2,'여'),
        extract(year from sysdate)-extract(year from hire_date)
        from employee
        join job using(job_code);

create or replace view v_job(job_code,job_name)
    as select job_code, job_name
        from job ;
--        join job using(job_code);
        
insert into v_job values('J8','인턴');
select * from v_job;

create or replace view v_job2
    as select job_code
        from job;
--insert into v_job2 values('J8','인턴');

create or replace view v_job3
 as select job_name
        from job;
delete from v_job3 where job_name ='인턴';

create or replace view emp_sal
    as select emp_id, emp_name, salary, (salary+(salary*nvl(bonus,0)))*12 연봉
        from employee;
--insert into emp_sal values(800, '정진훈', 3000000, 4000000);

create or replace view v_groupdept
    as select dept_code, sum(salary) 합계, avg(salary) 평균
        from employee group by dept_code;
--delete from v_groupdept where dept_code = 'D1';

create or replace view v_dt_emp
    as select distinct job_code
        from employee;
--insert into v_dt_emp values('J9');
--delete from v_dt_emp where job_code = 'J1';

create or replace view v_joinemp
    as select emp_id, emp_name, dept_title
        from employee
            join department on(dept_code = dept_id);
--insert into v_joinemp values(888,'조세오', '인사관리부');

select * from user_views;


--20230714 수업

select * from v_emp_job;
select extract (year from sysdate) from dual;
select extract (month from sysdate) from dual;
select extract (day from sysdate) from dual;

--9.view4.pdf 5page 예시3
--ORA-00918: 열의 정의가 애매합니다
--00918. 00000 -  "column ambiguously defined"
--CREATE OR REPLACE VIEW V_JOB(사번, 이름, 직급, 성별, 근무년수)
CREATE OR REPLACE VIEW V_JOB(job_code, job_name)
    AS SELECT j1.JOB_code, j1.JOB_NAME
    FROM JOB j1
    JOIN JOB j2 
        on j1.job_code = j2.job_code
--        USING(JOB_CODE)
;
    -- self join 은 반드시 table 별칭
select * from job;
INSERT INTO V_JOB VALUES('J8', '인턴');
commit;

create or replace view v_job2(job_code)
    as select job_code from job
;
insert into v_job2 values('J9');


--실습 04.join및 서브쿼리 문제 pdf 
--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회 

select * from
    (select emp_id, emp_name, d.dept_title, j.job_name
        , extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'rr')) age
        from employee e
        join department d on(e.dept_code = d.dept_id)
        join "JOB" j using (job_code)) tb1
    where age = (select min(extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'rr'))) from employee)
;

select min(extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'rr'))) minage
    from employee;
    


select extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'rr')) 
    from employee;
        
select emp_no, extract(year from to_date(substr(emp_no,1,2),'yy')),
--rr 은 50을 기준으로 1951, 2049
    extract(year from to_date(substr(emp_no,1,2),'rr')),
    case
        when extract(year from sysdate) - extract(year from to_date(substr(emp_no,1,2), 'yy')) <0
        then extract(year from sysdate) - (extract(year from to_date(substr(emp_no,1,2), 'yy'))-100)
        end age
from employee;
--
select extract(year from to_date('500112','yymmdd')) yy,
        extract(year from to_date('500112','rrmmdd')) mm
    from dual;
    
    
--04--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
select emp_name, tb_d.dept_title, tb_e.job_name, tb_d.local_name, tb_d.national_name
    from 
    (select * from employee e
        join "JOB" j using(job_code)) tb_e
    join
        (select * from department d 
            join location c on(d.location_id = c.local_code)
            join national n using(national_code)
            where national_name in ('한국', '일본')
            )tb_d
        on tb_e.dept_code = tb_d.dept_id
    ;
select * from department;
select * from location;
select * from national;


--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select e1.emp_name, e2.emp_name
    from employee e1
    join employee e2 on (e1.dept_code = e2. dept_code) and e1.emp_name <> e2.emp_name
--    where e1.emp_name <> e2.emp_name 
    order by e1.emp_name
;
select emp_name, dept_code from employee;

--2.kh_select.pdf
--21. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이(만) 조회
--(단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며
--나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)

select emp_name
    , to_date(substr(emp_no,1,6),'rrmmdd')
    , to_char(to_date(substr(emp_no,1,6),'rrmmdd'),'yy"년" mm"월" dd"일"')"생년월일"
    , floor((sysdate - to_date(substr(emp_no,1,6), 'rrmmdd'))/365) "만나이"
    from employee;
    
    
create synonym emp for employee;
select * from emp;

select * from dept2_public;

grant select on department to scott;