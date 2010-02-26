create sequence IMAGES_SEQ;

create sequence SCHEDULES_SEQ;

create sequence USERS_SEQ;

create table CELESTIAL_OBJECTS (
 name varchar2(255) not null);

create table IMAGES (
 id number(38,0) not null,
 schedule_id number(38,0),
 image_file_name varchar2(255),
 image_content_type varchar2(255),
 image_file_size number(38,0),
 image_updated_at date,
 created_at date,
 updated_at date);

create table SCHEDULES (
 id number(38,0) not null,
 start_time date,
 exposure number(38,0),
 number_of_pictures number(38,0),
 created_at date,
 updated_at date,
 user_id number(38,0),
 area_width number(38,0),
 area_height number(38,0),
 zoom number(38,0),
 iso number(38,0),
 shutter varchar2(255),
 duration number,
 right_ascension date,
 declination number,
 object_name varchar2(255));

create table SCHEMA_MIGRATIONS (
 version varchar2(255) not null);

create table USERS (
 id number(38,0) not null,
 username varchar2(255) not null,
 email varchar2(255) not null,
 crypted_password varchar2(255) not null,
 password_salt varchar2(255) not null,
 persistence_token varchar2(255) not null,
 single_access_token varchar2(255) not null,
 perishable_token varchar2(255) not null,
 login_count number(38,0) default 0  not null,
 failed_login_count number(38,0) default 0  not null,
 last_request_at date,
 current_login_at date,
 last_login_at date,
 current_login_ip varchar2(255),
 last_login_ip varchar2(255),
 created_at date,
 updated_at date,
 is_admin number(1,0));

INSERT INTO schema_migrations (version) VALUES ('20091111011531');

INSERT INTO schema_migrations (version) VALUES ('20091111012035');

INSERT INTO schema_migrations (version) VALUES ('20091115233038');

INSERT INTO schema_migrations (version) VALUES ('20091116003024');

INSERT INTO schema_migrations (version) VALUES ('20091120230624');

INSERT INTO schema_migrations (version) VALUES ('20091120230912');

INSERT INTO schema_migrations (version) VALUES ('20091120231230');

INSERT INTO schema_migrations (version) VALUES ('20091120233825');

INSERT INTO schema_migrations (version) VALUES ('20091120233851');

INSERT INTO schema_migrations (version) VALUES ('20091120234042');

INSERT INTO schema_migrations (version) VALUES ('20091121004907');

INSERT INTO schema_migrations (version) VALUES ('20091121005320');

INSERT INTO schema_migrations (version) VALUES ('20091121031705');

INSERT INTO schema_migrations (version) VALUES ('20091122034139');

INSERT INTO schema_migrations (version) VALUES ('20091124010135');

INSERT INTO schema_migrations (version) VALUES ('20100121011112');

INSERT INTO schema_migrations (version) VALUES ('20100121012122');

INSERT INTO schema_migrations (version) VALUES ('20100125224258');

INSERT INTO schema_migrations (version) VALUES ('20100128235919');

INSERT INTO schema_migrations (version) VALUES ('20100129003137');

INSERT INTO schema_migrations (version) VALUES ('20100129003198');

INSERT INTO schema_migrations (version) VALUES ('20100208014224');

INSERT INTO schema_migrations (version) VALUES ('20100208015245');

INSERT INTO schema_migrations (version) VALUES ('20100208032123');

INSERT INTO schema_migrations (version) VALUES ('20100214002358');

INSERT INTO schema_migrations (version) VALUES ('20100214002731');

INSERT INTO schema_migrations (version) VALUES ('20100214004007');