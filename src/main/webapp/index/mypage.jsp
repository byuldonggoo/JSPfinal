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
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Insert title here</title>

<link rel="stylesheet" type="text/css"
	href="../resource/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="../resource/css/override.css">
<script type="text/javascript"
	src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>

</head>
<body>
	<nav class="py-2 bg-light border-bottom ">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<!--여기 뭐 넣을지 생각....-->
				<li class="nav-item"><a
					href="${contextPath}/board/listArticles.do"
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
				<li class="nav-item login_true "><a
					href="${contextPath}/index/mypage.jsp"> <!--마이페이지 이동--> <!--로그인 자기 이미지 띄우기-->
						<img src="../resource/users/${userInfo.profile_img }" alt="mdo"
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
	<main class="container">
		<div class="container d-flex justify-content-evenly">
			<h2 style="text-align: center;"
				class="font-monospace text-muted text-uppercase">${userInfo.nickname }님 <span style="#666666">마이페이지</span>	<br> 
			</h2>
		</div>

		<div class="container">
			<div class="row ">
				<div class="col">
					<div
						class="bd-example-snippet d-flex bd-code-snippet justify-content-end">
						<div class="col-lg-2 imgContainer justify-content-end">
							<img style="width: 100%; height: 100%;"
								src="../resource/users/${userInfo.profile_img}"
								class="figure-img img-fluid rounded mt-2 " alt="preview">
						</div>
					</div>
				</div>
				<div class="col">
					<div class="input-group mb-3 mt-2 row">
						<a href="../join/myinfo.jsp"
							class="btn btn-outline-success btn-sm  w-25" tabindex="-1"
							role="button" aria-disabled="true">정보조회</a>
					</div>
					<div class="input-group mb-1 mt-3 row">
						<a href="../join/updateform.jsp"
							class="btn btn-outline-success btn-sm w-25" tabindex="-1"
							role="button" aria-disabled="true">정보수정</a>
					</div>
					<div class="input-group mb-3 mt-3 row">
						<a href="../join/deleteForm.jsp"
							class="btn btn-outline-success btn-sm w-25" tabindex="-1"
							role="button" aria-disabled="true">회원탈퇴</a>
					</div>

				</div>
				<hr style="color: green; margin-top:1em;" >
			</div>
		</div>
	</main>
	
	<!--페이징 넘버처리-->
	<!-- 서블릿에서 넘어온 articlesMap.totArticles값을 c set을통해 totArticles로 설정하여 판단 -->
	<!-- 서블릿에서 넘어온 articlesMap.section값을 c set을통해 section로 설정하여 판단 -->
	<!-- 서블릿에서 넘어온 articlesMap.pageNum값을 c set을통해 pageNum로 설정하여 판단 -->
	<!--<%-- 	<div>
		<c:if test="${totArticles != null }">
			<c:choose>
				<c:when test="${totArticles >100 }">
					<!-- 글 개수가 100 초과인경우 -->
					<nav>
						<ul class="pagination d-flex justify-content-center">
							<c:forEach var="page" begin="1" end="10" step="1">

								<c:if test="${section >1 && page==1 }">
									<li class="page-item"><a class="page-link"
										href="${contextPath }/board/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">pre
									</a></li>
								</c:if>

								<li class="page-item"><a class="page-link"
									href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
								</a></li>

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
								<li class="page-item"><a class="page-link" href="#">${page }</a>
								</li>
							</c:forEach>
						</ul>
					</nav>
				</c:when>

				<c:when test="${totArticles< 100 }">
					<!--등록된 글 개수가 100개 미만인 경우  -->
					<nav>
						<ul class="pagination d-flex justify-content-center">
							<c:forEach var="page" begin="1" end="${totArticles/10 +1}"
								step="1">
								<c:choose>
									<c:when test="${page==pageNum }">
										<li class="page-item active bs-green" aria-current="page">
											<a class="page-link"
											href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page }
										</a>
										</li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link"
											href="${contextPath }/board/listArticles.do?section=${section}&pageNum=${page}">${page }
										</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</ul>
					</nav>
				</c:when>
			</c:choose>
		</c:if>
	</div>
 --%>-->

</body>
</html>