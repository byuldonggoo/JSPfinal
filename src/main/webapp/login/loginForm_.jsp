<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!doctype html>
<html lang="ko">
<!-- 
<%
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie tempCookie : cookies) {
		if (tempCookie.getName().equals("id")) {
	//실행흐름이 서버에 있을때 서버코드로써 강제이동한다.
	//특정 page로 이동하라는 정보만 준다.
	response.sendRedirect("../index/index.jsp");
		}
	}
}
%>

 -->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.104.2">
<title>Best Seller</title>

<link rel="stylesheet" type="text/css"
	href="../resource/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="../resource/css/override.css">

<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>
<script type="text/javascript"
	src="../resource/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../resource/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="../resource/js/login.js"></script>
</head>

<body class="text-center">
	<main class="form-signin mw-100 mh-auto mt-5">
		<form class="w-25 m-auto mh-50 mt-5"
			action="${contextPath}/userController/login.do" method="post">
			<img alt="#" class="bi me-2 mb-5"
				src="../resource/banner/logo_green.png">
			<h1 class="h3 mb-3 fw-normal">Login</h1>

			<div class="form-floating">
				<input type="text" class="form-control w-100 mb-3"
					id="floatingInput" placeholder="id" name="id"> <label
					for="floatingInput">id</label>
			</div>
			<div class="form-floating">
				<input type="password" name="password"
					class="form-control w-100 mb-3" id="floatingPassword"
					placeholder="password"> <label for="floatingPassword">Password</label>
			</div>

			<!--아이디 비번 틀렸을때 디스플레이 속성등등 사용해서..
         나타내주거나 ...-->
			<c:if test="${loginResult== -1 || loginResult==0}">
				<div class="alert alert-success" role="alert">
					아이디 또는 비밀번호가 일치하지 않습니다.<br> 다시 입력해주세요.
				</div>
			</c:if>

			<div class="checkbox mt-3 mb-3 ">
				<!-- <label>
               <input type="checkbox"  name="loginChk" value = "true"> 자동로그인
            </label> -->
			</div>
			<button class="w-100 btn btn-lg btn-success mb-3" type="submit">Sign
				in</button>
			<button class="w-100 btn btn-lg btn-success" type="button"
				onclick="location.href='../join/joinForm_2.jsp'">Sign up</button>


		</form>
		

	</main>


	<script type="text/javascript">
		if (!Kakao.isInitialized()) {
			Kakao.init('a9bd1d62db585f44286b5451460b4031');
		};
		function kakaoLogout() {
			if (!Kakao.isInitialized()) {
				Kakao.init('a9bd1d62db585f44286b5451460b4031');
			}
			;
			if (Kakao.Auth.getAccessToken()) {
				Kakao.API.request({
					url : '/v1/user/unlink',
					success : function(response) {
						console.log(response)
						console.log('로그아웃 성공')
					},
					fail : function(error) {
						console.log(error)
					},
				})
				Kakao.Auth.setAccessToken(undefined)
			}
		}

		$(function() {
			$("#login_kakao").click(function(event) {
			//event.preventDefault();
				if (!Kakao.isInitialized()) {
					Kakao.init('a9bd1d62db585f44286b5451460b4031');
				};
				Kakao.Auth.login(
						{success : function(auth) {
							Kakao.API.request(
									{
															url : '/v2/user/me',
															success : function(
																	response) {
																var account = response.kakao_account;
																var email = account.email;

																console
																		.log('성공');

																$
																		.ajax({
																			url : "${contextPath}/KaoController/kaocheck.do",
																			type : "post",
																			data : {
																				email : email
																			},
																			success : function(
																					result) {
																				if (result == 1) {
																					alert(account.profile.nickname
																							+ "님 로그인되었습니다.");
																					$(
																							'#form_kakao input[name=email]')
																							.val(
																									account.email);
																					$(
																							'#form_kakao input[name=nickname]')
																							.val(
																									account.profile.nickname);
																					$(
																							'#form_kakao input[name=loginChk]')
																							.val(
																									'1');
																					document
																							.querySelector(
																									'#form_kakao')
																							.submit();
																					//location.href = '${contextPath}/KaoController/kaologin.do'
																				} else {
																					$(
																							'#form_kakao input[name=email]')
																							.val(
																									account.email);
																					$(
																							'#form_kakao input[name=nickname]')
																							.val(
																									account.profile.nickname);
																					document
																							.querySelector(
																									'#form_kakao')
																							.submit();
																					alert(account.profile.nickname
																							+ '님 가입을 환영합니다!');
																				}
																			}
																		});
															},fail : function(error) {
																console.log('오류가 발생했습니다.');
															}
														});
											},fail : function(error) {
												console.log('오류가 발생했습니다.');
											}
										});
							})
		})
	</script>


</body>

</html>
