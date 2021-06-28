package net.yangchoo.domain;

import org.springframework.stereotype.Component;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Component
@NoArgsConstructor
public class LoginUser implements Comparable<LoginUser>{
	String username;
	long time;
	
	
	@Override
	public int compareTo(LoginUser o) {
		return (int)(time - o.time);
	}
	@Override
	public boolean equals(Object obj) {
		return username.equals(((LoginUser)obj).username);
	}
	@Override
	public String toString() {
		return new Gson().toJson(this);
	}
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		return username.compareTo(username);
	}
	
}
