<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.memVO" var="memVO"/>
</sec:authorize>


<!-- header 시작-->
<div class="header">
	<div class="headerBox">
		<nav class="MainBar_MainBar_nav__kwHBF">
			<div class="headerLeftBox inlineBlock">
				<img class="logoSize" src="/resources/images/icon/hand-print.png" />
				<a class="menuA" href="/java/">JOB LUV</a>
			</div>
			<div class="inlineBlock">
				<div class="flex inlineBlock">
					<a class="menuA" href="/jobPosting/main">채용</a>
					<a class="menuA" href="/java/jobpartment" >JOB화점</a> 
					<a class="menuA" href="/mem/myResume" >이력서</a>
					<a class="menuA" href="/board/boardList?boardClfcNo=BRDCL0003" >커뮤니티</a>
					<a class="menuA" href="/premium/main">프리미엄</a>
				</div>
			</div>

			<div class="inlineBlock headerRightBox">

				<div class="inlineBlock boxItem">
					<sec:authorize access="isAuthenticated()">
						<a class="dropdown-item border-radius-md NanumSquareRoundBold profile_Name" 
							<sec:authorize access="hasRole('ROLE_NORMAL')">href="javascript:location.href='/mem/myPage'"</sec:authorize> >${memVO.memNm} 님</a>
					</sec:authorize>
				</div>
				<div class="inlineBlock" style="vertical-align: super;">
					<div class="dropdown">
						<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
							<img alt="" class="avatar avatar-xs shadow border-radius-lg" src="/resources/images/icon/free-icon-profile-4519729.png" />
						</button>

						<ul class="dropdown-menu px-2 py-3" aria-labelledby="dropdownMenuButton">
							<sec:authorize access="isAnonymous()">
								<li><a class="dropdown-item border-radius-md" href="javascript:location.href='/login'">로그인</a></li>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_NORMAL')">
								<li><a class="dropdown-item border-radius-md" href="javascript:location.href='/mem/myPage'">마이페이지</a></li>
								<li><a class="dropdown-item border-radius-md" href="javascript:logout();">로그아웃</a></li>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ENTERPRISE')">
								<li><a class="dropdown-item border-radius-md" href="javascript:logout();">로그아웃</a></li>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<li><a class="dropdown-item border-radius-md" href="javascript:location.href='/admin/nomalList'">관리페이지</a></li>
								<li><a class="dropdown-item border-radius-md" href="javascript:logout();">로그아웃</a></li>
							</sec:authorize>
						</ul>
						<div class="headerButton inlineBlock boxItem">
							<a class="headerBut" href="/enterprise/main">기업 서비스</a>
						</div>
					</div>
				</div>
			</div>
		</nav>
	</div>
</div>

<!-- header 끝-->
