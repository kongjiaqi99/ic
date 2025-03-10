alter table investment_entities add column ic_id varchar null,
add column email_list _varchar NULL,
add column address_line varchar NULL,
add column suburb varchar NULL,
add column state varchar NULL,
add column postcode varchar NULL,
add column application_form_signed varchar null,
add column is_client boolean null default false;

alter table enquiries add column status varchar null default 'NEW';
alter table investment_entities add column status varchar null default 'NORMAL';
alter table clients  add column status varchar null default 'NORMAL';

CREATE TABLE IF NOT EXISTS audit (
    id serial PRIMARY KEY,
    audit_type VARCHAR(50) null default 'Client Update',
    entity_content jsonb NULL DEFAULT '{}'::jsonb,
    entity_id int8 null default 1,
    entity_name VARCHAR(50) null,
    new_entity jsonb NULL DEFAULT '{}'::jsonb,
    created_at timestamp(6) NOT null default CURRENT_TIMESTAMP,
	updated_at timestamp(6) NOT null default CURRENT_TIMESTAMP,
    status VARCHAR(50) null default 'Pending approval',
	creator int8 null default 1,
	creator_name VARCHAR(50) null default 'system',
	approver int8 null default 1,
	approver_name VARCHAR(50) null default 'system'
);

alter table events
add column status varchar null default 'Upcoming',
add column link varchar NULL,
add column file_url varchar NULL,
add column type varchar null default 'Online';

CREATE TABLE IF NOT EXISTS notification (
    id serial PRIMARY KEY,
    client_id_arr _int4 NULL,
    client_name_arr _varchar NULL,
    is_all boolean null default false,
    title VARCHAR null,
    message VARCHAR null,
    created_at timestamp(6) NOT null default CURRENT_TIMESTAMP,
	updated_at timestamp(6) NOT null default CURRENT_TIMESTAMP,
    status VARCHAR(50) null default 'NEW',
	creator int8 null default 1
);

alter table notification add column client_id_arr _int4 NULL,
   add column client_name_arr _varchar null;

alter table financings add column entity_id int8 null;

CREATE TABLE finance_reference (
	id serial PRIMARY KEY,
	level int NOT NULL,
	finance_id int8 NOT NULL,
	client_id int8 NOT NULL,
	entity_id int8 NOT null,
	parent_id int8 NULL DEFAULT 0,
	created_at timestamp(6) NOT null default CURRENT_TIMESTAMP,
	updated_at timestamp(6) NOT null default CURRENT_TIMESTAMP
);

ALTER TABLE public.investment_entities ALTER COLUMN created_at SET DEFAULT now();
ALTER TABLE public.investment_entities ALTER COLUMN updated_at SET DEFAULT now();

alter table funds add column cover varchar;
alter table funds add column cover_cn varchar;
--字典初始化
insert into "dictionary" (type, code, value, sort) values
('investment_entity_type','trust',6,6),
('investment_entity_type','superannuation fund',7,7);

update dictionary set del_flag =true where "type" = 'investment_entity_type' and value in ('2','3','4','5');

--entity初始化
--insert into investment_entities(client_id, email_list, entity_name, ic_id, entity_type, is_client, created_at, updated_at)
--select id,ARRAY[email], name, beaver_id, invest_entity, true, now(),now()  from clients c where del_flag  = false;

update investment_entities ie set
email_list = array[c.email],
ic_id = c.beaver_id ,
is_client = true
from clients c
where c.id = ie.client_id
and c.del_flag = false
and c.id in (select client_id from
(select client_id,count(id)  count_id from investment_entities where del_flag = false group by client_id )
t where t.count_id =1 );
insert into investment_entities(client_id, email_list, entity_name, ic_id, entity_type, is_client, created_at, updated_at)
select id,ARRAY[email], name, beaver_id, invest_entity, true, now(),now()  from clients c
where del_flag  =  false and c.id  not in (select c.id  from clients c inner join investment_entities ie on c.id = ie.client_id);

--购买记录初始化
--insert into purchased_funds(id, investment_entity_id, updated_at, created_at)
--(select pf.id, ie.id as investment_entity_id, now(), now() from purchased_funds pf
--left join investment_entities ie on ie.client_id = pf.client_id
--where pf.del_flag = false and ie.is_client = true)
--on CONFLICT (id)
--DO
-- UPDATE
--   SET investment_entity_id = EXCLUDED.investment_entity_id;

update purchased_funds
set investment_entity_id = investment_entities.id
from investment_entities
where purchased_funds.client_id  = investment_entities.client_id
and investment_entities.is_client = true
and purchased_funds.investment_entity_id is null;

update investment_entities ie set
address_line = pf.address_line,
suburb = pf.suburb,
state = pf.state,
postcode = pf.postcode
from purchased_funds pf
 where pf.investment_entity_id = ie.id
 and ie.address_line is null
 and pf.id in (select max(id) from purchased_funds where address_line is not null group by investment_entity_id );

