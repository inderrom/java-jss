<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>


<div class="card-header" >
	<c:if test="${memVO.memAuth eq 'ROLE_ENTERPRISE' }">
		<a onclick="href='javascript:fn_boardInsert();'" class="btn btn-block bg-gradient-primary" style="width: 100px; float: right;">등록</a>
	</c:if>
</div>
<div id="testboardList" class="card-body">
	<table class="table align-items-center mb-0">
		<thead>
			<tr>
				<th class="text-center text-secondary text-xs">#</th>
				<th class="text-center text-secondary text-xs">제목</th>
				<th class="text-center text-secondary text-xs">작성자</th>
				<th class="text-center text-secondary text-xs">작성일</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${list.content}" var="boardVO" varStatus="status">
				<input type="hidden" id="itnsNo" value="${boardVO.itnsNo}" />
				<c:set var="itnsCmmuTitle" value="${boardVO.itnsCmmuTitle}" />
				<tr id="${boardVO.itnsCmmuNo}" data-itnsno="${boardVO.itnsNo}">
					<td class="align-middle text-center" style="width: 10%;">
						<span class="NanumSquareNeo">${status.count}</span>
					</td>
					<td class="align-middle" style="width: 60%;">
						<p class="NanumSquareNeo font-weight-bold mb-0">

							<c:choose>
								<c:when test="${fn:length(itnsCmmuTitle) ge 50}">
									${fn:substring(itnsCmmuTitle, 0, 50)}...
								</c:when>
								<c:otherwise>
									${itnsCmmuTitle}
								</c:otherwise>
							</c:choose>

						</p>
					</td>
					<td class="align-middle text-center" style="width: 10%;">
						<span class="NanumSquareNeo badge badge-sm badge-success">${boardVO.memNm}</span>
					</td>
					<td class="align-middle text-center" style="width: 10%;">
						<span class="NanumSquareNeo text-secondary text-xs font-weight-bold"><fmt:formatDate pattern="yyyy/MM/dd" value="${boardVO.itnsCmmuRegDt}"/></span>
					</td>
				</tr>
			</c:forEach>

		</tbody>
	</table>
</div>
<div class="card-footer">
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-end">
			<li class="page-item <c:if test='${list.startPage lt size}'>disabled</c:if>">
				<a class="page-link" href="javascript:fn_go_page(${pNo-size});" tabindex="-1">
					<i class="fa fa-angle-left"></i><span class="sr-only">Previous</span>
				</a>
			</li>

			<c:forEach var="pNo" begin="${list.startPage}" end="${list.endPage}">
				<li class="page-item <c:if test='${param.currentPage==pNo}'>active</c:if>">
					<a class="page-link" href="javascript:fn_go_page(${pNo});" >${pNo}</a>
				</li>
			</c:forEach>

			<li class="page-item">
				<a class="page-link <c:if test='${list.startPage+size ge list.totalPages}'>disabled</c:if>" href="javascript:fn_go_page(${pNo+size});" >
					<i class="fa fa-angle-right"></i><span class="sr-only">Next</span>
				</a>
			</li>
		</ul>
	</nav>
</div>

<script type="text/javascript">

function fn_go_page(pageNo) {
	console.log("#fn_go_page itnsNo : " + itnsNo);
	$.ajax({
		
		url : "/myPremium/boardList",
		type : "post",
		data : {"currentPage":pageNo, "itnsNo":itnsNo},
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			console.log(result);
			$("#note").html(result);
		}
	});
}

function fn_boardInsert() {
	console.log("#fn_boardInsert itnsNo : " + itnsNo);
	
	$.ajax({
		url : "/myPremium/boardInsert",
		type : "get",
		data : {"itnsNo":itnsNo},
		success : function(result) {
			console.log(result);
			$("#note").html(result);
		}
	});
}

$(function(){
	$("tr").on("click", function() {
		let itnsCmmuNo = $(this).attr("id");
		console.log("#tr itnsCmmuNo : " + itnsCmmuNo);
		console.log("#tr itnsNo : " + itnsNo);

		$.ajax({
			
			url : "/myPremium/boardDetail",
			type : "post",
			data : {"itnsCmmuNo":itnsCmmuNo, "itnsNo":itnsNo},
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(result) {
				console.log(result);
				$("#note").html(result);
			}
		});
	});
});

</script>
