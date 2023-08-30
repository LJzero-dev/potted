<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
.btn1 { border: 0; width:100px; font-size: 20px; background: #0B9649; color:white; padding-bottom: 8px; cursor: pointer; border-radius: 20px; }
.btn2 { border: 0; width:100px; font-size: 20px; background: #fff; padding-bottom: 8px; cursor: pointer; }
.btn2:hover { border: 0; width:100px; font-size: 20px; background: #0B9649; padding-bottom: 8px; cursor: pointer; border-radius: 20px; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/utils.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
var color = Chart.helpers.color;
var barChartData = {
	labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	datasets: [{
		label: '매출액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [30, 40, 35, 25, 55, 44, 18, 30, 40, 35, 25, 55]
	}, {
		label: '순이익',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [15, 20, 17, 13, 28, 22, 9, 15, 20, 17, 13, 28]
	}
/* -- 데이터 막대 추가
	, {
		label: '순이익2',
		backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [15, 20, 17, 13, 28, 22, 9]
	}
*/
	]
};

window.onload = function() {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend:{ position:'top' }, 
			title:{ display:true, text:'월별 매출 및 순이익(세로 막대 차트)' }
		}
	});
};
</script>
</head>
<body>
<div id="app">
<input type="button" class="btn1" value="매출" onclick="location.href='salesSlip';" />
<input type="button" class="btn2" value="회원통계" onclick="location.href='memberChart';"/>
<hr width="1000" align="left" />
<!-- 매출 통계 시작 -->
	<div class="salesSlip" id="menu1">
		<div style="margin-right:90px; float:right;">
		<select name="kind">
			<option value="a">월별</option>
			<option value="b">계절별</option>
			<option value="c">상품 대분류 별</option>
			<option value="d">옥션 매출</option>
		</select>
		</div>
		<div id="container" style="width: 90%;">
			<canvas id="canvas"></canvas>
		</div>
	</div>
<!-- 매출 통계 끝 -->

<!-- 회원 통계 시작 -->

<!-- 회원 통계 끝 -->
</div>

</body>
</html>