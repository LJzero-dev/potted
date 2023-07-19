<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<script>
function watering() {
	$("#wotter").show();
	setTimeout(function() {
		$("#wotter").hide();
	}, 2000);
}
function nutrients() {
	$("#nutrients").show();
	setTimeout(function() {
		$("#nutrients").hide();
	}, 2000);
}
</script>
MY PLANT
<div style="width:1200px; margin: 0 auto; position:relative;" >
<img src="/potted/resources/images/myPlant/water_icon.png" id="wotter" style="position:fixed; width:250px; height:250px; left: 700px; top:200px; transform:rotate(-35deg); display:none;" />
<img src="/potted/resources/images/myPlant/nutrients.png" id="nutrients" style="position:fixed; width:80px; height:250px; left: 700px; top:500px; transform:rotate(250deg); display:none;" />
<div style="position:absolute; right:0px;" >
<table style="background-color: 808080;">
<tr>
<td><img src="/potted/resources/images/myPlant/help.png" style="width:150px; height:150px;" /></td>
</tr>
</table>
</div>
<table style="width:1200px; height:700px;" >
<tr height="100px">
<td width="25%" rowspan="2"><img src="/potted/resources/images/myPlant/sun.png" style="width:250px; height:250px;" /></td>
<td width="*%"></td>
<td width="25%"></td>
</tr>
<tr height="200px">
<td rowspan="2"><img src="/potted/resources/images/myPlant/tree1.png" style="width:500px; height:500px;" /></td>
<td><div style="width:250px; height:200px; text-align:center;"><h3>영양제 : 3개<br />(HP 1000 회복)</h3><input type="button" value="영양제 주기" onclick="nutrients();" style="width:250px; height:70px;"><h3>(쿨타임 24시간)</h3></div></td>
</tr>
<tr height="200px">
<td>설명</td>
<td><div style="width:250px; height:200px; text-align:center;"><h3>물을 주면 기간동안<br />식물의 HP가 닳지 않아요</h3><input type="button" value="물주기" onclick="watering();" style="width:250px; height:70px;"><h3>(쿨타임 24시간)</h3></div></td>
</tr>
</table>
</div>
<%@ include file="../inc/inc_foot.jsp" %>