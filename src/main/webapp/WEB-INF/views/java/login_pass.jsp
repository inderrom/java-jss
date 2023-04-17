<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<main>
	<div class="login login_pass_size">
		<div class="email_back_div">
			<a class="smalldohyeon"><img class="left_arrow_size"
				src="/resources/images/icon/left-arrow.png"> <span
				class="email_back_word">이메일 로그인 돌아가기</span></a>
		</div>
		<div class="login_header margin_8">
			<div class="margin_8 margin_pading">
				<div class="label_div">
					<label for="pass"><span class="pass_label">비밀번호</span></label>
				</div>
				<input class="login_header login_input" type="text" name=""
					id="pass" placeholder="패스워드를 입력해주세요." />
			</div>
			<input class="margin_8 login_btn" type="button" name="" id=""
				value="다음" />

		</div>


	</div>
</main>
