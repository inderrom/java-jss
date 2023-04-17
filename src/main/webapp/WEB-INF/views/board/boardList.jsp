<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<sec:authorize access="isAuthenticated()"> 
	<sec:authentication property="principal.memVO" var="memVO"/>
</sec:authorize>

<link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script type="text/javascript">
$(function() {
	let jsmemId = "${memVO.memId}";
	
	$.ajax({
		url : "/mem/memSearch",
		data : {
			"memId" : jsmemId
		},
		type : "post",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			console.log(result);
			if(result.attNm != null && result.attNm != ""){
			   $("#myprofile").attr("src", "/resources/images"+result.attNm);
		   }
		}
	});

	$(".brdDetail").on("click", function() {	
		let txt = $(this).find("input").eq(0).attr("value");
		console.log(txt);
		
		location.href = "/board/boardDetail?boardNo=" + txt;
	});

	$("#brdInsert").on("click", function() {
		if(jsmemId == null || jsmemId == ""){
			location.href = "/login";
			return;
		}
		
		location.href = "/board/boardInsert";
	});

// 	$("#myBoardList").on("click", function() {
// 		if(jsmemId == null || jsmemId == ""){
// 			console.log("로그인하세요.")
// 			return;
// 		}
// 		location.href = "/mem/myBoardList?memId=${memVO.memId}";
// 	});
});

function selChange() {
	let show = document.getElementById('show').value;
	location.href = "/board/boardList?boardClfcNo=BRDCL0003&currentPage=1&keyword=${param.keyword}&show=" + show;
}
</script>
<style>
.filefile{
	position: absolute;
    top: 29px;
    right: 30px;
    width: 192px;
    height: 151px;
    border-radius: 5px;
    -o-object-fit: cover;
    object-fit: cover;
}
</style>

