<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../home/menu.jsp"/>
<div align="center">
	<div><h1>글수정</h1></div>
	<div>
		<c:if test="${message eq null }">
		<form id="frm" action="boardUpdate.do" method="post">
		<input type="hidden" name="no" value="${board.no }">
			<div>
				<table border="1">
					<tr>
						<th width="100">제 목</th>
						<td width="250"><input type="text" id="title" name="title" value="${board.title }" size="30" placeholder="제목을 입력하세요..." required="required"></td>
						<th width="100">작성일자</th>
						<td width="150" align="center">${board.wdate }</td>						
					</tr>
					<tr>
						<th>내 용</th>
						<td colspan="4">
							<textarea rows="10" cols="90" id="subject" name="subject">${board.subject }</textarea>
						</td>
					</tr>
				</table>
			</div><br>
			<div>
				<button type="submit">글수정</button>&nbsp;&nbsp;
				<button type="button" onclick="location.href='noticeList.do'">취소</button>&nbsp;&nbsp;
			</div>
		</form>
		</c:if>
		<c:if test="${message != null }">
			<div><h1>${message }</h1></div>
			<button type="button" onclick="location.href='noticeList.do'">목록가기</button>
		</c:if>		
		
	</div>
</div>
</body>
</html>