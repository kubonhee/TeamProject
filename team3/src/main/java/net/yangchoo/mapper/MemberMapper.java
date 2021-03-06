package net.yangchoo.mapper;

import org.apache.ibatis.annotations.Select;

import net.yangchoo.domain.AuthVO;
import net.yangchoo.domain.MemberVO;

public interface MemberMapper {
	@Select("SELECT SYSDATE FROM DUAL")
	String testTime();
	
	// 회원가입
	void register(MemberVO memberVO);
	
	// 권한
	void insertAuth(AuthVO authVO);
	
	MemberVO read(String username);
	
	void memberModify(MemberVO memberVO);
	
	MemberVO oauthLogin(String oauthid);
	
	void oauthJoin(MemberVO memberVO);
	
	void memberRemove(MemberVO memberVO);
}
