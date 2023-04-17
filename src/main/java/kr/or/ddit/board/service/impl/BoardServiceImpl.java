package kr.or.ddit.board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.mapper.BoardMapper;
import kr.or.ddit.board.service.BoardService;
import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {

	private final BoardMapper boardMapper;

	@Autowired
	public BoardServiceImpl(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	/**
	 * 글 목록을 조회한다.
	 * 
	 * @param boardVO - 조회할 정보가 담긴 BoardVO
	 * @return 글 목록
	 */
	@Override
	public List<BoardVO> boardList(Map<String, Object> map) {
		return this.boardMapper.boardList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.boardMapper.getTotal(map);
	}

	/**
	 * 글을 등록한다.
	 * 
	 * @param boardVO 등록할 정보가 담긴 BoardVO
	 * @return 등록 후 글번호
	 */
	@Override
	public int boardInsert(BoardVO boardVO) {
		return this.boardMapper.boardInsert(boardVO);
	}

	/**
	 * 글을 조회한다.
	 * 
	 * @param boardVO 조회할 정보가 담긴 BoardVO
	 * @return 조회한 글
	 */
	@Override
	public BoardVO boardDetail(BoardVO boardVO) {
		return this.boardMapper.boardDetail(boardVO);
	}

	/**
	 * 글을 삭제한다.
	 * 
	 * @param boardVO 삭제할 정보가 담긴 BoardVO
	 * @return void형
	 */
	@Override
	public void boardDelete(BoardVO boardVO) {
		this.boardMapper.boardDelete(boardVO);
	}

	/**
	 * 글을 수정한다.
	 * 
	 * @param boardVO 수정할 정보가 담긴 BoardVO
	 * @return void형
	 */
	@Override
	public void boardUpdate(BoardVO boardVO) {
		this.boardMapper.boardUpdate(boardVO);
	}

	/**
	 * 댓글을 등록한다.
	 * 
	 * @param commentVO 등록할 정보가 담긴 BoardCommentVO
	 * @return void형
	 */
	@Override
	public void boardCommentInsert(BoardCommentVO commentVO) {
		this.boardMapper.boardCommentInsert(commentVO);
	}

	/**
	 * 댓글을 삭제한다.
	 * 
	 * @param commentVO 삭제할 정보가 담긴 BoardCommentVO
	 * @return void형
	 */
	@Override
	public void boardCommentDelete(BoardCommentVO commentVO) {
		this.boardMapper.boardCommentDelete(commentVO);

	}

	/**
	 * 댓글을 수정한다.
	 * 
	 * @param commentVO 수정할 정보가 담긴 BoardCommentVO
	 * @return void형
	 */
	@Override
	public void boardCommentUpdate(BoardCommentVO commentVO) {
		this.boardMapper.boardCommentUpdate(commentVO);

	}
	
	/**
	 * 댓글을 총 갯수를 조회한다.
	 * 
	 * @param boardNo 조회할 정보가 담긴 boardNo
	 * @return 댓글 총 갯수
	 */
	@Override
	public int getCmntCount(String boardNo) {
		return this.boardMapper.getCmntCount(boardNo);
	}

	/**
	 * 사용자의 총 경력을 조회한다
	 * 
	 * @param memId 조회할 사용자의 아이디
	 * @return 연차
	 */
	@Override
	public int getCrrList(String memId) {
		return this.boardMapper.getCrrList(memId);
	}

}
