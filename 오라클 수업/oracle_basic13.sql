--GROUP BY 문제
/*  
    같은 값을 가지고 있는 그룹을 묶어서 그룹별 처리를 따로 하는 SQL
    SELECT~     =>5
    FROM        =>1
    WHERE       =>2
    GROUP BY    =>3 
        HAVING  =>4
    ORDER BY    =>6
*/
--1. 각 부서별로 최대 급여를 구하세요.
SELECT deptno,MAX(sal) 
FROM emp
GROUP BY deptno 
ORDER BY deptno ASC;

--2. 각 직급(job)별로 최대 급여를 구하세요. 
SELECT job,MAX(sal)
FROM emp
GROUP BY job;

--3. 각 부서별로 평균 급여를 구하세요.
SELECT deptno, ROUND(AVG(sal))
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;

--4. 각 직급(job)별의 인원수를 구하세요.
SELECT job,count(*)
FROM emp
GROUP BY job;

--5. 각 부서별 보너스(comm)을 받는  인원수 출력 . 
SELECT deptno,count(*)
FROM emp
WHERE comm IS NOT NULL AND comm<>0
GROUP BY deptno;

--6. 각 년도별로 입사한 인원수를 구하세요.
SELECT TO_CHAR(hiredate,'YYYY'),COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');


--6-1 같은 요일에 들어온 사람
SELECT TO_CHAR(hiredate,'DY'), COUNT(*),SUM(sal),ROUND(AVG(sal))
FROM emp
GROUP BY TO_CHAR(hiredate,'DY');

--7.  부셔별 평균급여를 구하고 그 결과 평균급여가 2000 이상인 부서만 출력하세요.
SELECT deptno,ROUND(AVG(sal))
FROM emp
GROUP BY deptno
HAVING AVG(sal)>2000;
--WHERE => 그룹함수를 사용할 수 없다, 그룹 함수 사용시에는 HAVING을 이용한다
--=>부서별, 입사년도, 직위, 
--JOIN 문제
--1. 사원 이름이 SCOTT인 사원의 사번(empno), 이름(ename), 부서명(dname)를 출력하세요.
SELECT empno, ename,dname
FROM emp,dept
WHERE ename='SCOTT';
--2. 사원이름과 급여(sal)와 급여등급(grade)을 출력하세요.
SELECT ename,sal, grade
FROM emp,salgrade;
--3. 위 2번문제에서 부서명을 추가시켜 출력하세요.
SELECT ename,sal,grade,dname
FROM emp,salgrade,dept;
--4. 사원이름과 매니저의 이름을 아래와 같은 형식으로 출력하세요.
    -- "XXX"의 매니져는 "XXX" 입니다. 
SELECT ename || '의 매니져는 ' || mgr || '입니다.'
FROM emp;
--5. 부서번호가 30번인 사원들의 이름, 직급(job), 부서번호(deptno), 부서위치(loc)를 출력하세요.
SELECT ename, job, emp.deptno, loc
FROM emp,dept
WHERE emp.deptno=30;
--6. 보너스(comm)을 받은사원의 이름, 보너스, 부서명, 부서위치를 출력하세요.
SELECT ename, comm, dname, loc
FROM emp, dept
WHERE comm!=NVL(null,0);
--7. DALLAS에서 근무하는 사원들의 이름, 직급, 부서번호, 부서명을 출력하세요.
SELECT ename,job,emp.deptno,dname
FROM emp,dept
WHERE dname='DALLAS';
--8. 이름에 'A'가 들어가는 사원들의 이름과 부서명을 출력하세요.
SELECT ename,dname
FROM emp,dept
WHERE ename LIKE '%A%';

--SUBQUERY 문제
--1. SCOTT의 급여와 동일하거나 더 많이 받는 사원의 이름과 급여를 출력하세요.
SELECT ename,sal
FROM emp
WHERE sal>=(SELECT sal FROM emp WHERE ename='SCOTT');
--2. 직급(job)이 'CLERK'인 사람의 부서의 부서번호와 부서명을 출력하세요.

--3. 이름에 T를 포함하고 있는 사원들과 같은부서에서 근무하는 사원의 사번과 이름을 출력하세요
SELECT empno,ename
FROM emp
WHERE 
--4. 부서위치(loc)가 DALLAS인 모든 사원의 이름, 부서번호를 출력하세요

--5. SALES 부서의 모든사원의 이름과 급여를 출력하세요

--6. 자신의 급여가 평균 급여보다 많고 이름에 S가 들어가는 사원과 
--  동일한 부서에서 근무하는 모든 사원의 이름, 급여를 출력하세요
--7. 평균 급여보다 더 많은 급여를 받는 사원의 이름, 사번, 급여를 검색하되 급여가 많은 순서로나열하세요.
