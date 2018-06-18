<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.Timestamp, ch11.LogonDBBean"
%>
<%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="ch11.LogonDataBean">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%  
    //폼으로 부터 넘어오지 않는 데이터인 가입날짜를 직접 데이터저장빈에 세팅
    member.setRegDate(new Timestamp(System.currentTimeMillis()));

    LogonDBBean manager = LogonDBBean.getInstance();
    //사용자가 입력한 데이터저장빈 객체를 가지고 회원가입 처리 메소드호출
    manager.insertMember(member);
%>