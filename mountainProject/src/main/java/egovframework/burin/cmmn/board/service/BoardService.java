package egovframework.burin.cmmn.board.service;

import java.util.List;
import java.util.Map;

import egovframework.burin.cmmn.board.vo.BoardLikeVO;
import egovframework.burin.cmmn.board.vo.BoardVO;
import egovframework.burin.cmmn.board.vo.MapVO;
import egovframework.burin.cmmn.board.vo.MountainInfoVO;
import egovframework.burin.cmmn.board.vo.RecruitementVO;
import egovframework.burin.cmmn.board.vo.RecruitmentBoardVO;

public interface BoardService {
	/**
	 * 
	 * 전체공개 게시물 list 조회
	 * 
	 * @return
	 */
	public List<BoardVO> retrievePublicBoardList(int page);
	
	
	/**
	 * 
	 * 전체공개 게시물 list 조회
	 * 
	 * @return
	 */
	public List<BoardVO> retrievePartialBoardList(int page);
	/**
	 * 
	 * 게시물의 좋아요를 누르면 boardLike에 board와 user_id를 insert해줌
	 * 
	 * @param blVO
	 * @return
	 */
	public String createBoardLike(BoardLikeVO blVO);
	
	/**
	 * 
	 * 해당 boardId가 가지고 있는 좋아요의 갯수를 알기위한 비즈니스 로직
	 * 
	 * @param blVO
	 * @return
	 */
	public int retrieveBoardLikeBoardCount(BoardLikeVO blVO);
	
	/**
	 * 
	 * 해당 user가 가지고 있는 좋아요를 알기위한 비즈니스 로직
	 * 
	 * @param blVO
	 * @return
	 */
	public List<BoardLikeVO> retrieveBoardLikeUserCount(BoardLikeVO blVO);
	
	/**
	 * 
	 * Board insert
	 * 
	 * @return
	 */
	public int createPublicBoard(BoardVO boardVO);
	
	
	/**
	 * 
	 * 모집 게시물 목록 조회
	 * 
	 * @return
	 */
	public List<RecruitmentBoardVO> retrieveRecruitmentBoardList(RecruitmentBoardVO rBoardVO);
	/**
	 * 
	 * 행정구역 시도 경계데이터 조회
	 * 
	 * @return
	 */
	public List<MapVO> retrieveMapData();
	
	/**
	 * 
	 * 100대 명산의 데이터를 조회
	 * 
	 */
	public List<MountainInfoVO> retrieveMountainInfo(String name);
	
	/**
	 * 
	 * RecruteBoard에 insert될 Board테이블의 데이터를 입력
	 * 
	 * @param boardVO
	 * @return
	 */
	public int createRboard(BoardVO boardVO, RecruitmentBoardVO rBoardVO);
	/**
	 * 
	 * rBoard id로 선택된 정보를 가져옴
	 * 
	 * @param boardId
	 * @return
	 */
	public List<Map<String, Object>> retrieveRboardDetail(String boardId);
	
	/**
	 * 
	 * 모임 참가하기
	 * 
	 * @param recVO
	 * @return
	 */
	public int createRecruitment(RecruitementVO recVO);
	
	/**
	 * 
	 * 모임 상태 변경
	 * 
	 * @return
	 */
	public int modifyStatus(String boardId);
	/**
	 * 
	 * 같은 게시물에 중복참여 여부검사
	 * 
	 * @param recVO
	 * @return
	 */
	public int retrieveParticipation(RecruitementVO recVO);
}
