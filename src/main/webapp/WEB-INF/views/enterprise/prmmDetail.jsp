<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal.memVO" var="memVO" />
<!-- ckEditor -->
<script type="text/javascript" src="/resources/ckeditor/ckeditor.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- sweetalert -->
<script src="/resources/js/sweetalert2.min.js"></script>

<style>
#cke_prmmContent{
	width: 90%;
}
#prmmContent{
	width: 90%;
}
label{
	width: 150px;
	font-size: unset;
}
input{
	width: 300px;

}
.form-control{
	background : #f5f5f5 !important;
}
.msskill{
	border-radius: 20px;
	font-size: 60%;
	width: auto;
	display: inline-block;
	vertical-align: bottom;
}
.txtbox{
	border:1px solid lightgray;
	border-radius:8px;
	background : #f5f5f5;
}
select option[value=""][disabled] {
	display: none;
}
/* .editElements{
	background : white;
} */
</style>

<div class="col-md-11 pt-sm-5 container-fluid kanban">
	<div class="tab-content mt-5">
		<!-- 정보 등록 -->
		<div class="tab-pane active" id="entInfo">
			<div class="card d-flex justify-content-center p-4 shadow-lg">
				<div class="ms-5 mt-3">인턴십  상세보기</div>
				<div class="card-body" style="padding: 3%;">
					<form id="infoFrm" action=""
						method="post" autocomplete="off">
						<input type="hidden" id="entNo" name="entNo"
							value="${data.entNo }" readonly />
						<input type="hidden" id="itnsNo" name="itnsNo"
							value=${data.itnsNo } readonly />
						<input type="hidden" id="prmmNo" name="prmmNo"
							value=${data.prmmNo } readonly />

						<span id="block1">
							<button type="button" id="itnsDeleteBtn"
								class="btn bg-gradient-danger ms-1 text-sm" style="float: right;"
								<c:choose>
									<c:when test="${data.itnsAprvYn eq 'Y' }">
										onclick="deleteAlert()"
									</c:when>
									<c:otherwise>
										data-bs-toggle="modal" data-bs-target="#modal-default"
									</c:otherwise>
								</c:choose>
								>삭제</button>
							<button type="button" id="itnsEditBtn"
								class="btn bg-gradient-info text-sm" style="float: right;"
								onclick="editItns()">수정</button>
						</span>

						<hr />

						<div class="input-group input-group-outline my-3">
							<label for="prmmTitle">인턴십 제목</label>
								<input type="text" id="prmmTitle"
									name="prmmTitle" class="form-control editElements" value="${data.prmmTitle }" readonly/>
						</div>
<!-- 						<p class="ps-9"> -->
<!-- 							<small>* 회사이름 및 웹사이트 주소는 직접 수정이 불가합니다. 수정이 필요하시면 관리자에게 -->
<!-- 								문의해 주세요.</small> -->
<!-- 						</p> -->


						<div class="row">
							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="AprvdNope">승인된 인원</label>
										<input type="text"
											id="AprvdNope" name="AprvdNope"
											class="form-control"
											value="${itnsEntrtCount }" readonly/>
								</div>
							</div>

							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsEntrtNope">모집 인원</label>
										<input type="text"
											id="itnsEntrtNope" name="itnsEntrtNope"
											class="form-control editElements"
											value="${data.itnsEntrtNope }" readonly/>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="input-group input-group-outline my-3">
								<label for="itnsCondition">참여 조건</label> <input type="text"
									id="itnsCondition" name="itnsCondition" class="form-control editElements"
									value="${data.itnsCondition }" readonly />
							</div>
						</div>

						<div class="row">
							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsRecStart">모집 시작</label>
										<input type="date"
											id="itnsRecStart" name="itnsRecStart"
											class="form-control"
											value="<fmt:formatDate pattern="yyyy-MM-dd" value="${data.itnsRecStart }" />" readonly/>
								</div>
							</div>

							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsRecEnd">모집 마감</label>
										<input type="date"
											id="itnsRecEnd" name="itnsRecEnd" class="form-control"
											value="<fmt:formatDate pattern="yyyy-MM-dd" value="${data.itnsRecEnd }"/>" readonly/>
								</div>
							</div>
						</div>

						<p>
