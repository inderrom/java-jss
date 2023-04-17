package kr.or.ddit.mem.chat;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class InternshipChatController {
	
	@CrossOrigin
	@GetMapping("/chat")
	public void chat(Model model) {
		
//		CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String user = "영";
		
		log.debug("==================================");
		log.debug("@ChatController, GET Chat / Username : {}", user);
		
		model.addAttribute("userid", user);
	}
}

