<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(function(){
	//이미지 미리보기 시작-------------------
	$("#input_imgs").on("change",handleImgFileSelect);
	//e: change이벤트
	function handleImgFileSelect(e){
		//파일객체에 파일들
		let files = e.target.files;
		//이미지 배열
		let fileArr = Array.prototype.slice.call(files);
		//fileArr에서 하나 꺼내면 f(파일객체 1개)
		fileArr.forEach(function(f){
			//이미지만 가능
			if(!f.type.match("image.*")){
				Swal.fire("이미지 확장자만 가능합니다.");
				return;
			}
			//이미지를 읽을 객체
			let reader = new FileReader();
			//reader.readAsDataURL(f);의 이벤트
			reader.onload = function(e){
				let img_html = "<img src=\"" + e.target.result + "\" style='width:30%' />";
				
				$(".imgs_wrap").append(img_html);
			}
			
			//이미지를 읽자
			reader.readAsDataURL(f);
		});//end forEach
	}
	//이미지 미리보기 끝-------------------
	
	$("#brdInsert").on("click", function(){
		let titleVal = $("#boardTitle").val();
		let contVal = $("#boardContent").val();
		$(".dataOk").text("");
		
		if(titleVal == null || titleVal == ""){
			$("#titleOk").text("게시글 제목을 입력해주세요.");
			$("#titleOk").css("color","red");
			$("#boardTitle").focus();
			return;
		}
		
		if(contVal == null || contVal == ""){
			$("#contOk").text("게시글 내용을 입력해주세요.");
			$("#contOk").css("color","red");
			$("#boardContent").focus();
			return;
		}
		
		$("#frm").submit();
	});
});
</script>
<sec:authentication property="principal.memVO" var="memVO"/>
<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container blur border-radius-lg p-5" style="min-height: 1000px;justify-content: center;background-color: rgb(255 244 244 / 60%) !important;">
			<div class="row">
				<div class="col-lg-12 mx-auto d-flex justify-content-center flex-column">
					<div class="card d-flex justify-content-center p-4 shadow-lg">
						<div class="text-center">
							<h3>등록</h3>
						</div>
						<div class="card card-plain">
							<form role="form" id="frm" action="/board/boardInsert" method="post" enctype="multipart/form-data" autocomplete="off">
								<input type="hidden" id="memId" name="memId" value="${memVO.memId}" />
								<input type="hidden" id="boardClfcNo" name="boardClfcNo" value="BRDCL0003" />
							
								<div class="card-body pb-2">
									<div class="mb-4">
										<div class="input-group mb-4 input-group-static">
											<input type="text" id="boardTitle" name="boardTitle" class="form-control" value="" />
											<div id="titleOk" class="dataOk"></div>
										</div>
									</div>
									<div class="input-group mb-4 input-group-static">
										<label>내용</label><br/>
										<div id="contOk" class="dataOk"></div>
										<textarea id="boardContent" name="boardContent" class="form-control" rows="30"></textarea>
									</div>
									<div class="input-group mb-4 input-group-static">
										<input type="file" id="uploadFile" name="uploadFile" class="form-control">
									</div>
									<div class="row">
										<div class="col-md-12" >
											<button type="button" id="cancle" onclick="javascript:history.back()" class="btn btn-secondary" style="float: right;margin-left: 5px;">취소</button>
											<button type="button" id="brdInsert" class="btn btn-success" style="float: right;">등록</button>
										</div>
									</div>
								</div>
								<sec:csrfInput/>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</main>