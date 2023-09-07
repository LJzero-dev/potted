<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");

int sy = ci.getSchYear(), sm = ci.getSchMonth(), sd = ci.getSchDay(), eDay = ci.getSchLast();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
select { border:1px solid #ced4da; padding:6px 12px; border-radius:5px; font-size:15px; }
input {	padding:5px 9px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
table { font-size:18px; }
#content { border:1px solid #ced4da; padding:6px 12px; border-radius:5px; font-size:17px; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script>
$(document).ready(function() {
	$("#btn").click(function() {
		var date = $("#y").val() + "-" + $("#m").val() + "-" + $("#d").val();
		var time = $("#h").val() + ":" + $("#n").val();
		
		$("#si_date").val(date);		$("#si_time").val(time);
// 값 확인용
//		alert($("#si_date").val() + "::" + $("#si_time").val());
		
		document.frm.submit();
	});
});

function chkVal(form) {
	if (form.title.value == "") {
		alert("일정 제목을 입력해주세요.");
		form.title.focus();
		return false;
	}
	if (form.content.value == "") {
		alert("일정 내용을 입력해주세요.");
		form.content.focus();
		return false;
	}
	
}
</script>
</head>
<body>
<h2>일정 등록</h2>
※날짜를 확인하시고 일정 내용을 입력해주세요.<br /><br />
<form name="frm" action="scheduleInProc" method="post" onsubmit="return chkVal(this);">
<input type="hidden" name="si_date" id="si_date" value="" />
<input type="hidden" name="si_time" id="si_time" value="" />
<table width="800" cellpadding="5">
<tr>
<th width="15%">일시</th>
<td width="*">
	<select name="y" id="y" onchange="resetday(this.value, this.form.m.value, this.form.d);">
<%for (int i = 200 ; i <= ci.getCurYear() + 10 ; i++) { %>
	<option <% if(i == sy) { %>selected="selected"<% } %>><%=i %></option>
<% } %>
	</select>년
	<select name="m" id="m" onchange="resetday(this.form.y.value, this.value, this.form.d);">
<%
for (int i = 1 ; i <= 12 ; i++) {
	String tmp = (i < 10 ? "0" + i : i + "");
	String slt = (i == sm ? " selected='selected'" : "");
%>
		<option <%=slt %>><%=tmp %></option>
<% } %>
	</select>월
	<select name="d" id="d">
<%
for (int i = 1 ; i <= eDay ; i++) {
	String tmp = (i < 10 ? "0" + i : i + "");
	String slt = (i == sd ? " selected='selected'" : "");
%>
		<option <%=slt %>><%=tmp %></option>
<% } %>
	</select>일&nbsp;&nbsp;&nbsp;&nbsp;
	<select name="h" id="h">
<%
for (int i = 0 ; i <= 23 ; i++) {
	String tmp = (i < 10 ? "0" + i : i + "");
%>
		<option><%=tmp %></option>
<% } %>
	</select>시
	<select name="n" id="n">
<%
for (int i = 0 ; i <= 59 ; i++) {
	String tmp = (i < 10 ? "0" + i : i + "");
%>
		<option><%=tmp %></option>
<% } %>
	</select>분
</td></tr>
<tr>
<th>일정제목</th>
<td><input type="text" name="title" /></td>
</tr>
<tr>
<th>일정내용</th>
<td><textarea id="content" name="content" rows="5" cols="45"></textarea></td>
</tr>
<tr><td colspan="2" align="right">
	<input type="button" value="취 소" onclick="history.back();" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="일정 등록" id="btn" />
</td></tr>
</table>
</form>
</body>
</html>