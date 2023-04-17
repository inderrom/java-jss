<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- sweetalert -->
<script src="/resources/js/sweetalert2.min.js"></script>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memVO" var="memVO"/>
</sec:authorize>


<!-- body 시작 -->
<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="card shadow-lg mb-5 blur">
			<div class="card-body p-5 ">
				<p id="general-terms" style="font-size: large;">
					<b id="textttt"></b>
				</p>

				<section class="pt-5 pb-0">
					<div class="container">
						<div class="row">
							<div class="col-md-6 mx-auto text-center mb-5">
								<h2>JAVA 멤버십</h2>
								<p class="lead">멤버십 구독 시 30일 동안 프리미엄 메뉴 무제한 이용 가능</p>
							</div>
						</div>
						<div class="row">
							<div class="card">
								<div class="row">
									<div class="col-lg-8">
										<div class="card-body">
											<h3 class="text-dark">JAVA만의 특별한 혜택</h3>
											<p class="font-weight-normal">'잡아줄게'에서 구직을 도와드려요</p>
											<div class="row mt-5 mb-2">
												<div class="col-lg-3 col-12">
													<h6 class="text-dark tet-uppercase">멤버십 주요 혜택</h6>
												</div>
												<div class="col-6">
													<hr class="horizontal dark">
												</div>
											</div>
											<div class="row">
												<div class="col-12 ps-0">
													<div class="d-flex align-items-center p-2">
														<i class="material-icons text-dark font-weight-bold">done</i>
														<span class="ps-2">유명 강사들의 취업강의</span>
													</div>
													<div class="d-flex align-items-center p-2">
														<i class="material-icons text-dark font-weight-bold">done</i>
														<span class="ps-2">취업 트렌드를 확인할 수 있는 특강</span>
													</div>
													<div class="d-flex align-items-center p-2">
														<i class="material-icons text-dark font-weight-bold">done</i>
														<span class="ps-2">유수기업에서 주관하는 인턴십 활동</span>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-4 my-auto">
										<div class="card-body text-center">
											<h6 class="mt-sm-4 mt-0 mb-0">30일 간 무제한 이용</h6>
											<h1 class="mt-0">
												<small>￦</small>4,900
											</h1>
											<form>
												<input type="hidden" value="${memId}" id="memId" name="memId" />
<%-- 												<input type="hidden" value="${vipNo }" id="vipNo" name="vipNo"/> --%>
												<button type="button"
													class="btn bg-gradient-danger btn-lg mt-2  subscribe">구독하기</button>
<!-- 											<p class="text-sm font-weight-normal">Get a free sample -->
<!-- 												(20MB)</p> -->
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>


		</div>
	</div>
</section>



<script type="text/javascript">

// let memId = $("#memId").val();
let nextVipNo = "${vipNo}";
let memId = "${memVO.memId}";
let memNm = "${memVO.memNm}";
let memTelno = "${memVO.memTelno}";
console.log("memId : ", memId, "nextVipNo", nextVipNo,  ", memNm : ", memNm);
console.log("memVO : ", "${memVO}");

//onclick="requestPay()"
$(function(){
	console.log("${principal}");
	//구독하기 버튼 클릭 시 로그인 여부에 따라 창 다르게 띄우기
	$(".subscribe").on("click", function(){
		if(memId == "" || memId == null){
			Swal.fire({
				 title: '로그인 후 이용해주세요',
                 icon: 'warning',
                 confirmButtonText: 'OK'
			}).then((result) => {
				if (result.isConfirmed) {
					location.href = "/login";
				}
			})

		} else {
			requestPay(memId);
		}
	})
})

let ranNum = Math.random().toString();
console.log("ranNum : " , ranNum);

var IMP = window.IMP; // 생략 가능
IMP.init("imp81404176"); // 예: 가맹점 식별코드

function requestPay(memId) {
    IMP.request_pay({
        pg : 'html5_inicis.INIpayTest',
        pay_method : 'card',
        merchant_uid: ranNum,
        name : 'JAVA 프리미엄 멤버십',
        amount : 4900,
        buyer_email : memId,
        buyer_name : memNm,
        buyer_tel : memTelno,
        }, function (rsp) { // callback
        if (rsp.success) {
            console.log(rsp);

            var data = {
            	"memId" : rsp.buyer_email,
//             	"vipNo" : rsp.merchant_uid   // 주문번호
            }
			console.log("성공 memId : " , memId);

            // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
            // jQuery로 HTTP 요청
            jQuery.ajax({
              url: "/premium/subscriptionPost",
              method: "POST",
              headers: { "Content-Type": "application/json" },
              data: JSON.stringify(data),
              beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); }
            }).done(function (data) {
				// 가맹점 서버 결제 API 성공시 로직
				Swal.fire({
	                 icon: 'success',
					 title: '결제가 완료되었습니다.',
	                 confirmButtonText: 'OK'
				}).then((result) => {
					if (result.isConfirmed) {
						location.replace("/premium/main");
					}
				})
				 return false;
            })
        } else {
            console.log(rsp);
            var msg = '';
            msg +=
            Swal.fire({
                icon: 'success',
				title: '결제에 실패하였습니다.\n 관리자에게 문의하세요.',
				text: '에러내용 : ' + rsp.error_msg,
                confirmButtonText: 'OK'
			})
        }
    });
}
</script>

