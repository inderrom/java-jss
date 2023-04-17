<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<div class="card card-plain">
	<form role="form" id="frm" action="#" method="post" enctype="multipart/form-data" autocomplete="off">
	
		<div class="card-body pb-2">
			<div class="mb-4">
				<div class="input-group mb-4 input-group-static">
					<label>제목</label>
					<input type="text" id="itnsCmmuTitle" name="itnsCmmuTitle" class="form-control lead" value="" />
				</div>
			</div>
			<div class="input-group mb-4 input-group-static">
				<label>내용</label>
				<textarea id="itnsCmmuContent" name="itnsCmmuContent" class="form-control lead" rows="20"></textarea>
			</div>
			<div class="input-group mb-4 input-group-static">
				<input type="file" id="uploadFile" name="uploadFile" class="form-control">
			</div>
			<div class="row">
				<div class="col-md-12" >
					<button type="button" id="cancle" class="btn btn-secondary" style="float: right;margin-left: 5px;">취소</button>
					<button type="button" id="brdInsert" class="btn btn-success" style="float: right;">등록</button>
				</div>
			</div>
		</div>
		<sec:csrfInput/>
	</form>
</div>


<script type="text/javascript">
$(function(){
	$("#cancle").on("click", function(){
		console.log("itnsNo : " + itnsNo);
		
		$.ajax({
			url : "/myPremium/boardList",
			type : "post",
			data : {"itnsNo":itnsNo},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log(result);
				$("#note").html(result);
			}
		});
	});
	
	$("#brdInsert").on("click", function(){
		let formData = new FormData($('#frm')[0]);
		
		formData.append("itnsNo", "${itnsNo}" );
		formData.append("memId", "${memVO.memId}" );
		formData.append("itnsCmmuTitle", $("#itnsCmmuTitle").val() );
		formData.append("itnsCmmuContent", $("#itnsCmmuContent").val() );
		formData.append("uploadFile", $("#uploadFile").val()) ;

		console.log("formData : ", formData);
		
		$.ajax({
			url : "/myPremium/boardInsert",
			type : "post",
            processData: false,
            contentType: false,
			data : formData,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log(result);
				$("#note").html(result);
			}
		});
	});
});
</script>