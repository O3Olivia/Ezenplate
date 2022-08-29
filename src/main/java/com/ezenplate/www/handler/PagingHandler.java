package com.ezenplate.www.handler;

import java.util.List;

import com.ezenplate.www.domain.CommentVO;
import com.ezenplate.www.domain.PagingVO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingHandler {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int totalCount;
	private PagingVO pgvo;
	private List<CommentVO> cmtList;
	
	
	public PagingHandler(PagingVO pgvo, int totalCount) {
		this.pgvo = pgvo;
		this.totalCount = totalCount;
		
		this.endPage = (int)(Math.ceil(pgvo.getPageNo() / (pgvo.getQty() *1.0))) * pgvo.getQty();
		this.startPage = endPage - 9;
		
		int realEndPage = (int)(Math.ceil((totalCount * 1.0) / pgvo.getQty()));
		if(realEndPage < this.endPage) {
			this.endPage = realEndPage;
		}
		this.prev = startPage > 1;
		this.next = endPage < realEndPage;
	}
	
	public PagingHandler(List<CommentVO> cmtList, PagingVO pgvo, int totalCount) {
		this(pgvo, totalCount);
		this.cmtList = cmtList;
	}
}
