<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="ch11.LogonDataBean"
    import="ch11.LogonDBBean"
%><%
  request.setCharacterEncoding("utf-8");
  String id = (String)session.getAttribute("id");
  LogonDBBean manager = LogonDBBean.getInstance();
  //아이디와 비밀번호에 해당하는 사용자의 정보를 얻어냄
  LogonDataBean member = manager.getMember(id); 
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../style.css"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
// [변경]버튼 클릭 시 수정폼에 입력한 값을  pwmodifyPro.jsp 실행
$("#pwmodifyProcess").click(function() {
	if($("#newpasswd").val() != $("#newpasswdre").val()) {
		alert("pass");
		return;
	}
var query = {
id : $("#id").val(),
passwd : $("#passwd").val(),
newpasswd : $("#newpasswd").val()
};


$.ajax({
type : "post",
url : "pwmodifyPro.jsp",
data : query,
success : function(data) {
data = data.trim();
if(data == "true") {//비밀번호변경 성공
alert("비밀번호가 변경되었습니다.");
window.location.href = "../index.jsp";
} else {
alert("비밀번호 변경에 실패하였습니다.");
}
}
});
});

// [취소]버튼 클릭 시 index.jsp로 이동
$("#cancel").click(function() {
window.location.href = "../index.jsp";
});
});

$(document).ready(function(){
    //[비밀번호변경]버튼을 클릭
    $("#pwupdate").click(function(){
        //비멀번호변경을 위한 modify.jsp 페이지 요청
        location.href = "../pwmodify/pwmodifyForm.jsp"
    });
});
</script>
</head>
<body>
<div id="regForm" class="box">
   <ul>
      <li><p class="center">회원 정보 수정</p></li>
      
      <li><label>아이디</label> <%= member.getId() %>
          <input id="id" name="id" type="hidden" value="<%= member.getId() %>">
      </li>
      
      <li><label for="passwd">현재비밀번호</label>
          <input id="passwd" name="passwd" type="password" size="20" placeholder="6~16자 숫자/문자" maxlength="16">
      </li>
      <li><label for="newpasswd">새 비밀번호</label>
          <input id="newpasswd" name="newpasswd" type="password" size="20" maxlength="10">
      </li>
      <li><label for="newpasswdre">새 비밀번호 확인</label>
          <input id="newpasswdre" name="newpasswdre" type="password" size="30" maxlength="50" >
      </li>
      <li class="label2">
      	  <button id="pwmodifyProcess">변경</button>
          <button id="cancel">취소</button>
      </li>
   </ul>
</div>
</body>
</html>

