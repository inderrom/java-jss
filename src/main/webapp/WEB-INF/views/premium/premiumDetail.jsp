<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- sweetalert -->
<script src="/resources/js/sweetalert2.min.js"></script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memVO" var="memVO"/>
</sec:authorize>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<fmt:formatDate value="${data.internshipList[0].itnsRecStart}" pattern="yyyy-MM-dd" var="recStart" />
<fmt:formatDate value="${data.internshipList[0].itnsRecEnd}" pattern="yyyy-MM-dd" var="recEnd" />

<style>
.vertical{
	border-right: 1px solid #808080b3;
}
.img-fluid {
  display: block;
  height : 360px;
}
.contentImageBox{

}
.contentImage{
	background-size: contain;
}
</style>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container blur border-radius-lg p-5" style="min-height: 1500px;background-color: rgb(255 244 244 / 60%) !important;">
			<form>
				<input type="hidden" value="${data.prmmNo }" id="prmmNo">
				<input type="hidden" value="${memVO.memId}" id="memId">
				<input type="hidden" value="${data.prmmClfc }" id="prmmClfc">
			</form>
			<div class="row">
				<!-- 게시판 리스트 시작 -->
				<div class="col-lg-12">
					<div class="card-body">
						<div class="row bg-white shadow-lg border-radius-lg" style="margin:0rem 0.1rem 0rem 0.1rem;">

						</div>
						<hr>


						<section>
							<div class="container bg-white shadow-lg border-radius-lg">

								<div class="row">
									<div class="col-md-7">
										<div class="card-header text-center m-4 vertical" style="max-height:360px;">

											<c:if test="${data.prmmClfc eq 'PRE0003' }">
												<c:set var="itnsList" value="${data.internshipList}" />
													<img class="img-fluid mx-auto pe-2"
														<c:choose>
															<c:when test="${itnsList[0].attNm eq null || itnsList[0].attNm eq '' }">
																src="/resources/images/기본인턴십.jpg" alt="인턴십 기본 이미지"
															</c:when>
															<c:otherwise>
																src="/resources/images${itnsList[0].attNm  }" alt="${itnsList[0].attNm }"
															</c:otherwise>
														</c:choose>
													>
											</c:if>
											<c:if test="${data.prmmClfc eq 'PRE0001'}">
												<c:set var="attachList" value="${data.attachList}" />
													<img class="img-fluid  mx-auto pe-2"
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
											</c:if>
											<c:if test="${data.prmmClfc eq 'PRE0002'}">
												<c:set var="attachList" value="${data.attachList}" />
													<img class="img-fluid mx-auto pe-2"
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
											</c:if>



										</div>
									</div>
									<div class="col-md-5 pt-5 p-3">
										<div class="row" style="height:250px;">
											<h4>${data.prmmTitle }</h4><br/>

											<div class="col-lg-12">
												<div class="row" >
													<c:if test="${data.prmmClfc eq 'PRE0003' }">
														<p><span>모집 기간 : </span>
															<fmt:formatDate pattern="yy-MM-dd" value="${data.internshipList[0].itnsRecStart}"/>-
															<fmt:formatDate pattern="yy-MM-dd" value="${data.internshipList[0].itnsRecEnd}"/>
															<input type="hidden" id="now" value="${now }">
														</p>
														<p><span>진행 기간 : </span>
															<fmt:formatDate pattern="yy-MM-dd" value="${data.internshipList[0].itnsBgngDt }"/> -
															<fmt:formatDate pattern="yy-MM-dd" value="${data.internshipList[0].itnsEndDt }"/>
														</p>
														<p><span>참여 조건 : </span>${data.internshipList[0].itnsCondition }</p>
														<p><span>최종 발표 : </span> 하루 전 개별 연락</p>
													</c:if>
													<!-- ================================================================ -->
													<!-- 강의, 특강 -->
													<c:if test="${data.prmmClfc eq 'PRE0001' or data.prmmClfc eq 'PRE0002'}">
														<c:if test="${data.prmmClfc eq 'PRE0001'}">
															<p>총 강의 시수 : <fmt:formatDate pattern="yyyy-MM-dd" value="${data.lectureList[0].lctDt }"/></p>
														</c:if>
														<c:if test="${data.prmmClfc eq 'PRE0002'}">
															<p>특강 일시 : <fmt:formatDate pattern="yy-MM-dd" value="${data.lectureList[0].lctDt }"/>
															</p>
														</c:if>

														<p>진행 강사 : ${data.lectureList[0].lctInstrNm }</p>
													</c:if>
													<!-- ================================================================  -->
												</div>
											</div>
										</div>
										<div class="row pe-4" style="justify-content: space-around;">
											<button type="button" class="btn bg-gradient-info mt-3 btn-lg btnApply" style="width:50%; border-radius : 30px;">신청하기</button>
											<button type="button" class="btn bg-gradient-danger mt-3 btn-lg" onclick="javascript:history.back()" style="width:50%; border-radius : 30px;">목록</button>
										</div>
									</div>
								</div>
							</div>

							<div class="container bg-white shadow-lg p-3 pt-5 mt-4" style="min-height:600px;">
