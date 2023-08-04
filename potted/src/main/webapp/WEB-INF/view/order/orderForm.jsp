<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
function chkPoint(amt,pnt,min,unit) {
	//amt : 최초 결제 금액 / pnt : 사용가능,남은 포인트 / min : 사용 가능 최소 포인트 / unit : 사용단위
	var v_point = 0;
	if (pnt < min) {  //최소 사용 단위보다 작을 때
		v_point = 0; 
	} else {
		v_point = pnt - pnt%unit; // 사용할 포인트 = 전체 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
	}
	document.getElementById("use_pnt").value = v_point;
	
	changePoint(amt,pnt,min,unit);
}

function changePoint(amt,pnt,min,unit) {
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
		v_point = v_point - v_point%unit; //사용할 포인트 = 사용할 마일리지 중 최소단위 이하 마일리지를 뺀 포인트
	}
}

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
	<div class="order_wrap">
		<h1 class="shop_tit">결제하기</h1>
		<div class="pd_box">
        <h3>주문 상품 정보</h3>
	        <div class="row">
	            <div class="item_box">
	                <div>
	                	<div class="shop_item_thumb">
                           <div class="product_img_wrap">
                               <img src="https://cdn.imweb.me/thumbnail/20220728/12a188e7ef268.png" alt="주문상품 이미지">
                           </div>
                           <div class="product_info_wrap">
                               <span class="shop_item_title">${pi_name }</span>
                               <div class="shop_item_opt">
                                   <p>${option }</p>
                               </div>
                               <div class="shop_item_pay">
                               	<span>${total }원</span>
                                  	<span style="text-decoration: line-through"></span>
                               </div>
                           </div>
	                    </div>
	                    <div class="im-payment-deliv">
	                     	<div>배송비 <span class="text-bold">3,500</span></div>
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
			<select class="form_control2">
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
			    
			        <input type="number" title="보유" id="use_pnt" class="form-control text-brand _input_point" />
			    	<a href="javascript:void(0);" id="chk_use" class="allpoint" onclick="chkPoint(${total}, ${mi_point}, 100, 100);">전액사용</a>
				</div>
				
				<p class="text-13 margin-top-xl no-margin-bottom">
				    보유 포인트 <strong>${mi_point }</strong>
				</p>
		        <p class="no-margin text-gray text-13">포인트는 100단위로 사용 가능합니다.</p>
			</div>
	    </div>
	    <div class="pd_box">
	    	<h3>결제 수단</h3>
	    	<p class="pLine">
				<input type="radio" name="pay" value="a" id="payCard" checked="checked" />
				<label for="payCard" style="font-size:14px; vertical-align:top;">카드 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pay" value="b" id="payPhone" />
				<label for="payPhone" style="font-size:14px; vertical-align:top;">휴대폰 결제</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="pay" value="c" id="payBank" />
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
					<p>${totalc}원</p>
					<p>${delic }원</p>
					<p>-118,656원</p>
				</div>
				<div class="col_ctr">
					<p>총 주문금액</p>
					<p>
						<span>원</span>
					</p>
				</div>		
			</div>
			<div class="tip-off bg-gray pay_area">
				<p class="no-margin text-13">
				<span class="text-brand">3,919</span> 포인트 적립예정</p>
			</div>
			<a href="javascript:void(0);" class="paymentBtn">결제하기</a>
	    </div>
	</div>
	</form>
	<%@ include file="../inc/inc_foot.jsp" %>
</div>
