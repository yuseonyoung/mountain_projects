package egovframework.burin.cmmn.board.vo;

import egovframework.burin.cmmn.user.vo.UserVO;
import lombok.Data;

@Data
public class CommentVO {
	/**
	 * 이거 이름 다 바꿔 이름 곂쳐서 그냥 매핑이 아무거나돼고있어
	 */
	private String commId;
    private String contents;
    private String currentDate;
    //userId
    private String commentWriter;
    private String boardId;
    //user와 1:1 매핑
    private UserVO userVO;
}
