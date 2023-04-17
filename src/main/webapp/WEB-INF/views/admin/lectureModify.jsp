<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/adminlte3/plugins/summernote/summernote.js">
</script>
<script type="text/javascript">
</script>


<div class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">강좌 </h1>
			</div>

		</div>
	</div>
</div>
<div class="card-body">
	${teacher}
	<form action="/admin/modifyLecture" method="post">
		<input type="hidden" name="lctNo" value="${data.lctNo}"/>
		<input type="hidden" name="prmmNo" value="${data.prmmNo }" />
		<div class="col-sm-12">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-3">
						<label>제목</label>
					</div>
					<div class="col-sm-5"></div>
				</div>
				<input type="text" class="form-control" name="title" value="${data.prmmTitle}" />
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<label>강사 명</label>

					<select class="form-control" name="lctInstrNm">
						<c:forEach var="commonCodeVO" items="${teacher}" varStatus="stat">
						    <option value="${commonCodeVO.cmcdDtlNm}" <c:if test="${commonCodeVO.cmcdDtlNm == data.lctInstrNm}">selected</c:if> >${commonCodeVO.cmcdDtlNm}</option>
						</c:forEach>
					</select>

				</div>
			</div>
			<div class="col-sm-2">
				<button type="submit" class="btn btn-block btn-info">수정하기</button>
			</div>
		</div>
		<sec:csrfInput />
	</form>
</div>


