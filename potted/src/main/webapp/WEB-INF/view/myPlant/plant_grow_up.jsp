<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.time.*" %>
<%
MemberTree mt = (MemberTree)request.getAttribute("mt");
%>
<script>
// 시간 확인 해서 사용가능일 경우에만 사용
// 사용 가능한 경우 물준 후 물주기 모션 이후 디비 다녀와서 새로고침?

function watering() {
	if (document.getElementById("watter").value == "y") {
		$("#wotter").show();
		setTimeout(function() {
			$.ajax({
				type : "POST",
				url : "./plantWatering",
				success : function() {
					location.href="myPlant";
				}
			});
		}, 2000);
	} else {
		alert("사용 가능한 시간이 아닙니다.");
	}
}
function nutrients() {
	$("#nutrients").show();
	setTimeout(function() {
		$("#nutrients").hide();
	}, 2000);
}
function updateTimer() {
    const future = Date.parse("<%=mt.getMt_date() %>");
 const now = new Date();
 const diff = future - now;
 const days = Math.floor(diff / (1000 * 60 * 60 * 24));
 const hours = Math.floor(diff / (1000 * 60 * 60));
 const mins = Math.floor(diff / (1000 * 60));
 const secs = Math.floor(diff / 1000);

 const d = days;
 const h = hours - days * 24;
 const m = mins - hours * 60;
 const s = secs - mins * 60;
 if (diff < 0) {
	 document.getElementById("timer").innerHTML ='<div>사용가능</div>';
	document.getElementById("watter").value = 'y';
 } else {
 document.getElementById("timer").innerHTML =
  '<div>' + h + '<span>시 </span>' +
   m + '<span>분 </span>' +
   s + '<span>초</span></div>';
   }
}

setInterval(updateTimer, 1000);
</script>
MY PLANT
<div style="width:1200px; margin: 0 auto; position:relative;" >
<input type="hidden" id="watter" value="">
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
<td rowspan="2"><img src="/potted/resources/images/myPlant/tree<%=mt.getMt_grade() %>.png" style="width:500px; height:500px;" /></td>
<td><div style="width:250px; height:200px; text-align:center;"><h3>영양제 : <%=mt.getMi_protein() %>개<br />(HP 1000 회복)</h3><input type="button" value="영양제 주기" onclick="nutrients();" style="width:250px; height:70px;"><h3>(쿨타임 24시간)</h3></div></td>
</tr>
<tr height="200px">
<td>설명</td>
<td><div style="width:250px; height:200px; text-align:center;"><h3>물을 주면 <%=(mt.getMt_grade() == 1 ? "24" : (mt.getMt_grade() == 2 ? "12" : "6")) %>시간동안<br />식물의 HP가 닳지 않아요</h3><input type="button" value="물주기" onclick="watering();" style="width:250px; height:70px;"><h3>(쿨타임)</h3><h3 id="timer"><br /></h3></div></td>
</tr>
</table>
</div>
<%@ include file="../inc/inc_foot.jsp" %>