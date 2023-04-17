package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class RecordVO {
	private String memId;
	private String etpId;
	private String recClfcNo;
	private Date recRegDt;
	private String recBmkYn;
	private String recordType;
}
