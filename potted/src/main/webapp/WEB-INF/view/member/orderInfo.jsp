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
#member { border:1.5px solid #CFD4CD; width:800px; height:100px; padding: 30px 30px; }
#welcome { font-size:30px; font-weight:bold; }
</style>
</head>
<body>
<div id="member">
<span id="welcome">${loginInfo.getMi_name()}</span> 님 안녕하세요. <br />
<div align="right">보유 포인트 : <br />
${loginInfo.getMi_point()}</div>
</div>
<!-- 회원 주문 내역 리스트 시작 -->
<table>
</table>
<!-- 회원 주문 내역 리스트 종료 -->
</body>
</html>