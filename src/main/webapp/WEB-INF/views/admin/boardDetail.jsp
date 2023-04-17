<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("CRLF", "\r\n"); %>
<% pageContext.setAttribute("LF", "\n"); %>

<script type="text/javascript"
	src="/resources/adminlte3/plugins/summernote/summernote.js"></script>
<script type="text/javascript">
$(function() {
	const delButtons = document.querySelectorAll('.delCmtBtn');
	delButtons.forEach(button => {
	    button.addEventListener('click', () => {
			const commentNo = button.getAttribute('data-cmdNo');
			console.log(commentNo);

			var isDel = confirm("삭제하시겠습니까");
			if(isDel > 0){
				alert("삭제되었습니다.")
				location.href = "/admin/cmtDelete?commentNo="+commentNo+"&boardNo=${boardVo.boardNo}";
			}

		});
	});
});

function confirmDel() {
	var isDel = confirm("삭제하시겠습니까");
	if (isDel > 0) {
		alert("삭제되었습니다.")
		location.href = "/admin/boardDelete?boardNo=${boardVo.boardNo}&boardType=${boardVo.boardClfcNo}"
	}
}
</script>
<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<c:if test="${boardVo.boardClfcNo == 'BRDCL0001'}">
					<h1 class="m-0">공지사항</h1>
				</c:if>
				<c:if test="${boardVo.boardClfcNo == 'BRDCL0002'}">
					<h1 class="m-0">FaQ</h1>
				</c:if>
				<c:if test="${boardVo.boardClfcNo == 'BRDCL0003'}">
					<h1 class="m-0">커뮤니티</h1>
				</c:if>
				<c:if test="${boardVo.boardClfcNo == 'BRDCL0004'}">
					<h1 class="m-0">문의사항</h1>
				</c:if>
			</div>

		</div>
	</div>
</div>
<c:if test="${not empty boardVo}">
	<div class="row">
		<div class="col-md-12">
			<div class="card card-default">
				<div class="card-body">
					<form>
						<div class="col-sm-12">
							<div class="form-group">
								<div class="row">
									<div class="col-sm-9">
										<label>제목 : ${boardVo.boardTitle}</label>
									</div>
									<div class="col-sm-3">
										<p>글쓴이 : ${boardVo.memId}</p>
									</div>
								</div>
								<hr/>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label>글 내용</label>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="card card-default">
									<div class="card-body">
<%-- 										${boardVo.boardContent} --%>
										${fn:replace(fn:replace(fn:escapeXml(boardVo.boardContent), CRLF, '<br/>'), LF, '<br/>')}
									</div>
								</div>
							</div>
						</div>

						<div class="row ">
							<div class="col-sm-8"></div>
							<div class="col-sm-2">
								<button type="button" class="btn btn-block btn-outline-info"
									onclick="location.href='/admin/boardModify?boardNo=${boardVo.boardNo}'">수정하기</button>
							</div>
							<div class="col-sm-2">
								<button type="button" class="btn btn-block btn-outline-danger deleteBtn"
									onclick="confirmDel()">삭제하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${empty boardVo}">
	<div class="row">
		<div class="col-md-12">
			<div class="card card-default">
				<div class="card-body">
					<div> 글이 삭제 되었거나 존재 하지 않습니다.</div>
				</div>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${boardVo == ''}">
	<div class="row">
		<div class="col-md-12">
			<div class="card card-default">
				<div class="card-body">
					<div> 글이 삭제 되었거나 존재 하지 않습니다.</div>
				</div>
			</div>
		</div>
	</div>
</c:if>

<c:if test="${not empty boardVo}">
	<div class="row">
		<c:if test="${boardVo.boardCmntVOList[0].cmntNo != null}">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h5 class="card-title">댓글</h5>
					</div>
					<c:forEach var="commendVO" items="${boardVo.boardCmntVOList }"
						varStatus="stat">
						<div class="card card-info">
							<div class="row card-body">
								<div class="col-sm-1">
									<div class="row">
										<p>${commendVO.memNm }</p>
										<div class="col-1"></div>
									</div>
									<c:if test="${not empty commendVO.attNm}">
										<div class="row">
											<img alt="이미지 파일" src="/resources/images${commendVO.attNm}" style="height: 70px; width: 70px">
										</div>
									</c:if>
									<c:if test="${empty commendVO.attNm}">
										<div class="row">
											<img alt="이미지 파일" src="/resources/images/login.jpg" style="height: 70px; width: 70px">
										</div>
									</c:if>
								</div>
								<div class="col-sm-10 card-body">
									${commendVO.cmntContent}
								</div>
								<div class="col-sm-1">
									<div class="row">
										<p style="float: right;">
											<fmt:formatDate value="${commendVO.cmntRegDt}"
												pattern="yyyy-MM-dd hh:mm" />
										</p>
									</div>
									<div class="row">
										<button type="button" class="btn btn-block btn-outline-danger delCmtBtn" data-cmdNo="${commendVO.cmntNo}">삭제하기</button>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
	</div>
	<c:if test="${boardVo.boardClfcNo != 'BRDCL0001'}">
		<c:if test="${boardVo.boardClfcNo != 'BRDCL0002'}">
			<div class="row">
				<div class="col-lg-12">
					<form action="/admin/createCmt" method="post">
						<input type="hidden" name="boardNo" value="${boardVo.boardNo}" />
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">댓글 작성</h3>
							</div>
							<div class="card-body">
								<textarea name="content" class="form-control" rows="3"
									placeholder="댓글을 입력하세요..."></textarea>
							</div>
							<div class="row">
								<div class="col-10"></div>
								<div class="col-2">
									<button type="submit" class="btn btn-block btn-outline-success">확인</button>
								</div>
							</div>
						</div>
						<security:csrfInput />
					</form>
				</div>
			</div>
		</c:if>
	</c:if>
</c:if>