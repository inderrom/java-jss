<%@page import="kr.or.ddit.vo.EnterpriseMemVO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

  <section style="margin-left: 4.4rem;margin-right: 4.4rem;padding-top: 7rem;" >

    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- -------------------- body 시작 -------------------- -->
    <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">채용 상세 공고</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form  name="job_post_update" method="post" action="" onsubmit="return submit_modify_check()">
                <input type="hidden" name="jobPstgNo" value="${jobPostingVO.jobPstgNo}" />
                <input type="hidden" name="entNo" value="${jobPostingVO.entNo}" />
                <input type="hidden" name="jobPstgAprvYn" value="${jobPostingVO.jobPstgAprvYn}" />
                <div class="card-body">

				<!-- 직군 선택 변경 -->
					<section class="py-6">
					  <div class="container">
					    <div class="row justify-space-between py-2">

							<div class="nav-wrapper position-relative end-0">
							   <ul class="nav nav-pills nav-fill p-1" style="height: 45px;" role="tablist">
							      <li class="nav-item">
							         <a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true">
										<div>
											<select style="width: 100px;" class="form-select" name="choices-button" id="inputGroupSelect01" placeholder="Departure" onchange="changeValue(this)">
											    <option selected="">${jobCodeVOList[0].cmcdClfcNm} 선택</option>
											    <c:forEach items="${jobCodeVOList}" var="jobGroup">
											    	<option  value="${jobGroup.cmcdDtl}">${jobGroup.cmcdDtlNm}</option><!-- onclick="choiceSelect(this)" 삭제 -->
											    </c:forEach>
											</select>
										</div>
							         </a>
							      </li>
							      <li class="nav-item">
							         <a id="job_click" class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false">
							        직무 선택
							         </a>
							      </li>
							      <li class="nav-item skill_item" style="display: none">
							         <a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#v-pills-settings" role="tab" aria-controls="v-pills-settings" aria-selected="false">
							         스킬
							         </a>
							      </li>
							      <li class="nav-item">
							         <a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false">
							        	태그
							         </a>
							      </li>
							    </ul>
							</div>

					      <div class="col me-auto my-auto text-start">
					        <div class="tab-content" id="v-pills-tabContent">

					          <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">

					          </div>

					          <div class="tab-pane fade " id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
						          <div class="card" >
						          	<div class="card-body" >
							            <div id="jobGroup" class="row align_fe" style="display: block;"><span style="justify-content: center;">직무을 선택해주세요</span> </div>

							          	<div class="jobgroup_box" data-value="DEVELOPER" style="display: none;">
							          		<c:forEach items="${developerList}" var="developer">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr detail_data job_btn"  data-value="${developer.cmcdDtl}" >${developer.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>
							          	<div class="jobgroup_box" data-value="MANAGEMENT" style="display: none;">
							          		<c:forEach items="${managementVOList}" var="management">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr detail_data job_btn"   data-value="${management.cmcdDtl}" >${management.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>
							          	<div class="jobgroup_box" data-value="MARKETING" style="display: none;">
							          		<c:forEach items="${marketingVOList}" var="marketing">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr detail_data job_btn"  data-value="${marketing.cmcdDtl}" >${marketing.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>
							          	<div class="jobgroup_box" data-value="DESIGN" style="display: none;">
							          		<c:forEach items="${designVOList}" var="design">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr detail_data job_btn"  data-value="${design.cmcdDtl}" >${design.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>

						          	</div>
						          </div>

					          </div>



					          <div class="tab-pane fade " id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
											<div id="skillGroup" class="row align_fe">
												<div class="card">
													<div class="card-body">
														<c:forEach items="${skillCodeVOList}" var="skill">
															<button type="button" onclick="addSkillData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr detail_data  skill_btn " 	data-value="${skill.cmcdDtl}">${skill.cmcdDtlNm}</button>
														</c:forEach>
													</div>
												</div>
											</div>
							</div>

					          <div class="tab-pane fade " id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
											<div class="card">
												<div class="card-body">
													<div id="jobGroup" class="row align_fe">
														<c:forEach items="${jobTagCodeVOList}" var="tag">
															<button type="button" onclick="addTagData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr detail_data tag_btn " 	data-value="${tag.cmcdDtl}">${tag.cmcdDtlNm}</button>
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
					        </div>
					      </div>
					    </div>
					  </div>
					</section>

					<!-- 선택한 스킬 -->
					<input type="hidden" name="selectSkillList" id="selectSkillList" value="" />
					<!-- 선택한 태그 -->
					<input type="hidden" name="selectTagList" id="selectTagList" value="" />
					<!-- 선택한 직문-->
					<input type="hidden" name="selectJobList" id="selectJobList" value="" />

					<div class="form-group">
						<div class="row">
								<div class="col-6">
									<div class="input-group input-group-static mb-4">
							          <label>공고 제목</label>
							          <input class="form-control detail_data" name="jobPstgTitle" placeholder="공고 제목" value="${jobPostingVO.jobPstgTitle}" type="text"  required/>
							        </div>
								</div>
								<div class="col-6">
									<div class="input-group input-group-dynamic mb-4 mt-4">
									  	<span class="input-group-text">원</span>
								        <input class="form-control detail_data" aria-label="Amount (to the nearest dollar)" id="showjobPstgPrize" name="showjobPstgPrize" value="${jobPostingVO.jobPstgPrize}" placeholder="취업 축하금" type="text" required />
										<input  type="hidden" name="jobPstgPrize" value="${jobPostingVO.jobPstgPrize}"/>
									</div>
								</div>
						</div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-6">
								<div class="input-group input-group-static my-3">
							    	<label>시작 일자</label>
							    	<input type="date" class="form-control detail_data" id="jobPstgBgngDt" name="jobPstgBgngDt"  value="${jobPostingVO.jobPstgBgngDt}" required  />
							    </div>
							</div>

							<div class="col-6">
								<div class="input-group input-group-static my-3">
									<label>종료 일자</label>
							     	<input type="date" class="form-control detail_data" id="jobPstgEndDate" name="jobPstgEndDate" value="${jobPostingVO.jobPstgEndDate}" required  />
							    </div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="mt-2">
								<label>공고 내용</label><span class="jobPstgContent" style="float: right;"> 0 / 1000 </span>
							</div>

							<div class="input-group input-group-dynamic">
						      <textarea class="form-control detail_data" rows="3"  name="jobPstgContent" placeholder="공고 내용" style="height: 81px;" required>${jobPostingVO.jobPstgContent}</textarea>
					    </div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-6">
								<div class="mt-4">
									<label>혜택 및 복지</label><span class="jobPstgBnf" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control detail_data" rows="3"  name="jobPstgBnf" placeholder="혜택 및 복지" style="height: 81px;" required>${jobPostingVO.jobPstgBnf}</textarea>
							    </div>
							</div>
							<div class="col-6">
								<div class="mt-4">
									<label>주요 업무</label><span class="jobPstgMainWork" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control detail_data" rows="3"  name="jobPstgMainWork" placeholder="주요 업무" style="height: 81px;" required>${jobPostingVO.jobPstgRpfntm}</textarea>
							    </div>
							</div>
						</div>
					</div>


					<div class="form-group">
						<div class="row">
							<div class="col-6">
								<div class="mt-4">
									<label>자격 요건</label><span class="jobPstgQlfc" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control detail_data" rows="3"  name="jobPstgQlfc" placeholder="자격 요건" style="height: 81px;" required>${jobPostingVO.jobPstgMainWork}</textarea>
							    </div>

							</div>
							<div class="col-6">
								<div class="mt-4">
									<label>우대사항</label><span class="jobPstgRpfntm" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control detail_data" rows="3"  name="jobPstgRpfntm" placeholder="자격 우대사항" style="height: 81px;" required>${jobPostingVO.jobPstgQlfc}</textarea>
							    </div>

							</div>
						</div>

					</div>


						<!-- /.card-body -->
	                <sec:csrfInput/>
	                 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

	                <div id="modify_mod" class="card-footer left_position" style="display: none;"  >
	                  <button type="submit" id="modify"  class="btn bg-gradient-warning input_left_margin">수정</button>
	                  <button type="button" onclick="roolback_page()" class="btn bg-gradient-danger input_left_margin">뒤로가기</button>
	                </div>

	                <div id="detail_mod" class="card-footer left_position" >
		                <c:if test="${jobPostingVO.jobPstgAprvYn == 'N'}">
		                  <button type="button" onclick="modify_fun()" class="btn bg-gradient-info input_left_margin">수정하기</button>
			              <button type="button" onclick="delete_fun()" id="delete"  class="btn bg-gradient-danger input_left_margin">삭제</button>
		                </c:if>
	                  <a href="/enterprise/job_posting" type="submit" class="btn bg-gradient-success input_left_margin">홈으로</a>
	                </div>
                </div>
             </form>
			<form action="" method="post" name="job_post_delete">
		    	<input type="hidden" name="jobPstgNo" value="${jobPostingVO.jobPstgNo}" />
				<sec:csrfInput/>
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
            </div>


    <div id="modal" style="display: none;">
  <div id="modal-content"></div>
