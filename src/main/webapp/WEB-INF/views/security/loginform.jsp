<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	let memIdExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

	let memId = "${cookie.memId.value}";

	let loginFailedCount = "${cookie.loginFailedCount.value}";

	$(function() {
		$("#username").focus();

		if (memId.length > 0) {
			$("#btnLogin").attr("data-input", "pass");
			$("#divid").hide();
			$("#divpass").show();
		}

		if (loginFailedCount >= 5) {
			grecaptcha.render('g-recaptcha', {
				'sitekey' : '6Ldto5saAAAAALjQt_YLT6L11O3NNFKcjgggPMb-'
			});
		}

		$("#btnLogin").on("click", login);

		$("#username").on("keyup", function(event){
			if(event.keyCode == 13){
				login();
			}
		});
		$("#password").on("keyup", function(event){
			if(event.keyCode == 13){
				login();
			}
		});

	});

	function login(){
		if ($("#btnLogin").attr("data-input") == "email") {
			if (regExp($("#username").val(), memIdExp)) {
				console.log("이메일 아님");
				return;
			}

			$.ajax({
				url : "/mem/existMem",
				data : {
					"memId" : $("#username").val()
				},
				type : "post",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success : function(result) {
					console.log("result: " + result);
					if (result == 1) {
						console.log("success");
						$("#btnLogin").attr("data-input","pass");
						$("#isOk").remove();
						$("#msg").remove();
						$("#divid").hide();
						$("#divpass").show();
						$("#password").focus();
					} else if(result == 2){
						Swal.fire("카카오로 로그인 하세요.");
						return;
					} else{
						$("#frm").attr("action","/mem/memJoinform");
						$("#frm").submit();
					}
				}
			});
		} else {
			if (loginFailedCount >= 5) {
				if (grecaptcha.getResponse().length < 1) {
					Swal.fire("reCaptcha 인증을 해주세요.");
					return false;
				}
			}

			$("#frm").submit();
		}
	}

	function regExp(str, regExp) {
		if (regExp.test(str)) {
			console.log("regExp success");
			return false;
		} else {
			document.querySelector("#isOk").innerHTML = "<p style='color:red;'>이메일 형식으로 입력해주세요.</p>";
			return true;
		}
	}

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
	                       console.log(kakao_account);
	                       console.log(kakao_account.email);
	                       console.log(kakao_account.profile.nickname);

						   let memId = kakao_account.email;
						   let memNm = kakao_account.profile.nickname;
						   let memVO = {
										   "memId": memId,
										   "memNm": memNm
									   };
	                       $.ajax({
	                           url:"/mem/kakaoLogin",
	                           contentType:"application/json;charset='UTF-8'",
	                           data: JSON.stringify(memVO),
	                           type:"post",
	                           beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                                  xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                           },
	                           success:function(pass){
	                              console.log("pass: " + pass);
	                              $("#username").val(memId);
	                              $("#password").val(pass);
	                              console.log("username : " + $("#username").val() + ", password: " + $("#password").val());
	                              $("#frm").submit();
	                           }
	                        });
	                   }
	               });
	               // window.location.href='/ex/kakao_login.html' //리다이렉트 되는 코드
	           },
	           fail: function(error) {
	               console.log(error);
	           }
	       });
	   }

	   function resetPass(){
		   if($("#username").val() == null || $("#username").val() == ""){
			   Swal.fire("아이디를 입력하세요.");
			   return;
		   }

		   let memId = $("#username").val();
		   console.log(memId);

		   sessionStorage.setItem("memId", memId);
		   location.href="/mem/forgotPass";
	   }
</script>


<div class="row justify-content-center" style="margin-top:20%;">

	<div class="col-xl-3 col-lg-3 col-md-6">
		<div class="card z-index-0 fadeIn3 fadeInBottom">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div class="bg-gradient-info shadow-primary border-radius-lg py-3 pe-1">
					<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">로그인</h4>
					<div class="row mt-4">
					</div>
				</div>
			</div>
			<div class="card-body">
				<form role="form" class="text-start" action="/login" method="post" id="frm">
					<div class="input-group">
						<span id="isOk"></span>
					</div>
					<div class="input-group input-group-static my-sm-4" id="divid">
						<label>아이디</label>
						<input type="email"	class="form-control" id="username" name="username" value="${cookie.memId.value}" placeholder="이메일 형식으로 입력해주세요." required>
					</div>
					<div class="input-group">
						<c:if test="${cookie.msg.value eq 'no'}" >
							<span id="msg" style="color: red;">비밀번호를 틀렸습니다.</span>
						</c:if>
					</div>
					<div class="input-group input-group-static my-sm-4" id="divpass" style="display:none;">
						<label>Password</label>
						<input type="password" class="form-control" id="password" name="password" />
					</div>
					<div id="g-recaptcha" ></div>
					<div class="form-check form-switch d-flex align-items-center mb-3 is-filled">
						<input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me">
						<label class="form-check-label mb-0 ms-3" for="rememberMe">Remember me</label>
					</div>
					<div class="text-center">
						<div>
							<button type="button" class="btn bg-gradient-info my-2 " id="btnLogin" data-input="email" style="width: 100%;">Sign in</button>
						</div>
						<div>
							<a href="javascript:kakaoLogin();">
								<button type="button" class="btn btn-kakao btn-icon mt-2" style="padding: 0px;">
								    <span class="btn-inner--icon"><img src="/resources/images/kakao_login.png" alt="카카오계정 로그인" style="width: 100%; " /></span>
								</button>
							</a>
						</div>
						<div id="resetpw">
							<a href="javascript:resetPass();">비밀번호 재설정</a>
						</div>
					</div>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>
