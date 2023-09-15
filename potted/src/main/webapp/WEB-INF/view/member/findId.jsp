<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
select { border:1.5px solid #ced4da; padding:6px 12px; border-radius:5px; align:right; }
input {	padding:9px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
#divBox { text-align:center; }
.find { font-size:17px; font-weight:bold; }
</style>
</head>
<body>
<div id="divBox">
<fieldset><legend class="find">아이디 찾기</legend>
<form name="frmfindId" action="findIdProc" method="post" onsubmit="return chkVal1(this);">
<input type="text" placeholder="이메일" name="mi_email" /><br />
<input type="submit" value="아이디 찾기" />
</form></fieldset><br />
<hr /><br />
<fieldset><legend class="find">비밀번호 찾기</legend>
<form name="frmfindPw" action="findPwProc" method="post" onsubmit="return chkVal2(this);">
<input type="text" placeholder="아이디" name="mi_id" /><br />
<input type="text" placeholder="이메일" name="mi_email" /><br />
<input type="submit" value="비밀번호 재설정" />
</form></fieldset>
</div>
</body>
</html>
<script>
function chkVal1(form){
	if (form.mi_email.value == "") {
		alert("이메일을 입력해주세요.");
		form.mi_email.focus();
		return false;
	}
}

function chkVal2(form){
	if (form.mi_id.value == "") {
		alert("아이디 입력해주세요.");
		form.mi_id.focus();
		return false;
	}
	if (form.mi_email.value == "") {
		alert("이메일을 입력해주세요.");
		form.mi_email.focus();
		return false;
	}
}
</script>