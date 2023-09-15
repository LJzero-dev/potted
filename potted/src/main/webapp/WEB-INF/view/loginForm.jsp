<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/inc_head.jsp" %>
<style>
#loginStyle { margin-top:200px; }
.put { font-size:18px; width:250px; height:30px; }
.fonts { font-size: 20px; }
#btn { width:360px; height:40px; background:#0B9649; color:white; font-size: 15px; border-radius: 20px; border:1.5px solid  #6E6E6E; cursor: pointer; }
#kakao { width:360px; height:50px; background:#F7E600; color:#3A1D1D; font-size: 15px; border-radius: 10px; cursor: pointer; }
.simg { width:30px; height:30px; margin-top:7px; postion:absolute; }
#start { font-size: 16px; font-weight: bold; }
a:hover { text-decoration:none; color:#0B9649; }
.join { font-size:20px; font-weight:bold; text-align:center; }
.inFind { font-size:15px; font-weight:bold; text-align:center; }
</style>

<div id="loginStyle" align="center" >
<img src="/potted/resources/images/main/loginlogo.png" style="width:100px; height:100px;" />
<form name="frmLogin" action="login" method="post"><br />
<table>
<tr><td><span class="fonts">아이디 : </span></td>
<td><input type="text" class="put" name="uid" value="" placeholder="ID" /></td></tr>
<tr><td><span class="fonts">비밀번호 : </span></td>
<td><input type="password" class="put" name="pwd" value="" placeholder="PW" /></td></tr>
<tr><td><br /></td></tr>
<tr><td colspan="2" align="center"><input type="submit" id="btn" value="로그인" /><br /><br /></td></tr>
<tr height="50" valign="top"><td class="inFind" colspan="2"><a href="javascript:findId();">아이디 찾기</a> | <a href="javascript:findPw();">비밀번호 찾기</a></td></tr>
<tr height="50" valign="top"><td class="join" colspan="2"><a href="joinForm">회원가입</a></td></tr>
<tr><td colspan="2" align="center"><a href="https://kauth.kakao.com/oauth/authorize?client_id=5a2d9d0124bccf5124c37344be839c1c&redirect_uri=http://localhost:8086/potted/kakaoLoginProc&response_type=code" ><div id="kakao"><table><tr>
<td><img src="/potted/resources/images/main/kakao_login.png" class="simg" /></td><td>&nbsp;&nbsp;<span id="start">카카오톡으로 시작하기</span></td>
</tr></table></div></a></td></tr>
</table>
</form>
</div>
<script>
function findId() {
	awin = window.open("findId", "findId", "width=600,height=600,left=500,top=200");
}
function findPw() {
	awin = window.open("findPw", "findPw", "width=600,height=600,left=500,top=200");
}
</script>
<%@ include file="inc/inc_foot.jsp" %>