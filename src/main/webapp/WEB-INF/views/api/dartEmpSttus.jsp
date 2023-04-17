<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					str = "<table border='1'>";
					str += "<tr><td>rcept_no</td><td>corp_cls</td><td>corp_code</td><td>corp_name</td><td>rm</td>";
					str += "<td>sexdstn</td><td>fo_bbm</td><td>reform_bfe_emp_co_rgllbr</td><td>reform_bfe_emp_co_cnttk</td><td>reform_bfe_emp_co_etc</td>";
					str += "<td>rgllbr_co</td><td>rgllbr_abacpt_labrr_co</td><td>cnttk_co</td><td>cnttk_abacpt_labrr_co</td><td>sm</td>";
					str += "<td>avrg_cnwk_sdytrn</td><td>fyer_salary_totamt</td><td>jan_salary_am</td></tr>";
					
					str += "</table>";
					
					$("#disp").html(str);
				}
			}
		});
	});
});
</script>


<h3>사업보고서 주요정보</h3>

<input type="number" id="bsns_year" name="bsns_year" min="2015"
	max="2021" step="1" value="2021" />
<select id="reprt_code" name="reprt_code">
	<option value="11013">1분기보고서</option>
	<option value="11012">반기보고서</option>
	<option value="11014">3분기보고서</option>
	<option value="11011">사업보고서</option>
</select>
<button type="button" id="btn">확인</button>
<hr />
<div id="disp"></div>

<pre>
rcept_no : 접수번호 > 접수번호(14자리)
corp_cls : 법인구분	> 법인구분 Y(유가), K(코스닥), N(코넥스), E(기타)
corp_code : 고유번호 > 공시대상회사의 고유번호(8자리)
corp_name : 법인명 > 법인명
fo_bbm : 사 업부문	
sexdstn : 성별 > 남, 여
reform_bfe_emp_co_rgllbr : 개정 전 직원 수 > 정규직	
reform_bfe_emp_co_cnttk : 개정 전 직원 수 > 계약직	
reform_bfe_emp_co_etc : 개정 전 직원 수 > 기타	
rgllbr_co : 정규직 수 > 상근, 비상근
rgllbr_abacpt_labrr_co : 정규직 단시간 근로자 수 > 대표이사, 이사, 사외이사 등
cnttk_co : 계약직 수 > 9,999,999,999
cnttk_abacpt_labrr_co : 계약직 단시간 근로자 수 > 9,999,999,999
sm : 합계 > 9,999,999,999
avrg_cnwk_sdytrn : 평균 근속 연수 > 9,999,999,999
fyer_salary_totamt : 연간 급여 총액 > 9,999,999,999
jan_salary_am : 1인평균 급여 액	9,999,999,999
rm : 비고	
</pre>