<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/adminlte3/plugins/summernote/summernote.js"></script>
<script type="text/javascript">
function noPermit(){

}
</script>
<div class="content-header">
</div>
<div class="row">
	<div class="col-md-12">
		<div class="card card-default">
			<div class="card-body">
				<div class="row">
					<div class="col-2">
						<p>제목 : ${data.prmmTitle}</p>
					</div>
					<div class="col-8"></div>
					<div class="col-2">
<%-- 						<p>기업명 : ${data.itnsEntrtVOList[0].memVo.enterPriseList[0].entNm}</p> --%>
							<p>기업명 : </p>
					</div>
				</div>

			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-11">
					${data.prmmContent}
				</div>
			</div>
			<div>
				<br/>
				<br/>
				<hr/>
			</div>
			<div class="card card-footer">
				<div class="row">
					<div class="col-4"></div>
					<div class="col-4">
						<c:if test="${data.itnsAprvYn == 'Y'}">
							<form action="/admin/noPermit" method="post">
								<input type="hidden" name="prmmNo" value="${data.itnsNo}">
								<button class="btn btn-block btn-outline-danger btn-lg" type="submit" >승인해제하기</button>
								<security:csrfInput />
							</form>
						</c:if>
						<c:if test="${data.itnsAprvYn == 'N'}">
							<form action="/admin/permitInternship" method="post">
								<input type="hidden" name="prmmNo" value="${data.itnsNo}">
								<button class="btn btn-block btn-outline-info btn-lg" type="submit" >승인하기</button>
								<security:csrfInput />
							</form>
						</c:if>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>

