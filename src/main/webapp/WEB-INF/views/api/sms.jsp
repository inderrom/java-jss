<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<script>
$(function(){
	$("#btn").on("click", function(){
		let sender = $("#sender").val();
		let data = {"sender": sender};
		$.ajax({
			url: "/api/sms",
			data: data,
// 			contentType: "application/json; charset=utf-8",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			type: "post",
			success: function(certificationNumber){
				console.log(certificationNumber);
			},
			error: function(xhr){
				console.log("error : " + xhr.status);
			}
		});
		$(this).attr("disabled", true);
	});
});
</script>

<h3>Naver SMS API</h3>
<input type="text" id="sender" name="sender" placeholder="수신번호 입력(숫자만)"/><br/>
<button type="button" id="btn">메세지 보내기</button>