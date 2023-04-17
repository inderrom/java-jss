<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>




<nav class="main-header navbar navbar-expand navbar-white navbar-light">
	<!-- Left navbar links -->
	<ul class="navbar-nav">
		<a class="nav-link" data-widget="pushmenu" href="#" role="button">
			<i class="fas fa-bars"></i>
		</a>
		<li class="nav-item d-none d-sm-inline-block">
			<a href="/admin/nomalList" class="nav-link">Manager Page</a>
		</li>
	</ul>

	<!-- Right navbar links -->
	<ul class="navbar-nav ml-auto">
		<!-- Notifications Dropdown Menu -->
		<li class="nav-item">
			<a class="nav-link" data-widget="fullscreen" href="#" role="button"> 
				<i class="fas fa-expand-arrows-alt"></i>
			</a>
		</li>
	</ul>
</nav>