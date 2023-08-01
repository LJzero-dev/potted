<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/inc_head.jsp" %>
<style>
#loginStyle { margin-top:200px; }
.put { font-size:18px; width:250px; height:30px; }
.fonts { font-size: 20px; }
#btn { width:360px; height:30px; background:#0B9649; color:white; font-size: 15px; border-radius: 20px; border:1.5px solid  #6E6E6E; cursor: pointer; }
</style>

<div id="loginStyle" align="center" >
<img src="/potted/resources/images/main/loginlogo.png" style="width:100px; height:100px;" />
<form name="frmLogin" action="login" method="post"><br />
<table>
<tr><td><span class="fonts">아이디 : </span></td>
<td><input type="text" class="put" name="uid" value="test1" placeholder="ID" /></td></tr>
<tr><td><span class="fonts">비밀번호 : </span></td>
<td><input type="password" class="put" name="pwd" value="1234" placeholder="PW" /></td></tr>
<tr><td><br /></td></tr>
<tr><td colspan="2" align="center"><input type="submit" id="btn" value="로그인" /></td></tr>
</table>
</form>
</div>
<%@ include file="inc/inc_foot.jsp" %>