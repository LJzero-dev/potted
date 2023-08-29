<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<style>
#title { font-size:40px; font-weight:bold; }
#menus { margin-top:50px; }
#menus td{ height:50px; }
.menu { font-size:20px; font-weight:bold; background:white; border:0px; cursor:pointer; }
.menu:hover { color:#0B9649; }
#showpage { width:1000px; height:800px; border:0; }
#member { border:1.5px solid #CFD4CD; width:700px; height:100px; padding: 30px 30px; margin-left:70px; }
#welcome { font-size:30px; font-weight:bold; }
</style>
<c:set var="loginInfo" value="<%=loginInfo %>" />

<div style="width:1150px; margin:0 auto; margin-top:40px;">
<span id="title">MY PAGE</span><br /><br />
<table>
<tr>
	<td valign="top"><table id="menus">
	<tr><td><input type="button" value="주문조회" class="menu" onclick="loadpage(1);" /></td></tr>
	<tr><td><input type="button" value="문의하기" class="menu" onclick="loadpage(2);" /></td></tr>
	<tr><td><input type="button" value="포인트" class="menu" onclick="loadpage(3);" /></td></tr>
	<tr><td><input type="button" value="정보수정" class="menu" onclick="loadpage(4);" /></td></tr>
	<tr><td><input type="button" value="옥션조회" class="menu" onclick="loadpage(5);" /></td></tr>
	<tr><td><input type="button" value="회원탈퇴" class="menu" onclick="loadpage(6);" /></td></tr>
	</table></td>
	<td width="100px;"></td>
	<td width="60px;"><table>
	<tr><td><div id="member">
		<span id="welcome">${loginInfo.getMi_name()}</span> 님 안녕하세요. <br />
		<div align="right">보유 포인트 : <br />
		${loginInfo.getMi_point()}</div>
	</div></td></tr>
	<tr><td><iframe id="showpage" src="orderInfo" ></iframe></td></tr>
	</table></td>
</tr>
</table>
</div>
<script>
function loadpage(num) {
	if(num == 1) {
		document.getElementById("showpage").src = "orderInfo";
	} else if(num == 2) {
		document.getElementById("showpage").src = "ask";
	} else if(num == 3) {
		document.getElementById("showpage").src = "pointInfo";
	} else if(num == 4) {
		document.getElementById("showpage").src = "setInfo";
	} else if(num == 5) {
		document.getElementById("showpage").src = "auctionInfo";
	} else {
		document.getElementById("showpage").src = "out";
	}
}
</script>


<%@ include file="../inc/inc_foot.jsp" %>