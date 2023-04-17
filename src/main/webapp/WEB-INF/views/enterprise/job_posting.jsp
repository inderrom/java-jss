<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



    <!-- Main content -->
    <section class="content " style="margin-left: 4.3rem;margin-right: 4.3rem;     padding-top: 7rem;">
      <div class="container-fluid">
        <!-- -------------------- body 시작 -------------------- -->
<div class="card">


	<div class="card-body" >
		<div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="row">

				<!-- 검색 기능 js로 만들어짐 -->
					<div class="card-header" >
						<h3 class="card-title" style="margin-top: 7px;">채용공고 리스트 <a href="/enterprise/job_posting_insert" class="btn btn-block bg-gradient-primary" style="width: 100px; float: right;">등록</a></h3>
					</div>

			</div>
			<div class="row">
				            <table class="table align-items-center mb-0">
				              <thead>
				                <tr>
				                  <th class="text-center text-uppercase text-secondary font-weight-bolder">승인 여부</th>
				                  <th class="text-center text-uppercase text-secondary font-weight-bolder">제목</th>
				                  <th class="text-center text-uppercase text-secondary font-weight-bolder">채용 시작일</th>
				                  <th class="text-center text-uppercase text-secondary font-weight-bolder">채용 마감일</th>
				                </tr>
				              </thead>
				              <tbody>
				              <c:if test="${jobPostingList.content.size() == 0}">
				              <tr >
					              <td colspan="4" style="text-align: center;">
					              등록하신 채용공고가 없습니다. <a href="/enterprise/job_posting_insert" class="btn btn-outline-success NanumGothic" style="margin: 0px;">채용공고를 등록(클릭)</a>
					              </td>
				              </tr>
				              </c:if>
							<c:forEach items="${jobPostingList.content}" var="jobPostingVO" varStatus="sta">

				 				<tr>
				                  <td class="text-center">
				                    <div class="px-2 py-1 text-center">
				                    	 <c:if test="${jobPostingVO.jobPstgAprvYn =='Y'}">
											<span class="badge bg-success">승인</span>
										</c:if>
										<c:if test="${jobPostingVO.jobPstgAprvYn =='N'}">
											<span class="badge bg-danger">미승인</span>
										</c:if>
				                    </div>
				                  </td>

				                  <td class="text-center">
				                    <c:if test="${jobPostingVO.jobPstgAprvYn =='Y'}">
										<a href="/enterprise/Detail?jobPstgNo=${jobPostingVO.jobPstgNo}">${jobPostingVO.jobPstgTitle}</a>
<%-- 										<td>${jobPostingVO.jobPstgTitle}</td> --%>
									</c:if>
									<c:if test="${jobPostingVO.jobPstgAprvYn =='N'}">
										<a href="/enterprise/Detail?jobPstgNo=${jobPostingVO.jobPstgNo}">${jobPostingVO.jobPstgTitle}</a>
									</c:if>
				                  </td>

				                  <td class="align-middle text-center ">
				                    	<span class="startDt">${jobPostingVO.jobPstgBgngDt}</span>
				                  </td>

				                  <td class="align-middle text-center">
				                     <span class="endDt">${jobPostingVO.jobPstgEndDate}</span>
				                  </td>

				                </tr>
			               	 </c:forEach>
			                 <tbody>

				            </table>
			<!-- 페이징 -->
			<div class="row mt-5 mb-3">
				<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
				    <li class="page-item ">
				      <a class="page-link <c:if test="${jobPostingList.startPage lt 6}">disabled</c:if>"      href="/enterprise/job_posting_pagination?total=${jobPostingList.total}&currentPage=${jobPostingList.endPage-5}" tabindex="-1" >
				        <i class="fa fa-angle-left"></i>
				        <span class="sr-only">Previous</span>
				      </a>
				    </li>


				    <c:forEach var="jobPostingNo" begin="${jobPostingList.startPage}" end="${jobPostingList.endPage}" varStatus="sta">
					    <li class="page-item <c:if test="${jobPostingList.currentPage ==jobPostingNo }">active</c:if>">
						    <a class="page-link" href="/enterprise/job_posting_pagination?total=${jobPostingList.total}&currentPage=${jobPostingNo}">${jobPostingNo}</a>
					    </li>
				    </c:forEach>


				    <li class="page-item">
				      <a class="page-link <c:if test="${jobPostingList.endPage ge jobPostingList.totalPages}">disabled</c:if>" href="/enterprise/job_posting_pagination?total=${jobPostingList.total}&currentPage=${jobPostingList.startPage+5}" >
				        <i class="fa fa-angle-right" ></i>
				        <span class="sr-only">Next</span>
				      </a>
				    </li>
				  </ul>
				</nav>
			</div>

			</div>
			</div>
			<!-- 이 어딘가 동적으로 페이징 생성됨 -->
		</div>
	</div>



        <!-- -------------------- body 끝 -------------------- -->
      </div><!-- /.container-fluid -->
 </section>
<script>
date_conversion();

function date_conversion() {

	const startDtElements = document.querySelectorAll('.startDt');

	startDtElements.forEach(function(startDtElement,index) {
		startDtValue =startDtElement.textContent;
		startDtElement.textContent= startDtValue.substring(0,10);
	});// end forEach

	const endDtElements = document.querySelectorAll('.endDt');

	endDtElements.forEach(function(endDtElement,index) {
		endDtValue =endDtElement.textContent;
		endDtElement.textContent= endDtValue.substring(0,10);
	});// end forEach
}; //end date_conversion
</script>