<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<MemberInfo> memberInfo = (ArrayList<MemberInfo>)request.getAttribute("memberInfo"); 

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
#yearmonth { width:920px; text-align:center; }
#searchBox { margin-left:600px; }
#select { cellpadding:0; cellspacing:0; }
#select td { font-size:15px; border-bottom:1px solid #0B9649; font-size:15px; }
</style>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
<input type="button" class="btn2" value="매출" onclick="location.href='salesSlip';" />
<input type="button" class="btn1" value="회원통계" onclick="location.href='memberChart';"/>
<hr width="900" align="left" />
<div id="yearmonth">
<table>
<tr>
	<td style="font-size:15px;"><%=sy %>년<br /><span align="left" style="font-size:30px; font-weight:bold;"><%=sm %>월</span></td>
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
	<div id="chartDiv"></div>

</body>
<script>


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
          title: '날짜'
        },
        vAxis: {
          title: '명'
        }
      };

      var chart = new google.visualization.LineChart(document.getElementById('chartDiv'));

      chart.draw(data, options);
    }
</script>
</html>