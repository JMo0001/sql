alter session set "_ORACLE_SCRIPT" = true;
create user kh2 identified by kh2;
create role role_manager;
create user khl identified by khl;
create user jmo identified by jmo;

grant connect, resource to kh2;
grant connect, resource to khl;

--connect -> 롤 이름
--권한들의 묶음 = 롤
--create session -> 접속권한
--create table, alter table, drop table, create view, drop view, create sequence, alter sequence ...
--공간 space를 사용하는 권한들을 묶어서 resource 롤에 지정함.

grant create table, create view to role_manager;
--grant 권한명, 권한명, ... , 롤 명, 롤 명, ...   to 롤명, 사용자명;
grant role_manager to kh2;
grant role_manager to khl;

revoke create view from role_manager;
-- 위에 준 권한 중 create view 권한 회수