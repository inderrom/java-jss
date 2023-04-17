<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 로그인 css -->
<link rel="stylesheet" type="text/css" href="/resources/css/java/JAVA_join.css">


 <!-- 메인 시작-->
    <main>
      <div class="main_container" style="padding-top: 180px;">
    <div class="login login_join_size" style="margin-bottom:230px;">
      <div class="login_header" style="margin-top: 0px;">
        <div class="join_header_backgrund"  >
          <div class=" dohyeon join_header" ><a class="join_cancel">취소</a><span class="join_span">회원가입</span></div>
        </div>
        <form action="">

          <!-- 없는 아이디 입력시 id에 value에 값이 들어가 있어야 한다.-->
          <div class="margin_8 margin_t_3 ">
            <div class="label_div_id">
              <label for="pass"><span class="pass_label">이메일</span></label>
            </div>
            <input class="login_header login_input" type="text" name="" id="" placeholder="이메일을 입력해주세요.">
          </div>
          
          <div class="margin_8 margin_t_3">
            <div class="label_div_id">
              <label for="pass"><span class="pass_label">이름</span></label>
            </div>
            <input class="login_header login_input" type="text" name="" id="" placeholder="이름을 입력해주세요.">
          </div>
          
          <div class="margin_8  margin_t_3 join_phone">
            <div class="label_div_id">
              <label for="pass"><span class="pass_label">전화번호</span></label>
            </div>
            <input class="login_header login_input join_phone_input" type="text" name="" id="" placeholder="(예시) 01012345678">
            <button class="join_phone_btn" >인증번호 받기</button>
            <div class="check_Num margin_t_3 pading_t_3">
              <input class="login_header login_input " type="text" name="" id="" placeholder="6자리 입력해주세요.">
              <button class="login_btn" >인증번호 받기</button>
              <!-- 사용 불가 예시 -->
              <input class="login_header login_input_stop " type="text" name="" id="" placeholder="6자리 입력해주세요.">
              <button class="login_btn_stop" >인증번호 받기</button>
            </div>
          </div>

          <div class="margin_8 margin_t-3">
            <div class="label_div_id">
              <label for="pass"><span class="pass_label">비밀번호</span></label>
            </div>
            <input class="login_header login_input" type="text" name="" id="pass" placeholder="비밀번호을 입력해주세요.">
          </div>
          <div class="margin_8 margin_t-3">
            <div class="label_div_id">
              <label for="pass_check"><span class="pass_label">비밀번호 확인</span></label>
            </div>
            <input class="login_header login_input" type="text" name="" id="pass_check" placeholder="다시한번 비밀번호를 입력해주세요.">
            <p color="var(--theme-palette-colors-gray-600)" class="join_p">영문 대소문자, 숫자, 특수문자를 3가지 이상으로 조합해 8자 이상 16자 이하로 입력해주세요.</p>
          </div>

          
          <div class="check_box_div margin_t_3">
            <input type="checkbox" name="" id="" /><p class="check_p" style="margin-bottom: 0px;;">전체 동의</p>
          </div>
          <hr class="" />

          <div class="check_box_div">
            <input type="checkbox" name="" id="" /><p class="check_p" style="margin-bottom: 0px;;">만 14세 이상입니다. (필수)</p>
          </div>
          <div class="check_box_div">
            <input type="checkbox" name="" id="" /><p class="check_p" style="margin-bottom: 0px;;">JAVA 이용약관 동의(필수)</p>
          </div>
          <div class="check_box_div">
            <input type="checkbox" name="" id="" /><p class="check_p" style="margin-bottom: 0px;;">JAVA 개인정보 수집 동의(필수)</p>
          </div>

          <div class="footer_div">
            <input class="margin_8 login_btn" type="button" name="" id="" value="가입하기" />
            <input class="margin_8 login_btn_stop" type="button" name="" id="" value="가입하기" />
          </div>
        </form>
        </div>
    </div> 
    </div> 
</main>
  <!-- 메인 끝-->