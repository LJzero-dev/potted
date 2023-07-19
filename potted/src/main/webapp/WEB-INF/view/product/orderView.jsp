<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
%>
<div class="shop_content payment">
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
                               <span class="shop_item_title">(주황색 도토리 토분 속) 필레아 페페로미오이데스</span>
                               <div class="shop_item_opt">
                                   <p>0. 마감돌은 괜찮아요 - 1개</p>
                               </div>
                               <div class="shop_item_pay">
                               	<span>52,934원</span>
                                  	<span style="text-decoration: line-through">139,300원</span>
                               </div>
                           </div>
	                    </div>
	                    <div class="im-payment-deliv">
	                     	<div>배송비 <span class="text-bold">무료</span></div>
	                    </div>	               
	            	</div>                        
	        	</div>
	        </div>
	    </div>
	    <div class="pd_box">
	    	<h3>주문자 정보</h3>
	    	<div class="order_detail">
	    		<h4>홍길동</h4>
	    		<p>01012345678</p>
	    		<p>test@naver.com</p>
	    	</div>
	    </div>
	    <div class="pd_box delivery">
	    	<h3>배송 정보</h3>
	    	<span>주소 선택 :</span>
	    	<select class="form_control">
				<option value="">기본주소</option>
				<option value="">집</option>
				<option value="">회사</option>
			</select>
			<div class="inp_box pd">
				<input type="text" placeholder="수령인" class="w50 h30" />
				<input type="text" placeholder="연락처" class="w50 h30" />
			</div>
			<div class="inp_box">				
				<input type="text" placeholder="우편번호" class="w50 h30" />
			</div>
			<div class="inp_box">				
				<input type="text" placeholder="주소" class="w100 h30" />
				<input type="text" placeholder="상세주소" class="w100 h30" style="margin-top:6px;" />
			</div>
			<select class="form_control2">
				<option value="">배송메모를 선택해 주세요.</option>
				<option value="배송 전에 미리 연락 바랍니다.">배송 전에 미리 연락 바랍니다.</option>
				<option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
				<option value="부재시 전화나 문자를 남겨주세요.">부재시 전화나 문자를 남겨주세요.</option>
			</select>
	    </div>
<!-- 	    <div class="pd_box">
	    	<h3>결제수단</h3>
	    </div>	   -->
	</div>
</div>
<%@ include file="../inc/inc_foot.jsp" %>