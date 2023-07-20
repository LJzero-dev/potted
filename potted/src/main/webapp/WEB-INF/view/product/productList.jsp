<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.springframework.context.annotation.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
%>

<style>
.ctgrb { padding: 6px 20px; font-size: 20px; font-color: #B8B8B8; cursor: pointer; text-align: center; 
	background: white; border: 2px; border-radius: 20px; border-color: #B8B8B8; }
.ctgrb:hover { font-color: #0B9649; border-color: #0B9649; }
.ctgrb:active { background-color: #3e8e41; }
.btn { background:white; border-radius: 20%; cursor: pointer; }
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

function cimage(ctgr) {
	if (ctgr.equals("AA"))
}

// 대분류에 따른 소분류
</script>
<div style="width:800px; margin:0 auto; ">
<h2 style="font-size:20pt;">STORE</h2>
<form>
<div class="ctgrb" onclick="" >다육선〮인장</div>
<img src="/potted/resources/images/product/reset.png" width="120" style="cursor:pointer;" /><br />
<a href="javascript:cimage('AA');"><img id="imageA" src="/potted/resources/images/product/AA.png" width="150" /></a>
<a href="javascript:cimage('BB');"><img id="imageB" src="/potted/resources/images/product/BB.png" width="150" /></a>
<a href="javascript:cimage('CC');"><img id="imageC" src="/potted/resources/images/product/CC.png" width="150" /></a>
</form>
<%
// 대분류에 따른 소분류 보여줄 부분
%>
<hr style="border-width:1px 0 0 0; border-style:dotted; border-color:#bbb;" />
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
		<input type="button" value="검색" class="btn" onclick="makeSch();" /><br />
	</div>
	<br /><br />
	<div>
		<img src="/potted/resources/images/product/search.png" width="25"/>
		<input type="text" name="pdt" id="pdt" placeholder="식물 이름을 검색해 주세요." value="" style=" width:700px; border:0;" />
		<input type="button" value="검색" class="btn" onclick="" />
	</div>
	<hr />
	</form>	 
</td>
</table>
</div>

<%@ include file="../inc/inc_foot.jsp" %>