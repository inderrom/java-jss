<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript">
$(function(){
	var boardBtns = document.querySelectorAll('.boardBtn');
	var boardNo = "";

	boardBtns.forEach(
		function(boardBtn) {
			boardBtn.addEventListener('click', function(event) {
			boardNo = event.target.id.replace('board-', '');
			window.boardNo = boardNo;
			console.log(boardNo);
			location.href = "/admin/boardDetail?boardNo="+boardNo;
		});
	});

	$('.btn-tool[title="edit"]').click(function() {
		 boardNo = $(this).closest('tr').find('.boardBtn ').attr('id').split('-')[1];
		console.log(boardNo);
		location.href = "/admin/boardModify?boardNo="+boardNo;
	});

	$('.btn-tool[title="Remove"]').click(function() {
		boardNo = $(this).closest('tr').find('.boardBtn ').attr('id').split('-')[1];
		console.log(boardNo);
		var boardType = "";
		var isDel = confirm("삭제하시겠습니까");
		if(isDel > 0){
			alert("삭제되었습니다.")
			location.href = "/admin/boardDelete?boardNo="+boardNo+"&boardType=BRDCL0002";
		}
	});


	$("#createNotice").on("click",function(){
		location.href = "/admin/createBoard?boardType=BRDCL0002";
	});



});
</script>

<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">게시판 관리</h1>
			</div>

		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<div class="card-12">
				<div class="card">
					<div class="card-header">
						<h3 class="card-title">FaQ 목록</h3>
					</div>
					<div class="card-body">
						<div class="card-body">
							<form>
								<div class="row">
									<div class="col-md-2">
										<select class="form-control" id="sel1" name = "searchType">
											<option value="title" <c:if test="${param.searchType == 'title' }"><c:out value="selected"/></c:if>>제목</option>
											<option value="id" <c:if test="${param.searchType == 'id' }"><c:out value="selected"/></c:if>>아이디</option>
										</select>
									</div>
									<div class="col-md-6">
										<input type="text" placeholder="검색어를 입력해주세요" class=" form-control form-control-md"
											   name = "keyword" value="${param.keyword}"/>
									</div>
									<div class="col-md-2">
										<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
									</div>
									<div class="col-2">
										<button type="button" class="btn btn-block btn-outline-info" id="createNotice">FaQ 등록</button>
									</div>
								</div>
							</form>
						</div>
						<div class="row">
							<table class="table table-head-fixed text-nowrap">
								<thead>
									<tr style="text-align: center;">
										<th style="width: 100px">번호</th>
										<th style="width: 200px">아이디</th>
										<th>제목</th>
										<th style="width: 100px">작성일</th>
										<th style="width: 170px">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="boardVo" items="${data.content}"
										varStatus="stat">
										<tr style="text-align: center;">
											<td>${boardVo.rnum}</td>
											<td>${boardVo.memId}</td>
											<td><a type="button" class="boardBtn" id="board-${boardVo.boardNo}">${boardVo.boardTitle}</a></td>
											<td><fmt:formatDate value="${boardVo.boardRegDt}"
													pattern="yyyy-MM-dd" /></td>
											<td>${boardVo.boardInqCnt}
												<div style="float: right;">
													<button type="button" class="btn btn-tool" title="edit"
														onclick="location.href='/admin/editCumuDetail'">
														<i class="fa-solid fa-pen-to-square"></i>
													</button>
													<button type="button" class="btn btn-tool deleteBtn"
														title="Remove" id="removeBtn">
														<i class="fas fa-times"></i>
													</button>
												</div>
											</td>
										</tr>
									</c:forEach>
									<c:if test="${data.total == 0}">
										<td colspan="5" style="text-align: center;">검색된 게시글이
											없습니다.</td>
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
									<a href="/admin/faqBoard?currentPage=${data.startPage-10}&keyword=${param.keyword}&searchType=${param.searchType}"
								       aria-controls="dataTable" data-dt-idx="0" tabindex="0"
								        class="page-link">Previous</a>
								</li>
								<c:set var="currentPage" value="${not empty param.currentPage ? param.currentPage : 1}" />
								<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
									<li class="paginate_button page-item <c:if test='${currentPage eq pNo}'> active</c:if>">
										<a href="/admin/faqBoard?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
										   aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link"> ${pNo} </a>
									</li>
								</c:forEach>
								<li class="paginate_button page-item next
								<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>" id="dataTable_next">
									<a href="/admin/faqBoard?currentPage=${data.startPage+10}&keyword=${param.keyword}&searchType=${param.searchType}"
									   aria-controls="dataTable" data-dt-idx="7"
									   tabindex="0" class="page-link"> Next </a>
								</li>
							</ul>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>