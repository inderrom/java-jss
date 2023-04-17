package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class JobPostingVO {
	
	//구인공고번호
	private String jobPstgNo;
	//기업 번호
	private String entNo;
	//승인여부
	private String jobPstgAprvYn;
	//채용 시작일
	private String jobPstgBgngDt;
	//채용 종료일
	private String jobPstgEndDate;
	//공고제목
	private String jobPstgTitle;
	//공고내용
	private String jobPstgContent;
	//주요 업무
	private String jobPstgMainWork;
	//자격요건
	private String jobPstgQlfc;
	// 우대사항
	private String jobPstgRpfntm;
	//혜택 및 복지
	private String jobPstgBnf;
	//취업 축하금
	private int jobPstgPrize;
	
	// 기업명
	private String entNm;
	
	//기업 번호 리스트
	private List<String> entNoList;
	
	// 북마크 상태
	private boolean recBmkYn;
	// 기업 첨부파일
	private List<AttachmentVO> attachmentList;
	// 모집 분야 
	private List<RequireJobVO> requireJobVOList;
	// 구인 공고 태그
	private List<JobPostingTagVO> jobPostingTagVOList;
	// 구인 공고 스킬
	private List<JobPostingSkillVO> jobPostingSkillVOList;
	
	// 기업 정보
	private EnterpriseVO  enterpriseVO;
	
	// 번호
	private int rnum;
}
