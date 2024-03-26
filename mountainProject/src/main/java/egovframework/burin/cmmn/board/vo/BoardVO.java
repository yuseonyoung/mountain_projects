package egovframework.burin.cmmn.board.vo;

import java.util.List;

import org.springmodules.validation.bean.conf.loader.annotation.handler.NotBlank;

import egovframework.burin.cmmn.user.vo.UserVO;
import lombok.Data;

@Data
public class BoardVO {
	
	private String boardId;
    @NotBlank
	private String ctnt;
    //@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private String cdate;
    private String fileCode;
    private String scope;
    private String bDivision;
    @NotBlank
    private String userId;
    
    private int likeQty;
    private UserVO userDetail;
    private List<CommentVO> commentVOList;
    
    private int page;
    
}
