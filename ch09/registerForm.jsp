<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register Form</title>
</head>
<body>
<form method="post" action="registerPro.jsp">
	<table style="border:1px solid green; background-color:#ffcccc;">
		<tr>
			<td><label for="id">아이디</label></td>
			<td><input id="id" name="id" type="text" size="20"
				maxlength="30" placeholder="example@hong.com" autofocus required></td>
		</tr>
		<tr>
			<td><label for="passwd">비밀번호</label></td>
			<td><input id="passwd" name="passwd" type="password" size="20"
				maxlength="12" placeholder="6~12자 숫자/문자" required></td>
		</tr>
		<tr>
			<td><label for="name">이름</label></td>
			<td><input id="name" name="name" type="text" size="20"
				maxlength="10" placeholder="홍길동" required></td>
		</tr>
		<tr>
			<td clospan="2" style="text-align:center;"><input type="submit" value="회원가입">
			<input type="reset" value="다시작성"></td>
		</tr>
	</table>
</form>
</body>
</html>
