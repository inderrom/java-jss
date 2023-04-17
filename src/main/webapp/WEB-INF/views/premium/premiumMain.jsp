<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- 스크롤페이징 -->
<script src="/resources/js/infiniteScroll.min.js"></script>
<!-- sweetalert -->
<script src="/resources/js/sweetalert2.min.js"></script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memVO" var="memVO"/>
</sec:authorize>

<style type="text/css">
</style>

<script type="text/javascript">
$(function(){

	//상단 분류(전체/강의/특강/인턴십) 클릭시 동작
	$(".prmmClfc").on("click", function(){
	console.log( $(this).data("clfc") );
	let data = {"prmmClfc" : $(this).data("clfc")}

		$.ajax({
			url:"/premium/mainCate",
	 		data:data,
	 		type:'get',
	 		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); },
			success:function(result){
	 			console.log("result : "  , result, result[0]) ;
	 			let code="";
	 			console.log("출력한다~~")
	 			if(result.length==0){
	 				code+='<div class="card blur mb-4 shadow-sm" style="height:410px; text-align:center; vertical-align:middle; line-height:350px;">';
	 				code+="<b>목록이 없습니다.<b>";
	 				code+='</div>'
	 			} else {
						console.log("i의 길이 : ", result.length);
		 			for(var i = 0; i<result.length; i++){
						code += '<div list class="col-md-3">';
						code += '<a class="goPage" href="/premium/premiumDetail?prmmNo='+ result[i].prmmNo+'">';
						code += '	<div class="card mb-4 shadow-sm" style="height:410px;">';
						code += '<div class="p-1" style="height:225px;">';
						code += '<img class="bd-placeholder-img card-img-top" width="100%"';
 		 				code += '	height="200" xmlns="http://www.w3.org/2000/svg" role="img"';
 		 				code += '	aria-label="Placeholder: Thumbnail"';
 		 				code += '	preserveAspectRatio="xMidYMid slice" focusable="false"';
						if(result[i].prmmClfc == 'PRE0003') {
							if(result[i].internshipList[0].attNm == null || result[i].internshipList[0].attNm == '' ){
								code += '	src="/resources/images/기본인턴십.jpg" alt="인턴십 이미지"';
							} else {
								code += '	src="D:/JOBJOB/images' + result[i].internshipList[0].attNm +'" alt="인턴십 이미지"';
							}
						}
						if(result[i].prmmClfc == 'PRE0001') {
							if(result[i].attachList.length == 0){
		 		 				code += '   src="/resources/images/기본강의.jpg" alt="기본 강의 이미지"';
							} else {
								for(var j = 0; j <result[i].attachList.length; j++){
									if(result[i].attachList[j].attClfcNo == 'ATTCL0009'){
				 		 				code += '	src="D:/JOBJOB/images' + result[i].attachList[j].attNm +'" alt="강의 이미지"';
									} else{
				 		 				code += '   src="/resources/images/기본강의.jpg" alt="기본 강의 이미지"';
									}
								}
							}
						}
						if(result[i].prmmClfc == 'PRE0002') {
							if(result[i].attachList.length != 0){
								for(var j = 0; j <result[i].attachList.length; j++){
									if(result[i].attachList[j].attClfcNo == 'ATTCL0009'){
				 		 				code += '	src="D:/JOBJOB/images' + result[i].attachList[j].attNm +'" alt="특강 이미지"';
// 				 		 				code += '	src="/resources/images' + result[i].attachList[j].attNm +'" alt="특강 이미지"';
									} else{
				 		 				code += '   src="/resources/images/기본특강.jpg" alt="기본 특강 이미지"';
									}
								}
							} else {
		 		 				code += '   src="/resources/images/기본특강.jpg" alt="기본 특강 이미지"';
							}
						}

						code += '></div>';
						code += '		<div class="card-body">';
						if(result[i].prmmClfc == 'PRE0001'){
							code += '<span class="badge bg-gradient-success">강의</span>';

						} else if(result[i].prmmClfc == 'PRE0002'){
							code += '<span class="badge bg-gradient-danger">특강</span>';
						} else {
							code += '<span class="badge bg-gradient-warning">인턴십</span>';
						}
						code += '<br />';

						code += '<p class="mt-1 card-text" style="height:80px !important;"><b>'+result[i].prmmTitle +'</b></p>';

						if(result[i].prmmClfc == "PRE0001") {
							code += '<div class="card-text">강사 : ' + result[i].lectureList[0].lctInstrNm + '</div>';
						}
						if(result[i].prmmClfc == "PRE0002") {
							code += '<div class="card-text">강사 : ' + result[i].lectureList[0].lctInstrNm;
							let itnsRecStartYear 	= new Date(result[i].lectureList[0].lctDt).getFullYear();
							let itnsRecStartMonth 	= new Date(result[i].lectureList[0].lctDt).getMonth() + 1;
							let itnsRecStartDay 	= new Date(result[i].lectureList[0].lctDt).getDate();

							code += '<br/>특강 일시: : ' + itnsRecStartYear + "-" + itnsRecStartMonth + "-" + itnsRecStartDay + '</div>';
						}
						if(result[i].prmmClfc == "PRE0003"){
							let itnsRecStartYear 	= new Date(result[i].internshipList[0].itnsRecStart).getFullYear();
							let itnsRecStartMonth 	= new Date(result[i].internshipList[0].itnsRecStart).getMonth() + 1;
							let itnsRecStartDay 	= new Date(result[i].internshipList[0].itnsRecStart).getDate();
							let itnsRecEndYear 	= new Date(result[i].internshipList[0].itnsRecEnd).getFullYear();
							let itnsRecEndMonth = new Date(result[i].internshipList[0].itnsRecEnd).getMonth() + 1;
							let itnsRecEndDay 	= new Date(result[i].internshipList[0].itnsRecEnd).getDate();

							code += '<div class="card-text">모집 : ' + itnsRecStartYear + "-" + itnsRecStartMonth + "-" + itnsRecStartDay + ' - '
									+ itnsRecEndYear + "-" + itnsRecEndMonth + "-" + itnsRecEndDay  + '</div>';
						}
						code += '		</div>';
						code += '	</div>';
						code += '</a>';
						code += '</div>';
		 			}
	 			}
	 				$(".prmmList").html(code);
	 		}, error:function(err){
	 			console.log("err : "  , err);
	 		}
		})
	})
})

