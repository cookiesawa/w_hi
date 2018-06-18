<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="ch12.BoardDBBean"
    import="ch12.BoardDataBean"
%>
<script>
var wStatus = true;

$(document).ready(function(){
    //글수정폼의 [수정]버튼을 클릭하면 자동실행
    $("#b_update").click(function(){
        formCheckIt();//글수정 폼의 입력 여부 체크
        if(wStatus){
        	// 페이지 번호 변수화 
        	// 화면에서 입력받은 정보를 JSON 객체로 패키징
        	// $.ajax 호출을 통해 게시글 변경 요청
        	// 변경 성공 후 목록화면으로 이동
        	// 변경 실패시 "비밀번호 틀림" 메시지 출력 후 비밀번호 초기화
        	// [수정]버튼의 값으로 지정된 현재페이지 번호를 얻어냄
        	var pageNum = $("#b_update").val();
        	//글 번호와 글 수정폼에 입력된 값을 얻어내서 query에 저장
        	var query = {
        			subject:$("#subject").val(),
        			content:$("#content").val(),
        			passwd:$("#passwd").val(),
        			num:$("#num").val()
        	};
        	
        	//query값을 갖고 updatePro.jsp 실행
        	$.ajax({
        		type: "POST",
        		url: "../board/updatePro.jsp",
        		data: query,
        		success: function(date){
        			data = data.trim();
        			if(data == "true"){ //글수정 처리가 성공한 경우
        				alert("글이 수정되었습니다.");
        				var query = "../board/list.jsp?pageNum="+pageNum;
        				$("#main_board").load(query);
        			}else{//글수정 처리가 실패한 경우
        				alert("비밀번호 틀림.");
        				$("#passwd").val("");
        				$("#passwd").focus();
        			}
        		}
        	});
        }
    });
    
    //글수정폼의 [취소]버튼을 클릭하면 자동실행
    //글목록보기 list.jsp페이지를 표시
    $("#b_cancle").click(function(){
        var pageNum = $("#b_cancle").val();
        var query = "../board/list.jsp?pageNum="+pageNum;
        $("#main_board").load(query);
    });
     
});

//글수정 폼의 입력값 유무 확인
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
  //수정할 글의 번호와 수정할 글이 위치한 페이지 번호를 얻어냄
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

  //주어진 글번호에 해당하는 수정할 글을 가져옴 
  BoardDBBean dbPro = BoardDBBean.getInstance();
  BoardDataBean article = dbPro.updateGetArticle(num);
%>
<%--수정할 글의 원래 저장내용을 글 수정폼에 표시 --%>
<div id="editForm" class="box">
   <ul>
      <li><p class="center">글수정</p></li>
      <li><label for="subject">제목</label>
          <input id="subject" name="subject" style="width:200px;" type="text" maxlength="50" value="<%= article.getSubject() %>">
          <input type="hidden" id="num" value="<%= num %>">
      </li>
      <li><label for="content">내용</label>
          <textarea id="content" rows="13" cols="50" style="width:100%;height:400px;"><%= article.getContent() %></textarea>
      </li>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" style="width:200px;" type="password" placeholder="6~16자 숫자/문자" maxlength="16">
      </li>
      <li class="label2">
          <button id="b_update" value="<%= pageNum %>">수정</button>
          <button id="b_cancle" value="<%= pageNum %>">취소</button>
      </li>
   </ul>
</div>