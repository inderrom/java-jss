<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function(){
	$(".postBtn").on("click",function(){
		console.log(this.getAttribute("data-jobPstgNo"));
		let jobPostNo = this.getAttribute("data-jobPstgNo");
		location.href = "/admin/jobPostingDetail?jobPstgNo="+jobPostNo;
	});

	$("#sel2").on("change",function(){
		$("#frm").submit();
	});

});
</script>


<div class="content-header">
	<h5>채용공고 관리</h5>
</div>

<div class="card">
	<div class="card-headr" style="padding: 20px;">
		<form id="frm">
			<div class="row">
				<div class="col-2">
					<select class="form-control" id="sel2" name = "isPermit">
						<option value="allThing" <c:if test="${param.isPermit == 'allThing' }"><c:out value="selected"/></c:if>>전체</option>
						<option value="permit" <c:if test="${param.isPermit == 'permit' }"><c:out value="selected"/></c:if>>승인</option>
						<option value="noPermit" <c:if test="${param.isPermit == 'noPermit' }"><c:out value="selected"/></c:if>>미승인</option>
					</select>
				</div>
				<div class="col-2">
					<select class="form-control" id="sel1" name = "searchType">
						<option value="entNm" <c:if test="${param.searchType == 'entNm' }"><c:out value="selected"/></c:if>>기업명</option>
						<option value="title" <c:if test="${param.searchType == 'title' }"><c:out value="selected"/></c:if>>제목</option>
					</select>
				</div>
				<div class="col">
					<input type="text" placeholder="검색어를 입력해주세요" class=" form-control form-control-md"
						   name = "keyword" value="${param.keyword}"/>
				</div>
				<div class="col-2">
					<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
				</div>
			</div>
		</form>
	</div>
	<div class="card-body">
		<div class="row">
			<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr style="text-align: center;">
						<th style="width: 100px">번호</th>
						<th style="width: 200px">기업 명</th>
						<th>제목</th>
						<th style="width: 100px">시작 일</th>
						<th style="width: 100px">종료 일</th>
						<th>승인 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="jobPostingVo" items="${data.content}" varStatus="stat">
						<tr style="text-align: center;">
							<td>${jobPostingVo.rnum }</td>
							<td>${jobPostingVo.entNm }</td>
							<td><a type="button" class="postBtn"  data-jobPstgNo="${jobPostingVo.jobPstgNo}">${jobPostingVo.jobPstgTitle }</a></td>
							<td>${jobPostingVo.jobPstgBgngDt}</td>
							<td>${jobPostingVo.jobPstgEndDate}</td>
							<c:if test="${jobPostingVo.jobPstgAprvYn=='Y'}">
								<td>승인 됨</td>
							</c:if>
							<c:if test="${jobPostingVo.jobPstgAprvYn=='N'}">
								<td>미 승인</td>
							</c:if>
						</tr>
					</c:forEach>
					<c:if test="${data.total == 0}">
						<td colspan="6" style="text-align: center;">검색된 게시글이 없습니다.</td>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
	<div class="card-footer clearfix">
		<c:if test='${data.total != 0 }'>
			<ul class="pagination justify-content-center">
			 	<li class="paginate_button page-item previous
				<c:if test='${data.startPage lt 11 }'>disabled</c:if>"
					id="dataTable_previous">
					<a href="/admin/jobPostingList?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}&isPermit=${param.isPermit}"
				       aria-controls="dataTable" data-dt-idx="0" tabindex="0"
				        class="page-link">Previous</a>
				</li>
				<c:set var="currentPage" value="${not empty param.currentPage ? param.currentPage : 1}" />
				<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
					<li class="paginate_button page-item <c:if test='${currentPage eq pNo}'> active</c:if>">
						<a href="/admin/jobPostingList?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}&isPermit=${param.isPermit}"
						   aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link"> ${pNo} </a>
					</li>
				</c:forEach>
				<li class="paginate_button page-item next
				<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>" id="dataTable_next">
					<a href="/admin/jobPostingList?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}&isPermit=${param.isPermit}"
					   aria-controls="dataTable" data-dt-idx="7"
					   tabindex="0" class="page-link"> Next </a>
				</li>
			</ul>
		</c:if>
	</div>
</div>
