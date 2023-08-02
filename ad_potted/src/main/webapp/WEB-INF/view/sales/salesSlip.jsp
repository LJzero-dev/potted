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
</style>
<script src="${pageContext.request.contextPath}/resources/js/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/utils.js"></script>
<script>
var color = Chart.helpers.color;
var barChartData = {
	labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월'],
	datasets: [{
		label: '매출액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [30, 40, 35, 25, 55, 44, 18]
	}, {
		label: '순이익',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [15, 20, 17, 13, 28, 22, 9]
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
<h2> 매출 표 </h2>
<div id="container" style="width: 90%;">
	<canvas id="canvas"></canvas>
</div>

</body>
</html>