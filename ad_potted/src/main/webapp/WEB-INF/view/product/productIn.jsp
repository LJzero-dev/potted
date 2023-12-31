<%@page import="vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<ProductCtgrBig> bigList = (ArrayList<ProductCtgrBig>)request.getAttribute("bigList");
ArrayList<ProductCtgrSmall> smallList = (ArrayList<ProductCtgrSmall>)request.getAttribute("smallList");
%>
<script>
<% 
for (ProductCtgrBig pcb_id : bigList) { 
	String arr = "arr" + pcb_id.getPcb_id();
%>
var <%=arr %> = new Array();
<%=arr %>[0] = new Option("", "선택");
<%
	for (int i = 0, j = 1 ; i < smallList.size() ; i++, j++) {
		ProductCtgrSmall pcs_id = smallList.get(i);
		if (pcs_id.getPcb_id().equals(pcb_id.getPcb_id())) {
%>
<%=arr %>[<%=j %>] = new Option("<%=pcs_id.getPcs_id() %>", "<%=pcs_id.getPcs_name() %>");
<% 
		} else {
			j = 0;
		}
	}
%>
<% 
} 
%>

function setCategory(x, target) {
	for (var i = target.options.length - 1; i > 0; i-- ) {
		target.options[i] = null;
	}

	if (x != "") { 
		var arr = eval("arr" + x);
		
		for (var i = 0; i < arr.length; i++ ) {
			target.options[i] = new Option(arr[i].value, arr[i].text);
			
		}

		target.options[0].selected = true;
	}
}

function showDiv(num) {
	var obj = document.getElementById("sub" + num);
	if (obj.style.display == "block")	obj.style.display = "none";
	else								obj.style.display = "block";
}

function posArr() {
    var checkedBoxesPos = document.querySelectorAll('input[name="pos_id"]:checked');
    var checkedBoxesPob = document.querySelectorAll('input[name="pob_id"]:checked');
    var pos_ids = [];
    var pob_ids = [];
    
    for (var i = 0; i < checkedBoxesPob.length; i++) {
        pob_ids.push(checkedBoxesPob[i].value);
    }
    
 	// "pob_ids" 필드에 체크된 값들을 하나의 문자열로 넣기
    var pob_ids_value = pob_ids.length > 0 ? pob_ids.join('/') : "없음";
    document.getElementById('pob_ids').value = pob_ids_value;
    
 	// "pob_id" 필드에도 값을 설정
    document.getElementById('pob_id').value = pob_ids_value;
    
    for (var i = 0; i < checkedBoxesPos.length; i++) {
        pos_ids.push(checkedBoxesPos[i].value);
    }
    
    // "pos_ids" 필드에 체크된 값들을 하나의 문자열로 넣기
    var pos_ids_value = pos_ids.length > 0 ? pos_ids.join('/') : "없음";
    document.getElementById('pos_ids').value = pos_ids_value;
    
    // "pos_id" 필드에도 값을 설정
    document.getElementById('pos_id').value = pos_ids_value;
    
}

