<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/inc_head.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
#img { width:100px; height:100px; }
#list { width:800px; }
#list th { border-bottom:1.5px solid #C6D0C3; }
#list td { border-bottom:1.5px solid #C6D0C3; }
#total { width:800px; }
#total th { border-bottom:1.5px solid #A1A1A1; text-align:left; font-size:16px; }
#total td { border-bottom:2px solid #A1A1A1; text-align:center; font-weight:bold; font-size:18px; }
#del { border:0; background:#fff; cursor:pointer; font-size:18px; color:grey; }
#all { font-size:13px; }
.btn1 { padding:6px 20px; font-size:15px; color:#6E6E6E; cursor:pointer; text-align:center; height:30px; border:1.5px solid  #6E6E6E; margin-bottom:10px; background:white; border-radius:20px;  }
.btn2 { padding:6px 20px; font-size:15px; color:white; cursor:pointer; text-align:center; height:30px; margin-bottom:10px; background:#0B9649; border-radius:20px; border:0; width:150px;  }
</style>
<script>
function chkAll(all) {
// 전체선택 체크박스 클릭시 모든 체크박스에 대한 체크 여부를 처리하는 함수
	var arr = document.frmCart.chk;
	for (var i = 1 ; i < arr.length ; i++) {
		arr[i].checked = all.checked;
	}
}

function chkOne(one) {
// 특정 체크박스 클릭시 체크 여부에 따른 '전체 선택' 체크박스의 체크 여부를 처리하는 함수
	var frm = document.frmCart;
	var all = frm.all;	// '전체 선택' 체크박스 객체
	if (one.checked) {	// 특정체크박스를 체크했을 경우
		var arr = frm.chk;
		var isChk = true;
		for (var i = 1 ; i < arr.length ; i++) {
			if (arr[i].checked == false) {	// 하나라도 체크가 안되어 있으면
				isChk = false;	break;
			}
		}
		all.checked = isChk;
	} else {	// 특정 체크박스를 체크 해제했을 경우
		all.checked = false;
	}
}

function cartDel(ocidx) {
// 장바구니내 특정 상품을 삭제하는 함수
	if (confirm("정말 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST", url : "/potted/cartProcDel", data : { "ocidx" : ocidx }, 
			success : function(chkRs) {
				if (chkRs == 0) {
					alert("상품 삭제에 실패했습니다.\n다시 시도하세요.");
				}
				location.reload();
			}
		});
	}
}

function getSelectedChk() {
// 체크박스들 중 선택된 체크박스들의 값(value)들을 쉼표로 구분하여 문자열로 리턴하는 함수	
	var chk = document.frmCart.chk;
	var idxs = "";	// chk컨트롤 배열에서 선택된 체크박스의 값들을 누적 저장할 변수
	for (var i = 1 ; i < chk.length ; i++) {
		if (chk[i].checked)	idxs += "," + chk[i].value;
	}
	return idxs.substring(1);	// ,1,2,3,...와 같이 출력되기 때문에 1부터 잘라 return함
}
	
function chkDel() {
// 사용자가 선택한 상품(들)을 삭제하는 함수
	var ocidx = getSelectedChk();
	// 선택한 체크박스의 oc_idx 값들이 쉼표를 기준으로 '1,2,3,4' 형태의 문자열로 저장됨
	if (ocidx == "")	alert("삭제할 상품을 선택하세요.");
	else				cartDel(ocidx);
}

function chkBuy() {
// 사용자가 선택한 상품(들)을 구매하는 함수
	var ocidx = getSelectedChk();
	// 선택한 체크박스의 oc_idx 값들이 쉼표를 기준으로 '1,2,3,4' 형태의 문자열로 저장됨
	if (ocidx == "")	alert("구매할 상품을 선택하세요.");
	else				document.frmCart.submit();

}
	
</script>
<div style="width:1000px; margin-left:570px; ">
<h2>장바구니</h2>
<form name="frmCart" action="orderForm" method="post">
<c:set var="totalPrice" value="0" />
<input type="checkbox" name="all" id ="all" checked="checked" onclick="chkAll(this);" />
<input type="hidden" name="chk" /><!-- chk 체크박스를 배열로 처리하기 위해 인위적으로 지정해 놓은 컨트롤 (값이 하나일때는 배열로 만들 수 없기 때문에) -->
<label for="all" id="all">전체 선택</label>
	<div style="display:none;">
	<c:if test="${orderCart.size() > 0}">
		<c:forEach items="${orderCart}" var="oc" varStatus="status">
			${totalPrice = totalPrice + oc.getOc_price()}
		</c:forEach>
	</c:if>
	</div>
<c:if test="${orderCart.size() > 0}">
	<table id="list" cellpadding="20" cellspacing="0">
		<tr height="20">
			<th width="*" colspan="3">상품정보</th>
			<th width="10%">수량</th>
			<th width="15%">주문금액</th>
			<th></th>
		</tr>
		<c:forEach items="${orderCart}" var="oc" varStatus="status">
		<tr height="30">
			<td width="5%" valign="top">
				<input type="checkbox" name="chk" value="${oc.getOc_idx()}" onclick="chkOne(this);" checked="checked" />
			</td>
			<td><a href="productView?piid=${oc.getPi_id()}"><img src="/potted/resources/images/product/${oc.getPi_img()}" id="img" /></a></td>
			<td valign="top"><span style="font-size:17px;">${oc.getPi_name()}</span><br /><span style="color:grey;">${oc.getOc_option()}</span></td>
			<td align="center">${oc.getOc_cnt()}</td>
			
			<td align="center"><fmt:formatNumber type="number" maxFractionDigits="3" value="${oc.getOc_price()}" /></td>
			<td valign="top"><input type="button" id="del" value="⊗" onclick="cartDel(${oc.getOc_idx()});" /></td>
		</tr>
		</c:forEach>
	</table>	
	<br /><br />
	<hr width="800" align="left" style="border-bottom:1.5px solid #A1A1A1;"/>
	<table id="total" cellpadding="0" cellspacing="0">
		<tr height="30px;"><th colspan="9">총 주문 상품 ${orderCart.size()}개</th></tr>
		<tr height="120px;">
			<td width="10%"></td>
			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /><p>상품 금액</p></td>
			<td>+<p style="height:15px;"></p></td>
			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="3500" /><p>배송비</p></td>
			<td>-<p style="height:15px;"></p></td>
			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="3500" /><p>할인금액</p></td>
			<td>=<p style="height:15px;"></p></td>
			<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /><p>총 주문금액</p></td>
			<td width="10%"></td>
		</tr>
	</table>
	<br />
	<input type="button" class="btn1" value="선택상품 삭제" onclick="chkDel();" /><br />
	<div style="margin-left:320px;">
	<input type="button" class="btn2" value="주문하기" onclick="chkBuy();" />
	</div>
	</c:if>
	<c:if test="${orderCart.size() == 0}">
		<tr height="50"><td colspan="5" align="center">
		텅~
		</td></tr>
	</c:if>
	</form>
	<br />
	<div style="margin-left:345px; font-size:15px;">
	<a href="productList">계속 쇼핑하기</a>
	</div>
</div>

<%@ include file="../inc/inc_foot.jsp" %>