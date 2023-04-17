<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<style>
.text-dark{
    color: #808080b3;
}
ul{
	list-style: none;
}
p{
	margin: 0;
	padding: 0;
}
</style>

<section>
	<form id="frmResume" action="/mem/createResume" method="post">
		<input type="hidden" name="rsmNo" />
		<div class="container min-height-600">
			<div class="row align-items-center">
				<h3 id="rsmTitle" class="font-weight-bolder text-dark display-6">
				</h3>
			</div>
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					간단 소개글
				</p>
				<div id="aboutMe"></div>
			</div>
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					경력
				</p>
				
				<!-- 주요성과폼 -->
				<div class="row px-sm-4 my-sm-3 divSubArea" id="divAchievement" style="display:none;">
					<ul>
						<li>
							<p class="form-control col-lg-10" id="achTitle" style="display: inline-block;" ></p>
						</li>
						<li>
							<p class="form-control" id="achBgngDtYear"  style="display: inline-block;width: 30px;" ></p>&nbsp;&nbsp;/
							<p class="form-control" id="achBgngDtMonth" style="display: inline-block;width: 30px;" ></p>&nbsp;~&nbsp;
							<p class="form-control" id="achEndDtYear" style="display: inline-block;width: 30px;" ></p>&nbsp;&nbsp;/
							<p class="form-control" id="achEndDtMonth" style="display: inline-block;width: 30px;" ></p>
						</li>
						<li><p class="form-control" id="achContent" style="display: inline-block;"></p></li>
					</ul>
				</div>
				<!-- 경력폼 -->
				<div class="row px-sm-4 my-sm-3 divMainArea" id="divCareer" style="display:none;">
					<div class="col-lg-4">
						<div id="divCrrRtrmDt">
							<p class="form-control" id="crrJncmpDtYear" style="display: inline-block;width: 30px;"></p>&nbsp;&nbsp;/
							<p class="form-control" id="crrJncmpDtMonth" style="display: inline-block;width: 30px;"></p>&nbsp;~&nbsp;
							<p class="form-control" id="crrRtrmDtYear" style="display: inline-block;width: 30px;"></p><span id="dot">&nbsp;&nbsp;/</span>
							<p class="form-control" id="crrRtrmDtMonth" style="display: inline-block;width: 30px;"></p>
						</div>
						<br/>
						<div class="form-check" style="padding-left: 0px;">
							<p class="my-sm-3"><input type="checkbox" class="form-check-input" id="crrHdofYn" />&nbsp;현재 재직중</p>
						</div>
					</div>
					<div class="col-lg-8">
						<p class="my-md-3 crrEntNm" id="crrEntNm">회사명</p>
						<p class="form-control" id="crrJbgdNm" style="display: inline-block;"></p>
						<hr/>
						<div id="divAchievementArea"></div>
					</div>
				</div>
				<!-- 경력 부분 -->
				<div id="divCareerArea"></div>
			</div>
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					학력
				</p>
				<!-- 학력 폼 -->
				<div class="row px-sm-4 my-sm-3 divMainArea" id="divAcademic" style="display: none;">
					<div class="col-lg-4">
						<div id="divAcbgDt">
							<p class="form-control" id="acbgMtcltnDtYear" style="display: inline-block;width: 30px;" ></p>&nbsp;&nbsp;/
							<p class="form-control" id="acbgMtcltnDtMonth" style="display: inline-block;width: 30px;" ></p>&nbsp;~&nbsp;
							<p class="form-control" id="acbgGrdtnDtYear" style="display: inline-block;width: 30px;" ></p><span id="dot">&nbsp;&nbsp;/</span>
							<p class="form-control" id="acbgGrdtnDtMonth" style="display: inline-block;width: 30px;" ></p>
						</div>
						<br/>
						<div class="form-check" style="padding-left: 0px;">
							<p class="my-sm-3"><input type="checkbox" id="acbgAttndYn" class="form-check-input" />&nbsp;현재 재학중</p>
						</div>
					</div>
					<div class="col-lg-8">
						<p class="my-md-3 acbgUniversityNm" id="acbgUniversityNm">학교명</p>
						<p class="form-control" id="acbgMajor" style="display: inline-block;"></p>
						<p class="form-control" id="acbgDegree" style="display: inline-block;"></p>
						<p class="form-control" id="acbgDiscription" style="display: inline-block;" ></p>
					</div>
				</div>
				<!-- 학력 부분 -->
				<div id="divAcademicArea"></div>
			</div>
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					스킬
				</p>
				<!-- 스킬 부분 -->
				<div id="divMySkl"></div>
			</div>
			
			
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					수상 및 기타
				</p>
				<!-- 수상 및 기타폼 -->
				<div class="row px-sm-4 my-sm-3 divMainArea" id="divAwards" style="display: none;">
					<div class="col-lg-4">
						<p class="form-control" id="awrdDtYear" style="display: inline-block;width: 30px;"></p>&nbsp;/&nbsp;
						<p class="form-control" id="awrdDtMonth"  style="display: inline-block;width: 30px;"></p>
					</div>
					<div class="col-lg-8">
						<p class="form-control" id="awrdNm" style="display: inline-block;"></p>
						<p class="form-control" id="awrdInfo" style="display: inline-block;"></p>
					</div>
				</div>
				<!--  수상 및 기타 부분 -->
				<div id="divAwardsArea"></div>
			</div>
			
			
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					외국어
				</p>
				<!-- 어학시험폼 -->
				<div class="row px-sm-4 my-sm-3v divSubArea" id="divLanguageScore" style="display: none;">
					<ul>
						<li>
							<p class="form-control" id="lscoNm" style="display: inline-block;" ></p>
						</li>
						<li><p class="form-control" id="lscoScore" style="display: inline-block;" ></p></li>
						<li><input type="date" class="form-control" id="lscoAcqsDt" /></li>
					</ul>
				</div>
				
				<!-- 언어폼 -->
				<div class="row px-sm-4 my-sm-3 divMainArea" id="divLanguage" style="display: none;">
					<div class="col-lg-12">
						<div class="col-lg-1">
							<button type="button" class="form-control " id="btnLanguageNm" >언어</button>
						</div>
						<div class="col-lg-1">
							<button type="button" class="form-control " id="btnLanguageLevel">수준</button>
						</div>
					</div>
					<div id="divLanguageScoreArea"></div>
				</div>
				<!-- 언어 부분 -->
				<div id="divLanguageArea"></div>
			</div>
			
			
			
			<div class="row mb-3">
				<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
					링크
				</p>
				<div class="row px-sm-4 my-sm-3">
					<p class="form-control" id="rsmUrl" style="display: inline-block;"></p>
				</div>
			</div>
		</div>
		<sec:csrfInput/>
	</form>
