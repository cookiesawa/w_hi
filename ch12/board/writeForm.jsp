<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<script>
var wStatus = true;

$(document).ready(function(){
    
    //글쓰기폼의 [등록]버튼을 클릭하면 자동실행
    $("#b_regist").click(function(){
        formCheckIt();//글쓰기 폼의 입력 여부 체크
        if(wStatus){//입력란에 값을 모두 입력한 경우
          //[등록]버튼의 값으로 지정된 현재페이지 번호를 얻어냄
          var pageNum = $("#b_regist").val();
          //글쓰기폼에 입력된 값을 얻어내서 query에 저장
          var query = {subject:$("#subject").val(),
                       content:$("#content").val(),
                       passwd:$("#passwd").val(),
                       ref:$("#ref").val(),
                       re_step:$("#re_step").val(),
                       re_level:$("#re_level").val(),
                       num:$("#num").val()};
          
          //query값을 갖고 writePro.jsp실행
          $.ajax({
             type: "POST",
             url: "../board/writePro.jsp",
             data: query,
             success: function(data){
            	 data = data.trim();
                 if(data == "true") { //글추가 성공
                     alert("글이 등록되었습니다.");
                     var query = "../board/list.jsp?pageNum=" + pageNum;
                     $("#main_board").load(query);
                 }
             }
          });
        }
    });
    
    //글쓰기폼의 [취소]버튼을 클릭하면 자동실행
    //글목록보기 list.jsp페이지를 표시
    $("#b_cancle").click(function(){
        var pageNum = $("#b_cancle").val();
        var query = "../board/list.jsp?pageNum=" + pageNum;
        $("#main_board").load(query);
    });
});

//글쓰기 폼의 입력값 유무 확인
function formCheckIt(){
    wStatus = true;
    if(!$.trim($("#subject").val())){
        alert("제목을 입력하세요.");
        $("#subject").focus();
        wStatus = false;
        return false;
    }
    
    if(!$.trim($("#content").val())){
        alert("내용을 입력하세요.");
        $("#content").focus();
        wStatus = false;
        return false;
    }
    
    if(!$.trim($("#passwd").val())){
        alert("비밀번호를 입력하세요.");
        $("#passwd").focus();
        wStatus = false;
        return false;
    }
}
</script>
<%
  request.setCharacterEncoding("utf-8");

  //제목글의 경우 갖는 값
  int num = 0,ref = 1, reStep = 0, reLevel = 0;
  int pageNum = 1;

  if(request.getParameter("num") != null){ // 댓글
    //제목글의 글번호, 그룹화번호, 그룹화내의 순서, 들여쓰기 정도가 list.jsp 에서 넘어옴
    num = Integer.parseInt(request.getParameter("num"));
    ref = Integer.parseInt(request.getParameter("ref"));
    reStep = Integer.parseInt(request.getParameter("re_step"));
    reLevel = Integer.parseInt(request.getParameter("re_level"));
    pageNum = Integer.parseInt(request.getParameter("pageNum"));
  }
%>
<input type="hidden" id="num" value="<%= num %>">
<input type="hidden" id="ref" value="<%= ref %>">
<input type="hidden" id="re_step" value="<%= reStep %>">
<input type="hidden" id="re_level" value="<%= reLevel %>">
<div id="writeForm" class="box">
   <ul>
      <li><label for="subject">제목</label>
<%
  if(num != 0) { //댓글
%>
          <img src="../images/re.gif">
<%
  }
%>
          <input id="subject" name="subject" type="text" size="50" placeholder="제목" maxlength="50">
      </li>
      <li><label for="content">내용</label>
          <textarea id="content" rows="13" cols="50"></textarea></li>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" type="password" size="20" placeholder="6~16자 숫자/문자" maxlength="16">
      </li>
      <li class="label2">
          <button id="b_regist" value="<%= pageNum %>">등록</button>
          <button id="b_cancle" value="<%= pageNum %>">취소</button>
      </li>
   </ul>
</div>

