<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>dart 공시정보</h3>

<p>https://opendart.fss.or.kr/api/company.json?crtfc_key=인증키&corp_code=고유번호</p>

<div>
	<table border="1">
		<tr><td>정식명칭</td><td>${company.corp_name}</td></tr>
		<tr><td>영문명칭</td><td>${company.corp_name_eng}</td></tr>
		<tr><td>종목명(상장사) 또는 약식명칭(기타법인)</td><td>${company.stock_name}</td></tr>
		<tr><td>상장회사인 경우 주식의 종목코드</td><td>${company.stock_code}</td></tr>
		<tr><td>대표자명</td><td>${company.ceo_nm}</td></tr>
		<tr><td>법인구분</td><td>${company.corp_cls}</td></tr>
		<tr><td>법인등록번호</td><td>${company.jurir_no}</td></tr>
		<tr><td>사업자등록번호</td><td>${company.bizr_no}</td></tr>
		<tr><td>주소</td><td>${company.adres}</td></tr>
		<tr><td>홈페이지</td><td>${company.hm_url}</td></tr>
		<tr><td>IR홈페이지</td><td>${company.ir_url}</td></tr>
		<tr><td>전화번호</td><td>${company.phn_no}</td></tr>
		<tr><td>팩스번호</td><td>${company.fax_no}</td></tr>
		<tr><td>업종코드</td><td>${company.induty_code}</td></tr>
		<tr><td>설립일(YYYYMMDD)</td><td>${company.est_dt}</td></tr>
		<tr><td>결산월(MM)</td><td>${company.acc_mt}</td></tr>
	</table>
</div>

