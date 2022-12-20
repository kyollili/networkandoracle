/*
        SELECT => 형식 , JOIN , SubQuery
                    연산자 , 내장함수
                    
        1) 형식
            = 컬럼명이 긴 경우 : 별칭
                컬럼명 별칭 , 컬럼명 as 별칭 , 컬럼명 "별칭"
                                            ----------- 공백이 있는 경우
            = || 문자열 결합
            = DISTINCT : 중복 제거
            
            *** SELECT 문장 => 컬럼 대신 사용, 테이블 대신 사용이 가능
                              -------------  --------------
                              스칼라서브쿼리   인라인뷰, Top-N => 페이징 기법 (******100%)
            SELECT * | column_list ==> *는 거의 빈도가 없다 (null값) => NVL
            FROM table_name | view_name _ SELECT~
            [
                WHERE 조건문 (컬럼명|함수명) 연산자 값
                GROUP BY 컬럼명|함수명 => 그룹별로 나눠서 처리 ==> 독립적으로 사용 가능
                HAVING 그룹에 대한 조건 ==> 무조건 GROUP BY와 동시에 설정
                ORDER BY 컬럼명|함수명 => default(asc) |desc는 생략 불가능
            ]
                => 데이터가 작은 경우 ORDER BY를 사용 , 빅데이터 => 인덱스(검색에 최적화 *****100%)
            WHERE 문장 사용 (조건문 => if)
            -------------- 연산자 , 내장함수
            연산자
                1) 산술연산자 : 자동형변환 => '10' => 10 , Only 산술만 처리
                                정수/정수=실수
                                => ROW단위 통계 => CUBE/ROLLUP
                2) 비교연산자 : =(같다), !=,<>(오라클) , < , > , <= , >=
                                자바 : == , 자바스크립트 : ===
                                => 문자열 , 날짜도 비교연산자를 사용한다 ==> 반드시 ''를 이용
                                String sql="SELECT ~~~"
                                            + "FROM ~~"
                                            + "WHERE name=홍길동"; ==> 자바에선 오류 없는데 오라클로 넘어가면서 오류남 => null하나 달랑 떠서 찾기 힘들다
                                                          ------ => "'홍길동'";
                    사용자 요청 ===> 자바 ===> 오라클 ===> 자바 ===> 브라우저 ===> 웹
                                        SQL         결과값     ArrayList
                                        --- String으로 전송
                                        --- 공백 처리 => 권장사항(키워드 대문자)
                                        --- SELECT FROM WHERE
                3) 논리연산자 : AND(범위 포함, 기간 포함) , OR(범위 초과)
                              *** && (입력값 받을 때), ||(문자열 결합) 
                4) IN 연산자 : OR 여러 개 사용시에 사용하는 연산자
                                WHERE 컬럼명 IN(값,값,값...)
                5) NULL 연산자 : NULL => 존재하지 않는 값 => 연산자처리 불가
                                => IS NULL (NULL 값일 때 처리), IS NOT NULL (NULL값이 아닌 경우)
                6) BETWEEN 연산자 : 기간 =>  >= AND <=   ==> 양쪽 포함
                                    페이지 나누기
                                    ----------- ==> 사이트(한 눈에 보게 만든다) ==> 테이블(20) ,이미지(15)
                7) LIKE 연산자 : 유사문자열 찾기
                                => _(한 글자) , %(글자수 관계없음) ==> 검색
                                A% , %A , %A% ==> 최근에는 REGEXP_LIKE => 패턴
                    WHERE name LIKE '%A%' OR name LIKE '%B%' OR name LIKE '%C% OR name LIKE '%D% OR name LIKE '%E%
                    ==> WHERE REGEXP_LIKE(name,'[A-E]')
                    
            ---------------------------------------------------------------------------------------------------
            내장함수
            -------
                오라클 데이터형
                -------------
                문자형 ==> 자바(String)
                    = CHAR(CHAR) => 1~2000byte => 고정형 ==> 성별, admin확인
                    = VARCHAR2(VARCHAR) => 1~4000byte => 가변형 (글자 개수에 따라 메모리 크기가 달라짐) => 문자열 중에 가장 많이 사용
                    = CLOB(TEXT) => 4기가 => 가변형 => 줄거리, 회사 소개, 레시피 제작...
                        *** 지정된 글자 수를 넘어가면 저장 불가
                숫자형
                    = NUMBER(4) ==> 4자리 정수까지 사용 ==> int
                    = NUMBER(7,2) ==> 7자리 중에 두 자리는 소수점 사용 ==> double
                    = NUMBER ==> 기본 디폴트는 8자리 
                날짜형 =====> java.util.Date
                    = DATE : 일반 날짜
                    = TIMESTAMP : 기록 경기
                기타형 ==> 4기가 (동영상, 사진.. 저장시)
                    ---------------------------------
                    = BLOB : binary로 저장시에 사용
                    = BFILE : file 형태로 저장시에 사용
                    ---------------------------------
                    
                = 함수는 데이터를 제어
                  단일행 함수 ==> ROW 단위
                    = 문자 관련 함수(웹 관련 => 문자)
                       *** 1) LENGTH() : 문자의 개수 => LENGTH('ABC') => 3 ==> length()
                                                    -------------
                       *** 2) SUBSTR(문자열,시작위치,자를 개수) ==> SUBSTR('Hello Oracle'1,2) ==> He ==> subString()
                       *** 3) INSTR(문자열,'찾는 문자',시작위치,몇번째) ==> indexOf()
                        ==> INSTR("Hello Oracle','l',1,2) ==> 4
                                      -              - => 1 : 앞에서부터
                                                         -1 : 뒤에서부터 
                            => 문자의 인덱스번호가 1부터 시작
                        4) UPPER(), LOWER(), INICAP() ==> 대문자, 소문자, 이니셜
                                             -------- 자바에 없다
                            *** 브라우저에서 요청 ==> 자바가 요청값을 받는다 ====> 변경 후에 오라클 전송
                                                자바에 있는 메소드, 없는 경우에는 오라클
                        5) TRIM() , LTRIM() , RTRIM() ==> trim() : 공백만 제거
                           -------------------------- 원하는 데이터를 제거
                        6) LPAD() , RPAD()
                                    ------ 아이디찾기 , 비밀번호찾기(JavaMail)
                                    RPAD('ABC',5,'*') ==> ABC**
                                               -- 다섯글자 출력 => 글자 수가 모자르면 *를 사용
                                               
                    = 숫자 관련 함수 (Math)   
                        1) MOD() => % (나머지) => MOD(10,3) ==> 1  10%3
                        *** 2) ROUND() => 반올림 => ROUND(10.123456,3)==> 10.123
                        3) TRUNC() => 버림 => TRUNC(10123756,3) ==> 10.123
                        *** 4) CEIL() => 올림 => CEIL(10.1) ==> 11
                    = 날짜 관련 함수 => Calendar
                        *** 1) SYSDATE : 시스템의 날짜, 시간 ==> 숫자형(날짜+시간) ==> 실수형
                        *** 2) MONTHS_BETWEEN : 기간 사이의 개월 수를 가지고 온다
                                MONTHS_BETSEEN(현재,과거)
                        3) ADD_MONTHS() => 배송일
                    = 변환 관련 함수
                        1) TO_CHAR : 문자열 변환 ==> 자바에는 무조건 String으로 값을 받는다
                            날짜
                                YYYY(RRRR) : 년도
                                MM(M) : 월
                                DD(D) : 일
                                HH/HH24 : 시
                                MI : 분
                                SS : 초
                                DY : 요일
                                ***대소문자 구분 없다
                            숫자
                                999,999 => $ ,L(원)
                    = 기타 함수
                        *** 1) NVL() ==> NULL을 다른 값으로 변경해서 사용 ==> String으로 값을 받을 경우 NULL이면 메소드를 사용할 수 없다
                            String s;
                            s.substring() => 오류 => NullpointerException
                            JSP 단점 => 오류 500
                        *** 2) DECODE ==> switch case 형식 => 별점 , 할인가 
                        3) CASE => 자동 조건문 (자동화)
                                    1 => UPDATE , 2 => DELETE , 3 => INSERT     ==> TRIGGER
                                    영화 / 댓글 ==> 분석이 어렵다
                                    입고 => 재고 변경 , 출고 => 재고 변경
                  집합행 함수 ==> Column 전체 단위
                  (그룹함수) => 일반 컬럼이나 단일행함수와 같이 사용이 불가능
                            ------------- GROUP BY를 이용해서 사용
                    SELECT deptno,job, AVG(), MAX()
                    FROM emp;       ====> 오류
                    
                    SELECT deptno, job, AVG(), MAX()
                    FROM emp
                    GROUP BY (deptno,job);
            
                    *** 1) COUNT() : ROW의 개수 => 로그인, ID 중복 처리, 검색 결과 ...
                    *** 2) MAX() : 자동 증가 번호
                    3) MIN, SUM, AVG
                    *** 4) RANK(), DENSE_RANK() 1 2 2 3
                          ------- 1 2 2 =>4
                          => RANK() OVER(ORDER BY sal DESC) => 자동으로 정렬
        ==> JOIN (162page, 169page)
            ---- 두 개 이상의 테이블에서 필요한 데이터를 추출 새로운 테이블을 만든다
            ---- 정규화 (테이블을 나눠서 저장 => 연결해서 데이터를 가지고 온다)
            1) 종류
                데이터베이스
                    *** 소형 : SQLlite (브라우저, 핸드폰)
                    *** 중형 : Oracle , MySQL , MariaDB
                                        --------------- 무료
                    *** 대용량 : 사이베이스 , DB2
                = INNER JOIN
                    1. 단점 : 교집합(같은 값을 가지고 있을 때 사용) = null일 경우에는 처리하지 못한다
                    = (=)연산자 사용 (동등조인, EQUI_JOIN)
                        = 오라클에서만 사용하는 JOIN 
                            형식)
                                SELECT A.column,B.column...
                                FROM A,B
                                WHERE A.column=B.column ==> 구분시 (테이블명,별칭)
                                -----------------------------
                                SELECT a.column,b.column...
                                FROM A a, B b
                                WHERE a.column=b.column
                                ***자동 인식 => 컬럼명이 다른 경우 (같은 컬럼명 앞에서는 반드시 구분)
                        = 표준화 된 JOIN (모든 데이터베이스에서 사용 가능:MySQK,MariaDB) ***실무
                                SELECT A.column,B.column...
                                FROM A JOIN B
                                ON A.column=B.column
                                -----------------------------
                                SELECT a.column,b.column...
                                FROM A a JOIN B b
                                ON a.column=b.column
                    = (=)이 아닌 연산자 (비등가조인, NON_EQUI_JOIN)
                        범위 안에 포함 ...
                        SELECT A.column , B.column
                        FROM A,B
                        WHERE A.column BETWEEN B.column AND B.column
                        
                        SELECT A.column , B.column
                        FROM A JOIN B
                        ON A.column BETWEEN B.column AND B.column
                    
                = OUTER JOIN : INNER JOIN의 단점을 보완(null일 경우에도 처리)
                    = LEFT OUTER JOIN
                        = 형식
                            = Oracle JOIN
                                SELECT A.column, B.column
                                FROM A,B
                                WHERE A.column=B.column(+)
                            = ANSI JOIN
                                SELECT A.column, B.column
                                FROM A LEFT OUTER JOIN B
                                ON A.column=B.column
                    = RIGHT OUTER JOIN
                        = 형식
                            = Oracle JOIN
                                SELECT A.column, B.column
                                FROM A,B
                                WHERE A.column(+)=B.column
                            = ANSI JOIN
                                SELECT A.column, B.column
                                FROM A RIGHT OUTER JOIN B
                                ON A.column=B.column
                    = FULL OUTER JOIN
                        = 형식
                            = ANSI JOIN
                                SELECT A.column, B.column
                                FROM A FULL OUTER JOIN B
                                ON A.column=B.column
                                
                JOIN은 테이블의 값을 연결
                *** 서브쿼리 (부속질의) ==> SQL을 여러 개 연결해서 사용
                (MainQuery) = (SUBQUERY)
                                    1 => 결과값을 MainQuery에 연결 후 처리
                WHERE 뒤에 ==> 단일행 서브쿼리 , 다중행 서브쿼리 , 다중 컬럼 서브쿼리 , 연관 서브쿼리
                              -------------------------------
                SELECT 뒤에 ==> 스칼라 서브쿼리
                FROM 뒤에 ==> 인라인뷰
                
                *** JOIN은 SELECT에서만 사용, SUBQUERY는 DML 전체에서 사용이 가능
                1) 단일행 서브쿼리 => 컬럼이 한 개, 값이 한 개인 경우
                2) 다중행 서브쿼리 => 컬럼이 한 개, 값이 여러 개인 경우
                    = 값 전체를 사용 ==> IN
                    = 값 중에 최소값
                    = 값 중에 최대값
                    ------------------------
                    ANY,SOME,ALL
                    
                    column<ANY(1,2,3) ==> 최대값(3) ==>SOME()
                    >ANY(1,2,3) ==> 최소값(1)
                
                    <ALL(1,2,3) ==> 최소값(1)
                    >ALL(1,2,3) ==> 최대값(3)
                    --------------------------------- 가독성 MAX(), MIN()
                    SQL 문장을 여러 개 모아서 한번에 처리 ==> 자바
                    --------------------------------------------
                    자바에서 
                        emp에서 평균 급여보다 작게 받는 사원의 목록을 출력
                        
                        오라클 연결
                        평균값을 구해온다
                        오라클 닫기
                        오라클 열기
                        평균을 대입해서 결과값 얻기
                        오라클 닫기
                        --------------------------
                        오라클 열기
                        평균을 대입해서 결과값 얻기
                        오라클 닫기
*/
/*SELECT ename,job FROM emp; --다중컬럼
SELECT deptno FROM emp WHERE ename='KING'; --단일행(컬럼 한 개에 결과값이 한 개인 경우)
SELECT DISTINCT deptno FROM emp; --다중행(컬럼 한 개 => 결과값이 여러 개)
*/
--사원 중에 평균 급여보다 작게 받는 사원의 모든 정보를 출력
-- 1. 평균 급여
SELECT ROUND(AVG(sal)) FROM emp;
-- 2. 평균 급여를 대입해서 => 요청 결과를 출력
SELECT * FROM emp
WHERE sal<2073;

