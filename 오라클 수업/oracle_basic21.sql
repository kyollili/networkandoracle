/*
        p.235 ��
        View : ���̺��� ����(�������̺�)
                = �� �� �̻��� ���̺��� �����ؼ� �������̺��� �����
                = SQL������ �����ϰ� ���� �� �ִ�
                = ������ �پ��
                = �б� ����
                = �ݵ�� �����ϴ� ���̺��� ������ �־���Ѵ�
                = ���̺�� �����ϰ� ����� ����
        1) ���� ����
            1. �ܼ� �� : ���̺��� �� ���� ����
            2. ���� �� : ���̺� ���� ���� ���� : �ڹٿ��� SQL ������ ���� �� �ִ�(JOIN,SUBQUERY)
            3. �ζ��� �� : FROM(SELECT~~) ==> ���� ���� ���
            *** �並 ���� �Ŀ� INSERT,UPDATE,DELETE => View�� ����Ǵ� ���� �ƴ϶� ���̺� ����
                => ����ÿ� ���̺� ������ ��ģ�� (READ ONLY)
                => �ɼ�
                    WITH CHECK OPTION => DML ���� (DEFAULT)
                    READ ONLY OPTION => DML �Ұ���
            *** ��� ����ÿ� �����Ͱ� ����Ǵ� ���� �ƴ϶� SQL������ �����Ѵ�
                                                       -------
        2) ���� ��� => SQL ������ ���� �Ŀ� ����
            = ����
                CREATE VIEW view_name
                AS
                SELECT ~
            = ������ ���ÿ� ����
                CREATE OR REPLACE view_name
                AS
                SELECT ~
        3) ���� ���
            DROP VIEW view_name;
*/
CREATE VIEW emp_view
AS
SELECT empno,ename,job,hiredate,sal,deptno FROM emp;
-- ����� ������ ������ ���� ���� ���� => system���� ������ �ο��Ѵ�
-- conn system/happy
-- grant create view to hr
-- ����Ŭ�� ����
-- users_table , users_views , users-constraints
SELECT * FROM user_views;
SELECT * FROM user_tables;
SELECT * FROM user_constraints;
SELECT * FROM user_tables WHERE table_name='EMP';
SELECT text FROM user_views WHERE view_name='EMP_VIEW';

SELECT * FROM emp_view;
--����
DROP VIEW emp_view;

CREATE TABLE myDept
AS
SELECT * FROM dept;

--View ����
CREATE VIEW dept_view
AS
SELECT * FROM myDept;

--DML
INSERT INTO dept_view VALUES(50,'������','����');

-- �߰� �Ŀ� VIEW Ȯ��
SELECT * FROM dept_view; -- dept_view�� ����Ǵ� ���� �ƴ϶� ������ ���̺� ������ �Ѵ�

--���̺� Ȯ�� ==> myDept ����
SELECT * FROM myDept;

DROP VIEW dept_view;

CREATE VIEW dept_view
AS
SELECT * FROM myDept WITH READ ONLY;

INSERT INTO dept_view VALUES(60,'���ߺ�','����'); --READ ONLY������ DML �Ұ�

