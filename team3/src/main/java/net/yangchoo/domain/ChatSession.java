package net.yangchoo.domain;

import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component("cSession")
@Data
public class ChatSession {
	private Set<LoginUserDTO> loginUser = new HashSet<>();
	
	// 로그인 시 ArrayList에 추가
	public void addLoginUser(LoginUserDTO email) {
		loginUser.add(email);
	}
	
	// 로그아웃 시 ArrayList에서 제거
	public void removeLoginUser(LoginUserDTO email) {
		loginUser.remove(email);
	}
	
}
