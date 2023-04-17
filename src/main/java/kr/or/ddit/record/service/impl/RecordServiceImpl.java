package kr.or.ddit.record.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.mapper.BoardMapper;
import kr.or.ddit.enterprise.mapper.EnterpriseMapper;
import kr.or.ddit.premium.mapper.PremiumMapper;
import kr.or.ddit.record.mapper.RecordMapper;
import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.JobPostingVO;
import kr.or.ddit.vo.PremiumVO;
import kr.or.ddit.vo.RecordVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RecordServiceImpl implements RecordService{
	private final RecordMapper recordMapper;
	private final BoardMapper boardMapper;
	private final PremiumMapper premiumMapper;
	private final EnterpriseMapper enterpriseMapper;
	
	@Autowired
	private RecordServiceImpl(RecordMapper recordMapper, BoardMapper boardMapper, PremiumMapper premiumMapper, EnterpriseMapper enterpriseMapper) {
		this.recordMapper = recordMapper;
		this.boardMapper = boardMapper;
		this.premiumMapper = premiumMapper;
		this.enterpriseMapper = enterpriseMapper;
	}
	
	@Override
	public int setRecord(RecordVO recordVO) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal(); 
		log.debug("class : {}", principal.getClass()+"");
		if(principal.getClass() != CustomUser.class) {
			log.info("로그인 정보 없음");
			return 0;
		}
		UserDetails userDetails = (UserDetails)principal;
		
		recordVO.setMemId(userDetails.getUsername());
		if(recordVO.getRecordType() == null || "".equals(recordVO.getRecordType())) {
			recordVO.setRecordType("record");
		}
		
		String etpId = recordVO.getEtpId();
		String recClfcNo = "";
		if(etpId.contains("@")) {
			recClfcNo = "RECCL0001";
		}
		if(etpId.startsWith("JPSTG") || etpId.startsWith("JPNG")) {
			recClfcNo = "RECCL0002";
		}
		if(etpId.startsWith("BRD")) {
			recClfcNo = "RECCL0003";
		}
		if(etpId.startsWith("PRMM")) {
			recClfcNo = "RECCL0004";
		}
		if(etpId.startsWith("ENT")) {
			recClfcNo = "RECCL0005";
		}
		if(etpId.startsWith("RSM")) {
			recClfcNo = "RECCL0006";
		}
		if(etpId.startsWith("LEC")) {
			recClfcNo = "RECCL0007";
		}
		if(etpId.startsWith("LECSRS")) {
			recClfcNo = "RECCL0008";
		}
		
		recordVO.setRecClfcNo(recClfcNo);
		
		return this.recordMapper.setRecord(recordVO);
	}
	
	@Override
	public Map<String, List<Object>> getRecord() {
		log.info("---------------RecordService---------------");
		Map<String, List<Object>> myRecordMap = new HashMap<String, List<Object>>();
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails)principal;
		
		RecordVO recordVO = new RecordVO();
		recordVO.setMemId(userDetails.getUsername());
		
		recordVO.setRecClfcNo("RECCL0001"); // 회원?
		List<RecordVO> memberRecordList = this.recordMapper.getRecord(recordVO);
		
		recordVO.setRecClfcNo("RECCL0002"); // 공고
		List<RecordVO> jobPostingRecordList = this.recordMapper.getRecord(recordVO);
		List<Object> jobPostingList = new ArrayList<Object>();
		for(RecordVO rVO : jobPostingRecordList) {
			JobPostingVO jobPostingVO = this.enterpriseMapper.getDetailJobPosting(rVO.getEtpId());
			jobPostingList.add(jobPostingVO);
		}
		log.debug("jobPostingList : {}", jobPostingList);
		
		recordVO.setRecClfcNo("RECCL0003"); // 게시글
		List<RecordVO> boardRecordList = this.recordMapper.getRecord(recordVO);
		List<Object> boardList = new ArrayList<Object>();
		for(RecordVO rVO : boardRecordList) {
			BoardVO boardVO = new BoardVO();
			boardVO.setBoardNo(rVO.getEtpId());
			boardVO = this.boardMapper.boardDetail(boardVO);
			boardList.add(boardVO);
		}
		log.debug("boardList : {}", boardList);
		
		recordVO.setRecClfcNo("RECCL0004"); // 프리미엄
		List<RecordVO> premiumRecordList = this.recordMapper.getRecord(recordVO);
		List<Object> premiumList = new ArrayList<Object>();
		for(RecordVO rVO : premiumRecordList) {
			PremiumVO premiumVO = new PremiumVO();
			premiumVO.setPrmmNo(rVO.getEtpId());
			premiumVO = this.premiumMapper.getPrmmDetail(premiumVO);
			premiumList.add(premiumVO);
		}
		log.debug("premiumList : {}", premiumList);
		
		recordVO.setRecClfcNo("RECCL0005"); // 기업
		List<RecordVO> entpriseRecordList = this.recordMapper.getRecord(recordVO);
		List<Object> enterpriseList = new ArrayList<Object>();
		for(RecordVO rVO : entpriseRecordList) {
			EnterpriseVO enterpriseVO = new EnterpriseVO();
			enterpriseVO.setEntNo(rVO.getEtpId());
			enterpriseVO = this.recordMapper.getEnterpriseDetail(enterpriseVO);
			enterpriseList.add(enterpriseVO);
		}
		
		myRecordMap.put("jobPostingList", jobPostingList);
		myRecordMap.put("boardList", boardList);
		myRecordMap.put("premiumList", premiumList);
		myRecordMap.put("enterpriseList", enterpriseList);
		
		return myRecordMap;
	}
}
