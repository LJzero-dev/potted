<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<OrderCart> pdtList = (ArrayList<OrderCart>)request.getAttribute("pdtList");
ArrayList<MemberAddr> addrList = (ArrayList<MemberAddr>)request.getAttribute("addrList");

%>
<style>
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {-webkit-appearance: none; margin: 0;}
</style>
<script>

function chAddr(val) {
	var frm = document.frmOrder;
	var arr = val.split("|");
	frm.oi_name.value = arr[0];
	frm.oi_phone.value = arr[1];
	frm.oi_zip.value = arr[2];
	frm.oi_addr1.value = arr[3];
	frm.oi_addr2.value = arr[4];
}


</script>
<div class="shop_content payment">
	<form name="frmOrder" action="orderProcIn" method="post">
	<input type="hidden" name="od_name" value="${pi_name }" />
	<input type="hidden" name="option" value="${option }" />
	<input type="hidden" name="total" value="${total }" />
	<input type="hidden" name="mi_name" value="${mi_name }" />
	<input type="hidden" name="od_price" value="${pi_price}" />
	<input type="hidden" id="totaldel" name="oi_pay" value="${total + deliPrice}">
	<c:set var="deliPrice" value="3500" />
	<c:set var="pcPrice" value="0" />
	<div style="display:none;">
		${pcPrice = pi_price * pi_dc}
		<c:if test="${totalPrice >= 30000}">
			${deliPrice = 0}
		</c:if>
	</div>
	<div class="order_wrap">
		<h1 class="shop_tit">결제하기</h1>
		<div class="pd_box">
        <h3>주문 상품 정보</h3>
	        <div class="row">
	            <div class="item_box">
	                <div>
	                	<div class="shop_item_thumb">
                           <div class="product_img_wrap">
                               <img src="/potted/resources/images/product/${pi_img1 }" alt="주문상품 이미지">
                           </div>
                           <div class="product_info_wrap">
                               <span class="shop_item_title">${pi_name }</span>
                               <div class="shop_item_opt">
                                   <p>${option }</p>
                               </div>
                               <div class="shop_item_pay">
								    <span id="total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}" />원</span>
								    <span style="text-decoration: line-through"></span>
								</div>
                           </div>
	                    </div>
	                    <div class="im-payment-deliv">
	                     	<div>배송비 <span class="text-bold"><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliPrice }" /></span></div>
	                    </div>	               
	            	</div>                        
	        	</div>
	        </div>
	    </div>
	    <div class="pd_box">
	    	<h3>주문자 정보</h3>
	    	<div class="order_detail">
	    		<h4>${mi_name }</h4>
	    		<p>${mi_phone }</p>
	    		<p>${mi_email }</p>
	    	</div>
	    </div>
	    <div class="pd_box delivery">
	    	<h3>배송 정보</h3>
	    	<span>주소 선택 :</span>
	    	<select class="form_control" onchange="chAddr(this.value);">
			<%
			String maname = "", marname = "", maphone = "", mazip = "", maaddr1 = "", maaddr2 = "";
			// 처음 페이지 로딩 시 보여줄 기본주소의 값들을 저장할 변수
			
			for (MemberAddr ma : addrList) {
				if (ma.getMa_basic().equals("y")) {	// 기본주소이면
					maname = ma.getMa_name();
					marname = ma.getMa_rname();
					maphone = ma.getMa_phone();
					mazip = ma.getMa_zip();
					maaddr1 = ma.getMa_addr1();
					maaddr2 = ma.getMa_addr2();
				}
				String val = "", txt = "";
				val = ma.getMa_rname() + "|" + ma.getMa_phone() + "|" + ma.getMa_zip() + "|" + ma.getMa_addr1() + "|" + ma.getMa_addr2();
				txt = ma.getMa_name();
				
				out.println("<option value='" + val + "'>" + txt + "</option>");
			}
			%>
			</select>
			<div class="inp_box pd">
				<input type="text" name="oi_name" value="<%=marname %>" placeholder="수령인" class="w50 h30" />
				<input type="text" name="oi_phone" value="<%=maphone %>" placeholder="연락처" class="w50 h30" />
			</div>
			<div class="inp_box">				
				<input type="text" name="oi_zip" value="<%=mazip %>" placeholder="우편번호" class="w50 h30" />
			</div>
			<div class="inp_box">				
				<input type="text" name="oi_addr1" value="<%=maaddr1 %>" placeholder="주소" class="w100 h30" />
				<input type="text" name="oi_addr2" value="<%=maaddr2 %>" placeholder="상세주소" class="w100 h30" style="margin-top:6px;" />
			</div>
			<select name="oi_memo" class="form_control2">
				<option value="">배송메모를 선택해 주세요.</option>
				<option value="배송 전에 미리 연락 바랍니다.">배송 전에 미리 연락 바랍니다.</option>
				<option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
				<option value="부재시 전화나 문자를 남겨주세요.">부재시 전화나 문자를 남겨주세요.</option>
			</select>
	    </div>
		<div class="pd_box">
	    	<h3>포인트</h3>
	    	<div class="point_wrap">
			    <div class="input_tools holder">
			        <input type="number" title="보유" id="use_pnt" name="oi_upoint" value="0" class="form-control text-brand _input_point"  onchange="changePoint(${total}, ${mi_point}, 100, 100, ${pcPrice});" />
			    	<a href="javascript:void(0);" id="chk_use" class="allpoint" onclick="chkPoint(${total}, ${mi_point}, 100, 100, ${pcPrice});">전액사용</a>
				</div>
				
				<p class="text-13 margin-top-xl no-margin-bottom">
				    보유 포인트 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${mi_point }" /></strong>
				</p>
		        <p class="no-margin text-gray text-13">포인트는 100단위로 사용 가능합니다.</p>
			</div>
	    </div>
	    <div class="pd_box">
	    	<h3>결제 수단</h3>
	    	<p class="pLine">
				<input type="radio" name="oi_payment" value="a" id="payCard" checked="checked" />
				<label for="payCard" style="font-size:14px; vertical-align:top;">카드 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="oi_payment" value="b" id="payPhone" />
				<label for="payPhone" style="font-size:14px; vertical-align:top;">휴대폰 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="oi_payment" value="c" id="payBank" />
				<label for="payBank" style="font-size:14px; vertical-align:top;">무통장 입금</label>
			</p>
	    </div>
	    <div class="pd_box2">
	    	<div class="paydetail">
		    	<h3>결제 상세</h3>
				<div class="pay_txt">
					<p class="text-gray">상품가격</p>
					<p class="text-gray">배송비</p>
					<p class="text-gray">상품 할인금액</p>
				</div>
				<div class="pay_number">
					<p><fmt:formatNumber type="number" maxFractionDigits="3" value="${pi_price}" />원</p>
					
					<p>+<fmt:formatNumber type="number" maxFractionDigits="3" value="${deliPrice}" />원</p>
					<c:if test="${pcPrice == 0}">
					<p name="left_pnt"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pcPrice }" />원</p>
					</c:if>
					<c:if test="${pcPrice > 0}">
					<p name="left_pnt">-<fmt:formatNumber type="number" maxFractionDigits="3" value="${pcPrice }" />원</p>
					</c:if>
				</div>
				<div class="col_ctr">
					<p>총 주문금액</p>
					<p>
						<span id="result_pnt"><fmt:formatNumber type="number" maxFractionDigits="3" value="${total + deliPrice}" />원</span>
						<input type="hidden" id="totaldel" name="oi_pay" value="${total + deliPrice}">
					</p>
				</div>		
			</div>
			<div class="tip-off bg-gray pay_area">
				<p class="no-margin text-13"><span id="acc" class="text-brand"><fmt:formatNumber type="number" maxFractionDigits="3" value="${(total + deliPrice) * 0.01}" /></span> 포인트 적립예정</p>
				<input type="hidden" id="oi_apoint" name="oi_apoint" value="${(total + deliPrice) * 0.01}">
			</div>
			<input type="submit" value="결제하기" class="paymentBtn">
	    </div>
	</div>
	</form>
	<%@ include file="../inc/inc_foot.jsp" %>
