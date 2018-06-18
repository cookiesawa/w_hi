<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="ch12.BoardDBBean"
%><%
  request.setCharacterEncoding("utf-8");
%>
<%-- BoardDataBean클래스의 객체 article을 생성: 향후 이 객체에 접근시 article.--%>
<jsp:useBean id="article" scope="page" class="ch12.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<%
  //글 수정 처리후 결과를 check변수에 저장
  BoardDBBean dbPro = BoardDBBean.getInstance();
  boolean check = dbPro.updateArticle(article);
 
  //이 페이지를 호출한 update.js로 처리결과값 check를 반환
  out.println(check);
%>