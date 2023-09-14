<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
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
	<table id="table" width="850px;" >
		<tr>
			<th width="10%">아이디</th>
			<th width="*">주문번호</th>
			<th width="21%">상품명</th>
			<th width="8%">수량</th>
			<th width="10%">상태</th>
			<th width="15%">주문금액</th>
			<th width="16%">주문일자</th>
		</tr>	
		<c:forEach var="ol" items="${orderList}">
		<tr>
			<td>${ol.mi_id }</td>
			<td>${ol.oi_id }</td>
			<td><a href="javascript:void(0);">${ol.pi_name }</a></td>
			<td>${ol.oi_cnt }</td>
			<td>배송대기</td>
			<td>${ol.oi_pay }</td>
			<td>${ol.oi_date }</td>
		</tr>	
		</c:forEach>
	</table>
	
	<!-- 주문 정보 팝업 -->
	
	<!-- 페이징 시작 -->
	<div style="margin-left:300px;">	
		<c:if test="${pi.getRcnt() > 0}">
			<c:if test="${pi.getCpage() == 1}">
				<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
			</c:if>
			<c:if test="${pi.getCpage() > 1}">
				<a href="orderList?cpage=1${pi.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
				<a href="orderList?cpage=${pi.getCpage() - 1}${pi.getSchargs()}"><</a>&nbsp;&nbsp;
			</c:if>
			
			<c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }" >
				<c:if test="${i == pi.getCpage()}">
					&nbsp;<strong>${i}</strong>&nbsp;
				</c:if>
				<c:if test="${i != pi.getCpage()}">
					&nbsp;<a href="orderList?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
				</c:if>
			</c:forEach>
			
			<c:if test="${pi.getCpage() == pi.getPcnt()}">
				&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
			</c:if>
			<c:if test="${pi.getCpage() < pi.getPcnt()}">
				&nbsp;&nbsp;<a href="orderList?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">></a>
				&nbsp;&nbsp;&nbsp;<a href="orderList?cpage=${pi.getPcnt()}${pi.getSchargs()}">>></a>
			</c:if>
		</c:if>
	</div>
	<!-- 페이징 끝 -->
</div>
<!-- 회원 주문 내역 리스트 종료 -->
</body>
</html>