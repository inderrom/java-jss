<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<sec:authentication property="principal" var="login" />

<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
<link rel="stylesheet" href="/resources/css/swiper.css" />

<!-- 메인 시작-->
<!-- 메인 시작-->
<main class="job_posting_main" style="margin-top: 100px;">
	<div class="container blur border-radius-lg bg-white shadow-lg p-4" style="margin-bottom: 25px;">
			<div class="row border-radius-md mt-4 mx-sm-0 mx-1 position-relative">
				<div class="col-2" style="margin-left: 45px;">
					<label class="ms-0"  style="font-size: large;">직군 선택</label>
					<div class="dropdown">
						<a href="#"  id="JobGroupChoice" style="font-size: large;" class="btn btn-outline-success dropdown-toggle "data-bs-toggle="dropdown" id="navbarDropdownMenuLink2">
							<c:if test="${selectJobGroup == null }">전체</c:if>
							<c:forEach var="CommonCodeVO" items="${codeMap.JOB}">
								<c:if test="${CommonCodeVO.cmcdDtl ==selectJobGroup }">	${CommonCodeVO.cmcdDtlNm}</c:if>
							</c:forEach>
						</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink2">
							<li><button class="dropdown-item "
									onclick="selectedJobGroup(this)" href="#" data-code="" style="font-size: large;">전체</button></li>
							<c:forEach var="CommonCodeVO" items="${codeMap.JOB}">
								<li>
									<button class="dropdown-item" onclick="selectedJobGroup(this)" href="#" data-code="${CommonCodeVO.cmcdDtl}" style="font-size: large;">${CommonCodeVO.cmcdDtlNm}</button>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div id="selectBox" class="col">
					<label class="ms-0"  style="font-size: large;">직무 선택</label>
					<div style="display: flex; align-items: center;">
						<button type="button" onclick="show_job()" id="select_job" class="iconSize delete_btn_design" style="margin-right: 20px;">
							<img class="iconSize " alt="down-arrow" src="/resources/images/icon/down-arrow.png" />
						</button>
						<div id="selected_job" class="selected_job"></div>
					</div>
				</div>
			</div>
			<hr class="mang_gr_hr mb-5">
			<!-- 태그 선택  -->
			<div class="row" style="justify-content: center;">
				<div class="col-11">
					<c:forEach items="${codeMap.TAG}" var="tagVO">
						<button class="btn btn-outline-info btn-sm br_20 data_setting" onclick="addTagData(this)" data-value="${tagVO.cmcdDtl}" style="font-size: large;"># ${tagVO.cmcdDtlNm}</button>
						<%--       		<button class="desin_btn tag_btn" onclick="addTagData(this)" data-value="${tagVO.cmcdDtl}">${tagVO.cmcdDtlNm}</button> --%>
					</c:forEach>
				</div>
			</div>

			<!-- form 태그 -->
			<div style="display:none;">
				<form action="" id="selectedMainForm" method="get">
					<input type="text" name="selectJobGroup" id="selectJobGroup" value="" />
					<input type="text" name="selectJobList"  id="selectJobList" value="" />
					<input type="text" name="selectTagList" id="selectTagList" value="" />
					<!-- 페이징 정보  -->
					<input type="text" name="total" id="total" value="" />
					<input type="text" name="selectJobNmList" id="selectJobNmList" value="" />
				</form>
				<input type="text" name="currentPage" id="currentPage"	value="${jobPostingList.currentPage}" />
			</div>

		</div>

		<%--     <p>${jobPostingList}</p> --%>
		<!--  채용공고 시작 -->
		<section class="container blur border-radius-lg p-4">
			<div class="container">
				<!-- 무한 스크롤 div -->
				<div id="infinite_paging_container"
					class="row infinite_paging_container">
					<!-- 채용공고 생성 -->
					<c:if test="${jobPostingList.content.size() == 0}">
						<img class="text-center mb-8" alt="noJobPosting" src="/resources/images/icon/noJobPosting.png">
					</c:if>
					<c:forEach items="${jobPostingList.content}" var="jobPostingVO">
						<!-- 무한 스크롤 내용 시작-->
						<div class="col-lg-4 col-md-6 mb-7  infinite_paging_content ">
							<div class="card mt-5 mt-md-0">
								<img src=" /resources/images${jobPostingVO.attachmentList[0].attNm}" alt="img-blur-shadow" 	class="img-fluid border-radius-lg jobPosting_size" loading="lazy">
								<span id="bookMarkBtn"> <!-- 로그인 유무 -->
									<sec:authorize access="isAuthenticated()">
										<button type="button" onclick="bookmarkSettings(this,'${jobPostingVO.jobPstgNo}','${jobPostingVO.recBmkYn}')"
											data-markCheck="<c:if test="${jobPostingVO.recBmkYn ==false}">N</c:if>
											<c:if test="${jobPostingVO.recBmkYn ==true}">Y</c:if>" class="btn bg-gradient-default book_mark_position">

											<c:if test="${jobPostingVO.recBmkYn ==false}">
												<img class="book_mark_size" alt="none_choice_mark" src="/resources/images/icon/none_choice_mark.png">
											</c:if>

											<c:if test="${jobPostingVO.recBmkYn ==true}">
												<img class="book_mark_size" alt="choice_mark" src="/resources/images/icon/choice_mark.png">
											</c:if>
										</button>
									</sec:authorize>
								</span>

								<a class="pointer" onclick="detailPage(this,'${jobPostingVO.jobPstgNo}')">
									<div class="card-body pt-3 ">
										<p class="text-dark mb-2 text-sm NanumSquareNeo">${jobPostingVO.jobPstgBgngDt} ~ ${jobPostingVO.jobPstgEndDate}</p>
										<h5 class="NanumSquareRoundBold title_height" >${jobPostingVO.jobPstgTitle}</h5>
										<p class="NanumSquareRound">${jobPostingVO.entNm}</p>
										<p class="NanumSquareRoundBold">
											<fmt:formatNumber value="${jobPostingVO.jobPstgPrize}"	pattern="#,###원" />
										</p>
									</div>
								</a>
							</div>
						</div>
					</c:forEach>
					<!-- 무한 스크롤 내용 끝 -->
				</div>
				<!-- 무한 스크롤 div -->
			</div>
		</section>
