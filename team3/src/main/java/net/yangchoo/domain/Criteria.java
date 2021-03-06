package net.yangchoo.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Criteria {
	private double latitude;
	private double longitude;
	private float distance;
	private Integer pageNum = 1;
	private Integer amount = 18;
	
	private String type;
	private String keyword;
	
	private Integer cate; 
	
	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	
	}
	public String[] getTypeArr(){
		return type == null ?new String[]{} : type.split("");
		//"ABCD".split("");
		//{"","","",""}
		
	}
	public String getListLink(){
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", pageNum)
				.queryParam("amount", amount)
				.queryParam("type", type)
				.queryParam("keyword", keyword)
				.queryParam("cate", cate);
		return builder.toUriString();
	}
	
	public String getListLink2(){
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("amount", amount)
				.queryParam("type", type)
				.queryParam("keyword", keyword)
				.queryParam("cate", cate);
		return builder.toUriString();
	}
	public String getListLink3(){
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", pageNum)
				.queryParam("type", type)
				.queryParam("keyword", keyword)
				.queryParam("cate", cate);
		return builder.toUriString();
	}
}
