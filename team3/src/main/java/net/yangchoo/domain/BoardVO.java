package net.yangchoo.domain;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private long price;
	private Integer category;
	private Date regdate;
	private Date updateDate;
	private double latitude;
	private double longitude;
	private float distance;
	private String detailaddr;
	
	private int replyCnt;
	
	private List<BoardAttachVO> attachList = new ArrayList<BoardAttachVO>();
	//new를 통해서 파일첨부 없이도 글작성 가능
}