--SQL문장을 통합해서 사용
SELECT * FROM emp
WHERE sal<(SELECT ROUND(AVG(sal)) FROM emp);

-- 같은 테이블만 사용하지 않는다, 다른 테이블을 사용할 수 있다
-- KING의 부서명, 근무지를 출력
-- 1. KING이 있는 부서번호 얻기
SELECT deptno FROM emp
WHERE ename='KING';
-- 2. 부서번호를 이용해서 부서명과 근무지 찾아오기
SELECT dname,loc FROM dept
WHERE deptno=10;
--3. 서브쿼리 이용
SELECT dname,loc FROM dept
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING');
--      deptno에 값을 대입   

-- SCOTT와 같은 부서에 근무하는 사원의 모든 정보 출력 ==> deptno
-- 1. SCOTT가 가지고 있는 deptno
SELECT deptno FROM emp
WHERE ename='SCOTT';
-- 2. 사원 검색
SELECT * FROM emp
WHERE deptno=20;
-- 3. 서브쿼리 이용 (반드시 결과값이 한 개인 경우)
SELECT * FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SCOTT');

-- 부서번호가 10,20,30 ==> 다중행 서브쿼리 ==> 한 개의 컬럼에 값이 여러 개인 경우 => ANY,ALL,MAX,MIN
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);


