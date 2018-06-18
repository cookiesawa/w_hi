<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
%><%
pageContext.setAttribute("pageAttr", "페이지속성값", PageContext.REQUEST_SCOPE);
%>
<jsp:useBean id="registerBean" class="ch08.RegisterBean" scope="request">
    <jsp:setProperty name="registerBean" property="id" value="hongkildong"/>
    <jsp:setProperty name="registerBean" property="name" value="홍길동"/>
</jsp:useBean>
<jsp:forward page="main.jsp" >
  <jsp:param name="forwardFrom" value="index.jsp" />
</jsp:forward>