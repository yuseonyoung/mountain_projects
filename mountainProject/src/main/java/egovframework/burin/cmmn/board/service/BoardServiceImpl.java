package egovframework.burin.cmmn.board.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import egovframework.burin.cmmn.board.dao.BoardDao;
import egovframework.burin.cmmn.board.vo.BoardLikeVO;
import egovframework.burin.cmmn.board.vo.BoardVO;
import egovframework.burin.cmmn.board.vo.MapVO;
import egovframework.burin.cmmn.board.vo.MountainInfoVO;
import egovframework.burin.cmmn.board.vo.RecruitementVO;
import egovframework.burin.cmmn.board.vo.RecruitmentBoardVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDao boardDao;
	
	/**
	 * 
	 * scroll이벤트가 발생하면 parameter로 페이징될 게시물을 dao에 넘겨주어
	 * offset limit 쿼리문을 실행시켜 10개씩 데이터를 받아옴 
	 * 
	 */
	
	@Override
	public List<BoardVO> retrievePublicBoardList(int page) {
		//보여줄 게시물 수량
		int postPage = 10;
		//페이징된 게시물 
		int boardPage = postPage * page;
		log.info("boardPage :{}",boardPage);
		
		List<BoardVO> test = boardDao.selectPublicBoardList(boardPage);
		for(BoardVO vo : test) {
			log.info("vo데이터 뽑아보자 {}",vo);
		}
		
		return boardDao.selectPublicBoardList(boardPage);
	}
	
	/**
	 * 
	 * scroll이벤트가 발생하면 parameter로 페이징될 게시물을 dao에 넘겨주어
	 * offset limit 쿼리문을 실행시켜 10개씩 데이터를 받아옴 
	 * 
	 */
	@Override
	public List<BoardVO> retrievePartialBoardList(int page) {
		//보여줄 게시물 수량
		int postPage = 10;
		//페이징된 게시물 
		int boardPage = postPage * page;
		
		return boardDao.selectPartialBoardList(boardPage);
	}
	
	/**
	 * 좋아요가 눌렸을때 발생하는 비즈니스로직으로써 
	 * 첫번째로 boardId와 userId를 조회하여 존재 여부를 확인하고
	 * 존재하면 1을 반환받고 존재하지않으면 0을 반환받음
	 * 
	 *   1. 0을 반환시 : insert를 이용하여 좋아요에 등록함
	 *   2. 1을 반환시 : 테이블에서 제거하여 좋아요를 삭제함
	 * 
	 */
	@Override
	public String createBoardLike(BoardLikeVO blVO) {
	    String result = "";
	    log.info("여기오냐 : {}", blVO);
	    
	    try {
	        int statusValue = boardDao.selectBoardLikeList(blVO);
	        
	        if (statusValue == 0) {
	            int status = boardDao.insertBoardLike(blVO);
	            if (status > 0) {
	                result = "Like";
	            } else {
	                result ="LikeFail";
	            }
	        } else {
	            int status = boardDao.deleteBoardLike(blVO);
	            if (status > 0) {
	                result = "UnLike";
	            } else {
	                result = "UnLikeFail";
	            }
	        }
	        log.info("정보3 : {}", result);
	    } catch (Exception e) {
	        log.error("createBoardLike 메서드에서 예외 발생:", e);
	        result = "error"; 
	    }
	    
	    return result;
	}
	
	/**
	 * 
	 * boardId를 파라미터로 넘겨주어 boardlike 테이블에 해당하는 좋아요의 수를 구한뒤 return
	 * 
	 */
	@Override
	public int retrieveBoardLikeBoardCount(BoardLikeVO blVO) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardLikeBoardCount(blVO);
	}

	@Override
	public List<BoardLikeVO> retrieveBoardLikeUserCount(BoardLikeVO blVO) {
		// TODO Auto-generated method stub
		return boardDao.selectBoardLikeUserCount(blVO);
	}

	@Override
	public int createPublicBoard(BoardVO boardVO) {
		// TODO Auto-generated method stub
		return boardDao.insertPublicBoard(boardVO);
	}

	@Override
	public List<RecruitmentBoardVO> retrieveRecruitmentBoardList(RecruitmentBoardVO rBoardVO) {
		// TODO Auto-generated method stub
		log.info("버바나");
		return boardDao.selectRecruitmentBoardList(rBoardVO);
	}
	
	
	@Override
	public List<MapVO> retrieveMapData() {
		// TODO Auto-generated method stub
		return boardDao.selectMapData();
	}

	@Override
	public List<MountainInfoVO> retrieveMountainInfo(String name) {
		// TODO Auto-generated method stub
		return boardDao.selectMountainInfo(name);
	}

	@Override
	public int createRboard(BoardVO boardVO, RecruitmentBoardVO rBoardVO) {
		// TODO Auto-generated method stub
		
		log.info("여긴오니1");	
		try {
			int cnt = boardDao.insertRboard(boardVO);
			log.info("boardVO의 ㄱ값을 보자 : {}",boardVO);	
			if(cnt>0) {
				log.info("여긴오니2");	
				rBoardVO.setBoardId(boardVO.getBoardId());
				log.info("여긴오니3");	
				return boardDao.insertRboardDetail(rBoardVO);
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public List<Map<String, Object>> retrieveRboardDetail(String boardId) {
		// TODO Auto-generated method stub
		return boardDao.selectRboardDetail(boardId);
	}

	@Override
	public int createRecruitment(RecruitementVO recVO) {
		return boardDao.insertRecruitment(recVO);
	}

	@Override
	public int modifyStatus(String boardId) {
		// TODO Auto-generated method stub
		return boardDao.updateStatus(boardId);
	}

	@Override
	public int retrieveParticipation(RecruitementVO recVO) {
		// TODO Auto-generated method stub
		return boardDao.selectParticipation(recVO);
	}
	
	
}
