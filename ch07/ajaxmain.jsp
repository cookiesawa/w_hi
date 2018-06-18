<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AJAX Main</title>
<script>
var httpRequest = null;
function doOnload(){
   document.getElementById("ajaxButton")
   .addEventListener("click", makeRequest);
}
function makeRequest(){
   httpRequest = new XMLHttpRequest();
   httpRequest.onreadystatechange = updateContents;
   httpRequest.open("POST", "ajaxctnt.jsp");
   httpRequest.send();
}
function updateContents(){
   if(httpRequest.readyState == XMLHttpRequest.DONE){
      if(httpRequest.status == 200){
         document.getElementById("content").innerHTML = httpRequest.responseText;
      }
   }
}
</script>
</head>
<body onload ="doOnload();">
<button id = "ajaxButton" type="button">
Make a request</button>
<div id = "content"></div>
</body>
</html>