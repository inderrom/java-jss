<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<style>
.nav-pills .nav-link.active {
    background-color: silver;
    color: white;
}

.lectuerCard {
	height: 600px;
}

</style>

<script type="text/javascript">
startdata("lecture");
startdata("special");

$(function(){
	$('#prmmContent1').summernote({
		height: 600,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정

	});
	$('#prmmContent2').summernote({
		height: 600,                 // 에디터 높이
		minHeight: null,             // 최소 높이
		maxHeight: null,             // 최대 높이
		focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		lang: "ko-KR",					// 한글 설정
		placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정

	});

	var today = new Date().toISOString().substr(0, 10);
	document.getElementById("lctDt").min = today;
	$("#crtBtn1").on("click",function(){
		if($("#lectForm #prmmTitle").val()=="" && $("#lectForm #prmmContent1").val()==""){
			Swal.fire("제목과 내용을 입력하세요");
		} else if($("#lectForm #prmmTitle").val()==""){
			Swal.fire("제목을 입력하세요");
		} else {
			$("#lectForm").submit();
		}
	});
	$("#crtBtn2").on("click",function(){
		if($("#specForm #prmmTitle").val()=="" && $("#specForm #prmmContent2").val()==""){
			Swal.fire("제목과 내용을 입력하세요");
		} else if($("#specForm #prmmTitle2").val()==""){
			Swal.fire("제목을 입력하세요");
		} else if( $("#specForm #prmmContent2").val()==""){
			Swal.fire("내용을 입력하세요");
		} else if( $("#specForm #prmmContent2").val()==""){
			Swal.fire("내용을 입력하세요");
		}else if( $("#lctDt").val()==""){
			Swal.fire("날짜를 선택해주세요.");
		} else {
			$("#specForm").submit();
		}
	});

});

function startdata(kind) {
	// 파라미터 값으로 안넘어오면 시작페이지가 1인걸로 시작
	// 페이지를 시작하면 바로 불러오는 함수
	if(kind == "lecture"){
		var currentPage = "${param.currentPage}";
		console.log(currentPage);
		console.log(currentPage == "");
		if("${param.currentPage}" == ""){
			currentPage = 1;
		} else{
			currentPage = "${param.currentPage}";
		}

		var searchType = "${param.searchType}";
		console.log(searchType);
		console.log(searchType == "");

		if("${param.searchType}" == ""){
			searchType = "title";
		} else{
			searchType = "${param.searchType}";
		}

		var keyword = "${param.keyword}"

		console.log(keyword);
		console.log(keyword == "");

		if("${param.keyword}" == ""){
			keyword = "";
		} else{
			keyword = "${param.keyword}";
		}
		if(searchType == ""){
			searchType = $("#searchType").val();
		}

		var data = {"keyword": keyword, "currentPage": currentPage, "searchType": searchType, "kind" : kind, "isPermit" : ""}
		// 비동기 통신을 실행 data를 해당 함수의 파라미터로 넘김 , 그리고 만들어진 페이지버튼을 위한 함수 이름을 넣어줌
		makeAjax(data,"#premiumList","#page","#curP", "pageClick(this)");

	} else if(kind == "special"){
		var currentPage = "${param.currentPage}";
		console.log(currentPage);
		console.log(currentPage == "");
		if("${param.currentPage}" == ""){
			currentPage = 1;
		} else{
			currentPage = "${param.currentPage}";
		}

		var searchType = "${param.searchType}";
		console.log(searchType);
		console.log(searchType == "");

		if("${param.searchType}" == ""){
			searchType = "title";
		} else{
			searchType = "${param.searchType}";
		}

		var keyword = "${param.keyword}"

		console.log(keyword);
		console.log(keyword == "");

		if("${param.keyword}" == ""){
			keyword = "";
		} else{
			keyword = "${param.keyword}";
		}
		if(searchType == ""){
			searchType = $("#searchType").val();
		}

		var data = {"keyword": keyword, "currentPage": currentPage, "searchType": searchType, "kind" : kind, "isPermit" : ""}
		makeAjax(data,"#specialList","#specialPage","#specialCurP", "specialPageClick(this)");
	}




}// end startData

