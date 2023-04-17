<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- Main Sidebar Container aside.jsp 시작 -->

<style>
.lfpd{
	padding-left: 15px;
}
</style>
<aside class="main-sidebar elevation-4 sidebar-light-maroon">
	<!-- Brand Logo -->
	<a href="/java/" class="brand-link">
		<img src="/resources/images/icon/hand-print.png" alt="AdminLTE Logo"
		     class="brand-image img-circle elevation-3" style="opacity: .8">
		<span class="brand-text font-weight-light">JOB LUV</span>
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<div class="user-panel mt-3 pb-3">
			<h5 style="margin: auto;text-align: center;">운영자</h5>
		</div>

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">

				<li class="nav-item menu-open">
					<a href="#" class="nav-link" onclick="activeClick(this)">
						<i class="material-icons" style="width: 25px;">account_circle</i>일반회원 관리 <i class="right fas fa-angle-left"></i>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item lfpd">
							<a href="/admin/nomalList" class="nav-link" onclick="activeClick(this)" style="">
								<i class="material-icons" style="width: 25px;">face</i>일반회원
							</a>
						</li>
<!-- 						<li class="nav-item lfpd"> -->
<!-- 							<a href="/admin/blockList" class="nav-link" onclick="activeClick(this)"> -->
<!-- 								<i class="material-icons" style="width: 25px;">block</i>차단회원 -->
<!-- 							</a> -->
<!-- 						</li> -->
<!-- 						<li class="nav-item lfpd"> -->
<!-- 							<a href="/admin/reportList" class="nav-link" onclick="activeClick(this)"> -->
<!-- 								<i class="material-icons" style="width: 25px;">report</i>신고회원 -->
<!-- 							</a> -->
<!-- 						</li> -->
					</ul>
				</li>

				<li class="nav-item menu-open">
					<a href="/admin/firm" class="nav-link">
						<i class="material-icons" style="width: 25px;">business</i>기업회원 관리 <i class="right fas fa-angle-left"></i>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item lfpd">
							<a href="/admin/firmList" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">format_list_bulleted</i>기업회원
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/permitRequest" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">approval</i>승인요청
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/jobPostingList" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">list_alt</i>채용공고
							</a>
						</li>
					</ul>
				</li>

				<li class="nav-item menu-open">
					<a href="#" class="nav-link">
						<i class="material-icons" style="width: 25px;">note_alt</i>게시판 관리 <i class="right fas fa-angle-left"></i>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item lfpd">
							<a href="/admin/noticeBoard" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">notifications_active</i>공지사항
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/faqBoard" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">contact_support</i>FAQ
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/questBoard" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">help_center</i>문의사항
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/manageCumunity" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">question_answer</i>커뮤니티
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/reportBoard" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">report</i>신고
							</a>
						</li>
					</ul>
				</li>

				<li class="nav-item menu-open">
					<a href="#" class="nav-link">
						<i class="material-icons" style="width: 25px;">business</i>프리미엄 관리 <i class="right fas fa-angle-left"></i>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item lfpd">
							<a href="/admin/premiumList" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">ondemand_video</i>강의/특강
							</a>
						</li>
						<li class="nav-item lfpd">
							<a href="/admin/internshipRequestList" class="nav-link" onclick="activeClick(this)">
								<i class="material-icons" style="width: 25px;">handshake</i>인턴십
							</a>
						</li>
					</ul>
				</li>
				<li class="nav-item menu-open">
					<a href="/admin/statistics" class="nav-link">
						<i class="material-icons" style="width: 25px;">business</i>통계 <i class="right fas fa-angle-left"></i>
					</a>
				</li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>
  <!-- Main Sidebar Container aside.jsp 끝 -->
  <script>
  function activeClick(el) {
	  console.log(el)
	  el.classList.toggle("active")
}
  </script>