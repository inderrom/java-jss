package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class LanguageVO {
	private String lanNo;
	private String rsmNo;
	private String lanNm;
	private String lanLevel;
	
	private List<LanguageScoreVO> languageScoreVOList;
}
