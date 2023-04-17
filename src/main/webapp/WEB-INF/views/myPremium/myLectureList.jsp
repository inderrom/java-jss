<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container py-5">
		<div class="card pb-5" style="height: auto; min-height: 500px;">

			<div class="mx-7 mt-5" id="" style="font-size: large;">
				<a href="/myPremium/main"> <b>프리미엄 마이페이지</b>
				</a>
			</div>

			<div class="card blur mb-3 mt-6"
					style="height: auto; min-height: 50px; text-align: center;">
				<p class="mb-0" style="font-size: large;">
					<b>강의 학습방</b>
				</p>
			</div>



			<div c lass="row">
					
				<div class="col-lg-3 mb-lg-0 mb-5 mt-8 mt-md-5 mt-lg-0">
					
					<div class="nav flex-column bg-white border-radius-lg p-3 ms-5 bg-light position-sticky top-10 shadow-lg" style="height:auto; min-height:500;">

							<div class="nav-item my-md-4" style="text-align: center;">

								<div>
									<button type="button" class="btn btn-secondary m-2 w-90" 
										onclick="location.href = '/myPremium/myLectureList' ">강의</button>
								</div>
								<div>
									<button type="button" class="btn btn-secondary m-2 w-90" 
										onclick="location.href = '/myPremium/myInternshipList' ">인턴십</button>
								</div>
								<div class="mt-6">
									<a href="/myPremium/main "> 프리미엄 마이페이지 <i class="fas fa-arrow-right text-sm ms-1" aria-hidden="true"></i>
									</a>
								</div>
								<div>
									<a href="/mem/myPage"> 마이페이지 <i class="fas fa-arrow-right text-sm ms-1" aria-hidden="true"></i>
									</a>
								</div>
							</div>
						</div>
					
				</div>

				<div class="col-lg-8">
					<div class="card-body table-responsive p-0">
						<table class="table table-hover text-nowrap" style="vertical-align:middle;">
							<thead>
								<tr>
									<th class="w-20"></th>
									<!-- 이미지 -->
									<th>강의</th>
									<th>강의 날짜</th>
									<!-- 										<th>신청 일자</th> -->
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="prmmVO" items="${data }" varStatus="stat">
									<tr>
										<td>
											<div>
												<img class="w-60 border-radius-md shadow-lg" 
													src="/resources/images/icon/hand-print.png"
													alt="image">
											</div>
										</td>
										<td >
											<c:if test="${prmmVO.prmmClfc eq 'PRE0001'}">
												<a class="badge badge-success  me-2">강의</a>
											</c:if> <c:if test="${prmmVO.prmmClfc eq 'PRE0002'}">
												<a class="badge badge-danger  me-2">특강</a>
											</c:if>
											${prmmVO.prmmTitle}
										</td>
										<td class="ps-4"><c:if test="${prmmVO.prmmClfc eq 'PRE0001'}">
														상시
													</c:if> <c:if test="${prmmVO.prmmClfc eq 'PRE0002'}">
														${prmmVO.lectureList[0].lctDt }
													</c:if>
										</td>
										<td class="text-center">
											<button type="button" class="btn btn-outline-info btn-sm" 
												onclick="location.href='/myPremium/mylectureDetail?prmmNo=${prmmVO.prmmNo }'"
												style="width:70px;">
												강의실 입장
											</button>
											<form action="/myPremium/deletemyLecture" method="post">
												<input type="hidden" name="etpId" value="${prmmVO.prmmNo }" />
												<button type="submit" class="btn btn-outline-danger btn-sm"
														style="width:70px;">
													수강 취소
												</button>
												<sec:csrfInput/>
											</form>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
	
			</div>




		</div>
	</div>
</section>





