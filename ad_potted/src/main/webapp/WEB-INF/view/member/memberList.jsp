<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<MemberInfo> memberList = (ArrayList<MemberInfo>)request.getAttribute("memberList");
DecimalFormat formatter = new DecimalFormat("###,###,###,###");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
input {	padding:2px 2px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; cursor:pointer; }
.btn { border:0; background-color:#fff; font-size:17px; }
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; }
#table th, td{ font-weight: lighter; border:1.5px solid #6B727A; }
#table { border:1.5px solid #6B727A; border-collapse:collapse; text-align:center; width:900px; }
#table tr { width:800px; height:50px; }
</style>
</head>
<body>
<h2>회원관리</h2>
<table id="table">
<tr>
<th width="7%">no</th>
<th width="14%">회원ID</th>
<th width="*">구매금액</th>
<th width="13%">회원 상태</th>
<th width="19%">회원가입일</th>
<th width="22%">최종 접속일</th>
</tr>
<% if (memberList.size() > 0) {
	for (int i = 0 ; i < memberList.size() ; i++) { 
		MemberInfo mi = memberList.get(i);	
		String lastlogin = "", status = "";
		if (mi.getMi_lastlogin() == null)		lastlogin = "로그인 내역 없음.";
		else									lastlogin = mi.getMi_lastlogin();
		if (mi.getMi_status().equals("a"))		status = "정상";
		else if (mi.getMi_status().equals("a"))	status = "휴면";
		else									status = "탈퇴";
%>
<tr onmouseover="this.style.background='#CFD4CD';" onmouseout="this.style.background='';"><td><%=memberList.size() - i %></td><td>
<a href="javascript:showDetail('<%=mi.getMi_id() %>')"><%=mi.getMi_id() %></a></td><td><%=formatter.format(mi.getPurchase_sum()) %></td><td><%=status %></td><td><%=mi.getMi_date() %></td><td><%=lastlogin %></td></tr>
<%
	}
} 
%>
<tr><td colspan="6"><c:if test="${pi.getRcnt() > 0}">
		<c:if test="${pi.getCpage() == 1}">
			<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
		</c:if>
		<c:if test="${pi.getCpage() > 1}">
			<a href="memberList?cpage=1${pi.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
			<a href="memberList?cpage=${pi.getCpage() - 1}${pi.getSchargs()}"><</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach var="i" begin="${pi.getSpage()}" end="${pi.getSpage() + pi.getBsize() - 1 < pi.getPcnt() ? pi.getSpage() + pi.getBsize() - 1 : pi.getPcnt() }" >
			<c:if test="${i == pi.getCpage()}">
				&nbsp;<strong>${i}</strong>&nbsp;
			</c:if>
			<c:if test="${i != pi.getCpage()}">
				&nbsp;<a href="memberList?cpage=${i}${pi.getSchargs()}">${i}</a>&nbsp;
			</c:if>
		</c:forEach>
		
		<c:if test="${pi.getCpage() == pi.getPcnt()}">
			&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
		</c:if>
		<c:if test="${pi.getCpage() < pi.getPcnt()}">
			&nbsp;&nbsp;<a href="memberList?cpage=${pi.getCpage() + 1}${pi.getSchargs()}">></a>
			&nbsp;&nbsp;&nbsp;<a href="memberList?cpage=${pi.getPcnt()}${pi.getSchargs()}">>></a>
		</c:if>
	</c:if>
</td></tr>
</table>
<table>

</table>
<script>
function showDetail(id) {
	awin = window.open("memberDetail?miid=" + id, "memberDetail", "width=950,height=350,left=710,top=200");
}
</script>
</body>
</html>
