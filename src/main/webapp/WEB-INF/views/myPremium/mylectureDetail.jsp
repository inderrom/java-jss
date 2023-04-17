<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- jQuery -->
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>

<style>
.vertical{
	border-right: 1px solid #808080b3;
}
.box{
  position: relative;
  width: 100%;
  overflow: hidden
}
.note-video-clip {
  display: block;
  border: none;
  height: 100%;
}

</style>

<section class="content pt-3 pt-md-5 pb-md-5">
	<div class="container py-5">
		<div class="container p-5 blur border-radius-lg" style="min-height: 500px;background-color: rgb(255 244 244 / 60%) !important;">


			<div class="mx-5  card  p-4" style="height: auto; min-height: 500px;">
				<div class="row">
					<div class="col-md-6 ">
						<a href="/myPremium/mylectureDetail?prmmNo=${param.prmmNo }">
						<p class="ms-5 mt-4" id="" style="font-size: large;">
							<b>강의 학습방</b><br/>
							${data.prmmTitle }
						</p>
					</a>
					</div>
					<div class="col-md-6">
						<div class="me-5 mt-4" style="display: inline-block; float: right;">
							<a href='javascript:window.history.back();'><i class="material-icons">close</i></a>
						</div>
					</div>
				</div>
				<div class="px-5 mt-2 mb-2">
					<div class="row box" style="height:350px;">
						<div class="row " style="height:300px;">
							<div class="col-md-7 pe-3 vertical">
								<c:choose>
									<c:when test="${not empty data.attNm  }">
										<img class="img-fluid border-radius-lg mx-auto"
											 src="/resources/images${data.attNm  }" alt="${data.attNm  }" >
									</c:when>
									<c:otherwise>
										<c:if test="${data.prmmClfc eq 'PRE0001' }">
											<img class="img-fluid border-radius-lg mx-auto"
											 src="/resources/images/기본강의.jpg" alt="기본 강의 이미지" >
										</c:if>
										<c:if test="${data.prmmClfc eq 'PRE0002'}">
											<img class="img-fluid border-radius-lg mx-auto"
											 src="/resources/images/기본특강.jpg" alt="기본 특강 이미지" >
										</c:if>
									</c:otherwise>
								</c:choose>

							</div>
							<div class="col-md-5 ps-3 pt-5">
								<p>강사 : ${data.lctInstrNm }</p>
								<p>시수 : ${fn:length(data.lecSeriesList)}차시</p>
							</div>
						</div>
					</div>

				</div>
			</div>


			<div class="mx-5 mt-6 card p-5 px-20 mb-8" style="height: auto; min-height: 200px;">

				<table class="table px-10 me-10 text-center" style="vertical-align: middle;">
					<thead>
						<tr>
							<th scope="col"><font style="vertical-align: inherit;">
									<font style="vertical-align: inherit;"> </font>
							</font></th>
							<th scope="col"><font style="vertical-align: inherit;">
									<font style="vertical-align: inherit;"> 제목 </font>
							</font></th>
<!-- 							<th scope="col"><font style="vertical-align: inherit;"> -->
<!-- 									<font style="vertical-align: inherit;">  </font> -->
<!-- 							</font></th> -->
							<th scope="col"><font style="vertical-align: inherit;">
									<font style="vertical-align: inherit;"> </font>
							</font></th>
						</tr>
					</thead>
					<tbody>

						<c:forEach var="LectureSeriesVO" items="${data.lecSeriesList}"
							varStatus="stat">
							<tr>
								<th><font style="vertical-align: inherit;"> <font
										style="vertical-align: inherit;">
											${LectureSeriesVO.rownum } </font>
								</font></th>
								<td class="text-wrap"><font style="vertical-align: inherit;"> <font
										style="vertical-align: inherit;">
											${LectureSeriesVO.lctTitle } </font>
								</font></td>
<!-- 								<td class="text-wrap"><font style="vertical-align: inherit;"> <font -->
<!-- 										style="vertical-align: inherit;"> -->
<%-- 											${LectureSeriesVO.lctHr } </font> --%>
<!-- 								</font></td> -->
								<td class="text-center ">
									<form name=videoForm" >
										<input type="hidden" name="lctSrsNo" id="lctSrsNo"
											value="${LectureSeriesVO.lctSrsNo }" />
										<button type="button" class="btn btn-info btn-sm lecturePlay">
											강의 수강하기</button>
									</form>
								</td>
							</tr>

						</c:forEach>
					</tbody>

				</table>

			</div>


		</div>
	</div>
</section>

<script type="text/javascript">
$(function() {
// 	동영상 재생 창(팝업) 열기
// 		$(".lecturePlay").on("click", function(){
// 			let lctSrsNo = $(this).parent().find("#lctSrsNo").val();
// 			console.log(lctSrsNo);

// 			//lctSrsNocs를 주소에 같이 넘겨줘야하는데
// 			let width = 1100;
// 			let height=800;

// 			let left = Math.ceil((window.screen.width - width)/2);
// 			let top = Math.ceil((window.screen.height - height)/2);

// 			window.open('/myPremium/lecturePlay?lctSrsNo='+lctSrsNo, '강의 재생',
// 					'width='+width+',height='+height+',left='+left+',top='+top+',scrollbars=yes');
// 		})


	//'강의 수강하기'버튼 클릭 시
	$(".lecturePlay").on("click", function(){
		//강의 번호 가져오기
		let lctSrsNo = $(this).parent().find("#lctSrsNo").val();
		console.log(lctSrsNo);
		let data = {"lctSrsNo":lctSrsNo};

		$.ajax({
			url: '/myPremium/lecturePlay',
// 			contentType:"application/json;charset=utf-8",
			data : data,
			type : 'get',
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(resultMap){
				console.log("resultMap : ", resultMap);
				let code = "";

				if(resultMap.size == 0 ) {
					code += "동영상 파일이 없습니다. 관리자에게 문의하세요.";
				} else {
// 					if()
// 					code += '<video src="'+'"height="420" controls><video>';
					code += resultMap.attNm;

				}

				$(".box").html(code);

				$(".box").height('400px');
				$("iframe").attr("class","note-video-clip mx-auto");
				console.log("개똥이");

			}
		});



	})
})

</script>
























