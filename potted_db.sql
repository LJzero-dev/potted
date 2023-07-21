create database potted;
use potted;

-- 관리자 테이블 테이블
create table t_admin_info (
	ai_idx int auto_increment unique,	-- 일련번호
    ai_id varchar(20) primary key,		-- 아이디
    ai_pw varchar(20),					-- 비밀번호
    ai_name varchar(20),				-- 이름
    ai_use char(1) default 'y',			-- 사용여부
    ai_date datetime default now()		-- 등록일
);



-- 회원 테이블 테이블
create table t_member_info (
	mi_id varchar(20) primary key,		-- 회원아이디
    mi_pw varchar(20) not null,			-- 회원비밀번호
    mi_name varchar(20) not null,		-- 회원이름
	mi_gender char(1) not null,			-- 성별
	mi_birth char(10) not null,			-- 생년월일
	mi_phone varchar(13) not null,		-- 전화번호
	mi_email varchar(50) not null,		-- 이메일
	mi_isad char(1) not null,			-- 광고수신
	mi_point int default 0 not null,	-- 보유 포인트
	mt_plant char(1) default 'n',		-- 식물상태값
	mt_protein int default 0,			-- 영양제갯수
	mi_status char(1) default 'a',		-- 상태 
	mi_date datetime default now(),		-- 가입일
	mi_lastlogin datetime				-- 최종 로그인
);
insert into t_member_info values ('test1', '1234', '홍길동', '남', '1975-05-24', '010-1234-1234', 'hong@naver.com', 'y', 1000, 'n', '0', 'a', now(), null);

-- 회원 주소록 테이블
create table t_member_addr (
	ma_idx int primary key auto_increment,	-- 일련번호
	mi_id varchar(20) not null,				-- 회원아이디
	ma_name varchar(20) not null,			-- 주소이름
	ma_rname varchar(20) not null,			-- 수취인이름
	ma_phone varchar(13) not null,			-- 휴대폰
	ma_zip char(5) not null,				-- 우편번호
	ma_addr1 varchar(50) not null,			-- 주소1
	ma_addr2 varchar(50) not null,			-- 주소2
	ma_basic char(1) default 'y',			-- 기본주소 여부
	ma_date datetime default now(),			-- 등록일
    constraint fk_t_member_addr_mi_id foreign key(mi_id) references t_member_info(mi_id)
);


drop table t_member_tree;
-- 회원 식물 테이블
create table t_member_tree (
	mt_idx int primary key auto_increment,	-- 일련번호
	mi_id varchar(20) not null,				-- 회원아이디
	mt_grade char(1),						-- 식물등급
	mt_hp int default 10000,				-- 식물HP
	mt_count int default 0,					-- 물준횟수
	mt_date datetime default now(),			-- 시작날짜
    constraint fk_t_member_tree_mi_id foreign key(mi_id) references t_member_info(mi_id)
);
insert into t_member_tree values ('', 'test1', 'y', '1', 's', '10000', '0', '');
select 1 from t_member_tree where mi_id = 'test1' and mt_plant = 'y';

-- 회원 포인트 내역 테이블
create table t_member_point (
	mp_idx int primary key auto_increment,	-- 일련번호
	mi_id varchar(20) not null,				-- 회원아이디
	mp_su char(1) default 's',				-- 사용/적립
	mp_point int default 0,					-- 포인트
	mp_desc varchar(20) not null,			-- 사용/적립내용
	mp_detail varchar(20) default '',					-- 내역상세				
	mp_date datetime default now(),			-- 사용/적립일
	mp_admin int default 0,					-- 관리자번호
	constraint fk_t_member_point_mi_id foreign key(mi_id) references t_member_info(mi_id)
);


-- 상품 대분류 테이블
create table t_product_ctgr_big (
   pcb_id char(2) primary key,      -- 대분류 코드
   pcb_name varchar(20) not null   	-- 대분류 이름
);

-- 상품 소분류 테이블
create table t_product_ctgr_small (
   pcs_id char(4) primary key,      -- 소분류 코드
   pcb_id char(2) not null,      	-- 대분류 코드
   pcs_name varchar(20) not null,   -- 소분류 이름
   constraint fk_product_ctgr_small_pcb_id foreign key (pcb_id) references t_product_ctgr_big(pcb_id)
);

