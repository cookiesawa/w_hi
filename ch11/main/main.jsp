<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../style.css"/>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
    /*-- 인증된 사용자 영역을 처리하는 버튼들 ---*/
    //[회원 정보 변경]버튼을 클릭
    $("#update").click(function(){
        //회원정보를 수정을 위한 modify.jsp 페이지 요청
        location.href = "../modify/modifyForm.jsp"
    });
    
    //[탈퇴]버튼을 클릭
    $("#delete").click(function(){
        //회원 탈퇴를 위한 delete.jsp 페이지 요청
        location.href = "../delete/deleteForm.jsp"
    });
    
    //[로그아웃]버튼을 클릭하면 자동실행
    //logout.jsp페이지를 실행
    $("#logout").click(function(){//[회원정보수정]버튼 클릭
        $.ajax({
           type: "POST",
           url: "../logout/logout.jsp",
           success: function(data){
        	   location.href = "../index.jsp";
           }
        });
    });
 });
</script>
</head>
<body>
<%
//id세션 속성의 값을 얻어내서 id변수에 저장
//인증된 사용자의 경우  id세션 속성의 값 null또는 공백이 아님
String id = (String)session.getAttribute("id");
%>
  <div id="status">
     <ul>
        <li><b><%= id %></b>님이 로그인 하셨습니다.</li>
        <li class="label2"><button id="logout">로그아웃</button>
           <button id="update">정보 변경</button>
           <button id="delete">탈퇴</button></li>
     </ul>
  </div>
</body>
</html>