--记账初始化
--insert into financings(id, entity_id, created_at, updated_at)
--(select f.id,ie.id as entity_id,now(),now()  from financings f
--left join investment_entities ie on f.client_id = ie.client_id
--where ie.is_client = true and f.del_flag = false)
--on CONFLICT (id)
--DO
-- UPDATE
--  SET entity_id = EXCLUDED.entity_id;
update financings
set entity_id = investment_entities.id
from investment_entities
where financings.client_id  = investment_entities.client_id
and investment_entities.is_client = true
and financings.entity_id is null;

insert into finance_reference(level, finance_id, client_id, entity_id, parent_id)
select
2,f.id,c.id,ie.id,0
       END  from financings f
inner join clients c on c.upper_client_id = f.client_id
inner join investment_entities ie on ie.client_id = c.id
where ie.is_client = true and f.del_flag = false and c.level_two_upper_client_id is null;

insert into finance_reference(level, finance_id, client_id, entity_id, parent_id)
select 3, f.id, c.id, ie.id, fr.id from financings f
inner join finance_reference fr on f.id = fr.finance_id
inner join clients c on c.level_two_upper_client_id = fr.client_id
inner join investment_entities ie on ie.client_id = c.id
where fr.level = 2 and ie.is_client = true and f.del_flag = false;

insert into finance_reference(level, finance_id, client_id, entity_id, parent_id)
select
2,f.id,c.id,ie.id,0  from financings f
inner join clients c on c.level_two_upper_client_id  = f.client_id
inner join investment_entities ie on ie.client_id = c.id
where ie.is_client = true and f.del_flag = false;

update funds set language = 1 where language is null;
ALTER TABLE funds ALTER COLUMN language SET DEFAULT 1;

alter table clients  add column read_time timestamp(6) null;

CREATE TABLE IF NOT EXISTS investment_entities_kyc (
    id serial PRIMARY KEY,
    client_id int8 NOT NULL,
	entity_type int4 NULL,
	kyc_result bool NULL DEFAULT false,
	entity_name varchar NULL,
	created_at timestamp(6) NOT NULL DEFAULT now(),
	updated_at timestamp(6) NOT NULL DEFAULT now(),
	bsb varchar NULL,
	account_number varchar NULL,
	account_name varchar NULL,
	file_1_front varchar NULL,
	file_1_back varchar NULL,
	file_2_front varchar NULL,
	file_2_back varchar NULL,
	detail_info jsonb NULL DEFAULT '{}'::jsonb,
	kyc_status int4 NULL,
	del_flag bool NOT NULL DEFAULT false,
	transcation_id varchar NULL
);

--字典初始化
insert into "dictionary" (type, code, value, sort) values
('enquiry_type','general',1,1),
('enquiry_type','investment',2,2),
('enquiry_type','borrow',3,3);

alter table enquiries  add column type int4 null default 1;

alter table enquiries add column fund_id int8 null,
add column investor_type int4 NULL,
add column investment_term int4 NULL,
add column investment_amount numeric(10, 2) NULL,
add column guarantor varchar NULL,
add column acn varchar NULL,
add column borrow_type varchar NULL,
add column borrow_purpose varchar NULL,
add column borrow_term int4 NULL,
add column borrow_amount varchar NULL,
add column borrow_date timestamp(6) NULL,
add column borrow_primary varchar NULL,
add column borrow_secondary varchar NULL,
add column borrow_tertiary varchar NULL,
add column borrow_additional varchar null;



CREATE TABLE IF NOT EXISTS borrow_proposed_security (
    id serial PRIMARY KEY,
    enquiry_id int8 NOT NULL,
	owner_name varchar NULL,
	house_type varchar NULL,
	loan_purpose varchar NULL,
	land_area varchar NULL,
	est_value varchar NULL,
	valuation_date timestamp(6) NULL,
	valuation_entity varchar NULL,
	security_status varchar NULL,
	borrow_amount varchar NULL,
	lender_name varchar NULL,
	in_arrears varchar NULL,
	reason varchar NULL
);
alter table notification  add column file varchar null;

