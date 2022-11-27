<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ page import="board.*"%>

<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="articlesList" value="${articlesMap.articlesList}" />
<c:set var="totArticles" value="${articlesMap.totArticles}" />
<c:set var="section" value="${articlesMap.section}" />
<c:set var="pageNum" value="${articlesMap.pageNum}" />

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Best Seller</title>

<link rel="stylesheet" type="text/css" href="../resource/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../resource/css/override.css">
<script type="text/javascript"
	src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	/*
	var link = '${contextPath}/board/listArticles.do'; 
	
	$.ajax({
	    type:"post",
	    dataType:"text",
	    async:true,  
	    url:"${contextPath}/board/listArticles.do",
	    data: "${contextPath}",
	    success:function (data,textStatus){
	    	//console.log(${articlesMap.articlesList});
	    },
	    error:function(data,textStatus){
	       alert("실패.");
	    },
	    complete:function(data,textStatus){
	    	location.replace(link);
	    }
	 });	*/
	
});

function kakaoLogout() {
	if (!Kakao.isInitialized()) {
		Kakao.init('a9bd1d62db585f44286b5451460b4031');
	};
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
            console.log(response)
            console.log('로그아웃 성공')
        },
        fail: function (error) {
          console.log(error)
        },
      })
    }
}

function newArticle() {
	var loginUser =  '<%=(String)session.getAttribute("sessionID")%>';
	console.log(loginUser);
	
	if(loginUser=="null"){
		alert("로그인이 필요한 서비스 입니다.");
		$(location).attr("href", "../login/loginForm_.jsp");
	}else{
		$(location).attr("href", "../boardview/addboard.jsp");
	}
}
</script>

