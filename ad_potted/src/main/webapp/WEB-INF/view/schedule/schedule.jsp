<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
// 달력 출력을 위한 정보(현재 연월일, 검색 연월, 말일 등)들을 저장하고 있는 인스턴스
List<ScheduleInfo> scheduleList = (List<ScheduleInfo>)request.getAttribute("scheduleList");
// 검색 연월에 해당하는 일정들의 목록을 저장하고 있는 List

int sy = ci.getSchYear(), sm = ci.getSchMonth();
int sWeek = ci.getsWeek(), eDay = ci.getSchLast();
// 1일의 요일 및 시작 번호(1~7, 1:월요일), 말일(루프의 조건으로 사용)

int minYear = 2000, maxYear = ci.getCurYear() + 10;
int nextYear = sy, nextMonth = sm + 1;
if (nextMonth == 13) { nextMonth = 1;	nextYear++; }
// 12월에서 '다음달' 버튼 클릭시 월은 1월로 연도를 1 증가 시킴

int prevYear = sy, prevMonth = sm - 1;
if (prevMonth == 0) { prevMonth = 12;	prevYear--; }
//1월에서 '이전달' 버튼 클릭시 월은 12월로 연도를 1 감소 시킴

String prevYearLink = "location.href='schedule?schYear=" + 
	(sy - 1) + "&schMonth=" + sm + "';";
if (sy - 1 < minYear)	prevYearLink = "alert('이전 연도가 없습니다.');";
String prevMonthLink = "location.href='schedule?schYear=" + 
	prevYear + "&schMonth=" + prevMonth + "';";
if (prevYear < minYear && prevMonth == 12)	prevMonthLink = "alert('이전 연도가 없습니다.');";

String nextYearLink = "location.href='schedule?schYear=" + 
	(sy + 1) + "&schMonth=" + sm + "';";
if (sy + 1 > maxYear)	nextYearLink = "alert('다음 연도가 없습니다.');";
String nextMonthLink = "location.href='schedule?schYear=" + 
	nextYear + "&schMonth=" + nextMonth + "';";
