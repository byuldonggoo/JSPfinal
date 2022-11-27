package board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardService {
	//BoardConnectDB boardConnectDB;
	BoardListDAO boardListDAO;
	BoardCreateDAO boardCreateDAO;
	BoardReadDAO boardReadDAO;
	BoardUpdateDAO boardUpdateDAO;
	BoardDelDAO boardDelDAO;
	BoardReservationDAO boardReservationDAO;
	public BoardService() {
		//boardConnectDB = new BoardConnectDB();
		boardListDAO = new BoardListDAO();
		boardCreateDAO = new BoardCreateDAO();
		boardReadDAO = new BoardReadDAO();
		boardUpdateDAO = new BoardUpdateDAO();
		boardDelDAO = new BoardDelDAO();
		boardReservationDAO = new BoardReservationDAO();
	}
	
	//전체 글 목록
	public List<BoardVO> showArticles() {
		List <BoardVO> atriclesList = boardListDAO.boardListArticles();
		return atriclesList;
	}
	
	public Map<String, Object> listArticles(Map<String, Integer> pagingMap) {
		Map<String, Object> articlesMap = new HashMap<String, Object>();
		List<BoardVO> articlesList = boardListDAO.selectAllArticles(pagingMap);
		int totArticles = boardListDAO.selectTotArticles();
		articlesMap.put("articlesList", articlesList);
		articlesMap.put("totArticles", totArticles);
		//articlesMap.put("totArticles", 170);
		return articlesMap;
	}
	
	public int addArticle (BoardVO board) {
		System.out.println("create 수행합니다");
		boardCreateDAO.createArticle(board);
		boardCreateDAO.createArticleImg(board);
		return boardCreateDAO.createArticleNum();
	}
	
	public BoardVO viewArticle (int num_article) {
		System.out.println("viewArticle() 수행합니다");
		BoardVO article = null;
		article = boardReadDAO.readArticle(num_article);
		return article;
	}
	
	public void modifyArticle (BoardVO board) {
		System.out.println("modifyArticle() 수행합니다");
		boardUpdateDAO.updateArticle(board);
	}
	
	public List<Integer> removeArticle (int num_aticle) {
		System.out.println("removeArticle() 수행합니다");
		List<Integer> atriclesList =boardDelDAO.delBoard(num_aticle);
		return atriclesList;
	}
	
	public BoardVO reservate (BoardVO board) {
		System.out.println("Reservate() 수행합니다");
		BoardVO reserv = null;
		reserv =boardReservationDAO.reservate(board);
		return reserv;
	}
}