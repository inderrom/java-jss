package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class LanguageScoreVO {
	private String lscoNo;
	private String lanNo;
	private String rsmNo;
	private String lscoNm;
	private String lscoScore;
	private Date lscoAcqsDt;
	private Date lscoExpryDt;
}
