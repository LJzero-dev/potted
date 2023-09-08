<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
OrderDetail od = (OrderDetail)request.getAttribute("od");

String rlName = od.getOd_name() + " | " + od.getOd_option();
%>

<style>
input {	padding:5px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
#reviewBox { width:800px; height:300px; margin-left:650px; }
#txt { width:500px; height:200px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; font-size:14px; }
</style>
<div id="reviewBox">
<h2>리뷰 작성</h2>
<form name="frmReview" method="post" action="reviewIn" onsubmit="return chkVal(this);" enctype="multipart/form-data">
<input type="hidden" name="oi_id" value="<%=od.getOi_id()%>" />
<input type="hidden" name="pi_id" value="<%=od.getPi_id()%>" />
<input type="hidden" name="rl_name" value="<%=rlName%>" />
<table>
	<tr><td>상품 명 : <%=od.getOd_name() %> | 옵션 : <%=od.getOd_option() %></td></tr>
	<tr><td><%=loginInfo.getMi_id() %></td></tr>
	<tr><td><label>좋아요<input type="radio" id="rl_good" name="rl_good" value="a" checked="checked" /></label>
			<label>별로에요<input type="radio" id="rl_good" name="rl_good" value="b" /></label></td></tr>
	<tr><td><textarea id="txt" name="rl_content"></textarea></td></tr>
	<tr><td><input type="file" name="uploadFile" id="rimg" /></td></tr>
	<tr><td><input type="submit" value="후기 등록" /></td></tr>
</table>
</form>
</div>
<script>
function chkVal(form) {
	if (form.txt.value == "") {
		alert("후기 내용을 입력해주세요.");
		form.txt.focus();
		return false;
	}
	
	alert("후기가 등록되었습니다.");
}
</script>
<%@ include file="../inc/inc_foot.jsp" %>