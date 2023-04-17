<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://www.google.com/recaptcha/api.js" async defer></script>

<script type="text/javascript">
  //	화면 시작 시 g-recaptcha 생성
$(function(){
	grecaptcha.render('g-recaptcha', {
		'sitekey' : '6Ldto5saAAAAALjQt_YLT6L11O3NNFKcjgggPMb-'
	});
	
	$("#loginBtn").on("click", function(){
		console.log(grecaptcha.getResponse());
		if(grecaptcha.getResponse().length < 1){
			alert("reCaptcha 인증을 해주세요.");
		}else{
			alert("인증 성공");
		}
	});
});
</script>

<h4>로그인 5회 실패하는것만 체크하면 됨</h4>
쿠키로 하면 될듯

<!-- reCAPTCHA 용 div -->
<div id="g-recaptcha" ></div>
<br>

<div>
	<input type="button" class="disabled-btn" id="loginBtn" value="로그인">
</div>