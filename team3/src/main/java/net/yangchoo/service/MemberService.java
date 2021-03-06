package net.yangchoo.service;

import org.springframework.stereotype.Service;

import net.yangchoo.domain.MemberVO;


@Service
public interface MemberService {

	// 회원 가입
	public int register(MemberVO memberVO) throws Exception; 
	
	MemberVO read(String userEmail);
	
	// 회원 수정
	public int memberModify(MemberVO memberVO) throws Exception;
	
	//oauth 로그인
	MemberVO oauthLogin(String oauthid);
	
	//oauth 등록
	public void oauthJoin(MemberVO memberVO);
	
	public void memberRemove(MemberVO memberVO);
}
