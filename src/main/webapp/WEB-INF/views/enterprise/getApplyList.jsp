<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<script type="text/javascript">
$(function(){
	$("tr").on("click", function(){
		let menu = $(this).data("menu");
		let rsmNo = $(this).data("rsmno");
		let memid = $(this).data("memid");
		let pstgno = $(this).data("pstgno");
		let emplno = $(this).data("emplno");
		var emplClfcNo = $(this).data("emplclfcno");
		
		$.ajax({
			url : "/enterprise/entrantDetail",
			type : "post",
			data : {"memId":memid, "jobPstgNo":pstgno, "rsmNo":rsmNo, "emplClfcNo":emplClfcNo, "emplno":emplno},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log(result);
				$("#entrantDetail").html(result);
			}
		});
		
		$(".modal-header").html("<h5>"+menu+"</h5>")
		$("#entrantDetail").modal("show");
	});
	
});
</script>
<style>
textarea{
	background: transparent;
    border: 1px solid rgb(204, 204, 204);
    box-sizing: border-box;
    padding: 10px 11px;
    border-radius: 0px;
    outline: none;
    font-weight: 400;
    font-size: 12px;
    line-height: 16px;
    color: rgb(51, 51, 51);
    width: 100%;
    height: 100px;
    resize: none;
    position: relative;
    z-index: 1;
}
.blackLine{
	border: 1px solid #808080b3;
}
</style>

