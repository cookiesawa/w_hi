<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP EL</title>
</head>
<body>
<h3>속성 표현</h3>
<dl>
  <dt>파라미터</dt>
  <dd>${param['forwardFrom']}</dd>
  <dt>페이지 속성</dt>
  <dd>${pageAttr}</dd>
</dl>
<h3>JavaBean usage</h3>
<dl>
  <dt>ID</dt>
  <dd>${registerBean.id}</dd>
  <dt>이름</dt>
  <dd>${registerBean.name}</dd>
</dl>
</body>
</html>