-- 급여를 가장 많이 받는 사원 중에 같은 부서에서 근무하는 모든 사원 정보
-- 1. 급여가 가장 많은 사원
SELECT MAX(sal) FROM emp; --5000
SELECT ename FROM emp WHERE sal=5000; --KING
-- 2. 찾은 사원의 부서 번호 확인
SELECT deptno FROM emp WHERE ename='KING';
-- 3. 같은 부서 근무자 추출
SELECT * FROM emp WHERE deptno=10;

SELECT * FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename=(SELECT ename FROM emp WHERE sal=(SELECT MAX(sal) FROM emp)));

-- IN, ANY, ALL ==> 결과값이 여러 개인 경우(컬럼명은 한 개) => 다중행 서브쿼리
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);

SELECT * FROM emp
WHERE deptno < ANY(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> 최대값만 대입
--              ==> WHERE deptno < 30
SELECT * FROM emp
WHERE deptno > ANY(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> 최소값만 대입
--              ==> WHERE deptno > 10

SELECT * FROM emp
WHERE deptno < SOME(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> 최대값만 대입
--              ==> WHERE deptno < 30
SELECT * FROM emp
WHERE deptno > SOME(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> 최소값만 대입
--              ==> WHERE deptno > 10

SELECT * FROM emp
WHERE deptno < (SELECT MAX(deptno) FROM emp);
--           ---------------------------------------10,20,30 ==> 최대값만 대입
--              ==> WHERE deptno < 30
SELECT * FROM emp
WHERE deptno > (SELECT MIN(deptno) FROM emp);
--           ---------------------------------------10,20,30 ==> 최소값만 대입
--              ==> WHERE deptno > 10

SELECT * FROM emp
WHERE deptno <= ALL(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> 최소값만 대입
--              ==> WHERE deptno <= 10
SELECT * FROM emp
WHERE deptno >= ALL(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> 최대값만 대입
--              ==> WHERE deptno >= 30
/*
    >ANY(10,20,30) ==> 30
    <ANY(10,20,30) ==> 10
                            ---> ANY()=SOME()
    >ALL(10,20,30) ==> 10
    <ALL(10,20,30) ==> 30
    ------------------------------------------MIN, MAX가 사용빈도가 많다
*/
/*
        = 스칼라 서브쿼리 => 조인 대신에 사용 가능 ==> 컬럼 대신 사용
        = 인라인뷰 => rownum (ROW의 번호) ==> 테이블 대신 사용
                    -------------------- 페이지 나누기
                    -------------------- 이전/다음
*/
/*
        for(=> emp)
        {
            for(=>dept)
            {
                if(emp.deptno==dept.deptno)
                {
                    => 출력
                }
            }
        }
*/
SELECT ename,job,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- 스칼라 서브 쿼리 ==> 반드시 한 개 컬럼만 가지고 온다
SELECT ename,job,hiredate,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=emp.deptno) loc
FROM emp;
-- 인라인뷰
-- 주의점 : FROM 다음에서 실행된 SELECT 문장의 컬럼만 사용이 가능
SELECT ename,job,hiredate,sal,deptno
FROM (SELECT ename,job,hiredate,sal FROM emp); --오류

--급여가 많은 사원 5명을 추출 -- 인기게시물, 인기댓글, 인기상품, 인기맛집 => 5~10
-- table은 rownum이 고정
-- 인라인뷰를 이용해서 rownum의 순서를 바꿔줌
SELECT ename,sal,rownum 
FROM (SELECT ename, sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;

/*
        서브쿼리 : DML 전체, DDL에서도 사용이 가능 ==> 기존에 있는 테이블 복사
        ------- 조인 대신 사용, 테이블 대신 사용, 데이터를 원하는 개수만큼 추출
        INSERT , UPDATE , DELETE
        CREATE TABLE ....
        
        여러 개의 SQL 문장을 한 개로 연결해서 사용
        = 실행은 서브쿼리가 먼저 실행이 된다 => 결과를 메인 쿼리로 전송해서 실행이 된다 
          -------------------------------- (서브쿼리)
*/
DESC dept;
DESC emp;


CREATE TABLE SALGRADE(
   GRADE NUMBER,
   LOSAL NUMBER,
   HISAL NUMBER
   );
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);
COMMIT;





