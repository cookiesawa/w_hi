<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	
	if(id.equals("kingdora")&& pass.equals("1234"))
		session.setAttribute("id",id);
	
	response.sendRedirect("sessionTestForm.jsp");
%>
