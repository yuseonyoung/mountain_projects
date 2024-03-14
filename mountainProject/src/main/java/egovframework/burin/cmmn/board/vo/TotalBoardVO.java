package egovframework.burin.cmmn.board.vo;


import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@EqualsAndHashCode(of = "boardId")
public class TotalBoardVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String boardId;
    @NotBlank
	private String ctnt;
    @NotBlank(message = "날짜를 지정하여 주세요")
    private String cdate;
    @JsonIgnore
    private MultipartFile fileCode;
    private String scope;
    private String bDivision;
    private String userId;
    private int likeQty;
    private int inqireQty;
    
    @Min(value = 2, message = "2명 이상이어야 합니다")
    @NotNull(message = "참여인원은 필수 입력 항목입니다")
    private Integer recQty;

	@NotBlank(message = "산을 선택하여 주세요")
	private String mntnNm;
	private Integer participationPee;
	@NotBlank(message = "제목을 입력하여 주세요")
	private String boardTitle;

	private String deadlineStatus;
}