-- 상품 테이블
create table t_product_info (
   pi_id char(7) primary key,			-- 상품ID
   pcb_id char(2) not null,				-- 대분류 코드
   pcs_id char(4) not null,         	-- 소분류 코드
   pi_name varchar(50) not null,		-- 상품명
   pi_price int default 0,				-- 가격
   pi_cost int default 0,				-- 원가
   pi_dc float default 0,				-- 할인율
   pi_status char(1) default 'a',		-- 상품 판매상태
   pi_img1 varchar(50) not null,		-- 상품 이미지1
   pi_img2 varchar(50) default '',		-- 상품 이미지2
   pi_img3 varchar(50) default '',		-- 상품 이미지3
   pi_desc varchar(50) not null,		-- 설명 이미지
   pi_special varchar(4) default '',	-- 특별상품 여부
   pi_read int default 0,				-- 조회수
   pi_review int default 0,				-- 후기 개수
   pi_sale int default 0,				-- 판매량
   pi_isview char(1) default 'n',		-- 게시여부
   pi_date datetime default now(),      -- 등록일
   ai_idx int not null,            		-- 등록관리자
   pi_last datetime default now(),		-- 최종 수정일
   pi_admin int default 0,				-- 최종 수정자
   constraint fk_product_info_pcb_id foreign key (pcb_id) references t_product_ctgr_big(pcb_id),
   constraint fk_product_info_pcs_id foreign key (pcs_id) references t_product_ctgr_small(pcs_id),
   constraint fk_product_info_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);


-- 상품 재고 테이블
create table t_product_stock (
   ps_idx int auto_increment primary key,   -- 일련번호
   pi_id char(7) not null,					-- 상품ID
   ps_stock int unsigned default 0,			-- 재고량
   ps_sale int default 0,					-- 판매량
   ps_isview char(1) default 'n',			-- 게시여부
   constraint fk_product_stock_pi_id foreign key (pi_id) references t_product_info(pi_id)
);



-- 주문정보 테이블
create table t_order_info (
	oi_id char(14) primary key,			-- 주문정보
	mi_id varchar(20) not null,			-- 회원아이디
	oi_name varchar(20) not null,		-- 수취인명
	oi_type char(1) default 'a',		-- 상품유형
	oi_phone varchar(13) not null,		-- 배송지 전화번호
	oi_zip char(5) not null,			-- 배송지 우편번호
	oi_addr1 varchar(50) not null,		-- 배송지 주소1
	oi_addr2 varchar(50) not null,		-- 배송지 주소2
	oi_memo varchar(50) default '',		-- 요청사항
	oi_payment char(1) default 'a',		-- 결제수단
	oi_pay int default 0,				-- 결제액
	oi_upoint int default 0,			-- 사용포인트
	oi_spoint varchar(50) default '',	-- 송장번호
	oi_status char(1) default 'a',		-- 주문상태
	oi_date datetime default now(),		-- 주무일
	constraint fk_t_order_info_mi_id foreign key(mi_id) references t_member_info(mi_id)
);


-- 장바구니 테이블
create table t_order_cart (
	oc_idx int primary key auto_increment,	-- 일련번호
	mi_id varchar(20) not null,				-- 회원아이디
	pi_id char(7) not null,					-- 상품ID
	ps_idx int not null,					-- 옵션별ID
	oc_cnt int default 1,					-- 개수
	oc_date datetime default now(),			-- 등록일
    constraint fk_t_order_cart_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_t_order_cart_pi_id foreign key (pi_id) references t_product_info(pi_id),
    constraint fk_t_order_cart_ps_idx foreign key (ps_idx) references t_product_stock(ps_idx)
);



-- 주문 상세정보 테이블
create table t_order_detail (
	od_idx int primary key auto_increment,	-- 일련번호
	oi_id char(14) not null,				-- 주문번호
	pi_id char(7) not null,					-- 상품ID
	ps_idx int not null,					-- 옵션별재고ID
	od_cnt int default 1,					-- 개수
	od_price int default 0,					-- 단가
	od_name varchar(50) not null,			-- 상품명
	od_img varchar(50) not null,			-- 상품이미지
	od_size int default 0,					-- 옵션명
    constraint fk_t_order_detail_oi_id foreign key (oi_id) references t_order_info(oi_id),
    constraint fk_t_order_detail_pi_id foreign key (pi_id) references t_product_info(pi_id),
    constraint fk_t_order_detail_ps_idx foreign key (ps_idx) references t_product_stock(ps_idx)
);



