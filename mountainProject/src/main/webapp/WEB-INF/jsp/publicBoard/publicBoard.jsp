<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

	<style>
	
	 	#profileImage{
			width: 40px;
			height: 40px;
			border-radius: 100%;
			margin-bottom : 10px;
			margin-right : 10px;
			
		}
		
		.boardContent{
			display: flex;
	    	justify-content: center;
			padding-left : 260px;
			padding-right : 260px;
			margin-top : 15px;
		}
		.commentDiv{
			display: flex;
	    	justify-content: left;
			margin-left : 403px;
			margin-right : 403px;
			margin-top : 15px;
		}
		.commentDiv li{
			list-style-type: none;
		}
		
		#textareaData, .commentTextArea{
		    width: 72%; 
		    height: 100px; 
		    background-color: black; 
		    color: white; 
		    resize: none; 
		    border: none; 
		    outline: none;
		}
		.commentTextArea{
			height: auto; 
		}
		.subContainer{
			display: flex;
    		justify-content: flex-start;
		}
		.subImage{
			width:30px;
			height:30px;
			border-radius: 100%;
		}
		.likeImage {
		    margin-right: 10px; /* 원래 스타일에 있던 마진을 여기에 적용 */
		}
		
		.likeIcon {
		    vertical-align: middle; /* 이미지를 텍스트에 수직 정렬 */
		}
		
		.likeText {
		    display: inline-block;
		    vertical-align: middle; /* 텍스트를 이미지에 수직 정렬 */
		    margin-right: 5px; /* 텍스트와 아이콘 사이의 여백 */
		}
		#boardCreateDiv{
			position: absolute;
			margin-top: 120px;
			right: 038vh;
		}
		.btn {
		  position: relative;
		  border: 0;
		  padding: 15px 25px;
		  display: inline-block;
		  text-align: center;
		  color: white;
		}
		.btn:active {
		  top: 4px; 
		}
		.btn.small{
		  padding: 8px 18px;  
		  font-size: 14px;
		}	
	
		.btn.green{
			background-color: #9abf7f;
		}
		.btn.green {
			box-shadow: 0px 4px 0px #87a86f;
		}
		.btn.green:active {
			box-shadow: 0 0 #87a86f; 
			background-color: #87a86f;
		}
		a {
		    text-decoration: none;
		}
		.insert {
		  padding: 20px 30px;
		  display: block;
		  width: 600px;
		  margin: 5vh auto;
		  height: 80%;
		  border: 1px solid #dbdbdb;
		  -webkit-box-sizing: border-box;
		  -moz-box-sizing: border-box;
		  box-sizing: border-box;
		}
		.insert .title {
		  border: 1px solid #dbdbdb;
		  padding: 5px 7px;
		  font-size: 16px;
		  display: block;
		  width: 100%;
		  -webkit-box-sizing: border-box;
		  -moz-box-sizing: border-box;
		  box-sizing: border-box;
		}
		.insert .content {
		  border: 1px solid #dbdbdb;
		  padding: 5px 7px;
		  color: white;
		  font-size: 16px;
		  display: block;
		  width: 100%;
		  -webkit-box-sizing: border-box;
		  -moz-box-sizing: border-box;
		  box-sizing: border-box;
			
		  background-color: #222;
		  margin-top: 15px;
		  resize: none;
		  height: 20vh;
		  
		}
		.insert .file-hidden-list {
		  height: 0;
		  overflow: hidden;
		}
		.insert .fileConfirm {
		  height: 50vh;
		  border: 1px solid #989898;
		  text-align: center;
		  display: flex; /* 부모 요소를 플렉스 컨테이너로 설정 */
		  justify-content: center; /* 수평 가운데 정렬 */
		  align-items: center; /* 수직 가운데 정렬 */
		}
		.insert .fileConfirm .thumbnail {
		  width: 20%;
		  float: left;
		  position: relative;
		  margin-top: 20px;
		  color: #555;
		  text-align: center;
		  padding: 20px 0px;
		  -webkit-box-sizing: border-box;
		  -moz-box-sizing: border-box;
		  box-sizing: border-box;
		}
		.insert .fileConfirm .thumbnail i {
		  font-size: 50px;
		}
		.insert .fileConfirm .thumbnail p {
		  font-size: 14px;
		  margin-top: 10px;
		}
		.insert .fileConfirm .thumbnail .delete i{
		  position: absolute;
		  font-size: 14px;
		  top: 0;
		  right: 0;
		  color: #ff5353;
		}
		.add-button {
		    /* 버튼의 크기 설정 */
		    width: 70px;
		    height: 70px;
		    /* 이미지 경로 설정 */
		    background-image: url('<%=request.getContextPath()%>/images/board/button.png');
		    /* 배경 이미지를 가운데 정렬하여 요소 내에 중앙에 위치시킵니다. */
		    background-position: center;
		    /* 배경 이미지가 잘릴 경우를 대비하여 요소의 크기에 맞춰 이미지를 확대하지 않습니다. */
		    background-size: contain;
		    /* 버튼 테두리 제거 */
		    border: none;
		    /* 기타 스타일링 */
		    cursor: pointer; /* 마우스 커서를 포인터로 변경하여 클릭 가능함을 나타냄 */
		    border-radius : 50%;
		}
		#imageRetrieve{
			padding-top : 100px;
		}
		#publicBoardCreate{
			display: flex;
   			justify-content: center;
			font-size : 20px;
			font-weight: bold;
		} 
		.imageTotalDiv{
		    padding-left: 150px;
		    padding-right: 150px;
		}
		.boardImages {
		    width: 100vh; /* 부모 div의 너비를 100%로 설정 */
		    height: 100%; /* 부모 div의 높이를 100%로 설정 */
		    overflow: hidden; /* 이미지가 부모 div를 넘어가는 경우를 처리하기 위해 오버플로우를 숨김으로 설정 */
		}
		
		.boardImages img {
		    width: 100%; /* 이미지의 너비를 부모 div의 너비에 맞게 설정 */
		    height: 100%; /* 이미지의 높이를 부모 div의 높이에 맞게 설정 */
		    object-fit: cover; /* 이미지를 부모 div에 꽉 차게 설정 */
		}
		.profileIcon{
			width: 40px;
		    height: 40px;
		    border-radius: 50%
		}
		.containerCommentDiv{
			display : flex;
		}
		.containerTextAreea{
			width:1080px;
		}
	</style>
	<%
		String selectBoard = (String)request.getAttribute("selectBoard");
	%>
	<div id="bdbuttonArea">
	<%
		if(selectBoard.equals("public")){
	%>
		<div id="boardCreateDiv">
			<a href="javascript:;" id="boardCreate" class="btn green small">게시물 등록</a>
		</div>
	<% 		
		}
	%>
	</div>
	<div id="imageRetrieve">
		
	</div>
	
	<div id="totalPage">
	    
    </div>
 	
 	
