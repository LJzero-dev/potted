<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<style>
.btn { background:white; font-size: 15px; border-radius: 20px; cursor: pointer; font-color: #6E6E6E; border:1px solid #6E6E6E; margin-right:10px; width:50px; height:30px; }
.btn:hover { background:#0B9649; border-color: #0B9649; font-color: white; }
</style>
<div style="width:1000px; margin:0 auto; " id="plantList">
<h2 style="font-size:20pt;"><a href="" style="text-decoration:none; color:black;">PLANT BOOK</a></h2>
<p>국명, 학명으로 찾고자 하는 식물을 검색하실 수 있습니다.</p>
<form name="">
<div style="overflow:hidden;">
	<div>국명</div>
	<div>학명</div>
	<div>영문명</div>
</div>
<hr :style="hrs" />
<div id="ctgr1" >
	<div>유사</div>
	<div>일치</div>
</div>
<hr :style="hrs" />
</form>
<table width="800">
<tr>
<td width="150" valign="top">
	<form name="">
	<div style="width:970px;">
		<img src="/potted/resources/images/product/search.png" width="25"/>&nbsp;
		<input placeholder="식물 이름을 검색해 주세요." value="" style="width:800px; border:0; font-size:13pt;" />
		<input class="btn" type="button" value="검색" onclick="" />
	<hr />
	</div>
	</form>
</tr>
<table width="100%" cellpadding="15" cellspacing="0" >
	<tr v-for="plant in arrObj">
	<td width="10%" align="left">
		<a href="">
			<div style="display:inline-block;vertical-align:top;">
    <img :src="plant.imgUrl" style="width:180px; height:180px; border:0px; margin-right:20px;" />
</div>
<div style="display:inline-block;">
	<strong style="font-size:20px;">{{plant.plantGnrlNm}}</strong>&nbsp;&nbsp;도감번호 : {{plant.plantPilbkNo}}
	<br /><br />
	[비추천명] : {{plant.notRcmmGnrlNm}}<br /><br />
	{{plant.familyKorNm + "  " + plant.genusKorNm}}<br /><br />
	{{plant.familyNm + "  " + plant.genusNm}}<br /><br />
	학명 : {{plant.plantSpecsScnm}}
</div>
	<hr :style="hrs" />
		</a>
	</td>
	</tr>
	</table>
</table>
</div>
<script>
new Vue({
	el : "#plantList",
	data : {
		arrObj : ${plantListJson}.response.body.items.item,
		selectedCtgr : "font-color: #0B9649; color: #0B9649; border:2px solid #0B9649;",
		hrs : "border-width:1px 0 0 0; border-style:dotted; border-color:#bbb; width:930px;"
	}
});
</script>
<%@ include file="../inc/inc_foot.jsp" %>