</section>

<script>
// 이력서 정보 불러오기
var resumeVO = ${resumeVO};
console.log(resumeVO);

document.querySelectorAll("input").forEach(function(v){
	v.setAttribute( 'readonly', 'readonly' );
});

// 이력서 기본정보
$("#rsmTitle").html(resumeVO.rsmTitle);
$("input[name=rsmNo]").val(resumeVO.rsmNo);
var aboutMe = resumeVO.rsmAboutMe;
aboutMe = aboutMe.replaceAll("\n","<br>");
$("#aboutMe").html(aboutMe);
$("#rsmUrl").html(resumeVO.rsmUrl);

// 경력
if(resumeVO.careerVOList[0].crrNo != null){
	$.each(resumeVO.careerVOList, function(careerIndex, careerValue){
		let divCareer = $("#divCareer").clone();
		
		let crrJncmpDt = new Date(careerValue.crrJncmpDt);
		let crrJncmpDtYear = crrJncmpDt.getFullYear();
		let crrJncmpDtMonth = crrJncmpDt.getMonth() < 10 ? "0" + (crrJncmpDt.getMonth() + 1) : crrJncmpDt.getMonth() + 1;
		divCareer.find("#crrJncmpDtYear").html(crrJncmpDtYear);
		divCareer.find("#crrJncmpDtMonth").html(crrJncmpDtMonth);
		
		let crrRtrmDt = new Date(careerValue.crrRtrmDt);
		let crrRtrmDtYear = crrRtrmDt.getFullYear();
		let crrRtrmDtMonth = crrRtrmDt.getMonth() < 10 ? "0" + (crrRtrmDt.getMonth() + 1) : crrRtrmDt.getMonth() + 1;
		divCareer.find("#crrRtrmDtYear").html(crrRtrmDtYear);
		divCareer.find("#crrRtrmDtMonth").html(crrRtrmDtMonth);
		
		if(careerValue.crrHdofYn == "Y"){
			divCareer.find("#crrHdofYn").prop("checked", true);
		}
		
		divCareer.find("#crrEntNm").html(careerValue.crrEntNm);
		divCareer.find("#crrJbgdNm").html(careerValue.crrJbgdNm);
		
		// 주요성과
		if(careerValue.achievementVOList[0].achTitle != null){
			$.each(careerValue.achievementVOList, function(achIndex, achValue){
				let divAchievement = $("#divAchievement").clone();
				
				divAchievement.find("#achTitle").html(achValue.achTitle);
				
				let achBgngDt = new Date(achValue.achBgngDt);
				let achBgngDtYear = achBgngDt.getFullYear();
				let achBgngDtMonth = achBgngDt.getMonth() < 10 ? "0" + (achBgngDt.getMonth() + 1) : achBgngDt.getMonth() + 1;
				divAchievement.find("#achBgngDtYear").html(achBgngDtYear);
				divAchievement.find("#achBgngDtMonth").html(achBgngDtMonth);
				
				let achEndDt = new Date(achValue.achEndDt);
				let achEndDtYear = achEndDt.getFullYear();
				let achEndDtMonth = achEndDt.getMonth() < 10 ? "0" + (achEndDt.getMonth() + 1) : achEndDt.getMonth() + 1;
				divAchievement.find("#achEndDtYear").html(achEndDtYear);
				divAchievement.find("#achEndDtMonth").html(achEndDtMonth);
				
				divAchievement.find("#achContent").html(achValue.achContent);
				
				divAchievement.show();
				divCareer.find("#divAchievementArea").append(divAchievement);
			});
		}
		
		divCareer.show();
		$("#divCareerArea").append(divCareer);
	});
}


