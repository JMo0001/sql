-- SQL01_select(basic)

-- 1. 학과 이름과 계열
select department_name "학과 명", category 계열
    from tb_department
;

--2. 학과의 학과 정원
select department_name||'의 정원은'||capacity||' 명 입니다.' "학과별 정원"
    from tb_department
;

--3. 국어국문학과, 휴학중인 여학생을 찾아달라
select s.student_name
    from tb_student s
    join tb_department d using(department_no)
    where department_no =001 and s.absence_yn like 'Y' and substr(s.student_ssn,8,1) =2
;

--4. 도서관 대출 도서 장기 연체자 이름
select student_name
    from tb_student
    where student_no in('A513079', 'A513090', 'A513091', 'A513110', 'A513119') 
;

--5. 입학정원이 20~30 이하인 학과들의 이름과 계열
select department_name, category
    from tb_department
    where capacity between 20 and 30
;
--6 총장의 이름
select professor_name
    from tb_professor
    where department_no is null
;

--7. 전산 착오로 학과 지정 안된 학생 찾기
select student_name
    from tb_student
    where department_no is null
;

--8. 선수과목이 존재하는 과목들의 과목번호
select class_no
    from tb_class
    where PREATTENDING_CLASS_NO is not null
;

--9. 대학에는 어떤 계열이 있는가
select distinct category
    from tb_department
;

--10. 02 학번 전주 거주자 학번, 이름, 주민번호(휴학 제외)
select student_no, student_name, student_ssn
    from tb_student
    where substr(entrance_date,1,2)=02 and student_address like '전주%' and ABSENCE_YN like'N'
    ;
    
--SQL02_select(function)

--1. 영어영문학과 학생들의 학번 이름, 입학년도 (입학년도 빠른순)
select student_no, student_name, entrance_date
    from tb_student
    where department_no like '002'
    order by entrance_date asc
;

--2. 교수중 이름이 세 글자가 아닌 교수의 이름, 주민번호
select professor_name, professor_ssn
    from tb_professor
    where length(professor_name) <> 3
;

--3 남자 교수들의 이름과 나이 (나이 적은 사람부터)
select professor_name, floor(months_between(to_date(substr(professor_ssn,1,6),'yy/mm/dd'), sysdate)/12) "나이"
    from tb_professor
    where substr(professor_ssn,8,1) = 1
    order by "나이" asc
;

--4 교수들의 이름 중 성을 제외한 이름만 출력
select substr(professor_name, 2) 이름
    from tb_professor
;

--5 재수생 입학자 (19살은 재수 아님)

select student_no, student_name
    from tb_student
    where floor(months_between(entrance_date, to_date(substr(student_ssn, 1,6),'rr/mm/dd'))/12)>19
;

--6 2020년 크리스마스는?
select to_char(to_date(('2020/12/25'),'yyyy/mm/dd'),'yyyy/mm/dd, day') from dual;

--7. 
select to_char(to_date('99/10/11','yy/mm/dd'),'yyyy/mm/dd') from dual;
select to_char(to_date('49/10/11','yy/mm/dd'),'yyyy/mm/dd') from dual;
select to_char(to_date('99/10/11','rr/mm/dd'), 'yyyy/mm/dd') from dual;
select to_char(to_date('49/10/11','rr/mm/dd'),'yyyy/mm/dd') from dual;
--to_date('99/10/11','yy/mm/dd') 는 2099년
--to_date('49/10/11','yy/mm/dd') 는 2049년
--to_date('99/10/11','rr/mm/dd') 는 1999년
--to_date('49/10/11','rr/mm/dd') 는 2049년

--8. 2000년도 이후 입학자들은 학번이 A로 시작. 2000년도 이전 입학 학생들의 학번과 이름
select student_no, student_name
    from tb_student
    where student_no not like 'A%'
;

--9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하기 점수 반올림하여 소수점 이하 1자리까지
select round(avg(point),1) 평점
    from tb_grade
    where student_no ='A517178'
    group by student_no
