<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
LocalDate today = LocalDate.now();
int cyear = today.getYear();
ArrayList<MemberInfo> memberInfo = (ArrayList<MemberInfo>)request.getAttribute("memberInfo"); 
ArrayList<MemberInfo> memberAge = (ArrayList<MemberInfo>)request.getAttribute("memberAge"); 

CalendarInfo ci = (CalendarInfo)request.getAttribute("ci");
int sy = ci.getSchYear(), sm = ci.getSchMonth();
int sWeek = ci.getsWeek(), eDay = ci.getSchLast();
int minYear = 2000, maxYear = ci.getCurYear() + 10;
int nextYear = sy, nextMonth = sm + 1;
if (nextMonth == 13) { nextMonth = 1;	nextYear++; }
// 12월에서 '다음달' 버튼 클릭시 월은 1월로 연도를 1 증가 시킴

int prevYear = sy, prevMonth = sm - 1;
if (prevMonth == 0) { prevMonth = 12;	prevYear--; }

String prevYearLink = "location.href='memberChart?schYear=" + (sy - 1) + "&schMonth=" + sm + "';";
if (sy - 1 < minYear)	prevYearLink = "alert('이전 연도가 없습니다.');";

String prevMonthLink = "location.href='memberChart?schYear=" + prevYear + "&schMonth=" + prevMonth + "';";
if (prevYear < minYear && prevMonth == 12)	prevMonthLink = "alert('이전 연도가 없습니다.');";

String nextYearLink = "location.href='memberChart?schYear=" + (sy + 1) + "&schMonth=" + sm + "';";
if (sy + 1 > maxYear)	nextYearLink = "alert('다음 연도가 없습니다.');";

String nextMonthLink = "location.href='memberChart?schYear=" + nextYear + "&schMonth=" + nextMonth + "';";
if (nextYear > maxYear && nextMonth == 1)	nextMonthLink = "alert('다음 연도가 없습니다.');";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/potted/resources/css/style.css">
<title>Insert title here</title>
<style>
.btn1 { border: 0; width:100px; font-size: 20px; background: #0B9649; color:white; padding-bottom: 8px; cursor: pointer; border-radius: 20px; }
.btn2 { border: 0; width:100px; font-size: 20px; background: #fff; padding-bottom: 8px; cursor: pointer; }
.btn2:hover { border: 0; width:100px; font-size: 20px; background: #0B9649; padding-bottom: 8px; cursor: pointer; border-radius: 20px; }
#yearmonth { width:920px; text-align:center; }
#searchBox { margin-left:600px; }
#select { cellpadding:0; cellspacing:0; }
#select td { font-size:15px; border-bottom:1px solid #0B9649; font-size:15px; }
#chartDiv1 { width:1000px; height:300px; }
#chartDiv2 { width:1000px; height:300px; }
.go {padding:6px 12px; border-radius:6px; color:#495057; border:1px solid #ced4da; cursor:pointer; }
.go:hover { background-color:#ced4da; }
.go:active { background-color:#6B727A; }
</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
<input type="button" class="btn2" value="매출" onclick="location.href='salesSlip?kind=a&year=<%=cyear %>';" />
<input type="button" class="btn1" value="회원통계" onclick="location.href='memberChart';"/>
<hr width="1000" align="left" />
<div id="yearmonth">
<table>
<tr>
	<td style="font-size:15px; font-weight:bold;">월별 가입자 수</td>
	<td width="48%"></td>
	<td align="right" width="40%">
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
		<input type="button" class="go" value="작년" onclick="<%=prevYearLink %>" />
		<input type="button" class="go" value="이전달" onclick="<%=prevMonthLink %>" />
		<input type="button" class="go" value="이번달" onclick="location.href='memberChart';" />
		<input type="button" class="go" value="다음달" onclick="<%=nextMonthLink %>" />
		<input type="button" class="go" value="내년" onclick="<%=nextYearLink %>" />
		</td></tr>
		</table>
	</form>
	</td>
</tr>
</table>
</div>
<div id="chartDiv1"></div>
<hr width="1000" align="left" />
<div id="chartDiv2"></div>
	

</body>
<script>

/* 월별 회원 가입자 수 시작 */
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);

function drawBasic() {

    var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', '회원수');
      data.addRows([
<%
String tmp = "";
for (int j = 1 ; j <= eDay ; j++) {
	int cnt = 0;
	String d = "";
	if (j < 10)		d = "0" + j;
	else			d = j + "";
//	System.out.println(d);
	
	for (int i = 0 ; i < memberInfo.size() ; i++) {
		MemberInfo mi = memberInfo.get(i);
		if (mi.getMi_day().equals(d)) 		cnt = mi.getMi_count();
//		System.out.println(mi.getMi_day() + "::: " + d + " ::: " + cnt + " ::" + mi.getMi_day().equals(d));
	}
	tmp = (j == 1 ? "" : ", ") + "[" + j + ", " + cnt + "]";
	out.print(tmp);
}
%>
        ]);

      var options = {
        hAxis: {
          title: '<%=sm %>월'
        },
        vAxis: {
          title: '명'
        }
      };

      var chart = new google.visualization.LineChart(document.getElementById('chartDiv1'));

      chart.draw(data, options);
    }
/* 월별 회원 가입자 수 끝*/


/* 나이대별 회원 수 시작 */ 
<%
int cnt1 = 0, cnt2 = 0, cnt3 = 0, cnt4 = 0, cnt5 = 0, cnt6 = 0, cnt7 = 0;
for (int i = 0 ; i < memberAge.size() ; i++) {
	MemberInfo ma = memberAge.get(i);
	
	if (ma.getMi_age() < 14)	cnt1++;
	else if (14 <= ma.getMi_age() && ma.getMi_age() < 20)	cnt2++;
	else if (20 <= ma.getMi_age() && ma.getMi_age() < 30)	cnt3++;
	else if (30 <= ma.getMi_age() && ma.getMi_age() < 40)	cnt4++;
	else if (40 <= ma.getMi_age() && ma.getMi_age() < 50)	cnt5++;
	else if (50 <= ma.getMi_age() && ma.getMi_age() < 60)	cnt6++;
	else cnt7++;
}
%>
</script>
<script>
var agedata = [
	["나이대", "회원 수", {role:"style"}, {role:"annotation"}], ["만 14세", <%=cnt1%>, "red", "만 14세"], ["만 14~19세", <%=cnt2%>, "#0000ff", "만 14~19세"], 
	["20대", <%=cnt3%>, "green", "20대"], ["30대", <%=cnt4%>, "gray", "30대"], ["40대", <%=cnt5%>, "yellow", "40대"], ["50대", <%=cnt6%>, "pink", "50대"], ["60대", <%=cnt6%>, "orange", "60대"]
];
google.charts.load("current", {packages: ["corechart"]});
google.charts.setOnLoadCallback(drawBasic);

function drawBasic() {
	var data = google.visualization.arrayToDataTable(agedata);
	var options = {title: "나이대별 회원 수", "is3D" : true};
	var chart = new google.visualization.PieChart(document.getElementById("chartDiv2"));
	chart.draw(data, options);
}

/* 나이대별 회원 수 끝 */ 
</script>
</html>