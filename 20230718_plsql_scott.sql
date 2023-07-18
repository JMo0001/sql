set serveroutput on;
set serveroutput off;
begin
    dbms_output.put_line('HELLO WORLD');
    dbms_output.put_line('HELLO WORLD2');
    dbms_output.put('HELLO WORLD3');
    dbms_output.put('HELLO WORLD4');
--    dbms_output.put_line();
--ORA-06550: 줄 6, 열5:PLS-00306: 'PUT_LINE' 호출 시 인수의 갯수나 유형이 잘못되었습니다
--ORA-06550: 줄 6, 열5:PL/SQL: Statement ignored
--06550. 00000 -  "line %s, column %s:\n%s"
    dbms_output.put_line('');
end;
/

declare
    emp_id number;
    emp_name varchar2(30);
begin
    emp_id:=888;
    emp_name:='배장남';
    dbms_output.put_line('emp_id: '||emp_id);
    dbms_output.put_line('emp_name: '||emp_name);
end;
/

declare
    emp_id employee.emp_id%type;
    emp_name employee.emp_name%type;
begin
    select emp_id, emp_name
    into emp_id, emp_name
    from employee
    where emp_id = '&emp_id';
    dbms_output.put_line('emp_id: '||emp_id);
    dbms_output.put_line('emp_name: '||emp_name);
end;
/
create or replace procedure pro_dept_insert
--declare
is
    maxdno dept.deptno%type;
    dno dept.deptno%type;
--    dnm dept.dname%type;
--    dloc dept.loc%type;
begin
    select max(deptno) into maxdno from dept;
    insert into emp (ename, empno, deptno) values ('EJ5', maxdno+10,20);
    insert into emp (ename, empno, deptno) values ('EJ5', maxdno+20,20);
    -- procedure는 update, delete, select등 모두 활용 가능함.
    commit;
end;
/
select * from user_procedures;


create or replace procedure pro_empc1_insert
is
    maxcno emp_copy1.empno%type;
    cno emp_copy1.empno%type;
begin
    select max(empno) into maxcno from emp_copy1;
    insert into emp_copy1 (ename, empno, deptno) values ('AA1',maxcno+100,50);
end;
/

declare
    e employee%rowtype;
begin
    select * into e
    from employee
    where emp_id = '&emp_id';
    dbms_output.put_line('emp_id:'||e.emp_id);
    dbms_output.put_line('emp_name:'||e.emp_name);
    dbms_output.put_line('emp_no:'||e.emp_no);
    dbms_output.put_line('salary:'||e.salary);
end;
/  

declare
    type emp_id_table_type is table of employee.emp_id%type
    index by binary_integer;
    type emp_name_table_type is table of employee.emp_name%type
    index by binary_integer;
    
    emp_id_table emp_id_table_type;
    emp_name_table emp_name_table_type;
    
    i binary_integer:=0;
begin
    for k in(select emp_id, emp_name from employee)loop
                i:=i+1;
                emp_id_table(i) := k.emp_id;
                emp_name_table(i) := k.emp_name;
    end loop;
    for j in 1..i loop
        dbms_output.put_line
            ('emp_id:'||emp_id_table(j)||', emp_name:'||emp_name_table(j));
    end loop;    
end;
/

declare
    type emp_record_type is record
            (emp_id employee.emp_id%type, emp_name employee.emp_name%type,
                dept_title department.dept_title%type,
                job_name job.job_name%type);
    emp_record emp_record_type;
begin
    select emp_id, emp_name, dept_title, job_name into emp_record
        from employee e, department d, job j
        where e.dept_code = d.dept_id and e.job_code = j.job_code
                and emp_name = '&emp_name';
    
    dbms_output.put_line('사번:'||emp_record.emp_id);
    dbms_output.put_line('이름:'||emp_record.emp_name);
    dbms_output.put_line('부서:'||emp_record.dept_title);
    dbms_output.put_line('직급:'||emp_record.job_name);
end;
/

declare
    emp_id employee.emp_id%type;
    emp_name employee.emp_name%type;
    salary employee.salary%type;
    bonus employee.bonus%type;
begin
    select emp_id, emp_name, salary, nvl(bonus,0)
        into emp_id, emp_name, salary, bonus
        from employee
        where emp_id='&emp_id';
        
    dbms_output.put_line('사번:'||emp_id);
    dbms_output.put_line('이름:'||emp_name);
    dbms_output.put_line('급여:'||salary);
    
    if(bonus =0)
        then dbms_output.put_line('보너스를 지급받지 않는 사원입니다.');
    end if;
    
    dbms_output.put_line('보너스율:'||bonus*100||'%');