</script>



<%-- ${data } --%>

<!-- Main content -->
<section class="pt-3 pt-md-5 pb-md-5">
	<div class="container-fluid">
		<!-- -------------------- body 시작 -------------------- -->

		<!-- 여기어 넣으면됨 -->
		<div class="container p-4 blur border-radius-lg" style="background-color: rgb(255 244 244 / 60%) !important;">
				<div class="card card-body blur shadow-blur"  style="height:auto;margin-bottom: 25px;">
					<div class="row" style="align-items: center;">
						<div class="col mx-auto" style="text-align:center;">
							<h4>다양한 커리어 관련 이벤트를 만나보세요!</h4>
						</div>
						<div class="col-2 text-end">
							<a class="badge badge-pill badge-lg bg-gradient-info prmmMyPage" href="#" onclick="goPrmm()">
								<strong style="font-size: large;">내 강의실</strong>
							</a>
						</div>
					</div>
				</div>

					<div class="row">
						<div class="col">
							<div class="card nav-wrapper position-relative end-0">
								<ul class="nav nav-pills nav-fill p-1" role="tablist">
									<li class="nav-item prmmClfc" data-clfc="">
										<a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab"
											href="#profile-tabs-simple" role="tab" aria-controls="profile"
											aria-selected="true" >
											<input class="category" type="hidden" value=""/>
											전체
										</a>
									</li>
									<li class="nav-item prmmClfc" data-clfc="PRE0001">
										<a class="nav-link mb-0 px-0 py-1 v"
											data-bs-toggle="tab" href="#dashboard-tabs-simple" role="tab"
											aria-controls="dashboard" aria-selected="false" >
											<input class="category" type="hidden" value=""/>
											 강의
										</a>
									</li>
									<li class="nav-item prmmClfc" data-clfc="PRE0002">
										<a class="nav-link mb-0 px-0 py-1"
											data-bs-toggle="tab" href="#dashboard-tabs-simple" role="tab"
											aria-controls="dashboard" aria-selected="false" >
											<input class="category" type="hidden" value=""/>
											 특강
										</a>
									</li>
									<li class="nav-item prmmClfc" data-clfc="PRE0003">
										<a class="nav-link mb-0 px-0 py-1 "
											data-bs-toggle="tab" href="#dashboard-tabs-simple" role="tab"
											aria-controls="dashboard" aria-selected="false">
											<input class="category" type="hidden" value=""/>
											인턴십
										</a>
									</li>
								</ul>
							</div>
						</div>
					</div>


			<!-- 무한스크롤 시작 -->
			<div class="fullContent pt-lg-4">
				<div class="list">
					<div class="row prmmList">
						<!-- ========== List<PremiumVO>에서 premiumVO 한개씩 꺼냄 ========== -->
						<c:forEach var="premiumVO" items="${data }" varStatus="stat">
							<div class="col-md-3">
								<a class="goPage" href="/premium/premiumDetail?prmmNo=${premiumVO.prmmNo }">
									<div class="card mb-4 shadow-sm" style="height:410px;">
										<c:if test="${premiumVO.prmmClfc eq 'PRE0003' }">
											<c:set var="itnsList" value="${premiumVO.internshipList}" />
												<div class="p-1" style="height:225px;">
													<img class="bd-placeholder-img card-img-top" width="100%"
														height="200" xmlns="http://www.w3.org/2000/svg" role="img"
														aria-label="Placeholder: Thumbnail"
														preserveAspectRatio="xMidYMid slice" focusable="false"
														<c:choose>
															<c:when test="${itnsList[0].attNm eq null || itnsList[0].attNm eq '' }">
																src="/resources/images/기본인턴십.jpg" alt="인턴십 기본 이미지"
															</c:when>
															<c:otherwise>
																src="/resources/images${itnsList[0].attNm  }" alt="${itnsList[0].attNm }"
															</c:otherwise>
														</c:choose>
													>
													<title>Placeholder</title>
													<rect width="100%" height="100%" fill="#55595c"></rect>
												</div>
										</c:if>
										<c:if test="${premiumVO.prmmClfc eq 'PRE0001'}">
											<!-- premiumVO 한 개에 들어있는 attachList 꺼내기-->
											<c:set var="attachList" value="${premiumVO.attachList}" />
												<!-- ====================================================== -->
															<!-- attachList에 데이터가 없으면 ==> 대체이미지 출력(넣어야함) -->
															<!-- attachList에 데이터가 있으면 -->
												<div class="p-1" style="height:225px;">
													<img class="bd-placeholder-img card-img-top" width="100%"
														height="200" xmlns="http://www.w3.org/2000/svg" role="img"
														aria-label="Placeholder: Thumbnail"
														preserveAspectRatio="xMidYMid slice" focusable="false"
															<c:if test="${fn:length(attachList) eq 0}">
																src="/resources/images/기본강의.jpg" alt="강의 기본 이미지"
															</c:if>
															<c:if test="${attachList eq null || fn:length(attachList) != 0}">
																<c:forEach var="attachVO" items="${attachList }" varStatus="stat">
																	<c:choose>
																		<c:when  test="${attachVO.attClfcNo eq 'ATTCL0009' }">
																			src="/resources/images${attachVO.attNm  }" alt="${attachVO.attNm }"
																		</c:when>
																		<c:otherwise>
																			src="/resources/images/기본강의.jpg" alt="강의 기본 이미지"
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</c:if>
													>
													<title>Placeholder</title>
													<rect width="100%" height="100%" fill="#55595c"></rect>
												</div>
										</c:if>
										<c:if test="${premiumVO.prmmClfc eq 'PRE0002'}">
											<!-- premiumVO 한 개에 들어있는 attachList 꺼내기-->
											<c:set var="attachList" value="${premiumVO.attachList}" />
												<!-- ====================================================== -->
															<!-- attachList에 데이터가 없으면 ==> 대체이미지 출력(넣어야함) -->
															<!-- attachList에 데이터가 있으면 -->
												<div class="p-1" style="height:225px;">
													<img class="bd-placeholder-img card-img-top" width="100%"
														height="200" xmlns="http://www.w3.org/2000/svg" role="img"
														aria-label="Placeholder: Thumbnail"
														preserveAspectRatio="xMidYMid slice" focusable="false"
															<c:if test="${fn:length(attachList) eq 0}">
																src="/resources/images/기본특강.jpg" alt="특강 기본 이미지"
															</c:if>
															<c:if test="${attachList eq null || fn:length(attachList) != 0}">
																<c:forEach var="attachVO" items="${attachList }" varStatus="stat">
																	<c:choose>
																		<c:when  test="${attachVO.attClfcNo eq 'ATTCL0009' }">
																			src="/resources/images${attachVO.attNm  }" alt="${attachVO.attNm }"
																		</c:when>
																		<c:otherwise>
																			src="/resources/images/기본특강.jpg" alt="특강 기본 이미지"
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</c:if>
													>
													<title>Placeholder</title>
													<rect width="100%" height="100%" fill="#55595c"></rect>
												</div>
										</c:if>


										<div class="card-body">
											<c:if test='${premiumVO.prmmClfc == "PRE0001"}'>
												<span class="badge bg-gradient-success">강의</span>
											</c:if>
											<c:if test='${premiumVO.prmmClfc eq "PRE0002"}'>
												<span class="badge bg-gradient-danger">특강</span>
											</c:if>
											<c:if test='${premiumVO.prmmClfc eq "PRE0003"}'>
												<span class="badge bg-gradient-warning">인턴십</span>
											</c:if>
											<br />
											<p class="mt-1 card-text" style="height:80px !important;"><b>${premiumVO.prmmTitle }</b></p>
											<c:forEach var="lectureVO" items="${premiumVO.lectureList }"
												varStatus="stat">

												<!-- 강의면 시간 출력 / 특강이면 특강일시 -->
												<div class="card-text">
													<c:if test='${premiumVO.prmmClfc == "PRE0001"}'>
														<div class="card-text">강사 : ${lectureVO.lctInstrNm }</div>
													</c:if>
													<c:if test='${premiumVO.prmmClfc eq "PRE0002"}'>
														<div class="card-text">강사 : ${lectureVO.lctInstrNm }</div>
														<div>특강 일시 : <fmt:formatDate pattern="yyyy-MM-dd" value="${lectureVO.lctDt}"/></div>
													</c:if>
												</div>
											</c:forEach>
											<div class="card-text">
												<c:if test='${premiumVO.prmmClfc eq "PRE0003"}'>
													<!-- 시작일의 7일 전부터 3일 전 -->
													모집 :
													<fmt:formatDate pattern="yyyy-MM-dd" value="${premiumVO.internshipList[0].itnsRecStart}"/> -
													<fmt:formatDate pattern="yyyy-MM-dd" value="${premiumVO.internshipList[0].itnsRecEnd}"/>
												</c:if>
											</div>
											<p class="card-text"></p>
