/************* 예시 데이터 삽입 전에 이미 존재하는 데이터 삭제 ************/ 
DROP TABLE TB_CUST CASCADE CONSTRAINTS; 
DROP TABLE TB_BADGE CASCADE CONSTRAINTS;
DROP TABLE TB_CUST_BADGE CASCADE CONSTRAINTS; 
DROP TABLE TB_BOARD CASCADE CONSTRAINTS;
DROP TABLE TB_COMMENT CASCADE CONSTRAINTS; 
DROP TABLE TB_PRD CASCADE CONSTRAINTS; 
DROP TABLE TB_DEAL CASCADE CONSTRAINTS;
DROP TABLE TB_CUST_LIKE CASCADE CONSTRAINTS; 
DROP TABLE TB_PRD_QNA CASCADE CONSTRAINTS; 
DROP TABLE TB_IMG CASCADE CONSTRAINTS ; 

DROP SEQUENCE SEQ_BOARD_ID; 
DROP SEQUENCE SEQ_COMMENT_ID;
DROP SEQUENCE SEQ_QNA_NO;
DROP SEQUENCE SEQ_IMG_NO;
DROP SEQUENCE SEQ_PRD_ID;
DROP SEQUENCE SEQ_DEAL_ID ; 




/******************************************************/


/*******************테이블 생성**********************/
--회원 정보 
CREATE TABLE TB_CUST (
	CUST_ID	    VARCHAR2(20)  		    NOT NULL,
	CUST_NAME	VARCHAR2(100)		    NOT NULL,
	PASSWD	    VARCHAR2(300)		    NOT NULL,
	BIRTH_DY	VARCHAR2(8)		        NULL,
	JOIN_DT	    DATE		            NOT NULL,
	DEL_YN	    VARCHAR2(3)	DEFAULT 'N'	NOT NULL,
    MONEY       NUMBER      DEFAULT 0   NOT NULL, 
	STOP_YN	    VARCHAR2(3)	DEFAULT 'N'	NOT NULL, 
	STOP_REL_DY	VARCHAR2(8)	            NULL,
	ACT_POINT	NUMBER		DEFAULT 0   NOT NULL,
	PHONE_NO	VARCHAR2(20)		    NULL,
	ADDR	    VARCHAR2(300)		    NULL
); 
 
--배지 정보  
CREATE TABLE TB_BADGE (
	BADGE_ID	    VARCHAR2(10)		NOT NULL,
	BADGE_NAME	    VARCHAR2(200)		NOT NULL,
	BADGE_CONDITION	VARCHAR2(1000)		NOT NULL,
	REG_DT	        DATE		        NOT NULL
);

--회원이획득한배지정보
CREATE TABLE TB_CUST_BADGE (
	BADGE_ID	    VARCHAR2(10)		NOT NULL,
	CUST_ID	        VARCHAR2(20)		NOT NULL,
	BADGE_GET_DT	DATE		        NOT NULL
);

--등록된 상품 정보
CREATE TABLE TB_PRD (
	PRD_ID	 VARCHAR2(100)		        NOT NULL,
	REG_ID	 VARCHAR2(20)		        NOT NULL,
	PRD_NAME VARCHAR2(300)		        NOT NULL,
    PRD_DETAIL VARCHAR2(4000)           NULL, 
	PRD_AMT	 NUMBER		                NOT NULL,
	PRD_TYPE VARCHAR2(50)		        NOT NULL,
	REG_DT	 DATE		                NOT NULL,
	SOLD_OUT_YN	 VARCHAR2(3)   DEFAULT 'N'	NOT NULL
);


--회원이 상품을 찜한 정보 
CREATE TABLE TB_CUST_LIKE (
	CUST_ID	    VARCHAR2(20)	NOT NULL,
    PRD_ID	    VARCHAR2(100)	NOT NULL,
	REG_DT	    DATE	    	NOT NULL
);

--상품 구매 리뷰 정보
CREATE TABLE TB_PRD_QNA (
	QNA_NO	        NUMBER		    NOT NULL,
	CUST_ID	        VARCHAR2(20)	NOT NULL,
	PRD_ID	        VARCHAR2(100) 	NOT NULL,
	QNA_TITLE	    VARCHAR2(300)	NOT NULL,
	QNA_CONTENT	    VARCHAR2(4000)	NOT NULL,
	REG_DT	        DATE	        NOT NULL, 
    QNA_ANSWER      VARCHAR2(4000)  NULL , 
    ANSWER_DT       DATE            NULL 
);


