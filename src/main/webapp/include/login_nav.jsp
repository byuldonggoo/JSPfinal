<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 부분</title>
</head>
<body>
   <nav class="py-2 bg-light border-bottom ">
      <div class="container d-flex flex-wrap">
         <ul class="nav me-auto">
           <!--여기 뭐 넣을지 생각....-->
            <li class="nav-item"><a href="${contextPath}/board/listArticles.do" class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">Features</a></li>
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">Pricing</a></li>
            <li class="nav-item"><a href="#" class="nav-link link-dark px-2">About</a></li>
         </ul>
         <ul class="nav">
	<%
	
	
	if(session.getAttribute("sessionID")!=null || session.getAttribute("kakaosessionID")!=null){
	%>
            <!--클래스로 로그인 유무 display 조정-->
            <li class="nav-item login_true ">
              <a href=""><!--마이페이지 이동-->
                <!--로그인 자기 이미지 띄우기-->
                 <img src="..resource/users/${userInfo.profile_img }" alt="mdo" width="40" height="40" class="rounded-circle">
              </a>
            </li>
            <li class="nav-item login_true ">
               <a href="${contextPath}/userController/logout.do" onclick="kakaoLogout()"; class="nav-link link-dark px-2">Logout</a>
            </li>
           
 <% 	
	}
	else if(session.getAttribute("sessionID")==null || session.getAttribute("kakaosessionID")==null){
%>           
     <!--클래스로 로그인 유무 display 조정-->
          
            <!--클래스로 로그인 유무 display 조정-->
            <li class="nav-item login_true">
               <!--로그인 페이지 이동-->
               <a href="../login/loginForm_.jsp" class="nav-link link-dark px-2">Login</a>
            </li>
            
            <li class="nav-item login_true">
               <!--회원가입 페이지 이동-->
               <a href="../join/joinForm_2.jsp" class="nav-link link-dark px-2">Sign up</a>
            </li>
  <% 	
	}
%>          
         </ul>
      </div>
   </nav>
	
</body>
</html>