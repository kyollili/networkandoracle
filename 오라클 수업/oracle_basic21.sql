/*
        p.235 뷰
        View : 테이블의 일종(가상테이블)
                = 한 개 이상의 테이블을 통합해서 가상테이블을 만든다
                = SQL문장을 간결하게 만들 수 있다
                = 보안이 뛰어나다
                = 읽기 전용
                = 반드시 참조하는 테이블을 가지고 있어야한다
                = 테이블과 동일하게 사용이 가능
        1) 뷰의 종류
            1. 단순 뷰 : 테이블을 한 개만 참조
            2. 복합 뷰 : 테이블 여러 개를 참조 : 자바에서 SQL 문장을 줄일 수 있다(JOIN,SUBQUERY)
            3. 인라인 뷰 : FROM(SELECT~~) ==> 가장 많이 사용
            *** 뷰를 생성 후에 INSERT,UPDATE,DELETE => View에 저장되는 것이 아니라 테이블에 적용
                => 변경시에 테이블에 영향을 미친다 (READ ONLY)
                => 옵션
                    WITH CHECK OPTION => DML 가능 (DEFAULT)
                    READ ONLY OPTION => DML 불가능
            *** 뷰는 저장시에 데이터가 저장되는 것이 아니라 SQL문장을 저장한다
                                                       -------
        2) 생성 방법 => SQL 문장을 저장 후에 재사용
            = 생성
                CREATE VIEW view_name
                AS
                SELECT ~
            = 수정과 동시에 생성
                CREATE OR REPLACE view_name
                AS
                SELECT ~
        3) 삭제 방법
            DROP VIEW view_name;
*/
CREATE VIEW emp_view
AS
SELECT empno,ename,job,hiredate,sal,deptno FROM emp;
-- 사용자 계정은 권한이 없는 것이 많다 => system에서 권한을 부여한다
-- conn system/happy
-- grant create view to hr
-- 오라클에 저장
-- users_table , users_views , users-constraints
SELECT * FROM user_views;
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_tables WHERE table_name='EMP';
SELECT text FROM user_views WHERE view_name='EMP_VIEW';

SELECT * FROM emp_view;
--삭제
DROP VIEW emp_view;

CREATE TABLE myDept
AS
SELECT * FROM dept;

--View 제작
CREATE VIEW dept_view
AS
SELECT * FROM myDept;

--DML
INSERT INTO dept_view VALUES(50,'영업부','서울');

-- 추가 후에 VIEW 확인
SELECT * FROM dept_view; -- dept_view에 저장되는 것이 아니라 참조한 테이블에 저장을 한다

--테이블 확인 ==> myDept 참조
SELECT * FROM myDept;

DROP VIEW dept_view;

CREATE VIEW dept_view
AS
SELECT * FROM myDept WITH READ ONLY;

INSERT INTO dept_view VALUES(60,'개발부','서울'); --READ ONLY에서는 DML 불가

--수정이 가능하게 만든다
--사용빈도 거의 없음(단순뷰 => 테이블 한 개 연결)
CREATE OR REPLACE VIEW dept_view
AS
SELECT empno,ename,job FROM emp;
-- 뷰는 테이블과 동일시 된다 => 함수, 연산자 사용이 가능 => 많이 사용되는 SQL 문장이 있는 경우 => VIEW 생성
-- 복합뷰 (테이블 여러 개 연결해서 사용)
CREATE OR REPLACE VIEW empDeptGrade_view
AS
    SELECT e1.empno,e1.ename,e2.ename "manager",e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
    FROM emp e1,dept,salgrade,emp e2
    WHERE e1.deptno=dept.deptno
    AND e1.sal BETWEEN losal AND hisal
    AND e1.mgr=e2.empno;
    
SELECT * FROM empDeptGrade_view;

CREATE OR REPLACE VIEW empDeptGrade_1
AS
    SELECT e1.empno,e1.ename,e2.ename "manager",e1.job,e1.hiredate,e1.sal,e1.comm,dname,loc,grade
    FROM emp e1 JOIN dept
    ON e1.deptno=dept.deptno
    JOIN salgrade
    ON e1.sal BETWEEN losal AND hisal
    LEFT OUTER JOIN emp e2 
    ON e1.mgr=e2.empno;
    
CREATE OR REPLACE VIEW empDeptGrade_2
AS
SELECT empno,ename,hiredate,sal,comm,
        (SELECT ename FROM emp e2 WHERE e1.mgr=e2.empno) manager,
        (SELECT dname FROM dept WHERE deptno=e1.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=e1.deptno) loc,
        (SELECT grade FROM salgrade WHERE e1.sal BETWEEN losal AND hisal) grade
