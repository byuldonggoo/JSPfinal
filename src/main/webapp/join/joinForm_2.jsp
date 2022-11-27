<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="../resource/css/layout3.css">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>

</head>
<body>
	<div id="join_container">
		<p id="logo" style="margin: 20px auto; width: 250px; height: 250px;">
			<img src="../resource/banner/logo_green.png" alt="#"
				style="width: 250px; height: 250px;">
		</p>
		<h3>회원가입</h3>

		<form action="${contextPath}/join.do" method="post" id="join"
			enctype="multipart/form-data">
			<fieldset class="join1">
				<legend>필수 입력 항목</legend>
				<p class="box_i">
					<label for="u_name"> 아이디</label><input type="text" name="id"
						id="u_name" class="input_id" autocomplete="off" required><input
						type="button" value="중복확인" class="zip_btn overlap">
				</p>
				<p id="checkId"></p>
				<p class="box_i">
					<label for="pwd1"> 비밀번호</label><input type="password"
						name="password" id="pwd1" autocomplete="off" required>
				</p>
				<p id="pwdtext"></p>
				<p class="box_i">
					<label for="pwd2"> 비밀번호 확인</label><input type="password"
						name="password" id="pwd2" autocomplete="off" required>
				</p>
				<p id="pwdChk"></p>
				<p class="box_i">
					<label for="u_id"> 닉네임</label><input type="text"
						class="input_nickname" id="u_id" name="nickname"
						autocomplete="off">
				</p>
				<p id="checkNickname"></p>
				<p class="box_i">
					<label for="u_id"> 휴대폰번호</label><input type="text"
						class="phone_number" id="u_id" name="phone_number"
						autocomplete="off">
				</p>
				<p id="checkphone"></p>
				<p class="box_i">
					<label for="u_id"> 이메일주소</label><input type="text" class="email"
						id="u_id" name="email" autocomplete="off"><input
						type="button" value="메일전송" class="zip_btn emailBtn">
				</p>
				<p id="checkId"></p>
				<p class="box_i">
					<label for="u_id"> 인증번호</label><input type="text" id="u_id"
						class="emailConfirm" name="emailConfirm" autocomplete="off"
						required><input type="button" value="번호인증"
						class="zip_btn confirmBtn">
				</p>
				<p id="checkEmail"></p>
			</fieldset>

			<fieldset class="join1">
				<legend>선택 입력 항목</legend>
				<p class="box_i">
					<label for="u_name"> 주소</label><input style="width: 200px;"
						type="text" id="address_kakao" name="addr" readonly
						autocomplete="off" />
				</p>
				<p class="box_i">
					<label for="u_name"> 상세주소</label><input style="width: 200px;"
						type="text" name="detail_addr" class="detail_addr"
						autocomplete="off" />
				</p>
				
				<!-- 프로필 사진 미리보기 -->
				<p id="profile_picture">
					<img id="preview"
						style="width: 200px; height: 200px; margin-left: 120px; display: none; border-radius: 50%;" />
				</p>
				<!-- 프로필사진 업로드 input -->
				<p class="box_i">
					<label for="u_name"> 프로필사진</label><input type="file" class="upfile" id="u_name"
						name="profile_img" accept=".jpg, .jpeg, .png"> 
				</p>

			</fieldset>
			<p class="btn">
				<input class="final" type="submit" value="회원가입"> <input
					class="final" type="reset" value="다시작성">
			</p>
		</form>

	<!-- 카카오 회원가입 폼 -->
		<form id="form_kakao" method="post"
			action="${contextPath}/KaoController/addkaouser.do">
			
			<input type="hidden" name="email" /> <input type="hidden"
				name="nickname" /> <input type="hidden" name="loginChk" /> 
			<div style="margin-top: 20px;">
				<a id="kakao_submit" href="#" style="margin-left: 150px;"> <img
					src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
					width="200" alt="카카오 로그인 버튼" />
				</a>
			</div>
		</form>
	</div>



<script type="text/javascript">

$(document).ready(function(){
//카카오로그인 기능
Kakao.init('a9bd1d62db585f44286b5451460b4031');

//로그아웃
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
      Kakao.Auth.setAccessToken(undefined)
    }
  }  

$(function(){
	//로그인, 회원가입 동시
	$("#kakao_submit").click(function(event){
		//event.preventDefault();
		//
		if (!Kakao.isInitialized()) {
			//카카오 개발자 내 앱 키
		Kakao.init('a9bd1d62db585f44286b5451460b4031');
	};
		Kakao.Auth.login({
			success:function(auth){ //로그인 성공시 
				Kakao.API.request({
					url: '/v2/user/me',//api호출
					success: function(response){
						
						var account = response.kakao_account;
						//카카오계정 이메일 가져오기
						var email=account.email;
						
						console.log('성공');
						
						$.ajax({
							url:"${contextPath}/KaoController/kaocheck.do",
							type:"post",
							//카카오계정 이메일 전송
							data:{email:email},
							success:function(result){
								//DB에 이미 계정이 존재하면 바로 로그인
								if(result==1){
									alert(account.profile.nickname+"님 로그인되었습니다.");
									//hidden 타입 input 태그들에 값 적용
									$('#form_kakao input[name=email]').val(account.email);
									$('#form_kakao input[name=nickname]').val(account.profile.nickname);
									$('#form_kakao input[name=loginChk]').val('1');
									document.querySelector('#form_kakao').submit();
									//location.href = '${contextPath}/KaoController/kaologin.do'
								
									//DB에 계정이 존재하지 않으면 회원가입 과정
								}else {
									$('#form_kakao input[name=email]').val(account.email);
									$('#form_kakao input[name=nickname]').val(account.profile.nickname);
									document.querySelector('#form_kakao').submit();
									alert(account.profile.nickname+'님 가입을 환영합니다!');
								}
							}
						});
					},
					fail: function(error){
						console.log('오류가 발생했습니다.');
					}
				}); 
			}, 
			fail:function(error){
				console.log('오류가 발생했습니다.');
			}
		}); 
	}) 
})
//프로필사진 미리보기

