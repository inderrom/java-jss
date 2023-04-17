package kr.or.ddit.board.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.BoardCommentVO;
import kr.or.ddit.vo.BoardVO;

public interface BoardMapper {

	/*
	 * alt + shift + j
	 */

	/**
	 * 글 목록을 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return 글 목록
	 */
	List<BoardVO> boardList(Map<String, Object> map);

	/** 
	 * 글 총 갯수를 조회한다.
	 * 
	 * @param map - 조회할 정보가 담긴 map
	 * @return 글 총 갯수
	 */
	int getTotal(Map<String, Object> map);

	/**
	 * 글을 등록한다.
	 * 
	 * @param boardVO 등록할 정보가 담긴 BoardVO
	 * @return 등록 후 글번호
	 */
	int boardInsert(BoardVO boardVO);

	/**
	 * 글을 조회한다.
	 * 
	 * @param boardVO 조회할 정보가 담긴 BoardVO
	 * @return 조회한 글
	 */
	BoardVO boardDetail(BoardVO boardVO);

	/**
	 * 글을 삭제한다.
	 * 
	 * @param boardVO 삭제할 정보가 담긴 BoardVO
	 * @return void형
	 */
	void boardDelete(BoardVO boardVO);

	/**
	 * 글을 수정한다.
	 * 
	 * @param boardVO 수정할 정보가 담긴 BoardVO
	 * @return void형
	 */
	void boardUpdate(BoardVO boardVO);

	/**
	 * 댓글을 등록한다.
	 * 
	 * @param commentVO 등록할 정보가 담긴 BoardCommentVO
	 * @return void형
	 */
	void boardCommentInsert(BoardCommentVO commentVO);

	/**
	 * 댓글을 삭제한다.
	 * 
	 * @param commentVO 삭제할 정보가 담긴 BoardCommentVO
	 * @return void형
	 */
	void boardCommentDelete(BoardCommentVO commentVO);

	/**
	 * 댓글을 수정한다.
	 * 
	 * @param commentVO 수정할 정보가 담긴 BoardCommentVO
	 * @return void형
	 */
	void boardCommentUpdate(BoardCommentVO commentVO);
	
	/**
	 * 댓글을 총 갯수를 조회한다.
	 * 
	 * @param boardNo 조회할 정보가 담긴 boardNo
	 * @return 댓글 총 갯수
	 */
	int getCmntCount(String boardNo);

	/**
	 * 사용자의 총 경력을 조회한다
	 * 
	 * @param memId 조회할 사용자의 아이디
	 * @return 연차
	 */
	int getCrrList(String memId);

}
