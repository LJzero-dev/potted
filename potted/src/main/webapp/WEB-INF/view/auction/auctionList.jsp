<%@page import="java.text.DecimalFormat"%>
<%@page import="ctrl.ProductListCtrl"%>
<%@page import="com.mysql.cj.PingTarget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.springframework.context.annotation.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%

request.setCharacterEncoding("utf-8");

List<ProductInfo> productList = (List<ProductInfo>)request.getAttribute("productList");
// 검색 연월에 해당하는 일정들의 목록을 저장하고 있는 List
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");

String pcb = request.getParameter("pcb");
if (pcb == null || pcb.equals("")) { pcb = ""; }

String pcs = request.getParameter("pcs");
if (pcs == null || pcs.equals("")) { pcs = ""; }

String name = "", sp = "", ep = "", sch = pageInfo.getSch();
if (sch != null && !sch.equals("")) {
// 검색조건 : &sch=ntest,p100000~200000
/*
arrSch[0] = ntest (상품명검색어)
arrSch[1] = p100000~200000 (가격대)
*/
	String[] arrSch = sch.split(",");
	for (int i = 0 ; i < arrSch.length ; i++) {
		char c = arrSch[i].charAt(0);
		if (c == 'n') {			// 상품명 검색일 경우(n검색어)
			name = arrSch[i].substring(1);
		} else if (c == 'p') {	// 가격대 검색일 경우(p시작가~종료가)
			sp = arrSch[i].substring(1, arrSch[i].indexOf('~'));
			ep = arrSch[i].substring(arrSch[i].indexOf('~') + 1);
		}
	}
}
DecimalFormat formatter = new DecimalFormat("###,###,###,###");
%>

