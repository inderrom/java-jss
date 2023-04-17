<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />



<style>
.vertical{
	border-right: 1px solid #808080b3;
}
.mb-0{
	font-size: xxx-large;
}
.userimage{
	height: 100px;
	width: 100px;
	border-radius: 50%;
}
#interestTag{
	border-radius: 1.875rem;
	width: 150px;
}
.my-menu-list{
	border-bottom: 1px solid #808080b3;
	font-size: large;
}
ul{
	list-style:none;
}
</style>
<script type="text/javascript">
$(function(){
	let myPageDetailDiv = $("#myPageDetailDiv");
	let emplClfcNo = "All";

	let jsmemId = "${memVO.memId}";
	let passExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,12}$/;

	$.ajax({
		url:"/mem/memSearch",
		data: {"memId": jsmemId},
		type:"post",
		beforeSend : function(xhr) {
		       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
		   console.log(result);
		   if(result.attNm != null && result.attNm != ""){
			   $("#myprofile").attr("src", "/resources/images"+result.attNm);
		   }
		}
	});

	$(".my-menu-list").on("click", function(){
		let mennum = $(this).data("menunm");
		console.log(mennum);
		$("#textttt").text(mennum);
	});

	$(".empState").on("click", function(){
		let emplClfcNo = $(this).data("cmcddtl");

		setEmplSts(emplClfcNo);
	});


	$("#myMembership").on("click", function(){
		$.ajax({
			url : "/mem/myMembership",
			data : {"memId" : jsmemId},
			type : "post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log( result );

				let code = "";
				code += '<section class="min-height-400 py-md-3"><div class="container"><div class="row" style="justify-content: center;"><div class="row justify-content-center">';

				code += '					<div class="table-responsive">';
				code += '						<table class="table align-items-center mb0-">';
				code += '							<thead>';
				code += '								<tr class="text-center">';
				code += '									<th class="text-uppercase text-secondary  font-weight-bolder opacity-7 ps-2">상품명</th>';
				code += '									<th class="text-center text-uppercase text-secondary  font-weight-bolder opacity-7">결제일</th>';
				code += '									<th class="text-center text-uppercase text-secondary  font-weight-bolder opacity-7">기간</th>';
				code += '									<th class="text-center text-uppercase text-secondary  font-weight-bolder opacity-7">금액</th>';
				code += '								</tr>';
				code += '							</thead>';
				code += '							<tbody>';
				for(let i=0;i<result.length; i++){
					let startDate = result[i].vipBgngDt.substr(0,10);
					let endDate = result[i].vipEndDt.substr(0,10);

					code += '								<tr>';
					code += '									<td class="text-center">';
					code += '										<p class="text-xs font-weight-bold mb-0"> [월 구독제] ' + result[i].vipGrdBnf + '</p>';
					code += '									</td>';
					code += '									<td class="align-middle text-center ">';
					code += '										<span class="badge badge-success"> '+ result[i].vipBgngDt.substr(0,10) +'</span>';
					code += '									</td>';
					code += '									<td class="align-middle text-center ">';
					code += 										startDate +' ~ '+ endDate;
					code += '									</td>';
					code += '									<td class="align-middle text-center">';
					code += '										<p class="text-xs font-weight-bold mb-0"> ￦ 4,900 </p>';
					code += '									</td>';
					code += '								</tr>';
				}
				code += '							</tbody></table></div>';
				code += '</div></div></div></section>';

				$("#myPageDetailDiv").html(code);
			}
		});
	});


})


</script>


