package egovframework.burin.cmmn.file.dao;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.burin.cmmn.file.vo.FileVO;

@Mapper
public interface FileDao {
	
	public FileVO selectFile(String fileCode);
	
	public int insertFile(FileVO flVO);

	public String selectRecnetFileCode(String saveNm);
}
