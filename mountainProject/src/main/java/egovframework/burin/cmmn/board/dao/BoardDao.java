package egovframework.burin.cmmn.board.dao;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.burin.cmmn.board.vo.BoardLikeVO;
import egovframework.burin.cmmn.board.vo.BoardVO;
import egovframework.burin.cmmn.board.vo.MapVO;
import egovframework.burin.cmmn.board.vo.MountainInfoVO;
import egovframework.burin.cmmn.board.vo.RecruitementVO;
import egovframework.burin.cmmn.board.vo.RecruitmentBoardVO;

@Mapper
public interface BoardDao {
	
	public List<BoardVO> selectPublicBoardList(int page);
	
	public List<BoardVO> selectPartialBoardList(BoardVO boardVO);

	public int selectBoardLikeList(BoardLikeVO blVO);

	public int insertBoardLike(BoardLikeVO blVO);
	
	public int deleteBoardLike(BoardLikeVO blVO);
	
	public int selectBoardLikeBoardCount(BoardLikeVO blVO);

	public List<BoardLikeVO> selectBoardLikeUserCount(BoardLikeVO blVO);
	
	public String selectBoardFileCode(String boardId);
	
	public int insertPublicBoard(BoardVO boardVO);

	public List<RecruitmentBoardVO> selectRecruitmentBoardList(RecruitmentBoardVO rBoardVO);
	
	public int rBoardCount();

	public List<MapVO> selectMapData();
	
	public List<MountainInfoVO> selectMountainInfo(String name);
	
	public int insertRboard(BoardVO boardVO);
	
	public int insertRboardDetail(RecruitmentBoardVO rboardVO);
	
	public List<Map<String, Object>> selectRboardDetail(String boardId);
	
	public int insertRecruitment(RecruitementVO recVO);

	public int updateStatus(String boardId);
	
	public int selectParticipation(RecruitementVO recVO);

	public int updateBoard(BoardVO boardVO);
	
	public int updateRecruitementBoard(RecruitmentBoardVO rBoardVO);
}
