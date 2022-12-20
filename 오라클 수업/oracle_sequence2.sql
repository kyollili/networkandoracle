/*
    = VIEW : 가상테이블(기존의 테이블을 참조해서 사용)
             한 개 사용 : 단순뷰
             여러 개 사용 : 복합뷰
             ---------------------뷰에는 SQL 문장만 저장 => 보안(금융권,공기업(국세청,학교))
             인라인뷰
            => 재사용목적, 보안
            => user_views(view를 저장하고 있는 테이블)
            => CREATE VIEW view_name
                AS
                SELECT ~~
            => CREATE OR REPLACE VIEW view_name
                AS
                SELECT ~~
            => SELECT~~
                FROM (SELECT~~)
            => DROP VIEW view_name
            => View의 내용을 확인
                SELECT text FROM user_views WHERE view_name='대문자';
    = SEQUENCE : 자동증가번호(PRIMARY KEY)
                => 생성
                    CREATE SEQUENCE seq_name
                        START WITH ==> 시작번호
                        INCREMENT BY ==> 증가
                        NOCACHE ==> 저장 없이 사용
                        NOCYCLE ==> 되돌리기 없다
                => 값 읽기
                    현재값 : currval
                    다음값 : nextval
                => 삭제
                    DROP SEQUENCE seq_name
    -----------------------------------------
    = SYNONYM : 테이블의 별칭 ==> 실무 (동의어) => 보안
        = 생성 방법
            CREATE SYNONYM 별칭명 
            FOR 테이블
        = 삭제 방법
            DROP SYNONYM 별칭명
    = INDEX
    = PL/SQL : FUNCTION, PROCEDURE/TRIGGER
    
    권한 부여 
    system/happy => 계정으로 접근
    
    GRANT CREATE View TO hr 권한부여
    GRANT CREATE SYNONYM TO hr
    GRANT CREATE FUNCTION TO hr
    GRANT CREATE PROCEDURE TO hr
    GRANT CREATE TRIGGER TO hr
    
    REVOKE CREATE View FROM hr 권한취소
    REVOKE CREATE SYNONYM FROM hr
    REVOKE CREATE FUNCTION FROM hr
    REVOKE CREATE PROCEDURE FROM hr
    REVOKE CREATE TRIGGER FROM hr
*/
--생성
CREATE SYNONYM 사원정보
FOR emp;

SELECT * FROM 사원정보;
DROP SYNONYM 사원정보;

DESC food_location;

SELECT name,hit FROM food_location ORDER BY hit DESC;

SELECT CEIL(COUNT(*)/20.0) FROM food_location;

@c:\javaDev\book
