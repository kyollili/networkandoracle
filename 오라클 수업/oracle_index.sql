/*
    PL/SQL , INDEX
    => 1) SQL ����, 2) �ڹ� => ȭ�� ���(������) => HTML
        ------------------ �ٽ�
        �ε���(INDEX)
        = �˻��ÿ� �ӵ� ���
        = �޸𸮰� ���� �ʿ�� �Ѵ�
        = �ڵ� ���� : UNIQUE, PRIMARY KEY => �ε���
    -----------------------------------------------> ����Ŭ �Թ�(DML,DQL,TCL)
    => �ε��� ����
        => �ñ�
            1) �����Ǵ� ���� ���� ��� (PRIMARY KEY)
            2) WHERE������ ���� �˻��Ǵ� �÷��� �ִ� ���
                => ���� , �̸�...
            3) JOIN���� �ַ� ���Ǵ� �÷�(deptno)
            4) NULL���� �����ϴ� �÷��� ���� ��� (comm,bunji,,)
            => �ε����� ������ �ʴ� �κ�
            1) insert, update, delete�� ���� �κ� => �ε����� ���� ��쿡 ���� ����
        => ���� : B*Ʈ���� ����ȴ�
        
        ***p.247
        1) �ڷḦ ���� ������ ã�� �� �ְ� ���� ������ ����
        2) B-tree
            ��Ʈ      -------
                         |
            ------------------------- ���η�Ʈ
            |            |          |
        --------      -------    ------- ������Ʈ
        
        ===> p.249 �ε����� Ư¡
        
        1) ����
            => PRIMARY KEY, UNIQUE => �ڵ� ����
            => ����
                CREATE INDEX index�� ON ���̺��(�÷���) => �÷��� (ASC), �÷��� DESC
                CREATE INDEX index�� ON ���̺��(�÷���,�÷���)
            => ����
                DROP INDEX index��
            => ����
                ORDER BY => ��Ʈ, ����
                SELECT /*+ INDEX_ASC(���̺�� PK)* / �÷���... FROM emp
                           INDEX_DESC(���̺�� PK)
                SELECT * ~~ FROM ���̺�� WHERE �ε��� �÷��� ����
*/
--�ε��� ����
CREATE INDEX idx_emp_ename ON emp(ename DESC);
SELECT * FROM emp;
SELECT * FROM emp WHERE ename>='A';

CREATE INDEX idx_emp_sal ON emp(sal);
SELECT * FROM emp WHERE sal>0;

SELECT title FROM seoul_hotel ORDER BY title ASC;
SELECT /*+ INDEX_ASC(seoul_hotel sh_no_pk) */ no,title FROM seoul_hotel;
CREATE INDEX idx_sh_title ON seoul_hotel(title);
SELECT title FROM seoul_hotel WHERE title>='A';
-- ����
DROP INDEX idx_emp_ename;
DROP INDEX idx_emp_sal;
DROP INDEX idx_sh_title;
/*
        1) �ε��� ��� ����
            => ���� ������ �˻� ����� ������ �� �� �ְ� ���� ����(B tree)
            => SQL ��ɹ��� ó�� �ӵ��� ���
            => ����ȭ
            => �˻���� ���� ���Ǵ� �÷��� �ִ� ��� (��ȭ����, ��ȭ�⿬, ��ȭ�帣)
            => JOIN���� �񱳵Ǵ� �÷�
            => INSERT,UPDATE,DELETE�� ���� ���̺��� INDEX�� ����� �ӵ��� ���ϵȴ�
               ----------------------------------------------------------------- �ε��� �籸��(����)
            => �����Ͱ� 10000�� �̻�, �˻�� INDEX ���� (����, �̸�)
                CREATE INDEX index�� ON ���̺��(�÷���) => �÷���(ASC), �÷��� DESC
                            ---------idx_���̺��_�÷���
                CREATE INDEX index�� ON ���̺��(�÷���,�÷���)
                    ��) job, sal => ON emp(job,sal,DESC)
                ����
                    DROP INDEX �ε�����
                INSERT, UPDATE, DELETE => �ε��� �籸��
                ALTER INDEX index�� REBUILD 
                ----------------------------> ������ ���� (������ �ִ� ��) ==> HIT, ���
                => ���� 
                    INDEX_ASC(���̺�� PK) , INDEX_DESC(���̺�� PK) => ORDER BY ��� ���(�ӵ� ���)
                    
                => ������Ʈ
                    = ���̺� ����
                    = ������ �˻�
                    = ������
                    = DML
                    = ������
                    = View(�ζ��κ�)
                    = �ʿ�ÿ��� INDEX ����
*/