</main>

<!-- 메인 끝-->
<!-- 슬라이드 -->
<script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
<!-- 페이징 -->
<script src="/resources/js/infiniteScroll.js"></script>





<script>
  //선택한 직군, 직무, 태그
 	let selectJobGroup = document.getElementById("selectJobGroup");

  // 상세 코드
 	let selectJobList = document.getElementById("selectJobList");

  // 상세 코드명
 	let selectJobNmList = document.getElementById("selectJobNmList");

 	let selectTagList = document.getElementById("selectTagList");



	//선택한 직업(code값)
	let selecJobValues = [];
	//선택한 직업 (name값)
	let selectJobinnerHTML=[];
	//선택한 태그
	let selectedTagValues = [];


 	//데이터 세팅
 	setting_data();

 	//데이터 세팅
	function setting_data(){
		let selectJobGroup_Str  = "${selectJobGroup}";
		let selectJobList_Str   = "${selectJobList}";
		let selectJobNmList_Str = "${selectJobNmList}";
		let selectTagList_Str   = "${selectTagList}";

// 		console.log(selectJobGroup_Str)
// 		console.log(selectJobList_Str)
// 		console.log(selectJobNmList_Str)
// 		console.log(selectTagList_Str)

		let selectJobList_Arr   = selectJobList_Str.split(',');
		let selectJobNmList_Arr = selectJobNmList_Str.split(',');
		let selectTagList_Arr   = selectTagList_Str.split(',');


		// 배열에 값 넣기
		selectJobList_Arr.forEach(function(item,index){
			if(item != ""){
				selecJobValues.push(item);
			}
		})

		selectJobNmList_Arr.forEach(function(item,index){
			if(item != ""){
				selectJobinnerHTML.push(item);
			}
		})

		selectTagList_Arr.forEach(function(item,index){
			if(item != ""){
				selectedTagValues.push(item);
			}
		})


// 		console.log(selecJobValues)
// 		console.log(selectJobinnerHTML)
// 		console.log(selectedTagValues)

// 		console.log(Array.isArray(selectJobList_Arr))
// 		console.log(Array.isArray(selectJobNmList_Arr))
// 		console.log(Array.isArray(selectTagList_Arr))

		//선택된 직무명 세팅
		selected_job.innerHTML =selectJobinnerHTML;

		// input에 값 넣기

		selectJobGroup.value = selectJobGroup_Str;
		selectJobList.value = selecJobValues;
		selectJobNmList.value = selectJobinnerHTML;
		selectTagList.value = selectedTagValues;

		let data_setting_btn = document.querySelectorAll(".data_setting");


		//버튼 클릭 효과
		data_setting_color(data_setting_btn);


	}

	//데이터 세팅(클릭 효과)
 	function data_setting_color(buttons) {
 		buttons.forEach((el, index) => {

				    //this에 data-value가져오기
				    let data_value = el.dataset.value;

				    // 직무 세팅
				    if(selecJobValues.indexOf(data_value) >= 0){
				    	//색 변경
				    	check_btn(el);

				    }

				    // 직무 명 세팅
				    if(selectJobinnerHTML.indexOf(data_value) >= 0){
				    	//색 변경
				    	check_btn(el);
				    }

				    // 태그 세팅
				    if(selectedTagValues.indexOf(data_value) >= 0){
				    	//색 변경
				    	check_btn(el);

				    }
 		});//end forEach
 	}// end data_setting_color

 	//버튼 클릭 세팅
 	function check_btn(el) {
 		el.classList.remove("btn-outline-info");
  		el.classList.add("bg-gradient-info");
  		el.classList.add("selected");
	}

  //페이지 정보, 조건(직무,태그 등) 가져오는 메서드
  function getPageInfo() {
 	let total = document.getElementById('total');

 	let currentPage = document.getElementById('currentPage');

 	let totalValue = total.value;

 	let currentPageValue = currentPage.value;

 	//조건
 	let selectJobGroupValue =selectJobGroup.value;
 	let selectJobListValue =selectJobList.value;
 	let selectJobNmListValue =selectJobNmList.value;
 	let selectTagListValue =selectTagList.value;

 	let pageInfo = new Map();
 	pageInfo.set("selectJobGroup", selectJobGroupValue);
 	pageInfo.set("selectJobList", selectJobListValue);
 	pageInfo.set("selectJobNmList", selectJobNmListValue);
 	pageInfo.set("selectTagList", selectTagListValue);

 	pageInfo.set("total", totalValue);
 	pageInfo.set("currentPage", currentPageValue);

 	 let statusInfo = {
			  "total" : Number(totalValue) ,
			  "currentPage" : Number(currentPageValue),
			  "selectJobGroup" :selectJobGroupValue,
			  "selectJobList" : selectJobListValue,
			  "selectJobNmList" :selectJobNmListValue,
			  "selectTagList" :selectTagListValue
	  }

 	return statusInfo;
 }//end getPageInfo

  //페이지 정보 업데이트 가져오는 메서드
 function updatePageInfo(currentPage) {
 	let currentPageInput = document.getElementById('currentPage');

 	currentPageInput.value = currentPage;
 }// end updatePageInfo





  // 채용공고 직무 선택
  function show_job(){
	  let find_select = document.getElementsByClassName("show_select_box")[0];

	  if(find_select !=null){
		  if (find_select.style.display === "none") {
			  find_select.style.display = "block";
		  } else {
			  find_select.style.display = "none";
		  }
		}else{
		  // 모달 버튼
		  let select_job_btn = document.getElementById('select_job');
		  //모달 만들기
		  let selet_box = document.getElementById('selectBox');

		  //section 박스 만들기
		  let select_modal_div = document.createElement('section');

		  select_modal_div.className = 'show_select_box';

		  selet_box.appendChild(select_modal_div);

		  // 직업 버튼 들어갈 div
		  let select_job_div = document.createElement('div');
		  select_job_div.className = 'selection_job_div';

		   let select_p = document.createElement('p');
		   select_p.className="JobCategoryOverlay_JobCategoryOverlay__top__title__3tneN";
		   select_p.textContent="직무를 선택해 주세요. (최대 3개 선택 가능)";

		   select_job_div.appendChild(select_p);

		   let select_in_div = document.createElement('div');
		   select_in_div.className="select_in_div";

		   select_job_div.appendChild(select_in_div);

		   let selectedValue = "${selectJobGroup}";

		   if(selectedValue =="DEVELOPER" ){
			   <c:forEach items="${codeMap.DEVELOPER}" var="developerVO" varStatus="sta">
				  let newButton${sta.index} = document.createElement("button");
				  newButton${sta.index}.type = 'button';
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  newButton${sta.index}.setAttribute("style", "font-size: large");
				  newButton${sta.index}.classList.add("btn", "btn-outline-info", "btn-sm", "br_20","data_setting_job");
				  newButton${sta.index}.setAttribute("data-value", "${developerVO.cmcdDtl}");
				  newButton${sta.index}.textContent ="${developerVO.cmcdDtlNm}";
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  select_in_div.appendChild(newButton${sta.index});
				</c:forEach>
		   }
		   if(selectedValue =="MANAGEMENT" ){
			   <c:forEach items="${codeMap.MANAGEMENT}" var="managementVO" varStatus="sta">
				  let newButton${sta.index} = document.createElement("button");
				  newButton${sta.index}.type = 'button';
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  newButton${sta.index}.setAttribute("style", "font-size: large");
				  newButton${sta.index}.classList.add("btn", "btn-outline-info", "btn-sm", "br_20" ,"data_setting_job");
				  newButton${sta.index}.setAttribute("data-value", "${managementVO.cmcdDtl}");
				  newButton${sta.index}.textContent ="${managementVO.cmcdDtlNm}";
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  select_in_div.appendChild(newButton${sta.index});
					</c:forEach>
		   }
		   if(selectedValue =="DESIGN" ){
			   <c:forEach items="${codeMap.DESIGN}" var="designVO" varStatus="sta">
				  let newButton${sta.index} = document.createElement("button");
				  newButton${sta.index}.type = 'button';
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  newButton${sta.index}.setAttribute("style", "font-size: large");
				  newButton${sta.index}.classList.add("btn", "btn-outline-info", "btn-sm", "br_20" ,"data_setting_job");
				  newButton${sta.index}.setAttribute("data-value", "${designVO.cmcdDtl}");
				  newButton${sta.index}.textContent ="${designVO.cmcdDtlNm}";
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  select_in_div.appendChild(newButton${sta.index});
					</c:forEach>
		   }
		   if(selectedValue =="MARKETING" ){
			   <c:forEach items="${codeMap.MARKETING}" var="marketingVO" varStatus="sta">
				  let newButton${sta.index} = document.createElement("button");
				  newButton${sta.index}.type = 'button';
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  newButton${sta.index}.setAttribute("style", "font-size: large");
				  newButton${sta.index}.classList.add("btn", "btn-outline-info", "btn-sm", "br_20" ,"data_setting_job");
				  newButton${sta.index}.setAttribute("data-value", "${marketingVO.cmcdDtl}");
				  newButton${sta.index}.textContent ="${marketingVO.cmcdDtlNm}";
				  newButton${sta.index}.setAttribute("onclick", "addJobData(this)");
				  select_in_div.appendChild(newButton${sta.index});
					</c:forEach>
		   }




		  select_modal_div.appendChild(select_job_div)



		  // 버튼 들어갈 div
		  let select_btn_div = document.createElement('div');
		  select_btn_div.className = 'selection_btn ';
		  //버튼 div에 들어갈 btn만들기
		  let select_btn = document.createElement('button');
		  select_btn.classList.add("btn", "btn-outline-info", "btn-sm", "br_20" );
		  select_btn.setAttribute("onclick", "selectedMainFormSubmit(this)");
		  select_btn.value="적용하기";
		  select_btn.innerHTML="적용하기";

		  select_btn_div.appendChild(select_btn);


		  select_modal_div.appendChild(select_btn_div)

		  let data_setting_job_btn = document.querySelectorAll(".data_setting_job");

			console.log(data_setting_job_btn);

			//버튼 클릭 효과
			data_setting_color(data_setting_job_btn);
	  }

  }// end job show



