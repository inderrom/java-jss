<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<script>
$(function(){
	$("#memJob").on("focus", function(){
		$("#searchMemJob").addClass("show");
	});
	$("#memJob").on("blur", function(){
		$("#searchMemJob").removeClass("show");
	});


	$("#memJob").on("keyup", function(){
		let keyword = $(this).val().toUpperCase();
		if(keyword == ''){
			$("#searchMemJob").empty();
			return false;
		}
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
</script>
<div class="row justify-content-center" style="margin-top:10%;">
	<div class="col-xl-3 col-lg-3 col-md-6">
		<div class="card z-index-0 fadeIn3 fadeInBottom">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div class="bg-gradient-info shadow-primary border-radius-lg py-3 pe-1">
					<h4 class="text-white font-weight-bolder text-center mt-2 mb-0">추가 정보 입력</h4>
					<div class="row mt-4">
					</div>
				</div>
			</div>
			<div class="card-body">
				<form role="form" id="frm" class="text-start" action="/mem/insertInformation" method="post" >
					<div class="input-group input-group-outline my-3" >
						<label class="form-label">연락처</label>
						<input type="text"	class="form-control" id="memTelno" name="memTelno">
					</div>
					<div class="input-group input-group-outline my-3" >
						<label class="form-label">직업</label>
						<input type="text"	class="form-control" id="memJob" name="memJob">
					</div>
					<div class="input-group input-group-outline my-3" >
						<ul id="searchMemJob" class="dropdown-menu"></ul>
					</div>
					<div class="text-center">
						<button type="submit" class="btn bg-gradient-info my-4 mb-2" style="width: 80%;">등록</button>
					</div>
					<input type="hidden" name="memId" value="${memVO.memId}"/>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>