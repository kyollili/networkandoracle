/*
    = VIEW : �������̺�(������ ���̺��� �����ؼ� ���)
             �� �� ��� : �ܼ���
             ���� �� ��� : ���պ�
             ---------------------�信�� SQL ���常 ���� => ����(������,�����(����û,�б�))
             �ζ��κ�
            => �������, ����
            => user_views(view�� �����ϰ� �ִ� ���̺�)
            => CREATE VIEW view_name
                AS
                SELECT ~~
            => CREATE OR REPLACE VIEW view_name
                AS
                SELECT ~~
            => SELECT~~
                FROM (SELECT~~)
            => DROP VIEW view_name
            => View�� ������ Ȯ��
                SELECT text FROM user_views WHERE view_name='�빮��';
    = SEQUENCE : �ڵ�������ȣ(PRIMARY KEY)
                => ����
                    CREATE SEQUENCE seq_name
                        START WITH ==> ���۹�ȣ
                        INCREMENT BY ==> ����
                        NOCACHE ==> ���� ���� ���
                        NOCYCLE ==> �ǵ����� ����
                => �� �б�
                    ���簪 : currval
                    ������ : nextval
                => ����
                    DROP SEQUENCE seq_name
    -----------------------------------------
    = SYNONYM : ���̺��� ��Ī ==> �ǹ� (���Ǿ�) => ����
        = ���� ���
            CREATE SYNONYM ��Ī�� 
            FOR ���̺�
        = ���� ���
            DROP SYNONYM ��Ī��
    = INDEX
    = PL/SQL : FUNCTION, PROCEDURE/TRIGGER
    
    ���� �ο� 
    system/happy => �������� ����
    
    GRANT CREATE View TO hr ���Ѻο�
    GRANT CREATE SYNONYM TO hr
    GRANT CREATE FUNCTION TO hr
    GRANT CREATE PROCEDURE TO hr
    GRANT CREATE TRIGGER TO hr
    
    REVOKE CREATE View FROM hr �������
    REVOKE CREATE SYNONYM FROM hr
    REVOKE CREATE FUNCTION FROM hr
    REVOKE CREATE PROCEDURE FROM hr
    REVOKE CREATE TRIGGER FROM hr
*/
--����
CREATE SYNONYM �������
FOR emp;

SELECT * FROM �������;
DROP SYNONYM �������;

DESC food_location;

SELECT name,hit FROM food_location ORDER BY hit DESC;

SELECT CEIL(COUNT(*)/20.0) FROM food_location;

@c:\javaDev\book
