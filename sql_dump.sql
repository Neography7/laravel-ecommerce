--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (DBngin.app)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: model_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_permissions (
    permission_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_permissions OWNER TO postgres;

--
-- Name: model_has_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_has_roles (
    role_id bigint NOT NULL,
    model_type character varying(255) NOT NULL,
    model_id bigint NOT NULL
);


ALTER TABLE public.model_has_roles OWNER TO postgres;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    stock_quantity integer DEFAULT 0 NOT NULL,
    category_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: role_has_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_has_permissions (
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.role_has_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    guard_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: telescope_entries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telescope_entries (
    sequence bigint NOT NULL,
    uuid uuid NOT NULL,
    batch_id uuid NOT NULL,
    family_hash character varying(255),
    should_display_on_index boolean DEFAULT true NOT NULL,
    type character varying(20) NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.telescope_entries OWNER TO postgres;

--
-- Name: telescope_entries_sequence_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.telescope_entries_sequence_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.telescope_entries_sequence_seq OWNER TO postgres;

--
-- Name: telescope_entries_sequence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.telescope_entries_sequence_seq OWNED BY public.telescope_entries.sequence;


--
-- Name: telescope_entries_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telescope_entries_tags (
    entry_uuid uuid NOT NULL,
    tag character varying(255) NOT NULL
);


ALTER TABLE public.telescope_entries_tags OWNER TO postgres;

--
-- Name: telescope_monitoring; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.telescope_monitoring (
    tag character varying(255) NOT NULL
);


ALTER TABLE public.telescope_monitoring OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: telescope_entries sequence; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telescope_entries ALTER COLUMN sequence SET DEFAULT nextval('public.telescope_entries_sequence_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, product_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name, description, created_at, updated_at) FROM stdin;
1	et harum	Reprehenderit itaque et reprehenderit sed.	2025-08-03 17:51:42	2025-08-03 17:51:42
2	ut sed	Blanditiis veniam quo eligendi nulla quia.	2025-08-03 17:51:42	2025-08-03 17:51:42
3	voluptatem et	Quia nostrum eveniet sit.	2025-08-03 17:51:42	2025-08-03 17:51:42
4	veritatis sed	Qui est vel aliquam.	2025-08-03 17:51:42	2025-08-03 17:51:42
5	quisquam minima	Voluptates ut sit minima distinctio omnis.	2025-08-03 17:51:42	2025-08-03 17:51:42
6	voluptas esse	Numquam minima aliquam ratione ut.	2025-08-03 17:51:42	2025-08-03 17:51:42
7	quidem ad	Maxime sit ut adipisci soluta velit.	2025-08-03 17:51:42	2025-08-03 17:51:42
8	esse dolores	A tenetur tempore inventore.	2025-08-03 17:51:42	2025-08-03 17:51:42
9	quo suscipit	Molestiae distinctio quibusdam quis corrupti.	2025-08-03 17:51:42	2025-08-03 17:51:42
10	eum aliquid	In ut adipisci blanditiis.	2025-08-03 17:51:42	2025-08-03 17:51:42
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
13	0001_01_01_000000_create_users_table	1
14	0001_01_01_000001_create_cache_table	1
15	0001_01_01_000002_create_jobs_table	1
16	2025_08_02_114241_create_personal_access_tokens_table	1
17	2025_08_02_114838_create_permission_tables	1
18	2025_08_02_115221_create_telescope_entries_table	1
19	2025_08_02_154417_create_categories_table	1
20	2025_08_02_183942_create_products_table	1
21	2025_08_02_192621_create_carts_table	1
22	2025_08_02_192714_create_cart_items_table	1
23	2025_08_02_195930_create_orders_table	1
24	2025_08_02_195939_create_order_items_table	1
\.


--
-- Data for Name: model_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_permissions (permission_id, model_type, model_id) FROM stdin;
\.


--
-- Data for Name: model_has_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_has_roles (role_id, model_type, model_id) FROM stdin;
1	App\\Models\\User	1
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, order_id, product_id, quantity, price, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, user_id, total_amount, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name, guard_name, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, price, stock_quantity, category_id, created_at, updated_at) FROM stdin;
1	qui illo molestiae	Nesciunt aliquam officia recusandae sit dolores iusto dolor mollitia sed totam.	116.21	85	1	2025-08-03 17:52:40	2025-08-03 17:52:40
2	autem nisi illo	Optio molestias fuga dolore est eum ab deserunt molestiae.	233.05	47	1	2025-08-03 17:52:40	2025-08-03 17:52:40
3	et occaecati corrupti	Iure commodi praesentium incidunt possimus est modi quia aut eos.	780.40	15	1	2025-08-03 17:52:40	2025-08-03 17:52:40
4	modi tenetur aliquam	Perferendis voluptatum impedit amet aut id labore veritatis quos.	69.92	5	1	2025-08-03 17:52:40	2025-08-03 17:52:40
5	earum fuga aut	Aut ut facere quo enim accusantium sit voluptatem et.	532.09	45	1	2025-08-03 17:52:40	2025-08-03 17:52:40
6	eum a qui	Consectetur ab ipsam possimus commodi maiores sed id.	672.53	94	1	2025-08-03 17:52:40	2025-08-03 17:52:40
7	excepturi laudantium adipisci	Ut a qui numquam ullam deleniti doloremque rem expedita optio.	702.99	60	1	2025-08-03 17:52:40	2025-08-03 17:52:40
8	id quo quia	Magnam autem ipsum sint facere debitis in aut voluptatem.	549.45	61	1	2025-08-03 17:52:40	2025-08-03 17:52:40
9	ut vel eos	Aspernatur esse omnis repellat in id assumenda voluptas.	760.46	12	1	2025-08-03 17:52:40	2025-08-03 17:52:40
10	quisquam sapiente tempora	Dolor facilis dignissimos esse voluptatem earum dolor et.	977.76	84	1	2025-08-03 17:52:40	2025-08-03 17:52:40
11	non commodi sunt	Rerum et facilis minima vitae ea accusamus libero alias in.	855.92	71	1	2025-08-03 17:52:40	2025-08-03 17:52:40
12	ipsa dolor nobis	Consectetur consequuntur quia distinctio atque nulla architecto magnam provident est sunt rerum quia voluptatibus.	32.78	69	1	2025-08-03 17:52:40	2025-08-03 17:52:40
13	tenetur omnis est	Nisi ipsam nostrum et quasi est doloribus nemo.	40.11	86	1	2025-08-03 17:52:40	2025-08-03 17:52:40
14	atque dolorem eos	Non sequi et aut perspiciatis pariatur libero deserunt suscipit eos repellat quidem veritatis.	711.84	73	1	2025-08-03 17:52:40	2025-08-03 17:52:40
15	molestiae dignissimos laboriosam	Quia fugiat ducimus voluptatem recusandae repellendus vel maiores qui quisquam facilis officia.	382.94	51	1	2025-08-03 17:52:40	2025-08-03 17:52:40
16	amet voluptatem nesciunt	Accusamus magni amet qui natus enim animi facilis consequuntur.	806.90	75	1	2025-08-03 17:52:40	2025-08-03 17:52:40
17	nemo iure commodi	Voluptatem tempore et modi voluptas beatae qui magnam error est aspernatur delectus ut sit.	65.37	90	1	2025-08-03 17:52:40	2025-08-03 17:52:40
18	animi eos necessitatibus	Deleniti veniam impedit veniam enim vel perspiciatis odit voluptates suscipit facilis et quisquam sit.	426.98	52	1	2025-08-03 17:52:40	2025-08-03 17:52:40
19	eveniet nisi praesentium	Consequatur aspernatur voluptatibus molestias eos illum eos repellat qui harum voluptas qui ut.	29.67	97	1	2025-08-03 17:52:40	2025-08-03 17:52:40
20	explicabo qui deleniti	Facere ratione ea est dignissimos sint odio sunt omnis officia.	353.39	32	1	2025-08-03 17:52:40	2025-08-03 17:52:40
21	enim quasi modi	Vitae facere voluptatibus in et molestiae nam aliquam.	90.27	59	1	2025-08-03 17:52:40	2025-08-03 17:52:40
22	est ut pariatur	Sequi nihil non odio ratione nulla ratione quia amet dolore.	156.23	96	1	2025-08-03 17:52:40	2025-08-03 17:52:40
23	dolor et magnam	Voluptatum et eum asperiores consequuntur laudantium modi quo aliquam sit.	64.37	96	1	2025-08-03 17:52:40	2025-08-03 17:52:40
24	dolores atque sapiente	Enim et eum repellat tempore saepe rem voluptatibus.	27.80	15	1	2025-08-03 17:52:40	2025-08-03 17:52:40
25	sit corporis aut	Error eligendi facere deleniti officia dolor vel nostrum odit.	469.43	32	1	2025-08-03 17:52:40	2025-08-03 17:52:40
26	consequuntur laborum modi	Perspiciatis blanditiis eaque id aliquam deserunt optio eveniet sed quo.	688.14	87	1	2025-08-03 17:52:40	2025-08-03 17:52:40
27	labore soluta neque	Quia sed ut eum voluptatibus repellendus sunt reiciendis architecto tempore in est.	300.32	41	1	2025-08-03 17:52:40	2025-08-03 17:52:40
28	molestiae inventore magnam	Fuga ipsam consequatur et porro sint et impedit est nisi.	674.86	27	1	2025-08-03 17:52:40	2025-08-03 17:52:40
29	aspernatur quia blanditiis	Culpa ea voluptates iure eos odit veritatis ut quaerat vel suscipit rem.	295.02	43	1	2025-08-03 17:52:40	2025-08-03 17:52:40
30	distinctio necessitatibus cumque	Architecto qui nostrum tempore et laboriosam unde error animi eos molestiae suscipit ducimus cupiditate.	154.00	38	1	2025-08-03 17:52:40	2025-08-03 17:52:40
31	enim rem doloremque	Beatae aspernatur itaque praesentium molestiae eos eos.	767.82	75	1	2025-08-03 17:52:40	2025-08-03 17:52:40
32	autem laboriosam et	Voluptas et sed doloremque consequatur cupiditate accusamus.	836.75	40	1	2025-08-03 17:52:40	2025-08-03 17:52:40
33	ut inventore ullam	Nemo suscipit consectetur voluptas blanditiis perspiciatis sed et ut nemo.	501.52	17	1	2025-08-03 17:52:40	2025-08-03 17:52:40
34	quibusdam itaque blanditiis	Nesciunt vitae est sit sint quasi quis quia perferendis saepe totam exercitationem praesentium eum.	457.55	15	1	2025-08-03 17:52:40	2025-08-03 17:52:40
35	sed ipsam quae	A culpa omnis placeat et dicta repudiandae iste sunt.	962.46	31	1	2025-08-03 17:52:40	2025-08-03 17:52:40
36	minima nobis sint	Et qui sunt quia aut esse et autem provident aut enim eos nemo.	32.13	18	1	2025-08-03 17:52:40	2025-08-03 17:52:40
37	voluptates harum ex	Ipsam consequuntur et debitis odio ratione animi quia odit fugiat molestias.	836.51	45	1	2025-08-03 17:52:40	2025-08-03 17:52:40
38	delectus qui a	Maxime ipsam excepturi facilis perferendis possimus est minus deleniti eum eaque quis perspiciatis dolorem.	368.31	87	1	2025-08-03 17:52:40	2025-08-03 17:52:40
39	deleniti itaque laudantium	Reiciendis fugit tempore voluptatem architecto tempora soluta est ea eius nostrum.	218.17	72	1	2025-08-03 17:52:40	2025-08-03 17:52:40
40	necessitatibus amet ut	Autem incidunt autem iure iste incidunt reprehenderit veritatis aut.	348.85	18	1	2025-08-03 17:52:40	2025-08-03 17:52:40
41	quo aspernatur sed	Velit nobis ipsam occaecati sint harum adipisci ipsam quis cum est quidem error molestias.	691.42	64	1	2025-08-03 17:52:40	2025-08-03 17:52:40
42	dolorem aperiam a	Et sunt consequuntur non eligendi earum est cupiditate mollitia numquam ut.	862.69	86	1	2025-08-03 17:52:40	2025-08-03 17:52:40
43	assumenda nobis et	Numquam officiis minus commodi optio enim optio.	686.77	0	1	2025-08-03 17:52:40	2025-08-03 17:52:40
44	quam error nisi	Et quasi consequatur vitae itaque consequuntur aspernatur ea eaque occaecati impedit impedit.	198.24	38	1	2025-08-03 17:52:40	2025-08-03 17:52:40
45	iste accusamus doloribus	Repellat dolorem amet placeat nihil earum assumenda nihil.	841.60	20	1	2025-08-03 17:52:40	2025-08-03 17:52:40
46	fugit ut incidunt	Ducimus consequuntur nemo hic ut possimus eum blanditiis consequuntur omnis qui necessitatibus at.	529.75	2	1	2025-08-03 17:52:40	2025-08-03 17:52:40
47	suscipit corrupti aperiam	Debitis blanditiis maxime atque et sed est dolore odio numquam minima amet.	673.43	27	1	2025-08-03 17:52:40	2025-08-03 17:52:40
48	dolor est mollitia	Deleniti alias laboriosam ea suscipit repellendus corrupti.	788.25	2	1	2025-08-03 17:52:40	2025-08-03 17:52:40
49	autem mollitia voluptatem	Qui illum velit quaerat alias ut molestiae rem ex voluptatibus sed dolorem blanditiis.	841.90	36	1	2025-08-03 17:52:40	2025-08-03 17:52:40
50	quasi amet expedita	Omnis beatae accusantium ut ut quod est similique cupiditate dolore excepturi culpa quas eveniet at.	374.62	12	1	2025-08-03 17:52:40	2025-08-03 17:52:40
51	molestiae odio omnis	Atque sequi voluptatem ea quis consequatur dolorem sunt perspiciatis.	233.45	10	1	2025-08-03 17:52:40	2025-08-03 17:52:40
52	exercitationem consequatur iusto	Saepe sit et est in voluptatem fugiat sed.	676.60	99	1	2025-08-03 17:52:40	2025-08-03 17:52:40
53	ipsam est veritatis	Saepe sequi nobis est quia est ut repudiandae autem officia doloribus cumque ad tenetur.	918.71	13	1	2025-08-03 17:52:40	2025-08-03 17:52:40
54	aut unde vero	Eaque voluptatum deleniti doloremque consequatur porro soluta placeat praesentium aut.	884.92	53	1	2025-08-03 17:52:40	2025-08-03 17:52:40
55	ea minima iste	Magnam rem libero illum quo omnis sit ipsum tempora.	318.60	86	1	2025-08-03 17:52:40	2025-08-03 17:52:40
56	molestiae est sequi	Voluptate qui in assumenda aperiam ea aliquam.	500.67	16	1	2025-08-03 17:52:40	2025-08-03 17:52:40
57	harum consectetur natus	Consequatur omnis sit doloremque voluptatibus velit nihil ea quam quo tenetur.	761.88	66	1	2025-08-03 17:52:40	2025-08-03 17:52:40
58	ut tempore quia	Repellendus est placeat fuga et deleniti dolorem corrupti.	44.52	93	1	2025-08-03 17:52:40	2025-08-03 17:52:40
59	quo explicabo non	Sit dolorum laudantium vitae cupiditate libero unde itaque facilis quam.	736.37	49	1	2025-08-03 17:52:40	2025-08-03 17:52:40
60	voluptas possimus et	Exercitationem et labore numquam consequatur et et mollitia dolor sint accusamus voluptas tempora quisquam.	367.13	16	1	2025-08-03 17:52:40	2025-08-03 17:52:40
61	cupiditate vel eum	Numquam earum illum ut quia unde et.	306.71	47	1	2025-08-03 17:52:40	2025-08-03 17:52:40
62	sit maxime enim	Sit fuga enim aspernatur totam aut adipisci alias ut ut deleniti placeat placeat aut.	566.16	14	1	2025-08-03 17:52:40	2025-08-03 17:52:40
63	facilis ratione qui	Molestiae voluptatibus earum necessitatibus eius eius ea ipsam.	789.57	5	1	2025-08-03 17:52:40	2025-08-03 17:52:40
64	ut distinctio ex	Omnis est natus ipsum reprehenderit laborum est voluptates voluptas voluptate in deleniti itaque neque.	860.41	9	1	2025-08-03 17:52:40	2025-08-03 17:52:40
65	provident sed facere	Debitis nostrum rem harum tenetur tempore facilis voluptate nihil.	515.22	100	1	2025-08-03 17:52:40	2025-08-03 17:52:40
66	molestias sint ea	Eius accusamus aperiam sequi pariatur distinctio ut qui.	119.33	2	1	2025-08-03 17:52:40	2025-08-03 17:52:40
67	quo eius soluta	Voluptas rem esse dolores neque blanditiis dolor placeat ut.	422.84	70	1	2025-08-03 17:52:40	2025-08-03 17:52:40
68	deserunt ipsam eos	Est vel ipsum corporis quis cumque quidem exercitationem blanditiis delectus quia qui omnis error.	587.22	85	1	2025-08-03 17:52:40	2025-08-03 17:52:40
69	non quia voluptas	Dolore optio a enim sint libero ipsa.	402.85	68	1	2025-08-03 17:52:40	2025-08-03 17:52:40
70	numquam dolores vel	Ratione veniam provident rem sit reprehenderit qui repellat consequatur.	350.84	12	1	2025-08-03 17:52:40	2025-08-03 17:52:40
71	illum cumque voluptas	Rem quaerat est sint et quis beatae autem illo.	819.22	21	1	2025-08-03 17:52:40	2025-08-03 17:52:40
72	fuga minima voluptatem	Repellendus delectus quis assumenda quod aliquid voluptatibus qui ipsum magnam minus.	379.83	76	1	2025-08-03 17:52:40	2025-08-03 17:52:40
73	libero et et	Odio consequatur veniam ipsum et optio dolorum totam velit itaque non est inventore.	450.74	91	1	2025-08-03 17:52:40	2025-08-03 17:52:40
74	eaque amet porro	Quod possimus atque dolores ipsa qui odio deserunt aut aut.	665.15	64	1	2025-08-03 17:52:40	2025-08-03 17:52:40
75	dolorem at et	Autem officia illum sed ut optio dolores.	572.74	99	1	2025-08-03 17:52:40	2025-08-03 17:52:40
76	id quia aut	Nostrum voluptatibus ut reprehenderit praesentium et magnam quasi nihil impedit sit quas voluptatum.	734.63	100	1	2025-08-03 17:52:40	2025-08-03 17:52:40
77	est a explicabo	Ea perferendis asperiores magnam dolores qui perspiciatis nam exercitationem placeat fuga repudiandae suscipit.	419.85	81	1	2025-08-03 17:52:40	2025-08-03 17:52:40
78	voluptatem dicta aut	Est fuga aut quia reiciendis dolores architecto accusantium et non pariatur doloribus ut.	598.08	39	1	2025-08-03 17:52:40	2025-08-03 17:52:40
79	culpa omnis error	Dolorem earum beatae enim architecto officiis consequatur rerum molestias adipisci in.	47.96	54	1	2025-08-03 17:52:40	2025-08-03 17:52:40
80	recusandae fugiat consequuntur	Ullam sunt non laudantium omnis voluptatem facilis et impedit deleniti deserunt.	404.13	58	1	2025-08-03 17:52:40	2025-08-03 17:52:40
81	assumenda facilis sit	Voluptas ullam possimus consectetur omnis iusto odio asperiores voluptatem.	802.90	82	1	2025-08-03 17:52:40	2025-08-03 17:52:40
82	ipsum illo in	Autem dolorum quis sint quisquam quia blanditiis repellat molestiae sint quo reprehenderit qui.	273.06	22	1	2025-08-03 17:52:40	2025-08-03 17:52:40
83	fugiat iure ut	Voluptatem aliquam numquam et sapiente expedita nostrum quia.	462.61	87	1	2025-08-03 17:52:40	2025-08-03 17:52:40
84	quo veritatis distinctio	A incidunt enim rerum modi fuga quis beatae ipsum autem voluptas assumenda.	498.42	54	1	2025-08-03 17:52:40	2025-08-03 17:52:40
85	quam eius maiores	Porro consequuntur eos consequatur ratione unde minus eos commodi.	148.81	12	1	2025-08-03 17:52:40	2025-08-03 17:52:40
86	et sit perspiciatis	Quia sed sit cupiditate aut itaque aut eum aperiam aliquid iusto quod impedit.	389.18	61	1	2025-08-03 17:52:40	2025-08-03 17:52:40
87	non aspernatur minima	Assumenda et id sit et assumenda numquam architecto laborum vel inventore ea et.	970.60	83	1	2025-08-03 17:52:40	2025-08-03 17:52:40
88	eius et temporibus	Excepturi totam vel aut in est est cum quam totam et.	848.47	72	1	2025-08-03 17:52:40	2025-08-03 17:52:40
89	dolorum itaque provident	Maiores neque magnam repellendus in ut nemo esse tenetur assumenda.	246.22	43	1	2025-08-03 17:52:40	2025-08-03 17:52:40
90	dolor culpa aut	Quam autem labore deleniti nisi nisi quaerat itaque voluptatem suscipit laudantium.	721.22	70	1	2025-08-03 17:52:40	2025-08-03 17:52:40
91	tenetur sit deserunt	Consequatur quia error architecto aut pariatur ut et et praesentium cupiditate deserunt error ut.	342.98	44	1	2025-08-03 17:52:40	2025-08-03 17:52:40
92	qui nostrum quod	Quaerat ratione aut sit delectus similique aperiam est dolor libero laudantium maxime laudantium asperiores.	188.26	11	1	2025-08-03 17:52:40	2025-08-03 17:52:40
93	maiores qui mollitia	Cupiditate quia voluptas sapiente dolorem nesciunt distinctio sunt optio.	817.57	89	1	2025-08-03 17:52:40	2025-08-03 17:52:40
94	aut quia voluptatem	Voluptates sed tenetur est esse magnam eligendi commodi omnis perferendis quia.	193.60	66	1	2025-08-03 17:52:40	2025-08-03 17:52:40
95	eos et similique	Perspiciatis rerum tempora occaecati error aut rerum ut.	750.26	74	1	2025-08-03 17:52:40	2025-08-03 17:52:40
96	aut quasi natus	Est modi aut et assumenda numquam unde et aut quo voluptas.	743.39	80	1	2025-08-03 17:52:40	2025-08-03 17:52:40
97	saepe maiores aliquam	Eum deserunt repellat qui reprehenderit eos tenetur reiciendis.	78.95	34	1	2025-08-03 17:52:40	2025-08-03 17:52:40
98	mollitia praesentium sed	At dolor dolorem dolore vel molestias libero nihil repellat similique quis dolorem aspernatur tempore.	750.96	67	1	2025-08-03 17:52:40	2025-08-03 17:52:40
99	enim voluptatem quia	Provident dolores quia molestias est repellendus occaecati amet autem ex.	792.59	55	1	2025-08-03 17:52:40	2025-08-03 17:52:40
100	voluptas sit dolor	Porro excepturi sit cumque veniam nisi veritatis perspiciatis corporis delectus.	174.86	62	1	2025-08-03 17:52:40	2025-08-03 17:52:40
101	ad rerum dolore	Dolor dolorum eaque enim dolor eos nihil cumque voluptatem sunt qui porro libero.	714.70	94	2	2025-08-03 17:52:46	2025-08-03 17:52:46
102	quo quo aut	Fugit voluptatem excepturi tenetur dolores impedit officiis deleniti aut et sed corporis dolor.	100.61	52	2	2025-08-03 17:52:46	2025-08-03 17:52:46
103	distinctio tempore fugiat	Ducimus assumenda non tenetur fugiat aliquam magnam necessitatibus optio ullam blanditiis nulla.	824.12	94	2	2025-08-03 17:52:46	2025-08-03 17:52:46
104	minus dolores omnis	Autem dignissimos est reprehenderit nihil consequatur harum autem quae et nihil dicta inventore veritatis.	777.97	75	2	2025-08-03 17:52:46	2025-08-03 17:52:46
105	et facilis omnis	Omnis ea quasi suscipit ut delectus quos perferendis ea sit dolorem aut.	678.14	82	2	2025-08-03 17:52:46	2025-08-03 17:52:46
106	est accusamus laudantium	Pariatur eum voluptatem corporis debitis rerum atque sunt voluptatum et cupiditate ab.	842.72	85	2	2025-08-03 17:52:46	2025-08-03 17:52:46
107	et dicta dolor	Aut voluptate nulla voluptas fugit dolores et nisi.	525.78	67	2	2025-08-03 17:52:46	2025-08-03 17:52:46
108	id qui eaque	Accusantium qui veniam nisi magnam dicta eum ab accusantium sed.	33.77	42	2	2025-08-03 17:52:46	2025-08-03 17:52:46
109	aperiam dolore sed	Placeat quia ut maxime provident velit nesciunt harum.	408.20	75	2	2025-08-03 17:52:46	2025-08-03 17:52:46
110	enim repudiandae consectetur	Et non nulla odit ut nisi sit.	973.12	88	2	2025-08-03 17:52:46	2025-08-03 17:52:46
111	ut laborum iure	Voluptas enim veritatis ut nihil quibusdam aut deleniti quibusdam.	869.01	25	2	2025-08-03 17:52:46	2025-08-03 17:52:46
112	optio accusamus et	Inventore ab porro eveniet fugit at temporibus reiciendis eum neque maxime dicta.	970.09	30	2	2025-08-03 17:52:46	2025-08-03 17:52:46
113	iure deserunt velit	Beatae culpa ipsum aperiam quod est quasi voluptate eius quasi atque.	681.68	73	2	2025-08-03 17:52:46	2025-08-03 17:52:46
114	et rerum fuga	Eaque maiores dolores nihil optio sed laboriosam corporis ratione.	17.88	37	2	2025-08-03 17:52:46	2025-08-03 17:52:46
115	quam facere pariatur	Hic sapiente est possimus et sapiente ut non sint inventore est sit.	316.21	5	2	2025-08-03 17:52:46	2025-08-03 17:52:46
116	et voluptatibus recusandae	Quod vero animi aut illo quae qui asperiores.	646.87	21	2	2025-08-03 17:52:46	2025-08-03 17:52:46
117	omnis quis explicabo	Neque dolores omnis delectus iusto autem laborum sapiente vitae et.	112.02	71	2	2025-08-03 17:52:46	2025-08-03 17:52:46
118	quidem enim voluptates	Unde officiis iste est voluptas ratione expedita similique adipisci consequatur distinctio.	589.16	12	2	2025-08-03 17:52:46	2025-08-03 17:52:46
119	quis cumque excepturi	Nihil impedit aut laudantium est qui in quam modi non perspiciatis est voluptatibus natus.	616.78	68	2	2025-08-03 17:52:46	2025-08-03 17:52:46
120	voluptas facilis ex	Dignissimos voluptate ab ipsam tenetur vel qui vel cumque dolores voluptatem aperiam.	44.38	64	2	2025-08-03 17:52:46	2025-08-03 17:52:46
121	explicabo consequatur aperiam	Modi in libero delectus et porro veritatis est inventore accusantium et nihil.	276.97	4	2	2025-08-03 17:52:46	2025-08-03 17:52:46
122	est sapiente et	Similique necessitatibus vel at explicabo ipsam et qui architecto est autem officia et.	567.05	56	2	2025-08-03 17:52:46	2025-08-03 17:52:46
123	sunt ullam ut	Ipsum est accusantium qui eaque id consequatur saepe sit.	11.60	84	2	2025-08-03 17:52:46	2025-08-03 17:52:46
124	necessitatibus incidunt nisi	In praesentium quidem placeat aut laboriosam eligendi dolorem quas qui nihil ullam molestias.	546.10	7	2	2025-08-03 17:52:46	2025-08-03 17:52:46
125	natus modi quia	Corporis minima quidem animi sunt facilis nulla et sequi dolores omnis dolores quos.	308.31	25	2	2025-08-03 17:52:46	2025-08-03 17:52:46
126	sapiente ut odit	Perferendis possimus ut ad ipsum voluptas quia dicta inventore.	617.30	96	2	2025-08-03 17:52:46	2025-08-03 17:52:46
127	sint impedit veritatis	Accusantium totam sint consequatur iusto nisi et quos libero odit et voluptatem.	196.84	73	2	2025-08-03 17:52:46	2025-08-03 17:52:46
128	vero voluptas modi	Eos molestiae deserunt ea provident distinctio reiciendis et temporibus laudantium occaecati.	509.50	25	2	2025-08-03 17:52:46	2025-08-03 17:52:46
129	voluptas ipsum eum	Est assumenda voluptas voluptates accusantium vel maxime qui iure dolor.	916.40	14	2	2025-08-03 17:52:46	2025-08-03 17:52:46
130	debitis dolore in	Qui minus ut quos consequatur ut praesentium ipsam et a qui fugiat id eaque.	643.19	55	2	2025-08-03 17:52:46	2025-08-03 17:52:46
131	et blanditiis atque	Eum sequi aliquid omnis nostrum cumque est voluptatem hic impedit non.	106.08	15	2	2025-08-03 17:52:46	2025-08-03 17:52:46
132	eum a sapiente	Rerum voluptatem omnis eius rerum fugiat iusto dignissimos.	516.03	37	2	2025-08-03 17:52:46	2025-08-03 17:52:46
133	laudantium dolorum quibusdam	Labore neque et quasi neque rerum doloremque enim illum quia ipsam.	140.10	10	2	2025-08-03 17:52:46	2025-08-03 17:52:46
134	est tempore quos	Autem voluptatum odit ut ea sequi ipsum non mollitia dolor ut quo et corrupti.	847.13	43	2	2025-08-03 17:52:46	2025-08-03 17:52:46
135	vel architecto totam	Optio ducimus corporis explicabo nemo cumque nihil beatae aperiam mollitia consectetur est.	31.24	37	2	2025-08-03 17:52:46	2025-08-03 17:52:46
136	ut expedita et	Unde rerum officiis molestias occaecati et numquam inventore at consequatur veniam omnis consequatur.	605.06	42	2	2025-08-03 17:52:46	2025-08-03 17:52:46
137	maiores consectetur et	Ut sed culpa rem sint eos unde aliquid voluptatibus ut et debitis architecto sed.	385.25	3	2	2025-08-03 17:52:46	2025-08-03 17:52:46
138	deleniti officiis ut	Quisquam enim suscipit qui rem et doloremque ea dicta est et repellendus.	153.94	69	2	2025-08-03 17:52:46	2025-08-03 17:52:46
139	quo deserunt repellat	Minus at mollitia voluptas sit non id optio sint molestiae sapiente rem dolorem.	661.93	21	2	2025-08-03 17:52:46	2025-08-03 17:52:46
140	aut molestiae aut	Tempore quaerat omnis atque quibusdam deleniti debitis voluptatem soluta ut blanditiis.	777.01	33	2	2025-08-03 17:52:46	2025-08-03 17:52:46
141	quis id asperiores	Cumque sint eaque modi sunt nam magni fuga est.	223.15	100	2	2025-08-03 17:52:46	2025-08-03 17:52:46
142	natus sint molestias	Est quos quia eligendi ut dolores dolorum sit necessitatibus.	382.73	51	2	2025-08-03 17:52:46	2025-08-03 17:52:46
143	aut similique consectetur	Cumque sit facilis adipisci dicta autem ex quia eius voluptatem velit sed.	781.06	73	2	2025-08-03 17:52:46	2025-08-03 17:52:46
144	est odio nam	Voluptatum hic eveniet voluptatibus et hic ut nesciunt accusamus.	332.25	42	2	2025-08-03 17:52:46	2025-08-03 17:52:46
145	et asperiores laboriosam	Id voluptas quis et laborum esse debitis dolorem recusandae laudantium rem.	401.00	88	2	2025-08-03 17:52:46	2025-08-03 17:52:46
146	sunt nemo reiciendis	Qui expedita saepe dolor quia quo incidunt nam quaerat natus veniam dolore.	460.00	69	2	2025-08-03 17:52:46	2025-08-03 17:52:46
147	dolor voluptate modi	Quia deleniti asperiores perspiciatis deleniti quia sequi magnam dolore praesentium dolor.	117.75	30	2	2025-08-03 17:52:46	2025-08-03 17:52:46
148	omnis facilis repudiandae	Voluptates sint architecto perspiciatis quae ad dicta maiores dolores maiores.	935.54	36	2	2025-08-03 17:52:46	2025-08-03 17:52:46
149	autem debitis incidunt	Pariatur aut qui quam praesentium et est debitis distinctio sunt aut.	276.53	8	2	2025-08-03 17:52:46	2025-08-03 17:52:46
150	unde temporibus omnis	Exercitationem unde quo illum sunt quasi ab totam.	815.45	92	2	2025-08-03 17:52:46	2025-08-03 17:52:46
151	consequatur enim explicabo	Sint et dignissimos expedita minus tempora accusamus consectetur.	249.61	12	2	2025-08-03 17:52:46	2025-08-03 17:52:46
152	alias praesentium non	Doloremque laboriosam sequi minus laudantium ea quo qui voluptatem nihil.	490.11	88	2	2025-08-03 17:52:46	2025-08-03 17:52:46
153	nobis dolore quidem	Aliquid nobis qui quis iure quam dignissimos quos.	501.17	3	2	2025-08-03 17:52:46	2025-08-03 17:52:46
154	possimus sed nisi	Rerum perferendis voluptate sint similique voluptatem libero.	965.79	38	2	2025-08-03 17:52:46	2025-08-03 17:52:46
155	aut et non	Omnis esse sunt est delectus dolor et repudiandae labore dolores perspiciatis.	833.67	21	2	2025-08-03 17:52:46	2025-08-03 17:52:46
156	et error doloribus	Veritatis vero sunt dolores repudiandae veniam consectetur quis quia.	422.39	56	2	2025-08-03 17:52:46	2025-08-03 17:52:46
157	delectus earum rem	Quia a animi cumque placeat velit et inventore.	888.96	23	2	2025-08-03 17:52:46	2025-08-03 17:52:46
158	iusto voluptatum repellendus	Nemo consequatur quasi beatae consequatur nulla magnam voluptatum sequi omnis.	175.49	81	2	2025-08-03 17:52:46	2025-08-03 17:52:46
159	est voluptatem sit	Blanditiis quos consequatur nam ex adipisci non quis alias accusantium.	625.05	83	2	2025-08-03 17:52:46	2025-08-03 17:52:46
160	excepturi vero odit	Sit sunt omnis exercitationem dolorem quod velit illo.	788.89	13	2	2025-08-03 17:52:46	2025-08-03 17:52:46
161	maxime eaque pariatur	Doloribus quis ut omnis et voluptas et dolores exercitationem minima quia cumque et.	144.62	29	2	2025-08-03 17:52:46	2025-08-03 17:52:46
162	magni porro et	Aliquam laboriosam optio nihil et dolore et debitis doloremque qui enim.	697.76	22	2	2025-08-03 17:52:46	2025-08-03 17:52:46
163	enim et architecto	Ab adipisci cum eum culpa odio voluptatem fugit qui eius.	834.76	33	2	2025-08-03 17:52:46	2025-08-03 17:52:46
164	autem aut voluptatem	Repellendus qui quisquam fugiat quis harum aut amet.	188.14	92	2	2025-08-03 17:52:46	2025-08-03 17:52:46
165	qui eligendi nobis	Hic maiores beatae esse et non velit.	961.38	58	2	2025-08-03 17:52:46	2025-08-03 17:52:46
166	in adipisci tempore	Libero consequuntur nulla quisquam et alias sunt fugit soluta et harum est reiciendis.	119.85	33	2	2025-08-03 17:52:46	2025-08-03 17:52:46
167	rerum aut earum	Nostrum sunt non at perspiciatis iste vero at quisquam ea quidem vero animi et.	655.03	0	2	2025-08-03 17:52:46	2025-08-03 17:52:46
168	non velit dolorem	Aut temporibus accusantium nesciunt maiores odio consequatur.	896.14	25	2	2025-08-03 17:52:46	2025-08-03 17:52:46
169	libero corrupti ipsum	Rerum nulla tempore architecto dolores placeat ea ut autem quidem veritatis placeat illo.	775.92	13	2	2025-08-03 17:52:46	2025-08-03 17:52:46
170	vitae et molestiae	Blanditiis recusandae qui ducimus rerum id commodi eos doloribus corrupti sed blanditiis.	807.74	26	2	2025-08-03 17:52:46	2025-08-03 17:52:46
171	ea officia nobis	Sunt dolorem amet saepe totam iste quo.	866.53	80	2	2025-08-03 17:52:46	2025-08-03 17:52:46
172	architecto cumque consequuntur	Voluptas fuga voluptatem quae numquam exercitationem neque sint ducimus saepe quia.	445.59	50	2	2025-08-03 17:52:46	2025-08-03 17:52:46
173	velit expedita natus	Non eos id similique voluptatem cupiditate voluptatem quia sed quod perferendis quisquam officia aut.	608.58	37	2	2025-08-03 17:52:46	2025-08-03 17:52:46
174	error totam deleniti	Necessitatibus dolorem maxime illum unde dolores quasi quia voluptates nisi et.	247.42	90	2	2025-08-03 17:52:46	2025-08-03 17:52:46
175	suscipit ea facere	Repellendus magni cumque quos qui sit ad eos incidunt laboriosam.	320.33	3	2	2025-08-03 17:52:46	2025-08-03 17:52:46
176	quasi sit voluptas	Consequatur vel nam occaecati porro quaerat eos at et iure impedit.	309.63	7	2	2025-08-03 17:52:46	2025-08-03 17:52:46
177	nobis eum quidem	Quae iusto alias blanditiis culpa minus reiciendis aut doloribus sit dolore.	601.13	97	2	2025-08-03 17:52:46	2025-08-03 17:52:46
178	magni labore maxime	Et aut hic vitae aut eum soluta reiciendis quo delectus.	149.32	5	2	2025-08-03 17:52:46	2025-08-03 17:52:46
179	et aut doloremque	Non eaque non quo recusandae aut dolor molestiae placeat harum necessitatibus qui qui non.	72.18	20	2	2025-08-03 17:52:46	2025-08-03 17:52:46
180	consequatur aspernatur sed	Autem laudantium soluta quia et odio ut qui.	709.43	24	2	2025-08-03 17:52:46	2025-08-03 17:52:46
181	et adipisci ut	Consequuntur officia odio aut ea consequatur cupiditate sed harum.	244.85	21	2	2025-08-03 17:52:46	2025-08-03 17:52:46
182	saepe aut inventore	Atque ipsam exercitationem dolore dolor atque nesciunt eius distinctio vel error tenetur.	282.63	65	2	2025-08-03 17:52:46	2025-08-03 17:52:46
183	consequuntur suscipit minima	Iste et magni enim et nam sunt vel quam sit eligendi magni quo omnis.	262.10	57	2	2025-08-03 17:52:46	2025-08-03 17:52:46
184	voluptatibus quia molestias	Dolor ut sed cum id et eos aspernatur quos quis dolores.	773.31	29	2	2025-08-03 17:52:46	2025-08-03 17:52:46
185	quis itaque occaecati	Incidunt eos itaque iusto quaerat porro a autem.	849.39	50	2	2025-08-03 17:52:46	2025-08-03 17:52:46
186	impedit in quia	Commodi dolores unde dolorem animi omnis distinctio nisi qui.	131.03	50	2	2025-08-03 17:52:46	2025-08-03 17:52:46
187	autem officiis quod	Voluptas quam quas dolor labore itaque exercitationem reiciendis id repellat non saepe.	759.44	50	2	2025-08-03 17:52:46	2025-08-03 17:52:46
188	est et minus	Ea cumque dolor non beatae dolor in facere quasi natus.	741.80	58	2	2025-08-03 17:52:46	2025-08-03 17:52:46
189	accusantium ex pariatur	Rerum libero cupiditate id tempora quo et aut eveniet reiciendis architecto vel delectus.	58.42	28	2	2025-08-03 17:52:46	2025-08-03 17:52:46
190	odio qui quibusdam	Voluptatibus quae sed eligendi possimus accusamus et inventore est sit enim illo voluptatem voluptas.	607.26	36	2	2025-08-03 17:52:46	2025-08-03 17:52:46
191	suscipit quasi possimus	Adipisci ipsa dolor qui nostrum quia iste minus laboriosam et ipsa nesciunt dolorum error.	815.55	10	2	2025-08-03 17:52:46	2025-08-03 17:52:46
192	doloremque illum facilis	Incidunt quasi assumenda ut perspiciatis occaecati illum et.	166.61	90	2	2025-08-03 17:52:46	2025-08-03 17:52:46
193	voluptas saepe repellat	Rem voluptas inventore recusandae nisi laborum tenetur.	352.69	99	2	2025-08-03 17:52:46	2025-08-03 17:52:46
194	dolorem natus accusamus	Et quam facere nam et velit officiis dolorem quibusdam praesentium.	890.85	40	2	2025-08-03 17:52:46	2025-08-03 17:52:46
195	magni temporibus porro	Est aut doloremque optio libero fugiat veritatis rem vel.	538.03	19	2	2025-08-03 17:52:46	2025-08-03 17:52:46
196	placeat harum culpa	Fuga occaecati quia inventore nemo voluptas illum unde soluta provident.	405.55	39	2	2025-08-03 17:52:46	2025-08-03 17:52:46
197	quo modi quia	Et est ipsam dolore cupiditate aperiam sequi hic ut vitae maxime dolores voluptas id.	972.84	43	2	2025-08-03 17:52:46	2025-08-03 17:52:46
198	cum dolore nam	Rerum recusandae ut quo officia eligendi iure autem et.	355.02	79	2	2025-08-03 17:52:46	2025-08-03 17:52:46
199	quaerat delectus dolor	Sint ducimus autem odio consequuntur aut incidunt ipsa illum eum.	409.79	33	2	2025-08-03 17:52:46	2025-08-03 17:52:46
200	ipsam maiores eligendi	Quo veritatis cumque non rerum dignissimos animi ut.	784.54	15	2	2025-08-03 17:52:46	2025-08-03 17:52:46
201	voluptates voluptatum assumenda	Neque sapiente aliquam harum est molestiae et labore inventore minima aspernatur quia dolorem modi.	437.81	93	3	2025-08-03 17:52:49	2025-08-03 17:52:49
202	consectetur et voluptas	Voluptas sunt nobis impedit necessitatibus omnis laborum itaque reiciendis.	626.51	52	3	2025-08-03 17:52:49	2025-08-03 17:52:49
203	sed voluptatibus facere	Laboriosam nihil quo aut porro dolores maxime.	551.31	94	3	2025-08-03 17:52:49	2025-08-03 17:52:49
204	explicabo autem et	Maxime sunt dolores repellat corrupti qui sed et sunt pariatur.	671.81	60	3	2025-08-03 17:52:49	2025-08-03 17:52:49
205	vel quam vel	Mollitia impedit voluptatem dolorem cumque quidem placeat.	142.40	70	3	2025-08-03 17:52:49	2025-08-03 17:52:49
206	atque laborum mollitia	Eos ut modi dolore est sed quam.	635.71	46	3	2025-08-03 17:52:49	2025-08-03 17:52:49
207	vitae dolorem unde	Porro ea ea ut odio dolor consequatur sequi possimus quo qui qui earum.	580.15	6	3	2025-08-03 17:52:49	2025-08-03 17:52:49
208	ea possimus aut	Perferendis molestias ullam facilis omnis at molestias.	176.57	59	3	2025-08-03 17:52:49	2025-08-03 17:52:49
209	quod neque earum	Incidunt eligendi quia omnis dolor accusantium rem ut.	41.97	60	3	2025-08-03 17:52:49	2025-08-03 17:52:49
210	a ut perferendis	Qui ab et dolor aperiam non aut quia et eius.	402.57	30	3	2025-08-03 17:52:49	2025-08-03 17:52:49
211	dolor laborum magni	Minus ratione qui consequatur quod aperiam ab aut optio eum cumque unde voluptatem.	231.00	1	3	2025-08-03 17:52:49	2025-08-03 17:52:49
212	eveniet molestiae culpa	Consequatur eos sunt atque error est amet debitis iste delectus sit.	444.81	63	3	2025-08-03 17:52:49	2025-08-03 17:52:49
213	fuga et et	Ea sint et accusamus eaque vel vero non cupiditate recusandae quidem iure ea odit minima.	772.61	67	3	2025-08-03 17:52:49	2025-08-03 17:52:49
214	corporis voluptatum incidunt	Explicabo dolores illum nam possimus sed fugit.	584.97	33	3	2025-08-03 17:52:49	2025-08-03 17:52:49
215	voluptate fuga deleniti	Quaerat aut iusto nihil quae in rerum.	965.27	4	3	2025-08-03 17:52:49	2025-08-03 17:52:49
216	vero tempora quo	Illo exercitationem veniam odio quae est minima culpa.	347.19	66	3	2025-08-03 17:52:49	2025-08-03 17:52:49
217	repudiandae dignissimos ab	Eveniet ullam repellat est repudiandae quae maiores ullam.	330.86	6	3	2025-08-03 17:52:49	2025-08-03 17:52:49
218	et placeat quibusdam	Perspiciatis veritatis quo et adipisci quisquam molestias et fugit qui et laboriosam ut.	512.07	36	3	2025-08-03 17:52:49	2025-08-03 17:52:49
219	non expedita qui	Saepe vel consectetur sit ut cum quibusdam in vitae quibusdam corrupti illum asperiores voluptatem.	106.75	31	3	2025-08-03 17:52:49	2025-08-03 17:52:49
220	beatae voluptatem enim	Consectetur soluta debitis commodi repellendus iste sunt molestiae animi fuga.	967.44	34	3	2025-08-03 17:52:49	2025-08-03 17:52:49
221	voluptatem omnis dolor	Minima aspernatur eos aspernatur totam vel architecto delectus.	959.93	15	3	2025-08-03 17:52:49	2025-08-03 17:52:49
222	est ex et	Dolorem officiis voluptatum commodi voluptatem ad vero ipsum sint eligendi.	971.47	15	3	2025-08-03 17:52:49	2025-08-03 17:52:49
223	totam quis quo	Quasi recusandae quis a amet rem dolore.	497.81	50	3	2025-08-03 17:52:49	2025-08-03 17:52:49
224	soluta quae distinctio	Dolor eligendi facere saepe atque quos sapiente.	469.38	96	3	2025-08-03 17:52:49	2025-08-03 17:52:49
225	numquam non nulla	Laboriosam sed alias aut magni culpa officiis dolorem architecto.	743.32	31	3	2025-08-03 17:52:49	2025-08-03 17:52:49
226	aut ut tenetur	Id praesentium itaque eius officia ab nulla natus nobis omnis eveniet.	427.19	43	3	2025-08-03 17:52:49	2025-08-03 17:52:49
227	officia autem laudantium	Animi voluptatum et officiis perspiciatis omnis cupiditate animi.	634.73	17	3	2025-08-03 17:52:49	2025-08-03 17:52:49
228	quis est earum	Dolor nesciunt deleniti voluptatum reiciendis repudiandae odio sequi blanditiis expedita officiis.	964.37	46	3	2025-08-03 17:52:49	2025-08-03 17:52:49
229	nulla delectus eaque	Id adipisci qui assumenda quia ut dolor temporibus dolores explicabo architecto et.	172.04	85	3	2025-08-03 17:52:49	2025-08-03 17:52:49
230	cupiditate temporibus est	Quidem maiores quod quis rem temporibus error sed hic est autem necessitatibus rerum.	533.77	68	3	2025-08-03 17:52:49	2025-08-03 17:52:49
231	natus nostrum dolores	Ipsa debitis et ullam blanditiis blanditiis omnis sed.	268.97	8	3	2025-08-03 17:52:49	2025-08-03 17:52:49
232	illum enim aut	Ipsa quo aspernatur pariatur recusandae vitae voluptas.	705.95	51	3	2025-08-03 17:52:49	2025-08-03 17:52:49
233	consectetur odio ipsam	Itaque adipisci et non enim voluptatem explicabo perspiciatis maiores optio ut ab rem architecto.	332.56	1	3	2025-08-03 17:52:49	2025-08-03 17:52:49
234	fugiat et nisi	Placeat quia maxime aut nisi nihil ipsum eos recusandae animi esse nemo provident ab.	505.90	97	3	2025-08-03 17:52:49	2025-08-03 17:52:49
235	cupiditate enim molestiae	Aut iste iste et sint est nihil rerum.	72.47	73	3	2025-08-03 17:52:49	2025-08-03 17:52:49
236	et inventore magnam	Modi commodi nulla illo non pariatur reiciendis quae rem amet mollitia ullam ipsam.	610.36	91	3	2025-08-03 17:52:49	2025-08-03 17:52:49
237	sed provident quos	Ratione sed libero ea maiores distinctio et a aut voluptas fugit repellat eveniet voluptatem.	795.07	31	3	2025-08-03 17:52:49	2025-08-03 17:52:49
238	est similique voluptate	Soluta ea officiis suscipit similique inventore at deserunt sapiente tenetur officiis.	228.93	44	3	2025-08-03 17:52:49	2025-08-03 17:52:49
239	consequatur explicabo dignissimos	Ut suscipit ut vero consectetur rem facere nihil est et dolore est reiciendis molestias repudiandae.	814.41	1	3	2025-08-03 17:52:49	2025-08-03 17:52:49
240	molestiae voluptatem quo	Enim blanditiis atque quis qui ut laboriosam laborum ad sequi nisi aut voluptatem.	35.37	31	3	2025-08-03 17:52:49	2025-08-03 17:52:49
241	est quam praesentium	Perferendis eius quia quasi suscipit velit quia odit excepturi quo eum.	397.40	68	3	2025-08-03 17:52:49	2025-08-03 17:52:49
242	in quo eligendi	Consequuntur quo veniam dignissimos voluptatem et voluptatem deserunt.	529.99	34	3	2025-08-03 17:52:49	2025-08-03 17:52:49
243	et est ratione	Quam illum totam quam at qui nobis facere.	759.69	11	3	2025-08-03 17:52:49	2025-08-03 17:52:49
244	placeat maxime quia	Natus ad et consectetur nostrum est consequatur iusto vel aliquid.	472.90	33	3	2025-08-03 17:52:49	2025-08-03 17:52:49
245	adipisci nisi delectus	Eum qui non consequatur fugit deserunt enim porro dolores ut.	309.61	40	3	2025-08-03 17:52:49	2025-08-03 17:52:49
246	facere nihil est	Rerum doloribus eveniet quia rem dolor consectetur magnam iste harum debitis.	914.63	23	3	2025-08-03 17:52:49	2025-08-03 17:52:49
247	natus quidem rerum	Rerum explicabo voluptatem ut reprehenderit ut culpa at.	658.34	73	3	2025-08-03 17:52:49	2025-08-03 17:52:49
248	incidunt eaque eligendi	Totam tenetur nisi eum sunt aspernatur sed consectetur sint illum.	944.72	76	3	2025-08-03 17:52:49	2025-08-03 17:52:49
249	dolores commodi et	Omnis ex accusamus praesentium debitis quo laudantium.	854.74	29	3	2025-08-03 17:52:49	2025-08-03 17:52:49
250	iure est voluptatem	Enim similique dolorum sint sapiente fugit vel est ut natus dolorem sapiente veritatis laborum.	415.63	89	3	2025-08-03 17:52:49	2025-08-03 17:52:49
251	dolorem ut adipisci	Tempora natus et repudiandae ducimus ex quo quis cupiditate.	519.80	57	3	2025-08-03 17:52:49	2025-08-03 17:52:49
252	omnis sint voluptas	Quibusdam ex aut et deserunt sequi ab est eum maxime omnis.	412.24	48	3	2025-08-03 17:52:49	2025-08-03 17:52:49
253	itaque aut ipsa	Fuga molestias tempore ad nihil sit et cupiditate eaque est perspiciatis.	236.24	78	3	2025-08-03 17:52:49	2025-08-03 17:52:49
254	repellat et cum	Sit sit veritatis reiciendis ipsum non repudiandae assumenda aut voluptatibus qui tenetur.	476.22	46	3	2025-08-03 17:52:49	2025-08-03 17:52:49
255	error alias ratione	Cum qui aut quo explicabo dolor similique eligendi accusamus non itaque natus qui.	911.11	15	3	2025-08-03 17:52:49	2025-08-03 17:52:49
256	vero dolores molestiae	Incidunt voluptatem voluptas temporibus est voluptates tempora ipsam.	376.15	17	3	2025-08-03 17:52:49	2025-08-03 17:52:49
257	corrupti aut ad	Hic sit minus vitae provident eius corporis.	927.09	25	3	2025-08-03 17:52:49	2025-08-03 17:52:49
258	facilis beatae aut	Rerum consequatur aperiam iusto cupiditate veritatis voluptate ipsam soluta labore.	380.95	65	3	2025-08-03 17:52:49	2025-08-03 17:52:49
259	molestias nam vitae	Doloremque rerum corrupti libero rerum laborum eum consequatur consequuntur eos dolorem id aut excepturi.	594.86	67	3	2025-08-03 17:52:49	2025-08-03 17:52:49
260	eaque rem qui	Rerum excepturi quasi perferendis modi corporis iste non illo ea officia inventore.	606.55	69	3	2025-08-03 17:52:49	2025-08-03 17:52:49
261	officia eos ab	Veritatis nulla sit dolorem quia impedit qui quam.	616.50	60	3	2025-08-03 17:52:49	2025-08-03 17:52:49
262	aut sed rerum	Molestiae enim praesentium qui incidunt nulla aspernatur quia.	280.26	72	3	2025-08-03 17:52:49	2025-08-03 17:52:49
263	eos animi eveniet	Enim tenetur dolore qui repudiandae possimus occaecati enim itaque.	112.84	7	3	2025-08-03 17:52:49	2025-08-03 17:52:49
264	repudiandae aut est	Ut quisquam non mollitia ea quos autem voluptatem illo mollitia at corrupti neque.	168.42	79	3	2025-08-03 17:52:49	2025-08-03 17:52:49
265	voluptatibus assumenda iusto	Est doloribus ex ut perspiciatis omnis et aut accusantium harum veritatis.	721.40	69	3	2025-08-03 17:52:49	2025-08-03 17:52:49
266	voluptatum omnis natus	Ut nostrum voluptas delectus doloremque non assumenda fugiat in molestiae qui.	771.63	17	3	2025-08-03 17:52:49	2025-08-03 17:52:49
267	alias qui error	Ea rem ut enim rerum minima unde deserunt ipsa ab.	894.46	79	3	2025-08-03 17:52:49	2025-08-03 17:52:49
268	non commodi laudantium	Et quod est eius rerum sapiente necessitatibus.	88.96	70	3	2025-08-03 17:52:49	2025-08-03 17:52:49
269	ut deserunt praesentium	Corrupti est voluptatem explicabo temporibus unde eveniet quaerat ducimus.	986.30	92	3	2025-08-03 17:52:49	2025-08-03 17:52:49
270	animi modi ut	Corporis voluptatem eos rerum voluptatem autem in vel.	723.20	100	3	2025-08-03 17:52:49	2025-08-03 17:52:49
271	error molestias velit	Incidunt doloremque libero sed eligendi tenetur totam iste dolor neque.	891.91	99	3	2025-08-03 17:52:49	2025-08-03 17:52:49
272	porro vel rem	Quis non quia illum vel aliquam reiciendis cupiditate et quis quisquam eius.	726.62	94	3	2025-08-03 17:52:49	2025-08-03 17:52:49
273	doloribus eligendi repellendus	Et odio ipsum ut modi itaque fugiat est aut.	680.34	51	3	2025-08-03 17:52:49	2025-08-03 17:52:49
274	sit voluptas fuga	Dicta officiis omnis placeat quae ratione ratione iusto ad omnis error modi nihil ad.	392.86	53	3	2025-08-03 17:52:49	2025-08-03 17:52:49
275	ut autem officia	Impedit dolores repellendus perferendis quam corporis maiores est iusto inventore est autem.	904.96	40	3	2025-08-03 17:52:49	2025-08-03 17:52:49
276	assumenda ut nam	Et voluptate deserunt dolor aut facere id.	423.71	78	3	2025-08-03 17:52:49	2025-08-03 17:52:49
277	corrupti illum sit	Provident est eum et repellendus voluptatibus sapiente.	283.79	78	3	2025-08-03 17:52:49	2025-08-03 17:52:49
278	numquam voluptas quia	Possimus delectus aut repellat sunt et dignissimos dignissimos est harum perspiciatis reiciendis ullam placeat.	243.48	57	3	2025-08-03 17:52:49	2025-08-03 17:52:49
279	aut consequuntur in	Aut atque pariatur assumenda ut quaerat laudantium quod sit eveniet et ut.	698.97	94	3	2025-08-03 17:52:49	2025-08-03 17:52:49
280	quia quidem cupiditate	Totam laboriosam dolorum sequi veniam itaque autem corporis.	61.25	22	3	2025-08-03 17:52:49	2025-08-03 17:52:49
281	eum dolores repudiandae	Quo tempore sint porro quia dicta dolores voluptate ut necessitatibus.	790.07	68	3	2025-08-03 17:52:49	2025-08-03 17:52:49
282	neque qui id	Doloremque voluptas provident cumque porro et et.	83.89	100	3	2025-08-03 17:52:49	2025-08-03 17:52:49
283	incidunt vitae ut	Blanditiis perferendis eligendi occaecati maiores est soluta excepturi cumque debitis.	971.01	14	3	2025-08-03 17:52:49	2025-08-03 17:52:49
284	reiciendis reiciendis et	Ut placeat placeat qui totam placeat placeat vero neque sit quos nisi.	729.25	81	3	2025-08-03 17:52:49	2025-08-03 17:52:49
285	aut optio aut	Minima incidunt et consequatur qui autem consequatur voluptate ut.	325.88	77	3	2025-08-03 17:52:49	2025-08-03 17:52:49
286	nemo magni molestias	Cumque molestiae molestiae aut accusamus et in repellendus ab explicabo et aliquid quisquam qui ut.	164.80	81	3	2025-08-03 17:52:49	2025-08-03 17:52:49
287	cupiditate minima quasi	Enim quam quibusdam fuga odit excepturi voluptas eaque veritatis natus.	329.88	89	3	2025-08-03 17:52:49	2025-08-03 17:52:49
288	odit natus qui	Possimus omnis omnis reprehenderit quidem porro sed voluptatem aperiam rem quo quidem tempore est.	434.20	80	3	2025-08-03 17:52:49	2025-08-03 17:52:49
289	facilis dolorem vel	Natus distinctio veritatis minima tempora quam doloremque dolorem consequatur.	41.05	91	3	2025-08-03 17:52:49	2025-08-03 17:52:49
290	eaque dolore voluptatum	Unde enim saepe fugiat repellendus et odit ipsa facilis sequi nemo.	810.59	65	3	2025-08-03 17:52:49	2025-08-03 17:52:49
291	nam ut voluptatem	Sit sit numquam quibusdam ducimus libero et temporibus repellat.	899.89	85	3	2025-08-03 17:52:49	2025-08-03 17:52:49
292	rerum ratione possimus	Repudiandae ducimus excepturi non fugiat non culpa.	722.92	21	3	2025-08-03 17:52:49	2025-08-03 17:52:49
293	unde modi excepturi	Error quo porro ut deserunt sunt voluptatem sit praesentium inventore veritatis.	149.79	61	3	2025-08-03 17:52:49	2025-08-03 17:52:49
294	facilis voluptas eaque	Adipisci voluptatem est reprehenderit officiis dolor eveniet aut.	317.81	33	3	2025-08-03 17:52:49	2025-08-03 17:52:49
295	sapiente doloremque alias	Eum cumque maxime unde corporis saepe accusamus maxime odit et ut fugit numquam ut.	810.86	78	3	2025-08-03 17:52:49	2025-08-03 17:52:49
296	ratione vel in	Odio tempore sed sint vitae nulla quia iure voluptatem ut.	883.21	48	3	2025-08-03 17:52:49	2025-08-03 17:52:49
297	provident tempora ipsam	Aliquam minima minima ea asperiores doloribus cum error consequatur.	716.19	78	3	2025-08-03 17:52:49	2025-08-03 17:52:49
298	enim illum sint	Non reprehenderit magnam et omnis sint nihil harum pariatur esse voluptatibus quae et.	221.88	58	3	2025-08-03 17:52:49	2025-08-03 17:52:49
299	eos sit et	Harum accusamus officia voluptate blanditiis rem delectus inventore et aut minima ipsam error.	101.91	87	3	2025-08-03 17:52:49	2025-08-03 17:52:49
300	nisi ipsam expedita	Officia eius ab qui vitae aperiam assumenda pariatur.	626.70	2	3	2025-08-03 17:52:49	2025-08-03 17:52:49
301	et nostrum aut	Sed iusto autem voluptas dolorem officia nisi non aut hic et fugiat.	156.24	39	4	2025-08-03 17:52:53	2025-08-03 17:52:53
302	odit quis ut	Voluptatem ipsum fuga rerum ipsam cupiditate vero voluptas omnis at facere vel rerum aut.	202.43	82	4	2025-08-03 17:52:53	2025-08-03 17:52:53
303	et voluptate perspiciatis	In quis perspiciatis culpa modi itaque iusto ut.	568.94	95	4	2025-08-03 17:52:53	2025-08-03 17:52:53
304	voluptatem a voluptates	Deserunt voluptatem amet voluptates debitis non corporis magni nisi similique sunt magni odio at laboriosam.	835.97	13	4	2025-08-03 17:52:53	2025-08-03 17:52:53
305	est tenetur minus	Quo at consequatur harum dolores dolores voluptas rerum rerum explicabo.	340.00	69	4	2025-08-03 17:52:53	2025-08-03 17:52:53
306	aut quisquam quia	Sit nihil aut consequuntur quis nisi facere ad reprehenderit.	359.32	33	4	2025-08-03 17:52:53	2025-08-03 17:52:53
307	sed ab corrupti	Distinctio saepe rerum doloribus officiis quisquam eum cupiditate voluptatem non quia nostrum qui nulla.	658.38	90	4	2025-08-03 17:52:53	2025-08-03 17:52:53
308	harum impedit enim	Nihil quasi itaque ut qui enim doloremque.	777.77	32	4	2025-08-03 17:52:53	2025-08-03 17:52:53
309	perspiciatis nemo reiciendis	Deserunt quae occaecati libero velit tempora occaecati assumenda perspiciatis quaerat quia hic ipsum consequatur.	354.19	79	4	2025-08-03 17:52:53	2025-08-03 17:52:53
310	laudantium omnis est	Nam eum quis sapiente autem voluptatum consequuntur temporibus molestiae consequatur molestiae et id.	100.68	79	4	2025-08-03 17:52:53	2025-08-03 17:52:53
311	molestias vero ducimus	Velit quia commodi ut dicta enim unde deserunt sunt iste magni.	624.66	19	4	2025-08-03 17:52:53	2025-08-03 17:52:53
312	autem itaque illo	Voluptatum qui adipisci fuga dolorem id porro est qui est incidunt est.	368.34	36	4	2025-08-03 17:52:53	2025-08-03 17:52:53
313	maxime esse nostrum	Id temporibus voluptatem veritatis provident sequi ut dolor ullam ducimus.	923.67	28	4	2025-08-03 17:52:53	2025-08-03 17:52:53
314	sit nisi est	Praesentium amet voluptas qui id rerum reprehenderit eos amet.	76.94	98	4	2025-08-03 17:52:53	2025-08-03 17:52:53
315	ut est deserunt	Excepturi eligendi provident et autem magni atque.	418.85	68	4	2025-08-03 17:52:53	2025-08-03 17:52:53
316	est alias veritatis	Voluptatem hic qui nisi quae aut eum dolore voluptas possimus et perspiciatis natus laboriosam.	75.49	56	4	2025-08-03 17:52:53	2025-08-03 17:52:53
317	quasi alias dolores	Ullam ut et ipsam autem mollitia voluptatem perspiciatis quos distinctio totam repellat quo.	37.86	95	4	2025-08-03 17:52:53	2025-08-03 17:52:53
318	sit possimus repellat	Sed harum et eligendi recusandae ex velit.	53.32	54	4	2025-08-03 17:52:53	2025-08-03 17:52:53
319	consequuntur pariatur adipisci	Et assumenda officia vero qui omnis nihil numquam veniam vitae eveniet occaecati.	179.79	48	4	2025-08-03 17:52:53	2025-08-03 17:52:53
320	sunt voluptas molestias	Quia eligendi nam architecto placeat repudiandae voluptatem qui.	838.73	72	4	2025-08-03 17:52:53	2025-08-03 17:52:53
321	aut culpa non	Voluptas impedit explicabo in natus fugit odio qui sit quasi in maxime ut.	612.95	3	4	2025-08-03 17:52:53	2025-08-03 17:52:53
322	est incidunt nemo	Iusto quos deserunt atque maiores aut totam ducimus pariatur beatae beatae exercitationem rerum iste.	728.03	86	4	2025-08-03 17:52:53	2025-08-03 17:52:53
323	dolorum dignissimos consequatur	Praesentium voluptatem autem quod ut culpa tempora aliquam est necessitatibus necessitatibus culpa.	902.67	58	4	2025-08-03 17:52:53	2025-08-03 17:52:53
324	ad expedita distinctio	Quo voluptatem nostrum inventore laudantium nemo officiis est distinctio sed voluptatum atque voluptatem est.	816.10	23	4	2025-08-03 17:52:53	2025-08-03 17:52:53
325	nam doloremque eos	Corporis aut facere voluptate et suscipit esse et.	528.96	100	4	2025-08-03 17:52:53	2025-08-03 17:52:53
326	ea dicta est	Magni voluptatem voluptatem saepe impedit id quam perferendis eum pariatur laboriosam tempore.	967.99	15	4	2025-08-03 17:52:53	2025-08-03 17:52:53
327	nihil ad dolor	Minus enim sit minus fugiat eum ipsum et animi sint.	315.71	77	4	2025-08-03 17:52:53	2025-08-03 17:52:53
328	numquam est repellat	Et eos nihil expedita nisi ex sunt quidem vel facilis officia sint molestias.	420.91	9	4	2025-08-03 17:52:54	2025-08-03 17:52:54
329	qui doloremque non	Omnis facilis nihil aliquid quos nam illo rerum.	624.54	17	4	2025-08-03 17:52:54	2025-08-03 17:52:54
330	illo animi nam	Molestias rerum quisquam et corrupti maxime non repellat non.	343.45	42	4	2025-08-03 17:52:54	2025-08-03 17:52:54
331	minus quisquam soluta	Delectus tenetur et voluptas consequuntur distinctio repellendus minima et ratione voluptatum occaecati aspernatur ipsam.	101.85	37	4	2025-08-03 17:52:54	2025-08-03 17:52:54
332	porro in neque	Sint eos odio sit ut ducimus vel harum et cupiditate itaque numquam rerum optio.	590.09	21	4	2025-08-03 17:52:54	2025-08-03 17:52:54
333	est earum porro	Magni non aut incidunt blanditiis rem enim.	400.99	5	4	2025-08-03 17:52:54	2025-08-03 17:52:54
334	dicta doloribus nam	Placeat consequuntur libero nostrum et odit quam voluptates accusantium et eveniet non libero.	284.51	54	4	2025-08-03 17:52:54	2025-08-03 17:52:54
335	recusandae tempore est	Atque nemo nemo repellendus facere perferendis tenetur quisquam velit quia impedit.	201.48	96	4	2025-08-03 17:52:54	2025-08-03 17:52:54
336	voluptates iusto hic	Nisi cupiditate perferendis praesentium quo dolorem vel reprehenderit illum.	51.96	73	4	2025-08-03 17:52:54	2025-08-03 17:52:54
337	autem illum qui	Minus ut at qui vel non et a asperiores enim deserunt non.	824.66	78	4	2025-08-03 17:52:54	2025-08-03 17:52:54
338	amet fugiat maxime	Tempore aperiam est hic perferendis deleniti non dolorem non dolores.	983.22	15	4	2025-08-03 17:52:54	2025-08-03 17:52:54
339	aut voluptatem debitis	Reprehenderit deleniti rerum quos qui quae modi aspernatur et.	194.20	98	4	2025-08-03 17:52:54	2025-08-03 17:52:54
340	sed facere sint	Modi quasi aut animi totam impedit rerum dolorem et veritatis.	802.68	32	4	2025-08-03 17:52:54	2025-08-03 17:52:54
341	possimus fugit est	Eos perspiciatis quae quod sed similique quo tenetur.	847.87	27	4	2025-08-03 17:52:54	2025-08-03 17:52:54
342	id assumenda magni	Voluptatibus totam ipsa velit asperiores magni sint.	105.45	96	4	2025-08-03 17:52:54	2025-08-03 17:52:54
343	culpa ut labore	Autem voluptatem aut et et qui nam qui.	376.64	27	4	2025-08-03 17:52:54	2025-08-03 17:52:54
344	quia quos ut	Accusantium aperiam corrupti iste cum quam molestiae rerum architecto sed tempora.	944.98	67	4	2025-08-03 17:52:54	2025-08-03 17:52:54
345	a eum cumque	Neque dicta error earum ipsa quis quas consequatur id maiores.	567.67	0	4	2025-08-03 17:52:54	2025-08-03 17:52:54
346	excepturi voluptatem accusamus	Quo ut minus doloribus reprehenderit voluptatem aliquid blanditiis veritatis.	974.60	24	4	2025-08-03 17:52:54	2025-08-03 17:52:54
347	pariatur et quis	Maxime qui praesentium ea et dicta incidunt cupiditate accusantium aliquam nesciunt sed.	598.32	54	4	2025-08-03 17:52:54	2025-08-03 17:52:54
348	sequi ut eos	Nam culpa veritatis voluptatem assumenda minima quia incidunt quidem dolores.	90.00	74	4	2025-08-03 17:52:54	2025-08-03 17:52:54
349	dolorum nemo placeat	Voluptas culpa autem praesentium et molestiae sapiente mollitia ipsa voluptatem veritatis non voluptas sint.	506.10	48	4	2025-08-03 17:52:54	2025-08-03 17:52:54
350	illo autem impedit	Nihil id iste qui pariatur sapiente voluptatem laborum sed molestias blanditiis accusantium aspernatur mollitia.	975.78	98	4	2025-08-03 17:52:54	2025-08-03 17:52:54
351	aliquid adipisci qui	Enim aliquid est ducimus sed omnis esse quaerat debitis fugit doloribus rem quia.	994.22	15	4	2025-08-03 17:52:54	2025-08-03 17:52:54
352	autem ut modi	Quia repellat culpa iusto aut labore velit ut nostrum.	101.73	95	4	2025-08-03 17:52:54	2025-08-03 17:52:54
353	sit odio unde	Occaecati possimus qui magni aut sit occaecati neque nostrum et nam numquam quia.	614.41	41	4	2025-08-03 17:52:54	2025-08-03 17:52:54
354	accusantium labore iste	Quos occaecati nesciunt enim nihil tempore et iste excepturi.	244.31	13	4	2025-08-03 17:52:54	2025-08-03 17:52:54
355	beatae sapiente sequi	Aut magni doloribus saepe quo dolore accusantium vel aut asperiores nisi est.	486.78	37	4	2025-08-03 17:52:54	2025-08-03 17:52:54
356	sunt placeat velit	Aspernatur officia voluptates vero possimus qui autem et.	753.71	80	4	2025-08-03 17:52:54	2025-08-03 17:52:54
357	dolorum et molestiae	Iusto exercitationem reprehenderit quos quidem laboriosam incidunt non eos iure repellendus qui.	528.38	46	4	2025-08-03 17:52:54	2025-08-03 17:52:54
358	consequuntur qui iusto	Voluptates ad voluptas illum maxime aliquid dolorem iure ut illo eum.	466.03	13	4	2025-08-03 17:52:54	2025-08-03 17:52:54
359	sapiente perferendis sed	Accusantium facere praesentium qui minima est nihil et.	964.36	78	4	2025-08-03 17:52:54	2025-08-03 17:52:54
360	quas eos est	Modi sit cum veniam qui suscipit non repellendus nisi omnis.	283.69	14	4	2025-08-03 17:52:54	2025-08-03 17:52:54
361	qui neque quo	Sit cum officiis ipsum consequatur cumque quo adipisci magni accusantium eos earum.	410.75	25	4	2025-08-03 17:52:54	2025-08-03 17:52:54
362	est adipisci quis	Est ducimus saepe distinctio amet magni asperiores provident quaerat fugit.	741.84	33	4	2025-08-03 17:52:54	2025-08-03 17:52:54
363	est culpa sunt	Ad incidunt unde rerum non omnis quaerat.	909.33	97	4	2025-08-03 17:52:54	2025-08-03 17:52:54
364	ut asperiores perspiciatis	Impedit et recusandae alias eligendi accusamus fugiat sed consectetur qui iure voluptatem.	500.29	15	4	2025-08-03 17:52:54	2025-08-03 17:52:54
365	occaecati praesentium atque	Et incidunt aperiam voluptatibus itaque eveniet voluptates voluptate molestias reprehenderit numquam laudantium est nostrum.	188.07	10	4	2025-08-03 17:52:54	2025-08-03 17:52:54
366	eligendi minus et	Hic incidunt id nesciunt et vel id nobis cupiditate.	599.97	38	4	2025-08-03 17:52:54	2025-08-03 17:52:54
367	in vel et	Vero deleniti atque nulla sint repellat dolore asperiores fugit.	775.78	8	4	2025-08-03 17:52:54	2025-08-03 17:52:54
368	amet molestias nulla	Quos inventore voluptas rem et aut saepe.	214.58	98	4	2025-08-03 17:52:54	2025-08-03 17:52:54
369	harum aspernatur vel	Voluptatem cumque soluta reiciendis libero tenetur possimus qui ex.	885.07	23	4	2025-08-03 17:52:54	2025-08-03 17:52:54
370	minus recusandae temporibus	Qui quisquam eum exercitationem iusto delectus itaque corporis aspernatur.	493.43	52	4	2025-08-03 17:52:54	2025-08-03 17:52:54
371	qui id accusantium	Quod optio quos necessitatibus beatae qui eveniet rem.	194.93	45	4	2025-08-03 17:52:54	2025-08-03 17:52:54
372	voluptatum est magnam	Est enim alias quod soluta magni adipisci porro error voluptates totam cumque doloribus optio.	120.22	72	4	2025-08-03 17:52:54	2025-08-03 17:52:54
373	explicabo quia ducimus	Atque vel omnis molestiae omnis voluptas dicta.	163.11	32	4	2025-08-03 17:52:54	2025-08-03 17:52:54
374	at eaque sapiente	Fuga possimus rerum repudiandae ea enim voluptatibus non porro ut corrupti sed.	719.15	26	4	2025-08-03 17:52:54	2025-08-03 17:52:54
375	quis eaque nihil	A molestias laborum rerum est nihil nihil unde sunt.	487.96	62	4	2025-08-03 17:52:54	2025-08-03 17:52:54
376	qui id et	Repudiandae laboriosam placeat molestiae perferendis et ratione.	437.82	42	4	2025-08-03 17:52:54	2025-08-03 17:52:54
377	atque architecto molestiae	Sit rem et quaerat doloremque voluptatem rerum nisi.	643.89	42	4	2025-08-03 17:52:54	2025-08-03 17:52:54
378	ea impedit tempore	Debitis repellendus id sit sapiente repudiandae voluptas excepturi natus velit et ut velit qui.	843.22	99	4	2025-08-03 17:52:54	2025-08-03 17:52:54
379	et repellat nam	Porro asperiores est et et pariatur animi tempore esse sint qui quia provident.	67.77	60	4	2025-08-03 17:52:54	2025-08-03 17:52:54
380	enim aliquam impedit	Est quos possimus est voluptates quia voluptatem velit dolores enim modi nihil vero.	815.62	45	4	2025-08-03 17:52:54	2025-08-03 17:52:54
381	error illo aut	Rerum doloremque labore hic dolores cum ad minus vel laboriosam.	475.64	18	4	2025-08-03 17:52:54	2025-08-03 17:52:54
382	voluptatum esse rerum	Animi accusamus eum aut velit ea maxime repellat tempora eos corporis ut dolor.	888.64	4	4	2025-08-03 17:52:54	2025-08-03 17:52:54
383	est sit qui	Est fugiat voluptas ea omnis quaerat quasi.	930.26	24	4	2025-08-03 17:52:54	2025-08-03 17:52:54
384	aut recusandae dignissimos	Enim repellat ipsum soluta dolorem dolor tenetur.	623.26	9	4	2025-08-03 17:52:54	2025-08-03 17:52:54
385	sunt exercitationem nisi	Saepe rerum qui rerum ea ipsum sapiente deserunt vero aut quasi.	246.65	36	4	2025-08-03 17:52:54	2025-08-03 17:52:54
386	nam rerum sint	Dolore et est corporis explicabo explicabo unde culpa.	25.88	45	4	2025-08-03 17:52:54	2025-08-03 17:52:54
387	molestias quas voluptas	Alias voluptatem veritatis rerum cum dolorem eligendi qui deserunt quod placeat quis cumque.	917.05	54	4	2025-08-03 17:52:54	2025-08-03 17:52:54
388	voluptates ullam est	Doloribus dolore molestiae et amet atque laborum reprehenderit et id.	391.92	9	4	2025-08-03 17:52:54	2025-08-03 17:52:54
389	natus alias dolorem	Itaque quis dolor voluptatem ex qui debitis et.	262.30	34	4	2025-08-03 17:52:54	2025-08-03 17:52:54
390	omnis qui consequatur	In ut qui hic reiciendis totam voluptatibus et velit optio est.	760.50	92	4	2025-08-03 17:52:54	2025-08-03 17:52:54
391	autem est quod	Quia repudiandae voluptatem totam facilis mollitia tenetur quasi.	743.89	64	4	2025-08-03 17:52:54	2025-08-03 17:52:54
392	nisi mollitia deserunt	Dolores sint est velit ex adipisci earum voluptatem consequatur accusamus repellendus iure ut.	831.75	83	4	2025-08-03 17:52:54	2025-08-03 17:52:54
393	occaecati modi porro	Quae animi accusantium voluptas magni rerum soluta sunt sit corrupti voluptatibus aut tempore.	700.05	73	4	2025-08-03 17:52:54	2025-08-03 17:52:54
394	dolores nihil ad	Consequatur nihil tenetur qui magni dolores reiciendis est alias nihil expedita.	646.89	42	4	2025-08-03 17:52:54	2025-08-03 17:52:54
395	dolorem nihil sint	Voluptas ipsam sed voluptatem accusamus sunt perferendis tenetur.	394.30	17	4	2025-08-03 17:52:54	2025-08-03 17:52:54
396	natus dolores magni	In numquam et sed eum dolorem reiciendis expedita illo magni animi et et qui.	512.94	8	4	2025-08-03 17:52:54	2025-08-03 17:52:54
397	id voluptatibus neque	Velit doloribus recusandae facilis sunt occaecati officiis sapiente doloremque debitis aut.	529.99	45	4	2025-08-03 17:52:54	2025-08-03 17:52:54
398	magnam impedit quibusdam	Voluptatum eos quis rerum molestias nulla quaerat explicabo amet excepturi.	384.08	87	4	2025-08-03 17:52:54	2025-08-03 17:52:54
399	sed adipisci magnam	Quia et sit odio recusandae culpa delectus quidem ex sequi sit quia mollitia ut.	66.70	7	4	2025-08-03 17:52:54	2025-08-03 17:52:54
400	repellendus delectus sit	Voluptas aut rerum illum deserunt consequuntur voluptate quibusdam porro vel delectus.	166.03	25	4	2025-08-03 17:52:54	2025-08-03 17:52:54
401	quis nisi eaque	Et est necessitatibus odit in temporibus eligendi tempora in qui.	302.73	100	5	2025-08-03 17:52:57	2025-08-03 17:52:57
402	porro voluptas omnis	Atque nobis aut impedit nulla aut saepe repellendus.	995.78	16	5	2025-08-03 17:52:57	2025-08-03 17:52:57
403	voluptate ut architecto	Quo consequuntur ex eius sunt alias sed veritatis qui fuga modi iste.	515.02	58	5	2025-08-03 17:52:57	2025-08-03 17:52:57
404	aperiam atque natus	Blanditiis error dolore velit magni ipsam omnis enim alias aut deserunt voluptatem doloribus dolore.	63.19	1	5	2025-08-03 17:52:57	2025-08-03 17:52:57
405	eligendi iure beatae	Illo quo quisquam sunt est et non tempora nihil labore quia.	987.00	97	5	2025-08-03 17:52:57	2025-08-03 17:52:57
406	sint et dolor	Ut velit maiores porro aspernatur impedit quaerat.	604.02	33	5	2025-08-03 17:52:57	2025-08-03 17:52:57
407	sint est porro	Iusto perspiciatis consequuntur nam commodi unde molestiae nesciunt quisquam doloremque non fugit iure aliquam.	494.65	8	5	2025-08-03 17:52:57	2025-08-03 17:52:57
408	qui iure aspernatur	Voluptatem earum maiores et maiores corrupti suscipit architecto animi ut sunt explicabo.	288.24	1	5	2025-08-03 17:52:57	2025-08-03 17:52:57
409	excepturi laboriosam tenetur	Illo est aut ut similique rerum vel aspernatur delectus quis ducimus dignissimos consectetur totam.	51.34	88	5	2025-08-03 17:52:57	2025-08-03 17:52:57
410	possimus fugit ratione	Non rerum et praesentium facilis quidem natus facere consequatur autem rerum.	849.91	4	5	2025-08-03 17:52:57	2025-08-03 17:52:57
411	consectetur assumenda sapiente	Fuga assumenda maiores molestias quis tenetur excepturi esse optio consequatur error ad et dolor.	236.97	83	5	2025-08-03 17:52:57	2025-08-03 17:52:57
412	ea iste perspiciatis	Vitae quos quia aut autem ut nemo tempora velit nisi qui dolore neque.	747.67	84	5	2025-08-03 17:52:57	2025-08-03 17:52:57
413	velit quo dolores	Quo et aut eum unde minus iusto voluptates iure.	730.64	2	5	2025-08-03 17:52:57	2025-08-03 17:52:57
414	praesentium soluta qui	Magnam adipisci et dolorum consequatur quaerat maiores.	712.93	36	5	2025-08-03 17:52:57	2025-08-03 17:52:57
415	a iusto cupiditate	Voluptas minus assumenda rerum corporis consequatur labore numquam magnam ea.	657.06	50	5	2025-08-03 17:52:57	2025-08-03 17:52:57
416	voluptatibus et ut	Quia in sit odit amet nesciunt nemo neque consequuntur dignissimos voluptas praesentium itaque soluta fugit.	278.20	71	5	2025-08-03 17:52:57	2025-08-03 17:52:57
417	velit harum id	Vero accusamus eum non tenetur provident laboriosam pariatur atque.	42.52	82	5	2025-08-03 17:52:57	2025-08-03 17:52:57
418	vero voluptatem nostrum	Vel aut et rerum sunt molestias omnis iste.	242.81	54	5	2025-08-03 17:52:57	2025-08-03 17:52:57
419	nulla dolores aspernatur	Qui possimus sunt voluptatem saepe id illo quod nesciunt sed sapiente nesciunt.	502.66	60	5	2025-08-03 17:52:57	2025-08-03 17:52:57
420	in voluptas quia	Et totam eum ullam in ea non assumenda error.	247.19	33	5	2025-08-03 17:52:57	2025-08-03 17:52:57
421	qui et id	Quis quia ab et nostrum qui minus ut rerum omnis id aut voluptatum.	574.16	72	5	2025-08-03 17:52:57	2025-08-03 17:52:57
422	rerum earum possimus	Qui sapiente autem placeat atque possimus repellendus dolorum harum consectetur in enim est.	652.60	35	5	2025-08-03 17:52:57	2025-08-03 17:52:57
423	impedit minus at	Exercitationem totam sit ab dicta est ut architecto.	918.26	11	5	2025-08-03 17:52:57	2025-08-03 17:52:57
424	voluptas veniam eius	Laudantium cum et necessitatibus iusto tenetur similique perspiciatis reprehenderit mollitia quo sed tempore eum.	444.52	73	5	2025-08-03 17:52:57	2025-08-03 17:52:57
425	qui voluptates quas	Id nihil consequatur quod a et tempora porro non aut omnis aut.	745.13	70	5	2025-08-03 17:52:57	2025-08-03 17:52:57
426	odit ducimus vel	Explicabo ex nihil iure rerum quas expedita corrupti explicabo reprehenderit numquam recusandae.	890.02	23	5	2025-08-03 17:52:57	2025-08-03 17:52:57
427	repellendus quam magni	Explicabo fuga nemo quasi quaerat id omnis.	713.51	55	5	2025-08-03 17:52:57	2025-08-03 17:52:57
428	nisi accusantium quam	Aut optio ea ut eos beatae dolor qui quis velit necessitatibus magni.	166.31	39	5	2025-08-03 17:52:57	2025-08-03 17:52:57
429	non ut labore	Voluptas nemo velit optio dolorem quia vitae corporis.	708.87	51	5	2025-08-03 17:52:57	2025-08-03 17:52:57
430	quod sint aut	Dolores et aut eveniet eum molestias omnis magnam sit.	789.56	75	5	2025-08-03 17:52:57	2025-08-03 17:52:57
431	nisi cupiditate incidunt	Architecto sit quis aspernatur ratione qui provident unde atque.	598.28	13	5	2025-08-03 17:52:57	2025-08-03 17:52:57
432	aliquam doloribus temporibus	Et iste quae quaerat quam quia repudiandae eaque ut accusantium cumque repellat id numquam.	660.04	97	5	2025-08-03 17:52:57	2025-08-03 17:52:57
433	quia accusamus est	Error consequatur eos ea cupiditate perferendis doloremque iure quidem at iure est placeat dignissimos.	405.46	28	5	2025-08-03 17:52:57	2025-08-03 17:52:57
434	libero voluptas omnis	Debitis adipisci est laboriosam eos eum voluptate quis quis maiores harum.	862.53	47	5	2025-08-03 17:52:57	2025-08-03 17:52:57
435	ipsa omnis et	Assumenda vel qui fugit corporis et dolor officiis quae repellat.	44.17	31	5	2025-08-03 17:52:57	2025-08-03 17:52:57
436	rem voluptatem blanditiis	Reprehenderit impedit vel quos non eaque expedita quis voluptatum quis.	691.87	55	5	2025-08-03 17:52:57	2025-08-03 17:52:57
437	impedit voluptatem eveniet	Tempore est ullam deleniti necessitatibus repellat ut magnam doloremque similique ullam exercitationem.	737.97	82	5	2025-08-03 17:52:57	2025-08-03 17:52:57
438	et qui est	Occaecati vel quisquam ut eum totam sed labore vero occaecati impedit.	460.30	26	5	2025-08-03 17:52:57	2025-08-03 17:52:57
439	distinctio nam sit	Sed voluptatem omnis accusamus perferendis et quia aut molestiae vel aliquam ab quis aliquid.	250.77	18	5	2025-08-03 17:52:57	2025-08-03 17:52:57
440	dignissimos quaerat ut	Et sunt impedit sit magnam placeat eligendi et omnis omnis ut.	195.86	82	5	2025-08-03 17:52:57	2025-08-03 17:52:57
441	fuga nam corrupti	Quos et illo consequatur dolores architecto doloremque esse ipsum ut.	331.43	34	5	2025-08-03 17:52:57	2025-08-03 17:52:57
442	perferendis ducimus distinctio	Quaerat qui reprehenderit officia ab voluptatem perspiciatis maiores ex ut.	305.36	62	5	2025-08-03 17:52:57	2025-08-03 17:52:57
443	accusamus quas necessitatibus	Est quam et veritatis rerum earum iusto blanditiis.	386.45	10	5	2025-08-03 17:52:57	2025-08-03 17:52:57
444	consequuntur totam necessitatibus	Adipisci necessitatibus consectetur nesciunt sint distinctio voluptatem aliquam possimus assumenda ab deleniti deleniti.	510.43	46	5	2025-08-03 17:52:57	2025-08-03 17:52:57
445	consectetur et iste	Ut nulla deserunt neque commodi minus debitis fuga voluptas quos ea alias.	383.66	46	5	2025-08-03 17:52:57	2025-08-03 17:52:57
446	in explicabo cupiditate	Exercitationem dolorem eius harum fugit sint maiores.	754.25	55	5	2025-08-03 17:52:57	2025-08-03 17:52:57
447	enim aut voluptatum	Aut vel voluptatem pariatur eligendi cumque possimus modi sequi sunt quia.	957.50	58	5	2025-08-03 17:52:57	2025-08-03 17:52:57
448	ut mollitia sint	Pariatur voluptas a et modi deserunt nam voluptatibus enim.	886.32	10	5	2025-08-03 17:52:57	2025-08-03 17:52:57
449	aut voluptas tempora	Facilis eum quasi incidunt animi quo in.	284.79	71	5	2025-08-03 17:52:57	2025-08-03 17:52:57
450	ipsam et commodi	Ducimus quam tenetur perspiciatis dolorum eaque quasi ut in delectus odit.	417.71	38	5	2025-08-03 17:52:57	2025-08-03 17:52:57
451	asperiores non hic	Consequuntur et tempore iure et non debitis quam quia.	916.75	35	5	2025-08-03 17:52:57	2025-08-03 17:52:57
452	ut omnis aut	Est et laborum tenetur dolores perferendis qui et facilis est.	364.38	2	5	2025-08-03 17:52:57	2025-08-03 17:52:57
453	est rerum optio	Veritatis fugit repellat beatae alias aut magnam.	754.76	17	5	2025-08-03 17:52:57	2025-08-03 17:52:57
454	provident impedit est	Voluptas assumenda consequatur et a commodi sint quaerat.	179.03	37	5	2025-08-03 17:52:57	2025-08-03 17:52:57
455	doloribus id et	Repellat voluptatem ratione labore autem iure et atque et distinctio qui ut aut.	101.66	89	5	2025-08-03 17:52:57	2025-08-03 17:52:57
456	omnis sunt delectus	Id aut perferendis suscipit et eius magnam ea autem sed et dolorem.	437.58	54	5	2025-08-03 17:52:57	2025-08-03 17:52:57
457	ut nesciunt ut	Ratione deleniti pariatur dolor et minus perferendis expedita suscipit.	823.12	46	5	2025-08-03 17:52:57	2025-08-03 17:52:57
458	commodi ut voluptatem	Sapiente voluptas possimus autem ipsum ad commodi repudiandae unde.	21.55	23	5	2025-08-03 17:52:57	2025-08-03 17:52:57
459	nostrum nihil ut	Iusto soluta debitis corrupti vel dolor reprehenderit nobis inventore.	323.37	79	5	2025-08-03 17:52:57	2025-08-03 17:52:57
460	eveniet sit deleniti	Voluptatem modi quia eius maxime aut error culpa.	635.37	67	5	2025-08-03 17:52:57	2025-08-03 17:52:57
461	modi atque aut	Dolorem tempora est itaque dignissimos sint et.	294.74	14	5	2025-08-03 17:52:57	2025-08-03 17:52:57
462	quaerat perspiciatis cupiditate	Aut eos ab quaerat dolorem nemo corporis iure autem asperiores ipsum nihil excepturi.	792.29	49	5	2025-08-03 17:52:57	2025-08-03 17:52:57
463	voluptas inventore qui	Atque laudantium eos sequi sed numquam qui commodi sed et officiis explicabo labore itaque.	686.78	76	5	2025-08-03 17:52:57	2025-08-03 17:52:57
464	corrupti ratione magni	Ex consequatur deserunt optio et autem error libero animi accusantium soluta exercitationem perspiciatis aut.	266.43	2	5	2025-08-03 17:52:57	2025-08-03 17:52:57
465	expedita dignissimos placeat	Sunt ipsam sint sint sit quidem est distinctio totam.	86.98	99	5	2025-08-03 17:52:57	2025-08-03 17:52:57
466	odio repudiandae et	Aliquid commodi est et reiciendis quia ad voluptatum.	179.66	54	5	2025-08-03 17:52:57	2025-08-03 17:52:57
467	ad repellendus pariatur	Ad est quia voluptatem necessitatibus sapiente aut voluptas quia.	870.65	67	5	2025-08-03 17:52:57	2025-08-03 17:52:57
468	quibusdam nisi ratione	Voluptatem quia facere ullam omnis veniam dolorum reiciendis similique qui sed maiores.	347.77	31	5	2025-08-03 17:52:57	2025-08-03 17:52:57
469	praesentium qui neque	Perferendis doloremque voluptas iure similique repellat iure voluptatem.	134.85	76	5	2025-08-03 17:52:57	2025-08-03 17:52:57
470	maxime qui quis	Quas est deleniti voluptates aut aut laboriosam aspernatur quidem temporibus deserunt ut vero.	550.93	15	5	2025-08-03 17:52:57	2025-08-03 17:52:57
471	fugit et vel	Repellendus blanditiis itaque qui ut corporis eius et quod iusto sit.	988.66	69	5	2025-08-03 17:52:57	2025-08-03 17:52:57
472	nemo et ab	Sed blanditiis cupiditate nihil molestiae omnis commodi et iusto consequuntur deleniti eaque.	170.68	87	5	2025-08-03 17:52:57	2025-08-03 17:52:57
473	et vero est	Culpa nostrum dolores voluptatibus autem dignissimos laudantium voluptatum facilis.	827.88	24	5	2025-08-03 17:52:57	2025-08-03 17:52:57
474	est illum qui	Dolore qui dolorem quibusdam ipsum aut aut.	839.86	65	5	2025-08-03 17:52:57	2025-08-03 17:52:57
475	cum animi nostrum	Unde ratione hic quia aliquam ad voluptatem omnis cum nobis voluptatibus velit.	726.69	76	5	2025-08-03 17:52:57	2025-08-03 17:52:57
476	voluptas aut sequi	Qui nam doloremque dolorem fugiat voluptatem eaque.	129.87	94	5	2025-08-03 17:52:57	2025-08-03 17:52:57
477	rem qui doloribus	Sint sed suscipit natus culpa quasi quis deserunt consequatur quia itaque repellat consequatur.	491.61	0	5	2025-08-03 17:52:57	2025-08-03 17:52:57
478	consequatur occaecati dolor	Non in perspiciatis id excepturi est eius omnis dolores fugiat.	346.71	0	5	2025-08-03 17:52:57	2025-08-03 17:52:57
479	assumenda quo dolores	Autem iste necessitatibus ratione aut atque voluptas velit necessitatibus veniam quod.	748.65	61	5	2025-08-03 17:52:57	2025-08-03 17:52:57
480	quis sed dolore	Quia corrupti libero asperiores voluptas ea ut esse et perspiciatis doloribus ad earum.	53.31	73	5	2025-08-03 17:52:57	2025-08-03 17:52:57
481	earum ipsam vel	Quod pariatur voluptates vitae et quidem ipsum vero molestias.	142.80	82	5	2025-08-03 17:52:57	2025-08-03 17:52:57
482	ducimus soluta officiis	Corporis et aliquid perferendis sunt facilis est atque tenetur cumque sit et.	165.52	80	5	2025-08-03 17:52:57	2025-08-03 17:52:57
483	neque exercitationem iste	Eaque dicta quis magnam rerum deserunt esse dolores eius ab.	889.60	8	5	2025-08-03 17:52:57	2025-08-03 17:52:57
484	non soluta quae	Voluptate voluptas et aut iure dolorem nobis est cumque facere alias.	280.60	18	5	2025-08-03 17:52:57	2025-08-03 17:52:57
485	perferendis eos et	Dolor eligendi cum qui velit nihil laboriosam aspernatur totam voluptas adipisci quia totam voluptas.	31.51	54	5	2025-08-03 17:52:57	2025-08-03 17:52:57
486	vero quia maiores	Voluptatem iusto quibusdam dolorem voluptas qui molestiae suscipit qui.	573.28	62	5	2025-08-03 17:52:57	2025-08-03 17:52:57
487	quod esse mollitia	Harum voluptate quaerat praesentium velit officia deleniti suscipit molestiae.	229.94	68	5	2025-08-03 17:52:57	2025-08-03 17:52:57
488	vitae iure dolore	Fugiat ex consequatur id quis in omnis quia at rerum.	262.45	41	5	2025-08-03 17:52:57	2025-08-03 17:52:57
489	ut possimus quia	Voluptas adipisci quidem iste aut facilis excepturi ut necessitatibus qui cumque aut.	124.75	43	5	2025-08-03 17:52:57	2025-08-03 17:52:57
490	nobis aliquam quidem	Pariatur quod iure et nobis eum ipsa distinctio quae eum.	912.41	48	5	2025-08-03 17:52:57	2025-08-03 17:52:57
491	est quas nesciunt	Voluptates est quibusdam rerum quo facilis et consequatur ut accusamus.	521.18	0	5	2025-08-03 17:52:57	2025-08-03 17:52:57
492	nisi facere beatae	Aspernatur id ab voluptates tempora magnam aliquid qui dolorum soluta necessitatibus corporis voluptas.	696.30	17	5	2025-08-03 17:52:57	2025-08-03 17:52:57
493	commodi accusamus non	Voluptatem id provident quia earum enim aut id ratione harum ea beatae.	605.40	7	5	2025-08-03 17:52:57	2025-08-03 17:52:57
494	ipsa error dolores	Repellendus nulla ex occaecati nobis dolor illo.	452.78	90	5	2025-08-03 17:52:57	2025-08-03 17:52:57
495	aliquid recusandae et	Magnam architecto et qui voluptatem culpa nisi totam suscipit ratione ea.	343.43	51	5	2025-08-03 17:52:57	2025-08-03 17:52:57
496	molestiae debitis et	Voluptate corporis voluptatum est voluptate consequatur magni et eaque dicta repellendus.	947.88	98	5	2025-08-03 17:52:57	2025-08-03 17:52:57
497	eius accusamus laborum	Nostrum voluptatum nihil et tempora velit nulla tenetur sed magni sapiente doloribus.	300.24	50	5	2025-08-03 17:52:57	2025-08-03 17:52:57
498	quia sequi dolorum	Dolorem voluptatem soluta eum quas magni sed.	158.46	47	5	2025-08-03 17:52:57	2025-08-03 17:52:57
499	eum porro laborum	Repudiandae libero magnam minus eligendi commodi sit aut blanditiis corporis nihil quo alias cupiditate.	237.59	94	5	2025-08-03 17:52:57	2025-08-03 17:52:57
500	adipisci et eligendi	Tempore qui incidunt rerum harum et consequatur unde voluptatem repellendus consequatur quo eos sit temporibus.	472.67	17	5	2025-08-03 17:52:57	2025-08-03 17:52:57
501	incidunt quaerat officiis	Repudiandae eum nam nam nulla qui et accusantium reprehenderit sunt accusantium consequatur dolorem in.	17.20	33	6	2025-08-03 17:53:00	2025-08-03 17:53:00
502	odio aut mollitia	Eos consequatur suscipit repellat nobis expedita omnis soluta.	298.02	76	6	2025-08-03 17:53:00	2025-08-03 17:53:00
503	sint impedit quo	Animi excepturi non voluptas sunt voluptatum et provident debitis.	197.72	62	6	2025-08-03 17:53:00	2025-08-03 17:53:00
504	autem placeat dolor	Expedita ut fugit quasi numquam deleniti vel qui non deserunt neque quia maiores.	979.58	38	6	2025-08-03 17:53:00	2025-08-03 17:53:00
505	adipisci exercitationem nam	Est quo est molestiae voluptatem repellat et possimus quis nihil id architecto.	484.36	60	6	2025-08-03 17:53:00	2025-08-03 17:53:00
506	voluptatem non iusto	Soluta dicta reprehenderit quaerat deleniti reprehenderit nisi dignissimos repellat dignissimos perferendis.	736.45	18	6	2025-08-03 17:53:00	2025-08-03 17:53:00
507	ratione totam earum	Porro nulla facere animi harum vel nam doloremque inventore veritatis hic.	884.12	64	6	2025-08-03 17:53:00	2025-08-03 17:53:00
508	labore minus et	Delectus consequatur aut accusamus inventore id ut veniam est pariatur architecto numquam modi impedit.	463.31	13	6	2025-08-03 17:53:00	2025-08-03 17:53:00
509	vitae sed deleniti	Voluptas voluptatem laboriosam eveniet qui ut harum ea et ea asperiores doloremque quia.	78.22	99	6	2025-08-03 17:53:00	2025-08-03 17:53:00
510	cumque sit animi	Enim odit et iusto rerum provident excepturi sapiente nemo.	923.64	96	6	2025-08-03 17:53:00	2025-08-03 17:53:00
511	in ipsam et	Eum fugit rerum cupiditate doloribus dignissimos sint provident occaecati et earum.	585.10	92	6	2025-08-03 17:53:00	2025-08-03 17:53:00
512	alias sit deleniti	Repellat eos magni blanditiis eum delectus voluptatum id tenetur minus voluptas illo.	816.83	13	6	2025-08-03 17:53:00	2025-08-03 17:53:00
513	dolor suscipit debitis	Ullam blanditiis neque itaque explicabo sunt perferendis quisquam quas id dicta.	352.94	67	6	2025-08-03 17:53:00	2025-08-03 17:53:00
514	voluptatum inventore vel	Non dolorum voluptatem autem sunt quaerat a dolore laboriosam.	827.08	8	6	2025-08-03 17:53:00	2025-08-03 17:53:00
515	atque ad repudiandae	Non et rerum asperiores ipsam natus veritatis nobis esse.	702.78	84	6	2025-08-03 17:53:00	2025-08-03 17:53:00
516	laborum perspiciatis necessitatibus	A at dolor quia temporibus aliquid non quia exercitationem voluptas sequi unde tempora natus.	962.54	37	6	2025-08-03 17:53:00	2025-08-03 17:53:00
517	sequi neque rem	Enim et nam sed rerum magni corporis veniam qui adipisci nobis aut nulla.	424.49	97	6	2025-08-03 17:53:00	2025-08-03 17:53:00
518	quo temporibus saepe	Eius minima est reiciendis laudantium sed exercitationem quos aut recusandae labore et velit et.	229.17	6	6	2025-08-03 17:53:00	2025-08-03 17:53:00
519	at incidunt modi	Error est officiis doloremque labore sint quidem qui.	136.22	68	6	2025-08-03 17:53:00	2025-08-03 17:53:00
520	non sunt consequatur	Omnis unde et laboriosam exercitationem harum optio.	206.78	54	6	2025-08-03 17:53:00	2025-08-03 17:53:00
521	et culpa incidunt	Aut sit aperiam commodi assumenda expedita voluptas.	484.33	44	6	2025-08-03 17:53:00	2025-08-03 17:53:00
522	minus non quod	Placeat neque aliquid ducimus enim beatae veritatis repudiandae et quis veniam saepe.	195.67	40	6	2025-08-03 17:53:00	2025-08-03 17:53:00
523	veniam repellat non	Harum totam quibusdam sed est ut deleniti beatae hic sed sit.	70.36	34	6	2025-08-03 17:53:00	2025-08-03 17:53:00
524	voluptatem vel earum	Pariatur vero dolorem quia tempore accusantium fugiat occaecati velit molestias earum exercitationem.	192.08	22	6	2025-08-03 17:53:00	2025-08-03 17:53:00
525	facere qui nostrum	Neque quis debitis perspiciatis impedit officiis magnam sit nulla consequatur fugit ad.	169.10	27	6	2025-08-03 17:53:00	2025-08-03 17:53:00
526	dolorum commodi voluptatibus	Et quis illum molestiae ratione ut quas et voluptas qui occaecati fugit.	649.24	95	6	2025-08-03 17:53:00	2025-08-03 17:53:00
527	libero non et	Aut nihil tempore sunt veritatis fugit id corporis aut ratione autem.	247.85	24	6	2025-08-03 17:53:00	2025-08-03 17:53:00
528	enim rerum blanditiis	Ab inventore nam ex sed laudantium modi sapiente iste.	854.41	73	6	2025-08-03 17:53:00	2025-08-03 17:53:00
529	voluptatem voluptatibus aut	Ipsum suscipit nihil quo molestias quos consequuntur.	353.10	34	6	2025-08-03 17:53:00	2025-08-03 17:53:00
530	aut architecto aut	Similique nobis earum iure totam nostrum sequi.	942.31	45	6	2025-08-03 17:53:00	2025-08-03 17:53:00
531	hic hic quia	Necessitatibus corporis et amet dolore praesentium voluptatem qui rerum quas.	499.82	16	6	2025-08-03 17:53:00	2025-08-03 17:53:00
532	illo maiores qui	Aut aspernatur architecto excepturi est distinctio neque sit libero hic sapiente.	575.80	18	6	2025-08-03 17:53:00	2025-08-03 17:53:00
533	provident reiciendis voluptatum	Ducimus ut et id assumenda et voluptatem libero.	265.74	70	6	2025-08-03 17:53:00	2025-08-03 17:53:00
534	eligendi nihil minima	Vel praesentium et hic aliquid ex natus ut fugit accusantium quia totam.	303.72	17	6	2025-08-03 17:53:00	2025-08-03 17:53:00
535	dolorem nesciunt in	Dolore nemo nisi iusto officiis aliquid soluta sit ipsa.	202.25	98	6	2025-08-03 17:53:00	2025-08-03 17:53:00
536	reiciendis delectus est	Officiis error minima inventore rerum ut neque enim qui.	438.75	48	6	2025-08-03 17:53:00	2025-08-03 17:53:00
537	qui quod temporibus	Pariatur et et iusto dicta quidem aut nostrum dicta.	982.58	15	6	2025-08-03 17:53:00	2025-08-03 17:53:00
538	impedit sequi blanditiis	Architecto voluptates rerum occaecati et ipsum enim rem suscipit tenetur aut sint fugit rerum.	559.79	86	6	2025-08-03 17:53:00	2025-08-03 17:53:00
539	eligendi ut ut	Similique nihil impedit temporibus incidunt omnis quia.	403.31	98	6	2025-08-03 17:53:00	2025-08-03 17:53:00
540	voluptas ad et	Ex et nihil voluptatem laudantium natus dolor est et quam.	750.84	76	6	2025-08-03 17:53:00	2025-08-03 17:53:00
541	quae omnis non	Eum perferendis exercitationem voluptate quia corporis aut alias quisquam vitae amet qui ex.	882.67	81	6	2025-08-03 17:53:00	2025-08-03 17:53:00
542	recusandae omnis vero	Eum est recusandae quod animi earum cumque occaecati omnis animi et.	309.28	66	6	2025-08-03 17:53:00	2025-08-03 17:53:00
543	est dolor molestiae	Cum vero iste ab quis iusto doloremque numquam enim qui dolor.	430.64	53	6	2025-08-03 17:53:00	2025-08-03 17:53:00
544	aut optio sint	Rerum tenetur accusantium rem unde minus sit officiis omnis repudiandae.	781.84	27	6	2025-08-03 17:53:00	2025-08-03 17:53:00
545	voluptas expedita qui	Reiciendis harum quasi aspernatur perspiciatis ullam facilis hic qui dolorem deleniti optio.	642.56	72	6	2025-08-03 17:53:00	2025-08-03 17:53:00
546	temporibus iusto ab	Id magnam nobis quis expedita deleniti ea et corporis tenetur ad enim impedit adipisci.	34.51	66	6	2025-08-03 17:53:00	2025-08-03 17:53:00
547	expedita omnis sed	Voluptas non in tempore laboriosam eos molestias et enim odio.	282.32	63	6	2025-08-03 17:53:00	2025-08-03 17:53:00
548	laboriosam minus temporibus	Commodi eaque nihil et quaerat molestias rerum sed.	38.51	67	6	2025-08-03 17:53:00	2025-08-03 17:53:00
549	illo nemo aut	Sapiente qui consectetur quia quae ea error ut animi.	687.39	50	6	2025-08-03 17:53:00	2025-08-03 17:53:00
550	corrupti fugiat laudantium	Pariatur rem cupiditate et dolor rerum eos rem ut asperiores similique blanditiis blanditiis mollitia.	868.43	16	6	2025-08-03 17:53:00	2025-08-03 17:53:00
551	delectus rem sunt	Eveniet qui et fugiat dignissimos ipsam consequuntur qui non quia harum.	986.25	61	6	2025-08-03 17:53:00	2025-08-03 17:53:00
552	ut illo eum	Commodi temporibus ipsam quaerat illum fugiat aut ratione officiis et.	753.06	40	6	2025-08-03 17:53:00	2025-08-03 17:53:00
553	ex ut pariatur	Qui rerum ut eos placeat qui veniam est.	903.12	53	6	2025-08-03 17:53:00	2025-08-03 17:53:00
554	non labore qui	Cupiditate ut nostrum voluptate deserunt consequatur eligendi vel voluptas natus.	932.91	14	6	2025-08-03 17:53:00	2025-08-03 17:53:00
555	nisi quam beatae	Officia iste porro porro esse hic eveniet placeat non dolor.	453.17	88	6	2025-08-03 17:53:00	2025-08-03 17:53:00
556	autem soluta consequatur	Dolor perferendis et porro error recusandae mollitia harum.	861.89	11	6	2025-08-03 17:53:00	2025-08-03 17:53:00
557	rerum ipsum odit	Omnis facilis quia similique ut odit vitae culpa.	623.15	1	6	2025-08-03 17:53:00	2025-08-03 17:53:00
558	qui qui necessitatibus	Distinctio explicabo et blanditiis non totam harum veniam.	345.09	87	6	2025-08-03 17:53:00	2025-08-03 17:53:00
559	similique iste eligendi	Voluptas itaque et quis aut enim est eos provident maiores itaque fuga necessitatibus porro.	549.09	33	6	2025-08-03 17:53:00	2025-08-03 17:53:00
560	eveniet consequatur tenetur	Sint tempora est quia esse perferendis at dolorem.	404.54	2	6	2025-08-03 17:53:00	2025-08-03 17:53:00
561	consequatur impedit voluptatibus	Eius tempore ut eos ea nesciunt rerum et nobis.	709.65	66	6	2025-08-03 17:53:00	2025-08-03 17:53:00
562	laudantium est voluptatem	Laboriosam eligendi ut mollitia nostrum fuga qui ut qui eos perferendis sunt.	421.92	48	6	2025-08-03 17:53:00	2025-08-03 17:53:00
563	voluptatem voluptatem reiciendis	Magnam repudiandae autem voluptatem minima at eum numquam.	972.38	19	6	2025-08-03 17:53:00	2025-08-03 17:53:00
564	laborum sit ut	Unde quisquam veritatis sunt mollitia ea hic fugit beatae.	19.12	86	6	2025-08-03 17:53:00	2025-08-03 17:53:00
565	ipsa voluptatem quis	Dolores temporibus ex maiores molestias amet qui cumque perferendis provident ad.	666.29	43	6	2025-08-03 17:53:00	2025-08-03 17:53:00
566	et totam voluptatem	Sint sunt numquam nesciunt corrupti ullam occaecati alias itaque consequuntur cum et blanditiis.	642.75	17	6	2025-08-03 17:53:00	2025-08-03 17:53:00
567	rerum officia est	Quis ab suscipit atque tempore et officia.	272.41	35	6	2025-08-03 17:53:00	2025-08-03 17:53:00
568	sunt libero vitae	Atque molestiae sit illum sunt sapiente tempora aliquam.	523.66	38	6	2025-08-03 17:53:00	2025-08-03 17:53:00
569	enim libero eos	Est pariatur unde qui nulla nihil hic consequuntur.	992.03	89	6	2025-08-03 17:53:00	2025-08-03 17:53:00
570	labore qui mollitia	Accusamus tempore omnis fuga similique quis velit explicabo quia.	97.62	62	6	2025-08-03 17:53:00	2025-08-03 17:53:00
571	accusantium itaque iste	Animi beatae laudantium repudiandae illum itaque reiciendis quos repudiandae ad accusamus molestiae.	621.40	52	6	2025-08-03 17:53:00	2025-08-03 17:53:00
572	atque quos impedit	Doloremque molestias fuga modi blanditiis officiis voluptatem a sed.	642.01	17	6	2025-08-03 17:53:00	2025-08-03 17:53:00
573	quasi dolores maxime	Et quaerat quo pariatur alias voluptas quos consequatur nesciunt voluptatem neque ut sunt quibusdam.	662.20	30	6	2025-08-03 17:53:00	2025-08-03 17:53:00
574	harum at ducimus	Voluptates ab aut cumque ut alias quas adipisci id in nobis.	663.24	99	6	2025-08-03 17:53:00	2025-08-03 17:53:00
575	eos voluptatum adipisci	Ipsam dolorem enim omnis et accusantium deserunt illo praesentium cum quasi.	352.36	65	6	2025-08-03 17:53:00	2025-08-03 17:53:00
576	praesentium quas assumenda	Aut et tempora earum et nam recusandae tempore.	295.35	12	6	2025-08-03 17:53:00	2025-08-03 17:53:00
577	voluptate deleniti unde	Pariatur quia quasi omnis fugit qui incidunt maxime occaecati ad molestias.	61.00	53	6	2025-08-03 17:53:00	2025-08-03 17:53:00
578	officiis tenetur animi	Voluptatem molestias itaque explicabo aut et ut enim tempora voluptatibus corporis.	521.53	44	6	2025-08-03 17:53:00	2025-08-03 17:53:00
579	eos quis exercitationem	Nobis est et molestiae illo voluptatem nam eos impedit accusamus est.	853.07	52	6	2025-08-03 17:53:00	2025-08-03 17:53:00
580	quibusdam perspiciatis facere	Id autem ea accusamus in beatae quasi ab ut non tenetur possimus neque.	269.97	43	6	2025-08-03 17:53:00	2025-08-03 17:53:00
581	similique sit quia	Id optio voluptas commodi voluptates beatae harum quae nostrum vel.	774.07	80	6	2025-08-03 17:53:00	2025-08-03 17:53:00
582	iste ea dolor	Rerum beatae autem quas corporis ipsam autem.	63.86	24	6	2025-08-03 17:53:00	2025-08-03 17:53:00
583	similique et repellendus	Aut velit sint voluptatum quibusdam illum rem aspernatur illo.	440.01	88	6	2025-08-03 17:53:00	2025-08-03 17:53:00
584	exercitationem delectus iure	Nihil eum ipsam enim ut ut qui sed.	168.89	20	6	2025-08-03 17:53:00	2025-08-03 17:53:00
585	rem omnis eligendi	Ipsa ea quos in quo laudantium nihil nihil eligendi sed inventore ut praesentium est.	512.80	79	6	2025-08-03 17:53:00	2025-08-03 17:53:00
586	veritatis ad qui	Cupiditate quas facere saepe dolores fugiat nam explicabo occaecati.	240.02	58	6	2025-08-03 17:53:00	2025-08-03 17:53:00
587	natus et aspernatur	Vitae eum et molestiae sed adipisci et error sit quia.	991.72	8	6	2025-08-03 17:53:00	2025-08-03 17:53:00
588	voluptas alias non	Qui enim quae ab velit vitae dolores optio laudantium veritatis placeat quaerat voluptatum minima.	768.56	30	6	2025-08-03 17:53:00	2025-08-03 17:53:00
589	autem debitis aut	Alias repudiandae iusto exercitationem laborum quod blanditiis veniam.	576.48	17	6	2025-08-03 17:53:00	2025-08-03 17:53:00
590	eius quia tenetur	Mollitia non amet quia aut maxime vero ut nulla.	779.11	29	6	2025-08-03 17:53:00	2025-08-03 17:53:00
591	temporibus praesentium necessitatibus	Quibusdam natus labore consequatur nihil delectus explicabo consequatur ut.	69.47	97	6	2025-08-03 17:53:00	2025-08-03 17:53:00
592	dolore ut modi	Qui quae culpa dicta et illo in.	49.51	89	6	2025-08-03 17:53:00	2025-08-03 17:53:00
593	eius delectus a	Et sunt perferendis ut doloribus rerum aperiam impedit rerum voluptatibus est sit molestiae.	293.04	63	6	2025-08-03 17:53:00	2025-08-03 17:53:00
594	odit sapiente ea	Facilis tempore nisi adipisci error distinctio iure.	216.63	42	6	2025-08-03 17:53:00	2025-08-03 17:53:00
595	suscipit facilis quisquam	Esse magni quisquam dignissimos enim corporis eveniet velit.	728.24	2	6	2025-08-03 17:53:00	2025-08-03 17:53:00
596	est voluptas blanditiis	Qui cumque dolor laudantium quaerat tempora perspiciatis deleniti eveniet.	299.94	83	6	2025-08-03 17:53:00	2025-08-03 17:53:00
597	est vero in	Ut architecto molestiae eius sint assumenda tempora nam.	664.43	52	6	2025-08-03 17:53:00	2025-08-03 17:53:00
598	ratione architecto deserunt	Et dolor magnam vitae saepe odio et vero ea ab quia consectetur magnam.	225.74	28	6	2025-08-03 17:53:00	2025-08-03 17:53:00
599	est ipsam temporibus	Natus temporibus voluptatibus quos rem ut laboriosam consequuntur asperiores quisquam omnis.	958.60	81	6	2025-08-03 17:53:00	2025-08-03 17:53:00
600	soluta quam corporis	Numquam quasi iusto consequatur rem accusamus et officiis sed et et.	848.60	10	6	2025-08-03 17:53:00	2025-08-03 17:53:00
601	molestias architecto repellendus	Nihil et odio est voluptatum dignissimos aspernatur ut et explicabo distinctio eos doloremque.	671.70	83	7	2025-08-03 17:53:03	2025-08-03 17:53:03
602	omnis earum modi	Accusamus ad ea voluptatibus aperiam accusamus occaecati sit voluptas neque quia non.	629.58	98	7	2025-08-03 17:53:03	2025-08-03 17:53:03
603	est qui harum	Occaecati ut omnis rerum voluptas officiis nemo omnis quibusdam cum.	194.24	82	7	2025-08-03 17:53:03	2025-08-03 17:53:03
604	laboriosam et facere	Porro odit porro qui dolores corrupti nam unde voluptate dolorem ex temporibus sit quis.	802.88	92	7	2025-08-03 17:53:03	2025-08-03 17:53:03
605	consequatur et optio	Sit dolorum beatae rerum vitae dolores nisi nesciunt asperiores excepturi qui.	388.50	11	7	2025-08-03 17:53:03	2025-08-03 17:53:03
606	nesciunt quia veritatis	Quis ducimus quod deserunt doloribus est aperiam dolores maxime error doloremque.	618.09	31	7	2025-08-03 17:53:03	2025-08-03 17:53:03
607	impedit repellendus nam	Laboriosam voluptatem officia libero enim a quia dolores deserunt commodi ipsum cum.	571.31	92	7	2025-08-03 17:53:03	2025-08-03 17:53:03
608	vel pariatur ducimus	Quia reiciendis laborum et aut voluptates magnam ut.	386.34	18	7	2025-08-03 17:53:03	2025-08-03 17:53:03
609	mollitia omnis veritatis	Expedita tempora et excepturi eos ut itaque suscipit vel aspernatur et nihil qui.	880.54	8	7	2025-08-03 17:53:03	2025-08-03 17:53:03
610	reprehenderit qui distinctio	Esse iure amet incidunt quo harum quia voluptates enim.	473.97	31	7	2025-08-03 17:53:03	2025-08-03 17:53:03
611	rerum non totam	Suscipit sint libero aut nihil quibusdam rerum aut accusantium at aspernatur corporis magni sed.	278.36	69	7	2025-08-03 17:53:03	2025-08-03 17:53:03
612	ea perferendis dolores	Quod qui hic veritatis sit aut eum vitae fuga cupiditate asperiores.	513.51	52	7	2025-08-03 17:53:03	2025-08-03 17:53:03
613	sed consequatur quo	Molestiae dolore omnis quae cumque eaque aperiam doloremque perspiciatis quas.	364.78	37	7	2025-08-03 17:53:03	2025-08-03 17:53:03
614	officia optio tempore	Distinctio reprehenderit et quibusdam culpa tenetur earum quidem et reiciendis facere porro voluptatem vel.	827.47	23	7	2025-08-03 17:53:03	2025-08-03 17:53:03
615	dolorum exercitationem ut	Quia harum aut quaerat culpa mollitia saepe eum et iste.	80.78	31	7	2025-08-03 17:53:03	2025-08-03 17:53:03
616	ullam cupiditate repellendus	Autem reiciendis accusantium nihil quia veniam hic aliquam qui ut harum.	746.13	36	7	2025-08-03 17:53:03	2025-08-03 17:53:03
617	ea sint similique	Qui consequatur minus labore esse tempora voluptate fugit.	187.24	95	7	2025-08-03 17:53:03	2025-08-03 17:53:03
618	voluptatem vitae placeat	Quaerat soluta id aut eligendi maxime illo voluptas sapiente.	196.72	28	7	2025-08-03 17:53:03	2025-08-03 17:53:03
619	eos odit nisi	Mollitia cumque repudiandae eos magnam distinctio occaecati cum velit nulla aliquid aperiam occaecati deleniti.	144.71	45	7	2025-08-03 17:53:03	2025-08-03 17:53:03
620	perferendis iste ut	Consequatur veniam corrupti et non aut vel sapiente velit.	768.62	40	7	2025-08-03 17:53:03	2025-08-03 17:53:03
621	dolor aliquid similique	Dignissimos ab enim id et fuga ipsam.	183.00	43	7	2025-08-03 17:53:03	2025-08-03 17:53:03
622	sed dolor neque	Dolores voluptatem veritatis et explicabo natus corrupti expedita sed est mollitia dignissimos.	728.31	9	7	2025-08-03 17:53:03	2025-08-03 17:53:03
623	earum consequuntur quisquam	Adipisci cupiditate rerum sequi omnis minima molestiae.	784.25	94	7	2025-08-03 17:53:03	2025-08-03 17:53:03
624	libero modi iusto	Et accusamus quia alias magni commodi quo et odio excepturi mollitia dicta.	338.19	26	7	2025-08-03 17:53:03	2025-08-03 17:53:03
625	cupiditate et vitae	Quam voluptate aperiam placeat et sint nostrum.	309.28	66	7	2025-08-03 17:53:03	2025-08-03 17:53:03
626	adipisci qui corporis	Sunt ipsum expedita facere tempora fugiat atque mollitia debitis nam voluptas nemo.	954.12	69	7	2025-08-03 17:53:03	2025-08-03 17:53:03
627	temporibus accusamus architecto	Ea est consequatur cupiditate officia modi aperiam cum non et et aperiam.	937.35	94	7	2025-08-03 17:53:03	2025-08-03 17:53:03
628	aut alias non	Sit rem est voluptatibus voluptas sunt voluptatum aut a incidunt est.	54.61	34	7	2025-08-03 17:53:03	2025-08-03 17:53:03
629	amet earum culpa	Beatae rem nisi dolores quo cum et aliquam non.	639.30	34	7	2025-08-03 17:53:03	2025-08-03 17:53:03
630	ratione nesciunt consequatur	Deleniti rerum eligendi in repellat hic minima atque architecto.	339.10	14	7	2025-08-03 17:53:03	2025-08-03 17:53:03
631	ducimus quia laboriosam	Ducimus illum a eum voluptates vitae ad eum.	766.13	59	7	2025-08-03 17:53:03	2025-08-03 17:53:03
632	excepturi et aliquid	Minima cumque ut et quae qui quae hic fugiat.	165.31	42	7	2025-08-03 17:53:03	2025-08-03 17:53:03
633	mollitia quam qui	Repellat animi ad nemo voluptas accusantium quibusdam maxime sed et nemo non maiores.	980.97	2	7	2025-08-03 17:53:03	2025-08-03 17:53:03
634	explicabo voluptas non	Occaecati aut dolorem molestiae consequatur voluptatem molestiae reprehenderit repudiandae deleniti reprehenderit.	787.18	9	7	2025-08-03 17:53:03	2025-08-03 17:53:03
635	facere quod autem	Explicabo et et totam omnis ipsa voluptas vitae voluptatibus occaecati voluptatum ab qui.	665.22	15	7	2025-08-03 17:53:03	2025-08-03 17:53:03
636	ut autem eum	Tenetur unde tempora aperiam neque voluptatem et voluptatem aliquid delectus deleniti.	219.09	77	7	2025-08-03 17:53:03	2025-08-03 17:53:03
637	voluptatem praesentium dolorem	Eum temporibus modi inventore sunt autem ducimus beatae ut id eius qui est.	332.14	6	7	2025-08-03 17:53:03	2025-08-03 17:53:03
638	veniam repellendus vel	Nisi fuga qui ut exercitationem neque tempore maxime.	594.21	0	7	2025-08-03 17:53:03	2025-08-03 17:53:03
639	ad repellat consequatur	Ratione voluptatem aliquam dignissimos ducimus nisi natus voluptate quasi enim perferendis omnis.	819.17	82	7	2025-08-03 17:53:03	2025-08-03 17:53:03
640	et velit blanditiis	Sint molestias aliquam consequuntur cumque nam sequi.	197.09	4	7	2025-08-03 17:53:03	2025-08-03 17:53:03
641	dolores excepturi omnis	Repellat enim quia eos consequatur officiis qui placeat.	947.16	56	7	2025-08-03 17:53:03	2025-08-03 17:53:03
642	quia minus neque	Harum ut dignissimos soluta dolorum blanditiis culpa aut ipsum sed.	706.06	25	7	2025-08-03 17:53:03	2025-08-03 17:53:03
643	amet id quidem	Quia suscipit et esse ut voluptatum fuga et sunt.	487.99	62	7	2025-08-03 17:53:03	2025-08-03 17:53:03
644	nulla quasi est	Deserunt voluptas amet laudantium facere rem error eum et officiis eum.	379.77	31	7	2025-08-03 17:53:03	2025-08-03 17:53:03
645	quis repudiandae illum	Sunt asperiores sapiente eum et eum non.	796.29	18	7	2025-08-03 17:53:03	2025-08-03 17:53:03
646	est qui incidunt	Magnam nisi vel minima occaecati qui sint neque.	549.74	57	7	2025-08-03 17:53:03	2025-08-03 17:53:03
647	ipsa cumque voluptatibus	Facere dolor a blanditiis nihil dolor et molestias.	275.74	64	7	2025-08-03 17:53:03	2025-08-03 17:53:03
648	ut fuga unde	Natus nesciunt aut tenetur mollitia a laudantium id nesciunt quia doloremque ducimus.	720.15	44	7	2025-08-03 17:53:03	2025-08-03 17:53:03
649	ea quod reiciendis	Natus aut quo repellendus non aut aut.	21.50	63	7	2025-08-03 17:53:03	2025-08-03 17:53:03
650	saepe eaque velit	Incidunt quae sed ducimus iure dolor velit molestias unde sit.	512.96	100	7	2025-08-03 17:53:03	2025-08-03 17:53:03
651	aspernatur maiores sunt	Et delectus enim facere expedita est omnis eos.	390.06	80	7	2025-08-03 17:53:03	2025-08-03 17:53:03
652	corporis porro quaerat	Velit distinctio nostrum magnam perspiciatis id eius sit voluptatibus reprehenderit ab rem nemo.	916.19	98	7	2025-08-03 17:53:03	2025-08-03 17:53:03
653	quis et autem	Veritatis aut cupiditate quod officia aut laboriosam dolorum quia esse aliquam est perspiciatis.	236.76	50	7	2025-08-03 17:53:03	2025-08-03 17:53:03
654	consequatur ab quae	Laborum dolore molestiae ex vel qui asperiores quo.	883.84	90	7	2025-08-03 17:53:03	2025-08-03 17:53:03
655	est aut iure	Ab ut minima ut perspiciatis pariatur incidunt commodi.	437.74	41	7	2025-08-03 17:53:03	2025-08-03 17:53:03
656	qui molestiae et	Alias error labore expedita odio inventore voluptatem occaecati.	485.18	50	7	2025-08-03 17:53:03	2025-08-03 17:53:03
657	iste in ipsa	Cum cumque dolorum nisi qui harum qui illo est atque sit aliquam.	664.08	14	7	2025-08-03 17:53:03	2025-08-03 17:53:03
658	natus fugit excepturi	Eum voluptas eveniet beatae voluptate in sint.	684.89	87	7	2025-08-03 17:53:03	2025-08-03 17:53:03
659	dicta dolor vel	Sit corporis deserunt unde labore quasi tenetur soluta impedit laborum.	645.06	49	7	2025-08-03 17:53:03	2025-08-03 17:53:03
660	adipisci ea dolor	Voluptas aperiam id nisi numquam iure repellendus sit laudantium voluptas repellat voluptatum et pariatur.	54.83	78	7	2025-08-03 17:53:03	2025-08-03 17:53:03
661	repudiandae velit quis	Officia nemo officiis dignissimos sit minima sed sed tenetur aliquam eos voluptates et.	18.20	86	7	2025-08-03 17:53:03	2025-08-03 17:53:03
662	voluptatibus eligendi hic	Similique numquam commodi non unde dicta quidem enim nesciunt ducimus voluptas officiis commodi perspiciatis.	142.62	22	7	2025-08-03 17:53:03	2025-08-03 17:53:03
663	nulla sint cupiditate	Doloremque incidunt aut cumque sit dignissimos voluptas reprehenderit consectetur voluptatem aut quas quaerat aut.	15.76	51	7	2025-08-03 17:53:03	2025-08-03 17:53:03
664	nihil ad quam	Sed eos voluptatibus non sunt non et veniam voluptatem aut repellat corporis enim.	476.06	56	7	2025-08-03 17:53:03	2025-08-03 17:53:03
665	consectetur incidunt laudantium	Sint quaerat aut totam consequatur repudiandae eos quibusdam ut.	678.34	8	7	2025-08-03 17:53:03	2025-08-03 17:53:03
666	est vitae sapiente	Culpa numquam eveniet dolorem culpa laudantium voluptas veniam quo qui voluptates.	375.55	6	7	2025-08-03 17:53:03	2025-08-03 17:53:03
667	vel quia ut	Culpa nemo consequatur qui eligendi et adipisci.	776.26	3	7	2025-08-03 17:53:03	2025-08-03 17:53:03
668	expedita enim non	Voluptate commodi aperiam magni qui quibusdam architecto veritatis magni voluptas.	818.63	41	7	2025-08-03 17:53:03	2025-08-03 17:53:03
669	ab velit eveniet	Qui magnam esse unde error tempore repudiandae deserunt.	897.46	52	7	2025-08-03 17:53:03	2025-08-03 17:53:03
670	voluptate consequatur et	Sunt quisquam repudiandae nihil error occaecati consequatur voluptas aliquid maiores nihil vel nostrum.	394.84	74	7	2025-08-03 17:53:03	2025-08-03 17:53:03
671	rerum aut eos	Vel quas numquam dolor quas recusandae ducimus iusto possimus corporis saepe repellendus.	884.31	21	7	2025-08-03 17:53:03	2025-08-03 17:53:03
672	omnis dolor provident	Sunt officiis dolores voluptatem et quam ut et.	474.64	47	7	2025-08-03 17:53:03	2025-08-03 17:53:03
673	neque dignissimos assumenda	Odit vero aliquam perspiciatis doloremque hic ea.	775.70	90	7	2025-08-03 17:53:03	2025-08-03 17:53:03
674	libero enim veniam	Corrupti ipsa consequatur laboriosam molestias et alias ratione.	575.27	92	7	2025-08-03 17:53:03	2025-08-03 17:53:03
675	sit sunt nobis	Ea eum ut ex facilis hic corporis quisquam quae vero enim quis.	280.03	23	7	2025-08-03 17:53:03	2025-08-03 17:53:03
676	totam id eos	Et vitae ut ab quisquam odit laudantium quasi non voluptate.	285.39	72	7	2025-08-03 17:53:03	2025-08-03 17:53:03
677	minima maiores libero	Maxime laborum aperiam animi non neque necessitatibus explicabo totam quibusdam et consequatur aliquam.	693.99	78	7	2025-08-03 17:53:03	2025-08-03 17:53:03
678	voluptatibus voluptates nobis	Error perferendis sed cum tenetur aut placeat consequuntur maiores beatae atque non modi.	184.68	74	7	2025-08-03 17:53:03	2025-08-03 17:53:03
679	consequatur sit voluptatibus	Voluptatum voluptatum quia aut quis sunt voluptatem ipsam dolore minima est nisi.	64.20	23	7	2025-08-03 17:53:03	2025-08-03 17:53:03
680	qui repellat deserunt	Earum rerum ab mollitia distinctio enim ea harum.	410.77	24	7	2025-08-03 17:53:03	2025-08-03 17:53:03
681	nostrum tenetur maiores	Cupiditate maxime animi id animi laudantium delectus a.	536.80	3	7	2025-08-03 17:53:03	2025-08-03 17:53:03
682	earum aut quod	Sapiente temporibus alias in eveniet unde ut voluptatem qui tempora odio natus.	942.90	47	7	2025-08-03 17:53:03	2025-08-03 17:53:03
683	qui provident qui	Suscipit occaecati pariatur ipsum beatae dolore sit ab laudantium repudiandae rerum.	778.09	37	7	2025-08-03 17:53:03	2025-08-03 17:53:03
684	architecto sunt ducimus	Doloribus perferendis sed enim iure delectus occaecati aspernatur nemo.	47.26	80	7	2025-08-03 17:53:03	2025-08-03 17:53:03
685	quasi labore non	Officiis fugit vel facilis porro quos sint sapiente.	448.30	42	7	2025-08-03 17:53:03	2025-08-03 17:53:03
686	laborum nam explicabo	Nobis sed voluptates ipsam dolorem voluptatum quam velit provident placeat quam facere necessitatibus.	621.80	7	7	2025-08-03 17:53:03	2025-08-03 17:53:03
687	dolor est atque	Qui eius sit assumenda nisi odit quae enim.	91.35	22	7	2025-08-03 17:53:03	2025-08-03 17:53:03
688	quo sed enim	Odio rerum occaecati repellat delectus nostrum perspiciatis quibusdam assumenda.	293.98	99	7	2025-08-03 17:53:03	2025-08-03 17:53:03
689	vel sunt earum	Nesciunt dolor vero facere suscipit ut sed quae asperiores sit animi voluptatem.	343.29	89	7	2025-08-03 17:53:03	2025-08-03 17:53:03
690	et dolore distinctio	Sit totam quaerat eum ut labore est est tempore eos.	251.58	1	7	2025-08-03 17:53:03	2025-08-03 17:53:03
691	et nostrum non	Quis et voluptatem labore sunt velit enim consequuntur non delectus et rem eveniet.	424.94	26	7	2025-08-03 17:53:03	2025-08-03 17:53:03
692	itaque et in	Necessitatibus sapiente repellendus quis cum et dolorem quia quod.	933.24	33	7	2025-08-03 17:53:03	2025-08-03 17:53:03
693	libero sint ratione	Voluptatum suscipit voluptatibus quidem iusto tempore ea.	990.61	42	7	2025-08-03 17:53:03	2025-08-03 17:53:03
694	fugiat tenetur sequi	Recusandae et aliquam impedit voluptas dolore consequatur voluptatibus dolorem culpa ut non.	330.64	21	7	2025-08-03 17:53:03	2025-08-03 17:53:03
695	nemo atque maiores	Voluptas fugiat deserunt aut et et iure rem repudiandae quibusdam.	270.08	19	7	2025-08-03 17:53:03	2025-08-03 17:53:03
696	dolorem et consequatur	Atque molestias perspiciatis rerum rerum veritatis odio aliquam ipsum fuga qui.	411.53	46	7	2025-08-03 17:53:03	2025-08-03 17:53:03
697	amet velit labore	Et iure officia sed sed enim vel qui laboriosam sit aut commodi quod non.	368.02	9	7	2025-08-03 17:53:03	2025-08-03 17:53:03
698	nihil nam quibusdam	Id facilis dolor eligendi ut at quibusdam eos totam dolorem.	888.55	70	7	2025-08-03 17:53:03	2025-08-03 17:53:03
699	aut tenetur ad	Doloremque quis sit saepe harum deleniti ullam est totam ut magnam quia.	213.19	100	7	2025-08-03 17:53:03	2025-08-03 17:53:03
700	sit sit suscipit	Et ut in voluptas rerum inventore optio vel minus mollitia fuga.	593.09	66	7	2025-08-03 17:53:03	2025-08-03 17:53:03
701	quaerat aut totam	Quas officiis itaque quas et repellat perferendis nihil ipsum maxime.	410.82	83	8	2025-08-03 17:53:06	2025-08-03 17:53:06
702	dicta non sed	Similique quam officia voluptas possimus voluptates optio eaque culpa et accusantium nam eos et.	483.32	17	8	2025-08-03 17:53:06	2025-08-03 17:53:06
703	qui magni dignissimos	Quisquam rem non labore officiis non sit.	358.56	48	8	2025-08-03 17:53:06	2025-08-03 17:53:06
704	illum tenetur molestias	Ut dolore consectetur sint ut ut necessitatibus in sint aut qui autem.	944.70	83	8	2025-08-03 17:53:06	2025-08-03 17:53:06
705	sint nostrum autem	Illum repudiandae recusandae labore molestiae aspernatur quas dolores velit impedit laborum eum.	590.42	51	8	2025-08-03 17:53:06	2025-08-03 17:53:06
706	amet consequatur ut	Laudantium cupiditate eaque sequi ut sed rerum.	86.15	86	8	2025-08-03 17:53:06	2025-08-03 17:53:06
707	quia laudantium possimus	Error quisquam rerum saepe quia quis corporis.	555.36	41	8	2025-08-03 17:53:06	2025-08-03 17:53:06
708	natus tempore dicta	Ducimus non nulla voluptatem in ut ut.	384.07	15	8	2025-08-03 17:53:06	2025-08-03 17:53:06
709	suscipit ut enim	Neque aperiam non ut praesentium sed ad nam velit dolore cumque.	257.33	35	8	2025-08-03 17:53:06	2025-08-03 17:53:06
710	beatae sapiente nemo	Vel eum tempora rerum iste possimus reiciendis sit sint mollitia.	386.32	16	8	2025-08-03 17:53:06	2025-08-03 17:53:06
711	sit magnam quisquam	Ad ut sit consectetur aut provident enim id iste qui minima.	880.97	33	8	2025-08-03 17:53:06	2025-08-03 17:53:06
712	architecto nihil asperiores	Ut et et ex sunt suscipit distinctio.	285.31	97	8	2025-08-03 17:53:06	2025-08-03 17:53:06
713	sed quo natus	Et beatae molestiae quam provident aut quo.	619.19	38	8	2025-08-03 17:53:06	2025-08-03 17:53:06
714	accusantium accusamus enim	Aspernatur et veniam quia omnis aut consequatur sed ut.	945.81	87	8	2025-08-03 17:53:06	2025-08-03 17:53:06
715	odit quia suscipit	Molestiae dolorem aspernatur delectus nihil dolorem sequi porro quam placeat sit.	985.98	22	8	2025-08-03 17:53:06	2025-08-03 17:53:06
716	recusandae incidunt fuga	Asperiores dolor ut veniam rerum omnis dolor sit.	975.21	72	8	2025-08-03 17:53:06	2025-08-03 17:53:06
717	ipsum itaque praesentium	Et ex officia voluptatum labore repellendus libero vero non quis doloremque dolor.	231.54	71	8	2025-08-03 17:53:06	2025-08-03 17:53:06
718	debitis fugit inventore	Eos quam sunt illum dolorem eveniet a.	422.79	62	8	2025-08-03 17:53:06	2025-08-03 17:53:06
719	molestias facere soluta	Autem voluptate soluta ea rerum aliquam repellat non ratione corrupti consequatur exercitationem assumenda delectus.	673.81	77	8	2025-08-03 17:53:06	2025-08-03 17:53:06
720	excepturi nihil impedit	Consequatur ex veniam eligendi occaecati eos tenetur dolorum impedit tempore rerum rerum sint aut.	323.12	76	8	2025-08-03 17:53:06	2025-08-03 17:53:06
721	explicabo nulla incidunt	Nisi quas ut culpa libero eum repellendus animi laboriosam dolore et quisquam.	232.99	58	8	2025-08-03 17:53:06	2025-08-03 17:53:06
722	voluptates accusantium voluptas	Amet aperiam nihil et qui et facere iusto et blanditiis deleniti.	81.73	33	8	2025-08-03 17:53:06	2025-08-03 17:53:06
723	non atque et	Accusamus dolores exercitationem sit placeat ut nostrum fugiat.	267.61	37	8	2025-08-03 17:53:06	2025-08-03 17:53:06
724	esse quo sint	Dolores quis veniam cum at quia autem pariatur.	347.53	13	8	2025-08-03 17:53:06	2025-08-03 17:53:06
725	consectetur et sit	Ducimus voluptatibus veritatis beatae et doloremque autem accusantium expedita minima illo sed reiciendis quis.	666.16	94	8	2025-08-03 17:53:06	2025-08-03 17:53:06
726	odit ea accusamus	Ut dolore nihil voluptate veritatis aut omnis reiciendis aliquid minima est deserunt vero eos.	263.07	6	8	2025-08-03 17:53:06	2025-08-03 17:53:06
727	molestias ut eligendi	Distinctio consequatur dolorum eos qui illum vel quo.	754.01	48	8	2025-08-03 17:53:06	2025-08-03 17:53:06
728	voluptate voluptates quo	Ab esse similique inventore et omnis iure reprehenderit et iusto deleniti non sit.	783.30	94	8	2025-08-03 17:53:06	2025-08-03 17:53:06
729	perspiciatis molestias veniam	Est maiores doloribus rerum fugit est qui magnam quam pariatur laborum.	728.35	75	8	2025-08-03 17:53:06	2025-08-03 17:53:06
730	quisquam assumenda nam	Nobis culpa explicabo magnam quo pariatur debitis ipsam veniam in odit qui consequuntur.	989.05	58	8	2025-08-03 17:53:06	2025-08-03 17:53:06
731	alias voluptatum sit	Id eum voluptas maxime vitae voluptatum repudiandae saepe accusamus in impedit et nisi autem.	810.28	36	8	2025-08-03 17:53:06	2025-08-03 17:53:06
732	asperiores soluta ab	Sunt et numquam impedit explicabo est commodi et ut aliquid.	361.49	66	8	2025-08-03 17:53:06	2025-08-03 17:53:06
733	officiis dolore voluptatem	Ut voluptatum et a ea corporis et modi impedit voluptas at consectetur mollitia.	175.86	80	8	2025-08-03 17:53:06	2025-08-03 17:53:06
734	vel quae placeat	Saepe enim et ea eaque sit facilis et mollitia ullam.	164.03	65	8	2025-08-03 17:53:06	2025-08-03 17:53:06
735	vel ipsum nemo	Cupiditate fuga quidem unde rem dicta dolorem in corrupti in et reprehenderit.	745.02	5	8	2025-08-03 17:53:06	2025-08-03 17:53:06
736	dolorem officia sapiente	Ab cum quo repellendus fuga quae et aperiam.	325.88	63	8	2025-08-03 17:53:06	2025-08-03 17:53:06
737	amet et rerum	Quod eos odit earum ut quia corrupti optio laborum accusantium ullam expedita in.	746.12	59	8	2025-08-03 17:53:06	2025-08-03 17:53:06
738	in repellendus officia	Fugiat iste et accusantium et consectetur est minima.	558.93	62	8	2025-08-03 17:53:06	2025-08-03 17:53:06
739	velit omnis accusamus	Quod velit iusto fugit tempora placeat corporis error error error sint quo quia voluptatem.	703.35	57	8	2025-08-03 17:53:06	2025-08-03 17:53:06
740	harum tenetur velit	Perspiciatis quia maxime ut totam quae distinctio tenetur labore sunt dignissimos architecto hic.	195.01	50	8	2025-08-03 17:53:06	2025-08-03 17:53:06
741	quibusdam saepe sunt	Quo neque aperiam totam veritatis dolorum adipisci delectus quisquam aliquam dicta illum aut praesentium.	467.35	91	8	2025-08-03 17:53:06	2025-08-03 17:53:06
742	aperiam repellat quia	Voluptates sequi molestias suscipit porro praesentium beatae nihil dolorem dolores.	790.37	93	8	2025-08-03 17:53:06	2025-08-03 17:53:06
743	veritatis sunt quam	Voluptatem est reprehenderit non est pariatur modi voluptas officia voluptatibus necessitatibus odio enim impedit.	874.04	99	8	2025-08-03 17:53:06	2025-08-03 17:53:06
744	ad suscipit qui	Quas et adipisci delectus totam quos provident reiciendis animi deserunt modi qui porro culpa.	390.35	10	8	2025-08-03 17:53:06	2025-08-03 17:53:06
745	expedita laboriosam suscipit	Nulla tempore autem voluptas qui delectus reiciendis consequatur facilis distinctio.	916.18	12	8	2025-08-03 17:53:06	2025-08-03 17:53:06
746	consequatur nihil et	Nisi suscipit ut dolor nisi soluta consequuntur aut.	404.99	90	8	2025-08-03 17:53:06	2025-08-03 17:53:06
747	id nisi quasi	Ad saepe est quasi et officiis enim quaerat voluptate facilis autem ipsa ullam.	501.58	10	8	2025-08-03 17:53:06	2025-08-03 17:53:06
748	fugiat eum id	Qui debitis eum voluptatem iure temporibus perspiciatis consequuntur ut ea velit vel.	909.77	71	8	2025-08-03 17:53:06	2025-08-03 17:53:06
749	voluptatem inventore aliquid	Quod dolor eligendi et fuga perferendis est accusantium provident quod consectetur qui sequi.	459.54	17	8	2025-08-03 17:53:06	2025-08-03 17:53:06
750	vel fugit sunt	Necessitatibus minima et cumque cupiditate est impedit explicabo voluptatibus.	289.40	21	8	2025-08-03 17:53:06	2025-08-03 17:53:06
751	id sed officiis	Voluptatibus officiis nemo unde velit eligendi nemo voluptas necessitatibus consequuntur sequi.	916.63	78	8	2025-08-03 17:53:06	2025-08-03 17:53:06
752	consequatur doloremque rem	Sunt id numquam commodi qui impedit aut.	464.69	93	8	2025-08-03 17:53:06	2025-08-03 17:53:06
753	autem fuga natus	Eligendi aut mollitia quasi placeat vel assumenda culpa excepturi.	265.31	54	8	2025-08-03 17:53:06	2025-08-03 17:53:06
754	dolores exercitationem molestiae	Dicta dolores aut molestiae soluta consectetur magni sed enim odio cupiditate in.	423.64	87	8	2025-08-03 17:53:06	2025-08-03 17:53:06
755	repellendus nam ullam	Deleniti id hic consequatur labore repellat iste voluptates aperiam sit sunt.	504.73	47	8	2025-08-03 17:53:06	2025-08-03 17:53:06
756	non quia laboriosam	Saepe omnis molestias ipsa molestias quia nam veniam.	668.04	68	8	2025-08-03 17:53:06	2025-08-03 17:53:06
757	autem ut doloribus	Aut ut maiores molestiae minima temporibus aut dicta rem.	865.70	50	8	2025-08-03 17:53:06	2025-08-03 17:53:06
758	voluptatem consequuntur perferendis	Molestiae aut possimus dolorum nobis quibusdam vel voluptates sint at qui nesciunt et.	123.44	10	8	2025-08-03 17:53:06	2025-08-03 17:53:06
759	soluta aut corrupti	Nihil odit velit molestiae recusandae temporibus ab autem illo reiciendis.	114.52	90	8	2025-08-03 17:53:06	2025-08-03 17:53:06
760	quia quisquam iure	Consectetur necessitatibus dicta porro sequi laborum quidem similique laudantium suscipit maxime doloribus.	998.78	74	8	2025-08-03 17:53:06	2025-08-03 17:53:06
761	inventore eligendi et	Aliquam esse iure sint repellat nobis in non consequuntur fugit.	806.68	77	8	2025-08-03 17:53:06	2025-08-03 17:53:06
762	hic porro delectus	Est illum vel dicta natus molestias delectus reprehenderit.	168.62	56	8	2025-08-03 17:53:06	2025-08-03 17:53:06
763	eum voluptatibus velit	Blanditiis nemo et et dolores quod sed officia voluptatem illum error possimus in aspernatur.	503.88	80	8	2025-08-03 17:53:06	2025-08-03 17:53:06
764	temporibus ut totam	Praesentium dolore amet odio cupiditate reiciendis rem id provident et non molestias.	276.03	65	8	2025-08-03 17:53:06	2025-08-03 17:53:06
765	voluptate ea adipisci	Veniam iste at doloremque sit repudiandae enim ipsum voluptates dicta magni et aut.	712.04	97	8	2025-08-03 17:53:06	2025-08-03 17:53:06
766	eligendi sint voluptates	Aut cum architecto aut sunt voluptatibus reiciendis quae quas non quos ut.	556.23	16	8	2025-08-03 17:53:06	2025-08-03 17:53:06
767	omnis eos nihil	Velit dolorum repudiandae qui ullam consequatur sed.	130.67	44	8	2025-08-03 17:53:06	2025-08-03 17:53:06
768	accusantium excepturi modi	Adipisci cum commodi architecto sit architecto sed eos sint aut quasi nostrum officia doloribus.	843.43	17	8	2025-08-03 17:53:06	2025-08-03 17:53:06
769	ipsa eos rerum	Dolores saepe molestiae recusandae dolorem et totam et perferendis qui distinctio.	858.15	11	8	2025-08-03 17:53:06	2025-08-03 17:53:06
770	fugit animi ipsum	Minima et aut minima aspernatur est tempore veritatis magni.	174.44	90	8	2025-08-03 17:53:06	2025-08-03 17:53:06
771	dolor esse quam	Qui rerum aut ducimus odit excepturi tenetur alias dolores voluptatem est.	472.11	74	8	2025-08-03 17:53:06	2025-08-03 17:53:06
870	aut qui voluptatibus	Totam velit est vel ea quia iste consequatur in.	185.02	32	9	2025-08-03 17:53:09	2025-08-03 17:53:09
772	itaque iste voluptatem	Facilis quos iste laborum omnis qui et magnam nobis nobis quam architecto expedita aut.	694.98	46	8	2025-08-03 17:53:06	2025-08-03 17:53:06
773	voluptas reprehenderit ut	Omnis eligendi nulla error dolor molestiae enim quia laborum soluta.	439.11	78	8	2025-08-03 17:53:06	2025-08-03 17:53:06
774	fugiat ut sequi	Ullam necessitatibus et quasi autem quaerat deleniti esse natus dignissimos sit enim aliquam sint.	330.83	84	8	2025-08-03 17:53:06	2025-08-03 17:53:06
775	et repudiandae est	Veniam iusto et non qui eligendi vitae quo.	759.54	99	8	2025-08-03 17:53:06	2025-08-03 17:53:06
776	illum cum dolores	Quia ullam animi et nemo iusto aut laudantium.	352.26	63	8	2025-08-03 17:53:06	2025-08-03 17:53:06
777	amet sed omnis	Placeat minima et possimus blanditiis voluptate sunt repellendus repellat consequatur natus.	269.70	19	8	2025-08-03 17:53:06	2025-08-03 17:53:06
778	perspiciatis rerum praesentium	Ut in saepe est ex nihil qui dignissimos incidunt ut eligendi.	285.23	36	8	2025-08-03 17:53:06	2025-08-03 17:53:06
779	voluptatibus hic dignissimos	Atque molestias fugit nulla minima provident illo hic.	248.79	7	8	2025-08-03 17:53:06	2025-08-03 17:53:06
780	dolorem quaerat aperiam	Consectetur nihil ullam alias aspernatur rerum ut quasi sed.	601.51	66	8	2025-08-03 17:53:06	2025-08-03 17:53:06
781	inventore quia qui	Iste ut voluptatem ea laborum optio nam nemo rerum et tempora nam et recusandae.	980.44	84	8	2025-08-03 17:53:06	2025-08-03 17:53:06
782	fugiat rem praesentium	Non consequatur et iste consequatur voluptas corporis quasi cumque sed nostrum velit eaque deleniti ut.	966.90	26	8	2025-08-03 17:53:06	2025-08-03 17:53:06
783	assumenda voluptatem vel	Sequi eum praesentium omnis recusandae excepturi cum atque consequatur.	923.36	80	8	2025-08-03 17:53:06	2025-08-03 17:53:06
784	sunt dolor aut	Voluptas dicta error et exercitationem a aut.	428.92	94	8	2025-08-03 17:53:06	2025-08-03 17:53:06
785	consectetur aut mollitia	Suscipit et et voluptatem eos dignissimos minima quia et.	942.95	1	8	2025-08-03 17:53:06	2025-08-03 17:53:06
786	minima omnis quia	Explicabo illum asperiores velit aut voluptas dicta at tempora.	80.54	60	8	2025-08-03 17:53:06	2025-08-03 17:53:06
787	modi dolorum veritatis	Debitis velit est a facere ut deleniti ex at consequuntur dolor.	353.49	8	8	2025-08-03 17:53:06	2025-08-03 17:53:06
788	sunt est repudiandae	Qui est consequatur sed esse eveniet amet molestias vero quisquam accusamus enim doloribus ut.	20.98	88	8	2025-08-03 17:53:06	2025-08-03 17:53:06
789	nulla ad voluptatibus	Fuga animi sit facere aliquid deleniti autem sunt excepturi rerum voluptas.	33.86	18	8	2025-08-03 17:53:06	2025-08-03 17:53:06
790	laborum reiciendis alias	Cum perspiciatis ex pariatur aut repellat voluptatum excepturi quia suscipit.	584.36	29	8	2025-08-03 17:53:06	2025-08-03 17:53:06
791	voluptas autem voluptatem	Exercitationem voluptas incidunt atque laboriosam officia natus unde.	999.61	14	8	2025-08-03 17:53:06	2025-08-03 17:53:06
792	facilis atque blanditiis	Ut aspernatur ut et est eaque dolorem in officia provident facilis numquam non.	116.99	73	8	2025-08-03 17:53:06	2025-08-03 17:53:06
793	asperiores qui iste	Ducimus dicta nesciunt expedita autem quae ad non corporis velit.	599.02	30	8	2025-08-03 17:53:06	2025-08-03 17:53:06
794	qui qui aut	Aut mollitia possimus hic et culpa repellat.	847.44	96	8	2025-08-03 17:53:06	2025-08-03 17:53:06
795	sit nisi repudiandae	Occaecati exercitationem quis ut repudiandae odit aspernatur eius nostrum et cumque quod enim eum.	393.28	90	8	2025-08-03 17:53:06	2025-08-03 17:53:06
796	recusandae laborum excepturi	Aut ipsum dolores minima ea et asperiores quia iusto aperiam esse.	536.85	26	8	2025-08-03 17:53:06	2025-08-03 17:53:06
797	nulla vel voluptatibus	Qui assumenda eligendi odio sequi atque in culpa laboriosam.	24.36	29	8	2025-08-03 17:53:06	2025-08-03 17:53:06
798	illum ipsam voluptatibus	Voluptas et vitae illo et laboriosam ut neque et optio molestiae.	569.84	2	8	2025-08-03 17:53:06	2025-08-03 17:53:06
799	nihil quasi ab	Temporibus maxime unde modi in rerum ipsam voluptatem autem.	882.54	85	8	2025-08-03 17:53:06	2025-08-03 17:53:06
800	aspernatur et similique	Dicta ut et occaecati eligendi qui itaque quis magnam doloribus vel voluptates.	999.61	49	8	2025-08-03 17:53:06	2025-08-03 17:53:06
801	sit molestiae ut	Architecto id ducimus qui saepe aliquam quia cumque.	817.96	85	9	2025-08-03 17:53:09	2025-08-03 17:53:09
802	veritatis iure quia	Qui voluptatum rem aliquam molestias qui quas quia quia ut molestias est.	566.61	34	9	2025-08-03 17:53:09	2025-08-03 17:53:09
803	nesciunt fugiat delectus	Et et distinctio omnis ut fuga ea minima illo dolore laudantium veritatis qui.	872.02	76	9	2025-08-03 17:53:09	2025-08-03 17:53:09
804	qui quia dolores	Beatae ut odit minima et aut alias pariatur et libero dolorum quia dignissimos.	670.03	58	9	2025-08-03 17:53:09	2025-08-03 17:53:09
805	magni consequatur dolores	Ipsa assumenda rem quaerat beatae voluptatem qui blanditiis dolores.	659.01	26	9	2025-08-03 17:53:09	2025-08-03 17:53:09
806	ut eos quis	Minima nihil veritatis non vel sed consectetur enim labore nulla.	779.15	8	9	2025-08-03 17:53:09	2025-08-03 17:53:09
807	quo sunt quo	Nihil dolores ab perspiciatis maiores nam aut.	202.86	76	9	2025-08-03 17:53:09	2025-08-03 17:53:09
808	expedita qui tempora	Error at sed eveniet tempora aliquid natus doloremque quos quo aut asperiores dolor itaque.	821.65	63	9	2025-08-03 17:53:09	2025-08-03 17:53:09
809	labore sunt a	Ex eius sed maiores sunt accusantium tenetur aut.	99.66	85	9	2025-08-03 17:53:09	2025-08-03 17:53:09
810	et consequuntur cum	Exercitationem quis harum quia cum error porro aspernatur laboriosam totam modi veniam.	214.82	38	9	2025-08-03 17:53:09	2025-08-03 17:53:09
811	vel laboriosam dolores	Omnis cumque aut delectus molestias sequi fuga et sit doloremque dolores adipisci reiciendis quia.	979.76	60	9	2025-08-03 17:53:09	2025-08-03 17:53:09
812	ducimus molestiae exercitationem	Exercitationem et incidunt provident sit cupiditate atque neque sint qui a quo qui mollitia.	832.76	65	9	2025-08-03 17:53:09	2025-08-03 17:53:09
813	id sit eos	Asperiores pariatur id maiores numquam ut tenetur.	450.77	96	9	2025-08-03 17:53:09	2025-08-03 17:53:09
814	distinctio dolor magnam	Laborum autem quisquam aliquid qui voluptatem hic consectetur repudiandae consequatur minus sit.	57.74	74	9	2025-08-03 17:53:09	2025-08-03 17:53:09
815	et id voluptas	Voluptatem repellat illum aliquam mollitia dolorem sequi magnam eos.	496.16	47	9	2025-08-03 17:53:09	2025-08-03 17:53:09
816	porro a sit	Provident aspernatur iure optio eum odit adipisci excepturi.	24.08	10	9	2025-08-03 17:53:09	2025-08-03 17:53:09
817	harum illo qui	Veritatis est unde similique aperiam sunt voluptas debitis.	989.87	42	9	2025-08-03 17:53:09	2025-08-03 17:53:09
818	autem voluptatem soluta	Qui est mollitia aliquam sapiente quos molestiae aliquam beatae et dolor.	884.68	25	9	2025-08-03 17:53:09	2025-08-03 17:53:09
819	est deleniti est	Iure at qui iure dignissimos saepe pariatur aut non veniam.	444.26	19	9	2025-08-03 17:53:09	2025-08-03 17:53:09
871	et culpa nulla	Libero odio dolor a odit occaecati impedit eum enim nemo eveniet placeat.	752.54	90	9	2025-08-03 17:53:09	2025-08-03 17:53:09
820	nulla ratione eaque	Aut voluptate quam est ullam amet ut officiis distinctio incidunt voluptate.	914.30	87	9	2025-08-03 17:53:09	2025-08-03 17:53:09
821	dolores impedit impedit	Sint alias incidunt voluptatibus ut veritatis est quam aut.	536.74	62	9	2025-08-03 17:53:09	2025-08-03 17:53:09
822	error commodi qui	Illum rerum eum explicabo dolorem id est qui reprehenderit.	901.67	35	9	2025-08-03 17:53:09	2025-08-03 17:53:09
823	sit quo possimus	Odio nesciunt ut voluptatum dolor minus dolorum magnam qui.	424.30	51	9	2025-08-03 17:53:09	2025-08-03 17:53:09
824	natus sequi iusto	Sit deserunt deserunt aut vero eos unde ea ullam.	770.82	84	9	2025-08-03 17:53:09	2025-08-03 17:53:09
825	esse nam officia	Dolor magnam voluptas qui non ratione modi sit maiores cumque.	346.55	9	9	2025-08-03 17:53:09	2025-08-03 17:53:09
826	nisi ut aut	Nemo in incidunt repellendus commodi quisquam dolores delectus et soluta minima quas et.	700.39	77	9	2025-08-03 17:53:09	2025-08-03 17:53:09
827	asperiores suscipit totam	Odit asperiores a necessitatibus quibusdam repellendus esse.	526.70	22	9	2025-08-03 17:53:09	2025-08-03 17:53:09
828	corrupti voluptate ex	Sit ipsum tempora ut eum sint maiores et voluptas similique.	587.39	6	9	2025-08-03 17:53:09	2025-08-03 17:53:09
829	amet earum deserunt	Sint et earum similique qui itaque voluptatem ut.	653.46	56	9	2025-08-03 17:53:09	2025-08-03 17:53:09
830	iure ut molestias	Aperiam harum consequatur voluptas iste eligendi est molestiae.	549.50	35	9	2025-08-03 17:53:09	2025-08-03 17:53:09
831	sequi consequatur ratione	Repellat eos odit molestiae ut omnis qui ut voluptatem.	320.81	71	9	2025-08-03 17:53:09	2025-08-03 17:53:09
832	quia eveniet vel	Non dolorem deleniti dolorum doloremque dolorem qui enim asperiores nisi nam est delectus tempora.	326.81	44	9	2025-08-03 17:53:09	2025-08-03 17:53:09
833	quo asperiores et	Nobis eligendi porro corporis id facere qui placeat explicabo atque sint et excepturi.	144.79	39	9	2025-08-03 17:53:09	2025-08-03 17:53:09
834	delectus debitis ab	Porro necessitatibus accusantium in sint ea eveniet sunt cumque reiciendis.	642.28	45	9	2025-08-03 17:53:09	2025-08-03 17:53:09
835	enim laboriosam aut	Non facilis ut temporibus sed commodi dolores aperiam vero dolor.	242.52	4	9	2025-08-03 17:53:09	2025-08-03 17:53:09
836	ipsum aliquid quidem	Ea eos accusantium nisi et aliquam itaque voluptatibus omnis sint ad deleniti eos.	630.91	23	9	2025-08-03 17:53:09	2025-08-03 17:53:09
837	laudantium ad sit	Nostrum delectus iusto autem beatae eum eaque cum qui eum minus.	179.27	90	9	2025-08-03 17:53:09	2025-08-03 17:53:09
838	deleniti corporis expedita	Placeat atque repellat iure consequatur placeat eos veniam et velit voluptatum.	879.96	82	9	2025-08-03 17:53:09	2025-08-03 17:53:09
839	quia possimus cum	Quibusdam voluptas quam dolorem provident esse cum quas at necessitatibus sequi.	316.56	79	9	2025-08-03 17:53:09	2025-08-03 17:53:09
840	illo sint hic	Libero sunt id dignissimos qui corrupti et rerum.	98.02	46	9	2025-08-03 17:53:09	2025-08-03 17:53:09
841	repellat quia et	Eos illo placeat assumenda maxime recusandae excepturi ut sunt alias ipsa inventore ut.	109.72	63	9	2025-08-03 17:53:09	2025-08-03 17:53:09
842	pariatur est nihil	Maxime aut odit perferendis voluptatem sit aut quia quo sunt cum in omnis repudiandae.	553.56	71	9	2025-08-03 17:53:09	2025-08-03 17:53:09
843	sit rerum qui	Sed eos beatae quia assumenda ipsa est culpa aspernatur est ut.	495.56	60	9	2025-08-03 17:53:09	2025-08-03 17:53:09
844	in cumque consectetur	Et omnis deserunt voluptatem ipsam eos temporibus non aut.	190.93	8	9	2025-08-03 17:53:09	2025-08-03 17:53:09
845	dolores nemo dolor	Deserunt dolorum dolor placeat dicta ut ex.	212.64	51	9	2025-08-03 17:53:09	2025-08-03 17:53:09
846	impedit voluptas quisquam	Nihil aut illo facilis deleniti omnis recusandae deserunt ipsa dolor ipsam dicta et dolore.	444.63	38	9	2025-08-03 17:53:09	2025-08-03 17:53:09
847	id odit ut	Ratione dolores id voluptatum velit ad aut id eos iste ipsum dolore ea rerum.	418.65	78	9	2025-08-03 17:53:09	2025-08-03 17:53:09
848	est autem earum	Non aut vel aut sit ut velit id.	481.84	20	9	2025-08-03 17:53:09	2025-08-03 17:53:09
849	vel quasi ea	Aperiam quia reprehenderit perspiciatis exercitationem qui blanditiis consequatur.	20.89	49	9	2025-08-03 17:53:09	2025-08-03 17:53:09
850	sunt dolore quidem	Praesentium quo quod eius nihil veritatis modi distinctio assumenda doloremque minus.	477.85	44	9	2025-08-03 17:53:09	2025-08-03 17:53:09
851	ea sit consectetur	Architecto blanditiis recusandae non labore cupiditate incidunt sed odio iusto porro unde eligendi.	626.27	94	9	2025-08-03 17:53:09	2025-08-03 17:53:09
852	fugit corrupti enim	Esse quam harum reiciendis ex eius iusto rerum sit at quis vel ratione et corporis.	110.26	81	9	2025-08-03 17:53:09	2025-08-03 17:53:09
853	amet eius dolorum	Est quidem aut aut quibusdam possimus ea sint.	236.84	47	9	2025-08-03 17:53:09	2025-08-03 17:53:09
854	ad consequatur dolores	Tempora nesciunt voluptatem aliquid nisi pariatur ea inventore.	104.20	8	9	2025-08-03 17:53:09	2025-08-03 17:53:09
855	magni similique omnis	Eos dolores est aut rerum voluptate excepturi accusamus dolorem.	944.92	92	9	2025-08-03 17:53:09	2025-08-03 17:53:09
856	deserunt sed est	Molestias eum repudiandae est tenetur sed ratione tenetur est laudantium corrupti.	765.05	61	9	2025-08-03 17:53:09	2025-08-03 17:53:09
857	praesentium dolorum possimus	Esse natus ipsum maiores quod ullam id id.	423.77	63	9	2025-08-03 17:53:09	2025-08-03 17:53:09
858	ea dolor non	Sed doloribus aut impedit ratione doloremque nostrum cumque qui repellendus ipsam.	689.64	30	9	2025-08-03 17:53:09	2025-08-03 17:53:09
859	praesentium corporis doloribus	Facere voluptatem ut nihil sed reprehenderit earum voluptate omnis aliquid quas fuga nihil.	707.45	83	9	2025-08-03 17:53:09	2025-08-03 17:53:09
860	sit itaque eum	Labore vero qui placeat culpa eligendi enim sed neque repudiandae numquam.	701.43	23	9	2025-08-03 17:53:09	2025-08-03 17:53:09
861	reiciendis ipsam pariatur	Unde cum mollitia sunt alias fugiat excepturi sapiente sunt.	228.07	6	9	2025-08-03 17:53:09	2025-08-03 17:53:09
862	quia excepturi atque	Quas asperiores dignissimos repellendus odio aut aliquam totam porro.	981.60	96	9	2025-08-03 17:53:09	2025-08-03 17:53:09
863	a architecto et	Aut omnis consequatur inventore quas nam reprehenderit aut.	723.98	58	9	2025-08-03 17:53:09	2025-08-03 17:53:09
864	quas velit dolorem	Culpa iure fuga et iure ducimus sapiente amet nemo.	818.89	55	9	2025-08-03 17:53:09	2025-08-03 17:53:09
865	quas non ea	Maxime dolores eveniet hic modi tempora dolore in temporibus.	852.26	98	9	2025-08-03 17:53:09	2025-08-03 17:53:09
866	illo perferendis voluptatum	Sequi consequatur et porro aspernatur ut aliquid accusamus non et ad et.	737.76	83	9	2025-08-03 17:53:09	2025-08-03 17:53:09
867	magni officiis eum	Rerum quo labore dolor consequatur libero natus.	537.45	52	9	2025-08-03 17:53:09	2025-08-03 17:53:09
868	accusantium animi molestias	Debitis eveniet dolor earum magni ea nostrum eligendi sit recusandae enim quo voluptas.	944.69	80	9	2025-08-03 17:53:09	2025-08-03 17:53:09
869	veniam quia optio	Quo distinctio ut ut ut ut libero.	789.77	52	9	2025-08-03 17:53:09	2025-08-03 17:53:09
872	aliquid est voluptate	Et ullam omnis tempora ut praesentium illum.	395.20	20	9	2025-08-03 17:53:09	2025-08-03 17:53:09
873	quidem est aut	Incidunt quod occaecati nihil inventore maiores fugit rerum quos optio odio aut culpa ipsum.	961.51	85	9	2025-08-03 17:53:09	2025-08-03 17:53:09
874	unde ut est	Facilis esse suscipit qui qui voluptatum sit.	28.74	57	9	2025-08-03 17:53:09	2025-08-03 17:53:09
875	mollitia itaque quis	Enim hic commodi iste nostrum doloribus molestias laudantium.	582.52	43	9	2025-08-03 17:53:09	2025-08-03 17:53:09
876	soluta ducimus libero	Recusandae quidem consequatur laborum iste excepturi fugit magni qui.	144.70	78	9	2025-08-03 17:53:09	2025-08-03 17:53:09
877	ex illo voluptatum	Est voluptatibus optio repellat aut mollitia adipisci nihil possimus omnis aut.	951.61	6	9	2025-08-03 17:53:09	2025-08-03 17:53:09
878	qui illum laboriosam	Eos impedit esse voluptatem dolorem nesciunt nihil saepe facere consectetur perferendis a repellendus.	142.21	53	9	2025-08-03 17:53:09	2025-08-03 17:53:09
879	dolore sed repellat	Deserunt rerum quasi odio officiis et voluptatem provident nam itaque.	746.10	99	9	2025-08-03 17:53:09	2025-08-03 17:53:09
880	voluptatem ratione nihil	Voluptatibus qui aut aperiam necessitatibus maxime expedita.	165.97	82	9	2025-08-03 17:53:09	2025-08-03 17:53:09
881	assumenda tempora laborum	Suscipit est temporibus porro sint voluptatem labore.	276.86	23	9	2025-08-03 17:53:09	2025-08-03 17:53:09
882	dolorem non doloribus	Porro sunt dolores quae omnis atque blanditiis officiis odio ullam cupiditate.	413.30	61	9	2025-08-03 17:53:09	2025-08-03 17:53:09
883	pariatur hic veniam	Et fugiat consequuntur est error quae est quod sint voluptates et.	358.72	92	9	2025-08-03 17:53:09	2025-08-03 17:53:09
884	quam odit cumque	Explicabo ut suscipit tempore in sit sit molestiae sapiente voluptate nisi molestiae aliquam voluptas.	452.65	11	9	2025-08-03 17:53:09	2025-08-03 17:53:09
885	et veritatis aliquid	Earum voluptatem ut non doloremque aut similique molestiae iste ullam optio vero.	766.74	82	9	2025-08-03 17:53:09	2025-08-03 17:53:09
886	et necessitatibus sunt	In id rerum tempore saepe error suscipit repellendus praesentium aperiam et est.	325.93	64	9	2025-08-03 17:53:09	2025-08-03 17:53:09
887	sed vitae tempore	Voluptas odio ipsam iste libero quia officiis aut vero quis non.	141.95	35	9	2025-08-03 17:53:09	2025-08-03 17:53:09
888	debitis omnis quod	Nemo quisquam pariatur voluptatibus eius facere eos provident rerum fuga autem nesciunt saepe placeat.	189.83	92	9	2025-08-03 17:53:09	2025-08-03 17:53:09
889	accusamus veritatis et	Aspernatur repellendus eius vero omnis culpa consequatur assumenda similique et labore.	395.10	57	9	2025-08-03 17:53:09	2025-08-03 17:53:09
890	repellendus aut qui	Sed molestias et consequatur excepturi est doloremque soluta ut fugiat beatae sint rem impedit cumque.	90.51	17	9	2025-08-03 17:53:09	2025-08-03 17:53:09
891	possimus odit ipsam	Odio cupiditate incidunt modi velit voluptas molestias dolor dolorem.	919.17	90	9	2025-08-03 17:53:09	2025-08-03 17:53:09
892	sit dolorem ducimus	Pariatur unde sunt in nam corporis excepturi temporibus.	863.27	59	9	2025-08-03 17:53:09	2025-08-03 17:53:09
893	consequatur dolorem nesciunt	Inventore inventore id nihil sit corporis id repellat earum fugit eius quia doloremque quas.	71.27	12	9	2025-08-03 17:53:09	2025-08-03 17:53:09
894	autem nisi maiores	Voluptatibus illum accusantium sit iste eos vel officia ad doloribus impedit quaerat maiores explicabo.	622.79	6	9	2025-08-03 17:53:09	2025-08-03 17:53:09
895	illum nisi tempora	Id autem quis et illum occaecati beatae ipsam asperiores perferendis neque enim facilis officia et.	350.43	20	9	2025-08-03 17:53:09	2025-08-03 17:53:09
896	id sapiente velit	Sint perferendis voluptates hic excepturi blanditiis et perferendis at.	592.35	55	9	2025-08-03 17:53:09	2025-08-03 17:53:09
897	nemo nisi alias	Molestias aperiam amet aliquid quibusdam quo et officia iure maxime aut aut voluptatem laudantium omnis.	786.97	33	9	2025-08-03 17:53:09	2025-08-03 17:53:09
898	doloremque eos assumenda	Hic optio sunt aut odit sed exercitationem nobis dolores.	500.28	7	9	2025-08-03 17:53:09	2025-08-03 17:53:09
899	dolorem velit ratione	Facilis illo delectus non voluptas exercitationem tempora corporis nulla nam et.	538.48	15	9	2025-08-03 17:53:09	2025-08-03 17:53:09
900	ab ullam ea	Ipsa et et omnis quod velit et non adipisci facere.	483.09	11	9	2025-08-03 17:53:09	2025-08-03 17:53:09
901	voluptatem fugiat ex	Facilis consequatur neque molestiae illum consequatur nam architecto maiores.	436.82	38	10	2025-08-03 17:53:12	2025-08-03 17:53:12
902	culpa eveniet nostrum	Totam saepe repellat ipsam dolorem eum qui neque quibusdam illum minima reiciendis eaque incidunt.	808.89	51	10	2025-08-03 17:53:12	2025-08-03 17:53:12
903	aliquid ex eos	Molestiae adipisci minima praesentium ut aut quia culpa aut assumenda ratione dicta sapiente.	919.86	57	10	2025-08-03 17:53:12	2025-08-03 17:53:12
904	et velit aut	Voluptatem deserunt similique reiciendis nesciunt nobis non est sunt ea cumque.	125.91	65	10	2025-08-03 17:53:12	2025-08-03 17:53:12
905	vel ut vitae	Possimus fugit ut assumenda quibusdam illo fuga neque.	518.65	75	10	2025-08-03 17:53:12	2025-08-03 17:53:12
906	similique quia esse	Aliquid eaque aspernatur ipsa maiores repellendus omnis nesciunt.	777.28	81	10	2025-08-03 17:53:12	2025-08-03 17:53:12
907	officiis voluptatem natus	Dolores error ut voluptas esse odit eligendi id nulla corporis consequatur dolores officia et.	117.54	90	10	2025-08-03 17:53:12	2025-08-03 17:53:12
908	quisquam magni dolor	Veritatis commodi eum dolores optio et facere aspernatur placeat iure.	889.61	40	10	2025-08-03 17:53:12	2025-08-03 17:53:12
909	nisi hic ea	Enim maxime id dolorem aperiam unde ut soluta qui quia.	34.43	54	10	2025-08-03 17:53:12	2025-08-03 17:53:12
910	modi ipsam doloribus	Nulla libero qui et sunt quam sit mollitia fugit at unde.	511.25	100	10	2025-08-03 17:53:12	2025-08-03 17:53:12
911	aut ab blanditiis	Qui ea magni aliquid eligendi architecto culpa omnis est eum reiciendis sint fugit rerum.	609.79	8	10	2025-08-03 17:53:12	2025-08-03 17:53:12
912	autem alias quaerat	Qui eveniet nam id possimus qui saepe.	851.64	3	10	2025-08-03 17:53:12	2025-08-03 17:53:12
913	dolor ut non	Porro molestiae consequatur in ipsam fugit quod harum ullam dolor et sed quisquam.	212.16	2	10	2025-08-03 17:53:12	2025-08-03 17:53:12
914	aperiam dolorum quas	Inventore doloribus necessitatibus praesentium officiis excepturi corporis.	180.31	78	10	2025-08-03 17:53:12	2025-08-03 17:53:12
915	numquam quibusdam eligendi	Odio et qui aut ratione dolorum deleniti.	299.11	39	10	2025-08-03 17:53:12	2025-08-03 17:53:12
916	quis voluptatem possimus	Qui fuga inventore rerum cum dignissimos sapiente cum fugit omnis eum a.	570.18	4	10	2025-08-03 17:53:12	2025-08-03 17:53:12
917	consequatur vitae incidunt	Sed autem enim soluta dolor et minima voluptatem id libero.	460.88	33	10	2025-08-03 17:53:12	2025-08-03 17:53:12
918	voluptatibus ex aut	Doloremque quidem vel minus repellendus ut vel et corrupti repellendus quos omnis impedit dolor.	674.86	63	10	2025-08-03 17:53:12	2025-08-03 17:53:12
919	aut et porro	Rem ut ea quibusdam iure accusantium necessitatibus quos fuga.	171.59	99	10	2025-08-03 17:53:12	2025-08-03 17:53:12
920	et saepe exercitationem	Ipsa ad in beatae consectetur velit ab.	420.52	71	10	2025-08-03 17:53:12	2025-08-03 17:53:12
921	consequatur ipsa animi	Iusto modi voluptas dolore perferendis quas facere quam perferendis atque.	425.68	25	10	2025-08-03 17:53:12	2025-08-03 17:53:12
922	commodi aut voluptas	Rem tenetur ipsa quaerat quia voluptatem ipsam ratione quia ut at et.	183.31	43	10	2025-08-03 17:53:12	2025-08-03 17:53:12
923	facere qui delectus	Est beatae voluptatum illo ad eum nobis quam.	806.28	10	10	2025-08-03 17:53:12	2025-08-03 17:53:12
924	libero rem vitae	Voluptatem similique quis libero excepturi perspiciatis non qui explicabo fugiat qui facilis enim.	78.81	21	10	2025-08-03 17:53:12	2025-08-03 17:53:12
925	provident repellat dolores	Rerum dolores iusto numquam nihil autem repudiandae ut quia dolore provident molestiae.	470.83	90	10	2025-08-03 17:53:12	2025-08-03 17:53:12
926	distinctio quis perspiciatis	Est sint sapiente sed animi aperiam architecto.	881.58	35	10	2025-08-03 17:53:12	2025-08-03 17:53:12
927	enim voluptates culpa	Eligendi similique assumenda voluptas magni enim quibusdam quia asperiores.	809.83	79	10	2025-08-03 17:53:12	2025-08-03 17:53:12
928	et et aliquid	Aut laudantium unde ipsam dolores blanditiis in dolor vel pariatur delectus.	522.97	54	10	2025-08-03 17:53:12	2025-08-03 17:53:12
929	enim error fugiat	Neque et sequi illum pariatur eum quia autem.	404.62	92	10	2025-08-03 17:53:12	2025-08-03 17:53:12
930	aperiam aut architecto	Ut voluptas voluptate doloribus eos alias fugiat quae atque eaque atque saepe quas.	740.90	88	10	2025-08-03 17:53:12	2025-08-03 17:53:12
931	rerum omnis quas	Molestias rem enim molestiae ut ut quo.	580.71	94	10	2025-08-03 17:53:12	2025-08-03 17:53:12
932	eligendi nisi est	Incidunt dolores voluptatibus voluptas maiores dicta facere eaque.	887.40	21	10	2025-08-03 17:53:12	2025-08-03 17:53:12
933	quo illo sit	Ab hic alias ea aperiam id iste cupiditate ipsam ea minima soluta.	736.59	44	10	2025-08-03 17:53:12	2025-08-03 17:53:12
934	asperiores itaque ea	Et ipsam debitis culpa rerum consequuntur illo libero provident eos nihil doloremque cupiditate.	873.18	63	10	2025-08-03 17:53:12	2025-08-03 17:53:12
935	est soluta tenetur	Magni iste corrupti repellendus est consectetur veniam est ipsa qui corrupti omnis nesciunt.	594.14	81	10	2025-08-03 17:53:12	2025-08-03 17:53:12
936	hic repellendus deleniti	Reiciendis quae corporis saepe illum qui rem magnam in.	329.54	0	10	2025-08-03 17:53:12	2025-08-03 17:53:12
937	illum occaecati suscipit	Et beatae sequi et culpa est exercitationem aspernatur rem repellendus voluptatem autem explicabo.	599.34	93	10	2025-08-03 17:53:12	2025-08-03 17:53:12
938	neque eveniet et	Dolorem enim ipsam omnis sed pariatur dignissimos.	711.51	93	10	2025-08-03 17:53:12	2025-08-03 17:53:12
939	laborum nostrum ut	Corrupti earum culpa quasi id quo rem ducimus ut facilis dolorem doloremque.	560.93	18	10	2025-08-03 17:53:12	2025-08-03 17:53:12
940	excepturi fugiat labore	Ipsam animi excepturi deserunt unde fugiat vero aut tenetur officia voluptatem debitis.	799.52	37	10	2025-08-03 17:53:12	2025-08-03 17:53:12
941	magnam et consequuntur	Velit qui consequuntur alias qui ut consectetur.	629.47	77	10	2025-08-03 17:53:12	2025-08-03 17:53:12
942	est dolores temporibus	Dolor perspiciatis nihil sit neque culpa ipsam eveniet est exercitationem.	85.97	92	10	2025-08-03 17:53:12	2025-08-03 17:53:12
943	quod consequatur dolorem	Quia facere sunt quas voluptatem delectus aspernatur eos nisi autem aut magni sequi porro.	753.87	42	10	2025-08-03 17:53:12	2025-08-03 17:53:12
944	quis nostrum veritatis	Explicabo fugiat debitis qui temporibus nobis libero voluptas distinctio rerum ea ut sit eos.	743.52	6	10	2025-08-03 17:53:12	2025-08-03 17:53:12
945	earum magni soluta	Dolorum mollitia cum rerum qui et reiciendis temporibus.	480.51	49	10	2025-08-03 17:53:12	2025-08-03 17:53:12
946	vel consequuntur placeat	Consectetur numquam dolorem inventore mollitia architecto consectetur consectetur fuga pariatur explicabo.	888.70	97	10	2025-08-03 17:53:12	2025-08-03 17:53:12
947	iure inventore nam	Nesciunt aut id autem repudiandae accusamus consequatur officia qui.	408.21	26	10	2025-08-03 17:53:12	2025-08-03 17:53:12
948	perspiciatis vitae nihil	Pariatur sit incidunt consequatur qui voluptatum dolorem placeat est provident a a quo.	281.39	29	10	2025-08-03 17:53:12	2025-08-03 17:53:12
949	vero molestias consequatur	Dolore alias ducimus praesentium est dignissimos doloremque porro.	774.48	19	10	2025-08-03 17:53:12	2025-08-03 17:53:12
950	alias veniam accusantium	Ullam beatae et animi sequi illo fugiat sapiente consequatur deleniti quam.	736.03	7	10	2025-08-03 17:53:12	2025-08-03 17:53:12
951	cupiditate magni vel	Quisquam ut sapiente et non quas accusantium.	58.79	79	10	2025-08-03 17:53:12	2025-08-03 17:53:12
952	sint occaecati voluptate	Debitis illum est numquam unde asperiores vel rerum accusantium.	321.22	98	10	2025-08-03 17:53:12	2025-08-03 17:53:12
953	est ab unde	Ex sunt saepe vel optio harum asperiores velit provident sapiente vel.	436.06	41	10	2025-08-03 17:53:12	2025-08-03 17:53:12
954	sunt dolore exercitationem	Rerum dolorum sed vitae nobis voluptas delectus.	42.21	3	10	2025-08-03 17:53:12	2025-08-03 17:53:12
955	illum sapiente tempore	Repudiandae et tempora ducimus aut et voluptas ut mollitia quia.	744.61	49	10	2025-08-03 17:53:12	2025-08-03 17:53:12
956	fugiat hic suscipit	Sit non et et est molestias praesentium minus provident sunt velit consectetur cupiditate.	29.39	78	10	2025-08-03 17:53:12	2025-08-03 17:53:12
957	harum quasi non	Similique necessitatibus quia sit assumenda iure adipisci autem non.	656.12	1	10	2025-08-03 17:53:12	2025-08-03 17:53:12
958	sit et facere	Iure neque non occaecati vel dolorum magnam sunt expedita hic ducimus nostrum expedita.	482.53	16	10	2025-08-03 17:53:12	2025-08-03 17:53:12
959	assumenda aut id	Esse officia beatae consequatur error occaecati vel.	829.88	100	10	2025-08-03 17:53:12	2025-08-03 17:53:12
960	vel iure dolor	Quaerat minima officiis maxime et et possimus suscipit ad dolor.	111.20	61	10	2025-08-03 17:53:12	2025-08-03 17:53:12
961	debitis a vero	Quia nulla eius quam sit aperiam voluptas dignissimos aut in esse eaque similique.	283.97	5	10	2025-08-03 17:53:12	2025-08-03 17:53:12
962	voluptas explicabo eos	Sint perspiciatis laudantium at neque explicabo molestiae consequatur et sed quod quas dolorem.	170.13	39	10	2025-08-03 17:53:12	2025-08-03 17:53:12
963	voluptatibus est qui	Perferendis et doloremque et repudiandae officia quis in rerum enim omnis eius dolore.	853.20	19	10	2025-08-03 17:53:12	2025-08-03 17:53:12
964	consequuntur velit voluptates	Sapiente error nobis ex maiores dolor blanditiis velit eum dolores doloribus.	486.04	51	10	2025-08-03 17:53:12	2025-08-03 17:53:12
965	dolores nobis vel	Exercitationem occaecati officia consequuntur excepturi minus omnis sapiente ab et.	245.31	3	10	2025-08-03 17:53:12	2025-08-03 17:53:12
966	suscipit veritatis aut	Eum minima natus id praesentium laboriosam maiores non architecto laudantium.	440.73	82	10	2025-08-03 17:53:12	2025-08-03 17:53:12
967	suscipit et aut	Repellendus et veniam at eos neque architecto voluptate alias quos quo velit vitae culpa.	42.76	45	10	2025-08-03 17:53:12	2025-08-03 17:53:12
968	et dolorem sed	Voluptates debitis cum voluptatibus nostrum nihil qui soluta aut quae laboriosam.	754.97	3	10	2025-08-03 17:53:12	2025-08-03 17:53:12
969	mollitia perspiciatis numquam	Iure omnis et et nulla quia in recusandae sed et reprehenderit adipisci et incidunt.	295.43	76	10	2025-08-03 17:53:12	2025-08-03 17:53:12
970	perferendis est consequatur	Ut dolorem similique perferendis aliquam sunt natus hic.	142.38	6	10	2025-08-03 17:53:12	2025-08-03 17:53:12
971	reiciendis numquam praesentium	Qui laboriosam quos placeat perspiciatis dolorem tempore pariatur consequuntur eaque.	235.29	16	10	2025-08-03 17:53:12	2025-08-03 17:53:12
972	voluptatem enim esse	Est architecto et officia cum eos minima enim eveniet qui.	150.41	97	10	2025-08-03 17:53:12	2025-08-03 17:53:12
973	quia et earum	Odio nihil aperiam sed excepturi nulla dolore perspiciatis mollitia non.	55.99	49	10	2025-08-03 17:53:12	2025-08-03 17:53:12
974	nisi maiores ipsam	Rerum sunt et debitis saepe autem repellat aut dicta esse sed consequatur ab.	909.66	20	10	2025-08-03 17:53:12	2025-08-03 17:53:12
975	voluptatem eaque veniam	Occaecati inventore quis et et at natus porro quia aut similique aliquid.	720.17	22	10	2025-08-03 17:53:12	2025-08-03 17:53:12
976	omnis rem ex	Nisi voluptatem quaerat sed magni provident deleniti illo ut at.	886.93	78	10	2025-08-03 17:53:12	2025-08-03 17:53:12
977	voluptatibus ratione nihil	Harum voluptatem facere pariatur non nisi quisquam asperiores quam.	172.33	8	10	2025-08-03 17:53:12	2025-08-03 17:53:12
978	voluptatem mollitia et	Dolor dignissimos magni ut fugiat voluptate repellat quaerat ipsum dolorem.	832.35	71	10	2025-08-03 17:53:12	2025-08-03 17:53:12
979	adipisci quo ad	Numquam vero itaque et facilis ea cum velit iusto itaque.	151.45	96	10	2025-08-03 17:53:12	2025-08-03 17:53:12
980	eum facere qui	Iste id aut consequatur qui iure labore soluta.	865.17	68	10	2025-08-03 17:53:12	2025-08-03 17:53:12
981	culpa consequatur rerum	Provident illum itaque animi minus quasi repellat consectetur voluptatibus quis magni qui rem repellendus.	633.33	70	10	2025-08-03 17:53:12	2025-08-03 17:53:12
982	non similique tempora	Consequatur quia distinctio sit quod repudiandae provident vero libero nisi et et ut.	879.33	85	10	2025-08-03 17:53:12	2025-08-03 17:53:12
983	nemo exercitationem ut	Hic necessitatibus dolor nobis magni quo molestiae deserunt illo quibusdam est.	291.47	92	10	2025-08-03 17:53:12	2025-08-03 17:53:12
984	occaecati quas repellat	Quod facere eum aut inventore non eligendi rerum quia.	317.72	94	10	2025-08-03 17:53:12	2025-08-03 17:53:12
985	voluptatem eum occaecati	Consectetur totam laboriosam consequatur quam quidem voluptates excepturi voluptate ut quod.	222.58	41	10	2025-08-03 17:53:12	2025-08-03 17:53:12
986	numquam occaecati in	Laudantium ut molestiae quaerat non omnis voluptatum veniam et.	524.85	75	10	2025-08-03 17:53:12	2025-08-03 17:53:12
987	architecto rerum voluptatem	Perspiciatis aut asperiores harum doloribus magni voluptas qui est nihil reiciendis aspernatur est.	189.20	84	10	2025-08-03 17:53:12	2025-08-03 17:53:12
988	excepturi maxime itaque	Quod qui aut dolorem sit nihil quam sint.	452.08	0	10	2025-08-03 17:53:12	2025-08-03 17:53:12
989	doloribus quidem sit	Aperiam reiciendis voluptas quia quaerat consectetur modi unde.	22.16	63	10	2025-08-03 17:53:12	2025-08-03 17:53:12
990	sit consequatur laudantium	Perspiciatis nam aut voluptatibus cumque quae rerum est ducimus rem quidem autem quod.	129.72	70	10	2025-08-03 17:53:12	2025-08-03 17:53:12
991	ea expedita veritatis	Quis et sed iure ducimus sit ab dolores.	912.79	96	10	2025-08-03 17:53:12	2025-08-03 17:53:12
992	qui dicta porro	Et earum a doloribus vel ut eos.	559.63	48	10	2025-08-03 17:53:12	2025-08-03 17:53:12
993	non commodi maxime	Et ad iusto consequatur itaque ut perferendis.	20.39	49	10	2025-08-03 17:53:12	2025-08-03 17:53:12
994	consectetur et deserunt	Provident modi voluptas est aut soluta impedit earum qui ab nihil velit ea.	818.52	3	10	2025-08-03 17:53:12	2025-08-03 17:53:12
995	quas animi consectetur	Facere tenetur ut animi quia eveniet possimus necessitatibus voluptatem nobis ipsa nemo sed sequi.	945.28	33	10	2025-08-03 17:53:12	2025-08-03 17:53:12
996	rem temporibus in	Qui rem voluptas veritatis velit ad maiores.	628.41	12	10	2025-08-03 17:53:12	2025-08-03 17:53:12
997	voluptatibus vel ipsa	Dolores ut quis eaque dicta ut earum.	659.34	87	10	2025-08-03 17:53:12	2025-08-03 17:53:12
998	et perferendis at	Aut quo vero quisquam quasi laudantium ex a consectetur ut sit.	861.00	7	10	2025-08-03 17:53:12	2025-08-03 17:53:12
999	consequatur quisquam laudantium	Harum et hic aliquam cupiditate ipsam cupiditate blanditiis sit corrupti harum veniam porro dolor.	516.20	12	10	2025-08-03 17:53:12	2025-08-03 17:53:12
1000	ut vel ut	Cumque quaerat explicabo voluptatem ab qui ex maiores.	204.03	31	10	2025-08-03 17:53:12	2025-08-03 17:53:12
\.


--
-- Data for Name: role_has_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_has_permissions (permission_id, role_id) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, guard_name, created_at, updated_at) FROM stdin;
1	admin	web	2025-08-03 17:51:27	2025-08-03 17:51:27
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
\.


--
-- Data for Name: telescope_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telescope_entries (sequence, uuid, batch_id, family_hash, should_display_on_index, type, content, created_at) FROM stdin;
1	9f8c29fd-2201-41d9-b4f8-14a0cb4b7b52	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select exists (select 1 from pg_class c, pg_namespace n where n.nspname = current_schema() and c.relname = 'migrations' and c.relkind in ('r', 'p') and n.oid = c.relnamespace)","time":"1.19","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"b6ddde8046c04ec7fb2b4992047c0410","hostname":"d782c42f75da"}	2025-08-03 17:51:26
2	9f8c29fd-2533-476c-a262-f49093fd58cd	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select \\"migration\\" from \\"migrations\\" order by \\"batch\\" asc, \\"migration\\" asc","time":"1.04","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"84af29f5c40ba2eeda76663cdfcee4df","hostname":"d782c42f75da"}	2025-08-03 17:51:26
3	9f8c29fd-34b4-4d33-bc11-75c9e9d6ab7f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"order_items\\"","time":"4.03","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195939_create_order_items_table.php","line":31,"hash":"5581e82c5b1354e5077381019c310319","hostname":"d782c42f75da"}	2025-08-03 17:51:26
4	9f8c29fd-38cc-4b05-b69f-ff7fa0531600	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_195939_create_order_items_table'","time":"0.81","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:26
5	9f8c29fd-3945-4792-b520-b847fe8ef963	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"orders\\"","time":"0.55","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195930_create_orders_table.php","line":28,"hash":"96c72344995aee7d936094b4aeca23cc","hostname":"d782c42f75da"}	2025-08-03 17:51:26
6	9f8c29fd-3bd1-4115-bc95-1b687821ef4e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_195930_create_orders_table'","time":"0.84","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:26
7	9f8c29fd-3c59-4061-a9b1-83068a33001d	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"cart_items\\"","time":"0.75","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192714_create_cart_items_table.php","line":31,"hash":"399eba833ea5175342c6233dae998259","hostname":"d782c42f75da"}	2025-08-03 17:51:26
8	9f8c29fd-3e76-467e-8320-80da7744ab96	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_192714_create_cart_items_table'","time":"0.34","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
9	9f8c29fd-3eca-4ae2-94d1-fa5cc7519ba0	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"carts\\"","time":"0.37","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192621_create_carts_table.php","line":26,"hash":"7a95fe4564b045a53c00c04834994fe1","hostname":"d782c42f75da"}	2025-08-03 17:51:27
10	9f8c29fd-40ff-4fc5-96d8-523f014bfedb	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_192621_create_carts_table'","time":"0.29","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
11	9f8c29fd-416f-4b22-bdbb-d137bd76362b	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"products\\"","time":"0.61","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_183942_create_products_table.php","line":30,"hash":"425aba63e50c7784b4995e5285f36fad","hostname":"d782c42f75da"}	2025-08-03 17:51:27
12	9f8c29fd-43d9-4884-99df-c173a36200b6	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_183942_create_products_table'","time":"0.47","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
13	9f8c29fd-443e-425a-888b-5c9637dbb0bf	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"categories\\"","time":"0.42","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_154417_create_categories_table.php","line":27,"hash":"fc1bb245f62c94aabe95caada7c01eb7","hostname":"d782c42f75da"}	2025-08-03 17:51:27
14	9f8c29fd-4643-4aea-8acb-0e2ebeb4ffde	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_154417_create_categories_table'","time":"0.44","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
15	9f8c29fd-469f-4ee4-af3f-b5302853c12a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"telescope_entries_tags\\"","time":"0.40","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":66,"hash":"3343ab7521447d3450a05bb40556baf0","hostname":"d782c42f75da"}	2025-08-03 17:51:27
16	9f8c29fd-46e1-413b-9a46-2bf842d09f93	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"telescope_entries\\"","time":"0.55","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":67,"hash":"878f3881758e611c9c4b0e6982b2120a","hostname":"d782c42f75da"}	2025-08-03 17:51:27
17	9f8c29fd-46fb-4dc1-b0b0-3747caa4df14	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"telescope_monitoring\\"","time":"0.17","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":68,"hash":"9111a4d2c15ce2786962ce6100b457ce","hostname":"d782c42f75da"}	2025-08-03 17:51:27
18	9f8c29fd-48a0-460c-8af9-a16914652354	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_115221_create_telescope_entries_table'","time":"0.40","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
19	9f8c29fd-4918-40c9-b05b-1fb35271bb9d	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table \\"role_has_permissions\\"","time":"0.43","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":130,"hash":"f381dc0cf085c7748f6e792678d65803","hostname":"d782c42f75da"}	2025-08-03 17:51:27
20	9f8c29fd-4940-4367-b164-3d1f929e17eb	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table \\"model_has_roles\\"","time":"0.29","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":131,"hash":"66bfb567b06ec9d6335bf3767a6ea1a9","hostname":"d782c42f75da"}	2025-08-03 17:51:27
21	9f8c29fd-4967-4da9-8fec-4206783a0deb	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table \\"model_has_permissions\\"","time":"0.29","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":132,"hash":"eea2d478de97888dd451fed9c784918e","hostname":"d782c42f75da"}	2025-08-03 17:51:27
22	9f8c29fd-4991-4677-a15f-178d9e45e2d2	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table \\"roles\\"","time":"0.33","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":133,"hash":"75c284e15107ebf1beb5a41a552780ab","hostname":"d782c42f75da"}	2025-08-03 17:51:27
23	9f8c29fd-49be-4680-8a5f-dac83a88f771	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table \\"permissions\\"","time":"0.34","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":134,"hash":"c12d26a7e70acb87d3c87b72cefd123c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
24	9f8c29fd-4bd2-4531-b1ff-aca84499edc2	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_114838_create_permission_tables'","time":"0.33","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
25	9f8c29fd-4c24-41d9-aa38-f679b9667b96	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"personal_access_tokens\\"","time":"0.36","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114241_create_personal_access_tokens_table.php","line":31,"hash":"bb727ec5a667b28b20fb0e8dcade427c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
26	9f8c29fd-4d51-418c-861b-eb862c55c24c	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '2025_08_02_114241_create_personal_access_tokens_table'","time":"0.34","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
27	9f8c29fd-4da8-40f1-ba87-91c1d43fbcf7	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"jobs\\"","time":"0.43","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":53,"hash":"35102f192cd7d073950cae202bc12602","hostname":"d782c42f75da"}	2025-08-03 17:51:27
28	9f8c29fd-4dc9-496c-96ce-e51a0cac2da3	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"job_batches\\"","time":"0.23","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":54,"hash":"081de242f47097b74d4f600196da62bf","hostname":"d782c42f75da"}	2025-08-03 17:51:27
29	9f8c29fd-4def-4be6-adc7-8f72a09ef82f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"failed_jobs\\"","time":"0.29","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":55,"hash":"63e960268bb2d38eb6b0f3680f454e7d","hostname":"d782c42f75da"}	2025-08-03 17:51:27
30	9f8c29fd-50b9-490f-b23b-5d3114f56727	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '0001_01_01_000002_create_jobs_table'","time":"0.44","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
31	9f8c29fd-5114-46f4-9153-18627afe0ce3	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"cache\\"","time":"0.31","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000001_create_cache_table.php","line":32,"hash":"99b3a558a3a4c312bbf87f73e1fca9eb","hostname":"d782c42f75da"}	2025-08-03 17:51:27
32	9f8c29fd-5134-4f38-9513-46176c2ffdb7	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"cache_locks\\"","time":"0.20","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000001_create_cache_table.php","line":33,"hash":"aa429031740fdab400d12ecab47b4ee9","hostname":"d782c42f75da"}	2025-08-03 17:51:27
33	9f8c29fd-5388-49f2-a312-a25b4f819763	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '0001_01_01_000001_create_cache_table'","time":"0.36","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
34	9f8c29fd-53e3-48da-a087-87e72dccd405	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"users\\"","time":"0.46","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":45,"hash":"c3b7c0bec69d3a6c32bcfc5ca2a89624","hostname":"d782c42f75da"}	2025-08-03 17:51:27
35	9f8c29fd-5406-43cf-9288-54307f37a30b	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"password_reset_tokens\\"","time":"0.24","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":46,"hash":"ce6e5413534beb01682b1de884e9c37b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
36	9f8c29fd-5426-44ff-a94b-e37277c849ba	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"drop table if exists \\"sessions\\"","time":"0.23","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":47,"hash":"9b36e288dc44b4d0983be51c0a08239b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
37	9f8c29fd-56a9-4e3f-98e7-00b38817bfaf	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"migrations\\" where \\"migration\\" = '0001_01_01_000000_create_users_table'","time":"0.38","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"8960385cf7ddcd29cd513bf889d53827","hostname":"d782c42f75da"}	2025-08-03 17:51:27
38	9f8c29fd-575f-466e-9ed4-aeb9d95c9acb	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select exists (select 1 from pg_class c, pg_namespace n where n.nspname = current_schema() and c.relname = 'migrations' and c.relkind in ('r', 'p') and n.oid = c.relnamespace)","time":"0.33","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"b6ddde8046c04ec7fb2b4992047c0410","hostname":"d782c42f75da"}	2025-08-03 17:51:27
39	9f8c29fd-5783-4796-9687-f407cfdbebed	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select exists (select 1 from pg_class c, pg_namespace n where n.nspname = current_schema() and c.relname = 'migrations' and c.relkind in ('r', 'p') and n.oid = c.relnamespace)","time":"0.23","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"b6ddde8046c04ec7fb2b4992047c0410","hostname":"d782c42f75da"}	2025-08-03 17:51:27
40	9f8c29fd-57a0-4afd-8508-85dd03595776	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select \\"migration\\" from \\"migrations\\" order by \\"batch\\" asc, \\"migration\\" asc","time":"0.13","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"84af29f5c40ba2eeda76663cdfcee4df","hostname":"d782c42f75da"}	2025-08-03 17:51:27
41	9f8c29fd-57dd-48ab-ba16-42017feafd16	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select \\"migration\\" from \\"migrations\\" order by \\"batch\\" asc, \\"migration\\" asc","time":"0.12","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"84af29f5c40ba2eeda76663cdfcee4df","hostname":"d782c42f75da"}	2025-08-03 17:51:27
42	9f8c29fd-5814-4e7a-b224-c8b17197a4a6	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select max(\\"batch\\") as aggregate from \\"migrations\\"","time":"0.24","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"891c93593b7807a7dfc0848070936947","hostname":"d782c42f75da"}	2025-08-03 17:51:27
43	9f8c29fd-5b7c-4595-95bd-cee276b06f8f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"users\\" (\\"id\\" bigserial not null primary key, \\"name\\" varchar(255) not null, \\"email\\" varchar(255) not null, \\"email_verified_at\\" timestamp(0) without time zone null, \\"password\\" varchar(255) not null, \\"remember_token\\" varchar(100) null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"6.82","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":14,"hash":"a9967097db44dc37f283d0b38f8c9313","hostname":"d782c42f75da"}	2025-08-03 17:51:27
44	9f8c29fd-5beb-4713-9bb4-ed8598d88de5	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"users\\" add constraint \\"users_email_unique\\" unique (\\"email\\")","time":"1.02","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":14,"hash":"a7941bc5211747d9f6bba27e7cd40aa3","hostname":"d782c42f75da"}	2025-08-03 17:51:27
45	9f8c29fd-5c9f-4ad2-96d4-72c88a50d922	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"password_reset_tokens\\" (\\"email\\" varchar(255) not null, \\"token\\" varchar(255) not null, \\"created_at\\" timestamp(0) without time zone null)","time":"1.61","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":24,"hash":"e8e5c5ce0dbec55ccd257c47e89ecaec","hostname":"d782c42f75da"}	2025-08-03 17:51:27
46	9f8c29fd-5ceb-4b58-8340-9f9f816be371	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"password_reset_tokens\\" add primary key (\\"email\\")","time":"0.66","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":24,"hash":"5b90b60c4becc7731fc855c5fa63972a","hostname":"d782c42f75da"}	2025-08-03 17:51:27
47	9f8c29fd-5d93-4759-88b7-9ca91cacfc6e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"sessions\\" (\\"id\\" varchar(255) not null, \\"user_id\\" bigint null, \\"ip_address\\" varchar(45) null, \\"user_agent\\" text null, \\"payload\\" text not null, \\"last_activity\\" integer not null)","time":"0.96","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":30,"hash":"8308816771d6a380fb3a4b72e22f4dac","hostname":"d782c42f75da"}	2025-08-03 17:51:27
48	9f8c29fd-5dee-497a-aef2-a53d4448e849	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"sessions\\" add primary key (\\"id\\")","time":"0.80","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":30,"hash":"632707dbc81193dc6466cf3ab7a3062b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
49	9f8c29fd-5e43-4be3-bd80-8c4349767a25	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"sessions_user_id_index\\" on \\"sessions\\" (\\"user_id\\")","time":"0.77","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":30,"hash":"2542eec4d80cc182d87c3cf7cab44922","hostname":"d782c42f75da"}	2025-08-03 17:51:27
50	9f8c29fd-5e9c-40bc-b2bf-dcaada970431	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"sessions_last_activity_index\\" on \\"sessions\\" (\\"last_activity\\")","time":"0.82","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000000_create_users_table.php","line":30,"hash":"d92496b4297ffd699cf298b9aeae6950","hostname":"d782c42f75da"}	2025-08-03 17:51:27
51	9f8c29fd-60e9-445b-bc88-9a547624ec5a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('0001_01_01_000000_create_users_table', 1)","time":"0.77","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
52	9f8c29fd-616b-4bb9-89fb-620c125436dc	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"cache\\" (\\"key\\" varchar(255) not null, \\"value\\" text not null, \\"expiration\\" integer not null)","time":"0.90","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000001_create_cache_table.php","line":14,"hash":"7f67485c05da39282f5a9cfc42f22833","hostname":"d782c42f75da"}	2025-08-03 17:51:27
53	9f8c29fd-61b6-4a3c-b74b-18eddf7026af	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"cache\\" add primary key (\\"key\\")","time":"0.65","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000001_create_cache_table.php","line":14,"hash":"787fdee5d41b50e0ddaee677c8df71ca","hostname":"d782c42f75da"}	2025-08-03 17:51:27
54	9f8c29fd-6238-4bc3-9777-be982098ea83	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"cache_locks\\" (\\"key\\" varchar(255) not null, \\"owner\\" varchar(255) not null, \\"expiration\\" integer not null)","time":"1.11","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000001_create_cache_table.php","line":20,"hash":"63ace63c4220a580aa733330af30f704","hostname":"d782c42f75da"}	2025-08-03 17:51:27
55	9f8c29fd-6304-40be-b308-a3d8ff73938e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"cache_locks\\" add primary key (\\"key\\")","time":"1.93","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000001_create_cache_table.php","line":20,"hash":"e725542fe13520a67e943bdf87887548","hostname":"d782c42f75da"}	2025-08-03 17:51:27
56	9f8c29fd-654f-4c68-8aa1-cc0a56575fe9	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('0001_01_01_000001_create_cache_table', 1)","time":"0.34","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
57	9f8c29fd-6621-430c-8b6a-a28d9c919983	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"jobs\\" (\\"id\\" bigserial not null primary key, \\"queue\\" varchar(255) not null, \\"payload\\" text not null, \\"attempts\\" smallint not null, \\"reserved_at\\" integer null, \\"available_at\\" integer not null, \\"created_at\\" integer not null)","time":"1.60","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":14,"hash":"b7729da8aa116863fe7f3af77c646f6b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
58	9f8c29fd-666a-4515-adb8-e67bf080baa3	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"jobs_queue_index\\" on \\"jobs\\" (\\"queue\\")","time":"0.63","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":14,"hash":"7b59ef50d4ab2d8cfe94adaf49d887a6","hostname":"d782c42f75da"}	2025-08-03 17:51:27
59	9f8c29fd-66e2-4757-8b96-b915f7bfa484	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"job_batches\\" (\\"id\\" varchar(255) not null, \\"name\\" varchar(255) not null, \\"total_jobs\\" integer not null, \\"pending_jobs\\" integer not null, \\"failed_jobs\\" integer not null, \\"failed_job_ids\\" text not null, \\"options\\" text null, \\"cancelled_at\\" integer null, \\"created_at\\" integer not null, \\"finished_at\\" integer null)","time":"0.90","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":24,"hash":"66e646f400ac2669f2ff0b0d511530a3","hostname":"d782c42f75da"}	2025-08-03 17:51:27
60	9f8c29fd-673c-4c96-a5ff-4312e9140195	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"job_batches\\" add primary key (\\"id\\")","time":"0.81","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":24,"hash":"ac41bc33ab9059ed28a4db56836e8c2a","hostname":"d782c42f75da"}	2025-08-03 17:51:27
61	9f8c29fd-684a-4202-bab7-a8bb2d240bf9	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"failed_jobs\\" (\\"id\\" bigserial not null primary key, \\"uuid\\" varchar(255) not null, \\"connection\\" text not null, \\"queue\\" text not null, \\"payload\\" text not null, \\"exception\\" text not null, \\"failed_at\\" timestamp(0) without time zone not null default CURRENT_TIMESTAMP)","time":"1.81","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":37,"hash":"8f6b859463c56bf902459b69488562c2","hostname":"d782c42f75da"}	2025-08-03 17:51:27
62	9f8c29fd-6894-4316-b3d0-9645a8f28143	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"failed_jobs\\" add constraint \\"failed_jobs_uuid_unique\\" unique (\\"uuid\\")","time":"0.66","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/0001_01_01_000002_create_jobs_table.php","line":37,"hash":"55995ef416af2079ea79dbfbd676c79f","hostname":"d782c42f75da"}	2025-08-03 17:51:27
63	9f8c29fd-6b49-4d76-bacc-b84a93380729	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('0001_01_01_000002_create_jobs_table', 1)","time":"0.48","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
64	9f8c29fd-6c8a-4de0-96aa-8017b6c57f3c	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"personal_access_tokens\\" (\\"id\\" bigserial not null primary key, \\"tokenable_type\\" varchar(255) not null, \\"tokenable_id\\" bigint not null, \\"name\\" text not null, \\"token\\" varchar(64) not null, \\"abilities\\" text null, \\"last_used_at\\" timestamp(0) without time zone null, \\"expires_at\\" timestamp(0) without time zone null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"2.55","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114241_create_personal_access_tokens_table.php","line":14,"hash":"ae54d2988a9553fcb7f59fedeffc291d","hostname":"d782c42f75da"}	2025-08-03 17:51:27
65	9f8c29fd-6cfb-440f-8ca2-7f25f50e314a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"personal_access_tokens_tokenable_type_tokenable_id_index\\" on \\"personal_access_tokens\\" (\\"tokenable_type\\", \\"tokenable_id\\")","time":"0.99","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114241_create_personal_access_tokens_table.php","line":14,"hash":"f58d8e450b917eab13e6bec95345ae07","hostname":"d782c42f75da"}	2025-08-03 17:51:27
66	9f8c29fd-6d61-423f-a260-be92adcee779	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"personal_access_tokens\\" add constraint \\"personal_access_tokens_token_unique\\" unique (\\"token\\")","time":"0.89","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114241_create_personal_access_tokens_table.php","line":14,"hash":"099e0991d0cc0d053795f9387a3a0a9f","hostname":"d782c42f75da"}	2025-08-03 17:51:27
67	9f8c29fd-6dd5-4591-b90e-fbd2dff156ca	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"personal_access_tokens_expires_at_index\\" on \\"personal_access_tokens\\" (\\"expires_at\\")","time":"1.06","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114241_create_personal_access_tokens_table.php","line":14,"hash":"4f13bccd14122c955e13c68c05d9484f","hostname":"d782c42f75da"}	2025-08-03 17:51:27
68	9f8c29fd-6f9a-4cd8-b011-83478c153d8c	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_114241_create_personal_access_tokens_table', 1)","time":"0.91","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
69	9f8c29fd-7260-4747-9581-e5bee9f8ca2e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"permissions\\" (\\"id\\" bigserial not null primary key, \\"name\\" varchar(255) not null, \\"guard_name\\" varchar(255) not null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"3.90","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":23,"hash":"2cdf843583ab952e0a7d68de7c7298e0","hostname":"d782c42f75da"}	2025-08-03 17:51:27
70	9f8c29fd-72cc-4d19-aad5-47f257011877	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"permissions\\" add constraint \\"permissions_name_guard_name_unique\\" unique (\\"name\\", \\"guard_name\\")","time":"0.88","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":23,"hash":"a987e545e2607004b8a704fc7f4d2ce5","hostname":"d782c42f75da"}	2025-08-03 17:51:27
71	9f8c29fd-739a-4798-8351-ab598aab6ce7	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"roles\\" (\\"id\\" bigserial not null primary key, \\"name\\" varchar(255) not null, \\"guard_name\\" varchar(255) not null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"1.73","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":33,"hash":"f772858f6604cd017e44dbefe4981f81","hostname":"d782c42f75da"}	2025-08-03 17:51:27
72	9f8c29fd-73f2-4a16-a733-55722f2dfa1f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"roles\\" add constraint \\"roles_name_guard_name_unique\\" unique (\\"name\\", \\"guard_name\\")","time":"0.76","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":33,"hash":"53e89a19f517be63d76d16a1fefb4684","hostname":"d782c42f75da"}	2025-08-03 17:51:27
73	9f8c29fd-7451-44d8-a338-a395554279cf	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"model_has_permissions\\" (\\"permission_id\\" bigint not null, \\"model_type\\" varchar(255) not null, \\"model_id\\" bigint not null)","time":"0.19","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":50,"hash":"b0f778c892277b3a260f20c127629972","hostname":"d782c42f75da"}	2025-08-03 17:51:27
74	9f8c29fd-74d5-499d-8d6e-a2ac7a6e491b	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"model_has_permissions_model_id_model_type_index\\" on \\"model_has_permissions\\" (\\"model_id\\", \\"model_type\\")","time":"1.23","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":50,"hash":"cf5f9f80c7ac71fb7239087d4cb21ed4","hostname":"d782c42f75da"}	2025-08-03 17:51:27
75	9f8c29fd-7532-4464-9137-22dae1db9ab4	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"model_has_permissions\\" add constraint \\"model_has_permissions_permission_id_foreign\\" foreign key (\\"permission_id\\") references \\"permissions\\" (\\"id\\") on delete cascade","time":"0.85","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":50,"hash":"81167ccf984060b32b9aa7d946d132e5","hostname":"d782c42f75da"}	2025-08-03 17:51:27
76	9f8c29fd-759d-4e4b-bdb2-716e4747c568	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"model_has_permissions\\" add primary key (\\"permission_id\\", \\"model_id\\", \\"model_type\\")","time":"1.00","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":50,"hash":"2754ebfb176137c2900d76331eda4ccd","hostname":"d782c42f75da"}	2025-08-03 17:51:27
77	9f8c29fd-75c5-4056-ae34-3eb52dfd5393	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"model_has_roles\\" (\\"role_id\\" bigint not null, \\"model_type\\" varchar(255) not null, \\"model_id\\" bigint not null)","time":"0.20","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":74,"hash":"59d34b769a58df7f3d62b3a3b36b247a","hostname":"d782c42f75da"}	2025-08-03 17:51:27
78	9f8c29fd-760c-4d0f-a2f5-865bfe9910b1	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"model_has_roles_model_id_model_type_index\\" on \\"model_has_roles\\" (\\"model_id\\", \\"model_type\\")","time":"0.65","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":74,"hash":"c51e6263718f9f58d5efff1dd3493c36","hostname":"d782c42f75da"}	2025-08-03 17:51:27
79	9f8c29fd-764e-4c21-afbd-8c72a98b7b9e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"model_has_roles\\" add constraint \\"model_has_roles_role_id_foreign\\" foreign key (\\"role_id\\") references \\"roles\\" (\\"id\\") on delete cascade","time":"0.47","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":74,"hash":"e0a5afa6f2e4988f7157fd2ece5c6779","hostname":"d782c42f75da"}	2025-08-03 17:51:27
80	9f8c29fd-76cc-40a1-aa7a-5345678df723	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"model_has_roles\\" add primary key (\\"role_id\\", \\"model_id\\", \\"model_type\\")","time":"1.02","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":74,"hash":"729e6f50efb6613a780d36563b889757","hostname":"d782c42f75da"}	2025-08-03 17:51:27
81	9f8c29fd-76fa-4fe9-afda-219f150548ab	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"role_has_permissions\\" (\\"permission_id\\" bigint not null, \\"role_id\\" bigint not null)","time":"0.23","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":97,"hash":"c33c44a8e870bc541d6160fa8f5727fd","hostname":"d782c42f75da"}	2025-08-03 17:51:27
82	9f8c29fd-771e-4d75-b0e5-388426560904	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"role_has_permissions\\" add constraint \\"role_has_permissions_permission_id_foreign\\" foreign key (\\"permission_id\\") references \\"permissions\\" (\\"id\\") on delete cascade","time":"0.27","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":97,"hash":"7c6a379505dc3f3b826bb68feb3194de","hostname":"d782c42f75da"}	2025-08-03 17:51:27
83	9f8c29fd-773a-4bda-a77b-b65adabde30e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"role_has_permissions\\" add constraint \\"role_has_permissions_role_id_foreign\\" foreign key (\\"role_id\\") references \\"roles\\" (\\"id\\") on delete cascade","time":"0.20","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":97,"hash":"b0cda7a338fbd06fc41220dc01da7ed4","hostname":"d782c42f75da"}	2025-08-03 17:51:27
84	9f8c29fd-7788-49ca-a8df-e52797fe3fa3	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"role_has_permissions\\" add primary key (\\"permission_id\\", \\"role_id\\")","time":"0.66","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":97,"hash":"2e9610279e3c81b806abffa421f762f7","hostname":"d782c42f75da"}	2025-08-03 17:51:27
85	9f8c29fd-77f3-44aa-a7a6-2c385a46065a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"cache\\" where \\"key\\" in ('laravel-cache-spatie.permission.cache', 'laravel-cache-illuminate:cache:flexible:created:spatie.permission.cache')","time":"0.30","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_114838_create_permission_tables.php","line":116,"hash":"fbacc8221a9f2412f41db4a6ec324f6b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
86	9f8c29fd-783b-49c4-aa67-941dcd22225f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	cache	{"type":"forget","key":"spatie.permission.cache","hostname":"d782c42f75da"}	2025-08-03 17:51:27
87	9f8c29fd-7a11-4e8b-a753-ed1293b2c470	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_114838_create_permission_tables', 1)","time":"0.39","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
88	9f8c29fd-7b2c-4dde-ba65-131c5de1236e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"telescope_entries\\" (\\"sequence\\" bigserial not null primary key, \\"uuid\\" uuid not null, \\"batch_id\\" uuid not null, \\"family_hash\\" varchar(255) null, \\"should_display_on_index\\" boolean not null default '1', \\"type\\" varchar(20) not null, \\"content\\" text not null, \\"created_at\\" timestamp(0) without time zone null)","time":"2.24","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":24,"hash":"b406db2c2f873cdd4e80585f223cfdf9","hostname":"d782c42f75da"}	2025-08-03 17:51:27
89	9f8c29fd-7b83-4acf-bc93-aa10f7c3a601	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"telescope_entries\\" add constraint \\"telescope_entries_uuid_unique\\" unique (\\"uuid\\")","time":"0.75","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":24,"hash":"65516b962cdccf5d313657a083ce8e23","hostname":"d782c42f75da"}	2025-08-03 17:51:27
90	9f8c29fd-7bcb-40f4-9ad5-9065034b4832	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_batch_id_index\\" on \\"telescope_entries\\" (\\"batch_id\\")","time":"0.62","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":24,"hash":"e10b43e84e03625fedc71f28fb117fcd","hostname":"d782c42f75da"}	2025-08-03 17:51:27
91	9f8c29fd-7c0e-4096-ba6c-088b78674832	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_family_hash_index\\" on \\"telescope_entries\\" (\\"family_hash\\")","time":"0.59","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":24,"hash":"83054e6de7da4fc398165e89e56e6579","hostname":"d782c42f75da"}	2025-08-03 17:51:27
92	9f8c29fd-7c57-4823-be21-8572e8d6308a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_created_at_index\\" on \\"telescope_entries\\" (\\"created_at\\")","time":"0.64","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":24,"hash":"480c085033a759f5759c64439988b7ad","hostname":"d782c42f75da"}	2025-08-03 17:51:27
93	9f8c29fd-7cbc-48ff-b703-1e5904a4354f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_type_should_display_on_index_index\\" on \\"telescope_entries\\" (\\"type\\", \\"should_display_on_index\\")","time":"0.90","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":24,"hash":"2dde9b32f7ec3cbde8e7233229f9e72a","hostname":"d782c42f75da"}	2025-08-03 17:51:27
94	9f8c29fd-7ce6-4711-bd22-835baad90048	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"telescope_entries_tags\\" (\\"entry_uuid\\" uuid not null, \\"tag\\" varchar(255) not null)","time":"0.20","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":41,"hash":"84423770c386428de619551ca156a52b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
95	9f8c29fd-7d51-4a89-a5f6-3f879e567e20	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"telescope_entries_tags\\" add primary key (\\"entry_uuid\\", \\"tag\\")","time":"0.97","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":41,"hash":"d121bf7f5eac3400def591e1ebce7439","hostname":"d782c42f75da"}	2025-08-03 17:51:27
96	9f8c29fd-7db5-46a3-9b7b-8fcd13b0b657	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create index \\"telescope_entries_tags_tag_index\\" on \\"telescope_entries_tags\\" (\\"tag\\")","time":"0.89","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":41,"hash":"fb3cf587edc205c8c419d474ea351a78","hostname":"d782c42f75da"}	2025-08-03 17:51:27
97	9f8c29fd-7e12-478b-ba43-3a98e37f5727	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"telescope_entries_tags\\" add constraint \\"telescope_entries_tags_entry_uuid_foreign\\" foreign key (\\"entry_uuid\\") references \\"telescope_entries\\" (\\"uuid\\") on delete cascade","time":"0.82","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":41,"hash":"84715bebe24deb92d4af7a4800fc4a2b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
98	9f8c29fd-7e39-4e3d-a769-75b2736de056	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"telescope_monitoring\\" (\\"tag\\" varchar(255) not null)","time":"0.21","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":54,"hash":"ae42f8fdcbfbd265b65572f79934d1ae","hostname":"d782c42f75da"}	2025-08-03 17:51:27
99	9f8c29fd-7e92-4cf8-8aa1-42ee379ce05e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"telescope_monitoring\\" add primary key (\\"tag\\")","time":"0.79","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_115221_create_telescope_entries_table.php","line":54,"hash":"27b4fa17d400b8ca9300968e559f8b58","hostname":"d782c42f75da"}	2025-08-03 17:51:27
100	9f8c29fd-8005-4199-8e18-d91a1394b55a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_115221_create_telescope_entries_table', 1)","time":"0.37","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
101	9f8c29fd-80cf-489b-8dd6-426a73d40df0	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"categories\\" (\\"id\\" bigserial not null primary key, \\"name\\" varchar(255) not null, \\"description\\" text null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"1.62","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_154417_create_categories_table.php","line":14,"hash":"429585f43f58558204ccf04280e5e71e","hostname":"d782c42f75da"}	2025-08-03 17:51:27
102	9f8c29fd-82b2-4af5-8d04-02f27c3f3c95	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_154417_create_categories_table', 1)","time":"0.33","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
103	9f8c29fd-87a2-4cbf-91d8-85dd39de5ca5	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"products\\" (\\"id\\" bigserial not null primary key, \\"name\\" varchar(255) not null, \\"description\\" text null, \\"price\\" decimal(10, 2) not null, \\"stock_quantity\\" integer not null default '0', \\"category_id\\" bigint not null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"2.00","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_183942_create_products_table.php","line":14,"hash":"ef013ca5a5b781145cec83a68e401ce5","hostname":"d782c42f75da"}	2025-08-03 17:51:27
104	9f8c29fd-87da-430b-adb7-1e3c4ab1f94e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"products\\" add constraint \\"products_category_id_foreign\\" foreign key (\\"category_id\\") references \\"categories\\" (\\"id\\") on delete cascade","time":"0.42","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_183942_create_products_table.php","line":14,"hash":"2e64609b6b099475f0dc1f387e85cbf0","hostname":"d782c42f75da"}	2025-08-03 17:51:27
105	9f8c29fd-881c-4a05-a5c2-aa2f4d593b60	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"products\\" add constraint \\"products_name_unique\\" unique (\\"name\\")","time":"0.56","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_183942_create_products_table.php","line":14,"hash":"f5e9e8fac5f403b08357afb44c9627f4","hostname":"d782c42f75da"}	2025-08-03 17:51:27
106	9f8c29fd-8a74-4611-94b3-894bcff43548	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_183942_create_products_table', 1)","time":"0.66","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
107	9f8c29fd-8c0e-4c01-b182-fb0091120c66	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"carts\\" (\\"id\\" bigserial not null primary key, \\"user_id\\" bigint not null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"1.18","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192621_create_carts_table.php","line":14,"hash":"eea5dcde336c0021a4d86cb44a1ac690","hostname":"d782c42f75da"}	2025-08-03 17:51:27
108	9f8c29fd-8c47-4634-ba5c-659460bc9899	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"carts\\" add constraint \\"carts_user_id_foreign\\" foreign key (\\"user_id\\") references \\"users\\" (\\"id\\") on delete cascade","time":"0.45","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192621_create_carts_table.php","line":14,"hash":"db2bbde50cddae305e2bef53c32b0174","hostname":"d782c42f75da"}	2025-08-03 17:51:27
109	9f8c29fd-8e83-4bd6-b7fd-50a0bc8c572c	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_192621_create_carts_table', 1)","time":"0.40","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
110	9f8c29fd-8f96-45e2-8f19-fbd6c79f722a	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"cart_items\\" (\\"id\\" bigserial not null primary key, \\"cart_id\\" bigint not null, \\"product_id\\" bigint not null, \\"quantity\\" integer not null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"1.33","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192714_create_cart_items_table.php","line":14,"hash":"6fb12afa21b9adc113e2d23707c830d0","hostname":"d782c42f75da"}	2025-08-03 17:51:27
111	9f8c29fd-8fc8-4fab-a77b-c7349f34cd7e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"cart_items\\" add constraint \\"cart_items_cart_id_foreign\\" foreign key (\\"cart_id\\") references \\"carts\\" (\\"id\\") on delete cascade","time":"0.40","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192714_create_cart_items_table.php","line":14,"hash":"a696ba7b9dd115704f055e0905b28c19","hostname":"d782c42f75da"}	2025-08-03 17:51:27
112	9f8c29fd-8fee-4d51-afc1-ce62ab041a7c	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"cart_items\\" add constraint \\"cart_items_product_id_foreign\\" foreign key (\\"product_id\\") references \\"products\\" (\\"id\\") on delete cascade","time":"0.28","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192714_create_cart_items_table.php","line":14,"hash":"cf774e3dabb86131cf74b89cee3f3bf4","hostname":"d782c42f75da"}	2025-08-03 17:51:27
113	9f8c29fd-906d-4a5f-a227-887ed3f3aad6	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"cart_items\\" add constraint \\"cart_items_cart_id_product_id_unique\\" unique (\\"cart_id\\", \\"product_id\\")","time":"1.14","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_192714_create_cart_items_table.php","line":14,"hash":"784630b76faf54cefbfba019c599857d","hostname":"d782c42f75da"}	2025-08-03 17:51:27
114	9f8c29fd-9275-4e9e-b0fc-cb7d4f4a8f06	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_192714_create_cart_items_table', 1)","time":"0.39","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
115	9f8c29fd-930d-4292-9fed-f52292c051c5	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"orders\\" (\\"id\\" bigserial not null primary key, \\"user_id\\" bigint not null, \\"total_amount\\" decimal(10, 2) not null, \\"status\\" varchar(255) not null default 'pending', \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"1.04","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195930_create_orders_table.php","line":14,"hash":"55bb218471ec064a139557c8c5db4715","hostname":"d782c42f75da"}	2025-08-03 17:51:27
116	9f8c29fd-9339-4118-8d5d-9447effbae6f	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"orders\\" add constraint \\"orders_user_id_foreign\\" foreign key (\\"user_id\\") references \\"users\\" (\\"id\\") on delete cascade","time":"0.35","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195930_create_orders_table.php","line":14,"hash":"0cc541d897ba188a8b7bab4d3a5231d2","hostname":"d782c42f75da"}	2025-08-03 17:51:27
117	9f8c29fd-957a-4186-9982-17bc2f251452	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_195930_create_orders_table', 1)","time":"0.48","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
118	9f8c29fd-9612-433b-a098-b7d787570516	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"create table \\"order_items\\" (\\"id\\" bigserial not null primary key, \\"order_id\\" bigint not null, \\"product_id\\" bigint not null, \\"quantity\\" integer not null, \\"price\\" decimal(10, 2) not null, \\"created_at\\" timestamp(0) without time zone null, \\"updated_at\\" timestamp(0) without time zone null)","time":"0.98","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195939_create_order_items_table.php","line":14,"hash":"cc89f02fa9370221c608621a5084cf42","hostname":"d782c42f75da"}	2025-08-03 17:51:27
119	9f8c29fd-963e-416b-98a7-c3ca2959b70e	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"order_items\\" add constraint \\"order_items_order_id_foreign\\" foreign key (\\"order_id\\") references \\"orders\\" (\\"id\\") on delete cascade","time":"0.34","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195939_create_order_items_table.php","line":14,"hash":"ac84b0d40642e24f19999adc61b36918","hostname":"d782c42f75da"}	2025-08-03 17:51:27
120	9f8c29fd-9661-47f7-b822-f1a7f89bd511	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"order_items\\" add constraint \\"order_items_product_id_foreign\\" foreign key (\\"product_id\\") references \\"products\\" (\\"id\\") on delete cascade","time":"0.26","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195939_create_order_items_table.php","line":14,"hash":"3661fd94384d8ce46f37622d33c99f8d","hostname":"d782c42f75da"}	2025-08-03 17:51:27
121	9f8c29fd-96b8-4a19-a58b-430338513fde	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"alter table \\"order_items\\" add constraint \\"order_items_order_id_product_id_unique\\" unique (\\"order_id\\", \\"product_id\\")","time":"0.79","slow":false,"file":"\\/var\\/www\\/database\\/migrations\\/2025_08_02_195939_create_order_items_table.php","line":14,"hash":"9f08b6647b1531b9e1aaf821c4f436a3","hostname":"d782c42f75da"}	2025-08-03 17:51:27
122	9f8c29fd-98b4-46e7-9181-9176c92fc6c4	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"migrations\\" (\\"migration\\", \\"batch\\") values ('2025_08_02_195939_create_order_items_table', 1)","time":"0.35","slow":false,"file":"\\/var\\/www\\/artisan","line":16,"hash":"09c22f830d52d80cc99fe8c1b1acc44c","hostname":"d782c42f75da"}	2025-08-03 17:51:27
123	9f8c29fd-9e06-4e70-9bc7-7baf6c679539	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select * from \\"roles\\" where \\"name\\" = 'admin' and \\"guard_name\\" = 'web' limit 1","time":"0.39","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/RoleSeeder.php","line":16,"hash":"1f8911a5e6ff0fc58cd5de7237dcacd5","hostname":"d782c42f75da"}	2025-08-03 17:51:27
124	9f8c29fd-9f3f-4e89-bf21-dcdfd8b1eaec	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"roles\\" (\\"guard_name\\", \\"name\\", \\"updated_at\\", \\"created_at\\") values ('web', 'admin', '2025-08-03 17:51:27', '2025-08-03 17:51:27') returning \\"id\\"","time":"0.46","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/RoleSeeder.php","line":16,"hash":"c5ddaf4bd5b14ea17ad58208b28aa3c1","hostname":"d782c42f75da"}	2025-08-03 17:51:27
125	9f8c29fd-9f7d-4305-8f34-da9368589307	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	model	{"action":"created","model":"Spatie\\\\Permission\\\\Models\\\\Role:1","hostname":"d782c42f75da"}	2025-08-03 17:51:27
126	9f8c29fd-9fa4-41f2-9055-aaf22c8e36cc	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"delete from \\"cache\\" where \\"key\\" in ('laravel-cache-spatie.permission.cache', 'laravel-cache-illuminate:cache:flexible:created:spatie.permission.cache')","time":"0.21","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/RoleSeeder.php","line":16,"hash":"fbacc8221a9f2412f41db4a6ec324f6b","hostname":"d782c42f75da"}	2025-08-03 17:51:27
127	9f8c29fd-9fb2-4a95-9795-252409dc8218	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	cache	{"type":"forget","key":"spatie.permission.cache","hostname":"d782c42f75da"}	2025-08-03 17:51:27
128	9f8c29fe-09a2-4077-b12e-15f79e2da778	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"users\\" (\\"name\\", \\"email\\", \\"password\\", \\"updated_at\\", \\"created_at\\") values ('Admin User', 'admin@test.com', 'y$LT6.Ea4tXfXEN23AsHYaYuSQViKzO0hhhlrE8zzp8\\/bWvQrEbFk0G', '2025-08-03 17:51:27', '2025-08-03 17:51:27') returning \\"id\\"","time":"0.77","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/UserSeeder.php","line":15,"hash":"6edc5611ba545f075879d9907a9d3b35","hostname":"d782c42f75da"}	2025-08-03 17:51:27
129	9f8c29fe-09b2-4c79-9715-392739455dd7	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	model	{"action":"created","model":"App\\\\Models\\\\User:1","hostname":"d782c42f75da"}	2025-08-03 17:51:27
130	9f8c29fe-09fb-4f6b-bc18-636ca133cdf2	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select * from \\"roles\\" where \\"name\\" = 'admin' and \\"guard_name\\" = 'web' limit 1","time":"0.28","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/UserSeeder.php","line":20,"hash":"1f8911a5e6ff0fc58cd5de7237dcacd5","hostname":"d782c42f75da"}	2025-08-03 17:51:27
131	9f8c29fe-0a0a-4f2f-ab08-825c1edb99c1	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	model	{"action":"retrieved","model":"Spatie\\\\Permission\\\\Models\\\\Role","count":1,"hostname":"d782c42f75da"}	2025-08-03 17:51:27
132	9f8c29fe-0be4-4f81-92be-0f77c3f8b08c	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"select \\"roles\\".*, \\"model_has_roles\\".\\"model_id\\" as \\"pivot_model_id\\", \\"model_has_roles\\".\\"role_id\\" as \\"pivot_role_id\\", \\"model_has_roles\\".\\"model_type\\" as \\"pivot_model_type\\" from \\"roles\\" inner join \\"model_has_roles\\" on \\"roles\\".\\"id\\" = \\"model_has_roles\\".\\"role_id\\" where \\"model_has_roles\\".\\"model_id\\" = 1 and \\"model_has_roles\\".\\"model_type\\" = 'App\\\\Models\\\\User'","time":"0.37","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/UserSeeder.php","line":20,"hash":"863c03f9fb0c154a0ac2a68918392cbd","hostname":"d782c42f75da"}	2025-08-03 17:51:27
133	9f8c29fe-0c53-4bc4-8623-312d1e89bb5b	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"model_has_roles\\" (\\"model_id\\", \\"model_type\\", \\"role_id\\") values (1, 'App\\\\Models\\\\User', 1)","time":"0.58","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/UserSeeder.php","line":20,"hash":"8a5bac758b9349bad35628a325ad1793","hostname":"d782c42f75da"}	2025-08-03 17:51:27
134	9f8c29fe-6dc7-4b90-a839-a086f60cdcbc	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	query	{"connection":"pgsql","bindings":[],"sql":"insert into \\"users\\" (\\"name\\", \\"email\\", \\"password\\", \\"updated_at\\", \\"created_at\\") values ('Normal User', 'user@test.com', 'y$He7iijpdYvojA98FFViwpe.lQz0JfYaL05elwx2BAjLXl3YImp.9e', '2025-08-03 17:51:27', '2025-08-03 17:51:27') returning \\"id\\"","time":"0.68","slow":false,"file":"\\/var\\/www\\/database\\/seeders\\/UserSeeder.php","line":22,"hash":"6edc5611ba545f075879d9907a9d3b35","hostname":"d782c42f75da"}	2025-08-03 17:51:27
135	9f8c29fe-6ddb-4629-b1ba-425fe5a457b7	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	model	{"action":"created","model":"App\\\\Models\\\\User:2","hostname":"d782c42f75da"}	2025-08-03 17:51:27
136	9f8c29fe-70a2-4344-85c0-5e4dc7dceea0	9f8c29fe-71a3-4743-9003-b9ab9898dcf6	\N	t	command	{"command":"migrate:refresh","exit_code":0,"arguments":{"command":"migrate:refresh"},"options":{"database":null,"force":false,"path":[],"realpath":false,"seed":true,"seeder":null,"step":null,"help":false,"silent":false,"quiet":false,"verbose":false,"version":false,"ansi":null,"no-interaction":false,"env":null},"hostname":"d782c42f75da"}	2025-08-03 17:51:27
\.


