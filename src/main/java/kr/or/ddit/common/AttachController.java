package kr.or.ddit.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.service.AttachService;

@Controller
@RequestMapping("/attach")
public class AttachController<T> {
	
	private final AttachService<T> attachService;
	
	public AttachController(AttachService<T> attachService) {
		this.attachService = attachService;
	}
	
	@PostMapping("/upload")
	public void attachInsert(MultipartFile[] uploadFile, T tvo) {
		this.attachService.attachInsert(uploadFile, tvo);
	}
}
