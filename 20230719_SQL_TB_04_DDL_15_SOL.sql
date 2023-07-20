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