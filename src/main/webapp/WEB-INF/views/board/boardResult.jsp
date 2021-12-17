<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../home/menu.jsp"/>
<div align="center">
	<div><h1>${message }</h1></div>
	<div><button type="button" onclick="location.href='noticeList.do'">게시판으로 가기</button></div>
</div>
</body>
</html>