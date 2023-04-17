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
</style>

<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container min-height-300">
			<div class="row">
				<div class="col-lg-12">
					<div class="card shadow-lg mb-5">
						<div class="card-body p-8">
							<section>
								<form id="frmResume" action="/mem/createResume" method="post">
									<input type="hidden" name="rsmNo" />
									<div class="container min-height-600">
										<div class="row align-items-center">
											<h3 class="font-weight-bolder text-dark display-6">
												<input id="rsmTitle" name="rsmTitle" class="form-control" type="text" style="font-size:50px;"/>
											</h3>
										</div>
										<hr/>
										<ul class="mt-md-5 mb-md-3" style="list-style: none;">
											<li class="my-md-5"><h5>${memVO.memNm}</h5></li>
											<li class="my-md-2"><h6>${memVO.memId}</h6></li>
											<li class="my-md-2"><h6>${memVO.memTelno}</h6></li>
										</ul>

										<div class="row mb-6">
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												간단 소개글
												<button type="button" class="btn btn-primary" style="float: right;" onclick="insertInput()">데이터 넣기</button>
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
													• 본인의 업무 경험을 기반으로 핵심역량과 업무 스킬을 간단히 작성해주세요. <br/>
													• 3~5줄로 요약하여 작성하는 것을 추천합니다!
													</h6>
												</blockquote>
											</div>
											<textarea rows="5" cols="1" id="rsmAboutMe" name="rsmAboutMe" class="form-control px-sm-4" placeholder="간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요! (권장 3-5줄)"></textarea>
										</div>



										<div class="row mb-6">
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												경력
												<button id="btnAddCareer" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
														• 담당하신 업무 중 우선순위가 높은 업무를 선별하여 최신순으로 작성해주세요. <br/>
														• 신입의 경우, 직무와 관련된 대외활동, 인턴, 계약직 경력 등이 있다면 작성해주세요. <br/>
														• 업무 또는 활동 시 담당했던 역할과 과정, 성과에 대해 자세히 작성해주세요. <br/>
														• 업무 성과는 되도록 구체적인 숫자 혹은 [%]로 표현해주세요!<br/>
														• 커리어 조회 후 기업명이 실제와 다른 경우, 부서명/직책 란에 원하시는 기업명을 작성해주세요.
													</h6>
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
														<input type="text" class="form-control col-lg-10" id="achTitle" placeholder="• 주요 성과" style="display: inline-block;" />
													</li>
													<li>
														<input type="text" class="form-control" id="achBgngDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" />.
														<input type="text" class="form-control" id="achBgngDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" />&nbsp;-&nbsp;
														<input type="text" class="form-control" id="achEndDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" />.
														<input type="text" class="form-control" id="achEndDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" />
													</li>
													<li><input type="text" class="form-control" id="achContent" placeholder="상세 업무 내용과 성과를 입력해주세요" style="display: inline-block;"/></li>
												</ul>
											</div>
											<!-- 경력폼 -->
											<div class="row px-sm-4 my-sm-5 divMainArea" id="divCareer" style="display:none;">
												<div class="col-lg-4">
													<div id="divCrrRtrmDt">
														<input type="text" class="form-control" id="crrJncmpDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" value="2016" />.
														<input type="text" class="form-control" id="crrJncmpDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" value="07" />&nbsp;-&nbsp;
														<input type="text" class="form-control" id="crrRtrmDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" value="2018" /><span id="dot">.</span>
														<input type="text" class="form-control" id="crrRtrmDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" value="04" />
													</div>
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
													<p class="my-md-3 crrEntNm" id="crrEntNm">아트박스</p>
													<input type="text" class="form-control" id="crrJbgdNm" placeholder="부서명/직책" style="display: inline-block;" value="경영지원부/사원"/>
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
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												학력
												<button id="btnAddAcbg" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
														• 최신순으로 작성해주세요.
													</h6>
												</blockquote>
											</div>
											<!-- 학력 폼 -->
											<div class="row px-sm-4 my-sm-5 divMainArea" id="divAcademic" style="display: none;">
												<div class="col-lg-4">
													<div id="divAcbgDt">
														<input type="text" class="form-control" id="acbgMtcltnDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" value="2012" />.
														<input type="text" class="form-control" id="acbgMtcltnDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" value="03" />&nbsp;-&nbsp;
														<input type="text" class="form-control" id="acbgGrdtnDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" value="2016" /><span id="dot">.</span>
														<input type="text" class="form-control" id="acbgGrdtnDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" value="02" />
													</div>
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
													<p class="my-md-3 acbgUniversityNm" id="acbgUniversityNm">서울대학교</p>
													<input type="text" class="form-control" id="acbgMajor" placeholder="전공" style="display: inline-block;" value="컴퓨터공학부"/>
													<input type="text" class="form-control" id="acbgDegree" placeholder="학위" style="display: inline-block;" value="학사"/>
													<input type="text" class="form-control" id="acbgDiscription" placeholder="이수과목 및 연구내용" style="display: inline-block;" value="공유기를 이용한 클라우드 시스템"/>
												</div>
											</div>
											<!-- 학력 부분 -->
											<div id="divAcademicArea"></div>
										</div>

										<div class="row mb-6">
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												스킬
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
														• 개발 스택, 디자인 툴, 마케팅 툴 등 가지고 있는 직무와 관련된 스킬을 추가해보세요.<br/>
														• 데이터 분석 툴이나 협업 툴 등의 사용해본 경험이 있으신 툴들도 추가해보세요.<br/>
														• 스킬을 등록한 원티드 이력서는 일반 이력서에 비해 서류통과율이 더 높습니다!
													</h6>
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
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												수상 및 기타
												<button id="btnAddAwards" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
														• 수상 이력, 직무 관련 자격증, 수료한 교육이나 참석한 외부활동 등이 있다면 간략히 작성해주세요.<br/>
														• 지원하는 회사에서 요구하는 경우가 아니라면 운전면허증과 같은 자격증은 생략하는 것이 좋습니다!
													</h6>
												</blockquote>
											</div>
											<!-- 수상 및 기타폼 -->
											<div class="row px-sm-4 my-sm-5 divMainArea" id="divAwards" style="display: none;">
												<div class="col-lg-4">
													<input type="text" class="form-control" id="awrdDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" value="2015"/>.
													<input type="text" class="form-control" id="awrdDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" value="10"/>
												</div>
												<div class="col-lg-8">
													<div class="col-lg-1 text-end"  style="float: right;">
														<button type="button" class="form-control btnMainDelete">
															<i class="material-icons" style="color: #808080b3;">clear</i>
														</button>
													</div>
													<input type="text" class="form-control" id="awrdNm" placeholder="활동명" style="display: inline-block;" value="ICPC 경진대회"/>
													<input type="text" class="form-control" id="awrdInfo" placeholder="세부사항" style="display: inline-block;" value="입상"/>
												</div>
											</div>
											<!--  수상 및 기타 부분 -->
											<div id="divAwardsArea"></div>
										</div>



										<div class="row mb-6">
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												외국어
												<button id="btnAddLanguage" type="button" class="btn btn-outline-info" style="float: right;"><i class="material-icons">add</i>추가</button>
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
														• 외국어 자격증을 보유한 경우 작성해주세요. <br/>
														• 활용 가능한 외국어가 있다면, 어느정도 수준인지 레벨을 선택해주세요.
													</h6>
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
													<li><input type="date" class="form-control" id="lscoAcqsDt" /></li>
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
														<button type="button" class="form-control dropdown-toggle" id="btnLanguageNm" data-bs-toggle="dropdown" aria-expanded="false">영어</button>
														<ul class="dropdown-menu" aria-labelledby="btnLanguageNm">
															<c:forEach items="${cmcdLanguage}" var="cmcdLanguage">
																<li><button type="button" class="dropdown-item languageNmList" data-cmcddtl="${cmcdLanguage.cmcdDtl}">${cmcdLanguage.cmcdDtlNm}</button></li>
															</c:forEach>
														</ul>
													</div>
													<div class="col-lg-1">
														<button type="button" class="form-control dropdown-toggle" id="btnLanguageLevel" data-bs-toggle="dropdown" aria-expanded="false">일상 회화</button>
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
											<h5 class="text-dark font-weight-bolder ms-3 mt-6 pb-3" style="border-bottom: 1px solid #808080b3">
												링크
											</h5>
											<div class="card-body">
												<blockquote class="blockquote text-white p-sm-3 bg-gray-100 mb-0">
													<h6 class="text-dark ms-3">
														• 깃헙, 노션으로 작성한 포트폴리오, 구글 드라이브 파일 등 업무 성과를 보여줄 수 있는 링크가 있다면 작성해주세요.
													</h6>
												</blockquote>
											</div>
											<div class="row px-sm-4 my-sm-5">
												<input type="text" class="form-control" id="rsmUrl" name="rsmUrl" placeholder="http://" style="display: inline-block;"/>
											</div>
										</div>
										<div class="row bm-6" style="justify-content: space-around;">
											<button type="button" class="btn btn-outline-info" id="btnSaveResume" style="width: 45%;">저장</button>
											<button type="button" class="btn btn-outline-danger" onclick="javascript:history.back()" style="width: 45%;">취소</button>
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
// 이력서 정보 불러오기
let resumeVO = ${resumeVO};
console.log(resumeVO);

