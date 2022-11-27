

Kakao.init('a9bd1d62db585f44286b5451460b4031');

function kakaoLogout() {
	if (!Kakao.isInitialized()) {
		Kakao.init('a9bd1d62db585f44286b5451460b4031');
	}
	;
	if (Kakao.Auth.getAccessToken()) {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function(response) {
				console.log(response)
				console.log('로그아웃 성공')
			},
			fail: function(error) {
				console.log(error)
			},
		})
		Kakao.Auth.setAccessToken(undefined)
	}
}

$(function(){
	
	$("#login_kakao").click(function(event){
		//event.preventDefault();
		if (!Kakao.isInitialized()) {
		Kakao.init('a9bd1d62db585f44286b5451460b4031');
	};
		Kakao.Auth.login({
			success:function(auth){
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response){
						var account = response.kakao_account;
						var email=account.email;
						
						console.log('성공');
						
						$.ajax({
							url:"${contextPath}/KaoController/kaocheck.do",
							type:"post",
							data:{email:email},
							success:function(result){
								if(result==1){
									alert(account.profile.nickname+"님 로그인되었습니다.");
									$('#form_kakao input[name=email]').val(account.email);
									$('#form_kakao input[name=nickname]').val(account.profile.nickname);
									$('#form_kakao input[name=loginChk]').val('1');
									document.querySelector('#form_kakao').submit();
									//location.href = '${contextPath}/KaoController/kaologin.do'
									
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