<%-- 							<c:set var="itnsRecEnd" value="${data.itnsRecEnd }"/> --%>
<%-- 							<fmt:parseDate value="${data.itnsRecEnd/ (1000*60*60*24)}" integerOnly="true" var="isDate" scope="request"/> --%>
							<label for=""></label>
							<small>
							인턴십 합격은 인턴십 시작일 하루 전에 개별 전달됩니다.
							</small><br/>
							<label for=""></label>
							<small>
<!-- 							yyyy/MM/dd까지 선발을 완료해주세요 -->
							</small>
						</p>

						<div class="row">
							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsBgngDt">인턴십 시작</label>
										<input type="date"
											id="itnsBgngDt" name="itnsBgngDt"
											class="form-control editElements"
											value="<fmt:formatDate pattern="yyyy-MM-dd" value="${data.itnsBgngDt }" />" readonly/>
								</div>
							</div>

							<div class="col-lg-6">
								<div class="input-group input-group-outline my-3">
									<label for="itnsEndDt">인턴십 종료</label>
										<input type="date"
											id="itnsEndDt" name="itnsEndDt" class="form-control editElements"
											value="<fmt:formatDate pattern="yyyy-MM-dd" value="${data.itnsEndDt }"/>" readonly/>
								</div>
							</div>
						</div>

						<div class="row" id="cont1">
							<div class="input-group input-group-outline my-3" style="flex-wrap: nowrap;">
								<div class="" style="width:150px;">
									<label for="prmmContent">상세 설명</label>
								</div>
								<div class="txtbox p-2" style="border-radius:6px; width:100%;">
									${data.prmmContent }
								</div>
							</div>
						</div>

						<div class="row" id="cont2" style="display:none;">
							<div class="input-group input-group-outline my-3" style="flex-wrap: nowrap;">
								<div class="" style="width:150px;">
									<label for="prmmContent">상세 설명</label>
								</div>
								<textarea id="prmmContent" name="prmmContent"
									style="visibility: hidden; display: none;">${data.prmmContent } </textarea>
							</div>
						</div>

						<span id="block2" style="display:none;">
							<button type="submit" id="editFinish" class="btn bg-gradient-info"
									style="float: right;" onclick="editItnsPost()">수정 완료</button>
						</span>

						<sec:csrfInput />
					</form>

					<div class="accordion px-3" id="accordionFaq">
						<div class="accordion-item mb-3">
							<h6 class="accordion-header" id="headingOne">
								<button class="accordion-button border-bottom font-weight-bold text-start collapsed"
										type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseOne" aria-expanded="false"
										aria-controls="collapseOne">
									인턴십 참가자
									<i 	class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0"
										aria-hidden="true"></i>
									<i 	class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0"
										aria-hidden="true"></i>
								</button>
							</h6>
							<div id="collapseOne" class="accordion-collapse collapse"
								aria-labelledby="headingOne" data-bs-parent="#accordionFaq"
								style="">
								<div class="accordion-body text-sm opacity-8">
									<div class="col-md-12">
										<div class="table-responsive mx-5" id="myLecList">
											<table class="table align-items-center">
												<thead>
													<tr>
														<th class="text-center">
														총 신청자 수 : ${fn:length(data.itnsEntrtVOList)}
														</th>
														<th>
														</th>
														<th>
															<select class="form-control"
																name="itnsEntrt-button" id="itnsEntrt-button"
																onchange="changeStatus()">
																	<option class="text-center" value="" disabled selected >신청 상태 변경</option>
																	<option value="Y">인턴(확정)</option>
																	<option value="N">반려</option>
															</select>
														</th>
													</tr>
													<tr>
														<th class="text-uppercase text-secondary text-sm font-weight-bolder opacity-7"></th>
														<th class="text-center text-secondary text-sm font-weight-bolder opacity-7">이름</th>
														<th class="text-center text-uppercase text-secondary text-sm font-weight-bolder opacity-7">신청 상태</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="itnsEntrtVO" items="${data.itnsEntrtVOList }" varStatus="stat">
														<tr class="text-center">
															<td width="100">
																<input type="checkbox" name="memId" class="memId" value="${itnsEntrtVO.memId }">
															</td>
															<td class="text-center">
																${itnsEntrtVO.memNm}
															</td>
															<td class="text-center ">
																<div class="itnsEntrtAprvYn">
																	<c:if test="${itnsEntrtVO.itnsEntrtAprvYn eq 'Y'}">
																		<a class="badge badge-success  me-2"> 확정 </a>
																	</c:if>
																</div>
															</td>
														</tr>
													</c:forEach>


												</tbody>
											</table>
										</div>


									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- 정보 등록 -->

	</div>
