<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("replaceChar", "\n");
%>


<script type="text/javascript">
//지원하기
function clickApplyBtn() {

	let applyForm = document.getElementById("applyForm");
	let formData = new FormData(applyForm);

	JobPostingApplyCheck(formData);

	console.log(applyForm);
	console.log(formData);

}//end 지원하기
</script>




<main>
	<section class="pt-3 pt-md-5 pb-md-5">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<header>
						<div class="page-header rounded-3 min-vh-50"
							style="background-image: url('/resources/images${detailJobPosting.attachmentList[0].attNm}');"
							loading="lazy">
							<span class="mask bg-gradient-dark opacity-4"></span>
						</div>
					</header>
					<div
						class="card card-body blur shadow-blur mx-md-4 mt-n6 overflow-hidden">
						<div class="container">
							<div class="row border-radius-md p-3 position-relative">
								<h2 class="h2_style">${detailJobPosting.jobPstgTitle}
									<!-- 북마크처리 -->
									<sec:authorize access="isAuthenticated()">
										<button type="button"
											onclick="bookmarkSettings(this,'${detailJobPosting.jobPstgNo}','${detailJobPosting.recBmkYn}')"
											data-markCheck="
									<c:if test="${detailJobPosting.recBmkYn ==false}">N</c:if>
									<c:if test="${detailJobPosting.recBmkYn ==true}">Y</c:if>
									"
											class="btn bg-gradient-default book_mark_position">
											<c:if test="${detailJobPosting.recBmkYn ==false}">
												<img class="detail_book_mark_size" alt="hollow_star"
													src="/resources/images/icon/hollow_star.png">
											</c:if>
											<c:if test="${detailJobPosting.recBmkYn ==true}">
												<img class="detail_book_mark_size" alt="star"
													src="/resources/images/icon/star.png">
											</c:if>
										</button>
									</sec:authorize>
								</h2>
								<br />
								<!-- 기업 상세 이동 a 태그 -->
								<a href="/mem/enterpriseInfo?entNo=${detailJobPosting.entNo }" style="font-size: x-large;">${detailJobPosting.entNm}</a> <br />

							</div>
						</div>
					</div>
				</div>

				<section class="pt-3">
					<div class="card shadow-lg mb-5">
						<div class="card-body" style="min-height: 1000px;">
							<div class="row content_div">
								<div class="col-8 ms-4 mt-3 p-4">
									<h6 class="text_content">주요 내용</h6>
									<%-- 					<p>${detailJobPosting}</p> --%>

									<%-- 					<p>${detailJobPosting}</p> --%>

									<p class="NanumSquareNeo ps-2">${fn:replace(detailJobPosting.jobPstgContent,replaceChar,"<br/>")}</p>
									<br /> <br />

									<h6 class="content_h6">주요 업무</h6>
									<p class="NanumSquareNeo ps-2">${fn:replace(detailJobPosting.jobPstgMainWork,replaceChar,"<br/>")}</p>
									<br /> <br />
									<hr>

									<h6 class="content_h6">자격 요건</h6>
									<p class="NanumSquareNeo ps-2">${fn:replace(detailJobPosting.jobPstgQlfc,replaceChar,"<br/>")}</p>
									<br /> <br />
									<hr>

									<h6 class="content_h6">우대사항</h6>
									<p class="NanumSquareNeo ps-2">${fn:replace(detailJobPosting.jobPstgRpfntm,replaceChar,"<br/>")}</p>
									<br /> <br />
									<hr>

									<h6 class="content_h6">혜택 및 복지</h6>
									<p class="NanumSquareNeo ps-2">${fn:replace(detailJobPosting.jobPstgBnf,replaceChar,"<br/>")}</p>
									<br /> <br />
									<hr>

									<h6 class="content_h6">기술스택 ・ 툴</h6>
									<div class="tag_div">
										<ul class="list_style_none">
											<c:forEach var="jobPostingSkillVO" items="${detailJobPosting.jobPostingSkillVOList}">
												<li class="display_inline_block">
													<a	class="btn tag_style" style="background-color: #B9FDEF;">${jobPostingSkillVO.jobPstgSklNm}</a>
												</li>
											</c:forEach>
										</ul>
									</div>
									<p class="apply_under_line"></p>
									<div class="row">

										<div class="col-12" style="display: inline-flex;">
											<p class="apply_text  pe-6 ps-6 col-md-auto"
												style="color: #999999">마감일</p>
											<p class="apply_text">${detailJobPosting.jobPstgEndDate}</p>
										</div>

										<div class="col-12" style="display: inline-flex;">
											<p class="apply_text  pe-5 ps-6 col-md-auto"
												style="color: #999999">근무지역</p>
											<p class="apply_text">${detailJobPosting.enterpriseVO.entAddr}</p>
										</div>

										<div id="kakaoDIV" class="mb-8 mt-4"
											style="width: 670px; height: 250px;"></div>
									</div>

								</div>
								<div class="col">
									<div class="card border_gray stickt_top70">
										<div class="card-bady">
											<div class="container">
												<div class="row mt-4 text-center">
													<h4 class="h4_font">채용 보상금</h4>
													<p class="p_style">
														<fmt:formatNumber value="${detailJobPosting.jobPstgPrize}"
															pattern="#,###원" />
													</p>
												</div>
												<div class="row">
													<div class="col text-center">
														<c:if test="${memVO == null}">
															<a href="/login" class="btn btn-info apply_btn width_auto">지원하기</a>
														</c:if>
														<c:if test="${memVO != null}">
															<button type="button" class="btn btn-info apply_btn width_auto" data-bs-toggle="modal" data-bs-target="#modal-form">지원하기</button>
														</c:if>
													</div>
													<div class="row mx-2 my-4">
														<div>
															<c:forEach var="jobPostingTagVO" items="${detailJobPosting.jobPostingTagVOList}">
																<span class="tag_style"
																	style="background-color: #FAE0E9;">${jobPostingTagVO.jobPstgTagNm}</span>
															</c:forEach>
														</div>
													</div>
												</div>
											</div>
										</div>
									<div class="row">
										<a class="col " onclick="goBack()"><img alt="go-back-arrow" class="detail_book_mark_size goBack" src="/resources/images/icon/back-arrow.png"/></a>
										<a class="col " href="#"><img alt="up-arrow" class="detail_book_mark_size upArrow" src="/resources/images/icon/up-arrow.png" /></a>
									</div>
									</div>
								</div>
								<!-- 가운데 정렬을 위한 빈칸 -->
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
	</section>
