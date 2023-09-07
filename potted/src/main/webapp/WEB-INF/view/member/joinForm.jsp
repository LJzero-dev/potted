<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
LocalDate today = LocalDate.now();
int cyear = today.getYear();
int cmonth = today.getMonthValue();
int cday = today.getDayOfMonth();
int last = today.lengthOfMonth();

%>
<style>
#joinBox { width:850px; margin-left:470px; margin-top:20px; }
#msg { font-size:20px; font-weight:bold; color:#0B9649; }
#msg2 { font-size:16px; color:#0B9649; }
#joinTable tr { height:50px; }
#joinTable td { vertical-align:top; font-size:15px; }
select { border:1.5px solid #ced4da; padding:6px 12px; border-radius:5px; cursor: pointer; }
.item { font-size:17px; }
input {	padding:7px 12px; border-radius:4px; color:#495057; border:1.5px solid #ced4da; }
#tos { width:680px; height:200px; }
#agree { font-size:16px; }
#goJoin { width:200px; height:40px; background:#0B9649; color:white; font-size: 15px; border-radius: 20px; border:1.5px solid  #6E6E6E; cursor: pointer; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/date_change.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addr_api.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div id="joinBox">
<h1>회원가입</h1>
<span id="msg">*모든 항목은 입력필수입니다</span>
<form name="frmJoin" action="memberJoin" method="post" onsubmit="return chkVal(this);">
<input type="hidden" name="idChk" id="idChk" value="n" />
<input type="hidden" name="pwChk" id="pwChk" value="n" />
<table id="joinTable" cellpadding="10"><tr>
	<td class="item">이용약관 동의${nickname}</td>
	<td><iframe id="tos" src="termsOfService"></iframe><br /><label><input type="checkbox" id="isagree" /><span id="agree">위 약관에 동의 합니다.</span></label><br /></td>
</tr><tr>
	<td class="item">아이디</td>
	<td><input type="text" maxlength="20" placeholder="아이디" name="mi_id" id="uid" onkeyup="chkDupId(this.value);" />&nbsp;&nbsp;<span id="idMsg">※아이디는 4~20자로 입력해주세요.</span></td>
</tr><tr>
	<td class="item">비밀번호</td>
	<td><input type="password" maxlength="20" placeholder="비밀번호" name="mi_pw" id="mi_pw" onkeyup="chkPw(this.form.mi_pw2.value, this.value);" />
	<br /><input type="password" maxlength="20" placeholder="비밀번호 확인" name="mi_pw2" id="mi_pw2"  onkeyup="chkPw(this.value, this.form.mi_pw.value);" />&nbsp;&nbsp;<span id="pwMsg">※비밀번호는 4~20자 이내로 입력하세요.</span></td>
</tr><tr>
	<td class="item">이메일</td>
	<td><input type="text" name="e1" id="e1" size="10" maxlength="25" placeholder="이메일 아이디" /> @ <input type="text" name="e3" id="e3" size="10" maxlength="25" placeholder="이메일 도메인" />
	<select name="e2" id="e2">
		<option value="">도메인 선택</option>
		<option>gmail.com</option>
		<option>nate.com</option>
		<option>naver.com</option>
		<option value="direct">직접 입력</option>
	</select></td>
</tr><tr>
	<td class="item">연락처</td>
	<td><input type="text" size="10" id="p1" name="p1" maxlength="3" /> - <input type="text" size="10" id="p2" name="p2" maxlength="4" /> - <input type="text" id="p3" name="p3" size="10" maxlength="4" /></td>
</tr><tr>
	<td class="item">이름</td>
	<td><input type="text" maxlength="20" placeholder="이름" id="mi_name" name="mi_name" /></td>
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
	<td><label>남 <input type="radio" id="male" name="mi_gender" checked="checked" value="남" /></label>&nbsp;&nbsp;&nbsp;&nbsp;<label>여 <input type="radio" name="mi_gender" value="여" id="female" /></label></td>
</tr><tr>
	<td class="item">주소</td>
	<td><span id="msg2">*회원가입시 입력한 주소가 기본 배송지로 등록됩니다.</span>
<table id="addrBox"><tr>
	<td align="right">우편 번호 : &nbsp;</td><td><input type="text" id="sample4_postcode" name="ma_zip" size="10" placeholder="우편번호" />&nbsp;&nbsp;&nbsp;
	<input id="addrFind" type="button" value="우편번호 찾기" onclick="sample4_execDaumPostcode()" /><br /><span id="guide" style="color:#999;display:none; position:absolute; top:-500px; left:-500px;"></span></td>
</tr><tr>
	<td align="right">주소 : &nbsp;</td><td><input type="text" id="sample4_roadAddress" name="ma_addr1" size="40" placeholder="도로명주소" />
	<input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="display:none;">
	<input type="text" id="sample4_extraAddress" placeholder="참고항목" style="display:none;"></td>
</tr><tr>
	<td align="right">상세 주소 : &nbsp;</td><td><input type="text" id="sample4_detailAddress" name="ma_addr2" size="40" placeholder="상세주소" /></td>
</tr></table></td></tr><tr>
	<td class="item">광고 수신 여부</td>
	<td><label>동의 <input type="radio" name="mi_isad" value="y" checked="checked" /></label>&nbsp;&nbsp;&nbsp;&nbsp;<label>미동의 <input type="radio" name="mi_isad" value="n" /></label></td>
</tr><tr>
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
					msg = "<span style='color:blue;'>아이디가 확인되었습니다.</span>";
					$("#idChk").val("y");
				} else {
					msg = "<span style='color:red;'>※이미 사용중인 아이디입니다.</span>";
					$("#idChk").val("n");
				}
				$("#idMsg").html(msg);
			}
		});
	} else {
		$("#idMsg").text("※아이디는 4~20자로 입력해주세요.");
		$("#idChk").val("n");
	}
}

