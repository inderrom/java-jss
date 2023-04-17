<%@page import="kr.or.ddit.vo.EnterpriseMemVO"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="entMemVO" value="${entMemVO}" />
    <section style="margin-left: 4.4rem;margin-right: 4.4rem;padding-top: 7rem;">
 <!-- Content Header (Page header) -->
    <div class="content-header">



    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <!-- -------------------- body 시작 -------------------- -->

    <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title" style="display:inline;">채용 공고 등록</h3>
                <button type="button" class="btn btn-primary" style="float:right;" onclick="insertInput()">데이터 넣기</button>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form autocomplete="off" id="insertForm" method="post" action="" name="job_post_insert" onsubmit="return submitCheck()">
                <input type="hidden" name="entNo" value="${entMemVO.ENT_NO}" />
                <div class="card-body">

				<!-- 직군 선택 변경 -->
					<section class="py-6">
					  <div class="container">
					    <div class="row justify-space-between py-2">

							<div class="nav-wrapper position-relative end-0">
							   <ul class="nav nav-pills nav-fill p-1" role="tablist">
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

					          <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
						          <div class="card" >
						          	<div class="card-body" >
							            <div id="jobGroup" class="row align_fe" style="display: block;"><span style="justify-content: center;">직무을 선택해주세요</span> </div>

							          	<div class="jobgroup_box" data-value="DEVELOPER" style="display: none;">
							          		<c:forEach items="${developerList}" var="developer">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr"  data-value="${developer.cmcdDtl}" >${developer.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>
							          	<div class="jobgroup_box" data-value="MANAGEMENT" style="display: none;">
							          		<c:forEach items="${managementVOList}" var="management">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr"  data-value="${management.cmcdDtl}" >${management.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>
							          	<div class="jobgroup_box" data-value="MARKETING" style="display: none;">
							          		<c:forEach items="${marketingVOList}" var="marketing">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr"  data-value="${marketing.cmcdDtl}" >${marketing.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>
							          	<div class="jobgroup_box" data-value="DESIGN" style="display: none;">
							          		<c:forEach items="${designVOList}" var="design">
												<button type="button" onclick="addJobData(this)" class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr"  data-value="${design.cmcdDtl}" >${design.cmcdDtlNm}</button>
							          		</c:forEach>
							          	</div>

						          	</div>
						          </div>

					          </div>



					          <div class="tab-pane fade" id="v-pills-settings" role="tabpanel" aria-labelledby="v-pills-settings-tab">
											<div id="skillGroup" class="row align_fe">
												<div class="card">
													<div class="card-body">
														<c:forEach items="${skillCodeVOList}" var="skill">
															<button type="button" onclick="addSkillData(this)"
																class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr"
																data-value="${skill.cmcdDtl}">${skill.cmcdDtlNm}</button>
														</c:forEach>
													</div>
												</div>
											</div>
							</div>

					          <div class="tab-pane fade" id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab">
											<div class="card">
												<div class="card-body">
													<div id="jobGroup" class="row align_fe">
														<c:forEach items="${jobTagCodeVOList}" var="tag">
															<button type="button" onclick="addTagData(this)"
																class="btn btn-tag-option btn-block btn-outline-success col-2 btn_hi btn_lr"
																data-value="${tag.cmcdDtl}">${tag.cmcdDtlNm}</button>
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
						          <input class="form-control" id="jobPstgTitle" name="jobPstgTitle" placeholder="공고 제목" type="text"  required/>
						        </div>
							</div>
							<div class="col-6">
								<div class="input-group input-group-dynamic mb-4 mt-4">
								  	<span class="input-group-text">원</span>
							        <input class="form-control" aria-label="Amount (to the nearest dollar)" id="showjobPstgPrize" name="showjobPstgPrize" placeholder="취업 축하금" type="text" required />
									<input  type="hidden" id="jobPstgPrize" name="jobPstgPrize" value="1000000"/>
								</div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-6">
								<div class="input-group input-group-static my-3">
							    	<label>시작 일자</label>
							    	<input type="date" class="form-control" id="jobPstgBgngDt" name="jobPstgBgngDt" required  />
							    </div>
							</div>

							<div class="col-6">
								<div class="input-group input-group-static my-3">
									<label>종료 일자</label>
							     	<input type="date" class="form-control" id="jobPstgEndDate" name="jobPstgEndDate" required  />
							    </div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<div class="mt-2">
							<label>공고 내용</label><span class="jobPstgContent" style="float: right;"> 0 / 1000 </span>
						</div>

						<div class="input-group input-group-dynamic">
					      <textarea class="form-control" rows="3" id="jobPstgContent" name="jobPstgContent" placeholder="공고 내용" style="height: 81px;" required></textarea>
					    </div>
					</div>

					<div class="form-group">
						<div class="row">
							<div class="col-6">
								<div class="mt-4">
									<label>혜택 및 복지</label><span class="jobPstgBnf" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control" rows="3" id="jobPstgBnf"  name="jobPstgBnf" placeholder="혜택 및 복지" style="height: 81px;" required></textarea>
							    </div>
							</div>
							<div class="col-6">
								<div class="mt-4">
									<label>주요 업무</label><span class="jobPstgMainWork" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control" rows="3" id="jobPstgMainWork"  name="jobPstgMainWork" placeholder="주요 업무" style="height: 81px;" required></textarea>
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
							      <textarea class="form-control" rows="3" id="jobPstgQlfc" name="jobPstgQlfc" placeholder="자격 요건" style="height: 81px;" required></textarea>
							    </div>

							</div>
							<div class="col-6">
								<div class="mt-4">
									<label>우대사항</label><span class="jobPstgRpfntm" style="float: right;"> 0 / 1000 </span>
								</div>

								<div class="input-group input-group-dynamic">
							      <textarea class="form-control" rows="3" id="jobPstgRpfntm" name="jobPstgRpfntm" placeholder="자격 우대사항" style="height: 81px;" required></textarea>
							    </div>

							</div>
						</div>
					</div>


					<!-- /.card-body -->
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <sec:csrfInput/>

 			   </div><!-- card-body -->
                <div class="card-footer left_position" >
                <!-- Button trigger modal -->
				<button type="button" class="btn btn-success" onclick="previewDataSetting()"  data-bs-toggle="modal" data-bs-target="#exampleModal">미리보기</button>
                  <button type="submit" id="insert"  class="btn btn-primary input_left_margin">등록</button>
                  <a href="/enterprise/job_posting" type="submit" class="btn bg-gradient-danger input_left_margin">취소</a>
                </div>
              </form>
            </div>

