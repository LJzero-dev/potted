<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/inc_head.jsp" %>
<style>
#menubars { width:1500px; margin:0 auto; }
#bars { background-color: #087237; width:200px; }
#menus { margin-bottom:350px; }
#menus td{ height:50px; }
.menua { font-size:20px; font-weight:bold; border:0px; cursor:pointer; background-color: #087237; color:white; }
.menua:hover { color:black; }
#showpage { width:1000px; height:800px; border:0; margin-top:50px; }
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

<div id="menubars">
<table>
<tr>
	<td id="bars"><table id="menus">
	<tr><td><input type="button" value="📊통계" class="menua" onclick="loadpage(1);" /></td></tr>
	<tr><td><input type="button" value="🗓일정 관리" class="menua" onclick="loadpage(2);" /></td></tr>
	<tr><td><input type="button" value="😄회원 관리" class="menua" onclick="loadpage(3);" /></td></tr>
	<tr><td><input type="button" value="📁배너 설정" class="menua" onclick="loadpage(4);" /></td></tr>
	<tr><td><input type="button" value="📦주문 관리" class="menua" onclick="loadpage(5);" /></td></tr>
	<tr><td><input type="button" value="📦옥션 주문 관리" class="menua" onclick="loadpage(6);" /></td></tr>
	</table></td>
	<td width="120px;"></td>
	<td>
	<iframe id="showpage" src="salesSlip" ></iframe>
	</td>
</tr>
</table>
</div>
<%@ include file="inc/inc_foot.jsp" %>