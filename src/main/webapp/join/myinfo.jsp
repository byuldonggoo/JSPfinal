<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 조회</title>
<style>
@charset "utf-8";

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
    width:450px;
    height:400px;
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
    width:250px;
    height:25px;
    border:1px solid #cccccc;
    text-align:center;
    color:#666666;
}


</style>
</head>
<body>
<div id="join_wrap">
    <form action="join.asp" method="post" id="join">
        <fieldset>
            <legend>■가입정보</legend>
            <ul>
                <li><label for="uname">아이디</label><input type="text" id="uname" value ="${userInfo.id }" readonly></li>
                
                <li><label for="pwd1">닉네임</label><input type="text" id="nickname" value="${userInfo.nickname }" readonly></li>
                
                <li><label for="phone_number">핸드폰번호</label><input type="text" id="phone_number" value="${userInfo.phone_number }" readonly></li>
                
                <li><label for="addr">주소</label><input type="text" id="addr" value="${userInfo.addr }" readonly></li>
                
                <li><label for="detail_addr">상세주소</label><input type="text" id="detail_addr" value="${userInfo.detail_addr }" readonly></li>
            </ul>
        </fieldset>
        
        
        
               
    </form>
</div>
</body>
</html>