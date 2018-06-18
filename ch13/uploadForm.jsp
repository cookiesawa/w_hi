<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FileUpload Form</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
<h1>폼태그 기반 파일업로드</h1>

<%-- 업로드 폼 작성 --%>
<form id="uploadFrm" enctype="multipart/form-data" action="uploadPro.jsp" method="POST">
   <input name="username" type="text" />
   <input name="userfile" type="file" />
   <input type="submit" value="파일 전송" />
</form>
<hr/>

<h1>Ajax 기반 파일업로드</h1>
<button id="ajaxupload" onclick="doAJAXUpload();">AJAX Fileupload</button>
<script>
function doAJAXUpload() {

   // AJAX Upload 소스 작성
   var uploadFrm = document.getElementById("uploadFrm");
   var frmData = new FormData(uploadFrm);
   
   var xhr = new XMLHttpRequest();
   xhr.onreadystatechange = function(){
      if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
         document.getElementById("ajaxresult").innerHTML = xhr.responseText;
      }
   }

   xhr.open("post", "uploadPro.jsp");
   xhr.send(frmData);
   
}
</script>
<div id="ajaxresult"></div>
<hr/>
<h1>jQuery 기반 파일업로드</h1>
<button id="jqupload">jQuery Fileupload</button>
<script>

// jQuery 업로드 소스 작성
$(document).ready(function(){
   $("#jqupload").click(function(){
      var frmData = new FormData($("#uploadFrm")[0]);
      
      $.ajax({
         url: 'uploadPro.jsp',
         type: 'POST',
         data: frmData,
         async: false,
         cache: false,
         contentType: false,
         enctype: 'multipart/form-data',
         processData: false,
         success: function (response){
            $("#jqresult").html(response);
         }
      });
   });
});

</script>
<div id="jqresult"></div>
</body>
</html>