<!--     <div id="modal" style="display: none;"> -->
<!--   <div id="modal-content"></div> -->
</div>



<!-- Modal -->
<div class="modal modal-xl fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content" style="background-color: #e9e9e9;">
      <div class="modal-body modal-dialog-scrollable">
      <div style="    display: flex;
		   			 -webkit-box-pack: center;
				    justify-content: center;
				    -webkit-box-align: center;
				    align-items: center;
				    flex-wrap: nowrap;
				    gap: 0px;
				    list-style: none;
				    position: fixed;
				    z-index: 101;
				    margin-bottom: 20.5px;
				    border-radius: 50%;
				    align-self: flex-end;
				    cursor: pointer;
				    width: 0px;
				    height: 32px;
    				margin: 10px auto;
    				position: relative;
    				right: -472px;
">
	      <a type="button"  data-bs-dismiss="modal" ><img alt="" src="/resources/images/icon/x-mark.png" style="width: 32px; height: 32px;"></a>
      </div>
      <!-- 데이터 -->
       <div class="container">
		<div class="row">
			<div class="col-lg-12">
				<header>
					<div class="page-header rounded-3 min-vh-50" style="background-image: url('/resources/images/icon/previewImage.png');" loading="lazy">

					</div>
				</header>
				<div class="card card-body blur shadow-blur mx-md-4 mt-n6 overflow-hidden">
					<div class="container">
						<div class="row border-radius-md p-3 position-relative">
							<h2 class="h2_style"><span id="previewTitle"></span>
								<!-- 북마크처리 -->

