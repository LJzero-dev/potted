<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
%>
<div class="shop-content payment" id="order_form_wrap">
	<div class="order_wrap ">
		<div class="tip-off ">
        <h6>주문 상품 정보</h6>
	        <div class="row">
	            <div class="col-xs-12 col_ctr">
	                <div>
	                	<div class="shop_item_thumb">
	                        <a href="javascript:void(0);" target="_blank">
	                            <div class="product_img_wrap">
	                                <img src="https://cdn.imweb.me/thumbnail/20220728/12a188e7ef268.png" alt="주문상품 이미지">
	                            </div>
	                            <div class="product_info_wrap">
	                                <span class="shop_item_title">(주황색 도토리 토분 속) 필레아 페페로미오이데스</span>
	                                <div class="shop_item_opt">
	                                    <p><em class="list_badge badge_latest">필수</em> 0. 마감돌은 괜찮아요 - 1개</p>
	                                </div>
	                                <div class="shop_item_pay">
	                                	<span class="text-bold text-14">52,934원</span>
	                                   	<span class="text-bold text-14" style="text-decoration: line-through">139,300원</span>
	                                </div>
	                            </div>
	                         </a>
	                     </div>
	                     <div class="im-payment-deliv">
	                     	<div>배송비 <span class="text-bold">무료</span>
	                     </div>
	                    </div>
	            	</div>                        
	        	</div>
	        </div>
	    </div>
	</div>
</div>
<%@ include file="../inc/inc_foot.jsp" %>