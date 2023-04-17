<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- html2canvas.js -->
<script src="/resources/js/html2canvas.js" type="text/javascript"></script>

<style>
button{
	width:100%;
	height:50%;
}

</style>

<form action="/mem/subscription" id="membershipFrm" name="enterpriseVO" method="post">
	<sec:csrfInput/>
	<input type="hidden" id="vipNo" name="vipVO.vipNo" value="${vipNo}">
	<input type="hidden" id="vipGrdNo" name="vipVO.vipGrdNo" value="${vipGrdNo}">
	<input type="hidden" id="memId" name="memId" value="${memId}" >

<section class="py-lg-7 pb-5">
	<div
		class="bg-gradient-dark position-relative m-3 border-radius-xl shadow-lg overflow-hidden"
		style="background-image: url('https://images.unsplash.com/photo-1467541473380-93479a5a3ffa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&amp;ixlib=rb-1.2.1&amp;auto=format&amp;fit=crop&amp;w=2246&amp;q=80'); background-size: cover;"
		loading="lazy">
		<span class="mask bg-gradient-dark opacity-6"></span>
		<div class="container pb-lg-9 pb-7 pt-7 position-relative z-index-1">
			<div class="row">
				<div class="col-md-8 mx-auto text-center">
					<h3 class="text-white">서비스 플랜</h3>
				</div>
			</div>
		</div>
	</div>
	<div class="mt-sm-n10 mt-n7">
      <div class="container">
        <div class="row mb-5">
          <div class="col-lg-4 col-md-6 col-7 mx-auto text-center">
          </div>
        </div>
        <div class="tab-content tab-space">

          <div class="tab-pane active" id="monthly" role="tabpanel" aria-labelledby="#tabs-iconpricing-tab-1">
            <div class="row">
              <div class="col-lg-4 mb-lg-0 mb-4">
                <div class="card shadow-lg">
                  <span class="badge rounded-pill bg-light text-dark w-30 mt-n2 mx-auto">Lite</span>
                  <div class="card-header text-center pt-4 pb-3">
                    <h1 id="liteAmount" class="font-weight-bold mt-2 amount" data-mount="500000" >
                      <small class="text-lg align-top me-1">￦</small>500,000<small class="text-lg">원</small>
                    </h1>
                    	<p>부가세 별도</p>
                  </div>
                  <div class="card-body text-lg-start text-center pt-0">
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">30일간 최대 30건의 이력서 열람 및 면접 제안</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">채용 수수료 무료</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">학력/경력 등 상세 이력 확인 </span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">30건 상세 이력서 열람 </span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">30회 면접 제안 보내기 가능</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">remove</i>
                      <span class="ps-3">* 유효기간 : 구매일로부터 30일</span>
                    </div>
                    	<button style="width:100%; height:50%;" type="button" class="btn btn-icon bg-gradient-dark d-lg-block mt-3 lg-0 subscribe"
                    	 data-title="선택하기" data-vipgrdno="VIPGRD0002" data-vipno="${vipNo}" data-memid="${memId}" >
	                    	선택하기
		                      <i class="fas fa-arrow-right ms-1" aria-hidden="true"></i>
                    	</button>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 mb-lg-0 mb-4">
                <div class="card bg-gradient-dark shadow-lg">
                  <span class="badge rounded-pill bg-primary w-30 mt-n2 mx-auto">Basic</span>
                  <div class="card-header text-center pt-4 pb-3 bg-transparent">
                    <h1 id ="basicAmount" class="font-weight-bold mt-2 text-white" data-mount="1000000">
                      <small class="text-lg align-top me-1">￦</small>1,000,000<small class="text-lg">원</small>
                    </h1>
                      <p class="text-white">부가세 별도</p>
                  </div>
                  <div class="card-body text-lg-start text-center pt-0">
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto text-white">done</i>
                      <span class="ps-3 text-white">30일간 최대 100건의 이력서 열람 및 면접 제안s</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto text-white">done</i>
                      <span class="ps-3 text-white">채용 수수료 무료 </span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto text-white">done</i>
                      <span class="ps-3 text-white">학력/경력 등 상세 이력 확인</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto text-white">done</i>
                      <span class="ps-3 text-white">100건 상세 이력서 열람</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto text-white">done</i>
                      <span class="ps-3 text-white">100회 면접 제안 보내기 가능</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto text-white">remove</i>
                      <span class="ps-3 text-white">*유효기간 : 구매일로부터 30일</span>
                    </div>
                    <button style="width:100%; height:50%;" type="button" class="btn btn-icon bg-gradient-primary d-lg-block mt-3 mb-0 subscribe"
                    	data-title="결제하기" data-vipGrdNo="VIPGRD0003" data-vipNo="${vipNo}" data-memId="${memId}">
                    	서비스 결제하기
	                      <i class="fas fa-arrow-right ms-1" aria-hidden="true"></i>
                    </button>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 mb-lg-0 mb-4">
                <div class="card shadow-lg">
                  <span class="badge rounded-pill bg-light text-dark w-30 mt-n2 mx-auto">Unlimited</span>
                  <div class="card-header text-center pt-4 pb-3">
                    <h2 class="font-weight-bold mt-2">
                      <small class="text-lg align-top me-1"></small>합격자 연봉의 7%<small class="text-lg"></small>
                    </h2>
                    <p>부가세 별도</p>
                  </div>
                  <div class="card-body text-lg-start text-center pt-0">
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">무제한 이력서 열람 및 면접 제안</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">합격자의 연봉 7%(최종합격 시)</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">학력/경력 등 상세 이력 확인</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">무제한 이력서 열람</span>
                    </div>
                    <div class="d-flex justify-content-lg-start justify-content-center p-2">
                      <i class="material-icons my-auto">done</i>
                      <span class="ps-3">무제한 제안 보내기 가능</span>
                    </div>
                    <button id="unlimitBtn" style="width:100%; height:50%;" type="button" class="btn btn-icon bg-gradient-dark d-lg-block mt-6 lg-0 subscribe"
                    data-vipGrdNo="VIPGRD0004" data-vipNo="${vipNo}" data-memId="${memId}" data-bs-toggle="modal" data-bs-target="#modalContract" >
                    	선택하기
                    	<i class="fas fa-arrow-right ms-1" aria-hidden="true"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>


   <!-- Modal -->
   <div class="modal fade" id="modalContract" tabindex="-1" aria-labelledby="modalContract" aria-hidden="true">
     <div class="modal-dialog modal-lg" role="document">
       <div class="modal-content">
         <div class="modal-body p-0">
           <div class="modal-content">
               <div class="modal-header">
               <div class="row" style="margin-left: 38%;">
	                 <h5 class="modal-title" id="exampleModalLongTitle">서비스 이용계약</h5>
	           </div>
	                 <div class="row">
		                 <button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal">
		                   <i class="fas fa-times"></i>
		                 </button>
	                  </div>
               </div>
               <div class="modal-body">
               	 <div class="row">