<!-- 																				<div class="d-flex justify-content-between align-items-center"> -->
<!-- 																					<div class="btn-group"> -->
<!-- 																						<button type="button" class="btn btn-sm btn-outline-secondary">View</button> -->
<!-- 																					</div> -->
<%-- 																					<small class="text-muted">${lectureVO.prmmRegDt}</small> --%>
<!-- 																				</div> -->
										</div>
										<!-- card-body 끝 -->
									</div>
								</a>

							</div>
						</c:forEach>
						<div class="pagination">
						</div>
						<!-- List<PremiumVO> 출력 끝 -->
					</div>
					<!-- row -->
				</div>
				<!-- list -->
			</div>
			<!-- infinite -->
		</div>


		<!-- -------------------- body 끝 -------------------- -->
	</div>

</section>


<script type="text/javascript">


	//프리미엄 입장 버튼
	//	1.멤버십 구독시 : 마이프리미엄 입장
	//	2.미 구독시 : 결제 페이지
	function goPrmm(){
		//멤버십 구독 여부
		let msyn = "${memVO.msyn}";
		console.log("msyn : " , msyn);

		if(msyn == 0) {
			Swal.fire({
				  icon: 'warning',
				  text: '',
				  title: '입장할 수 없습니다.',
				  text: '먼저 멤버십을 구독하세요',
				  closeOnClickOutside :false
			}).then((result) => {
// 					location.replace("/premium/subscription");
					location.href="/premium/subscription";
			})
		} else {
			location.href="/myPremium/main"
		}

	}

</script>

