package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AchievementVO {
	private String achNo;
	private String crrNo;
	private String rsmNo;
	private String achTitle;
	private String achContent;
	private Date achBgngDt;
	private Date achEndDt;
}