;

--10 학과별 학생수를 구하여 학과번호, 학생수의 형태로 출력"
select department_no "학과번호" , count(department_no) "학생수(명)"
    from tb_student
    group by department_no
    order by "학과번호" asc
;

--11 지도교수 배정 못받은 학생의 수
select count(*)
    from tb_student
    where COACH_PROFESSOR_NO is null
;

--12 학번이 A112113인 김고운 학생의 년도 별 평점 점수는 반올림하여 소수점 이하 1자리
select substr(term_no,1,4) "년도", round(avg(point), 1) "년도 별 평점"
    from tb_grade
    where student_no = 'A112113'
    group by substr(term_no,1,4)
;

--13 학과 별 휴학생 수
select department_no, count(student_no)
    from tb_student
    where ABSENCE_YN='Y'
    group by department_no
    order by department_no asc
;

--14 동명이인 학생의 이름 찾기
select student_name, count(student_name)
    from tb_student
    group by student_name
    having count(student_name) =2
;

--15 학번이 A112113인 김고운 학생의 년, 학기별 평점과 년도 별 누적 평점, 총 평점 ( 소수점 1자리까지 반올림)
select substr(term_no,1,4) "년도", nvl(substr(term_no,5,2),' ') "학기", round(avg(point),1) "누적평점"
    from tb_grade
    where student_no = 'A112113'
    group by rollup(substr(term_no,1,4), substr(term_no,5,2))
    order by "년도"
;

--SQL03_select(option)

--1. 학생 이름과 주소지
select student_name "학생 이름", student_address "주소지"
    from tb_student
    order by "학생 이름" asc
;

--2 휴학중인 학생들의 이름과 주민번호 나이가 적은 순
select student_name, student_ssn
    from tb_student
    where ABSENCE_YN ='Y'
    order by student_ssn desc
;

--3 주소지 강원, 경기 학새을 중 1900년대 학번을 가진 학생의 이름, 학번, 주소 (이름 오름차순 순)
select student_name "학생이름", student_no "학번", student_address "거주지 주소"
    from tb_student
    where student_no not like 'A%' and substr(student_address,1,3) in('경기도', '강원')
    order by student_address asc
;

--4. 법학과 교수 중 나이가 많은 사람부터 이름 확인
select p.professor_name, p.professor_ssn
    from tb_professor p
    join tb_department d using(department_no)
    where d.department_name = '법학과'
    order by professor_ssn asc
;

--5. 2004년 2학기에 C3118100 과목 수강한 학생들의 학점
select student_no, point, class_no
    from tb_grade
    where class_no = 'C3118100' and term_no = '200402'
    order by point desc
;

--6. 학생 번호, 학생 이름, 학과 이름 학생 이름 오름차순 순
select s.student_no, s.student_name, d.department_name
    from tb_student s
    join tb_department d using(department_no)
    order by student_name asc
;

--7. 과목 이름, 학과 이름 출력
select c.class_name, d.department_name
    from tb_department d
    join tb_class c using(department_no)
;

--8. 과목별 교수 이름
select c.class_name, p2.professor_name
    from tb_class c
    join tb_class_professor p1 using(class_no)
    join tb_professor p2 using(professor_no)
;

--9. 8번 결과 중 '인문사회' 과목 교수 이름 찾기
select class_name, professor_name
    from(select * from tb_professor 
            join tb_department using(department_no))
    join(select * from tb_class 
            join tb_class_professor using(class_no))
    using(professor_no)
    where category ='인문사회'
;

--10. 음악학과 학생들의 학번, 이름, 전체평점(소수점 1자리까지 반올림)
select student_no "학번", student_name "이름", round(avg(point),1) "전체평점"
    from tb_student
    join tb_grade using(student_no)
    join tb_department using(department_no)
    where department_name ='음악학과'
    group by student_no, student_name
;

