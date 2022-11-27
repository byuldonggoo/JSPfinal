package myboard;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

import board.BoardVO;
import login.UserDAO;
import login.UserVO;

@WebServlet("/myboard/*")
public class MyContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MyService boardService;
	BoardVO boardVO;
	UserDAO userDAO;
	int loginResult;

	// BoardDAO boardDAO;
	public void init() throws ServletException {
		// boardDAO = new BoardDAO();
		boardService = new MyService();
		boardVO = new BoardVO();
		userDAO = new UserDAO();
		System.out.println("초기화");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String nextPage = "";
		String action = request.getPathInfo();
		System.out.println("action: " + action);
		System.out.println(request.getServletContext());
		try {
			List<BoardVO> articlesList = new ArrayList<>();
			if(action == null|| action.equals("/listArticles.do")) {
				String _section=request.getParameter("section");
				String _pageNum=request.getParameter("pageNum");
				int section = Integer.parseInt(((_section==null)? "1":_section) );
				int pageNum = Integer.parseInt(((_pageNum==null)? "1":_pageNum));
				Map<String, Integer> pagingMap=new HashMap<String, Integer>();
				pagingMap.put("section", section);
				pagingMap.put("pageNum", pageNum);
				Map<String, Object> articlesMap=boardService.myListArticles(pagingMap);
				articlesMap.put("section", section);
				articlesMap.put("pageNum", pageNum);
				request.setAttribute("articlesMap", articlesMap);
				//response.sendRedirect("../index/index.jsp");
				nextPage = "../index/mypage.jsp";
			
			} 
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}