FROM emp e1;

SELECT * FROM empDeptGrade_2;
-- JOIN, SubQuery ==> View를 만들어서 재사용하면 응용프로그램에서 편리하게 사용이 가능
/*
        인라인뷰 => 뷰를 생성하는 것이 아니라 => SELECT를 이용하는 방식 => 테이블에서 몇 개를 잘라서 출력
                                              페이지를 나눠서 출력
                                            => 단점 : Top-N
        형식)
            SELECT ~~
            FROM (SELECT~~) ==> 서브쿼리(테이블 대신 사용)
            --------------------------------------------
            1) rownum : 가상 컬럼 (오라클) => row마다 번호(INSERT 된 순서로 지정)
                => rownum의 순서를 변경시에는 인라인뷰를 이용해서 변경 => ORDER BY를 이용해서 변경
                => 페이징에서도 많이 이용된다
                => 요구사항(업체)
                   -------------
                   1. 회원가입 => 로그인/로그아웃
                      ------- 아이디 중복체크 / 우편번호 검색
                      = 회원 수정
                      = 회원 탈퇴
                      = ID 찾기 / PWD 찾기(이메일 전송)
                    2. 게시판(댓글)
                    3. 공지사항(어드민 계정)
                    ******페이징기법 => 자바, 오라클, MySQL
                                            ------ ------
                                            인라인뷰    LIMIT 1,10
                                            no NUMBER auto_increment()
                                            => 시퀀스 제작
                    --------------------------------------------필수
                    4. 예약 / 결제 / 추천 / 멀티미디어 (1차)
                    5. 보안 / 스케줄러 / 데이터분석 (2차)
                    6. 신기술(현재 업체에서 사용하고 있는 신기술) =>3차
*/
-- 인라인뷰 (테이블 대신 SELECT)
/*
    SELECT *| column1,column2...
    FROM table_name|view_name|(SELECT~~)
                            --------------설정된 컬럼명을 벗어나면 안됨
    [
        WHERE 조건
        GROUP BY
        HAVING
        ORDER BY
    ]
    
    SELECT empno,ename,job,hiredate,sal,comm
                                        ----- 없는 식별자
    FROM (SELECT empno,ename,job,hiredate,sal FROM emp) ==> 오류 발생
                -----------------------------
                => JOIN / SUBQUERY / 일반 SQL 
*/
--오류 발생
SELECT empno,ename,job,hiredate,sal,comm
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);
--정상 수행
SELECT empno,ename,job
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);

--JOIN/SUBQUERY
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc
        FROM emp,dept
        WHERE emp.deptno=dept.deptno);
-- 서브쿼리는 반드시 별칭을 부여한다
/*
    인라인 ==> 자바스크립트, css
    <style>
      button{background-color:yellow}
    </style>
    <button style="background-color:yellow">
    <button onclick="javascript:history.back()">
*/
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=emp.deptno) loc
        FROM emp);
--필요한 개수만큼 ROW를 자른다
SELECT empno,ename,sal,rownum
FROM (SELECT empno,ename,sal FROM emp)
WHERE rownum<=5;

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp;

--rownum 번호 변경
SELECT empno,ename,job,hiredate,sal,rownum
FROM (SELECT empno,ename,job,hiredate,sal FROM emp ORDER BY sal DESC);

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum<=10;
-- 단점 : Top-N => 중간은 자를 수 없다 
SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum BETWEEN 5 AND 10;

-- 급여를 많이 받는 사원의 이름,직위,급여 ==> 상위 5명
SELECT ename,job,sal,rownum
FROM emp
WHERE rownum<=5
ORDER BY sal DESC;-------X

SELECT ename,sal
FROM emp
ORDER BY sal DESC;

SELECT ename,job,sal,rownum
FROM (SELECT ename,job,sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5; -------O

--중간에서 자르기(페이징)
SELECT ename,job,sal,num
FROM (SELECT ename,job,sal,rownum as num
        FROM (SELECT ename,job,sal 
        FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 11 AND 14;
-- 게시물 : 10~15개
-- 이미지 : 20개
SELECT COUNT(*) FROM food_location;
/*
    SQL 문장 길다, SQL 문장이 복잡하다 (JOIN,SUBQUERY), 보안 : 일반 뷰   
    상위에서부터 자르기, 페이지 나누기 : 인라인뷰                        
    SQL 문장을 자주 사용한다(같은거) : 재사용을 위해 뷰를 제작해서 사용 => 사용빈도가 거의 없다(MyBatis=>중복처리)
    ----------------------------------------------------------뷰
*/