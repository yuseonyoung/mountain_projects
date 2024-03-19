<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/headerStyle.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/leftSidebarStyle.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/rightSideBarStyle.css">
<script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb220a45abe792f033fbc010f5b30024"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.1.1/css/ol.css" type="text/css">
<script src="https://cdn.jsdelivr.net/gh/openlayers/openlayers.github.io@master/en/v6.9.0/build/ol.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
	 body, html {
	 		width : 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .container {
            display: flex;
            flex-direction: column;
            min-height: 100%;
        }

        .contents {
            display: flex;
            flex-grow: 1;
        }

        #listBody {
            flex-grow: 1;
            overflow-y: scroll
        }
        #content{
        	/* word-wrap: break-word; */
        	display: flex;
		    justify-content: center;
		    padding-top: 120px;
		    padding-left: 260px;
		    padding-right: 260px;
        }
	  
</style>
</head>
<body>
    <div class="container">

    	<div id="leftbar-wrapper">
	        <tiles:insertAttribute name="leftMenu" />
        </div>
        <div id="rightbar-wrapper">
            <tiles:insertAttribute name="rightMenu" />
        </div>
        <div class="contents">
            <tiles:insertAttribute name="headerMenu" />
            <div id="listBody">
                <tiles:insertAttribute name="content" />
            </div>
        </div>
    </div>
</body>
	<%
	    String userId = (String) session.getAttribute("userId");
	    if (userId == null || userId.isEmpty()) {
	%>
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> <!-- SweetAlert2 라이브러리 불러오기 -->
	    <script>
	
            Swal.fire({
                title: "로그인을 하지 않았습니다",
                text: "로그인 페이지로 이동합니다.",
                icon: "warning",
                confirmButtonText: "확인",
                allowOutsideClick: false 
            }).then(function() {
            	// 확인 버튼 클릭 시 로그인 페이지로 이동
                window.location.href = "/login.do"; 
            });
	    </script>
	<%
	        return; // 리디렉션 후 추가 코드 실행 방지
	    }
	%>

</html>