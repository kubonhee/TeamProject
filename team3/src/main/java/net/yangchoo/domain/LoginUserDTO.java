package net.yangchoo.domain;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Component
@Data
public class LoginUserDTO implements Comparable<LoginUserDTO> {
	private String userId;
	private Long time;
	
	@Override
	public int compareTo(LoginUserDTO o) {
		return (int)-(time - o.time);
	}
	
	@Override
	public boolean equals(Object obj) {
		return userId.equals(((LoginUserDTO)obj).userId);
	}
	
	@Override
	public int hashCode() {
		return userId.hashCode();
	}
}
