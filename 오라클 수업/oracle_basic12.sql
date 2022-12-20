/*
        SELECT => ���� , JOIN , SubQuery
                    ������ , �����Լ�
                    
        1) ����
            = �÷����� �� ��� : ��Ī
                �÷��� ��Ī , �÷��� as ��Ī , �÷��� "��Ī"
                                            ----------- ������ �ִ� ���
            = || ���ڿ� ����
            = DISTINCT : �ߺ� ����
            
            *** SELECT ���� => �÷� ��� ���, ���̺� ��� ����� ����
                              -------------  --------------
                              ��Į�󼭺�����   �ζ��κ�, Top-N => ����¡ ��� (******100%)
            SELECT * | column_list ==> *�� ���� �󵵰� ���� (null��) => NVL
            FROM table_name | view_name _ SELECT~
            [
                WHERE ���ǹ� (�÷���|�Լ���) ������ ��
                GROUP BY �÷���|�Լ��� => �׷캰�� ������ ó�� ==> ���������� ��� ����
                HAVING �׷쿡 ���� ���� ==> ������ GROUP BY�� ���ÿ� ����
                ORDER BY �÷���|�Լ��� => default(asc) |desc�� ���� �Ұ���
            ]
                => �����Ͱ� ���� ��� ORDER BY�� ��� , ������ => �ε���(�˻��� ����ȭ *****100%)
            WHERE ���� ��� (���ǹ� => if)
            -------------- ������ , �����Լ�
            ������
                1) ��������� : �ڵ�����ȯ => '10' => 10 , Only ����� ó��
                                ����/����=�Ǽ�
                                => ROW���� ��� => CUBE/ROLLUP
                2) �񱳿����� : =(����), !=,<>(����Ŭ) , < , > , <= , >=
                                �ڹ� : == , �ڹٽ�ũ��Ʈ : ===
                                => ���ڿ� , ��¥�� �񱳿����ڸ� ����Ѵ� ==> �ݵ�� ''�� �̿�
                                String sql="SELECT ~~~"
                                            + "FROM ~~"
                                            + "WHERE name=ȫ�浿"; ==> �ڹٿ��� ���� ���µ� ����Ŭ�� �Ѿ�鼭 ������ => null�ϳ� �޶� ���� ã�� �����
                                                          ------ => "'ȫ�浿'";
                    ����� ��û ===> �ڹ� ===> ����Ŭ ===> �ڹ� ===> ������ ===> ��
                                        SQL         �����     ArrayList
                                        --- String���� ����
                                        --- ���� ó�� => �������(Ű���� �빮��)
                                        --- SELECT FROM WHERE
                3) �������� : AND(���� ����, �Ⱓ ����) , OR(���� �ʰ�)
                              *** && (�Է°� ���� ��), ||(���ڿ� ����) 
                4) IN ������ : OR ���� �� ���ÿ� ����ϴ� ������
                                WHERE �÷��� IN(��,��,��...)
                5) NULL ������ : NULL => �������� �ʴ� �� => ������ó�� �Ұ�
                                => IS NULL (NULL ���� �� ó��), IS NOT NULL (NULL���� �ƴ� ���)
                6) BETWEEN ������ : �Ⱓ =>  >= AND <=   ==> ���� ����
                                    ������ ������
                                    ----------- ==> ����Ʈ(�� ���� ���� �����) ==> ���̺�(20) ,�̹���(15)
                7) LIKE ������ : ���繮�ڿ� ã��
                                => _(�� ����) , %(���ڼ� �������) ==> �˻�
                                A% , %A , %A% ==> �ֱٿ��� REGEXP_LIKE => ����
                    WHERE name LIKE '%A%' OR name LIKE '%B%' OR name LIKE '%C% OR name LIKE '%D% OR name LIKE '%E%
                    ==> WHERE REGEXP_LIKE(name,'[A-E]')
                    
            ---------------------------------------------------------------------------------------------------
            �����Լ�
            -------
                ����Ŭ ��������
                -------------
                ������ ==> �ڹ�(String)
                    = CHAR(CHAR) => 1~2000byte => ������ ==> ����, adminȮ��
                    = VARCHAR2(VARCHAR) => 1~4000byte => ������ (���� ������ ���� �޸� ũ�Ⱑ �޶���) => ���ڿ� �߿� ���� ���� ���
                    = CLOB(TEXT) => 4�Ⱑ => ������ => �ٰŸ�, ȸ�� �Ұ�, ������ ����...
                        *** ������ ���� ���� �Ѿ�� ���� �Ұ�
                ������
                    = NUMBER(4) ==> 4�ڸ� �������� ��� ==> int
                    = NUMBER(7,2) ==> 7�ڸ� �߿� �� �ڸ��� �Ҽ��� ��� ==> double
                    = NUMBER ==> �⺻ ����Ʈ�� 8�ڸ� 
                ��¥�� =====> java.util.Date
                    = DATE : �Ϲ� ��¥
                    = TIMESTAMP : ��� ���
                ��Ÿ�� ==> 4�Ⱑ (������, ����.. �����)
                    ---------------------------------
                    = BLOB : binary�� ����ÿ� ���
                    = BFILE : file ���·� ����ÿ� ���
                    ---------------------------------
                    
                = �Լ��� �����͸� ����
                  ������ �Լ� ==> ROW ����
                    = ���� ���� �Լ�(�� ���� => ����)
                       *** 1) LENGTH() : ������ ���� => LENGTH('ABC') => 3 ==> length()
                                                    -------------
                       *** 2) SUBSTR(���ڿ�,������ġ,�ڸ� ����) ==> SUBSTR('Hello Oracle'1,2) ==> He ==> subString()
                       *** 3) INSTR(���ڿ�,'ã�� ����',������ġ,���°) ==> indexOf()
                        ==> INSTR("Hello Oracle','l',1,2) ==> 4
                                      -              - => 1 : �տ�������
                                                         -1 : �ڿ������� 
                            => ������ �ε�����ȣ�� 1���� ����
                        4) UPPER(), LOWER(), INICAP() ==> �빮��, �ҹ���, �̴ϼ�
                                             -------- �ڹٿ� ����
                            *** ���������� ��û ==> �ڹٰ� ��û���� �޴´� ====> ���� �Ŀ� ����Ŭ ����
                                                �ڹٿ� �ִ� �޼ҵ�, ���� ��쿡�� ����Ŭ
                        5) TRIM() , LTRIM() , RTRIM() ==> trim() : ���鸸 ����
                           -------------------------- ���ϴ� �����͸� ����
                        6) LPAD() , RPAD()
                                    ------ ���̵�ã�� , ��й�ȣã��(JavaMail)
                                    RPAD('ABC',5,'*') ==> ABC**
                                               -- �ټ����� ��� => ���� ���� ���ڸ��� *�� ���
                                               
                    = ���� ���� �Լ� (Math)   
                        1) MOD() => % (������) => MOD(10,3) ==> 1  10%3
                        *** 2) ROUND() => �ݿø� => ROUND(10.123456,3)==> 10.123
                        3) TRUNC() => ���� => TRUNC(10123756,3) ==> 10.123
                        *** 4) CEIL() => �ø� => CEIL(10.1) ==> 11
                    = ��¥ ���� �Լ� => Calendar
                        *** 1) SYSDATE : �ý����� ��¥, �ð� ==> ������(��¥+�ð�) ==> �Ǽ���
                        *** 2) MONTHS_BETWEEN : �Ⱓ ������ ���� ���� ������ �´�
                                MONTHS_BETSEEN(����,����)
                        3) ADD_MONTHS() => �����
                    = ��ȯ ���� �Լ�
                        1) TO_CHAR : ���ڿ� ��ȯ ==> �ڹٿ��� ������ String���� ���� �޴´�
                            ��¥
                                YYYY(RRRR) : �⵵
                                MM(M) : ��
                                DD(D) : ��
                                HH/HH24 : ��
                                MI : ��
                                SS : ��
                                DY : ����
                                ***��ҹ��� ���� ����
                            ����
                                999,999 => $ ,L(��)
                    = ��Ÿ �Լ�
                        *** 1) NVL() ==> NULL�� �ٸ� ������ �����ؼ� ��� ==> String���� ���� ���� ��� NULL�̸� �޼ҵ带 ����� �� ����
                            String s;
                            s.substring() => ���� => NullpointerException
                            JSP ���� => ���� 500
                        *** 2) DECODE ==> switch case ���� => ���� , ���ΰ� 
                        3) CASE => �ڵ� ���ǹ� (�ڵ�ȭ)
                                    1 => UPDATE , 2 => DELETE , 3 => INSERT     ==> TRIGGER
                                    ��ȭ / ��� ==> �м��� ��ƴ�
                                    �԰� => ��� ���� , ��� => ��� ����
                  ������ �Լ� ==> Column ��ü ����
                  (�׷��Լ�) => �Ϲ� �÷��̳� �������Լ��� ���� ����� �Ұ���
                            ------------- GROUP BY�� �̿��ؼ� ���
                    SELECT deptno,job, AVG(), MAX()
                    FROM emp;       ====> ����
                    
                    SELECT deptno, job, AVG(), MAX()
                    FROM emp
                    GROUP BY (deptno,job);
            
                    *** 1) COUNT() : ROW�� ���� => �α���, ID �ߺ� ó��, �˻� ��� ...
                    *** 2) MAX() : �ڵ� ���� ��ȣ
                    3) MIN, SUM, AVG
                    *** 4) RANK(), DENSE_RANK() 1 2 2 3
                          ------- 1 2 2 =>4
                          => RANK() OVER(ORDER BY sal DESC) => �ڵ����� ����
        ==> JOIN (162page, 169page)
            ---- �� �� �̻��� ���̺��� �ʿ��� �����͸� ���� ���ο� ���̺��� �����
            ---- ����ȭ (���̺��� ������ ���� => �����ؼ� �����͸� ������ �´�)
            1) ����
                �����ͺ��̽�
                    *** ���� : SQLlite (������, �ڵ���)
                    *** ���� : Oracle , MySQL , MariaDB
                                        --------------- ����
                    *** ��뷮 : ���̺��̽� , DB2
                = INNER JOIN
                    1. ���� : ������(���� ���� ������ ���� �� ���) = null�� ��쿡�� ó������ ���Ѵ�
                    = (=)������ ��� (��������, EQUI_JOIN)
                        = ����Ŭ������ ����ϴ� JOIN 
                            ����)
                                SELECT A.column,B.column...
                                FROM A,B
                                WHERE A.column=B.column ==> ���н� (���̺��,��Ī)
                                -----------------------------
                                SELECT a.column,b.column...
                                FROM A a, B b
                                WHERE a.column=b.column
                                ***�ڵ� �ν� => �÷����� �ٸ� ��� (���� �÷��� �տ����� �ݵ�� ����)
                        = ǥ��ȭ �� JOIN (��� �����ͺ��̽����� ��� ����:MySQK,MariaDB) ***�ǹ�
                                SELECT A.column,B.column...
                                FROM A JOIN B
                                ON A.column=B.column
                                -----------------------------
                                SELECT a.column,b.column...
                                FROM A a JOIN B b
                                ON a.column=b.column
                    = (=)�� �ƴ� ������ (������, NON_EQUI_JOIN)
                        ���� �ȿ� ���� ...
                        SELECT A.column , B.column
                        FROM A,B
                        WHERE A.column BETWEEN B.column AND B.column
                        
                        SELECT A.column , B.column
                        FROM A JOIN B
                        ON A.column BETWEEN B.column AND B.column
                    
                = OUTER JOIN : INNER JOIN�� ������ ����(null�� ��쿡�� ó��)
                    = LEFT OUTER JOIN
                        = ����
                            = Oracle JOIN
                                SELECT A.column, B.column
                                FROM A,B
                                WHERE A.column=B.column(+)
                            = ANSI JOIN
                                SELECT A.column, B.column
                                FROM A LEFT OUTER JOIN B
                                ON A.column=B.column
                    = RIGHT OUTER JOIN
                        = ����
                            = Oracle JOIN
                                SELECT A.column, B.column
                                FROM A,B
                                WHERE A.column(+)=B.column
                            = ANSI JOIN
                                SELECT A.column, B.column
                                FROM A RIGHT OUTER JOIN B
                                ON A.column=B.column
                    = FULL OUTER JOIN
                        = ����
                            = ANSI JOIN
                                SELECT A.column, B.column
                                FROM A FULL OUTER JOIN B
                                ON A.column=B.column
                                
                JOIN�� ���̺��� ���� ����
                *** �������� (�μ�����) ==> SQL�� ���� �� �����ؼ� ���
                (MainQuery) = (SUBQUERY)
                                    1 => ������� MainQuery�� ���� �� ó��
                WHERE �ڿ� ==> ������ �������� , ������ �������� , ���� �÷� �������� , ���� ��������
                              -------------------------------
                SELECT �ڿ� ==> ��Į�� ��������
                FROM �ڿ� ==> �ζ��κ�
                
                *** JOIN�� SELECT������ ���, SUBQUERY�� DML ��ü���� ����� ����
                1) ������ �������� => �÷��� �� ��, ���� �� ���� ���
                2) ������ �������� => �÷��� �� ��, ���� ���� ���� ���
                    = �� ��ü�� ��� ==> IN
                    = �� �߿� �ּҰ�
                    = �� �߿� �ִ밪
                    ------------------------
                    ANY,SOME,ALL
                    
                    column<ANY(1,2,3) ==> �ִ밪(3) ==>SOME()
                    >ANY(1,2,3) ==> �ּҰ�(1)
                
                    <ALL(1,2,3) ==> �ּҰ�(1)
                    >ALL(1,2,3) ==> �ִ밪(3)
                    --------------------------------- ������ MAX(), MIN()
                    SQL ������ ���� �� ��Ƽ� �ѹ��� ó�� ==> �ڹ�
                    --------------------------------------------
                    �ڹٿ��� 
                        emp���� ��� �޿����� �۰� �޴� ����� ����� ���
                        
                        ����Ŭ ����
                        ��հ��� ���ؿ´�
                        ����Ŭ �ݱ�
                        ����Ŭ ����
                        ����� �����ؼ� ����� ���
                        ����Ŭ �ݱ�
                        --------------------------
                        ����Ŭ ����
                        ����� �����ؼ� ����� ���
                        ����Ŭ �ݱ�
*/
/*SELECT ename,job FROM emp; --�����÷�
SELECT deptno FROM emp WHERE ename='KING'; --������(�÷� �� ���� ������� �� ���� ���)
SELECT DISTINCT deptno FROM emp; --������(�÷� �� �� => ������� ���� ��)
*/
--��� �߿� ��� �޿����� �۰� �޴� ����� ��� ������ ���
-- 1. ��� �޿�
SELECT ROUND(AVG(sal)) FROM emp;
-- 2. ��� �޿��� �����ؼ� => ��û ����� ���
SELECT * FROM emp
WHERE sal<2073;

