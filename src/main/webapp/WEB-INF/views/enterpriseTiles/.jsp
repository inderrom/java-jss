<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- Main Sidebar Container aside.jsp 시작 -->
  

<aside class="main-sidebar sidebar-dark-primary elevation-4">
	<!-- Brand Logo -->
	<a href="index3.html" class="brand-link"> 
		<img src="/resources/adminlte3/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" 
		     class="brand-image img-circle elevation-3" style="opacity: .8"> 
		<span class="brand-text font-weight-light">AdminLTE 3</span>
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class="user-panel mt-3 pb-3 mb-3 d-flex">
			<div class="image">
				<img src="/resources/adminlte3/dist/img/user2-160x160.jpg"
					class="img-circle elevation-2" alt="User Image">
			</div>
			<div class="info">
				<a href="#" class="d-block">관리자</a>
			</div>
		</div>

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				
				<li class="nav-item">
					<a href="#" class="nav-link"> 
						<p>
							일반 회원 관리 <i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="/admin/nomalList" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>일반회원 목록</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="/admin/blockList" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>차단회원 목록</p>
							</a>
						</li>
					</ul>
				</li>
				
				<li class="nav-item">
					<a href="/admin/firm" class="nav-link"> 
						<p>
							기업회원 관리 <i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="/admin/firmList" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>기업회원 목록</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="/admin/permitRequest" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>기업회원 승인 요청</p>
							</a>
						</li>
					</ul>
				</li>
				
				<li class="nav-item">
					<a href="#" class="nav-link"> 
						<p>
							게시판 관리 <i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="/admin/noticeBoard" class="nav-link"> 
									<i class="far fa-circle nav-icon"></i>
								<p>공지사항</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="/admin/faqBoard" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>FAQ</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="/admin/questBoard" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>문의사항</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="/admin/manageCumunity" class="nav-link">
								<i class="far fa-circle nav-icon"></i>
								<p>커뮤니티 관리</p>
							</a>
						</li>
					</ul>
				</li>
				
				
				
				<li class="nav-item">
					<a href="/admin/checkAccount" class="nav-link">
						<p>계좌 관리</p>
					</a>
				</li>

				<li class="nav-item">
					<a href="#" class="nav-link"> 
						<p>
							프리미엄 관리 <i class="right fas fa-angle-left"></i>
						</p>
					</a>
					<ul class="nav nav-treeview">
						<li class="nav-item">
							<a href="#" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>특강/인턴십 목록</p>
							</a>
						</li>
						<li class="nav-item">
							<a href="#" class="nav-link"> 
								<i class="far fa-circle nav-icon"></i>
								<p>인턴십 승인 요청목록</p>
							</a>
						</li>
					</ul>
				</li>
				
				<li class="nav-item">
					<a href="/admin/reportList" class="nav-link">
						<p>신고 목록</p>
					</a>
				</li>


			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>
  <!-- Main Sidebar Container aside.jsp 끝 -->