--11. 학번이 A313047인 학생의 학과 이름, 학생 이름, 지도교수 이름
select department_name "학과이름", student_name "학생이름", professor_name "지도교수이름"
    from tb_department 
    join tb_student using(department_no)
    join tb_professor on (professor_no = tb_student.coach_professor_no)
    where student_no = 'A313047'
;

--12 2007년도에 '인관관계론' 과목 수강한 학생 이름, 수강학기
select student_name, term_no
    from tb_student
    join tb_grade using(student_no)
    join tb_class using(class_no)
    where class_name = '인간관계론' and substr(term_no,1,4)='2007'    
;

--13 예체능 계열 과목 중 담당교수 없는 과목의 이름, 학과  ????  
select class_name, department_name
    from tb_department d
    join tb_class c on (d.department_no = c.department_no)
    left join tb_professor p on(p.department_no = d.department_no)
    where category = '예체능' and p.department_no is null
;
--14. 서반아어학과 지도교수게시. 학생이름, 지도교수 , 지도교수 미지정
select student_name "학생이름", case 
                        when professor_name is null then '지도교수 미지정'
                        else professor_name end "지도교수"
    from tb_student s
    left join tb_professor p on (s.COACH_PROFESSOR_NO = p.professor_no)
    order by student_no asc
;

--15. 휴학생이 아닌 학생 중 평점 4.0 이상인 학생의 학번, 이름 , 학과이름, 평점
select student_no "학번", s.student_name "이름", d.department_name "학과이름", avg(point) "평점"
    from tb_student s
    join tb_department d using(department_no)
    join tb_grade g using(student_no)
    where s.absence_yn <> 'Y'
    group by student_no, s.student_name, d.department_name
    having avg(point)>4.0
;

--16. 환경조정학과 전공과목들의 과목 별 평점
select class_no, class_name, avg(point)
    from tb_department d
    join tb_class c using(department_no)
    join tb_grade g using(class_no)
    where department_name = '환경조경학과'
    group by class_no, class_name
;
--17. 최경희 학생과 같은 과 학생들의이름, 주소
select student_name, student_address
    from tb_student s
    where department_no = (select department_no 
            from tb_student where student_name ='최경희')
;
--18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번
select student_no, student_name
    from (select student_no, s.student_name, avg(point) 
                from tb_student s
                join tb_department d using(department_no)
                join tb_grade g using(student_no)
                where department_name = '국어국문학과'
                group by student_no, student_name
                order by avg(point) desc)
    where rownum = 1
;
--19. 춘 기술대학교의 환경조경학과가 속한 계열 학과들의 학과 별 전공과목 평점 파악
select d.department_name "계열 학과명", round(avg(point),1) "전공평점"
    from tb_department d
    join tb_class c using(department_no)
    join tb_grade g using(class_no)
    where category = (select category from tb_department where department_name = '환경조경학과')
    group by department_name
;
--1
create table tb_category( name varchar2(10), use_yn char(1) default 'Y');
--2
create table tb_class_type( no varchar2(5) primary key, name varchar2(10));
--3
alter table tb_category add constraint c_name_pk primary key(name);
--4
alter table tb_class_type modify name not null;
--5
alter table tb_category modify name varchar2(20);
alter table tb_class_type modify name varchar2(20);
alter table tb_class_type modify no varchar(10);
--6
alter table tb_category rename column name to category_name;
alter table tb_class_type rename column name to class_type_name;
alter table tb_class_type rename column no to class_type_no;
--7
alter table tb_category rename constraint c_name_pk to pk_category_name;
alter table tb_class_type rename constraint SYS_C008655 to pk_class_type_no;
--8
insert into tb_category values ('공학','Y');
insert into tb_category values ('자연과학','Y');
insert into tb_category values ('의학','Y');
insert into tb_category values ('예체능','Y');
insert into tb_category values ('인문사회','Y');
commit;
--9
alter table tb_department add constraint  fk_department_category foreign key (category) references tb_category( category_name);
--10
create or replace view "VW_학생일반정보" (학번, 학생이름, 주소)
            as select student_no, student_name, student_address
                    from tb_student
