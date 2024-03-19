package egovframework.burin.cmmn.file.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.server.ResponseStatusException;

import egovframework.burin.cmmn.file.service.FileService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/files")
@Controller
public class FileController {
	
	@Autowired
	private FileService service;
	
	@GetMapping("profile.do")
    public ResponseEntity<byte[]> getProfile(@SessionAttribute("userId") String userId) {
        return getImage(userId);
    }
    @GetMapping("{userId}/profileImage.do")
    public ResponseEntity<byte[]> getProfileImage(@PathVariable String userId) {
    	log.info("야야ㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑㅑ:{}",userId);
    	return getImage(userId);
    }
    
    @GetMapping("board/{boardId}/image.do")
    public ResponseEntity<byte[]> getBoardImage(@PathVariable String boardId) {
        return getImage(boardId);
    }
    /**
     * 
     * 파일조회 모듈화
     * id를 넘기면 파일을 조회해옴
     * 
     * @param id
     * @return
     */
    private ResponseEntity<byte[]> getImage(String id) {
        try {
        	log.info("여긴오지?");
            return service.retrieveFile(id);
        } catch (IOException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "파일이 없습니다.", e);
        }
    }
}
