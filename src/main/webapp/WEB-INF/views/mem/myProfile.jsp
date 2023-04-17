<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<script type="text/javascript">
$(function(){
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

	$("#myprofile").on("click", function(e){
	    document.signform.target_url.value = document.querySelector( '#myprofile' ).src;
	    e.preventDefault();
	    $('#uploadFile').click();
	});

	$("#btnUpdateMemNm").on("click", function(){
		let updateMemNm = $("#updateMemNm").val();
		console.log(memNm);
		$.ajax({
			url:"/mem/updateMem",
			data: {
				"value": updateMemNm,
				"type": "MEM_NM"},
			type:"post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
			   console.log(result);
			   if(result>0){
				   alert("이름이 변경되었습니다.");
				   $("#memNm").val(updateMemNm);
				   $("#changeNm").modal("hide");
			   }
			}
		});
	});

	$("#sendSMS").on("click", function(){
		let sender = $("#updateMemTelno").val();
		$.ajax({
			url: "/api/sms",
			data: {"sender": sender},
			beforeSend : function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			type: "post",
			success: function(result){
				Swal.fire('인증번호를 발송하였습니다.','문자메세지를 확인해주세요. :)');
				console.log(result);
				certificationNumber = result;
			},
			error: function(xhr){
				console.log("error : " + xhr.status);
			}
		});
	});

	$("#btnUpdateMemtelno").on("click", function(){
		if($("#certificationNumber").val()==certificationNumber){
			let updateMemTelno = $("#updateMemTelno").val();
			console.log(updateMemTelno);
			$.ajax({
				url:"/mem/updateMem",
				data: {
					"value": updateMemTelno,
					"type": "MEM_TELNO"},
				type:"post",
				beforeSend : function(xhr) {
				       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
				   console.log(result);
				   if(result>0){
						Swal.fire('전화번호가 변경되었습니다. :)');
					   $("#memTelno").val(updateMemTelno);
					   $("#changeTel").modal("hide");
					   $("#telno").html(updateMemTelno);
				   }
				}
			});
		}else{
			Swal.fire("인증번호가 일치하지 않습니다.");
			return;
		}
	});

	$("#btnUpdateMemPass").on("click", function(){
		if($("#memPass").val() != $("#oldMemPass").val()){
			Swal.fire("현재 비밀번호를 잘못 입력하였습니다.");
			return;
		}
		if($("#newMemPass").val() == ''){
			Swal.fire("변경할 비밀번호를 입력하세요.");
			return;
		}
		if($("#newMemPass").val() == ''){
			Swal.fire("비밀번호 확인을 입력하세요.");
			return;
		}
		if(!passExp.test($("#newMemPass"))){
			Swal.fire("비밀번호 형식이 올바르지 않습니다.");
			return;
		}
		if($("#newMemPass").val() != $("#newMemPassChk").val()){
			Swal.fire("비밀번호가 일치하지 않습니다.");
			return;
		}
		let newMemPass = $("#newMemPass").val();
		$.ajax({
			url:"/mem/updateMem",
			data: {
				"value": newMemPass,
				"type": "MEM_PASS"},
			type:"post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
			   console.log(result);
			   if(result>0){
				   Swal.fire("비밀번호가 변경되었습니다.", "다시 로그인 해주세요.");
				   $("#changePass").modal("hide");
				   logout();
			   }
			}
		});
	});

	$(".jobGroupList").on("click", function(){
		$("#btnMemJobGroup").html($(this).html());
		let cmcdClfc = $(this).data("cmcddtl");
		$.ajax({
			url:"/mem/getMemJob",
			data: {"cmcdClfc": cmcdClfc},
			type:"post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
			   console.log(result);
			   code = "";
			   $.each(result, function(i, v){
				   code += '<li><button type="button" class="dropdown-item jobList">' + v.cmcdDtlNm + '</button></li>';
			   });

			   $("#ulMemJob").html(code);
			}
		});
	});

	$(document).on("click", ".jobList", function(){
		$("#btnMemJob").html($(this).html());
	});

	$("#btnUpdateMemJob").on("click", function(){
		let memJob = $("#btnMemJob").html();
		$.ajax({
			url:"/mem/updateMem",
			data: {
				"value": memJob,
				"type": "MEM_JOB"},
			type:"post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
			   console.log(result);
			   if(result > 0){
				   Swal.fire("직업이 변경되었습니다.");
				   $("#memJob").val(memJob);
				   $("#changeJob").modal("hide");
			   }
			}
		});
	});
});

