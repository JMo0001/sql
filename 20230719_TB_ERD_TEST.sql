DROP TABLE "TB_GRADE";
DROP TABLE "TB_CLASS_PROFESSOR";
DROP TABLE "TB_STUDENT";
DROP TABLE "TB_CLASS";
DROP TABLE "TB_PROFESSOR";
DROP TABLE "TB_DEPARTMENT";

CREATE TABLE "TB_DEPARTMENT" (
	"DEPARTMENT_NO"	VARCHAR2(10)		NOT NULL,
	"DEPARTMENT_NAME"	VARCHAR2(20)		NOT NULL,
	"CATEGORY"	VARCHAR2(20)		NULL,
	"OPEN_YN"	CHAR(1)		NULL,
	"CAPACITY"	NUMBER		NULL
);

COMMENT ON COLUMN "TB_DEPARTMENT"."DEPARTMENT_NO" IS '학과 번호 000';
COMMENT ON COLUMN "TB_DEPARTMENT"."DEPARTMENT_NAME" IS '학과 이름';
COMMENT ON COLUMN "TB_DEPARTMENT"."CATEGORY" IS '계열';
COMMENT ON COLUMN "TB_DEPARTMENT"."OPEN_YN" IS 'Y/N';
COMMENT ON COLUMN "TB_DEPARTMENT"."CAPACITY" IS '정원';

CREATE TABLE "TB_PROFESSOR" (
	"PROFESSOR_NO"	VARCHAR2(10)		NOT NULL,
	"PROFESSOR_NAME"	VARCHAR2(30)		NOT NULL,
	"PROFESSOR_SSN"	VARCHAR2(14)		NULL,
	"PROFESSOR_ADDRESS"	VARCHAR2(100)		NULL,
	"DEPARTMENT_NO"	VARCHAR2(10)		NOT NULL
);

COMMENT ON COLUMN "TB_PROFESSOR"."PROFESSOR_NO" IS '교수번호';
COMMENT ON COLUMN "TB_PROFESSOR"."PROFESSOR_NAME" IS '이름';
COMMENT ON COLUMN "TB_PROFESSOR"."PROFESSOR_SSN" IS '6자리 || - || 7자리';
COMMENT ON COLUMN "TB_PROFESSOR"."PROFESSOR_ADDRESS" IS '주소';
COMMENT ON COLUMN "TB_PROFESSOR"."DEPARTMENT_NO" IS '학과 번호 000';

CREATE TABLE "TB_CLASS" (
	"CLASS_NO"	VARCHAR2(10)		NOT NULL,
	"PREATTENDING_CLASS_NO"	VARCHAR2(10)		NULL,
	"CLASS_NAME"	VARCHAR2(30)		NOT NULL,
	"CLASS_TYPE"	VARCHAR2(15)		NULL,
	"DEPARTMENT_NO"	VARCHAR2(10)		NOT NULL
);

COMMENT ON COLUMN "TB_CLASS"."CLASS_NO" IS '과목 번호';
COMMENT ON COLUMN "TB_CLASS"."PREATTENDING_CLASS_NO" IS '선수 과목 번호';
COMMENT ON COLUMN "TB_CLASS"."CLASS_NAME" IS '과목 이름';
COMMENT ON COLUMN "TB_CLASS"."CLASS_TYPE" IS '과목 구분';
COMMENT ON COLUMN "TB_CLASS"."DEPARTMENT_NO" IS '학과 번호 000';

CREATE TABLE "TB_STUDENT" (
	"STUDENT_NO"	VARCHAR2(10)		NOT NULL,
	"STUDENT_NAME"	VARCHAR2(30)		NOT NULL,
	"STUDENT_SSN"	VARCHAR2(14)		NULL,
	"STUDENT_ADDRESS"	VARCHAR2(100)		NULL,
	"ENTRANCE_DATE"	DATE		NULL,
	"ABSENCE_YN"	CHAR(1)		NULL,
	"Field"	VARCHAR(255)		NULL,
	"DEPARTMENT_NO"	VARCHAR2(10)		NOT NULL,
	"COACH_PROFESSOR_NO"	VARCHAR2(10)		NOT NULL
);

