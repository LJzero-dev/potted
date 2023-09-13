<%@page import="java.text.DecimalFormat"%>
<%@page import="com.mysql.cj.PingTarget"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp"%>
<br />
<br />
<div id="plantdetail" style="width: 850px; margin: 0 auto;">
	<table width="800">
		<tr valign="top">
			<td width="35%"><img :src="plantInfo.imgUrl" width="260"
				height="230" id="bigImg" /></td>
			<td>
				<ul>
					<li style="list-style: square;">국명 : {{plantInfo.plantGnrlNm}}</li>
					<hr />
					<li style="list-style: square;">영문명 : {{plantInfo.engNm}}</li>
					<hr />
					<li style="list-style: square;">과명 : {{plantInfo.familyNm}}</li>
					<hr />
					<li style="list-style: square;">과국명 :
						{{plantInfo.familyKorNm}}</li>
					<hr />
					<li style="list-style: square;">속명 : {{plantInfo.genusNm}}</li>
					<hr />
					<li style="list-style: square;">속국명 : {{plantInfo.genusKorNm}}</li>
					<hr />
					<li style="list-style: square;">학명 :
						{{plantInfo.plantSpecsScnm}}</li>
					<hr />
				</ul>
			</td>
		</tr>
	</table>
	<br />
	<br />
	<!-- 상품 상세 정보 및 구매 후기 영역 -->
	<div align="center">
		<p>식물 상세 정보</p>
	</div>
	<hr style="margin-left: 0px; width: 800px;" />
	<br /> ▶&nbsp;분포 정보
	<hr style="margin-left: 0px; width: 800px;" />
	{{plantInfo.dstrb}}<br />
	<br /> ▶&nbsp;설명
	<hr style="margin-left: 0px; width: 800px;" />
	{{plantInfo.flwrDesc}}<br />
	<br /> {{plantInfo.stemDesc}}<br />
	<br /> {{plantInfo.leafDesc}}<br />
	<br /> ▶&nbsp;기타
	<hr style="margin-left: 0px; width: 800px;" />
	<p v-html="smlrPlntDesc"></p>
	<br />
</div>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>
new Vue({
	el : "#plantdetail",
	data : {
		plantInfo : ${plantInfo}.response.body.item
	},
	computed : {
		smlrPlntDesc() {
	    	return this.plantInfo.smlrPlntDesc.replaceAll("\r", "<br />");
		}
	}
});
</script>

<%@ include file="../inc/inc_foot.jsp"%>