--게시판 정보
CREATE TABLE TB_BOARD (
	BOARD_ID	    VARCHAR2(30)        NOT NULL,
	CUST_ID	        VARCHAR2(20)		NOT NULL,
	BOARD_TITLE	    VARCHAR2(300)		NOT NULL,
	BOARD_CONTENT	VARCHAR2(4000)		NULL,
	REG_DT	        DATE	        	NOT NULL,
	REPORT_CNT	    NUMBER	DEFAULT 0	NOT NULL,
	HIT_CNT	        NUMBER	DEFAULT 0	NOT NULL
);

--댓글 정보
CREATE TABLE TB_COMMENT (
	COMMENT_ID	    VARCHAR2(30)        NOT NULL,
	UPPER_ID	    VARCHAR2(30)	    NOT NULL,
	CUST_ID	        VARCHAR2(20)	    NOT NULL,
	COMMENT_CONTENT	VARCHAR2(4000)	    NOT NULL,
	REG_DT	        DATE		        NOT NULL,
	REPORT_CNT	    NUMBER DEFAULT 0	NOT NULL
);


-- 거래 내역
CREATE TABLE TB_DEAL (
    DEAL_ID     VARCHAR2(30)        NOT NULL, 
	BUY_ID	    VARCHAR2(20)		NOT NULL, --구매자ID 
	PRD_ID	    VARCHAR2(100)		NOT NULL, --상품ID  
	DEAL_DT	    DATE		        NOT NULL 
);

-- 이미지 통합 정보
CREATE TABLE TB_IMG (
    IMG_NO     NUMBER           NOT NULL , 
    IMG_DV     VARCHAR2(20)     NOT NULL , 
    IMG_IDENT  VARCHAR2(100)    NOT NULL , 
    IMG_PATH   VARCHAR2(400)    NOT NULL , 
    REG_DT     DATE             NOT NULL 
); 

/*******************테이블 코멘트 생성**********************/

COMMENT ON COLUMN TB_CUST.CUST_ID IS '회원아이디';
COMMENT ON COLUMN TB_CUST.CUST_NAME IS '회원이름';
COMMENT ON COLUMN TB_CUST.PASSWD IS '비밀번호'; 
COMMENT ON COLUMN TB_CUST.BIRTH_DY IS '생일(YYYYMMDD)';
COMMENT ON COLUMN TB_CUST.JOIN_DT IS '가입일시';
COMMENT ON COLUMN TB_CUST.DEL_YN IS '탈퇴여부(기본은 N)';
COMMENT ON COLUMN TB_CUST.MONEY IS '보유금액 (가입시 0)';
COMMENT ON COLUMN TB_CUST.STOP_YN IS '신고당하면 정지여부가 Y가 됨 (기본은 N)';
COMMENT ON COLUMN TB_CUST.STOP_REL_DY IS '신고당한 경우 정지가 해제되는 일자';
COMMENT ON COLUMN TB_CUST.ACT_POINT IS '활동포인트 (가입시 0)';
COMMENT ON COLUMN TB_CUST.PHONE_NO IS '회원휴대폰번호(최대1개만 받는다고 가정)-안그럼정규화';
COMMENT ON COLUMN TB_CUST.ADDR IS '회원주소정보(최대1개만받는다고 가정) - 안그럼 정규화';

COMMENT ON COLUMN TB_BADGE.BADGE_ID IS '배지ID';
COMMENT ON COLUMN TB_BADGE.BADGE_NAME IS '배지명';
COMMENT ON COLUMN TB_BADGE.BADGE_CONDITION IS '배지를 획득할 수 있는 조건';
COMMENT ON COLUMN TB_BADGE.REG_DT IS '배지를 등록한 일시';

COMMENT ON COLUMN TB_CUST_BADGE.BADGE_ID IS '배지ID';
COMMENT ON COLUMN TB_CUST_BADGE.CUST_ID IS '회원아이디';
COMMENT ON COLUMN TB_CUST_BADGE.BADGE_GET_DT IS '배지획득일시';

COMMENT ON COLUMN TB_PRD.PRD_ID IS '상품ID';
COMMENT ON COLUMN TB_PRD.REG_ID IS '해당상품을등록한회원ID';
COMMENT ON COLUMN TB_PRD.PRD_NAME IS '상품이름';
COMMENT ON COLUMN TB_PRD.PRD_DETAIL IS '상품상세설명';
COMMENT ON COLUMN TB_PRD.PRD_AMT IS '상품가격';
COMMENT ON COLUMN TB_PRD.PRD_TYPE IS '상품타입';
COMMENT ON COLUMN TB_PRD.REG_DT IS '해당상품이등록된시점';
COMMENT ON COLUMN TB_PRD.SOLD_OUT_YN IS '품절(OUT OF STOCK) 여부 - 기본 N';

