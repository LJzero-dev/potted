<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="org.json.simple.parser.*" %>

<div id="app">
	<ul>
		<li v-for="item in arrObj">{{item.body.items.item[0].korNm}}</li>
	</ul>
</div>
<script>
new Vue({
	el : "#app",
	data : {		
		arrObj : ${plantListJson}
	}
});
</script>
<%@ include file="../inc/inc_foot.jsp" %>