<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script>
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
</script>
<section class="pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="row blur border-radius-lg bg-white shadow-lg p-4" style="align-items: flex-start;height: 1500px;background-color: rgb(255 244 244 / 60%) !important;justify-content: space-between;">
			<div class="col-lg-3" style="padding: 0;">
				<ul class="nav flex-column bg-white shadow-lg border-radius-lg p-3">
					<li class="nav-item my-md-4" style="text-align: center;">
						<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar mx-lg-auto avatar-xxl" />
						<form name="signform" method="POST" enctype="multipart/form-data" action="/mem/profileUpdate">
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
						<h5>면접 제안</h5>
						<div class="row mt-4" style="justify-content: center;">

							<div class="col vertical" >
								<div class="p-3 text-center empState" data-clfc="all" onclick="setEmplSts(this)">
									<p class="mb-0"  id="pAll">0</p>
									<h6 class="mt-2">전체</h6>
								</div>
							</div>
							<div class="col vertical" >
								<div class="p-3 text-center empState" data-clfc="like" onclick="setEmplSts(this)">
									<p class="mb-0" id="pLike">0</p>
									<h6 class="mt-2">관심 있음</h6>
								</div>
							</div>
							<div class="col vertical" >
								<div class="p-3 text-center empState" data-clfc="view" onclick="setEmplSts(this)">
									<p class="mb-0" id="pView">0</p>
									<h6 class="mt-2">이력서 열람</h6>
								</div>
							</div>
							<div class="col" >
								<div class="p-3 text-center empState" data-clfc="offer" onclick="setEmplSts(this)">
									<p class="mb-0" id="pOffer">0</p>
									<h6 class="mt-2">받은 제안</h6>
								</div>
							</div>


						</div>
					</div>
				</div>
				<div class="card-body bg-white border-radius-lg shadow-lg p-4 min-height-400 py-md-3 mb-4">
					<div class="table-responsive">
						<table class="table align-items-center mb0-">
							<thead>
								<tr class="text-center" id="theadtr">
									<th class="text-uppercase text-secondary  font-weight-bolder opacity-7 ps-2">회사명</th>
									<th class="text-center text-uppercase text-secondary  font-weight-bolder opacity-7">일자</th>
									<th class="text-center text-uppercase text-secondary  font-weight-bolder opacity-7">상태</th>
									<th class="text-center text-uppercase text-secondary  font-weight-bolder opacity-7" style="width:10%;"></th>
								</tr>
							</thead>
							<tbody id="tbody">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
let offerList = ${offerList};
let likeList = ${likeList};
let viewList = ${viewList};
let allList = [...offerList, ...likeList, ...viewList];
console.log("offerList", offerList);
console.log("likeList", likeList);
console.log("viewList", viewList);
console.log("allList", allList);

$("#pAll").html(allList.length);
$("#pLike").html(likeList.length);
$("#pView").html(viewList.length);
$("#pOffer").html(offerList.length);

let tbody = $("#tbody");

allList = allList.sort((a, b) => new Date(a.date) - new Date(b.date));
setTbody(allList);

//

function setLiBgColor(e){
	$("li").css("background-color", "white");
	$(e).css("background-color", "skyblue");
}

function setEmplSts(e){
	console.log(e);
	let clfc = $(e).data("clfc");
	if(clfc == 'all'){
		setTbody(allList);
	}else if(clfc == 'like'){
		setTbody(likeList);
	}else if(clfc == 'view'){
		setTbody(viewList);
	}else{
		setTbody(offerList);
	}
}

function setTbody(list){
	let code = "";
	if(list.length == 0){
		tbody.html("<tr><td colspan='3' class='text-center'>요청하신 결과가 없습니다.</td></tr>");
		return;
	}
	$.each(list, function(i, v){
		let date = new Date(v.date);
		code += '<tr><td class="text-center"><p class="font-weight-bold mb-0" style="font-size:large;">' + v.entNm + '</p></td>';
		code += '<td class="align-middle text-center"><span class="badge badge-success" style="font-size:initial;">' + date.toLocaleDateString() + '</span></td>';
		code += '<td class="align-middle text-center" style="font-size:large;">' + v.stsNm + '</td><td>';
		if(v.stsNm == '제안'){
			code += '<button type="button" class="btn btn-info text-end btnAccept" style="margin-top: auto;margin-bottom: auto;" data-mtchofferno="' + v.mtchOfferNo + '">수락하기</button>';
		}
		code += '</td></tr>';

	});
	tbody.html(code);
}

$(document).on("click", ".btnAccept", function(){
	Swal.fire({
		title: '수락하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '수락',
		cancelButtonText: '취소'
	}).then((result) => {
		if (result.isConfirmed) {
			Swal.fire({
				icon: 'success',
		 		title: '\n담당자가 지원자님께 연락드릴거에요. :)\n\n'
 			}).then((result) => {
 				if (result.isConfirmed) {
					let mtchOfferNo = $(this).data("mtchofferno");
					let form = document.createElement("form");
					form.method = "POST";
					form.action = "/mem/acceptMatchingOffer";
		
					let csrfInput = document.createElement("input");
					csrfInput.name = "${_csrf.parameterName}";
					csrfInput.value = "${_csrf.token}";
		
					let input = document.createElement("input");
					input.name = "mtchOfferNo";
					input.value = mtchOfferNo;
		
					form.append(csrfInput);
					form.append(input);
					document.body.append(form);
		
					form.submit();
 				}
 			});
	  	}
	});
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
				location.href="/premium/subscription";
		})
	} else {
		location.href="/myPremium/main"
	}
}
</script>