COMMENT ON COLUMN TB_CUST_LIKE.CUST_ID IS '회원아이디';
COMMENT ON COLUMN TB_CUST_LIKE.PRD_ID IS '상품 구분 ID';
COMMENT ON COLUMN TB_CUST_LIKE.REG_DT IS '상품을 찜한 일시';

COMMENT ON COLUMN TB_PRD_QNA.QNA_NO IS '문의를 구분하는 번호';
COMMENT ON COLUMN TB_PRD_QNA.CUST_ID IS '문의하는 회원아이디';
COMMENT ON COLUMN TB_PRD_QNA.PRD_ID IS '상품을 구분하는 ID';
COMMENT ON COLUMN TB_PRD_QNA.QNA_TITLE IS '문의제목';
COMMENT ON COLUMN TB_PRD_QNA.QNA_CONTENT IS '문의내용';
COMMENT ON COLUMN TB_PRD_QNA.REG_DT IS '문의 등록 일시';
COMMENT ON COLUMN TB_PRD_QNA.QNA_ANSWER IS '문의 답변 ';
COMMENT ON COLUMN TB_PRD_QNA.ANSWER_DT IS '문의 답변한 일시';


COMMENT ON COLUMN TB_BOARD.BOARD_ID IS '게시판ID (B0000001 등)';
COMMENT ON COLUMN TB_BOARD.CUST_ID IS '회원아이디';
COMMENT ON COLUMN TB_BOARD.BOARD_TITLE IS '게시물제목';
COMMENT ON COLUMN TB_BOARD.BOARD_CONTENT IS '게시물내용';
COMMENT ON COLUMN TB_BOARD.REG_DT IS '게시물을 등록한 일시';
COMMENT ON COLUMN TB_BOARD.REPORT_CNT IS '신고당한횟수 (기본 0)';
COMMENT ON COLUMN TB_BOARD.HIT_CNT IS '조회수 (기본 0)';

COMMENT ON COLUMN TB_COMMENT.COMMENT_ID IS '댓글ID';
COMMENT ON COLUMN TB_COMMENT.UPPER_ID IS '상위번호(게시물이면 B로 시작 ,  대댓글이면 CM으로시작 )';
COMMENT ON COLUMN TB_COMMENT.CUST_ID IS '회원아이디';
COMMENT ON COLUMN TB_COMMENT.COMMENT_CONTENT IS '댓글내용';
COMMENT ON COLUMN TB_COMMENT.REG_DT IS '댓글을 등록한 일시';
COMMENT ON COLUMN TB_COMMENT.REPORT_CNT IS '신고당한횟수 (기본 0)';

COMMENT ON COLUMN TB_DEAL.DEAL_ID IS '거래ID';
COMMENT ON COLUMN TB_DEAL.BUY_ID IS '구매자ID';
COMMENT ON COLUMN TB_DEAL.PRD_ID IS '상품ID';
COMMENT ON COLUMN TB_DEAL.DEAL_DT IS '거래완료일시';

COMMENT ON COLUMN TB_IMG.IMG_NO IS '이미지번호';
COMMENT ON COLUMN TB_IMG.IMG_DV IS '이미지구분';
COMMENT ON COLUMN TB_IMG.IMG_IDENT IS '이미지식별값 (리뷰면 리뷰번호 , 상품이면 상품ID , 회원이면 회원ID';
COMMENT ON COLUMN TB_IMG.IMG_PATH IS '이미지경로';
COMMENT ON COLUMN TB_IMG.REG_DT IS '이미지등록일시';




/*******************테이블 PRIMARY KEY 제약조건 **********************/
ALTER TABLE TB_CUST ADD CONSTRAINT PK_CUST PRIMARY KEY (CUST_ID);
ALTER TABLE TB_BADGE ADD CONSTRAINT PK_BADGE PRIMARY KEY (BADGE_ID);
ALTER TABLE TB_CUST_BADGE ADD CONSTRAINT PK_CUST_BADGE PRIMARY KEY (BADGE_ID , CUST_ID);
ALTER TABLE TB_BOARD ADD CONSTRAINT PK_BOARD PRIMARY KEY (BOARD_ID);
ALTER TABLE TB_COMMENT ADD CONSTRAINT PK_COMMENT PRIMARY KEY (COMMENT_ID);
ALTER TABLE TB_DEAL ADD CONSTRAINT PK_DEAL PRIMARY KEY (DEAL_ID);
ALTER TABLE TB_PRD ADD CONSTRAINT PK_PRD PRIMARY KEY (PRD_ID);
ALTER TABLE TB_CUST_LIKE ADD CONSTRAINT PK_CUST_LIKE PRIMARY KEY (CUST_ID , PRD_ID);
ALTER TABLE TB_PRD_QNA ADD CONSTRAINT PK_PRD_QNA PRIMARY KEY (QNA_NO);
ALTER TABLE TB_IMG ADD CONSTRAINT PK_IMG PRIMARY KEY (IMG_NO);