;
--11
create or replace view "VW_지도면담" (학생이름, 학과이름, 지도교수이름)
            as select s.student_name, d.department_name, p.professor_name
                    from tb_student s
                    join tb_department d using (department_no)
                    join tb_professor p on (COACH_PROFESSOR_NO = professor_no)
                    order by department_name
;
--12
create or replace view "VW_학과별학생수"
            as select d.department_name, count(student_no) student_count
                    from tb_department d
                    join tb_student using(department_no)
                    group by department_name
;
--13
update VW_학생일반정보 
    set 학생이름 = '박준모' where 학번 = 'A213046';
--14
create or replace view "VW_학생일반정보" (학번, 학생이름, 주소)
            as select student_no, student_name, student_address
                    from tb_student
                    with read only
;
--15        ????
create or replace view "VW_과목별_누적_수강인원" 
            as select *
               from (select class_no, class_name, count(g.student_no) bb, rank() over(order by count(g.student_no) desc) aaa
                        from tb_class c
                        join tb_grade g using(class_no)
                        group by class_no, class_name
                    )
    where aaa<4
;
select class_no "과목번호", class_name "과목이름", bb "누적수강생수(명)"
    from (select class_no, class_name, count(g.student_no) bb, 
                    rank() over(order by count(g.student_no) desc) aaa
                from tb_class c
                join tb_grade g using(class_no)
                group by class_no, class_name
        )
    where aaa<4 
;
select substr(to_char(sysdate,'yyyymmdd'),1,4) - substr(term_no,1,4) from tb_grade
;
select to_char(sysdate,'yyyymmdd') from dual;
select substr(to_char(sysdate,'yyyymmdd'),1,4) from dual;
select substr(term_no,1,4) from tb_grade;
select count(*) from tb_grade;
select (substr(to_char(sysdate,'yyyymmdd'),1,4) - substr(term_no,1,4) ) from tb_grade;

select uq_term curr_term from (select rownum rn, uq_term from (select distinct substr(term_no,1,4) uq_term from tb_grade  order by uq_term desc)) tb1 where rn < 5
;

select class_no, class_name, cnt 
    from (select rownum rn2, class_no, cnt  
            from (select class_no, count(*) cnt 
                    from tb_grade
                    where substr(term_no,1,4) in 
                        (select uq_term curr_term 
                            from (select rownum rn1, uq_term 
                                    from (select distinct substr(term_no,1,4) uq_term 
                                            from tb_grade  order by uq_term desc)) tb1 
                            where rn1 <= 5)  --최근 5년
                    group by class_no
                    order by cnt desc
                ) 
        ) tb1
   join tb_class using (class_no)
    where rn2 <= 3;

--이전 답안
select extract(year from sysdate)-1 from dual;
-- 문제에서 원한 것
select * from 
(
SELECT 과목번호, 과목이름, "누적수강생수(명)", rownum rn
FROM (SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
      FROM TB_GRADE
           JOIN TB_CLASS USING(CLASS_NO)
      WHERE TERM_NO LIKE '2009%'
      -- substr(TERM_NO,1,4) between extract(year from sysdate)-2 and extract(year from sysdate)
            OR TERM_NO LIKE '2008%'
            OR TERM_NO LIKE '2007%'
      GROUP BY CLASS_NO, CLASS_NAME
      ORDER BY 3 DESC)
) tb1
WHERE rn <= 3;

-- 문제에 나온 결과와 똑같은 결과 만들기
SELECT 과목번호, 과목이름, "누적수강생수(명)"
FROM (SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
      FROM TB_GRADE
           JOIN TB_CLASS USING(CLASS_NO)
      WHERE TERM_NO LIKE '2009%'
            OR TERM_NO LIKE '2008%'
            OR TERM_NO LIKE '2007%'
            OR TERM_NO LIKE '2006%'
            OR TERM_NO LIKE '2005%'
      GROUP BY CLASS_NO, CLASS_NAME
      ORDER BY 3 DESC)
