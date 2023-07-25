<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.time.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberTree mt = (MemberTree)request.getAttribute("mt");
String result = (String)request.getAttribute("result");
%>
<div style="width:1200px; height:300px; margin: 0 auto; text-align: center; background-color:" >
<br /><br /><br /><br />
<h3>asdfasdfajskdfnasfdl</h3>
<h3>asdfasdfajskdfnasfdl</h3>
<h3>asdfasdfajskdfnasfdl</h3>
<input type="button" value="aa" />
</div>
<div style="width:1200px; height:1000px; margin: 0 auto; text-align:center; position:absolute; top:0px; left:50%; transform:translate(-50%); z-index: -1;">
	<img src="/potted/resources/images/myPlant/tree<%=mt.getMt_grade() %>.png" style="width:500px; height:700px; left:100px; text-align:center;" />	
</div>

<%@ include file="../inc/inc_foot.jsp" %>