</div>
</section>
    <script>
    //선택 직업 배열
    let selecJobValues = [];
    //선택 태그 배열
    let selectedTagValues = [];

    //선택 스킬 배열
    let selectedSkillValues = [];


    let falg_dataSetting = true;

 // 직무 선택 함수
    function changeValue(el){
    	// select
    	   let mySelect = document.getElementById("inputGroupSelect01");
    	// 선택한 값
    	   let target = mySelect.options[mySelect.selectedIndex].value;


    	   let selectedJob= document.getElementsByClassName("jobgroup_box");
    	   console.log(selectedJob);

    	   Array.from(selectedJob).forEach(function(job_div){
    		   // div 내용물 값 value
    		   let jobGroup_div_vlaue =job_div.dataset.value;
    		    console.log(job_div);




    		    if(target == jobGroup_div_vlaue){
    		   	 	job_div.style.display ="block";

    		    	let jobGroupInfo = document.getElementById("jobGroup");
    		    	if(jobGroupInfo.style.display == "block"){
    		    		jobGroupInfo.style.display='none'
    		    	}
    		    }else{
    		    	job_div.style.display ="none";
    		    }

    		    // 개발자면 스킬 태그 열리는 메서드
    		    if(target == "DEVELOPER"){
    		    	let skill_item = document.getElementsByClassName("skill_item")[0];
	    		    skill_item.style.display  = "block"

	    		  	let job_click = document.getElementById("job_click");
	    		    job_click.click();
    		    }else{
    		    	let skill_item = document.getElementsByClassName("skill_item")[0];
	    		    skill_item.style.display = "none"

	    		    let job_click = document.getElementById("job_click");
	    		    job_click.click();
    		    }

    		});
    }



    // 글자수 계산기
    let textareas = document.querySelectorAll('textarea');

    textareas.forEach(textarea => {
  	  textarea.addEventListener('keyup', function() {
  		  console.log(this)

  			  // 글자수 안내를 위한 span
  			  const this_span = this.parentNode.parentNode.children[0].children[1];
  			  // 내가 입력한 글
				  let this_content = this.value;
  			  //내가 입력한 글자수
  			  let content_length = this_content.length;

  			  if(content_length >1000){
  				  this.value = this_content.substring(0, 1000);
  				  content_length= this.value.length;
  				Swal.fire("글자수가 1000자를 초과했습니다.")
	    			  this.focus();
  			  }
  			  this_span.textContent = content_length+' / 1000';
  			  //자동 높이 조절
  			  this.style.height = 'auto';
  			  this.style.height = this.scrollHeight + 'px';

	  	 });
	  });//end  textareas


    //채용공고 삭제 클릭
    function delete_fun() {

    	Swal.fire({
    		  title: '채용공고 삭제',
    		  text: "정말로 채용공고를 삭제하시겠습니까?",
    		  icon: 'warning',
    		  showCancelButton: true,
    		  confirmButtonColor: '#DB2C2C',
    		  cancelButtonColor: '#26C56F',
    		  confirmButtonText: '삭제하기!'
    		}).then((result) => {
    		  if (result.isConfirmed) {
  				 let deleteForm = document.job_post_delete;
  		    	 deleteForm.action ="/enterprise/delete";
    		   	 deleteForm.submit();
	    		 return true;
    		  }
    		})
	}


    //수정공고 클릭시 검사 함수
    function submit_modify_check() {
    	 let updateForm = document.job_post_update;
    	 updateForm.action ="/enterprise/modify";

    	 let startDt =document.getElementById("jobPstgBgngDt");
    	 let startDtValue = startDt.value;

    	 let endDt =document.getElementById("jobPstgEndDate");
    	 let endDtValue = endDt.value;
    	 console.log(endDtValue.length);

    	 if(startDtValue.length ==0){
    		 startDt.focus();
    		 Swal.fire("시작일자를 선택해주세요");
    		 return false;
    	 }
    	 if(endDtValue.length ==0){
    		 endDt.focus();
    		 Swal.fire("종료일자를 선택해주세요");
    		 return false;
    	 }

    	 if(selectedValues.length <1){
    		 Swal.fire("직무를 선택해주세요")
    		 return false;
    	 }
	}

  //클릭한 원하는 스킬 가져오는 메서드
	function addSkillData(button) {
    	//색 변경
    	if (button.classList.contains("btn-outline-success")) {
		    button.classList.remove("btn-outline-success");
		    button.classList.add("bg-gradient-success");
		  } else {
		    button.classList.add("btn-outline-success");
		    button.classList.remove("bg-gradient-success");
		  }

    	//클릭시 값 저장 또는 삭제
		  button.classList.toggle('selected');
		  let value = button.getAttribute('data-value');
		  if (button.classList.contains('selected')) {
			  selectedSkillValues.push(value);
		  } else {
			  let index = selectedSkillValues.indexOf(value);
		    if (index > -1) {
		    	selectedSkillValues.splice(index, 1);
		    }
		  }

		  //선택한 값을 넣음
		  let selectedSkillValuesInput = document.getElementById('selectSkillList');
		  selectedSkillValuesInput.value = selectedSkillValues;

	}// end addSkillData

	//클릭한 원하는 직업 가져오는 메서드
	function addJobData(button) {
    	//색 변경
    	if (button.classList.contains("btn-outline-success")) {
		    button.classList.remove("btn-outline-success");
		    button.classList.add("bg-gradient-success");
		  } else {
		    button.classList.add("btn-outline-success");
		    button.classList.remove("bg-gradient-success");
		  }

    	//클릭시 값 저장 또는 삭제
		  button.classList.toggle('selected');
		  let value = button.getAttribute('data-value');
		  if (button.classList.contains('selected')) {
		    selecJobValues.push(value);
		  } else {
			  let index = selecJobValues.indexOf(value);
		    if (index > -1) {
		      selecJobValues.splice(index, 1);
		    }
		  }

		  //선택한 값을 넣음
		  let selecJobValuesInput = document.getElementById('selectJobList');
		  selecJobValuesInput.value = selecJobValues;

		}// end addJobData

	//클릭한 채용공고 태그 가져오는 메서드
	function addTagData(tagButton) {

		//색 변경
    	if (tagButton.classList.contains("btn-outline-success")) {
    		tagButton.classList.remove("btn-outline-success");
    		tagButton.classList.add("bg-gradient-success");
		  } else {
			tagButton.classList.add("btn-outline-success");
			tagButton.classList.remove("bg-gradient-success");
		  }

		//클릭시 값 저장 또는 삭제
		tagButton.classList.toggle('selected');
		  let tagValue = tagButton.getAttribute('data-value');
		  if (tagButton.classList.contains('selected')) {
			  selectedTagValues.push(tagValue);
		  } else {
		    let tagIndex = selectedTagValues.indexOf(tagValue);
		    if (tagIndex > -1) {
		    	selectedTagValues.splice(tagValue, 1);
		    }
		  }

		  //선택한 값을 넣음
		  let selectedTagValuesInput = document.getElementById('selectTagList');
		  selectedTagValuesInput.value =selectedTagValues;

	}// end addTagData


		// 초기값 세팅 메서드
		dataSetting();


	  // 초기 값 세팅
	  function dataSetting() {
	  //사용불가 처리
	  unavailable_processing();

		let jpcode= "${jobPostingVO.jobPstgNo}";
		console.log("jpcode 확인 : "+ jpcode);
		let jobList =[];
		let tagList =[];
		let skillList =[];

		<c:forEach items="${jobList}" var="item">
			jobList.push("${item.rqrJobNo}");
		</c:forEach>

		<c:forEach items="${tagList}" var="item">
			tagList.push("${item.jobPstgTagNo}");
		</c:forEach>

		<c:forEach items="${skillList}" var="item">
			skillList.push("${item.jobPstgSklNo}");
		</c:forEach>

		  //선택 직업 배열
	     selecJobValues = jobList;
	    //선택 태그 배열
	     selectedTagValues = tagList;
	    //선택 스킬 배열
	     selectedSkillValues = skillList;

		document.getElementById("selectJobList").value= selecJobValues;
		document.getElementById("selectTagList").value= selectedTagValues;
		document.getElementById("selectSkillList").value= selectedSkillValues;

// 		console.log("값 확인 : "+jobList);
// 		console.log("값 확인 :"+tagList);
// 		console.log("값 확인 :"+skillList);
// 		console.log("selectedSkillValues 값 확인 : "+selectedSkillValues);
// 		console.log("selectedTagValues 값 확인 :"+selectedTagValues);
// 		console.log("selecJobValues 값 확인 :"+selecJobValues);

		select_option();

		jobSelected();

		tagSelected();

		skillSelected();
	}

	  //사용 불가 처리
	  function unavailable_processing() {
		const detail_datas = document.getElementsByClassName('detail_data');

		for (let i=0; i<detail_datas.length; i++) {
			detail_datas[i].disabled=true;
		}

	} // end unavailable_processing

	//사용 가능 처리
	function modify_fun(){
		let modify_mod = document.getElementById('modify_mod');
		modify_mod.style.display ="flex";
		console.log(modify_mod)
		let detail_mod = document.getElementById('detail_mod');
		detail_mod.style.display ="none";
		console.log(detail_mod)

		const detail_datas = document.getElementsByClassName('detail_data');

		for (let i=0; i<detail_datas.length; i++) {
			detail_datas[i].disabled=false;
		}
	}// endmodify_fun

	//페이지 새로고침
	function roolback_page() {
		location.reload();
	}// end roolback_page

	  //job 배열 값 selected
	  function jobSelected() {
		// 모든 직무 배열을 찾고 값을 비교
		  let buttons = document.querySelectorAll('.job_btn');

		  buttons.forEach(function(button) {

		    let buttonValue = button.getAttribute('data-value');

		    if (selecJobValues.includes(buttonValue)) {
// 			    console.log(buttonValue)
// 			    console.log(selecJobValues)
		      button.classList.add('selected');
		      button.classList.remove("btn-outline-success");
		      button.classList.add("bg-gradient-success");
		      button.classList.add("btn-block");
		      button.classList.add("btn_hi");
		      }
		  });// end forEach

		}// end jobSelected

	  //tag 배열 값 selected
	  function tagSelected() {

		  let buttons = document.querySelectorAll('.tag_btn');

			console.log(selectedTagValues)
		  buttons.forEach(function(button) {
		    let buttonValue = button.getAttribute('data-value');


		    if (selectedTagValues.includes(buttonValue)) {
// 			    console.log(button)
		      button.classList.add('selected');
		      button.classList.remove("btn-outline-success");
		      button.classList.add("bg-gradient-success");
		      button.classList.add("btn-block");
		      button.classList.add("btn_hi");
		    }
		  });// end forEach
		}// end jobSelected

 //skill 배열 값 selected
	function skillSelected() {

		let buttons = document.querySelectorAll('.skill_btn');

		console.log(selectedSkillValues)
		buttons.forEach(function(button) {

		let buttonValue = button.getAttribute('data-value');

			if (selectedSkillValues.includes(buttonValue)) {
// 				console.log(buttonValue)
// 				console.log(button)
				button.classList.add('selected');
				button.classList.remove("btn-outline-success");
				button.classList.add("bg-gradient-success");
				button.classList.add("btn-block");
				button.classList.add("btn_hi");
			}
		});
	}// end skillSelected

