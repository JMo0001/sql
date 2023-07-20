--화면 설계서 기준으로 DQL / DML 작성

--UI007 화면설계서 ID    -   학생등록
-- insert student_name, department_name, student_ssn, student_address
--보여주는 화면마다 보여주는 것들이 다르다.

--UI008 학생  -   마이페이지
--select student_no, student_name, s.department_no, d.department_name, student_address, absence_yn, p.professor_name
--  from tb_student s
--  join tb_departement d using(department_no)
--  join tb_professor p on(s.corach_professor_no = p.professor_no)
--  where student_no = 'A123456'
--  열정의 애매하다.
--  department, student, professor 안에도 department_no가 있다.
--  join tb_department d on (s.departement_no = d.department_no)?

--  join 다 해놓고 where 가서 찾는다.
--  속도 느릴텐데?


--  스칼라 서브쿼리
--select student_no, student_name, s.department_no, 
--        (select department_name from tb_department d where d.department_no = s.department_no) department_name,
--        (select professor_name from tb_professor p where p.professor_no = s.coach_professor_no) professor_name
--  from tb_student s
--  where tb_student = 'A123456'

--  where 가서 학생 한명 고른 다음 select 가서 찾아온다.