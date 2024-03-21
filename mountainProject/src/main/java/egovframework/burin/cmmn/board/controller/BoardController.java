package egovframework.burin.cmmn.board.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import egovframework.burin.cmmn.board.dao.BoardDao;
import egovframework.burin.cmmn.board.service.BoardService;
import egovframework.burin.cmmn.board.vo.BoardLikeVO;
import egovframework.burin.cmmn.board.vo.BoardVO;
import egovframework.burin.cmmn.board.vo.MapVO;
import egovframework.burin.cmmn.board.vo.MountainInfoVO;
import egovframework.burin.cmmn.board.vo.RecruitementVO;
import egovframework.burin.cmmn.board.vo.RecruitmentBoardVO;
import egovframework.burin.cmmn.board.vo.TotalBoardVO;
import egovframework.burin.cmmn.file.service.FileService;
import egovframework.burin.cmmn.file.vo.FileVO;
import lombok.extern.slf4j.Slf4j;

@PropertySource("classpath:properties/onepass.properties")
@Slf4j
@RequestMapping("/board")
@Controller
public class BoardController {
	
	@Inject
	private BoardService service;
	
	@Inject
	private FileService fileService;
	
	@Inject
	private BoardDao boardDao;
	
	
	@ModelAttribute("totBoard")
	public TotalBoardVO totalBoardVO() {
		  return new TotalBoardVO();
	} 
	@ModelAttribute("updateBoard")
	public TotalBoardVO updateBoardVO() {
		return new TotalBoardVO();
	} 
	
	BoardVO boardVO = new BoardVO();
	BoardLikeVO blVO = new BoardLikeVO();
	FileVO flVO = new FileVO();
	RecruitmentBoardVO rBoardVO = new RecruitmentBoardVO();
	RecruitementVO recVO = new RecruitementVO();
	
	
	@Value("${boardFilePath}")
	private String boardFilePath;
	
	@GetMapping("/publicView.do")
	public String publicBoardView(Model model) {
		model.addAttribute("selectBoard", "public");
		return "publicBoard/publicBoard";
	}
	
	@GetMapping("/partialView.do")
	public String partialBoardView(Model model) {
		model.addAttribute("selectBoard", "partial");
		return "publicBoard/publicBoard";
	}
	

	
	
	/**
	 * 
	 * 전체에게 공개하는 전체공개 게시물 조회
	 * 
	 * 스크롤 이벤트를 통하여 page를 전달받아 10개씩 다음 자료를 조회하여 넘겨줌 
	 * 
	 * @param page
	 * @param model
	 * @return
	 */
	@GetMapping("/main.do")
	public String publicBoardRetrieve(@RequestParam int page, Model model, HttpSession session){
		//session에서 user_id를 가져옴
		String userId = (String)session.getAttribute("userId");
		blVO.setUserId(userId);
		
		//10개씩 자료 boardList조회
		List<BoardVO> list = service.retrievePublicBoardList(page);
		//user가 좋아요를 누른 board의 목록 조회
		List<BoardLikeVO> boardLikeList = service.retrieveBoardLikeUserCount(blVO);
		
		log.info("@@@@@@@@@@@@@@@@@@@@@ : {}",list.size());
		log.info("@@@@@@@@@@@@@@@@@@@@@page : {}",page);
		
		model.addAttribute("PublicBoardList", list);
		model.addAttribute("boardLikeList", boardLikeList);
		
		return "jsonView";
	}	
	
	/**
	 * 
	 * 친구에게만 공유하는 게시물 조회
	 * 
	 * @param page
	 * @param model
	 * @return
	 */
	@GetMapping("/partialList.do")
	public String partialBoardRetrieve(@RequestParam int page, Model model, HttpSession session){
		
		//session에서 user_id를 가져옴
		String userId = (String)session.getAttribute("userId");
		blVO.setUserId(userId);
		log.info(" ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ");
		//10개씩 자료 boardList조회
		List<BoardVO> list = service.retrievePartialBoardList(page);
		//user가 좋아요를 누른 board의 목록 조회
		List<BoardLikeVO> boardLikeList = service.retrieveBoardLikeUserCount(blVO);
		
		model.addAttribute("PartialBoardList", list);
		model.addAttribute("boardLikeList", boardLikeList);
		
		return "jsonView";
	}	
	
