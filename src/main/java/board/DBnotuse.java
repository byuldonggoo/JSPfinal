package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBnotuse {
	protected static DataSource dataFactory;
	protected static Connection conn;
	protected static PreparedStatement pstmt;
	
	
	
	public DBnotuse() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	protected static PreparedStatement dbQuery(String query) {
		try {
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return pstmt;
	}
	
	protected static ResultSet dbRead (PreparedStatement pstmt)  {
		ResultSet rs;
		try {
			rs = pstmt.executeQuery();
			return rs ;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null ;
	}
	
	protected static void dbUpdate()  {
		try {
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		 
		 
	protected static void dbClose()  {
		
		try {
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	

	
	
	
	
	
	

	
	

}