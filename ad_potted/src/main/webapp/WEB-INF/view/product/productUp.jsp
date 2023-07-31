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
</style>

<div style="width:1100px; margin:0 auto; overflow:hidden;">
	<h2>상품 수정</h2>
	<form name="frm" action="productProcIn" method="post">
	<table>
		<tr>
			<th class="title">상품 상태</th>
			<td>
				<input type="radio" name="pi_status" value="a" id="ping" <c:if test="${pi.getPi_status() == 'a' }">checked="checked"</c:if> />
				<label for="ping">판매중</label>
				<input type="radio" name="pi_status" value="b" id="pstop" <c:if test="${pi.getPi_status() == 'b' }">checked="checked"</c:if> />
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
						<option value="${category.pcb_id}" >${category.pcb_name}</option>
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
				<input type="text" name="pi_name" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품명을 입력해주세요." value="${pi.getPi_name() }" /><br />
			</td>
		</tr>	
		<tr>
			<th class="title">추가상품</th>
			<td>
				<input type="checkbox" name="pob_id" value="1.분갈이" id="division" /> <label for="division">분갈이</label>
				<input type="checkbox" name="pob_id" value="2.화분" id="pot" /> <label for="pot">화분</label>
				<input type="checkbox" name="pob_id" value="3.마감돌" id="stone" /> <label for="stone">마감돌</label>
			</td>
		</tr>
		<tr>
			<th class="title" rowspan="3" style="padding-top:15px; vertical-align:text-top;">서브상품</th>
			<td align="right">
				<span style="vertical-align:super;">분갈이</span>
				<input type="checkbox" name="pos_id" value="1-1:직접 분갈이 (분갈이+난석+깔망)" id="pds01" style="vertical-align:super;" /> <label for="pds01" class="psub">1-1 직접 분갈이 (분갈이+난석+깔망)</label>
			</td>
			<td align="right">
				<span>화분</span>
				<input type="checkbox" name="pos_id" value="2-2:아트스톤 화분" id="pt01" /> <label for="pt01" class="psub">2-1 아트스톤 화분</label> 
			</td>
			<td align="right">
				<span>마감돌</span>
				<input type="checkbox" name="pos_id" value="3-1:마사토" id="st01" /> <label for="st01" class="psub">3-1 마사토</label>
			</td>

		</tr>
		<tr>
			<td align="right" rowspan="3" style="vertical-align:top;">
				<input type="checkbox" name="pos_id" value="1-2:분갈이 요청(분갈이+난석+분갈이)" id="pds02" /> <label for="pds02" class="psub">1-2 분갈이 요청(분갈이+난석+분갈이)</label>
			</td>
			<td align="right">
				<input type="checkbox" name="pos_id" value="2-2:도자기 화분" id="pt02" /> <label for="pt02" class="psub">2-2 도자기 화분</label>
			</td>
			<td align="right">
				<input type="checkbox" name="pos_id" value="3-2:화산석" id="st02" /> <label for="st02" class="psub">3-2 화산석</label>
			</td>
		</tr>
		<tr>
			<td align="right">
				<input type="checkbox" name="pos_id" value="2-3:유약분" id="pt03" /> <label for="pt03" class="psub">2-3 유약분</label>
			</td>
			<td align="right">
				<input type="checkbox" name="pos_id" value="3-3:자갈" id="st03" /> <label for="st03" class="psub">3-3 자갈</label>
			</td>
		</tr>
		<tr>
			<td></td>
			<td align="right">
				<input type="checkbox" name="pos_id" value="2-4:토분" id="st04" /> <label for="st04" class="psub">2-4 토분</label>
			</td>
		</tr>
		<tr>
			<th class="title">상품원가</th>
			<td>
				<input type="text" name="pi_cost" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품원가를 입력해주세요." value="${pi.getPi_cost() }" />원
			</td>
		</tr>
		<tr>
			<th class="title">상품판매가</th>
			<td>
				<input type="text" name="pi_price" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품판매가를 입력해주세요." value="${pi.getPi_price() }" />원
			</td>
		</tr>
		<tr>
			<th class="title">상품할인</th>
			<td>
				<input type="text" name="pi_dc" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="할인가를 입력해주세요." value="${pi.getPi_dc() }" />%
			</td>
		</tr>
		<tr>
			<th class="title">상품수량</th>
			<td>
				<input type="text" name="pi_stock" style="width:253px; padding:10px; margin-right:10px; border:1px solid #000;" placeholder="상품수량을 입력해주세요." value="${pi.getPi_stock() }" />개
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
		<input type="submit" value="상품 수정" class="insertBtn"/>
		<a href="javascript:void(0);" class="cancelBtn" onclick="history.back();">취소</a>
	</div>
	</form>
</div>

<script>
setCategory(document.frm.pcb_id.value, document.frm.pcs_id);
</script>
<%@ include file="../inc/inc_foot.jsp" %>