<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
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
	setEmplSts(emplClfcNo);

	let jsmemId = "${memVO.memId}";

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

	$("#myprofile").on("click", function(e){
	    document.signform.target_url.value = document.querySelector( '#myprofile' ).src;
	    e.preventDefault();
	    $('#uploadFile').click();
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

	function setEmplSts(emplClfcNo){
		$.ajax({
			url : "/mem/myEmployStatusInfo",
			data : {"emplClfcNo" : emplClfcNo},
			type : "post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			dataType: "json",
			success : function(result) {
				console.log(result);
				myPageDetailDiv.empty();
				code = "";
				code += '<div class="card-body p-4">';
				code += 	'<section class="min-height-400 pb-md-5">';
				code += 		'<div class="container">';
				code += 			'<div class="row" style="justify-content: center">';
				code += 				'<div class="row justify-content-center">';
				code += 					'<div class="table-responsive">';
				code += 						'<table class="table align-items-center mb-0">';
				code += 							'<thead>';
				code += 								'<tr class="text-center">';
				code += 									'<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">지원회사</th>';
				code += 									'<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">지원포지션</th>';
				code += 									'<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">작성시간</th>';
				code += 									'<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">진행상태</th>';
				code += 								'</tr>';
				code += 							'</thead>';
				code += 							'<tbody id="tbodyEmplSts">';
				if(result == null || result.length < 1){
					code += '<tr>';
					code += 	'<td colspan="4" class="align-middle text-center">';
					code += 		'<p class="text-xs font-weight-bold mb-0">요청하신 결과가 없습니다.</p>';
					code += 	'</td>';
					code += '</tr>';
				}else{
					$.each(result, function(i, v){
						let emplStsChgDt = new Date(v.EMPL_STS_CHG_DT);
						code += '<tr>';
						code += 	'<td>';
						code += 		'<div class="d-flex px-2 py-1">';
						code += 			'<div>';
						code += 				'<img src="/resources/images/hyundai.jpg" class="avatar avatar-sm me-3">';
						code += 			'</div>';
						code += 			'<div class="d-flex flex-column justify-content-center">';
						code += 				'<h5 class="mb-0 text-xs">' + v.ENT_NM + '</h5>';
						code += 				'<h6 class="text-xs text-secondary mb-0">' + v.ENT_URL + '</h6>';
						code += 			'</div>';
						code += 		'</div>';
						code += 	'</td>';
						code += 	'<td>';
						code += 		'<h6 class="text-xs font-weight-bold mb-0">' + v.JOB_PSTG_TITLE + '</h6>';
						code += 	'</td>';
						code += 	'<td class="align-middle text-center text-sm">';
						code += 		'<span class="badge badge-sm badge-success" style="font-size:upset;">' + emplStsChgDt.toLocaleDateString() + '</span>';
						code += 	'</td>';
						code += 	'<td class="align-middle text-center">';
						code += 		'<h6 class="text-xs font-weight-bold mb-0">' + v.CMCD_DTL_NM + '</h6>';
						code += 	'</td>';
						code += 	'<td class="align-middle text-center">';
						code += 	'</td>';
						code += '</tr>';
					});
				}
				code += 							'</tbody>';
				code += 						'</table>';
				code += 					'</div>';
				code += 				'</div>';
				code += 			'</div>';
				code += 		'</div>';
				code += 	'</section>';
				code += '</div>';
				myPageDetailDiv.html(code);
			}
		});
	}
});

function goPrmm(){
	//멤버십 구독 여부
	let msyn = ${memVO.msyn};
	console.log("msyn : " , msyn);

	if(msyn == 0) {
		Swal.fire({
			  icon: 'warning',
			  text: '',
			  title: '입장할 수 없습니다.',
			  text: '먼저 멤버십을 구독하세요',
			  closeOnClickOutside :false
		}).then((result) => {
//					location.replace("/premium/subscription");
				location.href="/premium/subscription";
		})
	} else {
		location.href="/myPremium/main"
	}
}

function changeValue(obj){
//  document.signform.submit();
	let formData = new FormData($('#frm')[0]);
	formData.append("uploadFile", $("#uploadFile").val()) ;

	var reader = new FileReader();

	$.ajax({
		url : "/mem/profileUpdate",
		type : "post",
     processData: false,
     contentType: false,
		data : formData,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			var preview = document.querySelector('#myprofile');
			var file = document.querySelector('input[name=uploadFile]').files[0];
			var reader = new FileReader();

			reader.addEventListener(
				'load',
				function () {
					preview.src = reader.result;
				},
				false
			);
			if (file) {
				reader.readAsDataURL(file);
			}
		}
	});
}
</script>

<section class="pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="row blur border-radius-lg bg-white shadow-lg p-4" style="align-items: flex-start;height: 1500px;background-color: rgb(255 244 244 / 60%) !important;justify-content: space-between;">
			<div class="col-lg-3" style="padding: 0;">
				<ul class="nav flex-column bg-white shadow-lg border-radius-lg p-3">
					<li class="nav-item my-md-4" style="text-align: center;">
						<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar mx-lg-auto avatar-xxl" />
						<form id=""frm name="signform" method="POST" enctype="multipart/form-data" action="/mem/profileUpdate">
						    <input type="file" id="uploadFile" name="uploadFile" style="display:none;" onchange="changeValue(this)" />
						    <input type="hidden" name = "target_url" />
						    <input type="hidden" name="memId" value="${memVO.memId}" />
							<sec:csrfInput/>
						</form>
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
								<button type="button" class="btn bg-gradient-info w-auto me-2">
									<i class="material-icons" onclick="javascript:location.href='/premium/subscription';">loyalty</i>&nbsp;&nbsp;멤버십
								</button>
							</c:otherwise>
						</c:choose>
					</li>
					<li>
						<ul class="nav flex-column px-4 pt-6">
							<li class="nav-item my-menu-list" data-menunm="프로필">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" data-scroll=""  href="/mem/myProfile" >
									<i class="material-icons text-dark opacity-5 pe-2">account_circle</i>프로필
								</a>
							</li>
							<li class="nav-item my-menu-list" data-menunm="면접제안">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" data-scroll=""  href="/mem/myEmployOffer">
									<i class="material-icons text-dark opacity-5 pe-2">widgets</i>면접제안
								</a>
							</li>
							<li class="nav-item my-menu-list" data-menunm="프리미엄">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" data-scroll=""  href="#" onclick="goPrmm()">
									<i class="material-icons text-dark opacity-5 pe-2">workspace_premium</i>프리미엄
								</a>
							</li>
							<li class="nav-item my-menu-list" data-menunm="커뮤니티">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" data-scroll=""  href="/mem/myBoardList">
									<i class="material-icons text-dark opacity-5 pe-2">people_alt</i>커뮤니티
								</a>
							</li>
							<li class="nav-item" data-menunm="기록" style="font-size: large;">
								<a class="nav-link text-dark text-bold d-flex align-items-center my-md-2" data-scroll=""  href="/mem/myRecord">
									<i class="material-icons text-dark opacity-5 pe-2">receipt_long</i>기록
								</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="col-lg-9" style="padding: 0 0 0 20px;">
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
				</div>
			</div>
		</div>
	</div>
</section>