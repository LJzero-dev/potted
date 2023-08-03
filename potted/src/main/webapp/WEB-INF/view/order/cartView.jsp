<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<style>
#img { width:100px; height:100px; }
#list { width:800px; }
#list th { border-bottom:1.5px solid #C6D0C3; }
#list td { border-bottom:1.5px solid #C6D0C3; }
#total { width:800px; }
#total th { border-bottom:1.5px solid #A1A1A1; text-align:left; font-size:16px; }
#total td { border-bottom:2px solid #A1A1A1; text-align:center; font-weight:bold; font-size:18px; }
</style>
<div style="width:1000px; margin-left:570px; ">
<h2>장바구니</h2>
	<c:set var="totalPrice" value="0" />
	<div style="display:none;">
	<c:if test="${orderCart.size() > 0}">
		<c:forEach items="${orderCart}" var="oc" varStatus="status">
			${totalPrice = totalPrice + oc.getOc_price()}
		</c:forEach>
	</c:if>
	</div>
<c:if test="${orderCart.size() > 0}">
	<table id="list" cellpadding="0" cellspacing="0">
		<tr height="30">
			<th width="*" colspan="2">상품정보</th>
			<th width="10%">수량</th>
			<th width="15%">주문금액</th>
		</tr>
		<c:forEach items="${orderCart}" var="oc" varStatus="status">
		<tr height="30">
			<td><a href="productView?piid=${oc.getPi_id()}"><img src="/potted/resources/images/product/${oc.getPi_img()}" id="img" /></a></td>
			<td>${oc.getPi_name()}<br />
				${oc.getOc_option()}
			</td>
			<td align="center">${oc.getOc_cnt()}</td>
			<td align="center">${oc.getOc_price()}</td>
		</tr>
		</c:forEach>
	</table>	
	<br /><br />
	<hr width="800" align="left" style="border-bottom:1.5px solid #A1A1A1;"/>
	<table id="total" cellpadding="0" cellspacing="0">
		<tr height="30px;"><th colspan="9">총 주문 상품 ${orderCart.size()}개</th></tr>
		<tr height="120px;">
			<td width="10%"></td>
			<td>20000<p>상품 금액</p></td>
			<td>+<p style="height:15px;"></p></td>
			<td>0<p>배송비</p></td>
			<td>-<p style="height:15px;"></p></td>
			<td>3500<p>할인금액</p></td>
			<td>=<p style="height:15px;"></p></td>
			<td>${totalPrice}<p>총 주문금액</p></td>
			<td width="10%"></td>
		</tr>
	</table>
	<input type="button" value="주문하기" onclick="" />	
</c:if>
<c:if test="${orderCart.size() == 0}">
	<tr height="50"><td colspan="5" align="center">
	텅~
	</td></tr>
</c:if>

<a href="productList">계속 쇼핑하기</a>

</div>

<%@ include file="../inc/inc_foot.jsp" %>