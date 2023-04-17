package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class LectureDetailVO {

	//PREMIUM + LECTURE JOIN => SELECT

	private String prmmNo;			//프리미엄 번호
	private String prmmTitle;		//프리미엄 제목
	private String prmmContent;		//프리미엄 내용
	private Date prmmRegDt;			//프리미엄 등록 일시
	private String prmmClfc;		//프리미엄 분류
	private String lctNo;			//강의번호
	private String lctDvsn;			//강의구분
	private String lctDt;			//강의시간
	private String lctInstrNm;		//강의 이름

	/** 강의 상세 리스트 */
	private List<LectureSeriesVO> lecSeriesList;
}