/*******************테이블 FOREIGN KEY 제약조건 **********************/

--회원이 삭제될 경우 획득한 뱃지 정보를 모두 삭제한다. 
ALTER TABLE TB_CUST_BADGE ADD CONSTRAINT FK_CUST_BADGE_1 
FOREIGN KEY(CUST_ID) REFERENCES TB_CUST (CUST_ID) ON DELETE CASCADE ; 

--배지 정보가 삭제시 획득한 배지 정보를 모두 삭제한다. (이후 공지사항 작성 등이 필요) 
ALTER TABLE TB_CUST_BADGE ADD CONSTRAINT FK_CUST_BADGE_2 
FOREIGN KEY(BADGE_ID) REFERENCES TB_BADGE (BADGE_ID) ON DELETE CASCADE ; 

--회원이 삭제될 경우 작성한 게시물 정보를 모두 삭제한다. 
ALTER TABLE TB_BOARD ADD CONSTRAINT FK_BOARD_1 
FOREIGN KEY(CUST_ID) REFERENCES TB_CUST (CUST_ID) ON DELETE CASCADE ; 

--회원이 삭제될 경우 거래내역도 함께 삭제한다. 
ALTER TABLE TB_DEAL ADD CONSTRAINT FK_DEAL_1 
FOREIGN KEY(BUY_ID) REFERENCES TB_CUST (CUST_ID) ON DELETE CASCADE ; 

--상품이 삭제될 경우 거래내역도 함께 삭제한다.
ALTER TABLE TB_DEAL ADD CONSTRAINT FK_DEAL_2 
FOREIGN KEY(PRD_ID) REFERENCES TB_PRD (PRD_ID) ON DELETE CASCADE ; 

--회원이 삭제될 경우 찜한 상품 정보도 함께 삭제한다. 
ALTER TABLE TB_CUST_LIKE ADD CONSTRAINT FK_CUST_LIKE_1  
FOREIGN KEY(CUST_ID) REFERENCES TB_CUST (CUST_ID) ON DELETE CASCADE ; 

--상품이 삭제될 경우 찜한 상품 정보도 함께 삭제한다. 
ALTER TABLE TB_CUST_LIKE ADD CONSTRAINT FK_CUST_LIKE_2  
FOREIGN KEY(PRD_ID) REFERENCES TB_PRD (PRD_ID) ON DELETE CASCADE ; 

--회원이 삭제될 경우 문의 정보를 함께 삭제한다. 
ALTER TABLE TB_PRD_QNA ADD CONSTRAINT FK_PRD_QNA_1 
FOREIGN KEY(CUST_ID) REFERENCES TB_CUST (CUST_ID) ON DELETE CASCADE ; 

--상품이 삭제될 경우 문의  정보를 함께 삭제한다. 
ALTER TABLE TB_PRD_QNA ADD CONSTRAINT FK_PRD_QNA_2 
FOREIGN KEY(PRD_ID) REFERENCES TB_PRD (PRD_ID) ON DELETE CASCADE ; 



/*******************테이블 데이터 삽입 *********************/


--TB_BADGE
INSERT INTO TB_BADGE VALUES( 'B001' , '회원가입축하해!' , '회원가입시 획득' , SYSDATE);
INSERT INTO TB_BADGE VALUES( 'B002' , '게시물작성3회달성!' , '게시물을 3회 이상 작성시 획득', SYSDATE);
INSERT INTO TB_BADGE VALUES( 'B003' , '관심상품 저장3회달성!' , '관심 상품 저장 3회 달성시 획득'  , SYSDATE);
INSERT INTO TB_BADGE VALUES( 'B004' , '포인트1000점달성!' , '활동 포인트 1000점 달성시 획득' , SYSDATE);

