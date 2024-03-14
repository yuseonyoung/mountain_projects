<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link
	href="https://fonts.googleapis.com/css?family=Indie+Flower|Overpass+Mono"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	
<style>
* {
	margin: 0px;
	padding: 0px;
}

body {
	background-color: #eee;
}

#wrapper {
	width: 500px;
	height: 50%;
	overflow: hidden;
	border: 0px solid #000;
	margin: 50px auto;
	padding: 10px;
}

.main-content {
	width: 250px;
	height: 40%;
	margin: 10px auto;
	background-color: #fff;
	border: 2px solid #e6e6e6;
	padding: 40px 50px;
}

.header {
	border: 0px solid #000;
	margin-bottom: 5px;
}

.header img {
	height: 50px;
	width: 175px;
	margin: auto;
	position: relative;
	left: 40px;
}

.input-1, .input-2 {
	width: 100%;
	margin-bottom: 5px;
	padding: 8px 12px;
	border: 1px solid #dbdbdb;
	box-sizing: border-box;
	border-radius: 3px;
}

.overlap-text {
	position: relative;
}

.overlap-text a {
	position: absolute;
	top: 8px;
	right: 10px;
	color: #003569;
	font-size: 14px;
	text-decoration: none;
	font-family: 'Overpass Mono', monospace;
	letter-spacing: -1px;
}

.btn {
	width: 100%;
	background-color: #3897f0;
	border: 1px solid #3897f0;
	padding: 5px 12px;
	color: #fff;
	font-weight: bold;
	cursor: pointer;
	border-radius: 3px;
}

.sub-content {
	width: 250px;
	height: 40%;
	margin: 10px auto;
	border: 1px solid #e6e6e6;
	padding: 20px 50px;
	background-color: #fff;
}

.s-part {
	text-align: center;
	font-family: 'Overpass Mono', monospace;
	word-spacing: -3px;
	letter-spacing: -2px;
	font-weight: normal;
}

.s-part a {
	text-decoration: none;
	cursor: pointer;
	color: #3897f0;
	font-family: 'Overpass Mono', monospace;
	word-spacing: -3px;
	letter-spacing: -2px;
	font-weight: normal;
}

input:focus {
	background-color: yellow;
}

body {
	background-color: #eee;
	background-image:
		url('<%=request.getContextPath()%>/images/background/background.jpg');
	background-size: cover;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<body>
	<%
	    String failMessage = (String) session.getAttribute("failLogin");
	    if (failMessage != null && !failMessage.isEmpty()) {
	%>
	    <script>
	        Swal.fire({
	           title: '로그인실패',
	           text: '<%=failMessage%>', // 여기 수정
	           icon: 'warning',
	           confirmButtonColor: '#3085d6',
	           confirmButtonText: '확인',
	        });
	    </script>
	<% 
	    } 
	%>

	<div id="wrapper">
		<input type="hidden" id="contextPath" value="<%=request.getContextPath()%>"/>
		<form:form modelAttribute="UserVO" method="POST" action="/login.do">
			<div class="main-content">
				<div class="header">
					<img src="<%=request.getContextPath()%>/images/loginImage/loginImage.png" />
				</div>
				<div class="l-part">
					<input type="text" placeholder="아이디" class="input-1" id="userId" name="userId"/>
					<div class="overlap-text">
						<input type="password" placeholder="비밀번호" class="input-2" id="pwdno" name="pwdno"/> 
					</div>
					<input type="submit" value="Log in" class="btn" />
				</div>
			</div>
		</form:form>
		<div class="sub-content">
			<div class="s-part">
				Don't have an account?<a href="#"> Sign up</a>
			</div>
		</div>
	</div>
</body>
<!-- <script>
    $(document).ready(function() {
    	
    	let path = contextPath = $('#contextPath').val();
    	
        $('form').submit(function(event) {
            event.preventDefault();

            var data = {
                userId: $('#userId').val(),
                pwdno: $('#pwdno').val()
            };

            // JSON 데이터를 서버로 전송
            $.ajax({
                type: 'POST',
                url: path + '/login.do',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function(res) {
                    if (res) {
                        window.location.href = res;
                    } else if(res.error){
                    
                    } else if(res.fail){
                    	
                    } else{
                    	
                    }
                },
                error: function(xhr, status, error) {
                    // 에러 발생 시 처리
                    console.error('Error:', error);
                }
            });
        });
    });
</script> -->
</html>