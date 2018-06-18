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
	// [수정]버튼 클릭 시 수정폼에 입력한 값을  modifyPro.jsp 실행
	$("#modifyProcess").click(function() {
		var query = {
			id : $("#id").val(),
			passwd : $("#passwd").val(),
			name : $("#name").val(),
			address : $("#address").val(),
			tel : $("#tel").val()
		};
		$.ajax({
			type : "post",
			url : "modifyPro.jsp",
			data : query,
			success : function(data) {
				data = data.trim();
				if(data == "true") {//정보수정 성공
					alert("회원정보가 수정되었습니다.");
					window.location.href = "../index.jsp";
				} else {
					alert("정보 변경에 실패하였습니다.");
				}
			}
		});
	});

	// [취소]버튼 클릭 시 index.jsp로 이동
	$("#cancel").click(function() {
		window.location.href = "../index.jsp";
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
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" type="password" size="20" placeholder="6~16자 숫자/문자" maxlength="16">
      </li>
      <li><label for="name">이름</label>
          <input id="name" name="name" type="text" size="20" maxlength="10" value="<%= member.getName() %>">
      </li>
      <li><label for="address">주소</label>
          <input id="address" name="address" type="text" size="30" maxlength="50" value="<%= member.getAddress() %>">
      </li>
      <li><label for="tel">전화번호</label>
          <input id="tel" name="tel" type="tel" size="20" maxlength="20" value="<%= member.getTel()%>">
      </li>
      <li class="label2"><button id="modifyProcess">수정</button>
          <button id="cancel">취소</button>
      </li>
   </ul>
</div>
</body>
</html>



