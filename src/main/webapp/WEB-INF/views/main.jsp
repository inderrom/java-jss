<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<link rel="stylesheet" href="/resources/css/swiper.css" />

<header	style="margin-bottom: 80px; margin-left: 25px; margin-right: 25px;">
	<div class="page-header min-vh-50" style="border-radius: 10px;"
		loading="lazy">
		<span class="" style="position: absolute; width: 100%; height: 100%;">
			<div class="swiper mySwiper">
				<div class="swiper-wrapper">
					<div class="swiper-slide">
						<div class="card">
							<a href="/jobPosting/detailJobPosting?jobPstgNo=JPNG0017">
								<img alt="sd" src="/resources/images/AD/33Img.png">
							</a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="card">
							<a href="/jobPosting/detailJobPosting?jobPstgNo=JPNG0009">
								<img alt="" src="/resources/images/AD/BMImg.png">
							</a>
						</div>
					</div>
					<div class="swiper-slide">
						<div class="card">
							<a href="/jobPosting/detailJobPosting?jobPstgNo=JPNG0004">
								<img alt="" src="/resources/images/AD/neopleImg.png">
							</a>
						</div>
					</div>
				</div>
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
				<div class="swiper-pagination"></div>
			</div>
		</span>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 mx-auto text-white text-center"></div>
			</div>
		</div>
	</div>
</header>

<!-- 메인 시작-->
<main class="job_posting_main">
	<div class="card-body mx-3 mx-md-4 mt-n6 overflow-hidden">
		<!--  채용공고 시작 -->
		<section class="pt-7 pb-0">
			<div class="container">
				<!-- 무한 스크롤 div -->
				<div class="row">
						<div class="row">
							<div class="col-8 mx-auto text-center mb-5">
								<h5><strong style="font-size:xx-large;" >#${recommList[0].JOB_PSTG_TAG_NM}</strong> 회사들을 모아봤어요</h5>
							</div>
						</div>
					<c:forEach items="${recommList}" var="jobPostingVO">
						<div class="col-lg-4 col-md-6 mb-7  infinite_paging_content">
							<div class="card mt-5 mt-md-0">
								<img src=" /resources/images${jobPostingVO.ATT_NM}" alt="img-blur-shadow" class="img-fluid border-radius-lg jobPosting_size" loading="lazy">

								<div class="card-body pt-3 pointer" onclick="detailPage(this,'${jobPostingVO.JOB_PSTG_NO}')">
									<p class="text-dark mb-2 text-sm NanumSquareNeo">
										<fmt:formatDate pattern="yyyy.MM.dd" value="${jobPostingVO.JOB_PSTG_BGNG_DT}"/> ~
										<fmt:formatDate pattern="yyyy.MM.dd" value="${jobPostingVO.JOB_PSTG_END_DATE}"/>
									</p>
									<h5 class="NanumSquareRoundBold title_height" >${jobPostingVO.JOB_PSTG_TITLE}</h5>
									<p class="NanumSquareRound">${jobPostingVO.ENT_NM}</p>
									<p class="NanumSquareRoundBold">
										<fmt:formatNumber value="${jobPostingVO.JOB_PSTG_PRIZE}" pattern="#,###원" />
									</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<!-- 무한 스크롤 div -->
			</div>
		</section>
	</div>
</main>
<!-- 메인 끝-->

<!-- 슬라이드 -->
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

<script>
// 상세 페이지 이동
function detailPage(el,jobPstgNo) {
	 console.log(el)
	 console.log(jobPstgNo)

	 location.href = "/jobPosting/detailJobPosting?jobPstgNo="+jobPstgNo;
}

let swiper3 = new Swiper(".mySwiper", {
	slidesPerView: 1,
	spaceBetween: 30,
	centeredSlides: true, // 1번 슬라이드가 가운데 보이기
	loop: true,
	pagination: {
	el: ".swiper-pagination",
		clickable: true,
	},
	navigation: {
		nextEl: ".swiper-button-next",
		prevEl: ".swiper-button-prev",
	},
});
</script>