function makeAjax(dta, list, page, curPage, pageBtn){
	$.ajax({
		url:"/admin/makeLecturePage",
	//		contentType : "application/json;charset:utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	//		data:JSON.stringify(data),
		data:dta,
		type:"post",
		dataType:"json",
		success:function(result){
			console.log(result) // 배열 result[0] id name
			const conList = result.content;
			console.log(conList[0]) // 배열 result[0] id name
			/*
			$("#모달 안에 있는 td의 id").val(result[0].jobPstgNo);
			*/
			var code = "";
			var pCode = "";
			code += "<table class='table table-head-fixed text-nowrap'>"
			code += "	<thead>"

			code += "	<th>강좌명</th><th>강좌 추가일</th>"

			code += "	</thead>"
			for(let i=0;i<conList.length;i++){
				code += "	<tbody>"
			    code += "	<tr>"
			    code += "		<td><a href='/admin/lectureDetail?lctNO="+conList[i].lctNo+"&prmmNo="+conList[i].prmmNo+"'>"+conList[i].prmmTitle+"</a></td>"
			    const timestamp = conList[i].prmmRegDt;
			    const date = new Date(timestamp);
			    const year = date.getFullYear();
			    const month = ('0' + (date.getMonth() + 1)).slice(-2);
			    const day = ('0' + date.getDate()).slice(-2);

			    code += "		<td>"+year+"/"+month+"/"+day+"</td>"
				code += "	</tr>"
				code += "	</tbody>"

// 				code += "<div class='card col-3' style='margin: 50px;'>"
// 				code += "	<div class='card lectuerCard'>"
// 				code += "		<div class='card-header'>"
// 				code += "			<h3 class='caerd-title'><a href='/admin/lectureDetail?lctNO="+conList[i].lctNo+"&prmmNo="+conList[i].prmmNo+"'>"+conList[i].prmmTitle+"</a></h3>"
// 				code += "		</div>"
// 				imgPath = conList[i].attNm;
// 				if(imgPath == null){
// 					imgPath = "/강의기본이미지.jpg"
// 				}
// 				code += "		<div class='card-card-body'>"
// 				code += "			<div class='card lectureCont'><a href='/admin/lectureDetail?lctNO="+conList[i].lctNo+"&prmmNo="+conList[i].prmmNo+"'><img class='profile-user-img img-fluid' src='/resources/images"+imgPath+"' alt='User profile picture' style='width: 400px;height: 300px;'></a></div>"
// 				code += "			<div>"+conList[i].prmmContent+"</div>"
// 				code += "		</div>"
// 				code +=	"	</div>"
// 				code += "</div>"
			}
			if(result.total == 0){
				code += "<tr><td colspan='3'>강의가 없습니다.</td></tr>"

			}
			code += "</table>"

			if(result.total != 0){
				pCode += "<ul class='pagination justify-content-center'>";
				pCode += "	<li class='paginate_button page-item previous ";
				if(result.startPage < 11){
					pCode += "      disabled'";
				}
				pCode += "		id='dataTable_previous'>";
				pCode += "		<a href='javascript:' onclick='"+pageBtn+"'";
				pCode += "			aria-controls='dataTable' data-dt-idx='0' tabindex='0'";
				pCode += "			class='page-link' id='"+(result.startPage-10)+"'>Previous</a>";
				pCode += "	</li>";
				pCode += "";
				// 여기 까지 일단 붙이고
				// 반복문 시작
				for(let i = result.startPage; i<=result.endPage; i++){
					pCode += "		<li class='paginate_button page-item";
					// if문 시작
					if(result.currentPage == i){
						pCode += "			active";
					}
					pCode += "'>";
					// if문 끝

					pCode += "			<a href='javascript:' onclick='"+pageBtn+"'";
					pCode += "				aria-controls='dataTable' data-dt-idx='1' tabindex='0'";
					pCode += "			class='page-link nodalPage'>"+i+"</a>";
					pCode += "		</li>";
				}
				// 반복문 끝
				pCode += "	<li class='paginate_button page-item next";
				// if문으로 넣기
	// 				pCode += "		<c:if test='${data.endPage ge data.totalPages }'>disabled</c:if>";
				if(result.endPage >= result.totalPages){
					pCode += " disabled'";
				}
				pCode += "	' id='dataTable_next'>";
				pCode += "		<a href='javascript:' onclick='"+pageBtn+"'";
				pCode += "		   aria-controls='dataTable' data-dt-idx='7' tabindex='0'";
				pCode += "		   class='page-link' id= '"+(result.startPage+10)+"'>Next</a>";
				pCode += "	</li>";
				pCode += "</ul>";
			}
			console.log(code);
			$(list).html(code);
			console.log(pCode);
			$(page).html(pCode);
			$(curPage).val(result.currentPage);
		}
	});	// end ajax
}

