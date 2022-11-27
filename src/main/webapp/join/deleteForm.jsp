<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>

<style>
ul,li{
    list-style:none;
}

body,div,form,fieldset,legend,ul,li,label,strong,input,p,button{
    margin:0; padding:0;
}

body,input,button{
    font:normal 12px/1.5em nanum,sans-serif;
    color:#333333;
    background-color:#ffffff;
}

input,button{
    outline:none;
}
@font-face{
		font-family:nanum;
		src:url('../font/NanumGothic.eot');
		src:url('../font/NanumGothic.eot?#iefix')format('embedded-opentype'),
			url('../font/NanumGothic.ttf')format('truetype'),
			url('../font/NanumGothic.woff')format('woff');
}

#join_wrap{
    border:1px solid rgba(135,135,135,0.5);
    width:430px;
    height:80px;
    padding:20px;
    margin-left:auto;
    margin-right:auto;
    margin-top:20px;
    border-radius:10px;
    box-shadow:2px 2px 3px #999999;
}

#join fieldset{
    border:none;
}

#join fieldset legend{
    height:20px;
    margin-bottom:10px;
}

#join ul li{
    clear:both;
    height:29px;
    margin-bottom:5px;
}

#join ul li label{
    width:120px;
    height:29px;
    display:block;
    float:left;
    line-height:29px;
    padding-left:30px;
}

#join ul li input{
    float:left;
    width:200px;
    height:25px;
    border:1px solid #cccccc;
    text-align:center;
    color:#666666;
}

.btnconfirm{
    background-color:#218b5a; 
}

.btnconfirm:hover{
    background-color:#000000;
    cursor: pointer;
    transition: all 0.5s ease-out;
}

</style>
<script type="text/javascript" src="../resource/js/jquery-3.6.0.js"></script>
</head>
<body>

<% 
	
%>
<div id="join_wrap">
    <form action="${contextPath}/userController/deleteUser.do" method="post" id="join">
        <fieldset>
            <legend>■회원탈퇴</legend>
            <ul>
                <li><label for="password">비밀번호 입력</label><input type="password" class="inputpwd" name="password" id="password" value ="">
                <input style="
                margin-left:10px; 
                width:40px; 
                color:white;" class="btnconfirm btn" type="submit" value="확인"></li>
            </ul>
        </fieldset>
    </form>
</div>





<script>
$('.btn').click(function(){
	let userPwd=$('.inputpwd').val();//input_id에 입력되는 값.
	//const link='${contextPath}/userController/deleteUser.do'
	
	$.ajax({
		url:"${contextPath}/userController/overlappwd.do",
		type:"post",
		data:{userPwd: userPwd},
		dataType:'json',
		success:function(result){ 
			if(result!=0){
				alert('비밀번호가 일치하지 않습니다. 다시 입력해주세요');
				$('.inputpwd').text('');
				$('.inputpwd').focus();
			}else{
				$('btn').submit();
			}
		},
		error:function(){
			alert("서버요청실패");
		}
	})
})
</script>
</body>
</html>