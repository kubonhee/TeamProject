package net.yangchoo.domain;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private int realEnd;
	private boolean prev;
	private boolean next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total){
		this.cri = cri;
		this.total = total;
		//목록9개씩 해야해서 수정
		endPage = (cri.getPageNum() + 9) / 10 * 10;
		startPage = endPage - 9; 
		
		realEnd = (total + 17)/ 18; //맨 마지막 게시글까지 나오게 
		endPage = realEnd < endPage ? realEnd : endPage;
		
		prev = startPage > 1;
		next = endPage < realEnd;
		
		
	}
}
