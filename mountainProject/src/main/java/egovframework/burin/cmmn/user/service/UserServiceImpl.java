package egovframework.burin.cmmn.user.service;


import java.util.List;

import javax.inject.Inject;

import org.antlr.grammar.v3.ANTLRParser.throwsSpec_return;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import egovframework.burin.cmmn.user.dao.UserDao;
import egovframework.burin.cmmn.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserDao dao;

	@Override
	public List<UserVO> retrieveUserList() {
		
		return dao.userList();
	}

	@Override
	public UserVO retrieveUserDetail(UserVO userVO) {
		
		String userId = userVO.getUserId();
		
		UserVO vo = dao.userDetail(userId);
		
		if (vo == null) {
		    throw new RuntimeException("등록된 정보가 없습니다.");
		}

		return vo;
	}
}
