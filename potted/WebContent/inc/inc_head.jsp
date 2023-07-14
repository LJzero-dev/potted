<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/potted/css/style.css">
<link rel="stylesheet" type="text/css" href="potted/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="potted/css/dashboard.css"/>

<script type="text/javascript" src="/jquery/js/jquery-3.6.4.js"></script>
<script type="text/javascript" src="/potted/js/bootstrap.js"></script>
<title>Insert title here</title>
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
<script>

</script>
</head>
<body>
<header id="header">
    <div class="header-inner">
        <h1><a href="" class="logo"><img src="/potted/images/logo.jpg" /></a></h1>
        <div class="top_search clear">
	        <div class="inner_search">
	          <input class="in_keyword" type="text" name="search" id="preSWord" title="검색어 입력" value="" placeholder="search">
	        </div>
	        <button class="search" id="searchSubmit"><span class="blind">검색</span></button>
        </div>
        <div class="gnb">
            <ul class="menu">
                <li><a href="" class="dep01">STORE</a></li>
                <li><a href="" class="dep01">COMMUNITY</a></li>
                <li><a href="" class="dep01">MY PLANT</a></li>
                <li><a href="" class="dep01">AUCTION</a></li>
                <li><a href="" class="dep01">SERVICE</a></li>
            </ul>
        </div>
	</div>
</header>