//클릭한 원하는 직업 가져오는 메서드
	function addJobData(button) {
	let contentValue= button.textContent

// 	console.log(selectJobinnerHTML.length ==3)
// 	console.log(selectJobinnerHTML.indexOf(contentValue) != -1)
// 	console.log(selectJobinnerHTML)
	console.log(contentValue)
	console.log(selectJobinnerHTML)

	if(selectJobinnerHTML.length >=3  ){

		if( selectJobinnerHTML.indexOf(contentValue) != -1){

			if (button.classList.contains("btn-outline-info")) {
			    button.classList.remove("btn-outline-info");
			    button.classList.add("bg-gradient-info");
	//		    button.classList.add("btn-block");
	//		    button.classList.add("btn_hi");
			  } else {
			    button.classList.add("btn-outline-info");
			    button.classList.remove("bg-gradient-info");
	//		    button.classList.remove("btn-block");
	//		    button.classList.remove("btn_hi");
			  }

			//클릭시 값 저장 또는 삭제
			  button.classList.toggle('selected');
			  let dataValue = button.getAttribute('data-value');
			  let value = button.textContent;
			  console.log(value);
			  if (button.classList.contains('selected')) {
				  selecJobValues.push(dataValue);
				  selectJobinnerHTML.push(value);
			  } else {
				  let index = selecJobValues.indexOf(dataValue);
				  let jobIndex = selecJobValues.indexOf(value);
			    if (index > -1) {
			    	selecJobValues.splice(index, 1);
			    	selectJobinnerHTML.splice(jobIndex, 1);
			    }
			  }


		}// end if
		return;
		Toastify({
			 position: "left",
			 gravity:"bottom",
			text: "선택할 수 있는 갯수는 3개 입니다.",
			style: {
				color: "black",
			    background: "linear-gradient(to right, #ffdee9, #b5fff0)",
			  },
			duration: 3000

			}).showToast();



	}


  	//색 변경
  	if (button.classList.contains("btn-outline-info")) {
		    button.classList.remove("btn-outline-info");
		    button.classList.add("bg-gradient-info");
		  } else {
		    button.classList.add("btn-outline-info");
		    button.classList.remove("bg-gradient-info");
		  }

  	//클릭시 값 저장 또는 삭제
		  button.classList.toggle('selected');
		  let dataValue = button.getAttribute('data-value');
		  let value = button.textContent;
		  console.log(value);
		  console.log(dataValue);
		  console.log(button.classList.contains('selected'));
		  console.log(selecJobValues);
		  console.log(selectJobinnerHTML);
		  if (button.classList.contains('selected')) {
			  selecJobValues.push(dataValue);
			  selectJobinnerHTML.push(value);
		  } else {
			  let index = selecJobValues.indexOf(dataValue);
			  let jobIndex = selecJobValues.indexOf(value);
		  console.log(index);
		  console.log(jobIndex);
		    if (index > -1) {
		    	selecJobValues.splice(index, 1);
		    	selectJobinnerHTML.splice(jobIndex, 1);
		    }
		  }

		  //선택한 값을 넣음
// 		  let selecJobValuesInput = document.getElementById('selectJobList');
		  let selecJobValuesInput = selectJobList;
		  selecJobValuesInput.value = selecJobValues;

		  let selected_job_div = document.getElementById('selected_job');
		  selected_job_div.innerHTML = selectJobinnerHTML;

		  let selectJobNmList = document.getElementById('selectJobNmList');
		  selectJobNmList.value = selectJobinnerHTML;

		}// end

	//클릭한 채용공고 태그 가져오는 메서드
	function addTagData(tagButton) {

		//색 변경
	  	if (tagButton.classList.contains("btn-outline-info")) {
	  		tagButton.classList.remove("btn-outline-info");
	  		tagButton.classList.add("bg-gradient-info");
		} else {
			tagButton.classList.add("btn-outline-info");
			tagButton.classList.remove("bg-gradient-info");
		}

		//클릭시 값 저장 또는 삭제
		tagButton.classList.toggle('selected');

		  let tagValue = tagButton.getAttribute('data-value');

		  if (tagButton.classList.contains('selected')) {
			  selectedTagValues.push(tagValue);
		  } else {
		    let tagIndex = selectedTagValues.indexOf(tagValue);
		    if (tagIndex > -1) {
		    	selectedTagValues.splice(tagIndex, 1);
		    }
		  }

		  //선택한 값을 넣음
		  let selectedTagValuesInput = selectTagList;
		  selectedTagValuesInput.value =selectedTagValues;

		//선택한 직군 직무 채용공고 가져오기
		selectedMainFormSubmit();

		}// end addTagData

  // 직군 선택
  function selectedJobGroup(el) {
	// 전에 선택했던 직무 초기화 작업
	let selectJobList = document.getElementById("selectJobList")
	let selectJobNmList = document.getElementById("selectJobNmList")
	let selected_job_div = document.getElementById('selected_job');
	selectJobList.value = ""
	selectJobNmList.value = ""
	selected_job_div.innerHTML = "";

	console.log(el.textContent)
	let dataCode = el.getAttribute("data-code");
	console.log(dataCode)

// 	let selectJobGroup = document.getElementById('selectJobGroup');
	selectJobGroup.value=dataCode;

	let JobGroupChoice = document.getElementById('JobGroupChoice');
	JobGroupChoice.textContent = el.textContent;

	 //선택한 직군 직무 채용공고 가져오기
	selectedMainFormSubmit();

}

  //선택한 직군 직무 채용공고 가져오기
  function selectedMainFormSubmit(){
	  let selectedMainForm = document.getElementById("selectedMainForm");
		console.log(selectedMainForm);
		selectedMainForm.action="/jobPosting/selectedMain";
		selectedMainForm.submit();

  }

  // 클릭시 바로 aJAX 통신(선택한 것들로 가져오기)
