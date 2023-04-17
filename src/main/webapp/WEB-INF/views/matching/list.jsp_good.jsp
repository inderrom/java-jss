<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authentication property="principal.memVO" var="memVO" />

<script>
	$(function() {
		
		
		// 키워드 검색어 입력시 검색버튼 생성
		$("#keyword").on("input", function(){
			if($(this).val() != ""){
				$("#searchBtn").show();
			}else{
				$("#searchBtn").hide();
			}
		});
		
		// 전체보기 네비바 toggle
		$(".nav-link").on("click", function() {
			// toggleClass() 메서드는 해당 클래스를 토글함
			$(".menulink").toggleClass("active");
			// removeAttr(): 선택한 요소에서 하나 이상의 특성을 제거함
			$(".menulink").removeAttr("aria=current");
			// attr() : 선택한 요소의 속성을 추가
			$(this).attr("aria-selected", true);

		});
		
		// 전체 직군/직무 select박스 
		$(".jobAll").on("change", function() {
			if($(this).val() == '개발'){
				$(".memJob").hide();
				$(".it").show();
			}
			if($(this).val() == '경영/비즈니스'){
				$(".memJob").hide();
				$(".etc").show();
			}
			if($(this).val() == '디자인'){
				$(".memJob").hide();
				$(".design").show();
			}
			if($(this).val() == '마케팅/광고'){
				$(".memJob").hide();
				$(".marketing").show();
			}
			
		});
	
		
		// 이력서 미리보기 모달창
			// 모달창 클릭
		$('.resumeSpn').click(function(e){
			$('#resumeModal').modal("show");
			
			let rsmNo = $(this).find("input").eq(0).val();
			let data = {"rsmNo":rsmNo};
			//rsmNo : RSM0003
			console.log("rsmNo : " + rsmNo);
// 			data : {"rsmNo":"RSM0003"}
			console.log("data : " + JSON.stringify(data));
			
			$(".wantSpnModal").find("button").eq(0).data("rsmno",rsmNo);
			$("#imgWantSpnModal").attr("src",$("#img"+rsmNo).attr("src"));
			
			$.ajax({
				url:"/matching/resumeBlock",
				type: "get",
				data : data,
				dataType : "json",
				success:function(result){
					console.log("resumeVO : " + result[0]);
					console.log("resumeVO.memNm : " + result[0].memNm);
					console.log("resumeVO.achievementVOList111 : " + result[0].careerVOList[0].achievementVOList[0].achTitle);
					$("#detailMemNm").html(result[0].memNm);
					console.log("result[0].rsmUrl : " + result[0].rsmUrl);
					if(result[0].rsmUrl != null){
						$("#detailRsmUrl").html("링크 : <a href='" + result[0].rsmUrl +"'target='_blank' >" + result[0].rsmUrl + "</a>");
					}
					$("#detailMemTelno").html("연락처 : " + result[0].memTelno +"<br/><br/>");
					
					let content = result[0].rsmAboutMe.replaceAll("\\n", "<br/>");
					$("#detailRsmAboutMe").html(content);
					console.log("result[0].beforeList : " + result[0].beforeList)
							let code ="";
					if(result[0].beforeList != null){
						for(let i = 0; i < result[0].beforeList.length; i++){
							console.log("포문에 들어왓어!");
							console.log(" result[0].beforeList[i].crrEntNm : " + result[0].beforeList[i].crrEntNm );
							console.log(" result[0].beforeList[i].crrJbgdNm : " + result[0].beforeList[i].crrJbgdNm );
							console.log(" result[0].beforeList[i].crrJncmpDt : " + result[0].beforeList[i].crrJncmpDt );
							console.log(" result[0].careerVOList[i].achievementVOList[0].achTitle : " + result[0].careerVOList[i].achievementVOList[0].achTitle);
							console.log(" result[0].beforeList[i].crrRtrmDt : " + result[0].beforeList[i].crrRtrmDt);
							code += '<div class="row">';
							code += '<div class="col-lg-9">';
							code += '<div class="col-lg-9"><ul>';
							code += '<li><b>'+ result[0].beforeList[i].crrEntNm +'</b></li><li>';
							code += '<li style="color: grey;">'+ result[0].beforeList[i].crrJbgdNm +'</li>';
							code += '<li style="color: grey;">'+ result[0].careerVOList[i].achievementVOList[0].achTitle + ' | <span style="color: grey;">' + result[0].careerVOList[i].achievementVOList[0].achContent + '</span></li>';
							code +='</ul></li></div></div>';
							code += '<div class="col-lg-3" style="margin: auto;"><ul>';
							
							let crrJncmpDtYear = new Date(result[0].beforeList[i].crrJncmpDt).getFullYear();
							let crrJncmpDtMonth = new Date(result[0].beforeList[i].crrJncmpDt).getMonth() + 1;
							let crrRtrmDtYear = new Date(result[0].beforeList[i].crrRtrmDt).getFullYear();
							let crrRtrmDtMonth = new Date(result[0].beforeList[i].crrRtrmDt).getMonth() + 1;
							
							code += '<li><b>' + crrJncmpDtYear + "." + crrJncmpDtMonth+ ' - ' + crrRtrmDtYear + "." + crrRtrmDtMonth  + '</b></li></ul></div></div>';
							code += '<hr />';
						}
						$("#detailCareer").html(code);
					}
						let acode = "";
					if(result[0].academicList != null || result[0].academicList.length != 0){
						for(let i = 0; i < result[0].academicList.length; i++){
							console.log(" result[0].academicList[i].acbgMajo : " +  result[0].academicList[i].acbgMajor);
							acode +='<ul>';
							acode += '<li><b>' + result[0].academicList[i].acbgUniversityNm +'</b></li>';
							acode += '<li style="color:grey;">' + result[0].academicList[i].acbgMajor +'</li></ul>';
						}
						$("#detailAcademic").html(acode);
					}
						let bcode = "";
					if(result[0].awardsVOList != null || result[0].awardsVOList.length != 0){
						for(let i = 0; i < result[0].awardsVOList.length; i++){
							bcode +='<ul>';
							bcode += '<li><b>' + result[0].awardsVOList[i].awrdNm +'</b></li>';
							bcode += '<li style="color:grey;">' + result[0].awardsVOList[i].awrdInfo +'</li></ul>';
							bcode += '<hr />';
						}
						
						$("#detailAwards").html(bcode);
					}
					
						let ccode = "";
					if(result[0].languageVOList != null || result[0].languageVOList.length != 0){
						for(let i = 0; i < result[0].languageVOList.length; i++){
							console.log(" result[0].languageVOList[i].lanNm : " + result[0].languageVOList[i].lanNm);
							console.log(" result[0].languageVOList[i].lanLevel : " + result[0].languageVOList[i].lanLevel);
							console.log(" result[0].languageVOList[i].languageScoreVOList[0].lscoNm : " +  result[0].languageVOList[i].languageScoreVOList[0].lscoNm);
							console.log(" result[0].languageVOList[i].languageScoreVOList[0].lscoScore : " +  result[0].languageVOList[i].languageScoreVOList[0].lscoScore);
							ccode +='<ul>';
							ccode += '<li><b>' + result[0].languageVOList[i].lanNm +'</b></li>';
							ccode += '<li style="color: grey;">' + result[0].languageVOList[i].lanLevel +'</li>';
							ccode += '<li>● ' + result[0].languageVOList[i].languageScoreVOList[0].lscoNm;
								if( result[0].languageVOList[i].languageScoreVOList[0].lscoScore != null){
									ccode += ' | ' + result[0].languageVOList[i].languageScoreVOList[0].lscoScore;
								}
							ccode += '</li>';
							ccode += '</ul>';
							ccode += '<hr />';
						}
						
						$("#detailLanguage").html(ccode);
					}
					
						let dcode = "";
					if(result[0].mySkillList != null || result[0].mySkillList.length != 0){
						for(let i = 0; i < result[0].languageVOList.length; i++){
							console.log(" result[0].mySkillList[i].mySklNm : " + result[0].mySkillList[i].mySklNm);
							dcode +='<ul>';
							dcode += '<li><b>' + result[0].mySkillList[i].mySklNm +'</b></li></ul>';
							dcode += '<hr />';
						}
						
						$("#detailMySkill").html(dcode);
					}
					
					
				}
			});
			
		});
		// 이력서 미리보기 모달창 (열람권 사용 안 했을 때)
			// 모달창 클릭
		$('.resumeSpn2').click(function(e){
			$('#resumeModal2').modal("show");
			
			let rsmNo = $('.resumeSpn2').find("input").eq(0).val();
			let vipNo = "${memVO.vipNo}";
			let data = {"rsmNo":rsmNo, "vipNo":vipNo};
			console.log(rsmNo);
			console.log(data);
			
			$.ajax({
				url:"/matching/resumeBlock",
				type: "get",
				data : data,
				dataType : "json",
				success:function(result){
					let memNm = result[0].memNm
					let memNmStr = memNm.substr(0,1) + "OO";
					let placeholder = '<div class="progress progress-bar col-2" role="progressbar" style="width: 25%; opacity:0.5;" aria-valuenow="25"></div></div>';
					let placeholder2 = '<div class="progress progress-bar" role="progressbar" style="width: 100%" aria-valuemin="0" aria-valuemax="100"></div>';
					
					$("#detailMemNm2").html(memNmStr);
					if(result[0].rsmUrl != null){
						$("#detailRsmUrl2").html('<div class="row"><div class="col-1">링크 :</div>' + placeholder);
					}
					$("#detailMemTelno2").html('<div class="row"><div class="col-1">연락처 :</div>' + placeholder + '<br/><br/>');
					
					let content = result[0].rsmAboutMe.replaceAll("\\n", "<br/>");
					let contentStr = content.substr(0,150) + "...";
					$("#detailRsmAboutMe2").html(contentStr);
							let code ="";
					if(result[0].beforeList != null){
						for(let i = 0; i < result[0].beforeList.length; i++){
							code += '<div class="row">';
							code += '<div class="col-lg-9">';
							code += '<div class="col-lg-12"><ul>';
							code += '<li><b>'+ result[0].beforeList[i].crrEntNm +'</b></li><li>';
							code += '<li style="color: grey;">'+ result[0].beforeList[i].crrJbgdNm +'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code += '<li class="placeColor">'+ placeholder2+'</li>';
							code +='</ul></li></div></div>';
							code += '<div class="col-lg-3" style="margin: auto;"><ul>';
							
							let crrJncmpDtYear = new Date(result[0].beforeList[i].crrJncmpDt).getFullYear();
							let crrJncmpDtMonth = new Date(result[0].beforeList[i].crrJncmpDt).getMonth() + 1;
							let crrRtrmDtYear = new Date(result[0].beforeList[i].crrRtrmDt).getFullYear();
							let crrRtrmDtMonth = new Date(result[0].beforeList[i].crrRtrmDt).getMonth() + 1;
							
							code += '<li><b>' + crrJncmpDtYear + "." + crrJncmpDtMonth+ ' - ' + crrRtrmDtYear + "." + crrRtrmDtMonth  + '</b></li></ul></div></div>';
							code += '<hr />';
						}
						$("#detailCareer2").html(code);
					}
						let acode = "";
					if(result[0].academicList != null || result[0].academicList.length != 0){
						for(let i = 0; i < result[0].academicList.length; i++){
							acode +='<ul>';
							acode += '<li><b>' + result[0].academicList[i].acbgUniversityNm +'</b></li>';
							acode += '<li style="color:grey;">' + result[0].academicList[i].acbgMajor +'</li></ul>';
						}
						$("#detailAcademic2").html(acode);
					}
			
					
				}
			});
			
		});
		
		// 상세이력 확인 모달창(멤버십 없을 때)
		$(".detailCheckBtn").click(function(e){
			if(${memVO.msyn == 0 || memVO.msyn == 1 && memVO.tcktQntt < 1}){
				$("#msCheckModal").modal("show");
				$(this).css("margin-top","30px;");
			}else {
				$("#rCheckModal").modal("show");
				$("#ticketQntt").text(${memVO.tcktQntt});
				
				console.log(" ${tcktQntt} : " , tcktQntt);
				$(this).css("margin-top","30px;");
			}
		});
		
		// 상세이력 확인 면접 제안 모달창(열람권 있을 때)
		$(".interviewBtn").click(function(e){
			$("#interviewCheckModal").modal("show");
			$(this).css("margin-top","30px;");
		});
		
		//열람권 확인 버튼을 눌렀을 때 상세보기 이력서로 전환하기
		$('#rCheckModalBtn').click(function(e){
			
			$("#rCheckModal").modal("hide");
			$('#resumeModal').modal("show");
			
			let rsmNo = $('.resumeSpn2').find("input").eq(0).val();
			let vipNo = "${memVO.vipNo}";
			let data = {"rsmNo":rsmNo, "vipNo":vipNo};
			console.log("rsmNo : " + rsmNo);
			console.log("data : " + JSON.stringify(data));
			
			$(".wantSpnModal").find("button").eq(0).data("rsmno",rsmNo);
			$("#imgWantSpnModal").attr("src",$("#img"+rsmNo).attr("src"));
			
			$.ajax({
				url:"/matching/resumeDetail",
				type: "get",
				data : data,
				dataType : "json",
				success:function(result){
					console.log("resumeVO : " + result[0]);
					console.log("resumeVO.memNm : " + result[0].memNm);
					console.log("resumeVO.achievementVOList111 : " + result[0].careerVOList[0].achievementVOList[0].achTitle);
					$("#detailMemNm").html(result[0].memNm);
					console.log("result[0].rsmUrl : " + result[0].rsmUrl);
					if(result[0].rsmUrl != null){
						$("#detailRsmUrl").html("링크 : <a href='" + result[0].rsmUrl +"'target='_blank' >" + result[0].rsmUrl + "</a>");
					}
					$("#detailMemTelno").html("연락처 : " + result[0].memTelno +"<br/><br/>");
					
					let content = result[0].rsmAboutMe.replaceAll("\\n", "<br/>");
					$("#detailRsmAboutMe").html(content);
					console.log("result[0].beforeList : " + result[0].beforeList)
							let code ="";
					if(result[0].beforeList != null){
						for(let i = 0; i < result[0].beforeList.length; i++){
							console.log("포문에 들어왓어!");
							console.log(" result[0].beforeList[i].crrEntNm : " + result[0].beforeList[i].crrEntNm );
							console.log(" result[0].beforeList[i].crrJbgdNm : " + result[0].beforeList[i].crrJbgdNm );
							console.log(" result[0].beforeList[i].crrJncmpDt : " + result[0].beforeList[i].crrJncmpDt );
							console.log(" result[0].careerVOList[i].achievementVOList[0].achTitle : " + result[0].careerVOList[i].achievementVOList[0].achTitle);
							console.log(" result[0].beforeList[i].crrRtrmDt : " + result[0].beforeList[i].crrRtrmDt);
							code += '<div class="row">';
							code += '<div class="col-lg-9">';
							code += '<div class="col-lg-9"><ul>';
							code += '<li><b>'+ result[0].beforeList[i].crrEntNm +'</b></li><li>';
							code += '<li style="color: grey;">'+ result[0].beforeList[i].crrJbgdNm +'</li>';
							code += '<li style="color: grey;">'+ result[0].careerVOList[i].achievementVOList[0].achTitle + ' | <span style="color: grey;">' + result[0].careerVOList[i].achievementVOList[0].achContent + '</span></li>';
							code +='</ul></li></div></div>';
							code += '<div class="col-lg-3" style="margin: auto;"><ul>';
							
							let crrJncmpDtYear = new Date(result[0].beforeList[i].crrJncmpDt).getFullYear();
							let crrJncmpDtMonth = new Date(result[0].beforeList[i].crrJncmpDt).getMonth() + 1;
							let crrRtrmDtYear = new Date(result[0].beforeList[i].crrRtrmDt).getFullYear();
							let crrRtrmDtMonth = new Date(result[0].beforeList[i].crrRtrmDt).getMonth() + 1;
							
							code += '<li><b>' + crrJncmpDtYear + "." + crrJncmpDtMonth+ ' - ' + crrRtrmDtYear + "." + crrRtrmDtMonth  + '</b></li></ul></div></div>';
							code += '<hr />';
						}
						$("#detailCareer").html(code);
					}
						let acode = "";
					if(result[0].academicList != null || result[0].academicList.length != 0){
						for(let i = 0; i < result[0].academicList.length; i++){
							console.log(" result[0].academicList[i].acbgMajo : " +  result[0].academicList[i].acbgMajor);
							acode +='<ul>';
							acode += '<li><b>' + result[0].academicList[i].acbgUniversityNm +'</b></li>';
							acode += '<li style="color:grey;">' + result[0].academicList[i].acbgMajor +'</li></ul>';
						}
						$("#detailAcademic").html(acode);
					}
						let bcode = "";
					if(result[0].awardsVOList != null || result[0].awardsVOList.length != 0){
						for(let i = 0; i < result[0].awardsVOList.length; i++){
							bcode +='<ul>';
							bcode += '<li><b>' + result[0].awardsVOList[i].awrdNm +'</b></li>';
							bcode += '<li style="color:grey;">' + result[0].awardsVOList[i].awrdInfo +'</li></ul>';
							bcode += '<hr />';
						}
						
						$("#detailAwards").html(bcode);
					}
					
						let ccode = "";
					if(result[0].languageVOList != null || result[0].languageVOList.length != 0){
						for(let i = 0; i < result[0].languageVOList.length; i++){
							console.log(" result[0].languageVOList[i].lanNm : " + result[0].languageVOList[i].lanNm);
							console.log(" result[0].languageVOList[i].lanLevel : " + result[0].languageVOList[i].lanLevel);
							console.log(" result[0].languageVOList[i].languageScoreVOList[0].lscoNm : " +  result[0].languageVOList[i].languageScoreVOList[0].lscoNm);
							console.log(" result[0].languageVOList[i].languageScoreVOList[0].lscoScore : " +  result[0].languageVOList[i].languageScoreVOList[0].lscoScore);
							ccode +='<ul>';
							ccode += '<li><b>' + result[0].languageVOList[i].lanNm +'</b></li>';
							ccode += '<li style="color: grey;">' + result[0].languageVOList[i].lanLevel +'</li>';
							ccode += '<li>● ' + result[0].languageVOList[i].languageScoreVOList[0].lscoNm;
								if( result[0].languageVOList[i].languageScoreVOList[0].lscoScore != null){
									ccode += ' | ' + result[0].languageVOList[i].languageScoreVOList[0].lscoScore;
								}
							ccode += '</li>';
							ccode += '</ul>';
							ccode += '<hr />';
						}
						
						$("#detailLanguage").html(ccode);
					}
					
						let dcode = "";
					if(result[0].mySkillList != null || result[0].mySkillList.length != 0){
						for(let i = 0; i < result[0].languageVOList.length; i++){
							console.log(" result[0].mySkillList[i].mySklNm : " + result[0].mySkillList[i].mySklNm);
							dcode +='<ul>';
							dcode += '<li><b>' + result[0].mySkillList[i].mySklNm +'</b></li></ul>';
							dcode += '<hr />';
						}
						
						$("#detailMySkill").html(dcode);
					}
					
					
				}
			});
			
		});
		
		
		
		// 찜하기 버튼
		$(".wantSpn").on("click",function(){
			let dataCheck = $(this).find("button").eq(0).data("input");
			let rsmNo = $("button", this).data("rsmno");
			console.log("dataCheck : " + dataCheck + ", rsmNo : " + rsmNo);
		//	let dataCheckModal = $(".wantModalSpn").find("button").eq(0).data("input");
		
			let data = {"etpId": rsmNo};			
			console.log("data : " + JSON.stringify(data));
			
			$.ajax({
				url:"/record/bookmarkWant",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend : function(xhr) {
				       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success: function(result){
					console.log("bookmark result : " + JSON.stringify(result));
				}
			});
		
			if(dataCheck == "ilikeyou"){
				Swal.fire("찜한 목록에 추가되었습니다.");
				
				$("#imgWantSpnModal").attr("src","/resources/images/star1.png");
				$(".wantSpnModal").find("button").eq(0).data("input","ihateyou");
				$(this).find("button").eq(0).data("input","ihateyou");
				
				let code = '<img id="img' + rsmNo + '" alt="star1" src="/resources/images/star1.png" style="margin-bottom: 6px;">찜함';
				$(this).find("button").eq(0).html(code);
			}else{
				Swal.fire("찜 해제되었습니다.");
 				$("#imgWantSpnModal").attr("src","/resources/images/star2.png");
 				$(".wantSpnModal").find("button").eq(0).data("input","ilikeyou");
				$(this).find("button").eq(0).data("input","ilikeyou");
				
				let code = '<img id="img' + rsmNo + '" alt="star2" src="/resources/images/star2.png" style="margin-bottom: 6px;">찜하기';
				$(this).find("button").eq(0).html(code);
			}
		});
		
		// 모달 찜하기 버튼
		$(".wantSpnModal").on("click",function(){
			let dataCheck = $(this).find("button").eq(0).data("input");
			let rsmNo = $("button", this).data("rsmno");
			console.log("dataCheck : " + dataCheck + ", rsmNo : " + rsmNo);
		//	let dataCheckModal = $(".wantModalSpn").find("button").eq(0).data("input");
		
			let data = {"etpId": rsmNo};			
			console.log("data : " + JSON.stringify(data));
			
			$.ajax({
				url:"/record/bookmarkWant",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend : function(xhr) {
				       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success: function(result){
					console.log("bookmark result : " + JSON.stringify(result));
				}
			});
		
			if(dataCheck == "ilikeyou"){
				Swal.fire("찜한 목록에 추가되었습니다.");
				$("#img"+rsmNo).attr("src","/resources/images/star1.png");
				$(".wantSpn").find("button").eq(0).data("input","ihateyou");
				$(this).find("button").eq(0).data("input","ihateyou");
				
				let jjimcode = '<img id="img' + rsmNo + '" alt="star1" src="/resources/images/star1.png" style="margin-bottom: 6px;">찜함';
				$(".wantSpn").find("button").eq(0).html(jjimcode)
				
				
				let code = '<img alt="star1" src="/resources/images/star1.png" style="margin-bottom: 6px;">';
				$(this).find("button").eq(0).html(code);
				
			}else{
				Swal.fire("찜 해제되었습니다.");
				$("#img"+rsmNo).attr("src","/resources/images/star2.png");
				$(".wantSpn").find("button").eq(0).data("input","ilikeyou");
				
				let jjimcode = '<img id="img' + rsmNo + '" alt="star1" src="/resources/images/star2.png" style="margin-bottom: 6px;">찜하기';
				$(".wantSpn").find("button").eq(0).html(jjimcode)
				
				$(this).find("button").eq(0).data("input","ilikeyou");
				
				let code = '<img alt="star2" src="/resources/images/star2.png" style="margin-bottom: 6px;">';
				$(this).find("button").eq(0).html(code);
			}
		});
		
	});
	
	// 페이징 함수
	function pageClick(link){
		let value = link.innerHTML;
		console.log(value);
		
		let data = { "searchMemJob" : $("#searchMemJob").val(),"currentPage" : value};
		console.log(data); 
		$.ajax({
			url:"/matching/getList",
			data: data,
			type:"post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
			   console.log("success result", result);
			
			   var matchingList = result.content;
			   console.log("matchingList : ", matchingList);

			   var code = "";
			   var pcode = "";
			   // 코드 생성
			   for(let i=0; i<matchingList.length; i++){
					console.log("첫번째 포문 안에 들어왔지롱");
					console.log("i의 길이 : " + i);
					code += '<div class="card m-lg-3">'	
					code += '<div class="card-body">';
					code += '<div class="card-content">';
					code +='<ul><li style="margin-top: 5px;"><h5>' + matchingList[i].memNm +'</h5></li>';
					if(matchingList[i].history[0].cryear == "0" ){
						code +='<li><span class="badge bg-gradient-info">신입</span></li>';
					}else{
						code +='<li>' + matchingList[i].history[0].cryear +'년 근무,</li>';
						code +='<li>'+'총'+ matchingList[i].history[0].crent + '개 회사 근무'+'</li>';
					}
					code += '<li><br/></li>';
					code +='<li style="margin-top: 15px;">'+ matchingList[i].rsmNo + '</small></li></ul></div>';
					
					code +='<div class="card-content">';
					code += '<ul>';
					console.log("이게 뭐냐고요!!!!" + matchingList[i].beforeList[0]);
					if( matchingList[i].beforeList[0] != null ){
						code +='<li>최근 : ' + matchingList[i].beforeList[0].crrEntNm +
									'(' + matchingList[i].beforeList[0].cryear+'년'+ matchingList[i].beforeList[0].crmonth+'개월)' ;
						if(matchingList[i].beforeList[0].crrHdofYn == "Y"){
							code +=	'<b>-재직중</b>'; 
						}
						code += '</li>';
							if( matchingList[i].beforeList.length > 1){
								
								code += '<li>이전 : ';
								for(let j=1; j < matchingList[i].beforeList.length; j++){
									code += matchingList[i].beforeList[j].crrEntNm + '(';
									if(matchingList[i].beforeList[j].cryear > 0){
										code += matchingList[i].beforeList[j].cryear + '년';
									}
									code += matchingList[i].beforeList[j].crmonth +'개월),';
								}
								code +='</li>';
							}
						}
					if(matchingList[i].academicList[0] != null || matchingList[i].academicList[0].length != 0 ){
						code += '<li>학교 : ' + matchingList[i].academicList[0].acbgUniversityNm + ',' + matchingList[i].academicList[0].acbgMajor + '</li>';   
					}
					if(matchingList[i].mySkillList[0] != null || matchingList[i].mySkillList[0].length != 0 ){
						code += '<li>';
						for(let k = 0; k < matchingList[i].mySkillList.length; k++){
							console.log("세번째 포문에 들어왔지롱");
							console.log(k)
							code += '<button type="button" class="btn bg-gradient-light w-auto me-2">' + matchingList[i].mySkillList[k].mySklNm + '</button>';
						}
						code += '</li>';
					}
					code += '<li>' + matchingList[i].memJob + '</li></div>';
					
					code += '<div class="card-content" style="float: right;">';
					code +='<ul><li style="margin: 5px;">';
					if(matchingList[i].rsmNo  == matchingList[i].tvrRsmNo && ${memVO.tcktQntt} > 0){
						code +='<span class="resumeSpn">';
						code +='<input type="hidden" class="rsmNo" name="rsmNo" value="' + matchingList[i].rsmNo + '" />';
						code +='<button type="button" class="btn btn-block btn-info btn-lg" data-bs-toggle="modal" data-bs-target="#exampleModalLong" style="border-radius: 50px; font-size: 15px;">이력서 상세보기</button></span>';
					}else{
						code +='<span class="resumeSpn2">';
						code +='<input type="hidden" class="rsmNo" name="rsmNo" value="' + matchingList[i].rsmNo + '"/>';
						code +='<button type="button" class="btn btn-block btn-info btn-lg" data-bs-toggle="modal" data-bs-target="#exampleModalLong" style="border-radius: 50px; font-size: 15px;">이력서 미리보기</button></span>';
					}
					code +='</li>';
					code +='<li style="margin: 5px;">';
					code +='<span class="wantSpn">';
					if(matchingList[i].recBmkYn == "Y"){
						code +='<button data-input="ihateyou" type="button" class="btn btn-block btn-outline-info btn-lg"';
						code +='style="border-radius: 50px; font-size: 15px; padding: 4px 39px;"  data-rsmno="'+ matchingList[i].rsmNo +'">';
						code +='<img id="img'+ matchingList[i].rsmNo +'" alt="star1" src="/resources/images/star1.png" style="margin-bottom: 6px;">찜함</button>';
					}else{
						code +='<button data-input="ilikeyou" type="button" class="btn btn-block btn-outline-info btn-lg"';
						code +='style="border-radius: 50px; font-size: 15px; padding: 4px 39px;"  data-rsmno="'+ matchingList[i].rsmNo +'">';
						code +='<img id="img$' + matchingList[i].rsmNo + '" alt="star2" src="/resources/images/star2.png" style="margin-bottom: 6px;">찜하기</button>';
					}
					code +='</span></li></ul></div></div></div>';
					code +='<!-- ============================================== -->'; 
				}// end for
			   console.log("code=============",code );
			   console.log("startPage : ",result.startPage );
			   console.log("endPage : ",result.endPage );
			   
				
			   // 페이징 코드 생성
				if(result.total != 0){
					pcode +='<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">';
					pcode +='<ul class="pagination">';
					pcode +='<li class="paginate_button page-item previous';
						if(result.startPage <6){
							pcode +=' disabled';
						}
					pcode +='" id="dataTable_previous">';
					pcode +='<a href="#"';
					pcode +='aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">';
					pcode +='<i class="fa fa-angle-double-left" aria-hidden="true"></i></a></li>';
					for(var i = result.startPage; i <= result.endPage; i++){
						
						if(result.currentPage == i){
							pcode +='<li class="paginate_button page-item active">';							
						}else{
							pcode +='<li class="paginate_button page-item">';
						}
						pcode +='<a href="javascript:" onclick="pageClick(this)"';
						pcode +='aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">'+i+'</a></li>';		
					}
					if(result.endPage + 5 > result.totalPages){
						pcode += '<li class="paginate_button page-item next disabled" id="dataTable_next">';
					}else{
						pcode += '<li class="paginate_button page-item next" id="dataTable_next">';							
					}
					pcode +='<a href="#"';
					pcode +='aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">';
					pcode +='<i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li></ul></div>';
				}
			   
			   console.log(pcode);
			   $(".ajax-body").html(code);
			   $("#dataTable_paginate").html(pcode);
			}
		});
	}
	
	
</script>
<style>
ul, li {
	list-style-type: none;
}

.card-content {
	float: left;
	margin: 30px;
}
.placeColor{
	color: grey;
	margin-top:3px;
	opacity:0.5;
}
</style>
	<!-- 검색 시작 -->
	<input type="hidden" id="tcktQntt" value="${memVO.tcktQntt}" />
	<form action="/matching/list" method="get" name="searchForm">
		<div class="card-body blur mx-md-4 p-5 overflow-hidden">
			<div style="margin-left:9%;"><h3>찾고 있는 인재의 <span style="color:#007bff;">직군/직무</span>를 선택하세요</h3></div>					
			<div class="container">
				<div class="row pb-4 position-relative">
					<div class="col mt-lg-n2 mt-2">
						<label class="ms-0">전체 직군</label>
						<!-- choices-button -> vo의 멤버변수로 변경 -->
						<select class="form-control jobAll" name="choicesbutton" id="choices-button">
							<option selected disabled>직군을 선택하세요</option>
							<c:forEach var="commonCodeVO" items="${cvo}" varStatus="stat">
								<option value="${commonCodeVO.cmcdDtlNm}"
									<c:if test='${param.choicesbutton eq commonCodeVO.cmcdDtlNm }'>selected</c:if>>${commonCodeVO.cmcdDtlNm}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-6 mt-lg-n2 mt-2">
						<input type="hidden" id="searchMemJob" name="searchMemJob" value="">
			            <div id="jobGroup" class="row align_fe" style="display: block;"><span style="justify-content: center;">직무을 선택해주세요</span> </div>
			          
			          	<div class="memJob it" data-value="it" style="display: none;">
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"  data-value="프론트엔드" >프론트앤드</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"  data-value="백엔드" >백엔드</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"  data-value="ios" >ios</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"  data-value="안드로이드" >안드로이드</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"  data-value="DBA" >DBA</button> 
			          	</div>
			          	<div class="memJob etc" data-value="etc" style="display: none;">
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"  data-value="PM/PO" >PM/PO</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="회계/경리" >회계/경리</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="데이터 분석가" >데이터 분석가</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="사업개발/기획자" >사업개발/기획자</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="서비스기획자" >서비스 기획자</button>  
			          	</div>
			        
			          	<div class="memJob design" data-value="it" style="display: none;">
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="UX" >UX</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="UI,GUI" >UI,GUI</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="그래픽" >그래픽</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="웹" >웹</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"   data-value="패션" >패션</button> 
			          	</div>
			          	<div class="memJob marketing" data-value="etc" style="display: none;">
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="디지털" >디지털</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="광고기획자(AE)" >광고기획자</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="콘텐츠" >데이터</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="브렌딩" >브렌딩</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi " onclick="addJobData(this)"   data-value="PR전문가" >PR 전문가</button> 
							<button type="button" class="btn btn-tag-option btn-block btn-outline-info col btn_hi "  onclick="addJobData(this)"  data-value="카피라이터" >카피라이터</button>  
			          	</div>
					</div>
						<div class="col mt-lg-n2 mt-2">
						<label class="ms-0">검색</label>
							<div class="row">
								<div class="input-group input-group-static">
									
									<div class="col-9">
										<input class="form-control" placeholder="검색어를 입력해주세요" id="keyword" name="keyword" type="text" value="${param.keyword}"
											onkeypress="if(event.keyCode==13) {press(); return false;}" />
									</div>
										<div class="col-3">	
											 <span id="searchBtn"class="badge bg-gradient-info" style="display:none;" onclick="javascript: press();">검색</span>
										</div>
								</div>
							</div>
					</div>
				</div>
			</div>
			<!-- 검색 끝 -->

			<!-- 네비바 탭 -->
			<div class="col-12 col-sm-12">
				<div class="card card-info card-outline card-outline-tabs ms-md-7" >
					<div class="card-header p-0 border-bottom-0">
						<ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
							<li class="nav-item"><a class="nav-link active"
								id="custom-tabs-four-allList-tab" data-toggle="pill"
								href="#custom-tabs-four-allList" role="tab"
								aria-controls="custom-tabs-four-allList" aria-selected="true">매칭 목록</a></li>
							<li class="nav-item"><a class="nav-link"
								id="custom-tabs-four-wantList-tab" data-toggle="pill"
								href="#custom-tabs-four-wantList" role="tab"
								aria-controls="custom-tabs-four-wantList" aria-selected="false">찜한
									목록</a></li>
							<li class="nav-item"><a class="nav-link"
								id="custom-tabs-four-readList-tab" data-toggle="pill"
								href="#custom-tabs-four-readList" role="tab"
								aria-controls="custom-tabs-four-readList" aria-selected="false">열람한
									목록</a></li>
							<li class="nav-item"><a class="nav-link"
								id="custom-tabs-four-propose-tab" data-toggle="pill"
								href="#custom-tabs-four-propose" role="tab"
								aria-controls="custom-tabs-four-propose" aria-selected="false">면접
									제안한 목록</a></li>
						</ul>
					</div>
			
					<hr>
					<!-- card body -->
					<div class="card-body">
						<div class="tab-content" id="custom-tabs-four-tabContent">

							<!-- card 내용 시작 -->
							<div class="tab-pane fade active show" id="custom-tabs-four-allList" role="tabpanel"
								aria-labelledby="custom-tabs-four-allList-tab">
									<div class="ajax-body">
									<c:forEach var="resumeVO" items="${data.content}" varStatus="stat" >
										<div class="card m-lg-3">	
											<div class="card-body">
												<div class="card-content">
													<ul>
														<li style="margin-top: 5px;"><h5>${resumeVO.memNm}</h5></li>
														<c:choose>
															<c:when test="${resumeVO.history[0].cryear eq '0'}">
																<span class="badge bg-gradient-info">신입</span>
															</c:when>
															<c:otherwise>
																<li>${resumeVO.history[0].cryear}년  경력,</li>
																 <li>총 ${resumeVO.history[0].crent}개 회사 근무</li>
															</c:otherwise>
														</c:choose>
														<li><br/></li>
														<li style="margin-top: 15px;"><small>${resumeVO.rsmNo}</small></li>
													</ul>
												</div>
												<div class="card-content">
													<ul>
														<c:if test="${resumeVO.beforeList[0] != null || fn:length(resumeVO.beforeList[0])!=0}">
															<li>최근 : ${resumeVO.beforeList[0].crrEntNm}(${resumeVO.beforeList[0].cryear}년 ${resumeVO.beforeList[0].crmonth}개월)
																<c:if test="${resumeVO.beforeList[0].crrHdofYn == 'Y'}">
																	<b>-재직중</b> 
																</c:if>
															</li>
																<c:if test="${fn:length(resumeVO.beforeList) > 1}">
																	<li>이전 : 
																		<c:forEach var="ii" items="${resumeVO.beforeList}" varStatus="stats">
																			<c:if test="${stats.index > 0}">
																				${ii.crrEntNm}(
																				<c:if test="${ii.cryear > 0}">	
																					${ii.cryear}년
																				</c:if>	
																				 ${ii.crmonth}개월),
																			</c:if>
																		</c:forEach>
																	</li>
															</c:if>	
														</c:if>
														<c:if test="${resumeVO.academicList[0] != null || fn:length(resumeVO.academicList[0])!=0}">
															<li>학교 : ${resumeVO.academicList[0].acbgUniversityNm },${resumeVO.academicList[0].acbgMajor}</li>
														</c:if>
														<c:if test="${resumeVO.mySkillList[0] != null || fn:length(resumeVO.mySkillList[0])!=0}">
															<li>
																<c:forEach var="ms" items="${resumeVO.mySkillList}">
																	<button type="button" class="btn bg-gradient-light w-auto me-2">${ms.mySklNm}</button>
																</c:forEach>
															</li>
														</c:if>
														<li>${resumeVO.memJob}</li>
													</ul>
												</div>
	
												<div class="card-content" style="float: right;">
													<ul>
														<li style="margin: 5px;">
														<!-- 이력서 미리보기 -->
														<c:choose>
															<c:when test="${ resumeVO.rsmNo == resumeVO.tvrRsmNo && memVO.tcktQntt > 0 }">
															  <span class="resumeSpn">
															  <input type="hidden" class="rsmNo" name="rsmNo" value="${resumeVO.rsmNo}" />
																<button type="button" class="btn btn-block btn-info btn-lg" data-bs-toggle="modal" data-bs-target="#exampleModalLong"
																	style="border-radius: 50px; font-size: 15px;">이력서 상세보기</button>
															  </span>	
															</c:when>
															<c:otherwise>
															  <span class="resumeSpn2">
															  <input type="hidden" class="rsmNo" name="rsmNo" value="${resumeVO.rsmNo}" />
																<button type="button" class="btn btn-block btn-info btn-lg"  data-bs-toggle="modal" data-bs-target="#exampleModalLong"
																	style="border-radius: 50px; font-size: 15px;">이력서 미리보기</button>
															  </span>	
															</c:otherwise>
														</c:choose>
														</li>
														<li style="margin: 5px;">
															<!-- 찜하기 버튼  -->
															<span class="wantSpn">
																<c:choose>
																	<c:when test="${resumeVO.recBmkYn == 'Y'}">
																		<button data-input="ihateyou" type="button" class="btn btn-block btn-outline-info btn-lg"
																			style="border-radius: 50px; font-size: 15px; padding: 4px 39px;" data-rsmno="${resumeVO.rsmNo}">
																			<img id="img${resumeVO.rsmNo}" alt="star1" src="/resources/images/star1.png" style="margin-bottom: 6px;">찜함
																		</button>
																	</c:when>
																	<c:otherwise>
																		<button data-input="ilikeyou" type="button" class="btn btn-block btn-outline-info btn-lg"
																			style="border-radius: 50px; font-size: 15px; padding: 4px 39px;" data-rsmno="${resumeVO.rsmNo}">
																			<img id="img${resumeVO.rsmNo}" alt="star2" src="/resources/images/star2.png" style="margin-bottom: 6px;">찜하기
																		</button>
																	</c:otherwise>
																</c:choose>
															</span>
														</li>
													</ul>
												</div>
										  	</div>
										  </div>	
									</c:forEach>
								</div>
							</div>
							<!-- card 내용 끝 -->

						</div>
					</div>
					<!-- card 끝 -->
					시작 : ${data.startPage} 
					끝 : ${data.endPage}
					스타트 + 사이즈 : ${data.startPage+size}
					전체 : ${data.totalPages}

					<!-- 페이징 시작 -->
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
							<ul class="pagination">
								<li class="paginate_button page-item previous <c:if test='${data.startPage lt size}'>disabled</c:if>" id="dataTable_previous">

									<a href="/matching/list?choicesbutton=${param.choicebutton}&currentPage=${data.startPage-5}&keyword=${param.keyword}&searchMemJob=${param.searchMemJob}" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">
										<i class="fa fa-angle-double-left" aria-hidden="true"></i>
									</a>
								</li>
								<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
									<li class="paginate_button page-item <c:if test='${param.currentPage==pNo}'>active</c:if>">
										<a href="/matching/list?choicesbutton=${param.choicebutton}&currentPage=${pNo}&keyword=${param.keyword}&searchMemJob=${param.searchMemJob}" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a>
									</li>
								</c:forEach>
								<li class="paginate_button page-item next <c:if test='${data.startPage+size gt data.totalPages}'>disabled</c:if>" id="dataTable_next">
									<a href='/matching/list?choicesbutton=${param.choicebutton}&currentPage=${data.startPage+5}&keyword=${param.keyword}&searchMemJob=${param.searchMemJob}' aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">
										<i class="fa fa-angle-double-right" aria-hidden="true"></i>
									</a>
								</li>
							</ul>
						</div>
					</div>
					<!-- 페이징 끝 -->
				</div>
			</div>
		</div>
	</form>
	
		<!-- 이력서 상세보기 모달창 시작-->
		<div class="modal fade" id="resumeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" style="margin-left:41%;">이력서 상세보기</h4>
						<button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal">
                      		<i class="fas fa-times"></i>
                   		</button>
					</div>
					<div class="modal-body">
						 <div class="row">
							<div class="col-lg-11">
								<h2 id="detailMemNm" style="margin-left:10px;"></h2>
								<h6 style="color: grey; margin-left:10px;" id="detailRsmUrl"></h6>
								<h6 style="color: grey; margin-left:10px;" id="detailMemTelno" ></h6>
								<p style="color: grey; margin-left:10px;" id="detailRsmAboutMe"></p>
							</div>
							<div class="col-lg-1">
							   <span class="wantSpnModal">
									<button type="button" data-input="ilikeyou" class="btn btn-block btn-outline-info btn-flat" style="border-radius: 50%;">
										<img id="imgWantSpnModal" alt="star2" src="/resources/images/star2.png">
									</button>
								</span>
							</div>
						</div>
							<hr style="background-color: #007bff; height:1px;" />
						 	<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>경력</b></li>
									</ul>
								</div>	
								<div id="detailCareer" class="col-lg-10">
								
								</div>
							<hr />
							</div>
							<hr style="background-color: #007bff;" />
							<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>학력</b></li>
									</ul>
								</div>
								<div id ="detailAcademic" class="col-lg-10">	
									
								</div>
						  </div>
						  <hr style="background-color: #007bff;" />
							<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>수상</b></li>
									</ul>
								</div>
								<div id ="detailAwards" class="col-lg-10">	
									
								</div>
						  </div>
						  <hr style="background-color: #007bff;" />
							<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>외국어</b></li>
									</ul>
								</div>
								<div id ="detailLanguage" class="col-lg-10">	
									
								</div>
						  </div>
						  <hr style="background-color: #007bff;" />
							<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>기술</b></li>
									</ul>
								</div>
								<div id ="detailMySkill" class="col-lg-10">	
									
								</div>
						  </div>
						<div class="modal-footer justify-content-between" style="background-color: #007bff;">
							<h5 style="color: white">이 회원에게 면접을 제안하시겠습니까?</h5>
							<button type="button" class="btn btn-info interviewBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">면접 제안하기</button>
					    </div>
					</div>
				</div>
			</div>
		</div>
		<!-- 이력서 모달창 끝 -->
		
		<!-- 이력서 미리보기 모달창 시작(열람권사용 안했을 때)-->
		<div class="modal fade" id="resumeModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" style="margin-left:41%;">이력서 미리보기</h4>
						<button type="button" class="btn btn-link text-dark my-1" data-bs-dismiss="modal">
                      		<i class="fas fa-times"></i>
                   		</button>
					</div>
					<div class="modal-body">
						 <div class="row">
							<div class="col-lg-11">
								<h2 id="detailMemNm2" style="margin-left:10px;"></h2>
								<h6 style="color: grey; margin-left:10px;" id="detailRsmUrl2"></h6>
								<h6 style="color: grey; margin-left:10px;" id="detailMemTelno2" ></h6>
								<p style="color: grey; margin-left:10px;" id="detailRsmAboutMe2"></p>
							</div>
							<div class="col-lg-1">
							   <span class="wantSpnModal">
									<button type="button" data-input="ilikeyou" class="btn btn-block btn-outline-info btn-flat" style="border-radius: 50%;">
										<img alt="star2" src="/resources/images/star2.png" style="margin-bottom: 6px;">
									</button>
								</span>
							</div>
						</div>
							<hr style="background-color: #007bff; height:1px;" />
						 	<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>경력</b></li>
									</ul>
								</div>	
								<div id="detailCareer2" class="col-lg-10">
								
								</div>
							<hr />
							</div>
							<hr style="background-color: #007bff;" />
							<div class="row">
								<div class="col-lg-2">
									<ul>
										<li><b>학력</b></li>
									</ul>
								</div>
								<div id ="detailAcademic2" class="col-lg-10">	
									
								</div>
						  </div>
						  
						<div class="modal-footer justify-content-between" style="background-color: #007bff;">
							<h5 style="color: white">상세이력 확인 시 , 열람권이 1회 차감됩니다.</h5>
								<button type="button" class="btn btn-info detailCheckBtn" data-bs-toggle="modal" data-bs-target="#exampleModal">상세이력 확인하기</button>
					    </div>
					</div>
				</div>
			</div>
		</div>
		<!-- 이력서 모달창 끝 -->
		
	 <!-- 이력서 멤버십 여부확인 모달창 시작-->
      <div class="modal fade" id="msCheckModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="margin-left:38%;">멤버십 가입</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="color:#7b809a;">X</button>
            </div>
            <div class="modal-body">
	             <p style="text-align: center;">멤버십에 가입되어 있지 않습니다.</p>	 
				 <p style="text-align: center;">멤버십에 가입하시겠습니까?</p>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn bg-gradient-dark mb-0" data-bs-dismiss="modal">취소</button>
              <a href="/java/membershipJoin"><button type="button" class="btn bg-gradient-info mb-0">확인</button></a>
            </div>
          </div>
        </div>
      </div>
    </div>
	<!-- 이력서 멤버십 여부확인 모달창 끝 -->	
		
	<!-- 이력서 열람권 확인 모달창 시작-->
	<div class="modal fade" id="rCheckModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="margin-left:41%;">열람권</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="color:#7b809a;">X</button>
            </div>
            <div class="modal-body">
          		<h2 style="text-align: center;">열람권을 사용하시겠습니까?</h2>	 
				<p style="text-align: center;">(잔여 열람권 : <span id="ticketQntt"></span>개 )</p>	
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn bg-gradient-dark mb-0" data-bs-dismiss="modal">취소</button>
              <a href="#"><button id="rCheckModalBtn" type="button" class="btn bg-gradient-info mb-0">확인</button></a>
            </div>
          </div>
        </div>
      </div>
    </div>
	<!-- 이력서 열람권 확인 모달창 끝-->
	
	<!-- 이력서 면접 제안하기 모달창 시작-->
	<div class="modal fade" id="interviewCheckModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalLabel" style="margin-left:41%;">면접 제안하기</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="color:#7b809a;">X</button>
            </div>
            <div class="modal-body">
          		<h2 style="text-align: center;">면접을 제안하시겠습니까?</h2>
          		<p style="text-align: center;">&nbsp;</p>		 
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn bg-gradient-dark mb-0" data-bs-dismiss="modal">취소</button>
              <a href="#"><button type="button" class="btn bg-gradient-info mb-0">확인</button></a>
            </div>
          </div>
        </div>
      </div>
    </div>
	<!-- 이력서 면접 제안하기 모달창 끝-->

<!-- adminlte 시작-->
<script src="/resources/adminlte3/plugins/jquery/jquery.min.js"></script>
<script src="/resources/adminlte3/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/resources/adminlte3/dist/js/adminlte.min.js?v=3.2.0"></script>
<script src="/resources/adminlte3/dist/js/demo.js"></script>
<!-- adminlte 끝 -->


  <!--   Core JS Files   -->
  <script src="/resources/materialKet2/js/core/popper.min.js" type="text/javascript"></script>
  <script src="/resources/materialKet2/js/core/bootstrap.min.js" type="text/javascript"></script>
  <script src="/resources/materialKet2/js/plugins/perfect-scrollbar.min.js"></script>
  <!--  Plugin for TypedJS, full documentation here: https://github.com/mattboldt/typed.js/ -->
  <script src="/resources/materialKet2/js/plugins/typedjs.js"></script>
  <script src="/resources/materialKet2/js/plugins/choices.min.js"></script>
  <script src="/resources/materialKet2/js/plugins/flatpickr.min.js"></script>
  <!--  Plugin for Parallax, full documentation here: https://github.com/wagerfield/parallax  -->
  <script src="/resources/materialKet2/js/plugins/parallax.min.js"></script>
  <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
  <script src="/resources/materialKet2/js/plugins/nouislider.min.js" type="text/javascript"></script>
  <!--  Plugin for the blob animation -->
  <script src="/resources/materialKet2/js/plugins/anime.min.js" type="text/javascript"></script>
  <!-- Control Center for Material UI Kit: parallax effects, scripts for the example pages etc -->
  <!--  Google Maps Plugin    -->
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDTTfWur0PDbZWPr7Pmq8K3jiDp0_xUziI"></script>
  <script src="/resources/materialKet2/js/material-kit-pro.min.js?v=3.0.3" type="text/javascript"></script>
  <script>
  
  
	let selectedValues = [];
	//엔터키 동작
	function press() {
		if(searchForm.choicesbutton.value == '직군을 선택하세요'){
			searchForm.choicesbutton.value = '';
		}
		if(searchForm.searchMemJob.value == '직무를 선택하세요'){
			searchForm.searchMemJob.value = '';
		}
		searchForm.submit(); //formname에 사용자가 지정한 form의 name입력
	}

	if (document.getElementById('choices-button')) {
	    var element = document.getElementById('choices-button');
	    const example = new Choices(element, {
	      searchEnabled: false
	    });
	
	}
	// 직무 선택 시작
	if (document.getElementById('choices-remove-button')) {
		var element = document.getElementById('choices-remove-button');
		const example = new Choices(element, {
			searchEnabled: false
		});
	}
      
	// 직무 선택 끝
	if (document.querySelector('.datepicker')) {
	  flatpickr('.datepicker', {
	    mode: "range"
	  }); // flatpickr
	}

	
	//클릭한 원하는 직업 가져오는 메서드
	function addJobData(button) {
		
		
		
// 		if (selectedValues.length == 1){
// 			alert("1개만 선택 가능합니다")
			
// 			return;
// 		}
    	//색 변경
    	if (button.classList.contains("btn-outline-info")) {
		    button.classList.remove("btn-outline-info");
		    button.classList.add("bg-gradient-info");
		    button.classList.add("btn-block");
		    button.classList.add("btn_hi");
		  } else {
		    button.classList.add("btn-outline-info");
		    button.classList.remove("bg-gradient-info");
		    button.classList.remove("btn-block");
		    button.classList.remove("btn_hi");
		  }
		
		//직군 클릭시 값 저장 또는 삭제 	
		  button.classList.toggle('selected');
		  let value = button.getAttribute('data-value');
		  if (button.classList.contains('selected')) {
		    selectedValues.push(value);
		  } else {
			  let index = selectedValues.indexOf(value);
		    if (index > -1) {
		      selectedValues.splice(index, 1);
		    }
		  }
		  
		  //선택한 값을 넣음
		  let selectedValuesInput = document.getElementById('searchMemJob');
		  selectedValuesInput.value = selectedValues;
		  
		  getjob();
	}
	
function getjob() {
	
		let data = { "searchMemJob" : $("#searchMemJob").val(),"currentPage" : 1};

		$.ajax({
			url:"/matching/getList",
			data: data,
			type:"post",
			beforeSend : function(xhr) {
			       xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
			   console.log("success result", result);
			
			   var matchingList = result.content;
			   console.log("matchingList : ", matchingList);

//				   getTotal을 다시 구해서 그 값을 설정해줘야하는데 지금 그 로직이 없다
			   
			   var code = "";
			   var pcode = "";
			   // 코드 생성
			   for(let i=0; i<matchingList.length; i++){
					console.log("첫번째 포문 안에 들어왔지롱");
					console.log("i의 길이 : " + i);
					code += '<div class="card m-lg-3">'	
					code += '<div class="card-body">';
					code += '<div class="card-content">';
					code +='<ul><li style="margin-top: 5px;"><h5>' + matchingList[i].memNm +'</h5></li>';
					if(matchingList[i].history[0].cryear == "0" ){
						code +='<li><span class="badge bg-gradient-info">신입</span></li>';
					}else{
						code +='<li>' + matchingList[i].history[0].cryear +'년 근무,</li>';
						code +='<li>'+'총'+ matchingList[i].history[0].crent + '개 회사 근무'+'</li>';
					}
					code += '<li><br/></li>';
					code +='<li style="margin-top: 15px;">'+ matchingList[i].rsmNo + '</small></li></ul></div>';
					
					code +='<div class="card-content">';
					code += '<ul>';
					console.log("이게 뭐냐고요!!!!" + matchingList[i].beforeList[0]);
					if( matchingList[i].beforeList[0] != null ){
						code +='<li>최근 : ' + matchingList[i].beforeList[0].crrEntNm +
									'(' + matchingList[i].beforeList[0].cryear+'년'+ matchingList[i].beforeList[0].crmonth+'개월)' ;
						if(matchingList[i].beforeList[0].crrHdofYn == "Y"){
							code +=	'<b>-재직중</b>'; 
						}
						code += '</li>';
							if( matchingList[i].beforeList.length > 1){
								
								code += '<li>이전 : ';
								for(let j=1; j < matchingList[i].beforeList.length; j++){
									code += matchingList[i].beforeList[j].crrEntNm + '(';
									if(matchingList[i].beforeList[j].cryear > 0){
										code += matchingList[i].beforeList[j].cryear + '년';
									}
									code += matchingList[i].beforeList[j].crmonth +'개월),';
								}
								code +='</li>';
							}
						}
					if(matchingList[i].academicList[0] != null || matchingList[i].academicList[0].length != 0 ){
						code += '<li>학교 : ' + matchingList[i].academicList[0].acbgUniversityNm + ',' + matchingList[i].academicList[0].acbgMajor + '</li>';   
					}
					if(matchingList[i].mySkillList[0] != null || matchingList[i].mySkillList[0].length != 0 ){
						code += '<li>';
						for(let k = 0; k < matchingList[i].mySkillList.length; k++){
							console.log("세번째 포문에 들어왔지롱");
							console.log(k)
							code += '<button type="button" class="btn bg-gradient-light w-auto me-2">' + matchingList[i].mySkillList[k].mySklNm + '</button>';
						}
						code += '</li>';
					}
					code += '<li>' + matchingList[i].memJob + '</li></div>';
					
					code += '<div class="card-content" style="float: right;">';
					code +='<ul><li style="margin: 5px;">';
					if(matchingList[i].rsmNo  == matchingList[i].tvrRsmNo && ${memVO.tcktQntt} > 0){
						code +='<span class="resumeSpn">';
						code +='<input type="hidden" class="rsmNo" name="rsmNo" value="' + matchingList[i].rsmNo + '" />';
						code +='<button type="button" class="btn btn-block btn-info btn-lg" data-bs-toggle="modal" data-bs-target="#exampleModalLong" style="border-radius: 50px; font-size: 15px;">이력서 상세보기</button></span>';
					}else{
						code +='<span class="resumeSpn2">';
						code +='<input type="hidden" class="rsmNo" name="rsmNo" value="' + matchingList[i].rsmNo + '"/>';
						code +='<button type="button" class="btn btn-block btn-info btn-lg" data-bs-toggle="modal" data-bs-target="#exampleModalLong" style="border-radius: 50px; font-size: 15px;">이력서 미리보기</button></span>';
					}
					code +='</li>';
					code +='<li style="margin: 5px;">';
					code +='<span class="wantSpn">';
					if(matchingList[i].recBmkYn == "Y"){
						code +='<button data-input="ihateyou" type="button" class="btn btn-block btn-outline-info btn-lg"';
						code +='style="border-radius: 50px; font-size: 15px; padding: 4px 39px;"  data-rsmno="'+matchingList[i].rsmNo+'">';
						code +='<img id="img'+ matchingList[i].rsmNo +'" alt="star1" src="/resources/images/star1.png" style="margin-bottom: 6px;">찜함</button>';
					}else{
						code +='<button data-input="ilikeyou" type="button" class="btn btn-block btn-outline-info btn-lg"';
						code +='style="border-radius: 50px; font-size: 15px; padding: 4px 39px;"  data-rsmno="'+matchingList[i].rsmNo+'">';
						code +='<img id="img$' + matchingList[i].rsmNo + '" alt="star2" src="/resources/images/star2.png" style="margin-bottom: 6px;">찜하기</button>';
					}
					code +='</span></li></ul></div></div></div>';
					code +='<!-- ============================================== -->'; 
				}// end for
			   console.log("code=============",code );
			   console.log("startPage : ",result.startPage );
			   console.log("endPage : ",result.endPage );
			   
				
			   // 페이징 코드 생성
				if(result.total != 0){
					pcode +='<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">';
					pcode +='<ul class="pagination">';
					pcode +='<li class="paginate_button page-item previous';
						if(result.startPage <6){
							pcode +=' disabled';
						}
					pcode +='" id="dataTable_previous">';
					pcode +='<a href="#"';
					pcode +='aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">';
					pcode +='<i class="fa fa-angle-double-left" aria-hidden="true"></i></a></li>';
					for(var i = result.startPage; i <= result.endPage; i++){
						
						if(result.currentPage == i){
							pcode +='<li class="paginate_button page-item active">';							
						}else{
							pcode +='<li class="paginate_button page-item">';
						}
						pcode +='<a href="javascript:" onclick="pageClick(this)"';
						pcode +='aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">'+i+'</a></li>';		
					}
					if(result.endPage + 5 > result.totalPages){
						pcode += '<li class="paginate_button page-item next disabled" id="dataTable_next">';
					}else{
						pcode += '<li class="paginate_button page-item next" id="dataTable_next">';							
					}
					pcode +='<a href="#"';
					pcode +='aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">';
					pcode +='<i class="fa fa-angle-double-right" aria-hidden="true"></i></a></li></ul></div>';
				}// end if
			   
			   console.log(pcode);
			   $(".ajax-body").html(code);
			   $("#dataTable_paginate").html(pcode);
			}//end success
		});// end ajax
}//end getjob
	
</script>