--SQL������ �����ؼ� ���
SELECT * FROM emp
WHERE sal<(SELECT ROUND(AVG(sal)) FROM emp);

-- ���� ���̺� ������� �ʴ´�, �ٸ� ���̺��� ����� �� �ִ�
-- KING�� �μ���, �ٹ����� ���
-- 1. KING�� �ִ� �μ���ȣ ���
SELECT deptno FROM emp
WHERE ename='KING';
-- 2. �μ���ȣ�� �̿��ؼ� �μ���� �ٹ��� ã�ƿ���
SELECT dname,loc FROM dept
WHERE deptno=10;
--3. �������� �̿�
SELECT dname,loc FROM dept
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING');
--      deptno�� ���� ����   

-- SCOTT�� ���� �μ��� �ٹ��ϴ� ����� ��� ���� ��� ==> deptno
-- 1. SCOTT�� ������ �ִ� deptno
SELECT deptno FROM emp
WHERE ename='SCOTT';
-- 2. ��� �˻�
SELECT * FROM emp
WHERE deptno=20;
-- 3. �������� �̿� (�ݵ�� ������� �� ���� ���)
SELECT * FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='SCOTT');

-- �μ���ȣ�� 10,20,30 ==> ������ �������� ==> �� ���� �÷��� ���� ���� ���� ��� => ANY,ALL,MAX,MIN
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);


