package board;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardReadDAO {
	// private final String BOARD_SELECT_VIEW_QUERY = "SELECT * FROM board_t where
	// num_aticle=?";
	private final String BOARD_SELECT_VIEW_QUERY = "SELECT * FROM board_t " + "JOIN  goods_t ON "
			+ "goods_t.num_aticle=board_t.num_aticle " + "WHERE board_t.num_aticle=?";

	private DataSource dataFactory;
	 Connection conn;
	 PreparedStatement pstmt;

	;

	public BoardReadDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Read
	public BoardVO readArticle(int num_aticle) {
		System.out.println("selectArticle 시작하냐?");
		BoardVO boardVO = new BoardVO();
		try {
			System.out.println("==================================");
			System.out.println("BOARD_SELECT_VIEW_QUERY 쿼리문 = [ " + BOARD_SELECT_VIEW_QUERY + " ]");
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(BOARD_SELECT_VIEW_QUERY);
			pstmt.setInt(1, num_aticle);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int search_num_aticle = rs.getInt("num_aticle");
			String nickname = rs.getString("nickname");
			String category = rs.getString("category");
			String title = rs.getString("title");
			String content = rs.getString("contents");
			int int_deal_status = rs.getInt("deal_status");
			String String_deal_status = null;
			if (int_deal_status == 0) {
				String_deal_status = "판매중";
			} else if (int_deal_status == 1) {
				String_deal_status = "예약중";
			} else if (int_deal_status == 2) {
				String_deal_status = "판매완료";
			}
			Date upload = rs.getDate("upload");
			String goods_name = rs.getString("goods_name");
			int num_cmnt = rs.getInt("num_cmnt");
			String goods_img = rs.getString("goods_img");
			String price = rs.getString("price");

			boardVO.setNum_aticle(search_num_aticle);
			boardVO.setNickname(nickname);
			boardVO.setCategory(category);
			boardVO.setTitle(title);
			boardVO.setContents(content);
			boardVO.setDeal_status(String_deal_status);
			boardVO.setUpload(upload);
			boardVO.setGoods_name(goods_name);
			boardVO.setNum_cmnt(num_cmnt);
			boardVO.setGoods_img(goods_img);
			boardVO.setPrice(price);

			System.out.println("boardVO 확인 = [ 넘버링 :" + boardVO.getNum_aticle() + " | 닉네임 : " + boardVO.getNickname()
					+ " | 글제목 : " + boardVO.getTitle() + " ]");
			System.out.println("==================================");

			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {pstmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return boardVO;

	}

}