UPDATE public.funds SET  cover='1723538900775989248.jpg', cover_cn=NULL where id=14;
UPDATE public.funds SET  cover='1723539078618673152.jpg', cover_cn=NULL where id=9;
UPDATE public.funds SET  cover=NULL, cover_cn='1724291349564473344.png' where id=2;
UPDATE public.funds SET  cover='1724291156324499456.png', cover_cn=NULL where id=30;
UPDATE public.funds SET  cover='1724290625120092160.png', cover_cn=NULL where id=33;
UPDATE public.funds SET  cover='1724284405793550336.png', cover_cn=NULL where id=29;
UPDATE public.funds SET  cover='1724284333156593664.png', cover_cn=NULL where id=28;
UPDATE public.funds SET  cover='1724284209059721216.png', cover_cn=NULL where id=18;
UPDATE public.funds SET  cover='1724290750550753280.png', cover_cn=NULL where id=32;
UPDATE public.funds SET  cover='1724284898259365888.png', cover_cn=NULL where id=37;
UPDATE public.funds SET  cover='1724284980249620480.png', cover_cn=NULL where id=39;
UPDATE public.funds SET  cover='1723536673994829824.png', cover_cn=NULL where id=43;
UPDATE public.funds SET  cover='1724289711583903744.png', cover_cn=NULL where id=78;
UPDATE public.funds SET  cover='1724289813979447296.png', cover_cn=NULL where id=69;
UPDATE public.funds SET  cover='1724289433866452992.png', cover_cn=NULL where id=84;
UPDATE public.funds SET  cover='1724286167325732864.png', cover_cn=NULL where id=76;
UPDATE public.funds SET  cover='1724289485523501056.png', cover_cn=NULL where id=83;
UPDATE public.funds SET  cover='1724285854367739904.png', cover_cn=NULL where id=74;
UPDATE public.funds SET  cover='1724289567748636672.png', cover_cn=NULL where id=80;
UPDATE public.funds SET  cover='1724289643929780224.png', cover_cn=NULL where id=79;
UPDATE public.funds SET  cover='1724285661975015424.png', cover_cn=NULL where id=70;
UPDATE public.funds SET  cover='1724286042394193920.png', cover_cn=NULL where id=75;
UPDATE public.funds SET  cover='1724289334323036160.png', cover_cn=NULL where id=86;
UPDATE public.funds SET  cover='1724284486865252352.png', cover_cn=NULL where id=34;
UPDATE public.funds SET  cover='1723538989430992896.jpg', cover_cn=NULL where id=11;
UPDATE public.funds SET  cover='1724290911280676864.png', cover_cn=NULL where id=31;
UPDATE public.funds SET  cover='1724284288550170624.png', cover_cn=NULL where id=27;
UPDATE public.funds SET  cover='1724289383664828416.png', cover_cn=NULL where id=85;
UPDATE public.funds SET  cover='1723534018765516800.jpg', cover_cn=NULL where id=90;
UPDATE public.funds SET  cover='1724291864725667840.png', cover_cn=NULL where id=89;
UPDATE public.funds SET  cover='1723533745665994752.png', cover_cn=NULL where id=93;
UPDATE public.funds SET  cover='1723533684856975360.png', cover_cn=NULL where id=94;
UPDATE public.funds SET  cover='1724288927274221568.png', cover_cn=NULL where id=103;
UPDATE public.funds SET  cover='1724289003291787264.png', cover_cn=NULL where id=102;
UPDATE public.funds SET  cover='1724289217637498880.png', cover_cn=NULL where id=97;
UPDATE public.funds SET  cover='1723519628548894720.png', cover_cn=NULL where id=108;
UPDATE public.funds SET  cover='1723536593384501248.jpg', cover_cn=NULL where id=44;
UPDATE public.funds SET  cover='1724288815516991488.png', cover_cn=NULL where id=105;
UPDATE public.funds SET  cover='1724289878114549760.png', cover_cn=NULL where id=45;
UPDATE public.funds SET  cover='1724288759581753344.png', cover_cn=NULL where id=106;
UPDATE public.funds SET  cover='1724288864468713472.png', cover_cn=NULL where id=104;
UPDATE public.funds SET  cover=NULL, cover_cn='1724289110586277888.png' where id=99;
UPDATE public.funds SET  cover='1724285737640259584.png', cover_cn=NULL where id=72;
UPDATE public.funds SET  cover='1724285797807550464.png', cover_cn=NULL where id=73;
UPDATE public.funds SET  cover='1724289755028504576.png', cover_cn=NULL where id=77;
UPDATE public.funds SET  cover='1724290401127481344.png', cover_cn=NULL where id=92;
UPDATE public.funds SET  cover='1724285047769526272.png', cover_cn=NULL where id=40;
UPDATE public.funds SET  cover=NULL, cover_cn='1724283396216188928.png' where id=15;
UPDATE public.funds SET  cover='1724284842445762560.png', cover_cn=NULL where id=38;
UPDATE public.funds SET  cover='1724285139545092096.png', cover_cn=NULL where id=41;
UPDATE public.funds SET  cover='1724285532526211072.png', cover_cn=NULL where id=42;
UPDATE public.funds SET  cover='1724289057717075968.png', cover_cn=NULL where id=100;
UPDATE public.funds SET  cover='1724289171613401088.png', cover_cn=NULL where id=98;

update investment_entities ie set
bsb  = c.bsb ,
account_number  = c.account_number  ,
account_name  = c.account_name
from clients  c
 where c.id = ie.client_id
 and ie.bsb is null
 and ie.account_number is null
 and ie.account_name is null
 and ie.del_flag = false
;
