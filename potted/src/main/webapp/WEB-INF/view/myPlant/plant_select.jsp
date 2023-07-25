<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<script>
function select(tmp) {
	if(confirm('선택하신 식물이 ' + tmp + ' 식물이 맞습니까?')) {
		location="plantSelect?plant=" + (tmp == "초급" ? "4" : tmp == "중급" ? "2" : "1");
	}
}
</script>
MY PLANT
<div style="width:1200px; margin: 0 auto; position:relative;" >
<div style="position:absolute; right:0px;" >
<table style="background-color: 808080;">
<tr>
<td>초급자용</td><td>3회</td>
</tr>
<tr>
<td>중급자용</td><td>3회</td>
</tr>
<tr>
<td>고급자용</td><td>3회</td>
</tr>
<tr>
<td>누적 포인트</td><td>300P</td>
</tr>
</table>
</div>
<table style="width:1200px; height:*; " >
<tr><td colspan="5" align="center"><h1>식물을 선택해 주세요</h1></td></tr>
<tr>
<td colspan="2" align="center"><h3>초급자용</h3><td colspan="2" align="center"><h3>중급자용</h3><td colspan="2" align="center"><h3>상급자용</h3>
</tr>
<tr>
<td><img src="/potted/resources/images/myPlant/tree1.png" onclick="select('초급');" style="width:200px; height:200px; cursor:pointer;" /></td>
<td style="">하루에 한번씩 물을 줘야 해요<br /><br />보상은 최대 500P 입니다.<br /><br />3일의 시간이 필요합니다.</td>
<td><img src="/potted/resources/images/myPlant/tree2.png" onclick="select('중급');" style="width:200px; height:200px; cursor:pointer;" /></td>
<td style="">하루에 두번씩 물을 줘야 해요<br /><br />보상은 최대 1500P 입니다.<br /><br />7일의 시간이 필요합니다.</td>
<td><img src="/potted/resources/images/myPlant/tree3.png" onclick="select('고급');" style="width:200px; height:200px; cursor:pointer;" /></td>
<td style="">하루에 세번씩 물을 줘야 해요<br /><br />보상은 최대 5000P 입니다.<br /><br />14일의 시간이 필요합니다.</td>
</tr>
</table>
</div>
<%@ include file="../inc/inc_foot.jsp" %>