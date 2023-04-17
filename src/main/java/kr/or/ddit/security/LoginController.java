package kr.or.ddit.security;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class LoginController {
	
	@GetMapping("/login")
	public String loginForm(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		model.addAttribute("body_main", "body_main");
		if(error != null) {
			model.addAttribute("error", "Login Error");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout");
		}
		return "security/loginform";
	}
	
	
	@GetMapping("/login2")
	public String loginFormTest(String error, String logout, Model model) {
		log.info("error : " + error);
		log.info("logout : " + logout);
		
		model.addAttribute("body_main", "body_main");
		return "security/loginformTest";
	}
	
	
	
}
