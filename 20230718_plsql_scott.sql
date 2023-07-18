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