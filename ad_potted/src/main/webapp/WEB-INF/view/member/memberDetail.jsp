<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo mi = (MemberInfo)request.getAttribute("memberInfo");

String status = "", lastlogin = "";
if (mi.getMi_status().equals("a"))		status = "정상";
else if (mi.getMi_status().equals("b"))	status = "휴면";
else									status = "탈퇴";
if (mi.getMi_lastlogin() == null)		lastlogin = "로그인 내역 없음.";
else									lastlogin = mi.getMi_lastlogin();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
input {	padding:5px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
.btn { border:0; background-color:#fff; font-size:17px; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; }
#table th, td{ font-weight: lighter; border:1.5px solid #6B727A; }
#table { border:1.5px solid #6B727A; border-collapse:collapse; text-align:center; width:900px; }
#table tr { width:800px; height:50px; }
</style>
</head>
<body>
<h2>'<%=mi.getMi_name() %>'님의 정보</h2>
<table id="table">
<tr><th width="8%">아이디</th><th width="20%"><%=mi.getMi_id() %></th><th width="8%">이메일</th><th width="30%"><%=mi.getMi_email() %></th></tr>
<tr><td>연락처</td><td><%=mi.getMi_phone() %></td><td>상태</td><td><%=status %></td></tr>
<tr><td>가입일</td><td><%=mi.getMi_date() %></td><td>최종로그인</td><td><%=lastlogin %></td></tr>
<tr><td>보유 포인트</td><td><%=mi.getMi_point() %></td><td></td><td></td></tr>
</table><br />
<div align="center"><input type="button" value="닫기" onclick="window.close();" /></div>
</body>
</html>