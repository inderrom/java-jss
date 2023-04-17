<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<c:set var="entVO"  value="${sessionScope.entMemVO }"/>

<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
$(function(){
	let input = document.getElementById("mySkill");
	

	$("#entSkillInsert").on("click", function(){
		let mySkills = $(".msskill");
		
		$.each(mySkills, function(i, v){
			let mySkillNm = document.createElement("input");
			mySkillNm.type = "hidden";
			mySkillNm.value = $(v).html();
			mySkillNm.name = "entSkillList[" + i + "].entSklNm";
			$("#skillFrm").append(mySkillNm);
			
			let mySkillNo = document.createElement("input");
			mySkillNo.type = "hidden";
			mySkillNo.value = $(v).data("cmcddtl");
			mySkillNo.name = "entSkillList[" + i + "].entSklNo";
			$("#skillFrm").append(mySkillNo);
		});
		
		$("#skillFrm").submit();
	});
	
	$(document).on("click",".msskill",function(){
		$(this).remove();
	});

	input.addEventListener("keyup", function (event) {
		let keyword = $("#mySkill").val().toUpperCase();
		if(keyword.trim() == ''){
			$("#mySkillul").empty();
			return false;
		}
		$.ajax({
			url: "/mem/getCommonCode",
			type: "post",
			data: {
				"clfc": "SKILL",
				"keyword": keyword
				},
			beforeSend : function(xhr) {   
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    },
		    success:function(commonCodeList){
		        console.log(commonCodeList);
		        code = "";
		        $.each(commonCodeList, function(i, v){
		        	code += "<div>";
		        	code += "<li class='dropdown-item searchSkillList' data-cmcddtl='" + v.cmcdDtl +"'>" + v.cmcdDtlNm +"</li>";
		        	code += "</div>";
		        });
		        $("#mySkillul").html(code);
		    }
		});
	});
	
	$(document).on("click", ".searchSkillList", function(){
		let cmcdDtl = $(this).data("cmcddtl");
		let cmcdDtlNm = $(this).html();
		$("#mySkilldiv").append('<button type="button" class="btn btn-block btn-outline-secondary mx-md-1 msskill" data-cmcddtl="' + cmcdDtl +'">' + cmcdDtlNm + '</button>');
		$("#mySkill").val("");
		$("#mySkillul").empty();
		$("#mySkill").focus();
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

	$("#entInfoInsert").on("click", function(){
		let telExp = /^010-\d{4}-\d{4}$/;
		let dateExp = /[0-9]{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/;
		$(".valueck").html("");
		
		if( regExp($("#entPicTelno").val(), telExp) ){
			console.log("연락처 틀림");
			$("#isTelOk").html("<p style='color:red;'>연락처 형식을 틀렸습니다.</p>");
			$("#corpMgTel").focus();
			return;
		}
		if( $("#entSlsAmt").val() == "" ){
			$("#slsCheck").html("<p style='color:red;'>매출액을 입력해주세요.</p>");
			return;
		}
		if( $("#entSector").val() == "" ){
			$("#setorCheck").html("<p style='color:red;'>산업분야를 입력해주세요.</p>");
			return;
		}
		if( $("#entEmpCnt").val() == "" ){
			$("#entCheck").html("<p style='color:red;'>직원수를 입력해주세요.</p>");
			return;
		}
		if( $("#entFndnDt").val() == "" ){
			$("#fndnCheck").html("<p style='color:red;'>설립연도를 입력해주세요.</p>");
			return;
		}
		
		$("#entSlsAmt").val($("#entSlsAmt").val().replaceAll(",", ""));
		$("#entEmpCnt").val($("#entEmpCnt").val().replaceAll(",", ""));
		
		$("#infoFrm").submit();
	});
	
	//이미지 미리보기 시작-------------------
	$("#entrprsimgs").on("change", handleRprsImgFileSelect1);
	function handleRprsImgFileSelect1(e){
		var files = e.target.files;
		var fileArr = Array.prototype.slice.call(files);
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				Swal.fire("이미지 확장자만 가능합니다.");
				return;
			}
			var reader = new FileReader();
			reader.onload = function(e){
				var img_html = "<img src=\"" + e.target.result + "\" style='width:40%;padding-bottom: 2%;' />";
				
				$("#entrprsimgs_wrap").append(img_html);
			}
			
			reader.readAsDataURL(f);
		});
	}
	//이미지 미리보기 끝-------------------
	
	//이미지 미리보기 시작-------------------
	$("#entlogoimgs").on("change", handleLogoImgFileSelect2);
	function handleLogoImgFileSelect2(e){
		var files = e.target.files;
		var fileArr = Array.prototype.slice.call(files);
		fileArr.forEach(function(f){
			if(!f.type.match("image.*")){
				Swal.fire("이미지 확장자만 가능합니다.");
				return;
			}
			var reader = new FileReader();
			reader.onload = function(e){
				var img_html = "<img src=\"" + e.target.result + "\" style='width:40%;padding-bottom: 2%;' />";
				
				$("#entlogoimgs_wrap").append(img_html);
			}
			
			reader.readAsDataURL(f);
		});
	}
	//이미지 미리보기 끝-------------------

});

