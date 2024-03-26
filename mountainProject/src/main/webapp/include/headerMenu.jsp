<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<header class="header">
	<div id="totalDiv" style="display: flex; justify-content: space-between;">
		<div id="logoDiv">
			<a href="/board/publicView.do" class="logo">등산어때</a>	
		</div>
	 	<div id="menuDiv">
		 	<ul class="menu">
				<li>
				    <a href="/board/publicView.do">
				        <div style="text-align: center;">
				            <img src="<%=request.getContextPath()%>/images/menu/home.png" alt="home" style="display: block; margin: 0 auto;">
				            <span style="display: block;">전체조회</span>
				        </div>
				    </a>
				</li>
				<li>
				    <a href="/board/partialView.do">
				        <div style="text-align: center;">
				            <img src="<%=request.getContextPath()%>/images/menu/groups.png" alt="groups" style="display: block; margin: 0 auto;">
				            <span style="display: block;">친구만조회</span>
				        </div>
				    </a>
				</li>
				<li>
				    <a href="/board/rBoardList.do">
				        <div style="text-align: center;">
				            <img src="<%=request.getContextPath()%>/images/menu/mountain.png" alt="mountain" style="display: block; margin: 0 auto;">
				            <span style="display: block;">모집게시물</span>
				        </div>
				    </a>
				</li>
				<!-- <li>
				    <a href="#">
				        <div style="text-align: center;">
				            <img src="<%=request.getContextPath()%>/images/menu/medal.png" alt="medal" style="display: block; margin: 0 auto;">
				            <span style="display: block;">뱃지조회</span>
				        </div>
				    </a>
				</li> -->
				<li>
				    <a href="/statistics/regionView.do">
				        <div style="text-align: center;">
				            <img src="<%=request.getContextPath()%>/images/menu/areaIcon.png" alt="area" style="display: block; margin: 0 auto;">
				            <span style="display: block;">지역통계</span>
				        </div>
				    </a>
				</li>
			</ul>
	  	</div>
	  	<%
		  	String userId = (String) session.getAttribute("userId");
		    if (userId != null && !userId.isEmpty()) {
	  	%>
	  	<div id="propileDiv">
	  		<img class="myProfile" src="/files/profile.do" alt="profile" 
	  			style="
		    			width: 40px;
		    			height: 40px;
		    			magin-top: 30px;
		    			padding-top: 15px; 
		    			vertical-align: middle;
		    		  "
		    >
			
			<span id="userName" 
				style="
					display: inline-block;
			    	vertical-align: middle; /* 텍스트를 이미지에 수직 정렬 */
			    	margin-right: 5px;
			    	padding-top: 15px;
		    	"
		    >
		    <c:out value="${sessionScope.userNM}"/></span>
		     <span style="
					display: inline-block;
			    	vertical-align: middle; /* 텍스트를 이미지에 수직 정렬 */
			    	margin-right: 5px;
			    	padding-top: 15px;
		    	">
		    <a href="<%=request.getContextPath()%>/login.do">로그아웃</a>
		    </span>
	    <%
		    }else{
		%>
			 <span style="
				display: inline-block;
		    	vertical-align: middle; /* 텍스트를 이미지에 수직 정렬 */
		    	margin-right: 5px;
		    	padding-top: 15px;
	    	">
		    <a href="<%=request.getContextPath()%>/login.do">로그인</a>
		    </span>		 
		<%
		    }
	    %>
		    	
	  	</div>
	</div>
</header>