<%@page import="vo.AdminInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%
AdminInfo loginInfo = (AdminInfo)session.getAttribute("loginInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/potted/resources/css/style.css">
<title>potted</title>
<style>
html, body {margin:0; padding:0;}
body, th, td, div, p { font-size:12px; }
ul,ol,li {list-style:none;}
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; color:red; }
.hand { cursor:pointer; } 
.bold { font-weight:bold; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>

</script>
</head>
<body>
<header id="header">
    <div class="header_inner">
        <h1><a href="" class="logo"><img src="/potted/resources/images/main/logo.jpg" /></a></h1>
        <div class="gnb">
            <ul class="menu">
                <li><a href="productList" class="dep01">상품 관리</a></li>
                <li><a href="freeList" class="dep01">게시판 관리</a></li>
                <li><a href="noticeList" class="dep01">서비스 관리</a></li>
                <li><a href="auction" class="dep01">옥션 관리</a></li>
                <li><a href="" class="dep01">사이트 관리</a></li>
            </ul>
        </div>
        <div class="gnb_util">
            <div class="infor">
            <% if (loginInfo == null) { %>
                <a href="login" class="loginForm">로그인</a>
            <% } else { %>
                <a href="memberList" class="minfor">회원정보</a>
                <a href="logout" class="logout">로그아웃</a>
            <% } %>
            </div>
        </div>
    </div>
</header>