--������ �����ϰ� �����
--���� ���� ����(�ܼ��� => ���̺� �� �� ����)
CREATE OR REPLACE VIEW dept_view
AS
SELECT empno,ename,job FROM emp;
-- ��� ���̺�� ���Ͻ� �ȴ� => �Լ�, ������ ����� ���� => ���� ���Ǵ� SQL ������ �ִ� ��� => VIEW ����
-- ���պ� (���̺� ���� �� �����ؼ� ���)
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
-- JOIN, SubQuery ==> View�� ���� �����ϸ� �������α׷����� ���ϰ� ����� ����
/*
        �ζ��κ� => �並 �����ϴ� ���� �ƴ϶� => SELECT�� �̿��ϴ� ��� => ���̺��� �� ���� �߶� ���
                                              �������� ������ ���
                                            => ���� : Top-N
        ����)
            SELECT ~~
            FROM (SELECT~~) ==> ��������(���̺� ��� ���)
            --------------------------------------------
            1) rownum : ���� �÷� (����Ŭ) => row���� ��ȣ(INSERT �� ������ ����)
                => rownum�� ������ ����ÿ��� �ζ��κ並 �̿��ؼ� ���� => ORDER BY�� �̿��ؼ� ����
                => ����¡������ ���� �̿�ȴ�
                => �䱸����(��ü)
                   -------------
                   1. ȸ������ => �α���/�α׾ƿ�
                      ------- ���̵� �ߺ�üũ / �����ȣ �˻�
                      = ȸ�� ����
                      = ȸ�� Ż��
                      = ID ã�� / PWD ã��(�̸��� ����)
                    2. �Խ���(���)
                    3. ��������(���� ����)
                    ******����¡��� => �ڹ�, ����Ŭ, MySQL
                                            ------ ------
                                            �ζ��κ�    LIMIT 1,10
                                            no NUMBER auto_increment()
                                            => ������ ����
                    --------------------------------------------�ʼ�
                    4. ���� / ���� / ��õ / ��Ƽ�̵�� (1��)
                    5. ���� / �����ٷ� / �����ͺм� (2��)
                    6. �ű��(���� ��ü���� ����ϰ� �ִ� �ű��) =>3��
*/
-- �ζ��κ� (���̺� ��� SELECT)
/*
    SELECT *| column1,column2...
    FROM table_name|view_name|(SELECT~~)
                            --------------������ �÷����� ����� �ȵ�
    [
        WHERE ����
        GROUP BY
        HAVING
        ORDER BY
    ]
    
    SELECT empno,ename,job,hiredate,sal,comm
                                        ----- ���� �ĺ���
    FROM (SELECT empno,ename,job,hiredate,sal FROM emp) ==> ���� �߻�
                -----------------------------
                => JOIN / SUBQUERY / �Ϲ� SQL 
*/
--���� �߻�
SELECT empno,ename,job,hiredate,sal,comm
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);
--���� ����
SELECT empno,ename,job
FROM (SELECT empno,ename,job,hiredate,sal FROM emp);

--JOIN/SUBQUERY
SELECT empno,ename,job,dname,loc
FROM (SELECT empno,ename,job,dname,loc
        FROM emp,dept
        WHERE emp.deptno=dept.deptno);
-- ���������� �ݵ�� ��Ī�� �ο��Ѵ�
/*
    �ζ��� ==> �ڹٽ�ũ��Ʈ, css
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
--�ʿ��� ������ŭ ROW�� �ڸ���
SELECT empno,ename,sal,rownum
FROM (SELECT empno,ename,sal FROM emp)
WHERE rownum<=5;

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp;

--rownum ��ȣ ����
SELECT empno,ename,job,hiredate,sal,rownum
FROM (SELECT empno,ename,job,hiredate,sal FROM emp ORDER BY sal DESC);

SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum<=10;
-- ���� : Top-N => �߰��� �ڸ� �� ���� 
SELECT empno,ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum BETWEEN 5 AND 10;

-- �޿��� ���� �޴� ����� �̸�,����,�޿� ==> ���� 5��
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

--�߰����� �ڸ���(����¡)
SELECT ename,job,sal,num
FROM (SELECT ename,job,sal,rownum as num
        FROM (SELECT ename,job,sal 
        FROM emp ORDER BY sal DESC))
WHERE num BETWEEN 11 AND 14;
-- �Խù� : 10~15��
-- �̹��� : 20��
SELECT COUNT(*) FROM food_location;
/*
    SQL ���� ���, SQL ������ �����ϴ� (JOIN,SUBQUERY), ���� : �Ϲ� ��   
    ������������ �ڸ���, ������ ������ : �ζ��κ�                        
    SQL ������ ���� ����Ѵ�(������) : ������ ���� �並 �����ؼ� ��� => ���󵵰� ���� ����(MyBatis=>�ߺ�ó��)
    ----------------------------------------------------------��
*/