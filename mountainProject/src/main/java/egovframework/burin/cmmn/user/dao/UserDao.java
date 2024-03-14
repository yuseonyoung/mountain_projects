package egovframework.burin.cmmn.user.dao;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.burin.cmmn.user.vo.UserVO;

@Mapper
public interface UserDao {
	
	/**
	 * 
	 * 회원의 전체정보를 조회
	 * 
	 * @return
	 */
	public List<UserVO> userList();

	/**
	 * 
	 * 유저의 상세정보를 조회
	 * 
	 * @param userId
	 * @return
	 */
	public UserVO userDetail(String userId);

}
