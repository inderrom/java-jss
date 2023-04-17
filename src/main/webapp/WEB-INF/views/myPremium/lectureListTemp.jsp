<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- mandatory scripts -->
<script src="./assets/js/plugins/choices.min.js"></script> 

<!-- Main content -->
<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container">
		<div class="container-fluid">
			<!-- -------------------- body 시작 -------------------- -->
	
			<!-- 여기어 넣으면됨 -->
	
	
			<div class="row">
				<div class="card">
					<div class="col-12">
						<div class="card-header">
							<div class="row">
								<!--  style="float: right;" -->


								<div class="input-group-sm">
									<select class="form-control"
										style="width: 90px; margin-right: 10px;">
										<option>강의</option>
										<option>특강</option>
									</select>
								</div>

								<div class="card-tools">
									<div style="width: 100px;" class="input-group input-group-sm">
										<input type="text" name="table_search"
											class="form-control float-right" placeholder="Search">
										<div class="input-group-append">
											<button type="submit" class="btn btn-default">
												<i class="fas fa-search" aria-hidden="true"></i>
											</button>
										</div>
									</div>
								</div>

							</div>
						</div>

						<div class="card-body table-responsive p-0">
							<table class="table table-hover text-nowrap" style="text-align:center;">
								<thead>
									<tr>
										<th>분류</th>
										<th>강의 제목</th>
										<th>강사</th>
										<th>강의 날짜</th>
										<th>신청 일자</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="prmmVO" items="${data }" varStatus="stat">
											<tr>
												<td>
													<c:if test="${prmmVO.prmmClfc eq 'PRE0001'}">
														<a class="badge badge-success">강의</a>
													</c:if>
													<c:if test="${prmmVO.prmmClfc eq 'PRE0002'}">
														<a class="badge badge-danger">특강</a>
													</c:if>
												</td>
												<td>${prmmVO.prmmTitle}</td>
												<td>${prmmVO.lectureList[0].lctInstrNm}</td>
												<td>
													<c:if test="${prmmVO.prmmClfc eq 'PRE0001'}">
														상시
													</c:if>
													<c:if test="${prmmVO.prmmClfc eq 'PRE0002'}">
														${prmmVO.lectureList[0].lctDt }
													</c:if>
												</td>
												<td><fmt:formatDate pattern="yyyy/MM/dd" value="${prmmVO.prmmRegDt}"/> </td>
												<td>
													<button type="button" class="btn btn-outline-info btn-sm"
															onclick="location.href='/myPremium/lectureDetail?prmmNo=${prmmVO.prmmNo }'">
														수강하기
													</button>
												</td>
											</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
	
						<div class="card-footer ">
							<ul class="pagination pagination-sm m-0 float-right">
								<li class="page-item"><a class="page-link" href="#">«</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">»</a></li>
							</ul>
						</div>
	
					</div>
				</div>
			</div>

			

			<!-- -------------------- body 끝 -------------------- -->
		</div>
	<!-- /.container-fluid -->
	</div>
</section>


<script type="text/javascript">
	if (document.getElementById("choices-button")) {
		var element = document.getElementById("choices-button");
		const example = new Choices(element, {});
	}
</script>