// 학력
if(resumeVO.academicList[0].acbgNo != null){
	$.each(resumeVO.academicList, function(acbgIndex, acbgValue){
		let divAcademic = $("#divAcademic").clone();
		
		let acbgMtcltnDt = new Date(acbgValue.acbgMtcltnDt);
		let acbgMtcltnDtYear = acbgMtcltnDt.getFullYear();
		let acbgMtcltnDtMonth = acbgMtcltnDt.getMonth() < 10 ? "0" + (acbgMtcltnDt.getMonth() + 1) : acbgMtcltnDt.getMonth() + 1;
		divAcademic.find("#acbgMtcltnDtYear").html(acbgMtcltnDtYear);
		divAcademic.find("#acbgMtcltnDtMonth").html(acbgMtcltnDtMonth);
		
		let acbgGrdtnDt = new Date(acbgValue.acbgGrdtnDt);
		let acbgGrdtnDtYear = acbgGrdtnDt.getFullYear();
		let acbgGrdtnDtMonth = acbgGrdtnDt.getMonth() < 10 ? "0" + (acbgGrdtnDt.getMonth() + 1) : acbgGrdtnDt.getMonth() + 1;
		divAcademic.find("#acbgGrdtnDtYear").html(acbgGrdtnDtYear);
		divAcademic.find("#acbgGrdtnDtMonth").html(acbgGrdtnDtMonth);
		
		if(acbgValue.acbgAttndYn == "Y"){
			divAcademic.find("#acbgAttndYn").prop("checked", true);
		}
		
		divAcademic.find("#acbgUniversityNm").html(acbgValue.acbgUniversityNm);
		divAcademic.find("#acbgMajor").html(acbgValue.acbgMajor);
		divAcademic.find("#acbgDegree").html(acbgValue.acbgDegree);
		divAcademic.find("#acbgDiscription").html(acbgValue.acbgDiscription);
		
		
		divAcademic.show();
		$("#divAcademicArea").append(divAcademic);
	});
}

