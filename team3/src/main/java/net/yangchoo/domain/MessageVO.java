package net.yangchoo.domain;

import java.util.Set;
import java.util.TreeSet;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class MessageVO {
	private String fromId;
	private String toId;
	private String content;
	
	private Set<String> loginUser = new TreeSet<>();
	
	public void addLoginUser(String user) {
		loginUser.add(user);
	}
	
	public void removeLoginUser(String user) {
		loginUser.remove(user);
	}
	
	
	
}
