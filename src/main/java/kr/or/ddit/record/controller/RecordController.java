package kr.or.ddit.record.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.vo.RecordVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/record")
@Controller
public class RecordController {
	private final RecordService recordService;
	
	@Autowired
	private RecordController(RecordService recordService) {
		this.recordService = recordService;
	}
	
	/**
	 * ETP_ID를 파라미터로 받아 기록 테이블에 북마크 해주는 메서드
	 * 비동기로 호출 
	 * @param etpId
	 * @param recordVO
	 * @return 성공 1, 실패 0
	 */
	@ResponseBody
	@PostMapping("/bookmark")
	public int bookmark(@RequestParam String etpId, RecordVO recordVO) {
		recordVO.setEtpId(etpId);
		recordVO.setRecordType("bookmark");
		return this.recordService.setRecord(recordVO);
	}
	
	/**
	 * ETP_ID를 파라미터로 받아 기록 테이블에 북마크 해주는 메서드
	 * 비동기로 호출 
	 * @param let data = {"etpId": rsmNo};	
	 * @param recordVO
	 * @return 성공 1, 실패 0
	 */
	@ResponseBody
	@PostMapping("/bookmarkWant")
	public int bookmarkWant(@RequestBody RecordVO recordVO) {
		log.debug("recordVO : {} ", recordVO);
		
		recordVO.setEtpId(recordVO.getEtpId());
		recordVO.setRecordType("bookmark");
		return this.recordService.setRecord(recordVO);
	}
}
