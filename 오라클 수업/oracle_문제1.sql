/*
        
        ����Ŭ�� �������
       *** 1. DBMS�� ���� => p.23
            ���α׷��̳� ȸ�翡 �ʿ��� �����͸� ��Ƽ� �����ϰ� ���� ������ ����
        2. DBMS���� �ϴ� ���� => P.24
            => �˻�(�߰�, ����, ����, �˻�) ==> DML
        3. DBMS ���� => p.44
            => �ߺ� �ּ�ȭ(����ȭ)
            => �ϰ��� ����, ������ ����
        4. SQL�� ����
            => DQL : SELECT
                    => JOIN�� ���� (INNER JOIN / OUTER JOIN ������)
                    => SUBQUERY�� ���� (�ζ��κ�, ��Į�� ��������)
            => DML : INSERT, UPDATE, DELETE => ������ ����
            => DCL : GRANT / REVOKE => ���� �ο� / ���� ����
            => DDL : CREATE / DROP / ALTER / TRUNCATE / RENAME => ����
            => TCL : COMMIT / ROLLBACK
                    *** Ʈ����� : �ϰ� ó��
        5. �����̼� : ���̺�
            => ������ ����
                ----------------------
                    �÷���(�Ӽ�)...
                ----------------------
                    ��.....          ====> row/record => �� �� ���� => ����(�� ��)
                ----------------------
                Ư¡) 
                     �÷����� ���ϰ��� ����� ���� => �÷�=����
                                                   -------- , ROW/RECORD ==> new Class��() => ~VO
                     �� ���� ���̺��� �÷����� ���� �̸��� ���� �� ����
                     �÷����� ������ ����
                     ROW�� ������ ����
                     ���� �����ͺ��̽����� ���̺�� �����ؾ��Ѵ�
                     1) ���̺��� �� ROW�� �����ϱ� ���ؼ� => �ߺ��� ���� ���� �����ϴ� ���� �⺻(������ ���Ἲ => PRIMARY KEY)
        -------------------------------------------------------------------------------------------
            6. SQL�� ����
                => �ڹ�/����Ŭ => �⺻ ���α׷�(VueJS / REACTJS)
                => JSP/Spring            
*/
-- �����ͺ��̽� : ���� => DESC ���̺��
DESC BOOK;
SELECT * FROM book;
SELECT * FROM book WHERE publisher='���ѹ̵��';

