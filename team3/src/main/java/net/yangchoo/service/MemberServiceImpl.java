package net.yangchoo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.yangchoo.domain.AuthVO;
import net.yangchoo.domain.MemberVO;
import net.yangchoo.mapper.AuthMapper;
import net.yangchoo.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	MemberMapper memberMapper;
	@Autowired @Qualifier("BCryptPasswordEncoder")
	private PasswordEncoder encoder;
	@Autowired
	AuthMapper authMapper;
	
	
/**
 * 구본희
 * 회원 가입
 * */
	@Transactional
	public int register(MemberVO memberVO) {
		try {
			AuthVO authVO = new AuthVO();
			authVO.setUserEmail(memberVO.getUserEmail());
			authVO.setUserAuth("ROLE_ADMIN");
			
			memberVO.setUserPw(encoder.encode(memberVO.getUserPw()));
			System.out.println(memberVO);
			memberMapper.register(memberVO);
			authMapper.authorization(authVO);
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("MemberService : 회원가입()"+e.getMessage());
		}
		return -1;
	}
	/** 구본희
	 * 
	 * */
	@Override
	public MemberVO read(String userEmail) {
		return memberMapper.read(userEmail);
	}
	/**구본희
	 * 회원 수정
	 * */
	public int memberModify(MemberVO memberVO){
		try {
			memberVO.setUserPw(encoder.encode(memberVO.getUserPw()));
			memberMapper.memberModify(memberVO);
			return 1;
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("MemberService : 회원 수정"+e.getMessage());
		}
		return -1;
	}
	
	/** 구본희
	 *  회원 삭제
	 * */
	public void memberRemove(MemberVO memberVO) {
		memberMapper.memberRemove(memberVO);
	}
	
	/*
	 *양수봉 oauthJoin 2021-06-07
	*/
	
	@Override
	public MemberVO oauthLogin(String oauthid) {
		return memberMapper.oauthLogin(oauthid);
	}
	
	/*
	 *양수봉 oauthJoin 2021-06-07
	*/
	@Override
	public void oauthJoin(MemberVO memberVO) {
		memberMapper.oauthJoin(memberVO);
	}
}
