package egovframework.burin.cmmn.user.service;

import java.util.List;

import egovframework.burin.cmmn.user.vo.UserVO;

public interface UserService {
	
	/**
	 * 회원의 전체정보를 조회
	 * 
	 * @return
	 */
	
	public List<UserVO> retrieveUserList();
	
	/**
	 * 
	 * 회원의 상세정보를 조회
	 * 
	 * @param userId
	 * @return
	 */
	public UserVO retrieveUserDetail(UserVO userVO);
}
