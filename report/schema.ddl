--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO postgres;

--
-- Name: broadcasts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE broadcasts (
    id bigint NOT NULL,
    content text,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE broadcasts OWNER TO postgres;

--
-- Name: broadcasts_feeds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE broadcasts_feeds (
    broadcast_id bigint,
    feed_id bigint
);


ALTER TABLE broadcasts_feeds OWNER TO postgres;

--
-- Name: broadcasts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE broadcasts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE broadcasts_id_seq OWNER TO postgres;

--
-- Name: broadcasts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE broadcasts_id_seq OWNED BY broadcasts.id;


--
-- Name: feeds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE feeds (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE feeds OWNER TO postgres;

--
-- Name: feeds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE feeds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE feeds_id_seq OWNER TO postgres;

--
-- Name: feeds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE feeds_id_seq OWNED BY feeds.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE images (
    id bigint NOT NULL,
    user_id bigint,
    photo_file_name character varying,
    photo_content_type character varying,
    photo_file_size integer,
    photo_updated_at timestamp without time zone
);


ALTER TABLE images OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE images_id_seq OWNER TO postgres;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE posts (
    id bigint NOT NULL,
    title character varying NOT NULL,
    body text NOT NULL,
    date timestamp without time zone NOT NULL,
    user_id bigint,
    topic_id bigint,
    parent_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: posts_reads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE posts_reads (
    id bigint NOT NULL,
    user_id bigint,
    topic_id bigint,
    post_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE posts_reads OWNER TO postgres;

--
-- Name: posts_reads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE posts_reads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_reads_id_seq OWNER TO postgres;

--
-- Name: posts_reads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE posts_reads_id_seq OWNED BY posts_reads.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE topics (
    id bigint NOT NULL,
    title character varying NOT NULL,
    date timestamp without time zone NOT NULL,
    user_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE topics OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE topics_id_seq OWNER TO postgres;

--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE topics_id_seq OWNED BY topics.id;


--
-- Name: user_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_details (
    id bigint NOT NULL,
    login character varying,
    salt character varying,
    crypted_password character varying,
    user_id bigint
);


ALTER TABLE user_details OWNER TO postgres;

--
-- Name: user_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_details_id_seq OWNER TO postgres;

--
-- Name: user_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_details_id_seq OWNED BY user_details.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id bigint NOT NULL,
    surname character varying NOT NULL,
    firstname character varying NOT NULL,
    phone character varying,
    grad_year integer NOT NULL,
    jobs boolean DEFAULT false,
    email character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: broadcasts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY broadcasts ALTER COLUMN id SET DEFAULT nextval('broadcasts_id_seq'::regclass);


--
-- Name: feeds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feeds ALTER COLUMN id SET DEFAULT nextval('feeds_id_seq'::regclass);


--
-- Name: images id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: posts_reads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts_reads ALTER COLUMN id SET DEFAULT nextval('posts_reads_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics ALTER COLUMN id SET DEFAULT nextval('topics_id_seq'::regclass);


--
-- Name: user_details id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_details ALTER COLUMN id SET DEFAULT nextval('user_details_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: broadcasts broadcasts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY broadcasts
    ADD CONSTRAINT broadcasts_pkey PRIMARY KEY (id);


--
-- Name: feeds feeds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY feeds
    ADD CONSTRAINT feeds_pkey PRIMARY KEY (id);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: posts_reads posts_reads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts_reads
    ADD CONSTRAINT posts_reads_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: user_details user_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_details
    ADD CONSTRAINT user_details_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_broadcasts_feeds_on_broadcast_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_broadcasts_feeds_on_broadcast_id ON broadcasts_feeds USING btree (broadcast_id);


--
-- Name: index_broadcasts_feeds_on_feed_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_broadcasts_feeds_on_feed_id ON broadcasts_feeds USING btree (feed_id);


--
-- Name: index_broadcasts_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_broadcasts_on_user_id ON broadcasts USING btree (user_id);


--
-- Name: index_images_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_images_on_user_id ON images USING btree (user_id);


--
-- Name: index_posts_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_parent_id ON posts USING btree (parent_id);


--
-- Name: index_posts_on_topic_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_topic_id ON posts USING btree (topic_id);


--
-- Name: index_posts_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_on_user_id ON posts USING btree (user_id);


--
-- Name: index_posts_reads_on_post_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_reads_on_post_id ON posts_reads USING btree (post_id);


--
-- Name: index_posts_reads_on_topic_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_reads_on_topic_id ON posts_reads USING btree (topic_id);


--
-- Name: index_posts_reads_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_posts_reads_on_user_id ON posts_reads USING btree (user_id);


--
-- Name: index_topics_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_topics_on_user_id ON topics USING btree (user_id);


--
-- Name: index_user_details_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_details_on_user_id ON user_details USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_surname; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_surname ON users USING btree (surname);


--
-- Name: posts_reads fk_rails_0af83d8f9d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts_reads
    ADD CONSTRAINT fk_rails_0af83d8f9d FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: user_details fk_rails_12e0b3043d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_details
    ADD CONSTRAINT fk_rails_12e0b3043d FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: images fk_rails_19cd822056; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY images
    ADD CONSTRAINT fk_rails_19cd822056 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: posts_reads fk_rails_3346b65d51; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts_reads
    ADD CONSTRAINT fk_rails_3346b65d51 FOREIGN KEY (topic_id) REFERENCES topics(id);


--
-- Name: broadcasts_feeds fk_rails_33b5ca3829; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY broadcasts_feeds
    ADD CONSTRAINT fk_rails_33b5ca3829 FOREIGN KEY (broadcast_id) REFERENCES broadcasts(id);


--
-- Name: posts fk_rails_3eb11ec3aa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT fk_rails_3eb11ec3aa FOREIGN KEY (parent_id) REFERENCES posts(id);


--
-- Name: broadcasts fk_rails_48d4c22743; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY broadcasts
    ADD CONSTRAINT fk_rails_48d4c22743 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: posts fk_rails_5b5ddfd518; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT fk_rails_5b5ddfd518 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: posts fk_rails_70d0b6486a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT fk_rails_70d0b6486a FOREIGN KEY (topic_id) REFERENCES topics(id);


--
-- Name: topics fk_rails_7b812cfb44; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT fk_rails_7b812cfb44 FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: broadcasts_feeds fk_rails_bfbc4740e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY broadcasts_feeds
    ADD CONSTRAINT fk_rails_bfbc4740e8 FOREIGN KEY (feed_id) REFERENCES feeds(id);


--
-- Name: posts_reads fk_rails_fb5b3e00dd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY posts_reads
    ADD CONSTRAINT fk_rails_fb5b3e00dd FOREIGN KEY (post_id) REFERENCES posts(id);


--
-- PostgreSQL database dump complete
--