<!--                	  	<img alt="서비스이용계약" src="/resources/images/서비스이용계약.png"> -->
				   	<canvas id="canvasContract" style="width:790px; height:800px; border: 1px solid #993300;"></canvas>
               	 </div>
               </div>
               <div class="modal-footer">
                 <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">취소</button>
                 <button type="button" class="btn bg-gradient-primary" onclick="javascript:saveContract();">완료</button>
               </div>
             </div>
         </div>
       </div>
     </div>
   </div>

   <div class="modal fade" id="modalSignature" tabindex="-1" aria-labelledby="modalSignature" aria-hidden="true">
     <div class="modal-dialog" role="document">
       <div class="modal-content">
         <div class="modal-body p-0">
           <div class="modal-content">
               <div class="modal-header">
               <div class="row" style="margin-left: 38%;">
	                 <h5 class="modal-title" id="exampleModalLongTitle">서명</h5>
	           </div>
	                 <div class="row">
		                 <button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal">
		                   <i class="fas fa-times"></i>
		                 </button>
	                  </div>
               </div>
               <div class="modal-body">
               	 <div class="row" style="justify-content: center;">
               	 	<canvas id="canvasSignature" style="width:400px; height:400px; border: 1px solid #993300;"></canvas>
               	 </div>
               </div>
               <div class="modal-footer">
                 <button type="button" class="btn bg-gradient-secondary" onclick="javascript:resetCanvasSignature();">다시 쓰기</button>
                 <button type="button" class="btn bg-gradient-primary" onclick="javascript:saveSignature();">확인</button>
               </div>
             </div>
         </div>
       </div>
     </div>
   </div>

</form>
<div id="divContract" style="position: fixed;"></div>

<script type="text/javascript">

	let memId = $("#memId").val();

	let sub =  "";
	let selName = "";
	let selAmount = "";

 $(function(){
 	//구독하기 버튼 클릭 시 로그인 여부에 따라 창 다르게 띄우기
 	$(".subscribe").on("click", function(){
 		sub =  $(this).data("title");

 		var vipNo = $(this).data("vipno");
 		var vipGrdNo = $(this).data("vipgrdno");
 		var memId = $(this).data("memid");

 		$("#vipNo").val(vipNo);
 		$("#vipGrdNo").val(vipGrdNo);

	 	if(sub == "선택하기"){
	 		selName = 'JAVA 프리미엄 멤버십 Lite';
	 		selAmount = 100;
	    }else{
	    	selName = 'JAVA 프리미엄 멤버십 basic';
	 		selAmount = 100;
	    }

 		if(memId == 'anonymousUser'){
 			location.href = "/login";
 		} else {
 			//alert("ddd");
 			//$("#membershipFrm").submit();

 			// 무제한 멤버십일 경우 메일 전송하기
 			if ("VIPGRD0004" == vipGrdNo){

 			} else {
 				requestPay();

 			}
 		}
 	});


 });
	// 결제하기
 	let rand = Math.random().toString();

 	var IMP = window.IMP; // 생략 가능
 	IMP.init("imp81404176"); // 예: 가맹점 식별코드

     function requestPay() {
         IMP.request_pay({
             pg : 'html5_inicis.INIpayTest',
             pay_method : 'card',
             merchant_uid: rand,
             name : selName,
             amount : selAmount,
             buyer_email : '${memVO.memId}',
             buyer_name : '${memVO.memNm}',
             buyer_tel : '${memVO.memTelno}',
         }, function (rsp) { // callback
             if (rsp.success) {
                 console.log(rsp);
                 var msg = '';
                 Swal.fire({
          			  icon: 'success',
          			  title: '결제가 완료되었습니다.',
          			  showConfirmButton: false,
          			  timer: 1500
          			}).then(() => {
                        $("#membershipFrm").submit();
          		  });
          	 return false;
                 // 여기다가 폼 서브밋 해주자 ! 3개 !!
             } else {
                 console.log(rsp);
                 var msg = '결제에 실패하였습니다.';
                 msg += '에러내용 : ' + rsp.error_msg;
                 Swal.fire(msg);
             }
             return false;
         });
     }


