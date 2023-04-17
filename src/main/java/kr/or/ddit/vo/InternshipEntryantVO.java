package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class InternshipEntryantVO {

	/**인턴십 참가자 번호*/
	private String itnsEntrtNo;
	/**인턴십 번호*/
	private String itnsNo;
	/**아이디*/
	private String memId;
	/**참가일시*/
	private Date itnsEntrtDt;
	/**승인여부*/
	private String itnsEntrtAprvYn;

	/**회원 이름*/
	private String memNm;

	/**해당 참가자 정보 */
	private List<MemVO> memVo;

	/**승인된 회원 수 담을 용*/
	private int cnt;
}
