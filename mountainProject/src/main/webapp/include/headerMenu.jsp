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
			    <li><a href="/board/publicView.do"><img src="<%=request.getContextPath()%>/images/menu/home.png" alt="home"></a></li>
			    <li><a href="/board/partialView.do"><img src="<%=request.getContextPath()%>/images/menu/groups.png" alt="groups"></a></li>
			    <li><a href="/board/rBoardList.do"><img src="<%=request.getContextPath()%>/images/menu/mountain.png" alt="mountain"></a></li>
			    <li><a href="#"><img src="<%=request.getContextPath()%>/images/menu/medal.png" alt="medal"></a></li>
			    <li><a href="/statistics/regionView.do"><img src="<%=request.getContextPath()%>/images/menu/areaIcon.png" alt="area"></a></li>
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