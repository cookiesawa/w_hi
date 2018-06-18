<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "java.sql.*"
%><%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MemberList</title>
</head>
<body>
<%
//connection 획득
String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230117"; //url
String dbId= "216230117"; // 사용자 계쩡
String dbPass = "hyw216230117"; //계정 패스워드

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

//레코드 검색
String sql = "select id, passwd, name, reg_date from member";

//쿼리 수행
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

//레코드셋 처리
while (rs.next()){
	String id= rs.getString("id");
	String passwd= rs.getString("passwd");
	String name= rs.getString("name");
	Date regDate= rs.getDate("reg_date");	
%>
<table style="border:1px solid green; background-color:#ffcccc; width:300px;">
	<tr>
		<td>아이디</td>
		<td><%= id %></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><%= passwd %></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><%= name %></td>
	</tr>
	<tr>
		<td>가입일</td>
		<td><%= regDate %></td>
	</tr>
</table>
<%
}
rs.close();
pstmt.close();
conn.close();
%>
</body>
</html>
