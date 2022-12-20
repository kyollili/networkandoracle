/*
        
        오라클의 기술면접
       *** 1. DBMS의 개념 => p.23
            프로그램이나 회사에 필요한 데이터를 모아서 통합하고 서로 공유할 목적
        2. DBMS에서 하는 역할 => P.24
            => 검색(추가, 수정, 삭제, 검색) ==> DML
        3. DBMS 장점 => p.44
            => 중복 최소화(정규화)
            => 일관성 유지, 독립성 유지
        4. SQL의 종류
            => DQL : SELECT
                    => JOIN의 종류 (INNER JOIN / OUTER JOIN 차이점)
                    => SUBQUERY의 종류 (인라인뷰, 스칼라 서브쿼리)
            => DML : INSERT, UPDATE, DELETE => 데이터 제어
            => DCL : GRANT / REVOKE => 권한 부여 / 권한 해제
            => DDL : CREATE / DROP / ALTER / TRUNCATE / RENAME => 생성
            => TCL : COMMIT / ROLLBACK
                    *** 트랜잭션 : 일괄 처리
        5. 릴레이션 : 테이블
            => 이차원 구조
                ----------------------
                    컬럼명(속성)...
                ----------------------
                    값.....          ====> row/record => 한 줄 단위 => 제어(한 줄)
                ----------------------
                특징) 
                     컬럼값은 단일값만 사용이 가능 => 컬럼=변수
                                                   -------- , ROW/RECORD ==> new Class명() => ~VO
                     한 개의 테이블에서 컬럼명은 같은 이름을 가질 수 없다
                     컬럼명의 순서는 없다
                     ROW의 순서가 없다
                     같은 데이터베이스에서 테이블명 유일해야한다
                     1) 테이블은 각 ROW를 구분하기 위해서 => 중복이 없는 값을 설정하는 것을 기본(데이터 무결성 => PRIMARY KEY)
        -------------------------------------------------------------------------------------------
            6. SQL의 기초
                => 자바/오라클 => 기본 프로그램(VueJS / REACTJS)
                => JSP/Spring            
*/
-- 데이터베이스 : 구조 => DESC 테이블명
DESC BOOK;
SELECT * FROM book;
SELECT * FROM book WHERE publisher='대한미디어';

