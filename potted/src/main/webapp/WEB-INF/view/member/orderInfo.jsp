<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
%>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#title { font-size:20px; font-weight: bold; }
#listbox { margin-left:60px; }
#table th, td{ font-weight: lighter; border:1.5px solid #CFD4CD; }
#table { border:1.5px solid #CFD4CD; border-collapse:collapse; }
#table tr { width:600px; height:30px; }
</style>
</head>
<body>
<!-- 회원 주문 내역 리스트 시작 -->
<div id="listbox"><br />
	<span id="title">주문조회</span>
	<select style="margin-left:550px;">
		<option value="a">최신순</option>
		<option value="b">오래된순</option>
		<option value="c">가격 높은 순</option>
		<option value="d">가격 낮은 순</option>
	</select><br /><br />
	<table id="table" width="750px;" >
	<tr><th width="*">주문번호</th><th width="21%">상품명</th><th width="8%">수량</th><th width="12%">상태</th><th width="15%">주문금액</th><th width="15%">주문일자</th></tr>
	<tr><td></td></tr>
	</table>
</div>
<!-- 회원 주문 내역 리스트 종료 -->
</body>
</html>