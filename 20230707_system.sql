select * from user_tables;

-- 주석
-- ctrl + / 주석 토글링
--create 명령어 - DDL 데이터 정의어.

create user c##scott identified by tiger;
drop user c##scott;
-- 21g xe버전, "_ORACLE_SCRIOPT"=ture; 셋 해줘야함.
alter session set "_ORACLE_SCRIPT"=true;

create user kh identified by kh;
create user scott identified by tiger;

--DCL
-- create session, create table 처럼 각각의 권한명을 모두 나열하여 적기 어려움...
-- 권한들을 묶어서 만들어둔 롤role을 사용하여 권한을 부여함.
-- connect - 접속 관련 권한들이 있는 role
-- resource - 자원 관련 권한들이 있는 role
grant connect, resource to c##scott, kh;
grant connect, resource to kh;
revoke connect, resource from kh;
grant connect, resource to scott, kh;
-- 21g xe버전, dba 추가
grant connect, resource, dba to scott, kh;


--select * from kh.dept;
--안됨. create public synonym dept_public for kh.dept;
create public synonym dept2_public for kh.department;
select * from dept2_public;