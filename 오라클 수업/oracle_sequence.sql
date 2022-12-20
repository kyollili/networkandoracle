/*
    SEQUENCE : 자동 증가번호(충원은 없다) 1 2 3 4 5
                                             -- 삭제 1 2 3 5....
    --------
        MAXVALUE : 최종값
        MINVALUE : 시작값
        -------------------------------사용빈도는 거의 없다(무한대)
        START WITH : 어디서부터 시작할 것인지 설정
                START WITH 1, START WITH 100
        INCREMENT BY : 몇개씩 증가 설정
                INCREMENT BY 1 ==> 1씩 증가, INCREMENT BY 100
                                   -------- 게시물 번호, 댓글 번호, 장바구니 번호, 찜 번호...
        CACHE | NOCACHE
        -----   ------- 사용
        1~20까지 미리 번호를 저장 후에 출력 
        CYCLE | NOCYCLE
        -----   ------- 사용
        범위까지 왔을 경우 ==> 다시 처음부터 시작(1~100) ==> 100 => 1부터
        
        ***현재값 읽기 ==> currVal
        ***다음값 읽기 ==> nextVal
        
        1) 생성
            CREATE SEQUENCE seq_name
                START WITH 1
                INCREMENT BY 1
                NOCACHE
                NOCYCLE
                
        2) 삭제
            DROP SEQUENCE seq_name
        *** 시퀀스의 구분
            ------------
            테이블명_컬럼명_seq;
            
            예)
                board ==> no
                board_no_seq
                notice ==> no
                notice_no_seq
                cart ==> no
                cart_no_seq
                reserve
                -------------> CREATE를 사용할 때마다 따로 증가
                PRIMARY KEY : 각 테이블마다 데이터 무결성 ==> 반드시 한 개 이상 설정
                                                ------- 원하는 데이터만 수정, 삭제(이상현상 방지)
                    |
                대체키, 후보키는 무조건 설정하는 것이 아님 => (기본키 찾기 ==> 회원가입)
*/
CREATE SEQUENCE test_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
SELECT test_no_seq.nextVal FROM DUAL;
SELECT test_no_seq.CURRVAL FROM DUAL;
DROP SEQUENCE test_no_seq;
/*
        정형화된 데이터 : 프로그램에서 필요한 데이터만 저장 => RDBMS (오라클, MYSQL....)
        --------------데이터를 공유할 목적으로 만든다
        반정형화 : 필요없는 데이터를 포함, 구분은 되어있다(HTML,XML,JSON)
        비정형화 : 필요한 데이터, 필요없는 데이터가 섞여있다 , 구분 안되어있음(트위터,페이스북,,,)
        ------- 정형화(빅데이터) => 기계에 학습(AI)
*/
CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(4000) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);

--no 처리 (중복이 없는 데이터) => 자동으로 처리
--중복 X => 1. 테이블명 2. 컬럼명 3. 뷰명 4. 시퀀스명 5. 제약조건명
--제어가 쉽게 (수정,삭제) => 가독성
CREATE SEQUENCE board_no_seq
    START WITH 1 
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');
INSERT INTO board(no,name,subject,content,pwd)
VALUES(board_no_seq.nextVal,'홍길동','시퀀스 사용..','시퀀스 사용 방법..','1234');

COMMIT;
    
SELECT * FROM board;

DELETE FROM  board WHERE no=3;

CREATE TABLE notice(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT notice_name_nn NOT NULL,
    msg CLOB CONSTRAINT notice_msg_nn NOT NULL,
    CONSTRAINT notice_no_pk PRIMARY KEY(no)
);

CREATE SEQUENCE notice_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
INSERT INTO notice VALUES(notice_no_seq.nextVal,'홍길동','공지사항');
INSERT INTO notice VALUES(notice_no_seq.nextVal,'홍길동','공지사항');
INSERT INTO notice VALUES(notice_no_seq.nextVal,'홍길동','공지사항');
INSERT INTO notice VALUES(notice_no_seq.nextVal,'홍길동','공지사항');
INSERT INTO notice VALUES(notice_no_seq.nextVal,'홍길동','공지사항');
COMMIT;
SELECT * FROM notice;
--MAX() +1
--@C:\javaDev\oracleStudy\book