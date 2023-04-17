<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<sec:authentication property="principal.memVO" var="memVO" />
<style>
.entInfo{
	width: 150px;
	font-size: larger;
	text-align: left;
	font-weight: bold;
}
</style>

<div id="firstStep" class="col-md-10 container-fluid kanban">
	<div class="card-body p-5">
		<div class="card card-row">
			<div class="card-header">
				<div class="row">
					<div class="col-lg-6">
						<h6><img src="/resources/images/looks_one.png" /> 계정확인</h6>
					</div>
					<div class="col-lg-6" style="text-align: right;">
						<img src="/resources/images/looks_two.png" />
					</div>
				</div>
			</div>
			<div class="card-body" style="padding: 3% 10% 5% 10%;text-align: center;">
				<div>
					<h3>기업 서비스 페이지입니다.</h3>
					<br/><br/>
					<h6 style="font-size:medium;">기업의 채용 업무를 위해 접속하셨다면 <br/>개인 계정이 아닌, 기업 이메일 계정으로 <br/>가입 혹은 로그인하기를 권장합니다.</h6>
					<br/><br/><br/>
					<div style="border: 1px solid #c2c2c2;padding: 10px;border-radius: 10px;">
						<img id="myprofile" src="/resources/images/icon/hand-print.png" alt="..." class="avatar avatar-l shadow border-radius-lg">
						<h6>${memVO.memId}</h6>
					</div>
				</div>
				<hr/>
				<div id="nextStep" class="row"  style="justify-content: center;">
					<h6>계속하기<i class="material-icons">arrow_forward</i></h6>
				</div>
			</div>
		</div>
	</div>
</div>

<div id="secondStep" class="col-md-10 container-fluid kanban" style="display: none;">
	<form id="frm" action="/enterprise/enterpriseJoin" method="post" enctype="multipart/form-data" autocomplete="off">
		<input type="hidden" id="memId" name="memId" value="${memVO.memId}" readonly/>
		<div class="card-body p-5">
			<div class="card card-row">
				<div class="card-header">
					<div class="row">
						<div class="col-lg-6">
							<h6><img src="/resources/images/looks_two.png" /> 정보등록</h6>
						</div>
					</div>
				</div>
				<div class="card-body" style="padding: 3% 10% 5% 10%;text-align: center;align-items: baseline;">
					<h3>기업 정보를 등록해주세요.</h3>
					<hr/>
					<div class="input-group input-group-outline my-3">
						<label class="entInfo" for="entNm">기업명</label>
						<input type="text" id="entNm" name="entNm" class="form-control" />
					</div>
					<hr/>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entUrl">사이트 주소</label>
								<input type="text" id="entUrl" name="entUrl" class="form-control"  />
							</div>
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="btnZip">우편번호</label>
								<input type="text" id="entZip" name="entZip" class="form-control"  readonly />
								<button type="button" id="btnZip" class="btn bg-gradient-info" style="margin: 1px;">검색</button>
							</div>
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entAddr">주소</label>
								<input type="text" id="entAddr" name="entAddr" class="form-control"  readonly/>
							</div>
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entDaddr">상세주소</label>
								<input type="text" id="entDaddr" name="entDaddr" class="form-control"  />
							</div>
						</div>
						<div class="col-lg-6">
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entSlsAmt">매출액</label>
								<input type="text" id="entSlsAmt" name="entSlsAmt" class="form-control"  />
							</div>
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entSector">산업분야</label>
								<input type="text" id="entSector" name="entSector" class="form-control"  />
							</div>
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entEmpCnt">직원수</label>
								<input type="text" id="entEmpCnt" name="entEmpCnt" class="form-control"  />
							</div>
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entFndnDt">설립연도</label>
								<input type="date" id="entFndnDt" name="entFndnDt" class="form-control"  />
							</div>
							<hr/>
						</div>
					</div>
					<hr/>
					<div class="row">
						<div class="col-lg-6">
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entPicNm">담당자 이름</label>
								<input type="text" id="entPicNm" name="entPicNm" class="form-control" />
							</div>
							
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entPicTelno">담당자 연락처</label>
								<input type="text" id="entPicTelno" name="entPicTelno" placeholder="010-0000-0000" class="form-control" />
								<span id="isTelOk"></span>
							</div>
							
							<div class="input-group input-group-outline my-3">
								<label class="entInfo" for="entPicJbgd">담당자 직급</label>
								<input type="text" id="entPicJbgd" name="entPicJbgd" class="form-control" />
							</div>
						</div>
					</div>
					<hr/>
					<div class="input-group mb-4 input-group-static">
						<label class="entInfo" for="entCertificate">사업자등록증명원</label>
						<input type="file" id="entCertificate" name="entCertificate" class="form-control">
					</div>
					<div class="row"  style="justify-content: center;">
						<button type="submit" class="btn bg-gradient-info">등록하기</button>
					</div>
				</div>
			</div>
		</div>
	<sec:csrfInput/>
	</form>
</div>


<script type="text/javascript">
$(function() {
	let jsmemId = "${memVO.memId}";

	$.ajax({
		url : "/mem/memSearch",
		data : {
			"memId" : jsmemId
		},
		type : "post",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			console.log(result);
			$(".myprofile").attr("src", "/resources/images" + result.attNm);
		}
	});
	
	$("#nextStep").on("click", function(){
		$(".kanban").show();
		$(this).closest(".kanban").hide();
	});
	
	$("#btnZip").on("click", function(){
		new daum.Postcode({
			oncomplete:function(data){
				$("#entZip").val(data.zonecode);
				$("#entAddr").val(data.address);
				$("#entDaddr").val(data.buildingName);
			}
		}).open();
	});

});
</script>