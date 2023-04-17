<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript">
$(function(){
	$("#fileImg").on("click", function(e){
	    document.signform.target_url.value = document.querySelector( '#fileImg' ).src;
	    e.preventDefault();
	    $('#uploadFile').click();
	});
});
</script>
<style>
.qna:hover {
	color:#1a73e8;
}
</style>

<main>
	<section class="py-md-5">
		<div class="container blur border-radius-lg p-5" style="min-height: 1000px;justify-content: center;background-color: rgb(255 244 244 / 60%) !important;">
			<div class="bg-white border-radius-lg ">
				<div class="row pt-md-5 px-md-5">
					<div class="col">
						<h3>고객센터</h3>
					</div>
				</div>
				<div class="container">
					<div class="row border-radius-md py-4 p-3 ps-0">
						<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
							<div class="carousel-inner mb-4">
								<div class="carousel-item active">
									<div class="page-header min-vh-25 m-3 border-radius-xl" style="background-image: url('https://demos.creative-tim.com/test/material-dashboard-pro/assets/img/products/product-2-min.jpg');">
										<span class="mask bg-gradient-dark"></span>
										<div class="container">
											<div class="row">
												<div class="col-md-10 mb-md-0 mb-2">
													<div class="input-group input-group-outline">
														<label class="form-label">궁금한 점을 검색해주세요.</label>
														<input type="text" class="form-control">
													</div>
												</div>
												<div class="col ps-md-0">
													<button class="btn bg-gradient-info w-100 mb-0 h-100 position-relative z-index-2"><i class="material-icons">search</i></button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row m-6">
						<div class="col">
							<h4>개인회원 자주 묻는 질문</h4>
							<hr class="dark horizontal" />
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0009'">지원 현황의 자세한 사항이 궁금해요! (튜토리얼)</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0010'">이력서 복사는 어떻게 하나요?</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0011'">이메일 변경 시 작성 중 목록 내 이메일이 변경되지 않아요</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0012'">지원한 회사에서 피드백이 없습니다. 어떻게 하면 되나요?</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0013'">원티드 이력서 양식을 꼭 사용해야 하나요?</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0014'">서류 전형에 합격했습니다. 이후 절차는 어떻게 되나요?</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0015'">제출하기 버튼이 비활성화(회색)되어 있어요.</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0016'">작성 중 목록을 삭제하고 싶어요</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0026'">내가 만든 파일을 사용하고 싶어요.</a></p>
						</div>
						<div class="col">
							<h4>기업회원 자주 묻는 질문</h4>
							<hr class="dark horizontal" />
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0018'">기업 서비스 가입, 이용 절차가 궁금합니다.</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0019'">기업 승인 요청 중으로 계속 확인됩니다.</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0020'">승인 보류 안내 메일을 받았습니다.</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0021'">중복 기업 안내 메일을 받았습니다. 관리자와 리뷰어 계정은 무엇인가요?</a></p>
							<p class="fw-normal my-sm-4"><a class="qna" href="javascript:location.href='/board/boardDetail?boardNo=BRD0022'">서비스 이용 계약은 어떻게 체결하나요?</a></p>
						</div>
					</div>
				</div>

				<hr class="dark horizontal" />

				<div class="row">
					<div class="col text-center">
						<strong>찾는 답변이 없으시면 문의글을 남겨주세요!</strong>
					</div>
					<!-- 문의글 남기기 양식 -->
					<section class="py-5">
						<div class="container">
							<div class="row align-items-center">
								<div class="col-lg-8 mx-auto text-center">
									<div class="mb-md-5">
										<h2>문의 등록</h2>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-lg-8 mx-auto">
									<div class="card card-plain">
										<form name="signform" enctype="multipart/form-data" method="post" action="">
										<sec:csrfInput/>
											<div class="card-body">
												<div class="row">
													<div class="col ps-md-2">
														<div class="input-group input-group-static mb-4">
															<label>아이디</label>
															<input type="text" class="form-control">
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col ps-md-2">
														<div class="input-group input-group-static mb-4">
															<label>제목</label>
															<input type="text" class="form-control">
														</div>
													</div>
												</div>
												<div class="input-group input-group-dynamic mb-4">
													<label class="form-label">설명</label>
													<textarea name="message" class="form-control" rows="6"></textarea>
												</div>
												<div class="row">
													<div class="col ps-md-2">
														<div class="input-group input-group-static mb-4">
															<label>연락처</label>
															<input type="text" class="form-control">
														</div>
													</div>
												</div>
												<div class="row align-items-center">
													<label style="width: 80px;">첨부파일</label>
													<img id="fileImg" src="/resources/images/upload_file.png" alt="..." class="avatar-lg p-0">
													    <input type="file" id="uploadFile" name="uploadFile" style="display:none;" onchange="changeValue(this)" />
													    <input type="hidden" name = "target_url" />
												</div>
												<hr/>
												<div class="row">
													<div class="col ps-md-2">
														<div class="input-group input-group-static mb-4">
															<small>
																개인정보 수집 및 이용에 대한 동의 내용
																<br/><br/>
																① 개인정보 수집 항목: 이메일, 연락처
																<br/>
																② 수집목적: 고객식별, 문의 응대, 서비스 품질 향상
																<br/>
																③ 보유 및 이용기간: 수집 목적이 달성되면 지체없이 모든 개인정보를 파기합니다.
																<br/>
																단, 관계법령에서 일정 기간 정보의 보관을 규정한 경우에 한해 분리 보관 후 파기합니다.
																<br/><br/>
																*위 동의는 거부할 수 있으며, 거부시 해당 문의를 처리할 수 없습니다.
																<br/><br/>
																<input type="checkbox" /> 동의합니다.
															</small>
														</div>
													</div>
												</div>

												<div class="row">
													<div class="col-md-12 text-center">
														<button type="submit" class="btn btn-light w-auto me-2">제출</button>
													</div>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</section>
					<!-- 문의글 남기기 양식 -->

				</div>
			</div>
		</div>
	</section>
</main>