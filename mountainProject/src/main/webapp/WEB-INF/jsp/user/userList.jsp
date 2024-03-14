<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<input type="hidden" id="contextPath" value="<c:url value="/" />">

<div id="userListData">
</div>
<script type="text/javascript">
	$(function(){
		let contextPath = $('#contextPath').val();
		console.log(contextPath);
		$.ajax({ 
            type:"GET", 
            url:"/user.do",
            dataType: "json",
            success:function(res){ 
                console.log(res);
            }, 
            error: function(xhr, status, error) {
                console.error("Ajax 요청 실패:", status, error);
                console.error("응답 상태 코드:", xhr.status);
                console.error("응답 메시지:", xhr.statusText);
                console.error("응답 본문:", xhr.responseText);
            }

        });
	})
</script>