function get_selecte_job_postings() {
	//선택한 직군
// 	let selectJobGroup = document.getElementById('selectJobGroup');
	let selectJobGroupVlaue = selectJobGroup.value;
	//선택한 직무
// 	let selectJobList = document.getElementById('selectJobList');
	let selectJobListVlaue = selectJobList.value;
	//선택한 태그
// 	let selectTagList = document.getElementById('selectTagList');
	let selectTagListVlaue = selectTagList.value;

	let selectedValues = { "jobGroup":selectJobGroupVlaue, "job":selectJobListVlaue, "tag":selectTagListVlaue };
	$.ajax({
		url : "/jobPosting/selectedCondition",
		data : JSON.stringify(selectedValues),
		contentType: "application/json;charset=utf-8",
		type : "post",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res) {
			console.log(res);
		}

	})// end ajax



}// end get_selecte_job_postings
  </script>


<!-- 무한스크롤 함수 -->
<script type="text/javascript">
 // 무한 스크롤 기능
 function YesScroll () {
	 const pagination = document.querySelector('.infinite_paging_content');
	 console.log(pagination)
	 const fullContent = document.querySelector('.infinite_paging_container');
	 console.log(fullContent)
	 const screenHeight = screen.height;
	 console.log(screenHeight)
	 let oneTime = false;
	 document.addEventListener('scroll',OnScroll,{passive:true})
	  function OnScroll () {
	    const fullHeight = fullContent.clientHeight;
	    const scrollPosition = pageYOffset;
	    if (fullHeight-screenHeight/2 <= scrollPosition && !oneTime) {
	      oneTime = true;

	      madeBox();
	    }
	  }//end OnScroll
	   function madeBox() {
		  // 페이지 정보 함수
		  let statusInfo =  getPageInfo();

// 		  let statusInfo = {
// 				  "total" : Number(mapmap.get('total')) ,
// 				  "currentPage" : Number(mapmap.get('currentPage')),
// 				  "selectJobGroup" :mapmap.get('selectJobGroup'),
// 				  "selectJobList" :mapmap.get('selectJobList'),
// 				  "selectJobNmList" :mapmap.get('selectJobNmList'),

// 				  "selectTagList" :mapmap.get('selectTagList')
// 		  }

		  $.ajax({
			  url:"/jobPosting/getPage",
			  data : JSON.stringify(statusInfo),
			  contentType: "application/json;charset=UTF-8",
			  method: "POST",
			  beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				  xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			  },
			  success : function(res) {

				  let jobPostingVO = res.content;
				  let currentPage =res.currentPage;
				  let voSize =res.content.length;

				  console.log(jobPostingVO)
				  console.log(currentPage)
				  console.log(voSize)

				  let checkCurrentPage = document.getElementById('currentPage');
				  let checkCurrentPageValue = checkCurrentPage.value;

				  console.log(checkCurrentPage)
				  console.log(checkCurrentPageValue == currentPage)
				  // 중복 페이지 체크
				 if(checkCurrentPageValue == currentPage){

// 					 Toastify({
// 						 position: "right",
// 						text: "더이상 채용공고가 없습니다.",
// 						style: {
// //			 				color: black;
// 						    background: "linear-gradient(to right, #ffdee9, #b5fff0)",
// 						  },
// 						duration: 3000

// 						}).showToast();

				 }else{


				  for (var i = 0; i < voSize; i++) {
				// create the largest container
				  const content_container = document.createElement('div');
				  content_container.classList.add("col-lg-4", "col-md-6", "mb-7", "infinite_paging_content");





				  // first div
				  const first_card_div = document.createElement('div');
				  first_card_div.classList.add("card", "mb-5", "mt-md-0");
				  content_container.appendChild(first_card_div);

				  // add image
				  const img = document.createElement('img');
				  img.src = '/resources/images'+jobPostingVO[i].attachmentList[0].attNm;
				  img.alt = "img-blur-shadow";
				  img.classList.add("img-fluid", "border-radius-lg","jobPosting_size");
				  img.loading = "lazy";
				  first_card_div.appendChild(img);





				  <sec:authorize access="isAuthenticated()">
				  // 북마크 상태 체크
				  let marckCheck = bookMarkCheck(jobPostingVO[i].jobPstgNo);

				  // 북마크 버튼
				  const secAuthorize = document.createElement('sec:authorize');
					secAuthorize.setAttribute("access", "isAuthenticated()");

					first_card_div.appendChild(secAuthorize);




				  const book_mark_button = document.createElement('button');
				  book_mark_button.type = "button";
// 				  book_mark_button.setAttribute("onclick", "addJobData(this)");
				  book_mark_button.classList.add("btn", "bg-gradient-default", "book_mark_position");
				  book_mark_button.setAttribute('onclick', "bookmarkSettings(this,'"+jobPostingVO[i].jobPstgNo+"','"+jobPostingVO[i].recBmkYn+"')");


				  secAuthorize.appendChild(book_mark_button);

				  //북마크 버튼안에 북마크 사진
				  const book_mark_img = document.createElement('img');
				  book_mark_img.classList.add('book_mark_size');

				  console.log(jobPostingVO[i].entNo);
				  //북마크 체크 해야함
				  console.log(marckCheck);

				  if(marckCheck){
// 					  console.log(marckCheck+" 여기?");
					  book_mark_button.setAttribute('data-markcheck', "Y");
				 	 book_mark_img.src = '/resources/images/icon/choice_mark.png';
				  }else{
// 					  console.log(marckCheck+" 여기?");
					  book_mark_button.setAttribute('data-markcheck', "N");
				  	book_mark_img.src = '/resources/images/icon/none_choice_mark.png';
				  }

				  book_mark_button.appendChild(book_mark_img);

				  </sec:authorize>


				  let datail_a_tag = document.createElement('a');
				  datail_a_tag.setAttribute("onclick", "detailPage(this,'"+jobPostingVO[i].jobPstgNo+"')");
				  datail_a_tag.classList.add("pointer");
// 				  datail_a_tag.setAttribute('data-jobPstgNo', jobPostingVO[i].jobPstgNo);
// 				  datail_a_tag.addEventListener('click', function() {
// 					  detailPage(this);
// 					});

// 				  datail_a_tag.onclick = function() {
// 					  detailPage(this);
// 					};
				  first_card_div.appendChild(datail_a_tag);



				  // add card body
				  const card_body = document.createElement('div');
				  card_body.classList.add("card-body", "pt-3", "pointer");
				  datail_a_tag.appendChild(card_body);

				  // add 날짜
				  const date_p = document.createElement('p');
				  date_p.classList.add("text-dark", "mb-2", "text-sm", "NanumSquareNeo");
				  date_p.textContent = jobPostingVO[i].jobPstgBgngDt+' - '+jobPostingVO[i].jobPstgEndDate;
				  card_body.appendChild(date_p);

// 				  // add job title
// 				  const job_title_a = document.createElement('a');
// 				  job_title_a.href = "javascript:;";
// 				  card_body.appendChild(job_title_a);

				//채용공고 제목
				  const job_title_h5 = document.createElement('h5');
				  job_title_h5.classList.add("NanumSquareRoundBold", "title_height");
				  job_title_h5.textContent = jobPostingVO[i].jobPstgTitle;
				  card_body.appendChild(job_title_h5);

				  console.log(jobPostingVO[i].entNm)
				  // 기업 명
				  const job_entNm = document.createElement('p');
				  job_entNm.classList.add("NanumSquareRound");
				  job_entNm.textContent = jobPostingVO[i].entNm;
				  card_body.appendChild(job_entNm);

				  // 취업 축하금 추가
				  let prize = jobPostingVO[i].jobPstgPrize.toLocaleString('ko-KR')+"원"

// 				  const job_prize_p = document.createElement('p');
// 				  job_prize_p.innerHTML = prize;
// 				  card_body.appendChild(job_prize_p);
					const job_prize_p = document.createElement('p');
					job_prize_p.classList.add("NanumSquareRoundBold");
					const prize_text = document.createTextNode(prize);
					job_prize_p.appendChild(prize_text);
					card_body.appendChild(job_prize_p);





				  // add content to infinite paging container
				  const infinite_paging_container = document.getElementById('infinite_paging_container');
				  infinite_paging_container.appendChild(content_container);

				  }// end for

				 //현재 페이지업데이트
				  updatePageInfo(currentPage);
				 }// ende if
			  }
		  });// end ajax
	     oneTime = false;
   }//end madeBox
 }//end YesScroll
	 YesScroll();

 //북마크 등록
 function bookmarkSettings(el,jptgNo,recBmkYn) {
// 	 console.log(el)
// 	 console.log(jptgNo)
// 	 console.log(recBmkYn)
	 let data = {"etpId": jptgNo};
	 let JSONdata = JSON.stringify(data);

	 // 북마크 설정 기능
	bookMarkRun(JSONdata,el);

}// end bookmarkSettings


 // 북마크
 function bookMarkRun(JSONdata,el) {
// 	 console.log(JSONdata)

	 $.ajax({
			url:"/record/bookmarkWant",
			contentType:"application/json;charset:utf-8",
			data:JSONdata,
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log("bookmark result : " + JSON.stringify(result));
				let successCheck = JSON.stringify(result);
				console.log(el);

				let bookmark_sta = el.dataset.markcheck.trim();
// 				console.log(successCheck);
// 				console.log(bookmark_sta);
// 				console.log(el.children[0]);

				//
				 if (bookmark_sta == "Y") {
					 if(successCheck == "1"){
						 toast_center("북마크가 삭제되었습니다.")
						 el.children[0].setAttribute("src", "/resources/images/icon/none_choice_mark.png");
						 el.dataset.markcheck ="N";
					 }
				 }// end if(Y)

				 if (bookmark_sta == "N") {
					 if(successCheck == "1"){
						 toast_center("북마크가 등록되었습니다.")

						 el.children[0].setAttribute("src", "/resources/images/icon/choice_mark.png");
						 el.dataset.markcheck ="Y";

					 }
				 }// end if(N)
			}// end success
		});// end ajax

}// end bookMarkRun

 //toast center 얼터창 내용 바꾸기
 function toast_center(notice) {
	Toastify({
		position: "center",
		text: notice,
		style: {
				color: "black",
				background: "linear-gradient(to right, #ffdee9, #b5fff0)",
		},
		duration: 3000

	}).showToast();
}


 // 아직스(동기) 북마크 체크
 function bookMarkCheck(jobPstgNo){
	 let checkYN = false;
	 console.log(jobPstgNo)
	  let jobPstgNo_data = {"jobPCstgNo": jobPstgNo};
	    $.ajax({
            url: "/jobPosting/bookMarkCheck",
            contentType:"application/json;charset:utf-8",
            data: JSON.stringify(jobPstgNo_data),
//             data: jobPstgNo,
            type: 'post',
            dataType:"json",
            async: false,
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
            success: function(data) {
                	 console.log(data);
            	checkYN=data;
            }// end success
       }); // end ajax
			 return checkYN;
 }// end bookMarkCheck

 // 상세 페이지 이동
 function detailPage(el,jobPstgNo) {
	 console.log(el)
	 console.log(jobPstgNo)

	 location.href = "/jobPosting/detailJobPosting?jobPstgNo="+jobPstgNo;

}
function JobGroupChoiceFn(){

}
</script>

<!-- Initialize Swiper -->
<script>

  <!-- 무한  넘기기 기능 -->

    let swiper3 = new Swiper(".mySwiper", {
      slidesPerView: 1,
      spaceBetween: 30,
      loop: true,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });

  </script>