<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSTL</title>
</head>
<body>

<h3>Header 정보:</h3>
<c:forEach var="head" items="${headerValues}">
  <p>param: <c:out value="${head.key}"/>
  <p>values:
   <c:forEach var="val" items="${head.value}">
     <c:out value="${val}"/>
   </c:forEach>
</c:forEach>

<h3>JSTL core 태그예제 - set, out, remove</h3>
<p>browser변수값 설정
<c:set var="browser" value="${header['User-Agent']}"/><br>
<c:out value="${browser}"/><p>

<p>browser변수값 제거 후
<c:remove var="browser"/>
<c:out value="${browser}"/>

</body>
</html>