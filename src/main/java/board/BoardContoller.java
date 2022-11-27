package board;

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

import login.UserDAO;
import login.UserVO;

@WebServlet("/board/*")
public class BoardContoller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String BOARD_IMG_REPOSITORY = "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\resource\\imgs";
	private String BOARD_IMG_REPOSITORY2 = "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\resource\\imgs\\temp";
	BoardService boardService;
	BoardVO boardVO;
	UserDAO userDAO;
	int loginResult;

	// BoardDAO boardDAO;
	public void init() throws ServletException {
		// boardDAO = new BoardDAO();
		boardService = new BoardService();
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
				Map<String, Object> articlesMap=boardService.listArticles(pagingMap);
				articlesMap.put("section", section);
				articlesMap.put("pageNum", pageNum);
				request.setAttribute("articlesMap", articlesMap);
				//response.sendRedirect("../index/index.jsp");
				nextPage = "../index.jsp";
			
			} else if (action.equals("/addboard.do")) {
				// 글쓰기 페이지로 이동
				System.out.println("[글입력 폼 페이지: http://localhost:8090/JspTeam/boardview/addboard.jsp] ");
				nextPage = "../boardview/addboard.jsp";
			} else if (action.equals("/createArticle.do")) {
				// C-작업수행
				Map<String, String> articleMap = upload(request, response);
				HttpSession session = request.getSession();
				String id=(String) session.getAttribute("sessionID");
				String title = articleMap.get("title");
				String content = articleMap.get("content");
				String price = articleMap.get("price");
				String imgFileName = articleMap.get("goods_img");
				
				System.out.println("articleMap 에서 가져오는 id==" + id);
				System.out.println("articleMap 에서 가져오는 title==" + title);
				System.out.println("articleMap 에서 가져오는 content==" + content);
				System.out.println("articleMap 에서 가져오는 price==" + price);
				System.out.println("articleMap 에서 가져오는 imgFileName==" + imgFileName);
				boardVO.setNickname(id);
				boardVO.setCategory("디폴트");
				boardVO.setTitle(title); // addboard input을 map으로 줘서 받아옴
				boardVO.setContents(content);
				boardVO.setGoods_name("디폴트");
				boardVO.setPrice(price);
				boardVO.setGoods_img(imgFileName);
				System.out.println("[ addArticle 수행 이전 ]");
				int num_aticle = boardService.addArticle(boardVO);
				System.out.println("[ addArticle 수행 이후! ] num_aticle "+num_aticle);
				System.out.println("[ addArticle 수행 이후! ] imgFileName "+imgFileName);
				if (imgFileName != null && imgFileName.length() != 0) {
					System.out.println("[ addArticle 수행 이후! ] imgFile 있기떄문에 여기로 온다");
					File srcFile = new File(BOARD_IMG_REPOSITORY + "\\" + "temp" + "\\" + imgFileName);
					System.out.println("srcFile");
					File destDir = new File(BOARD_IMG_REPOSITORY + "\\" + num_aticle);
					
					if(!srcFile.exists())srcFile.mkdirs();
					System.out.println("destDir");
					if(!destDir.exists())destDir.mkdirs();
					System.out.println("destDir.mkdirs()");
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
					System.out.println("FileUtils.moveFileToDirectory(srcFile, destDir, true)");
				}
				System.out.println("[ 새 글 작성 alert() 띄우기 전]");
				PrintWriter pw = response.getWriter();
				pw.print("<script>" + "  alert('새글을 추가했습니다.');" + " location.href='" + request.getContextPath()
						+ "/board/listArticles.do';" + "</script>");
				System.out.println("[ 새 글 작성 alert() 띄운 후]");
				return;
			} 
			// Read Article
			else if (action.equals("/readArticle.do")) {
				//로그인 정보 확인
				//세션 받아오기
				HttpSession session = request.getSession();
				String id=(String) session.getAttribute("sessionID");    
				
				System.out.println("세션아이디: "+ id);
				UserVO userInfo=userDAO.readUser(id);
				session.setAttribute("userInfo", userInfo);
				String picname=userInfo.getProfile_img();
				
				System.out.println(userInfo.getProfile_img());
				System.out.println(session.getAttribute("sessionID"));
				System.out.println(request.getParameter("num_aticle"));
				
				String num_aticle = request.getParameter("num_aticle");
				System.out.println("readArticle.do 서블렛 왔어요" + num_aticle);
				boardVO = boardService.viewArticle(Integer.parseInt(num_aticle));
				/* 더미 데이터 name 보냈습니다. 앞으로는 세션값과 비교를 해야합니다. */
				
				request.setAttribute("name", "디폴트");

				request.setAttribute("article", boardVO);
				nextPage = "../boardview/detailboard.jsp";

			} 
			
			else if(action.equals("/resolve.do")) {
				String deal_status = request.getParameter("deal_status");
				int num_aticle = Integer.parseInt(request.getParameter("num_aticle"));
				String nickname = request.getParameter("nickname");
				System.out.println("num_aticle = " + num_aticle);
				System.out.println("deal_status = " + deal_status);
				System.out.println("nickname = " + nickname);
				BoardVO boardVO = new BoardVO(num_aticle, nickname, deal_status);
				boardVO =boardService.reservate(boardVO);
				PrintWriter writer = response.getWriter();
				writer.print("상품 구매예약 했습니다."); 
				return;
			}else if (action.equals("/modifyArticles.do")) {
				// U
				Map<String, String> articleMap = upload(request, response);
				int num_aticle = Integer.parseInt(articleMap.get("num_aticle"));
				String title = articleMap.get("title");
				String content = articleMap.get("content");
				String price = articleMap.get("price");
				String imgFileName = articleMap.get("goods_img");
				System.out.println("오냐?");
				boardVO.setNum_aticle(num_aticle);
				boardVO.setTitle(title); // addboard input에서 받아옴
				boardVO.setContents(content);
				boardVO.setPrice(price);
				boardVO.setGoods_img(imgFileName);
				boardService.modifyArticle(boardVO);
				System.out.println("[ addArticle 수행 이후! ] num_aticle "+num_aticle);
				System.out.println("[ addArticle 수행 이후! ] imgFileName "+imgFileName);
				if (imgFileName != null && imgFileName.length() != 0) {
					System.out.println("[ addArticle 수행 이후! ] imgFile 있기떄문에 여기로 온다");
					File srcFile = new File(BOARD_IMG_REPOSITORY + "\\" + "temp" + "\\" + imgFileName);
					System.out.println("srcFile");
					File destDir = new File(BOARD_IMG_REPOSITORY + "\\" + num_aticle);
					
					if(!srcFile.exists())srcFile.mkdirs();
					System.out.println("destDir");
					if(!destDir.exists())destDir.mkdirs();
					System.out.println("destDir.mkdirs()");
					FileUtils.moveFileToDirectory(srcFile, destDir, true);
					System.out.println("FileUtils.moveFileToDirectory(srcFile, destDir, true)");
				}
				PrintWriter pw = response.getWriter();
				pw.print("<script>" + "  alert('글을 수정했습니다.');" + " location.href='" + request.getContextPath()
						+ "/board/readArticle.do?num_aticle='"+num_aticle+";" + "</script>");
				response.sendRedirect("/board/readArticle.do?num_aticle="+num_aticle);
			} 
			else if (action.equals("/deleteArticles.do")) {
				// D
				System.out.println("deleteArticles");
				String num_aticle = request.getParameter("num_aticle");
				System.out.println("num_aticle = " + num_aticle);
				List<Integer> removeArticleNo = boardService.removeArticle(Integer.parseInt(num_aticle));
				File imgDir = new File(BOARD_IMG_REPOSITORY + "//" + num_aticle);
				if (imgDir.exists()) {
					FileUtils.deleteDirectory(imgDir);
					System.out.println(num_aticle + "번 폹더 삭제 완료");
				}
				PrintWriter pw = response.getWriter();
				pw.print("<script>" + "  alert('글을 삭제했습니다.');" + " location.href='" + request.getContextPath()
						+ "/board/listArticles.do';" + "</script>");
				return;
			}
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	private Map<String,String> upload(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String encoding = "utf-8";
		Map<String, String> articleMap = new HashMap<String, String>();
		File currentDirPath = new File(BOARD_IMG_REPOSITORY);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);

		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);

				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {
					System.out.println("파라미터명:" + fileItem.getFieldName());
					System.out.println("파일명:" + fileItem.getName());
					System.out.println("파일크기:" + fileItem.getSize() + "bytes");

					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						String fileName = fileItem.getName().substring(idx + 1);
						System.out.println("파일명:" + fileName);
						articleMap.put(fileItem.getFieldName(), fileName);
						File uploadFile = new File(currentDirPath + "\\temp\\" + fileName);
						fileItem.write(uploadFile);
					} // end if
				} // end if
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleMap;
		
	}


}