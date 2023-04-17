<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript" src="/resources/adminlte3/plugins/summernote/summernote.js"></script>
<script type="text/javascript">
$(function(){
	let lctSrsNo = "";
	let lctNo = "${lectureVo.lctNo}"
	let pint = "${lectureVo.lecSeriesList[0].lctSrsNo}";
	console.log(pint);
	let degree = "";
	if(pint == ""){
		degree = 1;
	} else {
		degree = parseInt(${lectureVo.lecSeriesList[lectureVo.lecSeriesList.size() - 1].lctSrsDegree})+1;
	}

	$("#dgr").val(degree);
});

function goLecture(el){
	console.log(el)
	lctSrsNo = el.getAttribute('data-value');

	// 값을 받아와서 저장한다.
	// 그 값을 통해서 속성값을 만들어준다.
	console.log(lctSrsNo)

	let close = document.querySelectorAll('[class=midear]');

	for (let i = 0; i < close.length; i++) {
		close[i].style.display = "none";
	}

	let selectedForm= document.querySelector('[id = "div_'+lctSrsNo+'"]');
	let selected = selectedForm.getAttribute("data-lct-srs-no");

	selectedForm.style.display = "block";

	console.log("display 선택한 값"+selectedForm.style.display);
	console.log(selectedForm);

	// 변수로 받아온 값이랑  id 값이 같은 걸 가지고 온다.
	// data-lct-srs-no의 값이랑 같으면 해당 값의 disabled 속성을 지운다.

	console.log("선택한 값"+selected);

}

function lectureModify(){
	location.href = "/admin/lectureModify?lctNo="+lctNo

}

function fn_getDetail(e){
	console.log(e);
	let srsNo = e.getAttribute("data-no");
	console.log(srsNo);

	let list = document.querySelectorAll('[class=midear]');
	// 목록을 전부 불른다.

	for(let i = 0 ; i < list.length; i++){
		console.log(list[i]);
		console.log(list[i].getAttribute("data-lct-srs-no"));

		if(srsNo == list[i].getAttribute("data-lct-srs-no")){
			console.log("같은데?");
			nO = list[i].getAttribute("data-lct-srs-degree");
			title = list[i].getAttribute("data-lct-title");
			aNm = list[i].getAttribute("data-att-nm");
			onelctSrsNo = list[i].getAttribute("data-lct-srs-no");
			console.log(nO);
			console.log(aNm);
			$(".srNo").val(nO);
			$(".srTitle").val(title);
			$('#summernote2').summernote('code', aNm);
			$("#frmLctSrsNo").val(onelctSrsNo);
		}

	}
}

$(function(){
	$(".delAll").on("click",function(){
		console.log("눌림");
		var result = confirm('삭제 하시겠습니까?');
	    if(result>0) {
	    	Swal.fire("삭제 되었습니다.");
	        $("#frmDelAll").submit();
	    } else {

	    }
	});

})
</script>

<div class="content-header">
	<input type="hidden" id="ididid"  value="${lectureVo.prmmNo}"/>
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1 class="m-0">${lectureVo.prmmTitle}</h1>
			</div>
			<div class="col-sm-2"></div>
			<div class="col-sm-2">

				<button type="button" class="btn btn-block btn-outline-info"  data-toggle="modal" data-target="#modifyTitleTeacher">제목/강사명 수정하기</button>
			</div>
			<div class="col-sm-2">
				<form action="/admin/deletePrmm" method="post" id="frmDelAll">
					<input type="hidden" name="prmmNo" value="${lectureVo.prmmNo}" />
					<button type="button" class="btn btn-block btn-outline-danger delAll">강좌 전체 삭제하기</button>
					<security:csrfInput />
				</form>
			</div>
		</div>
	</div>
</div>

