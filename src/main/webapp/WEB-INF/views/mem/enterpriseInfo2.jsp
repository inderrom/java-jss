<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<script type="text/javascript">
$(function(){
	let jsmemId = "${memVO.memId}";
	
	$.ajax({
		url:"/mem/memSearch",
		data: {"memId": jsmemId},
		type:"post",
		beforeSend : function(xhr) {
		       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
		   console.log(result);
		   $("#myprofile").attr("src", "/resources/images"+result.attNm);
		   if(result.crrYear == "0" || result.crrYear == null){
			   $("#crrYear").text("신입");
		   }else{
			   $("#crrYear").text(result.crrYear+"년차");
		   }
		}
	});
});
</script>
<style>
.tagbtn{
	border-radius: 20px;
	font-size: 60%;
	width: auto;
	display: inline-block;
	vertical-align: bottom;
}
</style>
<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="card shadow-lg">
						<div class="card-header" style="border-bottom: 1px solid #808080b3">
							<div class="row">
								<div class="col-lg-6">
									<img id="myprofile" src="" alt="..." class="avatar-xxl" />
									<h4 id="memId" class="ps-3" style="display: inline-block;vertical-align: middle;">${memVO.memNm }</h4>
								</div>
								<div class="col-lg-6">
									<p><b>태그</b></p>
									<!-- 태그 반복문 돌릴 위치 -->
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#인원급성장</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#51~300명</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#설립4~9년</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#출산휴가</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#스타트업</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#식비</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#음료</button>
									<button type="button" class="btn btn-block btn-outline-secondary tagbtn">#간식</button>
									<!-- 태그 반복문 돌릴 위치 -->
								</div>
							</div>
						</div>
						<div class="card-body">
							<section>
								<!-- 채용공고 리스트 부분 -->
								<div class="row">
									<div class="col-lg-12">
										<div class="card-body">
											<p><b>채용중인 포지션</b></p>
											
											<!-- 공고리스트 반복문 돌릴 위치 -->
											<div class="row">
												<div class="col-lg-5 m-3 p-3" style="border: 1px solid black;">	
													<div class="row">
														<div class="col-lg-10">
															<h5>iOS Developer<br/><small style="font-size:60%; color: gray;">채용보상금 1,000,000원</small></h5>
															<small>상시 채용</small>
														</div>
														<div class="col-lg-1 m-sm-auto">
															<i class="material-icons">bookmark_border</i>
														</div>
													</div>
												</div>
												<div class="col-lg-5 m-3 p-3" style="border: 1px solid black;">	
													<div class="row">
														<div class="col-lg-10">
															<h5>iOS Developer<br/><small style="font-size:60%; color: gray;">채용보상금 1,000,000원</small></h5>
															<small>상시 채용</small>
														</div>
														<div class="col-lg-1 m-sm-auto">
															<i class="material-icons">bookmark_border</i>
														</div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-lg-5 m-3 p-3" style="border: 1px solid black;">	
													<div class="row">
														<div class="col-lg-10">
															<h5>iOS Developer<br/><small style="font-size:60%; color: gray;">채용보상금 1,000,000원</small></h5>
															<small>상시 채용</small>
														</div>
														<div class="col-lg-1 m-sm-auto">
															<i class="material-icons">bookmark_border</i>
														</div>
													</div>
												</div>
												<div class="col-lg-5 m-3 p-3" style="border: 1px solid black;">	
													<div class="row">
														<div class="col-lg-10">
															<h5>iOS Developer<br/><small style="font-size:60%; color: gray;">채용보상금 1,000,000원</small></h5>
															<small>상시 채용</small>
														</div>
														<div class="col-lg-1 m-sm-auto">
															<i class="material-icons">bookmark_border</i>
														</div>
													</div>
												</div>
											</div>
											<!-- 공고리스트 반복문 돌릴 위치 -->
											
											<button type="button" class="btn btn-default btn-block" style="width: 88%;">더 많은 포지션 보기</button>
										</div>
									</div>
								</div>
								<!-- 채용공고 리스트 부분 -->
								<div id="count-stats">
								<!-- 회사 소개 부분 -->
								<div class="row py-4">
									<div class="col-lg-12">
										<div class="card-body">
											<p><b>회사 소개</b></p>
											<div class="filter-container p-0 row">
												<div class="filter-container p-0 row" style="padding: 3px; position: relative; width: 100%; display: flex; flex-wrap: wrap; height: 50px;">
													<div class="filtr-item col-sm-2" data-category="1" data-sort="white sample" style="opacity: 1; transform: scale(1) translate3d(0px, 0px, 0px); backface-visibility: hidden; perspective: 1000px; transform-style: preserve-3d; position: absolute; width: 138.4px; transition: all 0.5s ease-out 0ms, width 1ms ease 0s;">
														<a href="/resources/images/hyundai.jpg?text=1" data-toggle="lightbox" data-title="sample 1 - white">
															<img class="avatar-xxl" src="/resources/images/hyundai.jpg?text=1" alt="img-fluid mb-2"/>
														</a>
													</div>
													<div class="filtr-item col-sm-2" data-category="2, 4" data-sort="black sample" style="opacity: 1; transform: scale(1) translate3d(141px, 0px, 0px); backface-visibility: hidden; perspective: 1000px; transform-style: preserve-3d; position: absolute; width: 138.4px; transition: all 0.5s ease-out 0ms, width 1ms ease 0s;">
														<a href="/resources/images/naver.png" data-toggle="lightbox" data-title="sample 2 - black">
															<img class="avatar-xxl" src="/resources/images/naver.png" class="img-fluid mb-2" alt="black sample">
														</a>
													</div>
													<div class="filtr-item col-sm-2" data-category="3, 4" data-sort="red sample" style="opacity: 1; transform: scale(1) translate3d(282px, 0px, 0px); backface-visibility: hidden; perspective: 1000px; transform-style: preserve-3d; position: absolute; width: 138.4px; transition: all 0.5s ease-out 0ms, width 1ms ease 0s;">
														<a href="/resources/images/kakao.jpg?" data-toggle="lightbox" data-title="sample 3 - red">
															<img class="avatar-xxl" src="/resources/images/kakao.jpg" class="img-fluid mb-2" alt="red sample">
														</a>
													</div>
													<div class="filtr-item col-sm-2" data-category="3, 4" data-sort="red sample" style="opacity: 1; transform: scale(1) translate3d(423px, 0px, 0px); backface-visibility: hidden; perspective: 1000px; transform-style: preserve-3d; position: absolute; width: 138.4px; transition: all 0.5s ease-out 0ms, width 1ms ease 0s;">
														<a href="/resources/images/daangn.png?" data-toggle="lightbox" data-title="sample 4 - red">
															<img class="avatar-xxl" src="/resources/images/daangn.png?" class="img-fluid mb-2" alt="red sample">
														</a>
													</div>
												</div>
											</div>
											<br/><br/><br/>
											
											<div>
												<!-- 회사 소개 부분 가져와서 끊기 -->
												<small>
													"데이터와 기술을 통해 화장품 시장을 어떻게 혁신할 수 있을까?"
													<br/>
													화해는 이 질문에 대한 답을 찾아가고 있어요.
												</small>
												<small id="moreDetail-Info" style="display: none;">
													<br/><br/>
													화해는 데이터와 기술을 바탕으로 16조의 거대한 화장품 시장에 존재하는 정보 비대칭 문제를 해결하여 소비자의 힘을 키우고, 이를 통해 다양한 브랜드가 선택받을 수 있는 기회를 확대해서, 소비자가 중심이 되면서도 다양성을 가진 시장구조로 화장품 시장을 혁신하고자 해요.
													<br/><br/>
													화장품 시장에 정보는 많지만, 실상 구매에 도움이 되지 않거나 신뢰할 수 없는 정보들이 대다수이지 않은가요? 이마저도 여러 군데에 파편화되어 있고 정보 탐색 도구는 열악한 상태죠. 화해는 이렇게 화장품을 구매하는데 필요한 정보들을 충분히 얻지 못한 상황을 정보 비대칭 문제가 있다고 판단하고, 이 문제들을 하나씩 해결해가고 있어요. 그리고 이를 더 많은 브랜드가 소비자에게 알려질 수 있는 기회로 연결하고 있어요.
													<br/><br/>
													200명의 구성원들이 모여 이렇게 화장품 시장의 혁신을 만들어가면서, 화해는 1000만 명이 다운로드 받고 130만 명이 매 월 사용하는(MAU) '1위 모바일 뷰티 플랫폼' 이 되었어요. 그리고 730만 리뷰, 25만 개의 전성분이 포함된 제품 정보 등 차별화된 데이터를 화장품 업계에서 가장 독보적인 수준으로 확보하고 있어요. 더불어, 연평균 80% 이상의 매출 성장을 이루면서도 영업이익을 만들어내며 건강하게 성장하고 있어요. (23/03 기준)
													<br/><br/>
													이를 인정한 7개의 회사로부터 지금까지 총 86억 원의 투자를 받았고, NICE 그룹의 신사업 부문 자회사로서 독립적인 경영을 보장받아 안정적인 환경에서 빠르게 성장하고 있답니다.
													<br/><br/>
													화해팀은 앞으로도 계속해서 소비자의 힘을 키우고, 거대한 화장품 시장을 혁신하고, 해외 시장에 한국 브랜드들의 존재감이 커질 수 있도록 만들어 갈거에요. 우리와 함께 이 꿈을 실현해 갈 동료를 찾고 있어요!
												</small>
												<!-- 회사 소개 부분 가져와서 끊기 -->
												<br/>
												<a id="moreDetail" style="color: gray;" data-input="open" ><small>+ 더보기</small></a>
											</div>
										</div>
									</div>
								</div>
								<!-- 회사 소개 부분 -->
								
								<!-- 회사 정보 부분 -->
								<div class="row py-4">
									<div class="col-lg-12">
										<div class="card-body">
											<div class="card-body">
												<div class="row">
													<div class="col-lg-6">
														<p><b>평균 연봉</b></p>
														<blockquote class="blockquote p-sm-3 bg-gray-100 mb-0">
															<div class="col-lg-3">
																<small>신입 입사자</small>
															</div>
															<div>
																<h3 class="text-gradient text-info">
																	<span id="starting_first" countto="4">4</span>,<span id="starting_second" countto="319">319</span>
																	<small>만원</small>
																</h3>
															</div>
														</blockquote>
														<br/>
														<blockquote class="blockquote p-sm-3 bg-gray-100 mb-0">
															<div class="col-lg-3">
																<small>전체 평균</small>
															</div>
															<div>
																<h3 class="text-gradient text-info">
																	<span id="annual_first" countto="5">5</span>,<span id="annual_second" countto="739">739</span>
																	<small>만원</small>
																</h3>
															</div>
														</blockquote>
													</div>
													<div class="col-lg-6">
														<p><b>사원</b></p>
														<blockquote class="blockquote p-sm-3 bg-gray-100 mb-0 text-center">
															<div>
																<small>입사자 수</small>
															</div>
															<div>
																<h3 class="text-gradient text-info">
																	<span id="memberIn" countto="215">215</span>
																	<small>명</small>
																</h3>
																
															</div>
														</blockquote>
														<br/>
														<blockquote class="blockquote p-sm-3 bg-gray-100 mb-0 text-center">
															<div>
																<small>퇴사자 수</small>
															</div>
															<div>
																<h3 class="text-gradient text-info">
																	<span id="memberOut" countto="30">30</span>
																	<small>명</small>
																</h3>
																
															</div>
														</blockquote>
													</div>
													
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- 회사 정보 부분 -->
								
								</div>
								
							</section>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</main>
  <script src="/resources/materialKet2/js/plugins/countup.min.js"></script>
