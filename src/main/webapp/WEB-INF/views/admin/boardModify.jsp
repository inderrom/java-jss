<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/adminlte3/plugins/summernote/summernote.js"></script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">게시글 수정</h1>
			</div>

		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="card card-default">
			<div class="card-header">
				<h3 class="card-title"></h3>
			</div>
			<div class="card-body">
				<form action="/admin/modifyContent" method="post">
					<input type="hidden" name="boardType" value="${boardType}">
					<input type="hidden" name="boardNo" value="${boardVo.boardNo}">
					<div class="col-sm-12">
						<div class="form-group">
							<div class="row">
								<div class="col-sm-3">
									<label>제목</label>
								</div>
								<div class="col-sm-5">
								</div>
							</div>
							<input type="text" class="form-control" name = "title" value="${boardVo.boardTitle}"/>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="form-group">
								<label>글 내용</label>
								<textarea id="summernote" name="editordata">${boardVo.boardContent}</textarea>
							</div>
						</div>
						<div class="col-sm-2">
								<button type="submit" class="btn btn-block btn-info">글 등록하기</button>
						</div>
					</div>
					<sec:csrfInput/>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(function(){
	$(".deleteBtn").on("click",function(){
		var result = confirm('삭제 하시겠습니까?');
        if(result>0) {
            alert("삭제 되었습니다.");
        } else {

        }
	});

	$('#summernote').summernote({
		height: 600,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정

		callbacks : {
        	onImageUpload : function(files, editor, welEditable) { // 파일 업로드(다중업로드를 위해 반복문 사용)
		        for (var i = files.length - 1; i >= 0; i--) {
		        	uploadSummernoteImageFile(files[i], this);
	         	}
         	}
		}
	});

// 	$("#summernote").summernote('code',  '${boardVo.boardContent}');


	function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			url : "/admin/uploadSummernoteImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				console.log(data.responseCode); //성공여부
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}

});
</script>