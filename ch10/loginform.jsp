<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<% if(session.getAttribute("id") != null) { %>
<jsp:forward page="main.jsp"></jsp:forward>
<% return; }
String msg = (String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인폼</title>
<script>
<% if(msg != null) { %>
alert("<%= msg %>");
<% } %>
</script>
</head>
<body>
<form method="post" action="loginpro.jsp">
 <table><tr>
  <td class="label"><label for="id">아이디</label></td>
  <td class="content"><input id="id" name="id" type="text" style="width:98%;"></td>
  </tr><tr>
  <td class="label"><label for="passwd">비밀번호</label></td>
  <td class="content"><input id="passwd" name="passwd" type="password" style="width:98%;"></td>
  </tr><tr>
  <td class="label2" colspan="2"><input type="submit" value="로그인">
     <input type="reset" value="다시작성"></td></tr></table>
</form>
</body>
</html>
