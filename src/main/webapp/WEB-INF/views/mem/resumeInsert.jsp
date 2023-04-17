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
	margin-left: -25px;
}
</style>

<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container">
			<div class="container p-5 blur border-radius-lg" style="height: auto; min-height: 300px;background-color: rgb(255 244 244 / 60%) !important;">
				<div class="row">
					<div class="col-lg-12">
						<div class="card shadow-lg mb-5">
							<div class="card-body p-8">
								<section>
									<form id="frmResume" action="/mem/createResume" method="post">
										<input type="hidden" name="rsmNo" value="${resumeVO.rsmNo}"/>
										<div class="container min-height-600">
											<div class="row align-items-center">
												<div class="mb-md-7">
													<h3 class="font-weight-bolder text-dark display-6">
														<input name="rsmTitle" class="form-control" type="text" value="${resumeVO.rsmTitle}" style="font-size:50px;"/>
													</h3>
												</div>
											</div>
											<hr/>
											<ul class="mt-md-5 mb-md-3" style="list-style: none;">
												<li class="my-md-5" style="font-size: large"><b>${memVO.memNm}</b></li>
												<li class="my-md-2" style="font-size: smaller">${memVO.memId}</li>
												<li class="my-md-2" style="font-size: smaller">${memVO.memTelno}</li>
											</ul>
											
											<div class="row mb-6">
												<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													간단 소개글
												</h5>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
														• 본인의 업무 경험을 기반으로 핵심역량과 업무 스킬을 간단히 작성해주세요. <br/>
														• 3~5줄로 요약하여 작성하는 것을 추천합니다!
														</h5>
													</blockquote>
												</div>
												<input type="text" class="form-control px-sm-4" name="rsmAboutMe" placeholder="간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요! (권장 3-5줄)" />
											</div>
											
											
											
											<div class="row mb-6">
												<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													경력
													<button id="btnAddCareer" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
												</p>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
															• 담당하신 업무 중 우선순위가 높은 업무를 선별하여 최신순으로 작성해주세요. <br/>
															• 신입의 경우, 직무와 관련된 대외활동, 인턴, 계약직 경력 등이 있다면 작성해주세요. <br/>
															• 업무 또는 활동 시 담당했던 역할과 과정, 성과에 대해 자세히 작성해주세요. <br/>
															• 업무 성과는 되도록 구체적인 숫자 혹은 [%]로 표현해주세요!<br/>
															• 커리어 조회 후 기업명이 실제와 다른 경우, 부서명/직책 란에 원하시는 기업명을 작성해주세요.
														</h5>
													</blockquote>
												</div>
												
												<!-- 주요성과폼 -->
												<div class="row px-sm-4 my-sm-5 divSubArea" id="divAchievement" style="display:none;">
													<ul>
														<li>
															<div class="col-lg-1 text-end"  style="float: right;">
																<button type="button" class="form-control col-lg-1 btnSubDelete">
																	<i class="material-icons" style="color: #808080b3;">clear</i>
																</button>
															</div>
															<input type="text" class="form-control col-lg-10" id="achTitle" placeholder="• 주요 성과" style="display: inline-block;"/>
														</li>
														<li>
															<input type="text" class="form-control" id="achBgngDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" pattern='yyyy'/>" />.
															<input type="text" class="form-control" id="achBgngDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" pattern='MM'/>" />&nbsp;-&nbsp;
															<input type="text" class="form-control" id="achEndDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" pattern='yyyy'/>" />.
															<input type="text" class="form-control" id="achEndDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" pattern='MM'/>" />
														</li>
														<li><input type="text" class="form-control" id="achContent" placeholder="상세 업무 내용과 성과를 입력해주세요" style="display: inline-block;" value="${achievement.achContent}" /></li>
													</ul>
												</div>
												<!-- 경력폼 -->
												<div class="row px-sm-4 my-sm-5 divMainArea" id="divCareer" style="display:none;">
													<div class="col-lg-4">
														<input type="text" class="form-control" id="crrJncmpDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;"/>.
														<input type="text" class="form-control" id="crrJncmpDtMonth" placeholder="MM" style="display: inline-block;width: 30px;"/>&nbsp;-&nbsp;
														<input type="text" class="form-control" id="crrRtrmDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;"/>.
														<input type="text" class="form-control" id="crrRtrmDtMonth" placeholder="MM" style="display: inline-block;width: 30px;"/>
														<br/>
														<div class="form-check" style="padding-left: 0px;">
															<p class="my-sm-3"><input type="checkbox" class="form-check-input" id="crrHdofYn"/>&nbsp;현재 재직중</p>
														</div>
													</div>
													<div class="col-lg-8">
														<div class="col-lg-1 text-end"  style="float: right;">
															<button type="button" class="form-control btnMainDelete">
																<i class="material-icons" style="color: #808080b3;">clear</i>
															</button>
														</div>
														<p class="my-md-3 crrEntNm" id="crrEntNm">회사명</p>
														<input type="text" class="form-control" id="crrJbgdNm" placeholder="부서명/직책" style="display: inline-block;"/>
														<hr/><hr/>
														
														<div class="col-lg-4" style="float: right;">
															<button class="form-control btn btn-default btnAddAchievement" type="button" style="color:blue;"><b><i class="material-icons" style="vertical-align: bottom; color:blue;">add</i>주요성과 추가</b></button>
														</div>
														<div id="divAchievementArea"></div>
													</div>
												</div>
												<!-- 경력 부분 -->
												<div id="divCareerArea"></div>
											</div>
											
											<div class="row mb-6">
												<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													학력
													<button id="btnAddAcbg" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
												</p>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
															• 최신순으로 작성해주세요.
														</h5>
													</blockquote>
												</div>
												<!-- 학력 폼 -->
												<div class="row px-sm-4 my-sm-5 divMainArea" id="divAcademic" style="display: none;">
													<div class="col-lg-4">
														<input type="text" class="form-control" id="acbgMtcltnDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" />.
														<input type="text" class="form-control" id="acbgMtcltnDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" />&nbsp;-&nbsp;
														<input type="text" class="form-control" id="acbgGrdtnDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" />.
														<input type="text" class="form-control" id="acbgGrdtnDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" />
														<br/>
														<div class="form-check" style="padding-left: 0px;">
															<p class="my-sm-3"><input type="checkbox" id="acbgAttndYn" class="form-check-input" />&nbsp;현재 재학중</p>
														</div>
													</div>
													<div class="col-lg-8">
														<div class="col-lg-1 text-end"  style="float: right;">
															<button type="button" class="form-control btnMainDelete">
																<i class="material-icons" style="color: #808080b3;">clear</i>
															</button>
														</div>
														<p class="my-md-3 acbgUniversityNm" id="acbgUniversityNm">학교명</p>
														<input type="text" class="form-control" id="acbgMajor" placeholder="전공" style="display: inline-block;"/>
														<input type="text" class="form-control" id="acbgDegree" placeholder="학위" style="display: inline-block;"/>
														<input type="text" class="form-control" id="acbgDiscription" placeholder="이수과목 및 연구내용" style="display: inline-block;" />
													</div>
												</div>
												<!-- 학력 부분 -->
												<div id="divAcademicArea"></div>
											</div>
											
											<div class="row mb-6">
												<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													스킬
												</p>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
															• 개발 스택, 디자인 툴, 마케팅 툴 등 가지고 있는 직무와 관련된 스킬을 추가해보세요.<br/>
															• 데이터 분석 툴이나 협업 툴 등의 사용해본 경험이 있으신 툴들도 추가해보세요.<br/>
															• 스킬을 등록한 원티드 이력서는 일반 이력서에 비해 서류통과율이 더 높습니다!
														</h5>
													</blockquote>
												</div>
												<!-- 스킬 부분 -->
												<div id="divMySkl"></div>
												<input type="text" class="form-control" id="searchSkill" placeholder="보유 스킬을 입력하세요." />
												<div class="col-12">
													<ul id="searchSkillDropdown" class="form-control dropdown-menu" style="width: auto;"></ul>
												</div>
											</div>
											
											
											
											<div class="row mb-6">
												<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													수상 및 기타
													<button id="btnAddAwards" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
												</p>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
															• 수상 이력, 직무 관련 자격증, 수료한 교육이나 참석한 외부활동 등이 있다면 간략히 작성해주세요.<br/>
															• 지원하는 회사에서 요구하는 경우가 아니라면 운전면허증과 같은 자격증은 생략하는 것이 좋습니다!
														</h5>
													</blockquote>
												</div>
												<!-- 수상 및 기타폼 -->
												<div class="row px-sm-4 my-sm-5 divMainArea" id="divAwards" style="display: none;">
													<div class="col-lg-4">
														<input type="text" class="form-control" id="awrdDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;"/>.
														<input type="text" class="form-control" id="awrdDtMonth" placeholder="MM" style="display: inline-block;width: 30px;"/>
													</div>
													<div class="col-lg-8">
														<div class="col-lg-1 text-end"  style="float: right;">
															<button type="button" class="form-control btnMainDelete">
																<i class="material-icons" style="color: #808080b3;">clear</i>
															</button>
														</div>
														<input type="text" class="form-control" id="awrdNm" placeholder="활동명" style="display: inline-block;"/>
														<input type="text" class="form-control" id="awrdInfo" placeholder="세부사항" style="display: inline-block;"/>
													</div>
												</div>
												<!--  수상 및 기타 부분 -->
												<div id="divAwardsArea"></div>
											</div>
											
											
											
											<div class="row mb-6">
												<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													외국어
													<button id="btnAddLanguage" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
												</p>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
															• 외국어 자격증을 보유한 경우 작성해주세요. <br/>
															• 활용 가능한 외국어가 있다면, 어느정도 수준인지 레벨을 선택해주세요.
														</h5>
													</blockquote>
												</div>
												<!-- 어학시험폼 -->
												<div class="row px-sm-4 my-sm-5v divSubArea" id="divLanguageScore" style="display: none;">
													<ul>
														<li>
															<div class="col-lg-1 text-end"  style="float: right;">
																<button type="button" class="form-control btnSubDelete">
																	<i class="material-icons" style="color: #808080b3;">clear</i>
																</button>
															</div>
															<input type="text" class="form-control" id="lscoNm" placeholder="시험명" style="display: inline-block;" />
														</li>
														<li><input type="text" class="form-control" id="lscoScore" placeholder="점수/급" style="display: inline-block;" /></li>
														<li><input type="text" class="form-control" id="lscoAcqsDt" placeholder="YYYY-MM-DD" style="display: inline-block;" /></li>
													</ul>
												</div>
												
												<!-- 언어폼 -->
												<div class="row px-sm-4 my-sm-5 divMainArea" id="divLanguage" style="display: none;">
													<div class="col-lg-12">
														<div class="col-lg-1 text-end"  style="float: right;">
															<button type="button" class="form-control btnMainDelete">
																<i class="material-icons" style="color: #808080b3;">clear</i>
															</button>
														</div>
														<div class="col-lg-1">
															<button type="button" class="form-control dropdown-toggle" id="btnLanguageNm" data-bs-toggle="dropdown" aria-expanded="false">언어</button>
															<ul class="dropdown-menu" aria-labelledby="btnLanguageNm">
																<c:forEach items="${cmcdLanguage}" var="cmcdLanguage">
																	<li><button type="button" class="dropdown-item languageNmList" data-cmcddtl="${cmcdLanguage.cmcdDtl}">${cmcdLanguage.cmcdDtlNm}</button></li>
																</c:forEach>
															</ul>
														</div>
														<div class="col-lg-1">
															<button type="button" class="form-control dropdown-toggle" id="btnLanguageLevel" data-bs-toggle="dropdown" aria-expanded="false">수준</button>
															<ul class="dropdown-menu" aria-labelledby="btnLanguageLevel">
																<c:forEach items="${cmcdLanguageLevel}" var="cmcdLanguageLevel">
																	<li><button type="button" class="dropdown-item languageLevelList" data-cmcddtl="${cmcdLanguageLevel.cmcdDtl}">${cmcdLanguageLevel.cmcdDtlNm}</button></li>
																</c:forEach>
															</ul>
														</div>
													</div>
													<button class="btn btn-default bntAddLanguageScore" type="button" style="color:blue;"><b><i class="material-icons" style="vertical-align: bottom;color:blue;">add</i>어학시험 추가</b></button>
													<div id="divLanguageScoreArea"></div>
												</div>
												<!-- 언어 부분 -->
												<div id="divLanguageArea"></div>
											</div>
											
											
											
											<div class="row mb-6">
												<p class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
													링크
												</p>
												<div class="card-body">
													<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
														<h5 class="text-dark ms-3">
															• 깃헙, 노션으로 작성한 포트폴리오, 구글 드라이브 파일 등 업무 성과를 보여줄 수 있는 링크가 있다면 작성해주세요.
														</h5>
													</blockquote>
												</div>
												<div class="row px-sm-4 my-sm-5">
													<input type="text" class="form-control" name="rsmUrl" placeholder="http://" style="display: inline-block;"/>
												</div>
											</div>
											<div class="row bm-6">
												<button type="button" class="btn btn-outline-info" id="btnSaveResume">저장</button>
												<button type="button" class="btn btn-outline-info" onclick="javascript:history.back()" >취소</button>
											</div>
										</div>
										<sec:csrfInput/>
									</form>
								</section>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</main>

	
