DROP TABLE "ATTACHE_FILE";
DROP TABLE "BOARD_READ_RECORD";
DROP TABLE "BOARD";
DROP TABLE "MEMBER";


CREATE TABLE "MEMBER" (
	"MID"	VARCHAR2(20)		NOT NULL,
	"MPWD"	VARCHAR2(20)		NOT NULL,
	"MNAME"	VARCHAR2(50)		NOT NULL,
	"MEMAIL"	VARCHAR2(150)		NOT NULL
);

COMMENT ON COLUMN "MEMBER"."MID" IS '아이디';

COMMENT ON COLUMN "MEMBER"."MPWD" IS '패스워드';

COMMENT ON COLUMN "MEMBER"."MNAME" IS '이름';

COMMENT ON COLUMN "MEMBER"."MEMAIL" IS '이메일-아이디,비밀번호찾기';


CREATE TABLE "BOARD" (
	"BNO"	NUMBER		NOT NULL,
	"BTITLE"	VARCHAR2(300)		NOT NULL,
	"BCONTENT"	VARCHAR2(4000)		NULL,
	"BWRITE_DATE"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"MID"	VARCHAR2(20)		NOT NULL,
	"BREF"	NUMBER		NOT NULL,
	"BRE_LEVEL"	NUMBER		NOT NULL,
	"BRE_STEP"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "BOARD"."BNO" IS 'SEQ_BOARD_BNO 사용';

COMMENT ON COLUMN "BOARD"."BTITLE" IS '제목';

COMMENT ON COLUMN "BOARD"."BCONTENT" IS '글내용';

COMMENT ON COLUMN "BOARD"."BWRITE_DATE" IS '작성시간';

COMMENT ON COLUMN "BOARD"."MID" IS '작성자';

COMMENT ON COLUMN "BOARD"."BREF" IS 'BNO=BREF:원본글, BNO<>BREF:답..글';

COMMENT ON COLUMN "BOARD"."BRE_LEVEL" IS '0:원본글, 1:답글, 2:답답글...';

COMMENT ON COLUMN "BOARD"."BRE_STEP" IS '0:원본글, 1-N 원본글기준답..글들의순서';


CREATE TABLE "BOARD_READ_RECORD" (
	"BNO"	NUMBER		NOT NULL,
	"MID"	VARCHAR2(20)		NOT NULL,
	"READ_DATE"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL
);

COMMENT ON COLUMN "BOARD_READ_RECORD"."BNO" IS 'SEQ_BOARD_BNO 사용';

COMMENT ON COLUMN "BOARD_READ_RECORD"."MID" IS '조회한사람';

COMMENT ON COLUMN "BOARD_READ_RECORD"."READ_DATE" IS '조회시간';


CREATE TABLE "ATTACHE_FILE" (
	"FILEPATH"	VARCHAR2(512)		NOT NULL,
	"BNO"	NUMBER		NOT NULL
);


ALTER TABLE "ATTACHE_FILE" ADD CONSTRAINT "PK_ATTACHE_FILE" PRIMARY KEY (
	"FILEPATH",
	"BNO"
);





-----------------------------------
ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BNO"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MID"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"MID"
)
REFERENCES "MEMBER" (
	"MID"
);

ALTER TABLE "BOARD_READ_RECORD" ADD CONSTRAINT "FK_BOARD_TO_BOARD_READ_RECORD_1" FOREIGN KEY (
	"BNO"
)
REFERENCES "BOARD" (
	"BNO"
);

ALTER TABLE "BOARD_READ_RECORD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_READ_RECORD_1" FOREIGN KEY (
	"MID"
)
REFERENCES "MEMBER" (
	"MID"
);

ALTER TABLE "ATTACHE_FILE" ADD CONSTRAINT "FK_BOARD_TO_ATTACHE_FILE_1" FOREIGN KEY (
	"BNO"
)
REFERENCES "BOARD" (
	"BNO"
);
