<%@page import="com.mysql.cj.PingTarget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.springframework.context.annotation.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

List<ProductInfo> productList = (List<ProductInfo>)request.getAttribute("productList");

%>
<table width="800" cellpadding="5">
<tr align="center">
<td width="35%">
<!-- 이미지 관련 영역 -->
	<table width="100%" cellpadding="5">
	<tr><td colspan="3" align="center">
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img1() %>" width="260" height="230" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img1() %>" width="80" height="80" onclick="showBig('<%=productInfo.getPi_img1() %>');" />
	</td>
	<td width="33.3%">
<% if (productInfo.getPi_img2() != null && !productInfo.getPi_img2().equals("")) { %>
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img2() %>" width="80" height="80" onclick="showBig('<%=productInfo.getPi_img2() %>');" />
<% } %>
	</td>
	<td width="33.3%">
<% if (productInfo.getPi_img3() != null && !productInfo.getPi_img3().equals("")) { %>
		<img src="/mvcSite/product/pdt_img/<%=productInfo.getPi_img3() %>" width="80" height="80" onclick="showBig('<%=productInfo.getPi_img3() %>');" />
<% } %>
	</td>
	</tr>
	</table>
</td>
<td width="*" valign="top">
<!-- 상품 정보 관련 영역 -->
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="d" />
	<input type="hidden" name="piid" value="<%=productInfo.getPi_id() %>" />
	<table width="100%" cellpadding="5" id="info" >
	<tr><td colspan="2">&nbsp;&nbsp;&nbsp;
		<a href="productList?pcb=<%=productInfo.getPcs_id().substring(0, 2) %>"><%=productInfo.getPcb_name() %></a>  ->  
		<a href="productList?pcb=<%=productInfo.getPcs_id().substring(0, 2) %>&pcs=<%=productInfo.getPcs_id() %>"><%=productInfo.getPcs_name() %></a>
	</td></tr>
	<tr>
	<td width="20%" align="right">상품명</td>
	<td width="*"><%=productInfo.getPi_name() %></td>
	</tr>
	<tr><td align="right">브랜드</td><td><%=productInfo.getPb_name() %></td></tr>
	<tr><td align="right">제조사</td><td><%=productInfo.getPi_com() %></td></tr>
	<tr><td align="right">가격</td><td><%=price %></td></tr>
	<tr>
	<td align="right">옵션</td>
	<td>
		<select name="size">
			<option value="">사이즈 선택</option>
<% 
for (ProductStock ps : stockList) {
	String opt = ps.getPs_size() + "mm (재고 : " + ps.getPs_stock() + "개)";
	String disabled = "";
	if (ps.getPs_stock() <= 0) {	// 재고 관리에서 오류가 생길 우려가 있기 때문에 0보다 작다는 조건을 줌
		disabled = " disabled=\"disabled\"";
		opt = ps.getPs_size() + "mm (재고없음 : 품절)";
	}
	out.println("<option value='" + ps.getPs_idx() + ":" + ps.getPs_stock() + "'" + disabled + ">" + opt + "</option>");
}
%>	
		
		</select>
	</td>
	</tr>
	<tr>
	<td align="right">수량</td>
	<td>
		<input type="button" value="-" onclick="setCnt(this.value);" />
		<input type="text" name="cnt" id="cnt" value="1" readonly="readonly" />
		<input type="button" value="+" onclick="setCnt(this.value);" />
	</td>
	</tr>
	<tr><td colspan="2" align="right">
		구매 가격 : <span id="total"><%=realPrice %></span>원
	</td></tr>
	<tr><td colspan="2" align="center">
		<input type="button" value="장바구니 담기" class="smt" onclick="buy('c');" />
		<input type="button" value="바로 구매하기" class="smt" onclick="buy('d');" />
	</td></tr>
	</table>
	</form>
</td>
</tr>
</table>
<%@ include file="../inc/inc_foot.jsp" %>