function pageClick(link){
	let value = link.innerHTML;
	console.log(value);
	let idL = link.getAttribute("id");
	console.log(idL);
	if(value == "Previous" || value == "Next" ){
		value = idl;
	}

	var keyword = $("#keyword").val();
	console.log(keyword);
	var searchType = $("#searchType").val();
	console.log(searchType);
	var data = {"keyword": keyword, "currentPage": value, "searchType":searchType, "kind" : "lecture", "isPermit" : ""}
	makeAjax(data,"#premiumList","#page","#curP","pageClick(this)");
}

function specialPageClick(link){
	let value = link.innerHTML;
	console.log(value);
	let idL = link.getAttribute("id");
	console.log(idL);
	if(value == "Previous" || value == "Next" ){
		value = idl;
	}

	var keyword = $("#keyword").val();
	console.log(keyword);
	var searchType = $("#searchType").val();
	console.log(searchType);
	var data = {"keyword": keyword, "currentPage": value, "searchType":searchType, "kind" : "special", "isPermit" : ""}
	makeAjax(data,"#specialList","#specialPage","#specialCurP","specialPageClick(this)");
}

function insertInput(){
	$("#prmmTitle").val("DEEP AI DAY");
	$('#prmmContent2').summernote('pasteHTML', "* 인공 신경망, weight와 bias의 직관적 이해<br/><br/>* 선형 회귀, 개념부터 알고리즘까지 step by step<br/><br/>* 가중치 초기화 기법 정리\n* GD vs SGD<br/><br/>* mini-batch SGD & Momentum & RMSprop & Adam 직관적 이해<br/><br/>* Traming vs Test vs Validation<br/><br/>* K-fold Cross Validation<br/><br/><strong>딥러닝, 그 것이 알고 싶다.</strong><br/><br/>* DNN, 단 한 줄의 수식으로 표현하기 (행렬과 벡터의 식)<br/><br/>* 왜 non-linear activation이 중요할까?<br/><br/>* Backpropagation : 깊은 인공신경망의 학습");
}
</script>

<div class="content-header">
	<h5>강의/특강 관리</h5>
</div>

<!-- Nav tabs -->
<ul class="nav nav-pills" role="tablist">
	<li class="nav-item">
		<a class="nav-link <c:if test = "${isSpecial == 'no' }">active</c:if><c:if test = "${empty isSpecial }">active</c:if>" data-toggle="tab" href="#home">강의 목록</a>
	</li>
	<li class="nav-item">
		<a class="nav-link <c:if test = "${isSpecial == 'yes' }">active</c:if>" data-toggle="tab" href="#menu1">특강목록</a>
	</li>
</ul>

<div class="card p-2">
	<div class="tab-content">
		<div id="home" class="col-md-12 container tab-pane <c:if test = "${param.isSpecial == 'no' }">active</c:if>
		                                                   <c:if test = "${empty param.isSpecial }">active</c:if>
		                                                   <c:if test = "${param.isSpecial == 'yes' }">fade</c:if>  ">
			<form>
				<input type="hidden" name="isSpecial" value="no" />
				<div class="card-header">
					<div class="row" style="justify-content: flex-end;">
						<button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#myModal">강의 등록</button>
					</div>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-2">
							<select class="form-control" id="searchType" name="searchType">
								<option value="title" <c:if test="${param.searchType == 'title' }"><c:out value="selected"/></c:if>>제목</option>
								<option value="content" <c:if test="${param.searchType == 'content' }"><c:out value="selected"/></c:if>>내용</option>
							</select>
						</div>
						<div class="col">
							<input type="text" placeholder="검색어를 입력해주세요" value="${param.keyword}" id = "keyword"
								   name="keyword" class="form-control form-control-md" />
						</div>
						<div class="col-2">
							<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
						</div>
					</div>
					<div id="premiumList"  style="padding-top: 50px;"></div>
				</div>
				<div class="card-footer clearfix">
					<div id="page"></div>
				</div>
				<input id="curP" type="hidden" name="currentPage" value="" />
			</form>
		</div>

