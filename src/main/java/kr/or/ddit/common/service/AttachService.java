package kr.or.ddit.common.service;

import org.springframework.web.multipart.MultipartFile;

public interface AttachService<T> {

	void attachInsert(MultipartFile[] uploadFile, T tvo);

}