<style>
</style>
</head>
<body>
	<!-- 헤더 -->
	<%-- <%@ include file="../include/login_nav.jsp" %> --%>

	<nav class="py-2 bg-light border-bottom ">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<!--여기 뭐 넣을지 생각....-->
				<li class="nav-item"><a href="${contextPath}/board/listArticles.do"
					class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Features</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Pricing</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">About</a></li>
			</ul>
			<ul class="nav">
				<%
				if (session.getAttribute("sessionID") != null || session.getAttribute("kakaosessionID") != null) {
				%>
				<!--클래스로 로그인 유무 display 조정-->
				<li class="nav-item login_true "><a href="${contextPath}/index/mypage.jsp">
						<!--마이페이지 이동--> <!--로그인 자기 이미지 띄우기--> <img
						src="../resource/users/${userInfo.profile_img }" alt="mdo"
						width="40" height="40" class="rounded-circle">
				</a></li>
				<li class="nav-item login_true "><a
					href="${contextPath}/userController/logout.do"
					onclick="kakaoLogout()" class="nav-link link-dark px-2">Logout</a>
				</li>

				<%
				} else if (session.getAttribute("sessionID") == null || session.getAttribute("kakaosessionID") == null) {
				%>
				<!--클래스로 로그인 유무 display 조정-->

				<!--클래스로 로그인 유무 display 조정-->
				<li class="nav-item login_true">
					<!--로그인 페이지 이동--> <a href="../login/loginForm_.jsp"
					class="nav-link link-dark px-2">Login</a>
				</li>

				<li class="nav-item login_true">
					<!--회원가입 페이지 이동--> <a href="../join/joinForm_2.jsp"
					class="nav-link link-dark px-2">Sign up</a>
				</li>
				<%
				}
				%>
			</ul>
		</div>
	</nav>
	<%@ include file="../include/head_title.jsp"%>
	<!-- 배너 -->
	<%@ include file="../include/banner.jsp"%>

	<!-- 새 글 등록 fixed -->
	<a class="newatcl" onClick="newArticle()" style="z-index: 1;">+</a>

	<section>
		<div class="container d-flex flex-wrap justify-content-center">
			<h2
				class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none mgt">오늘의
				추천 상품</h2>
		</div>


		<!-- 서블릿에서 넘어온 articlesMap.articlesList값을 c set을통해 articlesList로 설정하여 판단 -->
		<!-- articlesList를 articles로 재정의 하여 VO값을 꺼내온다 -->

		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
					<c:choose>
						
						<c:when test="${!empty articlesList }">

							<c:forEach var="articles" items="${articlesList }">
								<div class="col">
									<a href="${contextPath}/board/readArticle.do?num_aticle=${articles.num_aticle}">
									
										<div class="card shadow-sm text-center">
											<span style="width: 150px; display: none;">${articles.num_aticle}</span>
											<div class="bd-placeholder-img card-img-top w-100  d-flex justify-content-center"
												style="height: 185px; border-bottom: 1px solid #cccccc;">
												<img src="../resource/imgs/${articles.num_aticle}/${articles.goods_img}"
													class="d-block h-100 img-fluid img-thumbnail" >
												<%-- <p>이미지 경로 ${articles.goods_img}</p>
												<p>예약일때 표기 ex ${articles.deal_status}</p> --%>
											</div>
											<div class="card-body">
												<p class="card-text d-flex ">
													<span class="justify-content-left">제목:　</span>
													<span class="d-flex card-text">${articles.title} </span>
												</p>
												<p class="card-text d-flex ">
													<span class="justify-content-left">내용:　</span>
													<span class="d-flex card-text">${articles.contents} </span>
												</p>
												<div
													class="d-flex justify-content-between align-items-center">
													<div class="btn-group">
														<button type="button"
															class="btn btn-sm btn-outline-secondary">View</button>
													</div>
													<small class="text-muted">${articles.upload}</small>
												</div>
											</div>
										</div>
									</a>
								</div>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</section>


	<!--페이징 넘버처리-->
	<!-- 서블릿에서 넘어온 articlesMap.totArticles값을 c set을통해 totArticles로 설정하여 판단 -->
	<!-- 서블릿에서 넘어온 articlesMap.section값을 c set을통해 section로 설정하여 판단 -->
	<!-- 서블릿에서 넘어온 articlesMap.pageNum값을 c set을통해 pageNum로 설정하여 판단 -->
	<div>
		<c:if test="${totArticles != null }">
			<c:choose>
			
				<c:when test="${totArticles >100 }">
					<!-- 글 개수가 100 초과인경우 -->
					<nav>
						<ul class="pagination d-flex justify-content-center">
							<c:forEach var="page" begin="1" end="10" step="1">
								<c:if test="${section >1 && page==1 }">
									<li class="page-item"><a class="page-link"
										href="${contextPath }/board/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">pre</a>
									</li>
								</c:if>
								<li class="page-item"><a class="page-link"
									href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }</a>
								</li>
								<c:if test="${page ==10 }">
									<li class="page-item"><a class="page-link"
										href="${contextPath }/board/listArticles.do?section=${section+1}&pageNum=${section*10+1}">next</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</nav>
				</c:when>
				
				<c:when test="${totArticles == 100 }">
					<!--등록된 글 개수가 100개인경우  -->
					<nav>
						<ul class="pagination d-flex justify-content-center">
							<c:forEach var="page" begin="1" end="10" step="1">
								<li class="page-item">
									<a class="page-link" href="#">${page }</a>
								</li>
							</c:forEach>
						</ul>
					</nav>
				</c:when>

				<c:when test="${totArticles< 100 }">
					<!--등록된 글 개수가 100개 미만인 경우  -->
					<nav>
						<ul class="pagination d-flex justify-content-center">
							<c:forEach var="page" begin="1" end="${totArticles/10 +1}" step="1">
								<c:choose>
									<c:when test="${page==pageNum }">
										<li class="page-item active bs-green" aria-current="page">
											<a class="page-link" 
											href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page } </a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item">
											<a class="page-link" 
											href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page } </a>
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</nav>
				</c:when>
			</c:choose>
		</c:if>
	</div>

</body>
</html>