if (nextYear > maxYear && nextMonth == 1)	nextMonthLink = "alert('다음 연도가 없습니다.');";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/potted/resources/css/style.css">
<title>Insert title here</title>
<style>
a:link { color:black; text-decoration:none; }
a:hover { color:#0B9649; }
a:visited { color:black; text-decoration:none; }

#yearmonth { width:920px; text-align:center; }
#searchBox { position:absolute; float:right; }
.calendar, .calendar th, .calendar td { border:1px black solid; }
.calendar { border-collapse:collapse; }
.calendar td { height:100px; }
.txtRed { color:red; font-weight:bold; background:#FBCFCF; }
.txtBlue { color:blue; font-weight:bold; background:#CFE4FB; }
#txtToday { background:#efefef; }
.scheduleBox { width:700px; height:150px; background:#fbef84; padding:10px 5px; overflow:auto; position:absolute; top:200px; left:150px; display:none; font-size:0.9em; }
.today { background:#D4F6CD; }
#select { cellpadding:0; cellspacing:0; }
#select td { font-size:15px; border-bottom:1px solid #0B9649; font-size:15px; }
</style>
<script>
function showSchedule(num) {
	var obj = document.getElementById("box" + num);
	obj.style.display = "block";
}

function hideSchedule(num) {
	var obj = document.getElementById("box" + num);
	obj.style.display = "none";
}

function callDel(idx) {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href = "scheduleDel?idx=" + idx + '&sch=<%=sy+""+sm%>';
	}
}
</script>
</head>
<body>
<div id="yearmonth">
<table>
<tr>
	<td style="font-size:20px;"><%=sy %><br /><span align="left" style="font-size:40px; font-weight:bold;"><%=sm %>월</span></td>
	<td width="55%"></td>
	<td align="right" width="30%">
	<form name="frm">
		<table id="select"><tr><td align="left">년</td>
		<td><select name="schYear" onchange="this.form.submit();">
<% 		for (int i = minYear ; i <= maxYear ; i++) { %>
			<option <% if(sy == i) { %>selected="selected"<% } %>><%=i %></option>
<% 		} %>
		</select></td></tr><tr><td align="left">월</td>
		<td><select name="schMonth" onchange="this.form.submit();">
<% 		for (int i = 1 ; i <= 12 ; i++) { %>
			<option <% if(sm == i) { %>selected="selected"<% } %>><%=i %></option>
<% 		} %>
		</select></td></tr><tr><td align="justify" colspan="2" style="border:0px;">
		<input type="button" value="작년" onclick="<%=prevYearLink %>" />
		<input type="button" value="이전달" onclick="<%=prevMonthLink %>" />
		<input type="button" value="오늘" onclick="location.href='schedule';" />
		<input type="button" value="다음달" onclick="<%=nextMonthLink %>" />
		<input type="button" value="내년" onclick="<%=nextYearLink %>" />
		</td></tr>
		</table>
	</form>
	</td>
</tr>
</table>
</div>
<br />
<table width="900" class="calendar">
<tr height="30">
<th width="100">월</th><th width="100">화</th>
<th width="100">수</th><th width="100">목</th>
<th width="100">금</th><th width="100" class='txtBlue'>토</th>
<th width="100" class='txtRed'>일</th>
</tr>
<%
if (sWeek != 1) {	// 1일이 월요일이 아니면(1일의 시작위치가 처음이 아니면)
	out.println("<tr>");
	for (int i = 1 ; i < sWeek ; i++) {
		if (i == 7) {
			out.println("<td class='txtRed'></td>");
		} else if (i == 6) {
			out.println("<td class='txtBlue'></td>");
		} else {
			out.println("<td></td>");
		}
	}	
}

for (int i = 1, n = sWeek ; i <= eDay ; i++, n++) {
// i : 날짜의 일(day)을 표현하기 위한 변수
// n : 일주일이 지날 때 마다 다음 줄로 내리기 위한 변수
	String txtClass = "", txtID = "";

	if (n % 7 == 1)	out.println("<tr>");
	// 요일 번호가 1(월요일)이면 <tr>을 열어줌

	if (n % 7 == 6)			txtClass = " class='txtBlue'";
	else if (n % 7 == 0)	txtClass = " class='txtRed'";
	String sch = "", close = "";
	if (scheduleList.size() > 0) {	// 검색 연월에 해당하는 일정이 있을 경우
		String schDate = sy + "-" + (sm < 10 ? "0" + sm : sm) + "-" + (i < 10 ? "0" + i : i);	// si_date와 비교할 값
		out.println("<div class='scheduleBox' id='box" + i + "'>");
		for (ScheduleInfo si : scheduleList) {
			if (schDate.equals(si.getSi_date())) {
			// 현재 출력할 날짜에 해당하는 일정이 있을 경우
				sch = "<a href='javascript:showSchedule(" + i + ");'>📌" + si.getSi_title() + "</a>";
				close = "<input type='button' value='닫기' onclick='hideSchedule(" + i + ");' /><br /><br />";
%>
	<%=schDate %><span style="margin-right:240px;"></span><%=close %>
	일시 : <%=si.getSi_time() %>&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="삭제" onclick="callDel(<%=si.getSi_idx() %>);" />
	<br /><%=si.getSi_content().replace("\r\n", "<br />") %>
	<br /><br />등록일 : <%=si.getSi_regdate() %><hr />
<%
			}
		}
		out.println("</div>");
	}

	String args = "?y=" + sy + "&m=" + sm + "&d=" + i;
	
	if (ci.getCurDay() == i && ci.getCurMonth() == sm && ci.getCurYear() == sy) {
		out.println("<td valign='top' class='today'>" + "<a href='scheduleInForm" + args + "'>" + i + "</a><br />" + sch + "</td>");
	} else {
		out.println("<td valign='top'" + txtClass + ">" + "<a href='scheduleInForm" + args + "'>" + i + "</a><br />" + sch + "</td>");
	}
	
	if (n % 7 == 0) {	// 요일번호가 7의 배수(일요일)이면
		out.println("</tr>");
	} else if (i == eDay) {
		for (int j = n % 7 ; j < 7 ; j++) {
			if(j == 6) {
				out.println("<td class='txtRed'></td>");
			} else if(j == 5) {
				out.println("<td class='txtBlue'></td>");
			} else {
				out.println("<td></td>");
			}
		}
		out.println("</tr>");
	}
}
%>
</table>
※날짜를 클릭하면 일정등록이 가능합니다
</body>
</html>