<!-- 직장 검색 Modal -->
<div class="modal fade" id="modalSearchEnt" tabindex="-1" aria-labelledby="modalSearchEnt" aria-hidden="true">
	<div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
		<div class="modal-content w-sm-80 min-height-300">
			<div class="modal-header">
            	<h5 class="modal-title" id="exampleModalLabel">직장 검색</h5>
				<a class="btn btn-outline-default" data-bs-dismiss="modal" style="float: right;"><i class="material-icons">clear</i></a>
            </div>

			<div class="modal-body p-6">
				<div class="card card-plain">
					<div class="card-body pb-3">
						<div class="input-group input-group-static my-sm-4">
						
							<div class="col-lg-12">
								<label>직장</label>
								<button type="button" id="btnSearchEntNm" class="btn btn-outline-info" style="float: right;">검색</button>
							</div>
							<div class="col-lg-12">
								<input type="text" id="searchEntNm" class="form-control" placeholder="직장명 검색" />
								<ul id="searchEntNmDropdown" class="dropdown-menu">
                                </ul>
                            </div>
                            
							
							<hr/>
							
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>

<!-- 학교 검색 Modal -->
<div class="modal fade" id="modalSearchAcbg" tabindex="-1" aria-labelledby="modalSearchAcbg" aria-hidden="true">
	<div class="modal-dialog modal-danger modal-dialog-centered modal-" role="document">
		<div class="modal-content w-sm-80 min-height-300">
			<div class="modal-header">
            	<h5 class="modal-title" id="exampleModalLabel">학교 검색</h5>
				<a class="btn btn-outline-default" data-bs-dismiss="modal" style="float: right;"><i class="material-icons">clear</i></a>
            </div>

			<div class="modal-body p-6">
				<div class="card card-plain">
					<div class="card-body pb-3">
						<form role="form text-start">
							<div class="input-group input-group-static my-sm-4">
								<div class="col-lg-12">
									<label>학교</label>
									<button type="button" id="btnSearchAcbgNm" class="btn btn-outline-info" style="float: right;">검색</button>
								</div>
								<div class="col-lg-12">
									<input type="text" id="searchAcbgNm" class="form-control" placeholder="학교이름 검색" />
									<ul id="searchAcbgNmDropdown" class="dropdown-menu">
                                	</ul>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>

