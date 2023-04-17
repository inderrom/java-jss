<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
$(function(){
	var boardBtns = document.querySelectorAll('.boardBtn');
	var boardNo = "";

	boardBtns.forEach(
		function(boardBtn) {
			boardBtn.addEventListener('click', function(event) {
			boardNo = event.target.id.replace('board-', '');
			window.boardNo = boardNo;
			console.log(boardNo);
			location.href = "/admin/boardDetail?boardNo="+boardNo;
		});
	});

	//신고하기 실행
	$("#btnSubmit").on("click",function(){
		$("#frm").attr('action', '/admin/bReportPrcs');
		let counter = 0;
		let pCounter = 0;
		$(".prcs").each(function(index){
			if($(this).is(":checked")==true){
				counter = counter + 1;
			}
			if( ($(this).is(":checked")==true) && ($(this).data("prcsed") == "Y") ){
				pCounter = pCounter + 1;
			}
		});

		console.log("counter : " + counter);
		console.log("pCounter : " + pCounter);
		if(counter>0){
			if(pCounter <= 0) {
				$("#frm").submit();
			} else {
				alert("처리 안된 것만 고르세요.");
			}
		}else{
			alert("신고 대상을 체크해주세요");
		}
	});

	$("#btnSubmit2").on("click",function(){
		$("#frm").attr('action', '/admin/bReportNonPrcs');
		let counter = 0;
		let pCounter = 0;
		$(".prcs").each(function(index){
			if($(this).is(":checked")==true){
				counter = counter + 1;
			}
			if( ($(this).is(":checked")==true) && ($(this).data("prcsed") == "N") ){
				pCounter = pCounter + 1;
			}
		});
		console.log("counter : " + counter);
		console.log("pCounter : " + pCounter);
		if(counter>0){
			if(pCounter <= 0){
				$("#frm").submit();
			} else {
				alert("처리 된 것만 고르세요.");
			}

		}else{
			alert("신고 대상을 체크해주세요");
		}
	});



});
</script>
<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">게시판 관리</h1>
			</div>

		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<div class="card-12">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">신고 게시글 목록</h3>
					</div>
					<div class="card-body">
						<div class="card-body">
							<form>
								<div class="row">
									<div class="col-md-2">
										<select class="form-control" id="sel1" name = "searchType">
											<option value="content" <c:if test="content"><c:out value="selected"/></c:if>>신고사유</option>
											<option value="title" <c:if test="title"><c:out value="selected"/></c:if>>제목</option>
										</select>
									</div>
									<div class="col-md-7">
										<input type="text" placeholder="검색어를 입력해주세요" class=" form-control form-control-md"
											   name = "keyword" value=""/>
									</div>
									<div class="col-md-2">
										<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
									</div>
									<div class="col-md-1">
									<button type="button" id="btnSubmit" class="btn btn-block btn-outline-info">완료</button>
								</div>

								</div>
							</form>
<!-- 							<div class="row" style="padding-top: 30px;"> -->


<!-- 								<div class="col-1"> -->
<!-- 									<button type="button" id="btnSubmit2" class="btn btn-block btn-outline-danger">되돌리기</button> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</div>
						<form id="frm" action="/admin/bReportPrcs" method="post">
							<div class="row">
									<table class="table table-head-fixed text-nowrap">
										<thead>
											<tr style="text-align: center;">
												<th style="width: 100px">번호</th>
												<th style="width: 50px"></th>
												<th style="width: 200px">신고자</th>
												<th>게시글 제목</th>
												<th>신고사유</th>
												<th style="width: 100px">신고일자</th>
												<th>처리 여부</th>
											</tr>
										</thead>

										<tbody>
											<c:forEach var="reportVo" items="${data.content}" varStatus="stat">
												<tr style="text-align: center;">
													<td>${reportVo.rnum}</td>
													<td><input type="checkbox" class="prcs" name="prcs" value="${reportVo.rptNo}" data-prcsed="${reportVo.rptPrcsYn}"></td>
													<td>${reportVo.memId}</td>
													<td>
														<c:if test="${not empty reportVo.boardVo.boardTitle}">
															<a type="button" class="boardBtn" id="board-${reportVo.boardVo.boardNo}">
																${reportVo.boardVo.boardTitle}
															</a>
														</c:if>

														<c:if test="${empty reportVo.boardVo.boardTitle}">
															이미 삭제된 게시물입니다.
														</c:if>
													</td>
													<td>${reportVo.rptRsn}</td>
													<td>${reportVo.rptRegDt}</td>
													<c:if test="${reportVo.rptPrcsYn == 'N'}">
														<td>접수 중</td>
													</c:if>
													<c:if test="${reportVo.rptPrcsYn == 'Y'}">
														<td>접수 완료</td>
													</c:if>
												</tr>
											</c:forEach>
											<c:if test="${data.total == 0}">
												<td colspan="7" style="text-align: center;">신고된 게시글이 없습니다.</td>
											</c:if>
										</tbody>
									</table>
									<security:csrfInput />
							</div>
						</form>
					</div>
					<div class="card-footer clearfix">
						<c:if test='${data.total != 0 }'>
							<ul class="pagination justify-content-center">
							 	<li class="paginate_button page-item previous
								<c:if test='${data.startPage lt 11 }'>disabled</c:if>"
									id="dataTable_previous">
									<a href="/admin/reportBoard?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
								       aria-controls="dataTable" data-dt-idx="0" tabindex="0"
								        class="page-link">Previous</a>
								</li>
								<c:set var="currentPage" value="${not empty param.currentPage ? param.currentPage : 1}" />
								<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
									<li class="paginate_button page-item <c:if test='${currentPage eq pNo}'> active</c:if>">
										<a href="/admin/reportBoard?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
										   aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link"> ${pNo} </a>
									</li>
								</c:forEach>
								<li class="paginate_button page-item next
								<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>" id="dataTable_next">
									<a href="/admin/reportBoard?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
									   aria-controls="dataTable" data-dt-idx="7"
									   tabindex="0" class="page-link"> Next </a>
								</li>
							</ul>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>