<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");
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
a:hover { text-decoration:underline; }
.hand { cursor:pointer; } 
.bold { font-weight:bold; }

</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>

</script>
</head>
<body>
<header id="header">
    <div class="header_inner">
        <h1><a href="/potted/" class="logo"><img src="/potted/resources/images/main/logo.jpg" /></a></h1>
         <!-- <div class="top_search clear">
            <div class="inner_search">
              <input class="in_keyword" type="text" name="search" id="preSWord" title="검색어 입력" value="" placeholder="search">
            </div>
            <button class="search" id="searchSubmit"><span class="blind">검색</span></button>
        </div> -->
        <div class="gnb">
            <ul class="menu">
                <li><a href="plantBook" class="dep01">PLANT BOOK</a></li>
                <li><a href="productList" class="dep01">STORE</a></li>
                <li><a href="freeList" class="dep01">COMMUNITY</a></li>
                <li><a href="myPlant" class="dep01">MY PLANT</a></li>
                <li><a href="auctionList" class="dep01">AUCTION</a></li>
                <li><a href="noticeList" class="dep01">SERVICE</a></li>
            </ul>
        </div>
        <div class="gnb_util">
        <% if (loginInfo != null) { %>
            <a href="cartView" class="cartBtn"><img src="/potted/resources/images/main/cart_icon.png"></a>
            <span><%=loginInfo.getOrder_count() %></span>
            <% } %>
            <div class="infor">
            <% if (loginInfo == null) { %>
                <a href="login" class="login">로그인</a>
                <a href="joinForm">회원가입</a>
            <% } else { %>
                <a href="mypage" class="minfor">회원정보</a>
                <a href="logout" class="logout">로그아웃</a>
            <% } %>
            </div>
        </div>
    </div>
</header>
