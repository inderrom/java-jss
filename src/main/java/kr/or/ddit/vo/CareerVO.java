package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class CareerVO {
	private String crrNo;
	private String rsmNo;
	private String crrEntNm;
	private String crrJbgdNm;
	private Date crrJncmpDt;
	private Date crrRtrmDt;
	private String crrHdofYn;
	private String cryear;
	private String crent;
	private String crmonth;
	
	private List<AchievementVO> achievementVOList;
}


