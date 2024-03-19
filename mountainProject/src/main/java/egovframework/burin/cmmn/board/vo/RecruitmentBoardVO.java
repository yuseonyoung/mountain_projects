package egovframework.burin.cmmn.board.vo;

import javax.validation.constraints.NotNull;

import org.springmodules.validation.bean.conf.loader.annotation.handler.NotBlank;

import lombok.Data;

@Data
public class RecruitmentBoardVO {
	@NotBlank
	private String boardId;
    
	private int inqireQty;
	@NotNull
	private int recQty;
	@NotBlank
	private String mntnNm;
	@NotNull
	private int participationPee;
	@NotBlank
	private String boardTitle;
    
	private String deadlineStatus;
    
    
    private BoardVO boardVO;
    private int rnum;
    
    //페이징시 필요한 변수
    private int firstIndex;
    private int recordCountPerPage;
    
    private int recCount;
}
