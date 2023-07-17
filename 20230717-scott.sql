

create sequence seq_tb1_c1 start with 10 increment by 10 maxvalue 90 minvalue 10 nocycle cache 20;

--ORA-08002: 시퀀스 SEQ_TB1_C1.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다
--08002. 00000 -  "sequence %s.CURRVAL is not yet defined in this session"
-- nextval 먼저 하고 할 수 있다.
select seq_tb1_c1.currval from dual;

--ORA-08004: 시퀀스 SEQ_TB1_C1.NEXTVAL exceeds MAXVALUE은 사례로 될 수 없습니다
--08004. 00000 -  "sequence %s.NEXTVAL %s %sVALUE and cannot be instantiated"
--maxvalue 90 추가된 경우.
select seq_tb1_c1.nextval from dual;

--ROLE 객체
--접소고강련 설정 -> oracle 12 이후 버전에서 false 상태로 접속됨.
alter session set "_ORACLE_SCRIPT" = true;
create role role_scott_manager;