end;
/

declare
    emp_id employee.emp_id%type;
    emp_name employee.emp_name%type;
    dept_title department.dept_title%type;
    national_code location.national_code%type;
    team varchar2(20);
begin
    select emp_id, emp_name, dept_title, national_code
        into emp_id, emp_name, dept_title, national_code
        from employee e, department d, location l
        where e.dept_code = d.dept_id and d.location_id = l.local_code
                and emp_id = '&emp_id';
    
    if(national_code = 'KO')
        then team := '국내팀';
        else team := '해외팀';
    end if;
    
    dbms_output.put_line('사번:'||emp_id);
    dbms_output.put_line('이름:'||emp_name);
    dbms_output.put_line('부서:'||dept_title);
    dbms_output.put_line('소속:'||team);
end;
/

declare
    score int;
    grade varchar2(2);
begin
    score := '&score';
    
    if score >=90 then grade := 'A';
    elsif score >=80 then grade := 'B';
    elsif score >=70 then grade := 'C';
    elsif score >=60 then grade := 'D';
    else grade := 'F';
    end if;
    
    dbms_output.put_line('당신의 점수는 '||score||'점이고, 학점은 '||grade||'학점입니다.');
end;
/

declare
    n number := 1;
begin
    loop
        dbms_output.put_line(N);
        n := n+1;
        
        if N >5 then exit;
        end if;
    end loop;
end;
/

begin
    for n in 1..5 loop
        dbms_output.put_line(n);
        end loop;
end;
/

begin
    for n in reverse 1..5 loop
        dbms_output.put_line(n);
        end loop;
end;
/

declare
    n number := 1;
begin
    while n <= 5 loop
        dbms_output.put_line(n);
        n := n+1;
    end loop;
end;
/

declare
    dup_empno exception;
    pragma exception_init(dup_empno, -00001);
begin
    update employee
    set emp_id = '&사번'
    where emp_id = 200;
exception
    when dup_empno
        then dbms_output.put_line('이미 존재하는 사번입니다.');
end;
/


--procedure 만들기
--사원번호를 전달 받아서 이름, 급여, 업무를 반환함.
create or replace procedure pro_emp_arg_test
            ( arg_empno in emp.empno%type, 
                arg_ename out emp.ename%type,
                arg_sal out emp.sal%type,
                arg_job out emp.job%type)
is

begin
    dbms_output.put_line('arg_empno: '|| arg_empno);
    select ename, sal, job into arg_ename, arg_sal, arg_job
        from emp
        where empno= arg_empno;
    dbms_output.put_line('arg_ename: '|| arg_ename);
--procedure 는 return 없음.  > 대신 배개변수에 in / out 를 설정해서 out로 설정하면 그것이 return 됨.
--function에는 return 있음.

end;
/

----바인드 변수선언
variable var_ename varchar2(30);
variable var_sal varchar2(30);
variable var_job varchar2(30);

exec pro_emp_arg_test(7788 ,:var_ename, :var_sal, :var_job );

print var_ename;



create or replace procedure select_empid
        ( arg_emp_id in employee.emp_id%type
        , arg_emp_name out employee.emp_name%type
        , arg_salary out employee.salary%type
        , arg_bonus out employee.bonus%type)
is
begin
    dbms_output.put_line('arg_emp_id: '|| arg_emp_id);
    select emp_name, salary, bonus 
    into arg_emp_name, arg_salary, arg_bonus
        from employee
        where emp_id = arg_emp_id;
end;
/

--variable var_emp_id varchar2(30);
variable var_emp_name varchar2(30);
variable var_salary number;
variable var_bonus number;

exec select_empid(200, :var_emp_name, :var_salary, :var_bonus);

desc employee;

print var_emp_name;
print var_salary;
print var_bonus;
select * from employee;



create or replace procedure pro_all_emp
is
begin
    for e in (select * from employee) loop
--        dbms_output.put_line(e.emp_name);
        select_empid(e.emp_id, e.emp_name, e.salary, e.bonus);
    end loop;
end;
/
exec pro_all_emp;


create or replace procedure kh_gugudan
is
--    n number := 1;
--    m number := 1;
begin
    for n in 2..9 loop
        for m in 1..9 loop
        dbms_output.put_line(n||'*'||m||'='||m*n);
        end loop;
    end loop;
end;
/
exec kh_gugudan;