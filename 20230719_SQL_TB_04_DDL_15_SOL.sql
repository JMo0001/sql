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
    
--------------------------------------------------------------------------------------------------

select distinct substr(term_no,1,4) uq_term
    from tb_grade 
    order by uq_term desc; -- 최근 순서 년도 확인
    
select rownum, uq_term
    from(select distinct substr(term_no,1,4) uq_term
            from tb_grade 
            order by uq_term desc)
    where rownum <= 3;   --최근 가까운 순서 3개 년도 확인 및 순번 

select class_no, count(*) cnt
    from tb_grade
    group by class_no -- 클래스 별 수강 인원 확인.
;

select class_no, count(*) cnt
    from tb_grade   -- 클래스별 수강 인원 where in 최근 가까운 순서 3개 년도.
    where substr(term_no,1,4) in (select uq_term    
                                    from(select rownum r1, uq_term
                                            from(select distinct substr(term_no,1,4) uq_term
                                                    from tb_grade 
                                                    order by uq_term desc))
                                    where r1 <= 3)
    group by class_no
    order by cnt desc   -- 수강생 많은순 내림차순
;

select rownum r2, class_no, cnt
    from (select class_no, count(*) cnt
            from tb_grade   -- 클래스별 수강 인원 where in 최근 가까운 순서 3개 년도.
            where substr(term_no,1,4) in (select uq_term    
                                            from(select rownum r1, uq_term
                                                    from(select distinct substr(term_no,1,4) uq_term
                                                            from tb_grade 
                                                            order by uq_term desc))
                                            where r1 <= 3)
            group by class_no
            order by cnt desc)
    where rownum <= 3   --등수 3등까지.
;

select class_no, class_name, cnt
    from(select rownum r2, class_no, cnt
            from (select class_no, count(*) cnt
                    from tb_grade   -- 클래스별 수강 인원 where in 최근 가까운 순서 3개 년도.
                    where substr(term_no,1,4) in (select uq_term    
                                                    from(select rownum r1, uq_term
                                                            from(select distinct substr(term_no,1,4) uq_term
                                                                    from tb_grade 
                                                                    order by uq_term desc))
                                                    where r1 <= 3)
                    group by class_no
                    order by cnt desc)
            where rownum <= 3)   --등수 3등까지.
    join tb_class using(class_no)
    where r2 <=3
;

-------------------------------------------------------------------------------------------------- 

select class_no "과목번호", class_name "과목이름", bb "누적수강생수(명)"
    from (select class_no, class_name, count(g.student_no) bb, 
                    rank() over(order by count(g.student_no) desc) aaa
                from tb_class c
                join tb_grade g using(class_no)
                group by class_no, class_name
        )
    where aaa<4 
;


----------------------------------------------------------------

--04_실습_KH_JOIN및서브쿼리_문제.pdf
--4-11.

select d.dept_title, sum(salary) "부서별 급여 합계"
    from employee e
    join department d on(e.dept_code = d.dept_id) 
    group by dept_title
    having sum(salary) > (select sum(salary)*0.2 from employee) 
;

select *
    from (select dept_title, sum(salary) sal from employee e join department d on(e.dept_code = d.dept_id)
            group by dept_title)
    where sal > (select sum(salary)*0.2 from employee)     
;

--05_실습_SQL02_SELECT(Function)).pdf 
--춘대학교-2-14
select student_name, count(student_name)
    from tb_student
    group by student_name
    having count(student_name) >= 2
;

--05_실습_SQL03_SELECT(Option).pdf
--춘대학교-3-15
select student_no "학번", s. student_name "이름", d. department_name "학과 이름", avg(point) "평점"
    from tb_student s
    join tb_department d using(department_no)
    join tb_grade g using(student_no)
    where s.absence_yn ='N'
    group by student_no, student_name, department_name
    having avg(point) >= 4.0
;

--춘대학교-3-16
select class_no, class_name, avg(point)
    from tb_class c
    join tb_department d using(department_no)
    join tb_grade g using(class_no)
    where department_name = '환경조경학과' and class_type like '전공%'
    group by class_no, class_name
;
select student_name, student_address
    from tb_student
    where department_no = (select department_no from tb_student where student_name = '최경희')
;