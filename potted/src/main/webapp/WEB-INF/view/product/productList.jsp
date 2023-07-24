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


%>

<style>
.ctgrb {margin-right:10px; padding: 6px 20px; font-size: 20px; color: #6E6E6E; cursor: pointer; text-align: center; height:30px; border:1.5px solid  #6E6E6E; float:left; margin-bottom:10px;
	background: white; border-radius: 20px;  }
.ctgrb:hover { font-color: #0B9649; border-color: #0B9649; color: #0B9649; }
.btn { background:white; font-size: 15px; border-radius: 20px; cursor: pointer; border:1px solid #000; margin-right:10px; }
#ctgr1 { display:none; margin-top:10px; }
#ctgr2 { display:none; margin-top:10px; }
#ctgr3 { display:none; margin-top:10px; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
function makeSch() {
// 검색 폼의 조건들을 쿼리스트링 sch의 값으로 만듦 : ntest,bB1:B2:B3,p100000~200000
	var frm = document.frm2;
	var sch = ""; // 만들게될 쿼리스트링을 저장할 변수
	
	// 상품명 검색어 조건
	var pdt = frm.pdt.value.trim();
	if (pdt != "") sch += "n" + pdt;	// sch=n검색어
	
	// 가격대 검색 조건
	var sp = frm.sp.value, ep = frm.ep.value;
	if (sp != "" || ep != "") {	// 가격대중 하나라도 값이 있으면
		if (sch != "")	sch += ",";
		sch += "p" + sp + "~" + ep;		// sch=n검색어,b브랜드(들),p최저가~최고가
	}	
	
	document.frm1.sch.value = sch;
	document.frm1.submit();
}

function initSch() {
// 검색조건(상품명, 브랜드, 가격대)들을 모두 없애주는 함수 / 브랜드 checkbox 에 name값이 하나일때 
	var frm = document.frm2;
	frm.pdt.value = "";	frm.sp.value = "";	frm.ep.value = "";
	var arr = frm.brand;	// brand라는 이름의 컨트롤들을 배열로 받아옴
	for (var i = 0 ; i < arr.length ; i++) {
		arr[i].checked = false;
	}
}
/*
function initSch2() { 브랜드 이름들이 다 다를경우 : ex input type checkbox name="brand.getPb_id()" 가들어갈 때 
	var frm = document.frm2;
	var ids = frm.ids.value.split(",");
	for (var i = 0 ; i < ids.length ; i++) {
		var tmp = eval("frm.brand" + ids[i]);
		tmp.checked = false;
	}
} */ 

var ctgrn = 1;
function showCtgrS(ctgr) {
	var obj = document.getElementById("ctgr"+ ctgrn); //현재 메뉴를 객체로 받아옴
	obj.style.display = "none"; //현재 메뉴를 숨김
	var menu = document.getElementById("ctgr"+ ctgr); 
	menu.style.display = "block"; 
	ctgrn = ctgr; //현재 보이는 메뉴번호를 눌린 버튼의 번호로 변경
	
}
</script>
<div style="width:800px; margin:0 auto; ">
<h2 style="font-size:20pt;">STORE</h2>
<form>
<div style="overflow:hidden;">
	<div class="ctgrb" id="AA" onclick="showCtgrS(1);" >다육⦁선인장</div>
	<div class="ctgrb" id="BB" onclick="showCtgrS(2);" >관엽식물</div>
	<div class="ctgrb" id="CC" onclick="showCtgrS(3);" >허브⦁채소</div>
</div>
</form>
<hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;" />
<div id="ctgr1" >
	<div class="ctgrb" onclick="" >다육</div>
	<div class="ctgrb" onclick="" >선인장</div>
	<div><hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;" /></div>
</div>
<div id="ctgr2" >
	<div class="ctgrb" onclick="" >넝쿨⦁잎</div>
	<div class="ctgrb" onclick="" >열매⦁꽃</div>
	<div><hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;" /></div>
</div>
<div id="ctgr3" >
	<div class="ctgrb" onclick="" >허브</div>
	<div class="ctgrb" onclick="" >채소</div>
	<div><hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;" /></div>
</div>

<table width="800">
<tr>
<td width="150" valign="top">
	<!-- 검색 조건 입력 폼 -->
	<form name="frm1">
	<!--  검색조건으로 링크를 걸기위한 쿼리스트링용 컨트롤들의 집합 -->
	<input type="hidden" name="sch" value="" />
	</form>
	<form name="frm2">
	<div>
		<strong style="font-size:13pt;">가격대</strong>&nbsp;&nbsp;
		<input type="text" name="sp" class="price" value="" placeholder="최저가" onkeyup="onlyNum(this);" style="height:20px;" />&nbsp;&nbsp; ~ &nbsp;
		<input type="text" name="ep" class="price" value="" placeholder="최고가" onkeyup="onlyNum(this);" style="height:20px;" />
		<input type="button" value="검색" class="btn" onclick="makeSch();" />
		<input type="button" value="검색 초기화" class="btn" onclick="" />
	</div>
	<br /><br />
	<div>
		<img src="/potted/resources/images/product/search.png" width="25"/>&nbsp;
		<input type="text" name="pdt" id="pdt" placeholder="식물 이름을 검색해 주세요." value="" style=" width:690px; border:0; font-size:13pt;" />
		<input type="button" value="검색" class="btn" onclick="initSch();" />
		<select name="ob" onchange="" >
			<option value="a">최근 순</option>
			<option value="b">인기 순</option>
			<option value="c">이름 순</option>
			<option value="d">높은 가격 순</option>
			<option value="e">낮은 가격 순</option>
		</select>
	</div>
	<hr />
	</form>	 
</td>
</tr>
<%
// String lnk = "productList?cpage=1" + pageInfo.getSchargs();	
int i = 0;
for (i = 0 ; i < productList.size() ; i++) {
	ProductInfo pi = productList.get(i);
	/* String stock = pi.getStock() + "ea";
	if (pi.getStock() > 0) {	// 재고가 남았으면
	lnk = "priduct_view?piid=" + pi.getPi_id();
	} else {	// 재고가 없으면
		lnk = "javascript:alert('현재재고가 없습니다.')";
		stock = "품절(SOLD OUT)";
	} */
	String price = pi.getPi_price() + "원";
	if (pi.getPi_dc() > 0) {	// 할인율이 있으면
		price = Math.round(pi.getPi_price() * (1 - pi.getPi_dc())) + "원";	// 할인이 있을때 실제 판매가
		price = "<del>" + pi.getPi_price() + "</del>&nbsp;&nbsp;&nbsp;" + price;	// <del>태그는 글자 중간에 밑줄긋기 / 원래판매금액 밑줄긋기
	}
	
	if (i % 4 == 0) out.println("<tr>");
%>
<td width="10%" align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
	<a href="">
		<img src="/mvcSite/product/pdt_img/<%=pi.getPi_img1() %>" width="150" height="150" border="0" />
		<br /><%=pi.getPi_name() %>
	</a>
	<br /><%=price %><br />
</td>		
<%		
	if (i % 4 == 3) out.println("</tr>");
}
%>
<tr>
<td>
</td>
</tr>


</table>
</div>

<%@ include file="../inc/inc_foot.jsp" %>