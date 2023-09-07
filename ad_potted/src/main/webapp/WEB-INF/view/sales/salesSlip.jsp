<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.time.*" %>
<%
LocalDate today = LocalDate.now();
int cyear = today.getYear();
ArrayList<SalesSlip> salesSlipList = (ArrayList<SalesSlip>)request.getAttribute("salesSlipList");

PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.btn1 { border: 0; width:100px; font-size: 20px; background: #0B9649; color:white; padding-bottom: 8px; cursor: pointer; border-radius: 20px; }
.btn2 { border: 0; width:100px; font-size: 20px; background: #fff; padding-bottom: 8px; cursor: pointer; }
.btn2:hover { border: 0; width:100px; font-size: 20px; background: #0B9649; padding-bottom: 8px; cursor: pointer; border-radius: 20px; }
select { border:1.5px solid #ced4da; padding:6px 12px; border-radius:5px; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/utils.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
<div id="app">
<input type="button" class="btn1" value="매출" onclick="location.href='salesSlip?kind=a&year=<%=cyear %>';" />
<input type="button" class="btn2" value="회원통계" onclick="location.href='memberChart';"/>
<hr width="1000" align="left" />
<!-- 월별 매출 시작 -->
	<div class="salesSlip" id="menu1">
		<div style="margin-right:90px; float:right;">
		<form>
		<select name="kind" onchange="location.href='salesSlip?kind=' + this.value + '&year=' + this.form.year.value;">
			<option value="a" <%if (pageInfo.getOb().equals("a")) {%>selected="selected"<% } %>>월별</option>
			<option value="b" <%if (pageInfo.getOb().equals("b")) {%>selected="selected"<% } %>>계절별</option>
			<option value="c" <%if (pageInfo.getOb().equals("c")) {%>selected="selected"<% } %>>상품 대분류 별</option>
			<option value="d" <%if (pageInfo.getOb().equals("d")) {%>selected="selected"<% } %>>옥션 매출(월별)</option>
		</select><br /><br />
		<select name="year" onchange="location.href='salesSlip?kind=' + this.form.kind.value + '&year=' + this.value;">
<% for (int i = 2020 ; i <= cyear ; i++) { %>
		<option <%if (pageInfo.getSch().equals(i + "")) {%>selected="selected"<% } %>><%=i %></option>
<% } %>
		</select>&nbsp;년
		</form>
		</div><br /><br /><br /><br />
		<div id="chartDiv" style="width:90%;"></div>
	</div>
<!-- 월별 매출 끝 -->
</div>
<script>
google.charts.load('current', {packages: ['corechart', 'bar']});
google.charts.setOnLoadCallback(drawMultSeries);

function drawMultSeries() {
	var data = google.visualization.arrayToDataTable([ 
<%
String obj = "", pcb = "";
int spring = 0, summer = 0, autumn = 0, winter = 0;
int springR = 0, summerR = 0, autumnR = 0, winterR = 0;
if (pageInfo.getOb().equals("a")) {
	for (int i = 0 ; i < salesSlipList.size() ; i++) {
		SalesSlip sl = salesSlipList.get(i);
		obj = (i == 0 ? "['월', '매출', '순이익']," : ", ") + "['" + sl.getSs_month() + "월', " + sl.getSs_sale() + ", " + sl.getSs_real() + "]";
		out.print(obj);
	}
} else if (pageInfo.getOb().equals("b")) {
	for (int i = 0 ; i < salesSlipList.size() ; i++) {
		SalesSlip sl = salesSlipList.get(i);
		if (sl.getSs_month() == 3 || sl.getSs_month() == 4 || sl.getSs_month() == 5) {
			spring += sl.getSs_sale();
			springR += sl.getSs_real();
		} else if (sl.getSs_month() == 6 || sl.getSs_month() == 7 || sl.getSs_month() == 8) {
			summer += sl.getSs_sale();
			summerR += sl.getSs_real();
		} else if (sl.getSs_month() == 9 || sl.getSs_month() == 10 || sl.getSs_month() == 11) {
			autumn += sl.getSs_sale();
			autumnR += sl.getSs_real();
		} else {
			winter += sl.getSs_sale();
			winterR += sl.getSs_real();
		}
	}
	obj = "['계절', '매출', '순이익'], ['봄', " + spring + ", " + springR + "], ['여름', " + summer + ", " + summerR + "], ['가을', " + autumn + ", " + autumnR + "], ['겨울', " + winter + ", " + winterR + "]";
	out.print(obj);
} else if (pageInfo.getOb().equals("c")) {
	for (int i = 0 ; i < salesSlipList.size() ; i++) {
		SalesSlip sl = salesSlipList.get(i);
		if (sl.getSs_pcb().equals("AA"))		pcb = "다육▪선인장";
		else if (sl.getSs_pcb().equals("BB"))	pcb = "관엽식물";
		else									pcb = "채소▪허브";
		obj = (i == 0 ? "['대분류', '매출', '순이익']," : ", ") + "['" + pcb + "', " + sl.getSs_sale() + ", " + sl.getSs_real() + "]";
		out.print(obj);
	}
} else {
	for (int i = 0 ; i < salesSlipList.size() ; i++) {
		SalesSlip sl = salesSlipList.get(i);
		obj = (i == 0 ? "['월', '매출', '순이익']," : ", ") + "['" + sl.getSs_month() + "월', " + sl.getSs_sale() + ", " + sl.getSs_real() + "]";
		out.print(obj);
	}
}
%>
	]);
	var options = {
	  title: '매출과 순이익',
	  chartArea: {width: '70%'},
	  hAxis: {
	    title: '매출과 순이익',
	    minValue: 0
	  },
	  vAxis: {
	    title: '단위 : 원(₩)'
	  }
	};
	
	var chart = new google.visualization.ColumnChart(document.getElementById('chartDiv'));
	chart.draw(data, options);
}
</script>
</body>
</html>