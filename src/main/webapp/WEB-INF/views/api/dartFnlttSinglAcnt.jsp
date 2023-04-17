<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function(){
	$("#btn").on("click", function(){
		console.log("00"+${param.corp_code});
		$.ajax({
			url: "/api/dartEmpSttus",
			data: {"corp_code": "00"+${param.corp_code},
				   "bsns_year": $("#bsns_year").val(),
				   "reprt_code": $("#reprt_code").val()},
			type: "post",
			beforeSend : function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         	},
			success: function(result){
				console.log(result);
				if(result.status=="013"){
					$("#disp").html(result.message);
				}else{
					
				}
			}
		});
	});
});
</script>


<h3>사업보고서 주요정보</h3>

<input type="number" id="bsns_year" name="bsns_year" min="2015" max="2021" step="1" value="2021" />
<select id="reprt_code" name="reprt_code">
	<option value="11013">1분기보고서</option>
	<option value="11012">반기보고서</option>
	<option value="11014">3분기보고서</option>
	<option value="11011">사업보고서</option>
</select>
<button type="button" id="btn">확인</button>
<hr/>
<div id="disp">
	
</div>