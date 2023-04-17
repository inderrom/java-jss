package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

//강의 및 특강 VO
@Data
public class LectureVO {

	private String prmmNo;			//프리미엄 번호
	private String prmmTitle;		//프리미엄 제목
	private String prmmContent;		//프리미엄 내용
	private Date prmmRegDt;			//프리미엄 등록 일시
	private String prmmClfc;		//프리미엄 분류
	private String lctNo;			//강의 번호
	private String lctDvsn;			//강의 구분	(강의/특강)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date lctDt;			//강의시간		(특강에만 사용)	//jsp에서 null이 아닐시 특강에만 출력?
	private String lctInstrNm;		//강사 이름

	/** 대표 이미지  (코드 : ATTCL009) */
	private String attNm;			//프리미엄 이미지
	private String attPath;			//프리미엄 경로

	/** 첨부파일 리스트  (코드 : ATTCL010) */
	private List<AttachmentVO> lecAttVOList;

	/** 강의 상세 리스트 */
	private List<LectureSeriesVO> lecSeriesList;

	/** 강좌 메인 사진 */
	private String bgPicture;
}
