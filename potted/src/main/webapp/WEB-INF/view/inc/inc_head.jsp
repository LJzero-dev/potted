<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/potted/resources/css/style.css">
<title>potted</title>
<style>
html, body {margin:0; padding:0; height:100%; }
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
        <div class="top_search clear">
            <div class="inner_search">
              <input class="in_keyword" type="text" name="search" id="preSWord" title="검색어 입력" value="" placeholder="search">
            </div>
            <button class="search" id="searchSubmit"><span class="blind">검색</span></button>
        </div>
        <div class="gnb">
            <ul class="menu">
                <li><a href="productList" class="dep01">STORE</a></li>
                <li><a href="freeList" class="dep01">COMMUNITY</a></li>
                <li><a href="myPlant" class="dep01">MY PLANT</a></li>
                <li><a href="auction" class="dep01">AUCTION</a></li>
                <li><a href="service" class="dep01">SERVICE</a></li>
            </ul>
        </div>
        <div class="gnb_util">
            <a href="javascript:void(0);" class="cartBtn"><img src="/potted/resources/images/main/cart_icon.png"></a>
            <span>10</span>
            <div class="infor">
                <!-- <a href="javascript:void(0);" class="login">로그인</a> -->
                <a href="javascript:void(0);" class="minfor">회원정보</a>
                <a href="javascript:void(0);" class="logout">로그아웃</a>
            </div>
        </div>
    </div>
</header>