--TB_CUST
INSERT INTO TB_CUST (CUST_ID, CUST_NAME, PASSWD, BIRTH_DY, JOIN_DT, DEL_YN, STOP_YN , STOP_REL_DY , ACT_POINT , PHONE_NO , ADDR , MONEY ) 
SELECT 'C0001', '고객001', 'pass111', '19880101', TO_DATE('20230101051231' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 1050 ,  '010-1111-1111' , '광주광역시 남구 봉선동 254' , 10000 FROM DUAL UNION ALL 
SELECT 'C0002', '고객002', 'pass222', '19910202', TO_DATE('20230215121212' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 20000 ,  '010-2222-2222' , '광주광역시 광산구 임방울대로 12' , 10000 FROM DUAL UNION ALL
SELECT 'C0003', '고객003', 'pass333', '19920303', TO_DATE('20230320212323' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 500 ,  NULL , '광주광역시 북구 두암동 123' , 2000000 FROM DUAL  UNION ALL 
SELECT 'C0004', '고객004', 'pass444', '19930404', TO_DATE('20230425225512' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 200 ,  '010-4444-4444' , '광주광역시 서구 풍암동 52' , 15000 FROM DUAL UNION ALL 
SELECT 'C0005', '고객005', 'pass555', '19940505', TO_DATE('20230530231111' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 100 ,  NULL , '광주광역시 동구 충장로 555' , 0 FROM DUAL UNION ALL 
SELECT 'C0006', '고객006', 'pass666', '19950606', TO_DATE('20230605002312' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 0 ,   NULL , NULL , 0 FROM DUAL UNION ALL 
SELECT 'ADMIN', '관리자', 'ADMIN', '99991231', TO_DATE('20230605002312' , 'YYYYMMDDHH24MISS'), 'N', 'N' , NULL , 999999 ,   NULL , NULL , 9999999 FROM DUAL ; 



CREATE SEQUENCE SEQ_BOARD_ID INCREMENT BY 1 ; 
SELECT SEQ_BOARD_ID.NEXTVAL FROM DUAL CONNECT BY LEVEL <= 5 ; 

CREATE SEQUENCE SEQ_PRD_ID INCREMENT BY 1 ; 
SELECT SEQ_PRD_ID.NEXTVAL FROM DUAL CONNECT BY LEVEL <=19;

CREATE SEQUENCE SEQ_COMMENT_ID INCREMENT BY 1 ; 
SELECT SEQ_COMMENT_ID.NEXTVAL FROM DUAL CONNECT BY LEVEL <= 5 ; 

CREATE SEQUENCE SEQ_DEAL_ID INCREMENT BY 1; 
SELECT SEQ_DEAL_ID.NEXTVAL FROM DUAL CONNECT BY LEVEL <=5 ;


--TB_BOARD (5개 정도 넣기) 
INSERT INTO TB_BOARD ( BOARD_ID , CUST_ID , BOARD_TITLE , BOARD_CONTENT , REG_DT , REPORT_CNT , HIT_CNT ) 
VALUES ( 'B0000001' , 'C0001' , '갤탭 삽니다' , '갤럽시탭 싸게 파실 분 계신가요?? ' , TO_DATE('20230801123434' , 'YYYYMMDDHH24MISS') , 0 , 50 );

INSERT INTO TB_BOARD ( BOARD_ID , CUST_ID , BOARD_TITLE , BOARD_CONTENT , REG_DT , REPORT_CNT , HIT_CNT ) 
VALUES ( 'B0000002' , 'C0002' , '고객005 양아치입니다ㅡㅡ' , '거래와서 하는 말이 만원 깎아달라뇨..' , TO_DATE('20230802234444' , 'YYYYMMDDHH24MISS') , 0 , 23 ); 

INSERT INTO TB_BOARD ( BOARD_ID , CUST_ID , BOARD_TITLE , BOARD_CONTENT , REG_DT , REPORT_CNT , HIT_CNT ) 
VALUES ( 'B0000003' , 'C0003' , '아사히 맥주 혹시 파실 분' , '마셔보고 싶어요!!' , TO_DATE('20230802235555' , 'YYYYMMDDHH24MISS') , 0 , 7 ); 

INSERT INTO TB_BOARD ( BOARD_ID , CUST_ID , BOARD_TITLE , BOARD_CONTENT , REG_DT , REPORT_CNT , HIT_CNT ) 
VALUES ( 'B0000004' , 'C0003' , '먹태깡 혹시 파실 분' , '아사히는 구했는데 먹태깡을 팔지를 않네요..' , TO_DATE('20230803214412' , 'YYYYMMDDHH24MISS') , 0 , 50 ); 

INSERT INTO TB_BOARD ( BOARD_ID , CUST_ID , BOARD_TITLE , BOARD_CONTENT , REG_DT , REPORT_CNT , HIT_CNT ) 
VALUES ( 'B0000005' , 'C0004' , '풀충@@@매일충전가능@@@사다리타기@@@' , '아래링크클릭 http://hacker.co.kr' , TO_DATE('20230804123434' , 'YYYYMMDDHH24MISS') , 5 , 10 ) ;


--TB_COMMENT (5개 정도 넣기) 
INSERT INTO TB_COMMENT ( COMMENT_ID , UPPER_ID , CUST_ID , COMMENT_CONTENT , REG_DT , REPORT_CNT ) 
SELECT 'CM0000001' , 'B0000001' , 'C0002' , '갤탭 어떤 스펙으로 생각중이세요?' , ( SELECT REG_DT + 1/24 FROM TB_BOARD WHERE BOARD_ID = 'B0000001' ) , 0  FROM DUAL UNION ALL 
SELECT 'CM0000002' , 'B0000002' , 'C0005' , '아니 ㅡㅡ 애초에 물건이 달랐잖아요 이 새1야' , ( SELECT REG_DT + 1/24 FROM TB_BOARD WHERE BOARD_ID = 'B0000002' ) , 1  FROM DUAL UNION ALL 
SELECT 'CM0000003' , 'CM0000002', 'C0002' , '와 비속어 쓰시네요 신고합니다 ㅅㄱ ' , ( SELECT REG_DT + 2/24 FROM TB_BOARD WHERE BOARD_ID = 'B0000002' ) , 0  FROM DUAL UNION ALL 
SELECT 'CM0000004' , 'B0000005' , 'C0001' , '여기 그런곳 아닙니다~~ 이건 게시물 올리지 말아주세요' , ( SELECT REG_DT + 1/24 FROM TB_BOARD WHERE BOARD_ID = 'B0000005' ) , 0  FROM DUAL UNION ALL 
SELECT 'CM0000005' , 'CM0000004' ,  'C0004' , '풀충@@@매일충전가능@@@사다리타기@@@ 링크는 http://hacker.co.kr@@@' , ( SELECT REG_DT + 2/24 FROM TB_BOARD WHERE BOARD_ID = 'B0000005' ) , 0  FROM DUAL UNION ALL  
SELECT 'CM0000006' , 'CM0000005' ,  'C0001' , '야이' , ( SELECT REG_DT + 3/24 FROM TB_BOARD WHERE BOARD_ID = 'B0000005' ) , 0  FROM DUAL ;

COMMIT; 

INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0001', 'C0001' , '헤어드라이기' , '가전' , '머리를 아주 잘 말려주는 헤어드라이기 입니다.' , 30000 , TO_DATE('20230501122357' , 'YYYYMMDDHH24MISS') , 'N' ) ; 
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0002', 'C0001' , '에어컨', '가전', '더위를 싹 싹 날려주는 에어컨입니다.', 1500000, TO_DATE('20230501152222' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0003', 'C0001' , '세탁기', '가전', '옷을 깨끗하게 세탁해주는 세탁기입니다.', 600000, TO_DATE('20230502030212' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0004', 'C0001' , '건조기', '가전', '빠르고 간편하게 옷을 건조할 수 있는 건조기입니다.', 800000,  TO_DATE('20230502175525' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0005', 'C0001' , '노트북', '컴퓨터', '성능이 뛰어나고 가벼운 노트북입니다.', 1500000,TO_DATE('20230503235959' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0006', 'C0002' , '데스크탑', '컴퓨터', '강력한 성능을 가진 데스크탑 컴퓨터입니다.', 2000000, TO_DATE('20230503122337' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0007', 'C0002' , '태블릿', '컴퓨터', '가벼우면서도 다양한 기능을 갖춘 태블릿입니다.', 800000, TO_DATE('20230504221012' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0008', 'C0002' , '애플14', '스마트폰', '다양한 기능을 가진 스마트폰입니다.', 1200000, TO_DATE('20230504105523' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0010', 'C0003' ,'조아샴푸'  , '욕실용품' , '머리가 개운해지는 샴푸입니다.' , 20000 , TO_DATE('20230505190101' , 'YYYYMMDDHH24MISS') , 'N') ;
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0011', 'C0004' ,'주전자', '주방용품', '물을 끓이기에 적합한 주전자입니다.', 20000,  TO_DATE('20230506120000' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0012', 'C0004' ,'전기밥솥', '주방용품', '쌀맛이 좋아지는 전기밥솥입니다.', 80000, TO_DATE('20230506124728' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0013', 'C0005' , '냄비', '주방용품', '식재료를 끓이기에 적합한 냄비입니다.', 30000,  TO_DATE('20230507123456' , 'YYYYMMDDHH24MISS') , 'N');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0014', 'C0005' , '칼', '주방용품', '식재료를 자르기에 적합한 칼입니다.', 15000,  TO_DATE('20230507122357' , 'YYYYMMDDHH24MISS') , 'Y');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0015', 'C0005' , '수세미', '욕실용품', '욕실 청소에 사용되는 수세미입니다.', 5000,  TO_DATE('20230508110025' , 'YYYYMMDDHH24MISS') , 'Y');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0016', 'C0006' , '곰팡이제거제', '욕실용품', '곰팡이를 제거할 때 최고입니다.', 10000,  TO_DATE('20230508150010' , 'YYYYMMDDHH24MISS') , 'Y');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0017', 'C0006' , '샤워기', '욕실용품', '강력한 물줄기로 청결한 목욕을 즐길 수 있는 샤워기입니다.', 50000,  TO_DATE('20230509010101' , 'YYYYMMDDHH24MISS') , 'Y');
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0018', 'C0002' , '린스', '욕실용품', '찰랑거리는 머리를 가지고 싶다면 이 제품을 기억하세요' ,  20000 ,   TO_DATE('20230509001212' , 'YYYYMMDDHH24MISS') , 'Y') ; 
INSERT INTO TB_PRD(PRD_ID , REG_ID , PRD_NAME, PRD_TYPE , PRD_DETAIL , PRD_AMT  , REG_DT , SOLD_OUT_YN ) 
VALUES ('P0019', 'C0003' , '수건', '욕실용품', '호텔에서도 사용되는 고급소재의 친환경 타올 소재의 수건입니다.' , 5000,   TO_DATE('20230510215348' , 'YYYYMMDDHH24MISS') , 'Y') ; 

COMMIT; 

INSERT INTO TB_IMG (IMG_NO , IMG_DV , IMG_IDENT , IMG_PATH , REG_DT) 
SELECT 1 , 'P', 'P0001' , 'hair_dryer.png' , TO_DATE('20230501122357' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 2 , 'P', 'P0002' , 'aircool.jpg' , TO_DATE('20230501152222' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 3 , 'P', 'P0003' , 'washing_machine.png' , TO_DATE('20230502030212' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 4 , 'P', 'P0004' , 'washing_dryer.jpg' , TO_DATE('20230502175525' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 5 , 'P', 'P0005' , 'notebook.jpg' , TO_DATE('20230503235959' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 6 , 'P', 'P0006' , 'desktop.png' , TO_DATE('20230503122337' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 7 , 'P', 'P0007' , 'gall_tab.jpg' , TO_DATE('20230504221012' , 'YYYYMMDDHH24MISS')FROM DUAL UNION ALL 
SELECT 8 , 'P', 'P0008' , 'apple14.png' , TO_DATE('20230504105523' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 9 , 'P', 'P0010' , 'shampoo.png' , TO_DATE('20230505190101' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 10 , 'P', 'P0011' , 'teapot.png' , TO_DATE('20230506120000' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 11 , 'P', 'P0012' , 'cockoo.jpg' , TO_DATE('20230506124728' , 'YYYYMMDDHH24MISS')FROM DUAL UNION ALL 
SELECT 12 , 'P', 'P0013' , 'cooking_pot.png' , TO_DATE('20230507123456' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 13 , 'P', 'P0014' , 'knife.png' , TO_DATE('20230507122357' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 14 , 'P', 'P0015' , 'susemi.png' , TO_DATE('20230508110025' , 'YYYYMMDDHH24MISS')FROM DUAL UNION ALL 
SELECT 15 , 'P', 'P0016' , 'gompang.png' , TO_DATE('20230508150010' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 16 , 'P', 'P0017' , 'shower.png' , TO_DATE('20230509010101' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 17 , 'P', 'P0018' , 'linse.png', TO_DATE('20230509001212' , 'YYYYMMDDHH24MISS') FROM DUAL UNION ALL 
SELECT 18 , 'P', 'P0019' , 'towel.png' , TO_DATE('20230510215348' , 'YYYYMMDDHH24MISS') FROM DUAL;

COMMIT; 

--TB_DEAL
INSERT INTO TB_DEAL (DEAL_ID , BUY_ID , PRD_ID , DEAL_DT) 
VALUES ('D0000001' , 'C0001' , 'P0015' , (SELECT REG_DT + 1 FROM TB_PRD WHERE PRD_ID = 'P0015')) ;
INSERT INTO TB_DEAL (DEAL_ID, BUY_ID , PRD_ID ,  DEAL_DT) 
VALUES ('D0000002' , 'C0001' , 'P0016' , (SELECT REG_DT + 1 FROM TB_PRD WHERE PRD_ID = 'P0016')) ;
INSERT INTO TB_DEAL (DEAL_ID,BUY_ID , PRD_ID ,  DEAL_DT) 
VALUES ('D0000003' , 'C0004' , 'P0017'  , (SELECT REG_DT + 1 FROM TB_PRD WHERE PRD_ID = 'P0017')) ;
INSERT INTO TB_DEAL (DEAL_ID,BUY_ID , PRD_ID ,  DEAL_DT) 
VALUES ('D0000004' , 'C0005' , 'P0018' , (SELECT REG_DT + 1 FROM TB_PRD WHERE PRD_ID = 'P0018')) ;
INSERT INTO TB_DEAL (DEAL_ID, BUY_ID , PRD_ID ,  DEAL_DT) 
VALUES ('D0000005' , 'C0006' , 'P0019' , (SELECT REG_DT + 1 FROM TB_PRD WHERE PRD_ID = 'P0019')) ;

COMMIT; 


INSERT INTO TB_CUST_LIKE (CUST_ID , PRD_ID , REG_DT) 
SELECT 'C0001' , 'P0001' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0001' , 'P0005' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0001' , 'P0015' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0002' , 'P0002' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0002' , 'P0005' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0003' , 'P0010' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0001' , 'P0016' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0001' , 'P0017' , SYSDATE FROM DUAL UNION ALL 
SELECT 'C0002' , 'P0018' , SYSDATE FROM DUAL ;

CREATE SEQUENCE SEQ_QNA_NO INCREMENT BY 1 ; 
SELECT SEQ_QNA_NO.NEXTVAL FROM DUAL CONNECT BY LEVEL <= 2 ; 

CREATE SEQUENCE SEQ_IMG_NO INCREMENT BY 1; 
SELECT SEQ_IMG_NO.NEXTVAL FROM DUAL CONNECT BY LEVEL <= 18; 

COMMIT; 

INSERT INTO TB_PRD_QNA (QNA_NO , QNA_TITLE , QNA_CONTENT , REG_DT , PRD_ID , CUST_ID , QNA_ANSWER , ANSWER_DT) 
VALUES (1, '수세미 짱짱한가요' , '안녕하세요~ 수세미가 짱짱한가요?' , (SELECT REG_DT + 1/24 FROM TB_PRD WHERE PRD_ID = 'P0015') , 'P0015' , 'C0001' , NULL , NULL ); 

INSERT INTO TB_PRD_QNA (QNA_NO , QNA_TITLE , QNA_CONTENT , REG_DT , PRD_ID , CUST_ID , QNA_ANSWER , ANSWER_DT) 
VALUES (2, '곰팡이 제거제 어디서 산거에요?' , '브랜드 보고 살까말까 고민중입니다.' , (SELECT REG_DT + 1/24 FROM TB_PRD WHERE PRD_ID = 'P0016') , 'P0016' , 'C0001' , '아주좋아곰팡이브랜드입니다' , (SELECT REG_DT + 2/24 FROM TB_PRD WHERE PRD_ID = 'P0016')  ); 

COMMIT; 

--배지 처리 
INSERT INTO TB_CUST_BADGE 
SELECT 'B001' , CUST_ID , JOIN_DT + 15/24/60/60
  FROM TB_CUST; 

INSERT INTO TB_CUST_BADGE
SELECT 'B003' , CUST_ID , RN 
  FROM ( 
SELECT DISTINCT CUST_ID , MAX(REG_DT) OVER (PARTITION BY CUST_ID ORDER BY REG_DT DESC) AS RN  
  FROM TB_CUST_LIKE 
 ) ;

INSERT INTO TB_CUST_BADGE 
SELECT 'B004' , CUST_ID , SYSDATE  
  FROM TB_CUST
 WHERE ACT_POINT >= 1000 ; 

COMMIT ;


--추가 테이블 생성 (조인 이해용)  

DROP TABLE 회원; 
DROP TABLE 회원연락처 ;

CREATE TABLE 회원 ( 
    회원ID VARCHAR2(20) PRIMARY KEY , 
      이름 VARCHAR2(50) 
);
INSERT INTO 회원 
SELECT 'A0001' , '동동일' FROM DUAL UNION ALL 
SELECT 'A0002' , '동동이' FROM DUAL UNION ALL 
SELECT 'A0003' , '동동삼' FROM DUAL ;

CREATE TABLE 회원연락처 ( 
    회원ID VARCHAR2(20) ,
    구분코드 VARCHAR2(20) , 
    연락처 VARCHAR2(30) ,
    PRIMARY KEY(회원ID , 구분코드 ) 
);

INSERT INTO 회원연락처
SELECT 'A0001' , '휴대폰' , '010-111-1111' FROM DUAL UNION ALL 
SELECT 'A0001' , '집전화' , '062-111-1111' FROM DUAL UNION ALL 
SELECT 'A0002' , '집전화' , '062-222-2222' FROM DUAL UNION ALL 
SELECT 'A0004' , '휴대폰' , '010-4444-4444' FROM DUAL ;


COMMIT; 







