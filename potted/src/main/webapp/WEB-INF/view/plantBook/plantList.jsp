<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp"%>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<style>
.btn {
	background: white;
	font-size: 15px;
	border-radius: 20px;
	cursor: pointer;
	font-color: #6E6E6E;
	border: 1px solid #6E6E6E;
	margin-right: 10px;
	width: 50px;
	height: 30px;
}

.btn:hover {
	background: #0B9649;
	border-color: #0B9649;
	font-color: white;
}

.ctgrb {
	margin-right: 10px;
	padding: 6px 20px;
	font-size: 20px;
	color: #6E6E6E;
	cursor: pointer;
	text-align: center;
	height: 30px;
	border: 1.5px solid #6E6E6E;
	float: left;
	margin-bottom: 10px;
	background: white;
	border-radius: 20px;
}

.ctgrb:hover {
	font-color: #0B9649;
	border-color: #0B9649;
	color: #0B9649;
}

.selected {
	font-color: #0B9649;
	color: #0B9649;
	border: 2px solid #0B9649;
}
</style>
<div style="width: 1000px; margin: 0 auto;" id="plantList">
	<h2 style="font-size: 20pt;">
		<a href="" style="text-decoration: none; color: black;">PLANT BOOK</a>
	</h2>
	<p>국명, 학명으로 찾고자 하는 식물을 검색하실 수 있습니다.</p>
	<form name="frm">
		<input type="hidden" name="ctgr1" id="ctgr1" value="${ctgr1}">
		<input type="hidden" name="ctgr2" id="ctgr2" value="${ctgr2}">
		<div style="overflow: hidden;">
			<div :class="[ctgr,{'selected':isOn1}]" v-on:click="selectCtgr(1);">국명</div>
			<div :class="[ctgr,{'selected':isOn2}]" v-on:click="selectCtgr(2);">학명</div>
		</div>
		<hr :style="hrs" />
		<div id="ctgr1">
			<div :class="[ctgr,{'selected':isOn3}]" v-on:click="selectCtgr2(1);">유사</div>
			<div :class="[ctgr,{'selected':isOn4}]" v-on:click="selectCtgr2(2);">일치</div>
		</div>
		<hr :style="hrs" />
		<table width="800">
			<tr>
				<td width="150" valign="top">
					<div style="width: 970px;">
						<img src="/potted/resources/images/product/search.png" width="25" />&nbsp;
						<input placeholder="식물을 검색해 주세요." name="serch" value="${serch}"
							style="width: 800px; border: 0; font-size: 13pt;" /> <input
							class="btn" type="submit" value="검색" />
						<hr />
					</div>
					</form>
				</td>
			</tr>			
			<table width="100%" cellpadding="15" cellspacing="0">
				<tr v-if="arrObjLength > 1" v-for="plant in arrObj">
					<td width="10%" align="left"><a target="_blank"
						rel="noopener noreferrer" :href="url + plant.plantPilbkNo">
							<div style="display: inline-block; vertical-align: top;" v-if="plant.imgUrl != 'NONE'">
								<img :src="plant.imgUrl" style="width: 180px; height: 180px; border: 0px; margin-right: 20px;" />
							</div>
							<div style="display: inline-block; vertical-align: top;" v-else="">
								<img src="/potted/resources/images/product/no_img.jpg" style="width: 180px; height: 180px; border: 0px; margin-right: 20px;" />
							</div>
							<div style="display: inline-block;">
								<strong style="font-size: 20px;">{{plant.plantGnrlNm}}</strong>&nbsp;&nbsp;도감번호
								: {{plant.plantPilbkNo}} <br />
								<br /> [비추천명] : {{plant.notRcmmGnrlNm}}<br />
								<br /> {{plant.familyKorNm + " " + plant.genusKorNm}}<br />
								<br /> {{plant.familyNm + " " + plant.genusNm}}<br />
								<br /> 학명 : {{plant.plantSpecsScnm}}
							</div>
							<hr :style="hrs" />
					</a></td>
				</tr>
				<tr v-if="arrObjLength == 1">
					<td width="10%" align="left"><a target="_blank"
						rel="noopener noreferrer" :href="url + arrObj.plantPilbkNo">
							<div style="display: inline-block; vertical-align: top;">
								<img :src="arrObj.imgUrl"
									style="width: 180px; height: 180px; border: 0px; margin-right: 20px;" />
							</div>
							<div style="display: inline-block;">
								<strong style="font-size: 20px;">{{arrObj.plantGnrlNm}}</strong>&nbsp;&nbsp;도감번호
								: {{arrObj.plantPilbkNo}} <br />
								<br /> [비추천명] : {{arrObj.notRcmmGnrlNm}}<br />
								<br /> {{arrObj.familyKorNm + " " + arrObj.genusKorNm}}<br />
								<br /> {{arrObj.familyNm + " " + arrObj.genusNm}}<br />
								<br /> 학명 : {{arrObj.plantSpecsScnm}}
							</div>
							<hr :style="hrs" />
					</a></td>
				</tr>
			</table>
		</table>
