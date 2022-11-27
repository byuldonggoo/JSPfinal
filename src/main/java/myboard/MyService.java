package myboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import board.BoardVO;

public class MyService {
	//BoardConnectDB boardConnectDB;
	MyListDAO myListDAO;
	public MyService() {
		//boardConnectDB = new BoardConnectDB();
		myListDAO = new MyListDAO();
	}
	
	//전체 글 목록
	public List<BoardVO> myShowArticles() {
		List <BoardVO> MyAtriclesList = myListDAO.boardListArticles();
		return MyAtriclesList;
	}
	
	public Map<String, Object> myListArticles(Map<String, Integer> pagingMap) {
		Map<String, Object> MyArticlesMap = new HashMap<String, Object>();
		List<BoardVO> MyArticlesList = myListDAO.selectAllArticles(pagingMap);
		int MyTotArticles = myListDAO.selectTotArticles();
		MyArticlesMap.put("articlesList", MyArticlesList);
		MyArticlesMap.put("totArticles", MyTotArticles);
		//articlesMap.put("totArticles", 170);
		return MyArticlesMap;
	}
	
}