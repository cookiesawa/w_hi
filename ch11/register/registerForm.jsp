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
    //[ID중복확인]버튼을 클릭하면 자동실행
    //입력한 아이디 값을 갖고 confirmId.jsp페이지 실행
    $("#checkId").click(function(){
      if($("#id").val()){
        //아이디를 입력하고 [ID중복확인]버튼을 클릭한 경우
        var query = {id:$("#id").val()};
        
        $.ajax({
            type:"post",//요청방식
            url:"confirmId.jsp",//요청페이지
            data:query,//파라미터
            success:function(data){//요청페이지 처리에 성공시
            	data = data.trim();
                if(data == "false"){//사용할 수 없는 아이디
                    alert("사용할 수 없는 아이디");
                    $("#id").val("");
                 } else { //사용할 수 있는 아이디
                    alert("사용할 수 있는 아이디");
                 }
            }
        });
      }else{//아이디를 입력하지 않고 [ID중복확인]버튼을 클릭한 경우
          alert("사용할 아이디를 입력");
          $("#id").focus();
      }
    });
    
    //[가입하기]버튼을 클릭하면 자동실행
    //사용자가 가입폼인 registerForm.jsp페이지에 입력한 내용을 갖고
    //registerPro.jsp페이지 실행
    $("#process").click(function(){
       checkIt(); //입력폼에 입력한 상황 체크
       
       if(status){
          var query = {id:$("#id").val(), 
                  passwd:$("#passwd").val(),
                  name:$("#name").val(),
                  address:$("#address").val(),
                  tel:$("#tel").val()};
          
          $.ajax({
              type:"post",
              url:"registerPro.jsp",
              data:query,
              success:function(data){
                  location.href = "../index.jsp";
              }
          });
       }
    });
    
    //[취소]버튼을 클릭하면 자동실행
    $("#cancle").click(function(){
        location.href = "../index.jsp";
    });

 });

//사용자가 입력폼에 입력한 상황을 체크
function checkIt() {
    status = true;
    
    if(!$("#id").val()) {//아이디를 입력하지 않으면 수행
        alert("아이디를 입력하세요");
        $("#id").focus();
        status = false;
        return false;//사용자가 서비스를 요청한 시점으로 돌아감
    }
    
    if(!$("#passwd").val()) {//비밀번호를 입력하지 않으면 수행
        alert("비밀번호를 입력하세요");
        $("#passwd").focus();
        status = false;
        return false;
    }
    //비밀번호와 재입력비밀번호가 같지않으면 수행
    if($("#passwd").val() != $("#repass").val()){
        alert("비밀번호를 동일하게 입력하세요");
        $("#repass").focus();
        status = false;
        return false;
    }
    
    if(!$("#name").val()) {//이름을 입력하지 않으면 수행
        alert("사용자 이름을 입력하세요");
        $("#name").focus();
        status = false;
        return false;
    }
    
    if(!$("#address").val()) {//주소를 입력하지 않으면 수행
        alert("주소를 입력하세요");
        $("#address").focus();
        status = false;
        return false;
    }
    
    if(!$("#tel").val()) {//전화번호를 입력하지 않으면 수행
        alert("전화번호를 입력하세요");
        $("#tel").focus();
        status = false;
        return false;
    }  
}
</script>
</head>
<body>
<div id="regForm" class="box">
   <ul>
      <li><label for="id">아이디</label>
          <input id="id" name="id" type="email" size="20" 
           maxlength="50" placeholder="example@kings.com" autofocus>
          <button id="checkId">ID중복확인</button></li>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="passwd" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16"></li>
      <li><label for="repass">비밀번호 재입력</label>
          <input id="repass" name="repass" type="password" 
           size="20" placeholder="비밀번호재입력" maxlength="16"></li>
      <li><label for="name">이름</label>
          <input id="name" name="name" type="text" 
           size="20" placeholder="홍길동" maxlength="10"></li>
      <li><label for="address">주소</label>
          <input id="address" name="address" type="text" 
           size="30" placeholder="주소 입력" maxlength="50"></li>
      <li><label for="tel">전화번호</label>
          <input id="tel" name="tel" type="tel" 
           size="20" placeholder="전화번호 입력" maxlength="20"></li>
      <li class="label2"><button id="process">가입하기</button>
          <button id="cancle">취소</button></li>
   </ul>
</div>
</body>
</html>



