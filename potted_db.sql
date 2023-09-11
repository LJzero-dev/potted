-- drop database potted;
create database potted;
use potted;
show tables;

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
select * from t_admin_info;

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
insert into t_member_info values ('test4', '1234', '김길동', '남', '1975-05-24', '010-1234-1234', 'hong@naver.com', 'y', 1000, '0', 'a', now(), null);
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

insert into t_member_addr (mi_id, ma_name, ma_rname, ma_phone, ma_zip, ma_addr1, ma_addr2) values ('test1', '집주소', '홍길동', '010-1111-3333', '12345', '부산시 연제구 연산동', '987-654');
insert into t_member_addr values (2, 'test1', '회사', '홍길순', '010-1111-1111', '23537', '서울시 강남구 역삼동', '63층 101호', 'n', now());

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
	mp_detail varchar(20) default '',		-- 내역상세				
	mp_date datetime default now(),			-- 사용/적립일
	mp_admin int default 0,					-- 관리자번호
	constraint fk_t_member_point_mi_id foreign key(mi_id) references t_member_info(mi_id)
);
select * from t_member_point;
insert into t_member_point (mi_id, mp_su, mp_point, mp_desc, mp_detail, mp_admin) values ('test1', 'a', 1000, '회원 가입 축하 포인트', '회원 가입 축하 포인트', 1);

-- 상품 대분류 테이블
create table t_product_ctgr_big (
   pcb_id char(2) primary key,      -- 대분류 코드
   pcb_name varchar(20) not null    -- 대분류 이름
);


-- 상품 분류 테이블
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
   pi_auction char(1) default 'n',		-- 경매 여부
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
update t_product_info set pi_price = 30000 where pcb_id ='CC';


insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('AAbb111', 'AA', 'AAbb', '00선인장', 10000, 8000, 0, 'a', 'AAbb10101.jpg', '', 100, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('AAbb211', 'AA', 'AAbb', '11선인장', 8000, 8000, 0, 'a', 'AAbb20101.jpg', '', 0, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('AAbb311', 'AA', 'AAbb', '22선인장', 10000, 8000, 0, 'a', 'AAbb30101.jpg', '', 200, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('AAaa111', 'AA', 'AAaa', '다육다육', 5000, 2000, 0.3, 'a', 'AAaa10101.jpg', '', 100, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('AAaa211', 'AA', 'AAaa', '11다육다육', 5000, 2000, 0.6, 'a', 'AAaa20101.jpg', '', 400, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('AAaa311', 'AA', 'AAaa', '22다육다육', 5000, 2000, 0.05, 'a', 'AAaa30101.jpg', '', 0, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('BBaa111', 'BB', 'BBaa', '00넝쿨', 5000, 2000, 0.2, 'a', 'BBaa10101.jpg', '', 500, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('BBaa211', 'BB', 'BBaa', '11넝쿨', 5000, 2000, 0.2, 'a', 'BBaa20101.jpg', '', 20, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('BBaa311', 'BB', 'BBaa', '22넝쿨', 5000, 2000, 0.2, 'a', 'BBaa30101.jpg', '', 10, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('BBbb111', 'BB', 'BBbb', '00잎식물', 5000, 2000, 0.1, 'a', 'BBbb10101.jpg', '', 0, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('BBbb211', 'BB', 'BBbb', '11잎식물', 5000, 2000, 0, 'a', 'BBbb20101.jpg', '', 100, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('BBbb311', 'BB', 'BBbb', '22잎식물', 5000, 2000, 0.3, 'a', 'BBbb30101.jpg', '', 100, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('CCaa111', 'CC', 'CCaa', '00허브', 10000, 8000, 0.1, 'a', 'CCaa10101.jpg', '', 0, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('CCaa211', 'CC', 'CCaa', '11허브', 10000, 8000, 0.1, 'a', 'CCaa20101.jpg', '', 100, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('CCaa311', 'CC', 'CCaa', '22허브', 10000, 8000, 0.1, 'a', 'CCaa30101.jpg', '', 1, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('CCbb111', 'CC', 'CCbb', '00채소', 10000, 8000, 0, 'a', 'CCbb10101.jpg', '', 231, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('CCbb211', 'CC', 'CCbb', '11채소', 10000, 8000, 0, 'a', 'CCbb20101.jpg', '', 23, 'y', 1, 'y');
insert into t_product_info(pi_id, pcb_id, pcs_id, pi_name, pi_price, pi_cost, pi_dc, pi_status, pi_img1, pi_desc, pi_stock, pi_isview, ai_idx, pi_auction) values ('CCbb311', 'CC', 'CCbb', '22채소', 10000, 8000, 0.2, 'a', 'CCbb30101.jpg', '', 100, 'y', 1, 'y');

select * from t_product_info;

-- 상품 옵션 대분류 테이블
create table t_product_option_big (
	pob_id varchar(10) primary key		-- 옵션 대분류 코드
);
-- drop table t_product_option_stock;
-- 상품 옵션 재고 테이블
create table t_product_option_stock (
	pos_idx int unique auto_increment,
	pos_id varchar(50) not null,		-- 옵션 소분류 코드
	pob_id varchar(10) not null,		-- 옵션 대분류 코드
    pi_id char(7) not null,				-- 상품 ID
    pos_price int default 0,			-- 옵션 상품 가격
	pos_stock int default 0,			-- 재고량
	pos_sale int default 0,				-- 판매량
	pos_isview char(1) default 'n',		-- 사용여부
    constraint pk_t_product_option_stock primary key (pos_id, pi_id),
	constraint fk_t_product_info_pi_id foreign key(pi_id) references t_product_info(pi_id),
	constraint fk_t_product_option_big_pob_id foreign key(pob_id) references t_product_option_big(pob_id)
);

select * from t_product_option_stock;

insert into t_product_option_big values ('1.분갈이');
insert into t_product_option_big values ('2.화분');
insert into t_product_option_big values ('3.마감돌');
insert into t_product_option_big values ('없음');

insert into t_product_option_stock values (1, '1-1.직접 분갈이 (분갈이+난석+깔망)', '1.분갈이', 'CCaa201',3000 , 50, 0, 'y');
insert into t_product_option_stock values (2, '1-2.분갈이 요청(분갈이+난석+분갈이)', '1.분갈이', 'CCaa201',5000 , 100, 0, 'y');
insert into t_product_option_stock values (3, '2-1.아트스톤 화분', '2.화분', 'CCaa201',7000, 20, 0, 'y');
insert into t_product_option_stock values (4, '2-2.도자기 화분', '2.화분', 'CCaa201',10000, 10, 0, 'y');
insert into t_product_option_stock values (5, '2-3.유약분', '2.화분', 'CCaa201',4600, 230, 0, 'y');
insert into t_product_option_stock values (6, '2-4.토분', '2.화분', 'CCaa201',6700, 70, 0, 'y');
insert into t_product_option_stock values (7, '3-1.마사토', '3.마감돌', 'CCaa201',8000, 500, 0, 'y');
insert into t_product_option_stock values (8, '3-2.화산석', '3.마감돌', 'CCaa201',5000, 150, 0, 'y');
insert into t_product_option_stock values (9, '3-3:자갈', '3.마감돌', 'CCaa201',9000, 200, 0, 'y');


-- 주문정보 테이블
create table t_order_info (
	oi_id char(15) primary key,			-- 주문정보
	mi_id varchar(20) not null,			-- 회원아이디
    pi_id char(7) not null,				-- 상품ID
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
    oi_apoint int default 0,			-- 적립포인트
	oi_spoint varchar(50) default '',	-- 송장번호
	oi_status char(1) default 'a',		-- 주문상태
	oi_date datetime default now(),		-- 주문일
    oi_cnt int default 0,				-- 상품 수량
    constraint fk_t_order_info_pi_id foreign key (pi_id) references t_product_info(pi_id),
	constraint fk_t_order_info_mi_id foreign key(mi_id) references t_member_info(mi_id)
);

select * from t_order_info;

-- 장바구니 테이블
create table t_order_cart (
	oc_idx int primary key auto_increment,	-- 일련번호
	mi_id varchar(20) not null,				-- 회원아이디
	pi_id char(7) not null,					-- 상품ID
    oc_option varchar(100) not null,		-- 옵션 
	oc_cnt int default 1,					-- 개수
	oc_date datetime default now(),			-- 등록일
    oc_price int default 0,					-- 상품+옵션 가격
    first_cnt int default 0, 				-- 사용자가 처음선택한 상품 수량
    constraint fk_t_order_cart_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_t_order_cart_pi_id foreign key (pi_id) references t_product_info(pi_id)
);

select * from t_order_cart;



-- drop table t_order_detail;

-- 주문 상세정보 테이블
create table t_order_detail (
	od_idx int primary key auto_increment,	-- 일련번호
	oi_id char(15) not null,				-- 주문번호
	pi_id char(7) not null,					-- 상품ID
    od_option varchar(100) not null,		-- 옵션 
	od_cnt int default 1,					-- 개수
	od_price int default 0,					-- 단가
	od_name varchar(50) not null,			-- 상품명
	od_img varchar(50) not null,			-- 상품이미지
    constraint fk_t_order_detail_oi_id foreign key (oi_id) references t_order_info(oi_id),
    constraint fk_t_order_detail_pi_id foreign key (pi_id) references t_product_info(pi_id)
);


-- 자유게시판 테이블
create table t_free_list (
	fl_idx int primary key auto_increment,	-- 글번호
	fl_ismem char(1) default 'y',			-- 회원여부
	fl_writer varchar(20) not null,			-- 작성자
	fl_title varchar(100) not null,			-- 제목
	fl_content text not null,				-- 내용
	fl_reply int default 0,					-- 댓글갯수
	fl_read int default 0,					-- 조회수
	fl_img1 varchar(50) default '',			-- 자게이미지1
	fl_img2 varchar(50) default '',			-- 자게이미지2
	fl_isview char(1) default 'y',			-- 게시여부
	fl_date datetime default now()			-- 작성일
);

select * from t_free_list;
insert into t_free_list values('1', 'y', '홍길동', '자유게시판 글1', '자유게시판 내용1', 0, 0, null, null, 'y', '2023-06-12');
insert into t_free_list values(null, 'y', '전우치', '자유게시판 글2', '자유게시판 내용2', 0, 0, null, null, 'y', '2023-06-15');
insert into t_free_list values(null, 'y', '유관순', '자유게시판 글3', '자유게시판 내용3', 0, 0, null, null, 'y', '2023-06-16');
insert into t_free_list values(null, 'y', '임꺽정', '자유게시판 글4', '자유게시판 내용4', 0, 0, null, null, 'y', '2023-06-18');
insert into t_free_list values(null, 'y', '아무개', '자유게시판 글5', '자유게시판 내용5', 0, 0, null, null, 'y', '2023-06-20');
insert into t_free_list values(null, 'y', '신호진', '자유게시판 글6', '자유게시판 내용6', 0, 0, null, null, 'y', '2023-06-21');
insert into t_free_list values(null, 'y', '김철수', '자유게시판 글7', '자유게시판 내용7', 0, 0, null, null, 'y', '2023-06-21');
insert into t_free_list values(null, 'y', '이영미', '자유게시판 글8', '자유게시판 내용8', 0, 0, null, null, 'y', '2023-06-23');
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글9', '자유게시판 내용9', 0, 0, null, null, 'y', '2023-07-02');
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글10', '자유게시판 내용10', 0, 0, null, null, 'y', '2023-07-02');
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글11', '자유게시판 내용11', 0, 0, null, null, 'y', '2023-07-03');
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글12', '자유게시판 내용12', 0, 0, null, null, 'y', '2023-07-12');
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글13', '자유게시판 내용13', 0, 0, null, null, 'y', '2023-07-15');
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글14', '자유게시판 내용14', 0, 0, null, null, 'y', now());
insert into t_free_list values(null, 'y', '홍길동', '자유게시판 글14', '자유게시판 내용14', 0, 0, null, null, 'y', now());


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

insert into t_notice_list values (null, 1, 'potted 개설', 'potted 오픈!', '2023-06-25', 'y');
insert into t_notice_list values (null, 1, '옥션관련 공지사항', '욕션 공지', '2023-07-20', 'y');
insert into t_notice_list values (null, 1, '자유게시판 관련 공지사항', '자유게시판', '2023-07-11', 'y');
insert into t_notice_list values (null, 1, 'My plants관련 공지사항', '식물 키우기', '2023-07-12', 'y');
insert into t_notice_list values (null, 1, 'Store 이용안내', '많이 사줘', '2023-07-15', 'y');
insert into t_notice_list values (null, 1, '신규 옥션 물품 업데이트 안내', '신규 옥션 물품', '2023-07-18', 'y');
insert into t_notice_list values (null, 1, '홈페이지 긴급점검 안내', '홈페이지 긴급 점검', '2023-07-20', 'y');
insert into t_notice_list values (null, 1, '배송 문의관련 안내', '로켓배송', '2023-07-21', 'y');
insert into t_notice_list values (null, 1, '신고 정지 회원 안내', '너넨 다 정지', '2023-07-22', 'y');
insert into t_notice_list values (null, 1, 'point 관련 안내', '님 포 몇?', '2023-07-24', 'y');
insert into t_notice_list values (null, 1, '식물 검색 주의사항', '필터를 잘 활용해보아요', '2023-07-27', 'y');


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
	rl_idx int primary key auto_increment,		-- 후기번호
	mi_id varchar(20) not null,					-- 회원아이디
	oi_id char(15) not null,					-- 주문번호ID
	pi_id char(7) not null,						-- 상품ID
	rl_name varchar(100) not null,				-- 상품명/옵션명
	rl_content text not null,					-- 내용
	rl_img varchar(50) default '',				-- 이미지
	rl_good char(1) default 'a',				-- 좋아요/별로에요 여부
	rl_ip varchar(15)not null,					-- IP주소
	rl_isview char(1) default 'y',				-- 게시여부
	rl_date datetime default now(),				-- 작성일
    constraint fk_review_list_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_review_list_oi_id foreign key (oi_id) references t_order_info(oi_id),
    constraint fk_review_list_pi_id foreign key (pi_id) references t_product_info(pi_id)
);

-- 배너 이미지 테이블
create table t_banner_list (
   ai_idx int not null,
   bl_img1 varchar(50) not null,
   bl_img2 varchar(50) default '',
   bl_img3 varchar(50) default '',   
   bl_img4 varchar(50) default '',   
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

-- drop table t_product_auction_info;

insert into t_product_auction_info values (null, 'AAbb111', 1, 51000, '00:02:30', now(), 'test1');
insert into t_product_auction_info values (null, 'AAbb211', 1, 51000, '00:00:00', now(), 'test1');
insert into t_product_auction_info values (null, 'AAbb311', 2, 41000, '03:02:30', now(), 'test1');
insert into t_product_auction_info values (null, 'AAaa111', 3, 17000, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'AAaa211', 4, 10200, '03:02:30', now(), 'test1');
insert into t_product_auction_info values (null, 'AAaa311', 4, 10030, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'BBaa111', 5, 10700, '03:02:30', now(), 'test1');
insert into t_product_auction_info values (null, 'BBaa211', 6, 10500, '01:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'BBaa311', 7, 107000, '00:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'BBbb111', 5, 10200, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'BBbb211', 3, 10050, '03:02:30', now(), 'test1');
insert into t_product_auction_info values (null, 'BBbb311', 3, 10100, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'CCaa111', 2, 101200, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'CCaa211', 0, 8120100, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'CCaa311', 0, 1720200, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'CCbb111', 0, 1220300, '03:02:00', now(), 'test1');
insert into t_product_auction_info values (null, 'CCbb211', 2, 1000, '03:02:10', now(), 'test1');
insert into t_product_auction_info values (null, 'CCbb311', 1, 1000, '03:02:00', now(), 'test1');
select * from t_product_info;

update t_product_auction_info set pai_runtime = '00:00:00' where pI_id = "CCbb211";
select * from t_product_auction_info;

create table t_product_auction_info(
pai_idx	int auto_increment primary key,			-- 일련번호
pi_id char(7),						-- 상품ID
pai_bidder int default 0,			-- 입찰 수
pai_price int default 0,			-- 현재가
pai_runtime char(8) not null,		-- 경매 진행시간
pai_start datetime,					-- 경매 시작시간
pai_id varchar(20),					-- 입찰자 or 낙찰자
constraint fk_product_auction_info foreign key (pi_id) references t_product_info(pi_id)
);

-- 입찰자 테이블
create table t_auction_bidder_info(
	abi_idx	int auto_increment primary key,		-- 일련번호
    pi_id char(7),								-- 상품ID
    mi_id varchar(20),							-- 입찰자
    abi_price int default 0,					-- 입찰 금액
    pai_date datetime default now(),			-- 입찰 시간
    constraint fk_auction_bidder_info_mi_id foreign key (mi_id) references t_member_info(mi_id),
    constraint fk_auction_bidder_info_pi_id foreign key (pi_id) references t_product_info(pi_id)
);

insert into t_auction_bidder_info (pi_id,mi_id,abi_price) values ('CCbb211','test1','100000');

-- 일정관리 테이블
create table t_schedule_info (
	si_idx int primary key auto_increment,		-- 일련번호
	ai_id varchar(20) not null,					-- 관리자ID
	si_date char(10) not null,					-- 일정 일자
	si_time char(5)	not null, 					-- 일정 종료일
	si_title varchar(50) not null,                -- 일정 제목
	si_content varchar(200) not null,			-- 일정 내용
	si_regdate datetime default now(),			-- 등록일
    si_isview char(1) default 'y',                -- 게시여부
	constraint fk_schedule_info_ai_id foreign key (ai_id) references t_admin_info(ai_id)
);

-- 농원 정보 테이블 
create table t_garden_info (
	gi_idx int primary key auto_increment,	-- 일련번호
	gi_name varchar(50) not null,			-- 농원이름
	gi_location varchar(100) not null, 		-- 농원 위치
	gi_link varchar(200) default 'n',		-- 농원 사이트 링크
	gi_content varchar(500) not null, 		-- 농원 설명
	gi_date datetime default now()			-- 등록 일자
);
