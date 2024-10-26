package egovframework.burin.cmmn.user.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import egovframework.burin.cmmn.user.service.UserService;
import egovframework.burin.cmmn.user.vo.UserVO;

@Controller
public class UserController {
	@Inject
	private UserService service;


	@GetMapping("/user/view.do")
	public String UserView() {
		return "user/userList";
	}
	
	
	@GetMapping("/user.do")
	public String UserList(ModelMap model) {
		List<UserVO> list = service.retrieveUserList();
		model.addAttribute("List", list);
		return "jsonView";
	}
	
}
