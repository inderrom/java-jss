<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container blur border-radius-lg p-4" style="min-height: 1500px;background-color: rgb(255 244 244 / 60%) !important;"> 
			<div class="container bg-white border-radius-lg">
				<div class="row align-items-center">
					<div class="col text-start my-md-4">
						<h2>이력서</h2>
					</div>
					<div class="col-2 text-end">
						<a id="resumeInsert"  class="badge badge-pill badge-lg bg-gradient-info prmmMyPage" href="#">
							<strong style="font-size: large;">새 이력서</strong>
						</a>
					</div>
					<div class="col-2">
						<a class="badge badge-pill badge-lg bg-gradient-success prmmMyPage" href="#">
							<strong style="font-size: large;">파일 업로드</strong>
						</a>
					</div>
				</div>
			</div>
			
			<hr/>
			
			<div class="container bg-white border-radius-lg" style="min-height: 1500px;">
				<!-- 한줄에 3개씩, 이력서가 3개 넘어가면 해당 div 반복문으로 생성하기 -->
				<div class="row">
					<c:forEach var="resumeVO" items="${myResumeVOList}">
						<div class="card col-3 m-lg-5" id="divResume" style="border: 1px solid #00000033;">
							<div class="card-body min-height-200 resumeDetail">
								<a href="#">
									<input type="hidden" id="rsmNo" value="${resumeVO.rsmNo}"/>
									<input type="hidden" id="rsmRprs" value="${resumeVO.rsmRprs}"/>
									<h4>${resumeVO.rsmTitle}</h4>
									<h6 class="mb-0"><fmt:formatDate value="${resumeVO.rsmRegDt}" pattern="yyyy.MM.dd"/></h6>
								</a>
							</div>

							<div class="card-footer p-lg-0 text-end" style="border-top: 1px solid #00000033;">
								<div class="row align-items-sm-center ps-lg-3">
									<div class="col text-start" id="divRprs">
										<c:if test="${resumeVO.rsmRprs eq 'Y'}"><i class='material-icons'>star</i></c:if>
									</div>
									<div class="col text-end">
										<button type="button" class="btn bg-gradient-white w-auto me-2 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">...</button>
										<ul class="dropdown-menu px-2 py-3" aria-labelledby="dropdownMenuButton">
										    <li><button type="button" class="dropdown-item btn bg-gradient-white w-auto me-2 btnSetRprsRsm">대표이력서 설정</button></li>
										    <li><button type="button" class="dropdown-item btn bg-gradient-white w-auto me-2 resDelete">삭제</button></li>
										  </ul>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 한줄에 3개씩, 이력서가 3개 넘어가면 해당 div 반복문으로 생성하기 -->


			</div>
		</div>
	</section>
</main>


<script type="text/javascript">
$(function(){
	$("#resumeInsert").on("click", function(){
		console.log("resumeInsert 을 누르셨습니다.");
// 		location.href="/mem/resumeInsert";
		$.ajax({
			url: "/mem/resumeInsert",
			type: "get",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(rsmNo){
				location.href="/mem/resumeDetail?rsmNo="+rsmNo;
			}
		});
	});

	$(".resumeDetail").on("click", function(){
		console.log("resumeDetail 을 누르셨습니다.");
		let txt = $(this).find("input").eq(0).attr("value");
		console.log(txt);
		location.href="/mem/resumeDetail?rsmNo="+txt;
	});

	$(".resDelete").on("click", function(){
		let divResume = $(this).parents("#divResume");
		let rsmNo = divResume.find("input").val();
		console.log(divResume.find("#rsmRprs").val());
		if(divResume.find("#rsmRprs").val() == 'Y'){
			Swal.fire("대표이력서는 삭제할수 없습니다.");
			return;
		}
		Swal.fire({
			title: '삭제하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '삭제',
			cancelButtonText: '취소'
		}).then((result) => {
			if (result.isConfirmed) {
				$.ajax({
					url: "/mem/deleteResume",
					data: {"rsmNo": rsmNo},
					type: "post",
					beforeSend : function(xhr) {
			            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result){
						if(result > 0){
							Swal.fire('삭제되었습니다.');
							divResume.remove();
						}
					}
				});
		  	}
		});
	});

	$(".btnSetRprsRsm").on("click", function(){
		let divRprs = document.querySelectorAll("#divRprs");
		$.each(divRprs, function(i, v){
			$(v).empty();
		});
		let divResume = $(this).parents("#divResume");
		let rsmNo = divResume.find("#rsmNo").val();
		console.log(rsmNo);

		$.ajax({
			url: "/mem/setRprsRsm",
			data: {"rsmNo": rsmNo},
			type: "post",
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log(result);
				if(result > 0){
					divResume.find("#divRprs").append("<i class='material-icons'>star</i>");
				}
			}
		});
	});

	$("#resumeFile").on("change", function(){
		console.log(this);
		console.log($(this).val());
		let resumeFileForm = document.createElement("form");
		resumeFileForm.append(this);

		let resumeFileFormData = new FormData(resumeFileForm);
		console.log(resumeFileFormData);
		console.log("data", resumeFileFormData.get("resumeFile"));

		$.ajax({
			url : "/mem/insertResumeFile",
			type : "post",
			processData : false,
			contentType : false,
			data : resumeFileFormData,
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(result) {
				console.log(result); // 추가한 파일 화면에 추가해줘야함
			}
		});
	});
});
</script>