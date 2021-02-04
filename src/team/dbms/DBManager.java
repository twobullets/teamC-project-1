package team.dbms;

import java.sql.*;

public class DBManager 
{
	protected String     m_DBMS     = "jdbc:mysql://192.168.0.68/team?useUnicode=true&characterEncoding=utf-8&serverTimezone=UTC";
	protected String     m_UserID   = "root";
	protected String     m_UserPass = "mySQL1234";
	
	Connection        m_Connection;
	PreparedStatement m_SelectStatment;
	ResultSet         m_ResultSet;	
		
	public String getVersion()
	{
		return "Java Beans Board v1.0";
	}
	
	public void setUserID(String id)
	{
		m_UserID = id;
	}
	
	public void setPassword(String pw)
	{
		m_UserPass = pw;
	}	
	
	//MySQL ������ ���� ���̺귯���� �ε��Ѵ�.
	protected boolean LoadDriver() 
	{		
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch(Exception e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	//MySQL�� �����Ѵ�.
	public boolean DBOpen()
	{
		if(LoadDriver() == false)
		{
			return false;
		}
		try
		{
			m_Connection = DriverManager.getConnection( m_DBMS, m_UserID ,m_UserPass );
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}
		return true;
	}
	
	//MySQL ������ �����Ѵ�.
	public void DBClose()
	{
		try
		{
			m_Connection.close();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return;
		}		
	}
	
	//Query�� �����Ѵ�.
	public boolean OpenQuery(String pSQL)
	{
		try
		{
			m_SelectStatment= m_Connection.prepareStatement(pSQL,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			m_ResultSet = m_SelectStatment.executeQuery();		
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}			
		return true;
	}
	
	//Query�� �����Ѵ�.
	public void CloseQuery()
	{
		try
		{		
			//�˻��� ����� �ݴ´�.
			m_ResultSet.close();
	
			//stmt �� �ݴ´�.
			m_SelectStatment.close();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return;
		}				
	}
	
	//���� ���ڵ�� �̵��Ѵ�.
	public boolean ResultNext()
	{
		try
		{		
			return m_ResultSet.next();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}		
	}
	
	//���ڵ��� ���� ��´�.
	public String getString(String pName)
	{
		try
		{		
			return m_ResultSet.getString(pName);
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return null;
		}			
	}
	
	//���ڵ��� ���� ��´�.
	public int getInt(String pName)
	{
		try
		{		
			return Integer.parseInt(m_ResultSet.getString(pName));
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return 0;
		}			
	}	
	
	//Insert, Delete, Update ó���� �Լ�
	public boolean Excute(String pSQL)
	{
		PreparedStatement mStmt;
		
		try
		{		
			mStmt  = m_Connection.prepareStatement(pSQL,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			mStmt.executeUpdate();
			//stmt �� �ݴ´�.
			mStmt.close();
		}
		catch (SQLException e)
		{
			System.out.println("ERROR:" + e.getMessage());
			return false;
		}			
		return true;
	}
	
	
}