-- 자유게시판 테이블
create table t_free_list (
	fl_idx int primary key,				-- 글번호
	fl_ismem char(1) default 'y',		-- 회원여부
	fl_writer varchar(20) not null,		-- 작성자
	fl_title varchar(100) not null,		-- 제목
	fl_content text not null,			-- 내용
	fl_reply int default 0,				-- 댓글갯수
	fl_read int default 0,				-- 조회수
	fl_img1 varchar(50) default '',		-- 자게이미지1
	fl_img2 varchar(50) default '',		-- 자게이미지2
	fl_isview char(1) default 'y',		-- 게시여부
	fl_date datetime default now()		-- 작성일
);


-- 자유게시판 댓글 테이블
create table t_free_reply (
	fr_idx int primary key auto_increment,	-- 댓글번호
	fl_idx int not null,					-- 게시글번호
	mi_id varchar(20) not null,				-- 회원아이디
	fr_ismem char(1) default 'y',			-- 회원여부
	fr_content varchar(200) not null,		-- 내용
	fr_isview char(1) default 'y',			-- 게시여부
	fr_date datetime default now(),			-- 작성일
    constraint fk_t_free_reply_fl_idx foreign key (fl_idx) references t_free_list(fl_idx),
    constraint fk_t_member_info_mi_id foreign key (mi_id) references t_member_info(mi_id)
);



-- 공지사항 테이블
create table t_notice_list (
	nl_idx int primary key auto_increment,	-- 글번호
	ai_idx int not null,					-- 관리자번호
	nl_title varchar(50) not null,			-- 제목
	nl_content text not null,				-- 내용
	nl_date datetime default now(),			-- 작성일
	nl_isview char(1) default 'y',			-- 게시여부
    constraint fk_t_notice_list_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);


-- 문의(답변이 하나) 테이블
create table  t_qna_list (
	ql_idx int primary key auto_increment,	-- 글번호
	mi_id varchar(20)not null,				-- 회원아이디
	ql_title varchar(100) not null,			-- 질문제목
	ql_content text not null,				-- 질문내용
	ql_kind char(1) default 'q',			-- 질문유형
	ql_qdate datetime default now(),		-- 질문일자
	ql_isanswer char(1) default 'n',		-- 답변여부
	ai_idx int	default 0,					-- 답변관리자
	ql_answer text,							-- 답변내용
	ql_adate datetime default now(),		-- 답변일자
	ql_isview char(1) default 'y',			-- 게시여부
    constraint fk_t_qna_list_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_t_qna_list_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);


-- 구매후기 테이블
create table t_review_list (
	rl_idx int unique,							-- 후기번호
	mi_id varchar(20) primary key not null,		-- 회원아이디
	oi_id char(14) primary key not null,		-- 주문번호ID
	pi_id char(7) primary key not null,			-- 상품ID
	ps_idx int primary key not null,			-- 옵션별재고ID
	rl_name varchar(100) not null,				-- 상품명/옵션명
	rl_content text not null,					-- 내용
	rl_img varchar(50) default '',				-- 이미지
	rl_good char(1) default 'a',				-- 좋아요/별로에요 여부
	rl_ip varchar(15)not null,					-- IP주소
	rl_isview char(1) default 'y',				-- 게시여부
	rl_date datetime default now(),				-- 작성일
	constraint fk_t_review_list_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_t_review_list_oi_id foreign key (oi_id) references t_order_info(oi_id),
    constraint fk_t_review_list_pi_id foreign key (pi_id) references t_product_info(pi_id),
    constraint fk_t_review_list_ps_idx foreign key (ps_idx) references t_product_stock(ps_idx)
);


-- 배너 이미지 테이블
create table t_banner_list (
   ai_idx int not null,
   bl_img1 varchar(50) not null,
   bl_img2 varchar(50) default '',
   bl_img3 varchar(50) default '',   
   bl_date datetime default now(),
   constraint fk_banner_list_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);


-- 매출전표 테이블
create table t_sales_slip (
   ss_age int default 0,				-- 나이별
   ss_gender char(1) default 'a',       -- 성별
   ss_ctgrbig char(2) not null,       	-- 대분류별
   ss_auction int default 0,          	-- 옥션 매출
   ss_total int default 0,          	-- 매출액
   ss_earn int default 0,             	-- 순이익
   ss_date datetime default now()		-- 날짜
);


