/* SCHEMA ANIME */
-- anime.tb_anime definition

-- Drop table

-- DROP TABLE anime.tb_anime;

CREATE TABLE anime.tb_anime (
	id serial4 NOT NULL,
	id_jikan int4 NOT NULL,
	title varchar(200) NOT NULL,
	"source" varchar(100) NOT NULL,
	status varchar(50) NOT NULL,
	age_rating varchar(50) NULL,
	synopsys varchar(5000) NULL,
	episodes int4 NULL,
	release_year int4 NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_anime_title ON anime.tb_anime USING btree (title);

-- Permissions

ALTER TABLE anime.tb_anime OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime TO taboada;
GRANT ALL ON TABLE anime.tb_anime TO desenvolvimento;


-- anime.tb_config_parameter definition

-- Drop table

-- DROP TABLE anime.tb_config_parameter;

CREATE TABLE anime.tb_config_parameter (
	id serial4 NOT NULL,
	"key" varchar NOT NULL,
	value varchar NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_config_parameter_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE anime.tb_config_parameter OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_config_parameter TO taboada;
GRANT ALL ON TABLE anime.tb_config_parameter TO desenvolvimento;


-- anime.tb_demographic definition

-- Drop table

-- DROP TABLE anime.tb_demographic;

CREATE TABLE anime.tb_demographic (
	id serial4 NOT NULL,
	"name" varchar(50) NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_demographic_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_demographic_title ON anime.tb_demographic USING btree (name);

-- Permissions

ALTER TABLE anime.tb_demographic OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_demographic TO taboada;
GRANT ALL ON TABLE anime.tb_demographic TO desenvolvimento;


-- anime.tb_genre definition

-- Drop table

-- DROP TABLE anime.tb_genre;

CREATE TABLE anime.tb_genre (
	id serial4 NOT NULL,
	"name" varchar(50) NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_genre_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_genre_title ON anime.tb_genre USING btree (name);

-- Permissions

ALTER TABLE anime.tb_genre OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_genre TO taboada;
GRANT ALL ON TABLE anime.tb_genre TO desenvolvimento;


-- anime.tb_legal_document definition

-- Drop table

-- DROP TABLE anime.tb_legal_document;

CREATE TABLE anime.tb_legal_document (
	id serial4 NOT NULL,
	document_type varchar(50) NOT NULL,
	document_text text NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_legal_document_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE anime.tb_legal_document OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_legal_document TO taboada;
GRANT ALL ON TABLE anime.tb_legal_document TO desenvolvimento;


-- anime.tb_streaming definition

-- Drop table

-- DROP TABLE anime.tb_streaming;

CREATE TABLE anime.tb_streaming (
	id serial4 NOT NULL,
	"name" varchar NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_streaming_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE anime.tb_streaming OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_streaming TO taboada;
GRANT ALL ON TABLE anime.tb_streaming TO desenvolvimento;


-- anime.tb_studio definition

-- Drop table

-- DROP TABLE anime.tb_studio;

CREATE TABLE anime.tb_studio (
	id serial4 NOT NULL,
	"name" varchar(50) NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_studio_pkey PRIMARY KEY (id)
);
CREATE INDEX idx_studio_title ON anime.tb_studio USING btree (name);

-- Permissions

ALTER TABLE anime.tb_studio OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_studio TO taboada;
GRANT ALL ON TABLE anime.tb_studio TO desenvolvimento;


-- anime.tb_theme definition

-- Drop table

-- DROP TABLE anime.tb_theme;

CREATE TABLE anime.tb_theme (
	id serial4 NOT NULL,
	"name" varchar(50) NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_theme_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE anime.tb_theme OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_theme TO taboada;
GRANT ALL ON TABLE anime.tb_theme TO desenvolvimento;


-- anime.tb_anime_demographic definition

-- Drop table

-- DROP TABLE anime.tb_anime_demographic;

CREATE TABLE anime.tb_anime_demographic (
	id_anime int4 NOT NULL,
	id_demographic int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_demographic_pkey PRIMARY KEY (id_anime, id_demographic),
	CONSTRAINT tb_anime_demographic_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id),
	CONSTRAINT tb_anime_demographic_id_demographic_fkey FOREIGN KEY (id_demographic) REFERENCES anime.tb_demographic(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_demographic OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_demographic TO taboada;
GRANT ALL ON TABLE anime.tb_anime_demographic TO desenvolvimento;


-- anime.tb_anime_genre definition

-- Drop table

-- DROP TABLE anime.tb_anime_genre;

CREATE TABLE anime.tb_anime_genre (
	id_anime int4 NOT NULL,
	id_genre int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_genre_pkey PRIMARY KEY (id_anime, id_genre),
	CONSTRAINT tb_anime_genre_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id),
	CONSTRAINT tb_anime_genre_id_genre_fkey FOREIGN KEY (id_genre) REFERENCES anime.tb_genre(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_genre OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_genre TO taboada;
GRANT ALL ON TABLE anime.tb_anime_genre TO desenvolvimento;


-- anime.tb_anime_image definition

-- Drop table

-- DROP TABLE anime.tb_anime_image;

CREATE TABLE anime.tb_anime_image (
	id_anime int4 NOT NULL,
	image_url varchar NULL,
	small_image_url varchar NULL,
	large_image_url varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_image_pkey PRIMARY KEY (id_anime),
	CONSTRAINT tb_anime_image_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_image OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_image TO taboada;
GRANT ALL ON TABLE anime.tb_anime_image TO desenvolvimento;


-- anime.tb_anime_language definition

-- Drop table

-- DROP TABLE anime.tb_anime_language;

CREATE TABLE anime.tb_anime_language (
	id_anime int4 NOT NULL,
	language_code bpchar(2) NOT NULL,
	status varchar(50) NULL,
	age_rating varchar(50) NULL,
	synopsys varchar(5000) NULL,
	official_translate bool NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_language_pkey PRIMARY KEY (id_anime),
	CONSTRAINT tb_anime_language_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_language OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_language TO taboada;
GRANT ALL ON TABLE anime.tb_anime_language TO desenvolvimento;


-- anime.tb_anime_streaming definition

-- Drop table

-- DROP TABLE anime.tb_anime_streaming;

CREATE TABLE anime.tb_anime_streaming (
	id_streaming int4 NOT NULL,
	id_anime int4 NOT NULL,
	url varchar NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_streaming_pkey PRIMARY KEY (id_anime, id_streaming),
	CONSTRAINT tb_anime_streaming_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id),
	CONSTRAINT tb_anime_streaming_id_streaming_fkey FOREIGN KEY (id_streaming) REFERENCES anime.tb_streaming(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_streaming OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_streaming TO taboada;
GRANT ALL ON TABLE anime.tb_anime_streaming TO desenvolvimento;


-- anime.tb_anime_studio definition

-- Drop table

-- DROP TABLE anime.tb_anime_studio;

CREATE TABLE anime.tb_anime_studio (
	id_anime int4 NOT NULL,
	id_studio int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_studio_pkey PRIMARY KEY (id_anime, id_studio),
	CONSTRAINT tb_anime_studio_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id),
	CONSTRAINT tb_anime_studio_id_studio_fkey FOREIGN KEY (id_studio) REFERENCES anime.tb_studio(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_studio OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_studio TO taboada;
GRANT ALL ON TABLE anime.tb_anime_studio TO desenvolvimento;


-- anime.tb_anime_theme definition

-- Drop table

-- DROP TABLE anime.tb_anime_theme;

CREATE TABLE anime.tb_anime_theme (
	id_anime int4 NOT NULL,
	id_theme int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_theme_pkey PRIMARY KEY (id_anime, id_theme),
	CONSTRAINT tb_anime_theme_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id),
	CONSTRAINT tb_anime_theme_id_theme_fkey FOREIGN KEY (id_theme) REFERENCES anime.tb_theme(id)
);

-- Permissions

ALTER TABLE anime.tb_anime_theme OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_theme TO taboada;
GRANT ALL ON TABLE anime.tb_anime_theme TO desenvolvimento;


-- anime.tb_custom_anime_user definition

-- Drop table

-- DROP TABLE anime.tb_custom_anime_user;

CREATE TABLE anime.tb_custom_anime_user (
	id_anime int4 NOT NULL,
	id_user int4 NOT NULL,
	id_demographic int4 NOT NULL,
	id_studio int4 NOT NULL,
	id_genre int4 NOT NULL,
	custom_title varchar(200) NOT NULL,
	custom_synopsys varchar(5000) NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_custom_anime_user_pkey PRIMARY KEY (id_anime, id_user),
	CONSTRAINT tb_custom_anime_user_id_demographic_fkey FOREIGN KEY (id_demographic) REFERENCES anime.tb_demographic(id),
	CONSTRAINT tb_custom_anime_user_id_genre_fkey FOREIGN KEY (id_genre) REFERENCES anime.tb_genre(id),
	CONSTRAINT tb_custom_anime_user_id_studio_fkey FOREIGN KEY (id_studio) REFERENCES anime.tb_studio(id)
);

-- Permissions

ALTER TABLE anime.tb_custom_anime_user OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_custom_anime_user TO taboada;
GRANT ALL ON TABLE anime.tb_custom_anime_user TO desenvolvimento;


-- anime.tb_total_rating_users definition

-- Drop table

-- DROP TABLE anime.tb_total_rating_users;

CREATE TABLE anime.tb_total_rating_users (
	id_anime int4 NOT NULL,
	total_rating numeric DEFAULT 0 NOT NULL,
	total_votes int4 DEFAULT 0 NOT NULL,
	last_updated timestamp NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_total_rating_users_pkey PRIMARY KEY (id_anime),
	CONSTRAINT tb_total_rating_users_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id)
);

-- Permissions

ALTER TABLE anime.tb_total_rating_users OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_total_rating_users TO taboada;
GRANT ALL ON TABLE anime.tb_total_rating_users TO desenvolvimento;


-- anime.tb_user_preference_demographic definition

-- Drop table

-- DROP TABLE anime.tb_user_preference_demographic;

CREATE TABLE anime.tb_user_preference_demographic (
	id_user int4 NOT NULL,
	id_demographic int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_user_preference_demographic_pkey PRIMARY KEY (id_user, id_demographic),
	CONSTRAINT tb_user_preference_demographic_id_demographic_fkey FOREIGN KEY (id_demographic) REFERENCES anime.tb_demographic(id)
);

-- Permissions

ALTER TABLE anime.tb_user_preference_demographic OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_demographic TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_demographic TO desenvolvimento;


-- anime.tb_user_preference_genre definition

-- Drop table

-- DROP TABLE anime.tb_user_preference_genre;

CREATE TABLE anime.tb_user_preference_genre (
	id_user int4 NOT NULL,
	id_genre int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_user_preference_genre_pkey PRIMARY KEY (id_user, id_genre),
	CONSTRAINT tb_user_preference_genre_id_genre_fkey FOREIGN KEY (id_genre) REFERENCES anime.tb_genre(id)
);

-- Permissions

ALTER TABLE anime.tb_user_preference_genre OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_genre TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_genre TO desenvolvimento;


-- anime.tb_user_preference_studio definition

-- Drop table

-- DROP TABLE anime.tb_user_preference_studio;

CREATE TABLE anime.tb_user_preference_studio (
	id_user int4 NOT NULL,
	id_studio int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_user_preference_studio_pkey PRIMARY KEY (id_user, id_studio),
	CONSTRAINT tb_user_preference_studio_id_studio_fkey FOREIGN KEY (id_studio) REFERENCES anime.tb_studio(id)
);

-- Permissions

ALTER TABLE anime.tb_user_preference_studio OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_studio TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_studio TO desenvolvimento;


-- anime.tb_user_preference_theme definition

-- Drop table

-- DROP TABLE anime.tb_user_preference_theme;

CREATE TABLE anime.tb_user_preference_theme (
	id_user int4 NOT NULL,
	id_theme int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_user_preference_theme_pkey PRIMARY KEY (id_user, id_theme),
	CONSTRAINT tb_user_preference_theme_id_theme_fkey FOREIGN KEY (id_theme) REFERENCES anime.tb_theme(id)
);

-- Permissions

ALTER TABLE anime.tb_user_preference_theme OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_theme TO taboada;
GRANT ALL ON TABLE anime.tb_user_preference_theme TO desenvolvimento;


-- anime.tb_anime_interaction definition

-- Drop table

-- DROP TABLE anime.tb_anime_interaction;

CREATE TABLE anime.tb_anime_interaction (
	id_anime int4 NOT NULL,
	id_user int4 NOT NULL,
	rating_score int2 NOT NULL,
	last_episode int4 NULL,
	interaction_date timestamp NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_interaction_pkey PRIMARY KEY (id_anime, id_user)
);

-- Permissions

ALTER TABLE anime.tb_anime_interaction OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_interaction TO taboada;
GRANT ALL ON TABLE anime.tb_anime_interaction TO desenvolvimento;


-- anime.tb_anime_interaction_status definition

-- Drop table

-- DROP TABLE anime.tb_anime_interaction_status;

CREATE TABLE anime.tb_anime_interaction_status (
	id serial4 	PRIMARY KEY,
	id_anime int4 NOT NULL,
	id_user int4 NOT NULL,
	status int4 NOT NULL,
	quantity_status int4 NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NULL,
	CONSTRAINT tb_anime_interaction_status_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE anime.tb_anime_interaction_status OWNER TO taboada;
GRANT ALL ON TABLE anime.tb_anime_interaction_status TO taboada;
GRANT ALL ON TABLE anime.tb_anime_interaction_status TO desenvolvimento;


-- anime.tb_anime_interaction foreign keys

ALTER TABLE anime.tb_anime_interaction ADD CONSTRAINT tb_anime_interaction_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id);
ALTER TABLE anime.tb_anime_interaction ADD CONSTRAINT tb_anime_interaction_id_user_fkey FOREIGN KEY (id_user) REFERENCES auth.tb_user(id);


-- anime.tb_anime_interaction_status foreign keys

ALTER TABLE anime.tb_anime_interaction_status ADD CONSTRAINT tb_anime_interaction_status_id_anime_fkey FOREIGN KEY (id_anime) REFERENCES anime.tb_anime(id);
ALTER TABLE anime.tb_anime_interaction_status ADD CONSTRAINT tb_anime_interaction_status_id_user_fkey FOREIGN KEY (id_user) REFERENCES auth.tb_user(id);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* SCHEMA AUTH */
-- auth.tb_address definition

-- Drop table

-- DROP TABLE auth.tb_address;

CREATE TABLE auth.tb_address (
	id serial4 NOT NULL,
	id_user int4 NOT NULL,
	street varchar(100) NOT NULL,
	city varchar(100) NOT NULL,
	"estate" auth."tp_estate" NOT NULL,
	country varchar(50) DEFAULT 'Brasil'::character varying NOT NULL,
	cep varchar(20) NOT NULL,
	CONSTRAINT tb_address_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE auth.tb_address OWNER TO taboada;
GRANT ALL ON TABLE auth.tb_address TO taboada;
GRANT ALL ON TABLE auth.tb_address TO desenvolvimento;


-- auth.tb_document definition

-- Drop table

-- DROP TABLE auth.tb_document;

CREATE TABLE auth.tb_document (
	id serial4 NOT NULL,
	document_type int4 NOT NULL,
	document_value text NULL,
	CONSTRAINT tb_document_pkey PRIMARY KEY (id)
);

-- Permissions

ALTER TABLE auth.tb_document OWNER TO taboada;
GRANT ALL ON TABLE auth.tb_document TO taboada;
GRANT ALL ON TABLE auth.tb_document TO desenvolvimento;


-- auth.tb_user definition

-- Drop table

-- DROP TABLE auth.tb_user;

CREATE TABLE auth.tb_user (
	id serial4 NOT NULL,
	"name" varchar(100) NOT NULL,
	nickname varchar(100) NULL,
	email varchar(100) NOT NULL,
	"password" varchar(256) NOT NULL,
	"role" varchar(15) NOT NULL,
	birth_date timestamp NOT NULL,
	phone_number varchar(20) NULL,
	register_date timestamp NOT NULL,
	login_date timestamp NULL,
	CONSTRAINT tb_user_pkey PRIMARY KEY (id),
	CONSTRAINT unique_email UNIQUE (email)
);

-- Permissions

ALTER TABLE auth.tb_user OWNER TO taboada;
GRANT ALL ON TABLE auth.tb_user TO taboada;
GRANT ALL ON TABLE auth.tb_user TO desenvolvimento;