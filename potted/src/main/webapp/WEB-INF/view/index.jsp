<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="inc/inc_head.jsp" %>
<style>
#timg { width:150px; height:120px; border:0; }
.title { font-size:20px; font-weight:bold; }
.showall { font-color:#0B9649; }
.dc { color:#0B9649; font-weight:bold; }
.realprice { color:grey; }
.name { font-size:20px; }
.price { font-weight:bold; }
.free { width:750px; }
.free td { font-size:15px; border-bottom:1px solid black; }
</style>
<div style="width:800px; margin:0 auto; align:center; ">
<br />
<table>
<tr><td colspan="10"><img src="" style="width:750px; height:300px;"/></td></tr>
<tr height="40px;"></tr>
<tr><td class="title">새로들어온 식물</td><td colspan="3" >&nbsp;<a href="productList?cpage=1&ob=a" class="showall">모두 보기 >></a></td></tr>
<tr>
<c:forEach items="${productLista}" var="pi" >
	<c:set var="price">${pi.getPi_price() * (1 - pi.getPi_dc())}</c:set>
	<c:set var="dc">${pi.getPi_dc() * 100}</c:set>
	<td><a href="productView?piid=${pi.getPi_id()}"><img id="timg" src="/potted/resources/images/product/${pi.getPi_img1()}" /><br /><span class="name">${pi.getPi_name()}</span></a><br />
	<span class="price">${fn:substringBefore(price, '.')}원</span>&nbsp;<span class="dc">${fn:substringBefore(dc, '.')}%</span><br />
	<span class="realprice"><del>${pi.getPi_price() }</del></span></td><td width="50px;"></td>
</c:forEach>
</tr>
<tr height="40px;"></tr>
<tr><td class="title">인기 식물</td><td colspan="3" >&nbsp;<a href="productList?cpage=1&ob=b" class="showall">모두 보기 >></a></td></tr>
<tr>
<c:forEach items="${productListb}" var="pi" >
	<c:set var="price">${pi.getPi_price() * (1 - pi.getPi_dc())}</c:set>
	<c:set var="dc">${pi.getPi_dc() * 100}</c:set>
	<td><a href="productView?piid=${pi.getPi_id()}"><img id="timg" src="/potted/resources/images/product/${pi.getPi_img1()}" /><br /><span class="name">${pi.getPi_name()}</span></a><br />
	<span class="price">${fn:substringBefore(price, '.')}원</span>&nbsp;<span class="dc">${fn:substringBefore(dc, '.')}%</span><br />
	<span class="realprice"><del>${pi.getPi_price() }</del></span></td><td width="50px;"></td>
</c:forEach>
</tr>
</table>
<table class="free" cellpadding="0" cellspacing="0">
<tr height="40px;"></tr>
<tr><td colspan="4"><span class="title">인기 글</span>&nbsp;<a href="freeList?cpage=1&ob=b" class="showall">모두 보기 >></a></td></tr>
<c:forEach items="${freeList}" var="fl" >
	<tr height="35px;"><td width="*"><a href="freeView?cpage=1&flidx=${fl.getFl_idx()}">${fl.getFl_title()}</a></td><td width="20%" align="center">${fl.getFl_writer()}</td><td width="10%" align="right">${fl.getFl_date()}</td><td width="20%" align="left"> | 조회 : ${fl.getFl_read() }</td></tr>
</c:forEach>
</table>
</div>
<%@ include file="inc/inc_foot.jsp" %>