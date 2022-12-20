--GROUP BY ����
/*  
    ���� ���� ������ �ִ� �׷��� ��� �׷캰 ó���� ���� �ϴ� SQL
    SELECT~     =>5
    FROM        =>1
    WHERE       =>2
    GROUP BY    =>3 
        HAVING  =>4
    ORDER BY    =>6
*/
--1. �� �μ����� �ִ� �޿��� ���ϼ���.
SELECT deptno,MAX(sal) 
FROM emp
GROUP BY deptno 
ORDER BY deptno ASC;

--2. �� ����(job)���� �ִ� �޿��� ���ϼ���. 
SELECT job,MAX(sal)
FROM emp
GROUP BY job;

--3. �� �μ����� ��� �޿��� ���ϼ���.
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

--4. �� ����(job)���� �ο����� ���ϼ���.
SELECT job,count(*)
FROM emp
GROUP BY job;

--5. �� �μ��� ���ʽ�(comm)�� �޴�  �ο��� ��� . 
SELECT deptno,count(*)
FROM emp
WHERE comm IS NOT NULL AND comm<>0
GROUP BY deptno;

--6. �� �⵵���� �Ի��� �ο����� ���ϼ���.
SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');


--6-1 ���� ���Ͽ� ���� ���
SELECT TO_CHAR(hiredate,'DY'), COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
GROUP BY TO_CHAR(hiredate,'DY');

--7.  �μź� ��ձ޿��� ���ϰ� �� ��� ��ձ޿��� 2000 �̻��� �μ��� ����ϼ���.
SELECT deptno,ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000;
--WHERE => �׷��Լ��� ����� �� ����, �׷� �Լ� ���ÿ��� HAVING�� �̿��Ѵ�
--=>�μ���, �Ի�⵵, ����, 
--JOIN ����
--1. ��� �̸��� SCOTT�� ����� ���(empno), �̸�(ename), �μ���(dname)�� ����ϼ���.
SELECT empno, ename,dname
FROM emp,dept
WHERE ename='SCOTT';
--2. ����̸��� �޿�(sal)�� �޿����(grade)�� ����ϼ���.
SELECT ename,sal, grade
FROM emp,salgrade;
--3. �� 2���������� �μ����� �߰����� ����ϼ���.
SELECT ename,sal,grade,dname
FROM emp,salgrade,dept;
--4. ����̸��� �Ŵ����� �̸��� �Ʒ��� ���� �������� ����ϼ���.
    -- "XXX"�� �Ŵ����� "XXX" �Դϴ�. 
SELECT ename || '�� �Ŵ����� ' || mgr || '�Դϴ�.'
FROM emp;
--5. �μ���ȣ�� 30���� ������� �̸�, ����(job), �μ���ȣ(deptno), �μ���ġ(loc)�� ����ϼ���.
SELECT ename, job, emp.deptno, loc
FROM emp,dept
WHERE emp.deptno=30;
--6. ���ʽ�(comm)�� ��������� �̸�, ���ʽ�, �μ���, �μ���ġ�� ����ϼ���.
SELECT ename, comm, dname, loc
FROM emp, dept
WHERE comm!=NVL(null,0);
--7. DALLAS���� �ٹ��ϴ� ������� �̸�, ����, �μ���ȣ, �μ����� ����ϼ���.
SELECT ename,job,emp.deptno,dname
FROM emp,dept
WHERE dname='DALLAS';
--8. �̸��� 'A'�� ���� ������� �̸��� �μ����� ����ϼ���.
SELECT ename,dname
FROM emp,dept
WHERE ename LIKE '%A%';

--SUBQUERY ����
--1. SCOTT�� �޿��� �����ϰų� �� ���� �޴� ����� �̸��� �޿��� ����ϼ���.
SELECT ename,sal
FROM emp
WHERE sal>=(SELECT sal FROM emp WHERE ename='SCOTT');
--2. ����(job)�� 'CLERK'�� ����� �μ��� �μ���ȣ�� �μ����� ����ϼ���.

--3. �̸��� T�� �����ϰ� �ִ� ������ �����μ����� �ٹ��ϴ� ����� ����� �̸��� ����ϼ���
SELECT empno,ename
FROM emp
WHERE 
--4. �μ���ġ(loc)�� DALLAS�� ��� ����� �̸�, �μ���ȣ�� ����ϼ���

--5. SALES �μ��� ������� �̸��� �޿��� ����ϼ���

--6. �ڽ��� �޿��� ��� �޿����� ���� �̸��� S�� ���� ����� 
--  ������ �μ����� �ٹ��ϴ� ��� ����� �̸�, �޿��� ����ϼ���
--7. ��� �޿����� �� ���� �޿��� �޴� ����� �̸�, ���, �޿��� �˻��ϵ� �޿��� ���� �����γ����ϼ���.
