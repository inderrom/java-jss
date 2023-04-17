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
					<button type="button" class="btn btn-info interviewBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">면접 제안하기</button>
					<button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal"><i class="fas fa-times"></i></button>
				</div>
			</div>
		</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-lg-11">
					<h2 id="detailMemNm" style="margin-left: 10px;">${resumeVO.memNm}</h2>
					<h6 style="color: grey; margin-left: 10px;" id="detailRsmUrl">
						링크 : <a href="${resumeVO.rsmUrl}" target='_blank'>${resumeVO.rsmUrl}</a>
					</h6>
					<h6 style="color: grey; margin-left: 10px;" id="detailMemTelno">
						연락처 : ${resumeVO.memTelno}<br />
						<br />
					</h6>
					<p style="color: grey; margin-left: 10px;" id="detailRsmAboutMe">
						${fn:replace(fn:replace(fn:escapeXml(resumeVO.rsmAboutMe), CRLF, '<br/>'), LF, '<br/>')}
					</p>
				</div>
<!-- 				<div class="col-lg-1"> -->
<!-- 					<span id="wantSpnModalID" class="wantSpnModal"> -->
<%-- 						<button type="button" data-input="ilikeyou" class="btn btn-block btn-outline-info btn-flat" style="border-radius: 50%;" data-rsmno="${resumeVO.rsmNo}"> --%>
<%-- 							<img id="imgWantSpnModal${resumeVO.rsmNo}" alt="star2" src="/resources/images/star2.png"> --%>
<!-- 						</button> -->
<!-- 					</span> -->
<!-- 				</div> -->
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
										<li style="color: grey; ">
											[${resumeVO.careerVOList[stat.index].achievementVOList[0].achTitle}]
											<br/><span style="color: grey;"><i>${resumeVO.careerVOList[stat.index].achievementVOList[0].achContent}</i></span>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-3" style="margin: auto;">
								<ul>
									<li><strong> <fmt:formatDate
												value="${beforeList.crrJncmpDt}" type="both" pattern="yy" />.
											<fmt:formatDate value="${beforeList.crrJncmpDt}" type="both"
												pattern="MM" /> - <fmt:formatDate
												value="${beforeList.crrRtrmDt}" type="both" pattern="yy" />.
											<fmt:formatDate value="${beforeList.crrRtrmDt}" type="both"
												pattern="MM" />
									</strong></li>
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
						<li><strong>수상</strong></li>
					</ul>
				</div>
				<div id="detailAwards" class="col-lg-10">
					<c:forEach var="awardsVOList" items="${resumeVO.awardsVOList}" varStatus="stat">
						<ul>
							<li><strong>${awardsVOList.awrdNm}</strong></li>
							<li style="color: grey;">${awardsVOList.awrdInfo}</li>
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
							<li><strong>${languageVOList.lanNm}</strong></li>
							<li style="color: grey;">${languageVOList.lanLevel}</li>
							<li style="color: grey;">
								${languageVOList.languageScoreVOList[stat.index].lscoNm}
								<c:if test="${languageVOList.languageScoreVOList[stat.index].lscoScore != null }"> | ${languageVOList.languageScoreVOList[stat.index].lscoScore }</c:if>
							</li>
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
							<li><strong>${mySkillList.mySklNm }</strong></li>
						</c:forEach>
					</ul>
				</div>
			</div>

		</div>
	</div>
</div>
