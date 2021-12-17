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
	<div><h1>글쓰기</h1></div>
	<div>
		<form id="frm" action="boardInsert.do" method="post">
			<div>
				<table border="1">
					<tr>
						<th width="100">제 목</th>
						<td width="250"><input type="text" id="title" name="title" size="30" placeholder="제목을 입력하세요..." required="required"></td>
						<th width="100">작성일자</th>
						<td width="150"><input type="date" id="wdate" name="wdate" required="required"></td>						
					</tr>
					<tr>
						<th>내 용</th>
						<td colspan="4">
							<textarea rows="10" cols="90" id="subject" name="subject"></textarea>
						</td>
					</tr>
				</table>
			</div><br>
			<div>
				<button type="submit">글등록</button>&nbsp;&nbsp;
				<button type="button" onclick="location.href='noticeList.do'">취소</button>&nbsp;&nbsp;
			</div>
		</form>
	</div>
</div>
</body>
</html>