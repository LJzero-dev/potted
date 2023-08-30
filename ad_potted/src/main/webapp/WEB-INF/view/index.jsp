<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/inc_head.jsp" %>
<style>
#menus { margin-bottom:350px; }
#menus td{ height:50px; }
.menu { font-size:20px; font-weight:bold; background:white; border:0px; cursor:pointer; }
.menu:hover { color:#0B9649; }
#showpage { width:1000px; height:800px; border:0; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/utils.js"></script>
<script>
function loadpage(num) {
	if(num == 1) {
		document.getElementById("showpage").src = "salesSlip";
	} else if(num == 2) {
		document.getElementById("showpage").src = "schedule";
	} else if(num == 3) {
		document.getElementById("showpage").src = "memberList";
	} else if(num == 4) {
		document.getElementById("showpage").src = "setbanner";
	} else if(num == 5) {
		document.getElementById("showpage").src = "";
	} else {
		document.getElementById("showpage").src = "";
	}
}
</script>

<div style="width:1200px; margin:0 auto; margin-top:80px;">
<table>
<tr>
	<td><table id="menus">
	<tr><td><input type="button" value="매출 전표📊" class="menu" onclick="loadpage(1);" /></td></tr>
	<tr><td><input type="button" value="일정 관리🗓" class="menu" onclick="loadpage(2);" /></td></tr>
	<tr><td><input type="button" value="회원 관리😄" class="menu" onclick="loadpage(3);" /></td></tr>
	<tr><td><input type="button" value="배너 설정📁" class="menu" onclick="loadpage(4);" /></td></tr>
	<tr><td><input type="button" value="주문 관리📦" class="menu" onclick="loadpage(5);" /></td></tr>
	<tr><td><input type="button" value="옥션 주문 관리📦" class="menu" onclick="loadpage(6);" /></td></tr>
	</table></td>
	<td width="60px;"></td>
	<td>
	<iframe id="showpage" src="salesSlip" ></iframe>
	</td>
</tr>
</table>
</div>
<%@ include file="inc/inc_foot.jsp" %>