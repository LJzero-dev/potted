<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");

ArrayList<MemberPoint> memberPoint = (ArrayList<MemberPoint>)request.getAttribute("memberPoint");

%>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<style>
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; }
#title { font-size:20px; font-weight: bold; }
#listbox { margin-left:60px; }
#table th, td{ font-weight: lighter; border:1.5px solid #CFD4CD; }
#table { border:1.5px solid #CFD4CD; border-collapse:collapse; text-align:center; }
#table tr { width:620px; height:50px; }
#list { border:1.5px solid #CFD4CD; border-collapse:collapse; text-align:center; }
#list tr { width:620px; height:40px; }
#point { font-weight: 500; }
</style>
</head>
<body>
<!-- 회원 주문 내역 리스트 시작 -->
<div id="listbox"><br /><span id="title">포인트</span><br /><br />
	<table id="table" width="850px;" >
	<tr><th width="35%">사유</th><th width="*">포인트 내역</th><th width="20%">날짜</th></tr>
	</table>
	<div v-for="item in arrPoint" :key="item.mpidx">
	<point-list :object="item" ></point-list>
	</div>
	<div style="margin-left:300px;">
	<c:if test="${pi.getRcnt() > 0}">
		<c:if test="${pi.getCpage() == 1}">
			<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="pointInfo?cpage=1${pi.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
			<a href="pointInfo?cpage=${pi.getCpage() - 1}${pi.getSchargs()}"><</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }" >
			<c:if test="${i == pi.getCpage()}">
				&nbsp;<strong>${i}</strong>&nbsp;
			</c:if>
			<c:if test="${i != pi.getCpage()}">
				&nbsp;<a href="pointInfo?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
			</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt()}">
			&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="pointInfo?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">></a>
			&nbsp;&nbsp;&nbsp;<a href="pointInfo?cpage=${pi.getPcnt()}${pi.getSchargs()}">>></a>
		</c:if>
	</c:if>
	</div>
	
</div>
<!-- 회원 주문 내역 리스트 종료 -->
<script>
var PointList = {
	props:["object"], 
	template:`<table id="list" width="850px;" ><tr><td width="35%">{{object.mpdesc}}</td>
		<td width="*"><span id="point">{{object.mppoint}}</span>&nbsp;point</td><td width="20%">{{object.mpdate}}</td></tr></table>
		`
		
}

new Vue({
	el: "#listbox",
	data: {
		arrPoint: [
<%
String obj = "";
for (int i = 0 ; i < memberPoint.size() ; i++) {
	MemberPoint mp = memberPoint.get(i);
	String point = "";
	if (mp.getMp_point() >= 0) {
		point = "+" + mp.getMp_point();
	} else {
		point = mp.getMp_point() + "";
	}
	
	obj = (i == 0 ? "" : ", ") + "{mpidx:\"" + mp.getMp_idx() + "\", mpdesc:\"" + mp.getMp_desc() + "\", mppoint:\"" + point + 
		"\", mpdate:\"" + mp.getMp_date() + "\", mpdetail:\"" + mp.getMp_detail() + "\"}";
	out.println(obj);
}
%>
		],
		point: "plus"
	},
	components: {
		"point-list": PointList
	}
	
});
</script>
</body>
</html>