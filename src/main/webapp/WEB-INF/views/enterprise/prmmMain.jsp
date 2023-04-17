<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />


<style>
#cke_entDescription {
	width: 90%;
}

label {
	width: 150px;
	font-size: unset;
}

input {
	width: 300px;
}

.msskill {
	border-radius: 20px;
	font-size: 60%;
	width: auto;
	display: inline-block;
	vertical-align: bottom;
}

.card_main {
	height: auto;
	min-height: 200px;
}

td{
border-spacing: 0px;
}

</style>


<div class="col-md-11 pt-sm-5 container-fluid kanban">
	<div class="card-body  mt-6">
		<!-- Start Navbar -->
		<ul class="nav nav-pills nav-fill p-1" role="tablist">
			<li class="nav-item">
				<a class="nav-link text-md mb-0 px-0 py-1 active"
				data-bs-toggle="tab" href="#itnsAll" role="tab"
				aria-controls="itnsAll" aria-selected="true">
				전체
			</a></li>
			<li class="nav-item">
				<a class="nav-link text-md mb-0 px-0 py-1"
				data-bs-toggle="tab" href="#itnsIng" role="tab"
				aria-controls="itnsIng" aria-selected="false">
				진행중
			</a></li>
			<li class="nav-item">
				<a class="nav-link mb-0 px-0 py-1"
				data-bs-toggle="tab" href="#itnsPlanned" role="tab"
				aria-controls="itnsPlanned" aria-selected="false">
				시작예정
			</a></li>
			<li class="nav-item"><a class="nav-link mb-0 px-0 py-1"
				data-bs-toggle="tab" href="#itnsEnded" role="tab"
				aria-controls="itnsEnded" aria-selected="false">
				 종료
			</a></li>
		</ul>
		<!-- End Navbar -->


		<div class="tab-content" style="height: auto; min-height: 300px;">
			<!-- 전체 -->
			<div class="tab-pane active" id="itnsAll">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 500px;">
						<div class="row px-4 text-end">
							<div class="col">
								<button type="button" id="itnsInsertBtn" onclick="location.href='/enterprise/prmmRgstItns?entNo=${entVO.ENT_NO}'" class="btn bg-gradient-info btn-md text-md" style="float: right;">등록</button>
							</div>
						</div>
						<div class="row justify-content-center">
							<table class="table align-items-center mb-0" style="table-layout:fixed;">
								<thead>
									<tr>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:10%">진행상황</th>
										<th class="text-uppercase text-secondary text-md font-weight-bolder  ps-5" >인턴십 제목</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:12%">시작일</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:12%">종료일</th>
										<th class="text-secondary opacity-7" style="width:15%"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="itnsVO" items="${data }" varStatus="stat">
										<tr class="detailBtn">
											<td class="align-middle text-center">
												<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsBgngDt }" var="itnsBgngDt"/>
												<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsEndDt }" var="itnsEndDt"/>
												<c:choose>
													<c:when test="${itnsVO.itnsAprvYn == 'Y' }">
														<c:if test="${itnsVO.itnsBgngDt > now and itnsVO.itnsEndDt > now}">
															<span class="badge badge-md text-md badge-danger">
																예정
															</span>
														</c:if>
														<c:if test="${itnsBgngDt <= today and itnsEndDt >= today}">
															<span class="badge badge-md text-md badge-success">
																진행중
															</span>
														</c:if>
														<c:if test="${itnsVO.itnsBgngDt < now and itnsVO.itnsEndDt < now}">
															<span class="badge badge-md text-md badge-secondary">
																종료
															</span>
														</c:if>
													</c:when>
													<c:otherwise>
