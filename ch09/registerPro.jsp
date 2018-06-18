<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
%>
<%
request.setCharacterEncoding("utf-8"); 
%>
<jsp:useBean id="registerBean" class="ch08.RegisterBean">
	<jsp:setProperty name="registerBean" property="*"/>
</jsp:useBean>
<%
registerBean.setRegDate(new java.util.Date());//현재 날짜와 시간을 가입일로 지정 

//connection 획득
String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230117";
String dbId= "216230117"; // 사용자 계쩡
String dbPass = "hyw216230117"; //계정 패스워드

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

//레코드 추가
String sql = "insert into member(id, passwd, name, reg_date) values (?, ?, ?, ?)";

//쿼리 수행
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, registerBean.getId());
pstmt.setString(2, registerBean.getPasswd());
pstmt.setString(3, registerBean.getName());
pstmt.setTimestamp(4, new Timestamp(registerBean.getRegDate().getTime()));

pstmt.executeUpdate();

pstmt.close();
conn.close();

%>
<jsp:forward page="memeberList.jsp"/>


