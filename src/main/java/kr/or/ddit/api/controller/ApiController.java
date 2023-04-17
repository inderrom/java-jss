package kr.or.ddit.api.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.api.service.ApiService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/api")
@Controller
public class ApiController {
	private final ApiService apiService;
	
	@Autowired
	private ApiController(ApiService apiService) {
		this.apiService = apiService;
	}
	@GetMapping("/home")
	public void apiHome() {}
	
	@GetMapping("/kakaoMap")
	public void kakaoMap() {}
	
	@GetMapping("/jobKorea")
	public void jobKorea() {}
	
	@GetMapping("/googleChart")
	public void googleChart() {}
	
	@GetMapping("/employmentInsurance")
	public void employmentInsurance() {}
	
	@GetMapping("/dart")
	public void dart() {}
	
	@GetMapping("/reCaptcha")
	public void reCaptcha() {}
	
	@GetMapping("/email")
	public void email() {}
	
	@GetMapping("/snsLogin")
	public void snsLogin() {}
	
	@GetMapping("/dartCompany")
	public String dartCompany(@RequestParam String corp_code, Model model) {
		String url = "https://opendart.fss.or.kr/api/company.json?crtfc_key=e34034da260680c8ac25984de3d8f73c82580b91&corp_code=" + corp_code;
		Map<String, Object> company = this.apiService.getJson(url);
		model.addAttribute("company", company);
		return "api/dartCompany";
	}
	
	@GetMapping("/dartEmpSttus")
	public void dartEmpSttus() {}
	
	@GetMapping("/dartFnlttSinglAcnt")
	public void dartFnlttSinglAcnt() {}
	
	@ResponseBody
	@PostMapping("/dartEmpSttus")
	public Map<String, Object> dartEmpSttus(@RequestParam String corp_code, String bsns_year, String reprt_code) {
		String url = "https://opendart.fss.or.kr/api/empSttus.json?crtfc_key=e34034da260680c8ac25984de3d8f73c82580b91&corp_code=" + corp_code + "&bsns_year=" + bsns_year + "&reprt_code=" + reprt_code;
		System.out.println("url : " + url);
		Map<String, Object> company = this.apiService.getJson(url);
		return company;
	}
	
	@PostMapping("/dartFnlttSinglAcnt")
	public Map<String, Object> dartFnlttSinglAcnt(@RequestParam String corp_code, String bsns_year, String reprt_code) {
		String url = "https://opendart.fss.or.kr/api/fnlttSinglAcnt.json?crtfc_key=e34034da260680c8ac25984de3d8f73c82580b91&corp_code=" + corp_code + "&bsns_year=" + bsns_year + "&reprt_code=" + reprt_code;
		Map<String, Object> company = this.apiService.getJson(url);
		return company;
	}
	
	@GetMapping("/sms")
	public void sms() {}
	
	@ResponseBody
	@PostMapping("/sms")
	public String sendSMS(@RequestParam String sender) {
		log.info("sender: " + sender);
		sender = sender.replaceAll("-", "");
		return this.apiService.sendCertificationNumber(sender);
	}
	
	@ResponseBody
	@PostMapping("/sendEmail")
	public void sendEmail(@RequestBody Map<String, String> map) {
		log.info("map : " + map);
		this.apiService.sendEmail(map);
	}
	
	@ResponseBody
	@PostMapping("/sendCertificationNumberEmail")
	public String sendCertificationNumberEmail(@RequestParam String recipient) {
		String certificationNumber = this.apiService.sendCertificationNumberEmail(recipient);
		return certificationNumber;
	}
	
	@ResponseBody
	@PostMapping("/sendForgotPassEmail")
	public void sendForgotPassEmail(@RequestParam String recipient) {
		this.apiService.sendForgotPassEmail(recipient);
	}
	
	@ResponseBody
	@PostMapping("/passEmail")
	public void passEmail(@RequestParam Map<String, String> map) {
		log.debug("map : {}", map);
		this.apiService.passEmail(map);
		
		
	}
	
	@ResponseBody
	@PostMapping("/failEmail")
	public void failEmail(@RequestParam Map<String, String> map) {
		log.debug("map : {}", map);
		this.apiService.failEmail(map);
		
		
	}
	
	@GetMapping("/iniPay")
	public String iniPay() { return "api/iniPay";}
	
	@GetMapping("/fullcalendar")
	public void fullcalendar() {}
	
}