WHERE ROWNUM <= 3;





---05_SQL05_DML.pdf

--1
insert into tb_class_type values('01','전공필수');
insert into tb_class_type values('02','전공선택');
insert into tb_class_type values('03','교양필수');
insert into tb_class_type values('04','교양선택');
insert into tb_class_type values('05','논문지도');
commit;

--2
create table "TB_학생일반정보" as (select student_no "학번", student_name "학생이름", student_address "주소" 
                                        from tb_student);

--3
create table "TB_국어국문학과" as (select student_no "학번", student_name "학생이름",
                                    extract (year from to_date(substr(student_ssn,1,6),'rrmmdd')) "출생년도",
                                    professor_name "교수이름" 
                                    from tb_student
                                    join tb_professor on(COACH_PROFESSOR_NO = professor_no)
                                );
                                    
--4
update tb_department set capacity = floor(capacity*1.1);

--5
update tb_student set student_address = '서울시 종로구 숭인동 181-21' 
    where student_no = 'A413042';

--6
update tb_student set student_ssn = substr(student_ssn,1,6);
alter table tb_student modify student_ssn varchar(6);

--7
update tb_grade set point =3.5
    where student_no = (select student_no 
                            from tb_student s
                            join tb_department d using(department_no)
                            where s.student_name = '김명훈' and d.department_name = '의학과')
        and class_no = (select class_no
                            from tb_class
                            where class_name = '피부생리학')
        and term_no = '200501'
;

--8
delete from tb_grade
        where student_no in (select student_no 
                            from tb_grade 
                            join tb_student using(student_no) 
                            where ABSENCE_YN = 'Y');
                            
                            
                            
                            
--------------------------------------------------------------------------------------------------------

--  강사님 풀이.

--SQL03_select(option)
--3-15

select student_no, avg(point) avgpoint
    from (select * from tb_student where absence_yn<>'Y') s -- tb_student 테이블 안에서 휴학중이 아닌 사람만 골라냄.
    join tb_department d using (department_no)
    join tb_grade g using (student_no)   -- s+d에다가 g를 join. >> s의 student_no랑 겹치는 컬럼.
    group by student_no
    having avg(point) >= 4.0;   --avgpoint 별칭을 쓸 수 없음.  --avg(point) 계산을 having에서 1번, select에서 1번 총 2번 함.
---------------------
-- 서브쿼리 풀이.
select * from
(select student_no, avg(point) avgpoint
    from (select * from tb_student where absence_yn<>'Y') s -- tb_student 테이블 안에서 휴학중이 아닌 사람만 골라냄.
    join tb_department d using (department_no)
    join tb_grade g using (student_no)   -- s+d에다가 g를 join. >> s의 student_no랑 겹치는 컬럼.
    group by student_no)
    where avgpoint >= 4.0
;
------------------------------------
select  student_no, student_name, department_name, avg(point) avgpoint
    from (select * from tb_student where absence_yn<>'Y') s -- tb_student 테이블 안에서 휴학중이 아닌 사람만 골라냄.
            join tb_department d using (department_no)
            join tb_grade g using (student_no) 
    group by student_no, s.student_name, d.department_name  --동명2인 있을수 있으니 student_no 필요.
;
select s.student_name, 
            d.department_name, 
            round(avg(point),1) avgpoint   --화면에 나올떄만 round
    from (select * from tb_student where absence_yn<>'Y') s -- tb_student 테이블 안에서 휴학중이 아닌 사람만 골라냄.
            join tb_department d using (department_no)
            join tb_grade g using (student_no)   -- s+d에다가 g를 join. >> s의 student_no랑 겹치는 컬럼.
