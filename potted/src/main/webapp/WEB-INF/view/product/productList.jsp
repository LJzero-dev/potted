<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.springframework.context.annotation.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
%>

<style>
.bigCtgr {
	width:100px; height:30px; font-size:1.5em; background:#efefef; text-align:center; border:1px solid #c1c1c1; 
	margin:10px; padding:5px; display:inline-block;
}
#pcb { background:lightgreen; }
del { font-size:0.8em; color:#c0c0c0;}
.saleStock { font-size:0.8em; }
</style>
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

function smallCtgr() {
// 대분류 선택에 따라 소분류를 다르게 보여주는 메소드

}
 
</script>
<h2>상품 목록</h2>
<div class="bigCtgr" id="pcb"><a href="productList?pcb=AA" onclick="smallCtgr(this.value);">다육.선인장</a></div>
<div class="bigCtgr" id="pcb"><a href="productList?pcb=BB" onclick="smallCtgr(this.value);">관엽식물</a></div>
<div class="bigCtgr" id="pcb"><a href="productList?pcb=CC" onclick="smallCtgr(this.value);">허브.식물</a></div>
<%
// 대분류에 따른 소분류 보여줄 부분
%>
<hr />
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
		<input type="text" name="pdt" id="pdt" placeholder="상품명 검색" value="" /><br />
		<fieldset>
			<legend>가격대</legend>
			<input type="text" name="sp" class="price" value="" placeholder="최저가" onkeyup="onlyNum(this);" /> ~
			<input type="text" name="ep" class="price" value="" placeholder="최고가" onkeyup="onlyNum(this);" />
		</fieldset>
		<input type="button" value="상품검색" class="btn" onclick="makeSch();" />
		<input type="button" value="조건 초기화" class="btn" onclick="initSch();" />
	</div>
	</form>	 
</td>
<td width="*" valign="top">
	<!--  상품 목록 및 페이징 영역 -->
	<p align="right">
		<select name="ob" onchange="location.href='&ob=' + this.value;">
			<option value="a">신상품 순</option>
			<option value="b">인기 순</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<!-- 상품 이미지 부분 -->
	</p>
	<hr />
	<table width="100%" cellpadding="15" cellspacing="0">
<%
// 재고 , 가격, 할인율 보여줄 부분
%>
	
	<tr align="center" onmouseover="this.bgColor='#efefef';" onmouseout="this.bgColor='';">
	<td width="25%"><a href=""><img src="/mvcSite/product/pdt_img/" width="80" height="80" border="0" /></a></td>
	<td width="*" align="left">&nbsp;&nbsp;<a href=""></a></td>
	<td width="20%" align="left">2000원</td><td width="20%">판매 : 판매량 <br /> 재고 : 재고</td>
	</tr>
<%
// 페이징 영역
%>
</td>
</tr>
</table>

<%@ include file="../inc/inc_foot.jsp" %>