</main>

<!-- 지원하기 모달 시작 -->
<div class="modal fade" id="modal-form" tabindex="-1" role="dialog"	aria-labelledby="modal-form" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered " role="document">
		<div class="modal-content">
			<div class="modal-body p-0">
				<div class="card card-plain">
					<div class="card-header pb-0 text-left" style="position: sticky; top: 0px; border-bottom: 1px solid #e1e2e3;">
						<h3 class="font-weight-bolder text-info text-gradient text-center">지원하기</h3>
					</div>
					<div class="card-body" style="height: 763px; overflow-y: auto; padding-bottom: 0px;">
						<!-- form -->

						<form id="applyForm" method="post" action=""
							enctype="multipart/form-data">
							<input type="hidden" name="jobPstgNo" id="jobPstgNo"
								value="${jobPstgNo}" />
							<sec:csrfInput />
							<div>
								<h3 class="apply_info_title">지원 정보</h3>
								<div class="information row">
									<div class="col-md-auto">
										<label for="name" class=" col-md-auto lable_style"> <span class="apply_text pe-6 ps-6">이름</span></label>
										<input class="apply_text apply_under_line " type="text"	name="memNm" id="memNm" value="${memVO.memNm}" readonly/>
									</div>
									<div class="col-md-auto">
										<label for="email" class=" col-md-auto"><span class="apply_text  pe-5 ps-6">이메일</span></label>
										<input class="apply_text apply_under_line " type="text" name="memId" id="memId" value="${memVO.memId}" readonly/>
									</div>
									<div class="col-md-auto">
										<label for="email" class=" col-md-auto"> <span
											class="apply_text ps-6 pl_33">전화번호</span>
										</label> <input class="apply_text apply_under_line col" type="text" name="memTelno" value="${memVO.memTelno}" placeholder="예시>01012345678" readonl/>
									</div>
								</div>
								<h3 class="apply_info_title">첨부파일</h3>

								<div id="bigBoss" class="row">
									<!-- 대표 맨위에 놓기 위해 -->
									<c:forEach var="resumeVO" items="${resumeVOList}">
										<c:if test="${resumeVO.rsmRprs == 'Y'}">
											<div class="card card-body col mt-4 mb-2 ms-3 me-3  inline_flex_setting choine_resume">
												<div class="col-2 text-center">
													<input type="checkbox" class="resume_check checked" onclick="uncheckRsmNo(this)" name="rsmNo" id="resume_check" value="${resumeVO.rsmNo}" checked />
												</div>
												<div class="col-8 text-center">
													<div class="ResumeItem_Title_Wrapper__uet6C">
														<button type="button" onclick="resumeDetail(this)" class="resume_btn resume_title" data-rsmno="${resumeVO.rsmNo}">${resumeVO.rsmTitle}</button>
													</div>
													<div>
														<span><fmt:formatDate value="${resumeVO.rsmRegDt}" pattern="yyyy-MM-dd" /></span>
													</div>
												</div>
												<label class="col-2 text-center" style="margin: -10px;" for="resume_check">
													<p class="ResumeItem_Badge__Matchup__ZQMzW " style="margin: 0px;"><span class="badge badge-info">대표 이력서</span></p>
												</label>
											</div>
										</c:if>
									</c:forEach>

									<c:forEach var="resumeVO" items="${resumeVOList}">
										<c:if test="${resumeVO.rsmRprs == 'N' || resumeVO.rsmRprs == null}">
											<div class="card card-body col mt-4 mb-2 ms-3 me-3  inline_flex_setting	none_choice_resume">
												<div class="col-2 text-center">
													<input type="checkbox" class="resume_check" onclick="uncheckRsmNo(this)" name="rsmNo" id="resume_check" value="${resumeVO.rsmNo}" />
												</div>
												<div class="col-8 text-center" >
													<div class="ResumeItem_Title_Wrapper__uet6C">
														<button type="button" onclick="resumeDetail(this)" class="resume_btn resume_title" data-type="resume" value="${resumeVO.rsmNo}">${resumeVO.rsmTitle}</button>
													</div>
													<div>
														<span><fmt:formatDate value="${resumeVO.rsmRegDt}" pattern="yyyy-MM-dd" /></span>
													</div>

												</div>
												<div class="col-2"></div>
											</div>
										</c:if>
									</c:forEach>
									<input id="resumeFile" type="file" autocomplete="off"
										tabindex="-1" style="display: none;">
								</div>

								<div id="smallBoss" class="row">
									<c:if test="${attVOList != null || attVOList.size() > 0  }"></c:if>
									<c:forEach var="attachmentVO" items="${attVOList}">
										<div
											class="card card-body col mt-4 mb-2 ms-3 me-3  inline_flex_setting	none_choice_resume">
											<div class="col-2 text-center">
												<input type="checkbox" class="resume_check" name="attNo" id="attachment_check" value="${attachmentVO.atchNo}" />
											</div>
											<div class="col-8 text-center">
												<div class="ResumeItem_Title_Wrapper__uet6C resume_title">${attachmentVO.attNm}</div>
											</div>
											<span class="col-2 badge badge-success">${attachmentVO.attClfcNm}</span>
										</div>
									</c:forEach>

								</div>
							</div>
							<div class="card-body pt-3 pb-0">
								<label class="btn soso_btn horizontal_alignment"
									for="resumeFile">파일 업로드</label>

							</div>
							<div class="card-body pt-3 pb-3">
								<button type="button" onclick="resumeInsert()"
									class="btn soso_btn horizontal_alignment">새 이력서 작성</button>
							</div>
						</form>
						<!-- form -->
					</div>
					<form role="form" action="#" id="uploadFileForm" method="post" enctype="multipart/form-data" autocomplete="off">
					</form>
					<div class="card-footer text-muted apply_under_line" style="position: sticky; bottom: 0px; padding: 24px 20px; border-top: 1px solid #ececec; background: #fff;">
						<p class="end_text text-sm mx-auto text-center">
							JAVA 이력서로 지원하면 최종 합격률이 40% 높아집니다.<br /> 취업은 JAVA에서 잡아
						</p>
						<button type="button"  class="not_ready_btn" id="to_apply" onclick="clickApplyBtn()">지원하기</button>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<!-- 지원하기 모달 끝 -->

