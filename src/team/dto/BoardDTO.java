package team.dto;

import team.dbms.DBManager;
import team.vo.BoardVO;

public class BoardDTO 
{
	public boolean DoInsert(BoardVO vo) 
	{
		String sql = "";
		
		sql += "insert into board \n";
		sql += "( \n";
		sql += "subject,body,wdate \n";
		sql += ") \n";
		sql += "values \n";
		sql += "(\n";
		sql += "'" + vo.getSubject() + "',\n";
		sql += "'" + vo.getBody() +"',\n";
		sql += "now()\n";
		sql += ") \n";
		System.out.println(sql);
		DBManager dbms = new DBManager();
		dbms.DBOpen();
		dbms.Excute(sql);
		dbms.DBClose();
		return true;
	}
	
	public boolean DoDelete(BoardVO vo) 
	{
		String sql = "";
		
		sql += "delete from board \n";
		return true;
	}
}
