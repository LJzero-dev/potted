<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.time.*" %>
<%
LocalDate today = LocalDate.now();
int cyear = today.getYear();
int cmonth = today.getMonthValue();
int cday = today.getDayOfMonth();
int last = today.lengthOfMonth();
%>
<style>
#joinBox { width:800px; margin-left:550px; margin-top:20px; }
#msg { font-size:20px; font-weight:bold; color:#0B9649; }
#msg2 { font-size:18px; color:#0B9649; }
#joinTable tr { height:50px; }
#joinTable td { vertical-align:top; font-size:15px; }
select { border:1.5px solid #ced4da; padding:6px 12px; border-radius:5px; }
.item { font-size:17px; }
input {	padding:7px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
#tos { width:590px; height:200px; }
#agree { font-size:16px; }
#goJoin { width:200px; height:40px; background:#0B9649; color:white; font-size: 15px; border-radius: 20px; border:1.5px solid  #6E6E6E; cursor: pointer; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<div id="joinBox">
<h2>회원가입</h2>
<span id="msg">*모든 항목은 입력필수입니다</span>
<form name="frmJoin" action="login" method="post">
<table id="joinTable" cellpadding="10"><tr>
	<td class="item">이용약관 동의</td>
	<td><label><input type="checkbox" /><span id="agree">동의 합니다.</span></label>
	<br /><iframe id="tos" src="termsOfService"></iframe><br /><br /></td>
</tr><tr>
	<td class="item">아이디</td>
	<td><input type="text" maxlength="20" placeholder="아이디" name="mi_id" onkeyup="chkDupId(this.value);" />&nbsp;&nbsp;<span id="idMsg">*아이디는 4~20자로 입력해주세요.</span></td>
</tr><tr>
	<td class="item">비밀번호</td>
	<td><input type="password" maxlength="20" placeholder="비밀번호" name="mi_pw" />
	<br /><input type="password" maxlength="20" placeholder="비밀번호 확인" name="mi_pw2" /></td>
</tr><tr>
	<td class="item">이메일</td>
	<td><input type="text" maxlength="25" placeholder="이메일 아이디" /> @ <input type="text" maxlength="25" placeholder="이메일 도메인" />
	<select id="domain" onchange="onDomain">
		<option>직접 입력</option>
		<option>gmail.com</option>
		<option>nate.com</option>
		<option>naver.com</option>
	</select></td>
</tr><tr>
	<td class="item">연락처</td>
	<td><input type="text" maxlength="3" /> - <input type="text" maxlength="4" /> - <input type="text" maxlength="4" /></td>
</tr><tr>
	<td class="item">이름</td>
	<td><input type="text" maxlength="20" placeholder="이름" name="" /></td>
</tr><tr>
	<td class="item">생년월일</td>
	<td><select name="year" onchange="resetday(this.value, this.form.month.value, this.form.day);">
<% for (int i = 1950 ; i <= cyear ; i++) { %>
		<option <% if(i == cyear) { %>selected="selected"<% } %>><%=i %></option>
<% } %>
	</select>&nbsp;년
	<select name="month" onchange="resetday(this.form.year.value, this.value, this.form.day);">
<% for (int i = 1 ; i <= 12 ; i++) { 
	String tmp = (i < 10 ? "0" + i : i + "");
	String slt = (i == cmonth ? " selected='selected'" : "");
%>
		<option <%=slt %>><%=tmp %></option>
<% } %>
	</select>&nbsp;월
	<select name="day">
<% for (int i = 1 ; i <= last ; i++) { 
	String tmp = (i < 10 ? "0" + i : i + "");
	String slt = (i == cday ? " selected='selected'" : "");
%>
		<option <%=slt %>><%=tmp %></option>
<% } %>
	</select>&nbsp;일</td>
</tr><tr>
	<td class="item">성별</td>
	<td><label>남 <input type="radio" id="male" name="mi_gender" checked="checked" /></label>&nbsp;&nbsp;&nbsp;&nbsp;<label>여 <input type="radio" name="mi_gender" id="female" /></label></td>
</tr><tr>
	<td class="item">주소</td>
	<td><span id="msg2">*회원가입시 입력한 주소가 기본 배송지로 등록됩니다.</span>
<table id="addrBox"><tr>
	<td>우편 번호 : </td><td><input type="text" />&nbsp;&nbsp;&nbsp;<input id="addrFind" type="button" onclick="" value="우편번호 찾기" /></td>
</tr><tr>
	<td>주소 : </td><td><input type="text" /></td>
</tr><tr>
	<td>상세 주소 : </td><td><input type="text" /></td>
</tr></table></td></tr><tr>
	<td colspan="2" align="center"><input id="goJoin" type="submit" value="가입하기" /></td></tr>
</table>
</form>
</div>
<script>
function chkDupId(uid) {
	if (uid.length >= 4) {
		$.ajax({
			type : "POST", url : "./dupId", data : {"uid" : uid},
			success : function(chkRs) {
				var msg = "";
				if (chkRs == 0) {
					msg = "<span style='color:blue;'>사용하실 수 있는 ID입니다.</span>";
					$("#idChk").val("y");
				} else {
					msg = "<span style='color:red;'>*이미 사용중인 ID입니다.</span>";
					$("#idChk").val("n");
				}
				$("#idMsg").html(msg);
			}
		});
	} else {
		$("#idMsg").text("*아이디는 4~20자로 입력해주세요.");
		$("#idChk").val("n");
	}
}
</script>

<%@ include file="../inc/inc_foot.jsp" %>