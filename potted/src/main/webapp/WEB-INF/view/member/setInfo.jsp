<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
MemberInfo loginInfo = (MemberInfo)session.getAttribute("loginInfo");

ArrayList<MemberAddr> memberAddrList = (ArrayList<MemberAddr>)request.getAttribute("memberAddrList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
MemberAddr ma = (MemberAddr)request.getAttribute("ma");

String[] arrPhone = ma.getMa_phone().split("-");
String p1 = arrPhone[0], p2 = arrPhone[1], p3 = arrPhone[2];

int idx = memberAddrList.get(memberAddrList.size() - 1).getMa_idx() + 1;
%>
<c:set var="loginInfo" value="<%=loginInfo %>" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addr_api.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addr_api2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
select { border:1.5px solid #ced4da; padding:6px 12px; border-radius:5px; align:right; }
input {	padding:9px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
table { font-size:18px; }
#sel { background:#ced4da; }
#btn1 { border: 0; width:100px; font-size: 18px; background:#fff; padding-bottom: 8px; cursor: pointer; border-radius:0px; }
#btn1:hover { font-weight:bold; }
#btn2 { border: 0; width:100px; font-size: 18px; background:#ced4da; padding-bottom: 8px; cursor: pointer; border-radius:0px; }
#btn2:hover { font-weight:bold; }
.listbox { margin-left:60px; width:760px; border:1.5px solid #ced4da; background:#ced4da; }
#menu1 { background:#fff; padding-top:10px; padding-bottom:10px; }
#menu2 { background:#fff; padding-top:10px; padding-bottom:10px; display:none; }
</style>
</head>
<body>
<div class="listbox"><div id="sel">
<input type="button" id="btn1" value="주소 수정" onclick="showMenu(1);" />
<input type="button" id="btn2" value="주소 추가" onclick="showMenu(2);"/></div>
<div id="menu1">
	<form name="frmAddr1" action="addrUpdate" method="post" onsubmit="return chkVal1(this);">
	<table cellpadding="5" align="center">
	<tr><td>변경할 주소 선택 : </td><td>
		<select name="maidx" onchange="location.href='setInfo?maidx=' + this.value;">
<%
			for (int i = 0 ; i < memberAddrList.size() ; i++) {
				MemberAddr sma = memberAddrList.get(i);
%>
			<option value="<%=sma.getMa_idx() %>" <%if (pageInfo.getCpage() == sma.getMa_idx()) {%>selected="selected"<% } %>><%=sma.getMa_name() %></option>
<%
}
%>
	</select></td></tr>
	<tr><td align="right">주소 이름 : </td><td><input type="text" id="ma_name" name="ma_name" maxlength="20" size="10" value="<%=ma.getMa_name() %>" placeholder="주소 이름" />
	&nbsp;&nbsp;&nbsp;기본 주소 여부 : <input type="checkbox" <%if (ma.getMa_basic().equals("y")) {%> checked="checked" <% } %> id="ma_basic" name="ma_basic" /></td></tr>
	<tr><td align="right">수령인 : </td><td><input type="text" id="ma_rname" name="ma_rname" maxlength="20" size="10" value="<%=ma.getMa_rname() %>" placeholder="수령인 이름" /></td></tr>
	<tr><td align="right">연락처 : </td><td><input type="text" size="10" id="p1" name="p1" maxlength="3" value="<%=p1 %>" /> - <input type="text" size="10" id="p2" name="p2" maxlength="4" value="<%=p2 %>" /> - <input type="text" id="p3" name="p3" size="10" maxlength="4" value="<%=p3 %>" /></td></tr>
	<tr><td align="right">우편번호 : </td><td><input type="text" name="ma_zip" maxlength="5" size="10" value="<%=ma.getMa_zip() %>" id="sample4_postcode" placeholder="우편번호" />&nbsp;&nbsp;&nbsp;
		<input id="addrFind" type="button" value="우편번호 찾기" onclick="sample4_execDaumPostcode()" /><span id="guide" style="color:#999;display:none; position:absolute; top:-500px; left:-500px;"></span></td></tr>
	<tr><td align="right">주소 : </td><td><input type="text" name="ma_addr1" maxlength="50" size="40" value="<%=ma.getMa_addr1() %>" id="sample4_roadAddress" placeholder="도로명 주소" /></td></tr>
	<tr><td align="right">상세주소 : </td><td><input type="text" name="ma_addr2" maxlength="50" size="40" value="<%=ma.getMa_addr2() %>" id="sample4_detailAddress" placeholder="상세 주소" />
		<input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="display:none;">
		<input type="text" id="sample4_extraAddress" placeholder="참고항목" style="display:none;"></td></tr>
	<tr><td colspan="2" align="center"><input type="submit" value="주소 변경하기" /></td></tr>
	</table>
	</form>
</div>
<div id="menu2">
	<form name="frmAddr2" action="addrInsert" method="post" onsubmit="return chkVal2(this);">
		<input type="hidden" value="<%=idx %>" name="idx" />
		<table cellpadding="5" align="center">
		<tr><td align="right">주소 이름 : </td><td><input type="text" id="ma_name" name="ma_name" maxlength="20" size="10" value="" placeholder="주소 이름" />
		&nbsp;&nbsp;&nbsp;기본 주소 여부 : <input type="checkbox" id="ma_basic" name="ma_basic" /></td></tr>
		<tr><td align="right">수령인 : </td><td><input type="text" id="ma_rname" name="ma_rname" maxlength="20" size="10" value="" placeholder="수령인 이름" /></td></tr>
		<tr><td align="right">연락처 : </td><td><input type="text" size="10" id="p1" name="p1" maxlength="3" value="" /> - <input type="text" size="10" id="p2" name="p2" maxlength="4" value="" /> - <input type="text" id="p3" name="p3" size="10" maxlength="4" value="" /></td></tr>
		<tr><td align="right">우편번호 : </td><td><input type="text" name="ma_zip" maxlength="5" size="10" value="" id="sample3_postcode" placeholder="우편번호" />&nbsp;&nbsp;&nbsp;
			<input id="addrFind" type="button" value="우편번호 찾기" onclick="sample3_execDaumPostcode()" /><span id="guide2" style="color:#999;display:none; position:absolute; top:-500px; left:-500px;"></span></td></tr>
		<tr><td align="right">주소 : </td><td><input type="text" name="ma_addr1" maxlength="50" size="40" value="" id="sample3_roadAddress" placeholder="도로명 주소" /></td></tr>
		<tr><td align="right">상세주소 : </td><td><input type="text" name="ma_addr2" maxlength="50" size="40" value="" id="sample3_detailAddress" placeholder="상세 주소" />
			<input type="text" id="sample3_jibunAddress" placeholder="지번주소" style="display:none;">
			<input type="text" id="sample3_extraAddress" placeholder="참고항목" style="display:none;"></td></tr>
		<tr><td colspan="2" align="center"><input type="submit" value="주소 추가하기" /></td></tr>
		</table>
	</form>
</div>
</div>

<script>
var cmenu = 1;
function showMenu(num) {
	var obj = document.getElementById("menu" + cmenu);
	obj.style.display = "none";
	var b1 = document.getElementById("btn" + cmenu);
	b1.style.backgroundColor = "#ced4da";
	
	var menu = document.getElementById("menu" + num); 
	menu.style.display = "block"; 
	var b2 = document.getElementById("btn" + num);
	b2.style.backgroundColor = "#fff";
	cmenu = num;
}

function chkVal1(form) {
	if (form.ma_name.value == "") {
		alert("주소 이름을 적어주세요.");
		form.ma_name.focus();
		return false;
	}
	if (form.ma_rname.value == "") {
		alert("수령인 이름을 적어주세요.");
		form.ma_rname.focus();
		return false;
	}
	if (form.p1.value == "" || form.p2.value == "" || form.p3.value == "") {
		alert("수령인 연락처를 입력해주세요.");
		form.p1.focus();
		return false;
	}
	if (form.ma_zip.value == "") {
		alert("우편번호를 입력해주세요.");
		form.ma_zip.focus();
		return false;
	}
	if (form.ma_addr1.value == "") {
		alert("주소를 입력해주세요.");
		form.ma_addr1.focus();
		return false;
	}
	if (form.ma_addr2.value == "") {
		alert("상세 주소를 입력해주세요.");
		form.ma_addr2.focus();
		return false;
	}
	
	alert("주소가 변경되었습니다.");
}

function chkVal2(form) {
	if (form.ma_name.value == "") {
		alert("주소 이름을 적어주세요.");
		form.ma_name.focus();
		return false;
	}
	if (form.ma_rname.value == "") {
		alert("수령인 이름을 적어주세요.");
		form.ma_rname.focus();
		return false;
	}
	if (form.p1.value == "" || form.p2.value == "" || form.p3.value == "") {
		alert("수령인 연락처를 입력해주세요.");
		form.p1.focus();
		return false;
	}
	if (form.ma_zip.value == "") {
		alert("우편번호를 입력해주세요.");
		form.ma_zip.focus();
		return false;
	}
	if (form.ma_addr1.value == "") {
		alert("주소를 입력해주세요.");
		form.ma_addr1.focus();
		return false;
	}
	if (form.ma_addr2.value == "") {
		alert("상세 주소를 입력해주세요.");
		form.ma_addr2.focus();
		return false;
	}
	
	alert("주소가 추가되었습니다.");
}
</script>
</body>
</html>