<script>
let crrEntNm;
let acbgUniversityNm;

// 삭제
$(document).on("click", ".btnMainDelete", function(){
	$(this).parents(".divMainArea").remove();
});
$(document).on("click", ".btnSubDelete", function(){
	$(this).parents(".divSubArea").remove();
});

// 경력
$(document).on("click", ".crrEntNm", function(){
	crrEntNm = $(this);
	console.log(crrEntNm);
	$("#modalSearchEnt").modal("show");
});

$("#searchEntNm").on("focus", function(){
	$("#searchEntNmDropdown").addClass("show");
});

$("#searchEntNm").on("keyup", function(){
	
	let keyword = $("#searchEntNm").val();
	if(keyword.trim() == ''){
		$("#searchEntNmDropdown").empty();
		return false;
	}
	let cnt = 0;
	$.ajax({
		url: "/resources/CORPCODE.xml",
		type: "get",
		dataType: "xml",
		success: function(result){
			let list = $(result).find("list");
			console.log(list);
			console.log(result);
			str = "";
			$.each(list, function(i, v){
				if($(v).find("corp_name").html().includes(keyword)){
					str += "<li class='dropdown-item text-bold searchEntNmList'>" + $(v).find("corp_name").html() + "</li>";
					cnt++;
				}
			});
			if(cnt == 0){
				str += "<li>검색 결과가 없습니다</li>";
			}
			console.log(cnt);
			$("#searchEntNmDropdown").html(str);
		},
		error: function(xhr){
			console.log(xhr.status);
		}
	});
});