<!-- 									<button type="button" onclick="bookmarkSettings(this,'JPNG0002','false')" data-markcheck="N" class="btn bg-gradient-default book_mark_position">  -->

											<img class="book_mark_size book_mark_position" alt="hollow_star" src="/resources/images/icon/hollow_star.png">


<!-- 									</button> -->

							</h2>
							<br>

							<!-- 기업 상세 이동 a 태그 -->
							<a href="#" class="title_style"><span id="previewEntNm"></span></a>
							<br>

							<div class="tag_div">
								<ul id="previewTagList" class="list_style_none">

										<li class="display_inline_block"><a class="btn tag_style" style="background-color: #FAE0E9;">급성장 중</a></li>


								</ul>
							</div>
						</div>
					</div>
					<div class="container">
						<div class="row">
							<div class="col text-center">
								<h4 class="h4_font">채용 보상금</h4> <p class="p_style"><span id="previewJobPstgPrize"></span>원</p>
							</div>

							<div class="col text-center">


									<button type="button" class="btn btn-info apply_btn" >회원 지원하기</button>

							</div>
						</div>
					</div>
				</div>
			</div>

			<section class="pt-3">
				<div class="card shadow-lg mb-5">
					<div class="card-body" style="min-height: 1000px; ">
						<div class="row content_div">
						<div class="col-3"></div> <!-- 가운데 정렬을 위한 빈칸 -->
							<div class="col-6">
								<h6  class="content_h6">주요 내용</h6>




								<p id="previewJobPstgContent"  class="NanumSquareNeo ps-2"></p>
								<br>
								<br>

								<h6 class="content_h6">주요 업무</h6>
								<p id="previewJobPstgMainWork"  class="NanumSquareNeo ps-2"></p>
								<br>
								<br>
								<hr>

								<h6 class="content_h6">자격 요건</h6>
								<p id="previewJobPstgQlfc"  class="NanumSquareNeo ps-2"></p>
								<br>
								<br>
								<hr>

								<h6 class="content_h6">우대사항</h6>
								<p id="previewJobPstgRpfntm"  class="NanumSquareNeo ps-2"></p>
								<br>
								<br>
								<hr>

								<h6 class="content_h6">혜택 및 복지</h6>
								<p id="previewJobPstgBnf"  class="NanumSquareNeo ps-2"></p>
								<br>
								<br>
								<hr>

								<h6 class="content_h6">기술스택 ・ 툴</h6>
								<div class="tag_div">
									<ul id="previewJobPstgSkill" class="list_style_none">



									</ul>
								</div>
								<p class="apply_under_line"></p>
								<div class="row">

									<div class="col-12" style="display: inline-flex;">
										<p class="apply_text  pe-6 ps-6 col-md-auto" style="color: #999999">마감일</p>
										<p class="apply_text " id="previewJobPstgEndDate"></p>
									</div>

									<div class="col-12" style="display: inline-flex;">
										<p class="apply_text  pe-5 ps-6 col-md-auto" style="color: #999999">근무지역</p>
										<p class="apply_text"></p>
									</div>

									<div id="kakaoDIV" class="mb-8 mt-4" style="width: 670px; height: 250px; position: relative; overflow: hidden; background-image:url('/resources/images/icon/previewMap.png'); ">
								</div>


							</div>
							<div class="col-3"></div><!-- 가운데 정렬을 위한 빈칸 -->
						</div>


					</div>
				</div>
			</section>
		</div>
	</div>
      </div>

    </div>
  </div>
</div>
  </section>

<script>