<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="row blur border-radius-lg bg-white shadow-lg p-4" style="align-items: flex-start;height:auto; min-height: 500px;background-color: rgb(255 244 244 / 60%) !important;">
				<div class="col-lg-3 mb-lg-0 mb-5 mt-8 mt-md-5 mt-lg-0">
					<ul class="nav flex-column bg-white shadow-lg border-radius-lg p-3">
						<li class="nav-item my-md-4" style="text-align: center;">
							<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar mx-lg-auto avatar-xxl" />
						</li>
						<li class="nav-item" style="text-align: center;">
							<div class="mt-md-4 mb-md-3">
							<h5 class="my-md-4">${memVO.memNm}</h5>
							<h6 class="my-md-2">${memVO.memId}</h6>
							<h6 class="my-md-2">${memVO.memTelno}</h6>
							</div>
						</li>
						<li class="nav-item" style="text-align: center;">
						<c:choose>
							<c:when test="${memVO.msyn eq 1}">
								<button type="button" id="myMembership" class="btn bg-gradient-light w-auto me-2"><i class="material-icons">loyalty</i>&nbsp;&nbsp;구독중</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn bg-gradient-info w-auto me-2"><i class="material-icons" onclick="javascript:location.href='/premium/subscription';">loyalty</i>&nbsp;&nbsp;멤버십</button>
							</c:otherwise>
						</c:choose>
					</li>
						<li>
							<ul class="nav flex-column px-4 pt-6">
							<li class="nav-item my-menu-list" data-menunm="프로필">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" href="/mem/myProfile">
									<i class="material-icons text-dark opacity-5 pe-2">account_circle</i>프로필
								</a>
							</li>
							<li class="nav-item my-menu-list" data-menunm="면접제안">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" href="/mem/myEmployOffer">
									<i class="material-icons text-dark opacity-5 pe-2">widgets</i>면접제안
								</a>
							</li>
							<li class="nav-item my-menu-list" data-menunm="프리미엄">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" href="/myPremium/main">
									<i class="material-icons text-dark opacity-5 pe-2">workspace_premium</i>프리미엄
								</a>
							</li>
							<li class="nav-item my-menu-list" data-menunm="커뮤니티">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" href="/mem/myBoardList">
									<i class="material-icons text-dark opacity-5 pe-2">people_alt</i>커뮤니티
								</a>
							</li>
							<li class="nav-item" data-menunm="기록">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" style="font-size: large;" href="/mem/myRecord">
									<i class="material-icons text-dark opacity-5 pe-2">receipt_long</i>기록
								</a>
							</li>
						</ul>
						</li>
					</ul>
				</div>
				<div class="col-lg-9">
					<div class="mb-4">
						<div class="card-body bg-white border-radius-lg shadow-lg p-4">
							<p id="" style="font-size: large;"><b>지원 현황</b></p>
							<div class="row mt-4" style="justify-content: center;">
								<div class="col vertical" >
									<div class="p-3 text-center empState" data-cmcddtl="All">
										<p class="mb-0">
											<c:set var="cntSts" value="0"/>
											<c:forEach items="${myEmployStatus}" var="myEmpSts">
												<c:if test="${myEmpSts.CNT_STS ne null}">
													<c:set var="cntSts" value="${cntSts + myEmpSts.CNT_STS}"/>
												</c:if>
											</c:forEach>
											${cntSts}
										</p>
										<h6 class="mt-2">전체</h6>
									</div>
								</div>
								<c:forEach items="${myEmployStatus}" var="myEmpSts" varStatus="myEmpStsIndex">
									<c:if test="${myEmpSts.CMCD_DTL ne 'EMPSTS0006'}">
										<div class="col
											<c:if test="${myEmpStsIndex.count lt myEmployStatus.size() -1}">vertical</c:if>
										" >
											<div class="p-3 text-center empState" data-cmcddtl="${myEmpSts.CMCD_DTL}">
												<p class="mb-0">${myEmpSts.CNT_STS}</p>
												<h6 class="mt-2">${myEmpSts.CMCD_DTL_NM}</h6>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>

					<div class="card shadow-lg mb-5" id="myPageDetailDiv">
						<div class="container" id="">
							<div class="row justify-space-between py-2">
								<div class="col-lg-6 mx-auto">
									<div class="nav-wrapper position-relative end-0">
										<ul class="nav nav-pills nav-fill p-1 shadow" role="tablist">
											<li class="nav-item w-30 " >
												<a class="nav-link px-0 py-1 d-flex align-items-center justify-content-center active"
													data-bs-toggle="tab" href="#myLecList"
													role="tab" aria-controls="myLecList" aria-selected="true">
													<i class="material-icons text-sm me-2">edit</i> 내 강의
												</a>
											</li>
											<li class="nav-item w-30" >
												<a class="nav-link px-0 py-1 d-flex align-items-center justify-content-center "
													data-bs-toggle="tab" href="#myItnsList"
													role="tab" aria-controls="myItnsList" aria-selected="false">
													<i class="material-icons text-sm me-2">dashboard</i> 내 인턴십
												</a>
											</li>
											<li class="nav-item w-30 " >
												<a class="nav-link px-0 py-1 d-flex align-items-center justify-content-center"
													data-bs-toggle="tab" href="#myRecList"
													role="tab" aria-controls="myRecList" aria-selected="false">
													<i class="material-icons text-sm me-2">person</i> 내 기록
												</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>

						<div class="tab-content">
							<div class="tab-pane active" id="myLecList">
								<div class="table-responsive shadow p-sm-3">
									<table class="table align-items-center" style="table-layout:fixed;">
										<thead>
											<tr>
												<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="width:30%;"></th>
												<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 text-center" style="width:40%;">강의</th>
												<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="width:20%;">강의 날짜</th>
												<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="width:20%;"> </th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${fn:length(lec) == 0}">
													<tr>
														<td class="text-center" colspan="4">
															수강신청한 강의가 없습니다.
														</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="lecVO" items="${lec}" varStatus="stat">
														<tr class="lectureRow">
															<td class="text-center" style="height:120px;">
																	<c:choose>
																		<c:when test="${lecVO.attachList[0].attNm eq '' or fn:length(lecVO.attachList[0].attNm ) eq 0 }">
																			<c:if test="${lecVO.prmmClfc eq 'PRE0001' }">
																				<img class="img-fluid border-radius-lg mx-auto"
																				 src="/resources/images/기본강의.jpg" alt="기본 강의 이미지" style="max-width: 180px;">
																			</c:if>
																			<c:if test="${lecVO.prmmClfc eq 'PRE0002'}">
																				<img class="img-fluid border-radius-lg mx-auto"
																				 src="/resources/images/기본특강.jpg" alt="기본 특강 이미지" style="max-width: 180px;">
																			</c:if>
																		</c:when>
																		<c:otherwise>
																			<img class="border-radius-md shadow-lg"
																				src="/resources/images${lecVO.attachList[0].attNm}" alt="강의/특강 이미지" style="max-width:180px;">

																		</c:otherwise>
																	</c:choose>
															</td>
															<td class="ps-2 text-wrap">
																<c:if test="${lecVO.prmmClfc eq 'PRE0001'}">
																	<a class="badge badge-success  me-2">강의</a>
																</c:if>
																<c:if test="${lecVO.prmmClfc eq 'PRE0002'}">
																	<a class="badge badge-danger  me-2">특강</a>
																</c:if>
																<b>${lecVO.prmmTitle}</b>
															</td>
															<td class="text-center">
																<c:if test="${lecVO.prmmClfc eq 'PRE0001'}">
																	상시
																</c:if>
																<c:if test="${lecVO.prmmClfc eq 'PRE0002'}">
																	<fmt:formatDate pattern="yyyy-MM-dd" value="${lecVO.lectureList[0].lctDt}"/>
																</c:if>
															</td>
															<td class="text-center">
																<input type="hidden" value="${lecVO.prmmNo }" class="prmmNoLec">
																<input type="hidden" class="lctDtLec"
																	value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lecVO.lectureList[0].lctDt }"/>" >
																<input type="hidden" value="${lecVO.prmmClfc }" class="prmmClfcLec">
																<a type="button" class="btn bg-gradient-info me-2 btn-sm classBtn"
																	target="_blank" style="width: 95px;">강의실 입장</a><br/>
																<input type="hidden" name="etpId" value="${lecVO.prmmNo }" />
																<button type="button" class="btn bg-gradient-danger me-2 btn-sm deleteLecSubmit" style="width: 95px;">강의 삭제</button>
															</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>

										</tbody>
									</table>
								</div>
							</div>

							<div class="tab-pane " id="myItnsList">
								<div class="table-responsive shadow p-sm-3" >
									<table class="table align-items-center" style="table-layout:fixed;">
										<thead>
											<tr class="text-center">
												<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="width:30%;"></th>
												<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2" style="width:50%;">인턴십</th>
												<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" style="width:25%;"> </th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${fn:length(ing) == 0}">
													<tr>
														<td class="text-center" colspan="3">
															참여한 인턴십이 없습니다.
														</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="internVO" items="${ing}" varStatus="stat">
														<tr>
															<td class="text-center">
																<c:choose>
																	<c:when test="${internVO.attNm  eq '' or fn:length(internVO.attNm) eq 0 }">
																		<img class="border-radius-md shadow-lg"
																			src="/resources/images/기본인턴십.jpg" alt="인턴십 기본 이미지" height="120px">
																	</c:when>
																	<c:otherwise>
																		<img class=" border-radius-md shadow-lg"
																			src="/resources/images${internVO.attNm}" alt="인턴십 이미지"
																			style="max-width: 120px;">
																	</c:otherwise>
																</c:choose>
															</td>
															<td class="text-wrap">
																 <b>${internVO.prmmTitle}</b>
															</td>
															<td class="text-center">
																<a type="button" class="btn bg-gradient-info me-2 btn-sm" onclick="location.href='/myPremium/myInternshipDetail?itnsNo=${internVO.itnsNo }'"
																	target="_blank" style="width: 95px;">입  장</a>
																<form action="/myPremium/deletemyLecture" method="post">
																	<input type="hidden" name="etpId" value="${internVO.prmmNo }" />
																	<sec:csrfInput />
																</form>
															</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>

										</tbody>
									</table>
								</div>
							</div>

							<div class="tab-pane " id="myRecList">
								<div class="table-responsive shadow p-sm-3"  >
									<table class="table align-items-center" style="table-layout:fixed;">
										<thead>
											<tr>
												<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2" style="width:30%;"></th>
												<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7" syle="width:70%;">프리미엄 제목</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${fn:length(record) == 0}">
													<tr \height="120">
														<td class="text-center" colspan="3">
															열람한 기록이 없습니다.
														</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="recVO" items="${record}" varStatus="stat">
															<tr height="120" onclick="location.href='/premium/premiumDetail?prmmNo=${recVO.prmmNo }'">
																<td class="text-center">
																	<c:if test="${recVO.prmmClfc eq 'PRE0003' }">
																		<c:choose>
																			<c:when test="${recVO.internshipList[0].attNm eq null || recVO.internshipList[0].attNm eq '' }">
																				<img class=" border-radius-md shadow-lg"
																					src="/resources/images/기본인턴십.jpg"
																					alt="인턴십 기본 이미지" height="120px">
																			</c:when>
																			<c:otherwise>
																				<img class=" border-radius-md shadow-lg"
																					src="/resources/images${recVO.internshipList[0].attNm}" alt="인턴십 이미지"
																					style="max-width: 240px;">
																			</c:otherwise>
																		</c:choose>
																				<title>Placeholder</title>
																				<rect width="100%" height="100%" fill="#55595c"></rect>
																	</c:if>
																	<c:if test="${recVO.prmmClfc eq 'PRE0001'}">
																		<c:choose>
																			<c:when test="${recVO.attachList[0].attNm eq '' or fn:length(recVO.attachList[0].attNm ) eq 0 }">
																				<img class="border-radius-md shadow-lg"
																					src="/resources/images/기본강의.jpg" alt="강의 기본 이미지" height="120px">
																			</c:when>
																			<c:otherwise>
																				<img class="border-radius-md shadow-lg"
																					src="/resources/images${recVO.attachList[0].attNm}"
																					alt="강의 이미지" height="120px">

																			</c:otherwise>
																		</c:choose>
																	</c:if>
																	<c:if test="${recVO.prmmClfc eq 'PRE0002'}">
																		<c:choose>
																			<c:when test="${recVO.attachList[0].attNm eq '' or fn:length(recVO.attachList[0].attNm ) eq 0 }">
																				<img class="border-radius-md shadow-lg"
																					src="/resources/images/기본특강.jpg" alt="특강 기본 이미지" height="120px">
																			</c:when>
																			<c:otherwise>
																				<img class="border-radius-md shadow-lg"
																					src="/resources/images${recVO.attachList[0].attNm}"
																					alt="특강 이미지" height="120px">

																			</c:otherwise>
																		</c:choose>
																	</c:if>

																</td>
																<td class="text-center text-wrap">${recVO.prmmTitle } <br />
																</td>
		<%-- 															<c:if test='${recVO.prmmClfc == "PRE0001"}'>총 강의 시간 : ${recVO.lctDt}</c:if> --%>
		<%-- 															<c:if test='${recVO.prmmClfc eq "PRE0002"}'> 특강 일시 : ${recVO.lctDt}</c:if> --%>
		<%-- 															<c:if test='${recVO.prmmClfc eq "PRE0003"}'> <!-- 시작일의 7일 전부터 3일 전 --> --%>
		<%-- 																<fmt:formatDate pattern="yyyy-MM-dd" value="${recVO.internshipList[0].itnsRecStart}" /> - --%>
		<%-- 																<fmt:formatDate pattern="yyyy-MM-dd" value="${recVO.internshipList[0].itnsRecEnd}" /> --%>
		<%-- 															</c:if>  --%>
															</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
		</div>
	</div>
