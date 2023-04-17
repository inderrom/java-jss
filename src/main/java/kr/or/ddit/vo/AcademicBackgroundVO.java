package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class AcademicBackgroundVO {
	private String acbgNo;
	private String rsmNo;
	private String acbgUniversityNm;
	private String acbgMajor;
	private String acbgDegree;
	private String acbgDiscription;
	private Date acbgMtcltnDt;
	private Date acbgGrdtnDt;
	private String acbgAttndYn;
}