<!-- 								<hr style="background-color : gray"> -->
								<div class="contentImageBox mx-auto text-center mt-3 mb-7" style="width:800px; height:auto;">
									<c:if test="${data.prmmClfc eq 'PRE0003' }">
										<img class="contentImage border-radius-lg mx-auto "
											src="/resources/images${data.attachList[0].attNm  }" alt="${data.attachList[0].attNm }"
											style="width:100%;">
									</c:if>
								</div>
								<div class="mx-10 mb-7">${data.prmmContent }</div>
							</div>


						</section>
					</div>
				</div>
				<!-- 게시판 리스트 끝 -->

			</div>
		</div>
	</section>


<script type="text/javascript">
//참가 신청하기 버튼(btnItnsApply) 클릭시 ajax로 신청 처리 => 이미 신청한 프로그램일 경우 신청 막음
//강의, 인턴십 신청 성공여부 (기존에 내역이 있을 시 이미 신청한 내역이라는 알람이 뜬다.)
$(function(){
	let etpId = $('#prmmNo').val();
	let memId = $('#memId').val();
	let prmmClfc = $('#prmmClfc').val();
	console.log("prmmNo : " , etpId, ", prmmClfc : " , prmmClfc);
	// chekcApply 메소드에 보낼 데이터
	let jsonData = {
		"etpId" : etpId,
		"memId" : memId
	}
	let itnsNo = "";
	if(prmmClfc == 'PRE0003'){
		itnsNo = "${data.internshipList[0].itnsNo }";
	}
	let itnsData = {
		"itnsNo" : itnsNo,
		"memId" : memId
	}

	let memVO = "${memVO}";
	let msyn = "${memVO.msyn}";
	console.log("memVO : ", memVO, "/ msyn : ", msyn );



	$(".btnApply").on("click", function() {
		if(msyn == 1){
			if(prmmClfc == 'PRE0003'){ //신청하는 프리미엄이 인턴십이면
				console.log("여기는 인턴십!!")


				let now = new Date("${today}");
				let recStart = new Date("${recStart}");
				let recEnd = new Date("${recEnd}");
				console.log("start : " , recStart, ", end : " , recEnd, ", now : ", now);

				if(recStart <= now && now <= recEnd) {
					$.ajax({
						url : '/premium/checkInternshipEntryant',
						contentType : 'application/json;charset=utf-8',
						data : JSON.stringify(itnsData),
						type : 'post',
						beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(result) {
							console.log("checkInternshipEntryant result : ", result)
							if(result > 0){
								Swal.fire({	icon: 'warning',
									title: '\n참가 신청한 프로그램입니다.\n\n'});
							} else {
								location.href = "/premium/internshipApply?prmmNo=${data.prmmNo}";
							}
						},
						error : function(err) {
							console.log("err:" + err.status); }
					})
				} else{
					Swal.fire({	icon: 'warning',
						title: '\n인턴십 모집기간이 아닙니다.\n\n'});
				}

			}else { //신청하는 프리미엄이 강의/특강이면
				$.ajax({
					url : '/premium/checkApply',
					contentType : 'application/json;charset=utf-8',
					data : JSON.stringify(jsonData),
					type : 'post',
					beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); },
					success : function(result) {
						console.log("checkApply result :" + result);
						if (result > 0) {
							Swal.fire({	icon: 'warning',
								title: '\n수강 신청한 프로그램입니다.\n\n'});
						} else {
							Swal.fire({
								title: '수강 신청하시겠습니까?',
								icon: 'question',
								showCancelButton: true,
								confirmButtonColor: '#3085d6',
								cancelButtonColor: '#d33',
								confirmButtonText: '신청하기',
								cancelButtonText: '취소하기'
							}).then((result) => {
								if (result.isConfirmed) {
						 			$.ajax({
								         url:"/record/bookmark",
								         data: {"etpId": etpId}, // etpId는 각 테이블의 기본키(게시판, 프리미엄, 공고 등)
								         type:"post",
								         beforeSend : function(xhr) {
								                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
								         },
								         success:function(result){ // result는 성공 1, 실패 0
								        	 Swal.fire({icon: 'success',
								        		 		title: '\n수강 신청 완료!\n\n'});
								         }
							      	});
							  	}
							});
						}
					},
					error : function(err) {
						console.log("err:" + err.status); }
				})
			}
		} else {
			location.href = "/premium/subscription";
		}

	})

})
</script>

<%-- ${data } --%>