<!-- 			-----------------------------2페이지--------------------------- -->
		<div id="menu1" class="col-md-12 container tab-pane <c:if test = "${param.isSpecial == 'yes' }">active</c:if>
		                                                    <c:if test = "${param.isSpecial == 'no' }">fade</c:if>">
			<form>
				<input type="hidden" name="isSpecial" value="yes" />
				<div class="card-header">
					<div class="row" style="justify-content: flex-end;">
						<button type="button" class="btn btn-outline-info" data-toggle="modal"data-target="#myModal2">특강 등록</button>
					</div>
				</div>
				<div class="card-body">
					<div class="row">
						<div class="col-2">
							<select class="form-control" id="searchType" name="searchType">
								<option value="title" <c:if test="${param.searchType == 'title' }"><c:out value="selected"/></c:if>>제목</option>
								<option value="content" <c:if test="${param.searchType == 'content' }"><c:out value="selected"/></c:if>>내용</option>
							</select>
						</div>
						<div class="col">
							<input type="text" placeholder="검색어를 입력해주세요" value="${param.keyword}" id = "keyword"
								   name="keyword" class="form-control form-control-md" />
						</div>
						<div class="col-2">
							<button type="submit" class="btn btn-block btn-outline-dark">Search</button>
						</div>
					</div>
					<!-- 여기에 들어갈 예정 -->
					<div id="specialList" style="padding-top: 50px;"></div>
				</div>
				<div class="card-footer clearfix">
					<div id="specialPage"></div>
				</div>
				<input id="specialCurP" type="hidden" name="currentPage" value="" />
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="myModal">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">강의 추가</h4>
				<div class="row" style="justify-content: flex-end;">
					<button type="button" id="crtBtn1" class="btn btn-outline-info" style="margin-right: 10px;">확인</button>
					<button type="button" class="btn btn-defalt" data-dismiss="modal">X</button>
				</div>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<form action="/admin/registLecture" id="lectForm" method="post" enctype="multipart/form-data">
						<div class="row" style="margin-bottom: 10px;">
							<div class="col">
								<input type="text" class="form-control" name="prmmTitle" placeholder="강의 제목을 입력해주세요" value="" />
							</div>
							<div class="col-3">
								<select class="form-control" name="lctInstrNm">
										<option selected disabled>강사선택</option>
									<c:forEach var="commonCodeVO" items="${teacher}" varStatus="stat">
										<option value="${commonCodeVO.cmcdDtlNm}" > ${commonCodeVO.cmcdDtlNm} </option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="row">
							<textarea name="prmmContent1" id="prmmContent1"></textarea>
						</div>
						<input type="file" class="form-control" id="prmmImg" name="prmmImg" />
						<security:csrfInput />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myModal2">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">특강 추가</h4>
				<div class="row" style="justify-content: flex-end;">
					<button type="button" class="btn btn-danger" style="margin-right: 10px;" onclick="insertInput()">데이터 넣기</button>
					<button type="button" id="crtBtn2" class="btn btn-outline-info" style="margin-right: 10px;">확인</button>
					<button type="button" class="btn btn-defalt" data-dismiss="modal">X</button>
				</div>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<div class="card-body">
					<form action="/admin/registSpecial" id="specForm" method="post" enctype="multipart/form-data">
						<div class="row" style="margin-bottom: 10px;">
							<div class="col">
								<input type="text" class="form-control" name="prmmTitle" id="prmmTitle" placeholder="특강 제목을 입력해주세요" value="" />
							</div>
							<div class="col-3">
								<select class="form-control" name="lctInstrNm">
									<option selected disabled>강사선택</option>
									<c:forEach var="commonCodeVO" items="${teacher}" varStatus="stat">
										<option value="${commonCodeVO.cmcdDtlNm}" > ${commonCodeVO.cmcdDtlNm} </option>
									</c:forEach>
								</select>
							</div>
							<div class="col-3">
								<input type="date" name="lctDt" id="lctDt" class="form-control" value="" />
							</div>
						</div>
						<div class="row">
							<textarea name="prmmContent2" id="prmmContent2"></textarea>
						</div>
						<input type="file" class="form-control" id="prmmImg" name="prmmImg" />
						<security:csrfInput />
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


