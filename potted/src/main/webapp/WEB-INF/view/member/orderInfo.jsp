<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
ArrayList<OrderInfo> orderList = (ArrayList<OrderInfo>)request.getAttribute("orderList");
%>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<style>
input {	padding:2px 2px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; }
#title { font-size:20px; font-weight: bold; }
#listbox { margin-left:60px; }
#table th, td{ font-weight: lighter; border:1.5px solid #CFD4CD; }
#table { border:1.5px solid #CFD4CD; border-collapse:collapse; text-align:center; }
#table tr { width:620px; height:50px; }
.isDone { font-size:13px; }
</style>
</head>
<body>
<!-- 회원 주문 내역 리스트 시작 -->
<div id="listbox"><br />
	<span id="title">주문조회</span>
	<br /><br />
	<table id="table" width="750px;" >
	<tr><th width="*">주문번호</th><th width="21%">상품명</th><th width="8%">수량</th><th width="16%">상태</th><th width="15%">주문금액</th><th width="16%">주문일자</th></tr>
	</table>
	<div v-for="item in orderArr" :key="item.oiidx">
	<order-list :object="item" v-on:go-review="goReview"></order-list>
	</div>
	<div style="margin-left:300px;">
	<c:if test="${pi.getRcnt() > 0}">
		<c:if test="${pi.getCpage() == 1}">
			<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="orderInfo?cpage=1${pi.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
			<a href="orderInfo?cpage=${pi.getCpage() - 1}${pi.getSchargs()}"><</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }" >
			<c:if test="${i == pi.getCpage()}">
				&nbsp;<strong>${i}</strong>&nbsp;
			</c:if>
			<c:if test="${i != pi.getCpage()}">
				&nbsp;<a href="orderInfo?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
			</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt()}">
			&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="orderInfo?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">></a>
			&nbsp;&nbsp;&nbsp;<a href="orderInfo?cpage=${pi.getPcnt()}${pi.getSchargs()}">>></a>
		</c:if>
	</c:if>
	</div>
</div>
<!-- 회원 주문 내역 리스트 종료 -->
</body>
<script>
var orderList = {
		props: ["object"], 
		template:`<table id="table" width="750px;" >
			<tr><td width="*">{{object.oiid}}</td><td width="21%"><a :href="object.oilnk" target="_blank">{{object.piname}}</a></td><td width="8%">{{object.oicnt}}</td>
			<td width="16%">{{object.val}}<input type="button" v-if="object.oistatus == 'c'" v-on:click="goReview(object.oiid)" value="리뷰 작성"><br />
			<span class="isDone">{{object.isdone}}</span></td>
			<td width="15%">{{object.oipay}}</td><td width="16%">{{object.oidate}}</td></tr>
			</table>
		`,	
	methods: {
		goReview(oiid) { 
			this.$emit("go-review", oiid);
		}
	}
}

new Vue({
	el: "#listbox", 
	data: {
		orderArr: [
<%
String obj = "", status = "", oilnk = "", isdone = "";
for (int i = 0 ; i < orderList.size() ; i++) {
	OrderInfo oi = orderList.get(i);
	if(oi.getOi_status().equals("a")) {
		status = "배송 대기";
	} else if (oi.getOi_status().equals("b")) {
		status = "배송 중";
	} else if (oi.getOi_status().equals("c")) {
		status = "배송 완료";
	} else { 
		status = "배송 완료";
		isdone = "(후기작성완료)";		
	}
	
	oilnk = "http://localhost:8086/potted/productView?piid=" + oi.getPi_id();
	
	obj = (i == 0 ? "" : ", ") + "{oiidx:\"" + i + "\", oiid:\"" + oi.getOi_id() + "\", piname:\"" + oi.getPi_name() + "\", oicnt:\"" + oi.getOi_cnt() + 
		"\", oistatus:\"" + oi.getOi_status() + "\", oipay:\"" + oi.getOi_pay() + "\", oidate:\"" + oi.getOi_date() + "\", oilnk:\"" + oilnk + 
		"\", val:\"" + status + "\", isdone:\"" + isdone + "\"}";
		out.println(obj);
}
%>
		]
	},
	components: {
		"order-list": orderList
	},
	methods: {
		goReview(oiid) {
		    window.open("reviewForm?oiid=" + oiid);
		}
	}
});

</script>
</html>