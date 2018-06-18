<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
%>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
//connection 획득
String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230117";
String dbId= "216230117"; // 사용자 계쩡
String dbPass = "hyw216230117"; //계정 패스워드
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
// 레코드 검색
String sql = "select id, passwd, name, reg_date from member where id = ? and passwd = ?";
// 쿼리 수행
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, id);
pstmt.setString(2, passwd);
ResultSet rs = pstmt.executeQuery();
boolean success = rs.next(); // 로그인 성공여부
rs.close();
pstmt.close();
conn.close();
if(success) {
    // 로그인 성공
    session.setAttribute("id", id);
%><jsp:forward page="main.jsp"></jsp:forward><%
    } else {
    // 로그인 실패
    request.setAttribute("msg", "아이디와 비밀번호를 확인해 주세요");
    session.removeAttribute("id");
%>
<jsp:forward page="loginform.jsp"></jsp:forward>
<% }%>