COMMENT ON COLUMN "TB_STUDENT"."STUDENT_NO" IS '학번 YYYYNNNN 구성';
COMMENT ON COLUMN "TB_STUDENT"."STUDENT_NAME" IS '학생 이름';
COMMENT ON COLUMN "TB_STUDENT"."STUDENT_SSN" IS '6자리 || - || 7자리';
COMMENT ON COLUMN "TB_STUDENT"."STUDENT_ADDRESS" IS '주소';
COMMENT ON COLUMN "TB_STUDENT"."ENTRANCE_DATE" IS 'YYYYMMDD';
COMMENT ON COLUMN "TB_STUDENT"."ABSENCE_YN" IS 'Y / N';
COMMENT ON COLUMN "TB_STUDENT"."DEPARTMENT_NO" IS '학과 번호 000';
COMMENT ON COLUMN "TB_STUDENT"."COACH_PROFESSOR_NO" IS '지도 교수 번호';

CREATE TABLE "TB_CLASS_PROFESSOR" (
	"CLASS_NO"	VARCHAR2(10)		NOT NULL,
	"PROFESSOR_NO"	VARCHAR2(10)		NOT NULL
);

COMMENT ON COLUMN "TB_CLASS_PROFESSOR"."CLASS_NO" IS '과목 번호';
COMMENT ON COLUMN "TB_CLASS_PROFESSOR"."PROFESSOR_NO" IS '교수번호';

CREATE TABLE "TB_GRADE" (
	"TERM_NO"	VARCHAR2(10)		NOT NULL,
	"STUDENT_NO"	VARCHAR2(10)		NOT NULL,
	"CLASS_NO"	VARCHAR2(10)		NOT NULL,
	"POINT"	NUMBER(3,2)		NULL
);

COMMENT ON COLUMN "TB_GRADE"."TERM_NO" IS '학기 번호';
COMMENT ON COLUMN "TB_GRADE"."STUDENT_NO" IS '학번 YYYYNNNN 구성';
COMMENT ON COLUMN "TB_GRADE"."CLASS_NO" IS '과목 번호';
COMMENT ON COLUMN "TB_GRADE"."POINT" IS '학점';

ALTER TABLE "TB_STUDENT" ADD CONSTRAINT "PK_TB_STUDENT" PRIMARY KEY (
	"STUDENT_NO"
);

ALTER TABLE "TB_PROFESSOR" ADD CONSTRAINT "PK_TB_PROFESSOR" PRIMARY KEY (
	"PROFESSOR_NO"
);

ALTER TABLE "TB_DEPARTMENT" ADD CONSTRAINT "PK_TB_DEPARTMENT" PRIMARY KEY (
	"DEPARTMENT_NO"
);

ALTER TABLE "TB_CLASS" ADD CONSTRAINT "PK_TB_CLASS" PRIMARY KEY (
	"CLASS_NO"
);

ALTER TABLE "TB_CLASS_PROFESSOR" ADD CONSTRAINT "PK_TB_CLASS_PROFESSOR" PRIMARY KEY (
	"CLASS_NO",
	"PROFESSOR_NO"
);

ALTER TABLE "TB_GRADE" ADD CONSTRAINT "PK_TB_GRADE" PRIMARY KEY (
	"TERM_NO",
	"STUDENT_NO",
	"CLASS_NO"
);

ALTER TABLE "TB_STUDENT" ADD CONSTRAINT "FK_TB_DEPARTMENT_TO_TB_STUDENT_1" FOREIGN KEY (
	"DEPARTMENT_NO"
)
REFERENCES "TB_DEPARTMENT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "TB_STUDENT" ADD CONSTRAINT "FK_TB_PROFESSOR_TO_TB_STUDENT_1" FOREIGN KEY (
	"COACH_PROFESSOR_NO"
)
REFERENCES "TB_PROFESSOR" (
	"PROFESSOR_NO"
);

ALTER TABLE "TB_PROFESSOR" ADD CONSTRAINT "FK_TB_DEPARTMENT_TO_TB_PROFESSOR_1" FOREIGN KEY (
	"DEPARTMENT_NO"
)
REFERENCES "TB_DEPARTMENT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "TB_CLASS" ADD CONSTRAINT "FK_TB_DEPARTMENT_TO_TB_CLASS_1" FOREIGN KEY (
	"DEPARTMENT_NO"
)
REFERENCES "TB_DEPARTMENT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "TB_CLASS_PROFESSOR" ADD CONSTRAINT "FK_TB_CLASS_TO_TB_CLASS_PROFESSOR_1" FOREIGN KEY (
	"CLASS_NO"
)
REFERENCES "TB_CLASS" (
	"CLASS_NO"
);

