<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />

<div id="${cmntVO.itnsCmmuCmntNo }" class="row align-items-center p-3">
	<div class="col">
		<!-- 프로필 사진 등록 여부 체크 -->
		<c:choose>
			<c:when test="${cmntVO.attNm != null}">
				<img src="/resources/images${cmntVO.attNm}" alt="프로필" class="avatar shadow border-radius-lg" />
			</c:when>
			<c:otherwise>
				<img src="/resources/images/icon/hand-print.png" alt="프로필" class="avatar shadow border-radius-lg" />
			</c:otherwise>
		</c:choose>
		<!-- 프로필 사진 등록 여부 체크 -->
		${cmntVO.memNm}
	</div>
	
	<div class="col-9 px-5 cmntCont">
		${cmntVO.itnsCmmuCmntContent}
	</div>
	
	<div class="col text-end">
		<c:if test="${memVO.memId eq cmntVO.memId }">
			<a class="text-end cmntDelete" data-cmmucmntno="${cmntVO.itnsCmmuCmntNo }">
				<i class="material-icons text-dark opacity-5">clear</i>
			</a>
		</c:if>
	</div>
</div>