<script>
    //전역변수 선언 - 페이지를 전체공개인지 부분공개인지 담기위한 변수
    let selectBoard ='<%= selectBoard %>';
    let scrollStatus = false;
    
    $(document).ready(function(){
    	
    	console.log(selectBoard);
    	// 초기 페이지 로드 시 데이터 로드
        loadData(selectBoard);
        
        $('body').scroll(function() {
            // 현재 스크롤 위치
            var scrollTop = Math.round($(this).scrollTop());
            // 요소의 총 높이
            var scrollHeight = $(this)[0].scrollHeight;
            // 요소의 보이는 화면 높이
            var windowHeight = Math.round($(this).height());
	
 			//스크롤 데이터 테스트           
            /* console.log("scrollHeight",scrollHeight)
            console.log("windowHeight",windowHeight)
            console.log("scrollTop",scrollTop) */  
            
            
            if (scrollTop + windowHeight >= scrollHeight && scrollStatus==true) {
            	loadData(selectBoard);
            }
        });
    });
 	// 데이터 로딩 중 여부를 나타내는 변수
    let loading = false; 
 	//전체공개 페이지 및 친구에게만 공개 페이지 출력
    function loadData(selectBoard) {
        // 이미 데이터를 로딩 중이면 추가 요청을 방지
        if (loading) return;
     	// 데이터 로딩 중 표시
        loading = true; 
		//scroll을 true로 변경하여 스크롤 이벤트가 발생하게함
		scrollStatus = true;
     	
     	
     	if(selectBoard == 'public'){
     		$.ajax({
                url: "<%=request.getContextPath()%>/board/main.do",
                type: "GET",
                data: { page: getNextPage()},
                success: function(data) {
                    // 받은 데이터를 처리하고 화면에 표시
                    console.log(data);
                    appendDataToDOM(data);
                    loading = false; 
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    loading = false; 
                }
            });
     	}else if(selectBoard == 'partial'){
     		$.ajax({
                url: "<%=request.getContextPath()%>/board/partialList.do",
                type: "GET",
                data: { page: getNextPage()},
                success: function(data) {
                	console.log('여기맞아?')
                    // 받은 데이터를 처리하고 화면에 표시
                    console.log(data);
                    appendDataToDOM(data);
                    loading = false; 
                },
                error: function(xhr, status, error) {
                    console.error("Error:", error);
                    loading = false; 
                }
            });
     	}
        
    }
 	
	// html을 만들어서 return해주는 곳
    // public 과 parial의 조건에 따라서 다른 게시물을 return함
	function appendDataToDOM(data) {
    	let boardList;
    	
    	if(selectBoard =='public'){
        	boardList = data.PublicBoardList;
        }else if(selectBoard =='partial'){
        	boardList = data.PartialBoardList;
        }
    	console.log("전체보드리스트 : ",boardList);
    	
		let boardLikeList = data.boardLikeList;

		for (let i = 0; i < boardList.length; i++) {
        	let boardItem = boardList[i];
            let userId = boardItem.userId;
            let ctnt = boardItem.ctnt;
            let name = boardItem.userDetail.name;
         	let boardId = boardItem.boardId;
			let likeQty = boardItem.likeQty;
			let cmtList = boardItem.commentVOList;		
         	
			//좋아요 여부
         	let flag= false;
         	
         	
            // HTML 요소를 생성합니다.
            let appendHtml = `
            	<div class="containerContents">
                <div id = "content">
                    <div>
                    	<input type="hidden" class="boardData" value="${boardId}"/>
                        <div class="imageTotalDiv">
                            <div>
                                <img class = "likeIcon" id="profileImage" src="/files/profile.do" alt="home"><span class="likeText">${name}</span>
                            </div>
                            <div class ='boardImages'>
                                <img src="/files/board/${boardId}/image.do"  
                                 alt="img">
                            </div>
                            <div class="subContainer">
                                <div class="likeImage"> `;
                                
                                for (let j = 0; j < boardLikeList.length; j++) {
                                	
	                                if (boardLikeList[j].boardId == boardId) {
                                        flag = true;
                                  		break;
	                                }
	                            }
							if(flag){
					            appendHtml += ` 
								            	<a href="javascript:;" id="likeSelect"><img class="subImage likeIcon" src="<%=request.getContextPath()%>/images/board/like.png" alt="like"></a> 
								              	<span class="likeText">${likeQty}</span>
								              `;
							}else{
								appendHtml += `
								        		<a href="javascript:;" id="likeSelect"><img class="subImage likeIcon" src="<%=request.getContextPath()%>/images/board/unlike.png" alt="unlike"></a> 
								            	<span class="likeText">${likeQty}</span>
											  `;
							}
                                
                                
	        appendHtml +=     ` </div>
                                <div style="margin-right: 10px;">
                                    <a href="javascript:;" onclick="openComment(this)"><img class="subImage" src="<%=request.getContextPath()%>/images/board/comment.png" alt="comment"></a>
                                </div>
                                <div>
                                	<a href="javascript:;"><img class="subImage" src="<%=request.getContextPath()%>/images/board/share.png" alt="share"></a>
                                </div>
                            </div>
                        </div>
                    </div>    
                </div>
                <div class = "commentDiv" style="display:none;">
                	<ul>
                `;
                	
                appendHtml += getComment(cmtList);
                		<%-- <li>
                			<img class="subImage profile" src="<%=request.getContextPath()%>/images/board/like.png" alt="like">
                			
                		</li> --%>
                	
                		
            appendHtml +=   `</ul>
				                </div>
				                <div class="boardContent">
				                    <textarea id="textareaData" style="text-align: left;">${ctnt.trim()}</textarea>
				                </div>
			                </div>
				            `;
            
            // 생성한 HTML을 totalPage에 추가합니다.
            $('#totalPage').append(appendHtml);
        }
    }

	function getComment(commentList){
		
		let appendHtmlTag = "";
		commentList.forEach(function(comment){
			if(comment.commentWriter){
				let userInfo = comment.userVO;
				console.log(userInfo);
				appendHtmlTag += `
				    <li>
						<div class="containerCommentDiv">
					        <img class="profileIcon" id="contentsProfileImage" src="${userInfo.userId ? '/files/' + userInfo.userId + '/profileImage.do' : ''}" alt="home">
					        <div>
					        <span class="likeText">${userInfo.name}</span>    
					        <span>${comment.currentDate}</span>
				        	</div>
				        </div>
				        <div class="containerTextAreea">
				            <textarea class="commentTextArea" style="text-align: left;">${comment.contents}</textarea>
				        </div>
			    	</li>
				`;
			}

		})
		return appendHtmlTag;
	}
	
	
    let page = 0;
    function getNextPage() {
        // 다음으로 로드할 페이지 번호를 계산하여 반환
        // 처음엔 0으로 시작해서 1, 2, 3, ... 로 보내짐
        return page++;
    }
    
    //좋아요 등록 및 취소
    $(document).on("click", "#likeSelect", function(event) {
        event.preventDefault(); 
		
        // 클릭된 a 태그의 부모 요소인 div의 형제 요소인 hidden input의 값을 가져옴
       	let boardId = $(this).closest('.imageTotalDiv').siblings('input[type="hidden"]').val();
        let jsonData = {"boardId" : boardId}
        
        // 자신이 클릭한 이벤트를 closure로 넣어놓고 ajax에서 사용함
        let $this = $(this);
        
        $.ajax({
            url: "/board/likeInsert.do", 
            type: "POST",
            dataType: "json",
            data: JSON.stringify(jsonData),
            success: function(res) {
                console.log(res);
                let likeQty = res.likeQty;
                if(res){
                	if (res.Like) {
                			//클릭한 img의 상위에 있는 이미지가 담겨있는 div를 비우고 새로운것으로 등록
                	        let likeImg =  $this.closest('.likeImage');
                	        likeImg.empty(); 
                	        let appendHtml = `
                	        	<a href="javascript:;" id="likeSelect"><img class="subImage likeIcon" src="<%=request.getContextPath()%>/images/board/like.png" alt="like"></a> 
                	            <span class="likeText">${likeQty}</span>
                	        `;
                	        likeImg.append(appendHtml); // 새로운 데이터 추가
                	}else if(res.UnLike){
	                		let likeImg =  $this.closest('.likeImage');
	            	        likeImg.empty(); 
	            	        let appendHtml = `
	            	        	<a href="javascript:;" id="likeSelect"><img class="subImage likeIcon" src="<%=request.getContextPath()%>/images/board/unlike.png" alt="like"></a> 
                	            <span class="likeText">${likeQty}</span>
	            	        `;
	            	        likeImg.append(appendHtml); // 새로운 데이터 추가
                	}else if(res.UnLikeFail){
                		alert('좋아요를 취소하는데 실패하였습니다. 다시 시도 해주세요')
                	}else if(res.LikeFail){
                		alert('좋아요를 등록하는데 실패하였습니다. 다시 시도 해주세요')
                	}else if(res.fail){
                		alert('서버 오류 입니다. 다시 시도 해주세요 ')
                	}
                }
            },
            error: function(xhr, status, error) {
                console.error("Error:", error); 
            }
        }); 
    });
    
    
    $(document).on('click', '#boardCreate', function() {
    	console.log("나와");
    	//scroll 이벤트 막기
	    scrollStatus = false;
    	
    	$('#totalPage').empty();
    	$('#boardCreateDiv').empty();
    	$('#imageRetrieve').empty();
    	
    	let boardForm = ` 
    						<span id="publicBoardCreate">게시물 등록</span>
    						<div class="insert">
					    	  <form:form id="boardForm" modelAttribute="boardVO" action="/board/publicInsert.do" method="POST">
					    		<span>파일등록</span> 
					    		<select name="scope" style="float: right;">
					                <option value="PUBLIC">전체공개</option>
					                <option value="PARTIAL">친구에게만 공개</option>
					                <option value="PRIVATE">나만보기</option>
					            </select>
					    		<input type="file" id="fileInput" name="fileCode" enctype="multipart/form-data" style="display: none;">  
						    	<div class="fileConfirm">
						    		<button id="addFile" class="add-button" type="button"></button>
						    	</div>
						    	<div id="cancleData"></div>
					    	    <textarea class="content" name="ctnt" placeholder="내용을 입력해 주세요"></textarea>
					    	    <input type="submit" value="등록" style="background-color: #6B8E23; color: white;">
					    	    <input type="button" id="cancleBoardInsert" value="취소" style="background-color: #6B8E23; color: white;">
					    	  </form:form>
					    	</div>
					    `;
		$('#imageRetrieve').append(boardForm);
    })
	
	$(document).on('click', '#addFile', function() {
   		$('#fileInput').click(); // 파일 입력 요소 클릭
	});
	
	// 파일 선택 취소 버튼 클릭 시
	$(document).on('click', '#cancelFile', function() {
	    $('#fileInput').val(''); // 파일 선택 취소
	    $('.fileConfirm').empty(); // 이미지 미리보기 영역 비우기
	    
	    let imageData =`
	    	<input type="file" id="fileInput" style="display: none;">  
    		<button id="addFile" class="add-button" type="button"></button>
	    `
	    $('.fileConfirm').append(imageData); 
	    
	});
	
	$(document).on('change', '#fileInput', function(e) {
	    let files = e.target.files;
	    console.log('파일 정보:', files); // 파일 정보 출력
	    const fileConfirm = $('.fileConfirm');
		let cancleData = $('#cancleData');
	    for (let i = 0; i < files.length; i++) {
	        const file = files[i];
	        
	        // 파일이 이미지가 아닌 경우 경고 메시지 표시
	        if (!file.type.startsWith('image/')) {
	            alert('이미지 파일을 선택해주세요.');
	            $('#fileInput').val(''); // 파일 선택 취소
	            return; // 함수 종료
	        }
	        
	        const reader = new FileReader();
	
	        reader.onload = function(e) {
	            let image = $('<img>');
	            image.attr('src', e.target.result);
	            image.css('max-width', '100%');
	            image.css('max-height', '100%');
	            fileConfirm.empty();
	            fileConfirm.append(image);
	
	            // 파일 선택 취소 버튼 추가
	            const cancelButton = $('<button>');
	            cancelButton.attr('id', 'cancelFile');
	            cancelButton.attr('type', 'button'); // 버튼 타입을 명시적으로 지정
	            cancelButton.text('파일 취소');
	            cancelButton.css('background-color', '#6B8E23'); // 배경색을 연한 초록색으로 설정
	            cancelButton.css('color', 'white'); // 텍스트 색상을 하얀색으로 설정
	            cancleData.append(cancelButton);
	        };
	
	        reader.readAsDataURL(file);
	    }
	});

	$(document).on('click','#cancelFile',function(){
		$('#cancleData').empty();
	})
	
	$(document).on('submit', '#boardForm', function(event) {
	    event.preventDefault(); // 기본 제출 동작 막기
	  
	    
	    // FormData 객체 생성
	    const formData = new FormData(this);
	    const fileInput = $('#fileInput')[0].files[0]
	    console.log(fileInput);
	    formData.append('file', fileInput);
	    
        const urls = $(this).attr('action');
        const methods = $(this).attr('method');
        console.log(urls)
        console.log(methods)

        $.ajax({
            url: urls, 
            type: methods,
            data: formData,
            processData: false,  // FormData를 문자열로 변환하지 않음
            contentType: false,  // 컨텐츠 타입 설정을 위해 jQuery에게 위임
            success: function(res) {
                if(res.success){
                	alert('등록이 완료되었습니다.');
                	$('#totalPage').empty();
                	$('#imageRetrieve').empty();
                	$('#bdbuttonArea').empty();
                	let btData = `
                		<div id="boardCreateDiv">
	            			<a href="javascript:;" id="boardCreate" class="btn green small">게시물 등록</a>
	            		</div>
                	`;
                	//page를 다시 0으로 세팅
                	page = 0;
                	
                	loadData('public');
                	if(selectBoard === 'public'){
                		$('#bdbuttonArea').append(btData);
                	}
                	
                }else{
                	alert('등록이 실패하였습니다.');
                }
            },
            error: function(xhr, status, error) {
                console.error('오류:', error);
            }
		});
	});
		
	//취소버튼 누를시
    $(document).on('click', '#cancleBoardInsert', function() {
    	debugger;
    	$('#imageRetrieve').empty();
    	window.location.href = '<%=request.getContextPath()%>/board/publicView.do'; 

    })
    
    function openComment(element) {
	    var parentElement = $(element).closest('.containerContents');
	    var commentDiv = parentElement.find('.commentDiv');
	
	    // ul 아래의 li 요소를 확인하여 개수를 가져옴
	    var liCount = commentDiv.find('ul li').length;
	
	    if (liCount === 0) {
	        // li 요소가 없는 경우에만 display: none으로 설정
	        commentDiv.css('display', 'none');
	    } else {
	        // li 요소가 있는 경우에는 정상적으로 토글 처리
	        commentDiv.toggle();
	    }
	}



</script>

        
        
