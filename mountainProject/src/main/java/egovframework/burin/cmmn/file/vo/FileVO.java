package egovframework.burin.cmmn.file.vo;

import lombok.Data;

@Data
public class FileVO {
	
    private String fileCode;
    private String originNm;
    private String saveNm;
    private String path;
    private long size;
    private String fileExtension;
}
