package egovframework.burin.cmmn.main.controller;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class TestJava {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String password = "7487";
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		//비밀번호 암호화
		String encodedPwd = encoder.encode(password);
		
		System.out.println(encodedPwd);
		
		//암호화된 비밀번호 확인
		boolean isValid;
		
		isValid = BCrypt.checkpw("7487", encodedPwd);
		
		System.out.println(isValid);
	}
}