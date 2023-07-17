select * from emp;
savepoint c1;
update emp set ename='EJ11' where empno=8005;
savepoint c2;
update emp set ename='EJ12' where empno=8005;
savepoint c3;
update emp set ename='EJ14' where empno=8005;

rollback to c1;
rollback to c2;
rollback to c3;
commit;

create view view_emp10
    as 
    select max(sal) maxsal, job from emp group by job;
select*from view_emp10;
--insert into view_emp10;