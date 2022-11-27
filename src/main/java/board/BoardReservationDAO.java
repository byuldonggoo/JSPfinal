package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardReservationDAO {
	private final String BOARD_DEALUPDATE_QUERY = "UPDATE board_t SET deal_status=? "
			+ " WHERE nickname=? AND num_aticle=?;";
	private DataSource dataFactory;
	 Connection conn;
	 PreparedStatement pstmt;

	public BoardReservationDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public BoardVO reservate (BoardVO boardVO) {
		int num_aticle = boardVO.getNum_aticle();
		String nickname = boardVO.getNickname(); 
		int int_deal_status = 0;
		String String_deal_status = boardVO.getDeal_status();
		System.out.println("BoardVO reservate num_aticle: "+boardVO.getNum_aticle());
		System.out.println("BoardVO reservate nickname: "+boardVO.getNickname());
		System.out.println("BoardVO reservate String_deal_status: "+boardVO.getDeal_status());
		int_deal_status = Integer.parseInt(boardVO.getDeal_status());
		try {
			conn = dataFactory.getConnection();
			System.out.println("==================================");
			System.out.println("BOARD_DEALUPDATE_QUERY 쿼리문 = [ " + BOARD_DEALUPDATE_QUERY + " ]");
			pstmt = conn.prepareStatement(BOARD_DEALUPDATE_QUERY);
			pstmt.setInt(1, int_deal_status);
			System.out.println("BoardReservationDAO int_deal_status: "+int_deal_status);
			pstmt.setString(2, nickname);
			System.out.println("BoardReservationDAO nickname: "+nickname);
			pstmt.setInt(3, num_aticle);
			System.out.println("BoardReservationDAO num_aticle: "+num_aticle);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return boardVO;
	}
}