<div>
	<div class="card card-default">
		<div class="col-md-12">
			<div class="card-body">
				${lectureVo.prmmContent}
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-4">
		<div class="card card-default">
			<div class="col-md-12">
				<div class="card-body" style="height: 550px">
					<c:if test="${not empty lectureVo.bgPicture}">
						<div class="col-12">
							<img alt="강좌 이미지 파일" src="/resources/images${lectureVo.bgPicture}" style="height: 300px; width: 400px">
						</div>
					</c:if>
					<c:if test="${empty lectureVo.bgPicture}">
						<div class="col-12">
							<img alt="강좌 이미지 파일" src="/resources/images/기본강의.jpg" style=" height: 300px; width: 400px">
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-8" >
		<div class="card card-default">
			<div class="card-body" style="height: 550px">
				<c:forEach var="lectureSeriesVO" items="${lectureVo.lecSeriesList}" varStatus="stat">
					<div class="midear" id="div_${lectureSeriesVO.lctSrsNo}"  data-lct-srs-no="${lectureSeriesVO.lctSrsNo}"
						<c:if test="${stat.index>0}">style="display:none;"</c:if>
						      data-lct-title="${lectureSeriesVO.lctTitle}" data-lct-srs-no = "${lectureSeriesVO.lctSrsNo}"
						      data-lct-srs-degree="${lectureSeriesVO.lctSrsDegree}" data-att-nm='${lectureSeriesVO.attNm}'>
						<div class="col-sm-12">
							<div class="form-group">
								<div class="row">
									<div class="col-sm-9">
										<c:if test="${not empty lectureSeriesVO.lctTitle}">
											<label>제목 : ${lectureSeriesVO.lctTitle} </label>
										</c:if>
										<c:if test="${empty lectureSeriesVO.lctTitle}">
											<label>제목 : 추가된 회차가 없습니다. </label>
										</c:if>

									</div>
									<div class="col-sm-3" >
										<c:set var="teacherName" value="${lectureVo.lctInstrNm}" />
										강사명 : ${lectureVo.lctInstrNm}
									</div>
								</div>
								<div class="col-sm-5">
									${lectureSeriesVO.attNm}
								</div>
								<hr/>
							</div>
							<c:if test="${empty lectureSeriesVO.lctSrsNo}">
								<div class="col-12">등록된 강의가 없습니다. 우측의 강의 회차 추가하기를 눌러 강의를 추가하세요.</div>
							</c:if>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">

								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-8"></div>
							<c:if test="${not empty lectureVo.lecSeriesList[0].lctSrsNo}">
								<div class="col-sm-2">
									<button type="button" class="btn btn-block btn-outline-info"
										onclick="fn_getDetail(this)" data-no="${lectureSeriesVO.lctSrsNo}" data-toggle="modal"
										data-target="#modifyModal">수정하기</button>
								</div>
								<div class="col-sm-2">
									<form action="/admin/deleteSrs" method="post" id="sysDel_${lectureSeriesVO.lctSrsNo}">
										<input type="hidden" name="lctSrsNo" value="${lectureSeriesVO.lctSrsNo}" />
										<input type="hidden" name="lctNo" value="${lectureVo.lctNo}" />
										<input type="hidden" name="prmmNo" value="${lectureVo.prmmNo}" />
										<button type="button" class="btn btn-block btn-outline-danger deleteBtn" id = "${lectureSeriesVO.lctSrsNo}">
											삭제하기
										</button>
										<security:csrfInput />
									</form>
								</div>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<div class="row card">
	<div class="card card-body">
		<div class="row">
			<div class="col-sm-10"></div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-block btn-outline-info"
					data-toggle="modal" data-target="#myModal">강의 회차 추가 하기</button>
			</div>
		</div>
		<p>강좌 리스트</p>
		<table class="table table-head-fixed text-nowrap">
			<thead>
				<tr>
				<td>회차</td>
				<td>강의 제목</td>

			</thead>
			<tbody>
				<c:forEach var="lectureSeriesVO" items="${lectureVo.lecSeriesList}" varStatus="stat">
					<tr>
						<c:if test="${empty lectureSeriesVO.lctSrsDegree}">
							<td colspan="3">등록된 강의 회차가 없습니다.</td>
						</c:if>
						<c:if test="${not empty lectureSeriesVO.lctSrsDegree}">
							<td>${lectureSeriesVO.lctSrsDegree}</td>
							<td>${lectureSeriesVO.lctTitle}</td>
							<td style="width: 100px;"><button type="button" class="btn btn-block btn-outline-info"  onclick="goLecture(this)" data-value="${lectureSeriesVO.lctSrsNo}">강의 보기</button></td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>


