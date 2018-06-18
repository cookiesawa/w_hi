<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,java.text.*"
    import="java.sql.*"
    info="자바웹애플리케이션"
    session="true"
    buffer="8kb" autoFlush="true"
    isThreadSafe="true"
%><%@ include file="title.jsp" %>
<%!
private String hello = "안녕하세요";
private int count = 1;

private int getCount(){
   return this.count++;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= title %></title>
</head>
<body>
<h1><%=this.getCount() %> 번째 방문자입니다.</h1>
<%= this.getServletInfo() %>
</body>
</html>