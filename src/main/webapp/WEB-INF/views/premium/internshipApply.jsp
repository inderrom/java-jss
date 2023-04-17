<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- sweetalert -->
<script src="/resources/js/sweetalert2.min.js"></script>


<div class="page-header"></div>

<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container py-5">
		<div class="card" style="height: auto; min-height: 800px; background-color: rgb(255 244 244 / 60%) !important;">
			<div class="row">
				<div class="col-md-6 p-8">
					<div class="title_font">
						<img class="logoSize" src="/resources/images/icon/hand-print.png"
							alt="java"> java줄게
					</div>
					<div class="col-me-3">
						<hr style="background-color: black; width: 300px;" />
					</div>
					<div>
						<h2>${data.prmmTitle }</h2>
						<a data-bs-toggle="modal" href="#checkModal">
							이벤트 정보 상세보기 <i class="fas fa-arrow-right text-sm ms-1" aria-hidden="true"></i>
						</a>
					</div>
				</div>
				<div class="col-md-6 pe-10 pt-7">
					<div class="card card-body col-md-12">
						<h3 class="text-center">개인정보 확인</h3>
						<form id="form">
							<div class="card-body">
								<div class="row">
									<div class="mb-4">
										<div class="input-group input-group-static mb-4">
											<label>계정</label> <input class="form-control" type="text"
												name="memId" id="memId"
												value="<sec:authentication property="principal.memVO.memId"/>"
												readonly="readonly">
										</div>
									</div>
									<div class="mb-4">
										<div class="input-group input-group-static mb-4">
											<label>이름</label> <input type="text" class="form-control"
												name="memNm" id="memNm"
												value="<sec:authentication property="principal.memVO.memNm"/>"
												readonly="readonly">
										</div>
									</div>
									<div class="mb-4">
										<div class="input-group input-group-static mb-4">
											<label>전화번호</label> <input type="texts" class="form-control"
												name="memTelno" id="memTelno"
												value="<sec:authentication property="principal.memVO.memTelno"/>"
												readonly="readonly" />
										</div>
									</div>
								</div>
								<div class="row">
									<!--                 <div class="col-md-12"> -->
									<!--                   <div class="form-check form-switch d-flex align-items-center mb-4"> -->
									<label class="form-check-label ms-3 mb-0"> 프리미엄 이벤트 정보가
										발송됩니다.<br /> 개인정보가 다른 경우 프로필에서 수정해주세요.<br /> <a
										href="/mem/myProfile" class="text-dark"> <u>프로필 수정하기</u>
									</a>
									</label>
									<!--                   </div> -->
									<!--                 </div> -->
									<br />
									<div class="col-md-12">
										<input type="hidden" name="prmmNo" id="prmmNo"
											value="${data.prmmNo }" /> <input type="hidden" name="itnsNo"
											id="itnsNo" value="${data.internshipList[0].itnsNo }" />
										<br/>
										<button type="button" class="btn btn-info w-100" id="btnApply">
											참가 신청하기</button>
									</div>
								</div>
							</div>
							<sec:csrfInput />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- ================================================================ -->
<!-- ================================================================ -->
<!-- Modal -->
<div class="modal fade" id="checkModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-body" style="text-align: center;">
				<div>
					<img src="" alt="!" /> <br />
					<h5>
						참가 신청이 취소됩니다.<br /> 계속 진행하겠습니까?
					</h5>
				</div>
				<br />
				<button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-info"
					onclick="location.replace('/premium/premiumDetail?prmmNo=${data.prmmNo}')">확인</button>
			</div>
		</div>
	</div>
</div>

<!-- ================================================================ -->



<script type="text/javascript">
//참가 신청하기 버튼(btnApply) 클릭시 ajax로 신청 처리 => 알림 띄우기
$(function(){
	let etpId = $("#prmmNo").val();
	let form = $("#form");			//JSON.stringify($("#form").serializeObject())
	console.log("prmmNo(etpId) : " + etpId);
	let itnsNo = $("#itnsNo").val();
	let memId = $("#memId").val();

	let data = {"itnsNo": itnsNo, "memId": memId};
	//신청하기 클릭시
	$("#btnApply").on("click", function(){

		//인턴십 참가자(internship_entryant) 테이블에 기록 추가
		$.ajax({
			url:'/premium/internshipApplyPost',
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			dataType:'json',
			type:'post',
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log("result:" + result);
// 				alert("ajax성공");
				if(result > 0) {
					Swal.fire({
						  icon: 'success',
						  text: '',
						  title: '인턴십 참가 신청완료!',
						  text: '',
						  closeOnClickOutside :false
					}).then((result) => {
							location.replace("/premium/premiumDetail?prmmNo=${data.prmmNo}");
// 							location.href="/premium/premiumDetail?prmmNo=${data.prmmNo}";
					})
				} else {
					Swal.fire("참가 신청에 실패했습니다.")
				}
			},
			error:function(err){
				console.log("err:" + err);
			}
		});
	})
})


//페이징 용...
// $.fn.serializeObject = function()
// {
//    var o = {};
//    var a = this.serializeArray();
//    $.each(a, function() {
//        if (o[this.name]) {
//            if (!o[this.name].push) {
//                o[this.name] = [o[this.name]];
//            }
//            o[this.name].push(this.value || '');
//        } else {
//            o[this.name] = this.value || '';
//        }
//    });
//    return o;
// };

</script>





