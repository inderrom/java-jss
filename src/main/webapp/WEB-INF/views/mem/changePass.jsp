<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
$(function(){
	$("#memId").focus();
	let passExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,12}$/;
	
	$("#btnChangePass").on("click", function(){
		let password = $("#password").val();
		let passwordChk = $("#passwordChk").val();
		
		if(password == ''){
			$("#isPassOk").html("<p style='color:red;'>비밀번호를 입력하세요.</p>");
			$("#isPassOk").show();
			$("#password").focus();
			return;
		}else{
			$("#isPassOk").hide();
		}
		
		if(!passExp.test(password)){
			$("#isPassOk").html("<p style='color:red;'>비밀번호 형식이 잘못되었습니다.</p>");
			$("#isPassOk").show();
			$("#password").focus();
			return;
		}else{
			$("#isPassOk").hide();
		}
		if(password != passwordChk){
			$("#isPassChkOk").html("<p style='color:red;'>비밀번호가 일치하지 않습니다.</p>");
			$("#isPassChkOk").show();
			$("#passwordChk").focus();
			return;
		}else{
			$("#isPassChkOk").hide();
		}
		
		$.ajax({
			url: "/mem/updatePass",
			data:{
				"memId": "${memId}",
				"memPass": password
				},
			type: "post",
			beforeSend : function(xhr) {   
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    success: function(result){
		    	console.log(result);
		    	if(result > 0){
					deleteCookie("loginFailedCount");
					deleteCookie("memId");
					deleteCookie("msg");
					Swal.fire('비밀번호가 변경되었습니다. :)');
		    		location.href = "/login";
		    	}else{
					Swal.fire('다시 시도해주세요.');
		    	}
		    	
		    }
		});
	});
});

function deleteCookie(name) {
	document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
}
</script>
<div class="row justify-content-center" style="margin-top:10%;">
	<div class="col-xl-3 col-lg-3 col-md-6">
		<div class="card z-index-0 fadeIn3 fadeInBottom">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div class="bg-gradient-info shadow-primary border-radius-lg py-3 pe-1">
					<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">비밀번호 재설정</h4>
					<div class="row mt-4">
					</div>
				</div>
			</div>
			<div class="card-body">
				<div class="input-group input-group-outline my-3" >
					<label class="form-label">아이디</label> 
					<input type="text"	class="form-control" id="memId" name="memId" value="${memId}" readonly>
				</div>
				<div class="input-group input-group-outline my-3" >
					<label class="form-label">새로운 비밀번호</label> 
					<input type="password"	class="form-control" id="password" name="password">
				</div>
				<div class="input-group input-group-outline mb-3" style="display:none;" id="isPassOk"></div>
				<div class="input-group input-group-outline my-3" >
					<label class="form-label">새로운 비밀번호 확인</label>
					<input type="password"	class="form-control" id="passwordChk" name="passwordChk">
				</div>
				<div class="input-group input-group-outline mb-3" style="display:none;" id="isPassChkOk"></div>
				<div class="text-center">
					<button type="button" id="btnChangePass" class="btn bg-gradient-info my-4 mb-2" style="width: 80%;">저장</button>
				</div>
			</div>
		</div>
	</div>
</div>