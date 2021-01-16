--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE directus;




--
-- Drop roles
--

DROP ROLE directus;


--
-- Roles
--

CREATE ROLE directus;
ALTER ROLE directus WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5b6b2fa1d6e06b17c0856f4d9d6ed04f3';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Debian 12.5-1.pgdg100+1)
-- Dumped by pg_dump version 12.5 (Debian 12.5-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: directus
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO directus;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: directus
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: directus
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "directus" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Debian 12.5-1.pgdg100+1)
-- Dumped by pg_dump version 12.5 (Debian 12.5-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: directus; Type: DATABASE; Schema: -; Owner: directus
--

CREATE DATABASE directus WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE directus OWNER TO directus;

\connect directus

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cars; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.cars (
    id integer NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    model character varying(255) NOT NULL,
    manufacturer integer
);


ALTER TABLE public.cars OWNER TO directus;

--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.cars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cars_id_seq OWNER TO directus;

--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.cars_id_seq OWNED BY public.cars.id;


--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64)
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    locked boolean DEFAULT false NOT NULL,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    "group" integer,
    translations json,
    note text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize integer DEFAULT 0 NOT NULL,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    "limit" integer
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    filters json,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    many_primary character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_primary character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64)
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    module_list json,
    collection_list json,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10),
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128) NOT NULL,
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255)
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: manufacturers; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.manufacturers (
    id integer NOT NULL,
    manufacturer character varying(255) DEFAULT 'E.g. Audi'::character varying NOT NULL
);


ALTER TABLE public.manufacturers OWNER TO directus;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.manufacturers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manufacturers_id_seq OWNER TO directus;

--
-- Name: manufacturers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.manufacturers_id_seq OWNED BY public.manufacturers.id;