/*
BOOKID    NOT NULL NUMBER(2)    
BOOKNAME           VARCHAR2(40) 
PUBLISHER          VARCHAR2(40) 
PRICE              NUMBER(8) 

1) DQL : SELECT (�˻� �� ����)
        ����)
            SELECT * | column1,column2...
            FROM table_name|view_name|(SELECT~~)
            [
                WHERE ������ (������, �Լ�)
                GROUP BY �÷���|�Լ�
                HAVING �Լ� (�����Լ�)
                ORDER BY �÷���|�Լ�
            ]
2) DML
3) DDL
4) TCL
-- [���� 3-1] ��� ������ �̸��� ������ �˻��Ͻÿ�.
SELECT bookname,price
FROM book;
====�ݵ�� �ڹٷ� ���� ���� �� �� �־�� �Ѵ�

-- [���� 3-2] ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT * FROM book; => ��ü �������� ���(*) => ����Ŭ�� ��µ� ������ �о��
SELECT bookid, bookname, publisher, price => ������ ����
FROM book;

-- [���� 3-3] ���� ���̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�.
 => �ߺ� ���� : DISTINCT
SELECT DISTINCT publisher 
FROM book;

-- [���� 3-4] ������ 20,000�� �̸��� ������ �˻��Ͻÿ�.
    ����Ŭ �����ϴ� ������
    ��������� : SELECT���� �ַ� ��� => ROW ���� ��踦 ���ִ� �Լ��� �������� �ʴ´�
                +, -, *, /(����/����=�Ǽ�)
                '1' => ���ڿ� => �ڵ����� ���������� ������ �ȴ� TO_NUMBER('1') => �ӵ��� �ʱ� ������ �������� ����
                +�� ����� �����ϴ� (���ڿ��� ||)
    �񱳿����� : =(����), !=, <>(�����ʴ�) < , > , <=, >= ====> true/false => WHERE���� ���� ����
    �������� : AND, OR ==> (&=>�Է� ���� �� ���) ==> true/false ==> WHERE���� ���� ����
                --- ����(BETWEEN ~ AND) OR (IN)
    NOT : ���������� => NOT IN, NOT LIKE, NOT BETWEEN 
    NULL : NULL���� ��� ����ó���� �ȵȴ� => NULL��(IS NULL), NULL���� �ƴ� ���(IS NOT NULL)
    IN : OR�� ���� �� �϶� ó���ϴ� ������
    BETWEEN : >= AND <= ����, �Ⱓ => ������ ������
    LIKE : ���繮�ڿ� ã��(�˻�)
            & => ���� ������ �𸣴� ���
            _ => ���� �� ��
            ========================> %A% ==> ���� ����(�˻�)
            REGEXP_LIKE
    
SELECT * FROM book
WHERE price<20000;  ==> �񱳿����� �̿�

-- [���� 3-5] ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE price BETWEEN 10000 AND 20000;

-- [���� 3-6] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE publisher IN('�½�����','���ѹ̵��');

-- [���� 3-7] ���౸�� ���硯�� �Ⱓ�� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher FROM book
WHERE bookname='�౸�� ����';

-- [���� 3-8] �����̸��� ���౸�� �� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher FROM book
WHERE bookname LIKE '%�౸%';

SELECT publisher FROM book
WHERE REGEXP_LIKE(bookname,'�౸');
--[���� 3-9] �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
SELECT bookname FROM book
WHERE bookname LIKE '_��%';

--[���� 3-10] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE bookname LIKE '%�౸%'
AND price>=20000;

--[���� 3-11] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT * FROM book
WHERE publisher IN('�½�����','���ѹ̵��');

--[���� 3-12] ������ �̸������� �˻��Ͻÿ�. 
    *** ����Ŭ�� �����Ͱ� ������ �ȵ� ���·� ���� => ����鿡 ä���
    *** �ӵ��� ����(�ӵ��� ����ȭ : �ε��� => INDEX_ASC(), INDEX_DESC())
    ORDER BY�� ����� �� �������� ������ �ȴ�
    
    FROM => WHERE - GROUP BY - HAVING - SELECT - ORDER BY
    ORDER BY �÷��� ASC|DESC
                   ---- ������ ����
    ORDER BY �÷���, �÷��� DESC
    �÷��� ��ȣ�� �̿��� �� �ִ�
    SELECT publisher, price
    FROM book
    ORDER BY 1 DESC, 2 ASC;
SELECT * FROM book
ORDER BY bookname ASC;



--[���� 3-13] ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
SELECT * FROM book
ORDER BY price ASC, bookname ASC;

--[���� 3-14] ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�.
SELECT * FROM book
ORDER BY price DESC, publisher ASC;

--[���� 3-15] ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
        ==> �����Լ�
        ==> COLUMN ��ü�� ���
        ==> ROW �� ���� ���� ==> ������ �Լ�
        �����Լ� : sum, avg, max, min, count
        �������Լ�
            ���� : length(), substr(), instr(), rpad(), replace()
            ���� : mod(), ceil(), round(), trunc()
            ��¥ : sysdate, months_between
            ��ȯ : to_char()
                    ��¥ => YYYY , MM , DD , MI , SS, HH/HH24 , DY
                    ���� => 999,999
            ��Ÿ : NVL
DESC ORDERS;
ORDERID   NOT NULL NUMBER(2) 
CUSTID             NUMBER(2) 
BOOKID             NUMBER(2) 
SALEPRICE          NUMBER(8) 
ORDERDATE          DATE   

SELECT SUM(saleprice) "���Ǹž�" FROM orders;
--[���� 3-16] 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
            ----------------------����     --------
SELECT SUM(saleprice) FROM orders
WHERE custid=2;

--[���� 3-17] ���� �ֹ��� ������ �� �Ǹž�, ��հ�, ������, �ְ��� ���Ͻÿ�.
SELECT SUM(saleprice), AVG(saleprice), MAX(saleprice), MIN(saleprice)
FROM orders;

--[���� 3-18] ���缭���� ���� �Ǹ� �Ǽ��� ���Ͻÿ�.
SELECT COUNT(*) "�ǸŰǼ�" FROM orders;

--[���� 3-19] ������ �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
        GROUP BY => custid
        GROUP BY������ �������� ��� �Ұ�
        SELECT custid,COUNT(*) "�Ѽ���",SUM(saleprice) "���Ǹž�"
        FROM orders 
        GROUP BY custid;

--[���� 3-20] ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. ��, �� �� �̻� ������ ���� ���Ͻÿ�.
        => HAVING
SELECT custid, COUNT(*) " ��������"
FROM orders
WHERE saleprice>=8000
GROUP BY custid
HAVING count(*)>=2;

--[���� 3-21] ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�.
        => JOIN : customer / orders
           ---- �� �� �̻��� ���̺� �ʿ��� �����͸� �����ϴ� ���
           INNER JOIN
                = EQUI_JOIN(=)
                    SELECT A.col,B.col
                    FROM A,B
                    WHERE A.col=B.col;
                    --------------------����Ŭ������ ��� ����
                    SELECT A.col,B.col
                    FROM A,B
                    ON A.col=B.col;
                    ---------------------ǥ��ȭ�� JOIN
                = NON_EQUI_JOIN(=�� �ƴ� ������, �񱳿�����, ��������, IN, BETWEEN) => ����
                    SELECT A.col,B.col
                    FROM A JOIN B
                    WHERE A.col BETWEEN �� AND ��
                    --------------------����Ŭ������ ��� ����
                    SELECT A.col,B.col
                    FROM A JOIN B
                    ON A.col BETWEEN �� AND ��;
                    ---------------------ǥ��ȭ�� JOIN
           OUTER JOIN
                = LEFT OUTER JOIN
                = RIGHT OUTER JOIN

--[���� 3-22] ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.
        SELECT *
        FROM customer c,orders o
        WHERE c.custid=o.custid;

        SELECT *
        FROM customer c JOIN orders o
        ON c.custid=o.custid;
        
        SELECT *
        FROM customer c NATURAL JOIN orders o; --�÷����� ���� ���
        
        SELECT *
        FROM customer c JOIN orders o USING(custid); --���̺��� ���� �÷����� �����ؾ� ����Ѵ�
        -----------------------------------------------
        ***** �񱳽ÿ� �÷����� �ٸ� �� �ִ� (���� ���� ������ ������ �ȴ�)
        ====> �ڹٿ��� JOIN�� ������ => ����Ŭ������ �̿��Ѵ�
        DESC ORDERS;
        DESC customer;
SELECT *
FROM customer c,orders o
WHERE c.custid=o.custid
ORDER BY c.custid;
--[���� 3-23] ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT name,(SELECT bookname FROM book WHERE bookid=o.bookid) bookname ,saleprice
FROM customer c, orders o
WHERE c.custid=o.custid;
        ==> �ڹٿ����� Ŭ���� �ȿ� Ŭ������ �����ؼ� �о�� �����͸� ����(VO) => MyBatis
        
        SELECT empno,ename,hiredate,job,sal,dname,loc,grade
        FROM emp JOIN dept
        ON emp.deptno=dept.deptno
        JOIN salgrade
        ON sal BETWEEN losal AND hisal;
        
        SELECT empno,ename,hiredate,job,sal,dname,loc,grade
        FROM emp,dept,salgrade
        WHERE emp.deptno=dept.deptno
        AND sal BETWEEN losal AND hisal;
--[���� 3-24] ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
        SELECT
        FROM
        WHERE -> ���� ����
        GROUP BY 
        ORDER BY -> ���� ����
SELECT name,SUM(saleprice)
FROM customer c,orders o
WHERE c.custid=o.custid
GROUP BY c.name
ORDER BY c.name;
--[���� 3-25] ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�. 
SELECT name,bookname
FROM customer c, orders o, book b
WHERE c.custid=o.custid
AND o.bookid=b.bookid;

SELECT name,bookname
FROM customer c JOIN orders o
ON c.custid=o.custid
JOIN book b
ON o.bookid=b.bookid;

***JOIN ==> SELECT������ ����� ���� ==> ������ ����
***SUBQUERY => SELECT, INSERT, UPDATE, DELETE => SQL���� ����
***�����Ͱ� ���� ��� => �������� ����

--[���� 3-26] ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
                                           ----------  -----------
                                            Customer     Book   ===> JOIN
                                            --�� : customer / orders(�ֹ�����)
                                            --���� : orders / book
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
--[���� 3-27] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
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
--[���� 3-28] ���� ��� ������ �̸��� ���̽ÿ�.
SELECT MAX(Price) FROM book;

SELECT bookname 
FROM book
WHERE price=35000;

SELECT bookname 
FROM book
WHERE price=(SELECT MAX(Price) FROM book);
    ���� ���� ���� ���������� ���� ���� => ����� => ���������� ����
    �������� ���� ���� �ؾߵǱ� ������ () 
--[���� 3-29] ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
���� ������ ���� id
SELECT DISTINCT custid FROM orders;

SELECT name
FROM customer
WHERE custid IN(SELECT DISTINCT custid FROM orders);
--[���� 3-30] �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT bookid FROM book WHERE publisher='���ѹ̵��';

SELECT custid 
FROM orders 
WHERE bookid IN(SELECT bookid FROM book WHERE publisher='���ѹ̵��');

SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders 
WHERE bookid IN(SELECT bookid FROM book WHERE publisher='���ѹ̵��'));
        �ڹ� => ����/���� => �����ϴµ� �ð��� ���� �ɸ��� => ����(DBCP) => �̸� ���� ���� Connection�� �����ؼ� ���...
        �� ���α׷� �Ϲ�ȭ ==> ���̺귯��(����ġ)
        ���̺귯��
            �ڹ� => ����Ŭ
            �ڹ� => ������
            
--[���� 3-31] ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�. 
SELECT AVG(price) FROM book;

SELECT bookname
FROM book
WHERE price>(SELECT AVG(price) FROM book);

SELECT b1.bookname
FROM book b1
WHERE b1.price>(SELECT AVG(price) FROM book b2
    WHERE b2.publisher=b1.publisher);
    
--[���� 3-32] ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�. 
SELECT name
FROM customer;

SELECT name
FROM customer
WHERE custid NOT IN(SELECT custid FROM orders);

SELECT name
FROM customer --��ü��ܿ���
MINUS         -- ����
SELECT name
FROM customer
WHERE custid IN(SELECT custid FROM orders); -- �ֹ��� ���

        MINUS , INTERSECT , UNION , UNION ALL => ���տ�����
        A   B
        1   3
        2   4
        3   5
        4   6
        5   7
        -------INTERSECT : 3,4,5 (������) => INNER JOIN
                UNION : 1 2 3 4 5 6 7 => �� ���� ���ļ� ������ �б� => �ߺ��� ����
                UNION ALL : 1 2 3 4 5 3 4 5 6 7 => �ߺ� ���� ���� ��� ������ �б�
                MINUS
                    A-B= 1 2
                    B-A= 6 7
                    
--[���� 3-33] �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT name,address
FROM customer c
WHERE custid IN(SELECT custid FROM orders);

--[���� 3-34] Customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� �����ѹα� �λꡯ���� �����Ͻÿ�.
SELECT * FROM customer;
UPDATE customer SET
address='���ѹα� �λ�'
WHERE custid=5;
ROLLBACK;

        UPDATE => DML
        DML : ������ ���� ���
            INSERT : ������ �߰�
                = ��ü ������ �߰�
                    INSERT INTO table_name VALUES(��....) => table�� �÷� ���� = ���� ���� �ݵ�� ��ġ
                                                 ---------
                                                ��¥, ���ڿ� => ''
                                                ��¥�Է� : SYSDATE, 'YY/MM/DD'
                = �ʿ��� ������ �߰� (Default�� ���� �ִ� ���)
                    INSERT INTO table_name(�÷���,�÷���...) VALUES(�÷� ������ ������ ������ �����)
                                           ---------------���� ��� ����
            UPDATE : ������ ����
                    UPDATE table_name SET
                    �÷���=��,
                    �÷���=��;
                    --------------------��ü ����
                    [WHERE ���ǹ�]
                    --------------------���ǿ� �´� ROW�� ���� ***INSERT,UPDATE,DELETE => ROW������ ����
                                                             ***���ǿ� ���������� �̿��� �� �ִ�
            DELETE : ������ ����
                DELETE FROM table_name
                --------------------------��ü ����
                [WHERE ���ǹ�] 
                --------------------------���ǿ� �´� ROW�� ����
                ***** ����Ŭ : ROLLBACK(������ ����)
                ***** �ڹ� : ������ �� ����(COMMIT�� �ڵ� ����)
                        setAutoCommit(false) => Ʈ������
                       @Transactional (���������� @Transactional �ϸ� �Ʒ� �ڵ� �ڵ� ÷��)
                       ---------------------------------------
                        try
                        {
                            getConnection();
                            conn.setAutoCommit(false);
                            SQL ���� ó��
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
            MERGE : ������ ����

--[���� 3-35] Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
UPDATE customer SET
address =(SELECT address FROM customer
            WHERE name='�迬��')
WHERE name='�ڼ���';

SELECT * FROM customer;

ROLLBACK;

--[���� 3-36] Customer ���̺��� ����ȣ�� 5�� ���� ������ �� ����� Ȯ���Ͻÿ�.
DELETE FROM customer
WHERE custid=5;

SELECT * FROM customer;

ROLLBACK;

--[���� 3-37] ��� ���� �����Ͻÿ�.
DELETE FROM orders;
DELETE FROM customer;
SELECT * FROM customer;
SELECT * FROM orders;
ROLLBACK;
        1. �����ϰ� �ִ� ���̺��� ���� ����
        2. ���̺� ����
        3. ���̺� ���� => ON DELETE CasCade
*/







