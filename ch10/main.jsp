<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("id");
if(id == null) {
%>
<jsp:forward page="loginform.jsp"></jsp:forward>
<%
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인</title>
</head>
<body>
<h1><%= id %> 님 환영합니다.</h1>
<button onclick="document.location = 'logout.jsp';">로그아웃</button>
</body>
</html>
