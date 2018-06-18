<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Date"
%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="registerBean" class="ch08.RegisterBean">
	<jsp:setProperty name="registerBean" property="*"/>
</jsp:useBean>
<% registerBean.setRegDate(new Date());//현재 날짜와 시간을 가입일로 지정 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register Pro</title>
</head>
<body>
<table style="border:1px solid green; background-color:#ffcccc;">
	<tr>
		<td>아이디</td>
		<td><jsp:getProperty name="registerBean" property="id"/></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><jsp:getProperty name="registerBean" property="passwd"/></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><jsp:getProperty name="registerBean" property="name"/></td>
	</tr>
	<tr>
		<td>가입일</td>
		<td><jsp:getProperty name="registerBean" property="regDate"/></td>
	</tr>
</table>
</body>
</html>
