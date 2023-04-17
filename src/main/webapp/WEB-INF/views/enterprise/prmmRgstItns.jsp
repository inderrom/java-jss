<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<!-- ckEditor -->
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/materialKet2/js/plugins/flatpickr.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<style>
#cke_prmmContent {
	width: 90%;
}

label {
	width: 150px;
	font-size: unset;
}

input {
	width: 300px;
}

.msskill {
	border-radius: 20px;
	font-size: 60%;
	width: auto;
	display: inline-block;
	vertical-align: bottom;
}
</style>

<script type="text/javascript">

$(function(){
	//이미지 미리보기 시작-------------------
	$("#uploadFileImage").on("change", handleRprsImgFileSelect);
	function handleRprsImgFileSelect(e){
		let files = e.target.files;
		let fileArr = Array.prototype.slice.call(files);
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				Swal.fire("이미지 확장자만 가능합니다.");
				return;
			}
			let reader = new FileReader();
			reader.onload = function(e){
				let img_html = "<img src=\"" + e.target.result + "\" style='width:40%;padding-bottom: 2%;' />";

				$("#uploadFileImage_wrap").append(img_html);
			}

			reader.readAsDataURL(f);
		});
	}
	//이미지 미리보기 끝-------------------
})
</script>

<div class="col-md-11 pt-sm-5 pb-sm-7 container-fluid kanban">
	<div class="tab-content mt-5">
		<!-- 정보 등록 -->
		<div class="tab-pane active" id="entInfo">
			<div class="card d-flex justify-content-center p-4 shadow-lg">
				<div class="ms-5 mt-3">인턴십 등록
					<button type="button" class="btn btn-primary" style="float:right;" onclick="insertInput()">데이터 넣기</button>
				</div>
				<div class="card-body" style="padding: 3%;">
					<form id="infoFrm" action="/enterprise/prmmRgstItnsPost"
						method="post" enctype="multipart/form-data" autocomplete="off">
						<input type="hidden" id="entNo" name="entNo" value="${param.entNo }" readonly />
						<input type="hidden" id="prmmNo" name="prmmNo" value="${prmmNo }" readonly />

						<div class="input-group input-group-outline my-3">
							<label for="prmmTitle">인턴십 제목</label>
							<input type="text"
								id="prmmTitle" name="prmmTitle" class="form-control nullchk" value=""  required="required"/>
						</div>

						<div class="row">
							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsEntrtNope">모집 인원</label>
									<input type="text" id="itnsEntrtNope" name="itnsEntrtNope"
										class="form-control nullchk" value=""
										placeholder="숫자만 입력 가능" oninput="onlyNumber(this)" required/>
								</div>
							</div>

							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsCondition">참여 조건</label> <input type="text"
										id="itnsCondition" name="itnsCondition" class="form-control nullchk"
										value="" required/>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsBgngDt">시작 날짜</label>
									<input type="date"
										id="itnsBgngDt" name="itnsBgngDt" class="form-control nullchk"
										value="" required/>
								</div>
							</div>

							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsEndDt">종료 날짜</label> <input type="date"
										id="itnsEndDt" name="itnsEndDt" class="form-control nullchk" value="" required/>
								</div>
							</div>
						</div>
						<p>
							<label for=""></label>
							<small>
							인턴십 시작날짜는 오늘로부터 7일후부터 가능합니다.
							</small><br/>
							<label for=""></label>
							<small>
							인턴십 모집 기간은 인턴십 시작일로부터 7일전부터 3일전까지입니다.
							</small>
						</p>

						<div class="row">
							<div class="input-group input-group-outline my-3"
								style="flex-wrap: nowrap;">
								<label for="prmmContent">상세 설명</label>
								<textarea id="prmmContent" name="prmmContent" class="form-control "
									style="visibility: hidden; display: none;" required="required"></textarea>
							</div>
						</div>


						<div class="row" id="uploadFileImage_wrap">
							<div class="" style="width:150px;">
								<label for=""></label>
							</div>
							<div id="uploadFileImage_wrap"></div>
						</div>

						<div class="row">
							<div class="input-group input-group-outline my-3"
								style="flex-wrap: nowrap;">
								<label for="">상세 이미지</label>
								<input type="file" id="uploadFileImage" name="uploadFileImage" class="form-control"
										accept="image/gif, image/jpeg, image/png"/>
							</div>
						</div>
						<p>
							<label for=""></label>
							<small>
							상세화면에서 보여줄 이미지 파일을 올려주세요
							</small><br/>
						</p>

