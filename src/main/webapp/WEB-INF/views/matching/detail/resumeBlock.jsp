<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<sec:authentication property="principal.memVO" var="memVO" />

<div class="modal-dialog modal-xl" role="document" >
	<input type="hidden" id="memId" value="${resumeVO.memId}"/>
	<div class="modal-content" >
		<div class="modal-header row">
			<div class="col-10">
				<h4 class="modal-title" style="margin-left: 41%;">이력서 상세보기</h4>
			</div>
			<div class="col">
				<div class="justify-content-between">
					<button type="button" class="btn btn-info detailCheckBtn" data-bs-toggle="modal" data-bs-target="#exampleModal" data-rsmno="${resumeVO.rsmNo}">상세보기</button>
					<button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal"><i class="fas fa-times"></i></button>
			    </div>
		    </div>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-lg-11">
					<h2 id="detailMemNm" style="margin-left: 10px;">${fn:substring(resumeVO.memNm, 0, 1)}OO</h2>
					<h6 style="color: grey; margin-left: 10px;" id="detailRsmUrl">
						링크 : <div class="progress progress-bar bg-secondary col-2" role="progressbar" style="width: 25%; opacity:0.5;" aria-valuenow="25"></div>
					</h6>
					<h6 style="color: grey; margin-left: 10px;" id="detailMemTelno">
						연락처 : <div class="progress progress-bar bg-secondary col-2" role="progressbar" style="width: 25%; opacity:0.5;" aria-valuenow="25"></div>
					</h6>
					<p style="color: grey; margin-left: 10px;" id="detailRsmAboutMe">
						<c:forEach begin="0" end="${resumeVO.rsmAboutMe.length()}" step="100">
							<div class="progress progress-bar bg-secondary mb-1" role="progressbar" style="width: 100%" aria-valuemin="0" aria-valuemax="100"></div>
						</c:forEach>
					</p>
				</div>

			</div>

			<hr style="background-color: #007bff; height: 1px;" />

			<div class="row">
				<div class="col-lg-2">
					<ul>
						<li><strong>경력</strong></li>
					</ul>
				</div>
				<div id="detailCareer" class="col-lg-10">
					<c:forEach var="beforeList" items="${resumeVO.beforeList}" varStatus="stat">
						<div class="row">
							<div class="col-lg-9">
								<div class="col-lg-9">
									<ul>
										<li><strong>${beforeList.crrEntNm }</strong></li>
										<li style="color: grey;">${beforeList.crrJbgdNm }</li>
										<li style="color: grey;">
											<c:forEach begin="0" end="${result[0].careerVOList[stat.index].achievementVOList[0].achContent.length()}" step="30">
											</c:forEach>
											<div class="progress progress-bar bg-secondary col-2" role="progressbar" style="width: 100%; opacity:0.5;" aria-valuenow="25"></div>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-3" style="margin: auto;">
								<ul>
									<li>
										<strong>
											<fmt:formatDate	value="${beforeList.crrJncmpDt}" type="both" pattern="yy" />.
											<fmt:formatDate value="${beforeList.crrJncmpDt}" type="both" pattern="MM" /> -
											<fmt:formatDate	value="${beforeList.crrRtrmDt}" type="both" pattern="yy" />.
											<fmt:formatDate value="${beforeList.crrRtrmDt}" type="both"	pattern="MM" />
										</strong>
									</li>
								</ul>
							</div>
						</div>
						<hr />
					</c:forEach>
				</div>
				<hr />
			</div>

			<hr style="background-color: #007bff;" />

			<div class="row">
				<div class="col-lg-2">
					<ul>
						<li><strong>학력</strong></li>
					</ul>
				</div>
				<div id="detailAcademic" class="col-lg-10">
					<c:forEach var="academicList" items="${resumeVO.academicList}" varStatus="stat">
						<ul>
							<li><strong>${academicList.acbgUniversityNm}</strong></li>
							<li style="color: grey;">${academicList.acbgMajor}</li>
						</ul>
						<hr />
					</c:forEach>
				</div>
			</div>

			<hr style="background-color: #007bff;" />

			<div class="row">
				<div class="col-lg-2">
					<ul>
						<li><strong>수상 및 기타</strong></li>
					</ul>
				</div>
				<div id="detailAwards" class="col-lg-10">
					<c:forEach var="awardsVOList" items="${resumeVO.awardsVOList}" varStatus="stat">
						<ul>
							<li><div class="progress progress-bar bg-secondary mb-1 col-2" role="progressbar" style="width: 25%; opacity:0.5;" aria-valuenow="25"></div></li>
							<li><div class="progress progress-bar bg-secondary col-2" role="progressbar" style="width: 30%; opacity:0.5;" aria-valuenow="25"></div></li>
						</ul>
						<hr />
					</c:forEach>
				</div>
			</div>

			<hr style="background-color: #007bff;" />

			<div class="row">
				<div class="col-lg-2">
					<ul>
						<li><strong>외국어</strong></li>
					</ul>
				</div>
				<div id="detailLanguage" class="col-lg-10">
					<c:forEach var="languageVOList" items="${resumeVO.languageVOList}" varStatus="stat">
						<ul>
							<li><div class="progress progress-bar bg-secondary mb-1 col-2" role="progressbar" style="width: 20%; opacity:0.5;" aria-valuenow="25"></div></li>
							<li><div class="progress progress-bar bg-secondary mb-1 col-2" role="progressbar" style="width: 20%; opacity:0.5;" aria-valuenow="25"></div></li>
							<li><div class="progress progress-bar bg-secondary mb-1 col-2" role="progressbar" style="width: 20%; opacity:0.5;" aria-valuenow="25"></div></li>
						</ul>
						<hr />
					</c:forEach>
				</div>
			</div>

			<hr style="background-color: #007bff;" />

			<div class="row">
				<div class="col-lg-2">
					<ul>
						<li><strong>기술</strong></li>
					</ul>
				</div>
				<div id="detailMySkill" class="col-lg-10">
					<ul>
						<c:forEach var="mySkillList" items="${resumeVO.mySkillList}">
							<li><div class="progress progress-bar bg-secondary mb-1 col-2" role="progressbar" style="width: 15%; opacity:0.5;" aria-valuenow="25"></div></li>
						</c:forEach>
					</ul>
				</div>
			</div>


		</div>
	</div>
</div>
