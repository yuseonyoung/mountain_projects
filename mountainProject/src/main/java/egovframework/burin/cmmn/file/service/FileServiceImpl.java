package egovframework.burin.cmmn.file.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.burin.cmmn.board.dao.BoardDao;
import egovframework.burin.cmmn.file.dao.FileDao;
import egovframework.burin.cmmn.file.vo.FileVO;
import egovframework.burin.cmmn.user.dao.UserDao;
import egovframework.burin.cmmn.user.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileServiceImpl implements FileService {
	
	@Inject
	private FileDao fileDao;
	
	@Inject
	private UserDao userDao;
	@Inject
	private BoardDao boardDao;
	
	private UserVO userVO;

	
	
	@Override
	public ResponseEntity<byte[]> retrieveFile(String fileId) throws IOException {
	    String fileCode = "";
	    // user는 길이 9자리 고정
	    if (fileId.length() == 9) {
	        userVO = userDao.userDetail(fileId);
	        fileCode = userVO.getFileCode();
	    // board는 9번째 자리에 B가 고유 문자로 들어가있음	
	    } else if (fileId.charAt(8) == 'B') {
	        fileCode = boardDao.selectBoardFileCode(fileId);
	        log.info("fileCode: {}", fileCode);
	    }

	    FileVO fileVo = fileDao.selectFile(fileCode);
	    log.info("fileVO: {}", fileVo);

	    String fileName = fileVo.getSaveNm();
	    String fileDir = fileVo.getPath();

	    Path filePath = Paths.get(fileDir, fileName);
	    log.info("filePath: {}", filePath);
	    //btye로 변환된 이미지
	    byte[] fileBytes = Files.readAllBytes(filePath);

	    //확장자명을 통해 mediaType을 반환하는 메서드
	    MediaType mediaType = determineMediaType(fileVo.getFileExtension());

	    //response를 200 상태코드로 보내고 body에 file을 담아 전송 
	    return ResponseEntity.ok()
	            .contentType(mediaType)
	            .body(fileBytes);
	}
	 //확장자명에 따른 MediaType 결정
    //굳이 안해도 되는데 수신자가 보고 확장자명을 알 수 있게끔 보냄 
    private MediaType determineMediaType(String fileExtension) {
        switch (fileExtension.toLowerCase()) {
            case "jpg":
            case "jpeg":
                return MediaType.IMAGE_JPEG;
            case "png":
                return MediaType.IMAGE_PNG;
            case "gif":
                return MediaType.IMAGE_GIF;
            default:
                return MediaType.APPLICATION_OCTET_STREAM;
        }
    }



	@Override
	public int createFile(FileVO flVO) {
		
		return fileDao.insertFile(flVO);
	}
	
	
	@Override
    public String uploadFile(MultipartFile fileData, String filePath) throws IOException {
		
		log.info("테스트1");
		
        // 확장자까지 붙은 파일 이름
        String originalFilename = fileData.getOriginalFilename();
        // 파일 이름에서 확장자 추출
        String extension = "";
        // 확장자를 분리한 파일 이름
        int lastIndex = originalFilename.lastIndexOf(".");
        if (lastIndex >= 0) {
            // 확장자만 분리 [ .빼고 뒤의 이름만 가져옴 ]
            extension = originalFilename.substring(lastIndex + 1);
        }
        log.info("originalFilename : {}", originalFilename);
        // UUID가 적용된 fileName
        String newFilename = UUID.randomUUID().toString();

        // 파일 사이즈
        long fileSize = fileData.getSize();
        log.info("파일 사이즈: {} bytes", fileSize);

        // fileVO에 전부 set
        FileVO flVO = new FileVO();
        flVO.setOriginNm(originalFilename);
        flVO.setPath(filePath);
        flVO.setSaveNm(newFilename);
        flVO.setSize(fileSize);
        flVO.setFileExtension(extension);

        // Model layer에 값을 전달하여 DB에 insert
        int result = createFile(flVO);

        if (result > 0) {
            // 파일 저장 경로와 저장될 이름 설정
            String toalFilePath = filePath + newFilename;
            // 파일을 경로에 저장
            fileData.transferTo(new File(toalFilePath));
            return newFilename;
        }else {
        	return "";
        }
    }

	@Override
	public String retrieveRecentFile(String saveNm) {
		// TODO Auto-generated method stub
		return fileDao.selectRecnetFileCode(saveNm);
	}
}