// 스킬
$.each(resumeVO.mySkillList, function(mySkillIndex, mySkillValue){
	if(mySkillValue.mySklNo != null){
		$("#divMySkl").append('<button type="button" id="mySkill" class="btn btn-block btn-outline-secondary mx-md-1 btnMySkill" data-cmcddtl="' + mySkillValue.mySklNo +'">' + mySkillValue.mySklNm + '</button>');
	}
});

// 수상 및 기타
if(resumeVO.awardsVOList[0].awrdNo != null){
	$.each(resumeVO.awardsVOList, function(awardsIndex, awardsValue){
		let divAwards = $("#divAwards").clone();
		
		let awrdDt = new Date(awardsValue.awrdDt);
		let awrdDtYear = awrdDt.getFullYear();
		let awrdDtMonth = awrdDt.getMonth() < 10 ? "0" + (awrdDt.getMonth() + 1) : awrdDt.getMonth() + 1;
		divAwards.find("#awrdDtYear").html(awrdDtYear);
		divAwards.find("#awrdDtMonth").html(awrdDtMonth);
		
		divAwards.find("#awrdNm").html(awardsValue.awrdNm);
		divAwards.find("#awrdInfo").html(awardsValue.awrdInfo);
		
		divAwards.show();
		$("#divAwardsArea").append(divAwards);
	});
}

// 외국어
if(resumeVO.languageVOList[0].lanNo !=null){
	$.each(resumeVO.languageVOList, function(lanIndex, lanValue){
		let divLanguage = $("#divLanguage").clone();
		
		divLanguage.find("#btnLanguageNm").attr("cmcddtl", lanValue.lanNo);
		divLanguage.find("#btnLanguageNm").html(lanValue.lanNm);
		divLanguage.find("#btnLanguageLevel").html(lanValue.lanLevel);
		console.log("언어");
		// 어학시험
		if(lanValue.languageScoreVOList[0].lscoNm != null){
			console.log("어학");
			$.each(lanValue.languageScoreVOList, function(lanScoreIndex, lanScoreValue){
				let divLanguageScore = $("#divLanguageScore").clone();
				
				divLanguageScore.find("#lscoNm").html(lanScoreValue.lscoNm);
				divLanguageScore.find("#lscoScore").html(lanScoreValue.lscoScore);
				
				let lscoAcqsDt = new Date(lanScoreValue.lscoAcqsDt);
				let lscoAcqsDtYear = lscoAcqsDt.getFullYear();
				let lscoAcqsDtMonth = lscoAcqsDt.getMonth() < 10 ? "0" + (lscoAcqsDt.getMonth() + 1) : lscoAcqsDt.getMonth() + 1;
				let lscoAcqsDtDay = lscoAcqsDt.getDate() < 10 ? "0" + lscoAcqsDt.getDate() : lscoAcqsDt.getDate();
				divLanguageScore.find("#lscoAcqsDt").html(lscoAcqsDtYear + "-" + lscoAcqsDtMonth + "-" + lscoAcqsDtDay);
				console.log(divLanguageScore);
				divLanguageScore.show();
				divLanguage.find("#divLanguageScoreArea").append(divLanguageScore);
			});
		}
		
		divLanguage.show();
		$("#divLanguageArea").append(divLanguage);
	});
}
// 이력서 정보 불러오기 끝
</script>