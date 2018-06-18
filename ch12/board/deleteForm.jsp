<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<script>
var wStatus = true;

$(document).ready(function(){
    
    //글삭제폼의 [삭제]버튼을 클릭하면 자동실행
    $("#b_delete").click(function(){
        formCheckIt();
        if(wStatus){
          //[삭제]버튼의 값으로 지정된 현재페이지 번호를 얻어냄
          var pageNum = $("#b_delete").val();
          //글번호와 글삭제폼에 입력된 값을 얻어내서 query에 저장
          var query = {passwd:$("#passwd").val(),
                       num:$("#num").val()};
          
          //query값을 갖고 deletePro.jsp실행
          $.ajax({
             type: "POST",
             url: "../board/deletePro.jsp",
             data: query,
             success: function(data) {
            	 data = data.trim();
                 if(data == "true") { //글삭제 처리에 성공한 경우
                    alert("글이 삭제되었습니다.");
                    var query = "../board/list.jsp?pageNum=" + pageNum;
                    $("#main_board").load(query);
                 } else { //글삭제 처리에 실패한 경우
                    alert("비밀번호 틀림.");
                    $("#passwd").val("");
                    $("#passwd").focus();
                 }
             }
          });
        }
    });
    
    //글삭제폼의 [삭제]버튼을 클릭하면 자동실행
    //글목록보기 list.jsp페이지를 표시
    $("#b_cancle").click(function(){
        var pageNum = $("#b_cancle").val();
        var query = "../board/list.jsp?pageNum=" + pageNum;
        $("#main_board").load(query);
    });

});

//글삭제 폼의 비밀번호 입력 유무 확인
function formCheckIt(){
    wStatus = true;
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

  //삭제할 글의 번호와 삭제할 글이 위치한 페이지 번호를 얻어냄
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
%>
<div id="deleteForm">
   <ul>
      <li><p class="center">글삭제</p></li>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" type="password" size="20" placeholder="6~16자 숫자/문자" maxlength="16">
          <input type="hidden" id="num" value="<%= num %>">
      </li>
      <li class="label2">
          <button id="b_delete" value="<%= pageNum %>">삭제</button>
          <button id="b_cancle" value="<%= pageNum %>">취소</button>
      </li>
   </ul>
</div>










