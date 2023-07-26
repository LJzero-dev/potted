<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.time.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberTree mt = (MemberTree)request.getAttribute("mt");
int point = (int)request.getAttribute("mp");
int addPoint = 0;;
String result = (String)request.getAttribute("result");
switch(mt.getMt_grade()) {
case 1:
	addPoint = 500 * (mt.getMt_hp()/1000+1);
	break;
case 2:
	addPoint = 150 * (mt.getMt_hp()/1000+1);
	break;
case 4:
	addPoint = 50 * (mt.getMt_hp()/1000+1);
	break;
}
if (mt.getMt_hp() < 5000) addPoint = 0;
%>
<script>
function finish(val) {
	if (val > 0)  document.frm.grade.value = val;
	frm.submit();
}
</script>
<div style="width:1200px; height:300px; margin: 0 auto; text-align: center; background-color:" >
<br /><br /><br /><br />
<h3>현재 식물 : <%=mt.getMt_grade() == 1 ? "고급" : mt.getMt_grade() == 2 ? "중급" : "초급" %>자용<br />
남은 HP : <%=mt.getMt_hp() %><br />
물준 횟수 : (<%=mt.getMt_count() %>/<%=mt.getMt_grade() == 4 ? "3" : mt.getMt_grade() == 2 ? "7" : "14" %>)<br />
상태 : <%=mt.getMt_hp() >= 9000 ? "S등급" : mt.getMt_hp() >= 8000 ? "A등급" : mt.getMt_hp() >= 7000 ? "B등급" : mt.getMt_hp() >= 6000 ? "C등급" : "폐사" %><br />
</h3>
<form name="frm" action="plnatFinish" method="post">
<input type="hidden" name="grade" id="grade" value="">
<input type="hidden" name="addPoint" value="<%=addPoint %>">
</form>
<% if(result.equals("false"))  { %>
<h3>실패 했어요!<br />
식물이 말라버렸네요!<br />
현재 포인트 <%=point %> + (<%=addPoint %>) 
</h3>
<input type="button" value="식물 고르기" onclick="finish(0);"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="다시 키우기" onclick="finish(<%=mt.getMt_grade() %>);"/>
<% } else { %>
<h3>축하 드려요!<br />
수확에 성공했어요!<br />
현재 포인트 <%=point %> + (<%=addPoint %>)<br /> 
<input type="button" value="식물 고르기" onclick="finish(0);"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="다시 키우기" onclick="finish(<%=mt.getMt_grade() %>);"/>
<% } %>
</div>
<div style="width:1200px; height:300px; margin: 0 auto; text-align:center; position:absolute; top:400px; left:50%; transform:translate(-50%); z-index: -1;">
	<img src="/potted/resources/images/myPlant/tree<%=mt.getMt_grade() %>.png" style="width:400px; height:400px; top:100px; left:100px; text-align:center;" />	
</div>

<%@ include file="../inc/inc_foot.jsp" %>