function chkPw(pw2, pw) {
	if (pw.length >= 4 && pw2.length >= 4) {
		$.ajax({
			type : "POST", url : "./chkPw", data : {"pw2" : pw2, "pw" : pw},
			success : function(chkRs) {
				var msg = "";
				if (chkRs == 0) {
					msg = "<span style='color:red;'>비밀번호가 다릅니다.</span>";
					$("#pwChk").val("n");
				} else {
					msg = "<span style='color:blue;'>비밀번호가 확인되었습니다.</span>";
					$("#pwChk").val("y");
				}
				$("#pwMsg").html(msg);
			}
		});
	} else {
		$("#pwMsg").text("※비밀번호는 4~20자 이내로 입력하세요.");
		$("#pwChk").val("n");
	}
}

$(document).ready(function() {
	$("#e2").change(function() {
		if ($(this).val() == "") {
			$("#e3").val("");
		} else if ($(this).val() == "direct") {
			$("#e3").val("");	$("#e3").focus();
		} else {
			$("#e3").val($(this).val());
		}
	});
});

function chkVal(form) {
	if (form.isagree.checked == false) {
		alert("약관에 동의해주세요.");
		form.isagree.focus();
		return false;
	}
	if (form.uid.value == "") {
		alert("아이디를 입력해주세요.");
		form.uid.focus();
		return false;
	}
	if (form.mi_pw.value == "") {
		alert("비밀번호를 입력해주세요.");
		form.mi_pw.focus();
		return false;
	}
	if (form.mi_pw2.value == "" || form.mi_pw2.value != form.mi_pw.value) {
		alert("비밀번호 확인을 완료해주세요.");
		form.mi_pw2.focus();
		return false;
	}
	if (form.e1.value == "" || form.e3.value == "") {
		alert("이메일을 입력해주세요.");
		form.e1.focus();
		return false;
	}
	if (form.p1.value == "" || form.p2.value == "" || form.p3.value == "") {
		alert("전화번호를 입력해주세요.");
		form.p1.focus();
		return false;
	}
	if (form.mi_name.value == "") {
		alert("이름을 입력해주세요.");
		form.mi_name.focus();
		return false;
	}
	if (form.sample4_postcode.value == "") {
		alert("주소를 입력해주세요.");
		form.sample4_postcode.focus();
		return false;
	}
	if (form.idChk.value == "n" || form.pwChk.value == "n") {
		alert("입력정보를 다시 확인해주세요.");
		return false;
	}
	
	alert("POTTED 회원가입을 축하합니다!");
}

</script>

<%@ include file="../inc/inc_foot.jsp" %>