	/**
	 * 
	 * boardLike 좋아요 등록 / 기존에 좋아요가 눌려있다면 삭제
	 * 
	 * @param page
	 * @param model
	 * @return
	 */
	
	@PostMapping("/likeInsert.do")
	public String boardLikeCreate(@RequestBody String jsonData, Model model, HttpSession session){
	        
			try {
				// URL 디코딩 수행
				String decodedJsonData = URLDecoder.decode(jsonData, "UTF-8");
				
				//언마샬링
				JSONObject jsonObject = new JSONObject(decodedJsonData);
				
				if(jsonData == null) {
					model.addAttribute("fail", "정보에 문제가 발생하였습니다.");
				}
				//boardId 추출
				String boardId = jsonObject.getString("boardId");
				//session에서 받아온 userId 추출
				String userId = (String)session.getAttribute("userId");
				
				//vo세팅
				blVO.setBoardId(boardId);
				blVO.setUserId(userId);
				
				//결과값 호출
				String result = service.createBoardLike(blVO);
				
				log.info("result :{}",result);
				
				if(result.equals("Like")) {
					model.addAttribute("Like", "빨간하트");
				}else if(result.equals("UnLike")){
					model.addAttribute("UnLike","회색하트");
				}else if(result.equals("UnLikeFail")){
					model.addAttribute("UnLikeFail","삭제실패");
				}else if(result.equals("LikeFail")){
					model.addAttribute("LikeFail","등록실패");
				}else {
					model.addAttribute("fail","서버 오류 입니다.");
				}
				
				int likeQty = service.retrieveBoardLikeBoardCount(blVO);
				model.addAttribute("likeQty", likeQty);
			
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		
			return "jsonView";
	}
	/**
	 * 
	 * 게시물을 insert하는 작업
	 * 
	 * @param model
	 * @param session
	 * @param ctnt
	 * @param scope
	 * @param fileData
	 * @return
	 */
	@PostMapping("/publicInsert.do")
	public String boardCreate(Model model,
									HttpSession session,
	                                @RequestParam("ctnt") String ctnt,
	                                @RequestParam("scope") String scope,
	                                @RequestParam("file") MultipartFile fileData
									){
	    
	    log.info("데이터야 : {}", fileData.getOriginalFilename());
	    log.info("나에게로 : {}", ctnt);
	    log.info("와라~~ : {}", boardFilePath);

	    try {
	    	log.info("테스트2");
	        // 서비스 레이어로 파일 업로드를 위한 데이터 전달
	        String result = fileService.uploadFile(fileData, boardFilePath);
	        if(StringUtils.isNotEmpty(result)){
	        	String fileCode = fileService.retrieveRecentFile(result);
	        	String userId = (String)session.getAttribute("userId");
	        	
	        	log.info("fileCode : {}",fileCode);
	        	
	        	boardVO.setFileCode(fileCode);
	        	boardVO.setCtnt(ctnt);
	        	boardVO.setUserId(userId);
	        	boardVO.setScope(scope);
	        	
	        	int cnt = service.createPublicBoard(boardVO);
	        	
	        	if(cnt>0) {
	        		model.addAttribute("success", "success");
	        	}else {
	        		model.addAttribute("fail", "fail");
	        	}
	        }else{
	        	model.addAttribute("fail", "fail");
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    return "jsonView";
	}
	
	@GetMapping("rBoardList.do")
	public String rBoardRetrieve(Model model, @RequestParam(value="pageNo",required=false, defaultValue="1") int pageNo){
		log.info("여기오니");
		
		log.info("pageNo{}",pageNo);
		
		RecruitmentBoardVO rBoardVO = new RecruitmentBoardVO();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		//현재 페이지 번호
		paginationInfo.setCurrentPageNo(pageNo);
		//한 페이지에 게시되는 게시물 갯수
		paginationInfo.setRecordCountPerPage(10);
		//페이징 리스트의 사이즈
		paginationInfo.setPageSize(8);
		
		//첫번째 패이지의 인덱스
		int firstRecordIndex = paginationInfo.getFirstRecordIndex();
		//한 페이지에 게시되는 게시물 갯수
		int recordCountPerPage = paginationInfo.getRecordCountPerPage();
		
		rBoardVO.setFirstIndex(firstRecordIndex);
		rBoardVO.setRecordCountPerPage(recordCountPerPage);
		
		int totalCount = boardDao.rBoardCount();
		
		//전체 게시물 갯수
		paginationInfo.setTotalRecordCount(totalCount);
		
		List<RecruitmentBoardVO> RBoardList =service.retrieveRecruitmentBoardList(rBoardVO);
		int recCount = 0;
		int recQty = 0;
		int cnt =0;
		int result = 0;
		log.info("RBoardList:{}",RBoardList);
		for(RecruitmentBoardVO list : RBoardList) {
			BoardVO vo = list.getBoardVO();
			log.info("{}",vo);
			log.info("야ㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑ{}",list);
			log.info("{}",vo.getCdate());
			recCount = list.getRecCount();
			recQty = list.getRecQty();
			result = recQty - recCount;
			
			log.info("skdhkdkdhdkhdkdhkdhk{}",result);
			if(result == 0 ) {
				if(list.getDeadlineStatus().equals("N")) {
					cnt = service.modifyStatus(list.getBoardId());
					if(cnt>0) {
						log.info("업데이트 됏니?????????????????????");
						model.addAttribute("updateSuccess", "updateSuccess");
					}else {
						model.addAttribute("updateFail", "updateFail");
					}
				}
			}
		}
		model.addAttribute("RBoardList", RBoardList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "rBoard/rBoard";
	}
	
	
	@GetMapping("mapList.do")
	public String mapRetrieve(Model model) {
		
		List<MapVO> mapList =  service.retrieveMapData();
		
		model.addAttribute("mapList", mapList);
		
		return "jsonView";
	}
	
	@GetMapping("{name}/searchArea.do")
	public String searchAreaList(@PathVariable String name, Model model) {
		name = name.replace("NaN", "");
		log.info("mountain_name : {}",name);
		
		List<MountainInfoVO> mountainInfoList =  service.retrieveMountainInfo(name);
		
		model.addAttribute("mountainInfoList", mountainInfoList);
		
		return "jsonView";
	}
	
	@PostMapping("rBoardInsert.do")
	public String createRBoard(Model model, HttpSession session
	                            ,@Valid @ModelAttribute("totBoard")TotalBoardVO totalBoardVO
	                            ,BindingResult bindingResult
	                          ) {
		//유효성 검증을통해 에러가 있는지 판단
	    if(!bindingResult.hasErrors()) {
	        
	        MultipartFile fileData = totalBoardVO.getFileCode();
	        log.info("rboardFile : {}", fileData.getOriginalFilename());
	        log.info("boardFile 경로 : {}", boardFilePath);
	        
	        try {
	            log.info("들어오는지 테스트");
	            // 서비스 레이어로 파일 업로드를 위한 데이터 전달
	            String result = fileService.uploadFile(fileData, boardFilePath);
	            
	            if(StringUtils.isNotEmpty(result)){
	                String fileCode = fileService.retrieveRecentFile(result);
	                String userId = (String)session.getAttribute("userId");
	                
	                //제목
	                rBoardVO.setBoardTitle(totalBoardVO.getBoardTitle());
	                //참여인원
	                rBoardVO.setRecQty(totalBoardVO.getRecQty());
	                //참여금액
	                rBoardVO.setParticipationPee(totalBoardVO.getParticipationPee());
	                //산이름
	                rBoardVO.setMntnNm(totalBoardVO.getMntnNm());
	                
	                
	                
	                //모집날짜
	                boardVO.setCdate(totalBoardVO.getCdate());
	                //내용
	                boardVO.setCtnt(totalBoardVO.getCtnt());
	                //작성자
	                boardVO.setUserId(userId);
	                //파일코드
	                boardVO.setFileCode(fileCode);
	                log.info("fileCode : {}",fileCode);
	                log.info("boardVO : {}",boardVO);
	                log.info("rBoardVO : {}",rBoardVO);
	                
	                int cnt = service.createRboard(boardVO, rBoardVO);
	                
	                if(cnt>0) {
	                    model.addAttribute("success", "success");
	                }else {
	                    model.addAttribute("fail", "fail");
	                }
	            }else{
	                model.addAttribute("fail", "fail");
	            }
	            
	        }catch (IOException e) {
	            e.printStackTrace();
	        }
	    }else {
	        Map<String, Object> errorMap = new HashMap<>();
	        for (FieldError error : bindingResult.getFieldErrors()) {
	            String fieldName = error.getField();
	            String errorMessage = error.getDefaultMessage();
	            
	            if ("totBoard".equals(error.getObjectName()) && fieldName.startsWith("totBoard.")) {
	                fieldName = fieldName.substring("totBoard.".length());
	            }
	            
	            errorMap.put(fieldName, errorMessage);
	        }

	        log.info("error:@@@@@@@@{}",errorMap);
	        model.addAttribute("errors", errorMap);
	    }
	    return "jsonView";
	}

	
	@GetMapping("{boardId}/rBoardDetail.do")
	public String rBoardDetail(@PathVariable String boardId, Model model) {
			boardId = boardId.replace("NaN", "");
			log.info("boardId : {}",boardId);
			
			List<Map<String,Object>> rBoardDetail = service.retrieveRboardDetail(boardId);
			if(rBoardDetail.size()>0){
				
				model.addAttribute("rBoardDetail", rBoardDetail);
			}else {
				model.addAttribute("fail", "fail");
			}
			
			return "jsonView";
		}

	@PostMapping("/recruitment.do")
	public String recruitment(@RequestParam String boardId,Model model, HttpSession session){
		
		String userId = (String)session.getAttribute("userId");
		
		recVO.setBoardId(boardId);
		recVO.setUserId(userId);
		
		log.info("recririruriur: {}",boardId);
		log.info("recririruriur: {}",userId);
		
		int result = service.retrieveParticipation(recVO);
		if(result<=0) {
			int cnt = service.createRecruitment(recVO);
			
			if(cnt>0) {
				log.info("너냐1");
				model.addAttribute("success", "success");
			}else {
				log.info("너냐2");
				model.addAttribute("fali", "fali");
			}
		}else {
			model.addAttribute("duplicated", "duplicated");
		}
		return "jsonView";
	}
	
	@RequestMapping(value = "/rBoardUpdate.do", method = RequestMethod.POST)
	public String updateBoard(@ModelAttribute("updateBoard") TotalBoardVO totalBoardVO, Model model, HttpSession session){
		
		log.info("totalBoardVO : {},",totalBoardVO);
		
		try {
			MultipartFile fileData = totalBoardVO.getFileCode();
			String result ="";
			String fileCode ="";
			
			if (fileData != null && !fileData.isEmpty() && fileData.getSize() > 0) {
				result = fileService.uploadFile(fileData, boardFilePath);
			}
			
		
		    if(StringUtils.isNotEmpty(result)){
		    	fileCode = fileService.retrieveRecentFile(result);
		    }else {
		    	fileCode = service.retrieveBoardFileCode(totalBoardVO.getBoardId());
		    }     
		    
            String userId = (String)session.getAttribute("userId");
            
            //제목
            rBoardVO.setBoardTitle(totalBoardVO.getBoardTitle());
            //참여인원
            rBoardVO.setRecQty(totalBoardVO.getRecQty());
            //참여금액
            rBoardVO.setParticipationPee(totalBoardVO.getParticipationPee());
            //산이름
            rBoardVO.setMntnNm(totalBoardVO.getMntnNm());

            rBoardVO.setBoardId(totalBoardVO.getBoardId());
            //boardId
            boardVO.setBoardId(totalBoardVO.getBoardId());
            
            //모집날짜
            boardVO.setCdate(totalBoardVO.getCdate());
            //내용
            boardVO.setCtnt(totalBoardVO.getCtnt());
            //작성자
            boardVO.setUserId(userId);
            //파일코드
            boardVO.setFileCode(fileCode);

            int cnt = service.modifyRBoard(boardVO, rBoardVO);
            
            if(cnt>0) {
                model.addAttribute("success", "success");
            }else {
                model.addAttribute("fail", "fail");
            }
			  
	                
	                
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "jsonView";
	}
	
}