<style>
.ctgrb {margin-right:10px; padding: 6px 20px; font-size: 20px; color: #6E6E6E; cursor: pointer; text-align: center; height:30px; 
	border:1.5px solid  #6E6E6E; float:left; margin-bottom:10px; background: white; border-radius: 20px;  }
.ctgrb:hover { font-color: #0B9649; border-color: #0B9649; color: #0B9649; }
.btn { background:white; font-size: 15px; border-radius: 20px; cursor: pointer; border:1px solid #000; margin-right:10px; }
.sct { height:25px; margin-left:875px; font-size:18px; }
#table1 td{ font-size:15px; border:1.5px solid #6B727A; }
#table1 { border:1.5px solid #6B727A; border-collapse:collapse; text-align:center; width:210px; }
#table1 tr { width:210px; height:32px; }
.tim { font-size:17px; }

#ctgr1 { display: <% if(pcb.equals("AA") || pcs.equals("AAaa") || pcs.equals("AAbb")) { %>block; <%} else { %> none; <% } %> margin-top:10px; }
#ctgr2 { display: <% if(pcb.equals("BB") || pcs.equals("BBaa") || pcs.equals("BBbb")) { %>block; <%} else { %> none; <% } %> margin-top:10px; }
#ctgr3 { display: <% if(pcb.equals("CC") || pcs.equals("CCaa") || pcs.equals("CCbb")) { %>block; <%} else { %> none; <% } %> margin-top:10px; }

#<%=pcb%> { font-color: #0B9649; color: #0B9649; border:2px solid #0B9649; }
#<%=pcs%> { font-color: #0B9649; color: #0B9649; border:2px solid #0B9649; }

</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
function makeSch() {
// 검색 폼의 조건들을 쿼리스트링 sch의 값으로 만듦 : ntest,p100000~200000
	var frm = document.frm2;
	var sch = ""; // 만들게될 쿼리스트링을 저장할 변수
	
	// 상품명 검색어 조건
	var pdt = frm.pdt.value.trim();
	if (pdt != "") sch += "n" + pdt;	// sch=n검색어
	
	// 가격대 검색 조건
	var sp = frm.sp.value, ep = frm.ep.value;
	if (sp != "" || ep != "") {	// 가격대중 하나라도 값이 있으면
		if (sch != "")	sch += ",";
		sch += "p" + sp + "~" + ep;		// sch=n검색어,p최저가~최고가
	}	
	
	document.frm1.sch.value = sch;
	document.frm1.submit();
}

function showCtgrB(ctgr) {
	if (ctgr == 1) {
		location.href = "auctionList?pcb=AA";
	} else if (ctgr == 2) {
		location.href = "auctionList?pcb=BB";
	} else {
		location.href = "auctionList?pcb=CC";
	} 
	
}

function showCtgrS(code) {
	location.href = "auctionList?pcb=" + code.substring(0, 2) + "&pcs=" + code;
}
</script>
<div style="width:1100px; margin:0 auto; ">
<h2 style="font-size:20pt;"><a href="auctionList"; style="text-decoration:none; color:black;">AUCTION</a></h2>
<form name="frm0">
<div style="overflow:hidden;">
	<div class="ctgrb" id="AA" onclick="showCtgrB(1);" >다육⦁선인장</div>
	<div class="ctgrb" id="BB" onclick="showCtgrB(2);" >관엽식물</div>
	<div class="ctgrb" id="CC" onclick="showCtgrB(3);" >허브⦁채소</div>
</div>
<hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb; width:930px;" />
<div id="ctgr1" >
	<div class="ctgrb" id="AAaa" onclick="showCtgrS('AAaa')" >다육</div>
	<div class="ctgrb" id="AAbb" onclick="showCtgrS('AAbb')" >선인장</div>
</div>
<div id="ctgr2" >
	<div class="ctgrb" id="BBaa" onclick="showCtgrS('BBaa')" >넝쿨⦁잎</div>
	<div class="ctgrb" id="BBbb" onclick="showCtgrS('BBbb')" >열매⦁꽃</div>
</div>
<div id="ctgr3" >
	<div class="ctgrb" id="CCaa" onclick="showCtgrS('CCaa')" >허브</div>
	<div class="ctgrb" id="CCbb" onclick="showCtgrS('CCbb')" >채소</div>
</div>
</form>

<table width="800">
<tr>
<td width="150" valign="top">
	<!-- 검색 조건 입력 폼 -->
	<form name="frm1">
	<!--  검색조건으로 링크를 걸기위한 쿼리스트링용 컨트롤들의 집합 -->
	<input type="hidden" name="pcb" value="<%=pcb %>" />
<% if (pageInfo.getPcs() != null && !pageInfo.getPcs().equals("")) { %>
	<input type="hidden" name="pcs" value="<%=pcs %>" />
<% } %>
	<input type="hidden" name="ob" value="<%=pageInfo.getOb() %>" />
	<input type="hidden" name="sch" value="" />
	</form>
	<form name="frm2">
	<div>
		<strong style="font-size:13pt;">가격대</strong>&nbsp;&nbsp;
		<input type="text" name="sp" class="price" value="<%=sp %>" placeholder="최저가" onkeyup="onlyNum(this);" style="height:20px;" />&nbsp;&nbsp; ~ &nbsp;
		<input type="text" name="ep" class="price" value="<%=ep %>" placeholder="최고가" onkeyup="onlyNum(this);" style="height:20px;" />
		<input type="button" value="검색" class="btn" onclick="makeSch();" />
		<input type="button" value="검색 초기화" class="btn" onclick="location.href='productList';" />
	</div>
	<br /><br />
	<div style="width:1025px;">
		<img src="/potted/resources/images/product/search.png" width="25"/>&nbsp;
		<input type="text" name="pdt" id="pdt" placeholder="식물 이름을 검색해 주세요." value="<%=name %>" style="width:900px; border:0; font-size:13pt;" />
		<input type="button" value="검색" class="btn" onclick="makeSch();" />
	<hr />
	</div>
	</form>	 
<%
if (pageInfo.getRcnt() > 0) {
	String lnk = "auctionList?cpage=1" + pageInfo.getSchargs();
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
<table width="100%" cellpadding="15" cellspacing="0" >

<%	
	int i = 0;
	String pi_ids = "";
	String soldout = "";
	for (i = 0 ; i < productList.size() ; i++) {		
		ProductInfo pi = productList.get(i);
		lnk = "auctionView?piid=" + pi.getPi_id();
		pi_ids += "," + pi.getPi_id();		
		%>
		<script>
		function updateTimer() {
			const future = Date.parse("<%=pi.getProductAuctionInfo().getPai_end()%>");
			const now = new Date();
			const diff = future - now;
			const days = Math.floor(diff / (1000 * 60 * 60 * 24));
			const hours = Math.floor(diff / (1000 * 60 * 60));
			const mins = Math.floor(diff / (1000 * 60));
			const secs = Math.floor(diff / 1000);

			const d = days;
			const h = hours - days * 24;
			const m = mins - hours * 60;
			const s = secs - mins * 60;
			if (diff < 0) {
			document.getElementById("timer<%=i%>").innerHTML ='<div>종료된 경매 입니다.</div>';
			} else {
			document.getElementById("timer<%=i%>").innerHTML ='<div>' + d + '<span>일 </span>' + h + '<span>시 </span>' + m + '<span>분 </span>' + s + '<span>초</span></div>';
			}
		}
		setInterval(updateTimer, 1000);	
		</script>
		<%
		String price = "시작가 " +  formatter.format(pi.getPi_price()) + "원 <br />";
		if (i % 4 == 0) out.println("<tr>");
	%>
	<td width="10%" align="left">
		<a href="<%=lnk %>">
		<img id="timg" src="/ad_potted/resources/images/product/<%=pi.getPi_img1() %>" width="210" height="210" border="0" />
		<br /></a>
		<table id="table1">
		<tr><th colspan="2"><span style="font-size:20px; font-weight:bold;"><%=pi.getPi_name() %></span></th></tr>
		<tr><td width="40%">현재가</td><td><%=formatter.format(pi.getProductAuctionInfo().getPai_price()) %> 원</td></tr>
		<tr><td width="40%">남은 시간</td><td><span id="timer<%=i %>" class="tim"></span></td></tr>
		<tr><td width="40%">마감시간</td><td><%=pi.getProductAuctionInfo().getPai_end() %></td></tr>
		</table>
		<%=price %><br />
	</td>		
	<%		
		if (i % 4 == 3) out.println("</tr>");
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
		out.println("<a href='auctionList?cpage=1" + qs + "'>&lt;&lt;</a>&nbsp;&nbsp;");
		out.println("<a href='auctionList?cpage=" + (pageInfo.getCpage() - 1) + qs + "'>&lt;</a>&nbsp;");
	}

	for (int k = 1, j = pageInfo.getSpage() ; k <= pageInfo.getBsize() && j <= pageInfo.getPcnt() ; k++, j++) {
		if (pageInfo.getCpage() == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.println("&nbsp;<a href='auctionList?cpage=" + j + qs + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (pageInfo.getCpage() == pageInfo.getPcnt()) {
		out.println("&nbsp;&nbsp;&gt;&nbsp;&nbsp;&nbsp;&gt;&gt;");
	} else {
		out.println("&nbsp;&nbsp;<a href='auctionList?cpage=" + (pageInfo.getCpage() + 1) + qs + "'>&gt;</a>");
		out.println("&nbsp;&nbsp;&nbsp;<a href='auctionList?cpage=" + pageInfo.getPcnt() + qs + "'>&gt;&gt;</a>");
	}
	out.println("</p>");
} else {
	out.println("검색된 상품이 없습니다.");
}
%>
</table>
</div>
<script>updateTimer();</script>
<%@ include file="../inc/inc_foot.jsp" %>