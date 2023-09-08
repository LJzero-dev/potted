<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="inc/inc_head.jsp" %>
<%@ page import="java.util.*"  %>
<%

Calendar cal = Calendar.getInstance();
int y = cal.get(Calendar.YEAR);
int m = cal.get(Calendar.MONTH)+1;
int d = cal.get(Calendar.DATE);
int h = cal.get(Calendar.HOUR_OF_DAY);
int tm = cal.get(Calendar.MINUTE);

String month = "";
String day = "";
String hour = "";
String minute = "";
if (m < 10)		month = "0" + m;
else			month = m + "";

if (d < 10)		day = "0" + d;
else			day = d + "";

if (h < 10)		hour = "0" + h;
else			hour = h + "";

if (tm < 10)		minute = "0" + tm;
else			minute = tm + "";
String today = y + "" + month + "" + day;

BannerList bl = (BannerList)request.getAttribute("bl");
%>
<style>
#timg { width:190px; height:170px; border:0; border-radius:20%; }
.title { font-size:30px; font-weight:bold; height:50px; }
.showall { font-color:#0B9649; font-size:15px; font-weight:light; }
.dc { color:#0B9649; font-weight:bold; }
.realprice { color:grey; }
.name { font-size:20px; }
.price { font-weight:bold; }
.free { width:750px; }
.free td { font-size:15px; border-bottom:1px solid black; }
#txt { text-align: center; }
.imgbox { background-color: #F4F5F3; width:220px; height:300px; border-radius:10%;  box-shadow: 0px 0px 10px #000; }
</style>
<style>
body { margin:0; }
.slideshow { background:#000; height:600px; min-width:960px; overflow:hidden; position:relative; }
.slideshow-slides { width:100%; height:100%; position:absolute; }
.slideshow-slides .slide { width:100%; height:100%; position:absolute; overflow:hidden; }
.slideshow-slides .slide img { left:50%; margin-left:-800px; position:absolute; }
.slideshow-nav a, .slideshow-indicator a { background:rgba(0, 0, 0, 0); overflow:hidden; }
.slideshow-nav a:before, .slideshow-indicator a:before { content:url("images/sprites.png"); display:inline-block; font-size:0; line-height:0; }

.slideshow-nav a { position:absolute; top:50%; left:50%; width:72px; height:72px; margin-top:-36px; }
.slideshow-nav a.prev { margin-left:-480px; }
.slideshow-nav a.prev:before { margin-top:-20px; }
.slideshow-nav a.next { margin-left:408px; }
.slideshow-nav a.next:before { margin:-20px 0 0 -80px; }
.slideshow-nav a.disabled { display:none; }

.slideshow-indicator { height:16px; left:0; bottom:30px; right:0; text-align:center; position:absolute; }
.slideshow-indicator a { display:inline-block; width:16px; height:16px; margin:0 3px; }
.slideshow-indicator a.active { cursor:default; }
.slideshow-indicator a:before { margin-left:-110px; }
.slideshow-indicator a.active:before { margin-left:-130px; }

.weather {background-image: url("/potted/resources/images/weather/clouds.png"); background-repeat : no-repeat;}
.wsize {width:1400px; height:600px; margin-left:350px; }
.weatherInfo { text-align:right; padding-top:25px; margin-right:110px; font-size:50px; color:white; }
.wday { text-align:right; padding-top:30px; margin-right:80px; font-size:30px; color:white; }
.wtime { text-align:right; padding-top:30px; margin-right:120px; font-size:30px; color:white; }
.wimg { margin-right:140px; width:80px; height:80px; }
</style>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui-1.10.3.custom.min.js"></script>
<script>
$.getJSON('https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=8v9f7y0t91f1wlfyspJ%2BQEpRi%2BnQ1LWm%2FEoMFm8iqGkdSM8clOR3q7h5y6WtC9%2Bxxaa5wWZIQhdP77%2B3v%2FdOEA%3D%3D&pageNo=1&numOfRows=1000&dataType=JSON&base_date=<%=today%>&base_time=<%=hour%>00&nx=61&ny=125', function(data) {
	console.log(data);
	let wt = data.response.body.items.item[3].obsrValue; // 온도
	let pty = data.response.body.items.item[0].obsrValue; // 강수형태 : 0 = 없음, (1,2,4,5) = 비, (3,6,7) = 눈
	 $('.weatherInfo').text(wt + "℃");
	console.log(pty);
	console.log(wt);
	
});
</script>
<script>
$(document).ready(function() {
	$(".slideshow").each(function() {
		var $container = $(this), 
			$slideGroup = $container.find(".slideshow-slides"), 
			$slides = $slideGroup.find(".slide"), 
			$nav = $container.find(".slideshow-nav"), 
			$indicator = $container.find(".slideshow-indicator"), 
			slideCount = $slides.length, 
			indicatorHTML = "", 
			currentIndex = 0, 
			duration = 500, 
			easing = "easeInOutExpo", 
			interval = 3000, 
			timer;

		$slides.each(function(i) {
			$(this).css({ left:100 * i + "%" });
			indicatorHTML += "<a href='#'>" + (i + 1) + "</a>";
		});
		$indicator.html(indicatorHTML);

		function goToSlide(idx) {
			$slideGroup.animate({ left:-100 * idx + "%" }, duration, easing);
			currentIndex = idx;
			updateNav();
		}

 		function updateNav() {
			var $navPrev = $nav.find(".prev");
			var $navNext = $nav.find(".next");

			if (currentIndex == 0)	$navPrev.addClass("disabled");
			else					$navPrev.removeClass("disabled");

			if (currentIndex == slideCount - 1)	$navNext.addClass("disabled");
			else								$navNext.removeClass("disabled");

			$indicator.find("a").removeClass("active").eq(currentIndex).addClass("active");
		} 

		function startTimer() {
			timer = setInterval(function() {
				var nextIndex = (currentIndex + 1) % slideCount;
				goToSlide(nextIndex);
			}, interval);
		}

		function stopTimer() {
			clearInterval(timer);
		}

		$nav.on("click", "a", function(evt) {
			evt.preventDefault();

			if ($(this).hasClass("prev"))	goToSlide(currentIndex - 1);	
			else							goToSlide(currentIndex + 1);	
		});

		$indicator.on("click", "a", function(evt) {
			evt.preventDefault();
			if (!$(this).hasClass("active"))
				goToSlide($(this).index());
		});

		$container.on({ mouseenter:stopTimer, mouseleave:startTimer });
		goToSlide(currentIndex);
		startTimer();
	});
});
</script>

<div class="slideshow">
	<div class="slideshow-slides">
		<a href="#" class="slide" id="slide-1"><img src="http://localhost:8086/ad_potted/resources/images/product/banner/<%=bl.getBl_img1() %>" width="1600" height="600" /></a>
		<a href="#" class="slide" id="slide-2"><img src="http://localhost:8086/ad_potted/resources/images/product/banner/<%=bl.getBl_img2() %>" width="1600" height="600" /></a>
		<a href="#" class="slide" id="slide-3"><img src="http://localhost:8086/ad_potted/resources/images/product/banner/<%=bl.getBl_img3() %>" width="1600" height="600" /></a>
		<a href="#" class="slide" id="slide-4"><img src="http://localhost:8086/ad_potted/resources/images/product/banner/<%=bl.getBl_img4() %>" width="1600" height="600" /></a>
	</div>
	<!-- <div class="slideshow-nav">
		<a href="#" class="prev">Prev</a>
		<a href="#" class="next">Next</a>
	</div> -->
	<div class="slideshow-indicator"></div>
</div>
<div style="width:1100px; margin:0 auto; align:center; ">
<br />
<table>
<tr height="40px;"></tr>
<tr><td class="title" colspan="4">NEW&nbsp;&nbsp;<a href="productList?cpage=1&ob=a" class="showall">모두 보기 >></a></td></tr>
<tr>
<c:forEach items="${productLista}" var="pi" >
	<c:set var="price">${pi.getPi_price() * (1 - pi.getPi_dc())}</c:set>
	<c:set var="dc">${pi.getPi_dc() * 100}</c:set>
	<td id="txt"><div class="imgbox"><br />
		<a href="productView?piid=${pi.getPi_id()}"><img id="timg" src="/ad_potted/resources/images/product/${pi.getPi_img1()}" /><br />
		<span class="name">${pi.getPi_name()}</span></a><br />
		<span class="price">${fn:substringBefore(price, '.')}원</span>&nbsp;<span class="dc">${fn:substringBefore(dc, '.')}%</span><br />
		<span class="realprice"><del>${pi.getPi_price() }</del></span>
	</div></td><td width="50px;"></td>
</c:forEach>
</tr>
<tr height="40px;"></tr>
<tr><td class="title" colspan="4">Best&nbsp;&nbsp;<a href="productList?cpage=1&ob=b" class="showall">모두 보기 >></a></td></tr>
<tr>
<c:forEach items="${productListb}" var="pi" >
	<c:set var="price">${pi.getPi_price() * (1 - pi.getPi_dc())}</c:set>
	<c:set var="dc">${pi.getPi_dc() * 100}</c:set>
	<td id="txt"><div class="imgbox"><br />
		<a href="productView?piid=${pi.getPi_id()}"><img id="timg" src="/ad_potted/resources/images/product/${pi.getPi_img1()}" /><br />
		<span class="name">${pi.getPi_name()}</span></a><br />
		<span class="price">${fn:substringBefore(price, '.')}원</span>&nbsp;<span class="dc">${fn:substringBefore(dc, '.')}%</span><br />
		<span class="realprice"><del>${pi.getPi_price() }</del></span>
	</div></td><td width="50px;"></td>
</c:forEach>
</tr>
</table>
<br /><br />
<!-- 날씨정보 시작 -->
<h1>오늘의 날씨</h1><br />
</div>
<div class="weather wsize">
	<p class="wday"><%=y %>년 <%=m %>월 <%=d %>일</p><br />
	<p class="wtime"><%=hour %>시 <%=minute %>분</p><br />
	<p class="weatherInfo"></p><br />
	<img src="/potted/resources/images/weather/sun.png" class="wimg" align="right" />
</div>
<br />
<!-- 날씨정보 종료 -->
<div style="width:1100px; margin:0 auto; align:center; ">
<table class="free" cellpadding="0" cellspacing="0">
<tr height="40px;"></tr>
<tr><td colspan="4"><span class="title">인기 글</span>&nbsp;<a href="freeList?cpage=1&ob=b" class="showall">모두 보기 >></a></td></tr>
<c:forEach items="${freeList}" var="fl" >
	<tr height="35px;"><td width="*"><a href="freeView?cpage=1&flidx=${fl.getFl_idx()}">${fl.getFl_title()}</a></td><td width="20%" align="center">${fl.getFl_writer()}</td><td width="10%" align="right">${fl.getFl_date()}</td><td width="20%" align="left"> | 조회 : ${fl.getFl_read() }</td></tr>
</c:forEach>
</table>
</div>
<%@ include file="inc/inc_foot.jsp" %>