--
-- Data for Name: telescope_entries_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telescope_entries_tags (entry_uuid, tag) FROM stdin;
9f8c29fd-9f7d-4305-8f34-da9368589307	Spatie\\Permission\\Models\\Role:1
9f8c29fe-09b2-4c79-9715-392739455dd7	App\\Models\\User:1
9f8c29fe-0a0a-4f2f-ab08-825c1edb99c1	Spatie\\Permission\\Models\\Role
9f8c29fe-6ddb-4629-b1ba-425fe5a457b7	App\\Models\\User:2
\.


--
-- Data for Name: telescope_monitoring; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.telescope_monitoring (tag) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
1	Admin User	admin@test.com	\N	$2y$12$LT6.Ea4tXfXEN23AsHYaYuSQViKzO0hhhlrE8zzp8/bWvQrEbFk0G	\N	2025-08-03 17:51:27	2025-08-03 17:51:27
2	Normal User	user@test.com	\N	$2y$12$He7iijpdYvojA98FFViwpe.lQz0JfYaL05elwx2BAjLXl3YImp.9e	\N	2025-08-03 17:51:27	2025-08-03 17:51:27
\.


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 1, false);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 10, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 24, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 1000, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, true);


--
-- Name: telescope_entries_sequence_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.telescope_entries_sequence_seq', 136, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_cart_id_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_product_id_unique UNIQUE (cart_id, product_id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: model_has_permissions model_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_pkey PRIMARY KEY (permission_id, model_id, model_type);


