<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
$(function(){
	$.ajax({
		url: "/resources/CORPCODE.xml",
		type: "get",
		dataType: "xml",
		success: function(result){
			let list = $(result).find("list");
			console.log(list);
			console.log(result);
			str = "<thead><tr><td>corp_code</td><td>corp_name</td><td>stock_code</td><td>modify_date</td><td>공시정보</td><td>사업보고서 주요정보</td><td>상장기업 재무정보</td></tr></thead><tbody>";
			$.each(list, function(i, v){
				if(i > 100){
					return;
				}
				let corp_code = $(v).find("corp_code").html();
				str += "<tr>";
				str += "<td>"+corp_code+"</td>";
				str += "<td>"+$(v).find("corp_name").html()+"</td>";
				str += "<td>"+$(v).find("stock_code").html()+"</td>";
				str += "<td>"+$(v).find("modify_date").html()+"</td>";
				str += "<td><a href='/api/dartCompany?corp_code="+corp_code+"'>공시정보</a></td>";
				str += "<td><a href='/api/dartEmpSttus?corp_code="+corp_code+"'>사업보고서 주요정보</a></td>";
				str += "<td><a href='/api/dartFnlttSinglAcnt?corp_code="+corp_code+"'>상장기업 재무정보</a></td>";
				str += "</tr>";
			});
			str += "</tbody>";
			$("#dart").html(str);
			
			$("#dart").DataTable();
		},
		error: function(xhr){
			console.log(xhr.status);
		}
	});
});
</script>

crtfc_key = e34034da260680c8ac25984de3d8f73c82580b91
<h3>dart 기업별 고유번호</h3>

<div>
	<table id="dart" class="table table-bordered table-striped dataTable dtr-inline">
	</table>
</div>
