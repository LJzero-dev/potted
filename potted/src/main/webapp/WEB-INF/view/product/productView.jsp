<%@page import="com.mysql.cj.PingTarget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.springframework.context.annotation.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ProductInfo pi = (ProductInfo)request.getAttribute("productInfo");

List<ProductOptionStock> productOptionStock = (List<ProductOptionStock>)request.getAttribute("productOptionStock");

long realPrice = pi.getPi_price();			// 수량 변경에 따른 가격 연산을 위한 변수
String price = pi.getPi_price() + "원";		// 가격 출력을 위한 변수
if (pi.getPi_dc() > 0) {	// 할인율이 있으면
	realPrice = Math.round(realPrice * (1 - pi.getPi_dc()));
	price = "<del>" + pi.getPi_price() + "</del>&nbsp;&nbsp;&nbsp;" + realPrice + "원";
}

%>
<script>
<%-- function buy(kind) {
	<% if (isLogin) { %>
		var frm = document.frm;
		var size = frm.size.value;
		var cnt = frm.cnt.value;
		if (size == "") { alert("옵션을 선택하세요.");	return; }

		if (kind == "c") {	// 장바구니 담기일 경우
			$.ajax({
				type : "POST", url : "/potted/cartProc", data : {"piid" : "<%=pi.getPi_id()%>", "psidx" : size, "cnt" : cnt},
				success : function(chkRs) {	// insert된 레코트 개수 가져옴
					if (chkRs == 0) {	// 장바구니 담기에 실패했을 경우
						alert("장바구니 담기에 실패했습니다.\n다시 시도해 보세요.");
					} else {	// 장바구니 담기에 성공했을 경우
						if (confirm("장바구니에 담았습니다.\n장바구니로 이동하시겠습니까?")){
							location.href = "cartView";
						}
					}
				}
			});
		} else {	// 바로 구매하기일 경우
			frm.action = "orderForm";
			frm.submit();
		}
		
	<% } else { %>
		location.href = "loginForm?url=/mvcSite/productView?piid=<%=pi.getPi_id()%>";
	<% } %>
} --%>
</script>
<div style="width:850px; margin:0 auto; ">
<table width="800" cellpadding="5">
<tr align="center">
<td width="35%">
<!-- 이미지 관련 영역 -->
	<table width="100%" cellpadding="5">
	<tr><td colspan="3" align="center">
		<img src="/potted/resources/images/product/<%=pi.getPi_img1() %>" width="260" height="230" id="bigImg" />
	</td></tr>
	<tr align="center">
	<td width="33.3%">
		<img src="/potted/resources/images/product/<%=pi.getPi_img1() %>" width="80" height="80" onclick="showBig('<%=pi.getPi_img1() %>');" />
	</td>
	<td width="33.3%">
<% if (pi.getPi_img2() != null && !pi.getPi_img2().equals("")) { %>
		<img src="/potted/resources/images/product/<%=pi.getPi_img2() %>" width="80" height="80" onclick="showBig('<%=pi.getPi_img2() %>');" />
<% } %>
	</td>
	<td width="33.3%">
<% if (pi.getPi_img3() != null && !pi.getPi_img3().equals("")) { %>
		<img src="/potted/resources/images/product/<%=pi.getPi_img3() %>" width="80" height="80" onclick="showBig('<%=pi.getPi_img3() %>');" />
<% } %>
	</td>
	</tr>
	</table>
</td>
<td width="*" valign="top">
<!-- 상품 정보 관련 영역 -->
	<form name="frm" method="post">
	<input type="hidden" name="kind" value="d" />
	<input type="hidden" name="piid" value="<%=pi.getPi_id() %>" />
	<table width="100%" cellpadding="5" id="info" >
	<tr><td colspan="2">&nbsp;&nbsp;&nbsp;
		<a href="productList?pcb=<%=pi.getPcb_id() %>"><%=pi.getPcb_name() %></a> ‣ ‣
		<a href="productList?pcb=<%=pi.getPcs_id().substring(0, 2) %>&pcs=<%=pi.getPcs_id() %>"><%=pi.getPcs_name() %></a>
	</td></tr>
	<tr>
	<td width="20%" align="right">상품명</td>
	<td width="*"><%=pi.getPi_name() %></td>
	</tr>
	<tr><td align="right">가격</td><td><%=price %></td></tr>
	<tr>
<%=productOptionStock.get(0).getPos_id() %>
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
</div>


<%@ include file="../inc/inc_foot.jsp" %>