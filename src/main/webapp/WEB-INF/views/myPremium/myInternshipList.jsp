<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>





<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container py-5">
		<div class="card" style="height: auto; min-height: 500px;">

			<div class="card-header">
				<div class="mx-7 mt-5" id="" style="font-size: large;">
					<a href="/myPremium/main"> <b>프리미엄 마이페이지</b>
					</a>
				</div>
			</div>

			<div class="row">

				<div class="col-md-3">
					<div class="card bg-light mx-5 mt-5 p-5"
						style="height: auto; min-height: 300px;">

						<button type="button" class="btn btn-secondary m-2"
							onclick="location.href = '/myPremium/myLectureList' ">강의</button>
						<button type="button" class="btn btn-secondary m-2"
							onclick="location.href = '/myPremium/myInternshipList' ">인턴십</button>
					</div>
				</div>

				<div class="col-md-9 mt-5 px-3 pe-5">

					<div class="card card-plain mb-5">
						<div class="card-body p-5">
							<p id="general-terms" style="font-size: large;">
								<b id="textttt"></b>
							</p>

							<section class="pb-0">

								<div class="container">



									<div class="accordion" id="accordionFaq">
										<div class="accordion-item mb-3">
											<h6 class="accordion-header" id="headingOne">
												<button
													class="accordion-button border-bottom font-weight-bold text-start collapsed"
													type="button" data-bs-toggle="collapse"
													data-bs-target="#collapseOne" aria-expanded="true"
													aria-controls="collapseOne">
													진행중인 인턴십 <i
														class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0"
														aria-hidden="true"></i> <i
														class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0"
														aria-hidden="true"></i>
												</button>
											</h6>
											<div id="collapseOne" class="accordion-collapse collapse show"
												aria-labelledby="headingOne" data-bs-parent="#accordionFaq"
												style="">
												<div class="accordion-body text-sm opacity-8">
													<div class="row">

														<c:forEach var="itnsVO" items="${ing }" varStatus="stat">
															<div class="col-lg-4 col-md-6 px-1">
																<a
																	href="/myPremium/myInternshipDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo}&entNo=${itnsVO.entNo}">
																	<div class="card">
																		<div class="card-body pt-3">
																			<h5>${itnsVO.prmmTitle }</h5>
																			<p>
																				<b>활동기간</b><br />
																				<fmt:formatDate pattern="MM/dd"
																					value="${itnsVO.itnsBgngDt }" />
																				-
																				<fmt:formatDate pattern="MM/dd"
																					value="${itnsVO.itnsEndDt }" />
																			</p>
																		</div>
																	</div>
															</div>
															</a>
														</c:forEach>


													</div>
												</div>
											</div>
										</div>
										<div class="accordion-item mb-3">
											<h6 class="accordion-header" id="headingTwo">
												<button
													class="accordion-button border-bottom font-weight-bold text-start collapsed"
													type="button" data-bs-toggle="collapse"
													data-bs-target="#collapseTwo" aria-expanded="false"
													aria-controls="collapseTwo">
													종료된 인턴십 <i
														class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0"
														aria-hidden="true"></i> <i
														class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0"
														aria-hidden="true"></i>
												</button>
											</h6>
											<div id="collapseTwo" class="accordion-collapse collapse"
												aria-labelledby="headingTwo" data-bs-parent="#accordionFaq"
												style="">
												<div class="accordion-body text-sm opacity-8">
													<div class="row">

														<!-- 반복위치 -->
														<c:forEach var="itnsVO" items="${ended }" varStatus="stat">
															<div class="col-lg-4 col-md-6">
																<a
																	href="/myPremium/myInternshipDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo}&entNo=${itnsVO.entNo}">
																	<div class="card">
																		<div class="card-body pt-3">
																			<h5>${itnsVO.prmmTitle }</h5>
																			<p>
																				<b>활동기간</b><br />
																				<fmt:formatDate pattern="MM/dd"
																					value="${itnsVO.itnsBgngDt }" />
																				-
																				<fmt:formatDate pattern="MM/dd"
																					value="${itnsVO.itnsEndDt }" />
																			</p>
																		</div>
																	</div>
																</a>
															</div>
														</c:forEach>
														<!-- 반복위치 -->

													</div>
												</div>
											</div>
										</div>
									</div>


								</div>
							</section>
						</div>
					</div>
				</div>

			</div>


		</div>
	</div>
</section>


