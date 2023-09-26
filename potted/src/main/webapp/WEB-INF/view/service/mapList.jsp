<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%@ page import="java.net.*" %>
<%@ page import="java.time.*" %>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
ArrayList<GardenInfo> gardenList = (ArrayList<GardenInfo>)request.getAttribute("gardenList");
%>
<style>
#map { width:500px; height:400px; border:1px solid black; }
#infoWin { width:150px; text-align:center; padding:5px 0; }
#maptable { width:1000px; height:400px; margin-left:400px; }
#txtT { font-weight:bold; font-size:23px; }
#txtC {}
.listBox { cellpadding:100px; cellspacing:100px; margin-top:20px; }
.selected { width:60px; hegiht:60px; cursor:pointer; }
.blank { width:60px; height:40px; }
#contentBox { width:1000px; height:100px; margin-left:400px; font-size:15px; }
#txt td { border-bottom: 1px solid #1cad0a; }
#cont { margin-top:20px; margin-bottom:20px; font-size:15px; }
</style>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=56ed062996a7b7c5beb644b3106e2af6&libraries=services"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<h2 style="display:inline; margin-left:20px;">SERVICE</h2>
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
&nbsp;&nbsp;&nbsp;&nbsp;<h3 style="display:inline;"><a href="noticeList">공지사항</a></h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<h3 style="display:inline;"><a href="mapList">맵</a></h3>
<br />
<div id="app">
<hr color="#1cad0a" style="border-width:1px; height:1px; border:0;" />
<table id="maptable"><tr><td valign="top"><div id="map"></div></td><td width="10%"></td><td valign="top">
	<div v-for="item in mapArr" :key="item.giidx">
	<garden-list :object="item" v-on:addr2-geo="addr2Geo"></garden-list>
	</div>
</td></tr></table>
<div id="contentBox"><table id="txt" cellspacing="0"><tr><td width="5%"><img style="width:30px; height:30px;" src="/potted/resources/images/service/selected.png" /></td>
<td align="left"><span style="font-size:20px;">{{gardenname}}</span></td></tr><tr><td colspan="2"><div id="cont">{{content}}</div></td></tr></table></div>
</div>
<script>
var gardenList = {
	props: ["object"], 
	template: `<table class="listBox"><tr><td><img :id="object.giidx" class="selected" src="/potted/resources/images/service/unselected.png" 
	v-on:click="addr2Geo(object.giidx, object.giname, object.gilocation);" /></td><td align="left">
	<span id="txtT">{{object.giname}}</span></td></tr><tr><td class="blank"></td><td><span id="txtC">위치 : {{object.gilocation}}<br />
	<a :href="object.gilink" target="_blank">웹 사이트 : {{object.gilink}}</a></span><br /><br /></td></tr></table>`, 
	methods: {
		addr2Geo(idx, name, addr) { 
			this.$emit("addr2-geo", idx, name, addr);
		}
	}
}

new Vue({
	el: "#app", 
	data: {
		mapArr: [
<%
String obj = "";
for (int i = 0 ; i < gardenList.size() ; i++) {
	GardenInfo gi = gardenList.get(i);
	obj = (i == 0 ? "" : ", ") + "{giidx:\"" + gi.getGi_idx() + "\", giname:\"" + gi.getGi_name() + "\", gilocation:\"" + gi.getGi_location() + 
		"\", gilink:\"" + gi.getGi_link() + "\", gicontent:\"" + gi.getGi_content() + "\"}";
			out.println(obj);
}
%>
		],
		num: 0
	},
	computed: {
		content() {
			return this.mapArr[this.num].gicontent
		},
		gardenname() {
			return this.mapArr[this.num].giname
		}
	}, 
	components: {
		"garden-list": gardenList
	}, 
	methods: {
		addr2Geo(idx, name, addr) {
//			alert(idx + ":::" + name + ":::" + addr);
			var geocoder = new kakao.maps.services.Geocoder();
			// 주소를 좌표로 변경해주는 객체 생성

			geocoder.addressSearch(addr, function(result, status) {
				if (status == kakao.maps.services.Status.OK) {
					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					var marker = new kakao.maps.Marker({
						map: mapObj, position: coords
					});
					
					var infowindow = new kakao.maps.InfoWindow({
						content: "<div id='infoWin'>" + name + "</div>"
					});
					infowindow.open(mapObj, marker);
					
					mapObj.setCenter(coords);
				}
			});
			
			var tmp = "";
			for (var i = 0; i < this.mapArr.length ; i++) {
				tmp = this.mapArr[i].giidx;
				document.getElementById(tmp).src = "/potted/resources/images/service/unselected.png";
			}
			
			document.getElementById(idx).src = "/potted/resources/images/service/selected.png";
			this.num = idx - 1;
		}
	}
});



// 맵 구간
var mapObj;
window.onload = function showMap() {
	var mapBox = document.getElementById("map");
	var mapOpt = {
		center: new kakao.maps.LatLng(33.450701, 126.570667), 
		level: 3	
	};
	mapObj = new kakao.maps.Map(mapBox, mapOpt);	
	
	var zoomCtrl = new kakao.maps.ZoomControl();
	mapObj.addControl(zoomCtrl, kakao.maps.ControlPosition.RIGHT);
	
	var mapCtrl = new kakao.maps.MapTypeControl();
	mapObj.addControl(mapCtrl, kakao.maps.ControlPosition.TOPRIGHT);
	
	var geocoder = new kakao.maps.services.Geocoder();
	var addr = "경기도 포천시 소흘읍 광릉수목원로 509";
	
	geocoder.addressSearch(addr, function(result, status) {
		if (status == kakao.maps.services.Status.OK) {
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			var marker = new kakao.maps.Marker({
				map: mapObj, position: coords
			});
			
			var infowindow = new kakao.maps.InfoWindow({
				content: "<div id='infoWin'>국립수목원</div>"
			});
			infowindow.open(mapObj, marker);
			
			mapObj.setCenter(coords);
		}
	});

	document.getElementById(1).src = "/potted/resources/images/service/selected.png";
	
}

</script>
<%@ include file="../inc/inc_foot.jsp" %>