<script type="text/javascript">
//파일 업로드 및 지원하기
let bigBoss = document.getElementById("bigBoss");
let fileupload = document.getElementById("resumeFile");
fileupload.addEventListener("change", handleFiles, false);

//파일 화면 표시
function handleFiles() {
	if (!this.files.length) {
		Swal.fire("잘못된 파일 입니다.")
	} else {
		for (let i = 0; i < this.files.length; i++) {
			dataUpload(this.files[i]);
		}//end for
	}//end if

}//end handleFiles

//채용공고 지원 유무 확인
function JobPostingApplyCheck(formData) {
	$.ajax({
		url : "/jobPosting/JobPostingApplyCheck",
		type : "post",
		processData : false,
		contentType : false,
		data : formData,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success : function(result) {
			console.log(result)

			if (result == false) {
				Swal.fire({
					title : '이미 지원한 채용공고입니다!',
					icon : 'error',
					confirmButtonText : '확인'
				})//end toast
				return;
			}//end if

			console.log("필멸자여 찍히면 죽음뿐...")
			JobPostingApply(formData);
		}
	});//end ajax
}// end JobPostingApplyCheck

function JobPostingApply(formData) {
	$.ajax({
		url : "/jobPosting/JobPostingApply",
		type : "post",
		processData : false,
		contentType : false,
		data : formData,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success : function(result) {
			console.log(result)

			if (result > 0) {
				Swal.fire({
					  title: '채용공고 지원 완료!',
					  icon: 'success',
					  showCancelButton: true,
					  confirmButtonColor: '#3085d6',
					  cancelButtonColor: '#d33',
					  confirmButtonText: '지원 현황으로 이동',
					  cancelButtonText: '계속하기'
					}).then((result) => {
					  if (result.isConfirmed) {
						  location.href="/mem/myPage";
					  }
					})


// 				Swal.fire({
// 					title : '지원 완료!',
// 					icon : 'success',
// 					confirmButtonText : '확인'
// 				})
			}
		}
	});//end ajax
}

