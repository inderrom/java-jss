<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<c:set var="entVO"  value="${sessionScope.entMemVO }"/>

 <!-- Main Sidebar Container aside.jsp 시작 -->
<style>
</style>
<aside class="main-sidebar sidebar-light-primary elevation-4" style="position: fixed;min-width: 200px;">
	<div>
		<ul class="nav flex-column bg-white border-radius-lg p-3 position-sticky top-10 shadow-lg" style="height: 1300px;">
				<c:if test="${notEnterprise eq 'notEnterprise' }">
					<li class="nav-item px-lg-4 py-lg-2" style="background-color: #ecececb3; border-radius: 10px;">
						<h3 class="text-center" >일반 회원</h3>
					</li>
				</c:if>
				<c:if test="${notEnterprise ne 'notEnterprise' }">
					<li class="nav-item px-lg-4 py-lg-2" style="background-color: #ecececb3; border-radius: 10px;">
						<p><img id="myprofile" src="/resources/images${entVO.ENTLOGOIMGS }" alt="회사 로고사진" class="avatar-xl  border-radius-sm userimage" /></p>
						<h3 style="display: inline-block;vertical-align: -webkit-baseline-middle;">${entVO.ENT_NM }</h3>
						<form name="signform" method="POST" enctype="multipart/form-data" action="/enterprise/entLogoUpdate">
						    <input type="file" id="entlogoimgs" name="entlogoimgs" style="display:none;" onchange="changeValue(this)" />
						    <input type="hidden" name = "target_url" />
						    <input type="hidden" name="entNo" value="${entVO.ENT_NO}" />
							<sec:csrfInput/>
						</form>
						<hr style="color: #808080b3;"/>
						담당자 : ${entVO.ENT_PIC_NM }
			</li>
				</c:if>
			<li>
				<ul class="nav flex-column bg-white p-3">
				<c:if test="${notEnterprise eq 'notEnterprise' }">
					<li class="nav-item my-menu-list" data-menunm="기업 정보 수정">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="#">
							<i class="material-icons text-dark opacity-5 pe-2">info</i>기업 서비스 가입
						</a>
					</li>
				</c:if>
					<c:if test="${notEnterprise ne 'notEnterprise' }">
					<li class="nav-item my-menu-list" data-menunm="지원자 관리">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="/enterprise/getApplyList">
							<i class="material-icons text-dark opacity-5 pe-2">face</i>지원자 관리
						</a>
					</li>
					<li class="nav-item my-menu-list" data-menunm="기업 정보 수정">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="/enterprise/enterpriseDetail">
							<i class="material-icons text-dark opacity-5 pe-2">info</i>기업 정보 수정
						</a>
					</li>
					<li class="nav-item my-menu-list" data-menunm="내 면접제안">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="/enterprise/job_posting">
							<i class="material-icons text-dark opacity-5 pe-2">view_list</i>채용공고 리스트
						</a>
					</li>
					<li class="nav-item my-menu-list" data-menunm="내 프리미엄">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="/matching/list">
							<i class="material-icons text-dark opacity-5 pe-2">connect_without_contact</i>매칭
						</a>
					</li>
					<li class="nav-item my-menu-list" data-menunm="내 커뮤니티">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="/enterprise/prmmMain">
							<i class="material-icons text-dark opacity-5 pe-2">workspace_premium</i>인턴십 관리
						</a>
					</li>
				</c:if>
					<li class="nav-item my-menu-list" data-menunm="내 기록">
						<a class="nav-link text-dark text-bold d-flex align-items-center my-md-3" data-scroll=""  href="/java/">
							<i class="material-icons text-dark opacity-5 pe-2">home</i>JAVA 홈
						</a>
					</li>
				</ul>
			<li>
		</ul>
	</div>
</aside>

<script type="text/javascript">
$(function(){
	$("#myprofile").on("click", function(e){
	    document.signform.target_url.value = document.querySelector( '#myprofile' ).src;
	    e.preventDefault();
	    $('#entlogoimgs').click();
	});
});

function changeValue(obj){
    document.signform.submit();
}
</script>
  <!-- Main Sidebar Container aside.jsp 끝 -->