<!-- 						<div class="row"> -->
<!-- 							<div class="input-group input-group-outline my-3" -->
<!-- 								style="flex-wrap: nowrap;"> -->
<!-- 								<label for="">첨부 파일</label>  -->
<!-- 								<input type="file" id="uploadFileAll" name="uploadFileAll" class="form-control"/> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<p> -->
<!-- 							<label for=""></label> -->
<!-- 							<small> -->
<!-- 							이미지 파일을 제외한 나머지 형식의 파일을 올려주세요 -->
<!-- 							</small><br/> -->
<!-- 						</p> -->
<!-- 						<hr /> -->

						<button type="button" id="itnsInsertBtn"
							class="btn bg-gradient-info" style="float: right;">등록</button>
						<sec:csrfInput />
					</form>
				</div>
			</div>
		</div>

	</div>
</div>


<script type="text/javascript">
	CKEDITOR.replace('prmmContent');

	////////////////
	//숫자만 입력
	function onlyNumber(obj) {
	  obj.value = obj.value.replace(/[^0-9]/g, "");
	}

	////////////////////////////////////////
	//날짜 제한
	let date = new Date();
	date.setDate(date.getDate() + 7);	//시작, 종료 다 오늘 날짜에서 7일 후부터 선택 가능
	let dateString = date.toISOString();
	let dateAfterSeven = dateString.slice(0,10)
	console.log(dateString, "/", dateAfterSeven)

	let itnsBgngDt = document.getElementById("itnsBgngDt");
	let itnsEndDt = document.getElementById("itnsEndDt");

	itnsBgngDt.setAttribute("min", dateAfterSeven);
	itnsEndDt.setAttribute("min", dateAfterSeven);


	///////////////////////////////////////
	//모든 내용을 입력해야 등록 가능하도록


	function submitForm(){
		var NCcontents = document.getElementsByClassName("nullchk");
		console.log("NCcontents : " , NCcontents);

		for(var i = 0;  i < NCcontents.length; i++){
			console.log(NCcontents[i].value);
			if(NCcontents[i].value == ''){
				Swal.fire("빈 칸을 입력하세요.");
				return false;
			}
		}

		let cont = CKEDITOR.instances.prmmContent.getData();
		console.log("cont : ", cont);
		if(cont == '' || cont == null){
			Swal.fire("빈 칸을 입력하세요.");
			return false;
		}
		document.getElementById('infoFrm').submit();
	}
	let submitBtn = document.getElementById("itnsInsertBtn");
// 	submitBtn.onclick = function(){submitForm()};
	submitBtn.addEventListener('click', submitForm);


	function insertInput(){
		$("#prmmTitle").val("[DS부분 S.LSI사업부] 소프트웨어직 2023년 대학생 인턴 모집");
		$("#itnsEntrtNope").val("100");
		$("#itnsCondition").val("2023년 12월 ~ 2024년 8월 졸업 예정인 재학생(석사 제외)");
		$("#itnsBgngDt").val("2023-07-03");
		$("#itnsEndDt").val("2023-08-31");
		CKEDITOR.instances.prmmContent.setData("<h3>직무정보</h3><strong>수행업무</strong><br/>클라우드 서비스 설계/개발<br/>- 비즈니스 솔루션 정의 및 설계/개발<br/>- 아키텍쳐 전략 수립 및 어플리케이션/솔루션 구축<br/><strong>지원자격</strong><br/>2023년 12월 ~ 2024년 8월 졸업 예정인 재학생(석사 제외) 대상<br/>모집 전공: 이공계 全전공<br/>영어회화 최소등급 : IL(OPic) 또는 Level5 또는 110점 이상(토익스피킹)");
	}
</script>




${data }



