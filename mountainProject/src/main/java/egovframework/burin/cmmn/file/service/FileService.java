package egovframework.burin.cmmn.file.service;

import java.io.IOException;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import egovframework.burin.cmmn.file.vo.FileVO;

public interface FileService {
	/**
	 * 파일과 확장자를 조회
	 * 
	 * @return
	 * @throws IOException 
	 */
	public ResponseEntity<byte[]> retrieveFile(String fileCode) throws IOException;
	
	/**
	 * 
	 * 파일을 등록
	 * 
	 * @param flVO
	 * @return
	 */
	public int createFile(FileVO flVO);
	
	/**
	 * 
	 * 파일업로드 모듈화
	 * 
	 * 업로드후 해당 파일코드를 얻기위해서 UUID로 변경된 fileName을 return 받아 넘김
	 * 
	 * @param fileData
	 * @param boardFilePath
	 * @return
	 * @throws IOException
	 */
	public String uploadFile(MultipartFile fileData, String boardFilePath) throws IOException;

	public String retrieveRecentFile(String savaNm);
}