<script src="/resources/materialKet2/js/plugins/typedjs.js"></script>
<script type="text/javascript">
$(function(){
	$("#moreDetail").on("click", function(){
		if($(this).data("input") == "open"){
			$(this).data("input", "close");
			$(this).find("small").text("- 접기");
			$("#moreDetail-Info").show();
		}else{
			$(this).data("input", "open");
			$(this).find("small").text("+ 더보기");
			$("#moreDetail-Info").hide();
		}
	});
	
});

// get the element to animate
var element = document.getElementById('count-stats');
var elementHeight = element.clientHeight;

// listen for scroll event and call animate function

document.addEventListener('scroll', animate);

// check if element is in view
function inView() {
  // get window height
  var windowHeight = window.innerHeight;
  // get number of pixels that the document is scrolled
  var scrollY = window.scrollY || window.pageYOffset;
  // get current scroll position (distance from the top of the page to the bottom of the current viewport)
  var scrollPosition = scrollY + windowHeight;
  // get element position (distance from the top of the page to the bottom of the element)
  var elementPosition = element.getBoundingClientRect().top + scrollY + elementHeight;

  // is scroll position greater than element position? (is element in view?)
  if (scrollPosition > elementPosition) {
    return true;
  }

  return false;
}

var animateComplete = true;
// animate element when it is in view
function animate() {

  // is element in view?
  if (inView()) {
    if (animateComplete) {
      if (document.getElementById('starting_second')) {
        const countUp = new CountUp('starting_second', document.getElementById("starting_second").getAttribute("countTo"));
        if (!countUp.error) {
          countUp.start();
        } else {
          console.error(countUp.error);
        }
      }
      if (document.getElementById('starting_first')) {
        const countUp = new CountUp('starting_first', document.getElementById("starting_first").getAttribute("countTo"));
        if (!countUp.error) {
          countUp.start();
        } else {
          console.error(countUp.error);
        }
      }
      if (document.getElementById('annual_first')) {
        const countUp1 = new CountUp('annual_first', document.getElementById("annual_first").getAttribute("countTo"));
        if (!countUp1.error) {
          countUp1.start();
        } else {
          console.error(countUp1.error);
        }
      }
      if (document.getElementById('annual_second')) {
        const countUp1 = new CountUp('annual_second', document.getElementById("annual_second").getAttribute("countTo"));
        if (!countUp1.error) {
          countUp1.start();
        } else {
          console.error(countUp1.error);
        }
      }
      if (document.getElementById('memberIn')) {
        const countUp2 = new CountUp('memberIn', document.getElementById("memberIn").getAttribute("countTo"));
        if (!countUp2.error) {
          countUp2.start();
        } else {
          console.error(countUp2.error);
        };
      }
      if (document.getElementById('memberOut')) {
        const countUp2 = new CountUp('memberOut', document.getElementById("memberOut").getAttribute("countTo"));
        if (!countUp2.error) {
          countUp2.start();
        } else {
          console.error(countUp2.error);
        };
      }
      animateComplete = false;
    }
  }
}

if (document.getElementById('typed')) {
  var typed = new Typed("#typed", {
    stringsElement: '#typed-strings',
    typeSpeed: 90,
    backSpeed: 90,
    backDelay: 200,
    startDelay: 500,
    loop: true
  });
}
</script>
  <script>
    if (document.getElementsByClassName('page-header')) {
      window.onscroll = debounce(function() {
        var scrollPosition = window.pageYOffset;
        var bgParallax = document.querySelector('.page-header');
        var oVal = (window.scrollY / 3);
        bgParallax.style.transform = 'translate3d(0,' + oVal + 'px,0)';
      }, 6);
    }
  </script>