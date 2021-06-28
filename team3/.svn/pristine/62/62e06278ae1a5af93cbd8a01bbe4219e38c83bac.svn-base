package net.yangchoo.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
	
	public String getDownPath() {
		return uploadPath + "/" +uuid+ "_" + fileName;
	}
	public String getThumbPath() {
		return uploadPath + "/s_" +uuid+ "_" + fileName;
	}
}