<!-- 														<span class="badge badge-md text-md badge-warning"> -->
														<span class="badge text-md bg-gradient-secondary">
															미승인
														</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-wrap">
												<div class="d-flex px-2 py-1 ps-4">
													<div class="d-flex flex-column justify-content-center font-weight-bold">
														<h6>${itnsVO.prmmTitle }</h6>
													</div>
												</div>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsBgngDt}
												</span>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsEndDt }
												</span>
											</td>
											<td class="align-middle text-center">
													<button	type="button" class="btn text-md bg-gradient-info me-2 btn-sm"
														onclick="location.href='/myPremium/myInternshipDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user"
														<c:if test="${itnsVO.itnsAprvYn == 'N'}">
														 disabled
														</c:if>
													>
														입장
													 </button><br>
													<button	type="button" class="btn text-md bg-gradient-light me-2 btn-sm"
														onclick="location.href='/enterprise/prmmDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user">
														상세
													 </button>
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</div>
					</section>
				</div>
			</div>
			<!-- 전체 -->

			<!-- 진행중 -->
			<div class="tab-pane" id="itnsIng">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 500px;">
						<div class="row px-4 text-end">
							<div class="col">
								<button type="button" id="itnsInsertBtn" onclick="location.href='/enterprise/prmmRgstItns?entNo=${entVO.ENT_NO}'" class="btn bg-gradient-info btn-md text-md" style="float: right;">등록</button>
							</div>
						</div>
						<div class="row justify-content-center">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:10%">진행상황</th>
										<th class="text-uppercase text-secondary text-md font-weight-bolder  ps-5" >인턴십 제목</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:12%">시작일</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:12%">종료일</th>
										<th class="text-secondary opacity-7" style="width:15%"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="itnsVO" items="${data }" varStatus="stat">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsBgngDt }" var="itnsBgngDt"/>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsEndDt }" var="itnsEndDt"/>
									<c:if test="${itnsVO.itnsAprvYn == 'Y' and itnsBgngDt <= today and itnsEndDt >= today}">
										<tr class="detailBtn">
											<td class="align-middle text-center">
												<c:choose>
													<c:when test="${itnsVO.itnsAprvYn == 'Y' }">
														<c:if test="${itnsVO.itnsBgngDt > now and itnsVO.itnsEndDt > now}">
															<span class="badge badge-md text-md badge-danger">
																예정
															</span>
														</c:if>
														<c:if test="${itnsBgngDt <= today and itnsEndDt >= today}">
															<span class="badge badge-md text-md badge-success">
																진행중
															</span>
														</c:if>
														<c:if test="${itnsVO.itnsBgngDt < now and itnsVO.itnsEndDt < now}">
															<span class="badge badge-md text-md badge-secondary">
																종료
															</span>
														</c:if>
													</c:when>
													<c:otherwise>
<!-- 														<span class="badge badge-md text-md badge-warning"> -->
														<span class="badge text-md bg-gradient-secondary">
															미승인
														</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-wrap">
												<div class="d-flex px-2 py-1 ps-4">
													<div class="d-flex flex-column justify-content-center">
														<h6>${itnsVO.prmmTitle }</h6>
													</div>
												</div>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsBgngDt}
												</span>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsEndDt }
												</span>
											</td>
											<td class="align-middle text-center">
													<button	type="button" class="btn text-md bg-gradient-info me-2 btn-sm"
														onclick="location.href='/myPremium/myInternshipDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user"
														<c:if test="${itnsVO.itnsAprvYn == 'N'}">
														 disabled
														</c:if>
													>
														입장
													 </button><br>
													<button	type="button" class="btn text-md bg-gradient-light me-2 btn-sm"
														onclick="location.href='/enterprise/prmmDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user">
														상세
													 </button>
											</td>
										</tr>
									</c:if>
									</c:forEach>

								</tbody>
							</table>
						</div>
					</section>
				</div>
			</div>
			<!-- 진행중 -->

			<!-- 시작예정 -->
			<div class="tab-pane" id="itnsPlanned">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 500px;">
						<div class="row px-4 text-end">
							<div class="col">
								<button type="button" id="itnsInsertBtn" onclick="location.href='/enterprise/prmmRgstItns?entNo=${entVO.ENT_NO}'" class="btn bg-gradient-info btn-md text-md" style="float: right;">등록</button>
							</div>
						</div>
						<div class="row justify-content-center">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:10%">진행상황</th>
										<th class="text-uppercase text-secondary text-md font-weight-bolder  ps-5" >인턴십 제목</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:12%">시작일</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:12%">종료일</th>
										<th class="text-secondary opacity-7" style="width:15%"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="itnsVO" items="${data }" varStatus="stat">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsBgngDt }" var="itnsBgngDt"/>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsEndDt }" var="itnsEndDt"/>
									<c:if test="${itnsVO.itnsAprvYn == 'Y' and itnsVO.itnsBgngDt > now and itnsVO.itnsEndDt > now}">
										<tr class="detailBtn">
											<td class="align-middle text-center">
												<c:choose>
													<c:when test="${itnsVO.itnsAprvYn == 'Y' }">
														<c:if test="${itnsVO.itnsBgngDt > now and itnsVO.itnsEndDt > now}">
															<span class="badge badge-md text-md badge-danger">
																예정
															</span>
														</c:if>
														<c:if test="${itnsBgngDt <= today and itnsEndDt >= today}">
															<span class="badge badge-md text-md badge-success">
																진행중
															</span>
														</c:if>
														<c:if test="${itnsVO.itnsBgngDt < now and itnsVO.itnsEndDt < now}">
															<span class="badge badge-md text-md badge-secondary">
																종료
															</span>
														</c:if>
													</c:when>
													<c:otherwise>