</script>
<style>
.title {color:#1cad0a;}
h2 {font-size:24px;}
tr {height:45px;}
th, td {font-size:17px;}
th {width:130px; text-align:left;}
.pimg {padding:10px; margin-right:10px; border:1px solid #000;}
.psub {display:inline-block; width:178px; padding:10px 7px; text-align:left; font-size:12px; border:1px solid #000;}
.btnBox {margin-right:87px; float:right;}
.insertBtn {width:100px; padding:5px 0;margin-bottom:30px; border:0; background:gray; color:#fff;}
.cancelBtn {display:block; width:100px; padding:5px 0; float:right; text-align:center; border:1px solid #000; margin-left:10px; font-size:13px;}
#sub1, #sub2, #sub3 { display:none; }
</style>

<div style="width:1100px; margin:0 auto; overflow:hidden;">
	<h2>상품 등록</h2>
	<form name="frm" action="productProcIn" method="post"  enctype="multipart/form-data" onsubmit="posArr();">
	<input type="hidden" name="pos_id" id="pos_id">
	<input type="hidden" name="pos_ids" id="pos_ids" value="">
	<input type="hidden" name="pob_id" id="pob_id">
	<input type="hidden" name="pob_ids" id="pob_ids" value="">
	<table>
		<tr>
			<th class="title">상품 상태</th>
			<td>
				<input type="radio" name="pi_status" value="a" id="ping" checked="checked"/>
				<label for="ping">판매중</label>
				<input type="radio" name="pi_status" value="b" id="pstop" />
				<label for="pstop">판매중지</label>
			</td>
		</tr>
		<tr>
			<th class="title">상품 목록</th>
			<td>
				<span style="margin-right:10px; vertical-align:middle;">대분류</span>

				<select name="pcb_id" onchange="setCategory(this.value, this.form.pcs_id);" style="width:170px; height:30px; margin-right:20px;">
					<option value="">선택</option>
					<c:forEach items="${bigList}" var="category">
						<option value="${category.pcb_id}">${category.pcb_name}</option>
					</c:forEach>
				</select>
				
			</td>
			<td>
				<span style="margin-right:10px; vertical-align:middle;">소분류</span>
				<select name="pcs_id" style="width:170px; height:30px;">
					<option value="">선택</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="title">상품 이미지</th>
			<td>
				<input type="file" class="pimg" name="pi_img1" /><br />
			</td>
			<td>
				<input type="file" class="pimg" name="pi_img2" /><br />
			</td>
			<td>
				<input type="file" class="pimg" name="pi_img3" /><br />
			</td>
		</tr>
		<tr>
			<th class="title">상품명</th>
			<td>
				<input type="text" name="pi_name" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품명을 입력해주세요." /><br />
			</td>
		</tr>	
		<tr>
			<th class="title">추가상품</th>
			<td>
				<input type="checkbox" name="pob_id" value="1.분갈이" id="division" onclick="showDiv(1);" /> <label for="division">분갈이</label>
				<input type="checkbox" name="pob_id" value="2.화분" id="pot" onclick="showDiv(2);" /> <label for="pot">화분</label>
				<input type="checkbox" name="pob_id" value="3.마감돌" id="stone" onclick="showDiv(3);" /> <label for="stone">마감돌</label>
			</td>
		</tr>
		<tr>
			<th class="title" rowspan="3" style="padding-top:15px; vertical-align:text-top;">서브상품</th>
			<td align="right" valign="top">
				<div id="sub1">
				<span style="vertical-align:super;">분갈이</span>
				<input type="checkbox" name="pos_id" value="1.분갈이,10000,1-1:직접 분갈이 (분갈이+난석+깔망)" id="pds01" style="vertical-align:super;" /> <label for="pds01" class="psub">1-1 직접 분갈이 (분갈이+난석+깔망)</label><br /><br />
				<input type="checkbox" name="pos_id" value="1.분갈이,7500,1-2:분갈이 요청(분갈이+난석+분갈이)" id="pds02" /> <label for="pds02" class="psub">1-2 분갈이 요청(분갈이+난석+분갈이)</label>
				</div>
			</td>
			<td align="right" valign="top">
				<div id="sub2">
				<span>화분</span>
				<input type="checkbox" name="pos_id" value="2.화분,4500,2-1:아트스톤 화분" id="pt01" /> <label for="pt01" class="psub">2-1 아트스톤 화분</label><br /><br />
				<input type="checkbox" name="pos_id" value="2.화분,5000,2-2:도자기 화분" id="pt02" /> <label for="pt02" class="psub">2-2 도자기 화분</label><br /><br />
				<input type="checkbox" name="pos_id" value="2.화분,9000,2-3:유약분" id="pt03" /> <label for="pt03" class="psub">2-3 유약분</label><br /><br />
				<input type="checkbox" name="pos_id" value="2.화분,8000,2-4:토분" id="st04" /> <label for="st04" class="psub">2-4 토분</label>
				</div>
			</td>
			<td align="right" valign="top">
				<div id="sub3">
				<span>마감돌</span>
				<input type="checkbox" name="pos_id" value="3.마감돌,1000,3-1:마사토" id="st01" /> <label for="st01" class="psub">3-1 마사토</label><br /><br />
				<input type="checkbox" name="pos_id" value="3.마감돌,1500,3-2:화산석" id="st02" /> <label for="st02" class="psub">3-2 화산석</label><br /><br />
				<input type="checkbox" name="pos_id" value="3.마감돌,500,3-3:자갈" id="st03" /> <label for="st03" class="psub">3-3 자갈</label>
				</div>
			</td>

		</tr>
		
		<tr>
			<td align="right">
			</td>
			<td align="right">
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="right">
			</td>
		</tr>
		<tr>
			<th class="title">상품원가</th>
			<td>
				<input type="text" name="pi_cost" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품원가를 입력해주세요." />원
			</td>
		</tr>
		<tr>
			<th class="title">상품판매가</th>
			<td>
				<input type="text" name="pi_price" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품판매가를 입력해주세요." />원
			</td>
		</tr>
		<tr>
			<th class="title">상품할인</th>
			<td>
				<input type="text" name="pi_dc" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="할인가를 입력해주세요." />%
			</td>
		</tr>
		<tr>
			<th class="title">상품수량</th>
			<td>
				<input type="text" name="pi_stock" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품수량을 입력해주세요." />개
			</td>
		</tr>
		<tr>
			<th class="title">상품설명 이미지</th>
			<td>
				<input type="file" name="pi_desc" class="pimg" /><br />
			</td>
		</tr>
	</table>
	<div class="btnBox">
		<input type="submit" value="상품 등록" class="insertBtn" />
		<a href="productList" class="cancelBtn">취소</a>
	</div>
	</form>
</div>

<script>
setCategory(document.frm.pcb_id.value, document.frm.pcs_id);
</script>
<%@ include file="../inc/inc_foot.jsp" %>