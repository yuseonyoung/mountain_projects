package egovframework.burin.cmmn.login.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.burin.cmmn.user.service.UserService;
import egovframework.burin.cmmn.user.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/login.do")
@Controller
public class LoginController {
	
	@Inject
	private UserService service;
	
	private UserVO userData;
	
	@GetMapping
	public String loginForm(HttpSession session) {
		session.removeAttribute("userId");
		session.removeAttribute("userNm");
		log.info("오긴하지");
		return "login/loginForm";
	}
	
	@PostMapping
	public String loginTry(@Valid @ModelAttribute UserVO userVO,Errors errors, Model model
			,HttpSession session,HttpServletRequest request){
		boolean isValid = false;
		
		String path = request.getContextPath();
		
		StringBuffer redirectPath = new StringBuffer();
		
		redirectPath.append("redirect:").append(path);

		try {
		    userData = service.retrieveUserDetail(userVO);
		    isValid = BCrypt.checkpw(userVO.getPwdno(), userData.getPwdno());
		    
		} catch (RuntimeException e) {
		    log.info("RuntimeException",e.getMessage());
		}

		if(isValid) {
		    session.setAttribute("userId", userData.getUserId());
		    session.setAttribute("userNM", userData.getName());
		    session.removeAttribute("failLogin");
		    redirectPath.append("/board/publicView.do");
		} else {
		    session.setAttribute("failLogin", "로그인정보가 불일치 합니다");
		    redirectPath.append("/login.do");
		}

		return redirectPath.toString(); 
	}
}
