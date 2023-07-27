drop database potted;
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
insert into t_admin_info (ai_id,ai_pw,ai_name) values ('admin','1234','admin');
select * from t_member_info;

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
	mi_protein int default 0,			-- 영양제갯수
	mi_status char(1) default 'a',		-- 상태 
	mi_date datetime default now(),		-- 가입일
	mi_lastlogin datetime				-- 최종 로그인
);
insert into t_member_info values ('test1', '1234', '홍길동', '남', '1975-05-24', '010-1234-1234', 'hong@naver.com', 'y', 1000, '3', 'a', now(), null);
insert into t_member_info values ('test2', '1234', '홍길동', '남', '1975-05-24', '010-1234-1234', 'hong@naver.com', 'y', 1000, '2', 'a', now(), null);
insert into t_member_info values ('test3', '1234', '홍길동', '남', '1975-05-24', '010-1234-1234', 'hong@naver.com', 'y', 1000, '0', 'a', now(), null);
select * from t_member_info;
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
select a.mi_protein, b.mt_grade, b.mt_hp, b.mt_count, b.mt_date from t_member_info a, t_member_tree b where a.mi_id = b.mi_id and b.mt_plant = 'y' and b.mi_id = 'test1';
select mt_grade, mt_date, mt_hp from t_member_tree where mi_id = 'test1' and mt_plant = 'y';
-- drop table t_member_tree;
-- 회원 식물 테이블
create table t_member_tree (
	mt_idx int primary key auto_increment,	-- 일련번호
	mi_id varchar(20) not null,				-- 회원아이디
	mt_grade int,							-- 식물등급
	mt_hp int default 10000,				-- 식물HP
	mt_plant char(1) default 'n',			-- 식물상태값
	mt_count int default 0,					-- 물준횟수
	mt_date datetime default now(),			-- 물준날짜
	mt_protein_date datetime default now(),	-- 영양제날짜    
    constraint fk_t_member_tree_mi_id foreign key(mi_id) references t_member_info(mi_id)
);
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
   pi_stock int default 0,				-- 상품 재고량
   pi_isview char(1) default 'n',		-- 게시여부
   pi_date datetime default now(),      -- 등록일
   ai_idx int not null,            		-- 등록관리자
   pi_last datetime default now(),		-- 최종 수정일
   pi_admin int default 0,				-- 최종 수정자
   constraint fk_product_info_pcb_id foreign key (pcb_id) references t_product_ctgr_big(pcb_id),
   constraint fk_product_info_pcs_id foreign key (pcs_id) references t_product_ctgr_small(pcs_id),
   constraint fk_product_info_ai_idx foreign key (ai_idx) references t_admin_info(ai_idx)
);
insert into t_product_ctgr_big (pcb_id, pcb_name) values ('AA', '다육.선인장');
insert into t_product_ctgr_big (pcb_id, pcb_name) values ('BB', '관엽식물');
insert into t_product_ctgr_big (pcb_id, pcb_name) values ('CC', '허브.채소');

insert into t_product_ctgr_small (pcs_id, pcb_id, pcs_name) values ('AAaa', 'AA', '다육');
insert into t_product_ctgr_small (pcs_id, pcb_id, pcs_name) values ('AAbb', 'AA', '선인장');
insert into t_product_ctgr_small (pcs_id, pcb_id, pcs_name) values ('BBaa', 'BB', '넝쿨.잎');
insert into t_product_ctgr_small (pcs_id, pcb_id, pcs_name) values ('BBbb', 'BB', '열매.꽃');
insert into t_product_ctgr_small (pcs_id, pcb_id, pcs_name) values ('CCaa', 'CC', '허브');
insert into t_product_ctgr_small (pcs_id, pcb_id, pcs_name) values ('CCbb', 'CC', '채소');


insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('AAbb101', 'AA', 'AAbb', '00선인장', 10000, 8000, 0, 'a', 'AAbb10101.jpg', '', 100, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('AAbb201', 'AA', 'AAbb', '11선인장', 8000, 8000, 0, 'a', 'AAbb20101.jpg', '', 0, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('AAbb301', 'AA', 'AAbb', '22선인장', 10000, 8000, 0, 'a', 'AAbb30101.jpg', '', 200, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('AAaa101', 'AA', 'AAaa', '다육다육', 5000, 2000, 0.3, 'a', 'AAaa10101.jpg', '', 100, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('AAaa201', 'AA', 'AAaa', '11다육다육', 5000, 2000, 0.6, 'a', 'AAaa20101.jpg', '', 400, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('AAaa301', 'AA', 'AAaa', '22다육다육', 5000, 2000, 0.05, 'a', 'AAaa30101.jpg', '', 0, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('BBaa101', 'BB', 'BBaa', '00넝쿨', 5000, 2000, 0.2, 'a', 'BBaa10101.jpg', '', 500, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('BBaa201', 'BB', 'BBaa', '11넝쿨', 5000, 2000, 0.2, 'a', 'BBaa20101.jpg', '', 20, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('BBaa301', 'BB', 'BBaa', '22넝쿨', 5000, 2000, 0.2, 'a', 'BBaa30101.jpg', '', 10, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('BBbb101', 'BB', 'BBbb', '00잎식물', 5000, 2000, 0.1, 'a', 'BBbb10101.jpg', '', 0, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('BBbb201', 'BB', 'BBbb', '11잎식물', 5000, 2000, 0, 'a', 'BBbb20101.jpg', '', 100, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('BBbb301', 'BB', 'BBbb', '22잎식물', 5000, 2000, 0.3, 'a', 'BBbb30101.jpg', '', 100, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('CCaa101', 'CC', 'CCaa', '00허브', 10000, 8000, 0.1, 'a', 'CCaa10101.jpg', '', 0, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('CCaa201', 'CC', 'CCaa', '11허브', 10000, 8000, 0.1, 'a', 'CCaa20101.jpg', '', 100, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('CCaa301', 'CC', 'CCaa', '22허브', 10000, 8000, 0.1, 'a', 'CCaa30101.jpg', '', 1, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('CCbb101', 'CC', 'CCbb', '00채소', 10000, 8000, 0, 'a', 'CCbb10101.jpg', '', 231, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('CCbb201', 'CC', 'CCbb', '11채소', 10000, 8000, 0, 'a', 'CCbb20101.jpg', '', 23, 'y', 1);
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx) 
values ('CCbb301', 'CC', 'CCbb', '22채소', 10000, 8000, 0.2, 'a', 'CCbb30101.jpg', '', 100, 'y', 1);

select * from t_product_info;

-- 상품 옵션 정보 테이블
create table t_product_option_info (
	poi_id char(1) primary key,		-- 옵션 대분류 코드
	poi_name varchar(20) not null	-- 옵션 대분류 이름
);

-- 상품 옵션 재고 테이블
create table t_product_option_stock (
	pos_id char(3) primary key,			-- 옵션 소분류 코드
	pos_name varchar(50) not null,		-- 옵션 소분류 이름
	poi_id char(1) not null,			-- 옵션 대분류 코드
    pi_id char(7) not null,				-- 상품 ID
	pos_stock int default 0,			-- 재고량
	pos_sale int default 0,				-- 판매량
	pos_isview char(1) default 'n',		-- 사용여부
	constraint fk_t_product_option_stock_poi_id foreign key(poi_id) references t_product_option_info(poi_id),
	constraint fk_t_product_info_pi_id foreign key(pi_id) references t_product_info(pi_id)
);

select * from t_product_option_stock;
-- 옵션상품 DB insert
insert into t_product_option_info values ('1', '분갈이');
insert into t_product_option_info values ('2', '화분');
insert into t_product_option_info values ('3', '마감돌');

insert into t_product_option_stock values ('1-1', '직접 분갈이 (분갈이+난석+깔망)', '1', 'CCaa201', 50, 0, 'y');
insert into t_product_option_stock values ('1-2', '분갈이 요청(분갈이+난석+분갈이)', '1', 'CCaa201', 100, 0, 'y');
insert into t_product_option_stock values ('2-1', '아트스톤 화분', '2', 'CCaa201', 20, 0, 'y');
insert into t_product_option_stock values ('2-2', '도자기 화분', '2', 'CCaa201', 10, 0, 'y');
insert into t_product_option_stock values ('2-3', '유약분', '2', 'CCaa201', 230, 0, 'y');
insert into t_product_option_stock values ('2-4', '토분', '2', 'CCaa201', 70, 0, 'y');
insert into t_product_option_stock values ('3-1', '마사토', '3', 'CCaa201', 500, 0, 'y');
insert into t_product_option_stock values ('3-2', '화산석', '3', 'CCaa201', 150, 0, 'y');
insert into t_product_option_stock values ('3-3', '자갈', '3', 'CCaa201', 200, 0, 'y');



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
	ps_idx int not null,					-- 옵션 소분류 코드
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
	mi_id varchar(20) not null,					-- 회원아이디
	oi_id char(14) not null,					-- 주문번호ID
	pi_id char(7) not null,						-- 상품ID
	ps_idx int not null,						-- 옵션별재고ID
	rl_name varchar(100) not null,				-- 상품명/옵션명
	rl_content text not null,					-- 내용
	rl_img varchar(50) default '',				-- 이미지
	rl_good char(1) default 'a',				-- 좋아요/별로에요 여부
	rl_ip varchar(15)not null,					-- IP주소
	rl_isview char(1) default 'y',				-- 게시여부
	rl_date datetime default now(),				-- 작성일
    constraint pk_review_list primary key (mi_id, oi_id, pi_id, ps_idx),
    constraint fk_review_list_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_review_list_oi_id foreign key (oi_id) references t_order_info(oi_id),
    constraint fk_review_list_pi_id foreign key (pi_id) references t_product_info(pi_id),
    constraint fk_review_list_ps_idx foreign key (ps_idx) references t_product_stock(ps_idx)
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



