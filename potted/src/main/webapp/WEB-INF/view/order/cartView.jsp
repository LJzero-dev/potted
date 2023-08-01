<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<h2>장바구니</h2>

<table width="700" border="0" cellpadding="0" cellspacing="0" id="list">
<tr height="30">
<th width="*">상품정보</th>
<th width="10%">수량</th>
<th width="15%">주문금액</th>
</tr>
<c:if test="${orderCart.size() > 0}">
	<c:forEach items="${orderCart}" var="oc" varStatus="status">
	<tr height="30">
	<td><a href="productView?piid=${oc.getPi_id()}">${oc.getPi_id()}</a></td>
	<td align="center">${fl.getFl_writer()}</td>
	<td align="center">${oc.getOc_price()}</td>
	</tr>
	</c:forEach>
</c:if>
<c:if test="${orderCart.size() == 0}">
	<tr height="50"><td colspan="5" align="center">
	텅~
	</td></tr>
</c:if>

<%@ include file="../inc/inc_foot.jsp" %>