</section>


<script type="text/javascript">
$(".deleteLecSubmit").on("click", function(){

	let etpId = $(this).prev().val();
	console.log("etpId", etpId);
	let row = $(this).parents(".lectureRow");
	console.log("this : ", $(this));
  	console.log("this parents : ", $(this).parents("#lectureRow"));

	Swal.fire({
		title: '강의를 삭제하시겠습니까?',
		text: "삭제된 강의는 재신청할 수 있습니다.",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '삭제하기',
		cancelButtonText: '취소하기'
	}).then((result) => {
		if (result.isConfirmed) {
			$.ajax({
				url:"/myPremium/deletemyLecture",
		 		data:{"etpId" : etpId},
		 		type:'post',
		 		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); },
				success:function(result){
			      	row.remove();
					Swal.fire(
			      		'삭제되었습니다.'
			      	)
				}
		  	})
	  	}
	});
})

$(".classBtn").on("click", function(){

	let prmmNoLec = $(this).siblings(".prmmNoLec").val();
	let prmmClfcLec = $(this).siblings(".prmmClfcLec").val();
	let lctDtLec = $(this).siblings(".lctDtLec").val();
	console.log("prmmNoLec : ", prmmNoLec, ", prmmClfc : ",prmmClfcLec,", lctDtLec : ", lctDtLec);

	if(prmmClfcLec == 'PRE0002' ){
		if(lctDtLec == '${today}'){
			location.href = "/myPremium/mylectureDetail?prmmNo="+ prmmNoLec;
		} else {
			Swal.fire({	icon: 'error',
				title: '\n특강 진행 날짜가 아닙니다.\n\n'});
		}
	}else {
		location.href = "/myPremium/mylectureDetail?prmmNo="+prmmNoLec;
	}

})


</script>

<%-- [memVO] : ${memVO } --%>
<%-- [record] : ${record } --%>
<%-- [lec] : ${lec } --%>
<%-- [ing] : ${ing } --%>
<%-- [ended] : ${ended } --%>












