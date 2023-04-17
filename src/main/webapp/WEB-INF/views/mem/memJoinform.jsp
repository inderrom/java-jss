<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script>
$(function(){
	$("#memId").focus();
	let passExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
	let telExp = /^\d{3}-\d{4}-\d{4}$/;

	$("#wantjoin").on("click", function(){
		if($("#memNm").val() == "" || $("#memNm").val() == null){
			$("#isNameOk").html("<p style='color:red;'>이름을 입력하세요.</p>");
			$("#isNameOk").show();
			return;
		}else{
			$("#isNameOk").hide();
		}

		if($("#memTelno").val() == "" || $("#memTelno").val() == null){
			$("#isTelOk").html("<p style='color:red;'>전화번호를 입력하세요.</p>");
			$("#isTelOk").show();
			return;
		}else{
			$("#isTelOk").hide();
		}
		if($("#memPass").val() == "" || $("#memPass").val() == null){
			$("#isPassOk").html("<p style='color:red;'>비밀번호를 입력하세요.</p>");
			$("#isPassOk").show();
			return;
		}else{
			$("#isPassOk").hide();
		}
		if( regExp($("#memPass").val(), passExp) ){
			console.log("비밀번호 틀림");
			$("#isPassOk").html("<p style='color:red;'>비밀번호 형식을 틀렸습니다.</p><p>최소 8자 + 최소 한개의 영문자 + 최소 한개의 숫자 + 최소 한개의 특수 문자</p>");
			$("#isPassOk").show();
			return;
		}else{
			$("#isPassOk").hide();
		}
		if($("#memPass").val() != $("#memPassChk").val()){
			$("#isPassChkOk").html("<p style='color:red;'>비밀번호가 일치하지 않습니다.</p>");
			$("#isPassChkOk").show();
			return;
		}else{
			$("#isPassChkOk").hide();
		}
		if($("#isMemIdChkOk").html() != "OK"){
			$("#isMemIdChkOk").html("<p style='color:red;'>메일 인증을 진행해주세요.</p>");
			$("#isMemIdChkOk").show();
			return;
		}

		$("#frm").submit();
	});

	let certificationNumber = "";
	$("#btnMail").on("click", function(){
		$("#memIdChk").prop("disabled", false);
		$("#btnMailChk").prop("disabled", false);
		Swal.fire('인증번호를 메일로 전송했습니다.','메일을 확인해주세요. :)');
		$.ajax({
			url: "/api/sendCertificationNumberEmail",
			data: {"recipient": $("#memId").val()},
			type: "post",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log(result);
				certificationNumber = result;
			}
		});
	});

	$("#btnMailChk").on("click", function(){
		let memIdChk = $("#memIdChk").val();
		console.log(memIdChk);
		console.log(certificationNumber);
		if(certificationNumber == memIdChk){
			$("#memIdChk").prop("disabled", true);
			$("#btnMailChk").prop("disabled", true);
			Swal.fire('인증 성공 :)');
			$("#isMemIdChkOk").html("OK");
			$("#isMemIdChkOk").hide();
		}else{
			$("#isMemIdChkOk").html("<p style='color:red;'>인증번호가 일치하지 않습니다.</p>");
			$("#isMemIdChkOk").show();
		}
	});

	$("#memJob").on("focus", function(){
		$("#searchMemJob").addClass("show");
	});

	$("#memJob").on("keyup", function(){
		let keyword = $(this).val().toUpperCase();
		$.ajax({
			url: "/mem/getCommonCode",
			data: {
				"keyword": keyword,
				"clfc": "JOB"
			},
			type: "post",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
			success: function(commonCodeList){
				console.log(commonCodeList);
		        code = "";
		        $.each(commonCodeList, function(i, v){
		        	code += "<div>";
		        	code += "<li class='dropdown-item jobList'>" + v.cmcdDtlNm +"</li>";
		        	code += "</div>";
		        });
		        $("#searchMemJob").html(code);
			}
		});
	});

	$(document).on("click", ".jobList", function(){
		$("#memJob").val($(this).html());
		$("#searchMemJob").removeClass("show");
	});

});

function regExp(str, regExp){
	if(regExp.test(str)){
		return false;
	}else{
		return true;
	}
}
</script>

<style>
label{
	width: 150px;
}
input{
	width: 300px;
}
</style>

<div class="row justify-content-center" style="margin-top:15%;">

	<div class="col-xl-3 col-lg-3 col-md-6">
		<div class="card z-index-0 fadeIn3 fadeInBottom">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div class="bg-gradient-info shadow-primary border-radius-lg py-3 pe-1">
					<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">회원가입</h4>
					<div class="row mt-4">
					</div>
				</div>
			</div>
			<div class="card-body">
				<form role="form" id="frm" action="/mem/memJoin" method="post">
					<div class="input-group input-group-outline mb-3">
						<label class="form-label">아이디</label>
						<input type="email" class="form-control" id="memId" name="memId" value="${memId}" readonly/>
						<button type="button" class="btn bg-gradient-info" id="btnMail" style="width:30%; margin-bottom:0px;">메일 인증</button>
					</div>
					<div class="input-group input-group-outline mb-3">
						<label class="form-label">인증번호 확인</label>
						<input type="text" class="form-control" id="memIdChk" required disabled/>
						<button type="button" class="btn bg-gradient-info" id="btnMailChk" style="width:30%; margin-bottom:0px;" disabled>인증</button>
					</div>
					<div class="input-group input-group-static mb-3" style="display:none;"  id="isMemIdChkOk"></div>
					<div class="input-group input-group-static mb-3">
						<label>이름</label>
						<input type="text" class="form-control" id="memNm" name="memNm" required/>
					</div>
					<div class="input-group input-group-static mb-3" style="display:none;"  id="isNameOk"></div>
					<div class="input-group input-group-static mb-3">
						<label class="form-label">휴대폰 번호</label>
						<input type="text" class="form-control" id="memTelno" name="memTelno" required/>
					</div>
					<div class="input-group input-group-static mb-3" style="display:none;" id="isTelOk"></div>
					<div class="input-group input-group-static mb-3">
						<label class="form-label">비밀번호</label>
						<input type="password" class="form-control" id="memPass" name="memPass"/>
					</div>
					<div class="input-group input-group-static mb-3" style="display:none;" id="isPassOk"></div>
					<div class="input-group input-group-static mb-3">
						<label class="form-label">비밀번호 확인</label>
						<input type="password" class="form-control" id="memPassChk" name="memPassChk"/>
					</div>
					<div class="input-group input-group-static mb-3" style="display:none;"  id="isPassChkOk"></div>
					<div class="input-group input-group-outline mb-3">
						<label class="form-label">직업</label>
						<input type="text" class="form-control" id="memJob" name="memJob"/>
					</div>
					<ul id="searchMemJob" class="dropdown-menu" style="bottom: 65px;"></ul>
					<div class="text-center">
						<button type="button" class="btn bg-gradient-info" onclick="insertInput()">데이터 입력</button>
						<button type="button" class="btn bg-gradient-info my-4 mb-2" id="wantjoin" style="width: 80%;">회원가입</button>
						<br/>
					</div>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
function insertInput(){
	$("#memNm").val("박설아");
	$("#memTelno").val("010-1234-1234");
	$("#memPass").val("qwer1234!");
	$("#memPassChk").val("qwer1234!");
	$("#memJob").val("백엔드 개발자");
}
</script>