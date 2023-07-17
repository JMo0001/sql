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
select substr(term_no,1,4) "년도", substr(term_no,5,2) "학기", avg(point) "평점" 
    from tb_grade 
    where student_no = 'A112113'
    group by term_no
;
select substr(term_no,1,4) "년도", round(avg(point),1) "누적평점"
    from tb_grade
    where student_no = 'A112113'
    group by substr(term_no,1,4)
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
