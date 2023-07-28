desc member;

insert into MEMBER values ('kh1', '11', 'kh1name', 'kh1@a.co.kr')
;
insert into MEMBER values ('admin', 'admin', 'adminname', 'admin@a.co.kr')
;
insert into MEMBER values ('biz1', '11', 'bizname', 'biz1@a.co.kr')
;

drop sequence SEQ_BOARD_BNO;
create sequence SEQ_BOARD_BNO;
delete from board;


--원본글
desc board;
insert into BOARD values(SEQ_BOARD_BNO.nextval, 'title1', 'content1', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0)
;
insert into BOARD values(SEQ_BOARD_BNO.nextval, 'title2', 'content2', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0)
;
insert into BOARD values(SEQ_BOARD_BNO.nextval, 'title3', 'content3', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0)
;
insert into BOARD values(SEQ_BOARD_BNO.nextval, 'title4', 'content4', default, 'kh1', SEQ_BOARD_BNO.nextval, 0,0)
;
--원1 - 답글
insert into BOARD values(SEQ_BOARD_BNO.nextval, '1-답', '1-답', default, 'kh1', 1, 1 ,1)
;
--원1-5 5답-답답글
insert into BOARD values(SEQ_BOARD_BNO.nextval, '5-답', '5-답', default, 'kh1', 1, 2 ,2)
;
--원1 - 답글
update board set BRE_STEP = BRE_STEP +1 where BRE_STEP > 0;
insert into BOARD values(SEQ_BOARD_BNO.nextval, '1-답', '1-답', default, 'kh1', 1, 1 ,0+1)
;
--원1 -7 -답답글
update board set BRE_STEP = BRE_STEP +1 where BRE_STEP > 1;
insert into BOARD values(SEQ_BOARD_BNO.nextval, '1-답', '1-답', default, 'kh1', 1, 1+1 ,1+1)
;

--n 글의 답글
update board set BRE_STEP = BRE_STEP +1 
    where BRE_STEP > (SELECT BRE_STEP FROM BOARD WHERE BNO = '&n글')
        and BREF = (select bref from board where bno = '&n글')
;
insert into BOARD values (SEQ_BOARD_BNO.nextval, '&n글 제목', '&n글 내용', default, 'khl'
    , (select bref from board where bno = '&n글')
    , (select bre_level+1 from board where bno = '&n글')
    , (select bre_step+1 from board where bno = '&n글')
    )
;

desc board;



select BNO, BTITLE, to_char(BWRITE_DATE), MID, BREF, BRE_LEVEL, BRE_STEP
    from board order by bref desc, bre_step asc;


commit
;

--원본글
--insert into BOARD values(SEQ_BOARD_BNO.nextval, ?, ?, default, ?, SEQ_BOARD_BNO.nextval, 0,0)
----n 글의 답글

--update board set BRE_STEP = BRE_STEP +1 where BRE_STEP > (SELECT BRE_STEP FROM BOARD WHERE BNO = ?) and BREF = (select bref from board where bno = ?)

--insert into BOARD values (SEQ_BOARD_BNO.nextval, ?, ?, default, ?, (select bref from board where bno = ?), (select bre_level+1 from board where bno = ?), (select bre_step+1 from board where bno = ?))
    
;