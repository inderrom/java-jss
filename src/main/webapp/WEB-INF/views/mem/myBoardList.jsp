<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO"/>
<style>
.badge{
    font-size: 0.3em;
}
</style>
<script type="text/javascript">
$(function(){
	let jsmemId = "${myBoardList[0].memId}";
	
	$.ajax({
		url:"/mem/memSearch",
		data: {"memId": jsmemId},
		type:"post",
		beforeSend : function(xhr) {
		       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
		   console.log(result.attNm);
		   if(result.attNm != null && result.attNm != ""){
			   $("#myprofile").attr("src", "/resources/images"+result.attNm);
		   }
		   if(result.crrYear == "0" || result.crrYear == null){
			   $("#crrYear").text("신입");
		   }else{
			   $("#crrYear").text(result.crrYear+"년차");
		   }
		}
	});
	
	$(".brdDetail").on("click",function(){
		let txt = $(this).find("input").eq(0).attr("value");
		location.href="/board/boardDetail?boardNo="+txt;
	});
	
	$("#myBrdList").on("click",function(){
		$("#myCmnt").hide();
		$("#myboard").show();
	});
	
	$("#myCmntList").on("click",function(){
		$("#myboard").hide();
		$("#myCmnt").show();
	});
});
</script>

<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container min-height-300">
			<div class="row">
				<div class="col-lg-12">
					<div class="card blur shadow-lg mb-5 p-5" style="background-color: rgb(255 244 244 / 60%) !important;">
						<div class="card-body bg-white border-radius-lg">
						
							<div class="author align-items-center">
								<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar avatar-xxl shadow border-radius-lg">
								
								<div class="name ps-3">
									<span style="font-size: large;">${myBoardList[0].memNm}</span>
									<div class="stats">
										<span class="badge badge-lg badge-secondary" id="crrYear"></span>
									</div>
								</div>
							</div>
							
							<hr/>
							
							<section>
								<!-- Navbar Light -->
								<nav class="navbar navbar-expand-lg navbar-light bg-white z-index-3 py-3">
									<div class="container">
										<a href="https://www.creative-tim.com/product/material-design-system-pro#pricingCard" class="btn btn-sm  bg-gradient-primary  btn-round mb-0 ms-auto d-lg-none d-block">Buy Now</a>
										<button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
											<span class="navbar-toggler-icon mt-2">
												<span class="navbar-toggler-bar bar1"></span>
												<span class="navbar-toggler-bar bar2"></span>
												<span class="navbar-toggler-bar bar3"></span>
											</span>
										</button>
										<div class="collapse navbar-collapse w-100 pt-3 pb-2 py-lg-0" id="navigation">
											<ul class="navbar-nav navbar-nav-hover mx-auto">
												<li class="nav-item mx-5">
													<a id="myBrdList" class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" role="button">
														<strong>작성글</strong>
													</a>
												</li>
												<li class="nav-item mx-5">
													<a id="myCmntList" class="nav-link ps-2 d-flex justify-content-between cursor-pointer align-items-center" role="button">
														<strong>작성댓글</strong>
													</a>
												</li>
											</ul>
										</div>
									</div>
								</nav>
								<!-- End Navbar -->

								<div class="container mt-5" id="myboard">
								<c:choose>
									<c:when test="${myBoardList eq null || fn:length(myBoardList) eq 0}">
										<p class="text-center my-md-10">작성하신 글이 없습니다.</p>
									</c:when>
									<c:otherwise>
										<c:forEach var="boardVO" items="${myBoardList}" varStatus="stat">
											<div class="row brdDetail" style="min-height: 100px;">
												<input type="hidden" class="boardNo" name="boardNo" value="${boardVO.boardNo}" />
												<div class="col-lg-12 ms-auto me-auto">
												
													<hr style="color: white;"/>
													
													<div class="author align-items-center pb-3">
														<c:choose>
															<c:when test="${boardVO.brdAttNm eq null}">
																<img src="/resources/images/icon/hand-print.png" alt="..." class="avatar shadow border-radius-sm" style="height: 20px; width: 20px;" />
															</c:when>
															<c:otherwise>
																<img src="/resources/images${boardVO.brdAttNm }" alt="d" class="avatar shadow border-radius-sm" style="height: 20px; width: 20px;" />
															</c:otherwise>
														</c:choose>
														<div class="name ps-3 pe-3">
															<span style="font-size: smaller;">${boardVO.memNm}</span>
														</div>
														<div class="col-md-6 my-auto">
															<div>
																<span class="badge badge-sm badge-secondary">
																	<c:set var="brdTime" value="${boardVO.brdTime}"/>
																	<c:choose>
																		<c:when test="${fn:length(brdTime) >= 3}">${brdTime}</c:when>
																		<c:otherwise>${brdTime}시간 전</c:otherwise>
																	</c:choose>
																</span>
															</div>
														</div>
													</div>
													
													
													<div class="d-flex">
														<div style="width: 80%;">
															<h2 style="font-size: revert;">${boardVO.boardTitle}</h2>
															<br/>
															<c:set var="boardContent" value="${boardVO.boardContent}"/>
															<p class="mb-0">
																<c:choose>
																	<c:when test="${fn:length(boardContent) >= 150}">${fn:substring(boardContent, 0, 150)}...</c:when>
																	<c:otherwise>${boardContent}</c:otherwise>
																</c:choose>
															</p>
															<br/>
															<p><img alt=".." src="/resources/images/comment.png" style="width: 20px;margin-right: 5px;" />${boardVO.cmntCnt}</p>
														</div>
													</div>
												</div>
											</div>
											<hr class="dark horizontal" />
										</c:forEach>
									</c:otherwise>
								</c:choose>
									
								</div>

								<div class="container mt-5" id="myCmnt" style="display: none;">
									<c:choose>
										<c:when test="${myCmntList eq null || fn:length(myCmntList) eq 0}">
											<p class="text-center my-md-10">작성하신 댓글이 없습니다.</p>
										</c:when>
										<c:otherwise>
											<c:forEach var="cmntVO" items="${myCmntList}" varStatus="stat">
												<div class="row" style="min-height: 100px;">
													<div class="col-lg-12 ms-auto me-auto">
													
														<hr style="color: white;"/>
														
														<div class="author align-items-center pb-3">
															<c:choose>
																<c:when test="${cmntVO.attNm eq null}">
																	<img src="/resources/images/icon/hand-print.png" alt="..." class="avatar shadow border-radius-sm" style="height: 20px; width: 20px;" />
																</c:when>
																<c:otherwise>
																	<img src="/resources/images${cmntVO.attNm }" alt="d" class="avatar shadow border-radius-sm" style="height: 20px; width: 20px;" />
																</c:otherwise>
															</c:choose>
															<div class="name ps-3 pe-3">
																<span style="font-size: smaller;">${cmntVO.memNm}</span>
															</div>
														</div>
														<div class="d-flex">
															<div style="width: 80%;">
																<p class="mb-0">${cmntVO.cmntContent}</p>
															</div>
														</div>
													</div>
												</div>
												<hr class="dark horizontal" />
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
								
							</section>
						</div>
					</div>
				</div>
				<!-- 게시판 리스트 끝 -->
		
			</div>
		</div>
	</section>
	
</main>