<!-- 														<span class="badge badge-md text-md badge-warning"> -->
														<span class="badge text-md bg-gradient-secondary">
															미승인
														</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-wrap">
												<div class="d-flex px-2 py-1 ps-4">
													<div class="d-flex flex-column justify-content-center">
														<h6>${itnsVO.prmmTitle }</h6>
													</div>
												</div>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsBgngDt}
												</span>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsEndDt }
												</span>
											</td>
											<td class="align-middle text-center">
													<button	type="button" class="btn text-md bg-gradient-info me-2 btn-sm"
														onclick="location.href='/myPremium/myInternshipDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user"
														<c:if test="${itnsVO.itnsAprvYn == 'N'}">
														 disabled
														</c:if>
													>
														입장
													 </button><br>
													<button	type="button" class="btn text-md bg-gradient-light me-2 btn-sm"
														onclick="location.href='/enterprise/prmmDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user">
														상세
													 </button>
											</td>
										</tr>
									</c:if>
									</c:forEach>

								</tbody>
							</table>
						</div>
					</section>
				</div>
			</div>
			<!-- 시작예정 -->

			<!-- 종료 -->
			<div class="tab-pane" id="itnsEnded">
				<div class="card card_main d-flex justify-content-center p-5 shadow-lg ">
					<section class="pt-1" style="min-height: 500px;">
						<div class="row px-4 text-end">
							<div class="col">
								<button type="button" id="itnsInsertBtn" onclick="location.href='/enterprise/prmmRgstItns?entNo=${entVO.ENT_NO}'" class="btn bg-gradient-info btn-md text-md" style="float: right;">등록</button>
							</div>
						</div>
						<div class="row justify-content-center">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:10%">진행상황</th>
										<th class="text-uppercase text-secondary text-md font-weight-bolder  ps-5" >인턴십 제목</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:14%">시작일</th>
										<th class="text-center text-uppercase text-secondary text-md font-weight-bolder " style="width:14%">종료일</th>
										<th class="text-secondary opacity-7" style="width:15%"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="itnsVO" items="${data }" varStatus="stat">
									<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsBgngDt }" var="itnsBgngDt"/>
									<fmt:formatDate pattern="yyyy-MM-dd" value="${itnsVO.itnsEndDt }" var="itnsEndDt"/>
									<c:if test="${itnsVO.itnsAprvYn == 'Y' and itnsVO.itnsBgngDt < now and itnsVO.itnsEndDt < now      }">
										<tr class="detailBtn">
											<td class="align-middle text-center">
												<c:choose>
													<c:when test="${itnsVO.itnsAprvYn == 'Y' }">
														<c:if test="${itnsVO.itnsBgngDt > now and itnsVO.itnsEndDt > now}">
															<span class="badge badge-md text-md badge-danger">
																예정
															</span>
														</c:if>
														<c:if test="${itnsBgngDt <= today and itnsEndDt >= today}">
															<span class="badge badge-md text-md badge-success">
																진행중
															</span>
														</c:if>
														<c:if test="${itnsVO.itnsBgngDt < now and itnsVO.itnsEndDt < now}">
															<span class="badge badge-md text-md badge-secondary">
																종료
															</span>
														</c:if>
													</c:when>
													<c:otherwise>
<!-- 														<span class="badge badge-md text-md badge-warning"> -->
														<span class="badge text-md bg-gradient-secondary">
															미승인
														</span>
													</c:otherwise>
												</c:choose>
											</td>
											<td class="text-wrap">
												<div class="d-flex px-2 py-1 ps-4">
													<div class="d-flex flex-column justify-content-center">
														<h6>${itnsVO.prmmTitle }</h6>
													</div>
												</div>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsBgngDt}
												</span>
											</td>
											<td class="align-middle text-center">
												<span class="text-secondary text-md ">
													${itnsEndDt }
												</span>
											</td>
											<td class="align-middle text-center">
													<button	type="button" class="btn text-md bg-gradient-info me-2 btn-sm"
														onclick="location.href='/myPremium/myInternshipDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user"
														<c:if test="${itnsVO.itnsAprvYn == 'N'}">
														 disabled
														</c:if>
													>
														입장
													 </button><br>
													<button	type="button" class="btn text-md bg-gradient-light me-2 btn-sm"
														onclick="location.href='/enterprise/prmmDetail?prmmNo=${itnsVO.prmmNo }&itnsNo=${itnsVO.itnsNo }&entNo=${entVO.entNo}'"
														class="text-secondary font-weight-bold text-md"
														data-toggle="tooltip" data-original-title="Edit user">
														상세
													 </button>
											</td>
										</tr>
									</c:if>
									</c:forEach>

								</tbody>
							</table>
						</div>
					</section>
				</div>
			</div>
			<!-- 종료 -->


		</div>
	</div>
</div>

<script type="text/javascript">

</script>




