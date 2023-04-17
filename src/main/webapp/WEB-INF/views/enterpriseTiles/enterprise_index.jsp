<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="apple-touch-icon" sizes="76x76" href="/resources/images/icon/hand-print.png">
<link rel="icon" type="image/png" href="/resources/images/icon/hand-print.png">

<!-- materialKet -->
<!--     Fonts and icons     -->
<link href="https://webfontworld.github.io/NanumSquareNeo/NanumSquareNeo.css" rel="stylesheet">
<!-- Nucleo Icons -->
<link href="/resources/materialKet2/css/nucleo-icons.css" rel="stylesheet" />
<link href="/resources/materialKet2/css/nucleo-svg.css" rel="stylesheet" />
<!-- Font Awesome Icons -->
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<!-- Material Icons -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<!-- CSS Files -->
<link id="pagestyle" href="/resources/materialKet2/css/material-kit-pro.css" rel="stylesheet" />
<!-- 썸머 노트 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<link href="/resources/css/summernote-lite.min.css" rel="stylesheet">
<!--  toast css -->
<link rel="stylesheet" type="text/css" href="/resources/toast/src/toastify.css">
<!-- font 모음 -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_font.css">

<!-- 나눔 폰트 -->
<link rel="stylesheet" type="text/css"	href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-gothic.css" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-round.css" rel="stylesheet">
<!-- 직접 만드는 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_main.css">
<!-- 메인+기본 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_login.css">
<!-- 일반 채용공고 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/jobPosting/jobPosting.css">
<!-- 직접 만든 기업 채용공고 -->
<link rel="stylesheet" type="text/css" href="/resources/css/enterprise/job_posting.css">
<!-- 일반 상세채용공고 -->
<link rel="stylesheet" type="text/css" href="/resources/css/jobPosting/jobPostingDetail.css">
<style type="text/css">
* {
	font-family: 'NanumSquareNeo';
}
</style>

<title>잡아줄게 JAVA로 와요</title>

<!-- jquery-3.6.0.js  -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
</head>


<body class="bg-gray-200" style="height:auto;"><!-- ${body_main}  -->

	<div class="wrapper">

		<!-- Main Sidebar Container aside.jsp 시작 -->
		<tiles:insertAttribute name="enterpriseAside" />
		<!-- Main Sidebar Container aside.jsp 끝 -->


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
		 	<main style="margin-left: 14rem;">
				<!-- ----	---------------- body 시작 -------------------- -->
				<tiles:insertAttribute name="enterpriseBody" />
				<!-- -------------------- body 끝 -------------------- -->
			</main>
		</div>
		<!-- /.content-wrapper -->

		<!-- --------------  footer.jsp 시작 ----------------------- -->
		<tiles:insertAttribute name="enterpriseFooter" />
		<!-- --------------  footer.jsp 끝 ----------------------- -->

	</div>

	<!--   Core JS Files   -->
	<script src="/resources/materialKet2/js/core/popper.min.js" type="text/javascript"></script>
	<script src="/resources/materialKet2/js/core/bootstrap.min.js" type="text/javascript"></script>
	<script src="/resources/materialKet2/js/plugins/perfect-scrollbar.min.js"></script>
	<!--  Plugin for TypedJS, full documentation here: https://github.com/mattboldt/typed.js/ -->
	<script src="/resources/materialKet2/js/plugins/choices.min.js"></script>
	<script src="/resources/materialKet2/js/plugins/flatpickr.min.js"></script>
	<!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
	<script src="/resources/materialKet2/js/plugins/parallax.min.js"></script>
	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="/resources/materialKet2/js/plugins/nouislider.min.js" type="text/javascript"></script>
	<!--  Plugin for the blob animation -->
	<script src="/resources/materialKet2/js/plugins/anime.min.js" type="text/javascript"></script>
	<!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
	<!--  Google Maps Plugin    -->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
	<script src="/resources/materialKet2/js/material-kit-pro.min.js?v=3.0.3" type="text/javascript"></script>

	<!-- toast js -->
	<script src="/resources/toast/src/toastify.js" type="text/javascript"></script>
<!-- 	<script async type="text/javascript" src="//cdn.carbonads.com/carbon.js?serve=CEAIP2QI&placement=apvarungithubio" ></script> -->
<!-- 썸머노트 -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>
<script type="text/javascript">
      if (document.getElementById('inputGroupSelect01')) {
        var element = document.getElementById('inputGroupSelect01');
        const example = new Choices(element, {});
      }
      if (document.getElementById('itnsEntrt-button')) {
    		var element = document.getElementById('itnsEntrt-button');
    		const example = new Choices(element, {});
    	}

</script>
</body>
</html>