function dataUpload(file) {
	console.log(file)
	//form 태그 가져오기
	let uploadFileForm = document.getElementById("uploadFileForm");
	// 		let formData = new FormData($('#uploadFileForm')[0]);

	let memId = document.getElementById("memId");
	let memIdValue = memId.value;

	let formData = new FormData(uploadFileForm);
	console.log(formData)

	formData.append("memId", memIdValue);
	formData.append("uploadFile", file);

	console.log("formData : ", formData);

	$.ajax({
		url : "/jobPosting/uploadFile",
		type : "post",
		processData : false,
		contentType : false,
		data : formData,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success : function(result) {
			console.log(result);
			const smallBossDiv = document.getElementById("smallBoss");
			smallBossDiv.innerHTML = "";
			for (var i = 0; i < result.length; i++) {

				let newFileDiv = document.createElement("div");
				newFileDiv.classList.add("card", "card-body", "col",
						"mt-4", "mb-2", "ms-3", "me-3",
						"inline_flex_setting", "none_choice_resume");

				let checkBoxDiv = document.createElement("div");
				checkBoxDiv.classList.add("col-2", "text-center");

				let chechBox = document.createElement("input");
				chechBox.setAttribute("type", "checkBox");
				chechBox.setAttribute("name", "resumeFile");
				chechBox.setAttribute("id", "resume_file");

				let fileTitle = document.createElement("div");
				fileTitle.textContent = result[i].attNm
				fileTitle.classList.add("col-8", "resume_font",
						"text-center");

				let badgeSpan = document.createElement("span");
				badgeSpan.textContent = result[i].attClfcNm
				badgeSpan.classList.add("col-2", "badge",
						"badge-success");

				let dataInput = document.createElement("input");
				dataInput.setAttribute("type", "file");
				// 				dataInput.setAttribute("data-file", this.files[i]);
				// 				dataInput.classList.add("hidden_file");
				// 				dataInput.value= this.files[i];

				checkBoxDiv.appendChild(chechBox);
				// 				newFileDiv.appendChild(dataInput);
				newFileDiv.appendChild(checkBoxDiv);
				newFileDiv.appendChild(fileTitle);
				newFileDiv.appendChild(badgeSpan);
				smallBossDiv.appendChild(newFileDiv);
				console.log(dataInput)
				console.log(dataInput.dataset.file)
			}
		}
	});
}//end  dataUpload
</script>

	<script>
		// 모든 체크 박스
		const resumeCheck = document.querySelectorAll(".resume_check");
		let checkBoxCount = 0;
		checkBoxCheck();

		// 이력서 및 첨부 파일 관리
		resumeCheck.forEach(function(item) {
			item.addEventListener("change", function() {

				check_checkBox(this);

			});// end addEventListener
		})//end resumeCheck.forEach

		//체크된것이 있나 확인
		function checkBoxCheck() {

			let checkcheck = document
					.querySelectorAll('input[type="checkbox"]:checked')

			checkcheck.forEach(function(element) {

				if (element.checked) {
					checkBoxCount += 1
				}
			})//end forEach
			applyBtnOnOff()
		}// end checkBoxCheck

		// 체크박스 확인 표시 기능
		function check_checkBox(el) {
			el.classList.toggle('checked');
			let topParentNode = el.parentNode.parentNode;
			if (el.checked && el.classList.contains('checked')) {

				if (topParentNode.classList.contains('none_choice_resume')) {
					topParentNode.classList.toggle('choine_resume')
					topParentNode.classList.toggle('none_choice_resume')
				}
			} else {
				if (topParentNode.classList.contains('choine_resume')) {
					topParentNode.classList.toggle('choine_resume')
					topParentNode.classList.toggle('none_choice_resume')
				}
			}
			applyBtnOnOff()
		}// end check_checkBox

		function applyBtnOnOff() {
			// 지원히기 버튼
			const readyBtn = document.querySelector("#to_apply");

			if (checkBoxCount > 0
					&& readyBtn.classList.contains('not_ready_btn')) {
				readyBtn.classList.toggle('not_ready_btn')
				readyBtn.classList.toggle('ready_btn')
			}

			if (checkBoxCount <= 0 && readyBtn.classList.contains('ready_btn')) {
				readyBtn.classList.toggle('not_ready_btn')
				readyBtn.classList.toggle('ready_btn')
			}

		}
		// 이력서 추가
		function resumeInsert() {
			console.log("resumeInsert 을 누르셨습니다.");
			//		location.href="/mem/resumeInsert";
			$.ajax({
				url : "/mem/resumeInsert",
				type : "get",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("X-CSRF-TOKEN",
							"df56b236-1ba6-4f61-a2b9-fef7de7d9aef");
				},
				success : function(rsmNo) {
					location.href = "/mem/resumeDetail?rsmNo=" + rsmNo;
				}
			});
		};// end newResume

		//이력서 상세보기
		function resumeDetail(el) {
			console.log("resumeDetail 을 누르셨습니다.");
			let dataRsmNo = el.dataset.rsmno;
			console.log(dataRsmNo);
			location.href = "/mem/resumeDetail?rsmNo=" + dataRsmNo;
		}

		//북마크 등록
		function bookmarkSettings(el, jptgNo, recBmkYn) {
			//	 console.log(el)
			//	 console.log(jptgNo)
			//	 console.log(recBmkYn)
			let data = {
				"etpId" : jptgNo
			};
			let JSONdata = JSON.stringify(data);

			// 북마크 설정 기능
			bookMarkRun(JSONdata, el);

		}// end bookmarkSettings

		// 북마크
		function bookMarkRun(JSONdata, el) {
			//	 console.log(JSONdata)

			$.ajax({
				url : "/record/bookmarkWant",
				contentType : "application/json;charset:utf-8",
				data : JSONdata,
				type : "post",
				dataType : "json",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(result) {
					console.log("bookmark result : " + JSON.stringify(result));
					let successCheck = JSON.stringify(result);

					let bookmark_sta = el.dataset.markcheck.trim();
					//				console.log(successCheck);
					//				console.log(bookmark_sta);
					//				console.log(el);
					//				console.log(el.children[0]);

					//
					if (bookmark_sta == "Y") {
						if (successCheck == "1") {
							toast_center("북마크가 삭제되었습니다.")
							el.children[0].setAttribute("src",
									"/resources/images/icon/hollow_star.png");
							el.dataset.markcheck = "N";
						}
					}// end if(Y)

					if (bookmark_sta == "N") {
						if (successCheck == "1") {
							toast_center("북마크가 등록되었습니다.")

							el.children[0].setAttribute("src",
									"/resources/images/icon/star.png");
							el.dataset.markcheck = "Y";

						}
					}// end if(N)
				}// end success
			});// end ajax

		}// end bookMarkRun

		//toast center 얼터창 내용 바꾸기
		function toast_center(notice) {
			Toastify({
				position : "center",
				text : notice,
				style : {
					color : "black",
					background : "linear-gradient(to right, #ffdee9, #b5fff0)",
				},
				duration : 3000

			}).showToast();
		}

		// 다른 체크박스 풀기
		function uncheckRsmNo(el) {
			  const rsmNoCheckboxes = document.querySelectorAll('input[name="rsmNo"]');
			  rsmNoCheckboxes.forEach(checkbox => {
				  if(checkbox != el){
				 	 if(checkbox.checked){
					  console.log(checkbox.checked)
					  console.log(checkbox)
					  checkbox.click()

					  }

				  }


// 			    checkbox.checked = false;
			  });
			  el.click();
		}// end uncheckRsmNo
	</script>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=07456a9f4803641615581d7b53fb0ee3&libraries=services"></script>

	<!-- 카카오 맵 -->
	<script>
		let enterPriseAddress = '${detailJobPosting.enterpriseVO.entAddr}'; // 기업 주소
		let enterPriseName = '${detailJobPosting.enterpriseVO.entNm}'; // 기업명

		console.log(enterPriseAddress)
		console.log(enterPriseName)

		let mapContainer = document.getElementById('kakaoDIV'), // 지도를 표시할 div
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다
		let map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		let geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder
				.addressSearch(
						enterPriseAddress,
						function(result, status) {

							// 정상적으로 검색이 완료됐으면
							if (status === kakao.maps.services.Status.OK) {

								let coords = new kakao.maps.LatLng(result[0].y,
										result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								let marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								let infowindow = new kakao.maps.InfoWindow(
										{
											content : '<div style="width:150px;text-align:center;padding:6px 0;">'
													+ enterPriseName + '</div>'
										});
								infowindow.open(map, marker);
								console.log(coords)
								console.log(infowindow)
								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}

						});
		///////////////////////////////////////////////////////////////////////////////////////////////////////////
		// 마커를 표시할 위치와 title 객체 배열입니다
		let positions = [ {
			title : '카카오',
			latlng : new kakao.maps.LatLng(33.450705, 126.570677)
		}, {
			title : '생태연못',
			latlng : new kakao.maps.LatLng(33.450936, 126.569477)
		}, {
			title : '텃밭',
			latlng : new kakao.maps.LatLng(33.450879, 126.569940)
		}, {
			title : '근린공원',
			latlng : new kakao.maps.LatLng(33.451393, 126.570738)
		} ];

		// 마커 이미지의 이미지 주소입니다
		let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

		// 마커 이미지의 이미지 크기 입니다
		let imageSize = new kakao.maps.Size(24, 35);

		// 마커 이미지를 생성합니다
		let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

		geocoder.addressSearch('대전 중구 계룡로 858', function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				a = {
					title : '홈플러스',
					latlng : new kakao.maps.LatLng(result[0].y, result[0].x)
				};
				positions.push(a);

				for (let i = 0; i < positions.length; i++) {
					// 마커를 생성합니다
					let marker = new kakao.maps.Marker({
						map : map, // 마커를 표시할 지도
						position : positions[i].latlng, // 마커를 표시할 위치
						title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						image : markerImage
					// 마커 이미지
					});
				}
			}
		});


		function goBack() {
// 			window.history.back();
			location.href = document.referrer;
		}
	</script>