</script>

<script>
	let membershipFrm = $("#membershipFrm");
	let page = getContract();
	let parser = new DOMParser();
	let doc = parser.parseFromString(page, 'text/html');
	let contract = doc.querySelector("#contractArea");
	console.log(contract);
	$("#divContract").append(contract);

	//
	let canvasContract = document.querySelector("#canvasContract");
	let canvasContractCtx = canvasContract.getContext("2d");
	canvasContract.width = 790;
	canvasContract.height = 800;

	html2canvas($("#divContract")[0]).then(function(canvas){
		let myImg = canvas.toDataURL();

		let img = new Image (); //이미지 객체 생성
		img.src = myImg ;
		img.onload = function () //이미지 로딩 완료시 실행되는 함수
		{
			canvasContractCtx.drawImage(img, 0, 0, 790, 800);
			canvasContractCtx.strokeRect(645, 685, 100, 50);
		}
	});

	//
	let canvasSignature = document.querySelector("#canvasSignature");
	let canvasSignatureCtx = canvasSignature.getContext("2d");

	canvasSignature.width = 400;
	canvasSignature.height = 400;

	canvasSignatureCtx.strokeStyle = "black";
	canvasSignatureCtx.lineWidth = 2.5;

	let painting = false;

	function startPainting() {
	 painting=true;
	}
	function stopPainting(event) {
	 painting=false;
	}

	function onMouseMove(event) {
	 const x = event.offsetX;
	 const y = event.offsetY;
	 if(!painting) {
	 	canvasSignatureCtx.beginPath();
	 	canvasSignatureCtx.moveTo(x, y);
	 }
	 else {
	 	canvasSignatureCtx.lineTo(x, y);
	 	canvasSignatureCtx.stroke();
	 }
	}

	if (canvasSignature) {
		canvasSignature.addEventListener("mousemove", onMouseMove);
		canvasSignature.addEventListener("mousedown", startPainting);
		canvasSignature.addEventListener("mouseup", stopPainting);
		canvasSignature.addEventListener("mouseleave", stopPainting);
	}

	function resetCanvasSignature(){
		canvasSignatureCtx.clearRect(0, 0, canvasSignature.width, canvasSignature.height);
	}

	function getContract(){
		let resule = "";
		$.ajax({
			type: "get",
	     url: "/mem/getContract",
	     async: false,     //값을 리턴시 해당코드를 추가하여 동기로 변경
	     dataType: "html",
	     success: function (data) {
	         result = data;
	     }
		});
		return result;
	}


	canvasContract.addEventListener("mousedown", clickCanvasContract);

	function clickCanvasContract(event){
		const x = event.offsetX;
		const y = event.offsetY;
		console.log(x, y);
		if((x >=645 && x <= 745) && (y >= 685 && y <= 735)){
		    $("#modalSignature").modal("show");
		}

	}

	function saveSignature(){
		let imgSignature = canvasSignature.toDataURL();
		let img = new Image();
		img.src = imgSignature;
		img.onload = function(){
			canvasContractCtx.drawImage(img, 645, 685, 100, 50);
		}
		$("#modalSignature").modal("hide");
		resetCanvasSignature();
	}

	function cancelContract(){
		$("#modalContract").modal("hide");
	}

	function saveContract(){
		let inputFile = document.createElement("input");
		inputFile.type = "file";
		inputFile.name = "unlimitMsContract";
		inputFile.style.display = "none";

		let dataTranster = new DataTransfer();
		let img = canvasContract.toDataURL();
		let fileContract = new File([img], "unlimitMsContract",{type:"image/jpeg", lastModified:new Date().getTime()}, 'utf-8');
// 		console.log(fileContract);
		dataTranster.items.add(fileContract);
// 		console.log(dataTranster.items);

		inputFile.files = dataTranster.files;
		console.log(inputFile.files);

		membershipFrm.append(inputFile);
		membershipFrm.prop("enctype", "multipart/form-data");
		membershipFrm.submit();
	}
</script>