/*
BOOKID    NOT NULL NUMBER(2)    
BOOKNAME           VARCHAR2(40) 
PUBLISHER          VARCHAR2(40) 
PRICE              NUMBER(8) 

1) DQL : SELECT (검색 후 추출)
        형식)
            SELECT * | column1,column2...
            FROM table_name|view_name|(SELECT~~)
            [
                WHERE 조건절 (연산자, 함수)
                GROUP BY 컬럼명|함수
                HAVING 함수 (집합함수)
                ORDER BY 컬럼명|함수
            ]
2) DML
3) DDL
4) TCL
-- [질의 3-1] 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname,price
FROM book;
====반드시 자바로 값을 갖고 올 수 있어야 한다

-- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT * FROM book; => 전체 데이터일 경우(*) => 오라클에 출력된 순서로 읽어옴
SELECT bookid, bookname, publisher, price => 순서를 지정
FROM book;

-- [질의 3-3] 도서 테이블에 있는 모든 출판사를 검색하시오.
 => 중복 제거 : DISTINCT
SELECT DISTINCT publisher 
FROM book;

-- [질의 3-4] 가격이 20,000원 미만인 도서를 검색하시오.
    오라클 지원하는 연산자
    산술연산자 : SELECT에서 주로 사용 => ROW 단위 통계를 내주는 함수가 존재하지 않는다
                +, -, *, /(정수/정수=실수)
                '1' => 문자열 => 자동으로 정수형으로 변경이 된다 TO_NUMBER('1') => 속도가 늦기 때문에 권장하지 않음
                +는 산술만 가능하다 (문자열은 ||)
    비교연산자 : =(같다), !=, <>(같지않다) < , > , <=, >= ====> true/false => WHERE에서 조건 제시
    논리연산자 : AND, OR ==> (&=>입력 받을 때 사용) ==> true/false ==> WHERE에서 조건 제시
                --- 범위(BETWEEN ~ AND) OR (IN)
    NOT : 부정연산자 => NOT IN, NOT LIKE, NOT BETWEEN 
    NULL : NULL값일 경우 연산처리가 안된다 => NULL값(IS NULL), NULL값이 아닌 경우(IS NOT NULL)
    IN : OR가 여러 개 일때 처리하는 연산자
    BETWEEN : >= AND <= 범위, 기간 => 페이지 나누기
    LIKE : 유사문자열 찾기(검색)
            & => 문자 개수를 모르는 경우
            _ => 문자 한 개
            ========================> %A% ==> 문자 포함(검색)
            REGEXP_LIKE
    
SELECT * FROM book
WHERE price<20000;  ==> 비교연산자 이용

-- [질의 3-5] 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

-- [질의 3-6] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT * FROM book
WHERE publisher IN('굿스포츠','대한미디어');

-- [질의 3-7] ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT publisher FROM book
WHERE bookname='축구의 역사';

-- [질의 3-8] 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.
SELECT publisher FROM book
WHERE bookname LIKE '%축구%';

SELECT publisher FROM book
WHERE REGEXP_LIKE(bookname,'축구');
--[질의 3-9] 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT bookname FROM book
WHERE bookname LIKE '_구%';

--[질의 3-10] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT * FROM book
WHERE bookname LIKE '%축구%'
AND price>=20000;

--[질의 3-11] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT * FROM book
WHERE publisher IN('굿스포츠','대한미디어');

--[질의 3-12] 도서를 이름순으로 검색하시오. 
    *** 오라클은 데이터가 정렬이 안된 상태로 저장 => 빈공백에 채운다
    *** 속도가 저하(속도를 최적화 : 인덱스 => INDEX_ASC(), INDEX_DESC())
    ORDER BY는 실행시 맨 마지막에 실행이 된다
    
    FROM => WHERE - GROUP BY - HAVING - SELECT - ORDER BY
    ORDER BY 컬럼명 ASC|DESC
                   ---- 생략이 가능
    ORDER BY 컬럼명, 컬럼명 DESC
    컬럼의 번호를 이용할 수 있다
    SELECT publisher, price
    FROM book
    ORDER BY 1 DESC, 2 ASC;
SELECT * FROM book
ORDER BY bookname ASC;



--[질의 3-13] 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT * FROM book
ORDER BY price ASC, bookname ASC;

--[질의 3-14] 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT * FROM book
ORDER BY price DESC, publisher ASC;

--[질의 3-15] 고객이 주문한 도서의 총 판매액을 구하시오.
        ==> 집합함수
        ==> COLUMN 전체를 통계
        ==> ROW 한 개만 변경 ==> 단일행 함수
        집합함수 : sum, avg, max, min, count
        단일행함수
            문자 : length(), substr(), instr(), rpad(), replace()
            숫자 : mod(), ceil(), round(), trunc()
            날짜 : sysdate, months_between
            변환 : to_char()
                    날짜 => YYYY , MM , DD , MI , SS, HH/HH24 , DY
                    숫자 => 999,999
            기타 : NVL
DESC ORDERS;
ORDERID   NOT NULL NUMBER(2) 
CUSTID             NUMBER(2) 
BOOKID             NUMBER(2) 
SALEPRICE          NUMBER(8) 
ORDERDATE          DATE   

SELECT SUM(saleprice) "총판매액" FROM orders;
--[질의 3-16] 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
            ----------------------조건     --------
SELECT SUM(saleprice) FROM orders
WHERE custid=2;

--[질의 3-17] 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT SUM(saleprice), AVG(saleprice), MAX(saleprice), MIN(saleprice)
FROM orders;

--[질의 3-18] 마당서점의 도서 판매 건수를 구하시오.
SELECT COUNT(*) "판매건수" FROM orders;

--[질의 3-19] 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
        GROUP BY => custid
        GROUP BY에서는 서브쿼리 사용 불가
        SELECT custid,COUNT(*) "총수량",SUM(saleprice) "총판매액"
        FROM orders 
        GROUP BY custid;

--[질의 3-20] 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구하시오.
        => HAVING
SELECT custid, COUNT(*) " 도서수량"
FROM orders
WHERE saleprice>=8000
GROUP BY custid
HAVING count(*)>=2;

--[질의 3-21] 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
        => JOIN : customer / orders
           ---- 한 개 이상의 테이블에 필요한 데이터를 추출하는 기법
           INNER JOIN
                = EQUI_JOIN(=)
                    SELECT A.col,B.col
                    FROM A,B
                    WHERE A.col=B.col;
                    --------------------오라클에서만 사용 가능
                    SELECT A.col,B.col
                    FROM A,B
                    ON A.col=B.col;
                    ---------------------표준화된 JOIN
                = NON_EQUI_JOIN(=이 아닌 연산자, 비교연산자, 논리연산자, IN, BETWEEN) => 포함
                    SELECT A.col,B.col
                    FROM A JOIN B
                    WHERE A.col BETWEEN 값 AND 값
                    --------------------오라클에서만 사용 가능
                    SELECT A.col,B.col
                    FROM A JOIN B
                    ON A.col BETWEEN 값 AND 값;
                    ---------------------표준화된 JOIN
           OUTER JOIN
                = LEFT OUTER JOIN
                = RIGHT OUTER JOIN

--[질의 3-22] 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
        SELECT *
        FROM customer c,orders o
        WHERE c.custid=o.custid;

        SELECT *
        FROM customer c JOIN orders o
        ON c.custid=o.custid;
        
        SELECT *
        FROM customer c NATURAL JOIN orders o; --컬럼명이 같을 경우
        
        SELECT *
        FROM customer c JOIN orders o USING(custid); --테이블에서 같은 컬럼명이 존재해야 사용한다
        -----------------------------------------------
        ***** 비교시에 컬럼명이 다를 수 있다 (같은 값을 가지고 있으면 된다)
        ====> 자바에서 JOIN이 있으면 => 포함클래스를 이용한다
        DESC ORDERS;
        DESC customer;
SELECT *
FROM customer c,orders o
WHERE c.custid=o.custid
ORDER BY c.custid;
--[질의 3-23] 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT name,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname ,saleprice
FROM customer c, orders o
WHERE c.custid=o.custid;
        ==> 자바에서는 클래스 안에 클래스를 포함해서 읽어온 데이터를 저장(VO) => MyBatis
        
        SELECT empno,ename,hiredate,job,sal,dname,loc,grade
        FROM emp JOIN dept
        ON emp.deptno=dept.deptno
        JOIN salgrade
        ON sal BETWEEN losal AND hisal;
        
        SELECT empno,ename,hiredate,job,sal,dname,loc,grade
        FROM emp,dept,salgrade
        WHERE emp.deptno=dept.deptno
        AND sal BETWEEN losal AND hisal;
--[질의 3-24] 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
        SELECT
        FROM
        WHERE -> 조인 조건
        GROUP BY 
        ORDER BY -> 정렬 조건
SELECT name,SUM(saleprice)
FROM customer c,orders o
WHERE c.custid=o.custid
GROUP BY c.name
ORDER BY c.name;
--[질의 3-25] 고객의 이름과 고객이 주문한 도서의 이름을 구하시오. 
SELECT name,bookname
FROM customer c, orders o, book b
WHERE c.custid=o.custid
AND o.bookid=b.bookid;

SELECT name,bookname
FROM customer c JOIN orders o
ON c.custid=o.custid
JOIN book b
ON o.bookid=b.bookid;

***JOIN ==> SELECT에서만 사용이 가능 ==> 데이터 연결
***SUBQUERY => SELECT, INSERT, UPDATE, DELETE => SQL문장 연결
***데이터가 많은 경우 => 서브쿼리 권장

--[질의 3-26] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
                                           ----------  -----------
                                            Customer     Book   ===> JOIN
                                            --고객 : customer / orders(주문내역)
                                            --도서 : orders / book
SELECT name,bookname,price
FROM customer c, orders o, book b
WHERE c.custid=o.custid
AND o.bookid=b.bookid
AND price>=20000;

ANSI
SELECT name,bookname,price
FROM customer c JOIN orders o
ON c.custid=o.custid
JOIN book b
ON o.bookid=b.bookid
WHERE price>=20000;
--[질의 3-27] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT name,saleprice,bookname
FROM customer c, orders o, book b
WHERE c.custid=o.custid(+)
AND o.bookid=b.bookid;

SELECT name,saleprice,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname
FROM customer c, orders o
WHERE c.custid=o.custid(+);

SELECT name,saleprice,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname
FROM customer c LEFT OUTER JOIN orders o
ON c.custid=o.custid;
--[질의 3-28] 가장 비싼 도서의 이름을 보이시오.
SELECT MAX(Price) FROM book;

SELECT bookname 
FROM book
WHERE price=35000;

SELECT bookname 
FROM book
WHERE price=(SELECT MAX(Price) FROM book);
    먼저 수행 쿼리 서브쿼리가 먼저 수행 => 결과값 => 메인쿼리에 전송
    서브쿼리 먼저 수행 해야되기 때문에 () 
--[질의 3-29] 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
도서 구매한 고객의 id
SELECT DISTINCT custid FROM orders;

SELECT name
FROM customer
WHERE custid IN(SELECT DISTINCT custid FROM orders);
--[질의 3-30] ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT bookid FROM book WHERE publisher='대한미디어';

SELECT custid 
FROM orders 
WHERE bookid IN(SELECT bookid FROM book WHERE publisher='대한미디어');

SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders 
WHERE bookid IN(SELECT bookid FROM book WHERE publisher='대한미디어'));
        자바 => 연결/해제 => 연결하는데 시간이 오래 걸린다 => 방지(DBCP) => 미리 여러 개의 Connection을 연결해서 대기...
        웹 프로그램 일반화 ==> 라이브러리(아파치)
        라이브러리
            자바 => 오라클
            자바 => 브라우저
            
--[질의 3-31] 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오. 
SELECT AVG(price) FROM book;

SELECT bookname
FROM book
WHERE price>(SELECT AVG(price) FROM book);

SELECT b1.bookname
FROM book b1
WHERE b1.price>(SELECT AVG(price) FROM book b2
    WHERE b2.publisher=b1.publisher);
    
--[질의 3-32] 도서를 주문하지 않은 고객의 이름을 보이시오. 
SELECT name
FROM customer;

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

SELECT name
FROM customer --전체명단에서
MINUS         -- 빼기
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders); -- 주문한 사람

        MINUS , INTERSECT , UNION , UNION ALL => 집합연산자
        A   B
        1   3
        2   4
        3   5
        4   6
        5   7
        -------INTERSECT : 3,4,5 (교집합) => INNER JOIN
                UNION : 1 2 3 4 5 6 7 => 두 개를 합쳐서 데이터 읽기 => 중복을 제거
                UNION ALL : 1 2 3 4 5 3 4 5 6 7 => 중복 제거 없이 모든 데이터 읽기
                MINUS
                    A-B= 1 2
                    B-A= 6 7
                    
--[질의 3-33] 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT name,address
FROM customer c
WHERE custid IN(SELECT custid FROM orders);

--[질의 3-34] Customer 테이블에서 고객번호가 5인 고객의 주소를 ‘대한민국 부산’으로 변경하시오.
SELECT * FROM customer;
UPDATE customer SET
address='대한민국 부산'
WHERE custid=5;
ROLLBACK;

        UPDATE => DML
        DML : 데이터 조작 언어
            INSERT : 데이터 추가
                = 전체 데이터 추가
                    INSERT INTO table_name VALUES(값....) => table의 컬럼 개수 = 값의 개수 반드시 일치
                                                 ---------
                                                날짜, 문자열 => ''
                                                날짜입력 : SYSDATE, 'YY/MM/DD'
                = 필요한 데이터 추가 (Default가 많이 있는 경우)
                    INSERT INTO table_name(컬럼명,컬럼명...) VALUES(컬럼 지정된 순서와 개수를 맞춘다)
                                           ---------------순서 상관 없음
            UPDATE : 데이터 수정
                    UPDATE table_name SET
                    컬럼명=값,
                    컬럼명=값;
                    --------------------전체 변경
                    [WHERE 조건문]
                    --------------------조건에 맞는 ROW만 변경 ***INSERT,UPDATE,DELETE => ROW단위로 변경
                                                             ***조건에 서브쿼리를 이용할 수 있다
            DELETE : 데이터 삭제
                DELETE FROM table_name
                --------------------------전체 삭제
                [WHERE 조건문] 
                --------------------------조건에 맞는 ROW만 삭제
                ***** 오라클 : ROLLBACK(복원이 가능)
                ***** 자바 : 복원할 수 없다(COMMIT을 자동 수행)
                        setAutoCommit(false) => 트랜젝션
                       @Transactional (스프링에서 @Transactional 하면 아래 코딩 자동 첨부)
                       ---------------------------------------
                        try
                        {
                            getConnection();
                            conn.setAutoCommit(false);
                            SQL 문장 처리
                            conn.commit();
                        }catch(Exception ex)
                        {
                            conn.rollback();
                        }
                        finally
                        {
                            conn.setAutoCommit(true);
                            disConnection();
                        }
                        ----------------------------------------
            MERGE : 데이터 병합

--[질의 3-35] Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE customer SET
address =(SELECT address FROM customer
            WHERE name='김연아')
WHERE name='박세리';

SELECT * FROM customer;

ROLLBACK;

--[질의 3-36] Customer 테이블에서 고객번호가 5인 고객을 삭제한 후 결과를 확인하시오.
DELETE FROM customer
WHERE custid=5;

SELECT * FROM customer;

ROLLBACK;

--[질의 3-37] 모든 고객을 삭제하시오.
DELETE FROM orders;
DELETE FROM customer;
SELECT * FROM customer;
SELECT * FROM orders;
ROLLBACK;
        1. 참조하고 있는 테이블을 먼저 삭제
        2. 테이블 삭제
        3. 테이블 제작 => ON DELETE CasCade
*/







