<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="../home/menu.jsp"/>
<div align="center">
	<div><h1>회 원 가 입</h1></div>
	<div>
		<form id="frm" action="memberJoin.do" method="post" onsubmit="return formCheck()" enctype="multipart/form-data">
		<div>
			<table border="1">
				<tr>
				<th>* 아 이 디</th>
				<td colspan="3"><input type="email" id="id" name="id" placeholder="Your E-Mail" required="required" >&nbsp;&nbsp;
				<button type="button" id="btn" onclick="isIdCheck()" value="NoCheck">중복체크</button>
				</td>
				</tr>
				<tr>
				<th width="150">* 패스워드</th>
				<td width="150"><input type="password" id="password" name="password" placeholder="Your Password" required="required" ></td>
				<th width="150">* 패스워드확인</th>
				<td width="150"><input type="password" id="password1" name="password1" placeholder="Your Password Check" required="required" ></td>				
				</tr>
				<tr>
				<th>* 이 름</th>
				<td><input type="text" id="name" name="name" placeholder="Your Name" required="required" ></td>
				<th>전화번호</th>
				<td><input type="text" id="tel" name="tel" placeholder="Your Tel"></td>				
				</tr>
				<tr>
				<th>주 소</th>
				<td colspan="3"><input type="text" id="address" name="address" placeholder="Your Address" size="67"></td>
				</tr>
				<th>사 진</th>
				<td colspan="3"><input type="file" id="file" name="file"></td>
				</tr>									
			</table>
		</div><br>
		<div>
			<button type="submit">회원가입</button>&nbsp;&nbsp;
			<button type="reset">취 소</button>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript">
	function isIdCheck() {
		var id = $("#id").val();
		if(id){
			$.ajax({ 
				url: "idCheck.do", // 클라이언트가 HTTP 요청을 보낼 서버의 URL 주소 
				data: { id: id }, // HTTP 요청과 함께 서버로 보낼 데이터 
				method: "POST", // HTTP 요청 메소드(GET, POST 등) 
				dataType: "text", // 서버에서 보내줄 데이터의 타입 (html,xml,json,text,js)
				success:function(result){
					console.log(result);
					if(result == '1'){
						alert("사용 가능한 아이디 입니다.");
						$("#btn").val("YesCheck");
						$("#btn").hide();
						$("#id").attr("readonly", true);
						$("#password").focus();
					}else{
						alert("이미 사용중인 아이디 입니다.");
						$("#id").val('');
						$("#id").focus();
					}
				},
				error:function(){
				}
			})
		}else{
			alert("아이디를 입력하세요.");
			$("#id").focus();			
		}

	}
	
	function formCheck() {
		if($("#btn").val() != "YesCheck"){
			alert("아이디 중복체크를 해주세요.");
			return false;
		}
		if($("#password").val() != $("#password1").val()){
			alert("패스워드가 일치 하지 않습니다.");
			return false;
		}
		return true;
	}
</script>
</body>
</html>