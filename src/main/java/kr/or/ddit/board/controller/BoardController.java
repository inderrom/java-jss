package kr.or.ddit.board.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.common.service.AttachService;
import kr.or.ddit.record.service.RecordService;
import kr.or.ddit.security.CustomUser;
import kr.or.ddit.vo.ArticlePage;
import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.RecordVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/board")
@Controller
public class BoardController {

	private BoardService boardService;
	private RecordService recordService;
	private AttachService<BoardVO> attchService;

	@Autowired
	public BoardController(BoardService boardService, RecordService recordService, AttachService<BoardVO> attchService) {
		this.boardService = boardService;
		this.recordService = recordService;
		this.attchService = attchService;
	}

	/**
	 * 글 목록을 조회한다. (pageing)
	 * 
	 * @param boardVO - 조회할 정보가 담긴 BoardVO
	 * @param model
	 * @return void형
	 */
	@GetMapping("/boardList")
	public String boardList(@ModelAttribute BoardVO boardVO, Model model, Principal principal,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "show", required = false, defaultValue = "5") int size,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "boardClfcNo", required = true) String boardClfcNo) {
		log.debug("boardListGet 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("boardClfcNo", boardClfcNo);
		int total = this.boardService.getTotal(map);
		
		if(principal != null) {
			int crrYear = boardService.getCrrList(principal.getName());
			model.addAttribute("crrYear", crrYear);
		}
		
		map.put("size", size+"");
		map.put("currentPage", currentPage+"");
		List<BoardVO> boardVOList = boardService.boardList(map);
		log.debug("boardVOList : {} " , boardVOList);

		model.addAttribute("list", new ArticlePage<BoardVO>(total, currentPage, size, boardVOList));
		model.addAttribute("total", total);
		model.addAttribute("size", size);
		
		String pages = "";
		switch (boardClfcNo) {
		case "BRDCL0001":
			pages = "board/noticeList";
			break;
		case "BRDCL0002":
			pages = "board/faqList";
			break;
		case "BRDCL0003":
			pages = "board/boardList";
			break;
		case "BRDCL0004":
			pages = "board/qnaList";
			break;
		
		}

		return pages;
	}
	
	/**
	 * 글 등록 화면을 조회한다.
	 * 
	 * @return void형
	 */
	@GetMapping("/cusCenterMain")
	public void cusCenterMain() {
		log.debug("cusCenterMain 시작");
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * 
	 * @return void형
	 */
	@GetMapping("/boardInsert")
	public void boardInsertGet() {
		log.debug("boardInsertGet 시작");
	}

	/**
	 * 글을 등록한다.
	 * 
	 * @param boardVO 등록할 정보가 담긴 BoardVO
	 * @param model
	 * @return "redirect:/board/boardDetail"
	 */
	@PostMapping("/boardInsert")
	public String boardInsertPost(@ModelAttribute BoardVO boardVO, Model model, Principal principal) {
		log.debug("boardInsertPost 시작");
		if (principal == null) {
			return "redirect:/login";
		}

		int result = boardService.boardInsert(boardVO);
		MultipartFile[] uploadFile = boardVO.getUploadFile();
		
		if(uploadFile[0].getOriginalFilename() != null && !uploadFile[0].getOriginalFilename().equals("")) {
			this.attchService.attachInsert(boardVO.getUploadFile(), boardVO);
		}
		log.debug("boardInsert boardNo : {} " , result);

		return "redirect:/board/boardList?boardClfcNo=BRDCL0003";
	}

	/**
	 * 글을 조회한다.
	 * 
	 * @param boardVO 조회할 정보가 담긴 BoardVO
	 * @param model
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 */
	@GetMapping("/boardDetail")
	public String boardDetail(@ModelAttribute BoardVO boardVO, Model model, RecordVO recordVO) {
		log.debug("boardDetailGet 시작 boardVO: " + boardVO);

		recordVO.setEtpId(boardVO.getBoardNo());
		this.recordService.setRecord(recordVO);
		
		boardVO = this.boardService.boardDetail(boardVO);
		log.debug("boardDetail boardVO : {} " , boardVO);
		int cmntCount = this.boardService.getCmntCount(boardVO.getBoardNo());
		
		model.addAttribute("cmntCount", cmntCount);
		model.addAttribute("boardVO", boardVO);
		
		return "board/boardDetail";
	}

	/**
	 * 글을 삭제한다.
	 * 
	 * @param boardVO 삭제할 정보가 담긴 BoardVO
	 * @param model
	 * @return "redirect:/boardList"
	 */
	@GetMapping("/boardDelete")
	public String boardDelete(@ModelAttribute BoardVO boardVO, Model model, Principal principal) {
		log.debug("boardDeleteGet 시작");
		if (principal == null) {
			return "redirect:/login";
		}

		this.boardService.boardDelete(boardVO);

		return "redirect:/board/boardList?boardClfcNo=BRDCL0003";
	}

	/**
	 * 글 수정화면을 조회한다.
	 * 
	 * @param boardVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "boardUpdate"
	 */
	@GetMapping("/boardUpdate")
	public String boardUpdateGet(@ModelAttribute BoardVO boardVO, Model model, Principal principal) {
		log.debug("boardUpdateGet 시작");
		if (principal == null) {
			return "redirect:/login";
		}

		boardVO = this.boardService.boardDetail(boardVO);
		model.addAttribute("boardVO", boardVO);
		log.debug("boardUpdate boardVO : {} " , boardVO);

		return "board/boardUpdate";
	}

	/**
	 * 글을 수정한다.
	 * 
	 * @param boardVO 수정할 정보가 담긴 BoardVO
	 * @param model
	 * @return "redirect:/boardDetail"
	 */
	@PostMapping("/boardUpdate")
	public String boardUpdate(@ModelAttribute BoardVO boardVO, Model mode) {
		log.debug("boardUpdatePost 시작");
		this.boardService.boardUpdate(boardVO);

		return "redirect:/board/boardDetail?boardNo=" + boardVO.getBoardNo();
	}

	/**
	 * 댓글을 등록한다.
	 * 
	 * @param commentVO 등록할 정보가 담긴 BoardCommentVO
	 * @param model
	 * @return "redirect:/boardDetail"
	 */
	@PostMapping("/boardCommentInsert")
	public String boardCommentInsert(@ModelAttribute BoardCommentVO commentVO, Model model, Principal principal) {
		log.debug("boardCommentInsertPost 시작");
		if (principal == null) {
			return "redirect:/login";
		}

		boardService.boardCommentInsert(commentVO);

		return "redirect:/board/boardDetail?boardNo=" + commentVO.getBoardNo();
	}

	/**
	 * 댓글을 삭제한다.
	 * 
	 * @param commentVO 삭제할 정보가 담긴 BoardCommentVO
	 * @param model
	 * @return "redirect:/boardDetail"
	 */
	@GetMapping("/boardCommentDelete")
	public String boardCommentDelete(@ModelAttribute BoardCommentVO commentVO, Model model, Principal principal) {
		log.debug("boardCommentDeleteGet 시작");
		if (principal == null) {
			return "redirect:/login";
		}
		
		String boardNo = commentVO.getBoardNo();
		log.debug("commentVO : {} " , commentVO);
		
		this.boardService.boardCommentDelete(commentVO);

		return "redirect:/board/boardDetail?boardNo=" + boardNo;
	}

	/**
	 * 댓글을 수정한다.
	 * 
	 * @param commentVO 수정할 정보가 담긴 BoardCommentVO
	 * @param model
	 * @return "redirect:/boardDetail"
	 */
	@PostMapping("/boardCommentUpdate")
	public String boardCommentUpdate(@ModelAttribute BoardCommentVO commentVO, Model mode, Principal principal) {
		log.debug("boardCommentUpdatePost 시작");
		if (principal == null) {
			return "redirect:/login";
		}
		
		this.boardService.boardCommentUpdate(commentVO);

		return "redirect:/board/boardDetail?boardNo=" + commentVO.getBoardNo();
	}


}
