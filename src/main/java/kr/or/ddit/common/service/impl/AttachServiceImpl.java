package kr.or.ddit.common.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.common.mapper.AttachMapper;
import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.security.CustomUserDetailsService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.EnterpriseVO;
import kr.or.ddit.vo.InternshipCommunityVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.MemVO;
import kr.or.ddit.vo.PremiumVO;
import lombok.extern.slf4j.Slf4j;

@Service("attachService")
@Slf4j
//@Component
public class AttachServiceImpl<T> implements AttachService<T> {
	private final AttachMapper attachMapper;
	private final CustomUserDetailsService customUserDetailsService;

	@Autowired
	public AttachServiceImpl(AttachMapper attachMapper, CustomUserDetailsService customUserDetailsService) {
		this.attachMapper = attachMapper;
		this.customUserDetailsService = customUserDetailsService;
	}

	private void setUserDetails() {
		Authentication oldAuth = SecurityContextHolder.getContext().getAuthentication();
		Authentication newAuth = new PreAuthenticatedAuthenticationToken(
				customUserDetailsService.loadUserByUsername(this.getUserName()), oldAuth.getCredentials(),
				oldAuth.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(newAuth);
	}

	private String getUserName() {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserDetails userDetails = (UserDetails) principal;
		return userDetails.getUsername();
	}

	@Override
	public void attachInsert(MultipartFile[] uploadFile, T tvo) {
		log.debug("tvo : {} ", tvo);

		String uploadFolder = "D:/JOBJOB/images";

		// 오늘 날짜로 폴더 만들기 시작-----------------------
		File uploadPath = new File(uploadFolder, getFolder());
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		// 오늘 날짜로 폴더 만들기 끝-----------------------

		Map<String, String> map = new HashMap<String, String>();

		for (MultipartFile multipartFile : uploadFile) {
			log.debug("multipartFile : {} ", multipartFile.getOriginalFilename());

			String uploadFileName = multipartFile.getOriginalFilename();

			// 파일 중복을 방지하기 위해 랜덤문자열 생성
			uploadFileName = UUID.randomUUID().toString() + "_" + uploadFileName;

			File saveFile = new File(uploadPath, uploadFileName);

			try {
				multipartFile.transferTo(saveFile);

			} catch (IllegalStateException e) {
				log.error(e.getMessage());
			} catch (IOException e) {
				log.error(e.getMessage());
			}

			// 기업회원이 파일 업로드 한 경우
			if (tvo instanceof EnterpriseVO) {
				map.put("etpId", ((EnterpriseVO) tvo).getEntNo());
				if (uploadFile[0].getName().equals("entCertificate")) {
					map.put("attClfcNo", "ATTCL0001"); // 사업자등록증명원
				} else if (uploadFile[0].getName().equals("entrprsimgs")) {
					map.put("attClfcNo", "ATTCL0002"); // 회사 대표 이미지
				} else if (uploadFile[0].getName().equals("entlogoimgs")) {
					map.put("attClfcNo", "ATTCL0003"); // 회사 로고 이미지
				} else if (uploadFile[0].getName().equals("unlimitMsContract")) {
					map.put("attClfcNo", "ATTCL0013"); // 무제한 멤버십 계약서
				}
			}

			// 일반회원이 파일 업로드 한 경우
			else if (tvo instanceof MemVO) {
				map.put("etpId", ((MemVO) tvo).getMemId());
				if (!checkImageType(saveFile)) {
					map.put("attClfcNo", "ATTCL0004"); // 이력서 파일
				} else {
					map.put("attClfcNo", "ATTCL0005"); // 회원 프로필 이미지
				}
			}

			// 게시판에서 파일 업로드 한 경우
			else if (tvo instanceof BoardVO) {
				map.put("etpId", ((BoardVO) tvo).getBoardNo());
				if (checkImageType(saveFile)) {
					map.put("attClfcNo", "ATTCL0007"); // 게시글 이미지
				} else {
					map.put("attClfcNo", "ATTCL0008"); // 게시글 첨부파일
				}
			}

			// 프리미엄에서 파일 업로드 한 경우
			else if (tvo instanceof PremiumVO) {
				map.put("etpId", ((PremiumVO) tvo).getPrmmNo());
				if (checkImageType(saveFile)) {
					map.put("attClfcNo", "ATTCL0009"); // 프리미엄 이미지
				} else {
					map.put("attClfcNo", "ATTCL0010"); // 프리미엄 첨부파일
				}
			}

			// 강의에서 파일 업로드 한 경우
			else if (tvo instanceof LectureVO) {
				map.put("etpId", ((LectureVO) tvo).getLctNo());
				map.put("attClfcNo", "ATTCL0012"); // 강의 파일
			}

			// 인턴십 커뮤니티에서 파일 업로드 한 경우
			else if (tvo instanceof InternshipCommunityVO) {
				map.put("etpId", ((InternshipCommunityVO) tvo).getItnsCmmuNo());
				if (checkImageType(saveFile)) {
					map.put("attClfcNo", "ATTCL0014"); // 인턴십 커뮤니티 이미지
				} else {
					map.put("attClfcNo", "ATTCL0015"); // 인턴십 커뮤니티 첨부파일
				}
			}

			map.put("uploadFolder", uploadFolder);
			String filename = "/" + getFolder().replace("\\", "/") + "/" + uploadFileName;
			map.put("filename", filename);
		}

		this.attachMapper.attachInsert(map);
		this.setUserDetails();
	}

	// 연/월/일 폴더 생성
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);

		return str.replace("-", File.separator);
	}

	// 이미지 파일 판단
	public boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			log.debug("contentType : {} ", contentType);
			return contentType.startsWith("image");
		} catch (IOException e) {
			log.error(e.getMessage());
		}
		return false;
	}
}