-- �޿��� ���� ���� �޴� ��� �߿� ���� �μ����� �ٹ��ϴ� ��� ��� ����
-- 1. �޿��� ���� ���� ���
SELECT MAX(sal) FROM emp; --5000
SELECT ename FROM emp WHERE sal=5000; --KING
-- 2. ã�� ����� �μ� ��ȣ Ȯ��
SELECT deptno FROM emp WHERE ename='KING';
-- 3. ���� �μ� �ٹ��� ����
SELECT * FROM emp WHERE deptno=10;

SELECT * FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename=(SELECT ename FROM emp WHERE sal=(SELECT MAX(sal) FROM emp)));

-- IN, ANY, ALL ==> ������� ���� ���� ���(�÷����� �� ��) => ������ ��������
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);

SELECT * FROM emp
WHERE deptno < ANY(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> �ִ밪�� ����
--              ==> WHERE deptno < 30
SELECT * FROM emp
WHERE deptno > ANY(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> �ּҰ��� ����
--              ==> WHERE deptno > 10

SELECT * FROM emp
WHERE deptno < SOME(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> �ִ밪�� ����
--              ==> WHERE deptno < 30
SELECT * FROM emp
WHERE deptno > SOME(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> �ּҰ��� ����
--              ==> WHERE deptno > 10

SELECT * FROM emp
WHERE deptno < (SELECT MAX(deptno) FROM emp);
--           ---------------------------------------10,20,30 ==> �ִ밪�� ����
--              ==> WHERE deptno < 30
SELECT * FROM emp
WHERE deptno > (SELECT MIN(deptno) FROM emp);
--           ---------------------------------------10,20,30 ==> �ּҰ��� ����
--              ==> WHERE deptno > 10

SELECT * FROM emp
WHERE deptno <= ALL(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> �ּҰ��� ����
--              ==> WHERE deptno <= 10
SELECT * FROM emp
WHERE deptno >= ALL(SELECT DISTINCT deptno FROM emp);
--           ---------------------------------------10,20,30 ==> �ִ밪�� ����
--              ==> WHERE deptno >= 30
/*
    >ANY(10,20,30) ==> 30
    <ANY(10,20,30) ==> 10
                            ---> ANY()=SOME()
    >ALL(10,20,30) ==> 10
    <ALL(10,20,30) ==> 30
    ------------------------------------------MIN, MAX�� ���󵵰� ����
*/
/*
        = ��Į�� �������� => ���� ��ſ� ��� ���� ==> �÷� ��� ���
        = �ζ��κ� => rownum (ROW�� ��ȣ) ==> ���̺� ��� ���
                    -------------------- ������ ������
                    -------------------- ����/����
*/
/*
        for(=> emp)
        {
            for(=>dept)
            {
                if(emp.deptno==dept.deptno)
                {
                    => ���
                }
            }
        }
*/
SELECT ename,job,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;
-- ��Į�� ���� ���� ==> �ݵ�� �� �� �÷��� ������ �´�
SELECT ename,job,hiredate,
        (SELECT dname FROM dept WHERE deptno=emp.deptno) dname,
        (SELECT loc FROM dept WHERE deptno=emp.deptno) loc
FROM emp;
-- �ζ��κ�
-- ������ : FROM �������� ����� SELECT ������ �÷��� ����� ����
SELECT ename,job,hiredate,sal,deptno
FROM (SELECT ename,job,hiredate,sal FROM emp); --����

--�޿��� ���� ��� 5���� ���� -- �α�Խù�, �α���, �α��ǰ, �α���� => 5~10
-- table�� rownum�� ����
-- �ζ��κ並 �̿��ؼ� rownum�� ������ �ٲ���
SELECT ename,sal,rownum 
FROM (SELECT ename, sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;

/*
        �������� : DML ��ü, DDL������ ����� ���� ==> ������ �ִ� ���̺� ����
        ------- ���� ��� ���, ���̺� ��� ���, �����͸� ���ϴ� ������ŭ ����
        INSERT , UPDATE , DELETE
        CREATE TABLE ....
        
        ���� ���� SQL ������ �� ���� �����ؼ� ���
        = ������ ���������� ���� ������ �ȴ� => ����� ���� ������ �����ؼ� ������ �ȴ� 
          -------------------------------- (��������)
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





