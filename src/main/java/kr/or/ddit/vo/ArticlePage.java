package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ArticlePage<T> {
	private int total;
	private int currentPage;
	private int totalPages;
	private int startPage;
	private int endPage;
	private int blockSize;
	private List<T> content;

	public ArticlePage() {}
	
	// size : 한 화면에 보여질 행의 수
	public ArticlePage(int total, int currentPage, int size, List<T> content) {
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;

		if (total == 0) {// 전체 글 수가 0일 때
			totalPages = 0;
			startPage = 0;
			endPage = 0;
		} else {// 전체 글 수가 1 이상일 때
			totalPages = total / size;

			if (total % size > 0) {
				totalPages++;
			}

			startPage = currentPage / size * size + 1;

			if (currentPage % size == 0) {
				startPage -= size;
			}

			endPage = startPage + (size - 1);
			
			if (endPage > totalPages) {
				endPage = totalPages;
			}
		}
	}

	@Override
	public String toString() {
		return "ArticlePage [total=" + total + ", currentPage=" + currentPage + ", totalPages=" + totalPages
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", content=" + content + "]";
	}
}