</script>
<script>

	//직무
    let selectedValues = [];
    let selectedJobTextValues = [];

    //태그
    let selectedTagValues = [];
    let selectedTagTextValues = [];

    //스킬
    let selectedSkillValues = [];
    let selectedSkillTextValues = [];


    // 직무 선택 함수
    function changeValue(el){
    	// select
    	   let mySelect = document.getElementById("inputGroupSelect01");
    	// 선택한 값
    	   let target = mySelect.options[mySelect.selectedIndex].value;


    	   let selectedJob= document.getElementsByClassName("jobgroup_box");
//     	   console.log(selectedJob);

    	   Array.from(selectedJob).forEach(function(job_div){
    		   // div 내용물 값 value
    		   let jobGroup_div_vlaue =job_div.dataset.value;
//     		    console.log(job_div);




    		    if(target == jobGroup_div_vlaue){
    		   	 	job_div.style.display ="block";

    		    	let jobGroupInfo = document.getElementById("jobGroup");
    		    	if(jobGroupInfo.style.display == "block"){
    		    		jobGroupInfo.style.display='none'
    		    	}
    		    }else{
    		    	job_div.style.display ="none";
    		    }

    		    //
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
//     		  console.log(this)

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



    //등록 버튼 클릭시 action 변경
   function submitCheck() {
    	 let insertForm = document.job_post_insert;
    	 insertForm.action ="/enterprise/insert";

    	 let startDt =document.getElementById("jobPstgBgngDt");
    	 let startDtValue = startDt.value;

    	 let endDt =document.getElementById("jobPstgEndDate");
    	 let endDtValue = endDt.value;
//     	 console.log(endDtValue.length);

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

   		Swal.fire({

   			  icon: 'success',
   			  text:  '채용공고가 등록 되었습니다. 24시간 이내 관리자 승인 됩니다.',
   			  title: '<strong>채용공고 등록 완료</strong>',
   			  showConfirmButton: false,
   			  timer: 1500
   			}).then(() => {
   			    insertForm.submit();
   		  });
   	 return false;
 	}


	//클릭한 원하는 스킬 가져오는 메서드
	function addSkillData(button) {
    	//색 변경
    	if (button.classList.contains("btn-outline-success")) {
		    button.classList.remove("btn-outline-success");
		    button.classList.add("bg-gradient-success");
		    button.classList.add("btn-block");
		    button.classList.add("btn_hi");
		  } else {
		    button.classList.add("btn-outline-success");
		    button.classList.remove("bg-gradient-success");
		    button.classList.remove("btn-block");
		    button.classList.remove("btn_hi");
		  }

    	//클릭시 값 저장 또는 삭제
		  button.classList.toggle('selected');
		  let value = button.getAttribute('data-value');
		  let textValue = button.textContent;
		  if (button.classList.contains('selected')) {
			  selectedSkillValues.push(value);
			  selectedSkillTextValues.push(textValue);
		  } else {
			  let index = selectedSkillValues.indexOf(value);
		    if (index > -1) {
		    	selectedSkillValues.splice(index, 1);
		    	selectedSkillTextValues.splice(index, 1);
		    }
		  }

		  //선택한 값을 넣음
		  let selectedSkillValuesInput = document.getElementById('selectSkillList');
		  selectedSkillValuesInput.value = selectedSkillValues;

		}
	//클릭한 원하는 직업 가져오는 메서드
	function addJobData(button) {
    	//색 변경
    	if (button.classList.contains("btn-outline-success")) {
		    button.classList.remove("btn-outline-success");
		    button.classList.add("bg-gradient-success");
		    button.classList.add("btn-block");
		    button.classList.add("btn_hi");
		  } else {
		    button.classList.add("btn-outline-success");
		    button.classList.remove("bg-gradient-success");
		    button.classList.remove("btn-block");
		    button.classList.remove("btn_hi");
		  }

    	//클릭시 값 저장 또는 삭제
		  button.classList.toggle('selected');
		  let value = button.getAttribute('data-value');
		  let textValue = button.textContent;
// 		  console.log(textValue)
		  if (button.classList.contains('selected')) {
		    selectedValues.push(value);
		    selectedJobTextValues.push(textValue);
		  } else {
			  let index = selectedValues.indexOf(value);
		    if (index > -1) {
		      selectedValues.splice(index, 1);
		      selectedJobTextValues.splice(index, 1);
		    }
		  }
// 		  console.log(selectedJobTextValues)
		  //선택한 값을 넣음
		  let selectedValuesInput = document.getElementById('selectJobList');
		  selectedValuesInput.value = selectedValues;

		}
	//클릭한 채용공고 태그 가져오는 메서드
	function addTagData(tagButton) {

		//색 변경
    	if (tagButton.classList.contains("btn-outline-success")) {
    		tagButton.classList.remove("btn-outline-success");
    		tagButton.classList.add("bg-gradient-success");
    		tagButton.classList.add("btn-block");
    		tagButton.classList.add("btn_hi");
		  } else {
			tagButton.classList.add("btn-outline-success");
			tagButton.classList.remove("bg-gradient-success");
			tagButton.classList.remove("btn-block");
			tagButton.classList.remove("btn_hi");
		  }

		//클릭시 값 저장 또는 삭제
		tagButton.classList.toggle('selected');
		  let tagValue = tagButton.getAttribute('data-value');
		  let textTagValue = tagButton.textContent;
		  if (tagButton.classList.contains('selected')) {
			  selectedTagValues.push(tagValue);
			  selectedTagTextValues.push(textTagValue);
		  } else {
		    let tagIndex = selectedTagValues.indexOf(tagValue);
		    if (tagIndex > -1) {
		    	selectedTagValues.splice(tagValue, 1);
		    	selectedTagTextValues.splice(tagValue, 1);
		    }
		  }
// 		  console.log(selectedTagTextValues)
		  //선택한 값을 넣음
		  let selectedTagValuesInput = document.getElementById('selectTagList');
		  selectedTagValuesInput.value =selectedTagValues;

		}

	//미리보기 세팅
	function previewDataSetting(){
		let jobPstgTitle = document.getElementById("jobPstgTitle");
		let jobPstgPrize = document.getElementById("showjobPstgPrize");
		let jobPstgEndDate = document.getElementById("jobPstgEndDate");
		let jobPstgContent = document.getElementById("jobPstgContent");
		let jobPstgBnf = document.getElementById("jobPstgBnf");
		let jobPstgMainWork = document.getElementById("jobPstgMainWork");
		let jobPstgQlfc = document.getElementById("jobPstgQlfc");
		let jobPstgRpfntm = document.getElementById("jobPstgRpfntm");


		let previewTitle = document.getElementById("previewTitle");
		let previewEntNm = document.getElementById("previewEntNm");
		let previewJobPstgContent = document.getElementById("previewJobPstgContent");
		let previewJobPstgPrize = document.getElementById("previewJobPstgPrize");
		let previewJobPstgMainWork = document.getElementById("previewJobPstgMainWork");
		let previewJobPstgQlfc = document.getElementById("previewJobPstgQlfc");
		let previewJobPstgRpfntm = document.getElementById("previewJobPstgRpfntm");
		let previewJobPstgBnf = document.getElementById("previewJobPstgBnf");
		let previewJobPstgEndDate = document.getElementById("previewJobPstgEndDate");


		let previewJobPstgSkill = document.getElementById("previewJobPstgSkill");
		let previewTagList = document.getElementById("previewTagList");

		previewTitle.textContent =jobPstgTitle.value;

		previewJobPstgPrize.textContent = jobPstgPrize.value
		previewJobPstgEndDate.textContent = jobPstgEndDate.value

		converter(jobPstgContent,previewJobPstgContent);
		converter(jobPstgMainWork,previewJobPstgMainWork);
		converter(jobPstgQlfc,previewJobPstgQlfc);
		converter(jobPstgRpfntm,previewJobPstgRpfntm);
		converter(jobPstgBnf,previewJobPstgBnf);



// 		previewJobPstgContent.textContent = jobPstgContent.value
// 		previewJobPstgMainWork.textContent = jobPstgMainWork.value
// 		previewJobPstgQlfc.textContent = jobPstgQlfc.value
// 		previewJobPstgRpfntm.textContent = jobPstgRpfntm.value
// 		previewJobPstgBnf.textContent = jobPstgBnf.value




		previewJobPstgSkill.textContent = "";
		previewTagList.textContent = "";

		for (let i = 0; i < selectedTagTextValues .length; i++) {
			let tag_button = document.createElement("li");
			tag_button.classList.add("display_inline_block","btn","tag_style");
			tag_button.setAttribute("style","background-color: #FAE0E9")
			tag_button.textContent=selectedTagTextValues [i];

			previewTagList.appendChild(tag_button)
		}

		for (let i = 0; i < selectedSkillTextValues.length; i++) {
			let tag_button = document.createElement("li");
			tag_button.classList.add("display_inline_block","btn","tag_style");
			tag_button.setAttribute("style","background-color: #FAE0E9")
			tag_button.textContent=selectedSkillTextValues[i];

			previewJobPstgSkill.appendChild(tag_button)
		}



	}//end previewDataSetting

// 스페이스 엔터 변환기
	function converter(text,destination) {
		let lines = text.value.split('\n');

		 // generate HTML version of text
		 let resultString  = "";
		 for (let i = 0; i < lines.length; i++) {
		   resultString += lines[i] + "<br />";
		 }
		 destination.innerHTML = resultString;

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

	// 날짜 채용공고 시작일보다 이전에  종료일을 찍을 수 없게
// 	var start = document.getElementById('jobPstgBgngDt');
// 	var end = document.getElementById('jobPstgEndDate');

// 	start.addEventListener('change', function() {
// 	    if (start.value)
// 	        end.min = start.value;
// 	}, false);
// 	end.addEventLiseter('change', function() {
// 	    if (end.value)
// 	        start.max = end.value;
// 	}, false);

    </script>



        <!-- -------------------- body 끝 -------------------- -->
      </div><!-- /.container-fluid -->
       </section>

<script>
function insertInput(){
	$("#jobPstgTitle").val("[DS부분 S/W개발] TSP총괄 채용");
	$("#showjobPstgPrize").val("1,000,000");
	$("#jobPstgBgngDt").val("2023-04-06");
	$("#jobPstgEndDate").val("2023-04-30");
	$("#jobPstgContent").val("S/W 및 Data Science 기술 관련 지식을 바탕으로 반도체 설비를 동작시키는 운영 S/W(동작 Sequence, Algorithm)를 개발하고,\nTest 공정의 생산, 품질에서 발생하는 실시간 이상을 감지하고 제어한다.\n또한 설비에서 발생하는Data를 활용해 Data Mining Application과 Platform 개발,\nData Cloud 연계 등 Data 기반 정보 가치를 극대화 하는 직무이다");
	$("#jobPstgBnf").val("개인연금, 건강검진, 의료비, 자녀학자금, 경조사, 장기근속휴가, 휴양소 운영, 선택적 복리후생 제도,\n사내제품 판매 지원, 다양한 메뉴의 사내 식당");
	$("#jobPstgMainWork").val("1. 설비 제어 Platform/Data Gathering, System간 Interface Platform/AI Platform/Big Data 분석 시스템 개발\n2. S/W Engineering\n3. 반도체 TEST 공정 생산 제어 System 개발\n4. 반도체 TEST 공정 품질 제어 System 개발\n5. 반도체 TEST 공정 생산/제어/분석 UI System 개발/운영 Platform 제공");
	$("#jobPstgQlfc").val("프로그래밍 언어(C/C++/C#/Python/Java 등) 및 알고리즘 문제해결 역량 보유자\nEmbedded시스템 및 ARM Architecture, 운영체제(Windows/Linux) 역량 보유자\n요구사항을 이해하고 이에 맞는 소프트웨어를 설계 및 구현할 수 있는 역량 보유자");
	$("#jobPstgRpfntm").val("AI 및 Machine Learning에 대한 이해와 활용 경험 보유자\nMachine Learning, Deep Learning 기반 최적화, 예측 Model/Application 개발 경험\n직무와 연관된 경험 보유자(프로젝트, 논문, 특허, 경진대회)\n소프트웨어/하드웨어 플랫폼을 활용한 프로젝트 수행 경험 보유자\nS/W Architecture 및 Source 코드 분석 경험자\nS/W Measurement 기법 활용 및 Metrics 분석 경험자\nICS/SCADA, Application, Mobile, Cloud 취약점 진단 지식 및 해킹 기술 보유자\n설비 제어SW, Embedded SW, Vision SW개발 경험 보유자");
}
</script>