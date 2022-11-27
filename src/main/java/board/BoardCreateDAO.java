package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardCreateDAO {

	private final String BOARD_INSERT_QUERY = "INSERT INTO board_t (nickname, category, title, contents, goods_name)"
			+ " VALUES (?, ?, ?, ?, ?) ";
	private final String BOARD_INSERT_IMG_QUERY = "INSERT INTO goods_T (num_aticle, price, goods_img) "
			+ "VALUES ((select max(num_aticle) from board_t), ?, ?)";
	private final String BOARD_NUMBERUNG_QUERY = "select max(num_aticle) num from board_t WHERE num_aticle ";
	private DataSource dataFactory;
	Connection conn;
	PreparedStatement pstmt;

	public BoardCreateDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("mariadb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void createArticle(BoardVO bd) {
		try {
			System.out.println("BOARD_INSERT 쿼리문 = [ " + BOARD_INSERT_QUERY + " ]");
			String nickname = bd.getNickname();
			String category = bd.getCategory();
			String title = bd.getTitle();
			String contents = bd.getContents();
			String goods_name = bd.getGoods_name();
			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(BOARD_INSERT_QUERY);

			pstmt.setString(1, nickname);
			pstmt.setString(2, category);
			pstmt.setString(3, title);
			pstmt.setString(4, contents);
			pstmt.setString(5, goods_name);

			System.out.println("board_t 들어가는 내용 = [ 닉네임: " + nickname + ", 카테고리: " + category + ", 제목: " + title
					+ ", 내용: " + contents + ", 상품명: " + goods_name + " ]");
			System.out.println("==================================");
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	public int createArticleNum() {
		int setnum = 0;
		try {
			System.out.println("BOARD_NUMBERUNG_QUERY 쿼리문 = [ " + BOARD_NUMBERUNG_QUERY + " ]");
			conn = dataFactory.getConnection();

			pstmt = conn.prepareStatement(BOARD_NUMBERUNG_QUERY);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				setnum = rs.getInt(1);
			}

			System.out.println("goods_T 마지막 번호 = [ boart_T 마지막 번호: " + setnum + " ]");
			System.out.println("==================================");
			rs.close();
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
		return setnum;

	}

	public void createArticleImg(BoardVO bd) {
		try {
			System.out.println("BOARD_INSERT_IMG_QUERY 쿼리문 = [ " + BOARD_INSERT_IMG_QUERY + " ]");
			String price = bd.getPrice();
			System.out.println("price = " + price);
			String goods_img = bd.getGoods_img();
			System.out.println("goods_img = " + goods_img);

			conn = dataFactory.getConnection();
			pstmt = conn.prepareStatement(BOARD_INSERT_IMG_QUERY);
			pstmt.setString(1, price);
			pstmt.setString(2, goods_img);
			System.out.println("goods_T 들어가는 내용 = [ 가격: " + price + ", 이미지경로: " + goods_img + " ]");
			System.out.println("==================================");
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
	}

}