$(document).ready(function(){
	//파일첨부 input이 바뀌면 handleImgSelect실행
	$(".upfile").on("change",handleImgSelect);
})

function handleImgSelect(e){
	//해당 파일 가져오기
	var files=e.target.files;
	var reader=new FileReader();
	//reader에 파일이 업로드되면
	reader.onload=function(e){
		//src에 이미지부여, none으로 되어있던 display 보이게 변경
		$("#preview").attr("src",e.target.result);
		$("#preview").css("display","block");
	}
	//reader에 0번째 인덱스 업로드
	reader.readAsDataURL(files[0]);
}


//주소검색
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}

//핸드폰번호 정규식
$('.phone_number').keyup(function(){
	let phonenumber=$('.phone_number').val();	
	let phonecheck = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	    if (!phonecheck.test(phonenumber)){
	    	$('#checkphone').html('알맞은 핸드폰 번호를 입력해주세요');
	    }else{
	    	$('#checkphone').html('알맞은 형식입니다.');
	    }	
})

//인증번호 확인
$('.confirmBtn').click(function(){
	
	let emailConfirm=$('.emailConfirm').val();
	if(emailConfirm==''){
		alert('인증번호를 입력하세요');
		return;
	}
	
	$.ajax({
		url:"${contextPath}/userController/emailConfirm.do",
		type:"post",
		data:{emailConfirm: emailConfirm}, //인증번호 전송
		success:function(result){
			if(result==1){ //인증번호가 일치하면
				$('#checkEmail').text('인증되었습니다.');
			}else{//일치하지 않으면
				alert('번호가 일치하지 않습니다. 다시 입력해주세요.')
				$('.emailConfirm').focus();
			}
		},
		error:function(request,status,error){
			console.log("code:"+request.status+"\n"+"message:"
					+request.responseText+"\n"+"error:"+error);}
	})
})
//인증이메일전송
$('.emailBtn').click(function(){
	let emailAdr=$('.email').val();
	
	$.ajax({
		url:"${contextPath}/userController/sendEmail.do",
		type:"post",
		data:{emailAdr: emailAdr},
		success:function(result){ 
			console.log('보내기 성공')
		},
		error:function(request,status,error){        
		console.log("code:"+request.status+"\n"+"message:"
				+request.responseText+"\n"+"error:"+error);}
	})
	alert('메일을 보냈습니다.')
})


//아이디중복확인
$('.overlap').click(function(){
	let userId=$('.input_id').val();//input_id에 입력되는 값.
	
	$.ajax({
		url:"${contextPath}/userController/overlapChk.do",
		type:"post",
		data:{userId: userId},
		dataType:'json',
		success:function(result){ //result: overlapChk.do 에서 넘겨준 값
			if(result==0){
				alert('이미 등록된 아이디입니다. 다른 아이디를 입력해주세요.');
			}else{
				alert('사용할 수 있는 아이디입니다.');
			}
		},
		error:function(){
			alert("서버요청실패");
		}
	})
})

//아이디유효성검사(영소문자, 숫자 가능 6자 이상)
$('.input_id').keyup(function(){
	let idval = $('.input_id').val()
    let idvalcheck = /^[a-z0-9]+$/
    if (!idvalcheck.test(idval) || idval.length<6){
    	$('#checkId').html('영소문자,숫자 가능(6자이상)');
    }else{
    	$('#checkId').html('사용가능한 아이디입니다.');
    }	
})

//비밀번호 유효성(영문자와 숫자 포함, 8~16자)
$('#pwd1').keyup(function(){
	let pwdval = $('#pwd1').val()
    let pwdvalcheck = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/
    if (!pwdvalcheck.test(pwdval) || pwdval.length<8){
    	$('#pwdtext').html('영문자,숫자를 포함해주세요(8~16자)');
    }else{
    	$('#pwdtext').html('사용가능한 비밀번호입니다.');
    }	
})
//비밀번호 일치 확인
$('#pwd2').blur(function(){
	if($('#pwd1').val()!=$("#pwd2").val()){
		if($('#pwd2').val()!=''){
			alert("비밀번호가 일치하지 않습니다. 다시입력해주세요");
			$('#pwd2').val('');
			$('#pwd2').focus();
			$('#pwdChk').html('');
		}
	}else{
		$('#pwdChk').html('비밀번호가 일치합니다.');
	}
})


//닉네임 중복확인
$('.input_nickname').keyup(function(){
	let userNickname=$('.input_nickname').val();//input_id에 입력되는 값.
	
	$.ajax({
		url:"${contextPath}/userController/overlapChkNickname.do",
		type:"post",
		data:{userNickname: userNickname},
		dataType:'json',
		success:function(result){ //result: overlapChk.do 에서 넘겨준 값
			if(result==0){
				$('#checkNickname').html('이미 등록된 닉네임입니다.');
			}else{
				$('#checkNickname').html('사용할 수 있는 닉네임입니다.');
			}
		},
		error:function(){
			alert("서버요청실패");
		}
	})
})

});
</script>
	
</body>
</html>