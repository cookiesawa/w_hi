<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="ch11.LogonDBBean"
%><%
    request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="member" class="ch11.LogonDataBean">
    <jsp:setProperty name="member" property="*" />
</jsp:useBean>
<%  
  LogonDBBean manager = LogonDBBean.getInstance();
  //회원정보 수정 처리 메소드 호출 후 수정 상황값 반환
  boolean check = manager.updateMember(member);
    
  out.println(check);
 %>
 