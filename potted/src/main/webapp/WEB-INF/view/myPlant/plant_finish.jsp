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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<div style="width:1200px; margin: 0 auto; position:relative;" >
	<img src="/potted/resources/images/myPlant/tree<%=mt.getMt_grade() %>.png" style="width:500px; height:700px;" />
</div>
<%@ include file="../inc/inc_foot.jsp" %>