$(document).on("click", ".searchEntNmList", function(){
	crrEntNm.html($(this).html());
	$("#modalSearchEnt").modal("hide");
	$("#searchEntNm").val("");
	$("#searchEntNmResult").empty();
	$("#searchEntNmDropdown").removeClass("show");
	$("#searchEntNmDropdown").empty();
});

$("#btnAddCareer").on("click", function(){
	let divCareer = $("#divCareer").clone();
	divCareer.show();
	$("#divCareerArea").append(divCareer);
});

$(document).on("click", ".btnAddAchievement", function(){
	let divAchievement = $("#divAchievement").clone();
	divAchievement.show();
	$(this).parents("#divCareer").find("#divAchievementArea").append(divAchievement);
});

// 학력
$(document).on("click", ".acbgUniversityNm", function(){
	acbgUniversityNm = $(this);
	$("#modalSearchAcbg").modal("show");
});

$("#searchAcbgNm").on("focus", function(){
	$("#searchAcbgNmDropdown").addClass("show");
});

$("#searchAcbgNm").on("keyup", function(){
	let keyword = $(this).val();
	if(keyword == ''){
		$("#searchAcbgNmDropdown").empty();
		return false;
	}
	let cnt = 0;
	$.ajax({
		url: "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=b4f563f5c0c429fe66effef81d963a2f&svcType=api&svcCode=SCHOOL&contentType=json&gubun=univ_list&searchSchulNm=" + keyword,
		type: "get",
		success: function(result){
			console.log(result);
			console.log(result.dataSearch.content);
			let code = "";
			$.each(result.dataSearch.content, function(i, v){
				code += "<li class='dropdown-item text-bold searchAcbgNmList'>" + v.schoolName +"</li>" 
				cnt++;
			});
			if(cnt == 0){
				code += "<li>검색 결과가 없습니다.</li>";
			}
			$("#searchAcbgNmDropdown").html(code);
		}
	});
});

