<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<style>
#title { font-size:25px; font-weight:bold; }
#divbox { border: 1px solid #0B9649; width:500px; height:300px; margin-left:250px; text-align:center; }
#btn1 { border: 1px solid black; background-color: white; color: black; font-weight: bold; border-radius:20px; width:50px; hegiht:20px; cursor: pointer; }
#btn2 { border: 1px solid black; background-color: black; color: white; font-weight: bold; border-radius:20px; width:50px; hegiht:20px; cursor: pointer; }
</style>
</head>
<body>
<div id="divbox"><br />
<span id="title">회원 탈퇴</span><br /><br />
탈퇴 시 가입된 회원정보가 모두 삭제됩니다.<br />
작성하신 게시물은 삭제되지 않습니다.<br />
탈퇴 후 같은 아이디로 재가입이 불가합니다.<br />
보유 포인트도 모두 소멸 되며, 복구 불가 합니다.<br />
회원 탈퇴를 진행하시겠습니까?<br /><br /><br />
<input type="button" id="btn2" value="탈퇴" onclick="isOut();" />
</div>
<script>
function isOut() {
	if(confirm("정말 탈퇴하시겠습니까?")) {
		location.href="memberOut";
	}
}
</script>
</body>
</html>