<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%><%
String id = (String)session.getAttribute("id");
if(id != null) {
	response.sendRedirect("main/main.jsp");
} else {
	response.sendRedirect("login/loginForm.jsp");
}
%>