function select_option() {
	let select = document.getElementById("inputGroupSelect01");
	let options_len = select.options.length;
	let selected_job = "${selectJobGroup}";

	for (let i = 0; i < options_len; i++) {
		if(select.options[i].value == selected_job){
			select.options[i].selected = true;
			changeValue(this);
		}

	}


}

	// 숫자 1000마다 ,찍기
	const showjobPstgPrize = document.querySelector('#showjobPstgPrize');

	showjobPstgPrize.addEventListener('keyup', function(e) {

	  let jobPstgPrizeValue = e.target.value;

	  jobPstgPrizeValue = Number(jobPstgPrizeValue.replaceAll(',', '')) ;

	  document.getElementsByName("jobPstgPrize")[0].value = jobPstgPrizeValue;
	  if(isNaN(jobPstgPrizeValue)) {
		  showjobPstgPrize.value = 0;
	  }else {
	    const formatValue = jobPstgPrizeValue.toLocaleString('ko-KR');
	    showjobPstgPrize.value = formatValue;
	  }
	})// end function

// 	// 날짜 채용공고 시작일보다 이전에  종료일을 찍을 수 없게
// 	let startjobPstgBgngDt = document.getElementById('jobPstgBgngDt');
// 	let endjobPstgEndDate = document.getElementById('jobPstgEndDate');

// 	startjobPstgBgngDt.addEventListener('change', function() {
// 	    if (startjobPstgBgngDt.value)
// 	    	endjobPstgEndDate.min = startjobPstgBgngDt.value;
// 	}, false);
// 	endjobPstgEndDate.addEventLiseter('change', function() {
// 	    if (endjobPstgEndDate.value)
// 	    	startjobPstgBgngDt.max = endjobPstgEndDate.value;
// 	}, false);

    </script>




        <!-- -------------------- body 끝 -------------------- -->
      </div><!-- /.container-fluid -->
       </section>