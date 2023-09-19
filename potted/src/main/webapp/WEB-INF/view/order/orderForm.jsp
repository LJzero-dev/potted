<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../inc/inc_head.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.4.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addr_api.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/addr_api2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<%
request.setCharacterEncoding("utf-8");

ArrayList<MemberAddr> addrList = (ArrayList<MemberAddr>)request.getAttribute("addrList");

%>
<style>
input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {-webkit-appearance: none; margin: 0;}
#addrFind {height:36px; vertical-align:top;}
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
    

const userCode = "imp32400633";
IMP.init(userCode);

function requestPay() {
  IMP.request_pay({
    pg: "html5_inicis",
    pay_method: "card",
    merchant_uid: "test_lmq36j0n",
    name: "테스트 결제",
    amount: 100,
    buyer_tel: "010-0000-0000",
  });
}

</script>
<div class="shop_content payment">
	<form name="frmOrder" action="orderProcIn" method="post">
	<input type="hidden" name="kind" value="${kind }" />
	<input type="hidden" name="pi_id" value="${pi_id }" />
	<input type="hidden" name="isAuction" value="${isAuction }" />
	<input type="hidden" name="od_name" value="${pi_name }" />
	<input type="hidden" name="od_img" value="${pi_img1 }" />
	<input type="hidden" name="mi_name" value="${mi_name }" />
	<input type="hidden" name="od_price" value="${pi_price}" />
	<input type="hidden" name="option" value="${option}" />
	<input type="hidden" name="total" value="${total }" />
	<input type="hidden" name="pcnt" value="${pcnt }" />
	<c:set var="deliPrice" value="3500" />
	<c:set var="totalPrice" value="0" />
	<c:set var="totalOption" value="" />
	<c:forEach var="oc" items="${pdtList}">
		<input type="hidden" name="oc_idx" value="${oc.oc_idx}" />
	    
	    <c:set var="totalPrice" value="${totalPrice + oc.oc_price}" />
	    <c:if test="${not empty totalOption}">
	        <c:set var="totalOption" value="${totalOption}/${oc.oc_option}" />
	    </c:if>
	    
	    <c:if test="${empty totalOption}">
	        <c:set var="totalOption" value="${oc.oc_option}" />
	    </c:if>
	</c:forEach>
	<c:choose>
		<c:when test="${kind eq 'c'}">
			<input type="hidden" id="totaldel" name="oi_pay" value="${totalPrice}">
		</c:when>
		<c:otherwise>
			<input type="hidden" id="totaldel" name="oi_pay" value="${total + deliPrice}">     
		</c:otherwise>     
	</c:choose>
	
	<input type="hidden" id="totaldel" name="oi_pay" value="${total + deliPrice}">  
	
	<c:set var="pcPrice" value="0" />
	<div style="display:none;">
		${pcPrice = pi_price * pi_dc}
		<c:if test="${totalPrice >= 30000}">
			${deliPrice = 0}
		</c:if>
		<c:if test="${total >= 30000}">
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
	                	<c:forEach var="oc" items="${pdtList}">
                        <div class="shop_item_thumb">
                           <div class="product_img_wrap">                            
                               <img src="/ad_potted/resources/images/product/${oc.pi_img}" alt="주문상품 이미지">
                           </div>
                           <div class="product_info_wrap">                               
                               <div class="shop_item_opt">                                   
	                               <span class="shop_item_title">${oc.pi_name }</span>
	                               <div class="shop_item_opt">
	                               <c:choose>
	                                   <c:when test="${kind eq 'c'}">
	                                   		<p>${oc.oc_option }</p>
	                                   </c:when>
	                                   <c:otherwise>
	                                        <p>${option }</p>
	                                   </c:otherwise>
	                               </c:choose>
	                               </div>
	                               <div class="shop_item_pay">
	                               		<c:choose>
		                               		<c:when test="${kind eq 'c'}">
		                               			<span id="total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${oc.oc_price }" />원</span>	  
		                               		</c:when>
		                               		<c:otherwise>
		                                    	<span id="total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}" />원</span>	       
		                                    </c:otherwise>     
	                                    </c:choose>                     
									</div>
	                           </div>
	                    	</div>
	                    </div>
	                    </c:forEach>
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
				<input type="text" name="oi_zip" value="<%=mazip %>" id="sample4_postcode" class="w50 h30" placeholder="우편번호"/>
				<input id="addrFind" type="button" value="우편번호 찾기" onclick="sample4_execDaumPostcode()" /><span id="guide" style="color:#999;display:none; position:absolute; top:-500px; left:-500px;"></span>
			</div>
			<div class="inp_box">				
				<input type="text" name="oi_addr1" value="<%=maaddr1 %>" id="sample4_roadAddress" class="w100 h30" placeholder="주소"/>
				<input type="text" name="oi_addr2" value="<%=maaddr2 %>" id="sample4_detailAddress" class="w100 h30" placeholder="상세주소" style="margin-top:6px;" />
				<input type="text" id="sample4_jibunAddress" placeholder="지번주소" style="display:none;">
				<input type="text" id="sample4_extraAddress" placeholder="참고항목" style="display:none;">
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
			    	<c:choose>
						<c:when test="${kind eq 'c'}">
							 <input type="number" title="보유" id="use_pnt" name="oi_upoint" value="0" class="form-control text-brand _input_point"  onchange="changePoint(${totalPrice}, ${mi_point}, 100, 100, ${pc_price});" />
						</c:when>
						<c:otherwise>
							 <input type="number" title="보유" id="use_pnt" name="oi_upoint" value="0" class="form-control text-brand _input_point"  onchange="changePoint(${total}, ${mi_point}, 100, 100, ${pcPrice});" />    
						</c:otherwise>     
					</c:choose>  
			       
			       	<c:choose>
						<c:when test="${kind eq 'c'}">
							 <a href="javascript:void(0);" id="chk_use" class="allpoint" onclick="chkPoint(${totalPrice}, ${mi_point}, 100, 100, ${pc_price});">전액사용</a>
						</c:when>
						<c:otherwise>
							 <a href="javascript:void(0);" id="chk_use" class="allpoint" onclick="chkPoint(${total}, ${mi_point}, 100, 100, ${pcPrice});">전액사용</a>    
						</c:otherwise>     
					</c:choose>
			    	
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
					<c:choose>
						<c:when test="${kind eq 'c'}">
							<p name="left_pnt">-<fmt:formatNumber type="number" maxFractionDigits="3" value="${pc_price }" />원</p>
						</c:when>
						<c:otherwise>
							<p name="left_pnt">-<fmt:formatNumber type="number" maxFractionDigits="3" value="${pcPrice }" />원</p>
						</c:otherwise>     
					</c:choose>
					
				</div>
				<div class="col_ctr">
					<p>총 주문금액</p>
					<p>
						<c:choose>
							<c:when test="${kind eq 'c'}">
								<span id="result_pnt"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" />원</span>  
							</c:when>
							<c:otherwise>
								<span id="result_pnt"><fmt:formatNumber type="number" maxFractionDigits="3" value="${total + deliPrice}" />원</span>	       
							</c:otherwise>     
						</c:choose>  
						
						<input type="hidden" id="totaldel" name="oi_pay" value="${total + deliPrice}">
					</p>
				</div>		
			</div>
			<div class="tip-off bg-gray pay_area">
				<c:choose>
					<c:when test="${kind eq 'c'}">
						<p class="no-margin text-13"><span id="acc" class="text-brand"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice * 0.01}" /></span> 포인트 적립예정</p>
						<input type="hidden" id="oi_apoint" name="oi_apoint" value="${totalPrice * 0.01}">
					</c:when>
					<c:otherwise>
						<p class="no-margin text-13"><span id="acc" class="text-brand"><fmt:formatNumber type="number" maxFractionDigits="3" value="${(total + deliPrice) * 0.01}" /></span> 포인트 적립예정</p>
						<input type="hidden" id="oi_apoint" name="oi_apoint" value="${(total + deliPrice) * 0.01}">
					</c:otherwise>     
				</c:choose> 
				
			</div>
			<input type="button" value="결제하기" onclick="requestPay();" class="paymentBtn">
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
	var v_point = parseInt(document.getElementById("use_pnt").value);
	var kind = "${kind}";
	
	var pcPrice = 0;
	
    if (kind == 'c') {
        pcPrice = ${pc_price}0;
    } else {
        pcPrice = ${pcPrice};
    }
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
	
	if (kind == 'c') {
		var total = ${totalPrice}
	} else {
		var total = ${total + deliPrice}
	}
	var tvp = total - v_point;
	var accValue = (total - v_point) * 0.01;
	var formattedTotal = (total - v_point).toLocaleString(); // 숫자에 천 단위마다 콤마 찍기

	document.getElementById("result_pnt").innerHTML = formattedTotal + "원";
	document.getElementById("totaldel").value = tvp;
	
	document.getElementById("acc").innerHTML = accValue.toLocaleString();
	document.getElementById("oi_apoint").value = accValue;
	
}

</script>