</div>
<script>
function chkPoint(amt,pnt,min,unit,sp) {
	//amt : 최초 결제 금액 / pnt : 사용가능,남은 포인트 / min : 사용 가능 최소 포인트 / unit : 사용단위
	var v_point = 0;
	if (pnt < min) {  //최소 사용 단위보다 작을 때
		v_point = 0; 
	} else {
		v_point = pnt - pnt%unit; // 사용할 포인트 = 전체 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
	}
	document.getElementById("use_pnt").value = v_point;
	
	changePoint(amt,pnt,min,unit,sp);
}

function changePoint(amt,pnt,min,unit) {
	var pcPrice = ${pcPrice}
	var v_point = parseInt(document.getElementById("use_pnt").value);
	if (v_point > pnt) { //입력값이 사용가능 포인트보다 클때
		v_point = pnt;
		document.getElementById("use_pnt").value = v_point;
	} 
	
	if (v_point > amt) { //결제금액보다 포인트가 더 클 때
		v_point = amt;
		document.getElementById("use_pnt").value = v_point;
	}
	
	if (v_point < min) { //최소 사용 단위보다 작을 때
		v_point = 0;
		document.getElementById("use_pnt").value = v_point;
	} else {
        v_point = Math.floor(v_point / 100) * 100; // 입력된 포인트의 십의 자리수와 일의 자리수 제거
        document.getElementById("use_pnt").value = v_point;
    }
	
	var v_left = document.getElementsByName("left_pnt"); //사용가능 마일리지, 남은 포인트 값 설정
	for (var i = 0; i < v_left.length; i++) {
		var totalLeft = pcPrice + v_point;
        var formattedTotalLeft = totalLeft.toLocaleString();
		v_left[i].innerHTML = '-' + formattedTotalLeft + '원'; //= 전체 포인트 중에 사용할 포인트빼고 남은 포인트

	}
	
	var total = ${total + deliPrice}
	var tvp = total - v_point;
	var accValue = (total - v_point) * 0.01;
	var formattedTotal = (total - v_point).toLocaleString(); // 숫자에 천 단위마다 콤마 찍기

	document.getElementById("result_pnt").innerHTML = formattedTotal + "원";
	document.getElementById("totaldel").value = tvp;
	
	document.getElementById("acc").innerHTML = accValue.toLocaleString();
	document.getElementById("oi_apoint").value = accValue;
	
}

</script>
