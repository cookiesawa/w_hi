<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../style.css"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>

var status = false;

$(document).ready(function(){
    //[회원가입]버튼을 클릭하면 자동실행       
    $("#register").click(function(){//[회원가입]버튼 클릭
        //회원가입폼 registerForm.jsp 페이지를 
        //id 속성값이 main_auth인 영역에 로드
        location.href = "../register/registerForm.jsp";
    });
    
    //[로그인]버튼을 클릭하면 자동실행    
    //입력한 아이디와 비밀번호를 갖고 loginPro.jsp 페이지 실행
    $("#login").click(function(){
        checkIt();//입력폼에 입력한 상황 체크
        if(status){
          //입력된 사용자의 아이디와 비밀번호를 얻어냄
          var query = {id : $("#id").val(), passwd:$("#passwd").val()};
          
          $.ajax({
             type: "POST",
             url: "loginPro.jsp",
             data: query,
             success: function(data) {
            	 data = data.trim();
                 if(data == "true") { //로그인 성공
                	 location.href = "../index.jsp";
                 } else {
                     alert("아이디 또는 비밀번호가 맞지 않습니다.");
                     $("#passwd").val("");
                     $("#passwd").focus();
                 }
             }
          });
        }
    });
 });

//인증되지 않은 사용자 영역에서 사용하는 입력 폼의 입력값 유무 확인
function checkIt(){
    status = true;
    if(!$.trim($("#id").val())){
        alert("아이디를 입력하세요.");
        $("#id").focus();
        status = false;
        return false;
    }
    
    if(!$.trim($("#passwd").val())){
        alert("비밀번호를 입력하세요.");
        $("#passwd").focus();
        status = false;
        return false;
    }
}
</script>
</head>
<body>
  <div id="status">
     <ul>
        <li><label for="id">아이디</label>
            <input id="id" name="id" type="email" size="20" 
              maxlength="50" placeholder="example@kings.com"></li>
        <li><label for="passwd">비밀번호</label>
            <input id="passwd" name="passwd" type="password" 
              size="20" placeholder="6~16자 숫자/문자" maxlength="16"></li>
        <li class="label2">
            <button id="login">로그인</button>
            <button id="register">회원가입</button></li>
     </ul>
  </div>
</body>
</html>











