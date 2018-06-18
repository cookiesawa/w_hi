<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../style.css"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
    // [탈퇴]버튼을 클릭
    $("#delete").click(function() {
        var query = {passwd:$("#passwd").val()};
        
        $.ajax({
        	type: "POST",
        	url: "deletePro.jsp",
        	data: query,
        	success: function(data) {
        		data = data.trim();
        		if(data == "true") {//탈퇴 성공
        			alert("탈퇴 되었습니다.");
        			location.href = "../index.jsp";
        		} else {
        			alert("탈퇴에 실패하였습니다.");
        		}
           }
        });
    });

    // [취소]버튼 클릭 시 index.jsp로 이동
    $("#cancel").click(function() {
        location.href = "../index.jsp";
    });
});
</script>
</head>
<body>
<div id="status">
  <ul>
     <li><label for="passwd">비밀번호</label>
         <input id="passwd" name="passwd" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16">
     </li>
     <li class="label2">
         <button id="delete">탈퇴</button>
         <button id="cancel">취소</button>
     </li>
  </ul>
</div>
</body>
</html>



