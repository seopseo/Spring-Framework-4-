<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="menu.jsp" />
<div align="center">
	<div><h1>WellCome to my Web-site</h1></div>
	<button type="button" onClick="memberList()">멤버리스트 ajax 호출</button>
	<div id="memberList">
	
	</div>
</div>
<script type="text/javascript">
	function memberList() {
		$.ajax({ 
			url: "ajaxMemberlist.do", 
			dataType: "json",
			success:function(data){
				//console.log(data);
				//alert(data);
				//$("#memberList").html(JSON.stringify(data));
				if(data.length > 0){
					viewHtml(data);
				}else{
					alert("데이터가 존재하지 않습니다.");
				}
			},
			error:function(){
			}
		})		
	}
	
	function viewHtml(data) {
		var html = "<br><table border=1>";
		html += "<tr>";
		html += "<th width='150'>아이디</th>";
		html += "<th width='150'>이 름</th>";
		html += "<th width='150'>전화번호</th>";
		html += "<th width='150'>주 소</th>";
		html += "<th width='150'>권 한</th>";
		html += "</tr>";		
		$(data).each(function(index, item) {
			html += "<tr align='center'>";
			html += "<td>" + item.id + "</td>";
			html += "<td>" + item.name + "</td>";
			html += "<td>" + item.tel + "</td>";
			html += "<td>" + item.address + "</td>";
			html += "<td>" + item.author + "</td>";
			html += "</tr>";
		});
		html += "</table>";
		html += "<br>";
		html += "<button type='button' onclick='closeView()'>창닫기</button>";
		//console.log(html);
		$("#memberList").html(html);
	}	
	
	function closeView(data) {
		$("#memberList").empty();
	}	
</script>
</body>
</html>