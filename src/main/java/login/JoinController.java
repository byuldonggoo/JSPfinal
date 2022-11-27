package login;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import board.BoardService;

//회원가입 컨트롤러
@WebServlet("/join.do")
public class JoinController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	UserDAO userDAO;
	UserVO userVO;
	String nextPage="";
	BoardService boardService;
	
	  public void init() throws ServletException{
			userDAO=new UserDAO();
			userVO=new UserVO();
			boardService = new BoardService();
	    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException {
		
		//인코딩
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		//회원가입 성공시 나타날 메인화면 리스트를 위해서
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
		
		
		
		//upload메서드로 이미지업로드, 파일이름 들어간 map반환
		Map<String,String> articleMap2=upload(request,response);
		System.out.println("서블릿접근");
		//회원가입 폼에서 받아온 회원정보
		String id=articleMap2.get("id");
		String password=articleMap2.get("password");
		String nickname=articleMap2.get("nickname");
		String phone_number=articleMap2.get("phone_number");
		//프로필 사진을 가입시 설정하지 않은 경우 기본 이미지지정(userProfile.jsp)
		String profile_img=(!(articleMap2.get("profile_img")==null))?articleMap2.get("profile_img"):"userProfile.jpg";
		String addr=articleMap2.get("addr");
		String detail_addr=articleMap2.get("detail_addr");
		
		//값 잘 받아왔나 확인
		System.out.println("회원정보 폼 정보 잘 받아왔는지 확인:" + id);
		System.out.println(password);
		System.out.println(nickname);
		System.out.println(phone_number);
		System.out.println(profile_img);
		System.out.println(addr);
		System.out.println(detail_addr);
		
		//받아온 회원정보들로 userVO에 세팅해서 객체 새성
		UserVO userVO = new UserVO(id, password, nickname, phone_number,profile_img,addr,detail_addr);
		//디비에 추가.
		userDAO.addMember(userVO);
		//nextPage="../index/index.jsp";
		//메인 화면으로 이동
		response.sendRedirect("../board/listArticles.do");
	}
	
	
	private Map<String,String> upload(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String encoding = "utf-8";
		//이미지 파일명을 저장할 Map
		Map<String, String> articleMap = new HashMap<String, String>();
		
		//이미지 저장 경로
		String realPath = "D:\\JSP\\JSP_Workspace\\DbTest\\JspTeam\\src\\main\\webapp\\resource\\users";
		File currentDirPath = new File(realPath); // realPath경로 갖는 File객체 생성
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath); //업로드된 파일을 저장할 위치를 File객체로 지정.
		factory.setSizeThreshold(1024 * 1024); //크기한계 지정
		
		String fileName="";
		
		// HttpServletRequest 객체로부터 multipart/form-data형식으로 넘어온 HTTP Body 부분을 다루기 쉽게 변환해주는 역할
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List<FileItem> items = upload.parseRequest(request);//넘어온 객체를 FileItem이라는 형식으로 변환
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);//list를 하나씩 풀어서
				
				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					articleMap.put(fileItem.getFieldName(), fileItem.getString(encoding));
				} else {//첨부파일 바이너리 데이터이면(이미지)
				
					System.out.println("파라미터명:" + fileItem.getFieldName());
					System.out.println("파일명:" + fileItem.getName());
					System.out.println("파일크기:" + fileItem.getSize() + "bytes");
					
					//첨부파일 파일명 얻기
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						fileName = fileItem.getName().substring(idx + 1);
						System.out.println("파일명:" + fileName);
						
						//articleMap객체에 파일명 put
						articleMap.put(fileItem.getFieldName(), fileName);
						//파일경로+파일명 
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						//파일 업로드
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
