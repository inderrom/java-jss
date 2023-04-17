<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script>
$(function() {
	let memId = sessionStorage.getItem("memId");
	console.log(memId);
	$("#memId").html("<b class='bg-gray-200 text-center mx-sm-auto w-md-80 p-sm-3'>"+memId+"</b>");

	$("#btnLogin").on("click",function(){
		location.href="/java/";
	});
	
	$.ajax({
		url: "/api/sendForgotPassEmail",
		data: {"recipient": memId},
		type: "post",
		beforeSend : function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log("success");
		}
	});
});
</script>
<div class="row justify-content-center" style="margin-top:15%;">
	<div class="col-xl-3 col-lg-3 col-md-6">
		<div class="card z-index-0 fadeIn3 fadeInBottom">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div class="bg-gradient-info shadow-primary border-radius-lg py-3 pe-1">
					<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">비밀번호 재설정</h4>
					<div class="row mt-4">
					</div>
				</div>
			</div>
			<div class="card-body text-center">
				<h3>비밀번호 재설정</h3>
				<br/>
				<h5>이메일을 전송했어요.</h5>
				<small>
					비밀번호 재설정을 위한 이메일을 전송했어요.<br/>
					이메일이 오지 않았다면, 이메일이 맞는지 확인해주세요.
				</small>
			</div>
			<div id="memId" class="input-group input-group-outline my-3">
			</div>
			<div class="text-center">
				<button type="button" class="btn bg-gradient-info my-4 mb-2" id="btnLogin" style="width: 80%;">메인으로 돌아가기</button>
			</div>
			<br/>
		</div>
	</div>
</div>
