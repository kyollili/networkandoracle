package com.sist.dao;
import java.util.*;
import java.sql.*;
public class ViewDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	//Driver등록 => Properties => Class.forName()
	public ViewDAO()
	{
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex) {}
	}
	//연결
	public void getConnection()
	{
		try
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch(Exception ex) {}
	}
	//해제
	public void disConnection()
	{
		try
		{
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch(Exception ex) {}
	}
	//전체 목록 ==> 테이블 4개 연결
	public void empListData()
	{
		try
		{
			//1.연결
			getConnection();
			//2.SQL 문장 제작
			String sql="SELECT e1.empno,e1.ename,e2.ename as manager,e1.job,e1.hiredate,e1.sal,dname,loc,grade "
		               +"FROM emp e1 JOIN dept "
		               +"ON e1.deptno=dept.deptno "
		               +"JOIN salgrade "
		               +"ON e1.sal BETWEEN losal AND hisal "
		               +"LEFT OUTER JOIN emp e2 "
		               +"ON e1.mgr=e2.empno";

			//3.SQL 문장 전송
			ps=conn.prepareStatement(sql);
			//4.실행 후 데이터 저장
			ResultSet rs=ps.executeQuery();
			//5.저장된 데이터 출력
			while(rs.next())
			{
				System.out.println(
					rs.getInt(1)+" "
					+rs.getString(2)+" "
					+rs.getString(3)+" "
					+rs.getString(4)+" "
					+rs.getDate(5).toString()+" "
					+rs.getInt(6)+" "
					+rs.getInt(7)+" "
					+rs.getString(8)+" "
					+rs.getString(9)+" "
					+rs.getInt(10)
				);
			}
			rs.close();
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
	}
	//상세보기
	public void empDetailData(int empno)
	{
		try
		{
			//1. 연결
			getConnection();
			//2. SQL 문장 제작
			String sql="SELECT e1.empno,e1.ename,e2.ename as manager,e1.job,e1.hiredate,e1.sal,dname,loc,grade "
		               +"FROM emp e1 JOIN dept "
		               +"ON e1.deptno=dept.deptno "
		               +"JOIN salgrade "
		               +"ON e1.sal BETWEEN losal AND hisal "
		               +"LEFT OUTER JOIN emp e2 "
		               +"ON e1.mgr=e2.empno "
		               +"WHERE e1.empno="+empno;

			//3. 전송(오라클)
			ps=conn.prepareStatement(sql);
			//4. 데이터 읽기
			ResultSet rs=ps.executeQuery();
			rs.next();
			System.out.println(
					rs.getInt(1)+" "
					+rs.getString(2)+" "
					+rs.getString(3)+" "
					+rs.getString(4)+" "
					+rs.getDate(5).toString()+" "
					+rs.getInt(6)+" "
					+rs.getInt(7)+" "
					+rs.getString(8)+" "
					+rs.getString(9)+" "
					+rs.getInt(10)
				);
			rs.close();
			 // row가 1개일 경우 => rs.next() 한번만 사용
	         // row가 여러개일 경우 => while(rs.next())

		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
	}
	//View를 이용해서 전체 목록
	public void viewListData()
	{
		try
		{
			//1.연결
			getConnection();
			//2.SQL 문장 제작
			String sql="SELECT * FROM empDeptGrade_1";
			//3.SQL 문장 전송
			ps=conn.prepareStatement(sql);
			//4.실행 후 데이터 저장
			ResultSet rs=ps.executeQuery();
			//5.저장된 데이터 출력
			while(rs.next())
			{
				System.out.println(
					rs.getInt(1)+" "
					+rs.getString(2)+" "
					+rs.getString(3)+" "
					+rs.getString(4)+" "
					+rs.getDate(5).toString()+" "
					+rs.getInt(6)+" "
					+rs.getInt(7)+" "
					+rs.getString(8)+" "
					+rs.getString(9)+" "
					+rs.getInt(10)
				);
			}
			rs.close();
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
	}
	public void viewDetailData(int empno)
	{
		try
		{
			//1. 연결
			getConnection();
			//2. SQL 문장 제작
			String sql="SELECT * FROM empDeptGrade_1 "
						+"WHERE empno="+empno;
			//3. 전송(오라클)
			ps=conn.prepareStatement(sql);
			//4. 데이터 읽기
			ResultSet rs=ps.executeQuery();
			rs.next();
			System.out.println(
					rs.getInt(1)+" "
					+rs.getString(2)+" "
					+rs.getString(3)+" "
					+rs.getString(4)+" "
					+rs.getDate(5).toString()+" "
					+rs.getInt(6)+" "
					+rs.getInt(7)+" "
					+rs.getString(8)+" "
					+rs.getString(9)+" "
					+rs.getInt(10)
				);
			rs.close();
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
	}
	//View를 이용해서 상세보기
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ViewDAO dao=new ViewDAO();
		dao.empListData();
		System.out.println("==================================");
		dao.viewListData();
		System.out.println("==================================");
		dao.empDetailData(7788);
		System.out.println("==================================");
		dao.viewDetailData(7788);
	}

}