<br />
<table width="*" cellpadding="5" align="center">
<tr>
<td width="*">
<c:if test="${1 > 0}">
	
	<c:if test="${si.getCpage() == 1}">
		<<&nbsp;&nbsp;&nbsp;<&nbsp;&nbsp;
	</c:if>
	<c:if test="${si.getCpage() > 1}">
		<a href="plantBook?cpage=1${si.getSchargs()}"><<</a>&nbsp;&nbsp;&nbsp;
		<a href="plantBook?cpage=${si.getCpage() - 1}${si.getSchargs()}"><</a>&nbsp;&nbsp;
	</c:if>
	
	<c:forEach var="i" begin="${si.getSpage()}" end="${si.getSpage() + si.getBsize() - 1 < si.getPcnt() ? si.getSpage() + si.getBsize() - 1 : si.getPcnt()}">
		<c:if test="${i == si.getCpage()}">
			&nbsp;<strong>${i}</strong>&nbsp;
		</c:if>
		<c:if test="${i != si.getCpage()}">
			&nbsp;<a href="plantBook?cpage=${i}${si.getSchargs()}">${i}</a>&nbsp;
		</c:if>
	
	</c:forEach>
	
	<c:if test="${si.getCpage() == si.getPcnt()}">
		&nbsp;&nbsp;>&nbsp;&nbsp;&nbsp;>>
	</c:if>
	<c:if test="${si.getCpage() < si.getPcnt()}">
		&nbsp;&nbsp;<a href="plantBook?cpage=${si.getCpage() + 1}${si.getSchargs()}">></a>
		&nbsp;&nbsp;&nbsp;<a href="plantBook?cpage=${si.getPcnt()}${si.getSchargs()}">>></a>
	</c:if>
</c:if>	
</td>
</tr>
</table>
</div>
<script>
new Vue({
	el : "#plantList",
	data : {
		url : "plantInfo?plantPilbkNo=",
		cpage : ${plantListJson},
		arrObjLength : ${plantListJson}.response.body.totalCount - ${si.getPsize()*(si.getCpage()-1)},
		arrObj : ${plantListJson}.response.body.items.item,
		hrs : "border-width:1px 0 0 0; border-style:dotted; border-color:#bbb; width:930px;",
		selected : "selected",
		ctgr : "ctgrb",
		isOn1 : ${ctgr1} == 1 ? true : false,
		isOn2 : ${ctgr1} == 2 ? true : false,
		isOn3 : ${ctgr2} == 1 ? true : false,
		isOn4 : ${ctgr2} == 2 ? true : false
	},
	methods : {
		selectCtgr(num){
			$("#ctgr1").val(num);
			if(num == 1){
				this.isOn1 = true;	this.isOn2 = false;
			} else {
				this.isOn2 = true;	this.isOn1 = false;
			}
		},
		selectCtgr2(num){
			$("#ctgr2").val(num);
			if(num == 1){
				this.isOn3 = true;	this.isOn4 = false;
			} else {
				this.isOn4 = true;	this.isOn3 = false;
			}
		}
	}
});
</script>
<%@ include file="../inc/inc_foot.jsp"%>