<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 쿠키 생성
	Cookie cookie = new Cookie("id","hongildong"); 
	cookie.setHttpOnly(true);
	cookie.setMaxAge(120);
	response.addCookie(cookie);
%>
<p> 쿠키가 생성되었습니다.</p>
<form method ="post" action = "cookie-use.jsp">
	<input type = "submit" value="생성된 쿠키 확인">
</form>

