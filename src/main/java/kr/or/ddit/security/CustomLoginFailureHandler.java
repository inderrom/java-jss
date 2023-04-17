package kr.or.ddit.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler{
   
   @Override
   public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
      log.info("CustomLoginFailureHandler 도착~!");
      log.info("id : " + request.getParameter("username"));
      
      Cookie cookieMemId = new Cookie("memId", request.getParameter("username"));
      response.addCookie(cookieMemId);
      
      Cookie[] cookies = request.getCookies();
      Map<String, String> map = new HashMap<String, String>();
      if(cookies!=null){
          for (Cookie c : cookies) {
             map.put(c.getName(), c.getValue());
          }
      }
      Cookie cookieFailCnt;
      Cookie cookieMsg;
      cookieMsg = new Cookie("msg", "no");
      response.addCookie(cookieMsg);
      
      if(!map.containsKey("loginFailedCount")) {
         cookieFailCnt = new Cookie("loginFailedCount", "1");
         response.addCookie(cookieFailCnt);
      }else {
         int cnt = Integer.parseInt(map.get("loginFailedCount")) + 1;
         cookieFailCnt = new Cookie("loginFailedCount", cnt+"");
         response.addCookie(cookieFailCnt);
      }
      
      response.sendRedirect("/login");
   }
}