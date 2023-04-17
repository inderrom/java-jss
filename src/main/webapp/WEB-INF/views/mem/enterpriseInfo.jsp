<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>
<style>
.tagbtn{
	border-radius: 20px;
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
							<div class="row pt-3">
								<div class="col-lg-7">
									<img id="myprofile" src="/resources/images${entMap.ENTLOGOIMGS }" alt="${entMap.ENTLOGOIMGS }" class="avatar-xxl" />
									<h2 id="memId" class="ps-3" style="display: inline-block;vertical-align: middle;">${entMap.ENT_NM}</h2>
								</div>
								<div class="col-lg-5">
									<!-- 태그 반복문 돌릴 위치 -->
									<c:forEach items="${tagList}" var="tag">
										<button type="button" class="btn bg-gradient-light w-auto me-2 tagbtn">#${tag}</button>
									</c:forEach>
									<!-- 태그 반복문 돌릴 위치 -->
								</div>
							</div>
						</div>
						<div class="card-body">
							<section>
								<!-- 채용공고 리스트 부분 -->
								<div class="card-body">
									<p class="h3 font-weight-normal">채용중인 포지션</p>

									<!-- 공고리스트 반복문 돌릴 위치 -->
									<c:forEach items="${jobPstgVOList}" var="jobPstgVO" varStatus="jobPstgSts" step="2">
										<c:if test="${jobPstgVO.jobPstgAprvYn ne 'N'}">
											<div class="row" style="justify-content: space-evenly;">
												<div class="col m-3 p-3" style="border: 1px solid #808080b3;" onclick="javascript:location.href='/jobPosting/detailJobPosting?jobPstgNo=${jobPstgVO.jobPstgNo}';">
													<h4>
														${jobPstgVOList[jobPstgSts.index].jobPstgTitle}<hr/>
														<small style="font-size:70%; color: gray;">채용보상금 <fmt:formatNumber pattern="###,###" value="${jobPstgVOList[jobPstgSts.index].jobPstgPrize}"></fmt:formatNumber>원</small><br/>
														<small style="font-size:80%;">
														<c:if test="${jobPstgVOList[jobPstgSts.index].jobPstgEndDate ne null}">
															${jobPstgVOList[jobPstgSts.index].jobPstgBgngDt} ~ ${jobPstgVOList[jobPstgSts.index].jobPstgEndDate}
														</c:if>
														<c:if test="${jobPstgVOList[jobPstgSts.index].jobPstgEndDate eq null}">
															상시채용
														</c:if>
														</small>
													</h4>
												</div>
												<div class="col m-3 p-3" style="border: 1px solid #808080b3; <c:if test="${jobPstgSts.index +1 ge jobPstgVOList.size()}">visibility: hidden; </c:if>" onclick="javascript:location.href='/jobPosting/detailJobPosting?jobPstgNo=${jobPstgVOList[jobPstgSts.index +1].jobPstgNo}';">
													<h4>
														${jobPstgVOList[jobPstgSts.index +1].jobPstgTitle}<hr/>
														<small style="font-size:70%; color: gray;">채용보상금 <fmt:formatNumber pattern="###,###" value="${jobPstgVOList[jobPstgSts.index +1].jobPstgPrize}"></fmt:formatNumber>원</small><br/>
														<small style="font-size:80%;">
														<c:if test="${jobPstgVOList[jobPstgSts.index +1].jobPstgEndDate ne null}">
															${jobPstgVOList[jobPstgSts.index +1].jobPstgBgngDt} ~ ${jobPstgVOList[jobPstgSts.index +1].jobPstgEndDate}
														</c:if>
														<c:if test="${jobPstgVOList[jobPstgSts.index +1].jobPstgEndDate eq null}">
															상시채용
														</c:if>
														</small>
													</h4>
												</div>
											</div>
										</c:if>
									</c:forEach>
									<!-- 공고리스트 반복문 돌릴 위치 -->

								</div>
								<!-- 채용공고 리스트 부분 -->

								<!-- 회사 소개 부분 -->
								<div id="ent-info">
									<div class="row py-4">
										<div class="col-lg-12">
											<div class="card-body ms-xxl-4">
												<p class="h3 font-weight-normal">회사 소개</p>

												<div class="filter-container p-0 mb-8 row">
													<div class="filter-container p-0 row" style="padding: 3px; position: relative; width: 100%; display: flex; flex-wrap: wrap; height: 50px;">
														<div class="filtr-item col-sm-2" data-category="1" data-sort="white sample" style="opacity: 1; transform: scale(1) translate3d(0px, 0px, 0px);
															backface-visibility: hidden; perspective: 1000px; transform-style: preserve-3d; position: absolute; width: 138.4px;
															transition: all 0.5s ease-out 0ms, width 1ms ease 0s;">
															<a href="/resources/images${entMap.ENTLOGOIMGS }" data-toggle="lightbox" data-title="sample 1 - white">
																<img src="/resources/images${entMap.ENTLOGOIMGS }" alt="img-fluid mb-2" style="width: 250px; height: 150px;"/>
															</a>
														</div>
														<div class="filtr-item col-sm-2" data-category="2,4" data-sort="white sample" style="opacity: 1; transform: scale(1) translate3d(26	0px, 0px, 0px);
															backface-visibility: hidden; perspective: 1000px; transform-style: preserve-3d; position: absolute; width: 138.4px;
															transition: all 0.5s ease-out 0ms, width 1ms ease 0s;">
															<a href="/resources/images${entMap.ENTPRSIMGS }" data-toggle="lightbox" data-title="sample 1 - white">
																<img src="/resources/images${entMap.ENTPRSIMGS }" alt="img-fluid mb-2" style="width: 250px; height: 150px;"/>
															</a>
														</div>
													</div>
												</div>

												<div>
													<!-- 회사 소개 부분 가져와서 끊기 -->
													<p id="summary">
														<span class="fs-5 fw-bold" >${fn:substring(fn:replace(fn:replace(fn:escapeXml(entMap.ENT_DESCRIPTION), CRLF, '<br/>'), LF, '<br/>'), 0, 80)}</span>
														${fn:substring(fn:replace(fn:replace(fn:escapeXml(entMap.ENT_DESCRIPTION), CRLF, '<br/>'), LF, '<br/>'), 80, 1000)}
													</p>
												</div>

											</div>
										</div>
									</div>
								</div>
								<!-- 회사 소개 부분 -->

								<!-- 회사 정보 부분 -->
								<div id="count-stats">
									<div class="row py-4">
										<div class="col-lg-12">
											<div class="card-body">
												<div class="card-body">
													<div class="row">
														<div class="col-lg-6">
															<h5>평균 연봉</h5>
															<blockquote class="blockquote p-sm-3 bg-gray-100 mb-0 ps-sm-5">
																<div class="col-lg-3">
																	<small>전체 평균</small>
																</div>
																<div>
																	<h3 class="text-gradient text-info" id="h3Annual">
																		<span id="annual" countto="0"></span>
																		<small>만원</small>
																	</h3>
																</div>
															</blockquote>
														</div>
														<div class="col-lg-6">
															<h5>사원</h5>
															<blockquote class="blockquote p-sm-3 bg-gray-100 mb-0 ps-sm-5">
																<div>
																	<small>사원 수</small>
																</div>
																<div>
																	<h3 class="text-gradient text-info" id="h3Employee">
																		<span id="employee" countto="0"></span>
																		<small>명</small>
																	</h3>

																</div>
															</blockquote>
															<br/>
														</div>

													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- 회사 정보 부분 -->

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
<script>
$.ajax({
	async: false,
	url: "/api/dartEmpSttus",
	data: {"corp_code": "${cmcdVO.cmcdDtlNm}",
		   "bsns_year": "2022",
		   "reprt_code": "11011"},
	type: "post",
	beforeSend : function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
 	},
	success: function(result){
		console.log(result);
		console.log(result.list);

		if(result.status=="013"){
			$("#h3Annual").html("정보 없음");
			$("#h3Employee").html("정보 없음");
		}else{
			let sumSalary = 0;
			let sumSm = 0;
			$.each(result.list, function(i, v){
				if(v.fo_bbm === '성별합계'){
					sumSalary += parseInt(v.jan_salary_am.replaceAll(",", ""));
					sumSm += parseInt(v.sm.replaceAll(",", ""));
					console.log(sumSalary);
					console.log(sumSm);
					document.getElementById('annual').setAttribute("countTo", sumSalary / 10000 / 2);
					document.getElementById('employee').setAttribute("countTo", sumSm);
				}

			});
		}
	}
});
</script>

<script type="text/javascript">
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
      if (document.getElementById('annual')) {
        const countUp1 = new CountUp('annual', document.getElementById("annual").getAttribute("countTo"));
        if (!countUp1.error) {
          countUp1.start();
        } else {
          console.error(countUp1.error);
        }
      }
      if (document.getElementById('employee')) {
        const countUp2 = new CountUp('employee', document.getElementById("employee").getAttribute("countTo"));
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
