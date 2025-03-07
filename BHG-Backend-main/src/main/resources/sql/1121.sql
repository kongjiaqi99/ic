alter table clients add column push_client_id varchar null;
alter table clients add column language int4 default 1;
alter table notification
add column title_cn VARCHAR null,
add column message_cn VARCHAR null;