ALTER TABLE "TB_CLASS_PROFESSOR" ADD CONSTRAINT "FK_TB_PROFESSOR_TO_TB_CLASS_PROFESSOR_1" FOREIGN KEY (
	"PROFESSOR_NO"
)
REFERENCES "TB_PROFESSOR" (
	"PROFESSOR_NO"
);

ALTER TABLE "TB_GRADE" ADD CONSTRAINT "FK_TB_STUDENT_TO_TB_GRADE_1" FOREIGN KEY (
	"STUDENT_NO"
)
REFERENCES "TB_STUDENT" (
	"STUDENT_NO"
);

ALTER TABLE "TB_GRADE" ADD CONSTRAINT "FK_TB_CLASS_TO_TB_GRADE_1" FOREIGN KEY (
	"CLASS_NO"
)
REFERENCES "TB_CLASS" (
	"CLASS_NO"
);

insert into tb_department (department_no, department_name, category, open_yn, capacity)
                values ('001','국어국문학과','인문사회','Y','20');
insert into tb_department (department_no, department_name, category, open_yn, capacity)
                values ('002','영어영문학과','인문사회','Y','36');
commit;

insert into tb_professor (professor_no, professor_name, professor_ssn, professor_address, department_no)
                values ('p095','노현주','650330-2117560','서울시 영등포구 대림동 755-6','001');
insert into tb_professor (professor_no, professor_name, professor_ssn, professor_address, department_no)
                values ('p109','서준원','560409-2113517','경기도 부천시 원미구 상동 반달A 1821-609','002'); 
commit;

insert into tb_class (class_no, department_no, preattending_class_no, class_name, class_type)
                values ('c0245500','001',null,'고전기사론특강','전공선택');
insert into tb_class (class_no, department_no, preattending_class_no, class_name, class_type)
                values ('c0405000','001',null,'국어어휘론특강','전공선택');
commit;

insert into tb_student (student_no, department_no, student_name, student_ssn, 
                          student_address, entrance_date, absence_yn, coach_professor_no)
                values ('A213046','001','서가람','830530-2124663','경기도 군포시 산본동 1053번지 대림아파트',
                        to_date('01-03-2002','dd-mm-yyyy'),'N','p095');
insert into tb_student (student_no, department_no, student_name, student_ssn, 
                          student_address, entrance_date, absence_yn, coach_professor_no)
                values ('A445008','002','남가영','860510-2120325','인천광역시 남동구 구월1동 1129-5',
                        to_date('01-03-2004','dd-mm-yyyy'),'Y','p109');
commit;

insert into tb_class_professor (class_no, professor_no)
                values ('c0245500','p095');
insert into tb_class_professor (class_no, professor_no)
                values ('c0405000','p109'); 
commit;

insert into tb_grade (term_no, student_no, class_no, point)
                values ('200601','A445008','c0245500',1.5);
insert into tb_grade (term_no, student_no, class_no, point)
                values ('200602','A445008','c0405000',3.5);  
commit;


-- dictionary 찾기
--insert into tb_professor (professor_no, professor_name, professor_ssn, professor_address, department_no)
--                values ('p095','노현주','650330-2117560','서울시 영등포구 대림동 755-6','001')
--오류 보고 -
--ORA-00001: 무결성 제약 조건(KH.PK_PROFESSOR)에 위배됩니다.
select * from user_constraints where constraint_name='PK_PROFESSOR';
select * from tb_professor;
select * from user_constraints where constraint_name='FK_TB_DEPARTMENT_TO_TB_PROFESSOR_1';
select * from user_cons_columns where constraint_name = 'PK_PROFESSOR';
--ORA-02297: 무결성 제약조건(KH.FK_TB_DEPARTMENT_TO_TB_PROFESSOR_1)에 위배되었습니다- 부모 키가 없습니다.
--FK라는 뜻. >> CONSTRAINT_TYPE = R == REFERRENCE = FOREIGN KEY >> R.CONSTRAINT_KEY 에 PK가 어느 테이블인지 나옴.
--  PK에 연결이 안됨. >> CONS_COLUMNS 체크 >> PK가 어느 컬럼에 걸려있는지 나옴.