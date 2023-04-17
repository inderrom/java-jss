<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
$(function(){
	$("#btnSend").on("click", function(){
		let recipient = $("#recipient").val();
		let mailTitle = $("#mailTitle").val();
		let mailContent = $("#mailContent").val();
		let data = {
			"recipient": recipient,
			"mailTitle": mailTitle,
			"mailContent": mailContent,
		};
		$.ajax({
			url: "/api/sendEmail",
			data: JSON.stringify(data),
			type: "post",
			contentType: "application/json; charset=utf-8",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			error: function(xhr){
				console.log(xhr.status);
			}
		});
	});
});
</script>

<h3>email</h3>

<input type="text" id="recipient" placeholder="받는 사람 이메일" value="zcz0011@naver.com"/><br/>
<input type="text" id="mailTitle" placeholder="메일 제목"/><br/>
<textarea id="mailContent" style="width: 300px; height: 500px;" placeholder="메일 내용"></textarea><br/>
<button type="button" id="btnSend">메일 보내기</button>


