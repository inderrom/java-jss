<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<script type="text/javascript">
$(function(){
	let jsmemId = "${memVO.memId}";
	
	$.ajax({
		url:"/mem/memSearch",
		data: {"memId": jsmemId},
		type:"post",
		beforeSend : function(xhr) {
		       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
		   console.log(result);
		   $("#myprofile").attr("src", "/resources/images"+result.attNm);
		   if(result.crrYear == "0"){
			   $("#crrYear").text("신입");
		   }else{
			   $("#crrYear").text(result.crrYear+"년차");
		   }
		}
	});
	
});
</script>
<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="card shadow-lg mb-5">
						<div class="card-body p-8">
							<section>
								<div class="container">
									<div class="row align-items-center">
										<div class="col-lg-8 col-10 mx-auto text-center">
											<div class="mb-md-7">
												<h1 class="font-weight-bolder text-dark display-3">회원 탈퇴 시 주의사항</h1>
											</div>
										</div>
									</div>
									<div class="row">
										<p class="font-weight-bolder">탈퇴하기 전에</p>
										<hr/>
										<p>· 탈퇴 시 OneID를 통해 등록한 서비스의 모든 정보가 영구적으로 삭제되며, 다시는 복구할 수 없습니다.</p>
										<hr/>
										<br/>
										<p class="font-weight-bolder">미리 백업하기</p>
										<hr/>
										<p>· OneID로 등록한 서비스에서 정보 백업을 원하실 경우, 탈퇴 이전에 해당 서비스에서 백업을 진행해 주세요.</p>
										<hr/>
										<br/>
										<p class="font-weight-bolder">미리 관리하기</p>
										<hr/>
										<p>· 서비스 이용 중 본인의 OneID 계정에 귀속되지 않은 정보는 자동으로 삭제되지 않으며, 탈퇴
											시 수정이나 삭제가 불가능합니다. OneID 계정에 귀속되지 않은 정보를 수정하거나 삭제하려는 경우, 회원
											탈퇴 이전에 해당 서비스에서 수정 또는 삭제를 진행해 주세요.</p>
									</div>
									
									<hr class="dark horizontal my-md-7" />
									
									<div class="row">
										<p class="font-weight-bolder">탈퇴하려는 계정</p>
										<div class="input-group input-group-outline my-3">
											<p class="form-control font-weight-bolder" style="font-size:small;">
												<img id='myprofile' src='' alt='...' class='avatar rounded-circle avatar-sm shadow border-radius-lg me-lg-4'>
												${memVO.memId}
											</p>
										</div>
									</div>
									
									<hr/>
									<hr/>
									
									<div class="row">
										<p class="font-weight-bolder">삭제되는 정보</p>
										<div class="input-group input-group-outline my-3">
											<p class="form-control font-weight-bolder" style="font-size:small;">
												<img src='/resources/images/icon/hand-print.png' alt='...' class='avatar-sm shadow me-lg-4'>
												JOB LUV
											</p>
										</div>
									</div>
									
									<hr/>
									<hr/>
									
									<div class="form-check">
										<p class="my-sm-3"><input type="checkbox" class="form-check-input" /> 회원 탈퇴 이후 미결된 금액을 받을 수 없음을 이해했으며 동의합니다.</p>
										<p class="my-sm-3"><input type="checkbox" class="form-check-input" /> 회원 탈퇴를 진행하여 해당 OneID 계정에 귀속된 모든 정보를 삭제하는 데 동의합니다.</p>
									</div>
									
									<hr/>
									<hr/>
									<hr/>
									
									<div class="row my-sm-3">
										<button type="button" class="btn btn-info btn-lg w-100">회원탈퇴</button>
										<a href="javascript:history.back()" class="btn btn-default btn-lg w-100">회원탈퇴 취소</a>
									</div>
								</div>
							</section>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</main>