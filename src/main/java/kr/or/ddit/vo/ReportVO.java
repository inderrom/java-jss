package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReportVO {
	private String rptNo;
	private String rptClfcNo;
	private String memId;
	private String rptRegDt;
	private String etpId;
	private String rptRsn;
	private String rptPrcsYn;
	private String rptPrcsPicNm;
	private Date   rptPrcsDt;

	private List<MemVO> reportingList;
	// 신고 출처 이름
	private String rptClfcNm;

	// 순서 저장
	private int rnum;

	private BoardVO boardVo;

	private MemVO memVo;
}