// 이력서 기본정보
$("input[name=rsmTitle]").val(resumeVO.rsmTitle);
$("input[name=rsmNo]").val(resumeVO.rsmNo);
$("#rsmAboutMe").val(resumeVO.rsmAboutMe);
$("input[name=rsmUrl]").val(resumeVO.rsmUrl);

// 경력
if(resumeVO.careerVOList[0].crrNo != null){
	$.each(resumeVO.careerVOList, function(careerIndex, careerValue){
		let divCareer = $("#divCareer").clone();

		let crrJncmpDt = new Date(careerValue.crrJncmpDt);
		let crrJncmpDtYear = crrJncmpDt.getFullYear();
		let crrJncmpDtMonth = crrJncmpDt.getMonth() < 9 ? "0" + (crrJncmpDt.getMonth() + 1) : crrJncmpDt.getMonth() + 1;
		divCareer.find("#crrJncmpDtYear").val(crrJncmpDtYear);
		divCareer.find("#crrJncmpDtMonth").val(crrJncmpDtMonth);

		let crrRtrmDt = new Date(careerValue.crrRtrmDt);
		let crrRtrmDtYear = crrRtrmDt.getFullYear();
		let crrRtrmDtMonth = crrRtrmDt.getMonth() < 9 ? "0" + (crrRtrmDt.getMonth() + 1) : crrRtrmDt.getMonth() + 1;
		divCareer.find("#crrRtrmDtYear").val(crrRtrmDtYear);
		divCareer.find("#crrRtrmDtMonth").val(crrRtrmDtMonth);

		if(careerValue.crrHdofYn == "Y"){
			divCareer.find("#crrHdofYn").prop("checked", true);
		}

		divCareer.find("#crrEntNm").html(careerValue.crrEntNm);
		divCareer.find("#crrJbgdNm").val(careerValue.crrJbgdNm);

		// 주요성과
		if(careerValue.achievementVOList[0].achTitle != null){
			$.each(careerValue.achievementVOList, function(achIndex, achValue){
				let divAchievement = $("#divAchievement").clone();

				divAchievement.find("#achTitle").val(achValue.achTitle);

				let achBgngDt = new Date(achValue.achBgngDt);
				let achBgngDtYear = achBgngDt.getFullYear();
				let achBgngDtMonth = achBgngDt.getMonth() < 9 ? "0" + (achBgngDt.getMonth() + 1) : achBgngDt.getMonth() + 1;
				divAchievement.find("#achBgngDtYear").val(achBgngDtYear);
				divAchievement.find("#achBgngDtMonth").val(achBgngDtMonth);

				let achEndDt = new Date(achValue.achEndDt);
				let achEndDtYear = achEndDt.getFullYear();
				let achEndDtMonth = achEndDt.getMonth() < 9 ? "0" + (achEndDt.getMonth() + 1) : achEndDt.getMonth() + 1;
				divAchievement.find("#achEndDtYear").val(achEndDtYear);
				divAchievement.find("#achEndDtMonth").val(achEndDtMonth);

				divAchievement.find("#achContent").val(achValue.achContent);

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
		let acbgMtcltnDtMonth = acbgMtcltnDt.getMonth() < 9 ? "0" + (acbgMtcltnDt.getMonth() + 1) : acbgMtcltnDt.getMonth() + 1;
		divAcademic.find("#acbgMtcltnDtYear").val(acbgMtcltnDtYear);
		divAcademic.find("#acbgMtcltnDtMonth").val(acbgMtcltnDtMonth);

		let acbgGrdtnDt = new Date(acbgValue.acbgGrdtnDt);
		let acbgGrdtnDtYear = acbgGrdtnDt.getFullYear();
		let acbgGrdtnDtMonth = acbgGrdtnDt.getMonth() < 9 ? "0" + (acbgGrdtnDt.getMonth() + 1) : acbgGrdtnDt.getMonth() + 1;
		divAcademic.find("#acbgGrdtnDtYear").val(acbgGrdtnDtYear);
		divAcademic.find("#acbgGrdtnDtMonth").val(acbgGrdtnDtMonth);

		if(acbgValue.acbgAttndYn == "Y"){
			divAcademic.find("#acbgAttndYn").prop("checked", true);
		}

		divAcademic.find("#acbgUniversityNm").html(acbgValue.acbgUniversityNm);
		divAcademic.find("#acbgMajor").val(acbgValue.acbgMajor);
		divAcademic.find("#acbgDegree").val(acbgValue.acbgDegree);
		divAcademic.find("#acbgDiscription").val(acbgValue.acbgDiscription);


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
		console.log("aaaaaaaaaaaaaaaaaaaaaaaaaaaa",awrdDt.getMonth());
		let awrdDtMonth = awrdDt.getMonth() < 9 ? "0" + (awrdDt.getMonth() + 1) : awrdDt.getMonth() + 1;
		divAwards.find("#awrdDtYear").val(awrdDtYear);
		divAwards.find("#awrdDtMonth").val(awrdDtMonth);

		divAwards.find("#awrdNm").val(awardsValue.awrdNm);
		divAwards.find("#awrdInfo").val(awardsValue.awrdInfo);

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

				divLanguageScore.find("#lscoNm").val(lanScoreValue.lscoNm);
				divLanguageScore.find("#lscoScore").val(lanScoreValue.lscoScore);

				let lscoAcqsDt = new Date(lanScoreValue.lscoAcqsDt);
				let lscoAcqsDtYear = lscoAcqsDt.getFullYear();
				let lscoAcqsDtMonth = lscoAcqsDt.getMonth() < 9 ? "0" + (lscoAcqsDt.getMonth() + 1) : lscoAcqsDt.getMonth() + 1;
				let lscoAcqsDtDay = lscoAcqsDt.getDate() < 9 ? "0" + lscoAcqsDt.getDate() : lscoAcqsDt.getDate();
				divLanguageScore.find("#lscoAcqsDt").val(lscoAcqsDtYear + "-" + lscoAcqsDtMonth + "-" + lscoAcqsDtDay);
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

// 모달 검색용 변수
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
	let crrRtrmDt = '<input type="text" class="form-control" id="crrRtrmDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;"/><span id="dot">.</span><input type="text" class="form-control" id="crrRtrmDtMonth" placeholder="MM" style="display: inline-block;width: 30px;"/>';
	let crrHdofYn = divCareer.find("#crrHdofYn");
	crrHdofYn.on("change", function(){
		if($(this).is(":checked")){
			divCareer.find("#crrRtrmDtYear").remove();
			divCareer.find("#dot").remove();
			divCareer.find("#crrRtrmDtMonth").remove();
		}else{
			divCareer.find("#divCrrRtrmDt").append(crrRtrmDt);
		}
	});
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

	let acbgAttndYn = divAcademic.find("#acbgAttndYn");
	acbgAttndYn.on("change", function(){
		let acbgGrdtnDt = '<input type="text" class="form-control" id="acbgGrdtnDtYear" placeholder="YYYY" style="display: inline-block;width: 30px;" /><span id="dot">.</span><input type="text" class="form-control" id="acbgGrdtnDtMonth" placeholder="MM" style="display: inline-block;width: 30px;" />';
		if($(this).is(":checked")){
			console.log("체크");
			divAcademic.find("#acbgGrdtnDtYear").remove();
			divAcademic.find("#acbgGrdtnDtMonth").remove();
			divAcademic.find("#dot").remove();
		}else{
			console.log("체크해제");
			console.log(divAcademic.find("#divAcbgDt"));
			console.log(acbgGrdtnDtYear);
			console.log(dot);
			console.log(acbgGrdtnDtMonth);
			divAcademic.find("#divAcbgDt").append(acbgGrdtnDt);
		}
	});

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
		let crrRtrmDt;
		let crrEntNm = v.find("#crrEntNm").html();
		let crrJbgdNm = v.find("#crrJbgdNm").val();
		let crrHdofYn = "N";
		if(v.find("#crrHdofYn").is(":checked")){
			crrHdofYn = "Y";
		}else{
			crrRtrmDt = v.find("#crrRtrmDtYear").val() + "/" + v.find("#crrRtrmDtMonth").val() + "/01";
		}

		let arrCareerValue = [crrJncmpDt, crrRtrmDt, crrEntNm, crrJbgdNm, crrHdofYn];

		$.each(arrCareerNm, function(i, v){
			let inputCrrData = document.createElement("input");
			inputCrrData.type = "hidden";
			inputCrrData.value = arrCareerValue[i];
			inputCrrData.name = "careerVOList[" + careerIndex + "]." + v;
			form.append(inputCrrData);
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
		let acbgGrdtnDt;
		let acbgAttndYn = "N";
		if(v.find("#acbgAttndYn").is(":checked")){
			acbgAttndYn = "Y";
		}else{
			acbgGrdtnDt = v.find("#acbgGrdtnDtYear").val() + "/" + v.find("#acbgGrdtnDtMonth").val() + "/01";
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
			});
		});
	});

	console.log(form);
	form.submit();
});

function insertInput(){
	$("#rsmTitle").val("끊임없이 노력하겠습니다.");
	$("#rsmAboutMe").val('"Agile & Active"\n새로운 것을 배우는 데 적극적입니다. 학과 수업을 듣던 중 데이터 분석에 흥미가 생겨 곧바로 교내 컴퓨터 동아리에 들어가 Python을 공부하며 분석 역량을 키웠습니다. 이후 복약 안내 서비스 회사의 인턴으로 일하며, 개발자를 거치지 않고 직접 고객 데이터를 분석하기 위해 SQL, Power BI 등 데이터 추출 및 시각화 툴을 공부했습니다. 이처럼, 직무 수행에 필요한 역량을 갖추기 위해 항상 적극적으로 노력하는 자세를 가지고 있습니다.\n\n"Sociable"\n배려를 기반으로 소통하는 커뮤니케이션 역량을 가지고 있습니다. 교내 마케팅학회의 기획부장으로 활동하며, 매주 진행되는 세션을 성공적으로 이끌기 위해 \'올바르게 피드백을 주고받는 매뉴얼\'을 만들었습니다. 그 결과, 서로의 감정을 상하게 하는 날카로운 피드백을 줄일 수 있었고 더욱 밝은 분위기를 조성할 수 있었습니다. 항상 배려하는 자세로 기획·운영을 위한 유관부서와의 협업에 임하겠습니다.');
	$("#rsmUrl").val("https://ddit.or.kr/");
}
</script>