<div class="col-md-11 pt-sm-5 container-fluid kanban">
	<div class="card-body mt-6">
	
		<!-- Start Navbar -->
		<ul class="nav nav-pills nav-fill p-1" role="tablist">
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1 toggletab active" data-bs-toggle="tab" href="#empsts0002" role="tab" aria-controls="empsts0002" aria-selected="true">접수</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1 toggletab" data-bs-toggle="tab" href="#empsts0003" role="tab" aria-controls="empsts0003" aria-selected="false">서류합격</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1 toggletab" data-bs-toggle="tab" href="#empsts0004" role="tab" aria-controls="empsts0004" aria-selected="false">최종합격</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1 toggletab" data-bs-toggle="tab" href="#empsts0005" role="tab" aria-controls="empsts0005" aria-selected="false">불합격</a>
			</li>
		</ul>
		<!-- End Navbar -->
		
		<div class="tab-content">
			<!-- 전체 -->
			
			<div class="tab-pane active" id="empsts0002">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 1000px;">
						<div class="row justify-content-center">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원자</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">공고</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원일</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">상태</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">변경일</th>
									</tr>
								</thead>
								<tbody id="apply">
								
									<c:forEach var="list" items="${getApplyList}" >
										<c:if test="${list.EMPL_CLFC_NO eq 'EMPSTS0002'}" >
											<tr id="${list.MEM_ID}" data-menu="접수" data-emplclfcno="EMPSTS0002" data-emplno="${list.EMPL_NO}" data-memid="${list.MEM_ID}" 
												data-rsmno="${list.RSM_NO}" data-pstgno="${list.JOB_PSTG_NO}" >
												<td class="align-middle text-center py-3" style="width: 10%;" style="width: 10%;" >
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0">${list.MEM_NM}</h6>
													</div>
												</td>
												<td class="align-middle text-center">
													<span class="font-weight-bold mb-0">${list.JOB_PSTG_TITLE }</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="badge badge-info badge-lg"><fmt:formatDate value="${list.EMPL_BGNG_DT}" pattern="yyyy/MM/dd" /></span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="text-secondary font-weight-bold">접수</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
												</td>
											</tr>
										</c:if>
									</c:forEach>
								
								</tbody>
							</table>
						</div>
					</section>
				</div>
			</div>
			<!-- 전체 -->

			<!-- 진행중 -->
			<div class="tab-pane" id="empsts0003">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 1000px;">
						<div class="row justify-content-center">
							
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원자</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">공고</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원일</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">상태</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">변경일</th>
									</tr>
								</thead>
								<tbody id="docPass">
								
									<c:forEach var="list" items="${getApplyList }" >
										<c:if test="${list.EMPL_CLFC_NO eq 'EMPSTS0003' }" >
											<tr data-menu="서류합격" data-emplclfcno="EMPSTS0003" data-emplno="${list.EMPL_NO }" data-rsmno="${list.RSM_NO }" data-memid="${list.MEM_ID }" 
												data-pstgno="${list.JOB_PSTG_NO }">
												<td class="align-middle text-center py-3"  style="width: 10%;">
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0">${list.MEM_NM }</h6>
													</div>
												</td>
												<td class="align-middle text-center">
													<span class="font-weight-bold mb-0">${list.JOB_PSTG_TITLE }</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="badge badge-info badge-lg"><fmt:formatDate value="${list.EMPL_BGNG_DT }" pattern="yyyy/MM/dd" /></span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="text-secondary font-weight-bold">서류합격</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="badge badge-success badge-lg"><fmt:formatDate value="${list.EMPL_STS_CHG_DT }" pattern="yyyy/MM/dd" /></span>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								
								</tbody>
							</table>

						</div>
					</section>
				</div>
			</div>
			<!-- 진행중 -->

			<!-- 시작예정 -->
			<div class="tab-pane" id="empsts0004">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 1000px;">
						<div class="row justify-content-center">
						
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원자</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">공고</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">합격일</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">상태</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">정산하기</th>
									</tr>
								</thead>
								<tbody id="pass">
								
									<c:forEach var="list" items="${getApplyList }" >
										<c:if test="${list.EMPL_CLFC_NO eq 'EMPSTS0004' }" >
											<tr data-menu="최종합격" data-emplclfcno="EMPSTS0004" data-emplno="${list.EMPL_NO }" data-rsmno="${list.RSM_NO }" data-memid="${list.MEM_ID }" 
												data-pstgno="${list.JOB_PSTG_NO }">
												<td class="align-middle text-center py-3"  style="width: 10%;">
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0">${list.MEM_NM }</h6>
													</div>
												</td>
												<td class="align-middle text-center">
													<span class="font-weight-bold mb-0">${list.JOB_PSTG_TITLE }</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="badge badge-success badge-lg"><fmt:formatDate value="${list.EMPL_STS_CHG_DT }" pattern="yyyy/MM/dd" /></span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="text-secondary font-weight-bold">최종합격</span>
												</td>
												<td  onclick="event.cancelBubble=true" class="align-middle text-center" style="width: 10%;">
													<div class="d-flex flex-column justify-content-center">
														<span class="text-secondary ">정산중</span>
														<a href="javascript:;" class="text-secondary text-xs" data-toggle="tooltip" data-original-title="Edit user">정산요청</a>
													</div>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								
								</tbody>
							</table>
							
						</div>
					</section>
				</div>
			</div>
			<!-- 시작예정 -->

			<!-- 종료 -->
			<div class="tab-pane" id="empsts0005">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 1000px;">
						<div class="row justify-content-center">
						
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원자</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">공고</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">지원일</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">상태</th>
										<th onclick="event.cancelBubble=true" class="text-center text-secondary font-weight-bolder opacity-7">변경일</th>
									</tr>
								</thead>
								<tbody id="fail">
								
									<c:forEach var="list" items="${getApplyList }">
										<c:if test="${list.EMPL_CLFC_NO eq 'EMPSTS0005' }" >
											<tr data-menu="불합격" data-emplclfcno="EMPSTS0005" data-emplno="${list.EMPL_NO }" data-rsmno="${list.RSM_NO }" data-memid="${list.MEM_ID }" 
												data-pstgno="${list.JOB_PSTG_NO }">
												<td class="align-middle text-center py-3"  style="width: 10%;">
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0">${list.MEM_NM }</h6>
													</div>
												</td>
												<td class="align-middle text-center">
													<span class="font-weight-bold mb-0">${list.JOB_PSTG_TITLE }</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="badge badge-success badge-lg"><fmt:formatDate value="${list.EMPL_BGNG_DT }" pattern="yyyy/MM/dd" /></span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="text-secondary font-weight-bold">불합격</span>
												</td>
												<td class="align-middle text-center" style="width: 10%;">
													<span class="badge badge-success badge-lg"><fmt:formatDate value="${list.EMPL_STS_CHG_DT }" pattern="yyyy/MM/dd" /></span>
												</td>
											</tr>
										</c:if>
									</c:forEach>
								
								</tbody>
							</table>
							
						</div>
					</section>
				</div>
			</div>
			<!-- 종료 -->


		</div>
	</div>
</div>



<!-- Modal -->
<div class="modal fade" id="entrantDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content">
			
		</div>
	</div>
</div>