<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container blur border-radius-lg p-4" style="min-height: 1500px;background-color: rgb(255 244 244 / 60%) !important;">
			<div class="row">
				<!-- 게시판 리스트 시작 -->
				<div class="col-lg-12">
					<div class="card-body">
						<div class="row bg-white shadow-lg border-radius-lg" style="margin:0rem 0.1rem 2rem 0.1rem;">
							<div class="col-3 shadow-lg pt-4x m-3">
								<div class="col mt-lg-4" id="myBoardList" onclick="getBoardList()">
									<a href="#">
										<div class="nav flex-column p-4 text-center">
											<h5>내 커뮤니티<i class="material-icons text-dark opacity-5 pe-2">navigate_next</i></h5>
											<br />
											<br />
											<div class="author align-items-center" style="justify-content: center;">
												<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar-xl shadow border-radius-lg">
				
												<c:choose>	
													<c:when test="${memVO eq null}">
														<div class="name ps-3">
															<span >로그인 해주세요.</span>
														</div>
													</c:when>
													<c:otherwise>
														<div class="name ps-3">
															<h4>${memVO.memNm}</h4>
															<div class="stats">
																<c:choose>
																	<c:when test="${crrYear eq '0' || crrYear eq null}">
																		<h5>신입</h5>
																	</c:when>
																	<c:otherwise>
																		<h5>${crrYear}년차</h5>
																	</c:otherwise>
																</c:choose>
															</div>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</a>
								</div>
							</div>
							<div class="col shadow-lg" style="margin: 1rem 1rem 1rem 0;background-image: url('/resources/images/pattern.png');">
								<div class="row">
									<div class="d-flex">
										<div id="brdInsert" class="input-group input-group-outline my-3" style="border: 1px solid #808080b3;">
											<a href="#" style="width: 100%;text-align: center;"> 
												<h5 class="text-dark" style="padding: 2%;margin: auto;"><span class="text-dark" id="brdTyped"></span> 자유롭게 소통해보세요.</h5>
												<div id="brdTyped-strings">
													<h5>커리어고민</h5>
													<h5>취업/이직</h5>
													<h5>회사생활</h5>
													<h5>인간관계</h5>
												</div>
											</a>
										</div>
										<div>
											<img src="/resources/images/comment.png" style="width: 45px; margin-left: 10px; margin-top: 30%;" />
										</div>
									</div>
								</div>
							</div>
							<hr/>
						</div>
					</div>
					<!-- 게시판 리스트 끝 -->
					
							<section>
								<div class="container bg-white border-radius-lg">
									<hr />
									<a href="#">
										<c:choose>
											<c:when test="${list.content eq null || fn:length(list.content) eq 0}">
												<p class="text-center my-md-10">작성된 글이 없습니다.</p>
											</c:when>
											<c:otherwise>
												<c:forEach var="boardVO" items="${list.content}" varStatus="stat">
													<div class="card-body shadow-lg row brdDetail p-lg-4" style="min-height: 100px;">
														<input type="hidden" class="boardNo" name="boardNo" value="${boardVO.boardNo}" />
														<div class="col-lg-12 ms-auto me-auto">
															<div class="author align-items-center">
																<c:choose>
																	<c:when test="${boardVO.brdAttNm eq null}">
																		<img src="/resources/images/icon/hand-print.png" alt="..." class="avatar-lg shadow border-radius-sm"
																			style="height: 30px; width: 30px;" />
																	</c:when>
																	<c:otherwise>
																		<img src="/resources/images${boardVO.brdAttNm }" alt="d" class="avatar-lg shadow border-radius-sm"
																			style="height: 30px; width: 30px;" />
																	</c:otherwise>
																</c:choose>
																<div class="name ps-3 pe-3">
																	<h5>${boardVO.memNm}</h5>
																</div>
																<div class="col-md-6 my-auto">
																	<div>
																		<span class="badge badge-lg badge-primary">${boardVO.memJobNm}</span>
																		<c:choose>
																			<c:when
																				test="${boardVO.crrYear eq '0' || boardVO.crrYear eq null}">
																				<span class="badge badge-lg badge-success">신입</span>
																			</c:when>
																			<c:otherwise>
																				<span class="badge badge-lg badge-success">${boardVO.crrYear}년차</span>
																			</c:otherwise>
																		</c:choose>
																		<span class="badge badge-lg badge-secondary"> <c:set
																				var="brdTime" value="${boardVO.brdTime}" /> <c:choose>
																				<c:when test="${fn:length(brdTime) >= 3}">${brdTime}</c:when>
																				<c:otherwise>${brdTime}시간 전</c:otherwise>
																			</c:choose>
																		</span>
																	</div>
																</div>
															</div>
			
															<hr />
			
															<div class="row">
																<div class="col-lg-9">
																	<h4 class="my-sm-3">${boardVO.boardTitle}</h4>
																	<c:set var="boardContent" value="${boardVO.boardContent}" />
																	<p class="mb-0 font-weight-normal" style="color: gray;">
																		<c:choose>
																			<c:when test="${fn:length(boardContent) >= 150}">
																				${fn:substring(fn:replace(fn:replace(fn:escapeXml(boardContent), CRLF, '<br/>'), LF, '<br/>'), 0, 150)} &nbsp; 
																				<strong style="color: black;font-size: 80%;">...더보기</strong>
																			</c:when>
																			<c:otherwise>
																				${fn:replace(fn:replace(fn:escapeXml(boardContent), CRLF, '<br/>'), LF, '<br/>')}
																			</c:otherwise>
																		</c:choose>
																	</p>
																	<br />
																	<p>
																		<img alt=".." src="/resources/images/comment.png" style="width: 20px; margin-right: 5px;" />
																		${boardVO.boardCmntVOList[0].cmntCnt}
																	</p>
																</div>
			
																<c:if test="${boardVO.boardAttVOList[0] != null || fn:length(boardVO.boardAttVOList[0]) > 0}">
																	<div class="col-lg-3">
																		<div class="position-relative">
																			<div class="blur-shadow-avatar">
																				<c:choose>
																					<c:when test="${boardVO.boardAttVOList[0].attClfcNo eq 'ATTCL0007'}">
																						<img class="border-radius-xl filefile" src="/resources/images${boardVO.boardAttVOList[0].attNm}" />
																					</c:when>
																					<c:otherwise>
																						<img class="avatar border-radius-xl" src="/resources/images/attach_file.png" style="width: 30px; height: 30px;" />
																					</c:otherwise>
																				</c:choose>
																			</div>
																		</div>
																	</div>
																</c:if>
			
															</div>
														</div>
													</div>
													<hr class="dark horizontal" />
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</a>
		
									<div class="row">
										<div class="col-sm-12 col-md-7">
											<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate" style="width: 40%;float: right;">
												<ul class="pagination">
													<li class="paginate_button page-item previous <c:if test='${list.startPage lt size}'>disabled</c:if>" id="dataTable_previous">
														<a href="/board/boardList?boardClfcNo=BRDCL0003&currentPage=${list.startPage-size}&keyword=${param.keyword}&show=${param.show}"
														aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link"><i class="material-icons">chevron_left</i></a>
													</li>
													<c:forEach var="pNo" begin="${list.startPage}" end="${list.endPage}">
														<li class="paginate_button page-item <c:if test='${param.currentPage==pNo}'>active</c:if>">
															<a href="/board/boardList?boardClfcNo=BRDCL0003&currentPage=${pNo}&keyword=${param.keyword}&show=${param.show}"
															aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a>
														</li>
													</c:forEach>
													<li class="paginate_button page-item next <c:if test='${list.startPage+size ge list.totalPages}'>disabled</c:if>" id="dataTable_next">
														<a href="/board/boardList?boardClfcNo=BRDCL0003&currentPage=${list.startPage+size}&keyword=${param.keyword}&show=${param.show}"
														aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link"><i class="material-icons">chevron_right</i></a>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</section>
	
				</div>
			</div>
		</div>
	</section>
</main>


<!--  Plugin for the typed animation -->
<script src="/resources/materialKet2/js/plugins/typedjs.js" type="text/javascript"></script>
<script type="text/javascript">
if (document.getElementById('brdTyped')) {
	var typed = new Typed("#brdTyped", {
		stringsElement: '#brdTyped-strings',
		typeSpeed: 90,
		backSpeed: 90,
		backDelay: 200,
		startDelay: 500,
		loop: true
	});
}
</script>
<script>
function getBoardList(){
	if(jsmemId == null || jsmemId == ""){
		console.log("로그인하세요.")
		return;
	}
	
	var form = document.createElement("form");
	form.setAttribute("id", "frm");
	form.setAttribute("method", "post");
	form.setAttribute("url", "/mem/myBoardList");
	
	var hiddenField = document.createElement("input");
	hiddenField.setAttribute("type", "hidden");
	hiddenField.setAttribute("name", "memId");
	hiddenField.setAttribute("value", ${memVO.memId});
	
	form.appendChild(hiddenField);
	
	document.body.appendChild(form);
	form.submit;
	document.getElementById("form").remove();
}
</script>