</div>


<script type="text/javascript">
//CKEditor
CKEDITOR.replace('prmmContent');

//폼 정보
let form = document.getElementById('infoFrm');
console.log(form);

//checkBox 값 다 가져오기
let checkBox = document.querySelectorAll('.memId');
console.log("checkBox : ", checkBox);

let valueArray = [];
//itnsNo, select option value(확정 = Y, 반려=N) 가져와서 담기!!!


function changeStatus(){
	//인턴십 번호
	let itnsNo = "${param.itnsNo}";
	//selected된 값
	let itnsEntrt = document.getElementById("itnsEntrt-button");
	let itnsAprvYn  = itnsEntrt.options[itnsEntrt.selectedIndex].value;
	console.log("itnsNo : " , itnsNo, " / itnsAprvYn : ", itnsAprvYn);
	//valueArray에 담기(쿼리문 작동할 때 필요)
	valueArray.push(itnsNo);
	valueArray.push(itnsAprvYn);

	for(var i = 0; i < checkBox.length; i++) {
		if(checkBox[i].checked == true){
			valueArray.push(checkBox[i].value);
		}
	}
	console.log("valueArray", valueArray);
// 	let valArr2 = JSON.stringify(valueArray);
// 	console.log("valArr2", valArr2);

	$.ajax({
		url:"/enterprise/aprvItnsEntrt",
		contentType: "application/json",
		data:JSON.stringify(valueArray),
		type:'post',
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}"); },
		success:function(result){
			console.log("result : "  , result) ;

			let aprvPrintArr = document.querySelectorAll(".itnsEntrtAprvYn");

			console.log("aprvPrintArr :", aprvPrintArr, "/", aprvPrintArr[0])
			for(var i = 0; i < aprvPrintArr.length; i++){
				let code="";
				if(result[i].itnsEntrtAprvYn == 'Y') {
					code = "<a class='badge badge-success  me-2'> 확정 </a>";
				}
				$(aprvPrintArr[i]).html(code);
				console.log("code : "  , code) ;
			}

			document.getElementById('AprvdNope').value = result[0].cnt;

		},error:function(err){
 			console.log("err : " , err, "/", err.status);
 		}
	})
	valueArray = [];

}

//인턴십이 승인됐을 때 삭제버튼 누르면 진행X
function deleteAlert(){
	Swal.fire({
		  icon: 'warning',
		  title: '삭제할 수 없습니다.',
		  text: '승인된 프로그램 삭제는 관리자에게 문의하세요',
		  closeOnClickOutside :false
	})
// 	alert("승인된 인턴십은 삭제할 수 없습니다. 관리자에게 문의하세요");
}

//삭제 모달에서 삭제하기 버튼 클릭 시 동작하는 함수
function deleteItns(){
	form.action = "/enterprise/deleteItns";
	form.submit();
}

//수정하기 버튼 클릭
function editItns(){

	//수정할 목록 readonly풀기
	let inputs = document.getElementsByClassName('editElements');
// 	$(inputs).readOnly = false;
	$(inputs).attr("style", "background-color:white !important");

	for(let i = 0; i < inputs.length; i++){
		inputs[i].readOnly = false;
// 		$(inputs[i]).attr("style", "background-color:white !important");
	}


	//수정,삭제 버튼 숨기기 / 수정 완료 버튼 띄우기
	document.getElementById("block1").style.display="none";
	document.getElementById("block2").style.display="";

	//div => ck Editor로 변경
	document.getElementById("cont1").style.display="none";
	document.getElementById("cont2").style.display="";
}

//수정 완료 버튼 클릭
function editItnsPost(){
	form.action = "/enterprise/editItnsPost";
	console.log(form.action);
	form.submit();

}

</script>




<!-- 취소 확인용 모달 -->
    <div class="modal fade" id="modal-default" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
      <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
          <div class="">
            <h6 class="modal-title text-center" id="modal-title-default"></h6>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body text-center">
            <p><b>해당 내용들은 복구되지 않습니다.</b></p>
            <p><b>정말 삭제하시겠습니까?</b></p>
          </div>
          <div class="text-center px-auto pb-3">
            <button type="button" class="btn bg-gradient-danger" onclick="deleteItns()">삭제하기</button>
            <button type="button" class="btn bg-gradient-default ml-auto" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>