$(document).on("click", ".searchAcbgNmList", function(){
	acbgUniversityNm.html($(this).html());
	$("#modalSearchAcbg").modal("hide");
	$("#searchAcbgNm").val("");
	$("#searchAcbgNmResult").empty();
	$("#searchAcbgNmDropdown").removeClass("show");
	$("#searchAcbgNmDropdown").empty();
});

$("#btnAddAcbg").on("click", function(){
	let divAcademic = $("#divAcademic").clone();
	divAcademic.show();
	$("#divAcademicArea").append(divAcademic);
});

// 스킬
$(document).on("click",".btnMySkill", function(){
	$(this).remove();
});

$("#searchSkill").on("focus", function(){
	$("#searchSkillDropdown").addClass("show");
});

$("#searchSkill").on("keyup", function () {
	let keyword = $(this).val().toUpperCase();
	if(keyword.trim() == ''){
		$("#searchSkillDropdown").empty();
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
	        $("#searchSkillDropdown").html(code);
	    }
	});
});

$(document).on("click", ".searchSkillList", function(){
	let cmcdDtl = $(this).data("cmcddtl");
	let cmcdDtlNm = $(this).html();
	$("#divMySkl").append('<button type="button" id="mySkill" class="btn btn-block btn-outline-secondary mx-md-1 btnMySkill" data-cmcddtl="' + cmcdDtl +'">' + cmcdDtlNm + '</button>');
	$("#searchSkill").val("");
	$("#searchSkillDropdown").empty();
	$("#searchSkill").focus();
});

// 수상
$("#btnAddAwards").on("click", function(){
	let divAwards = $("#divAwards").clone();
	divAwards.show();
	$("#divAwardsArea").append(divAwards);
});

// 외국어
$(document).on("click", ".languageNmList, .languageLevelList", function(){
	$(this).parents("ul").prev().html($(this).html());
	$(this).parents("ul").prev().attr("data-cmcddtl", $(this).data("cmcddtl"));
});

$("#btnAddLanguage").on("click", function(){
	let divLanguage = $("#divLanguage").clone();
	divLanguage.show();
	$("#divLanguageArea").append(divLanguage);
});

