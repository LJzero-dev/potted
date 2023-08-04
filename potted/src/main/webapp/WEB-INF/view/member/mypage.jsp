<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<style>
#menus { margin-bottom:350px; }
#menus td{ height:50px; }
.menu { font-size:20px; font-weight:bold; background:white; border:0px; cursor:pointer; }
.menu:hover { color:#0B9649; }
#showpage { width:1000px; height:800px; border:0; }
</style>
<h2>마이페이지</h2>
<c:set var="loginInfo" value="<%=loginInfo %>" />

<div style="width:1200px; margin:0 auto; margin-top:80px;">
<table>
<tr>
	<td><table id="menus">
	<tr><td><input type="button" value="주문조회" class="menu" onclick="loadpage(1);" /></td></tr>
	<tr><td><input type="button" value="문의하기" class="menu" onclick="loadpage(2);" /></td></tr>
	<tr><td><input type="button" value="포인트" class="menu" onclick="loadpage(3);" /></td></tr>
	<tr><td><input type="button" value="정보수정" class="menu" onclick="loadpage(4);" /></td></tr>
	<tr><td><input type="button" value="옥션조회" class="menu" onclick="loadpage(5);" /></td></tr>
	<tr><td><input type="button" value="회원탈퇴" class="menu" onclick="loadpage(6);" /></td></tr>
	</table></td>
	<td width="60px;"></td>
	<td>
	<iframe id="showpage" src="orderInfo" ></iframe>
	</td>
</tr>
</table>
</div>


<%@ include file="../inc/inc_foot.jsp" %>