--
-- Name: model_has_roles model_has_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_pkey PRIMARY KEY (role_id, model_id, model_type);


--
-- Name: order_items order_items_order_id_product_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_product_id_unique UNIQUE (order_id, product_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: permissions permissions_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: products products_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_name_unique UNIQUE (name);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: role_has_permissions role_has_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_pkey PRIMARY KEY (permission_id, role_id);


--
-- Name: roles roles_name_guard_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_guard_name_unique UNIQUE (name, guard_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: telescope_entries telescope_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telescope_entries
    ADD CONSTRAINT telescope_entries_pkey PRIMARY KEY (sequence);


--
-- Name: telescope_entries_tags telescope_entries_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telescope_entries_tags
    ADD CONSTRAINT telescope_entries_tags_pkey PRIMARY KEY (entry_uuid, tag);


--
-- Name: telescope_entries telescope_entries_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telescope_entries
    ADD CONSTRAINT telescope_entries_uuid_unique UNIQUE (uuid);


--
-- Name: telescope_monitoring telescope_monitoring_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telescope_monitoring
    ADD CONSTRAINT telescope_monitoring_pkey PRIMARY KEY (tag);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: model_has_permissions_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_permissions_model_id_model_type_index ON public.model_has_permissions USING btree (model_id, model_type);


--
-- Name: model_has_roles_model_id_model_type_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX model_has_roles_model_id_model_type_index ON public.model_has_roles USING btree (model_id, model_type);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: telescope_entries_batch_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX telescope_entries_batch_id_index ON public.telescope_entries USING btree (batch_id);


--
-- Name: telescope_entries_created_at_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX telescope_entries_created_at_index ON public.telescope_entries USING btree (created_at);


--
-- Name: telescope_entries_family_hash_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX telescope_entries_family_hash_index ON public.telescope_entries USING btree (family_hash);


--
-- Name: telescope_entries_tags_tag_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX telescope_entries_tags_tag_index ON public.telescope_entries_tags USING btree (tag);


--
-- Name: telescope_entries_type_should_display_on_index_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX telescope_entries_type_should_display_on_index_index ON public.telescope_entries USING btree (type, should_display_on_index);


--
-- Name: cart_items cart_items_cart_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_foreign FOREIGN KEY (cart_id) REFERENCES public.carts(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: carts carts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: model_has_permissions model_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_permissions
    ADD CONSTRAINT model_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: model_has_roles model_has_roles_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_has_roles
    ADD CONSTRAINT model_has_roles_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_product_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_foreign FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: orders orders_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: products products_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES public.permissions(id) ON DELETE CASCADE;


--
-- Name: role_has_permissions role_has_permissions_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_has_permissions
    ADD CONSTRAINT role_has_permissions_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: telescope_entries_tags telescope_entries_tags_entry_uuid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.telescope_entries_tags
    ADD CONSTRAINT telescope_entries_tags_entry_uuid_foreign FOREIGN KEY (entry_uuid) REFERENCES public.telescope_entries(uuid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