$(document).on("click", ".bntAddLanguageScore", function(){
	let divLanguageScore = $("#divLanguageScore").clone();
	divLanguageScore.show();
	$(this).parents("#divLanguage").find("#divLanguageScoreArea").append(divLanguageScore);
});

// 저장
$("#btnSaveResume").on("click", function(){
	// 경력
	let form = $("#frmResume");
	let careerList = $("#divCareerArea").find("#divCareer");
	let arrCareerNm = ["crrJncmpDt", "crrRtrmDt", "crrEntNm", "crrJbgdNm", "crrHdofYn"];
	
	$.each(careerList, function(careerIndex, careerValue){
		let v = $(careerValue);
		let crrJncmpDt = v.find("#crrJncmpDtYear").val() + "/" + v.find("#crrJncmpDtMonth").val() + "/01";
		let crrRtrmDt = v.find("#crrRtrmDtYear").val() + "/" + v.find("#crrRtrmDtMonth").val() + "/01";
		let crrEntNm = v.find("#crrEntNm").html();
		let crrJbgdNm = v.find("#crrJbgdNm").val();
		let crrHdofYn = "N";
		if(v.find("#crrHdofYn").is(":checked")){
			crrHdofYn = "Y";
		}
		
		let arrCareerValue = [crrJncmpDt, crrRtrmDt, crrEntNm, crrJbgdNm, crrHdofYn];
		
		$.each(arrCareerNm, function(i, v){
			let inputCrrData = document.createElement("input");
			inputCrrData.type = "hidden";
			inputCrrData.value = arrCareerValue[i];
			inputCrrData.name = "careerVOList[" + careerIndex + "]." + v;
			form.append(inputCrrData);
// 			console.log(inputCrrData);
		});
		
		// 성과
		let achievementList = v.find("#divAchievement");
// 		console.log(achievementList);
		let arrAchievementNm = ["achTitle", "achBgngDt", "achEndDt", "achContent"];
		
		$.each(achievementList, function(achIndex, achValue){
			let v = $(achValue);
			let achTitle = v.find("#achTitle").val();
			let achBgngDt = v.find("#achBgngDtYear").val() + "/" + v.find("#achBgngDtMonth").val() + "/01";
			let achEndDt = v.find("#achEndDtYear").val() + "/" + v.find("#achEndDtMonth").val() + "/01";
			let achContent = v.find("#achContent").val();
			
			let arrAchievementValue = [achTitle, achBgngDt, achEndDt, achContent];
			
			$.each(arrAchievementNm, function(i, v){
				let inputAchievementData = document.createElement("input");
				inputAchievementData.type = "hidden";
				inputAchievementData.value = arrAchievementValue[i];
				inputAchievementData.name = "careerVOList[" + careerIndex + "].achievementVOList[" + achIndex + "]." + v;
				form.append(inputAchievementData);
// 	 			console.log(inputAchievementData);
			});
		});
		
	});
	
	// 학력
	let academicList = $("#divAcademicArea").find("#divAcademic");
	let arrAcademicNm = ["acbgUniversityNm", "acbgMtcltnDt", "acbgGrdtnDt", "acbgAttndYn", "acbgMajor", "acbgDegree", "acbgDiscription"];
	
	$.each(academicList, function(acbgIndex, acbgValue){
		let v = $(acbgValue);
		let acbgUniversityNm = v.find("#acbgUniversityNm").html();
		let acbgMtcltnDt = v.find("#acbgMtcltnDtYear").val() + "/" + v.find("#acbgMtcltnDtMonth").val() + "/01";
		let acbgGrdtnDt = v.find("#acbgGrdtnDtYear").val() + "/" + v.find("#acbgGrdtnDtMonth").val() + "/01";
		let acbgAttndYn = "N";
		if(v.find("#acbgAttndYn").is(":checked")){
			acbgAttndYn = "Y";
		}
		let acbgMajor = v.find("#acbgMajor").val();
		let acbgDegree = v.find("#acbgDegree").val();
		let acbgDiscription = v.find("#acbgDiscription").val();
		
		let arrAcademicValue = [acbgUniversityNm, acbgMtcltnDt, acbgGrdtnDt, acbgAttndYn, acbgMajor, acbgDegree, acbgDiscription];
		
		$.each(arrAcademicNm, function(i, v){
			let inputAcademicData = document.createElement("input");
			inputAcademicData.type = "hidden";
			inputAcademicData.value = arrAcademicValue[i];
			inputAcademicData.name = "academicList[" + acbgIndex + "]." + v;
			form.append(inputAcademicData);
//  			console.log(inputAcademicData);
		});
	});
	
	// 스킬
	let mySkillList = document.querySelectorAll("#mySkill");
	let arrMySkillNm = ["mySklNo", "mySklNm"] 
	$.each(mySkillList, function(mySkillIndex, mySkillValue){
		let v = $(mySkillValue);
		let mySklNo = v.data("cmcddtl");
		let mySklNm = v.html();
		
		let arrMySkillValue = [mySklNo, mySklNm];
		
		$.each(arrMySkillNm, function(i, v){
			let inputMySkillData = document.createElement("input");
			inputMySkillData.type = "hidden";
			inputMySkillData.value = arrMySkillValue[i];
			inputMySkillData.name = "mySkillList[" + mySkillIndex + "]." + v;
			form.append(inputMySkillData);
//  			console.log(inputMySkillData);
		});
	});
	
	// 수상 및 기타
	let awardsList = $("#divAwardsArea").find("#divAwards");
	let arrAwardsNm = ["awrdDt", "awrdNm", "awrdInfo"];
	
	$.each(awardsList, function(awardsIndex, awardsValue){
		let v = $(awardsValue);
		let awrdDt = v.find("#awrdDtYear").val() + "/" + v.find("#awrdDtMonth").val() + "/01";
		let awrdNm = v.find("#awrdNm").val();
		let awrdInfo = v.find("#awrdInfo").val();
		
		let arrAwardsValue = [awrdDt, awrdNm, awrdInfo];
		
		$.each(arrAwardsNm, function(i, v){
			let inputAwardsData = document.createElement("input");
			inputAwardsData.type = "hidden";
			inputAwardsData.value = arrAwardsValue[i];
			inputAwardsData.name = "awardsVOList[" + awardsIndex + "]." + v;
			form.append(inputAwardsData);
//  			console.log(inputAwardsData);
		});
	});
	
	// 외국어
	let languageList = $("#divLanguageArea").find("#divLanguage");
	let arrLanguageNm = ["lanNo", "lanNm", "lanLevel"];
	
	$.each(languageList, function(lanIndex, lanValue){
		let v = $(lanValue);
		let lanNo = v.find("#btnLanguageNm").data("cmcddtl");
		let lanNm = v.find("#btnLanguageNm").html();
		let lanLevel = v.find("#btnLanguageLevel").html();
		
		let arrLanguageValue = [lanNo, lanNm, lanLevel];
		
		$.each(arrLanguageNm, function(i, v){
			let inputLanguageData = document.createElement("input");
			inputLanguageData.type = "hidden";
			inputLanguageData.value = arrLanguageValue[i];
			inputLanguageData.name = "languageVOList[" + lanIndex + "]." + v;
			form.append(inputLanguageData);
//  			console.log(inputLanguageData);
		});
		
		let languageScoreList = v.find("#divLanguageScore");
		let arrLanguageScoreNm = ["lscoNm", "lscoScore", "lscoAcqsDt"];
		
		$.each(languageScoreList, function(lanScoreIndex, lanScoreValue){
			let v = $(lanScoreValue);
			let lscoNm = v.find("#lscoNm").val();
			let lscoScore = v.find("#lscoScore").val();
			let lscoAcqsDt = v.find("#lscoAcqsDt").val().replaceAll("-", "/");
			
			let arrLanguageScoreValue = [lscoNm, lscoScore, lscoAcqsDt];
			
			$.each(arrLanguageScoreNm, function(i, v){
				let inputLanguageScoreData = document.createElement("input");
				inputLanguageScoreData.type = "hidden";
				inputLanguageScoreData.value = arrLanguageScoreValue[i];
				inputLanguageScoreData.name = "languageVOList[" + lanIndex + "].languageScoreVOList[" + lanScoreIndex + "]." + v;
				form.append(inputLanguageScoreData);
// 	  			console.log(inputLanguageScoreData);
			});
		});
	});
	
	console.log(form);
	form.submit();
});

</script>