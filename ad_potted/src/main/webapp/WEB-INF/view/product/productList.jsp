<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.util.*" %>
<%@page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");
List<ProductInfo> productList = (List<ProductInfo>)request.getAttribute("productList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
%>


<style>
.ctgrb {margin-right:10px; padding: 6px 20px; font-size: 20px; color: #6E6E6E; cursor: pointer; text-align: center; height:30px; 
	border:1.5px solid  #6E6E6E; float:left; margin-bottom:10px; background: white; border-radius: 20px;  }
.ctgrb:hover { font-color: #0B9649; border-color: #0B9649; color: #0B9649; }
.btn { background:white; font-size: 15px; border-radius: 20px; cursor: pointer; border:1px solid #000; margin-right:10px; }
.sct { height:25px; margin-left:690px; }
.goForm { margin-left: 750px; width:100px; padding:5px 0; margin-bottom:30px; border:0; background:gray; color:#fff; cursor: pointer; }


</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
function makeSch() {
// 검색 폼의 조건들을 쿼리스트링 sch의 값으로 만듦 : ntest,p100000~200000
}


</script>
<div style="width:850px; margin:0 auto; ">
<h2 style="font-size:20pt;"><a href="productList"; style="text-decoration:none; color:black;">상품관리</a></h2>
<form>

<table width="800">
<tr>
<td width="150" valign="top">
	<!-- 검색 조건 입력 폼 -->
	<form name="frm1">
	<!--  검색조건으로 링크를 걸기위한 쿼리스트링용 컨트롤들의 집합 -->
	<input type="hidden" name="ob" value="<%=pageInfo.getOb() %>" />
	<input type="hidden" name="sch" value="" />
	</form>
	<form name="frm2">
		<img src="/potted/resources/images/product/search.png" width="25"/>&nbsp;
		<input type="text" name="pdt" id="pdt" placeholder="식물 이름을 검색해 주세요." value="" style="width:700px; border:0; font-size:13pt;" />
		<input type="button" value="검색" class="btn" onclick="makeSch();" />
	<hr />
	</div>
	</form>	 
<%
if (pageInfo.getRcnt() > 0) {
	String lnk = "productList?cpage=1" + pageInfo.getSchargs();
%>
		<select name="ob" class="sct" onchange="location.href='<%=lnk%>&ob=' + this.value;" >
			<option value="a" <%if (pageInfo.getOb().equals("a")) {%>selected="selected"<% } %>>최근 순  🌱</option>
			<option value="b" <%if (pageInfo.getOb().equals("b")) {%>selected="selected"<% } %>>인기 순  🌱</option>
			<option value="c" <%if (pageInfo.getOb().equals("c")) {%>selected="selected"<% } %>>이름 순  🌱</option>
			<option value="d" <%if (pageInfo.getOb().equals("d")) {%>selected="selected"<% } %>>높은 가격 순  🌱</option>
			<option value="e" <%if (pageInfo.getOb().equals("e")) {%>selected="selected"<% } %>>낮은 가격 순  🌱</option>
		</select>
</td>
</tr>
<table width="100%" cellpadding="15" cellspacing="0" border="1 solid black">
<tr>
	<td>번호</td>
	<td>상품명</td>
	<td>판매가</td>
	<td>판매상태</td>
	<td>재고</td>
	<td>판매량</td>
	<td>등록일</td>
</tr>
<%	
	int i = 0;
	for (ProductInfo pi : productList) {
		lnk = "productUp?piid=" + pi.getPi_id();
		// 할인가격 확인
	%>
	
	<tr align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
	<td>번호</td>
	<td><a href="<%=lnk %>">
		<img src="/potted/resources/images/product/<%=pi.getPi_img1() %>" width="100" height="100" border="0" />
		<input type="hidden" name="piid" value="<%=pi.getPi_id()%>" />
		<div><%=pi.getPi_name() %></div>
	</a></td>
	<td><%=pi.getPi_price() %></td>
	<td>판매상태</td>
	<td><%=pi.getPi_stock() %></td>
	<td><%=pi.getPi_sale() %></td>
	<td><%=pi.getPi_date() %></td>
	</tr>
	<%
	}
	if (i % 4 > 0) {	// 목록에 나오는 상품 수가 4개가 안될때도 왼쪽부터 잘 나오도록 함
		for (int j = 0 ; j < (4 - (i % 4)) ; j++) {
			out.println("<td width='25%'></td>");
		}
		out.println("</tr>");
	}
%>
	</table>
<%
	out.println("<p align='center' style='font-size:18px;'>");	// 페이징 영역을 보여줄 p태그
	
	String qs = pageInfo.getSchargs() + pageInfo.getObargs();
	// 페이징 영역 링크에서 사용할 쿼리 스트링의 공통 부분(검색조건들, 정렬방식, 보기방식)
	
	if (pageInfo.getCpage() == 1) {
		out.println("&lt;&lt;&nbsp;&nbsp;&lt;&nbsp;");
	} else {
		out.println("<a href='productList?cpage=1" + qs + "'>&lt;&lt;</a>&nbsp;&nbsp;");
		out.println("<a href='productList?cpage=" + (pageInfo.getCpage() - 1) + qs + "'>&lt;</a>&nbsp;");
	}

	for (int k = 1, j = pageInfo.getSpage() ; k <= pageInfo.getBsize() && j <= pageInfo.getPcnt() ; k++, j++) {
		if (pageInfo.getCpage() == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='productList?cpage=" + j + qs + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (pageInfo.getCpage() == pageInfo.getPcnt()) {
		out.println("&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&gt;&gt;");
	} else {
		out.println("&nbsp;&nbsp;<a href='productList?cpage=" + (pageInfo.getCpage() + 1) + qs + "'>&gt;</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='productList?cpage=" + pageInfo.getPcnt() + qs + "'>&gt;&gt;</a>");
	}
	out.println("</p>");
} else {
	out.println("검색된 상품이 없습니다.");
}
%>


</table>
		<input type="button" value="상품 등록" class="goForm" onclick="location.href='productIn?';" />
</div>
<%@ include file="../inc/inc_foot.jsp" %>