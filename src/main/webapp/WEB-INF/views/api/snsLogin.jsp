<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<h3>SNS 로그인</h3>
<div>
    <a href="javascript:kakaoLogin();"><img src="./kakao_login.png" alt="카카오계정 로그인" style="height: 100px;"/></a>
    <a href="javascript:kakaoLogout();"><img src="./kakao_login.png" alt="카카오계정 로그아웃" style="height: 100px;"/></a>
    <a href="javascript:secession();"><img src="./kakao_login.png" alt="카카오계정 탈퇴" style="height: 100px;"/></a>

    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
    <script>
        window.Kakao.init('07456a9f4803641615581d7b53fb0ee3');

        function kakaoLogin() {
            window.Kakao.Auth.login({
                scope: 'profile_nickname, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
                success: function(response) {
                    console.log(response) // 로그인 성공하면 받아오는 데이터
                    window.Kakao.API.request({ // 사용자 정보 가져오기 
                        url: '/v2/user/me',
                        success: (res) => {
                            const kakao_account = res.kakao_account;
                            console.log(kakao_account)
                        }
                    });
                    // window.location.href='/ex/kakao_login.html' //리다이렉트 되는 코드
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        }
        
    	function kakaoLogout() {
        	if (!Kakao.Auth.getAccessToken()) {
    		    console.log('Not logged in.');
    		    return;
    	    }
    	    Kakao.Auth.logout(function(response) {
        		alert(response +' logout');
//     		    window.location.href='/'
    	    });
		};
		
		function secession() {
			Kakao.API.request({
		    	url: '/v1/user/unlink',
		    	success: function(response) {
		    		console.log(response);
		    		//callback(); //연결끊기(탈퇴)성공시 서버에서 처리할 함수
// 		    		window.location.href='/'
		    	},
		    	fail: function(error) {
		    		console.log('탈퇴 미완료')
		    		console.log(error);
		    	},
			});
		};
</script>
</div>