function changeValue(obj){
//     document.signform.submit();
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
<style>
label, .form-control {
	font-size: large;
	width: 200px;
	display: inline-block;
}
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


<section class="pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="row blur border-radius-lg bg-white shadow-lg p-4" style="align-items: flex-start;height: 1500px;background-color: rgb(255 244 244 / 60%) !important;justify-content: space-between;">
			<div class="col-lg-3" style="padding: 0;">
				<ul class="nav flex-column bg-white shadow-lg border-radius-lg p-3">
					<li class="nav-item my-md-4" style="text-align: center;">
						<img id="myprofile" src="/resources/images${memVO.attNm }" alt="..." class="avatar mx-lg-auto avatar-xxl" />
						<form id="frm" name="signform" method="POST" enctype="multipart/form-data" action="/mem/profileUpdate">
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
							<h6 class="my-md-2" id="telno">${memVO.memTelno}</h6>
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
					<section>
						<div class="card card-body shadow-lg mb-4 p-5">
							<h5>프로필</h5>
							<hr/>
							<h5>계정관리</h5>
							<h6 style="color: #808080b3;">서비스에서 사용하는 내 계정 정보를 관리할 수 있습니다.</h6>
							<div class="row mt-4">
								<p class="my-md-3" data-bs-toggle="modal" data-bs-target="#changeNm">
									<label>이름</label>
									<input type="text" class="form-control" id="memNm" name="memNm" value="${memVO.memNm}" />
								</p>
								<hr class="dark horizontal" />
								<p class="my-md-3" data-bs-toggle="modal" data-bs-target="#changeTel">
									<label>연락처</label>
									<input type="text" class="form-control" id="memTelno" name="memTelno" value="${memVO.memTelno}" />
								</p>
								<hr class="dark horizontal" />
								<p class="my-md-3" data-bs-toggle="modal" data-bs-target="#changeJob">
									<label>직업</label>
									<input type="text" class="form-control" id="memJob" name="memJob" value="${memVO.memJob}<c:if test="${memVO.memJob eq null}">직업을 선택해주세요.</c:if>" />
								</p>
							</div>
						</div>
						<div class="card card-body shadow-lg p-5">
							<h5>개인 정보 보호</h5>
							<h6 style="color: #808080b3;">내 계정을 안전하게 보호하기 위한 정보를 관리할 수 있습니다.</h6>
							<hr />
							<div class="row mt-4">
								<div class="row align-items-center">
									<div class="col-11">
										<h6 class="my-md-3" data-bs-toggle="modal" data-bs-target="#changePass">비밀번호 변경</h6>
									</div>
									<div class="col-1 px-lg-0 text-end">
										<i class="material-icons">arrow_forward</i>
									</div>
								</div>
								<hr class="dark horizontal" />
								<div class="row align-items-center">
									<div class="col-11">
										<h6 class="my-md-3" onclick="javascript:location.href='/mem/outMember'">회원 탈퇴</h6>
									</div>
									<div class="col-1 px-lg-0 text-end">
										<i class="material-icons">arrow_forward</i>
									</div>
								</div>

							</div>
						</div>
					</section>
				</div>
				<div class="card shadow-lg mb-5" id="myPageDetailDiv">
				</div>
			</div>
		</div>
	</div>
</section>




<!-- 비밀번호 변경 Modal -->
<div class="modal fade" id="changePass" tabindex="-1" aria-labelledby="changePass" aria-hidden="true">
	<div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
		<div class="modal-content min-height-300">
			<div class="modal-header">
            	<h5 class="modal-title" id="exampleModalLabel">비밀번호</h5>
            </div>
			<div class="modal-body p-6">
				<div class="card card-plain">
					<div class="card-body pb-3">
						<form role="form text-start">
							<div class="input-group input-group-outline my-sm-4">
								<label class="form-label">현재 비밀번호</label>
								<input type="password" class="form-control" id="oldMemPass"/>
								<input type="hidden" id="memPass" value='<sec:authentication property="principal.memVO.memPass"/>'/>
							</div>

							<hr/>

							<div class="input-group input-group-outline my-sm-4">
								<label class="form-label">새 비밀번호</label>
								<input type="password" class="form-control" id="newMemPass"/>
							</div>

							<div class="input-group input-group-outline my-sm-4">
								<label class="form-label">비밀번호 확인</label>
								<input type="password" class="form-control" id="newMemPassChk"/>
							</div>

						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer text-end">
				<button type="button" class="btn btn-outline-info" id="btnUpdateMemPass">저장</button>
				<button type="button" class="btn btn-outline-default" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 회원 이름 변경 Modal -->
<div class="modal fade" id="changeNm" tabindex="-1" aria-labelledby="changeNm" aria-hidden="true">
	<div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
		<div class="modal-content min-height-300">
			<div class="modal-header">
            	<h5 class="modal-title" id="exampleModalLabel">이름</h5>
            </div>
			<div class="modal-body p-6">
				<div class="card card-plain">
					<div class="card-body pb-3">
						<form role="form text-start">

							<div class="input-group input-group-outline my-sm-4">
								<input type="text" class="form-control" id="updateMemNm" value="${memVO.memNm}" />
							</div>

						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer text-end">
				<button type="button" class="btn btn-outline-info" id="btnUpdateMemNm">저장</button>
				<button type="button" class="btn btn-outline-default" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 회원 연락처 변경 Modal -->
<div class="modal fade" id="changeTel" tabindex="-1" aria-labelledby="changeTel" aria-hidden="true">
	<div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
		<div class="modal-content min-height-300">
			<div class="modal-header">
            	<h5 class="modal-title" id="exampleModalLabel">연락처</h5>
            </div>
			<div class="modal-body p-6">
				<div class="card card-plain">
					<div class="card-body pb-3">
						<form role="form text-start">
							<div class="input-group input-group-outline my-sm-4">
								<input type="text" class="form-control" id="updateMemTelno" value="${memVO.memTelno}" />
								<button type="button" class="btn bg-gradient-info m-sm-1" id="sendSMS">인증번호 발송</button>
							</div>
							<div class="input-group input-group-outline my-sm-4">
								<input type="text" class="form-control" id="certificationNumber" placeholder="인증번호를 입력해주세요" />
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer text-end">
				<button type="button" class="btn btn-outline-info" id="btnUpdateMemtelno">저장</button>
				<button type="button" class="btn btn-outline-default" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 회원 직업 수정 모달 -->
<div class="modal fade" id="changeJob" tabindex="-1" aria-labelledby="changeTel" aria-hidden="true">
	<div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
		<div class="modal-content min-height-300">
			<div class="modal-header">
            	<h5 class="modal-title" id="exampleModalLabel">직업</h5>
            </div>
			<div class="modal-body p-6">
				<div class="card card-plain">
					<div class="card-body pb-3">
						<form role="form text-start">
							<div class="input-group input-group-outline my-sm-4">
								<button type="button" class="form-control dropdown-toggle" id="btnMemJobGroup" data-bs-toggle="dropdown" aria-expanded="false">직군</button>
								<ul class="dropdown-menu" aria-labelledby="btnMemJobGroup" style="width: 100%; text-align: center;">
									<c:forEach items="${cmcdJob}" var="job">
										<li><button type="button" class="dropdown-item jobGroupList" data-cmcddtl="${job.cmcdDtl}">${job.cmcdDtlNm}</button></li>
									</c:forEach>
								</ul>
							</div>
							<div class="input-group input-group-outline my-sm-4">
								<button type="button" class="form-control dropdown-toggle" id="btnMemJob" data-bs-toggle="dropdown" aria-expanded="false">직업</button>
								<ul class="dropdown-menu" aria-labelledby="btnMemJob" id="ulMemJob" style="width: 100%; text-align: center;"></ul>
							</div>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer text-end">
				<button type="button" class="btn btn-outline-info" id="btnUpdateMemJob">저장</button>
				<button type="button" class="btn btn-outline-default" data-bs-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>