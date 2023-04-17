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
						<h5>기록</h5>
						<div class="row mt-4" style="justify-content: center;">
							<div class="col vertical" >
								<div class="p-3 text-center empState" data-cmcddtl="All">
									<p class="mt-2">
										<a href="#"><i class="material-icons text-dark opacity-5 pe-2">apps</i>전체</a>
									</p>
								</div>
							</div>
							<div class="col vertical" >
								<div class="p-3 text-center myRec" data-clfc="jpstg" onclick="javascript:setData(this);">
									<p class="mt-2">
										<a href="#"><i class="material-icons text-dark opacity-5 pe-2">account_circle</i>공고</a>
									</p>
								</div>
							</div>
							<div class="col vertical" >
								<div class="p-3 text-center myRec"  data-clfc="board" onclick="javascript:setData(this);">
									<p class="mt-2">
										<a href="#"><i class="material-icons text-dark opacity-5 pe-2">edit_note</i>게시글</a>
									</p>
								</div>
							</div>
							<div class="col vertical" >
								<div class="p-3 text-center myRec" data-clfc="ent" onclick="javascript:setData(this);">
									<p class="mt-2">
										<a href="#"><i class="material-icons text-dark opacity-5 pe-2">widgets</i>회사</a>
									</p>
								</div>
							</div>
							<div class="col" >
								<div class="p-3 text-center myRec" data-clfc="prmm" onclick="javascript:setData(this);">
									<p class="mt-2">
										<a href="#"><i class="material-icons text-dark opacity-5 pe-2">workspace_premium</i>프리미엄</a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row" style="justify-content: center">
					<div class="col" id="divRecord" style="display: none;">
						<div class="card mb-1">
							<div class="card-body">
								<h5 id="title"></h5>
								<p id="content"></p>
							</div>
						</div>
					</div>
				</div>
				
				<div class="card-body bg-white border-radius-lg shadow-lg p-4 min-height-400 py-md-3 mb-4">
					<div class="table-responsive">
						<table class="table align-items-center mb0-">
							<tbody id="divRecordArea">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
let myRecordMap =  ${myRecordMap};
let jobPstgList = myRecordMap.jobPostingList;
let boardList = myRecordMap.boardList;
let enterpriseList = myRecordMap.enterpriseList;
let premiumList = myRecordMap.premiumList;
let divRecordArea = $("#divRecordArea");
console.log(jobPstgList);
console.log(boardList);
console.log(enterpriseList);
console.log(premiumList);

setJobPstgRecord();

function setData(el){
	let e = $(el);
	$("li").css("background-color", "white");
	e.parent().css("background-color", "skyblue");
	if(e.data("clfc") == 'jpstg'){
		setJobPstgRecord();
		return;
	}
	if(e.data("clfc") == 'board'){
		setBoardRecord();
		return;
	}
	if(e.data("clfc") == 'ent'){
		setEntRecord();
		return;
	}
	if(e.data("clfc") == 'prmm'){
		setPrmmRecord();
		return;
	}
}

function setJobPstgRecord(){
	divRecordArea.empty();
	if(jobPstgList.length == 0){
		divRecordArea.html("기록이 없습니다.");
		return;
	}
	$.each(jobPstgList, function(i, v){
		if(v == null){
			return;
		}
		let divRecord = $("#divRecord").clone();
		divRecord.find("#title").html(v.jobPstgTitle);
		divRecord.find("#content").html(v.jobPstgContent.substring(0, 20));
		divRecord.on("click", function(){
			location.href = "/jobPosting/detailJobPosting?jobPstgNo=" + v.jobPstgNo;
		});
		divRecord.show();
		divRecordArea.append(divRecord);
	});
}

function setBoardRecord(){
	divRecordArea.empty();
	if(boardList.length == 0){
		divRecordArea.html("기록이 없습니다.");
		return;
	}
	$.each(boardList, function(i, v){
		if(v == null){
			return;
		}
		let divRecord = $("#divRecord").clone();
		divRecord.find("#title").html(v.boardTitle);
		divRecord.find("#content").html(v.boardContent.substring(0, 20));
		divRecord.on("click", function(){
			location.href = "/board/boardDetail?boardNo=" + v.boardNo;
		});
		divRecord.show();
		divRecordArea.append(divRecord);
	});
}

function setEntRecord(){
	divRecordArea.empty();
	if(enterpriseList.length == 0){
		divRecordArea.html("기록이 없습니다.");
		return;
	}
	$.each(enterpriseList, function(i, v){
		if(v == null){
			return;
		}
		let divRecord = $("#divRecord").clone();
		divRecord.find("#title").html(v.entNo);
		divRecord.find("#content").html(v.entDescription.substring(0, 20));
		divRecord.on("click", function(){
// 			location.href = "";
		});
		divRecord.show();
		divRecordArea.append(divRecord);
	});
}

function setPrmmRecord(){
	divRecordArea.empty();
	if(premiumList.length == 0){
		divRecordArea.html("기록이 없습니다.");
		return;
	}
	$.each(premiumList, function(i, v){
		if(v == null){
			return;
		}
		let divRecord = $("#divRecord").clone();
		divRecord.find("#title").html(v.prmmTitle);
		divRecord.find("#content").html(v.prmmContent.substring(0, 20));
		divRecord.on("click", function(){
			location.href = "/premium/premiumDetail?prmmNo=" + v.prmmNo;
		});
		divRecord.show();
		divRecordArea.append(divRecord);
	});
}


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