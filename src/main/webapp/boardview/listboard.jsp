<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="board.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>


<link rel="stylesheet" type="text/css" href="../resource/css/test.css">

<link rel="stylesheet" type="text/css"
	href="../resource/css/bootstrap.css">
<script type="text/javascript"
	src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>

<style>
a {
	color: #999999;
	text-decoration: none;
}

.newatcl {
	position: fixed;
	right: 50px;
	bottom: 50px;
	font-size: 50px;
	width: 60px;
	height: 60px;
	background-color: #80d100;
	text-align: center;
	line-height: 50px;
	border-radius: 50%;
}

.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

.b-example-divider {
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 100vh;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: auto;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
	color: #80d100;
	width: 40px;
	height: 40px;
}

.login_false {
	display: none;
}

.login_true {
	display: inline-block;
}

.c {
	background-color: #80d100;
}

.mgt {
	margin-top: 30px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="py-2 bg-light border-bottom">
		<div class="container d-flex flex-wrap">
			<ul class="nav me-auto">
				<!--여기 뭐 넣을지 생각....-->
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2 active" aria-current="page">Home</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Features</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">Pricing</a></li>
				<li class="nav-item"><a href="#"
					class="nav-link link-dark px-2">About</a></li>
			</ul>
			<ul class="nav">
				<!--클래스로 로그인 유무 display 조정-->
				<li class="nav-item login_true "><a href=""> <!--마이페이지 이동-->
						<!--로그인 자기 이미지 띄우기--> <img src="https://github.com/mdo.png"
						alt="mdo" width="40" height="40" class="rounded-circle">
				</a></li>
				<li class="nav-item login_true "><a href="#"
					class="nav-link link-dark px-2">Logout</a></li>
				<!--클래스로 로그인 유무 display 조정-->
				<li class="nav-item login_false">
					<!--로그인 페이지 이동--> <a href="#" class="nav-link link-dark px-2">Login</a>
				</li>

				<li class="nav-item login_false">
					<!--회원가입 페이지 이동--> <a href="#" class="nav-link link-dark px-2">Sign
						up</a>
				</li>
			</ul>
		</div>
	</nav>

	<header class="py-3 mb-4 border-bottom">
		<div class="container d-flex flex-wrap justify-content-center">
			<a href="/"
				class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
				<img alt="#" class="bi me-2" src="../resource/banner/logo_green.png">
				<span class="fs-4">Best Seller</span>
			</a>
			<form class="col-12 col-lg-auto mb-3 mb-lg-0" role="search">
				<input type="search" class="form-control" placeholder="제품 검색"
					aria-label="Search">
			</form>
		</div>
	</header>

	<main>
		<div id="carouselExampleFade" class="carousel slide carousel-fade"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active" data-bs-interval="500">
					<img src="../resource/banner/001.png" class="d-block w-100">

				</div>
				<div class="carousel-item" data-bs-interval="500">
					<img src="../resource/banner/002.png" class="d-block w-100">

				</div>
				<div class="carousel-item" data-bs-interval="500">
					<img src="../resource/banner/003.png" class="d-block w-100">

				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleFade" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleFade" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</main>

	<!--등록 제품 사진-->

	<!--새글 등록 fixed-->
	<a class="newatcl" href="${contextPath}/board/addboard.do">+</a>
	<!--gpem-->
	<section>
		<div class="container d-flex flex-wrap justify-content-center">
			<h2
				class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none mgt">오늘의
				추천 상품</h2>
		</div>


		<!-- 서블릿에서 넘어온 articlesMap.articlesList값을 c set을통해 articlesList로 설정하여 판단 -->
		<!-- articlesList를 articles로 재정의 하여 VO값을 꺼내온다 -->
<c:set var="articlesList" value="${articlesMap.articlesList}" />
<c:set var="totArticles" value="${articlesMap.totArticles}" />
<c:set var="section" value="${articlesMap.section}" />
<c:set var="pageNum" value="${articlesMap.pageNum}" />
		<div class="album py-5 bg-light">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-3">
					<c:choose>
						<c:when test="${empty articlesList }">
							<p>리스트가 없습니다.</p>
						</c:when>
						<c:when test="${!empty articlesList }">

							<c:forEach var="articles" items="${articlesList }">
								<div class="col">
									<a
										href="${contextPath}/board/readArticle.do?num_aticle=${articles.num_aticle}">
										<div class="card shadow-sm text-center">
											<span style="width: 150px; display: none;">${articles.num_aticle}</span>
											<div class="bd-placeholder-img card-img-top w-100"
												style="height: 185px; border-bottom: 1px solid #cccccc;">
												<img
													src="../resource/imgs/${articles.num_aticle}/${articles.goods_img}"
													class="d-block h-100 img-fluid img-thumbnail">
												<p>이미지 경로 ${articles.goods_img}</p>
												<p>예약일때 표기 ex ${articles.deal_status}</p>
											</div>
											<div class="card-body">
												<p class="card-text">${articles.title}</p>
												<p class="card-text">${articles.contents}</p>
												<div
													class="d-flex justify-content-between align-items-center">
													<div class="btn-group">
														<button type="button"
															class="btn btn-sm btn-outline-secondary">View</button>
														<button type="button"
															class="btn btn-sm btn-outline-secondary">Edit</button>
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



</body>
</html>