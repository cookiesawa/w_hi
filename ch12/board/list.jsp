<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="ch12.BoardDBBean"
    import="ch12.BoardDataBean"
    import="java.util.*"
    import="java.text.SimpleDateFormat"
%>
<script>
$(document).ready(function(){
    //[글쓰기]버튼을 클릭하면 제목글 쓰기(writeForm.jsp)로 이동 
    $("#b_new").click(function(){
        $("#main_board").load("../board/writeForm.jsp");
    });
});

// [글수정]버튼을 클릭하면  main.jsp의 main_board 영역에 글수정폼 표시
function edit(editBtn){
    //수정할 글의 정보가 [글수정]버튼인 editBtn의 name속성에 지정
    var rStr = editBtn.name;
    var arr = rStr.split(",");
    //글번호와 페이지번호를 갖고 updateForm.jsp 페이지 로드
    var query = "../board/updateForm_se.jsp?num=" + arr[0];
    query += "&pageNum=" + arr[1];
    $("#main_board").load(query);
}

//[글삭제]버튼을 클릭하면 main.jsp의 main_board영역에 글삭제폼 표시
function del(delBtn){
    var rStr = delBtn.name;
    var arr = rStr.split(",");
    //글번호와 페이지번호를 갖고 deleteForm.jsp 페이지 로드
    var query = "../board/deleteForm.jsp?num=" + arr[0];
    query += "&pageNum=" + arr[1];
    $("#main_board").load(query);
}

//[댓글쓰기]버튼을 클릭하면 main.jsp의 main_board영역에 글쓰기폼 표시
function reply(replyBtn){
    var rStr = replyBtn.name;
    var arr = rStr.split(",");
    //댓글쓰기에 필요한 정보를 갖고 writeForm.jsp 페이지 로드
    var query = "../board/writeForm.jsp?num=" + arr[0] + "&ref=" + arr[1];
    query += "&re_step=" + arr[2] + "&re_level=" + arr[3] + "&pageNum=" + arr[4];
    $("#main_board").load(query);
}

//페이지 이동 버튼을 누르면 main.jsp의 main_board영역에 해당페이지의 글목록 표시
function p(jumpBtn){
    var rStr = jumpBtn.name;
    var query = "../board/list.jsp?pageNum=" + rStr;
    $("#main_board").load(query);
}
</script>
<%
  request.setCharacterEncoding("utf-8");

  int pageSize = 3; // 한 페이지에 표시할 글의 수 
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //날짜데이터 표시형식지정

  String pageNum = request.getParameter("pageNum");//화면에 표시할 페이지번호
  if (pageNum == null) pageNum = "1"; //페이지번호가 없으면 1페이지의 내용이 화면에 표시

  int currentPage = Integer.parseInt(pageNum);//숫자로 파싱
    
  List<BoardDataBean> articleList = null;//글목록을 저장
  BoardDBBean dbPro = BoardDBBean.getInstance();
  int count = dbPro.getArticleCount();//전체글수 얻어냄

  if(count == (currentPage - 1) * pageSize) currentPage -=1;
  
  int startRow = (currentPage - 1) * pageSize + 1;//현재 페이지에서의 시작글번호

  //테이블에 저장된 글이 있으면, 테이블에서 글목록을 가져옴
  if(count > 0) articleList = dbPro.getArticles(startRow, pageSize);
  else articleList = new ArrayList<BoardDataBean>();

  //테이블에 저장된 글이 없으면, 전체글 수 : 0
  if(articleList.isEmpty()) count = 0;
%>

<div id="list_head" class="box2">
   <h3 class="inline">글목록(전체 글 : <%= count %>)</h3>
   <button id="b_new">글쓰기</button>
</div>

<%
  if (count == 0) { // 게시판에 글이 없는 경우
%>
<div id="list_article" class="box2">
  <ul>
    <li><p>게시판에 저장된 글이 없습니다.
  </ul>
</div>
<%
  } else { // 게시판에 글이 있는 경우
%>
<div id="list_article" class="box2">
<% 
  // 글목록을 반복처리
  for (int i = 0; i < articleList.size(); i++) {
     BoardDataBean article = articleList.get(i);
     String writer = article.getWriter();
%>
   <ul class="article">  
    <li class="layout_f"><%= article.getWriter() %></li>
    <li class="layout_f">
<%
    int wid = 0; 
    if(article.getReLevel() > 0){
       wid = 5 * (article.getReLevel());
%>
       <img src="../images/level.gif" width="<%= wid %>">
       <img src="../images/re.gif">
<%
     } else {
%>
       <img src="../images/level.gif" width="<%= wid %>" height="16">
<%
     }
     int num = article.getNum();
     int ref = article.getRef();
     int re_step = article.getReStep();
     int re_level = article.getReLevel();
%>
<%= article.getSubject() %>
   <p class="date"><%= sdf.format(article.getRegDate()) %><br>
   <pre><%= article.getContent() %></pre><br>
<%
     String id = (String)session.getAttribute("id");
     if(id != null && id.equals(writer)) {
%>
     <button id="edit" name="<%= num + "," + pageNum %>" onclick="edit(this)">수정</button>
     <button id="delete" name="<%= num + "," + pageNum %>" onclick="del(this)">삭제</button>
<%
     } else {
%>
     <button id="reply" name="<%= num + "," + ref + "," + re_step + "," + re_level + "," + pageNum %>" onclick="reply(this)">댓글쓰기</button>
<%
     }
%>
    </li>
  </ul>
<%
   }
%>
</div>
<%
}
%>
<%-- 페이지 이동 처리 --%>
<div id="jump" class="box3">
<%
if (count > 0) {
   int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
   int startPage = 1;
      
   if(currentPage % pageSize != 0)
      startPage = (int)(currentPage / pageSize) * pageSize + 1;
   else
      startPage = ((int)(currentPage / pageSize) - 1) * pageSize + 1;
   
   int pageBlock = 3; //페이지들의 블럭단위 지정
   int endPage = startPage + pageBlock - 1;
   
   if (endPage > pageCount) endPage = pageCount;
        
   if (startPage > pageBlock) {
%>
      <button id="juP" name="<%= startPage - pageBlock %>" onclick="p(this)" class="w2">이전</button>&nbsp;
<%
   }
   for (int i = startPage; i <= endPage; i++) {
     if(currentPage == i) {
%>
      <button id="ju" name="<%= i %>" onclick="p(this)" class="w1"><%= i %></button>
<%
     } else {
%> 
      <button id="ju" name="<%= i %>" onclick="p(this)" class="w"><%= i %></button>
<%
     }
%>
      &nbsp; 
<% }
   if (endPage < pageCount) {
%>
      &nbsp;
      <button id="juN" name="<%= startPage + pageBlock %>" onclick="p(this)" class="w2">다음</button>
<%
   }
}//108라인 if꺼
%>
</div>


