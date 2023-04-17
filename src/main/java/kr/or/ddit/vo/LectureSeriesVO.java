package kr.or.ddit.vo;

import lombok.Data;

@Data
public class LectureSeriesVO {
	private int rownum;
	private String lctSrsNo;	//강의 기본번호
	private String lctNo;		//강의 번호
	private String prmmNo;		//프리미엄 번호
	private String lctTitle;	//강의 제목
	private String lctHr;	//
	private String lctSrsDegree; // 강의 차수

	//첨부파일
	private String attPath;		//파일 경로
	private String attNm;		//파일명

}
