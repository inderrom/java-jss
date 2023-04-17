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
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="/resources/materialKet2/css/nucleo-icons.css" rel="stylesheet" />
  <link href="/resources/materialKet2/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="/resources/materialKet2/css/material-kit-pro.css" rel="stylesheet" />



<!--  toast css -->
<link rel="stylesheet" type="text/css" href="/resources/toast/src/toastify.css">


<!-- font 모음 -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_font.css">

<!-- 나눔 폰트 -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css">

<!-- 직접 만드는 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_main.css">
<!-- 메인+기본 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_login.css">

<!-- 채용공고 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/jobPosting/jobPosting.css">

<title>잡아줄게 JAVA로 와요</title>

<!-- jquery-3.6.0.js  -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
</head>

<body class="body_main" style="height:auto;"><!-- ${body_main}  -->
	<div class="wrapper">

		<!-- ---------------- Navbar header.jsp 시작 ---------------- -->
		
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
					<a class="menuA" href="/board/boardList?boardClfcNo=BRDCL0003" >커뮤니티</a>
					<a class="menuA" href="/premium/main">프리미엄</a>
				</div>
			</div>

			<div class="inlineBlock headerRightBox">
				<div class="inlineBlock boxItem">
					<input id="searchImg" type="image" class="iconSize " data-bs-target="#offcanvasTop" aria-controls="offcanvasTop" data-bs-toggle="offcanvas"
							src="/resources/images/icon/baseline_search_black_24dp.png" />
				</div>
				<div class="inlineBlock" style="vertical-align: super;">
					<div class="dropdown">
						<button class="btn dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
							<img class="avatar avatar-xs shadow border-radius-lg"" src="/resources/images/icon/free-icon-profile-4519729.png" />
						</button>
						<ul class="dropdown-menu px-2 py-3" aria-labelledby="dropdownMenuButton">
							<sec:authorize access="isAnonymous()">
								<li><a class="dropdown-item border-radius-md" href="javascript:location.href='/login'">로그인</a></li>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<li><a class="dropdown-item border-radius-md" href="javascript:location.href='/mem/myPage'">마이페이지</a></li>
								<li><a class="dropdown-item border-radius-md" href="javascript:logout();">로그아웃</a></li>
							</sec:authorize>
						</ul>
					</div>
				</div>
				<div class="headerButton inlineBlock boxItem">
					<a class="headerBut" href="/enterprise/main">기업 서비스</a>
				</div>
			</div>
		</nav>
	</div>
</div>

<!-- header 끝-->
		
		
		
		<!-- ---------------- /.navbar header.jsp 끝----------------  -->



			<!-- Main content -->
			<section class="content" style="margin-top: 50px;">
				<div class="container-fluid">
					<!-- -------------------- body 시작 -------------------- -->
					
					
					
					
					
					<section class="pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="row">
		
		<!-- aside 영역 -->
			<tiles:insertAttribute name="admin_aside" />		
		<!-- aside 영역 -->
			
			
			
			
		<!-- body 영역 -->	
		<div class="col-lg-8">
			<tiles:insertAttribute name="admin_body" />
		</div>
		<!-- body 영역 -->
			
			
			
			
			
		</div>
	</div>
</section>
					
					
					
					
					
					
					
					
					
					
					
					<!-- -------------------- body 끝 -------------------- -->
				</div>
			</section>

		<!-- --------------  footer.jsp 시작 ----------------------- -->
		
		<footer>
		<p>마음이 잡잡할때 JAVA</p>
		</footer>

		<!-- --------------  footer.jsp 끝 ----------------------- -->







	</div>




	<!-- 검색 모달창 -->
<div class="offcanvas offcanvas-top " style="height: max-content;" tabindex="-1" id="offcanvasTop" aria-labelledby="offcanvasTopLabel" >
  <div class="offcanvas-body serachBarContainer">
    <!-- 검색용 form태그-->
    <form > 
      <input class="serachBar" type="text" value="" placeholder="검색어를 입력해주세요" />
      <svg xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18" class="serachSvg"><defs><path id="qt2dnsql4a" d="M15.727 17.273a.563.563 0 10.796-.796l-4.875-4.875-.19-.165a.563.563 0 00-.764.028 5.063 5.063 0 111.261-2.068.562.562 0 101.073.338 6.188 6.188 0 10-1.943 2.894l4.642 4.644z"></path></defs><g fill="none" fill-rule="evenodd"><use fill="#333" fill-rule="nonzero" stroke="#333" stroke-width=".3" xlink:href="#qt2dnsql4a"></use></g></svg>
    </form>
      
        <h4 class="serachLog">최근 검색 기록</h4>  
        <button type="button" class="AllSerachLogDelete delete_btn_design" data-attribute-id="search__deleteHistory">전체삭제</button>

        <ul class="serachUl">

          <!-- js로 추가 삭제-->
          <li class="serachWord">
            <a href="" class="" aria-label="">백엔드</a>
            <button type="button" class="serachWordBtn delete_btn_design">
              <span class="SvgIcon_SvgIcon__root__8vwon"><svg class="SvgIcon_SvgIcon__root__svg__DKYBi" viewBox="0 0 24 24">
                  <path d="M5.93289 4.6068C5.56201 4.33162 5.03569 4.36219 4.69935 4.69853C4.32938 5.0685 4.32938 5.66834 4.69935 6.03831L10.6611 12L4.69935 17.9617L4.60763 18.0679C4.33244 18.4388 4.36302 18.9651 4.69935 19.3015L4.80561 19.3932C5.17649 19.6684 5.7028 19.6378 6.03914 19.3015L12.0009 13.3402L17.9626 19.3015L18.0688 19.3932C18.4397 19.6684 18.966 19.6378 19.3023 19.3015C19.6723 18.9315 19.6723 18.3317 19.3023 17.9617L13.3406 12L19.3023 6.03831L19.3941 5.93206C19.6693 5.56118 19.6387 5.03487 19.3023 4.69853L19.1961 4.6068C18.8252 4.33162 18.2989 4.36219 17.9626 4.69853L12.0009 10.6598L6.03914 4.69853L5.93289 4.6068Z">
                  </path>
                </svg></span></button></li>

        </ul>

  </div>
</div>
<!-- 검색 모달창 끝 -->






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
<script async type="text/javascript" src="//cdn.carbonads.com/carbon.js?serve=CEAIP2QI&placement=apvarungithubio" ></script>

<script type="text/javascript">
if (document.getElementById('choices-button')) {
	var element = document.getElementById('choices-button');
	const example = new Choices(element, {});
}
if (document.getElementById('lanSearch')) {
	var element = document.getElementById('lanSearch');
	const example = new Choices(element, {});
}
if (document.getElementById('lanLevel')) {
	var element = document.getElementById('lanLevel');
	const example = new Choices(element, {});
}

var choicesTags = document.getElementById('choices-tags');
var color = choicesTags.dataset.color;

if(choicesTags) {
	const example = new Choices(choicesTags, {
		delimiter: ',',
		editItems: true,
		maxItemCount: 10,
		removeItemButton: true,
		addItems: true,
		classNames: {
			item: 'badge rounded-pill choices-' + color + ' me-2'
		}
	});
}
function logout(){
	let name = "${_csrf.parameterName}";
	let value = "${_csrf.token}";
	let input = document.createElement("input");
	input.type = "hidden";
	input.name = name;
	input.value = value;
	
	let form = document.createElement("form");
	form.method = "post";
	form.action = "/logout";
	
	form.append(input);
	document.body.append(form);
	
	form.submit();
}
</script>

</body>
</html>