<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">회차 추가하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<form action="/admin/insertSeries" method="post">
						<input type="hidden" name="lctNo" value="${lectureVo.lctNo }">
						<input type="hidden" name="prmmNo" value="${lectureVo.prmmNo }">
						<div class="row">
							<div class="form-group" style="text-align: center;">
								<div class="row">
									<div class="col-sm-2" style="text-align: center;">
										회차 :
									</div>
									<input type="text" class="form-control col-sm-2" id = "dgr" name="no" readonly/>
									<div class="col-sm-2" style="text-align: center;">
										제목 :
									</div>
									<input type="text" class="form-control col-sm-6" name="title" value=""  placeholder="제목을 입력 해주세요"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label>글 내용</label>
									<textarea id="summernote" name="editordata"></textarea>
								</div>
							</div>
							<div class="col-sm-10"></div>
							<div class="col-sm-2">
								<button type="submit" class="btn btn-block btn-outline-info">추가하기</button>
							</div>
						</div>
						<security:csrfInput />
					</form>
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="modifyModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">수정하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<form action="/admin/changeSeriese" method="post">
						<input type="hidden" name="prmmNo" value="${lectureVo.prmmNo }">
						<input type="hidden" name="frmLctSrsNo" id="frmLctSrsNo" >
						<input type="hidden" name="frmLctNo" id="frmLctNo" value="${lectureVo.lctNo}">
						<div class="row">
							<div class="form-group" style="text-align: center;">
								<div class="row">
									<div class="col-sm-2" style="text-align: center;" >
										회차 :
									</div>
									<input type="text" class="form-control col-sm-2 srNo" name="no" value="" readonly/>
									<div class="col-sm-2" style="text-align: center;">
										제목 :
									</div>
									<input type="text" class="form-control col-sm-6 srTitle" name="title" value=""  placeholder="제목을 입력 해주세요"/>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label>글 내용</label>
									<textarea id="summernote2" class="snte" name = "editData" ></textarea>
								</div>
							</div>
							<div class="col-sm-10"></div>
							<div class="col-sm-2">
								<button type="submit" class="btn btn-block btn-outline-info">수정하기</button>
							</div>
						</div>
						<security:csrfInput />
					</form>
				</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="modifyTitleTeacher">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">수정하기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<form action="/admin/modifyLecture" method="post">
						<input type="hidden" name="lctNo" value="${lectureVo.lctNo}" /> <input
							type="hidden" name="prmmNo" value="${lectureVo.prmmNo }" />
						<div class="col-sm-12">
							<div class="form-group">
								<div class="row">
									<div class="col-sm-3">
										<label>제목</label>
									</div>
									<div class="col-sm-5"></div>
								</div>
								<input type="text" class="form-control" name="title" value="${lectureVo.prmmTitle}"/>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<label>강사 명</label> <select class="form-control"
										name="lctInstrNm">
										<c:forEach var="commonCodeVO" items="${teacher}"
											varStatus="stat">
											<option value="${commonCodeVO.cmcdDtlNm}"
												<c:if test="${commonCodeVO.cmcdDtlNm == teacherName}">selected</c:if>>${commonCodeVO.cmcdDtlNm}</option>
										</c:forEach>
									</select>

								</div>
							</div>
							<div class="col-sm-2">
								<button type="submit" class="btn btn-block btn-info">수정하기</button>
							</div>
						</div>
						<security:csrfInput />
					</form>
				</div>
			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
$(function(){
	$(".deleteBtn").on("click",function(){
		srs = this.getAttribute("id");
		console.log(srs);

		var result = confirm('삭제 하시겠습니까?');
        if(result>0) {
        	Swal.fire("삭제 되었습니다.");
            $("#sysDel_"+srs).submit();
        } else {

        }
	});


	$('#summernote').summernote({
		height: 300,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정

		callbacks : {
        	onImageUpload : function(files, editor, welEditable) { // 파일 업로드(다중업로드를 위해 반복문 사용)
		        for (var i = files.length - 1; i >= 0; i--) {
		        	uploadSummernoteImageFile(files[i], this);
	         	}
         	}
		}
	});

	$('#summernote2').summernote({
		height: 300,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정

		callbacks : {
        	onImageUpload : function(files, editor, welEditable) { // 파일 업로드(다중업로드를 위해 반복문 사용)
		        for (var i = files.length - 1; i >= 0; i--) {
		        	uploadSummernoteImageFile(files[i], this);
	         	}
         	}
		}
	});


// 	$("#summernote").summernote('code',  '${boardVo.boardContent}');


	function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			url : "/admin/uploadSummernoteImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				console.log(data.responseCode); //성공여부
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}

});
</script>
