package kr.or.ddit.common;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DownloadController {
	// 요청URI : http://localhost/download?fileName=/2023/01/30/922035f6-e453-434e-9d69-dd68588308f7_nullPointer.jpg
	@ResponseBody
	@GetMapping("/download")
	public ResponseEntity<Resource> download(@RequestParam String fileName) {
		log.debug("fileName : {} ", fileName);

		Resource res = new FileSystemResource("D:/JOBJOB/images" + fileName);
		String resName = res.getFilename();
		HttpHeaders hds = new HttpHeaders();

		try {
			hds.add("Content-Disposition", "attachment;filename=\"" + new String(resName.getBytes("UTF-8"),"ISO-8859-1") + "\"");
		} catch (Exception e) {
			log.error(e.getMessage());
		}finally {

		}

		return new ResponseEntity<Resource>(res, hds, HttpStatus.OK);
	}

}
