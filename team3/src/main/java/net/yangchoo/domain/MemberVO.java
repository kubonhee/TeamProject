package net.yangchoo.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String userEmail;
	private String userPw;
	private String userName;
	private String oauthid;
	
	private String postCode;
	private String roadAddress;
	private String jibunAddress;
	private String extraAddress;
	private double latitude;
	private double longitude;
	
	private String birthDate;
	
	private Date regDate;
	private Date updateDate;
	private boolean enabled;
	
	private String detailaddr;
	
	private List<AuthVO> authList;
	
}