--
-- Name: cars id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cars ALTER COLUMN id SET DEFAULT nextval('public.cars_id_seq'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: manufacturers id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.manufacturers ALTER COLUMN id SET DEFAULT nextval('public.manufacturers_id_seq'::regclass);


--
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.cars (id, status, user_created, date_created, user_updated, date_updated, model, manufacturer) FROM stdin;
1	published	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:16.364+00	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:01:01.336+00	Octavia RS iV	3
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment) FROM stdin;
1	authenticate	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:25:59.543816+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_users	dee95160-b78e-4aa1-b06d-89489a8eab03	\N
2	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:26:30.111347+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_files	000555d4-03af-43ae-be82-07b44fcb9f33	\N
3	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_collections	cars	\N
4	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	1	\N
5	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	2	\N
6	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	3	\N
7	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	4	\N
8	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	5	\N
9	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	6	\N
10	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.805066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	7	\N
11	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.914317+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_relations	1	\N
12	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:45:30.914317+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_relations	2	\N
13	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:46:51.075685+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	8	\N
14	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:46:54.264676+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_collections	cars	\N
15	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:16.35544+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	cars	1	\N
16	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:33.98344+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
17	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:34.869066+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
18	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:37.994997+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
19	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:43.190451+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
20	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:47.220271+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
21	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:52.113215+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
22	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:47:56.235274+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
23	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:49:07.76905+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_collections	manufacturers	\N
24	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:49:07.76905+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	9	\N
25	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:49:30.912707+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	10	\N
26	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:49:47.792082+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	manufacturers	1	\N
27	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:49:53.333607+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	manufacturers	2	\N
28	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:49:58.105979+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	manufacturers	3	\N
29	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:50:01.806529+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	2	\N
30	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:50:02.334386+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	2	\N
31	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:50:02.904126+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	2	\N
32	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:51:55.451757+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_collections	cars	\N
33	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:54:43.884919+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_collections	manufacturers	\N
34	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:55:17.063244+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_collections	manufacturers	\N
35	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:57:55.393111+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	11	\N
36	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:57:55.456598+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_relations	3	\N
37	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:58:13.493704+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	cars	1	\N
38	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:58:23.830755+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
39	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:58:27.095955+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_presets	1	\N
40	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:59:15.17342+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	11	\N
41	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:59:15.241801+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_relations	3	\N
42	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:00:06.472296+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_fields	11	\N
43	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:00:06.545929+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_relations	3	\N
44	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:01:01.333825+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	cars	1	\N
45	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:05:17.665852+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_permissions	1	\N
46	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:05:19.949686+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_permissions	2	\N
47	create	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:05:35.383178+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_permissions	3	\N
48	update	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 14:05:49.868525+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36	directus_permissions	3	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field) FROM stdin;
cars	directions_car	Cars	\N	f	f	\N	status	t	archived	draft	\N
manufacturers	handyman	Manufacturers	\N	f	f	\N	\N	t	\N	\N	\N
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, locked, readonly, hidden, sort, width, "group", translations, note) FROM stdin;
1	cars	id	\N	numeric	\N	\N	\N	f	t	t	\N	full	\N	\N	\N
2	cars	status	\N	dropdown	{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]}	labels	{"showAsDot":true,"choices":[{"background":"#2F80ED","value":"published"},{"background":"#ECEFF1","value":"draft"},{"background":"#F2994A","value":"archived"}]}	f	f	f	\N	full	\N	\N	\N
4	cars	user_created	user-created	user	{"display":"both"}	user	\N	f	t	t	\N	half	\N	\N	\N
5	cars	date_created	date-created	datetime	\N	datetime	{"relative":true}	f	t	t	\N	half	\N	\N	\N
6	cars	user_updated	user-updated	user	{"display":"both"}	user	\N	f	t	t	\N	half	\N	\N	\N
7	cars	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	f	t	t	\N	half	\N	\N	\N
8	cars	model	\N	\N	\N	\N	\N	f	f	f	\N	full	\N	\N	E.g. Octavia
9	manufacturers	id	\N	numeric	\N	\N	\N	f	t	t	\N	full	\N	\N	\N
10	manufacturers	manufacturer	\N	\N	\N	\N	\N	f	f	f	\N	full	\N	\N	\N
11	cars	manufacturer	\N	many-to-one	{"template":"{{manufacturer}}"}	related-values	{"template":"{{manufacturer}}"}	f	f	f	\N	full	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
000555d4-03af-43ae-be82-07b44fcb9f33	local	000555d4-03af-43ae-be82-07b44fcb9f33.jpeg	PbPYzVD.jpg	Pb P Yz Vd	image/jpeg	\N	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-16 13:26:30.111347+00	\N	2021-01-16 13:26:30.238+00	\N	398052	2560	1440	\N	\N	\N	\N	\N	{}
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2021-01-16 13:01:32.765856+00
20201029A	Remove System Relations	2021-01-16 13:01:32.772408+00
20201029B	Remove System Collections	2021-01-16 13:01:32.776301+00
20201029C	Remove System Fields	2021-01-16 13:01:32.78265+00
20201105A	Add Cascade System Relations	2021-01-16 13:01:32.847502+00
20201105B	Change Webhook URL Type	2021-01-16 13:01:32.851476+00
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields, "limit") FROM stdin;
1	\N	cars	read	\N	\N	\N	*	\N
2	\N	manufacturers	read	\N	\N	\N	*	\N
3	\N	directus_collections	read	\N	\N	\N	*	\N
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, filters, layout, layout_query, layout_options) FROM stdin;
2	\N	dee95160-b78e-4aa1-b06d-89489a8eab03	\N	manufacturers	\N	\N	tabular	{"tabular":{"sort":"manufacturer"}}	\N
1	\N	dee95160-b78e-4aa1-b06d-89489a8eab03	\N	cars	\N	[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}]	tabular	{"tabular":{"fields":["id","manufacturer","model","date_created","date_updated"]}}	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field) FROM stdin;
1	cars	user_created	id	directus_users	\N	id	\N	\N	\N
2	cars	user_updated	id	directus_users	\N	id	\N	\N	\N
3	cars	manufacturer	id	manufacturers	cars	id	\N	\N	\N
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
1	2	directus_files	000555d4-03af-43ae-be82-07b44fcb9f33	{"title":"Pb P Yz Vd","uploaded_by":"dee95160-b78e-4aa1-b06d-89489a8eab03","filename_download":"PbPYzVD.jpg","type":"image/jpeg","storage":"local","id":"000555d4-03af-43ae-be82-07b44fcb9f33"}	{"title":"Pb P Yz Vd","uploaded_by":"dee95160-b78e-4aa1-b06d-89489a8eab03","filename_download":"PbPYzVD.jpg","type":"image/jpeg","storage":"local","id":"000555d4-03af-43ae-be82-07b44fcb9f33"}	\N
2	3	directus_collections	cars	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"cars"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"collection":"cars"}	\N
3	4	directus_fields	1	{"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"cars","id":1}	{"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"cars","id":1}	\N
4	5	directus_fields	2	{"width":"full","options":{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]},"interface":"dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#2F80ED","value":"published"},{"background":"#ECEFF1","value":"draft"},{"background":"#F2994A","value":"archived"}]},"field":"status","collection":"cars","id":2}	{"width":"full","options":{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]},"interface":"dropdown","display":"labels","display_options":{"showAsDot":true,"choices":[{"background":"#2F80ED","value":"published"},{"background":"#ECEFF1","value":"draft"},{"background":"#F2994A","value":"archived"}]},"field":"status","collection":"cars","id":2}	\N
5	6	directus_fields	3	{"interface":"numeric","hidden":true,"field":"sort","collection":"cars","id":3}	{"interface":"numeric","hidden":true,"field":"sort","collection":"cars","id":3}	\N
6	7	directus_fields	4	{"special":["user-created"],"interface":"user","options":{"display":"both"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"cars","id":4}	{"special":["user-created"],"interface":"user","options":{"display":"both"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"cars","id":4}	\N
7	8	directus_fields	5	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"cars","id":5}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"cars","id":5}	\N
8	9	directus_fields	6	{"special":["user-updated"],"interface":"user","options":{"display":"both"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"cars","id":6}	{"special":["user-updated"],"interface":"user","options":{"display":"both"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"cars","id":6}	\N
9	10	directus_fields	7	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"cars","id":7}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"cars","id":7}	\N
10	11	directus_relations	1	{"many_collection":"cars","many_field":"user_created","many_primary":"id","one_collection":"directus_users","one_primary":"id","id":1}	{"many_collection":"cars","many_field":"user_created","many_primary":"id","one_collection":"directus_users","one_primary":"id","id":1}	\N
11	12	directus_relations	2	{"many_collection":"cars","many_field":"user_updated","many_primary":"id","one_collection":"directus_users","one_primary":"id","id":2}	{"many_collection":"cars","many_field":"user_updated","many_primary":"id","one_collection":"directus_users","one_primary":"id","id":2}	\N
12	13	directus_fields	8	{"hidden":false,"readonly":false,"note":"E.g. Octavia","collection":"cars","field":"model","id":8}	{"hidden":false,"readonly":false,"note":"E.g. Octavia","collection":"cars","field":"model","id":8}	\N
13	14	directus_collections	cars	{"collection":"cars","icon":"directions_car","note":"Cars","display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":"sort"}	{"icon":"directions_car","note":"Cars"}	\N
14	15	cars	1	{"status":"draft","model":"Octavia RS iV","id":1}	{"status":"draft","model":"Octavia RS iV","id":1}	\N
15	16	directus_presets	1	{"bookmark":null,"role":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","sort","date_updated"]}},"layout_options":null,"collection":"cars","id":1}	{"bookmark":null,"role":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","sort","date_updated"]}},"layout_options":null,"collection":"cars","id":1}	\N
16	17	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","sort","date_updated","model"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"sort\\",\\"date_updated\\",\\"model\\"]}}","layout_options":null}	\N
17	18	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["model","id","sort","date_updated"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"model\\",\\"id\\",\\"sort\\",\\"date_updated\\"]}}","layout_options":null}	\N
22	23	directus_collections	manufacturers	{"singleton":false,"collection":"manufacturers"}	{"singleton":false,"collection":"manufacturers"}	\N
18	19	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","model","sort","date_updated"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"model\\",\\"sort\\",\\"date_updated\\"]}}","layout_options":null}	\N
19	20	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","model","date_updated"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"model\\",\\"date_updated\\"]}}","layout_options":null}	\N
20	21	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","model","date_updated","date_created"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"model\\",\\"date_updated\\",\\"date_created\\"]}}","layout_options":null}	\N
21	22	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","model","date_created","date_updated"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"model\\",\\"date_created\\",\\"date_updated\\"]}}","layout_options":null}	\N
23	24	directus_fields	9	{"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"manufacturers","id":9}	{"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"manufacturers","id":9}	\N
24	25	directus_fields	10	{"hidden":false,"readonly":false,"collection":"manufacturers","field":"manufacturer","id":10}	{"hidden":false,"readonly":false,"collection":"manufacturers","field":"manufacturer","id":10}	\N
25	26	manufacturers	1	{"manufacturer":"Audi","id":1}	{"manufacturer":"Audi","id":1}	\N
26	27	manufacturers	2	{"manufacturer":"BMW","id":2}	{"manufacturer":"BMW","id":2}	\N
27	28	manufacturers	3	{"manufacturer":"Skoda","id":3}	{"manufacturer":"Skoda","id":3}	\N
28	29	directus_presets	2	{"bookmark":null,"role":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","search":null,"filters":null,"layout":"tabular","layout_query":{"tabular":{"sort":"manufacturer"}},"layout_options":null,"collection":"manufacturers","id":2}	{"bookmark":null,"role":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","search":null,"filters":null,"layout":"tabular","layout_query":{"tabular":{"sort":"manufacturer"}},"layout_options":null,"collection":"manufacturers","id":2}	\N
29	30	directus_presets	2	{"id":2,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"manufacturers","search":null,"filters":null,"layout":"tabular","layout_query":{"tabular":{"sort":"-manufacturer"}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"manufacturers","search":null,"filters":null,"layout":"tabular","layout_query":"{\\"tabular\\":{\\"sort\\":\\"-manufacturer\\"}}","layout_options":null}	\N
30	31	directus_presets	2	{"id":2,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"manufacturers","search":null,"filters":null,"layout":"tabular","layout_query":{"tabular":{"sort":"manufacturer"}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"manufacturers","search":null,"filters":null,"layout":"tabular","layout_query":"{\\"tabular\\":{\\"sort\\":\\"manufacturer\\"}}","layout_options":null}	\N
31	32	directus_collections	cars	{"collection":"cars","icon":"directions_car","note":"Cars","display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":"status","archive_app_filter":true,"archive_value":"archived","unarchive_value":"draft","sort_field":null}	{"sort_field":null}	\N
32	33	directus_collections	manufacturers	{"collection":"manufacturers","icon":"handyman","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null}	{"icon":"handyman"}	\N
33	34	directus_collections	manufacturers	{"collection":"manufacturers","icon":"handyman","note":"Manufacturers","display_template":null,"hidden":false,"singleton":false,"translations":null,"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null}	{"note":"Manufacturers"}	\N
34	35	directus_fields	11	{"hidden":false,"interface":"many-to-one","display":"related-values","readonly":false,"collection":"cars","field":"manufacturer","id":11}	{"hidden":false,"interface":"many-to-one","display":"related-values","readonly":false,"collection":"cars","field":"manufacturer","id":11}	\N
35	36	directus_relations	3	{"many_collection":"cars","many_field":"manufacturer","many_primary":"id","one_collection":"manufacturers","one_primary":"id","one_field":"cars","id":3}	{"many_collection":"cars","many_field":"manufacturer","many_primary":"id","one_collection":"manufacturers","one_primary":"id","one_field":"cars","id":3}	\N
36	37	cars	1	{"id":1,"status":"draft","user_created":"dee95160-b78e-4aa1-b06d-89489a8eab03","date_created":"2021-01-16T13:47:16Z","user_updated":"dee95160-b78e-4aa1-b06d-89489a8eab03","date_updated":"2021-01-16T13:58:13Z","model":"Octavia RS iV","manufacturer":3}	{"manufacturer":3,"user_updated":"dee95160-b78e-4aa1-b06d-89489a8eab03","date_updated":"2021-01-16T13:58:13.496Z"}	\N
37	38	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","model","date_created","date_updated","manufacturer"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"model\\",\\"date_created\\",\\"date_updated\\",\\"manufacturer\\"]}}","layout_options":null}	\N
38	39	directus_presets	1	{"id":1,"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":[{"key":"hide-archived","field":"status","operator":"neq","value":"archived","locked":true}],"layout":"tabular","layout_query":{"tabular":{"fields":["id","manufacturer","model","date_created","date_updated"]}},"layout_options":null}	{"bookmark":null,"user":"dee95160-b78e-4aa1-b06d-89489a8eab03","role":null,"collection":"cars","search":null,"filters":"[{\\"key\\":\\"hide-archived\\",\\"field\\":\\"status\\",\\"operator\\":\\"neq\\",\\"value\\":\\"archived\\",\\"locked\\":true}]","layout":"tabular","layout_query":"{\\"tabular\\":{\\"fields\\":[\\"id\\",\\"manufacturer\\",\\"model\\",\\"date_created\\",\\"date_updated\\"]}}","layout_options":null}	\N
39	40	directus_fields	11	{"id":11,"collection":"cars","field":"manufacturer","special":null,"interface":"many-to-one","options":null,"display":"related-values","display_options":{"template":"{{manufacturer}}"},"locked":false,"readonly":false,"hidden":false,"sort":null,"width":"full","group":null,"translations":null,"note":null}	{"id":11,"collection":"cars","field":"manufacturer","special":null,"interface":"many-to-one","options":null,"display":"related-values","display_options":"{\\"template\\":\\"{{manufacturer}}\\"}","locked":false,"readonly":false,"hidden":false,"sort":null,"width":"full","group":null,"translations":null,"note":null}	\N
40	41	directus_relations	3	{"id":3,"many_collection":"cars","many_field":"manufacturer","many_primary":"id","one_collection":"manufacturers","one_field":"cars","one_primary":"id","one_collection_field":null,"one_allowed_collections":null,"junction_field":null}	{"id":3,"many_collection":"cars","many_field":"manufacturer","many_primary":"id","one_collection":"manufacturers","one_field":"cars","one_primary":"id","one_collection_field":null,"one_allowed_collections":null,"junction_field":null}	\N
41	42	directus_fields	11	{"id":11,"collection":"cars","field":"manufacturer","special":null,"interface":"many-to-one","options":{"template":"{{manufacturer}}"},"display":"related-values","display_options":{"template":"{{manufacturer}}"},"locked":false,"readonly":false,"hidden":false,"sort":null,"width":"full","group":null,"translations":null,"note":null}	{"id":11,"collection":"cars","field":"manufacturer","special":null,"interface":"many-to-one","options":"{\\"template\\":\\"{{manufacturer}}\\"}","display":"related-values","display_options":"{\\"template\\":\\"{{manufacturer}}\\"}","locked":false,"readonly":false,"hidden":false,"sort":null,"width":"full","group":null,"translations":null,"note":null}	\N
42	43	directus_relations	3	{"id":3,"many_collection":"cars","many_field":"manufacturer","many_primary":"id","one_collection":"manufacturers","one_field":"cars","one_primary":"id","one_collection_field":null,"one_allowed_collections":null,"junction_field":null}	{"id":3,"many_collection":"cars","many_field":"manufacturer","many_primary":"id","one_collection":"manufacturers","one_field":"cars","one_primary":"id","one_collection_field":null,"one_allowed_collections":null,"junction_field":null}	\N
43	44	cars	1	{"id":1,"status":"published","user_created":"dee95160-b78e-4aa1-b06d-89489a8eab03","date_created":"2021-01-16T13:47:16Z","user_updated":"dee95160-b78e-4aa1-b06d-89489a8eab03","date_updated":"2021-01-16T14:01:01Z","model":"Octavia RS iV","manufacturer":3}	{"status":"published","user_updated":"dee95160-b78e-4aa1-b06d-89489a8eab03","date_updated":"2021-01-16T14:01:01.336Z"}	\N
44	45	directus_permissions	1	{"role":null,"collection":"cars","action":"read","fields":"*","id":1}	{"role":null,"collection":"cars","action":"read","fields":"*","id":1}	\N
45	46	directus_permissions	2	{"role":null,"collection":"manufacturers","action":"read","fields":"*","id":2}	{"role":null,"collection":"manufacturers","action":"read","fields":"*","id":2}	\N
46	47	directus_permissions	3	{"role":null,"collection":"directus_collections","action":"read","fields":"*","id":3}	{"role":null,"collection":"directus_collections","action":"read","fields":"*","id":3}	\N
47	48	directus_permissions	3	{"id":3,"role":null,"collection":"directus_collections","action":"read","permissions":null,"validation":null,"presets":null,"fields":["*"],"limit":null}	{"id":3,"role":null,"collection":"directus_collections","action":"read","permissions":null,"validation":null,"presets":null,"fields":"*","limit":null}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) FROM stdin;
7b46d59a-a6e1-49ad-b787-918994d4c2cc	Admin	supervised_user_circle	\N	\N	f	\N	\N	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent) FROM stdin;
XY2krLJxOrR_VAYqoNNFClY9eV102E9z0A8mLZEsHtLtkcUKPPQhLjVTTnKdKyLT	dee95160-b78e-4aa1-b06d-89489a8eab03	2021-01-23 14:28:30.035+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 11_1_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page) FROM stdin;
dee95160-b78e-4aa1-b06d-89489a8eab03	\N	\N	admin@example.com	$argon2i$v=19$m=4096,t=3,p=1$mC1SLHSYpuPFmWx9qhLRNA$WsOgCQzXJs2dyzaycicwnRvITyp4/bPGQii0ojeyo+I	\N	\N	\N	\N	\N	en-US	auto	\N	active	7b46d59a-a6e1-49ad-b787-918994d4c2cc	\N	2021-01-16 14:28:30.02+00	/collections/cars/1
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections) FROM stdin;
\.


--
-- Data for Name: manufacturers; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.manufacturers (id, manufacturer) FROM stdin;
1	Audi
2	BMW
3	Skoda
\.


--
-- Name: cars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.cars_id_seq', 1, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 48, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 11, true);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 3, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 2, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 3, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 47, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.manufacturers_id_seq', 3, true);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: manufacturers manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.manufacturers
    ADD CONSTRAINT manufacturers_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Debian 12.5-1.pgdg100+1)
-- Dumped by pg_dump version 12.5 (Debian 12.5-1.pgdg100+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: directus
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO directus;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

