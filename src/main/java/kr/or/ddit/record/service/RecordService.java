package kr.or.ddit.record.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.RecordVO;

public interface RecordService {
	/**
	 * 기록 분류 번호, 회원 아이디, 전사적 아이디, 책갈피 여부를 
	 * 파라미터로 받아 기록 테이블에 데이터를 insert하는 메서드 
	 * 기록 분류 번호(REC_CLFC_NO)
	 * 회원 아이디(MEM_ID)
	 * 전사적 아이디(ETP_ID) -> 회원 아이디, 채용공고 번호, 게시글 번호, 프리미엄 번호
	 * 책갈피 여부(REC_REG_YN) -> Y/N
	 * 
	 * @param recordVO
	 * @return 성공 : 1, 실패 0
	 */
	public int setRecord(RecordVO recordVO);

	Map<String, List<Object>> getRecord();
	
}