function regExp(str, regExp){
	if(regExp.test(str)){
		return false;
	}else{
		return true;
	}
}

function inputNumberFormat(obj) {
	obj.value = comma(uncomma(obj.value));
}

function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
	str = String(str);
	return str.replace(/[^\d]+/g, '');
}
</script>

<style>
#cke_entDescription{ 
	width: 90%; 
}
label{
	width: 150px;
	font-size: unset;
	font-weight: bold;
}
.msskill{
	border-radius: 20px;
	font-size: 60%;
	width: auto;
	display: inline-block;
	vertical-align: bottom;
}
</style>

<div class="col-md-11 pt-sm-5 container-fluid kanban">
	<div class="card-body mt-6">
		<!-- Start Navbar -->
		<ul class="nav nav-pills nav-fill p-1" role="tablist">
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" href="#entInfo" role="tab" aria-controls="entInfo" aria-selected="true">
				<span class="material-icons align-middle mb-1">
					assignment_ind
				</span>
				정보
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#entSkill" role="tab" aria-controls="entSkill" aria-selected="false">
				<span class="material-icons align-middle mb-1">
					hub
				</span>
				기술스택
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#entImages" role="tab" aria-controls="entImages" aria-selected="false">
				<span class="material-icons align-middle mb-1">
					image
				</span>
				이미지
				</a>
			</li>
		</ul>
		<!-- End Navbar -->
		
	
		<div class="tab-content">
			<!-- 정보 등록 -->
			<div class="tab-pane active" id="entInfo">
				<div class="card d-flex justify-content-center p-4 shadow-lg">
					<div class="card-body" style="padding: 3%;">
						<form id="infoFrm" action="/enterprise/enterpriseUpdate" method="post" autocomplete="off">
							<input type="hidden" id="entNo" name="entNo" value="${entVO.ENT_NO}" readonly/>
							
							<div class="input-group input-group-outline my-3">
								<label for="entNm">기업명</label>
								<input type="text" id="entNm" name="entNm" class="form-control" value="${entVO.ENT_NM}" readonly/>
							</div>
							<p class="ps-9"><small>* 회사이름 및 웹사이트 주소는 직접 수정이 불가합니다. 수정이 필요하시면 관리자에게 문의해 주세요.</small></p>
							<div class="input-group input-group-outline my-3" style="flex-wrap: nowrap;">
								<label for="entDescription">기업 소개</label>
								<textarea id="entDescription" name="entDescription">${entVO.ENT_DESCRIPTION}</textarea>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="input-group input-group-outline my-3">
										<label for="entUrl">사이트 링크</label>
										<input type="text" id="entUrl" name="entUrl" placeholder="https://www.ddit.or.kr/"  class="form-control" value="${entVO.ENT_URL}" readonly/>
									</div>
									
									<div class="input-group input-group-outline my-3">
										<label for="btnZip">우편번호</label>
										<input type="text" id="entZip" name="entZip" class="form-control"  value="${entVO.ENT_ZIP}" readonly />
										<button type="button" id="btnZip" class="btn bg-gradient-info" style="margin: 1px;">검색</button>
									</div>
									
									<div class="input-group input-group-outline my-3">
										<label for="entAddr">주소</label>
										<input type="text" id="entAddr" name="entAddr" class="form-control"  value="${entVO.ENT_ADDR}" readonly/>
									</div>
									
									<div class="input-group input-group-outline my-3">
										<label for="entDaddr">상세주소</label>
										<input type="text" id="entDaddr" name="entDaddr" class="form-control" value="${entVO.ENT_DADDR}" />
									</div>
								</div>
								<div class="col-lg-6">
									<div class="input-group input-group-outline my-3">
										<label for="entSlsAmt">매출액</label>
										<input type="text" id="entSlsAmt" name="entSlsAmt" class="form-control" 
												value="<fmt:formatNumber value="${entVO.ENT_SLS_AMT}" pattern="#,###"/>" onkeyup="inputNumberFormat(this)" /><small style="margin: auto;">백만원</small>
									</div>
									<p class="ps-9"><small id="slsCheck" class="valueck"></small></p>
									
									<div class="input-group input-group-outline my-3">
										<label for="entSector">산업분야</label>
										<input type="text" id="entSector" name="entSector" class="form-control" value="${entVO.ENT_SECTOR}"  />
									</div>
									<p class="ps-9"><small id="setorCheck" class="valueck"></small></p>
									
									<div class="input-group input-group-outline my-3">
										<label for="entEmpCnt">직원수</label>
										<input type="text" id="entEmpCnt" name="entEmpCnt" class="form-control" 
												value="<fmt:formatNumber value="${entVO.ENT_EMP_CNT}" pattern="#,###"/>" onkeyup="inputNumberFormat(this)" /><small style="margin: auto;">명</small>
									</div>
									<p class="ps-9"><small id="entCheck" class="valueck"></small></p>
									
									<div class="input-group input-group-outline my-3">
										<label for="entFndnDt">설립연도</label>
										<input type="date" id="entFndnDt" name="entFndnDt" class="form-control" placeholder="2022-09-01" 
												value="<fmt:formatDate pattern='yyyy-MM-dd' value="${entVO.ENT_FNDN_DT}"/>" />
									</div>
									<p class="ps-9"><small id="fndnCheck" class="valueck"></small></p>
								</div>
							</div>
							<hr/>
							<div class="row">
								<div class="col-lg-6">
									<div class="input-group input-group-outline my-3">
										<label for="entPicNm">담당자 이름</label>
										<input type="text" id="entPicNm" name="entPicNm" class="form-control" value="${entVO.ENT_PIC_NM}" />
									</div>
									
									<div class="input-group input-group-outline my-3">
										<label for="entPicTelno">담당자 연락처</label>
										<input type="text" id="entPicTelno" name="entPicTelno" placeholder="010-0000-0000" class="form-control" value="${entVO.ENT_PIC_TELNO}" />
										<span id="isTelOk" class="valueck"></span>
									</div>
									
									<div class="input-group input-group-outline my-3">
										<label for="entPicJbgd">담당자 직급</label>
										<input type="text" id="entPicJbgd" name="entPicJbgd" class="form-control" value="${entVO.ENT_PIC_JBGD}" />
									</div>
								</div>
							</div>
							
							<button type="button" id="entInfoInsert" class="btn bg-gradient-info" style="float: right;">등록</button>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
			</div>
			<!-- 정보 등록 -->
			
			<!-- 스킬 등록 -->
			<div class="tab-pane" id="entSkill">
				<div class="card d-flex justify-content-center p-4 shadow-lg">
					<div class="card-body" style="padding: 3%;">
						<form id="skillFrm" action="/enterprise/entSkillUpdate" method="post" autocomplete="off">
							<input type="hidden" id="entNo" name="entNo" value="${entVO.ENT_NO}" readonly/>
							<div class="row mb-6">
								<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
									스킬
								</p>
								<div id="mySkilldiv">
									<c:forEach var="skillVO" items="${skillList }">
										<button type="button" class="btn btn-block btn-outline-secondary mx-md-1 msskill" data-cmcddtl="${skillVO.entSklNo }">${skillVO.entSklNm }</button>
									</c:forEach>
								</div>
							
								<input type="text" class="form-control p-4" id="mySkill" placeholder="원하시는 기술을 입력하세요." />
								<div class="col-12">
									<ul id="mySkillul" class="form-control dropdown-menu show" style="width: auto;"></ul>
								</div>
							</div>
							<button type="button" id="entSkillInsert" class="btn bg-gradient-info" style="float: right;">등록</button>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
			</div>
			<!-- 스킬 등록 -->
			
			<!-- 이미지 등록 -->
			<div class="tab-pane" id="entImages">
				<div class="card d-flex justify-content-center p-4 shadow-lg">
					<div class="card-body" style="padding: 3%;">
						<form role="form" id="imageFrm" action="/enterprise/fileUpload" method="post" enctype="multipart/form-data" >
							<input type="hidden" id="entNo" name="entNo" value="${entVO.ENT_NO}" />
							
							<div class="input-group mb-4 input-group-static">
								<label for="entrprsimgs">회사 대표 이미지</label>
								<img src="/resources/images${entVO.ENTPRSIMGS }" alt="회사 대표사진" style="width: 500px;" />
								<input type="file" id="entrprsimgs" name="entrprsimgs" class="form-control entimgs" required />
								<div id="entrprsimgs_wrap"></div>
							</div>
							
							<hr/>
							
							<div class="input-group mb-4 input-group-static">
								<label for="entlogoimgs">회사 로고 이미지</label>
								<img src="/resources/images${entVO.ENTLOGOIMGS }" alt="회사 로고사진" style="width: 500px;" />
								<input type="file" id="entlogoimgs" name="entlogoimgs" class="form-control entimgs" required />
								<div id="entlogoimgs_wrap"></div>
							</div>
							
							<button type="submit" id="entImgInsert" class="btn bg-gradient-info" style="float: right;">등록</button>
							<sec:csrfInput/>
						</form>
					</div>
				</div>
			</div>
			<!-- 이미지 등록 -->
			
		</div>
	</div>
</div>

<script type="text/javascript">
CKEDITOR.replace('entDescription');
</script>
