<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery Ajax메소드 - $.post()</title>
<style type="text/css">
#result{
   width: 300px; height: 300px; border: 5px double #6699FF;
}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
   $(document).ready(function(){
      $("#b1").click(function(){
         $.post("process.jsp",
            {name:"JavaWebProgramming", status:"맑음"},
            function(data, status){ // 응답내용 처리
               if(status == "success") // 요청이 제대로 처리되었으면
                  $("#result").html(data);
            });
         });
   });
</script>
</head>
<body>
   <button id = "b1">결과</button> <div id = "result"></div>
</body>
</html>