--student_no, student_name, d.departemtn_name는 join 결과 같은 값으로 묶임. select 사용 가능하도록 group by로 묶음.
    group by student_no, s.student_name, d.department_name  --동명2인 있을수 있으니 student_no 필요.
    having avg(point) >= 4.0    --round 하면 안됨. 3.99 가 4.0으로 반올림 되기 때문에 추출되선 안됨.
    --평점에 필요한 grade는 join 필요. department join 해야 하나?
    -- 4.0 미만인데 join 해놀 필요가 있나? ㅇㅇ. 스칼라 서브쿼리 쓰면? 아래 참고.
;
----------
select s.student_name, 
--      group by 사용시 group by에 사용한 컬럼명만 select에 사용할 수 있음 + 그룹함수 사용 가능. >> 스칼라 서브쿼리? 안됨.
        (select department_name from tb_department t where t.department_no = s.department_no) department_name
--  메인쿼리에서 group by 에 묶인 컬럼명, 그룹함수 밖에 select에 못쓴다. >> 스칼라 서브쿼리 사용이 안됨.
        , round(avg(point),1) avgpoint   --화면에 나올떄만 round
    from (select * from tb_student where absence_yn<>'Y') s 
            join tb_grade g using (student_no)  
    group by student_no, s.student_name 
    having avg(point) >= 4.0
    --평점에 필요한 grade는 join 필요. department join 해야 하나?
    -- 4.0 미만인데 join 해놀 필요가 있나? >> 스칼라 서브쿼리 사용하면? 4.0인 인원들 중에서 골라올 수 있다.
;


----------------------------------------------------------------------------------------------------------

--3-18
select tb2.* from
(select rownum rn, tb1.*
    from (select student_name, avg(point) avgpoint
            from (select * from tb_student where department_no = 
                                                (select department_no from tb_department 
                                                    where department_name = '국어국문학과')
                    ) s
            join tb_grade g using(student_no)
            group by student_no, student_name
            order by avgpoint desc
        ) tb1
) tb2      
where rn =1
;
--------------------------------------------KH---------------------------------------------------------
--04_KH_join및 서브쿼리 문제
--4-10
select tb2.* from
(
select tb1.*, rownum rn from
(
select emp_id, emp_name,(select dept_title from department d where dept_id = e.dept_code ) "부서 명",job_code
        , hire_date, salary*12+(salary*12*nvl(bonus, 0)) salrank
    from employee e
    order by salrank) tb1
    ) tb2
where rn <= 5
;
select emp_id, salary*12+(salary*12*nvl(bonus, 0)) salrank from employee order by salrank desc; 
select decode(bonus,null,0,bonus) from employee;
    
-- 입사일 순서가 빠른 사람 3명을 조회해 주세요.
select * from
(
select rownum rn, tb1.* from
(
select emp_id, emp_name, hire_date "입사일"
    from employee
    order by "입사일"
    )tb1
)tb2
where rn <= 3

;
select tb1.* from
(
select * from employee order by hire_date asc
)tb1
where rownum <=3
;

------------------------------------춘대학교------------------------------------------------------------
--SQL_04_DDL
--15

desc tb_class;
desc tb_student;
-----------------------
--04-15
--최근 3년
select term curr_term from(select distinct substr(term_no,1,4) term from tb_grade order by term desc)tb1 where rownum <= 3
;
--수강인원 (class_no 별로)
select count(*) cnt, class_no
    from tb_grade
    group by class_no
    order by cnt desc
;
--수강인원 top3==> N-Top 방식 (class_no 별)
select * from
(
select count(*) cnt, class_no from tb_grade group by class_no order by cnt desc
)
where rownum <=3
;

--수강인원을 구하기 전, 최근 3년이라는 조건으로 걸러낸 후에 수강인원 구해야 함.
select cnt, class_no, (select class_name from tb_class where class_no=tb2.class_no) class_name from
(
select rownum rn, tb1.* from
(
select count(*) cnt, class_no
    from tb_grade
    where substr(term_no,1,4) in 
    (select term curr_term from(select distinct substr(term_no,1,4) term from tb_grade order by term desc)tb1 where rownum <= 5)
    group by class_no
    order by cnt desc
    )tb1
)tb2
where rn <=3
;