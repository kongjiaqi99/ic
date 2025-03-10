--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.4

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
-- Name: action_text_rich_texts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.action_text_rich_texts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    body text,
    record_type character varying NOT NULL,
    record_id integer NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.action_text_rich_texts OWNER TO postgres;

--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.action_text_rich_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.action_text_rich_texts_id_seq OWNER TO postgres;

--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.action_text_rich_texts_id_seq OWNED BY public.action_text_rich_texts.id;


--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_admin_comments (
    id bigint NOT NULL,
    namespace character varying,
    body text,
    resource_type character varying,
    resource_id bigint,
    author_type character varying,
    author_id bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.active_admin_comments OWNER TO postgres;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_admin_comments_id_seq OWNER TO postgres;

--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_admin_comments_id_seq OWNED BY public.active_admin_comments.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_users (
    id bigint NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    role_id bigint,
    del_flag boolean DEFAULT false NOT NULL
);


ALTER TABLE public.admin_users OWNER TO postgres;

--
-- Name: COLUMN admin_users.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.admin_users.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_users_id_seq OWNER TO postgres;

--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: annual_approve; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annual_approve (
    id integer NOT NULL,
    fund_id bigint,
    client_id bigint,
    entity_id bigint,
    year_list character varying[]
);


ALTER TABLE public.annual_approve OWNER TO postgres;

--
-- Name: annual_approve_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annual_approve_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.annual_approve_id_seq OWNER TO postgres;

--
-- Name: annual_approve_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annual_approve_id_seq OWNED BY public.annual_approve.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit (
    id integer NOT NULL,
    audit_type character varying(50) DEFAULT 'Client Update'::character varying,
    entity_content jsonb DEFAULT '{}'::jsonb,
    entity_id bigint DEFAULT 1,
    entity_name character varying(50),
    new_entity jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status character varying(50) DEFAULT 'Pending approval'::character varying,
    creator bigint DEFAULT 1,
    creator_name character varying(50) DEFAULT 'system'::character varying,
    approver bigint DEFAULT 1,
    approver_name character varying(50) DEFAULT 'system'::character varying
);


ALTER TABLE public.audit OWNER TO postgres;

--
-- Name: audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_id_seq OWNER TO postgres;

--
-- Name: audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_id_seq OWNED BY public.audit.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id bigint NOT NULL,
    permission_name character varying NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    del_flag boolean DEFAULT false NOT NULL,
    create_by character varying,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    update_by character varying,
    update_time timestamp without time zone DEFAULT now() NOT NULL,
    permission_code character varying NOT NULL,
    permission_level integer,
    upper_permission_id bigint
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_permission_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission_role (
    id bigint NOT NULL,
    permission_id bigint NOT NULL,
    role_id bigint NOT NULL,
    create_by character varying,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    update_by character varying,
    update_time timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.auth_permission_role OWNER TO postgres;

--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_permission_role_id_seq OWNER TO postgres;

--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_role_id_seq OWNED BY public.auth_permission_role.id;


--
-- Name: auth_permission_role_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_permission_role_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_role_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_role_permission_id_seq OWNED BY public.auth_permission_role.permission_id;


--
-- Name: auth_permission_role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_permission_role_role_id_seq OWNER TO postgres;

--
-- Name: auth_permission_role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_role_role_id_seq OWNED BY public.auth_permission_role.role_id;


--
-- Name: auth_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_role (
    id bigint NOT NULL,
    role_name character varying NOT NULL,
    active_flag boolean DEFAULT true NOT NULL,
    del_flag boolean DEFAULT false NOT NULL,
    create_by character varying,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    update_by character varying,
    update_time timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.auth_role OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auth_role_id_seq OWNER TO postgres;

--
-- Name: auth_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_role_id_seq OWNED BY public.auth_role.id;


--
-- Name: borrow_proposed_security; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.borrow_proposed_security (
    id integer NOT NULL,
    enquiry_id bigint NOT NULL,
    owner_name character varying,
    house_type character varying,
    loan_purpose character varying,
    land_area character varying,
    est_value character varying,
    valuation_date timestamp(6) without time zone,
    valuation_entity character varying,
    security_status character varying,
    borrow_amount character varying,
    lender_name character varying,
    in_arrears character varying,
    reason character varying
);


ALTER TABLE public.borrow_proposed_security OWNER TO postgres;

--
-- Name: borrow_proposed_security_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.borrow_proposed_security_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.borrow_proposed_security_id_seq OWNER TO postgres;

--
-- Name: borrow_proposed_security_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.borrow_proposed_security_id_seq OWNED BY public.borrow_proposed_security.id;


--
-- Name: ckeditor_assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ckeditor_assets (
    id bigint NOT NULL,
    data_file_name character varying NOT NULL,
    data_content_type character varying,
    data_file_size integer,
    type character varying(30),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ckeditor_assets OWNER TO postgres;

--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ckeditor_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ckeditor_assets_id_seq OWNER TO postgres;

--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ckeditor_assets_id_seq OWNED BY public.ckeditor_assets.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id bigint NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    sign_in_count integer NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    upper_client_id integer,
    beaver_id character varying,
    name character varying,
    client_type integer,
    country_code character varying,
    mobile character varying,
    salt character varying,
    birth date,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    bsb character varying,
    account_name character varying,
    account_number character varying,
    end_date date,
    interested_fund character varying,
    invest_entity integer,
    invest_status integer,
    link_to_valueup boolean,
    target_amount numeric(8,2),
    del_flag boolean DEFAULT false NOT NULL,
    level_two_upper_client_id integer,
    start_date date,
    withheld_tax boolean,
    tf_num character varying,
    status character varying DEFAULT 'NORMAL'::character varying,
    read_time timestamp(6) without time zone,
    push_client_id character varying,
    language integer DEFAULT 1,
    pin character varying(50)
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: COLUMN clients.upper_client_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.upper_client_id IS '1级upper client';


--
-- Name: COLUMN clients.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: COLUMN clients.level_two_upper_client_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.clients.level_two_upper_client_id IS '2级upper client';


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: cmd_exec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cmd_exec (
    cmd_output text
);


ALTER TABLE public.cmd_exec OWNER TO postgres;

--
-- Name: dictionary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dictionary (
    id bigint NOT NULL,
    type character varying,
    code character varying,
    value character varying,
    sort integer,
    create_time timestamp without time zone DEFAULT now() NOT NULL,
    update_time timestamp without time zone DEFAULT now() NOT NULL,
    del_flag boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dictionary OWNER TO postgres;

--
-- Name: dictionary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dictionary_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dictionary_id_seq OWNER TO postgres;

--
-- Name: dictionary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dictionary_id_seq OWNED BY public.dictionary.id;


--
-- Name: dividend_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dividend_histories (
    id bigint NOT NULL,
    purchased_fund_id bigint,
    divided_date date,
    amount numeric(8,2),
    currency character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    del_flag boolean DEFAULT false NOT NULL
);


ALTER TABLE public.dividend_histories OWNER TO postgres;

--
-- Name: COLUMN dividend_histories.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.dividend_histories.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: dividend_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dividend_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dividend_histories_id_seq OWNER TO postgres;

--
-- Name: dividend_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dividend_histories_id_seq OWNED BY public.dividend_histories.id;


--
-- Name: enquiries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enquiries (
    id bigint NOT NULL,
    name character varying,
    message character varying,
    email character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    phone character varying,
    interest character varying,
    suburb character varying,
    state character varying,
    del_flag boolean DEFAULT false NOT NULL,
    status character varying DEFAULT 'NEW'::character varying,
    type integer DEFAULT 1,
    fund_id bigint,
    investor_type integer,
    investment_term integer,
    investment_amount numeric(10,2),
    guarantor character varying,
    acn character varying,
    borrow_type character varying,
    borrow_purpose character varying,
    borrow_term integer,
    borrow_amount character varying,
    borrow_date timestamp(6) without time zone,
    borrow_primary character varying,
    borrow_secondary character varying,
    borrow_tertiary character varying,
    borrow_additional character varying,
    broker character varying,
    intention_file character varying,
    valuation_file character varying,
    borrow_file character varying,
    asic_file character varying,
    id_file character varying,
    house_file character varying,
    invest_file character varying,
    car_file character varying,
    loan_file character varying,
    lease_file character varying,
    card_file character varying
);


ALTER TABLE public.enquiries OWNER TO postgres;

--
-- Name: COLUMN enquiries.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.enquiries.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: enquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enquiries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enquiries_id_seq OWNER TO postgres;

--
-- Name: enquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enquiries_id_seq OWNED BY public.enquiries.id;


--
-- Name: event_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_client (
    id integer NOT NULL,
    event_id bigint,
    client_id bigint
);


ALTER TABLE public.event_client OWNER TO postgres;

--
-- Name: event_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_client_id_seq OWNER TO postgres;

--
-- Name: event_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_client_id_seq OWNED BY public.event_client.id;


--
-- Name: event_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_registrations (
    id bigint NOT NULL,
    client_id bigint,
    event_id bigint NOT NULL,
    participant_number integer,
    name character varying,
    email character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE public.event_registrations OWNER TO postgres;

--
-- Name: event_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_registrations_id_seq OWNER TO postgres;

--
-- Name: event_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_registrations_id_seq OWNED BY public.event_registrations.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id bigint NOT NULL,
    title character varying,
    start_time timestamp without time zone,
    city integer,
    location character varying,
    brief_introduction text,
    language integer,
    main_img character varying,
    trans_id bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    del_flag boolean DEFAULT false NOT NULL,
    status character varying DEFAULT 'Upcoming'::character varying,
    link character varying,
    file_url character varying,
    type character varying DEFAULT 'Online'::character varying
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: COLUMN events.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.events.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: finance_reference; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_reference (
    id integer NOT NULL,
    level integer NOT NULL,
    finance_id bigint NOT NULL,
    client_id bigint NOT NULL,
    entity_id bigint NOT NULL,
    parent_id bigint DEFAULT 0,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.finance_reference OWNER TO postgres;

--
-- Name: finance_reference_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_reference_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.finance_reference_id_seq OWNER TO postgres;

--
-- Name: finance_reference_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_reference_id_seq OWNED BY public.finance_reference.id;


--
-- Name: financings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.financings (
    id bigint NOT NULL,
    client_id bigint,
    fund_id bigint,
    financing_amount numeric(10,2),
    commission_rate numeric(5,4),
    commission_amount numeric(8,2),
    currency character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    referral_agreement character varying,
    target_amount numeric,
    target_date date,
    achieve_target boolean,
    del_flag boolean DEFAULT false NOT NULL,
    gst boolean,
    entity_id bigint
);


ALTER TABLE public.financings OWNER TO postgres;

--
-- Name: COLUMN financings.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.financings.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: financings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.financings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.financings_id_seq OWNER TO postgres;

--
-- Name: financings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.financings_id_seq OWNED BY public.financings.id;


--
-- Name: fund_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fund_tag (
    tag_id bigint NOT NULL,
    fund_id bigint NOT NULL
);


ALTER TABLE public.fund_tag OWNER TO postgres;

--
-- Name: fund_tag_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fund_tag_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fund_tag_tag_id_seq OWNER TO postgres;

--
-- Name: fund_tag_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fund_tag_tag_id_seq OWNED BY public.fund_tag.tag_id;


--
-- Name: funds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.funds (
    id bigint NOT NULL,
    name character varying,
    description text,
    settlement_date date,
    amount numeric(20,2),
    currency character varying,
    fund_type character varying,
    investment_type character varying,
    product_type character varying,
    purchase_min_amount character varying,
    investment_cycle character varying,
    fix_net_return character varying,
    float_net_return character varying,
    application_fee_rate character varying,
    management_fee_rate character varying,
    im_file_path character varying,
    introduce_file_path character varying,
    eoi_file_path character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    net_return_a character varying,
    net_return_b character varying,
    cash_divided_cycle character varying,
    performance_fee_rate character varying,
    investment_strategy character varying,
    nature_yearly_return character varying,
    value_yearly_return character varying,
    subscription_fee_rate character varying,
    report_file_path character varying,
    language integer DEFAULT 1,
    trans_id bigint,
    additional_investment_file character varying,
    display_order integer,
    constitution_file character varying,
    b_fund_category integer,
    b_project_duration_month integer,
    b_yearly_return_rate numeric,
    b_delayed_growth_rate numeric,
    fully_subscription boolean,
    fund_status integer,
    end_date date,
    sub_im_file_path character varying,
    application_form character varying,
    del_flag boolean DEFAULT false NOT NULL,
    interest_starts_date date,
    sub_im_date date,
    deed_date date,
    description_cn text,
    name_cn character varying,
    fund_type_cn character varying,
    investment_type_cn character varying,
    product_type_cn character varying,
    cash_divided_cycle_cn character varying,
    currency_cn character varying,
    investment_cycle_cn character varying,
    fix_net_return_cn character varying,
    float_net_return_cn character varying,
    application_fee_rate_cn character varying,
    management_fee_rate_cn character varying,
    net_return_a_cn character varying,
    net_return_b_cn character varying,
    performance_fee_rate_cn character varying,
    investment_strategy_cn character varying,
    nature_yearly_return_cn character varying,
    value_yearly_return_cn character varying,
    subscription_fee_rate_cn character varying,
    cover character varying,
    cover_cn character varying,
    popular integer DEFAULT 0,
    state_id integer,
    state_en character varying,
    state_cn character varying,
    extend_start_date timestamp(6) without time zone,
    default_start_date timestamp(6) without time zone,
    application_form_two character varying,
    application_form_three character varying,
    application_form_four character varying,
    cover_two character varying,
    cover_three character varying,
    cover_four character varying,
    cover_cn_two character varying,
    cover_cn_three character varying,
    cover_cn_four character varying,
    company character varying DEFAULT 'BHG'::character varying
);


ALTER TABLE public.funds OWNER TO postgres;

--
-- Name: COLUMN funds.settlement_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.funds.settlement_date IS 'used be found_date';


--
-- Name: COLUMN funds.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.funds.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: funds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.funds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.funds_id_seq OWNER TO postgres;

--
-- Name: funds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.funds_id_seq OWNED BY public.funds.id;


--
-- Name: investment_entities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investment_entities (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    entity_type integer,
    kyc_result boolean,
    entity_name character varying,
    created_at timestamp(6) without time zone DEFAULT now(),
    updated_at timestamp(6) without time zone DEFAULT now(),
    bsb character varying,
    account_number character varying,
    account_name character varying,
    file_1_front character varying,
    file_1_back character varying,
    file_2_front character varying,
    file_2_back character varying,
    detail_info character varying,
    kyc_status integer,
    del_flag boolean DEFAULT false NOT NULL,
    transcation_id character varying,
    ic_id character varying,
    email_list character varying[],
    address_line character varying,
    suburb character varying,
    state character varying,
    postcode character varying,
    application_form_signed character varying,
    is_client boolean DEFAULT false,
    status character varying DEFAULT 'NORMAL'::character varying,
    withheld_tax boolean,
    tf_num character varying,
    application_form_signed_two character varying,
    application_form_signed_three character varying,
    application_form_signed_four character varying,
    application_form_list character varying[]
);


ALTER TABLE public.investment_entities OWNER TO postgres;

--
-- Name: COLUMN investment_entities.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.investment_entities.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: COLUMN investment_entities.transcation_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.investment_entities.transcation_id IS 'transaction Id from kyc';


--
-- Name: investment_entities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.investment_entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investment_entities_id_seq OWNER TO postgres;

--
-- Name: investment_entities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.investment_entities_id_seq OWNED BY public.investment_entities.id;


--
-- Name: investment_entities_kyc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investment_entities_kyc (
    id integer NOT NULL,
    client_id bigint NOT NULL,
    entity_type integer,
    kyc_result boolean DEFAULT false,
    entity_name character varying,
    created_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT now() NOT NULL,
    bsb character varying,
    account_number character varying,
    account_name character varying,
    file_1_front character varying,
    file_1_back character varying,
    file_2_front character varying,
    file_2_back character varying,
    detail_info jsonb DEFAULT '{}'::jsonb,
    kyc_status integer,
    del_flag boolean DEFAULT false NOT NULL,
    transcation_id character varying
);


ALTER TABLE public.investment_entities_kyc OWNER TO postgres;

--
-- Name: investment_entities_kyc_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.investment_entities_kyc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.investment_entities_kyc_id_seq OWNER TO postgres;

--
-- Name: investment_entities_kyc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.investment_entities_kyc_id_seq OWNED BY public.investment_entities_kyc.id;


--
-- Name: loan_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loan_items (
    id bigint NOT NULL,
    address character varying,
    project_date date,
    loan_status integer,
    description character varying,
    value character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    del_flag boolean DEFAULT false NOT NULL
);


ALTER TABLE public.loan_items OWNER TO postgres;

--
-- Name: COLUMN loan_items.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.loan_items.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: loan_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loan_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loan_items_id_seq OWNER TO postgres;

--
-- Name: loan_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loan_items_id_seq OWNED BY public.loan_items.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news (
    id bigint NOT NULL,
    publish_date date,
    title character varying,
    content text,
    main_pic character varying,
    show_to_web boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    news_type integer,
    language integer,
    del_flag boolean DEFAULT false NOT NULL
);


ALTER TABLE public.news OWNER TO postgres;

--
-- Name: COLUMN news.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.news.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_id_seq OWNER TO postgres;

--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: news_imgs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.news_imgs (
    id bigint NOT NULL,
    img character varying,
    news_id bigint NOT NULL,
    display_order integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    del_flag boolean DEFAULT false NOT NULL
);


ALTER TABLE public.news_imgs OWNER TO postgres;

--
-- Name: COLUMN news_imgs.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.news_imgs.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: news_imgs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_imgs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_imgs_id_seq OWNER TO postgres;

--
-- Name: news_imgs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_imgs_id_seq OWNED BY public.news_imgs.id;


--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification (
    id integer NOT NULL,
    client_id_arr integer[],
    client_name_arr character varying[],
    is_all boolean DEFAULT false,
    title character varying,
    message character varying,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status character varying(50) DEFAULT 'NEW'::character varying,
    creator bigint DEFAULT 1,
    file character varying,
    title_cn character varying,
    message_cn character varying
);


ALTER TABLE public.notification OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;


--
-- Name: notify_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notify_client (
    id integer NOT NULL,
    notify_id bigint,
    client_id bigint
);


ALTER TABLE public.notify_client OWNER TO postgres;

--
-- Name: notify_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notify_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notify_client_id_seq OWNER TO postgres;

--
-- Name: notify_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notify_client_id_seq OWNED BY public.notify_client.id;


--
-- Name: operate_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operate_log (
    id integer NOT NULL,
    entity_type character varying(50),
    operate_type character varying(50),
    content jsonb DEFAULT '{}'::jsonb,
    entity_id bigint,
    created_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(6) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    creator bigint DEFAULT 1,
    creator_name character varying(50) DEFAULT 'system'::character varying,
    entity_name character varying
);


ALTER TABLE public.operate_log OWNER TO postgres;

--
-- Name: operate_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.operate_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.operate_log_id_seq OWNER TO postgres;

--
-- Name: operate_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.operate_log_id_seq OWNED BY public.operate_log.id;


--
-- Name: purchased_funds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchased_funds (
    id bigint NOT NULL,
    client_id bigint,
    fund_id bigint,
    unit_certificate_date date,
    purchase_amount numeric(10,2),
    current_return numeric(8,2),
    dividend_amount numeric(8,2),
    dividend_cycle character varying,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    unit_certi character varying,
    entity_name character varying,
    address_line character varying,
    suburb character varying,
    state character varying,
    postcode character varying,
    country character varying,
    uc_no character varying,
    investment_entity_id bigint,
    del_flag boolean DEFAULT false NOT NULL,
    transaction_date date,
    application_form_signed character varying,
    purchase_end_date date,
    application_form_signed_two character varying,
    application_form_signed_three character varying,
    application_form_signed_four character varying
);


ALTER TABLE public.purchased_funds OWNER TO postgres;

--
-- Name: COLUMN purchased_funds.unit_certificate_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.purchased_funds.unit_certificate_date IS 'used be purchase_date';


--
-- Name: COLUMN purchased_funds.del_flag; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.purchased_funds.del_flag IS 'true:deleted, false: not deleted';


--
-- Name: COLUMN purchased_funds.transaction_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.purchased_funds.transaction_date IS '客户投资款确认日';


--
-- Name: COLUMN purchased_funds.application_form_signed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.purchased_funds.application_form_signed IS '签过字的认购确认表';


--
-- Name: COLUMN purchased_funds.purchase_end_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.purchased_funds.purchase_end_date IS 'end date to calculate return, can be null';


--
-- Name: purchased_funds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.purchased_funds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.purchased_funds_id_seq OWNER TO postgres;

--
-- Name: purchased_funds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.purchased_funds_id_seq OWNED BY public.purchased_funds.id;


--
-- Name: referral; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referral (
    referral_id bigint NOT NULL,
    entity_id character varying(255) NOT NULL,
    referral_entity_id character varying(255) NOT NULL,
    rate numeric NOT NULL
);


ALTER TABLE public.referral OWNER TO postgres;

--
-- Name: referral_referral_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referral_referral_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referral_referral_id_seq OWNER TO postgres;

--
-- Name: referral_referral_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referral_referral_id_seq OWNED BY public.referral.referral_id;


--
-- Name: referral_structure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referral_structure (
    id bigint NOT NULL,
    entity_id character varying(255) NOT NULL,
    referral_entity_id character varying(255) NOT NULL,
    root_id bigint NOT NULL
);


ALTER TABLE public.referral_structure OWNER TO postgres;

--
-- Name: referral_structure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.referral_structure_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referral_structure_id_seq OWNER TO postgres;

--
-- Name: referral_structure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.referral_structure_id_seq OWNED BY public.referral_structure.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    tag_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    abn character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tags_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tags_tag_id_seq OWNER TO postgres;

--
-- Name: tags_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tags_tag_id_seq OWNED BY public.tags.tag_id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id bigint NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object text,
    created_at timestamp(6) without time zone
);


ALTER TABLE public.versions OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.versions_id_seq OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: visitor_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.visitor_log (
    id integer NOT NULL,
    email character varying NOT NULL,
    login_time timestamp(6) without time zone DEFAULT now(),
    status character varying DEFAULT 'Unconfirmed'::character varying
);


ALTER TABLE public.visitor_log OWNER TO postgres;

--
-- Name: visitor_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.visitor_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.visitor_log_id_seq OWNER TO postgres;

--
-- Name: visitor_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.visitor_log_id_seq OWNED BY public.visitor_log.id;


--
-- Name: action_text_rich_texts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.action_text_rich_texts ALTER COLUMN id SET DEFAULT nextval('public.action_text_rich_texts_id_seq'::regclass);


--
-- Name: active_admin_comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_admin_comments ALTER COLUMN id SET DEFAULT nextval('public.active_admin_comments_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: annual_approve id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_approve ALTER COLUMN id SET DEFAULT nextval('public.annual_approve_id_seq'::regclass);


--
-- Name: audit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit ALTER COLUMN id SET DEFAULT nextval('public.audit_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_permission_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_role_id_seq'::regclass);


--
-- Name: auth_permission_role permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role ALTER COLUMN permission_id SET DEFAULT nextval('public.auth_permission_role_permission_id_seq'::regclass);


--
-- Name: auth_permission_role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role ALTER COLUMN role_id SET DEFAULT nextval('public.auth_permission_role_role_id_seq'::regclass);


--
-- Name: auth_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_role ALTER COLUMN id SET DEFAULT nextval('public.auth_role_id_seq'::regclass);


--
-- Name: borrow_proposed_security id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_proposed_security ALTER COLUMN id SET DEFAULT nextval('public.borrow_proposed_security_id_seq'::regclass);


--
-- Name: ckeditor_assets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ckeditor_assets ALTER COLUMN id SET DEFAULT nextval('public.ckeditor_assets_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: dictionary id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dictionary ALTER COLUMN id SET DEFAULT nextval('public.dictionary_id_seq'::regclass);


--
-- Name: dividend_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dividend_histories ALTER COLUMN id SET DEFAULT nextval('public.dividend_histories_id_seq'::regclass);


--
-- Name: enquiries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries ALTER COLUMN id SET DEFAULT nextval('public.enquiries_id_seq'::regclass);


--
-- Name: event_client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_client ALTER COLUMN id SET DEFAULT nextval('public.event_client_id_seq'::regclass);


--
-- Name: event_registrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_registrations ALTER COLUMN id SET DEFAULT nextval('public.event_registrations_id_seq'::regclass);


--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Name: finance_reference id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_reference ALTER COLUMN id SET DEFAULT nextval('public.finance_reference_id_seq'::regclass);


--
-- Name: financings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financings ALTER COLUMN id SET DEFAULT nextval('public.financings_id_seq'::regclass);


--
-- Name: fund_tag tag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_tag ALTER COLUMN tag_id SET DEFAULT nextval('public.fund_tag_tag_id_seq'::regclass);


--
-- Name: funds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.funds ALTER COLUMN id SET DEFAULT nextval('public.funds_id_seq'::regclass);


--
-- Name: investment_entities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investment_entities ALTER COLUMN id SET DEFAULT nextval('public.investment_entities_id_seq'::regclass);


--
-- Name: investment_entities_kyc id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investment_entities_kyc ALTER COLUMN id SET DEFAULT nextval('public.investment_entities_kyc_id_seq'::regclass);


--
-- Name: loan_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loan_items ALTER COLUMN id SET DEFAULT nextval('public.loan_items_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: news_imgs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_imgs ALTER COLUMN id SET DEFAULT nextval('public.news_imgs_id_seq'::regclass);


--
-- Name: notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);


--
-- Name: notify_client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notify_client ALTER COLUMN id SET DEFAULT nextval('public.notify_client_id_seq'::regclass);


--
-- Name: operate_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operate_log ALTER COLUMN id SET DEFAULT nextval('public.operate_log_id_seq'::regclass);


--
-- Name: purchased_funds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchased_funds ALTER COLUMN id SET DEFAULT nextval('public.purchased_funds_id_seq'::regclass);


--
-- Name: referral referral_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral ALTER COLUMN referral_id SET DEFAULT nextval('public.referral_referral_id_seq'::regclass);


--
-- Name: referral_structure id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_structure ALTER COLUMN id SET DEFAULT nextval('public.referral_structure_id_seq'::regclass);


--
-- Name: tags tag_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags ALTER COLUMN tag_id SET DEFAULT nextval('public.tags_tag_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: visitor_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor_log ALTER COLUMN id SET DEFAULT nextval('public.visitor_log_id_seq'::regclass);


--
-- Data for Name: action_text_rich_texts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.action_text_rich_texts (id, name, body, record_type, record_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: active_admin_comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_admin_comments (id, namespace, body, resource_type, resource_id, author_type, author_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, role_id, del_flag) FROM stdin;
19	qizuo1130@gmail.com	$2a$10$4GS/vH9Zt4OvWKd1eYxcGuKz/gCNzLSzNsYTA1AX0IT9sG.FmDWSO	6E2D24E7E42747E4DF8541D83FA6226B	2023-10-04 11:14:08.77	\N	2023-08-14 16:40:33.204	2023-10-04 11:14:08.77	2	f
16	frank.mai@bhgglobal.com.au	$2a$10$GK2iVCH1yoa0manfGc7ZBeNcF4li2b8KZLmhW31qSVIJEjER7Vas.	\N	\N	\N	2023-03-07 13:39:35.383	2023-03-07 13:40:59.304	1	t
13	robert.chen@bhgglobal.com.au	$2a$10$aiX25r..QDoeEiXoX4Nb9.gA1UE6kbdmOMnQy3x8Iny.Ko3IcOxZa	\N	\N	2023-02-21 07:42:47.594086	2023-02-21 07:31:16.859401	2023-07-24 10:47:57.677	1	t
7	marketing@beavercapital.com.au	$2a$12$4MI9/tZoslT4JYBKRGZcIe5KcAfYWp4gy40uttDgb38g0h5.CnAai	\N	\N	2022-06-14 10:19:52.308161	2022-06-14 09:06:38.963321	2023-11-29 15:26:58.484	1	t
3	andy.chen@bhgglobal.com.au	$2a$10$bzAxEBbhefv5qMZ1CHZI..iSuwKOiGinXeVOQBewMBbVl7eIxDdSS	\N	\N	\N	2022-02-07 12:54:29.877197	2024-06-11 17:42:49.989	1	t
15	brendon.wu@bhgglobal.com.au	$2a$10$Unr.YVhoufJRlASHb9qqGeBPUUMQKqDQO7mLJuNgjNlnfLo4SVmCe	\N	\N	\N	2023-03-06 10:49:08.656	2024-06-11 17:43:35.819	3	t
18	jerry.zhang@bhgglobal.com.au	$2a$10$glTG6QL60wi2rRjSgiIrlOpkWjSAkRhaeLN8Zh5orUSZ3bodSWMHS	\N	\N	\N	2023-07-31 16:55:54.522	2024-06-11 17:43:55.812	2	t
20	test@gmail.com.au	$2a$10$eSYuVijwY1bMmFgKHPbDfu3Uxu0jxRIDPitH.dTUUJWgGHpL9jSqS	\N	\N	\N	2023-08-23 14:30:39.306	2024-06-11 17:44:08.317	3	t
22	temp@bhgglobal.com.au	$2a$10$6PRtLQ6UDima5IEKr1xAR.yW4zXH5Epkm5IUMnWbWHDr8XDoaFefq	\N	\N	\N	2024-01-30 14:25:32.862	2024-06-11 17:44:22.877	1	t
23	accounting@bhgglobal.com.au	$2a$10$uuv1y1cIyUMeJmy2AlM8DeU7G0zpItbqb25q/pp.6w6lIxaljIZOy	\N	\N	\N	2024-03-05 10:36:44.7	2024-06-11 17:44:29.494	1	t
26	test1@gmail.com.au	$2a$10$oIbM8Q9.GrNjwWbvgO3AX.6AKnvwbzGzIurr2UvW.nOCz9A2zw0GW	\N	\N	\N	2024-06-05 10:02:19.043	2024-06-11 17:44:41.375	1	t
25	test1@gmail.com	$2a$10$0VIvKeH8l/R11DQIIkZsFeXrHebwRmeQNABxrZ9X/1qgqNYtffH6.	\N	\N	\N	2024-06-03 14:38:08.67	2024-06-05 10:02:02.273	2	t
31	weilipersonalemail@gmail.com	$2a$10$ftx8ap5EzWhg28KW9pamJu.8S4bddyXEZKC6DzLpH3CV48ehXFR9u	\N	\N	\N	2024-09-09 10:21:11.94	2024-09-11 11:49:41.862	1	t
33	fiona.wang@bhgglobal.com.au	$2a$10$p7NVXsSd1/z/Me9gGQgcouX71NZThnU4MFyQwpzhJlwNEVnfs.1g2	\N	\N	\N	2024-09-20 11:38:07.585	2025-03-07 10:50:39.354	3	t
32	info@bhgglobal.com.au	$2a$10$UZ4rdITxO4qg3RjghSVpe.hjyXYuXzzRfjZJxV/YcJjgg8vUJs8p6	\N	\N	\N	2024-09-11 11:49:57.776	2025-03-07 10:50:43.971	1	t
29	phoebe.lin@bhgglobal.com.au	$2a$10$HvlE4w/Oi9Mu04LRdFNba..JuscCZbHCcyjuNuiGnkBv2MrCSEXxe	\N	\N	\N	2024-08-29 10:55:46.451	2025-03-07 10:50:49.409	4	t
28	operation.sa@bhgglobal.com.au	$2a$10$y73x9KPoPyZv4yeCzbMX0.csrc0Vb3nlGrYfNIRNJdqA5RuCjxhZi	\N	\N	\N	2024-06-07 10:58:35.684	2025-03-07 10:50:55.064	3	t
27	amelia.hou@bhgglobal.com.au	$2a$10$s980LnbXUIf0YBIOgL3M9u1T/syUtyJ30Dzgte.JuPxbqetoUJriy	\N	\N	\N	2024-06-05 10:32:50.856	2025-03-07 10:50:59.038	3	t
21	it@bhgglobal.com.au	$2a$10$DR1opeoUhXo5nCjyDjq8HeCpq2HycVI0AmiJ2um.zpLuVnOgsrPXC	\N	\N	\N	2023-12-01 10:16:29.702	2025-03-07 10:51:03.796	1	t
24	yuki.sun@bhgglobal.com.au	$2a$10$Il1YeKKgr7brHj4zvVsuAO9Zvcyp1Q7n36oG0ZhTaA.mixRFzbtYW	\N	\N	\N	2024-03-05 10:37:11.131	2025-03-07 10:51:08.78	1	t
17	accounts@bhgglobal.com.au	$2a$10$MpWlJWWfPEwZM7PkoGSWbuItSS9S7NA2cl9uLdfg.X5UFJREfmue6	\N	\N	\N	2023-05-23 10:47:28.137	2025-03-07 10:51:14.072	2	t
14	jason_wtx@hotmail.com	$2a$10$xECLKP.mQXAXS.K84j52FOUotPS0whoqw7Y1pY6uS3K5W0ZtlFane	8402F883648A946BEF5CF8E24BAD7B05	2023-03-01 17:48:07.138	2023-02-27 15:31:51.646926	2023-02-27 15:31:51.646926	2025-03-07 10:51:23.56	1	t
11	emily.zhang@bhgglobal.com.au	$2a$10$1b6j/6FLXa5XUjttBVgJSeUTGyMXe/L/57t.kF.3laTRO1owNaBQC	\N	\N	\N	2022-10-07 10:46:33.631707	2025-03-07 10:51:27.734	1	t
10	benson@bchyper.com.au	$2a$10$y8AcDC7ixd6jPBGLkilI1uBK9vOGf4Ee2rdYSwiMc/brW9FMxp38O	\N	\N	\N	2022-10-05 08:10:20.550179	2025-03-07 10:51:35.174	1	t
9	frank.mai@bhgglobal.com.au	$2a$10$w7NL4k3xe1T8g6s1oJcTw.V.W3k3t7IZjdmipy5i.WSPAxXwaSODG	\N	\N	2022-08-30 12:08:14.165556	2022-08-30 08:40:42.888722	2025-03-07 10:51:38.117	1	t
5	anna.feng@beavercapital.com.au	$2a$12$gde87QsGY.Hkvb/by021m.rnAoxOWnpz8H0onhGfpBcNl7jZHkyv6	\N	\N	2022-03-31 10:34:00.63077	2022-03-31 10:27:56.041685	2025-03-07 10:51:43.244	1	t
1	operations@beavercapital.com.au	$2a$12$cjONMdxaXqCfWC87Q0WHu.bWVNr9xBB3JD4Cc.mH6HfF2nPFx9rsi	\N	\N	2022-04-20 10:11:42.213378	2021-07-14 07:41:22.160233	2025-03-07 10:51:46.201	1	t
34	Jessie@starx.com.au	$2a$10$9HwMxgzpKGOnQxq.BV.RDOM.MpjRs5RrZbFKWqXAyEB2K9o2L6YGW	\N	\N	\N	2025-03-07 12:11:28.838	2025-03-07 12:11:28.838	1	f
30	oliver@starx.com.au	$2a$10$ruarbrqaTTsHMO9eMJLiSOXj/H9GSVo9ZxVlCUAjWHG3E1g/zHoPe	\N	\N	\N	2024-09-03 15:42:04.897	2025-03-07 12:11:35.984	1	f
\.


--
-- Data for Name: annual_approve; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annual_approve (id, fund_id, client_id, entity_id, year_list) FROM stdin;
2	123	123	123	{2025,2024}
4	134	304	320	{2021,2023,2022,2024}
5	102	218	240	{2021,2022,2023,2024}
6	37	23	137	{2024}
7	2	304	320	{2024}
8	38	250	249	{2023}
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2021-07-13 16:35:36.007204	2021-07-22 13:20:45.043856
\.


--
-- Data for Name: audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit (id, audit_type, entity_content, entity_id, entity_name, new_entity, created_at, updated_at, status, creator, creator_name, approver, approver_name) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, permission_name, active_flag, del_flag, create_by, create_time, update_by, update_time, permission_code, permission_level, upper_permission_id) FROM stdin;
1	Dashboard	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	dashboard	1	\N
2	Clients	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	clients	1	\N
3	Admin Users	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	admin-users	1	\N
5	Events	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	events	1	\N
6	Financings	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	financings	1	\N
7	Funds	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	funds	1	\N
8	Loan Items	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	loan-items	1	\N
9	News	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	news	1	\N
10	News Imgs	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	news-imgs	1	\N
11	Purchased Funds	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	purchased-funds	1	\N
12	clinets-edit	t	f	admin	2023-02-27 12:45:32.044224	admin	2023-02-27 12:45:32.044224	clinets-edit	2	2
13	financings-edit	t	f	admin	2023-02-27 12:45:32.075158	admin	2023-02-27 12:45:32.075158	financings-edit	2	6
14	funds-edit	t	f	admin	2023-02-27 12:45:32.10515	admin	2023-02-27 12:45:32.10515	funds-edit	2	7
15	loan-items-edit	t	f	admin	2023-02-27 12:45:32.135162	admin	2023-02-27 12:45:32.135162	loan-items-edit	2	8
16	purchased-funds-edit	t	f	admin	2023-02-27 12:45:32.165165	admin	2023-02-27 12:45:32.165165	purchased-funds-edit	2	11
17	Admin Users-edit	t	f	admin	2023-02-27 12:45:32.198167	admin	2023-02-27 12:45:32.198167	admin-users-edit	2	3
18	Enquiries-edit	t	f	admin	2023-02-27 12:45:32.228138	admin	2023-02-27 12:45:32.228138	enquiries-edit	2	4
19	Events-edit	t	f	admin	2023-02-27 12:45:32.258153	admin	2023-02-27 12:45:32.258153	events-edit	2	5
20	News-edit	t	f	admin	2023-02-27 12:45:32.28816	admin	2023-02-27 12:45:32.28816	news-edit	2	9
21	News Imgs-edit	t	f	admin	2023-02-27 12:45:32.318147	admin	2023-02-27 12:45:32.318147	news-imgs-edit	2	10
4	Enquiries	t	f	admin	2022-11-16 12:56:09.897228	admin	2022-11-16 12:56:09.897228	enquiries	1	\N
24	audit	t	f	admin	2023-02-27 12:45:32.318	admin	2023-02-27 12:45:32.318	audit	1	10
25	audit-edit	t	f	admin	2023-02-27 12:45:32.318	admin	2023-02-27 12:45:32.318	audit-edit	2	10
26	notification	t	f	admin	2023-02-27 12:45:32.318	admin	2023-02-27 12:45:32.318	notification	1	10
27	notification-edit	t	f	admin	2023-02-27 12:45:32.318	admin	2023-02-27 12:45:32.318	notification-edit	2	10
\.


--
-- Data for Name: auth_permission_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission_role (id, permission_id, role_id, create_by, create_time, update_by, update_time) FROM stdin;
1	1	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
2	2	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
3	3	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
4	4	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
5	5	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
6	6	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
7	7	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
8	8	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
9	9	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
10	10	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
11	11	1	admin	2022-11-16 12:57:06.236157	admin	2022-11-16 12:57:06.236157
12	12	1	admin	2023-02-27 12:46:34.730303	admin	2023-02-27 12:46:34.730303
13	13	1	admin	2023-02-27 12:46:34.759292	admin	2023-02-27 12:46:34.759292
14	14	1	admin	2023-02-27 12:46:34.788262	admin	2023-02-27 12:46:34.788262
15	15	1	admin	2023-02-27 12:46:34.818258	admin	2023-02-27 12:46:34.818258
16	16	1	admin	2023-02-27 12:46:34.848266	admin	2023-02-27 12:46:34.848266
17	17	1	admin	2023-02-27 12:46:34.878272	admin	2023-02-27 12:46:34.878272
18	18	1	admin	2023-02-27 12:46:34.908263	admin	2023-02-27 12:46:34.908263
19	19	1	admin	2023-02-27 12:46:34.938258	admin	2023-02-27 12:46:34.938258
20	20	1	admin	2023-02-27 12:46:34.968253	admin	2023-02-27 12:46:34.968253
21	21	1	admin	2023-02-27 12:46:34.998317	admin	2023-02-27 12:46:34.998317
22	1	2	admin	2023-02-27 12:46:35.028287	admin	2023-02-27 12:46:35.028287
23	2	2	admin	2023-02-27 12:46:35.058255	admin	2023-02-27 12:46:35.058255
24	12	2	admin	2023-02-27 12:46:35.087257	admin	2023-02-27 12:46:35.087257
25	4	2	admin	2023-02-27 12:46:35.116263	admin	2023-02-27 12:46:35.116263
26	18	2	admin	2023-02-27 12:46:35.14626	admin	2023-02-27 12:46:35.14626
27	5	2	admin	2023-02-27 12:46:35.176282	admin	2023-02-27 12:46:35.176282
28	19	2	admin	2023-02-27 12:46:35.205273	admin	2023-02-27 12:46:35.205273
31	7	2	admin	2023-02-27 12:46:35.295262	admin	2023-02-27 12:46:35.295262
32	14	2	admin	2023-02-27 12:46:35.325273	admin	2023-02-27 12:46:35.325273
33	8	2	admin	2023-02-27 12:46:35.355263	admin	2023-02-27 12:46:35.355263
34	15	2	admin	2023-02-27 12:46:35.386245	admin	2023-02-27 12:46:35.386245
35	9	2	admin	2023-02-27 12:46:35.416251	admin	2023-02-27 12:46:35.416251
36	20	2	admin	2023-02-27 12:46:35.446274	admin	2023-02-27 12:46:35.446274
37	10	2	admin	2023-02-27 12:46:35.476251	admin	2023-02-27 12:46:35.476251
38	21	2	admin	2023-02-27 12:46:35.506298	admin	2023-02-27 12:46:35.506298
39	11	2	admin	2023-02-27 12:46:35.536248	admin	2023-02-27 12:46:35.536248
40	16	2	admin	2023-02-27 12:46:35.566268	admin	2023-02-27 12:46:35.566268
41	1	3	admin	2023-02-27 12:46:35.596253	admin	2023-02-27 12:46:35.596253
42	2	3	admin	2023-02-27 12:46:35.626249	admin	2023-02-27 12:46:35.626249
43	4	3	admin	2023-02-27 12:46:35.656256	admin	2023-02-27 12:46:35.656256
45	5	3	admin	2023-02-27 12:46:35.71626	admin	2023-02-27 12:46:35.71626
48	7	3	admin	2023-02-27 12:46:35.806256	admin	2023-02-27 12:46:35.806256
49	8	3	admin	2023-02-27 12:46:35.836252	admin	2023-02-27 12:46:35.836252
50	9	3	admin	2023-02-27 12:46:35.86627	admin	2023-02-27 12:46:35.86627
52	10	3	admin	2023-02-27 12:46:35.925256	admin	2023-02-27 12:46:35.925256
54	11	3	admin	2023-02-27 12:46:35.986256	admin	2023-02-27 12:46:35.986256
56	4	4	admin	2023-02-27 12:46:36.045285	admin	2023-02-27 12:46:36.045285
57	18	4	admin	2023-02-27 12:46:36.075253	admin	2023-02-27 12:46:36.075253
58	5	4	admin	2023-02-27 12:46:36.105254	admin	2023-02-27 12:46:36.105254
59	19	4	admin	2023-02-27 12:46:36.135278	admin	2023-02-27 12:46:36.135278
60	9	4	admin	2023-02-27 12:46:36.165258	admin	2023-02-27 12:46:36.165258
61	20	4	admin	2023-02-27 12:46:36.195293	admin	2023-02-27 12:46:36.195293
62	10	4	admin	2023-02-27 12:46:36.225266	admin	2023-02-27 12:46:36.225266
63	21	4	admin	2023-02-27 12:46:36.255265	admin	2023-02-27 12:46:36.255265
65	24	1	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
66	25	1	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
67	26	1	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
68	27	1	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
69	11	2	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
70	16	2	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
71	24	2	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
72	25	2	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
73	26	2	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
74	27	2	admin	2024-06-04 10:31:01.312407	admin	2024-06-04 10:31:01.312407
78	11	3	admin	2024-06-04 10:39:44.206338	admin	2024-06-04 10:39:44.206338
79	24	3	admin	2024-06-04 10:39:44.206338	admin	2024-06-04 10:39:44.206338
80	26	3	admin	2024-06-04 10:39:44.206338	admin	2024-06-04 10:39:44.206338
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_role (id, role_name, active_flag, del_flag, create_by, create_time, update_by, update_time) FROM stdin;
1	Super Admin	t	f	admin	2022-11-16 10:39:48.514121	admin	2022-11-16 10:39:48.514121
2	Fund Admin	t	f	admin	2023-02-27 12:46:57.929343	admin	2023-02-27 12:46:57.929343
3	Fund Operation	t	f	admin	2023-02-27 12:46:57.959302	admin	2023-02-27 12:46:57.959302
4	Web Admin	t	f	admin	2023-02-27 12:46:57.989309	admin	2023-02-27 12:46:57.989309
\.


--
-- Data for Name: borrow_proposed_security; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.borrow_proposed_security (id, enquiry_id, owner_name, house_type, loan_purpose, land_area, est_value, valuation_date, valuation_entity, security_status, borrow_amount, lender_name, in_arrears, reason) FROM stdin;
1	19	22222	Residential	Loan Purpose (In details)	20	30000	2023-11-30 08:00:00	222222	Yes	22222	333333	Yes	222222222222
2	20	22222	Residential	Loan Purpose (In details)	20	30000	2023-11-30 11:00:00	222222	Yes	22222	333333	Yes	222222222222
3	21	22222	Residential	Loan Purpose (In details)	20	30000	2023-11-30 11:00:00	222222	Yes	22222	333333	Yes	222222222222
4	22	22222	Commercial	2222	333	30000	2023-11-30 11:00:00	222222	Yes	22222	333333	Yes	7777777
5	24	Qi Zuo	Residential	12	12		1996-12-12 11:00:00	121	Yes	1	1	Yes	q2
6	56			Purchase land and construct three single storey dwellings for turn-key house and land packages	710	$710,000	2023-12-06 11:00:00	Owner	Unencumbered	$0.00	N?A	No	
7	61	Qw	Residential	Wetyik	123456	543222	2024-01-31 11:00:00	Qwrtyuu	Encumbered	1234567	Asdgg	Yes	
8	63	22222	Residential	44444	44	30000	2024-01-31 11:00:00	222222	Encumbered				
9	81						\N						
10	82	22222	Residential				\N						
11	104						\N						
12	106						\N						
13	107						\N						
\.


--
-- Data for Name: ckeditor_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ckeditor_assets (id, data_file_name, data_content_type, data_file_size, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, email, encrypted_password, reset_password_token, reset_password_sent_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, upper_client_id, beaver_id, name, client_type, country_code, mobile, salt, birth, created_at, updated_at, bsb, account_name, account_number, end_date, interested_fund, invest_entity, invest_status, link_to_valueup, target_amount, del_flag, level_two_upper_client_id, start_date, withheld_tax, tf_num, status, read_time, push_client_id, language, pin) FROM stdin;
329	111@gmail.com	$2a$10$aZU.CVone9/a2aJ9UrXEkusrsMb7XTqL/KYejKv9EvMeFDt.g45rG	\N	\N	0	\N	\N	\N	\N	\N		11	\N			\N	\N	2025-03-07 10:31:05.519	2025-03-07 10:31:05.519				\N	\N	\N	\N	f	\N	f	\N	\N	f		NORMAL	\N	\N	1	\N
\.


--
-- Data for Name: cmd_exec; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cmd_exec (cmd_output) FROM stdin;
\.


--
-- Data for Name: dictionary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dictionary (id, type, code, value, sort, create_time, update_time, del_flag) FROM stdin;
1	client_type	direct	0	0	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	f
2	client_type	refered	1	1	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	f
3	client_type	value_up	2	2	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	f
4	client_type	partner	3	3	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	f
11	admin_user_filter_type	Contains	0	0	2022-11-24 11:57:39.559	2022-11-24 11:57:39.559	f
12	admin_user_filter_type	Equals	1	1	2022-11-24 11:57:39.61	2022-11-24 11:57:39.61	f
13	admin_user_filter_type	Starts with	2	2	2022-11-24 11:57:39.659	2022-11-24 11:57:39.659	f
14	admin_user_filter_type	Ends with	3	3	2022-11-24 11:57:39.705	2022-11-24 11:57:39.705	f
15	event_city	Online	0	0	2023-02-27 12:47:40.739462	2023-02-27 12:47:40.739462	f
16	event_city	Sydney	1	1	2023-02-27 12:47:40.7704	2023-02-27 12:47:40.7704	f
17	event_city	Melbourne	2	2	2023-02-27 12:47:40.800394	2023-02-27 12:47:40.800394	f
18	event_city	Brisbane	3	3	2023-02-27 12:47:40.830383	2023-02-27 12:47:40.830383	f
19	event_city	Adelaide	4	4	2023-02-27 12:47:40.860411	2023-02-27 12:47:40.860411	f
20	event_city	Perth	5	5	2023-02-27 12:47:40.89039	2023-02-27 12:47:40.89039	f
21	event_city	Hobart	6	6	2023-02-27 12:47:40.91939	2023-02-27 12:47:40.91939	f
22	event_city	Canberra	7	7	2023-02-27 12:47:40.950406	2023-02-27 12:47:40.950406	f
23	event_city	Gold Coast	8	8	2023-02-27 12:47:40.980382	2023-02-27 12:47:40.980382	f
26	fund_status	coming_soon	0	0	2023-02-27 12:47:41.071384	2023-02-27 12:47:41.071384	f
27	fund_status	now_open	1	1	2023-02-27 12:47:41.101384	2023-02-27 12:47:41.101384	f
28	fund_status	fully_invested	2	2	2023-02-27 12:47:41.131381	2023-02-27 12:47:41.131381	f
29	fund_status	completed	3	3	2023-02-27 12:47:41.161375	2023-02-27 12:47:41.161375	f
24	language	Cn	0	0	2022-11-30 20:20:15.293	2022-11-30 20:20:15.293	f
25	language	En	1	1	2022-11-30 20:20:15.293	2022-11-30 20:20:15.293	f
30	fund_category	Pool	0	0	2023-02-27 12:47:41.254424	2023-02-27 12:47:41.254424	f
31	fund_category	Direct	1	1	2023-02-27 12:47:41.283415	2023-02-27 12:47:41.283415	f
32	news_type	beaver_news	0	0	2023-02-27 12:47:41.313409	2023-02-27 12:47:41.313409	f
33	news_type	last_insights	1	1	2023-02-27 12:47:41.343376	2023-02-27 12:47:41.343376	f
34	news_type	global_weekly_wrap	2	2	2023-02-27 12:47:41.373384	2023-02-27 12:47:41.373384	f
7	investment_entity_type	smsf	2	2	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	t
8	investment_entity_type	trust_individual	3	3	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	t
9	investment_entity_type	trust_family	4	4	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	t
10	investment_entity_type	oversea_tax_person	5	5	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	t
38	enquiry_type	general	1	1	2023-11-14 18:01:00.85224	2023-11-14 18:01:00.85224	f
39	enquiry_type	investment	2	2	2023-11-14 18:01:00.85224	2023-11-14 18:01:00.85224	f
40	enquiry_type	borrow	3	3	2023-11-14 18:01:00.85224	2023-11-14 18:01:00.85224	f
54	state	South Australia	南澳大利亚州	6	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
49	state	ACT	堪培拉	1	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
50	state	New South Wales	新南威尔士州	2	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
51	state	Victoria	维多利亚州	3	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
52	state	Queensland	昆士兰州	4	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
53	state	Western Australia	西澳大利亚州	5	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
55	state	Tasmania	塔斯曼尼亚	7	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
56	state	Northern Territory	北领地	8	2024-06-24 10:23:30.319932	2024-06-24 10:23:30.319932	f
37	investment_entity_type	Superannuation Fund (Individual)	7	7	2023-11-14 18:00:57.156211	2023-11-14 18:00:57.156211	f
57	investment_entity_type	Joint Holding	8	8	2024-08-03 17:59:03.644113	2024-08-03 17:59:03.644113	f
58	investment_entity_type	Family Trust (Individual)	9	9	2024-08-03 17:59:03.644113	2024-08-03 17:59:03.644113	f
59	investment_entity_type	Family Trust (Corporate Trustee)	10	10	2024-08-03 17:59:03.644113	2024-08-03 17:59:03.644113	f
60	investment_entity_type	Superannuation Fund (Corporate Trustee)	11	11	2024-08-03 17:59:03.644113	2024-08-03 17:59:03.644113	f
61	investment_entity_type	Trust (Individual)	12	12	2024-08-03 17:59:03.644113	2024-08-03 17:59:03.644113	f
62	investment_entity_type	Trust (Corporate)	13	13	2024-08-03 17:59:03.644113	2024-08-03 17:59:03.644113	f
5	investment_entity_type	Individual	0	0	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	f
6	investment_entity_type	Company	1	1	2022-11-21 11:18:35.675093	2022-11-21 11:18:35.675093	f
36	investment_entity_type	trust	6	6	2023-11-14 18:00:57.156211	2023-11-14 18:00:57.156211	t
\.


--
-- Data for Name: dividend_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dividend_histories (id, purchased_fund_id, divided_date, amount, currency, created_at, updated_at, del_flag) FROM stdin;
\.


--
-- Data for Name: enquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enquiries (id, name, message, email, created_at, updated_at, phone, interest, suburb, state, del_flag, status, type, fund_id, investor_type, investment_term, investment_amount, guarantor, acn, borrow_type, borrow_purpose, borrow_term, borrow_amount, borrow_date, borrow_primary, borrow_secondary, borrow_tertiary, borrow_additional, broker, intention_file, valuation_file, borrow_file, asic_file, id_file, house_file, invest_file, car_file, loan_file, lease_file, card_file) FROM stdin;
\.


--
-- Data for Name: event_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_client (id, event_id, client_id) FROM stdin;
\.


--
-- Data for Name: event_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_registrations (id, client_id, event_id, participant_number, name, email, created_at, updated_at) FROM stdin;
1	29	1	1	Chang Liu	changfamily608@gmail.com	2022-04-01 12:21:54.187515	2022-04-01 12:21:54.187515
2	37	2	1	Lin Tan	jewel00tl@gmail.com	2022-04-05 13:07:30.506862	2022-04-05 13:07:30.506862
3	\N	2	5	test name 	\N	2022-04-05 15:07:07.366628	2022-04-05 15:07:07.366628
4	\N	2	5	testname	someemail@gmail.com	2022-04-05 15:10:15.585005	2022-04-05 15:10:15.585005
5	\N	2	5	test no auth	hello@gmail.com	2022-04-05 15:24:28.124663	2022-04-05 15:24:28.124663
6	\N	2	5	test no auth		2022-04-05 15:24:36.053074	2022-04-05 15:24:36.053074
7	\N	2	5	test	email@email.com	2022-04-05 15:27:34.970269	2022-04-05 15:27:34.970269
8	72	2	2	Xunao WANG	emma.wang@beavercapital.com.au	2022-04-07 16:18:03.116171	2022-04-07 16:18:03.116171
9	72	2	2	Xunao WANG	emma.wang@beavercapital.com.au	2022-04-07 16:27:51.93861	2022-04-07 16:27:51.93861
10	54	6	12	Yu PEI (Ryan)	ryan@ppta.com.au	2022-05-30 13:57:46.636205	2022-05-30 13:57:46.636205
11	\N	12	1	Harley Liu	harley.liu@bankofchina.com	2022-06-23 12:03:05.514042	2022-06-23 12:03:05.514042
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, title, start_time, city, location, brief_introduction, language, main_img, trans_id, created_at, updated_at, del_flag, status, link, file_url, type) FROM stdin;
138	123	2025-02-06 00:00:00	1	111111111111	\N	1	1897796043262742528.png	\N	2025-03-07 10:46:50.715	2025-03-07 10:46:50.715	f	End	\N	\N	Online
\.


--
-- Data for Name: finance_reference; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_reference (id, level, finance_id, client_id, entity_id, parent_id, created_at, updated_at) FROM stdin;
1	2	7	128	75	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
2	2	11	24	157	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
3	2	7	258	257	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
4	2	7	259	258	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
5	2	7	132	77	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
6	2	14	257	256	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
7	2	8	264	262	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
8	2	8	265	263	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
9	2	7	272	269	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
10	2	17	274	272	0	2023-11-14 18:00:59.083112	2023-11-14 18:00:59.083112
11	2	18	30	72	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
12	2	7	21	136	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
13	2	19	36	142	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
14	2	10	38	143	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
15	2	19	34	140	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
16	2	7	15	88	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
17	2	7	23	137	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
18	2	7	46	145	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
19	2	10	47	146	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
20	2	18	30	138	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
21	2	8	33	43	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
22	2	8	35	141	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
23	2	7	171	89	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
24	2	7	49	158	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
25	2	8	74	169	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
26	2	15	68	171	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
27	2	16	17	201	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
28	2	19	127	205	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
29	2	19	31	105	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
30	2	12	48	135	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
31	2	20	32	139	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
32	2	19	52	148	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
33	2	7	110	82	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
34	2	19	45	144	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
35	2	18	136	79	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
36	2	19	155	70	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
37	2	19	143	80	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
38	2	19	153	71	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
39	2	8	29	50	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
40	2	7	171	90	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
41	2	8	130	73	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
42	2	19	158	1	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
43	2	19	159	2	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
44	2	8	28	83	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
45	2	19	201	129	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
46	2	19	133	78	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
47	2	19	184	125	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
48	2	19	200	128	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
49	2	7	14	42	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
50	2	18	211	100	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
51	2	18	207	92	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
52	2	18	221	103	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
53	2	19	233	114	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
54	2	18	147	81	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
55	2	11	37	159	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
56	2	8	67	163	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
57	2	8	64	164	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
58	2	20	77	165	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
59	2	7	69	166	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
60	2	16	80	173	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
61	2	18	62	174	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
62	2	8	61	175	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
63	2	18	60	176	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
64	2	8	70	177	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
65	2	8	63	179	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
66	2	7	58	180	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
67	2	21	59	181	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
68	2	14	54	182	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
69	2	8	53	183	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
70	2	19	126	190	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
71	2	21	145	191	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
72	2	19	100	192	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
73	2	21	103	193	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
74	2	19	98	194	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
75	2	19	111	196	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
76	2	19	99	198	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
77	2	18	118	199	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
78	2	11	97	200	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
79	2	21	96	202	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
80	2	19	148	203	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
81	2	20	150	204	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
82	2	19	137	207	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
83	2	19	139	208	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
84	2	19	138	209	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
85	2	18	140	210	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
86	2	19	141	211	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
87	2	19	149	213	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
88	2	19	144	214	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
89	2	19	151	215	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
90	2	19	146	216	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
91	2	8	129	217	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
92	2	18	124	218	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
93	2	19	122	219	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
94	2	21	121	220	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
95	2	18	173	222	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
96	2	7	172	223	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
97	2	19	163	224	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
98	2	20	154	225	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
99	2	21	75	227	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
100	2	19	164	228	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
101	2	8	57	231	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
102	2	19	189	234	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
103	2	19	156	236	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
104	2	18	180	238	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
105	2	7	51	243	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
106	2	19	113	244	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
107	2	20	123	245	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
108	2	19	170	246	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
109	2	18	251	250	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
110	2	14	66	260	0	2023-11-14 18:00:59.698362	2023-11-14 18:00:59.698362
111	2	30	329	357	0	2025-03-07 10:44:13.754852	2025-03-07 10:44:13.754852
\.


--
-- Data for Name: financings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.financings (id, client_id, fund_id, financing_amount, commission_rate, commission_amount, currency, created_at, updated_at, referral_agreement, target_amount, target_date, achieve_target, del_flag, gst, entity_id) FROM stdin;
24	177	2	100000.00	0.0050	\N	AUD	2023-02-20 07:31:07.409233	2023-02-20 07:31:07.409233	\N	\N	\N	f	f	\N	\N
25	165	2	500000.00	0.0500	\N	AUD	2023-02-21 07:13:55.758565	2023-02-21 07:13:55.758565	\N	\N	\N	f	f	\N	\N
26	179	2	\N	0.1000	\N	\N	2023-03-02 22:21:26.121	2023-03-03 09:50:28.742	\N	\N	\N	f	t	\N	\N
22	152	2	550500.00	0.0500	\N	AUD	2023-02-07 12:57:32.870341	2023-03-06 12:14:53.59	\N	\N	\N	f	t	\N	\N
27	179	2	\N	0.0100	\N	\N	2023-03-03 14:59:36.824	2023-03-06 13:00:51.858	\N	\N	\N	f	t	\N	\N
18	30	2	1200000.00	0.0050	\N	AUD	2022-05-10 13:38:30.136162	2022-05-10 13:38:30.136162	\N	\N	\N	f	f	\N	72
10	38	2	600000.00	0.0050	\N	AUD	2022-02-07 09:39:23.432917	2022-05-04 15:38:48.049829	\N	\N	\N	f	f	\N	143
15	71	2	\N	0.0100	\N	AUD	2022-03-29 10:43:34.704791	2022-05-04 15:38:14.96275	\N	\N	\N	f	f	\N	154
19	108	2	450000.00	0.0050	\N	AUD	2022-05-30 15:07:31.335421	2022-05-30 15:07:31.335421	\N	\N	\N	f	f	\N	187
16	17	2	100000.00	0.0100	\N	AUD	2022-04-04 13:18:17.84018	2022-05-04 15:37:52.228674	\N	\N	\N	f	f	\N	201
28	231	34	\N	0.0100	\N	\N	2023-06-26 18:04:09.111	2023-06-26 18:04:09.111	\N	\N	\N	f	f	\N	241
12	48	2	200000.00	0.0100	\N	AUD	2022-02-07 09:48:14.492946	2022-05-04 15:38:31.549891	\N	\N	\N	f	f	\N	135
20	32	2	\N	0.0050	\N	AUD	2022-09-27 12:37:55.848346	2022-09-27 12:37:55.848346	\N	\N	\N	f	f	\N	139
8	29	2	18045000.00	0.0050	108.90	AUD	2021-12-23 00:29:45.583528	2022-03-31 08:56:14.552039	\N	\N	\N	f	f	\N	50
7	14	2	4348000.00	0.0100	521.92	AUD	2021-09-30 16:25:27.58728	2023-03-29 11:42:57.087	\N	\N	\N	f	f	\N	42
11	37	2	\N	0.0050	\N	AUD	2022-02-07 09:42:28.129826	2022-05-04 17:41:40.31636	\N	\N	\N	f	f	\N	159
14	54	2	400000.00	0.0050	\N	AUD	2022-03-29 09:41:43.309962	2022-05-04 15:38:22.944363	\N	\N	\N	f	f	\N	182
17	86	2	200000.00	0.0050	\N	AUD	2022-05-04 15:37:00.818018	2022-05-04 15:37:44.74727	\N	\N	\N	f	f	\N	226
21	75	2	\N	0.0050	\N	AUD	2022-09-27 12:47:42.287253	2022-12-29 15:22:31.108261	\N	\N	\N	f	f	\N	227
30	329	159	\N	5.0000	\N		2025-03-07 10:44:13.743	2025-03-07 10:44:13.743	\N	\N	\N	\N	f	t	357
\.


--
-- Data for Name: fund_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund_tag (tag_id, fund_id) FROM stdin;
1	79
1	78
1	77
2	76
\.


--
-- Data for Name: funds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.funds (id, name, description, settlement_date, amount, currency, fund_type, investment_type, product_type, purchase_min_amount, investment_cycle, fix_net_return, float_net_return, application_fee_rate, management_fee_rate, im_file_path, introduce_file_path, eoi_file_path, created_at, updated_at, net_return_a, net_return_b, cash_divided_cycle, performance_fee_rate, investment_strategy, nature_yearly_return, value_yearly_return, subscription_fee_rate, report_file_path, language, trans_id, additional_investment_file, display_order, constitution_file, b_fund_category, b_project_duration_month, b_yearly_return_rate, b_delayed_growth_rate, fully_subscription, fund_status, end_date, sub_im_file_path, application_form, del_flag, interest_starts_date, sub_im_date, deed_date, description_cn, name_cn, fund_type_cn, investment_type_cn, product_type_cn, cash_divided_cycle_cn, currency_cn, investment_cycle_cn, fix_net_return_cn, float_net_return_cn, application_fee_rate_cn, management_fee_rate_cn, net_return_a_cn, net_return_b_cn, performance_fee_rate_cn, investment_strategy_cn, nature_yearly_return_cn, value_yearly_return_cn, subscription_fee_rate_cn, cover, cover_cn, popular, state_id, state_en, state_cn, extend_start_date, default_start_date, application_form_two, application_form_three, application_form_four, cover_two, cover_three, cover_four, cover_cn_two, cover_cn_three, cover_cn_four, company) FROM stdin;
159	11		2025-03-06	\N					10000	\N	\N	\N			\N	\N	\N	2025-03-07 10:33:24.388	2025-03-11 09:45:25.698	\N	\N	\N	\N	\N	\N	\N	\N	\N	1	\N	\N	\N	\N	0	6	0.08	\N	\N	0	2025-03-08	\N	\N	f	2025-03-07	\N	\N						\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1897792661277986816.png		0	50	New South Wales	新南威尔士州	\N	\N	1897792661261209600.png	\N	\N							
\.


--
-- Data for Name: investment_entities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investment_entities (id, client_id, entity_type, kyc_result, entity_name, created_at, updated_at, bsb, account_number, account_name, file_1_front, file_1_back, file_2_front, file_2_back, detail_info, kyc_status, del_flag, transcation_id, ic_id, email_list, address_line, suburb, state, postcode, application_form_signed, is_client, status, withheld_tax, tf_num, application_form_signed_two, application_form_signed_three, application_form_signed_four, application_form_list) FROM stdin;
327	312	0	\N	Ying ZHANG	2024-08-13 10:24:09.591544	2024-08-13 10:24:09.591544	015010	408740918	JIA MENGYANG  ZHANG YING	\N	\N	\N	\N	\N	\N	f	\N	146256	{ying.rosemary@gmail.com}	Unit 9 6 Third Avenue	Everard Park	SA	5035	\N	f	NORMAL	f	493 227 189	\N	\N	\N	\N
274	275	0	\N	Yinghong XING	2023-11-16 16:21:18.49867	2023-11-16 16:21:18.49867	012950	633515	Yinghong Xing	\N	\N	\N	\N	\N	\N	f	\N	146177	{xyh13738066033@aliyun.com}	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	f	NORMAL	t		\N	\N	\N	\N
83	28	13	f	Han Family Investment Pty Ltd ATF Han Trust	2023-03-06 17:11:55.558	2023-08-03 11:07:44.308	063185	11214633	Han Family Investment Pty Ltd ATF Han Trust	\N	\N	\N	\N	\N	\N	f	\N	146034	{boxing.han@hotmail.com}	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	t	NORMAL	f	998624164	\N	\N	\N	{}
279	277	0	\N	Ke XU	2023-12-08 15:17:14.519562	2023-12-08 15:17:14.519562	062692	17418135	Ke XU	\N	\N	\N	\N	\N	\N	f	\N	146220	{superise@gmail.com}	U16, 222-228 SUSSEX ST	SYDNEY	NSW	2000	\N	f	NORMAL	f	802379759	\N	\N	\N	{}
277	171	1	\N	Wei CHEN	2023-12-04 11:15:36.944226	2023-12-04 11:15:36.944226	732080	779563	Wei CHEN	\N	\N	\N	\N	\N	\N	f	\N	146151	{chenw6198@gmail.com}	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	f	NORMAL	f	596426376	\N	\N	\N	{}
256	257	0	\N	Lijun LIU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	112879	204556369	Lijun LIU	\N	\N	\N	\N	\N	\N	f	\N	146201	{505357960a@gmail.com}	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	t	NORMAL	t		\N	\N	\N	\N
273	195	1	\N	BIC PTY LTD	2023-11-15 10:06:09.956345	2023-11-15 10:06:09.956345	111222		12341234	\N	\N	\N	\N	\N	\N	f	\N	11489	{anna.feng@bhgglobal.com.au}	23 Young St	Sydney	NSW	2000	\N	f	NORMAL	f	\N	\N	\N	\N	\N
52	187	0	f	LEI WU	2023-03-03 20:00:08.298	2023-08-02 16:56:48.603	033089	681957	Chang LIU & Lei WU ATF Value Up 1106 Unit Trust	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	680136679	\N	\N	\N	\N
51	187	0	f	CHANG LIU	2023-03-03 20:00:08.298	2023-08-02 16:56:48.603	033089	681957	Chang LIU & Lei WU ATF Value Up 1106 Unit Trust	\N	\N	\N	\N	\N	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	680136679	\N	\N	\N	\N
62	179	\N	f	\N	2023-03-04 23:23:38.987	2023-04-11 13:54:02.599	1	1	1	1631993806007881728.jpeg	1631993806007881729.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	0a458d0d-aedc-4a6c-975e-383ce7066528	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
31	176	4	f	Lofty and Steep Pty Ltd ATF DWW Family Trust	2023-01-13 14:39:03.357096	2023-08-03 16:45:36.845	085458	401089229	Lofty and Steep Pty Ltd ATF DWW Family Trust	\N	\N	\N	\N	{}	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
240	218	1	\N	qqww	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	121212	212121212	212121	\N	\N	\N	\N	\N	\N	f	\N		{qizuo1130@gmail.com}	703/458 forest road,2220	hurstville	NSW	2220	\N	t	NORMAL	\N		\N	\N	\N	\N
32	176	10	f	Lofty and Steep Pty Ltd ATF DWW Family Trust	2023-01-13 14:39:03.359647	2023-08-03 16:45:36.845	085458	401089229	Lofty and Steep Pty Ltd ATF DWW Family Trust	\N	\N	\N	\N	{}	\N	f	\N	146118	{s18610307110@gmail.com}	2A White Avenue	Kensington Gardens	SA	5068	\N	f	NORMAL	f	508097321	\N	\N	\N	{}
338	318	7	\N	William Tomlinson and Gina Tomlinson ATF Tomlinson Superannuation Fund	2024-09-26 14:29:41.34114	2024-09-26 14:29:41.34114	015208\t	483753014	William Mckay Tomlinson And Gina Veronica Tomlinson ATF Tomlinson Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146262	{t.bill@telstra.com}	50 Johnson Rd	One Tree Hill	SA	5114	\N	f	NORMAL	f	880 272 692	\N	\N	\N	\N
347	324	0	\N	test IT	2024-10-16 10:04:22.72586	2024-10-16 10:06:53.998				\N	\N	\N	\N	\N	\N	t	\N	145001	{server@bhgglobal.com.au}	sfw	wdf	feg	0000	\N	f	NORMAL	f		\N	\N	\N	\N
102	131	10	f	Fei Bo Associated Pty Ltd ATF C C Family Trust	2023-04-06 17:27:50.979	2023-08-03 09:59:31.308	063182	11412128	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146164	{fei_bob@yahoo.com.au}	21 Acheron Ave	Camberwell	VIC 	3124	\N	f	NORMAL	f	925658932	\N	\N	\N	{}
353	327	0	\N	25523	2024-11-22 16:21:38.881015	2024-11-22 16:24:01.582				\N	\N	\N	\N	\N	\N	t	\N	42344233232432	{frank.mai@bhgglobal.com.au,blueapple6891@gmail.com}	rewrew	rewr	rweewr	werwer	\N	f	NORMAL	f		\N	\N	\N	{}
297	210	0	\N	Kaer Guan	2024-04-03 17:08:44.908069	2024-04-03 17:08:44.908069	 062948	4034 5761	Kaer Guan	\N	\N	\N	\N	\N	\N	f	\N	146241	{shawnguan1986@gmail.com}	9 Derwent Avenue	North Wahroonga	NSW	2076	\N	f	NORMAL	t		\N	\N	\N	\N
291	285	0	\N	He Yan Fang	2024-03-04 14:08:32.506171	2024-03-04 14:08:32.506171		976643	 He Yan Fang	\N	\N	\N	\N	\N	\N	f	\N	146230	{janishe@aliyun.com}	Room B6-3402, Vanke Opal, Nancun town	Panyu District\t	Guangzhou, China	510006	\N	f	NORMAL	t		\N	\N	\N	\N
337	73	1	\N	Wins College Pty Ltd	2024-09-06 15:57:47.722307	2024-09-06 15:57:47.722307	062018	10531736	WINS COLLEGE PTY LTD 	\N	\N	\N	\N	\N	\N	f	\N	146219	{hans@bhgglobal.com.au,ivoryqian@hotmail.com}	Ground Floor, 187 Thomas Street	HAYMARKET 	NSW 	2000	\N	f	NORMAL	f	576333821	\N	\N	\N	\N
309	289	11	\N	Hou Family Wealth Pty Ltd ATF Hou Family Wealth Superannuation Fund	2024-06-05 10:06:07.681746	2024-06-05 10:06:07.681746		360473354	Yu (Ade) Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146251	{wu0071@gmail.com}	6 Glenroy Ave \t	Beaumont  	SA	5066	\N	f	NORMAL	f	863364054	\N	\N	\N	{}
339	316	13	\N	BHG ONE PTY LTD ATF BHG Debt Income Master Fund (BDIMF)	2024-10-01 09:30:14.112842	2024-10-01 09:30:14.112842				\N	\N	\N	\N	\N	\N	f	\N	146001	{operations@bhgglobal.com.au}	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW	2060	\N	f	NORMAL	f	442188659	\N	\N	\N	\N
133	73	10	f	Wins Republic Pty Ltd ATF Wins Republic Family Trust	2023-07-25 10:23:42.705	2023-08-03 11:09:43.624	082309	764275848	Wins Republic Pty Ltd ATF Wins Republic Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146024	{hans@bhgglobal.com.au,ivoryqian@hotmail.com,ivory@abbeycollege.edu.au}	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	t	NORMAL	f	975358162	\N	\N	\N	{}
101	212	1	f	Rex Investment Consultants Limited	2023-04-05 11:28:02.808	2023-08-02 11:31:50.381	062010	11378093	Rex Investment Consultants Limited	\N	\N	\N	\N	\N	\N	f	\N	146165	{allyuse@gmail.com}	17 Davington Way	Burswood	Auckland, New Zealand	2013	\N	t	NORMAL	t	\N	\N	\N	\N	\N
91	195	0	f	Anna	2023-03-08 11:47:06.763	2023-08-01 10:08:37.525	111222		12341234	\N	\N	\N	\N	\N	\N	f	\N	146999	{anna.feng@bhgglobal.com.au}	25 Norway St	Sydney	NSW	2000	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
108	225	5	f	Yinghong XING	2023-05-15 11:30:07.309	2023-11-16 16:22:50.92	012950	196586284	Yinghong XING	\N	\N	\N	\N	\N	\N	t	\N	146177	{xyh13738066033@aloyun.com}	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng District 	Hangzhou	310006	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
354	327	8	\N	64646	2024-11-22 16:22:38.389113	2024-11-22 16:24:01.582				\N	\N	\N	\N	\N	\N	t	\N	23432432	{frank.mai@bhgglobal.com.au}	436	3466	3634t	grger	\N	f	NORMAL	f		\N	\N	\N	{}
74	125	4	f	Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust	2023-03-06 11:55:11.646	2023-10-06 15:15:42.604	012140	640898787	Parque Edition P/L ATF Parque Edition Investment Trust 	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	535040749	\N	\N	\N	\N
276	276	0	\N	Wenli WANG	2023-11-29 14:40:40.247354	2023-11-29 14:40:40.247354	082231	501912593	Wenli WANG	\N	\N	\N	\N	\N	\N	f	\N	146216	{2023invest.wenma@gmail.com}	40 Berith St	Auburn	NSW 	2144	\N	f	NORMAL	\N	790214022	\N	\N	\N	\N
206	166	6	\N	Juncheng Investment Pty Ltd ATF Juncheng Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013231	161811146	Juncheng Investment Pty Ltd ATF Juncheng Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146215	{zhangsuzhen68@yahoo.com}	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	t	NORMAL	\N	24956431	\N	\N	\N	\N
301	297	0	\N	Xueyan Wang	2024-04-10 14:25:18.476207	2024-04-10 14:25:18.476207	\N	330632422	Xueyan Wang	\N	\N	\N	\N	\N	\N	f	\N	146246	{mollyau2022@gmail.com}	32A Sutton Street	Balwyn North	VIC	3104	\N	f	NORMAL	\N	606266597	\N	\N	\N	\N
280	278	0	\N	Ying CHEN	2023-12-08 16:27:20.717517	2024-06-28 14:45:40.124	\N	814516	ChuanQing ZHAO & Ying CHEN	\N	\N	\N	\N	\N	\N	t	\N	146222	{joezhao@gmail.com}	2A Lochiel Ave \t	Campbelltown \t	SA \t	5074	\N	f	NORMAL	\N	982805993	\N	\N	\N	\N
64	179	\N	f	\N	2023-03-04 23:42:29.355	2023-04-11 13:54:02.599	1	1	1	1631998547144302592.jpeg	1631998547144302593.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	6ac691d0-3100-4184-9c68-4afe42d3409f	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
66	179	\N	f	\N	2023-03-04 23:43:31.693	2023-04-11 13:54:02.599	1	1	1	1631998808579465216.jpeg	1631998808579465217.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	9af008b4-8d7c-4640-8245-1bf3cfef2c0c	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
315	308	0	\N	TEST TEST	2024-07-17 16:58:09.296381	2024-07-17 16:58:53.103	\N			\N	\N	\N	\N	\N	\N	t	\N	test	{server@bhgglobal.com.au}	TEST	TEST	TEST	0000	\N	f	NORMAL	\N		\N	\N	\N	\N
88	15	0	f	Jianxin Liu	2023-03-07 15:53:58.532	2023-07-25 11:02:56.982	082356	784217776	Jianxin Liu	\N	\N	\N	\N	\N	\N	f	\N	146021	{jessieljx@qq.com}	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	t	NORMAL	\N	376276070	\N	\N	\N	\N
326	283	0	\N	Peng LI	2024-08-07 16:06:22.665242	2024-08-07 16:06:22.665242	012344	302689923	LI PENG	\N	\N	\N	\N	\N	\N	f	\N	146255	{fifa588@hotmail.com}	6A ROSLYN AVE	ROSEVILLE	NSW	2069	\N	f	NORMAL	t	\N	\N	\N	\N	\N
328	313	0	\N	DONGYUE XU	2024-08-15 17:33:51.276643	2024-08-15 17:33:51.276643	732719	846510	DONGYUE XU	\N	\N	\N	\N	\N	\N	f	\N	146257	{xdy@addvaldevelopments.com.au}	12-1-1501, Qian Tang Chun Xiao	Binjiang District	Hangzhou	310052	\N	f	NORMAL	t	642 913 574	\N	\N	\N	\N
141	35	0	f	Yu Ping WAN	2023-07-25 10:48:06.314	2023-08-10 15:04:31.096	303432	807708	Yu Ping Wan	\N	\N	\N	\N	\N	\N	f	\N	146041	{wanyp@yahoo.com}	8 Murray Dr	Burwood	VIC	3125	\N	t	NORMAL	f	432153210	\N	\N	\N	{}
96	209	10	f	ANTHONY DONATO HOLDINGS PTY LTD ATF ANTHONY DONATO FAMILY TRUST	2023-03-24 15:29:29.998	2023-08-09 10:19:58.368	105900 	984286640	Donato Enterprises Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146160	{anthony@adarchitects.com.au}	29 Gleeson Cres	 Rostrevor	SA	5073	\N	t	NORMAL	f	71162042	\N	\N	\N	{}
122	241	11	f	BLACK HORSES WEALTH PTY. LTD. ATF WINTER SWEET SUPER FUND	2023-07-14 14:54:31.899	2023-10-04 10:10:51.982	182500	940983950	BLACK HORSES WEALTH PTY. LTD. ATF WINTER SWEET SUPER FUND	\N	\N	\N	\N	\N	\N	f	\N	146191	{mywsz1120@gmail.com}	Unit 18/1 Kensington St	Kogarah	NSW	2217	\N	t	NORMAL	f	594655057	\N	\N	\N	{}
278	119	10	\N	Orient soar Pty Ltd ATF the Zeng Family Trust	2023-12-04 15:58:31.224268	2023-12-04 15:58:31.224268	033172	591661	Orient Soar Pty Ltd ATF The Zeng Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146099	{wensheng.zeng@bigpond.com}	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	f	NORMAL	f	409814062	\N	\N	\N	{}
340	316	13	\N	BHG ONE PTY LTD ATF BHG Rock Debt Income Master Fund (BRDIMF)	2024-10-01 09:31:34.919308	2024-10-01 09:31:34.919308				\N	\N	\N	\N	\N	\N	f	\N	146002	{operations@bhgglobal.com.au}	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW	2060	\N	f	NORMAL	f	219777678	\N	\N	\N	\N
342	316	1	\N	BHG Global Pty Ltd	2024-10-01 09:34:09.78512	2024-10-01 09:34:09.78512	062217	10925808	BHG Global Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146006	{operations@bhgglobal.com.au}	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW	2060	\N	f	NORMAL	f	695458427	\N	\N	\N	\N
76	131	11	f	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	2023-03-06 11:56:40.06	2023-08-03 09:59:31.308	063182	11412128	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146122	{fei_bob@yahoo.com.au}	21 Acheron Ave	Camberwell	VIC	3124	\N	f	NORMAL	f	907985513	\N	\N	\N	{}
341	316	13	\N	BHG ONE PTY LTD ATF BHG UCapital Debt Master Fund (BCUC Direct)	2024-10-01 09:32:34.923565	2024-10-01 09:32:34.923565				\N	\N	\N	\N	\N	\N	f	\N	146005	{operations@bhgglobal.com.au}	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW	2060	\N	f	NORMAL	f	238272213	\N	\N	\N	{}
355	125	13	\N	Moncello Investments Group Pty Ltd ATF Pedra Trust	2024-11-26 18:17:43.120393	2024-11-26 18:17:43.120393	012055	435604858	Moncello Investments Group Pty Ltd ATF Pedra Trust	\N	\N	\N	\N	\N	\N	f	\N	146264	{monika@lamafamilylawyers.com.au}	88 John Road	Cherrybrook	NSW	2126	\N	f	NORMAL	f	584099316	\N	\N	\N	\N
316	309	0	\N	ETST	2024-07-18 14:37:06.42566	2024-07-18 23:39:22.079	\N			\N	\N	\N	\N	\N	\N	t	\N	TEST	{server@bhgglobal.com.au}	na	na	na	0000	\N	f	NORMAL	\N		\N	\N	\N	\N
149	119	0	f	Wensheng ZENG	2023-09-04 14:09:24.246	2023-09-08 10:17:55.519	033172	591661	Orient Soar Pty Ltd ATF The Zeng Family Trust	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	409814062	\N	\N	\N	\N
34	152	0	f		2023-02-16 16:38:15.006058	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
329	306	1	\N	Athena Capital Invesment Pty Ltd	2024-08-21 14:55:46.425384	2024-08-21 14:55:46.425384	062692	80964294	ATHENA CAPITALINVESMENT	\N	\N	\N	\N	\N	\N	f	\N	146254	{weinaxu81@gmail.com}	N/A	N/A	NSW	N/A	\N	f	NORMAL	f		\N	\N	\N	\N
310	32	9	\N	Lei Wu And Yiping Cao ATF Value Up 0508 Unit Trust	2024-06-11 16:33:21.708774	2024-06-11 16:33:21.708774	193879\t	206405118	VALUE UP 0508 UNIT TRUST	\N	\N	\N	\N	\N	\N	f	\N	146252	{wulei_1@hotmail.com}	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	f	NORMAL	f		\N	\N	\N	{}
82	110	11	f	Wenyan Wu Pty Ltd ATF Wu Superannuation Fund	2023-03-06 12:16:04.521	2023-08-03 15:48:46.645	062443	11162665	Wenyan Wu Pty Ltd ATF Wu Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146083	{cindyyan73@gmail.com}	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	t	NORMAL	f	905375889	\N	\N	\N	{}
343	319	0	\N	Adam & Nadine Macbeth	2024-10-08 10:56:19.325148	2024-10-08 10:56:19.325148	012417	350631179	MACBETH ADAM DAVID and MACBETH NADINE DIANNE	\N	\N	\N	\N	\N	\N	f	\N	146213	{adndmacbeth@gmail.com}	6 Armidale Cres	Castle Hill	NSW	2154	\N	f	NORMAL	f	Adam: 181673099 / Nadine: 190077224	\N	\N	\N	\N
348	323	0	\N	Zheng LIU	2024-10-23 10:13:19.274105	2024-10-23 10:13:19.274105	063019	11732623	Zheng LIU	\N	\N	\N	\N	\N	\N	f	\N	146263	{LZ849038566@gmail.com}	12 William St	Boxhill	VIC	3128	\N	f	NORMAL	f	557059977	\N	\N	\N	\N
356	328	0	\N	Junjun ZHANG	2024-12-03 09:59:26.111256	2024-12-03 09:59:26.111256	013326	403924048	ZHANG JUNJUN	\N	\N	\N	\N	\N	\N	f	\N	146267	{jenny_zhangyongqin@163.com}	3504/466 Tianbao Road	Hongkou	Shanghai	200086	\N	f	NORMAL	\N		\N	\N	\N	\N
317	309	1	\N	test com	2024-07-18 23:38:19.916018	2024-07-18 23:39:22.079	\N			\N	\N	\N	\N	\N	\N	t	\N	146000	{server@bhgglobal.com.au}	test	tttt	NSW	0000	\N	f	NORMAL	\N		\N	\N	\N	\N
65	179	\N	f	\N	2023-03-04 23:43:28.93	2023-04-11 13:54:02.599	1	1	1	1631998796990603264.jpeg	1631998796990603265.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	56f27b6d-47b6-4858-98b1-4e0ef31d9b8c	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
210	140	0	\N	Yan LIU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	733385	866734	Yan LIU	\N	\N	\N	\N	\N	\N	f	\N	146145	{happyliu5200@gmail.com}	23 Hampstead Cres	Glen Waverley	VIC 	3150	\N	t	NORMAL	f	457168192	\N	\N	\N	{}
72	30	4	f	Evergreen SUN Pty Ltd ATF Evergreen Spring TRUST	2023-03-06 11:50:48.183	2023-08-02 16:55:22.693	033-089	623802	EVERGREEN SUN PTY LTD	\N	\N	\N	\N	\N	\N	t	\N	146035	{gxsyj1970@163.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	569452875	\N	\N	\N	\N
150	41	\N	\N	Nick Yang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701			admin@example.com	\N	\N	\N	\N	\N	\N	f	\N	000099	{nick.yang@tmgm.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
134	19	0	f	Li WANG\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t	2023-07-25 10:24:47.476	2023-07-25 10:24:47.476	732-062	580550	Li Wang	\N	\N	\N	\N	\N	\N	f	\N	146025	{linawang218@hotmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
105	31	10	f	Oasisun Management Pty Ltd ATF Sean Family Trust	2023-05-08 10:12:53.505	2023-08-03 14:22:57.956	033172	914168	Oasisun Management Pty Ltd ATF Sean Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146037	{cizhang2017@foxmail.com}	235 Kooyong Road	Elsternwick	VIC	3185	\N	t	NORMAL	f	506062413	\N	\N	\N	{}
151	25	\N	\N	Bowen Zheng	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	146031	{leo.zhengbowen@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
191	145	\N	\N	Yicong GUO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063121	10945374	Yicong GUO	\N	\N	\N	\N	\N	\N	f	\N	146132	{13301014134@163.com}	3 GLADWYN AVENUE	BENTLEIGH EAST	VIC 	3165	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
41	152	0	f	\N	2023-02-27 09:33:44.133214	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
161	87	0	\N	Emma	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{emma_wangwang@hotmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
49	185	0	f	Tiechuan HU	2023-03-03 19:15:27.968	2023-07-24 14:04:05.898	065005	10472770	Sailing Overseas Project Management Group Pty Ltd	\N	\N	\N	\N	\N	\N	t	\N	146153	{sailingoverseasgroup@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	970160347	\N	\N	\N	\N
162	89	1	\N	ella	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{emma@fxplus.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
167	88	\N	\N	Shanshan	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	146074	{kevin1668@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
169	74	\N	\N	Zining Guo	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	193879	421753115	Zining GUO	\N	\N	\N	\N	\N	\N	f	\N	146069	{znguo@hotmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
171	68	\N	\N	Xiaoping CAO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	012260	303634748	Xiaoping CAO	\N	\N	\N	\N	\N	\N	f	\N	146066	{landyxhl1210@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
172	65	\N	\N	Yaping Li	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	015025	528730466	The trustee for Shengli Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146062	{yaping.li@fxplus.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
208	139	\N	\N	Guige PIAO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063182	11426474	Guige PIAO	\N	\N	\N	\N	\N	\N	f	\N	146142	{pgg100@163.com}	7 Corunna Court	Glen Waverley 	VIC 	3150	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
298	32	0	\N	Zhen WU	2024-04-08 13:58:46.046039	2024-04-08 13:58:46.046039		11270858	Sunrise Development (AU) Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146244	{wulei_1@hotmail.com}	6 Woodlands Ave 	Camberwell	VIC	3124	\N	f	NORMAL	t		\N	\N	\N	\N
207	137	0	\N	HUIXIA GAO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083266	773855617	Huixia GAO	\N	\N	\N	\N	\N	\N	f	\N	146104	{sandygaohx@hotmail.com}	f 1 Pascall St.	Mount Waverley	VIC	3149	\N	t	NORMAL	f	977233296	\N	\N	\N	{}
136	21	1	f	Aussie Essence International PTY LTD	2023-07-25 10:28:01.87	2023-08-03 16:43:49.692	032-090	134868	Aussie Essence International PTY LTD	\N	\N	\N	\N	\N	\N	f	\N	146028	{invincibleandy@hotmail.com}	83/209 Harris St	Pyrmont	NSW	2009	\N	t	NORMAL	f	465479447	\N	\N	\N	{}
275	166	0	\N	Suzhen ZHANG	2023-11-24 13:54:50.286586	2023-11-24 13:54:50.286586	343005	349964439	Suzhen ZHANG	\N	\N	\N	\N	\N	\N	f	\N	146107	{zhangsuzhen68@yahoo.com}	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	f	NORMAL	f	638998640	\N	\N	\N	{}
281	132	11	\N	Evertree Hw Pty Ltd ATF Evertree Family Super Fund	2023-12-11 12:20:30.387613	2023-12-11 12:20:30.387613	065005	10836706	Evertree Family Super Fund	\N	\N	\N	\N	\N	\N	f	\N	146173	{wangyangying2@gmail.com,charlie@mainning.com.cn}	17 Holmwood Ave	Brighton	VIC	3186	\N	f	NORMAL	f	698411276	\N	\N	\N	{}
213	149	\N	\N	Haowen Xue	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	733065	722790	Haowen Xue	\N	\N	\N	\N	\N	\N	f	\N	146144	{mr.xue1658@gmail.com}	2 BRIMAR CT.	MOUNT WAVERLY 	VIC 	3149	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
160	78	1	\N	Beaver Capital	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701				\N	\N	\N	\N	\N	\N	f	\N	144000	{operations@beavercapital.com.au}	beaver	beaver	NSW	2060	\N	t	NORMAL	f	\N	\N	\N	\N	{}
344	320	0	\N	Alex Gambotto	2024-10-08 11:09:07.832278	2024-10-08 11:09:07.832278	182222	305576225	Gamblor Property Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146218	{agambotto@themissinglink.com.au}	9 Dickson Ave	Artarmon	NSW	2064	\N	f	NORMAL	f	699564079	\N	\N	\N	\N
190	126	0	\N	Zhiyuan FENG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063 -019	1157 7571 	Zhiyuan FENG 	\N	\N	\N	\N	\N	\N	f	\N	146092	{fengzywilla@gmail.com}	19B Arlington Drive 	Glen Waverley	VIC	3150	\N	t	NORMAL	f	502718879	\N	\N	\N	{}
217	129	0	\N	Mingshan YANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013148	647466653	Mingshan YANG	\N	\N	\N	\N	\N	\N	f	\N	146095	{yms2022424@gmail.com}	48 Balladonia Rd 	Rowville 	VIC 	3178	\N	t	NORMAL	f	609690077	\N	\N	\N	{}
211	141	0	\N	Mei YANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013255	210600629	Mei YANG 	\N	\N	\N	\N	\N	\N	f	\N	146133	{meiyang8@hotmail.com}	808/50 Haig St,	Southbank	VIC 	3006	\N	t	NORMAL	f	845539930	\N	\N	\N	{}
212	142	0	\N	Yue Chan LUO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013405	281169071	Yue Chan LUO	\N	\N	\N	\N	\N	\N	f	\N	146134	{beckyfive@gmail.com}	355 Dandelion Dr.	Rowville	VIC 	3178	\N	t	NORMAL	f	394583843	\N	\N	\N	{}
183	53	0	\N	Yang WU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083004	534625451	Yang Wu	\N	\N	\N	\N	\N	\N	f	\N	146052	{wuyang900627@gmail.com}	1 Balgowlah Avenue	 Keysborough 	VIC	3173	\N	t	NORMAL	f	492853757	\N	\N	\N	{}
349	325	0	\N	Genmei HUANG	2024-10-28 14:18:10.900697	2024-10-28 14:18:10.900697	182182	020482295	GENMEI HUANG	\N	\N	\N	\N	\N	\N	f	\N	146265	{genmeihuang@gmail.com}	18/1 Kensington St	Kogarah	NSW	2210	\N	f	NORMAL	f	970375446	\N	\N	\N	\N
300	296	0	\N	Yueting Hou	2024-04-08 14:46:11.352353	2024-04-08 14:46:11.352353	015025	461426928	Yueting Hou	\N	\N	\N	\N	\N	\N	f	\N	146245	{houyuetingellen@gmail.com}	Unit 25 7 Liberman Close	Adelaide	SA	5000	\N	f	NORMAL	f	595610020	\N	\N	\N	{}
220	121	0	\N	Yanmei YU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063019	12029139	Yanmei YU	\N	\N	\N	\N	\N	\N	f	\N	146089	{phoenixyanmei218@gmail.com}	Unit 107, 5 Claire St	McKinnon	VIC	3127	\N	t	NORMAL	f	573 226 536	\N	\N	\N	{}
216	146	0	\N	Chiu Ying TSUI 	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	343003	347689439	Tsui Chiu Ying	\N	\N	\N	\N	\N	\N	f	\N	146101	{tinatsui605@gmail.com}	22 Barbara Cres	Avondale Heights	VIC	3034	\N	t	NORMAL	f	406123477	\N	\N	\N	{}
184	91	0	\N	Jennie	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{dingzijin93@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
33	152	0	f		2023-02-16 15:46:59.661469	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
67	179	\N	f	\N	2023-03-04 23:44:28.604	2023-04-11 13:54:02.599	1	1	1	1631999047281500160.jpeg	1631999047281500161.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	dcc2160f-b306-467c-83d4-385a8075dc00	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
68	179	\N	f	\N	2023-03-04 23:47:21.781	2023-04-11 13:54:02.599	1	1	1	1631999773638483968.jpeg	1631999773638483969.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	c0b8dc54-98c3-4e16-a6ee-f5fbdd2b88f1	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
69	179	\N	f	\N	2023-03-04 23:53:51.398	2023-04-11 13:54:02.599	1	1	1	1632001407810625536.jpeg	1632001407810625537.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	eb0ad730-1866-463e-b60b-5c708e3c2e39	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
357	329	0	\N	333	2025-03-07 10:42:23.262775	2025-03-07 10:42:23.262775				\N	\N	\N	\N	\N	\N	f	\N	11	{111@gmail.com,111@gmail.com}	UNIT 1003 152 CITY RD	Darlington	NSW	2016	\N	f	NORMAL	\N		\N	\N	\N	\N
95	179	\N	f	\N	2023-03-24 11:25:45.223	2023-04-11 13:54:02.599	1	1	1	1639060898859270144.png	1639060898859270145.png	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	adea2ab0-6703-4675-a961-c8900e13fae5	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
302	298	6	\N	Nanhui Investment Pty Ltd ATF Nanhui Investment Trust	2024-04-10 15:57:07.785004	2024-04-10 15:57:07.785004	\N	Nanhui Investment Pty Ltd ATF Nanhui Investment Trust	467234265	\N	\N	\N	\N	\N	\N	f	\N	146168	{zhangqing231@gmail.com}	10 Chilcote Court	Box Hill South	VIC	3128	\N	f	NORMAL	\N	499732737	\N	\N	\N	\N
303	36	6	\N	Shell Family Pty Ltd ATF Shell Family Trust	2024-04-11 10:21:35.38875	2024-04-11 10:21:35.38875	\N	11687388	Chang Qin	\N	\N	\N	\N	\N	\N	f	\N	146247	{380817544@qq.com}	42A Paxton Street	Malvern East	VIC	3145	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
185	92	4	\N	emma	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{farnelly@sina.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
186	93	0	\N	Jian zhao	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{kevin121668@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
187	108	\N	\N	Value Up	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701				\N	\N	\N	\N	\N	\N	f	\N		{valueup88@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
188	117	\N	\N	LL & Associates Pty Ltd	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	302-162 	0625743	LL & Associates Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N		{lc@viptax.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
189	120	0	\N	Jennie	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{jennie.ding@andeconsulting.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
201	17	\N	\N	Ausgreen Investment Consultation Pty Ltd - Zixuan Guo	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062256	11182306	Ausgreen Investment Consultation Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146032	{brianguo8283@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
330	315	0	\N	Weijia CHEN	2024-08-29 09:43:15.855937	2024-08-29 09:43:15.855937	062184	11300229	Weijia Chen	\N	\N	\N	\N	\N	\N	f	\N	146259	{chenweijia1992@hotmail.com}	70A Pymble Ave	Pymble	NSW	2073	\N	f	NORMAL	f	415 057 474	\N	\N	\N	\N
318	310	0	\N	Xiaoyu ZHU	2024-07-19 12:18:21.998848	2024-07-19 12:18:21.998848	065005	10908239	Xiaoyu ZHU	\N	\N	\N	\N	\N	\N	f	\N	146253	{hong2024@myyahoo.com}	T20-C HUTANG XINCUNNANDU	CHANGZHOU	JIANGSU	000000	\N	f	NORMAL	t		\N	\N	\N	\N
235	182	1	\N	LJSD 2020 Pty Ltd	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	035-016	036067	LJSD 2020 Pty Ltd 	\N	\N	\N	\N	\N	\N	f	\N	146149	{zhan0142@gmail.com}	6 Bethune Ave	Glenunga	SA	5064	\N	t	NORMAL	f	638823942	\N	\N	\N	{}
142	36	0	f	Chang QIN	2023-07-25 10:49:20.238	2023-07-25 10:49:20.238	063-109	11687388	Chang Qin	\N	\N	\N	\N	\N	\N	f	\N	146042	{380817544@qq.com}	42A Paxton Street	Malvern East	VIC	3145	\N	t	NORMAL	f	774852750	\N	\N	\N	{}
209	138	10	\N	M&H Management Pty Ltd ATF Mo & Huang Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083153	763182527	M&H Management Pty Ltd ATF Mo & Huang Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146102	{13906264851@163.com}	29A Parkers Rd.	Parkdale	VIC	3195	\N	t	NORMAL	f	429579005	\N	\N	\N	{}
231	57	0	\N	Aiping HUANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083251	783354998	AIPING HUANG	\N	\N	\N	\N	\N	\N	f	\N	146065	{qiantai1953@163.com}	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	t	NORMAL	f	346436102	\N	\N	\N	{}
218	124	11	\N	Evergreen Forest Pty Ltd ATF Evergreen Super Fund	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	182512	966346744	Evergreen Forest Pty Ltd ATF Evergreen Super Fund	\N	\N	\N	\N	\N	\N	f	\N	146119	{gaoxiang64@163.com}	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	t	NORMAL	f	503729613	\N	\N	\N	{}
233	183	0	\N	Jianqun LIAO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	733178	677586	Jianqun Liao	\N	\N	\N	\N	\N	\N	f	\N	146150	{1871485362@qq.com}	1 Larne Avenue   	Donvale	VIC	3111	\N	t	NORMAL	f	972791455	\N	\N	\N	{}
219	122	11	\N	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063109	13440282	Titanium Titan Pry Ltd ATF Qin Self Managed Super Fund	\N	\N	\N	\N	\N	\N	f	\N	146090	{273342287@qq.com}	235 Kooyong Road	Elsternwick	VIC	3185	\N	t	NORMAL	f	443875720	\N	\N	\N	{}
282	279	0	\N	Tian QIN	2023-12-12 17:31:31.244175	2023-12-12 17:31:31.244175	013160	197120638	TIAN QIN	\N	\N	\N	\N	\N	\N	f	\N	146221	{luciusqin@foxmail.com}	2406/33 Mackenzie street	Melbourne 	VIC 	3000	\N	f	NORMAL	f	231643607	\N	\N	\N	{}
345	321	0	\N	Kenneth George COADY	2024-10-08 16:38:14.864934	2024-10-08 16:38:14.864934	112879	486871614	Kenneth George COADY	\N	\N	\N	\N	\N	\N	f	\N	146214	{kdcoady@outlook.com}	Unit 55/50 Kenthurst Rd	Dural	NSW	2158	\N	f	NORMAL	f	256421644	\N	\N	\N	\N
215	151	0	\N	Meifang Zhang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	343007	087034090	Meifang Zhang	\N	\N	\N	\N	\N	\N	f	\N	146136	{ellahuang166@gmail.com}	14 Bond Street	Mount Waverley	VIC	3149	\N	t	NORMAL	t	\N	\N	\N	\N	{}
236	156	0	\N	Kaidi LIU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083323	273270057	Kaidi LIU	\N	\N	\N	\N	\N	\N	f	\N	146128	{davidkaidiliu@gmail.com}	1 Pascall Street	Mount Waverley	VIC	3149	\N	t	NORMAL	f	459071818	\N	\N	\N	{}
350	326	11	\N	Bowwood Road Pty Ltd ATF Bowwood Road Superannuation Fund	2024-10-31 15:03:21.350737	2024-10-31 15:03:21.350737	082055	566334173	Bowwood Road Pty Ltd ATF Bowwood Road Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146260	{neville@katzproperty.com.au}	19 Kenneth St	Tamarama	NSW	2026	\N	f	NORMAL	f	765620235	\N	\N	\N	\N
214	144	0	\N	Meifang JI	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013326	401488684	Meifang JI	\N	\N	\N	\N	\N	\N	f	\N	146126	{1013631994@qq.com}	5 Winbourne Road	Mount Waverley	VIC	3149	\N	t	NORMAL	f	428189166	\N	\N	\N	{}
331	314	0	\N	Bing SUN	2024-08-29 11:14:22.664241	2024-08-29 11:14:22.664241	732028	591395	Bing Sun	\N	\N	\N	\N	\N	\N	f	\N	146258	{sajbin8053@gmail.com}	G81 37 Rothschild Ave	Rosebery	NSW	2018	\N	f	NORMAL	f	888 606 130	\N	\N	\N	\N
244	113	7	\N	Yanchao YANG, Ruiqing YANG and Li XU ATF JRYX Superfund	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013-141	1134-79687	Yanchao YANG, Ruiqing YANG and Li XU ATF JRYX Superfund	\N	\N	\N	\N	\N	\N	f	\N	146086	{shellyxuli77@gmail.com}	38 Dalgetty Road	Beaumaris	VIC	3193	\N	t	NORMAL	f	609282406	\N	\N	\N	{}
232	202	\N	\N	AUSA Migration & Education Service P/L 	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	012071	498249822	AUSA Migration & Education Service P/L 	\N	\N	\N	\N	\N	\N	f	\N		{jk@ausamigration.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
239	204	\N	\N	BHG South Australia Pty Ltd 	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	082309	335133024	Beaver South Australia Pty Ltd 	\N	\N	\N	\N	\N	\N	f	\N		{Shanshan871201@hotmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
319	311	0	\N	Tran Nha My CHAU	2024-07-19 16:14:36.138944	2024-07-19 16:14:36.138944		11548347	Thi Thu Hang TRAN	\N	\N	\N	\N	\N	\N	f	\N	146229	{nhamy062004@gmail.com}	28 Griffiths Street	Sans Souci	NSW	2219	\N	f	NORMAL	f		\N	\N	\N	{}
143	38	0	f	Xue HAN	2023-07-25 10:51:14.016	2023-07-25 10:51:14.016	732-135	833169	Christina Han	\N	\N	\N	\N	\N	\N	f	\N	146044	{xuefhan@hotmail.com}	45A Woonona Ave	Wahroonga	NSW	2076	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
222	173	0	\N	Bai ENAGA	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013-381	404035592	Bai ENAGA	\N	\N	\N	\N	\N	\N	f	\N	146115	{dorise917@hotmail.com}	97 Holmes Street	Brunswick	VIC	3056	\N	t	NORMAL	t	\N	\N	\N	\N	{}
246	170	11	\N	South Star Australia Group Pty Ltd atf Chen Superannuation Fund	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	067000	10568801	South Star Australia Group Pty Ltd atf Chen Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146146	{malinda.zhu@gmail.com}	261 High St Rd 	Mount Waverley 	VIC 	3149	\N	t	NORMAL	f	877945457	\N	\N	\N	{}
146	47	0	f	Yufeng LU & Bingdi LI	2023-07-25 10:54:25.874	2023-07-25 10:54:25.874	733-073	847788	Yufeng Lu& Bingdi Li	\N	\N	\N	\N	\N	\N	f	\N	146047	{libingdi@163.com}	64 Catherine St	ST IVES	NSW	2075	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
241	231	6	\N	Frank_test Individual	2023-11-14 18:00:57.957701	2024-05-07 15:17:55.13	033330	2121212	Frank Test	\N	\N	\N	\N	\N	\N	t	\N	99999999999	{frank.mai@bhgglobal.com.au,blueapple6891@gmail.com}	fake1	fake1	fake1	fake1	\N	t	NORMAL	\N		\N	\N	\N	\N
251	253	\N	\N		2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701				\N	\N	\N	\N	\N	\N	f	\N		{test@gmail.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N		\N	\N	\N	\N
257	258	\N	\N	XI CHEN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	732028	694095	Xi CHEN	\N	\N	\N	\N	\N	\N	f	\N	146147	{nathancx86@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	376843834	\N	\N	\N	\N
237	72	\N	\N	Xunao Wang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062-217	10912089	Harmony & LOVE Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146026	{emma.wang@beavercapital.com.au}	3 LEO ROAD	PENNANT HILL	NSW 	2120	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
242	248	\N	\N	UCaptial International Pty Ltd As Trustee of UCapital Unit Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	032173	533063	UCAPITAL INTERNATIONAL PTY LTD ATF UCAPITAL UNIT TRUST	\N	\N	\N	\N	\N	\N	f	\N	146196	{jp@ucapital.com.au}	Level 26, 44 Market Street	SYDNEY 	NSW 	2000	\N	t	NORMAL	\N	348888762	\N	\N	\N	\N
247	243	\N	\N	test account	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	123456	12345678	test	\N	\N	\N	\N	\N	\N	f	\N	9899999999	{jerry.zhang@bhgglobal.com.au}	rwqe	rq	rq	rqew	\N	t	NORMAL	\N		\N	\N	\N	\N
26	152	0	f		2022-11-02 21:37:51.506938	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
137	23	10	f	Nathan Management PL ATF Ultimate Family Trust	2023-07-25 10:29:36.296	2023-09-05 10:04:53.918	032-282	437804	Nathan Management PL ATF Ultimate Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146029	{natebizau@gmail.com}	Unit 602, 19 Shoreline Drive	Rhodes	NSW 	2138	\N	t	NORMAL	f	597708479	\N	\N	\N	{}
140	34	0	f	Chunnian DING	2023-07-25 10:46:40.65	2023-07-25 10:46:40.65	733-173	644056	Chunnian Ding	\N	\N	\N	\N	\N	\N	f	\N	146040	{chunnianding@gmail.com}	7/82-86 Atherton Road	Oakleigh	VIC	3166	\N	t	NORMAL	f	369032627	\N	\N	\N	{}
145	46	10	f	Xiaoyin Pty Ltd ATF Xiaoyin Family Trust	2023-07-25 10:53:25.33	2023-08-02 11:46:26.987	062-475	10338006	XIAOYIN FAMILY TRUST	\N	\N	\N	\N	\N	\N	f	\N	146046	{zhou.yinhui@gmail.com}	1009/ 7 Rider Boulevard	Rhodes	NSW	2138	\N	t	NORMAL	f	575098665	\N	\N	\N	{}
243	51	7	\N	Ling Huang and Yajun Liu ATF ARVOR Superannuation Fund	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	012406	228286324	ARVOR Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146051	{christinemelbar@gmail.com}	155 Connells Point Road	 Connells Point	NSW 	2221	\N	t	NORMAL	f	457163914	\N	\N	\N	{}
262	264	0	\N	Ci ZHANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013225	456888298	Ci ZHANG	\N	\N	\N	\N	\N	\N	f	\N	146205	{cococheung008@gmail.com}	235 Kooyong Road\t	Elsternwic	VIC	3185	\N	t	NORMAL	f	958143876	\N	\N	\N	{}
245	123	10	\N	Qianxi Investment Pty Ltd ATF Wang Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083028	442078614	Qianxi Investment Pty Ltd ATF Wang Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146091	{steven.qiwang@gmail.com}	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	t	NORMAL	f	220238587	\N	\N	\N	{}
223	172	0	\N	Bo LI	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013-265	310125255	Bo LI	\N	\N	\N	\N	\N	\N	f	\N	146116	{foreverbeautiful8@gmail.com}	139/120 Sturt St	Southbank	VIC	3006	\N	t	NORMAL	f	886158768	\N	\N	\N	{}
351	316	13	\N	BHG Rock Debt Income Pool Fund (BRDIPF)	2024-11-12 14:21:17.46223	2024-11-12 14:21:17.46223				\N	\N	\N	\N	\N	\N	f	\N	145002	{operations@bhgglobal.com.au}	Suite 1001B, 53 Walker Street	North Sydney	NSW	2060	\N	f	NORMAL	f		\N	\N	\N	{}
352	316	13	\N	BHG UCapital Master Fund	2024-11-12 14:23:21.664717	2024-11-12 14:23:21.664717				\N	\N	\N	\N	\N	\N	f	\N	145005	{operations@bhgglobal.com.au}	Suite 1001B, 53 Walker Street	North Sydney	NSW	2060	\N	f	NORMAL	f		\N	\N	\N	\N
272	274	1	\N	ACY Holding Pty Ltd	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	105074\t	061780040	ACY HOLDING PTY LTD	\N	\N	\N	\N	\N	\N	f	\N	146209	{kdaconstructiongroup@gmail.com}	76A TRIMMER PDE\t	SEATON\t	SA\t	5023	\N	t	NORMAL	f	529045190	\N	\N	\N	{}
320	304	7	\N	Entity for Test	2024-07-22 11:15:17.316026	2024-07-22 11:15:17.316026	123456	123456678	guess	\N	\N	\N	\N	\N	\N	f	\N	145000	{exceptionalismee@gmail.com,hzsnq@qq.com}	guess	Sub	SAT	0000	1821370252076720128.png	f	NORMAL	f	67545e3	1821370252076720129.png	1820075367017205761.png	1820075367017205762.png	{https://beaver-bucket.oss-ap-southeast-2.aliyuncs.com/uploads/re_investment/file/1_1/1831293735155224576.png}
332	316	13	\N	BHG ONE PTY LTD ATF Debt Income Opportunities Fund (BCDIOF)	2024-08-29 12:17:20.998743	2024-08-29 12:17:20.998743	082057	705817758	PCT BCDIOF APPLICATION ACC	\N	\N	\N	\N	\N	\N	f	\N	146000	{operations@bhgglobal.com.au}	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	f	NORMAL	f	698 562 351	\N	\N	\N	\N
165	77	0	\N	Xian LI	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	733173	682028	Xian Li	\N	\N	\N	\N	\N	\N	f	\N	146072	{xianli612@yahoo.com.au}	42 Lewton Rd.	Mount Waverley	VIC 	3149	\N	t	NORMAL	f	859124624	\N	\N	\N	{}
346	322	0	\N	Ruizhen WANG	2024-10-08 18:52:40.921272	2024-10-08 18:52:40.921272	062010\t	11115023	Ruizhen WANG	\N	\N	\N	\N	\N	\N	f	\N	146261	{wangyazhe1030@hotmail.com}	Building 15, Room 503	Xuchang City	Henan Province, China	450000	\N	f	NORMAL	t		\N	\N	\N	{}
289	255	1	\N	WINS COLLEGE PTY LTD	2024-02-01 13:59:16.550188	2024-02-01 13:59:16.550188		10531736	WINS COLLEGE PTY LTD 	\N	\N	\N	\N	\N	\N	f	\N	146219	{ivoryqian@hotmail.com}	Ground Floor, 187 Thomas Street	HAYMARKET	NSW	2000	\N	f	NORMAL	f	576333821	\N	\N	\N	{}
306	301	0	\N	Yutong ZHANG	2024-05-10 15:27:09.672408	2024-05-10 15:27:09.672408	734216	644254	Sun Xiaojing	\N	\N	\N	\N	\N	\N	f	\N	146170	{1119029136@qq.com}	5 SHIELDS CT	BLACKBURN SOUTH	VIC	3130 	\N	f	NORMAL	f	678156266	\N	\N	\N	{}
39	152	0	f	\N	2023-02-24 09:00:17.38247	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
313	187	6	\N	Chang LIU & Lei WU ATF Value Up 1106 Unit Trust 	2024-07-02 11:33:08.112171	2024-07-02 11:33:08.112171	\N	681957	Chang LIU & Lei WU ATF Value Up 1106 Unit Trust	\N	\N	\N	\N	\N	\N	f	\N	146105	{Valueup88@gmail.com}	 10B El Nido Grove	Carnegie	VIC	3163	\N	f	NORMAL	\N	680136679	\N	\N	\N	\N
103	221	0	f	Yutong ZHANG	2023-04-28 15:52:01.961	2024-05-10 15:32:05.034	733173	644254	Sun Xiaoiing	\N	\N	\N	\N	\N	\N	t	\N	146170	{yzha0750@student.monash.edu,1119029136@qq.com}	5 SHIELDS CT	BLACKBURN SOUTH	VIC	3130 	\N	t	NORMAL	\N	678 156 266	\N	\N	\N	\N
314	306	1	\N	Verna	2024-07-02 15:06:05.013807	2024-07-02 15:06:05.013807	\N	80964294	ATHENA CAPITALINVESMENT	\N	\N	\N	\N	\N	\N	f	\N	000001	{weinaxu81@gmail.com}	N/A	N/A	NSW	N/A	\N	f	NORMAL	\N		\N	\N	\N	\N
89	171	0	f	Wei CHEN	2023-03-07 16:48:14.342	2023-03-07 16:48:56.761	182-512	970466371	ONE REED PTY LTD ATF ONE REED SUPER FUND	\N	\N	\N	\N	\N	\N	t	\N	146117	{chenw6198@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
174	62	\N	\N	Yanchao SHU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063-109	11657760	Yanchao SHU	\N	\N	\N	\N	\N	\N	f	\N	146058	{pwy20081222@163.com}	5 Rookwood Street	Balwyn North	VIC	3104	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
175	61	\N	\N	Zhengrong HUANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	033-084	526085	Xinyue Investment Group 	\N	\N	\N	\N	\N	\N	f	\N	146057	{mikehuang166@gmail.com}	3 Wendyn Avenue	Keysborough	VIC	3173	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
178	56	\N	\N	Gang LIU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013271	283165576	Gang Liu	\N	\N	\N	\N	\N	\N	f	\N	146059	{lgliugangfff@gmail.com}	26 Urban Drive	Williams Landing	VIC	3027	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
40	152	0	f	\N	2023-02-24 12:05:02.415822	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
180	58	\N	\N	Dong XIA	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	082001	776937917	Norman RAY	\N	\N	\N	\N	\N	\N	f	\N	146054	{dongxia1968@gmail.com}	28 Woodbury Road	St Ives 	NSW 	2075	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
181	59	\N	\N	Denghua WU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063-106	10794876	QI Property PL ATF Q1 Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146055	{denghuawu@yahoo.com}	L1/ 21 Shierlaw Avenue	Canterbury 	VIC	3126	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
182	54	\N	\N	Yu PEI (Ryan)	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	082356	359670721	LYNK Tech Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146053	{ryan@ppta.com.au}	111 MILL ST	CARLTON	NSW	2218	\N	t	NORMAL	\N		\N	\N	\N	\N
286	256	7	\N	Wins Super Pty Ltd ATF Wins Superfund	2023-12-18 14:52:34.223288	2023-12-18 14:52:34.223288	\N	734429324	Zongnan HAN	\N	\N	\N	\N	\N	\N	f	\N	146226	{ivory@abbeycollege.edu.au}	 6 Greenwich Road	Greenwich	NSW	2065	\N	f	NORMAL	\N		\N	\N	\N	\N
196	111	2	\N	Zhengrong HUANG (SMSF)	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	033 084	526106	Zhengrong Yongjuan Pty Ltd ATF Zhengrong Yongjuan Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146084	{taoyongjuan@gmail.com}	3 Wendyn Avenue	Keysborough	VIC	3173	\N	t	NORMAL	f	680136679	\N	\N	\N	\N
333	170	11	\N	South Star Australia Group Pty Ltd AS TRUSTEES FOR THE CHEN ZHU FAMILY TRUST	2024-08-29 14:45:12.529482	2024-08-29 14:45:12.529482	063151	10596630	South Star Australia Group Pty Ltd AS TRUSTEES FOR THE CHEN ZHU FAMILY TRUST	\N	\N	\N	\N	\N	\N	f	\N	146148	{malinda.zhu@gmail.com}	261 High St Rd 	Mount Waverley	VIC	3149	\N	f	NORMAL	f	363580202	\N	\N	\N	\N
43	33	11	f	Calm & Harmony Pty Ltd ATF Forever Young Superfund	2023-03-03 14:43:05.825	2023-07-25 10:45:25.322	063-154	10791817	Calm & Harmony Pty Ltd Trustee For Forever Young Superfund	\N	\N	\N	\N	\N	\N	f	\N	146039	{lanwatts3@gmail.com}	27B Toolambool Road	Carnegie	VIC	3163	\N	t	NORMAL	f	974371890	\N	\N	\N	{}
197	112	10	\N	SY Family Holding Pty Ltd ATF Song Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	082 356	318429931	SY Family Holding Pty Ltd ATF Song Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146085	{tuotuomarina@gmail.com}	2a King Edward Street\t	Roseville	NSW 	2069	\N	t	NORMAL	f	606681587	\N	\N	\N	{}
173	80	10	\N	IOK SP Holdings Pty Ltd ATF IOK SP Holdings Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062759	10586365	IOK SP Holdings Pty Ltd ATF IOK SP Holdings Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146073	{lmkgeorge@gmail.com}	Unit 2, 12 Lucas Road	 Burwood	NSW	2134	\N	t	NORMAL	f	465191449	\N	\N	\N	{}
179	63	0	\N	Zongquan YU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	033385	608172	Zhongquan YU	\N	\N	\N	\N	\N	\N	f	\N	146060	{zongquan1936@gmail.com}	Suite 407, Blk 18, Jianjin Street	Jiangyang City	Jiangsu Province	China	\N	t	NORMAL	t	\N	\N	\N	\N	{}
177	70	0	\N	Liping TAN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063182	11353113	Liping TAN	\N	\N	\N	\N	\N	\N	f	\N	146068	{732672012@qq.com}	1/72 Willow Avenue	Glen Waverley	VIC	3150	\N	t	NORMAL	f	987244906	\N	\N	\N	{}
334	233	9	\N	Chiu Ying Tsui And Yiwenlin ATF Tinaewen Family Trust	2024-08-29 14:48:39.592672	2024-08-29 14:48:39.592672	063142	10595366	Chiu Ying Tsui And Yiwenlin ATF Tinaewen Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146240	{auewenlin@gmail.com}	898 Burke Rd	Canterbury 	VIC	3126	\N	f	NORMAL	f		\N	\N	\N	\N
203	148	0	\N	Jingyuan HUANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	303432	0807708	Jingyuan HUANG	\N	\N	\N	\N	\N	\N	f	\N	146127	{1213776047@qq.com}	8 Murray Dr	Burwood 	VIC	3125	\N	t	NORMAL	f	446449560	\N	\N	\N	{}
199	118	0	\N	Shengling HU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063109	13224336	Shengling HU	\N	\N	\N	\N	\N	\N	f	\N	146087	{caobinger@163.com}	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	t	NORMAL	t	\N	\N	\N	\N	\N
200	97	\N	\N	Setall Family Pty Ltd ATF Setall Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062-759	10598390	Setall Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146096	{55858058@qq.com}	1203/3 Haran Street	Mascot	NSW 	2020	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
152	26	\N	\N	Dermott Lynch	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	146033	{dermottl@eastsuper.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
154	71	\N	\N	FX Plus	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062113	10155235	FX Plus	\N	\N	\N	\N	\N	\N	f	\N		{info@fujia.co}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
155	90	0	\N	emma	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	\N	\N	{emmaw@eastsuper.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
204	150	13	\N	QFH PTY LTD ATF QFH TRUST	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063113	11274533	QFH PTY LTD ATF QFH TRUST	\N	\N	\N	\N	\N	\N	f	\N	146103	{kmbonnie06264@gmail.com}	57 ATHELSTAN RD.	CAMBERWELL	VIC	3124	\N	t	NORMAL	f	803084742	\N	\N	\N	{}
198	99	1	\N	Vathey Investment Pty Ltd	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063109	13376428	Vathey Investment Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146077	{liang84926@hotmail.com}	10 Dane St.	Box Hill North	VIC	3129	\N	t	NORMAL	f	636069101	\N	\N	\N	{}
157	24	\N	\N	Junguo Wang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701				\N	\N	\N	\N	\N	\N	f	\N	146030	{jason.wang@aufci.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
158	49	\N	\N	Jason XU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701				\N	\N	\N	\N	\N	\N	f	\N	146049	{jason.xu@boanco.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
311	304	0	\N	TEST ENTITY	2024-06-14 15:00:36.801971	2024-06-14 15:00:36.801971	123123	00000000	TEST	\N	\N	\N	\N	\N	\N	f	\N	000001	{exceptionalismee@gmail.com,it@bhgglobal.com.au}	TEST	NSW	TEST	0000	1820360139308257280.png	f	NORMAL	f	000000000	\N	\N	\N	\N
335	304	1	\N	test company	2024-09-03 14:35:49.175279	2024-09-03 14:35:49.175279	000000	123456	test000	\N	\N	\N	\N	\N	\N	f	\N	146999	{exceptionalismee@gmail.com}	lalala	lala	VIC	2111	\N	f	NORMAL	f	123456789	\N	\N	\N	\N
293	287	0	\N	Xiaoxian WANG 	2024-03-08 11:49:01.935566	2024-03-08 11:49:01.935566	193879	472534941 	Xiaoxian WANG 	\N	\N	\N	\N	\N	\N	f	\N	146235	{meiomasa66@gmail.com}	16 Elwood St	Brighton	VIC	3186	\N	f	NORMAL	t		\N	\N	\N	{}
221	167	0	\N	Ming LIU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	735016	10715728	Ming LIU	\N	\N	\N	\N	\N	\N	f	\N	146109	{liuming050328@gmail.com}	11 Parsons Street	Oaklands Park	SA	5046	\N	t	NORMAL	t		\N	\N	\N	\N
292	286	0	\N	Company_TEST	2024-03-06 11:06:07.050894	2024-05-10 14:43:24.727	\N			\N	\N	\N	\N	\N	\N	t	\N	000000	{exceptionalismee@gmail.com,it@bhgglobal.com.au,exceptionalismeee@gmail.com}	Company_TEST	TEST	TEST	0000	\N	f	NORMAL	\N		\N	\N	\N	\N
336	304	0	\N	testnew0824172477	2024-09-04 09:57:22.788577	2024-09-04 09:57:22.788577	10000000	100000000	test	\N	\N	\N	\N	\N	\N	f	\N	11111	{exceptionalismee@gmail.com,hzsnq11@qq.com}	test	test	test	2009900	\N	f	NORMAL	f	123456789	\N	\N	\N	{123}
230	168	0	\N	Yingda Xu	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062948	32397799	Yingda Xu	\N	\N	\N	\N	\N	\N	f	\N	146110	{congcong1120@outlook.com}	21 Acheron Avenue	Camberwell	VIC	3124	\N	t	NORMAL	t	\N	\N	\N	\N	\N
238	180	0	\N	Jingwen CUI	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	633000	717630	JINGWEN CUI	\N	\N	\N	\N	\N	\N	f	\N	146113	{jacob.si@outlook.com}	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	t	NORMAL	t		\N	\N	\N	\N
229	174	0	\N	Zhimin HU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063000	13318194	Zhimin HU	\N	\N	\N	\N	\N	\N	f	\N	146114	{jin_217@163.com}	198 Pennant Hills Road	Oatlands	NSW	2117	\N	t	NORMAL	t	\N	\N	\N	\N	\N
304	299	1	\N	Addval Investment Management Pty Ltd	2024-04-12 10:43:48.826932	2024-04-12 10:43:48.826932	\N	567134	Addval Investment Management Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146248	{bing@addvaldevelopments.com.au}	18 Astrolabe Street	RED HILL	ACT	2603	\N	f	NORMAL	\N	528 732 886	\N	\N	\N	\N
227	75	\N	\N	Mckesson Pty Ltd ATF Lucky Guo Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063109	13340337	Maggie GUO	\N	\N	\N	\N	\N	\N	f	\N	146070	{luckyguo666@gmail.com}	3 Gladwyn Avenue	Bentleigh East	VIC	3165	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
224	163	0	\N	Hong MENG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	732028 	745585 	Hong MENG	\N	\N	\N	\N	\N	\N	f	\N	146108	{1728157225@qq.com}	8-10  Fairthorne  Street	Keysborough	VIC	3173	\N	t	NORMAL	f	389053848	\N	\N	\N	{}
226	86	0	\N	Shanshan ZHOU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	105029	090350740	Shanshan ZHOU	\N	\N	\N	\N	\N	\N	f	\N	146074	{shanshan871201@hotmail.com}	62 Wright St.	Paradise	SA	5075	\N	t	NORMAL	f	898680137	\N	\N	\N	{}
228	164	0	\N	Boyang ZHENG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	343005	341201439	 Boyang ZHENG 	\N	\N	\N	\N	\N	\N	f	\N	146131	{zhby2005@icloud.com}	47 Winfield Road	Balwyn North	VIC	3104	\N	t	NORMAL	f	442346841	\N	\N	\N	{}
225	154	0	\N	Haojie Wang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	303438	0216604	HAOJIE WANG	\N	\N	\N	\N	\N	\N	f	\N	146137	{shinewanghaojie@gmail.com}	3 SMYTHE AVENUE 	MONT ALBERT	VIC 	3127	\N	t	NORMAL	f	406281338	\N	\N	\N	{}
268	271	6	\N	Lei WU and Chang LIU ATF ValueUp 1018 Unit Trust 	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	193879\t	463416299	Chang LIU & Lei WU ATF Value Up 1018 Unit Trust\t	\N	\N	\N	\N	\N	\N	f	\N	146210	{valueup1018@outlook.com}	 10B El Nido Grove	Carnegie\t	VIC\t	3163	\N	t	NORMAL	\N		\N	\N	\N	\N
271	273	0	\N	Yan Wang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063225\t	10551939	Yan Wang	\N	\N	\N	\N	\N	\N	f	\N	146212	{sophia20210917@gmail.com}	6 Bernborough Ave  \t	Balwyn \t	VIC \t	3103	\N	t	NORMAL	\N	646225379	\N	\N	\N	\N
269	272	0	\N	Xiangjiang Wang	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	670864	23642794	Xiangjiang Wang	\N	\N	\N	\N	\N	\N	f	\N	146211	{xiangjiangw@gmail.com}	Unit 18/1 Kensington St\t	Kogarah\t	NSW\t	2217	\N	t	NORMAL	\N	967879513	\N	\N	\N	\N
299	295	0	\N	Miao ZHU	2024-04-08 14:35:47.396333	2024-04-08 14:35:47.396333	\N	410373512	Miao ZHU	\N	\N	\N	\N	\N	\N	f	\N	146243	{melina66@qq.com}	6 Dight Avenue	Balwyn North	VIC	3104	\N	f	NORMAL	\N	493930633	\N	\N	\N	\N
248	247	1	\N	First Capital Finance Group Pty Ltd	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	112879	433330697	First Capital Finance Group Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146194	{Andrew@ffccommercial.com.au}	6.11/55 Miller Street	Pyrmont	NSW	2009	\N	t	NORMAL	\N		\N	\N	\N	\N
259	262	0	\N	Dongmei HE	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	112-879	460019538	Dongmei HE	\N	\N	\N	\N	\N	\N	f	\N	146202	{Helen.hedm@gmail.com}	15 Edison St	Belmore	NSW	2192	\N	t	NORMAL	\N	641970191	\N	\N	\N	\N
135	48	0	f	Yang LI	2023-07-25 10:26:52.303	2023-07-25 10:26:52.303	980-205	900172140	Yang Li	\N	\N	\N	\N	\N	\N	f	\N	146027	{lisunshine2008@126.com}	16 GOTTENHAM ST.	GLEBE	NSW	2037	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
144	45	0	f	Yanchao YANG	2023-07-25 10:52:33.714	2023-07-25 10:52:33.714	083-019	471967971	Yanchao Yang	\N	\N	\N	\N	\N	\N	f	\N	146045	{jerryyanchao77@gmail.com}	38 Dalgetty Road	Beaumaris	VIC 	3193	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
267	270	\N	\N		2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701				\N	\N	\N	\N	\N	\N	f	\N		{it@bhgglobal.com.au}	\N	\N	\N	\N	\N	t	NORMAL	\N		\N	\N	\N	\N
255	256	0	\N	Zongnan HAN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	082465	734429324	Zongnan HAN	\N	\N	\N	\N	\N	\N	f	\N	146195	{ivory@abbeycollege.edu.au,ivoryqian@hotmail.com,""}	 6 Greenwich Road\t	Greenwich 	NSW	2065	\N	t	NORMAL	t		\N	\N	\N	\N
254	255	0	\N	Yufeng MA	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	082465\t	10531736	WINS COLLEGE PTY LTD 	\N	\N	\N	\N	\N	\N	f	\N	146200	{ivoryqian@hotmail.com}	 6 Greenwich Road\t	Greenwich 	NSW\t	2065	\N	t	NORMAL	t		\N	\N	\N	\N
250	251	0	\N	Ziping SI	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701		717606	Ziping SI	\N	\N	\N	\N	\N	\N	f	\N	146193	{szpty@vip.sina.com}	Unit 2, Level Building 4, 38 South Taoyuan Road	Lianhu \t	Xi'an	710000	\N	t	NORMAL	t		\N	\N	\N	\N
258	259	7	\N	Duplicated	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	065005\t		Duplicated	\N	\N	\N	\N	\N	\N	f	\N	Duplicated	{charlie@mainning.com.cn}	17 Holmwood Ave	Brighton	VIC	3186	\N	t	NORMAL	f		\N	\N	\N	\N
261	263	0	\N	Thi Thu Hang TRAN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062010	1154 8347	Thi Thu Hang TRAN	\N	\N	\N	\N	\N	\N	f	\N	146204	{Thuhang2091979@gmail.com}	L6, C1 / 90 Nguyen Binh Khiem Street	Rach Gia City 	Kien Giang, Vietnam	920000 	\N	t	NORMAL	t		\N	\N	\N	\N
312	305	0	\N	Ying CHEN	2024-06-28 14:42:21.519442	2024-06-28 14:42:21.519442	735016	814516	ChuanQing ZHAO & Ying CHEN	\N	\N	\N	\N	\N	\N	f	\N	146222	{joezhao123@gmail.com}	2A Lochiel Ave	Campbelltown	SA	5074	\N	f	NORMAL	f	982805993	\N	\N	\N	\N
305	300	0	\N	Rui CAO	2024-04-17 10:28:54.964084	2024-04-17 10:28:54.964084		399790445	Rui CAO	\N	\N	\N	\N	\N	\N	f	\N	146238	{199022701@QQ.com}	U501a, 250 Liverpool Rd	Ashfield	NSW	2131	\N	f	NORMAL	t		\N	\N	\N	\N
139	32	1	f	Sunrise Development (AU) Pty Ltd	2023-07-25 10:44:03.46	2023-08-02 17:07:02.636	063-113	11270858	Sunrise Development (AU) Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146038	{wulei_1@hotmail.com}	6 Woodlands Avenue	Camberwell	VIC	3124	\N	t	NORMAL	f	379415200	\N	\N	\N	{}
50	29	9	f	Chang Liu ATF Chang Family Trust	2023-03-03 19:48:35.236	2023-07-25 10:39:49.514	733-040	694500	CHANG LIU ATF CHANG FAMILY TRUST	\N	\N	\N	\N	\N	\N	f	\N	146036	{changfamily608@gmail.com}	10B El Nido Grove 	Carnegie	VIC	3163	\N	t	NORMAL	f	454985882	\N	\N	\N	{}
29	162	1	f	WZH Pty Ltd	2022-11-09 13:08:10.687819	2023-08-02 17:32:53.448	082-309	385517907	WZH Pty Ltd	\N	\N	\N	\N	{}	\N	f	\N	146106	{1823547847@qq.com}	 10B El Nido Grove	Carnegie	VIC	3163	\N	t	NORMAL	f	638998640	\N	\N	\N	{}
148	52	0	f	Ling YUAN	2023-07-25 11:00:38.6	2023-07-25 11:00:38.6	083-343 	187071326	Ling YUAN	\N	\N	\N	\N	\N	\N	f	\N	146050	{ling.abid@gmail.com}	55 Salisbury Rd.	Ashwood	VIC	3147	\N	t	NORMAL	f	355849933	\N	\N	\N	{}
260	66	13	\N	Gold Phoenix Holding Pty Ltd ATF Jing Hui Feng Liang Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	112879	416697737	Gold Phoenix Holding Pry Ltd ATF Jing Hui Feng Liang Trust	\N	\N	\N	\N	\N	\N	f	\N	146063	{hlgs3030@outlook.com}	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	t	NORMAL	f	466624861	\N	\N	\N	{}
90	171	11	f	ONE REED PTY LTD ATF ONE REED SUPER FUND	2023-03-07 16:48:14.342	2023-08-03 16:36:47.438	182512	970466371	ONE REED PTY LTD ATF ONE REED SUPER FUND	\N	\N	\N	\N	\N	\N	f	\N	146117	{chenw6198@gmail.com}	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	t	NORMAL	f	608626888	\N	\N	\N	{}
77	132	12	f	Yangying Wang ATF HW Investment Trust	2023-03-06 12:03:38.49	2023-08-16 11:16:55.247	065005	10797452	Yangying Wang ATF HW Investment Trust	\N	\N	\N	\N	\N	\N	f	\N	146123	{wangyangying2@gmail.com}	13 West Terrace	Kensington Gardens	SA	5068	\N	t	NORMAL	f	556307077	\N	\N	\N	{}
253	254	10	\N	MICHAEL & PING PTY LTD ATF MICHAEL & PING FAMILY TRUST	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063182	11574856	MICHAEL & PING PTY LTD ATF MICHAEL & PING FAMILY TRUST	\N	\N	\N	\N	\N	\N	f	\N	146198	{MICHAELWANG1@HOTMAIL.COM,CAOYIPING05@GMAIL.COM}	5 Rubens Court\t	Wheelers Hill	VIC	3150	\N	t	NORMAL	f	636666088	\N	\N	\N	{}
70	155	1	f	DT Analytics Pty Ltd	2023-03-06 11:33:48.507	2023-08-16 14:55:28.576	083004	250506303	DT Analytics Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146141	{alexhu777@hotmail.com}	PO Box 571	Glen Waverley	VIC	3150	\N	t	NORMAL	f	539093125	\N	\N	\N	{}
79	136	10	f	BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust	2023-03-06 12:05:31.514	2023-08-03 14:19:49.25	033173	104917	BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146135	{1633040554@qq.com}	2/21 Albury Road	Balwyn North	VIC	3104	\N	t	NORMAL	f	468580408	\N	\N	\N	{}
71	153	12	f	Chuwen Lu ATF Bitquantum Investment Trust	2023-03-06 11:34:51.848	2023-08-03 16:12:38.292	033127	468576	Chuwen Lu ATF Bitquantum Investment Trust	\N	\N	\N	\N	\N	\N	f	\N	146125	{jessleelovelife124@gmail.com}	85 Nurlendi Rd.	Vermont	VIC	3133	\N	t	NORMAL	f	507764537	\N	\N	\N	{}
80	143	10	f	AF. Homey Pty Ltd ATF AF.Family Trust	2023-03-06 12:12:06.04	2023-08-03 14:21:29.254	033172	882522	AF. Homey Pty Ltd ATF AF.Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146138	{xizewrichard@gmail.com}	Unit 3,13 Graham Place	Hill Box	VIC	3128	\N	t	NORMAL	f	774713177	\N	\N	\N	{}
295	289	1	\N	Yu (Ade) Pty Ltd	2024-03-15 14:23:27.37971	2024-03-15 14:23:27.37971	085458	360473354	Yu (Ade) Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146237	{wu0071@gmail.com}	6 Glenroy Ave	Beaumont	SA	5066	\N	f	NORMAL	f	863364054	\N	\N	\N	{}
73	130	4	f	Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust	2023-03-06 11:52:21.329	2023-08-03 09:52:25.731	083004	759658262	Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146121	{auzchn_pl@yahoo.com}	3 Gianluca Ave	Keysborough	VIC	3173	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
84	190	1	f	World Tour Australia Pty Ltd	2023-03-07 14:35:50.721	2023-08-03 10:14:16.714	062217	10948321	 World tour Australia Pty Ltd 	\N	\N	\N	\N	\N	\N	f	\N	146158	{worldtourau@gmail.com}	Suite 302, 53 Walker St	North Sydney 	NSW 	2060	\N	t	NORMAL	\N	685568081	\N	\N	\N	\N
86	192	0	f	Yi-Han TENG	2023-03-07 14:41:12.63	2023-07-24 14:13:48.09	012071	391839793	Yi-Han TENG	\N	\N	\N	\N	\N	\N	f	\N	146154	{q22135948@gmail.com}	22 Loftus Street	Ashfield	NSW 	2131	\N	t	NORMAL	\N	965428129	\N	\N	\N	\N
129	201	0	f	Wenhui WU	2023-07-24 14:42:36.908	2023-07-24 14:42:36.908	013225	382065781	Wenhui WU	\N	\N	\N	\N	\N	\N	f	\N	146162	{weniie333333@gmail.com}	2 Woods St	Balwyn	VIC	3103	\N	t	NORMAL	\N	357467536	\N	\N	\N	\N
87	193	0	f	Yaoqin Wu 	2023-03-07 14:44:00.156	2023-07-24 14:18:47.452	980205	900159375	Yaoqin Wu 	\N	\N	\N	\N	\N	\N	f	\N	146155	{zekunchen@msn.cn}	16 Joly Parade	Hunters Hill	NSW	2110	\N	t	NORMAL	\N	415584514	\N	\N	\N	\N
48	181	0	f	Zhaolun DING	2023-03-03 18:54:15.649	2023-03-17 15:28:11.005	035002	443446	Auriga International Group Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146100	{gin@urbaninvestment.com.au}	UNIT 1507 , 68 ELIZABETH STREET	ADELAIDE	SA	5000	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
125	184	0	f	Keya LONG	2023-07-24 14:15:13.884	2023-07-24 14:15:13.884	063019	11601703	Keya LONG	\N	\N	\N	\N	\N	\N	f	\N	146152	{ivyrickyll@gmail.com}	2/385 Blackburn Rd	Mount Waverley	VIC	3149	\N	t	NORMAL	\N	556824155	\N	\N	\N	\N
85	191	0	f	Haibin XI	2023-03-07 14:38:04.852	2023-07-24 14:27:39.082	944600	001641293	 Haibin XI 	\N	\N	\N	\N	\N	\N	f	\N	146157	{kenkiwi@gmail.com}	2B Wandella Ave	Roseville 	NSW 	2069	\N	t	NORMAL	\N	495549684	\N	\N	\N	\N
128	200	0	f	Ling SONG	2023-07-24 14:40:01.708	2023-07-24 14:40:01.708	013225	268047934	LING SONG	\N	\N	\N	\N	\N	\N	f	\N	146161	{celinesfinance@gmail.com}	94 Sanctuary Lakes South Blvd	Point Cook	VIC	3030	\N	t	NORMAL	\N	347869323	\N	\N	\N	\N
107	203	1	f	Worldlink Group pty Ltd	2023-05-15 11:22:19.605	2023-08-03 16:04:25.246	062104	10270068	Worldlink Group	\N	\N	\N	\N	\N	\N	f	\N	146176	{Max.xi@worldlinkgroup.com.au}	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	t	NORMAL	\N	455341043	\N	\N	\N	\N
131	224	0	f	Siqi WANG	2023-07-24 15:02:23.564	2023-08-01 17:25:27.834	342096	398581412	Siqing WONG	\N	\N	\N	\N	\N	\N	f	\N	146174	{kennywong163@163.com}	4 Hornbuckle CT.	Ferntree Gully	VIC\t	3156	\N	t	NORMAL	\N	365974721	\N	\N	\N	\N
132	232	0	f	Changxing LIU 	2023-07-24 15:46:33.128	2023-07-24 15:46:33.128	733089	11377172	Changxing LIU	\N	\N	\N	\N	\N	\N	f	\N	146184	{Billsmowing72@gmail.com}	5 Palm Beach Dr 	Patterson Lakes	VIC	3197	\N	t	NORMAL	\N	873325676	\N	\N	\N	\N
110	227	4	f	ZHOUS' CAPITAL Pty Ltd ATF ZHOUS' CAPITAL Superannuation Fund	2023-05-29 10:01:03.009	2023-08-02 11:48:11.977	065000	12580832	ZHOUS' CAPITAL Pty Ltd ATF ZHOUS' CAPITAL Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146179	{sheng.1122@hotmail.com}	90 Commodore Drive	Surfers Paradise	QLD	4217	\N	t	NORMAL	\N	598237780	\N	\N	\N	\N
115	234	1	f	YELLOW RIBBON CLH AUSTRALIA PTY LTD	2023-07-11 15:27:19.058	2023-07-24 15:49:35.983	033380	637628	YELLOW RIBBON CLH AUSTRALIA PTY LTD	\N	\N	\N	\N	\N	\N	f	\N	146185	{tracyaumel8456@163.com}	31 Kirribilli Ave 	Keysborough 	VIC 	3173	\N	t	NORMAL	\N	988089872	\N	\N	\N	\N
99	210	1	f	TX International Pty Ltd	2023-04-05 09:43:21.234	2023-07-24 14:49:52.219	012245	220641352	TX International Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146166	{shawnguan1986@gmail.com}	3 Dalwood Pl	Carlingford	NSW	2118	\N	t	NORMAL	\N	971202729	\N	\N	\N	\N
104	222	0	f	Lihua TU	2023-05-04 14:18:04.54	2023-07-24 15:00:04.685	013225	388021974	Lihua TU	\N	\N	\N	\N	\N	\N	f	\N	146171	{zhuoylu@gmail.com}	62A FITZWILLIAM ST	KEW	VIC	3101	\N	t	NORMAL	\N	965428417	\N	\N	\N	\N
130	220	0	f	Qidi WU	2023-07-24 14:54:26.36	2023-07-24 14:54:26.36	062000	13488953	Qidi WU	\N	\N	\N	\N	\N	\N	f	\N	146169	{bleach_bobby@hotmail.com}	58 Shaftesbury Rd	Burwood	NSW	2134	\N	t	NORMAL	\N	436 001 774	\N	\N	\N	\N
109	226	0	f	WANG LUI	2023-05-25 11:43:04.747	2023-07-24 15:21:57.878	732090	652486	WANG LUI	\N	\N	\N	\N	\N	\N	f	\N	146178	{wlui28@163.com}	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	t	NORMAL	\N	353811944	\N	\N	\N	\N
116	235	0	f	Xianfeng HUANG	2023-07-11 15:53:31.81	2023-07-24 15:50:52.925	063109	13330075	Xianfeng HUANG	\N	\N	\N	\N	\N	\N	f	\N	146186	{huangxf1275@gmail.com}	55 Gordon St	Balwyn 	VIC 	3103	\N	t	NORMAL	\N	643156592	\N	\N	\N	\N
106	223	1	f	AG SANTORINI PTY LTD	2023-05-08 10:52:30.386	2023-07-24 16:27:33.818	062161	10868313	AG SANTORINI PTY LTD	\N	\N	\N	\N	\N	\N	f	\N	146172	{aliceice25@hotmail.com}	SUITE 404 16 SHORELINE DRIVE 	RHODES	NSW	2138	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
127	208	0	f	Hiu Hung WONG	2023-07-24 14:31:13.692	2023-07-24 14:31:13.692	062759	10486276	HIU HUNG WONG	\N	\N	\N	\N	\N	\N	f	\N	146159	{venuswong8838@yahoo.com}	1201/339 Sussex St	Sydney 	NSW 	2000	\N	t	NORMAL	t	\N	\N	\N	\N	\N
124	185	1	f	Sailing Overseas Project Management Group Pty Ltd	2023-07-24 14:14:16.678	2023-07-24 14:14:16.678	065005	10472770	Sailing Overseas Project Management Group Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146153	{sailingoverseasgroup@gmail.com}	42 Edward Street	Magill	SA	5072	\N	t	NORMAL	\N	970160347	\N	\N	\N	\N
126	186	0	f	Jianxin HUANG	2023-07-24 14:20:08.806	2023-07-24 14:20:08.806	012266	463291262	HUANG jianxin	\N	\N	\N	\N	\N	\N	f	\N	146156	{jeansingxh@gmail.com}	11/77 Warrane Rd	North Willoughby  	NSW 	2068	\N	t	NORMAL	\N	356013989	\N	\N	\N	\N
30	169	13	f	CASA A Pty Ltd ATF CASA 1 Unit Trust 	2022-12-13 14:00:34.378642	2023-08-03 16:36:02.634	082001	526004524	CASA A Pty Ltd ATF CASA 1 Unit Trust 	\N	\N	\N	\N	{}	\N	f	\N	146111	{traceyli@hopefluent.com.au}	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	t	NORMAL	f	444519359	\N	\N	\N	{}
42	14	10	t	Prosperity 2020 PL ATF Genesis Family Trust	2023-03-03 14:27:08.118	2023-08-03 13:41:55.63	062-799	13076828	Daxia Ge	\N	\N	\N	\N	\N	\N	f	\N	146022	{jeffrey.liu@hippowealth.com.au}	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	t	NORMAL	f	647097592	\N	\N	\N	{}
112	229	1	f	Twyco Invest Pty Ltd	2023-06-13 15:13:33.212	2023-08-03 16:48:10.717	015025\t	333059617	Twyco Invest Pty Ltd	\N	\N	\N	\N	\N	\N	f	\N	146181	{Max@soonta.com.au}	1/221 Henley Beach Rd	Torrensville	SA 	5031	\N	t	NORMAL	f	684996879	\N	\N	\N	{}
285	282	0	\N	Sulan Wu	2023-12-15 18:20:14.53054	2023-12-15 18:20:14.53054	193879	205602451	Sulan Wu	\N	\N	\N	\N	\N	\N	f	\N	146223	{wusulan2023@outlook.com}	6 Woodlands Avenue	Camberwell	VIC 	3124	\N	f	NORMAL	t		\N	\N	\N	{}
92	207	0	f	Min LIANG	2023-03-20 17:08:03.946	2023-07-24 14:44:08.23	013606	194605314	 Min LIANG 	\N	\N	\N	\N	\N	\N	f	\N	146163	{1737303587@qq.com}	10 Boston Road	Balwyn	VIC	3103	\N	t	NORMAL	t	\N	\N	\N	\N	{}
78	133	11	f	Chen246 Pty Ltd ATF Chen246 Superannuation Fund	2023-03-06 12:04:37.46	2023-08-03 15:50:18.721	034069	459720	Chen246 Pty Ltd ATF Chen246 Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146124	{anxiangau@qq.com}	6 Casuarina Court 	Capalaba 	QLD 	4157	\N	t	NORMAL	f	608723263	\N	\N	\N	{}
2	159	12	f	Rui PAN ATF The Pan's Trust 	2022-09-21 13:50:54.787778	2023-08-03 14:38:02.531	033135	569166	Rui PAN ATF The Pan's Trust 	\N	\N	\N	\N	{}	\N	f	\N	146129	{tw0210@yahoo.com}	41 Fraser St.	Glen Waverley	VIC	3150	\N	t	NORMAL	f	455034478	\N	\N	\N	{}
120	239	0	f	David Anthony BERRY and Joyce Ann BERRY	2023-07-13 15:41:04.831	2023-07-24 15:43:06.272	732349	706624	David Anthony BERRY and Joyce Ann BERRY	\N	\N	\N	\N	\N	\N	f	\N	146182	{david.berry@iinet.net.au}	155 Bradley Street	Glenmore Park	NSW 	2745	\N	t	NORMAL	\N	157077620 / 265994971	\N	\N	\N	\N
117	236	0	f	XIANG LIANG	2023-07-12 09:40:56.189	2023-07-24 15:52:41.607	733165	736815	XIANG LIANG	\N	\N	\N	\N	\N	\N	f	\N	146187	{ch_christinahan@hotmail.com}	3 GILMORE RD	DONCASTER	VIC\t	3108	\N	t	NORMAL	\N	498577890	\N	\N	\N	\N
121	240	0	f	Jing Yuan	2023-07-14 11:33:45.022	2023-07-24 16:16:36.079	062009	10976850	Jing Yuan	\N	\N	\N	\N	\N	\N	f	\N	146189	{jing@kwllawyers.com.au}	17 Mulvihill Cres 	Denham Court 	NSW 	2565	\N	t	NORMAL	\N	176334998	\N	\N	\N	\N
296	294	0	\N	Xiaofeng Zhang	2024-04-03 16:52:56.525244	2024-04-03 16:52:56.525244	\N	092569040	Xiaofeng Zhang	\N	\N	\N	\N	\N	\N	f	\N	146242	{px348090@gmail.com}	20 Mahar Street	Kensington Gardens	SA	5068	\N	f	NORMAL	\N	518025562	\N	\N	\N	\N
111	228	0	f	Qiao ZHANG	2023-06-08 11:33:24.504	2023-07-24 15:27:02.956	735016	838315	Qiao ZHANG	\N	\N	\N	\N	\N	\N	f	\N	146180	{qiao-zhang1941@outlook.com}	36A Birkinshaw Ave.	Tranmere	SA	5073	\N	t	NORMAL	\N	571576583	\N	\N	\N	\N
100	211	0	f	LIHUA JIANG 	2023-04-05 10:26:46.508	2023-07-24 14:58:08.682	013128	416609098	JIANG LIHUA	\N	\N	\N	\N	\N	\N	f	\N	146167	{lihuajiang789@gmail.com}	3/226 Belmore Road	Balwyn	VIC	3103	\N	t	NORMAL	\N	505747881	\N	\N	\N	\N
153	40	\N	\N	Andy Chen	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701			admin@example.com	\N	\N	\N	\N	\N	\N	f	\N	00000908	{andy.chen@beavercapital.com.au}					\N	t	NORMAL	\N	\N	\N	\N	\N	\N
159	37	\N	\N	Lin TAN (Jewel)	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062-190	10557239	Lin Tan	\N	\N	\N	\N	\N	\N	f	\N	146043	{jewel00tl@gmail.com}	1203/3 Haran Street	Mascot	NSW 	2020	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
17	152	0	f		2022-11-02 06:52:10.730805	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
16	152	0	f		2022-11-02 06:49:33.241197	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	0	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
15	152	0	f		2022-11-02 06:42:43.351165	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	0	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
14	152	0	f		2022-11-02 06:40:30.579196	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
13	152	0	f		2022-11-02 06:35:21.559341	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
287	125	6	\N	Parque Edition P/L ATF Parque Edition Investment Trust 	2024-01-05 10:39:05.669788	2024-01-05 10:39:05.669788	\N	640898787	Parque Edition P/L ATF Parque Edition Investment Trust 	\N	\N	\N	\N	\N	\N	f	\N	146120	{monika@lamafamilylawyers.com.au}	88 John Rd 	Cherrybrook 	NSW 	2126	\N	f	NORMAL	\N	535040749	\N	\N	\N	\N
12	152	0	f		2022-11-01 15:24:41.272208	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
11	152	0	f		2022-10-31 14:20:01.236542	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
10	152	0	f		2022-10-28 09:14:18.071777	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
9	152	0	f		2022-10-27 22:31:55.990033	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
8	152	0	f		2022-10-27 22:24:08.543169	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
7	152	0	f		2022-10-27 21:39:10.144674	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
6	152	0	f		2022-10-25 21:14:28.723364	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
5	152	0	f		2022-10-25 21:14:09.54116	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
4	152	0	f		2022-10-25 21:07:07.108478	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
3	152	0	f		2022-10-25 21:03:51.154004	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
38	152	0	f		2023-02-20 11:50:36.560434	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
37	152	0	f		2023-02-20 11:26:05.233743	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
36	152	0	f		2023-02-20 10:06:33.567637	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
35	152	0	f		2023-02-19 18:03:35.688264	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
75	128	3	f	Xiaobo HAN ATF Han Investment Trust	2023-03-06 11:55:50.308	2023-09-07 09:55:08.697	065-005	10836693	Xiaobo HAN ATF Han Investment Trust	\N	\N	\N	\N	\N	\N	f	\N	146094	{charliehan74@gmail.com}	\N	\N	\N	\N	\N	t	NORMAL	\N	446 299 473	\N	\N	\N	\N
195	102	\N	\N	Minglan CHEN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063154	10572614	Minglan CHEN	\N	\N	\N	\N	\N	\N	f	\N	146080	{lanchenlan@hotmail.com}	27B Toolambool Road	 Carnegie	VIC	3163	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
202	96	\N	\N	Jianhong DU	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	083 231	395996550	Jianhong DU	\N	\N	\N	\N	\N	\N	f	\N	146075	{sunrising@vip.163.com}	3 Gianluca Avenue	Keysborough	VIC	3073	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
193	103	0	\N	Yong ZHANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	343002	541274439	Yong ZHANG	\N	\N	\N	\N	\N	\N	f	\N	146081	{zhoufangde@163.com}	No. 417, Fourth Gate, 11th Floor, Dongluoquan Hutong A	Dongcheng District 	Beijing, China	100005	\N	t	NORMAL	t	\N	\N	\N	\N	{}
138	30	13	f	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	2023-07-25 10:38:19.614	2023-08-02 16:55:22.689	033089	623802	EVERGREEN SUN PTY LTD	\N	\N	\N	\N	\N	\N	f	\N	146035	{gxsyj1970@163.com}	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	t	NORMAL	f	569452875	\N	\N	\N	{}
147	50	0	f	Ying DONG	2023-07-25 10:55:56.535	2023-07-25 11:03:53.413	242-200	491642351	Ying DONG	\N	\N	\N	\N	\N	\N	f	\N	146048	{elainedy39@gmail.com}	18 Perch CT	 Kingston	TAS	7050	\N	t	NORMAL	f	534081603	\N	\N	\N	{}
194	98	11	\N	Han Family SMSF Pty Ltd ATF Han Family SMSF	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	033 358	650260	Han Family SMSF Pty Ltd ATF Han Family SMSF	\N	\N	\N	\N	\N	\N	f	\N	146076	{boxing.han@icloud.com}	63 Fernhill Road	Sandringham	VIC	3191	\N	t	NORMAL	f	637212189	\N	\N	\N	{}
156	18	0	\N	Hung Fung Tong	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062-009	10991049	Hung Fung Tong	\N	\N	\N	\N	\N	\N	f	\N	146023	{bpi99409@163.com}	Unit 302, 80 Alfred St.	Milsons Point 	NSW 	2061	\N	t	NORMAL	f	498464236	\N	\N	\N	{}
114	233	11	f	Tina Ywen Pty Ltd ATF Tinaewen Superannuation Fund	2023-07-07 10:10:28.116	2023-07-24 15:45:25.731	063113	11306777	Tina Ywen Pty Ltd ATF Tinaewen Superannuation Fund	\N	\N	\N	\N	\N	\N	f	\N	146183	{auewenlin@gmail.com}	898 Burke Rd	Canterbury	VIC	3126	\N	t	NORMAL	f	297289399	\N	\N	\N	{}
81	147	10	f	AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust	2023-03-06 12:14:09.051	2023-08-03 15:54:01.084	083004	364501615	AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146143	{hyinvestment@hotmail.com}	11 Inglis Ct	Glen Waverley	VIC	3150	\N	t	NORMAL	f	963981610	\N	\N	\N	{}
119	238	10	f	MINGMING INVESTMENT PTY LTD ATF MINGMING FAMILY TRUST	2023-07-13 12:23:20.715	2023-07-24 16:17:27.593	033385	090465	MINGMING INVESTMENT PTY LTD ATF MINGMING FAMILY TRUST	\N	\N	\N	\N	\N	\N	f	\N	146190	{nqchen69@gmail.com}	u1/28 Danien St 	Glen Waverley 	VIC 	3150	\N	t	NORMAL	f	650686029	\N	\N	\N	{}
63	179	\N	f	\N	2023-03-04 23:41:47.466	2023-04-11 13:54:02.599	1	1	1	1631998371600097280.jpeg	1631998371608485888.jpeg	\N	\N	class Record {\n    transactionRecordID: null\n    recordStatus: nomatch\n    datasourceResults: []\n    errors: []\n    rule: class RecordRule {\n        ruleName: null\n        note: null\n    }\n}	2	t	e93f45c4-09db-4bc1-80ce-c8ecf5d8f6a2	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
28	152	0	f		2022-11-03 07:13:19.080501	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	0	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
27	152	0	f		2022-11-03 06:46:55.604868	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	0	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
25	152	0	f		2022-11-02 21:26:54.364158	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	0	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
24	152	0	f		2022-11-02 21:26:34.466831	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
23	152	0	f		2022-11-02 21:20:01.181202	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
22	152	0	f		2022-11-02 21:19:25.444132	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
21	152	0	f		2022-11-02 21:14:58.003446	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
20	152	0	f		2022-11-02 11:42:34.751037	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
19	152	0	f		2022-11-02 10:10:20.635229	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
18	152	0	f		2022-11-02 06:53:38.427892	2024-05-10 14:43:42.51	\N		operations@beavercapital.com.au	\N	\N	\N	\N	{}	0	t	\N	\N	\N	\N	\N	\N	\N	\N	f	NORMAL	\N	\N	\N	\N	\N	\N
307	302	0	\N	Jerry Test Account	2024-06-03 15:12:54.160927	2024-06-03 15:12:54.160927	\N	86868686	Jerry Test Account	\N	\N	\N	\N	\N	\N	f	\N	696969696969	{Jerry.Zhang@bhgglobal.com.au}	Fake add	Fake sub	Fake State	99999	\N	f	NORMAL	\N	9999999	\N	\N	\N	\N
265	266	0	\N	Wan NG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	342091	439075118	Wan NG	\N	\N	\N	\N	\N	\N	f	\N	146207	{jessica.yi@hope733.com}	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	999077	\N	t	NORMAL	t		\N	\N	\N	\N
263	265	12	\N	Lei WU and Yiwen LIN ATF ValueUp 0928 Unit Trust 	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	193879	417388987	ValueUp 0928 Unit Trust 	\N	\N	\N	\N	\N	\N	f	\N	146206	{Valueup0928@outlook.com}	6 Woodlands Avenue	Camberwell	VIC	3124	\N	t	NORMAL	f	528567020	\N	\N	\N	{}
270	260	0	\N	Wensheng ZENG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	733172	892576	Wensheng Zeng	\N	\N	\N	\N	\N	\N	f	\N	146088	{576340975@qq.com}	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	t	NORMAL	t		\N	\N	\N	{}
290	284	0	\N	Tao XU	2024-02-29 16:25:39.214144	2024-02-29 16:25:39.214144	062475	10435447	Tao XU	\N	\N	\N	\N	\N	\N	f	\N	146234	{RYAN0314AU@GMAIL.COM}	1012 JIANDE NANJIAO VILLA,578 NANLIU ROAD	PUDONG	SHANGHAI, China	201314	\N	f	NORMAL	f	589881665	\N	\N	\N	{}
308	303	0	\N	Wan MEN	2024-06-03 17:29:45.654657	2024-06-03 17:29:45.654657	063464	11138432	Wan Men	\N	\N	\N	\N	\N	\N	f	\N	146250	{terrysun2002@gmail.com}	42A Paxton St	Malvern East	VIC	3145	\N	f	NORMAL	t		\N	\N	\N	{}
266	261	0	\N	Guanyu CHEN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	105-029	085666340	Guanyu CHEN	\N	\N	\N	\N	\N	\N	f	\N	146203	{albertcgy@gmail.com}	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	t	NORMAL	f	357304758	\N	\N	\N	{}
249	250	10	\N	Shelford Enterprise Pty Ltd ATF Shelford Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	013366 	409398296	SHELFORD ENTERPRISE PTY LTD	\N	\N	\N	\N	\N	\N	f	\N	146197	{rogerheng@bigpond.com}	3 Pescott Close	BURWOOD 	VIC 	3125	\N	t	NORMAL	f	920933293	\N	\N	\N	{}
283	280	0	\N	Gang LIU	2023-12-12 17:48:16.749222	2023-12-12 17:48:16.749222	193879	006324073	Gang LIU	\N	\N	\N	\N	\N	\N	f	\N	146217	{wulei654321@gmail.com}	6 Woodlands Avenue 	Camberwell 	VIC 	3124	\N	f	NORMAL	t		\N	\N	\N	{}
205	127	0	\N	Rong SHI	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062948	22605187	Rong SHI	\N	\N	\N	\N	\N	\N	f	\N	146093	{rongshi206@gmail.com}	 19B Arlington Drive\t	Glen Waverley\t	VIC \t	3150\t	\N	t	NORMAL	f	605978930	\N	\N	\N	{}
176	60	0	\N	Xiandong GAO	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	062692	46930314	Xiandong GAO	\N	\N	\N	\N	\N	\N	f	\N	146056	{525196937@qq.com}	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou,	Wulumuqi	Xinjiang, Uyghur, China	830063	\N	t	NORMAL	t	\N	\N	\N	\N	\N
264	268	0	\N	Huanghui JIANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	193879	417327877	Huanghui JIANG	\N	\N	\N	\N	\N	\N	f	\N	146208	{442699674@qq.com}	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	t	NORMAL	t		\N	\N	\N	\N
288	283	1	\N	DORGON FINANCIAL TECHNOLOGY PTE LTD	2024-01-25 13:42:45.484065	2024-01-25 13:42:45.484065		3419060230	DORGON FINANCIAL TECHNOLOGY PTE LTD	\N	\N	\N	\N	\N	\N	f	\N	146225	{fifa588@hotmail.com}	1B LEEDON HEIGHTS	SINGAPORE	SINGAPORE	267941	\N	f	NORMAL	t		\N	\N	\N	\N
294	288	1	\N	Hongde Buddhist Temple Australia 	2024-03-11 12:23:07.32236	2024-03-11 12:23:07.32236	\N	163133852	Hongde Buddhist Temple Australia Inc	\N	\N	\N	\N	\N	\N	f	\N	146231	{hongdetemple@gmail.com}	58 Queen Victoria St	Bexley	NSW	2207	\N	f	NORMAL	\N	443345173	\N	\N	\N	\N
234	189	6	\N	Value Up 1123 Pty Ltd ATF for Value Up 1123 Trust 	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	033084	577261	Value Up 1123 Pty Ltd ATF for Value Up 1123 Trust 	\N	\N	\N	\N	\N	\N	f	\N	146112	{liusmsf@gmail.com}	 10B El Nido Grove	Carnegie	VIC	3163	\N	t	NORMAL	\N	\N	\N	\N	\N	\N
252	101	10	\N	Autstrip Pty Ltd ATF Lu Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063619	10435170	Autstrip Pty Ltd ATF Lu Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146079	{ivanlu@me.com}	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	t	NORMAL	f	854531846	\N	\N	\N	{}
284	281	0	\N	Huijing SONG	2023-12-15 10:30:43.523943	2023-12-15 10:30:43.523943	\N	865291	Huijing Song	\N	\N	\N	\N	\N	\N	f	\N	146224	{s979016@gmail.com}	52 Andromeda Pkwy	Box Hill 	NSW	2765	\N	f	NORMAL	\N	353400632	\N	\N	\N	\N
1	158	0	f	Shunhua ZHENG	2022-09-21 09:29:13.640648	2023-03-17 16:42:23.505	343003	338746439	Shunhua ZHENG	\N	\N	\N	\N	{}	\N	f	\N	146130	{826606048@qq.com}	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	t	NORMAL	f	963381308	\N	\N	\N	{}
123	242	0	f	Xiumei WU	2023-07-14 15:09:16.05	2023-07-24 16:18:53.741	083153	300303644	Xiumei WU	\N	\N	\N	\N	\N	\N	f	\N	146192	{greenphile2010@gmail.com}	108 Cityview Road	Balwyn North	VIC	3104	\N	t	NORMAL	f	428198041	\N	\N	\N	{}
118	237	0	f	Fengye Wang	2023-07-12 09:49:33.705	2023-07-25 12:41:41.286	732323	533374	Fengye Wang	\N	\N	\N	\N	\N	\N	f	\N	146188	{hhtuboa@hotmail.com}	58 Shaftesbury Road	Burwood 	NSW	2134	\N	t	NORMAL	t		\N	\N	\N	{}
164	64	9	\N	Minghao GU ATF GU Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	033090	593292	Minghao GU ATF GU Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146061	{colingugo@gmail.com}	8 Heaton CT	Burwood East	VIC	3151	\N	t	NORMAL	f	494420333	\N	\N	\N	{}
163	67	0	\N	Dong Rong JIN	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	733340	525047	Dongrong Jin	\N	\N	\N	\N	\N	\N	f	\N	146064	{dongrjin@hotmail.com}	3/ 12 -14 Oak Avenue	 Boronia	VIC	3155	\N	t	NORMAL	f	383247309	\N	\N	\N	{}
166	69	10	\N	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	032382	469440	Ethan & Aurora Family Trust	\N	\N	\N	\N	\N	\N	f	\N	146067	{fz0207@hotmail.com}	39 Tweed Street	The Ponds	NSW	2769	\N	t	NORMAL	f	552495525	\N	\N	\N	{}
192	100	11	\N	Liu SMSF Pty Ltd ATF Liu SMSF	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	193 879	440350080	Liu SMSF Pty Ltd ATF Liu SMSF	\N	\N	\N	\N	\N	\N	f	\N	146078	{dadudie88@gmail.com}	10B El Nido Grove	Carnegie	VIC	3163	\N	t	NORMAL	f	983874599	\N	\N	\N	{}
170	109	11	\N	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063 010	14628244	wuxufamilysuperfund pty ltd ATF wuxufamilysuperannuation	\N	\N	\N	\N	\N	\N	f	\N	146082	{susanxu70@gmail.com}	6 Woodlands avenue	Camberwell	VIC	3124	\N	t	NORMAL	f	604076735	\N	\N	\N	{}
168	76	0	\N	Manli YANG	2023-11-14 18:00:57.957701	2023-11-14 18:00:57.957701	063157	10079645	Manli Yang	\N	\N	\N	\N	\N	\N	f	\N	146071	{yeungmandy2009@hotmail.com}	28/38 Wells Street	Southbank	VIC	3006	\N	t	NORMAL	f	183923906	\N	\N	\N	{}
\.


--
-- Data for Name: investment_entities_kyc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investment_entities_kyc (id, client_id, entity_type, kyc_result, entity_name, created_at, updated_at, bsb, account_number, account_name, file_1_front, file_1_back, file_2_front, file_2_back, detail_info, kyc_status, del_flag, transcation_id) FROM stdin;
1	195	\N	f	\N	2024-06-03 18:19:49.018	2024-06-03 18:19:49.018	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
2	303	\N	f	\N	2024-06-05 12:05:39.531	2024-06-05 12:05:39.531	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
3	302	\N	f	\N	2024-06-05 12:05:49.297	2024-06-05 12:05:49.297	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
4	301	\N	f	\N	2024-06-05 13:52:50.944	2024-06-05 13:52:50.944	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
5	300	\N	f	\N	2024-06-05 13:53:02.652	2024-06-05 13:53:02.652	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
6	299	\N	f	\N	2024-06-05 13:53:19.123	2024-06-05 13:53:19.123	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
7	298	\N	f	\N	2024-06-05 13:53:43.292	2024-06-05 13:53:43.292	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
8	297	\N	f	\N	2024-06-05 13:53:53.48	2024-06-05 13:53:53.48	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
9	296	\N	f	\N	2024-06-05 13:54:04.303	2024-06-05 13:54:04.303	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
10	295	\N	f	\N	2024-06-05 13:54:13.931	2024-06-05 13:54:13.931	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
11	294	\N	f	\N	2024-06-05 13:54:24.548	2024-06-05 13:54:24.548	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
12	289	\N	f	\N	2024-06-05 13:54:53.839	2024-06-05 13:54:53.839	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
13	288	\N	f	\N	2024-06-05 13:55:09.808	2024-06-05 13:55:09.808	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
14	287	\N	f	\N	2024-06-05 13:55:23.742	2024-06-05 13:55:23.742	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
15	285	\N	f	\N	2024-06-05 13:55:37.654	2024-06-05 13:55:37.654	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
16	284	\N	f	\N	2024-06-05 13:55:49.709	2024-06-05 13:55:49.709	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
17	283	\N	f	\N	2024-06-05 13:56:10.08	2024-06-05 13:56:10.08	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
18	282	\N	f	\N	2024-06-05 13:56:28.202	2024-06-05 13:56:28.202	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
19	281	\N	f	\N	2024-06-05 13:56:41.864	2024-06-05 13:56:41.864	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
20	280	\N	f	\N	2024-06-05 13:56:55.886	2024-06-05 13:56:55.886	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
21	279	\N	f	\N	2024-06-05 13:57:24.931	2024-06-05 13:57:24.931	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
22	278	\N	f	\N	2024-06-05 13:57:38.548	2024-06-05 13:57:38.548	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
23	277	\N	f	\N	2024-06-05 13:57:50.43	2024-06-05 13:57:50.43	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
24	276	\N	f	\N	2024-06-05 13:58:04.693	2024-06-05 13:58:04.693	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
25	275	\N	f	\N	2024-06-05 13:58:15.592	2024-06-05 13:58:15.592	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
26	274	\N	f	\N	2024-06-05 13:58:30.602	2024-06-05 13:58:30.602	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
27	273	\N	f	\N	2024-06-05 13:58:43.389	2024-06-05 13:58:43.389	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
28	272	\N	f	\N	2024-06-05 13:58:59.705	2024-06-05 13:58:59.705	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
29	271	\N	f	\N	2024-06-05 13:59:13.823	2024-06-05 13:59:13.823	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
30	268	\N	f	\N	2024-06-05 13:59:30.36	2024-06-05 13:59:30.36	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
31	266	\N	f	\N	2024-06-06 10:41:20.884	2024-06-06 10:41:20.884	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
32	265	\N	f	\N	2024-06-06 10:41:40.238	2024-06-06 10:41:40.238	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
33	264	\N	f	\N	2024-06-06 10:41:54.551	2024-06-06 10:41:54.551	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
34	263	\N	f	\N	2024-06-06 10:42:18.502	2024-06-06 10:42:18.502	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
35	262	\N	f	\N	2024-06-06 10:42:29.757	2024-06-06 10:42:29.757	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
36	261	\N	f	\N	2024-06-06 10:43:05.12	2024-06-06 10:43:05.12	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
37	260	\N	f	\N	2024-06-06 10:43:22.468	2024-06-06 10:43:22.468	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
38	259	\N	f	\N	2024-06-06 10:43:33.141	2024-06-06 10:43:33.141	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
39	258	\N	f	\N	2024-06-06 10:43:43.41	2024-06-06 10:43:43.41	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
40	257	\N	f	\N	2024-06-06 10:43:55.613	2024-06-06 10:43:55.613	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
41	256	\N	f	\N	2024-06-06 10:44:06.416	2024-06-06 10:44:06.416	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
42	255	\N	f	\N	2024-06-06 10:44:34.5	2024-06-06 10:44:34.5	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
43	254	\N	f	\N	2024-06-06 10:44:47.838	2024-06-06 10:44:47.838	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
44	251	\N	f	\N	2024-06-06 10:45:05.547	2024-06-06 10:45:05.547	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
45	250	\N	f	\N	2024-06-06 10:45:16.513	2024-06-06 10:45:16.513	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
46	248	\N	f	\N	2024-06-06 10:45:37.436	2024-06-06 10:45:37.436	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
47	247	\N	f	\N	2024-06-06 10:45:48.475	2024-06-06 10:45:48.475	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
48	242	\N	f	\N	2024-06-06 10:46:07.597	2024-06-06 10:46:07.597	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
49	241	\N	f	\N	2024-06-06 10:46:18.355	2024-06-06 10:46:18.355	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
50	240	\N	f	\N	2024-06-06 10:46:30.048	2024-06-06 10:46:30.048	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
51	239	\N	f	\N	2024-06-06 10:46:41.225	2024-06-06 10:46:41.225	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
52	238	\N	f	\N	2024-06-06 10:47:07.694	2024-06-06 10:47:07.694	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
53	237	\N	f	\N	2024-06-06 10:47:19.669	2024-06-06 10:47:19.669	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
54	236	\N	f	\N	2024-06-06 10:47:31.119	2024-06-06 10:47:31.119	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
55	235	\N	f	\N	2024-06-06 10:47:42.088	2024-06-06 10:47:42.088	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
56	234	\N	f	\N	2024-06-06 10:47:54.564	2024-06-06 10:47:54.564	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
57	233	\N	f	\N	2024-06-06 10:48:05.392	2024-06-06 10:48:05.392	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
58	232	\N	f	\N	2024-06-06 10:48:19.802	2024-06-06 10:48:19.802	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
59	229	\N	f	\N	2024-06-06 10:48:32.469	2024-06-06 10:48:32.469	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
60	228	\N	f	\N	2024-06-06 10:48:52.998	2024-06-06 10:48:52.998	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
61	227	\N	f	\N	2024-06-06 10:49:11.15	2024-06-06 10:49:11.15	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
62	226	\N	f	\N	2024-06-06 10:49:25.163	2024-06-06 10:49:25.163	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
63	224	\N	f	\N	2024-06-06 10:49:39.293	2024-06-06 10:49:39.293	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
64	223	\N	f	\N	2024-06-06 10:49:53.457	2024-06-06 10:49:53.457	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
65	222	\N	f	\N	2024-06-06 10:50:08.962	2024-06-06 10:50:08.962	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
66	220	\N	f	\N	2024-06-06 10:50:20.192	2024-06-06 10:50:20.192	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
67	218	\N	f	\N	2024-06-06 10:50:34.29	2024-06-06 10:50:34.29	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
68	212	\N	f	\N	2024-06-06 10:50:49.759	2024-06-06 10:50:49.759	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
69	211	\N	f	\N	2024-06-06 10:51:00.034	2024-06-06 10:51:00.034	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
70	210	\N	f	\N	2024-06-06 10:51:13.092	2024-06-06 10:51:13.092	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
71	209	\N	f	\N	2024-06-06 10:51:24.66	2024-06-06 10:51:24.66	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
72	208	\N	f	\N	2024-06-06 10:51:40.841	2024-06-06 10:51:40.841	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
73	207	\N	f	\N	2024-06-06 10:51:54.408	2024-06-06 10:51:54.408	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
74	204	\N	f	\N	2024-06-06 10:52:14.762	2024-06-06 10:52:14.762	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
75	203	\N	f	\N	2024-06-06 10:52:29.456	2024-06-06 10:52:29.456	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
76	202	\N	f	\N	2024-06-06 10:52:46.081	2024-06-06 10:52:46.081	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
77	201	\N	f	\N	2024-06-06 10:52:58.002	2024-06-06 10:52:58.002	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
78	200	\N	f	\N	2024-06-06 10:53:12.347	2024-06-06 10:53:12.347	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
79	193	\N	f	\N	2024-06-06 10:53:45.03	2024-06-06 10:53:45.03	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
80	192	\N	f	\N	2024-06-06 10:53:58.357	2024-06-06 10:53:58.357	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
81	191	\N	f	\N	2024-06-06 10:54:08.406	2024-06-06 10:54:08.406	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
82	190	\N	f	\N	2024-06-06 10:54:20.675	2024-06-06 10:54:20.675	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
83	189	\N	f	\N	2024-06-06 10:54:33.967	2024-06-06 10:54:33.967	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
84	187	\N	f	\N	2024-06-06 10:54:49.326	2024-06-06 10:54:49.326	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
85	186	\N	f	\N	2024-06-06 10:55:02.201	2024-06-06 10:55:02.201	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
86	185	\N	f	\N	2024-06-06 10:55:17.305	2024-06-06 10:55:17.305	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
87	184	\N	f	\N	2024-06-06 10:55:35.614	2024-06-06 10:55:35.614	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
88	183	\N	f	\N	2024-06-06 10:55:45.438	2024-06-06 10:55:45.438	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
89	182	\N	f	\N	2024-06-06 10:55:55.091	2024-06-06 10:55:55.091	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
93	174	\N	f	\N	2024-06-06 10:57:23.676	2024-06-06 10:57:23.676	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
90	181	\N	f	\N	2024-06-06 10:56:07.799	2024-06-06 10:56:07.799	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
91	180	\N	f	\N	2024-06-06 10:56:19.666	2024-06-06 10:56:19.666	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
92	176	\N	f	\N	2024-06-06 10:56:32.748	2024-06-06 10:56:32.748	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
96	171	\N	f	\N	2024-06-06 10:58:00.704	2024-06-06 10:58:00.704	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
94	173	\N	f	\N	2024-06-06 10:57:35.69	2024-06-06 10:57:35.69	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
95	172	\N	f	\N	2024-06-06 10:57:47.526	2024-06-06 10:57:47.526	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
97	170	\N	f	\N	2024-06-11 09:42:45.446	2024-06-11 09:42:45.446	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
99	168	\N	f	\N	2024-06-11 09:45:25.723	2024-06-11 09:45:25.723	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
100	167	\N	f	\N	2024-06-11 09:45:38.302	2024-06-11 09:45:38.302	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
101	166	\N	f	\N	2024-06-11 11:08:04.251	2024-06-11 11:08:04.251	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
102	164	\N	f	\N	2024-06-11 11:08:13.154	2024-06-11 11:08:13.154	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
103	163	\N	f	\N	2024-06-11 11:10:13.556	2024-06-11 11:10:13.556	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
104	162	\N	f	\N	2024-06-11 11:18:54.205	2024-06-11 11:18:54.205	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
105	159	\N	f	\N	2024-06-11 11:19:04.174	2024-06-11 11:19:04.174	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
106	158	\N	f	\N	2024-06-11 11:19:15.153	2024-06-11 11:19:15.153	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
107	156	\N	f	\N	2024-06-11 11:19:25.892	2024-06-11 11:19:25.892	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
108	155	\N	f	\N	2024-06-11 11:19:35.1	2024-06-11 11:19:35.1	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
109	154	\N	f	\N	2024-06-11 11:19:46.98	2024-06-11 11:19:46.98	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
110	153	\N	f	\N	2024-06-11 11:19:56.521	2024-06-11 11:19:56.521	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
111	151	\N	f	\N	2024-06-11 11:20:07.451	2024-06-11 11:20:07.451	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
112	33	\N	f	\N	2024-06-12 13:31:55.66	2024-06-12 13:31:55.66	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
113	31	\N	f	\N	2024-06-18 16:41:50.52	2024-06-18 16:41:50.52	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
114	133	\N	f	\N	2024-06-21 09:59:37.616	2024-06-21 09:59:37.616	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
167	50	\N	f	\N	2024-09-12 10:14:23.774	2024-09-12 10:14:23.774	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
168	57	\N	f	\N	2024-09-12 10:20:10.263	2024-09-12 10:20:10.263	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
169	318	\N	f	\N	2024-09-27 10:53:43.635	2024-09-27 10:53:43.635	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
115	304	\N	f	\N	2024-06-24 13:43:14.967	2024-06-24 13:43:14.967	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
116	73	\N	f	\N	2024-07-02 14:11:53.816	2024-07-02 14:11:53.816	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
117	112	\N	f	\N	2024-07-02 14:14:54.509	2024-07-02 14:14:54.509	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
118	306	\N	f	\N	2024-07-02 14:47:47.236	2024-07-02 14:47:47.236	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
119	132	\N	f	\N	2024-07-02 15:03:31.25	2024-07-02 15:03:31.25	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
120	131	\N	f	\N	2024-07-02 15:21:08.504	2024-07-02 15:21:08.504	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
121	125	\N	f	\N	2024-07-02 15:25:56.992	2024-07-02 15:25:56.992	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
122	52	\N	f	\N	2024-07-02 15:29:11.139	2024-07-02 15:29:11.139	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
123	18	\N	f	\N	2024-07-03 15:57:54.196	2024-07-03 15:57:54.196	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
124	32	\N	f	\N	2024-07-08 10:57:40.643	2024-07-08 10:57:40.643	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
125	124	\N	f	\N	2024-07-08 14:56:15.617	2024-07-08 14:56:15.617	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
126	122	\N	f	\N	2024-07-10 11:11:54.744	2024-07-10 11:11:54.744	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
127	118	\N	f	\N	2024-07-10 11:29:56.6	2024-07-10 11:29:56.6	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
128	109	\N	f	\N	2024-07-10 12:05:02.034	2024-07-10 12:05:02.034	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
129	60	\N	f	\N	2024-07-10 12:08:29.733	2024-07-10 12:08:29.733	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
130	113	\N	f	\N	2024-07-10 12:39:38.139	2024-07-10 12:39:38.139	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
131	63	\N	f	\N	2024-07-10 16:11:37.97	2024-07-10 16:11:37.97	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
132	148	\N	f	\N	2024-07-11 09:23:32.275	2024-07-11 09:23:32.275	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
133	30	\N	f	\N	2024-07-14 20:44:09.993	2024-07-14 20:44:09.993	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
134	305	\N	f	\N	2024-07-15 17:24:20.439	2024-07-15 17:24:20.439	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
135	310	\N	f	\N	2024-07-19 12:02:03.292	2024-07-19 12:02:03.292	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
136	36	\N	f	\N	2024-07-23 10:13:01.206	2024-07-23 10:13:01.206	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
137	66	\N	f	\N	2024-07-24 11:15:06.059	2024-07-24 11:15:06.059	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
138	119	\N	f	\N	2024-07-24 11:15:33.712	2024-07-24 11:15:33.712	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
140	77	\N	f	\N	2024-07-24 11:25:01.824	2024-07-24 11:25:01.824	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
141	123	\N	f	\N	2024-07-24 11:33:58.116	2024-07-24 11:33:58.116	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
142	100	\N	f	\N	2024-07-24 11:59:19.028	2024-07-24 11:59:19.028	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
143	101	\N	f	\N	2024-07-24 11:59:51.445	2024-07-24 11:59:51.445	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
144	110	\N	f	\N	2024-07-24 12:04:58.189	2024-07-24 12:04:58.189	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
145	127	\N	f	\N	2024-07-24 15:03:08.251	2024-07-24 15:03:08.251	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
146	130	\N	f	\N	2024-07-24 15:06:02.265	2024-07-24 15:06:02.265	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
147	136	\N	f	\N	2024-07-24 15:13:03.227	2024-07-24 15:13:03.227	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
148	15	\N	f	\N	2024-07-24 15:18:03.009	2024-07-24 15:18:03.009	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
149	35	\N	f	\N	2024-07-30 11:28:28.057	2024-07-30 11:28:28.057	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
150	311	\N	f	\N	2024-07-30 16:03:56.099	2024-07-30 16:03:56.099	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
151	28	\N	f	\N	2024-07-31 12:40:25.804	2024-07-31 12:40:25.804	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
152	51	\N	f	\N	2024-07-31 16:45:22.631	2024-07-31 16:45:22.631	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
153	14	\N	f	\N	2024-08-01 09:46:22.129	2024-08-01 09:46:22.129	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
154	67	\N	f	\N	2024-08-07 15:35:12.276	2024-08-07 15:35:12.276	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
155	34	\N	f	\N	2024-08-07 15:38:50.396	2024-08-07 15:38:50.396	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
156	312	\N	f	\N	2024-08-13 10:22:45.309	2024-08-13 10:22:45.309	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
157	313	\N	f	\N	2024-08-15 17:32:34.047	2024-08-15 17:32:34.047	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
170	324	\N	f	\N	2024-10-16 10:06:38.916	2024-10-16 10:06:38.916	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
158	315	\N	f	\N	2024-08-29 09:41:12.629	2024-08-29 09:41:12.629	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
159	316	\N	f	\N	2024-08-29 12:16:03.07	2024-08-29 12:16:03.07	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
171	323	\N	f	\N	2024-10-23 10:12:03.424	2024-10-23 10:12:03.424	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
139	29	\N	f	\N	2024-07-24 11:20:35.441	2024-07-24 11:20:35.441	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
98	169	\N	f	\N	2024-06-11 09:42:56.409	2024-06-11 09:42:56.409	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
160	314	\N	f	\N	2024-09-02 09:48:43.808	2024-09-02 09:48:43.808	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
161	138	\N	f	\N	2024-09-03 17:20:34.611	2024-09-03 17:20:34.611	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
162	86	\N	f	\N	2024-09-06 11:23:08.501	2024-09-06 11:23:08.501	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
163	23	\N	f	\N	2024-09-09 16:13:23.65	2024-09-09 16:13:23.65	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
164	46	\N	f	\N	2024-09-11 15:29:15.285	2024-09-11 15:29:15.285	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
165	64	\N	f	\N	2024-09-11 15:41:21.049	2024-09-11 15:41:21.049	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
166	21	\N	f	\N	2024-09-12 09:39:59.997	2024-09-12 09:39:59.997	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
172	325	\N	f	\N	2024-10-28 14:16:52.808	2024-10-28 14:16:52.808	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
173	322	\N	f	\N	2024-10-31 14:27:36.724	2024-10-31 14:27:36.724	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
174	326	\N	f	\N	2024-10-31 15:01:50.964	2024-10-31 15:01:50.964	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
175	328	\N	f	\N	2024-12-03 09:58:22.928	2024-12-03 09:58:22.928	\N	\N	\N	\N	\N	\N	\N	{}	1	f	\N
\.


--
-- Data for Name: loan_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loan_items (id, address, project_date, loan_status, description, value, created_at, updated_at, del_flag) FROM stdin;
1	1212	2023-07-24	0	121		2023-07-24 11:12:08.461	2023-07-24 11:12:13.926	t
\.


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news (id, publish_date, title, content, main_pic, show_to_web, created_at, updated_at, news_type, language, del_flag) FROM stdin;
5	2021-07-07	Beaver Capital—Adelaide CBD Landmark Project Briefing’ successfully held !	On 16th Mar and 17th Mar of 2021, ‘2021 Beaver Capital—Adelaide CBD Landmark Project Briefing’ successfully held in Hilton by main sponsor Beaver Capital and co-sponsor Mai Capital.	df217d47ee5a96fa354bf18ef49992cb.png	t	2021-07-14 08:29:41.136646	2021-07-19 14:56:16.55697	0	1	f
11	2021-07-12	wrap5	\N	23f5be1b1f0dc45adcbe61c8ec40cbac.jpeg	t	2021-07-14 09:45:32.149701	2021-07-19 14:59:26.073296	2	1	f
10	2021-07-10	wrap4		4147ea9ad21f3c26f273982b289e14ca.jpeg	t	2021-07-14 09:44:25.40053	2021-07-19 14:59:58.302079	2	1	f
15	2021-07-05	10年期美债收益率再创两周新高 美财政部一年来首度以0%收益率发债	周五（4月30日）亚洲时段，现货黄金小幅下跌，交投于1769附近。周四（4月29日）金价跌0.53%，因美国强劲的经济数据拖累金价下滑，同时美国股市再创新高。不过印度疫情有望带来一些避险需求。另外，世界黄金协会周四公布的报告显示，第一季全球黄金需求疲软，不过中国方面需求维持较好。\r日内关注美国3月PCE物价指数、3月个人支出、4月密歇根大学消费者信心指数等重要数据，可能会继续拖累金价。	9148e0476c02bd3f1fd561dc38af2067.png	f	2021-07-19 15:06:33.912856	2021-08-02 14:01:00.822363	1	0	f
26	2021-07-21	负利率意味着什么？	负利率意味着什么？\r\n澳大利亚审慎监管局(Australian Prudential Regulation Authority)周一表示，7个月前曾致函各银行，要求它们告知监管机构在实施负利率方面是否会有任何问题。希望银行为零利率和负利率做好准备，并呼吁银行采取一切”合理措施”，以应对到2022年4月30日实施零和负的市场利率以及隔夜拆款利率的情况，确保其技术体系能够应对极端的货币政策环境。\r\n\r\n如果负利率真正实施，会给我们带来什么影响？\r\n1. 理解“负利率”正确概念\r\n名义利率为负的情况一度是比较少的，而今年除了日本、丹麦、瑞典、瑞士，德国之外，新西兰也正在在为实施负利率做准备。各国施行负利率政策旨在刺激消费，恢复受到疫情重创的国家经济，带动提升流动性。\r\n严格意义上讲，负利率应该是指名义利率为负利率，并不是商业银行的实际存款和贷款利率。不过不可否认的是，央行和银行间的负利率会进一步影响货币市场的其它利率，参考现金利率或市场利率的产品包括商业借贷、住宅抵押贷款、个人贷款和信用卡也会收到负利率带来的影响。所以生活中存款和贷款利率为负的现象是理论上完全可能发生的。\r\n2. 负利率对国家带来的影响\r\n各国实施负利率政策主要考虑到两个维度：一方面全球贸易摩擦升级，经济增速放缓，为了刺激国内投资和消费，各国银行纷纷采取负利率，以促进国内经济复苏。另一方面，负利率有助于稳定汇率，降低本币升值压力，改善贸易平衡，短期有助于刺激出口，\r\n负利率同时也对银行金融机构盈利影响显著，负利率对银行的资产负债表两端会施加不对称的影响。在资产端银行金融机构面临负收益率的压力，而在负债端却难以对零售储户转嫁这种压力；造成银行利差收窄，从而影响银行的盈利能力，另一个可能的前景是，银行在负利率下不得不放缓借贷，并提升高风险借贷和高风险投资的比重，提升了银行系统风险。\r\n\r\n3. 负利率对投资者的影响\r\n负利率会增加现金持有的成本，千百年来，占用资金、支付利息已在经济活动中被视为常识，也正因如此，谈到负利率——让渡了资金的使用权反而减少了本金，相当于借款方被奖赏而出资方被惩罚，似乎违背常理。而事实却真实的发生过。\r\n\r\n比如存款：瑞士银行2019年8月6日告诉它的超富客户，如果他们的存款超过50万欧元（约合392万元人民币），自11月份开始将收取0.6%的年费，一笔50万欧元的存款需要支付3000欧元的年费。对于200万瑞士法郎（约合1445万元人民币）以上的存款，年费率将上升到0.75%，因而一笔200万瑞士法郎的存款将每年支付1.5万瑞士法郎（约合10.8万人民币）的年费。\r\n\r\n比如贷款：总部位于芬兰的北欧银行（Nordea）已经在丹麦开始提供固定年利率为0的20年期按揭贷款和年利率为0.5%的30年期贷款。申请负利率贷款的贷款人将照常每月还房贷，但贷款余额每月减少的金额将超过贷款人还款的金额。比如，一个贷款人在8月份还了3000丹麦克朗，而贷款余额减少3015克朗，多于他的还款金额。由于贷款利率为负，原本需要偿还的3015克朗本金只需要偿还3000。\r\n\r\n对资产配置的影响\r\n对债券收益率的影响：负利率有利于压低短期国债收益率，并对长期收益率产生向下压力。从短端收益率来看，欧洲已经采取负利率的国家在实施负利率政策后，国债收益率纷纷下行，两年期内的国债收益率均跌至负值区间。长期收益率方面，早在2015年实施负利率政策后，瑞士10年期国债收益率转变为负值至今，德国、日本、法国、瑞典、丹麦、澳大利亚等10年期国债收益率也转为负值。 \r\n\r\n对股市的影响：\r\n短期内能提振股市，持续性不强。目前实施负利率国家，还没有出现股票等风险资产价格暴涨，其中，丹麦是负利率政策之后，股市表现较为积极的国家；欧元区宣布实施负利率政策后，欧洲斯托克50指数出现6%上涨，但是随着经济下行压力增加，随后出现显著下行；日本在宣布实行负利率政策后，日经225指数上升了2.8%；但是瑞士、瑞典等国在负利率政策后股价还是出现了下挫，因此负利率政策长期对股市的刺激作用有限。\r\n并且负利率政策出台也会诱发股票估值定价难度提升。\r\n根据股票估值的现金流贴现定价公式（DCF模型），PV=∑[CFt*（1-r）]/[（1+i）^t]。\r\nPV=未来现金流量现值，CFt=第t年的现金流量，r=现金流量的风险调整系数，i=无风险利率。\r\n公司股价受到风险偏好、未来盈利和无风险利率三大因素影响，其中风险偏好一般可根据市场波动率进行预测，未来盈利也即未来现金流量根据长期经济增长预测，而无风险利率主要参考10年期国债到期收益率。但负利率政策出台后，无风险收益率表现为负，会直接导致相关股票难以定价。此外也要注意到，负利率使得金融投资加杠杆成本下降，投资者风险偏好提升，股价短期波动加剧，受利率直接影响的银行股波动尤为明显。\r\n\r\n对于黄金投资：\r\n理论上负利率下黄金投资价值凸显。在负利率大时代下，黄金内在投资价值凸显，黄金成为市场上灸手可热的贵金属资产，尤其在股债汇波动增加时，黄金再现光芒。\r\n事实上，2019年第二季度以来黄金价格节节上升，势头锐不可挡，未来黄金的投资价值依然取决于市场预期，如果全球负利率政策还将加深，那么将会支撑黄金价格继续上行，如果市场预期全球负利率政策出现反转，黄金将会出现交易拥挤，影响金价未来走势。\r\n（非专业投资者需要慎重把握黄金买点卖点及交易机构。）\r\n \r\n\r\n首先，新冠疫情爆发后的多项量化宽松政策导致投资者对通胀担忧增加，因此过去三年黄金价格飙升，虽近期有调整，但仍处于近40年高位，因此澳洲可能出现负利率这一单一因素环境短期内对黄金的影响十分有限。其次，澳洲的负利率政策尚未实施，考虑到黄金是全世界交易的期货品种，而澳洲在全球经济体中影响力有限，并不能单独影响黄金价格，而由于欧洲各国及日本已经持续执行了一段时间的负利率政策，信息引导的市场反应已经大概消化，因此综合上述两点，黄金投资的可行性也需慎重考虑。\r\n \r\n\r\n引用及参考：\r\n《“负利率”政策下的投资策略》招商银行首席观点\r\n《宏观研究与资产配置》李超\r\n《负利率的未来：巨债、通胀与增长的平衡》第一财经\r\n	48cbfc5d7ea8cbbce71e05eddef91732.png	t	2021-08-02 13:56:54.216685	2021-08-02 13:56:54.216685	1	0	f
16	2021-07-13	沉寂已久的恐慌指数VIX即将迎来爆发？	英为财情Investing.com – 衡量波动性的VIX恐慌指数近期一直在下降。该指数最近跌至2020年3月疫情爆发后市场崩盘以来的最低水平。不过，期权交易者一直在押注，波动率将卷土重来，推动VIX飙升。	27b6809ce0872535ae63baac2fa3f073.png	f	2021-07-19 15:07:25.52535	2021-08-02 14:01:03.72032	1	0	f
27	2021-08-06	海利淘金大讲堂第13期- 海利带你阿德莱德去淘金（一）	8月5日晚7点，海利基金第13期海利淘金大讲堂活动准时开始，本次活动以zoom meeting的形式在线上举行，海利基金的董事长Hans, CEO Emma，以及前南澳州政府国际招商总监、南澳教育署独立董事的李晶先生出席了本次活动。本次活动共有23名观众参加，专业丰富的内容，以及安全轻松的线上活动形式得到了观众们的认可和支持。\r\n\r\n在活动过程中，董事长Hans向观众们介绍了海利基金的成立初衷以及企业价值观，也表示疫情期间开办海利淘金大讲堂活动与海利基金“利他”的初衷相符，疫情期间大家有更多的时间呆在家里，这是一个挑战，同时也是积累知识，沉淀自身的好机会。海利基金愿意通过线上讲座，邀请金融行业内的精英，持续的举办不同主题活动，帮助海利基金的朋友们更深入，更专业的了解金融市场以及感兴趣的经济话题，更好的进行投资和资产管理。\r\n\r\n本次活动请到了君道咨询的李晶先生，李晶先生曾担任前南澳州政府国际招商总监、南澳教育署独立董事，领导南澳的中国战略、负责南澳面向全球的招商工作，入职州政府前，担任上市基金公司分析师，协助澳大利亚企业的主板上市\r\n\r\n在活动中，李晶先生表示南澳政府对于新冠疫情的良好控制，以及疫情期间房地产市场的突出表现让人们把视线聚焦到了南澳，随后李晶先生带大家了解了南澳独特的商业模式，从农业，能源，矿业，国防，教育及医疗各方面介绍了南澳的核心产业，也从来自州政府，联盟政府和地方政府的贸易拨款，创业基金，产业基金三方面讲述了南澳政府对于招商引资的积极态度。通过具体招商案例，以及自身对于政府招商流程的深刻理解，对于在南澳有哪些投资机会，如何少走弯路，掌握和政府正确的合作模式给投资者们提供了宝贵的建议。\r\n\r\n接下来海利基金的CEO Emma也针对南澳的招商引资政策以及房地产市场发表了自己的看房以及之前张院长提到的澳元利率问题发表了自己的想法，Emma表示李晶先生提到的多项产业让她对阿德莱德有了更深的认识，Emma也提到，其实海利基金的管理层很早就通过market square项目关注了阿德莱德，尤其是房产市场，我们通过数据得知阿德莱德house公寓比远高于澳洲其他城市，过去12个月的数据也显示阿德莱德的公寓以及租金增速位于澳洲主要城市前列，同时未来的基建建设以及城区规划也为阿德莱德的房产市场带来了积极影响。之后Emma向大家详细介绍了阿德莱德CBD地标投资基金，该基金将用于翻新阿德莱德中央市场，在最核心的位置打造顶级的酒店，公寓以及办公物业。之后Emma从投资标的规划，基金框架，风控设施，产品回报等多方面详细介绍了该基金，并在之后观众热烈的提问中给出了详细解答。\r\n\r\n本次活动共有23名观众参加，会后得到了大家的一致好评，海利基金也将再接再厉，每周带给投资者更新鲜的财经知识以及投资分享。\r\n在此感谢您对海利基金的关注！下一期海利淘金大讲堂将继续跟进阿德莱德CBD地标投资基金，并带来更多基金+买房结合的限时优惠投资机会，敬请期待！\r\n	0c4ad8247a5328473d3c727ee073702f.png	t	2021-08-09 14:00:25.096606	2021-08-09 14:00:25.096606	0	0	f
21	2021-08-02	海利淘金大讲堂第12期 - 揭秘澳元汇率波动背后的故事和机遇	7月29日晚7点，海利基金第12期海利淘金大讲堂活动准时开始，本次活动以zoom meeting的形式在线上举行，海利基金的董事长Hans, 基金经理Tianlei，以及来自富甲国际金融学院的张彝伦教授出席了本次活动。本次活动共有29名观众参加，专业丰富的内容，以及安全轻松的线上活动形式得到了观众们的认可和支持。\r\n\r\n在活动过程中，董事长Hans向观众们介绍了海利基金的成立初衷以及企业价值观，也表示疫情期间开办海利淘金大讲堂活动的想法源于海利基金“利他”的初衷，疫情期间大家有更多的时间呆在家里，这是一个挑战，同时也是积累知识，沉淀自身的好机会。海利基金愿意通过线上讲座，邀请金融行业内的精英，持续的举办不同主题活动，帮助海利基金的朋友们更深入，更专业的了解金融市场以及感兴趣的经济话题，更好的进行投资和资产管理。\r\n\r\n本次活动请到了富甲国际金融学院的张彝伦院长，张院长曾在央视财经频道接受过专访并在CCTV证券资讯频道进行专场的解盘分析，也曾担任过花旗，汇丰等大型外汇银行机构的操盘顾问，目前张院长同时在sigma风控管理公司担任董事长，为大型进出口公司进行外汇风险管控。\r\n\r\n在活动中，张院长带大家回顾了澳元汇率的历史波动，介绍了澳元市场在世界外汇交易中的重要地位，也倾囊相授了自己关于澳元汇率的3G（Geology,Geography,Government policy）基本面分析方法以及4C（Cycle, Correlation, Characteristic,Carry trade）技术面分析方法，通过具体案例分析经济活动，国家政策对于澳元汇率的影响，并结合当前经济环境从资产配置角度为投资者提供了投资建议。\r\n\r\n接下来蒋天雷经理也针对澳元汇率以及之前张院长提到的澳元利率问题发表了自己的看法，天雷提到澳洲目前已经步入“零”利率时代，投资者应当注意到银行存款利率已达到历史最低点，需要考虑进行适当的投资从而避免资产缩水，抵御通货膨胀。之后天雷向大家详细介绍了海利固定收益债权优选基金，从固定收益产品对比，历史运营记录，基金投资策略，基金运作，风险控制，投资者权益及相关文件等多个角度分析了产品，并在之后观众热烈的提问中给出了详细解答。\r\n\r\n本次活动共有29名观众参加，会后得到了大家的一致好评，海利基金也将再接再厉，每周带给投资者更新鲜的财经知识以及投资分享。\r\n在此感谢您对海利基金的关注！下一期海利淘金大讲堂将从地产角度入手，请到专业人士与大家分享关于澳洲地产行业的理解和看法，以及投资于阿德莱德CBD地标的地产债权基金，敬请期待！\r\n	df09cc9375c99008bc95f1db5e7619af.png	t	2021-08-02 13:03:55.787183	2021-08-02 16:03:08.131608	0	0	f
28	2021-08-04	No.31 海利财经快讯		6e86465aae63732475bdcd7cc8cb4ecd.jpg	t	2021-08-09 14:06:41.543913	2021-08-09 14:06:41.543913	2	0	f
29	2021-08-12	海利淘金大讲堂第14期 - 海利带你阿德莱德去淘金（二）	8月12日晚7点，海利基金第14期海利淘金大讲堂活动准时开始，本次活动以zoom meeting的形式在线上举行，海利基金的董事长Hans,麦氏资本的副总裁Steve Yang, 以及南澳州政府议员、大公地产董事长Simon Hou先生出席了本次活动。本次活动共有29名观众参加，专业丰富的内容，以及安全轻松的线上活动形式得到了观众们的认可和支持。\r\n在活动过程中，董事长Hans向观众们介绍了海利基金的成立初衷以及企业价值观，也表示疫情期间开办海利淘金大讲堂活动与海利基金“利他”的初衷相符，疫情期间大家有更多的时间呆在家里，这是一个挑战，同时也是积累知识，沉淀自身的好机会。海利基金愿意通过线上讲座，邀请金融行业内的精英，持续的举办不同主题活动，帮助海利基金的朋友们更深入，更专业的了解金融市场以及感兴趣的经济话题，更好的进行投资和资产管理。\r\n本次活动请到了麦氏资本的Steve Yang先生，麦氏资本、麦氏资本、ICD地产、麦氏慈善基金会，同属于麦氏集团，主要业务板块分别为资产管理、地产开发和慈善基金会。麦氏集团拥有20余年的中澳投资经验和开发经验，开发项目超过2500套，在管资金超过5亿澳元，项目总值约23亿澳元。\r\n在活动中，Steve先生提到，麦氏集团致力于传承家族精神，以华人的身份为澳洲的发展创造价值，秉承合作至上，价值投资，稳中求胜的地产投资理念打造高品质的物业。ICD地产作为麦氏集团旗下的大型开发团队，在澳洲打造了多个如Aspire一样受到关注和好评的大型项目，在过去的几年，也顺利和南澳政府达成共识，共同开发打造旧址位于阿德莱德central market的Market Square项目，该地标项目将承载阿德莱德的未来，升级阿德莱德的购物，商业，酒店业服务，对于阿德莱德和麦氏集团的意义都十分重大。目前前期的融资以及发售前准备工作正步入尾声，官网的购房意向申请已经有数十人注册，核心的地理位置和综合体概念使项目得到了投资者和买家的肯定。\r\n接下来大公地产的董事长Simon先生也针对Market Square项目发表了自己的看法。Simon先生在阿德莱德地产行业有着十几年的行业经验，同时也在南澳政府担任议员一职，因此他从很早以来就对Market Square特别关注。Simon提到，central market对于阿德莱德而言是非常重要，代表城市特征的一个地标，而Market Square项目会给阿德莱德这个城市的购物，和商业发展带来前所未有的进步。由于南澳对疫情的良好防控，更多人把目光放到了阿德莱德。通过Simon十余年的行业经验，他提到阿德莱德的居民大多买房用于自住，尤其是对于Market Square 这样地理位置优越，居住方便的物业更会得到本地人的青睐，而将自住作为主要购买意图的物业也会在未来给投资者带来更好的资产增值。很多新移民的父母在刚来到澳洲的时候，不能很快的适应澳洲生活，如Market Square一样位置优越，配套完善的物业可以帮他们很好的解决这个问题。\r\nMarket Square 临近希尔顿酒店，项目底层有升级后的商铺作为配套，同时由于独特的地理位置，很多户型可以在未来一直拥有优质景观。同时价格合理，设计新颖，因此Simon在得知项目即将发售时的心情是十分兴奋的。他表示Market Square这一个项目，对于阿德莱德所有的地产销售中介而言，都是一个难得的机遇，另一方面，很多项目也因为不具备竞争力，都只能选择在Market Square的发售之后才有信心到市场上进行推广，足以看出Market Square的独特优势。\r\n本次活动共有29名观众参加，会后得到了大家的一致好评，海利基金也将再接再厉，每周带给投资者更新鲜的财经知识以及投资分享。\r\n在此感谢您对海利基金的关注！下一期海利淘金大讲堂将继续跟进阿德莱德CBD地标投资基金，并带来更多基金+买房结合的限时优惠投资机会，敬请期待！\r\n	54e5b708c31f06d38afef98b31a23b70.png	t	2021-08-17 13:01:43.284071	2021-08-17 13:01:43.284071	0	0	f
31	2021-08-24	No.33 海利财经快讯		f26c948dcbc579a4df824843a772b452.jpg	t	2021-08-25 13:33:07.208038	2021-08-25 13:33:07.208038	2	0	f
32	2021-08-23	No.32 海利财经快讯		c9107a93c50fedc5e5ab95ce2e808eb5.jpg	t	2021-08-25 13:41:33.587472	2021-08-25 13:41:33.587472	2	0	f
34	2021-08-26	据称佩洛西与党内温和派达成协议 3.5万亿基建预算框架或于日内通关众议院	财联社讯，据一位与会的民主党议员称，美国众议院议长佩洛西已和党内温和派议员达成了协议，共同推进价值4.1万亿美元经济计划。\r\n\r\n外界预计众议院周二投票中，民主党有足够的票数将通过3.5万亿美元的预算方案框架。这将使众议院能开始着手处理参议院通过的3.5万亿美元税收和支出计划蓝图，并在9月底对另一项5500亿美元的基建法案进行最终投票。\r\n\r\n先前参众两院的一些温和派民主党人对支出方案3.5万亿美元的价格犹豫不决，一些人对计划中针对企业和高收入个人的一些增税措施表示担忧。\r\n\r\n以新泽西州众议员乔什·戈特海默 （Josh Gottheimer）为首的约10名温和派曾表示，他们希望在启动预算程序之前就参议院通过的基础设施法案进行投票。激进的民主党议员提出了相反的要求，他们希望在包括关键医疗保健和税收优先事项在内的预算方案完成之前，暂缓进行最后的基础设施投票。\r\n\r\n为与党内温和派达成协议，不仅是佩洛西和多位国会领导人，甚至是拜登和白宫的高级官员也给他们打电话交流，与他们强调预算决议、基础设施法案和投票权立法对白宫目标的重要性。\r\n\r\n规则委员会主席、马萨诸塞州众议员吉姆·麦克戈文 （Jim McGovern）说：“一路的谈判都不容易，我希望我的同僚们能够认识到推进或阻挠议程都只是‘一念之差’。”\r\n\r\n佩洛西的支持者、宾夕法尼亚州众议员布伦丹·博伊尔（Brendan Boyle）说：“我们将不得不携手共进，我的核心小组中最激进的成员和最温和的成员需要走到一起，认识到要么两个法案全做，要么两个法案最终都不通过。”\r\n\r\n不过，这些重大分歧也预示，未来几周民主党议员之间将面临艰难的谈判。先前参议院设定了9月15日的最后期限，这个时间框架十分紧迫。	51635a26038e52fb2a760d0bcf176602.jpg	t	2021-08-26 14:39:18.794433	2021-08-26 14:39:18.794433	1	0	f
35	2021-09-03	No.36 海利快讯		91406fe9b876511191c18b3067961a6d.jpg	t	2021-10-05 10:50:49.1337	2021-10-05 10:50:49.1337	2	0	f
33	2021-07-27	No.29 海利财经快讯		70f7fb12fdf5e342b72db4ecf26b71a7.jpg	f	2021-08-25 13:45:59.467503	2021-10-05 10:53:15.874133	2	0	f
30	2021-08-26	No.34 海利财经快讯		a583df3e07ea099616a1a6b86f379cc2.jpg	t	2021-08-25 13:28:04.883475	2021-10-05 11:15:08.213144	2	0	f
25	2021-07-28	No.30 Latest Financial Express		ef000652708c341f5ae2ce119699f05f.jpg	t	2021-08-02 13:35:26.750974	2022-07-06 16:27:32.929124	2	1	f
13	2021-07-14	No.18 Latest Financial Express		ad6c1f629951ad24b78dea6cb815a41b.jpeg	t	2021-07-14 09:47:17.187845	2022-07-06 16:32:53.115029	2	1	f
36	2021-10-01	No. 37 海利快讯		fc3bd3f08606b37d67fb5033df60d903.jpg	t	2021-10-05 10:54:25.825156	2021-10-05 10:54:25.825156	2	0	f
37	2021-10-02	No. 38海利快讯		619e1111229e411841088d3d8a7888ee.jpg	t	2021-10-05 10:57:35.835711	2021-10-05 10:57:35.835711	2	0	f
38	2021-10-03	No. 39海利快讯		52161a06e45f7884c80a71c735dce400.jpg	t	2021-10-05 10:59:37.637132	2021-10-05 11:00:06.929806	2	0	f
4	\N	\N	\N	\N	t	2021-07-14 08:24:52.864018	2023-08-09 16:35:16.209	\N	\N	f
6	\N	\N	\N	\N	t	2021-07-14 08:30:48.18415	2023-08-09 16:35:21.271	\N	\N	f
8	\N	\N	\N	\N	t	2021-07-14 09:43:02.633719	2023-08-09 16:35:24.276	\N	\N	f
14	\N	\N	\N	\N	f	2021-07-19 15:05:13.185596	2023-08-09 16:37:50.06	\N	\N	f
1	\N	\N	\N	\N	f	2021-07-14 07:45:23.999734	2023-08-09 16:41:52.519	\N	\N	f
17	\N	\N	\N	\N	t	2021-07-19 15:10:16.153955	2023-08-09 16:38:22.052	\N	\N	f
19	\N	\N	\N	\N	t	2021-07-19 15:20:10.180801	2023-08-09 16:38:30.889	\N	\N	f
24	\N	\N	\N	\N	f	2021-08-02 13:31:04.764295	2023-08-09 16:38:36.188	\N	\N	f
2	\N	\N	\N	\N	f	2021-07-14 07:46:59.048489	2023-08-09 16:41:55.635	\N	\N	f
3	\N	\N	\N	\N	f	2021-07-14 07:48:48.218601	2023-08-09 16:41:57.071	\N	\N	f
39	2021-09-01	No.35 海利快讯		7a4359ba7ab89936bcf7ad8da7996cc0.jpg	t	2021-10-05 11:05:28.339253	2021-10-05 11:05:28.339253	2	0	f
40	2021-10-05	首个新冠口服药就要来了，降低约50%住院和死亡风险	这可能是目前听到的最激动人心的消息。\r\n\r\n美国当地时间上周五（10月1日），世界第二大疫苗制造商Merck(NYSE:MRK)（默沙东，在美国和加拿大被称为“默克”）宣布，该公司与Ridgeback生物疗法公司联合研发的研究性口服抗新冠病毒药物Molnupiravir（莫努匹拉韦），在治疗轻度至中度新冠肺炎患者的三期临床中期数据，比安慰剂对照组降低约50%的住院和死亡风险。\r\n\r\n一石激起千层浪，在该消息发布后，默沙东周五盘中涨幅一度超过12%，创2009年以来的最高盘中涨幅，收盘涨幅收窄至8.44%，股价报收于81.45美元/股，对应市值为2062亿美元。不仅如此，该消息似乎还提振了美股市场，美股三大股指周五均出现不同程度反弹，道指、标普涨超1%，纳指结束五连跌。\r\n\r\n但几家欢喜几家忧，默沙东的这则重磅新闻引发了疫苗股普跌——诺瓦瓦克斯(NASDAQ:NVAX)收盘跌12.21%、莫德纳Moderna(NASDAQ:MRNA)跌11.37%、BioNTech(NASDAQ:BNTX)跌6.67%、吉利德科学(NASDAQ:GILD)跌1.85%、阿斯利康(NASDAQ:AZN)跌0.63%、辉瑞(NYSE:PFE)跌0.26%。\r\n\r\n默沙东和Ridgeback表示，将尽快向美国食品和药物管理局（Food and Drug Administration，FDA）提交紧急授权许可（EUA）申请，同时也将在全球范围内提交申请。若获批，莫努匹拉韦将成为全球首个新冠口服抗病毒药物。美国顶级传染病专家、美国国家过敏和传染病研究所所长安东尼·福奇对《纽约时报》解释道，这就像患了流感后迅速取得达菲的处方一样：“我早上醒来，感觉不太好，嗅觉和味觉都消失了，喉咙痛。我打电话给我的家庭医生说，‘我得了新冠，请给我开个处方。’”这意味着未来确认感染新冠的人不用去医院排队就可以在家吃药治疗，另外这也是那些害怕打针的人的福音。\r\n\r\n在III期试验中，默沙东和Ridgeback对入组的病患有严格的选择条件，轻到中症（出现症状5天内），没打过疫苗，至少有一个与不良疾病预后相关的高危风险因素，比如有高龄、肥胖、糖尿病、心脏病等基础病，这其中不包括孕妇。根据试验结果，在随机分组后的第29天，Molnupiravir治疗组的住院或死亡率为7.3%（28/385），无一例死亡。作为对照，安慰剂组中有53名患者住院或死亡（53/377），占14.1%，其中8人死亡。从数据上，莫努匹拉韦降低了50%的住院或死亡率，p值为0.0012。这似乎意味着莫努匹拉韦能有效降低这些高危风险因素患者的死亡率。\r\n\r\n默沙东公司全球研发主管Dean Li（迪安·李）接受采访时说：“Molnupiravir这个名字确实恰如其分——它是以雷神之锤Mjollnir来命名的。这款药物是一种对抗新冠病毒的锤子，不管新冠病毒会进化出什么样的变体。”\r\n他表示，从试验数据来看，这种药物对新冠病毒变种同样有效，包括病毒的Gamma、Delta和Mu变种。这将抑制新冠病毒的传播。在实验中，医生会给Molnupiravir治疗组的患者开具处方，病人拿到药片后，按照一天4粒、一天两次服药，五天为一个疗程。这意味着一个疗程要吃40粒“雷神之锤”。\r\n\r\n默沙东公司表示，它希望在今年年底前能生产1000万个疗程的药物，并在明年加大生产力度。不过，该药依然价格不菲，根据默沙东与美国政府签订的协议，一旦该药获得了紧急授权许可，美国政府将以12亿美元的价格购买170万个疗程的该药，约合700美元一个疗程。虽然不便宜，但这个价格只有再生元单克隆抗体治疗费用的1/3，尽管它的效果可能不如单克隆抗体治疗，后者主要通过静脉注射对新冠患者进行治疗，并且需要患者去医院或诊所进行治疗。\r\n\r\n默沙东公司表示，它的目标是让全球受益，并称它已与五家印度仿制药制造商达成许可协议，以加快向100多个低收入和中等收入国家的药物供应。它将采用“分层定价方法”，对药物的定价能反映各国对该药物的支付能力。目前默沙东公司还没有公布Molnupiravir的药物有什么副作用，也尚未经过同行评议，Dean Li承诺将在晚些时候公布更多的数据。\r\n\r\n根据微信公众号“纽约时间”的报道，Molnupiravir并非是新研发的药物，它2013年诞生于埃默里大学的实验室，当时研究人员的目标是为了治疗马脑炎病毒感染。后来在测试中发现，作为一种广谱抗病毒药物，它能够阻止多种RNA病毒复制，包括流感病毒、SARS和MERS病毒（中东呼吸综合症）、埃博拉病毒以及呼吸道合胞病毒。2020年3月，位于迈阿密的Ridgeback生物疗法公司获得了该药的许可，两个月后，默克参与了进来，共同投资开发这款药物。\r\n\r\n2021年1月，默沙东自己的两款新冠疫苗和一款药物研发计划以失败告终。如今颇有风水轮流转的意思，默沙东在抗击新冠疫情方面重新找到了存在感。《纽约时报》援引多位华尔街分析师的预测称，该药物将给默沙东和Ridgeback生物疗法公司带来每年100亿美元的收入。\r\n\r\n——摘抄自“虎嗅APP”2021年10月3日发表的文章《首个新冠口服药就要来了，是个“锤子”》\r\n	906333a7ba3235cd6afb79f8c6e87e3a.jpg	t	2021-10-07 08:27:35.356718	2021-10-07 08:27:35.356718	1	0	f
41	2021-10-12	No.40 海利快讯		2f643a457523d2489ff35488c234ee12.jpeg	t	2021-10-12 11:51:35.818396	2021-10-12 11:51:35.818396	2	0	f
47	2021-10-18	练就火眼金睛，找到靠谱基金	John Xu是Spectre Linkers的合伙人。在澳大利亚和亚洲地区为投资者提供投资、开发、融资的代理服务，拥有丰富金融的经验。在成为合伙人之前，John在一家知名律师事务所担任金融服务经理，也曾作为一家顶级公司的律师为大型企业就跨境交易提供咨询。\r\n \r\n在一个基金里面，都有哪些Key Players（关键人物）呢？\r\n\r\nJohn：我觉得第一个最重要的人物是Investment manager（投资经理），为什么重要，因为一年中投资的钱是赚的还是亏的，大多数时间是靠投资经理的管理。在不一样的基金里面，投资经理的作用也是很不一样的，要看IM（information memorandum）里面是怎么要求的。比如房产基金，它的一些业务像是造哪栋楼，回报多少，这些是已经提前算好的了，投资经理只要保证合同里的数字是对的就好了，属于被动投资。那另一种是股票基金，你的钱放进基金里去投资股票或外汇，投资经理就要24小时盯着市场动向和数字，评估市场风险等等，基金能不能赚钱直接取决于投资经理的经验和技术。\r\n\r\n第二个很重要的人物是Custodian（托管人），托管人有点像一个非常保守的第三方会计师。每一次基金想把钱拿出来，不管是去投资还是付给客户利息，都要通过托管人。他会问你很多问题，如果没有合理的理由，托管人是不会把资金给你的。因为他们直接控制了基金的投资情况，还有些其他项目比如抵押物的钱也是放进Custodian里面的。他会保障投资者资金的安全性，只有基金需要资金去投资，Custodian才会把钱放给基金。\r\n\r\n但是第三方的Custodian会增加基金的管理费，因为每一次放款都是需要收费的，如果一个本身很保守的基金，每个月需要给客户付息，那么一个第三方的Custodian就会大大增加成本，不如把钱作为利息返还给投资者。\r\n\r\n第三个重要人物是Trustee（信托人），他就像是公司的CEO，管理着一个基金的内部运营，保证所有员工做自己该做的事。比如投资经理出现重大失误，Trustee有权利换掉他。平时签合同，和第三方打交道，雇佣律师，这些都需要Trustee来做决定。\r\n \r\n基金中有哪些重要的文件?\r\n\r\nJohn：其中最重要的三个文件是IM（Information Memorandum），Unit of Certificate（信托单位证明）和Application Form（申请表）。IM里面包括一个基金产品的全部信息，包括开始时间，退出时间，退出方式，最低投资额，回报率，基金的投资标的，还会详细告诉你投资经理的权利，他们会用资金的百分之多少投资到哪里，比如30%投资美股，40%投资地产。在投资基金之前，我建议投资者一定要把IM仔细地研究明白，不要只是听别人说。\r\n\r\n第二个文件是申请表，很多基金里面会有不同的产品，大家填写的时候一定要确保选择正确的产品并且个人信息一定要确保填写正确。因为基金的钱是放在第三方托管人那里的，个人信息填错的话，再想把钱拿出来就会很困难。还有要确定自己是否符合投资资格，有的基金只接受Wholesale的投资者，最低投资额要超过50万澳元，如果你不是Wholesale的客户，是没有资格投资的。\r\n\r\n第三个文件是Unit of Certificate。这个就相当于买基金给你的收据，上面有一些最基本的内容比如产品的名字，投资额，投资时间和投资者的个人信息，如果个人信息错了的话，一定要及时更正。\r\n \r\n作为普通投资者，会面临一些什么样的风险呢？\r\n\r\nJohn：根据真实的研究表明，人们在亏钱时候感受到的痛苦会比挣钱时候的快乐要更强烈很多倍。对于投资者来说，我们最看重的一点是本金不能亏损，所以在投资之前一定要清楚基金的风控和增信是怎样的。很多时候会有客户把基金文件发给我，让我帮她分析会不会有风险。其实每一个基金，不管大小，不管在哪个国家，都会有风险。所以投资之前要明确，你能接受多大的风险，因为每个人对风险的接受程度不同，有的人为了保本金而不能接受任何激进的投资，有的人为了追求高回报而去投资高风险的产品。\r\n\r\n当然我们也可以通过基金的架构和IM来分析一下基金的风险，首先要了解投资经理过去的投资标的和经验，回报率，有没有出现过失误。Trustee和Custodian都是谁，大机构会比小机构风险相对小一些。还有基金的风控和增信，比如它有没有止损点，止损点是多少。有没有抵押物，抵押物是保证这个项目不会垮掉还是保证一年回报率10%。这些都是大家在投资之前一定要考虑清楚的。\r\n\r\n希望大家听了今天的讲座能有所收获。\r\n\r\n【投资都是有风险的，大家要保持谨慎】\r\n\r\n（本文章只分享投资心得，不构成投资及财务建议）\r\n\r\n	d64cf91472232bfa799feb8052d904fe.png	t	2021-10-19 13:15:12.064919	2021-10-19 13:54:13.655532	0	0	f
50	\N	海利金控助力第九届亚太金融投资峰会，解决全球金融痛点	\r\n疫情之下，全世界的经济面临前所未有的挑战。市场极具分化，资本轮动转换加速，是政策影响也是机构布局。为了解决全球金融从业者的痛点，打通不同圈层的隔阂。第九届亚太金融投资峰会在悉尼盛大开启。\r\n\r\n让全世界精英、顶流大佬一同来探讨传统型态下的亚太企业经济性发展与创新探索。海利金控很荣幸地以协办方的身份出席了本次峰会。开启了海利金控项目启动仪式，也为投资者们指明未来发展方向。\r\n\r\n本次史诗级峰会由亚太金融投资协会、BOA Private Wealth冠名主办，海利金控、Arthur St Capital Management、Sigma Risk Management、富甲金融学院、Tycoon Capital共同协办，BCU WORLD、安德咨询、Inno Australia、悉尼游艇俱乐部及澳中企业家俱乐部共同承办。现场空前盛大，打造了高端朋友圈，涵盖众多环节。\r\n\r\n01\r\n\r\n精英翘楚指明未来方向 \r\n\r\n借此绝佳的时机，本次峰会正式宣布开启海利金控项目启动仪式。亚太金融投资协会主席Emma Wang, 海利金控董事长Hans Han, 莲餐饮集团创始人及董事长Michael Jiang, 海利金控合伙人Yang Li, 海利金控合伙人 Andy Chen主持启动仪式。现场大咖云集，作为无数投资者教父——吉姆·罗杰斯-Jim Rogers的出席掀起了高潮。但疫情的原因，罗杰斯先生无法亲临现场，通过视频展开一场隔空对话，讨论亚太金融的新趋势和新机会。为亚太经济之后疫情时代寻找破局方式。\r\n\r\nBOA Financial Group CEO- Jason Xu在现场给出后疫情时代，财富管理新趋势。知名财富管理及股权投资专家、北大清华澳洲麦格里大学客座教授，国际家族基金协会高级顾问，现任Richlink Capital Group, Founder——郑锦桥先生也来到现场。分享主题为Strategy and Risk Control of Family Office的演讲。CCTV财经频道特邀分析师，多家国际银行的交易顾问，富甲学院创始人院长Jack Zhang回顾和展望新经济环境下的金融交易环境。\r\n\r\n作为此次盛会主办方的亚太金融投资协会主席Emma Wang，亲临现场发表精彩讲话。在全场精英们的瞩目下，亚太金融投资协会授牌仪式开启。协会精选出了一批优秀企业以及个人，在此年度峰会上进行入会授牌。\r\n\r\n授牌嘉宾：亚太金融投资协会主席Emma Wang, 海利金控董事长Hans Han, 莲餐饮集团创始人及董事长Michael Jiang\r\n\r\n理事单位：今日悉尼，澳洲同城，澳洲印象App，AFN，悉尼游艇俱乐部，红桉资本，BOA Group，TMGM集团，合富辉煌, East Super\r\n\r\n理事：河马财富创始人Jeffrey Liu, 富甲国际金融学院Aaron Wei, Discover energy创始人及CEO Anson Zhang, 悉尼游艇俱乐部创始人Steven Zhang，BOA Financial Group CEO- Jason Xu, TMGM 首席商务官Nick Yang, 亚太金融投资协会执行秘书长&安德咨询CEO Ryan Li, 海利金控合伙人Yang Li, AFT Group 合伙人-Tony Lu, Arthur Street Venture Capital Fund-Nicholas O’Day, New Vista Fund: Christopher Leach\r\n\r\n不仅如此，峰会还正式宣布DCG项目启动仪式。\r\n开启启动仪式的嘉宾有:DCG集团Chairman：Gavin Xu, DCG集团 CEO：Kelly Lu, DCG集团 Partner: Golden Chen, DCG集团 Fund Manager: Christopher Leach, DCG集团 外部合伙人：Nick, DCG集团创新基金副总裁 ：Lucas Wu, DCG集团交易所合伙人: Matt Ma, DCG集团总裁助理：Constance Liu。\r\n\r\n02\r\n\r\n圆桌会议，直击当下痛点\r\n\r\n这次峰会主会场的一个重要环节就是圆桌论坛，各位行业精英集聚一堂，围绕大家关心的业内话题及热点展开讨论，为大家拨开迷雾。三场圆桌会议，分别对应下午三个分会场的主题：\r\n地产投资，创业及可持续发展，以及金融交易和新零售。\r\n\r\n圆桌会议1：\r\n2022年澳洲地产投资趋势及策略问题\r\n在疫情反扑的大背景下，澳元加息没有像美联储这么快，那么导致澳洲房地产呈现疯涨状态。那么2022年房产的趋势到底是什么？哪类型房屋是投资新趋势？在宏观政策快速变化的当下，对于地产投资有什么好的建议？\r\n\r\n面对这些问题，本次峰会邀请业内顶级行业翘楚，直击痛点解决问题👇。\r\nDirector of Development Lotus Property- Damien Kiley，合富辉煌Sales Director- Herman Han,，海利金控常务董事Michael Jiang， Han’s Holding Group, General Manager-Andrew Lau，Colliers- National Director-Guillaume Volz。\r\n\r\n他们亲临现场，现场解读2022年的澳洲房产市场。\r\n \r\n圆桌会议2: \r\n关于澳洲风险投资，创业，以及可持续发展策略ESG\r\nESG（环境、社会和 治理）越来越多被提及和关注，尤其是当下的投资机构在做投资决策时，ESG扮演了重要角色。次圆桌会议，分享了ESG投资方面的重要信息，给出未来投资机构和公司有效的措施，来完善ESG信息披露。\r\n\r\n行业巨头给出建议策略，海利金控合伙人Andy Chen, Follow the seed创始人Curt Shi, 安永大洋洲区中国业务部总监Catherine Qian以及Discover energy 联合创始人兼CEO Anson Zhang。\r\n\r\n\r\n圆桌会议3：\r\nAI时代的智能交易及国际交易趋势\r\n经历了两年的疫情，除了大的经济形势，人们的生活方式，消费习惯，投资理念，也都随着疫情在发生变化，对于交易市场而言也发生了巨大变革。Online trading platform成为疫情时代大的趋势，数字货币是否随着online trading持续升温？\r\n\r\n河马财富创始人Jeffrey作为本场圆桌会议主持人，嘉宾：Tycoon Capital大君资本CEO Jason Xu, TMGM首席商务官Nick Yang, CMC Markets Sales Executive- Jason So, Sigma Trading Management 董事总经理Anthony Wu\r\n\r\n他们面对瞬息万变的市行业，顶流嘉宾给出AI时代的智能交易以及国际交易趋势，。\r\n\r\n03\r\n\r\n3大会场展望未来\r\n\r\nA场：\r\n传统投资与资产配置\r\n\r\n面对突如其来的疫情，投资格局发生剧烈变化。在传统投资与资产配置领域，峰会的先行者们同样也指出了光明的方向。金融市场的起伏关系着每一个在澳洲生活工作人们的命运，面临诸多挑战。我们该如何建立财富护城河，从而有效的创造，保障，和传承财富成为必须考虑的问题。\r\n\r\n澳洲著名财富教育博主- 河马财富创始人兼首席保险理财师 Jeffrey刘梦麒携手澳洲和世界顶级基金和财富专家。\r\n\r\n面对当前挑战，共同探讨，寻找出路。\r\n\r\n挑战一通货膨胀：COVID-19大流行继续为经济大环境带来新的挑战，面对通货膨胀该何去何从？\r\n\r\n挑战二创新金融：传统投资者除了房产，股票传统资产类别以外，我们还有哪些选择来应对挑战？\r\n\r\n挑战三合规理财： 我们该如何擦亮双眼，获得正确全面，透明专业的信息，保护我们的财富？ \r\n \r\n挑战四财富传承：高净值人士又该如何为后续的财富传承进行资产配置？\r\n \r\n挑战五可持续发展：面对社会环境的变化，讨如何顺势而为，在创造财富的同时，让全人类可持续发展？  \r\n\r\n这些关乎无数人命运的挑战，在这场世纪峰会上指明了方向，合理做好传统投资与资产配置才能事倍功半。 \r\n\r\n\r\n参与的嘉宾来自：\r\nVanEck的John CaulfieldSequoia CEO- Garry Crole ；FireTrail Investment Director的Kyle Macintyre、East Super的Dermott Lynch，来自Bennelong Funds Management 的 Chris Bedingfield，Tycoon Capital Founder Jason Xu\r\n\r\nMyboats Fund Management Co-Founder（海利游艇基金联合创始人） Steven Zhang，Lotus hospitality group founder and CEO Michael Jiang，Beaver Capital partner-Andy Chen，Genlife CEO Grant Hackett\r\n \r\n以及Jordan Cvetanovski ，Jimmy Pan (Head of Sales CMC Markets APAC and Canada)  ，Tim Samway (Hyperion Chair) ，Peter Cook (CEO of Novatti)，Sam Wetzler (head of Sequoia Asset Management) ，Jeffrey Liu (河马财富创始人)  \r\n\r\n \r\nB场：\r\n2021创新澳洲创业大赛\r\n\r\n在这次峰会上，2021 澳洲创业创新大赛决赛精彩上演。现正值澳洲解封初期经济复苏之际，各项经济政策应运而生。为了解决华人创业者的痛点，BCU 创业孵化器的负责人吴海洋Lucaswu给青年才俊们送上鼎力支持。\r\n\r\n100 支优秀队伍于BCU 孵化器中心进行项目路演。\r\n\r\n其中脱颖而出的 12 支队伍，由来自中国和澳洲的专业评审，评分选出 3 支优胜队伍。角逐最终冠军年度最佳项目，赢取获得$1,000,000 澳元的投资基金，以及全方位的项目孵化和风投对接。三强队伍包括\r\n\r\n最受投资人青睐奖：\r\n引领支付生活新时代的——lifepay\r\n\r\n最受大众欢迎奖：\r\n扎克伯格背书的线上儿童教育平台——Dr.Chris Steamverse\r\n\r\n第一名最佳年度项目：\r\n引领新时代的宠物食品——RARA Fresh\r\n\r\n项目包括：\r\n\r\n区块链metaverse技术搭建全球化的平台；用户在线服务平台；高校配送及严密保鲜技术的宠物食品；基于位置的移动交易应用程序；STEM教育；家庭烹饪解决方案；养老金基金；通过人工智能技术加速全球可再生资源的发展；全球医疗专业资源共享中心；澳洲有机原材料的电子烟；一体化数字金融平台；基于云的数字孪生城市平台。最后，Rara Fresh的宠物食品获得了全场第一名，并得到了意向投资100万。\r\n\r\nC场：\r\n金融交易与新零售\r\n\r\n聚焦亚太金融圈的优秀企业家群体共同探讨国家现行财政策略下的：经济发展模式，传统投资模块、科技创新型产业以及新零售发展。\r\n\r\n圆桌1：机构和专业投资人对上市公司的估值和股价波动的分析。\r\n\r\nJewel Tan - BCU World Marketing Director, Jason XU- Tycoon Captial 大君资本 CEO, Nina Zhang - Bank of America Merrill Lynch 美银证券分析师, Justin Foord - Market Eye - Director 董事，给出未来发展方向。\r\n\r\n圆桌2 Sigma: 解析疫情对进出口企业的影响，以及风险控制的解决方案\r\n\r\n现场嘉宾包括Jewel Tan - BCU World Marketing Director, Jason XU- Tycoon Captial 大君资本 CEO, Nina Zhang - Bank of America Merrill Lynch 美银证券 分析师, Justin Foord - Market Eye - Director 董事\r\n\r\n\r\n圆桌3: 股票交易趋势。比如：美联储计划缩表和哪些类股是2022年的机会等等干货分享。\r\n\r\n富甲国际金融学院CEO-Aaron Wei, CMC Markets-Jason So, Sales executive, 资深股票交易员及上海复旦大学讲师 Zhiwei Mao, 富甲国际金融学院股票投资高级顾问及基金经理- Eric Ji, TMGM 首席商务官- Nick Yang给出解决之道。\r\n\r\n\r\n圆桌4：后疫情时代对用人单位和人才的影响\r\n\r\n嘉宾：富甲国际金融学院CEO-Aaron Wei, Abbey College CEO- Tony Tang,  Robert Half Sydney- Principal Consultant Sonia Shaw，亚太金融投资协会主席-Emma Wang，海利金控市场总监-Brian\r\n\r\n\r\n圆桌5: East SuperTopic: Alternative investment trends。\r\n邀请了重量级嘉宾参加：East Super Co-founder，Dermott, Michael Zahn,  Suthan Naganayagam, Peter Smith\r\n\r\n4\r\n\r\n海利之夜，游轮晚宴\r\n \r\n到了夜晚，全悉尼最大最豪华的宴会邮轮Star Ship点亮海港。海利金控开启盛大的颁奖！\r\n\r\n开启一场海上巡航。\r\n最专业的表演团队带来震撼表演。最具感染的乐队交织出美妙的夜晚。最懂味蕾的主厨团队演绎出当晚的高潮。尽享美酒美食，结识一生的贵人。行业精英私享，悉尼海滩上的夜景为你一网打尽，同时开启颁奖之夜。\r\n\r\n个人奖项：\r\n年度金融活跃人物 \r\nBrian Guo\r\n\r\n年度最佳金融知识传播人物  \r\nJeffrey Liu\r\n\r\n年度最受信赖金融人物 \r\nGrant Hackett\r\n\r\n年度最佳金融服务人物 \r\nPeter Cook\r\n\r\n年度最佳金融投资人物 \r\nJason Zheng 郑锦桥\r\n\r\n年度最佳金融创新人物\r\nSteven Zhang \r\n \r\n机构奖项：\r\n\r\n年度最佳金融服务机构 \r\nBOA Private Wealth\r\n\r\n年度最佳金融知识传播机构  \r\n富甲金融学院\r\n\r\n年度用户选择金融机构 \r\nVanguard\r\n\r\n年度最佳金融知识传播媒体  \r\n澳华财经在线\r\n\r\n年度最佳金融投资机构 \r\nArthur st capital\r\n年度最佳新兴金融机构\r\nEastsuper\r\n\r\n\r\n感谢大家，明年再见\r\n这次活动只是序章，\r\n未来更加精彩，拭目以待！\r\n\r\n\r\n	b99c985d250f4b7a9a55eb4bf695f271.png	t	2022-01-11 13:26:18.937188	2022-01-11 13:26:36.799628	0	\N	f
51	2022-03-29	海利财经快讯第55期		3bb67823042ff6723a0b199ae9725461.JPG	t	2022-04-05 12:45:41.231993	2022-04-05 12:45:41.231993	2	0	f
53	2022-03-24	海利大讲堂第40期-全球经济是否进入新的金融危机周期？	海利大讲堂第40期邀请到了莫纳什大学（Monash University）的经济系教授史鹤凌来为大家分析全球经济是否进入了新的金融危机周期。\r\n\r\n影响全球经济的最大因素\r\n\r\n史教授：实际现在影响全球经济的最大因素的就是俄罗斯和乌克兰之间的战争，战争对世界经济一向是有着重大影响的。本次战争在短期内会影响大众的产品首先就是石油跟天然气，其次就是铜、锡、铝等，这些产品的影响必然会影响各个国家的通货膨胀率。各个国家对于现在如此高的通货膨胀，都会采取一些货币政策，这个货币政策主要就是我们所称的紧缩型的货币政策，也就是说通过升息的方法增加利息的方法。同时，此次战争对于几个特定的行业还会造成供应链管理上的一些困难，虽然俄罗斯和乌克兰在全球经济当中的地位不是那么的高，但是他们在某些特定行业当中还是占有举足轻重的地位。这些就是对全球经济的短期影响，现在有些说法是说2022年的三月份会爆发一些比较大的经济冲突，但是个人认为可能性不大，在5年内的话，这些影响都是可控的。\r\n\r\n石油和天然气的市场影响\r\n\r\n史教授：俄罗斯实际上是欧洲的石油跟天然气的主要的供应国，所以这场危机，率先就给那个石油跟天然气的市场带来很大的冲击。首先看一下就是俄罗斯在石油和天然气方面，在国际市场上所占的地位，那么俄罗斯是世界第三大的石油生产国，日产原油大概是1000万桶左右。天然气的话，可能占的比重更高，因为欧洲大概40%的天然气的供应，特别是德国，主要是依赖于俄罗斯。所以一切的经济制裁一旦涉及到天然气的供应的时候，德国会首先起来反对。因为这个原因，在最坏情况之下的话，英国的financial time就是金融时报，预测油价很可能会升到大概140美元一桶，那么今天大概在130左右，所以还有大概十美元的上升的空间。如果这种情况持续到今年的年底的话，欧洲天然气的价格会继续上涨，这会使得发达经济体的通货膨胀率增加大概2%左右。现在美国的通货膨胀率在7.5%左右，欧洲在6%左右，澳大利亚原来一直是非常好的控制通货膨胀率的，现在的通货膨胀率大概在3.5%左右，这实际上已经是超出了澳大利亚联邦储备银行的上限。但是我对这个石油跟天然气并没有那么的悲观，最主要的原因是因为实际上美国是有很多的石油的储备。之所以现在美国没有办法对国际的石油市场施加更大的影响力，是因为现在的美国那个民主党的政府在拜登上台以后的第一个措施就是因为绿色环保，在美国本土不再开发新的油田这个政策。我认为美国现在是应该增加石油产出的时候了，在这样条件之下，我相信美国的政府，应该会做出一些改变。所以尽管现在石油的供应出了一点问题，油价飞速的上涨，但是应该是会很快就得到控制的，对全球经济的影响应该是暂时和可控的。\r\n\r\n对全球金融市场的影响\r\n\r\n史教授：历史数据来看，二次世界大战以后，就1945年二战结束以后，每一次的局部战争，如果大家是投资在美股的话，基本上是一样的趋势，就是先降后升，战争一旦爆发以后的话，会降的比较多，这次的话也不例外。但是呢，从历史数据来看，降了一段时间以后，股价反而是会上升的，一般比起战争刚开始的时候会上升5%左右，那么估计这一次的话也不例外，所以就看这次战争什么时候结束。如果大家做美股的话，现在应该是逢低做多的时候。所以如果大家有一个资金的配置，在美国跟欧洲的话，从基本的判断来看，应该是减少在欧洲的投资配比，而更多的资金的配比应该进入美国的市场，无论是美股也好，或者美债也好，一部分资金的话，也应该进入澳大利亚市场，回报也会比较高。\r\n\r\n\r\n（本文章只分享嘉宾观点，不构成投资及财务建议）	1ce9a1314d26206bb78fda4db89e812d.jpg	t	2022-04-07 14:24:59.956362	2022-04-07 14:24:59.956362	1	0	f
42	2021-10-14	No.41 Latest Financial Express		03861c1943333dcd596bd7a2521826b1.jpg	t	2021-10-18 08:43:40.625861	2022-07-06 16:25:17.280748	2	1	f
52	2022-04-06	海利大讲堂第43期-澳洲借贷的抵押保障	海利大讲堂第43期有请到了Alva为我们讲解澳洲借贷的抵押保障\r\n\r\nAlva作为Greengate Advisory的技术总监，同时还是澳大利亚重组清算协会会员、注册会计师及注册事务律师，拥有超过10年的清算重组实践经验。\r\n\r\n无担保/有担保债券的区别\r\n\r\n顾名思义，无担保债券就是这笔贷款没有用于作为抵押的资产进行担保，抵押。其中包括了几个方面，一种就是非常常见的朋友或者关系户之间的借款。另一种就是在做生意过程中出现的赊账情况。比如invoice上的payment due date会是7天、14天甚至1个月，在没有付款的情况下，这个未付款就是无担保债权的一种。最后还有一种是个人担保的这样一种情况，如果没有一个资产进行作为这个抵押支撑的话，它其实也是属于无担保债权。\r\n\r\n下面看一下有担保债权，和无担保债权最大的区别，首先第一它要具有法律效应的，明确规定详细条款及其有担保债权性质的这样一个文件，那通常我们比较常见的local government债权协议，可能还有一些担保协议，在此之上，在澳洲的法律体系下，最重要一点就是它有相应的登记。\r\n\r\n有担保债权的优势\r\n\r\n从出资人的角度来讲，有担保的资产，首先有财产作为抵押，显而易见它是有一定保障的。它有正式的登记，所以无论是在上庭或者是在其他的这个强制执行的过程中，它是公开的记录。借款人违约的时候，债权人如果是有担保的债权人，你可以通过法定程序获取，从他的抵押资产中或它的收益中获得。通常有担保的这个债权，适用于大额的借款，他可以为出资人提供很高的信心，但与此同时，他会有一定的，相对比较低一点的利率，同时也就等于他会有相对低一点的风险，但是这种情况，通常受这个担保人这个借款协议上的条款制约，如果在借款人违约的时候，他逾期没有偿付这个贷款，这时候会自动变为高息的一个贷款。\r\n\r\n无担保债权的优势\r\n\r\n第一他申请的方式非常简单快捷。第二，它是比较适用于小额的借贷。第三，通常无担保的情况下，他会有相对应的高利率，无担保就等于高风险。\r\n\r\n有担保和无担保债权的劣势\r\n\r\n有担保资产的劣势，首先，申请过程相对更加复杂，在追讨债款的时候，要进行一系列的这个追讨的程序，或者是强制执行的程序，那它这个成本方面可能就会比较高。\r\n无担保债权最根本的劣势就是它没有保障，即便在后期追债执行的情况下，费用可能没有那么高，但是相对应的，你获得赔付能追回来借款的这个可能性也非常的低。再有一个很重要的就是，无担保贷款在进行强制执行的过程中，它的赔付排序很有可能远远的低于有担保债权。只有当有担保的债权人完全收回他的债款的时候，才有可能轮到无担保的债权人。\r\n\r\n以上就是本期海利大讲堂的内容了，希望大家听了今天的讲座能有所收获。\r\n\r\n（本文章只分享嘉宾观点，不构成投资及财务建议）	901d4e6a703f1566f7f0b0debb13fcb5.jpg	t	2022-04-06 12:52:41.326918	2022-07-04 15:58:29.923398	1	0	f
46	2021-10-19	Wall Street banks set to profit again when Fed withdraws pandemic stimulus	NEW YORK, Oct 15 (Reuters) - Wall Street banks have been among the biggest beneficiaries of the pandemic-era trading boom, fueled by the Federal Reserve's massive injection of cash into financial markets.\r\n\r\nWith the central bank nearing the time when it will start winding down its asset purchases, banks are set to profit again as increased volatility encourages clients to buy and sell more stocks and bonds, analysts, investors and executives say.\r\n\r\nThe Fed has been buying up government-backed bonds since March 2020, adding $4 trillion to its balance sheet, as part of an emergency response to the COVID-19 pandemic.\r\n\r\nThe strategy was designed to stabilize financial markets and ensure companies and other borrowers had sufficient access to capital. It succeeded but also resulted in unprecedented levels of liquidity, helping equity and bond traders enjoy their most profitable period since the 2007-09 financial crisis.\r\n\r\nThe top five Wall Street investment banks - JP Morgan Chase & Co (JPM.N), Goldman Sachs (GS.N), Bank of America (BAC.N), Morgan Stanley (MS.N) and Citigroup (C.N) - made an additional $51 billion in trading revenues last year and in the first three quarters of 2021, compared with the comparative quarters in the year prior to COVID, according to company earnings statements.\r\n\r\nThe trading bonanza, along with a boom in global deal-making, has helped bank stocks outperform the broader market. The KBW Bank index (.BKX) has risen by 40% in the year-to-date compared with a 19% advance in the S&P 500 (.SPX).\r\n\r\nNow, banks with large trading businesses are expected to profit a second time as the Fed starts to withdraw the stimulus, prompting investors to rejig their portfolios again.\r\n\r\nThird-quarter results from the biggest U.S. banks this week showed strong performances in equities trading, boosted by stocks hitting record highs, but a more subdued showing in bond trading reflecting calm in those markets.	42ea30e153616992e4a35738881638f6.jpeg	f	2021-10-19 11:31:27.209501	2022-07-05 09:40:19.729295	1	1	f
54	2022-04-21	海利大讲堂第44期-美联储启动加息循环对全球经济影响及投资展望	海利大讲堂第44期很荣幸邀请到了FXPlus Trading Academy的张彝伦院长来为大家分析美联储启动加息循环对全球经济影响及投资展望。 \r\n\r\n一、启动加息循环\r\n\r\n美联储在今年3月17日启动加息，但真正标准的说法叫做启动加息循环。利率本来是0%-0.25%，现在提高了25个基点，目标区停到了0.25%-0.5%的区间，是四年来的首次加息。加息，不是只加一次，加息利率周期其实是有加息循环波，会启动一连串的加息，之后会有一个平衡期，再接着就会有个减息循环波。 \r\n\r\n二、加息的原因 \r\n\r\n1. 美国的失业率已经降到了有史以来最低的3% \r\n\r\n2. 通货膨胀，美国物价指数和通货膨胀率已经将近8% \r\n\r\n美国目前的通货膨胀已经是这五六十年最高的水平，在这一情况下美联储无法理会俄罗斯跟乌克兰的战争的对经济的一些影响，还是坚定地启动了加息循环。 \r\n\r\n三、加息的幅度以及频率\r\n\r\n根据美联储的历史加息记录可以得到一个结论，每一轮加息大致是维持12个月，不排除更高到36个月。所以从2022年现在三月份开始加，可能会加到2023年年底。 \r\n\r\n四、对全球股市的影响 \r\n\r\n美联储加息的结论就是说第一个加息循环波，维持会一到三年，那加息的幅度大概2%-4%，加息的次数，不排除6到10次。第一次加息就是一个开弓箭，没有办法回头。市场在去年从九月份，去年第三季预测美联储大概今年第三月份会加息的时候，市场就是美元已经开始趋升了，过程中加息就会抑制通膨。股市在今年年初的时候，事实上已经受到了重挫，几乎从牛市进入熊市，但是在加息当天触底反弹，这个只能讲最近的股市是上市先预期反应。根据这个循环波还可以得出的结论是新兴市场资金会外逃，新货币会大幅贬值，这些货币主要可以说是金砖国家，南非币，土耳其币，巴西币，印度币，人民币啊，都有可能因此受到影响。根据今年的整体情况，价值股要优于成长股，但在未来的一个经济形势不是很确定的情况下，在整个资产配置当中，安全性的固定保本，有担保的固定收益还是最佳选择之一。 \r\n\r\n \r\n\r\n（本文章只分享嘉宾观点，不构成投资及财务建议） 	4cf505bad36960932aab64e1bee005ca.jpeg	t	2022-04-21 10:02:14.739039	2022-04-21 10:04:41.683465	1	0	f
55	2022-03-15	海利财经快讯 第53期 		40c3925b2471171885a4f45418072e7d.jpg	t	2022-04-21 13:24:04.163359	2022-07-06 16:18:22.13594	2	0	f
57	2022-07-04		海利大讲堂第56期-投资理财？投资人必须知道的那些财务架构与筹划	bbf0cbc95b735a6bfba72bae8a3c007a.jpg	t	2022-07-04 15:34:57.022335	2022-07-05 09:57:13.556144	1	0	f
56	\N	\N	\N	\N	t	2022-06-29 12:34:02.118691	2023-08-09 16:29:16.701	\N	\N	f
18	\N	\N	\N	\N	t	2021-07-19 15:15:49.377521	2023-08-09 16:38:26.933	\N	\N	f
45	\N	\N	\N	\N	f	2021-10-18 10:39:16.649436	2023-08-09 16:42:44.467	\N	\N	f
44	\N	\N	\N	\N	f	2021-10-18 10:30:16.427322	2023-08-09 16:42:45.468	\N	\N	f
43	\N	\N	\N	\N	f	2021-10-18 09:04:54.916344	2023-08-09 16:42:46.851	\N	\N	f
59	2022-07-06	海利大讲堂第56期-投资理财？投资人必须知道的那些财务架构与筹划	海利大讲堂第56期 很荣幸邀请到了特许税务顾问以及澳大利亚税务协会会员Jerry Wang 为大家分享投资理财需要知道的财务架构与筹划。 \r\n\r\n澳洲投资主体\r\n1.\t个人：无限责任，按个人所得税累进税率，直接持有，适用自用住房\r\n2.\t公司：有限责任，出于公司所得税25% 或30%， 固定股权比率，适用于独资或合作\r\n3.\t家庭信托：可预先责任，受益人先分后税，由于没人税务状况不同则无固定比例，适用于家庭成员\r\n4.\t单位信托：可有限责任，受益人先分后税，固定份额比例，适用于独资或合作\r\n5.\t自管养老金：与其限制于其他第三方super监管，可以选择自我管理养老金，可以自由西安则购买产品。 可有限责任，15% 或免税，成员共同决定投资方向，适用于高净值家庭\r\n澳洲税务身份：\r\n1.\t澳洲税务居民：通过四个法定测试（惯常居住测试，常住地测试，183天测试，养老金测试），限于PR 和citizen；全球收入进行征税；五级累进税率 0%-45%； 特点是￥18，200 起综合征税。\r\n2.\t非澳洲税务居民：通过四个法定测试；对澳洲收入进行征税；三级累进税率 32.5% -45% ；$0 起征税，其中利息股息分项征税\r\n3.\t澳洲临时税务居民： 持有临时居住签证；征税于澳洲收入且税率同于澳洲税务居民；常为留学签证持有人和处于永久签证等待期的人群等\r\n税务分类： \r\n1.\t个人所得税\r\na.\t澳洲税务居民：全球收入综合征税，起征点$18,200；征收2%的医疗保险税\r\nb.\t非澳洲税务居民： 来源于澳洲的收入征税，起征点$0； 不适用于2%的医疗保险税\r\n2.\t利息收入所得税\r\na.\t澳洲税务居民：五级累进税率\r\nb.\t非澳洲税务居民： 均为10%\r\n3.\t公司带股息分红收入所得税\r\na.\t澳洲税务居民： 五级累进税率\r\nb.\t非澳洲税务居民：0%\r\n4.\t资本利得收入所得税： \r\na.\t澳洲税务居民： 自住房无利得税；投资方持有超过12个月， 出售时享受资本利得税减免50%优惠，资本利得损失可抵扣当年其他资本利得收入；股票债券投资同投资房\r\nb.\t非澳洲税务居民：自住房无资本利得豁免；投资房出售时无50% 资本利得税优惠；股票和债券投资若非澳洲征税资产，则资本利得免税，但资本利损不能做抵扣。 \r\n\r\n（本文章只分享嘉宾观点和内容，不构成投资及财务建议）	5fe764bb450364bb691b388f8c0cc041.jpg	t	2022-07-06 15:08:50.502454	2022-07-06 15:09:01.763847	1	0	f
60	2022-07-05	海利大讲堂第55期-澳大利亚电力市场（NEM）的停摆事件与相关热点 	本期海利大讲堂很荣幸邀请到了澳大利亚注册会计师Dawei Huang为大家分享澳大利亚电力市场（NEM）的停摆事件与相关热点。 \r\n\r\n \r\n\r\n电网停摆事件的背景和相关热点： \r\n\r\nAEMO 于2022年6月15日 14:05 AEST发出暂停市场的公告，于2022年6月22日 14:00 AEST 重启市场 \r\n\r\n \r\n\r\n停摆事件的导火索源于六月初。昆士兰州电力现货价格连续七天均超过$670 / kWh,一些发电机厂退出可用性市场，再加上澳洲燃气电站发点成本过高（俄乌冲突及其国际连锁反应），导致澳大利亚电力市场能源短缺。  \r\n\r\n \r\n\r\n总体来讲，国际冲突，东海岸寒流导致高用电需求，大量发电厂的计划内停止运行 三方因素导致澳大利亚电力供应危机，而澳大利亚电价则飙涨到需要政府干预,。 因此，本次停摆事件发生。 \r\n\r\n \r\n\r\n近期电力市场及其价格回顾： \r\n\r\n除去停摆事件相关电价，一年电价总体上呈现先抑后扬趋势。其中昆士兰电价相对较高，塔州较低。  \r\n\r\n关于停摆事件，尽管AEMO 设置价格上限控制时长，但并未奏效。 于是被迫指示发电站运行时间以及计划电价。 干预适用于五千兆瓦电力。 同时新能源企业有新能源补贴政策简称LGC。 \r\n\r\n \r\n\r\n澳大利亚电力市场简介：  \r\n\r\n澳大利亚电力市场有国家电力市场（NEM），西南电力市场（SWIS）和西北电力市场（NWIS） 三个板块组成。 其中国家电力市场占全国电力市场百分之九十，是全世界自由度最高的电力市场之一。 国家电力市场又分为昆州，新州，维州，南澳和塔州五个电价区，有大约300个不同规模的大型电站项目。具体三个电力市场的装机容量，输电和配电网络请看youtube发布视频。 \r\n\r\n澳大利亚电力市场发展趋势： \r\n\r\n燃煤机组相继退役：由于澳大利亚煤炭资源丰富， 且相当部分资源位于相对容易开采的地表浅层，因而燃煤电站是澳大利亚传统主流的发呆女子安。 近年来部分大型燃煤电站已接近使用年限。护理费用高昂且存在安全隐患，部分大型燃煤电站业主选择关停这些电站。  \r\n\r\n碳中和碳达峰 \r\n\r\n国家电网升级规划： \r\n\r\n澳大利亚国家电力市场书店网络的设计和建造是为了将原有大型燃煤和燃气发电机组的电力传输到各个用电中心，并分配到家庭和企业等最终用户端。当前国家电力市场正处于大规模的能源结构转型时期，分布式能源增长迅速，形成数以百万计的分布式并网点。 伴随着使用间歇性新能源发电机组的比例不断增加，给澳大利亚国家电网的可靠性和稳定性带来新的挑战。  \r\n\r\n \r\n\r\n(本文章只分享嘉宾观点，不构成投资建议） 	37123109dd934b9386b983bae68020f0.jpg	t	2022-07-06 15:58:39.241584	2022-07-11 09:30:39.039451	1	0	f
61	2022-06-30	海利大讲堂第50期-《小心驶得万年船》【风险管理】思维成长记	本期海利大讲堂很荣幸邀请到河马财富创始人兼首席保险理财师，曾任职于Westpac和ANZ财富部的Jeffrey Liu来为大家分享题为”《小心驶得万年船》【风险管理】思维成长记“ 的投资理念。 \r\n\r\n \r\n\r\nJefferey 个人的投资三不原则：不谈“高收益无风险”的产品，不讲“短期致富“的立论以及不做“无法兑现”的承诺。 \r\n\r\n \r\n\r\n投资潜在风险： \r\n\r\n收入风险 & 破产风险 \r\n\r\n通胀风险，税务风险，市场风险 \r\n\r\n生活保障风险，子女教育风险 \r\n\r\n杠杆断裂，资产安全问题 \r\n\r\n \r\n\r\n养老金是合法合规的避税方式： \r\n\r\nGroup super ，比如industry super。选择局限性是group super最明显的弊端。 \r\n\r\nPersonal Super （个人养老金），可以提供个性化养老金收益。 \r\n\r\nSMSF是自管养老金. 可以最大限度为一个六个会员为上限的团体提供个性化理财。  \r\n\r\n \r\n\r\n养老金三大好处： \r\n\r\n一是税率低至15%的earning tax和10%的capital gain。 \r\n\r\n二是养老金可以提供资金链和资产安全的保障。其中有财产保障和默认保险两种保障。财产保障中有信托结构，债权人也不能追究其内资金。默认保险有人寿，意外伤残和收入保险等。 \r\n\r\n三是其投资灵活度。其中有团体养老金的默认投资， 个人养老金的投资组合和自管养老金的灵活选择。建议高净值顾客首选SMSF。SMSF可以根据个人需求，自由组合私募，IPO，地产等投资产品。 \r\n\r\n \r\n\r\n养老金的两个账户（具体数字讯息参考相关政府网页于1 July 2021更新的款项）： \r\n\r\n第一个是低税率的存款账户。存款账户会收取15% earning tax以及10% capital gain。税率远低于普通存款账户。其中有$27,500的concessional contribution 以及 $110,000 non-concessional contribution。 相比较高净值客户的个人高税收银行账户，养老金存款账户税率更低。 \r\n\r\n当然，55岁以上的客户，可考虑将存款账户$1.7 million 转入免税的退休账户（tax free）。退休账户的资金来源包含 lump sum payment 和 income stream。 \r\n\r\n \r\n\r\n因此，投资前需要注意规避风险，具体步骤可分为： \r\n\r\n投资前了解自己的财务状况和风险系数偏好 \r\n\r\n了解产品的风险和底层逻辑，在看回报率之外一定要测量产品的风险系数 \r\n\r\n结合两点评估投资产品是否在自己风险可承受范围之内 \r\n\r\n同时考量最高风险时，资产流失是否影响正常投资和生活。 \r\n\r\n(本文章只分享嘉宾观点，不构成投资建议）	35cc5bbe22df2d205559c89d5ddad500.jpg	t	2022-07-12 09:43:17.037028	2022-07-12 09:43:17.037028	1	0	f
62	2022-06-29	海利大讲堂第期-	本期海利大讲堂很荣幸邀请到了拥有16年生意经营者和多个基金项目投资人Ivan Lu为我们带来有关“长期主义者的投资之道“的分享。 \r\n\r\n \r\n\r\n必胜客的卖店经历令Ivan意识到，一味地努力工作却不思考未来局势并不会带来长期收益。 而后面的彩票零售店创业使Ivan意识到投资到未来看好行业产品的重要性。同时Ivan也意识到人生成就并不止步于事业，工作和财富。社交关系，健康，爱好，家庭关系等一样是人生意义所在。因此，Ivan建议大家花更多时间思考，把目光定睛在人生长期目标上。  \r\n\r\n \r\n\r\n这也是Ivan做出转卖其彩票零售店的重要原因。Ivan在转卖之前认为，尽管目前看来零售收益稳定，但是越来越多线下零售生意会转为线上。而一旦大家都发现了机会，市场份额会被占空。因此Ivan于2018年决定卖出零售彩票店，2019年初成功卖出店面。一年后，2020年初澳洲疫情开始，网上彩票行业发展迅速。 Ivan表示，尽管卖店金额有小损失，但是整体收益并未亏损。 联想到2020年零售店家关店，Ivan认为自己做出了一个当下比较正确的决定。 总体来讲，第二次卖店经历成功得益于思想提升，意识到线上零售已成趋势。 \r\n\r\n \r\n\r\nIvan认为，初期资本积累需要能力提升和工作收入，而长期的资本积累需要投资理念的加持。 Ivan目前的长期投资定睛在地产投资。其中澳洲稳定的土地价值和对投资发起人的信任是Ivan投资的主要原因。 \r\n\r\n \r\n\r\n最后，Ivan认为，在投资之前应该先学习风险和相关收益知识。投资人很难对不了解的产品和行业发表意见，但是当个人对相关行业产品有一定的了解，自己就可以独立做出投资决策。 \r\n\r\n（本文章只分享嘉宾观点，不构成投资及财务建议） 	cff99de7099a89b414ab257bc2f658f9.jpg	t	2022-07-12 15:15:10.424559	2022-07-12 15:15:10.424559	1	0	f
63	2022-06-28	海利大讲堂第48期-华人澳洲投资那些事	本期海利大讲堂我们有幸邀请到了 自身投资人，数家基金及财富管理机构董事 Chang Liu为大家带来“华人澳洲投资那些事”为题的华人投资环境分析。  \r\n\r\n \r\n\r\nChang 认为抵押债是目前较看好的投资方向。抵押债前期确认性很强，收益稳定且风险低。不仅如此，抵押债违约收益反而更高，比如延期还款所需金额大于基本还款金额。 投资人可以延期得到更多收益。 \r\n\r\n抵押债好处： \r\n\r\n一是不把鸡蛋放一个篮子。 \r\n\r\n二是一个基于长远利益眼光的稳定收益选择。抵押债有抵押物保证，同时专业基金公司的严谨和合规操作可以保证抵押债的安全可靠。当然，目前的澳洲降息现状以及更多市场份额切割使得利益降低，从最高的11%-12% 慢慢下滑。 但是澳洲的法律法规不断完善，以及澳洲适宜生存环境以及其他优势使得抵押债仍然是一个用于稳定收益的投资产品。 \r\n\r\n三是消息来源广泛。抵押债所需投资人数较多。华人投资人多数拥有房产，大家群策群力资讯共享。相比只从产品经理和纸上看到产品，消息渠道的扩张使得投资人集体更易做出正确决定。  \r\n\r\n \r\n\r\n(本文章只分享嘉宾观点，不构成投资及财务建议) 	2a8fcd99346904358575530186000f9f.jpg	t	2022-07-12 15:46:08.971488	2022-07-12 15:46:08.971488	1	0	f
64	2022-08-05	Beaver BC Forum Session 40th - Is the global economy heading for recession?	Beaver BC Forum Session 44th is honoured to invite Shi Heling, a professor of economics at Monash University, to analyze whether the global economy is entering a new financial crisis cycle. What is the most significant factor affecting the global economy? Prof. Shi: “The biggest factor affecting the global economy is the war between Russia and Ukraine. The war has always had a significant impact on the world economy. The goods that will be affected by this war in the short term are oil, natural gas, copper, tin, aluminium, etc. These products’ impact will inevitably affect each country’s inflation rate. Various countries will adopt monetary policies in response to the current high inflation. This monetary policy was called a contractionary monetary policy, a method of increasing interest by raising interest rates. At the same time, the war will also cause some difficulties in supply chain management for several industries; although Russia and Ukraine do not have too high positions in the global economy, they still play a pivotal role. In a few specific industries. These are short-term effects on the worldwide economy. Currently, a few argue that some relatively large economic conflicts will break out in March 2022, but I think it is unlikely that in 5 years, these effects are controllable. The impact on the oil and natural gas market? Prof. Shi: Russia is the leading supplier of oil and natural gas to Europe, so the crisis will significantly impact the oil and natural gas market. First, let’s look at Russia’s position in the international market in terms of oil and natural gas. Then Russia is the third-largest oil producer in the world, with a daily crude oil output of about 10 million barrels. Natural gas may account for a higher proportion because about 40% of Europe’s natural gas supply, especially in Germany, mainly depends on Russia. Therefore, when all economic sanctions are related to the collection of natural gas, Germany will be the first to oppose it. \r\nFor this reason, in the worst-case scenario, the financial time in the UK is the Financial Times, which predicts that oil prices are likely to rise to about $140 a barrel, so today it will be around $130, so there is still room for an increase of about $10. If this continues until the end of this year, the price of natural gas in Europe will continue to rise, increasing inflation in advanced economies by about 2%. Currently, the inflation rate in the United States is around 7.5%, and Europe’s is about 6%. Australia has always controlled the inflation rate very well. The current inflation rate is approximately 3.5%, more than Australia’s federal government. Limits of the Reserve Bank. But I am not too pessimistic about this oil and natural gas source, mainly because the United States has enormous oil reserves. The United States has no way to exert more significant influence on the international oil market because the first measure taken by the current Democratic Party government after President Biden took office was to prevent the development of new oil in the United States because of environmental protection and also the policy of no longer developing new oil fields in the continental United States. I think it is time for the United States to increase oil production. Under such conditions, I believe that the US government should make some changes.\r\nTherefore, although there is a problem with the oil supply and the rapid rise in oil prices, it should be brought under control soon, and the impact on the global economy should be temporary and controllable. Professor Shi said influence on the global financial market: “According to historical data, after World War II, after the end of World War II in 1945, every local war, if everyone invests in US stocks, is the same trend. After the fall, it will rise. Once the war breaks out, it will fall more, and this time is no exception. However, from the historical data perspective, the stock price will rise after a decline. Generally, it will increase by about 5% compared to the war’s beginning. It is estimated that this time is no exception, depending on when the war will end. If everyone is trading US stocks, now should be the time to buy long on dips. Therefore, if you have a capital allocation, in the US and Europe, from a fundamental point of view, the investment allocation should be reduced in Europe, and more capital allocation should be in the US market, whether That’s US stock or US bonds, some funds will also enter the Australian market, and returns will be higher. (This article only shares the views of the guests and does not constitute any investment and financial advice)\r\n	65f1d366cd2fd61fc3ff8b981392885f.jpg	t	2022-08-05 13:25:16.409212	2022-08-22 12:28:11.073866	1	1	f
65	2022-08-05	Beaver BC Forum Session 43rd - Secure Your Loan In Australia.	In this Beaver BC Forum Session 44th, we have invited Alva to explain loan protection in Australia. Alva is one of the senior managers of Greengate Advisory, at the same time, she is also a member of the Australian Restructuring Insolvency & Turnaround Association, a certified public accountant and a registered solicitor with more than 10 years of practical experience in liquidation and restructuring. As implied by the name, the difference between unsecured/secured loans is that an unsecured loan is a loan that is not secured by the assets used as collateral, it includes several aspects, one is the very common loan between friends or related households. The other is the credit situation that occurs in the process of doing business, for instance, the payment due date on the invoice will be 7 days, 14 days or even 1 month, in the case of no payment received, this non-payment is a type of unsecured claim. Finally, there is a case of personal guarantee. If there is no collateral for the loan, it is an unsecured claim. Let's look at the biggest difference between secured and unsecured claims. First of all, it must have a legal effect. A document that clearly states the detailed terms and nature of the security claim is usually the local government claim agreement which is more common, and there may also be several guarantee arrangements. In addition, the most crucial point under the Australian legal system is that it has a corresponding registration. The advantages of Secured Claims From an investor's point of view, collateral is primarily secured by assets guaranteed to a certain extent. If it is officially registered, it is a public record, whether in court or in any other enforcement process. When a borrower defaults on a debt, you can obtain it through legal proceedings, either from his collateral or proceeds, if the creditor is a secured creditor. This creditor's right is usually guaranteed and is suitable for large loans. It can provide investors with high confidence, but at the same time, he will have a specific relatively low-interest rate, which means that he will have a certain amount of interest and relatively low risk. However, this situation is usually limited by the terms of the guarantor's loan contract. If the borrower defaults and fails to repay the loan, it will become a high interest. The advantage of secured loans is that the application is straightforward, quick, and more suitable for small loans, and when there is no collateral, they will have a correspondingly high-interest rate, in which no collateral means high risk. The disadvantages of secured and unsecured loans The disadvantages of secured assets, first of all, the application process is relatively more complicated, when recovering debts, a series of recovery procedures or compulsory enforcement procedures must be carried out, so the cost may be fairly high. The most important disadvantage of unsecured debt is that it is not guaranteed. Even in the case of later debt collection execution, the cost may not be so high, but the possibility that you can get the interest and recover the loan is also very low.\r\nAnother crucial thing is that the unsecured creditors ranking in liquidation are likely far lower than secured loans. The secured creditors have a higher priority than the unsecured creditors. (This article only shares the views of the guests and does not constitute investment and financial advice)\r\n	b914e92c87e9cd5c145fd2e8560789e0.jpg	t	2022-08-05 13:27:33.591638	2022-08-22 12:28:13.932541	1	1	f
66	2022-08-05	Beaver BC Forum Session 44th - Impact of the FED's interest rate hike cycle on the global economy and investment forecast.	Beaver BC Forum Session 44th is honoured to invite Dean Zhang Yilun of FXPlus Trading Academy to analyse the impact of the Fed's beginning of an interest rate hike cycle on the global economy and investment forecast.\r\nI.\tBeginning of the interest rate hike cycles. \r\nA series of interest rate hikes will be initiated. The rate hike will start on March 17 this year; however, the primary standard is to begin the cycle of raising interest rates. The interest rate was originally 0%-0.25%, but now it has been increased by 25 basis points, and the target zone has stopped in the range of 0.25%-0.5%, which is the first rate hike in four years. The interest rate hike cycle is a cycle of interest rate hikes. After that, there will be a balance period, and then there will be a cycle of interest rate cuts.\r\nII.\tThe reason for raising interest rates\r\n1.\tThe US unemployment rate has dropped to an all-time low of 3%\r\n2.\tInflation, the US price index and inflation rate are nearly 8%. The current inflation in the United States has been at the highest level in the past 50 or 60 years. In this case, the Federal Reserve cannot pay attention to the economic impact of the war between Russia and Ukraine. The result or firmly started the interest rate hike cycle\r\nIII.\tThe magnitude and frequency of interest rate hikes \r\nAccording to the historical interest rate hike record of the Federal Reserve, a conclusion can be drawn that each round of interest rate hikes is roughly maintained for 12 months, and it cannot be ruled out that it will be as high as 36 months. As a result, starting in March 2022, it may be added until the end of 2023.\r\nIV.\tThe impact on the global stock market \r\nThe conclusion of the FED rate hike is a bullish cycle. The first interest rate will last from one to three years, and the rate of the interest rate increase is about 2% -4% and does not eliminate the possibility of rate hikes from 6 to 10 times. The first interest rate hike is a bow and arrow, and there is no way to turn back. When the market predicted that the FED would raise interest rates in the third quarter of last year from September 2021, the market believed that the US dollar had already begun to rise and that interest rate hikes would curb inflation. At the beginning of this year, the stock market suffered a heavy setback, almost from a bull market to a bear market, but bottomed out on the day of the rate hike. This action can only be said that the recent stock market is the first to react to the interesting hiking. Following this circular wave, it can also be concluded that the capital in emerging markets will flee away, and the emerging market currencies will depreciate significantly. These market currencies can mainly be said BRICS, South African, Turkish, Brazilian currency, Indian currency, and RMB, which have a chance of being affected by this scenario. According to the general situation this year, value stocks are better than growth stocks, but in a situation where the economic situation in the future is not very clear, in the entire asset allocation, the safe fixed capital preservation and guaranteed fixed income are still one of the best options. (This article only shares the views of the speaker and does not constitute any investment and financial advice)\r\n	5515ddb967809af29c6b0da62cca81ee.jpg	t	2022-08-05 13:30:31.16902	2022-08-22 12:28:15.977503	1	1	f
68	2022-08-05	Beaver BC Forum session 49th  - Long-termism investment Method	In this week’s Beaver BC Forums session 49th, we are honoured to invite Ivan Lu, a business operator with 16 and an investor in multiple fund projects, to share with us “the investment method of Long-termism “. The experience of opening a Pizza Hut store made Ivan realise that working hard without thinking about the future won’t bring long-term benefits. The subsequent lottery retail store business made Ivan realise the importance of investing to be optimistic about future industry products. At the same time, Ivan also acknowledges that achievement in life is not limited to career, work and wealth; social relationships, health, hobbies, family relationships, etc., are the meaning of life. Therefore, Ivan recommends that you spend more time thinking and focusing on your long-term goals in life. The above reasons are also crucial for Ivan to resell his lottery retail store. Before the store sale, Ivan believes that while retail sales appear to be stable for now, more offline retail businesses will shift to online businesses, and once everyone finds the opportunity, they will occupy the market. Therefore, Ivan decided to sell the retail lottery store in 2018 and successfully sold the storefront in early 2019. A year later, the Australian epidemic began in early 2020, and the online lottery industry developed rapidly. Ivan said there was a slight loss in the amount of the store, but the overall profit was not lost. Considering closing lottery stores in 2020, Ivan believes he has made a relatively correct decision. In general, the success of the second store opening experience is due to the improvement of thinking and realising that online retail has become a trend. Ivan believes that initial capital accumulation requires ability improvement and work income, while long-term capital accumulation requires the support of investment concepts. Ivan’s current long-term investments focus on real estate investments; among them, Australia’s stable land value and trust in investment sponsors are the main reasons for Ivan’s investment. Finally, Ivan believes that knowledge of risk and associated benefits should be learned before investing. It is difficult for investors to express opinions on products and industries that they do not understand, but when individuals have a specific understanding of products in related industries, they can make investment decisions independently. (This article only shares the views of the speaker and does not constitute investment and financial advice)	ec3dd2193755dd1bbc7c800c95c6ad09.jpg	t	2022-08-05 13:38:50.793804	2022-08-22 12:28:23.344994	1	1	f
69	2022-08-05	Beaver BC Forum session 50th - One Can Always Be Safe If One Is Careful, [Risk Management] Mind Growth investment philosophy	In this week of Beaver BC Forum session 50th, we are honoured to invite Jeffrey Liu, the founder and chief insurance financial planner of Hippo Wealth, who has worked in the Wealth Department of Westpac and ANZ, to share with you the topic of “One Can Always Be Safe If One Is Careful” [Risk Management] “Mind Growth Mind” investment philosophy\r\nJeffrey’s personal investment three principles: do not talk about “high-yield and risk-free” products, do not talk about “short-term wealth” arguments and do not make “unfulfilled” promises. Potential Investment Risks: Income Risk, Bankruptcy Risk, Inflation Risk, Tax Risk, Market Risk, Life Security Risk, Children’s Education Risk Leverage Broken, Asset Security Issues Pensions are a legal and compliant tax avoidance method: Group super, such as industry super. The limitation of selection is the most apparent disadvantage of group super. Personal Super (personal pension), which can provide personalised pension benefits. SMSF is self-managed superannuation.\r\nPersonalised financial management can be delivered to a group of six members. Three primary benefits of pensions: First, the tax rate is as low as 15% earning tax and 10% capital gain. Second, pensions can provide the guarantee of capital chain and asset security. Among them are two kinds of protection: property protection and default insurance. Property security has a trust structure, and the creditor cannot pursue the funds. Default insurance includes life, accidental disability and income insurance, etc. The third is its investment flexibility. Among them are default investments for group pensions, investment portfolios for individual pensions and flexible options for self-managed pensions. It is recommended that high net worth clients prefer SMSF. SMSF can freely combine private placement, IPO, real estate and other investment products according to individual needs.\r\nTwo accounts for pensions (for specific figures, please refer to the relevant government website for the updated payment on 1 July 2021): The first is a low-tax deposit account; deposit accounts will charge 15% earning tax and 10% capital gain, Tax rates are much lower than ordinary deposit accounts. There is a concessional contribution of $27,500 and a non-concessional contribution of $110,000. Pension deposit accounts are taxed lower than higher net worth clients’ high-tax bank accounts. Customers over 55 may consider transferring $1.7 million from their savings account to a tax-free retirement account (tax-free). Funding sources for retirement accounts include lump sum payments and income streams. Therefore, you need to pay attention to avoiding risks before investing. The steps can be divided into: Understand your financial situation and risk coefficient preference before investing, understand the product’s risks and underlying logic and measure the product’s risk coefficient in addition to looking at the rate of return. When evaluating whether the investment products are within the risk tolerance range and considering the highest risk, the loss of assets affects regular investment and life. (This article only shares the views of the speaker and does not constitute investment advice)\r\n	59aae8ce1788e30e5be96c0bd42493e8.jpg	t	2022-08-05 13:57:09.906702	2022-08-22 12:28:25.553151	1	1	f
70	2022-08-05	Beaver BC Forum session 55th - The National Electricity Market (NEM) shutdown and related hotspots	In this week's BC Forum session 55th, Beaver Holding Group is honoured to invite Dawei Huang, a certified public accountant in Australia, to share with you the shutdown events and related hotspots of the Australian Electricity Market (NEM).\r\nBackground and related hotspots of the grid shutdown event: AEMO announced to suspend the market at 14:05 AEST on June 15, 2022, and the market restarted at 14:00 AEST on June 22, 2022; the origin of the event shut down at the beginning of June. The spot price of electricity in Queensland has exceeded $670/kWh for seven consecutive days, and several generators have withdrawn from the available market, coupled with the high cost of Australian gas power plants (Russian-Ukrainian conflict and its international chain reaction), resulting in energy shortages in the Australian electricity market. In general, the international conflict, the East Coast cold snap led to high demand for electricity, the planned shutdown of a large number of power plants, the three-way factor caused the Australian power supply crisis, and the Australian electricity price soared to the point that government intervention is required. Review of the recent electricity market and its prices: Excluding the electricity price related to the shutdown event, the one-year electricity price generally declined and then increased. Among them, the electricity price in Queensland is relatively high, and Tasmanian is relatively low.\r\nIntervention applies to five gigawatts of electricity. Although AEMO set a price cap for the lockout event to control the duration, it did not work. Therefore, it is forced to indicate the operating hours of the power station and the planned electricity price. At the same time, new energy companies have a new energy subsidy policy called LGC. Introduction to the Australian Electricity Market: The Australian electricity market consists of three parts: the National Electricity Market (NEM), the Southwest Electricity Market (SWIS) and the Northwest Electricity Market (NWIS). Among them, the national electricity market accounts for 90% of the national electricity market, and it is one of the world's electricity markets with the highest degree of freedom. The national electricity market is divided into five electricity price regions: Queensland, New South Wales, Victoria, South Australia and Tasmania, with about 300 large-scale power station projects of different sizes. The development trend of the Australian electricity market: Coal-fired units have been decommissioned one after another: Australia is rich in coal resources, and a considerable part of the resources are located in relatively easy-to-mined shallow layers, coal-fired power plants are the traditional mainstream in Australia. Please watch the video on YouTube for the specific installed capacity of the three power markets, transmission and distribution networks. Recently, some large coal-fired power plants are approaching their service life. Due to the high cost of care and potential safety hazards, some owners of large coal-fired power plants choose to shut down these power plants. \r\nCarbon neutrality and carbon peaking State grid upgrade plan: The Australian National Electricity Market bookstore network is designed and constructed to transmit electricity from the original large coal-fired and gas-fired generator sets to various power centres and distribute it to households and businesses, etc. user terminals. The National Electricity Market Transmission Network of Australia is designed and constructed to transmit electricity from existing large coal-fired and gas-fired generator sets to various power centres and distribute it to households, businesses, and user terminals. Currently, the national electricity market is in the phase of large-scale energy restructuring, and distributed energy is developing rapidly, forming millions of distributed grid connection points. With an increasing proportion of new generating sets being interrupted, it challenges the reliability and stability of Australia's national grid. (This article only shares the views of the guests and is not investment advice)\r\n	961ff1b7eb3d7dc8b4f451ff7c47ab04.jpg	t	2022-08-05 13:59:04.890831	2022-08-22 12:28:31.089169	1	1	f
71	2022-08-05	56th BC Forum session- Investment and financial management? The financial structure and planning that investors must know.	In this week's BC Forum session 56th, Beaver Holding Group is honoured to invite Jerry Wang, a Chartered Tax Consultant and member of the Taxation Institute of Australia, to share with you the financial structure and planning that you need to know about investment and wealth management.\r\n\r\nAustralian investors:\r\n1.\tIndividuals: unlimited liability, the progressive tax rate of personal income tax, direct holding, applicable to self-use housing\r\n2.\tCompany: limited liability, subject to corporate income tax 25% or 30%, fixed shareholding ratio, for sole proprietorship or partnership\r\n3.\tFamily trust: can be liable in advance, the beneficiary will distribute the income first, and there is no fixed proportion because the family member has a different tax rate than other parties, applicable family members.\r\n4.\tUnit trust: limited liability, beneficiaries first share and then tax, fixed share ratio, suitable for sole proprietorship or cooperation.\r\n5.\tSelf-managed pension: Instead of being limited to other third-party superannuation supervision, you can choose to self-manage pensions and buy products freely. Members jointly decide the investment direction for limited liability, 15% or tax exemption, suitable for high-net-worth families.\r\n\r\nAustralian tax status:\r\n1.\tAustralian tax residents: Pass four statutory tests (habitual residence test, habitual residence test, 183-day test, pension test), limited to PR and citizen; global income is taxed; five-level progressive tax rate 0%-45%; The characteristic is the tax from A$18,200.\r\n2.\tNon-Australian tax resident: pass four statutory tests; tax Australian income; three-tier progressive tax rate 32.5% -45%; tax from $0, with interest and dividends taxed separately.\r\n3.\tAustralian Temporary Tax Resident: Holds a temporary resident visa; taxed on Australian income and at the same tax rate as Australian tax residents; often student visa holders and those in the permanent visa waiting period, etc.\r\n\r\nTax classification:\r\n1.\tPersonal income tax\r\na.\tAustralian Tax Residents: Global Income Tax, threshold of $18,200; 2% Medicare levy\r\nb.\tNon-Australian tax residents: taxed on Australian-sourced income with a threshold of $0; not applicable to the 2% Medicare levy\r\n2.\tIncome tax on interest income:\r\na.\tAustralian Tax Residents: Five-Tier Progressive Tax Rates\r\nb.\tNon-Australian tax residents: both 10%\r\n3.\tIncome tax on dividends paid by the company:\r\na.\tAustralian tax residents: five progressive tax rates\r\nb.\tNon-Australian tax residents: 0%\r\n4.\tIncome tax on capital gains:\r\na.\tAustralian tax residents: There is no income tax for owner-occupier's housing; investors who buy and hold the property for more than 12 months can get a 50% discount on capital gains tax when selling, and capital gains losses can be deducted from other capital gains income of the year; stock bond investment is the same as an investment property\r\nb.\tNon-Australian tax residents: No capital gains exemption for owner-occupiers; no 50% capital gains tax concession when investment properties are sold; if stock and bond investments are not Australian taxable assets, capital gains are exempt, but capital gains and losses cannot be deducted.\r\n\r\n(This article only shares the views and content of the speaker and does not constitute investment and financial advice)\r\n	3442c325d5f7357cfd369b2f35d54b41.jpg	t	2022-08-05 14:00:04.291403	2022-08-22 12:28:33.104587	1	1	f
72	\N	\N	\N	\N	f	2022-08-05 14:04:31.875632	2023-08-09 16:29:07.388	\N	\N	f
67	2022-08-05	BC Beaver Forum session 48th  - Things about Chinese Australian Investment	In this week’s BC Beaver Forum session 48th, we are honoured to invite Chang Liu, the director of a financial fund and wealth management institution, to bring you an analysis of the Chinese investment environment on the topic of “What Chinese invest in Australia.”. Chang believes that mortgage bonds are a more optimistic investment direction at present,\r\n Benefits: First, don’t put your eggs in one basket. Mortgage bonds have a high stable income and low risk; not only that, but the default yield of mortgage bonds is higher than others; for instance, the amount required for deferred repayment is greater than the basic repayment amount. The secondly is a stable income option based on long-term interests. Mortgage bonds are secured by collateral, and professional fund companies' rigorous and compliant operation can ensure the safety and reliability of mortgage bonds. The current interest rate cut in Australia and more market share cuts have reduced benefits, slowly declining from the highest 11%-12%. However, Australia’s laws and regulations continue to improve, and Australia’s living conditions and other advantages make mortgage bonds still an investment product for a stable income. Third, the sources of information are extensive. Mortgage bonds require more investment than other bonds. Most Chinese investors own real estate, and everyone works together to share information. The expansion of news channels makes it easier for investors collectively to make the right decisions than just seeing the product from the product manager and on paper. (This article only shares the views of the speaker and does not constitute investment and financial advice)\r\n	e882612300c1b2f104d12a1fcd4db97c.jpg	t	2022-08-05 13:37:16.586666	2022-08-22 12:28:18.528772	1	1	f
73	\N	\N	\N	\N	f	2022-08-05 14:17:28.108333	2023-08-09 16:16:09.016	\N	\N	f
74	\N	\N	\N	\N	f	2022-08-05 14:20:23.146805	2023-08-09 16:29:05.552	\N	\N	f
9	\N	\N	\N	\N	t	2021-07-14 09:43:46.439114	2023-08-09 16:29:38.937	\N	\N	f
75	\N	\N	\N	\N	f	2022-08-05 14:21:32.392558	2023-10-03 14:24:31.389	\N	\N	f
\.


--
-- Data for Name: news_imgs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_imgs (id, img, news_id, display_order, created_at, updated_at, del_flag) FROM stdin;
1	9f5283a60165bcef7f2f89dce6cbad14.png	4	1	2021-07-14 11:17:58.487527	2021-07-14 11:17:58.487527	f
3	cf28a1eefda2990870531be110442e37.png	4	3	2021-07-14 11:20:38.059695	2021-07-14 11:20:38.059695	f
4	6c56bfa37f9950c8b1c3e2b6411b4fc7.png	4	4	2021-07-14 11:21:08.637997	2021-07-14 11:21:08.637997	f
2	d07435e1abf0a898279ae74fd1c5e25a.png	4	2	2021-07-14 11:20:16.219891	2021-07-14 11:20:16.219891	f
5	650f3079c7d3c31b561984851326c876.png	18	1	2021-07-14 11:17:58.487527	2021-07-19 15:30:31.563668	f
6	e1990437d2e127e16231c1b4b4c3e70b.png	18	2	2021-07-14 11:20:16.219891	2021-07-19 15:30:53.860987	f
7	47250ff48c5a2e69cdc5eb28596e6647.png	18	3	2021-07-14 11:20:38.059695	2021-07-19 15:31:11.583943	f
8	1af905f75689fb8de84ea8f49598dca2.png	18	4	2021-07-14 11:21:08.637997	2021-07-19 15:31:29.095502	f
10	aaf47f4240c2cb3e27b2dd9a4b13f8fa.png	27	1	2021-08-09 14:01:22.086481	2021-08-09 14:01:38.343992	f
11	6c8a465d7ad3a9ce7c47fd94bfadf3d7.png	29	1	2021-08-17 13:02:27.333496	2021-08-17 13:02:27.333496	f
12	1fb5e465810760aa05d4799d286957c4.jpg	34	1	2021-08-26 14:39:53.934107	2021-08-26 14:39:53.934107	f
13	f82c1b67d893d0d686b117278a575c71.jpg	40	1	2021-10-07 08:31:03.523226	2021-10-07 08:31:03.523226	f
14	864dc4777bfb950f4e27fc7711be45cd.png	43	1	2021-10-18 09:07:09.924818	2021-10-18 09:07:09.924818	f
15	ea33698bd9815f1b3d694532205538f9.jpg	44	1	2021-10-18 10:30:47.748751	2021-10-18 10:30:47.748751	f
16	110c0ebb8d9a13772cfa7de9ab1b52fd.jpg	45	1	2021-10-18 10:40:22.232784	2021-10-18 10:40:22.232784	f
17	d108236994c4a48eed1231fd49dd748c.jpeg	46	1	2021-10-19 11:32:03.693159	2021-10-19 11:32:03.693159	f
\.


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification (id, client_id_arr, client_name_arr, is_all, title, message, created_at, updated_at, status, creator, file, title_cn, message_cn) FROM stdin;
19	{329}	{11}	f	3-3-2025	200 ok	2025-03-07 10:48:33.746184	2025-03-07 10:48:33.746184	NEW	1	\N	一	一
\.


--
-- Data for Name: notify_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notify_client (id, notify_id, client_id) FROM stdin;
\.


--
-- Data for Name: operate_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operate_log (id, entity_type, operate_type, content, entity_id, created_at, updated_at, creator, creator_name, entity_name) FROM stdin;
1234	Client	Create	{}	329	2025-03-07 10:31:05.381668	2025-03-07 10:31:05.381668	30	oliver@starx.com.au	11
1235	Fund	Create	{}	159	2025-03-07 10:33:24.413003	2025-03-07 10:33:24.413003	30	oliver@starx.com.au	11
1236	Entity	Create	{}	357	2025-03-07 10:42:23.269352	2025-03-07 10:42:23.269352	30	oliver@starx.com.au	333
1237	Investment	Create	{"fundName": "11", "clientName": "11", "unitCertificateDate": 1741304569367, "investmentEntityName": "333"}	1704	2025-03-07 10:42:47.770483	2025-03-07 10:42:47.770483	30	oliver@starx.com.au	
1238	Referral	Create	{}	30	2025-03-07 10:44:13.754852	2025-03-07 10:44:13.754852	30	oliver@starx.com.au	\N
1239	Fund	Update	{"purchase_min_amount": {"10000$": "10000"}, "application_form_two": {"1897792661261209600.png": ""}}	159	2025-03-11 09:45:25.64549	2025-03-11 09:45:25.64549	30	oliver@starx.com.au	11
\.


--
-- Data for Name: purchased_funds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchased_funds (id, client_id, fund_id, unit_certificate_date, purchase_amount, current_return, dividend_amount, dividend_cycle, created_at, updated_at, unit_certi, entity_name, address_line, suburb, state, postcode, country, uc_no, investment_entity_id, del_flag, transaction_date, application_form_signed, purchase_end_date, application_form_signed_two, application_form_signed_three, application_form_signed_four) FROM stdin;
1080	195	92	2023-10-02	1000000.00	\N	\N	\N	2023-11-15 13:13:01.787	2023-11-22 15:29:20.997	ab6a7994-7306-4c0b-9b05-d623a7a195a0.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2023-10-02	\N	\N	\N	\N	\N
1070	195	37	2023-08-10	200000.00	\N	\N	\N	2023-11-15 10:23:30.391	2023-11-22 15:29:57.974	9e749cb7-ed69-4f93-9bd4-fe0dcf437fb3.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2023-08-10	\N	\N	\N	\N	\N
1452	304	130	2024-08-13	500000.00	\N	\N	\N	2024-08-13 12:07:50.079	2024-10-09 14:56:39.844	BCDIOF-Unit_Certificate-(82)-146000[Entity_for_Test]20240814.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-13	\N	\N	\N	\N	\N
1409	294	119	2024-07-17	130000.00	\N	\N	\N	2024-07-17 10:04:04.778	2024-07-17 10:04:04.778	BCDIOF-Unit_Certificate-(69-B)-146242[Xiaofeng_Zhang]20240814.pdf	\N	20 Mahar Street	Kensington Gardens	SA	5068	\N	\N	296	f	2024-07-17	\N	\N	\N	\N	\N
1360	236	38	2024-06-01	250000.00	\N	\N	\N	2024-06-05 12:27:31.409	2024-07-11 11:14:37.999	099d74ea-ba59-4a4d-919a-7b09f18657b2.pdf	\N	3 GILMORE RD	DONCASTER	VIC\t	3108	\N	\N	117	f	2024-06-01	\N	2024-07-07	\N	\N	\N
1090	30	37	2023-11-01	500000.00	\N	\N	\N	2023-11-22 17:13:48.071	2024-07-12 14:48:49.967	8f75097f-4689-4cd1-bc41-49d26879919b.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-11-01	\N	2024-07-11	\N	\N	\N
1570	304	103	2023-10-18	100000.00	\N	\N	\N	2024-10-11 12:15:18.344	2024-11-05 10:38:34.974	BCDIOF-Unit_Certificate-(63-B)-000001[TEST_ENTITY]20241011.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-10-18	\N	2023-12-20	\N	\N	\N
1101	218	102	2023-11-28	500000.00	\N	\N	\N	2023-11-28 09:58:30.868	2023-11-28 09:58:30.868	540dd4ac-38ad-4c07-9485-0db69ab6e282.pdf	\N	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	240	f	2023-11-28	\N	\N	\N	\N	\N
1115	250	38	2023-12-01	250000.00	\N	\N	\N	2023-12-04 09:49:03.601	2023-12-04 11:14:34.493	d22fe9b5-9b14-428d-b78b-be2b99d115c1.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2023-12-01	1731465862377787392.pdf	2024-09-30	\N	\N	\N
1145	164	107	2023-12-14	100000.00	\N	\N	\N	2023-12-14 10:40:20.675	2023-12-14 10:40:20.675	c8e2c728-3cf0-44ac-bc39-95078099bc61.pdf	\N	47 Winfield Road	Balwyn North	VIC	3104	\N	\N	228	f	2023-12-14	1735082255669231616.pdf	\N	\N	\N	\N
1148	280	107	2023-12-13	100000.00	\N	\N	\N	2023-12-14 10:46:37.81	2023-12-14 10:46:37.81	df7a9e86-7e40-472c-b9bf-fa070dfafced.pdf	\N	6 Woodlands Avenue 	Camberwell 	VIC 	3124	\N	\N	283	f	2023-12-13	1735083837479682048.pdf	\N	\N	\N	\N
1232	124	115	2022-09-15	150000.00	\N	\N	\N	2024-02-20 10:46:10.307	2024-02-20 10:46:10.307	96bae458-9b70-4c9b-8019-9c6d6f0c5571.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2022-09-15	\N	2022-10-14	\N	\N	\N
1259	286	117	2022-03-02	100000.00	\N	\N	\N	2024-03-07 11:53:32.668	2024-03-07 11:53:32.668	e68801c2-8869-4fe4-b18a-31511becb7e3.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2022-03-02	\N	2022-09-02	\N	\N	\N
1282	169	38	2024-03-01	300000.00	\N	\N	\N	2024-04-02 15:21:00.346	2024-05-01 17:15:39.669	656b5a6c-69b1-4f37-9527-add3d75a5c9a.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2024-03-01	\N	2024-04-11	\N	\N	\N
1173	211	110	2023-12-21	200000.00	\N	\N	\N	2023-12-22 10:07:58.587	2024-05-20 09:17:06.516	d52dd4b0-629a-4ed1-bf51-612fc5bd27fc.pdf	\N	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2023-12-21	1737973212882354176.pdf	2024-05-06	\N	\N	\N
700	199	45	2023-03-01	\N	\N	\N	\N	2023-03-15 14:30:13.442	2023-03-16 15:26:51.721	d81f5e28-241a-46af-8cf7-1290e6dcf99d.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
38	39	2	2021-12-17	500000.00	\N	\N		2022-01-14 06:40:36.309131	2023-03-03 15:35:05.811	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
40	39	1	2021-12-17	500000.00	\N	\N		2022-01-18 08:18:58.923344	2023-03-03 15:35:12.104	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
1435	109	38	2024-08-01	250000.00	\N	\N	\N	2024-08-02 17:01:16.768	2024-08-02 17:01:16.768	BCDIOF-Unit_Certificate-146082[Wuxufamilysuperfund_Pty_Ltd_ATF_Wuxufamilysuperannuation]20240814.pdf	\N	6 Woodlands avenue	Camberwell	VIC	3124	\N	\N	170	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1474	29	141	2024-08-21	100000.00	\N	\N	\N	2024-08-21 16:46:03.841	2024-08-21 16:46:03.841	BCDIOF-Unit_Certificate-(90)-146036[Chang_Liu_ATF_Chang_Family_Trust]20240821.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2024-08-21	\N	\N	\N	\N	\N
1308	300	122	2024-03-20	100000.00	\N	\N	\N	2024-04-17 10:31:34.555	2024-08-23 10:51:44.431	BCDIOF-Unit_Certificate-(76-B)-146238[Rui_CAO]20240823.pdf	\N	U501a, 250 Liverpool Rd	Ashfield	NSW	2131	\N	\N	305	f	2024-03-20	1780393631652192256.pdf	2024-08-19	\N	\N	\N
1385	259	38	2024-06-26	250000.00	\N	\N	\N	2024-06-27 11:17:36.214	2024-08-29 17:07:53.218	BCDIOF-Unit_Certificate-146173[Evertree_Hw_Pty_Ltd_As_Trustees_For_Evertree_Family_Super_Fund]20240814.pdf	\N	17 Holmwood Ave	Brighton	VIC	3186	\N	\N	258	t	2024-06-26	1806134753414275072.pdf	2025-03-31	\N	\N	\N
1501	212	135	2024-09-02	100000.00	\N	\N	\N	2024-09-03 10:58:59.179	2024-09-03 10:58:59.179	BCDIOF-Unit_Certificate-(85)-146165[Rex_Investment_Consultants_Limited]20240903.pdf	\N	17 Davington Way	Burswood	Auckland, New Zealand	2013	\N	\N	101	f	2024-09-02	\N	\N	\N	\N	\N
1508	15	38	2024-09-01	250000.00	\N	\N	\N	2024-09-05 15:21:45.829	2024-09-05 15:21:45.829	BCDIOF-Unit_Certificate-146021[Jianxin_Liu]20240905.pdf	\N	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	\N	88	f	2024-09-01	\N	2025-05-31	\N	\N	\N
1146	201	107	2023-12-13	100000.00	\N	\N	\N	2023-12-14 10:41:33.116	2024-09-23 12:48:31.24	BCDIOF-Unit_Certificate-(67)-146162[Wenhui_WU]20240923.pdf	\N	2 Woods St	Balwyn	VIC	3103	\N	\N	129	f	2023-12-13	1735082559508807680.pdf	2024-06-07	\N	\N	\N
1512	298	38	2024-09-12	63363634.00	\N	\N	\N	2024-09-19 10:17:06.138	2024-09-19 10:17:18.593	BCDIOF-Unit_Certificate-146168[Nanhui_Investment_Pty_Ltd_ATF_Nanhui_Investment_Trust]20240919.pdf	\N	10 Chilcote Court	Box Hill South	VIC	3128	\N	\N	302	t	2024-09-12	1836560108416794624.pdf	2024-09-15	\N	\N	\N
1511	298	38	2024-09-17	250000.00	\N	\N	\N	2024-09-19 10:16:05.307	2024-09-30 14:39:10.981	BCDIOF-Unit_Certificate-146168[Nanhui_Investment_Pty_Ltd_ATF_Nanhui_Investment_Trust]20240930.pdf	\N	10 Chilcote Court	Box Hill South	VIC	3128	\N	\N	302	f	2024-09-17	1836559928623759360.pdf	2025-06-30	\N	\N	\N
1500	257	135	2024-09-02	1340000.00	\N	\N	\N	2024-09-03 10:57:27.978	2024-09-30 15:05:21.921	BCDIOF-Unit_Certificate-(85)-146201[Lijun_LIU]20240930.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-09-02	\N	2024-09-19	\N	\N	\N
1538	257	138	2024-09-20	170000.00	\N	\N	\N	2024-10-02 16:46:22.149	2024-10-02 16:46:22.149	BCDIOF-Unit_Certificate-(87)-146201[Lijun_LIU]20241002.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-09-20	\N	\N	\N	\N	\N
1336	101	127	2024-05-06	100000.00	\N	\N	\N	2024-05-07 10:14:38.573	2024-10-04 12:52:47.643	BCDIOF-Unit_Certificate-(79)-146079[Autstrip_Pty_Ltd_ATF_Lu_Family_Trust]20241004.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2024-05-06	1787637127622631424.pdf	2024-10-03	\N	\N	\N
1598	304	2	2024-10-20	99777.00	\N	\N	\N	2024-10-20 16:14:01.271	2024-10-20 16:37:56.264	BCDIOF-Unit_Certificate-146999[test_company]20241020.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-20	\N	\N	\N	\N	\N
1702	226	156	2024-12-01	200000.00	\N	\N	\N	2024-12-02 16:36:52.967	2024-12-02 16:36:52.967	BCDIOF-Unit_Certificate-(A)-146178[WANG_LUI]20241202.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2024-12-01	\N	2025-11-30	\N	\N	\N
1618	304	151	2024-10-22	12345.00	\N	\N	\N	2024-10-22 12:58:03.679	2024-10-22 13:01:05.703	BCDIOF-Unit_Certificate-(93-B)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1572	312	2	2024-10-14	100000.00	\N	\N	\N	2024-10-14 10:56:28.775	2024-10-31 12:14:35.197	BCDIOF-Unit_Certificate-146256[Ying_ZHANG]20241031.pdf	\N	Unit 9 6 Third Avenue	Everard Park	SA	5035	\N	\N	327	f	2024-10-14	\N	2025-07-31	\N	\N	\N
1679	174	156	2024-08-15	500000.00	\N	\N	\N	2024-10-31 14:52:17.623	2024-10-31 14:52:17.623	BCDIOF-Unit_Certificate-(A)-146114[Zhimin_HU]20241031.pdf	\N	198 Pennant Hills Road	Oatlands	NSW	2117	\N	\N	229	f	2024-08-15	\N	2025-08-31	\N	\N	\N
1681	207	156	2024-09-26	450000.00	\N	\N	\N	2024-10-31 14:54:15.306	2024-10-31 14:54:15.306	BCDIOF-Unit_Certificate-(A)-146163[Min_LIANG]20241031.pdf	\N	10 Boston Road	Balwyn	VIC	3103	\N	\N	92	f	2024-09-26	\N	2025-09-30	\N	\N	\N
1678	166	158	2024-10-18	300000.00	\N	\N	\N	2024-10-31 14:45:49.348	2024-11-11 10:36:42.228	BCDIOF-Unit_Certificate-(98)-146215[Juncheng_Investment_Pty_Ltd_ATF_Juncheng_Family_Trust]20241111.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	f	2024-10-18	\N	\N	\N	\N	\N
1071	195	39	2023-09-01	250000.00	\N	\N	\N	2023-11-15 10:24:06.137	2023-11-22 15:29:54.366	09f66898-efc5-44c7-ba89-043ac0fa4a04.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2023-09-01	\N	\N	\N	\N	\N
1260	60	37	2024-03-06	570000.00	\N	\N	\N	2024-03-07 12:12:38.773	2024-06-27 16:38:35.113	c4ec0cfa-dfb0-4551-933d-01e4f2d9460d.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2024-03-06	1765546064842014720.pdf	2024-06-25	\N	\N	\N
1509	172	38	2024-08-01	330000.00	\N	\N	\N	2024-09-06 09:36:40.299	2024-09-06 09:36:40.299	BCDIOF-Unit_Certificate-146116[Bo_LI]20240906.pdf	\N	139/120 Sturt St	Southbank	VIC	3006	\N	\N	223	f	2024-08-01	\N	2025-04-30	\N	\N	\N
479	171	38	2023-02-13	300000.00	\N	\N	\N	2023-03-03 18:43:06.172	2023-12-04 11:17:37.846	3f48e9dd-47d5-4a87-a1a5-85151f34bfd5.pdf	\N	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	90	t	2023-02-13	1636204534944313344.pdf	2023-11-30	\N	\N	\N
1513	304	134	2024-09-03	500000.00	\N	\N	\N	2024-09-19 10:17:44.241	2024-09-19 10:17:52.954	BCDIOF-Unit_Certificate-(FUND)-146000[Entity_for_Test]20240919.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-09-03	1836560268232359936.pdf	2025-09-03	\N	\N	\N
1091	64	2	2023-11-01	100000.00	\N	\N	\N	2023-11-22 17:20:58.325	2023-11-22 17:20:58.325	7ae82d48-0e3d-430f-a3bb-fd8de18b37ed.pdf	\N	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-11-01	\N	2024-08-31	\N	\N	\N
1092	69	37	2023-11-01	500000.00	\N	\N	\N	2023-11-22 17:23:32.469	2023-11-29 16:05:13.722	13ef2797-9ecf-4984-b1bc-d04db4654a74.pdf	\N	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2023-11-01	\N	2024-11-30	\N	\N	\N
1116	171	38	2023-02-13	300000.00	\N	\N	\N	2023-12-04 11:18:23.587	2023-12-04 11:51:10.597	3199f3a3-daee-42c5-b0b9-b89d4b3f477f.pdf	\N	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	277	f	2023-02-13	1731467952235892736.pdf	2023-11-30	\N	\N	\N
1147	127	107	2023-12-13	100000.00	\N	\N	\N	2023-12-14 10:43:39.838	2023-12-14 10:45:00.5	a3f2dee0-06a1-4353-8475-5752ccace8fa.pdf	\N	 19B Arlington Drive\t	Glen Waverley\t	VIC \t	3150\t	\N	\N	205	f	2023-12-13	1735083091015204864.pdf	\N	\N	\N	\N
1174	263	111	2023-12-14	200000.00	\N	\N	\N	2023-12-22 10:43:26.406	2023-12-22 10:43:26.406	3ac83096-cd20-4d3d-afb7-eeed7b6837f2.pdf	\N	L6, C1 / 90 Nguyen Binh Khiem Street	Rach Gia City 	Kien Giang, Vietnam	920000 	\N	\N	261	f	2023-12-14	1737982137602097152.pdf	\N	\N	\N	\N
1233	174	102	2024-02-08	2000000.00	\N	\N	\N	2024-02-22 13:42:53.86	2024-02-22 13:42:53.86	4151f5d3-5e2f-4b53-8014-e7ccaaed0772.pdf	\N	198 Pennant Hills Road	Oatlands	NSW	2117	\N	\N	229	f	2024-02-08	1760495347244687360.pdf	2025-08-31	\N	\N	\N
1514	304	134	2024-09-12	500000.00	\N	\N	\N	2024-09-19 10:18:16.041	2024-09-19 10:18:24.047	BCDIOF-Unit_Certificate-(FUND)-146000[Entity_for_Test]20240919.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-09-12	1836560401611227136.pdf	2025-09-12	\N	\N	\N
1283	294	121	2024-04-03	200000.00	\N	\N	\N	2024-04-03 16:54:02.065	2024-04-03 16:54:02.065	f2520b6e-dfd6-48b7-89db-d47422895b8c.pdf	\N	20 Mahar Street	Kensington Gardens	SA	5068	\N	\N	296	f	2024-04-03	1775401350872416256.pdf	\N	\N	\N	\N
1337	29	127	2024-05-06	45000.00	\N	\N	\N	2024-05-07 10:16:55.78	2024-10-04 12:50:58.92	BCDIOF-Unit_Certificate-(79)-146036[Chang_Liu_ATF_Chang_Family_Trust]20241004.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2024-05-06	1787637703118888960.pdf	2024-10-03	\N	\N	\N
1309	209	38	2024-04-01	250000.00	\N	\N	\N	2024-04-19 10:35:22.622	2024-05-07 15:00:41.442	2dfc1056-33c1-4448-b105-70dee5b8a553.pdf	\N	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2024-04-01	\N	2024-04-17	\N	\N	\N
701	199	70	2023-03-01	\N	\N	\N	\N	2023-03-15 14:30:27.834	2023-03-16 15:27:07.204	43c5f10a-d9fb-40b9-8a70-e653b6ee3eed.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1539	319	153	2023-11-14	100000.00	\N	\N	\N	2024-10-08 10:57:18.348	2024-10-08 10:57:18.348	BCDIOF-Unit_Certificate-(66)-146213[Adam_&_Nadine_Macbeth]20241008.pdf	\N	6 Armidale Cres	Castle Hill	NSW	2154	\N	\N	343	f	2023-11-14	\N	2024-05-29	\N	\N	\N
1453	304	39	2024-08-13	500000.00	\N	\N	\N	2024-08-13 15:35:30.388	2024-10-09 14:56:36.838	BCDIOF-Unit_Certificate-146000[Entity_for_Test]20240814.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-13	\N	\N	\N	\N	\N
1507	304	141	2024-09-01	10000.00	\N	\N	\N	2024-09-04 21:06:20.44	2024-10-09 14:57:28.052	BCDIOF-Unit_Certificate-(90)-11111[testnew0824172477]20240904.pdf	\N	test	test	test	2009900	\N	\N	336	t	2024-09-01	\N	2024-10-31	\N	\N	\N
1362	302	37	2024-06-03	1000000.00	\N	\N	\N	2024-06-07 11:48:13.203	2024-10-09 14:57:47.738	59760802-9560-4f85-807b-0f313c46e8f7.pdf	\N	Fake add	Fake sub	Fake State	99999	\N	\N	307	t	2024-06-03	\N	2025-06-30	\N	\N	\N
1386	180	37	2024-06-25	610000.00	\N	\N	\N	2024-06-27 12:21:19.587	2024-07-04 15:10:55.233	BCDIOF-Unit_Certificate-146113[Jingwen_CUI]20240814.pdf	\N	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2024-06-25	1806150789735833600.pdf	2024-06-30	\N	\N	\N
1436	171	38	2024-08-01	303000.00	\N	\N	\N	2024-08-02 17:03:22.894	2024-08-02 17:03:22.894	BCDIOF-Unit_Certificate-146117[ONE_REED_PTY_LTD_ATF_ONE_REED_SUPER_FUND]20240814.pdf	\N	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	90	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1442	283	135	2024-08-07	200000.00	\N	\N	\N	2024-08-07 16:09:29.467	2024-08-07 16:09:29.467	BCDIOF-Unit_Certificate-(85)-146255[Peng_LI]20240814.pdf	\N	6A ROSLYN AVE	ROSEVILLE	NSW	2069	\N	\N	326	f	2024-08-07	\N	\N	\N	\N	\N
1475	261	135	2024-08-22	100000.00	\N	\N	\N	2024-08-22 09:49:29.571	2024-08-22 09:49:29.571	BCDIOF-Unit_Certificate-(85)-146203[Guanyu_CHEN]20240822.pdf	\N	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	\N	266	f	2024-08-22	\N	\N	\N	\N	\N
1573	304	2	2024-10-14	99999999.00	\N	\N	\N	2024-10-14 11:17:54.872	2024-10-14 11:21:40.324	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-14	\N	\N	\N	\N	\N
1599	304	2	2024-10-20	777777.00	\N	\N	\N	2024-10-20 16:15:10.79	2024-10-20 16:15:34.329	BCDIOF-Unit_Certificate-146999[test_company]20241020.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-20	\N	\N	\N	\N	\N
1682	326	137	2024-08-08	100000.00	\N	\N	\N	2024-10-31 15:04:16.608	2024-10-31 15:04:16.608	BCDIOF-Unit_Certificate-(86)-146260[Bowwood_Road_Pty_Ltd_ATF_Bowwood_Road_Superannuation_Fund]20241031.pdf	\N	19 Kenneth St	Tamarama	NSW	2026	\N	\N	350	f	2024-08-08	\N	\N	\N	\N	\N
1410	304	134	2022-07-28	500000.00	\N	\N	\N	2024-07-17 11:17:01.587	2024-11-05 10:37:32.17	862e61e3-9ae9-457c-982c-7fe779ba7f1b.pdf	\N	TEST	TEST	TEST	0000	\N	\N	311	t	2022-07-28	\N	\N	\N	\N	\N
1619	304	146	2024-10-22	12345.00	\N	\N	\N	2024-10-22 13:02:16.851	2024-11-05 10:39:47.742	BCDIOF-Unit_Certificate-(94)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1502	304	134	2024-08-23	100000.00	\N	\N	\N	2024-09-03 14:36:24.969	2024-11-05 10:40:05.087	BCDIOF-Unit_Certificate-(FUND)-146999[test_company]20240903.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-08-23	\N	\N	\N	\N	\N
1571	304	106	2023-10-02	100000.00	\N	\N	\N	2024-10-11 12:36:41.807	2024-11-05 10:40:55.522	BCDIOF-Unit_Certificate-(62)-000001[TEST_ENTITY]20241011.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-10-02	\N	2023-12-02	\N	\N	\N
1703	328	38	2024-12-02	250000.00	\N	\N	\N	2024-12-03 10:00:06.043	2024-12-03 10:00:06.043	BCDIOF-Unit_Certificate-146267[Junjun_ZHANG]20241203.pdf	\N	3504/466 Tianbao Road	Hongkou	Shanghai	200086	\N	\N	356	f	2024-12-02	\N	2025-09-30	\N	\N	\N
1074	195	40	2022-06-01	150000.00	\N	\N	\N	2023-11-15 10:26:30.078	2023-11-22 15:29:44.489	8a9453ce-3352-4124-b6e9-67759cbba616.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2022-06-01	\N	\N	\N	\N	\N
1073	195	2	2022-09-07	200000.00	\N	\N	\N	2023-11-15 10:25:42.343	2023-11-22 15:29:47.804	fe1e3d35-3ef2-4523-9613-8128d54d5056.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2022-09-07	\N	\N	\N	\N	\N
136	125	9	2022-08-12	50000.00	\N	\N	\N	2022-08-12 15:45:30.399561	2023-03-17 10:07:42.471	700d7aa4-b6f8-401e-a263-f7296f76418d.pdf	Parque Edition ATF Parque Edition Investment Trust 	85 Nurlendi Rd	Vermont	VIC 	3133	\N	\N	\N	f	2022-08-12	1636504542910427136.pdf	2022-09-25	\N	\N	\N
1072	195	73	2023-09-05	300000.00	\N	\N	\N	2023-11-15 10:24:44.392	2023-11-22 15:29:51.069	27ba2622-da24-4a56-8a28-d61d5d307791.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2023-09-05	\N	\N	\N	\N	\N
1207	254	110	2024-01-11	100000.00	\N	\N	\N	2024-01-19 17:01:13.269	2024-05-15 15:29:01.456	c779dc7a-7c60-440d-8202-27646e344c0c.pdf	\N	5 Rubens Court\t	Wheelers Hill	VIC	3150	\N	\N	253	f	2024-01-11	1748224069641146368.pdf	2024-05-06	\N	\N	\N
1149	29	110	2023-12-13	100000.00	\N	\N	\N	2023-12-14 10:52:10.236	2024-05-20 09:21:34.654	56403c37-4be4-45cb-bafb-424a113c1017.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2023-12-13	1735085231779577856.pdf	2024-05-06	\N	\N	\N
1363	255	37	2024-06-06	1250000.00	\N	\N	\N	2024-06-07 14:43:26.524	2024-06-07 14:43:26.524	c470cade-1be6-4368-b629-1f9afc2cf5cc.pdf	\N	Ground Floor, 187 Thomas Street	HAYMARKET	NSW	2000	\N	\N	289	f	2024-06-06	1798938797006573568.pdf	2025-06-30	\N	\N	\N
1117	119	37	2023-05-17	700000.00	\N	\N	\N	2023-12-04 15:59:20.78	2023-12-04 16:23:45.475	7fc4435d-ea97-4670-86c6-681374b7c6f9.pdf	\N	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	278	f	2023-05-17	\N	2024-05-31	\N	\N	\N
1102	276	40	2023-11-28	50000.00	\N	\N	\N	2023-11-29 14:42:08.484	2023-12-07 16:42:07.65	8ab7977d-481b-466f-88d4-b24ccc236e6e.pdf	\N	40 Berith St	Auburn	NSW 	2144	\N	\N	276	f	2023-11-28	1729707287931744256.pdf	2024-03-31	\N	\N	\N
1175	208	37	2023-12-29	500000.00	\N	\N	\N	2024-01-02 15:35:00.418	2024-01-02 15:35:21.938	4075c98c-38d5-49ed-9fce-0374001a6038.pdf	\N	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2023-12-29	1742041779412033536.jpg	2024-12-31	\N	\N	\N
152	131	11	2022-08-17	100000.00	\N	\N	\N	2022-08-25 15:42:49.365205	2023-03-14 17:57:03.857	d9962079-6626-4598-9f50-43875d0705b1.pdf	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	280 Springvale Road	Glen Waverley	VIC	3150	\N	BCFCT3-1-146024	\N	f	2022-08-17	\N	2023-02-18	\N	\N	\N
163	119	14	2022-08-17	100000.00	\N	\N	\N	2022-08-26 08:19:46.263074	2023-03-08 17:32:23.493	0d911803-c818-44fb-8138-0707b801c6e8.pdf	\N	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-08-17	\N	2023-02-18	\N	\N	\N
1261	167	37	2024-03-06	550000.00	\N	\N	\N	2024-03-07 12:18:20.907	2024-03-07 16:53:01.248	e07ced11-ab4e-4477-8733-acaa27fc38bd.pdf	\N	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2024-03-06	1765616623412002816.jpg	2025-03-31	\N	\N	\N
1411	308	134	2022-07-20	500000.00	\N	\N	\N	2024-07-17 16:58:33.523	2024-07-18 14:33:02.265	c68acf68-7d55-4414-bd40-03d5b50fac1c.pdf	\N	TEST	TEST	TEST	0000	\N	\N	315	t	2022-07-20	\N	\N	\N	\N	\N
1234	167	37	2024-02-26	500000.00	\N	\N	\N	2024-02-26 16:26:02.449	2024-04-02 15:03:02.153	233d9b6e-ff1f-4006-b163-7248127813e4.pdf	\N	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2024-02-26	1761985955125739520.jpg	2024-03-27	\N	\N	\N
201	152	5	2022-09-14	100000.00	\N	\N	\N	2022-09-15 10:15:50.619276	2023-03-06 16:15:57.745	e990a595bd229879829b1e118fa592a4.pdf						\N		\N	t	\N	\N	\N	\N	\N	\N
1284	212	122	2024-03-28	100000.00	\N	\N	\N	2024-04-03 17:07:06.433	2024-04-03 17:07:06.433	e0a02248-7dd2-44e7-acb7-fd5aeb10d45d.pdf	\N	17 Davington Way	Burswood	Auckland, New Zealand	2013	\N	\N	101	f	2024-03-28	1775404640750256128.pdf	\N	\N	\N	\N
202	152	18	2022-08-30	500000.00	\N	\N	\N	2022-09-15 10:16:32.610184	2023-03-03 17:48:48.604	cc851b742cb29304599529de45158b14.pdf						\N		\N	t	\N	\N	\N	\N	\N	\N
1310	209	37	2024-04-18	500000.00	\N	\N	\N	2024-04-19 10:39:15.945	2024-04-19 10:39:15.945	8ebff7d5-fa11-4bad-912e-702aacdc8a9b.pdf	\N	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2024-04-18	1781120342597509120.pdf	2025-04-30	\N	\N	\N
1093	257	107	2023-11-22	1400000.00	\N	\N	\N	2023-11-23 13:44:28.501	2024-08-02 12:26:29.321	69fda12c-0ca0-4686-9d42-f63c43622f04.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2023-11-22	1727518448435896320.pdf	2024-07-25	\N	\N	\N
1443	166	2	2022-11-02	500000.00	\N	\N	\N	2024-08-08 17:27:05.7	2024-08-08 17:27:05.7	93dbdb19-d10b-475f-8a8e-cbaada744948.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	275	f	2022-11-02	\N	2023-08-31	\N	\N	\N
1444	166	38	2023-06-01	300000.00	\N	\N	\N	2024-08-08 17:29:12.383	2024-08-08 17:29:12.383	afc11599-0ba2-4e59-8204-51762b4c4127.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	275	f	2023-06-01	\N	2023-08-31	\N	\N	\N
1437	250	38	2024-08-01	250000.00	\N	\N	\N	2024-08-02 17:08:45.622	2024-08-02 17:08:45.622	BCDIOF-Unit_Certificate-146197[Shelford_Enterprise_Pty_Ltd_ATF_Shelford_Family_Trust]20240814.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1387	109	38	2024-06-27	250000.00	\N	\N	\N	2024-06-27 13:48:40.503	2024-06-27 13:48:40.503	BCDIOF-Unit_Certificate-146082[Wuxufamilysuperfund_Pty_Ltd_ATF_Wuxufamilysuperannuation]20240814.pdf	\N	6 Woodlands avenue	Camberwell	VIC	3124	\N	\N	170	f	2024-06-27	1806172771730776064.pdf	2025-03-31	\N	\N	\N
1440	274	38	2024-08-01	250000.00	\N	\N	\N	2024-08-02 17:11:44.676	2024-08-02 17:11:44.676	BCDIOF-Unit_Certificate-146209[ACY_Holding_Pty_Ltd]20240814.pdf	\N	76A TRIMMER PDE\t	SEATON\t	SA\t	5023	\N	\N	272	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1383	275	132	2024-06-19	3615000.00	\N	\N	\N	2024-06-26 14:58:31.372	2024-06-26 14:58:31.372	BCDIOF-Unit_Certificate-(83-A)-146177[Yinghong_XING]20240814.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2024-06-19	\N	\N	\N	\N	\N
1476	276	135	2024-08-22	100000.00	\N	\N	\N	2024-08-22 09:50:57.216	2024-08-22 09:50:57.216	BCDIOF-Unit_Certificate-(85)-146216[Wenli_WANG]20240822.pdf	\N	40 Berith St	Auburn	NSW 	2144	\N	\N	276	f	2024-08-22	\N	\N	\N	\N	\N
1510	272	39	2024-09-10	150000.00	\N	\N	\N	2024-09-12 14:59:30.502	2024-09-12 15:07:45.92	BCDIOF-Unit_Certificate-146211[Xiangjiang_Wang]20240912.pdf	\N	Unit 18/1 Kensington St\t	Kogarah\t	NSW\t	2217	\N	\N	269	f	2024-09-10	1834096541096435712.pdf	2025-06-30	\N	\N	\N
1515	162	39	2024-09-01	200000.00	\N	\N	\N	2024-09-19 21:14:59.377	2024-09-19 21:14:59.377	BCDIOF-Unit_Certificate-146106[WZH_Pty_Ltd]20240919.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	29	f	2024-09-01	\N	2025-05-31	\N	\N	\N
1286	168	121	2024-03-26	300000.00	\N	\N	\N	2024-04-03 17:13:59.821	2024-09-30 15:08:50.193	BCDIOF-Unit_Certificate-(76-A)-146110[Yingda_Xu]20240930.pdf	\N	21 Acheron Avenue	Camberwell	VIC	3124	\N	\N	230	f	2024-03-26	1775406374625198080.pdf	2024-09-30	\N	\N	\N
1503	60	37	2024-08-28	510000.00	\N	\N	\N	2024-09-03 16:25:42.271	2024-09-03 16:25:42.271	BCDIOF-Unit_Certificate-146056[Xiandong_GAO]20240903.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou,	Wulumuqi	Xinjiang, Uyghur, China	830063	\N	\N	176	f	2024-08-28	\N	2025-08-31	\N	\N	\N
1338	31	127	2024-05-07	350000.00	\N	\N	\N	2024-05-07 12:12:04.845	2024-10-04 12:51:38.48	BCDIOF-Unit_Certificate-(79)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20241004.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-05-07	1787666681833660416.pdf	2024-10-03	\N	\N	\N
1540	320	153	2023-11-07	280000.00	\N	\N	\N	2024-10-08 11:14:41.611	2024-10-08 11:14:41.611	BCDIOF-Unit_Certificate-(66)-146218[Alex_Gambotto]20241008.pdf	\N	9 Dickson Ave	Artarmon	NSW	2064	\N	\N	344	f	2023-11-07	\N	2024-05-29	\N	\N	\N
1574	304	2	2024-10-14	999999.00	\N	\N	\N	2024-10-14 11:22:10.894	2024-10-14 14:31:56.289	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-14	\N	\N	\N	\N	\N
1620	304	151	2024-10-22	12345.00	\N	\N	\N	2024-10-22 13:20:08.742	2024-10-22 13:21:20.619	BCDIOF-Unit_Certificate-(93-B)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	2025-10-31	\N	\N	\N
1441	304	134	2024-08-04	100000.00	\N	\N	\N	2024-08-05 17:27:35.454	2024-11-05 10:37:12.148	BCDIOF-Unit_Certificate-(FUND)-146000[Entity_for_Test]20240814.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-04	1821370921265340416.png	\N	1821371022230626304.png	\N	\N
1049	233	103	2023-10-12	100000.00	\N	\N	\N	2023-11-01 17:08:23.767	2023-11-29 15:11:17.579	a0140811-ddae-4e3f-9fc3-0a89c8bdad6e.pdf	\N	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2023-10-12	\N	2023-11-27	\N	\N	\N
1014	266	103	2023-10-12	200000.00	\N	\N	\N	2023-10-12 14:33:07.863	2023-11-29 15:12:42.015	cb544e43-cd83-4137-9da8-aef8f1ccb104.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	\N	\N	\N	265	f	2023-10-12	1712310402758066176.pdf	2023-11-27	\N	\N	\N
1235	208	117	2024-02-29	130000.00	\N	\N	\N	2024-02-29 14:43:08.551	2024-07-04 17:36:02.7	c9a20a54-663b-4686-b2ad-0f4d726c5640.pdf	\N	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2024-02-29	1763050518311026688.pdf	2024-06-12	\N	\N	\N
1103	31	103	2023-11-28	61729.00	\N	\N	\N	2023-11-29 15:03:05.133	2023-11-29 15:14:52.505	f06e079e-2099-4930-be9b-2e8b9f089c54.pdf	\N	47 ERICA AVE.\t	GLEN IRIS\t	VIC\t	3146	\N	\N	105	t	2023-11-28	\N	2023-11-28	\N	\N	\N
211	119	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:16:33.964527	2023-03-14 17:23:26.913	dd6074ae10f6f6cee530a6efa76023c6.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	BCFCT7-146028	\N	t	\N	\N	\N	\N	\N	\N
1107	233	103	2023-11-28	39318.00	\N	\N	\N	2023-11-29 15:10:49.377	2024-05-20 09:23:09.146	ca8e1b8d-f96c-40df-b303-03ac6680f5e8.pdf	\N	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2023-11-28	\N	2024-05-03	\N	\N	\N
1179	168	37	2023-12-01	600000.00	\N	\N	\N	2024-01-03 11:31:02.28	2024-01-03 11:52:34.133	01f906fd-bfa3-49c5-b842-e8751ae56fc8.pdf	\N	21 Acheron Avenue	Camberwell	VIC	3124	\N	\N	230	f	2023-12-01	\N	2024-11-30	\N	\N	\N
1208	231	37	2023-12-04	1000000.00	\N	\N	\N	2024-01-23 15:27:32.655	2024-01-23 15:28:01.758	d21f083c-a748-44d4-8cdb-c89161e9e8d2.pdf	\N	\N	\N	\N	\N	\N	\N	241	f	2023-12-04	1749650046455877632.jpg	2024-12-31	\N	\N	\N
1105	266	103	2023-11-28	78636.00	\N	\N	\N	2023-11-29 15:03:32.029	2024-05-20 09:24:08.376	388d0a9c-6975-4245-99d6-6b5d342ae2a2.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	\N	\N	\N	265	f	2023-11-28	\N	2024-05-03	\N	\N	\N
1096	162	39	2023-11-01	200000.00	\N	\N	\N	2023-11-23 14:31:08.863	2023-11-23 14:31:08.863	57ea1fd0-9d59-4875-aea3-7497f1797b49.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	29	f	2023-11-01	\N	2024-08-31	\N	\N	\N
1099	176	38	2023-11-01	250000.00	\N	\N	\N	2023-11-23 14:40:02.798	2023-11-23 14:40:02.798	b654b316-5074-4661-9f90-37188dec8553.pdf	\N	\N	\N	\N	\N	\N	\N	32	f	2023-11-01	\N	2024-08-31	\N	\N	\N
1094	123	37	2023-11-01	500000.00	\N	\N	\N	2023-11-23 14:28:36.729	2023-11-29 10:20:48.951	65c1042e-79a7-41a6-a2b8-8cb386fbc683.pdf	\N	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	\N	245	f	2023-11-01	\N	2024-11-30	\N	\N	\N
1150	191	111	2023-12-13	150000.00	\N	\N	\N	2023-12-14 13:45:06.407	2023-12-15 18:24:15.566	39ff6a9a-918e-4478-9dcd-bc168d1ac3bd.pdf	\N	2B Wandella Ave	Roseville 	NSW 	2069	\N	\N	85	f	2023-12-13	1735561391521103872.pdf	\N	\N	\N	\N
1176	166	38	2023-12-01	500000.00	\N	\N	\N	2024-01-03 11:19:12.546	2024-01-03 11:21:19.393	f21a67ab-475e-4b39-ab18-42e2e564310b.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	t	2023-12-01	\N	2024-12-31	\N	\N	\N
1177	166	38	2022-12-02	500000.00	\N	\N	\N	2024-01-03 11:20:15.763	2024-01-03 11:21:24.772	7f98f6c1-413f-4908-8f89-b8403e074029.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	t	2022-12-02	\N	2023-12-31	\N	\N	\N
1181	184	2	2023-12-01	50000.00	\N	\N	\N	2024-01-03 11:33:39.077	2024-01-03 11:33:39.077	87f1b0b4-e9de-4f04-b7c8-972dbc875075.pdf	\N	2/385 Blackburn Rd	Mount Waverley	VIC	3149	\N	\N	125	f	2023-12-01	\N	2024-08-31	\N	\N	\N
1182	186	38	2023-12-01	250000.00	\N	\N	\N	2024-01-03 11:36:10.472	2024-05-29 14:21:18.764	4cf97311-3dee-4dfb-8131-1b0e7277bfc3.pdf	\N	11/77 Warrane Rd	North Willoughby  	NSW 	2068	\N	\N	126	f	2023-12-01	\N	2024-08-31	\N	\N	\N
1180	171	38	2023-12-01	300000.00	\N	\N	\N	2024-01-03 11:32:42.49	2024-02-02 09:41:09.15	3bbd753b-955f-4ce9-b604-d479469cd841.pdf	\N	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	277	f	2023-12-01	\N	2024-08-31	\N	\N	\N
1412	309	134	2022-09-07	500000.00	\N	\N	\N	2024-07-18 14:37:33.383	2024-07-18 14:41:00.82	b187c205-dc60-48ef-9467-af656e61ee36.pdf	\N	na	na	na	0000	\N	\N	316	f	2022-09-07	1813796088348377088.png	\N	\N	\N	\N
1178	166	37	2023-12-01	500000.00	\N	\N	\N	2024-01-03 11:21:57.14	2024-03-04 14:21:10.935	f93ee66a-2575-4efa-ad3e-527ee9d500a6.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	f	2023-12-01	\N	2024-03-03	\N	\N	\N
1236	180	37	2024-02-28	500000.00	\N	\N	\N	2024-02-29 14:57:57.156	2024-03-06 15:00:29.583	d9786d67-dfe8-46f0-843a-cfdc186dbe4c.pdf	\N	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2024-02-28	1765225917010886656.pdf	2025-02-28	\N	\N	\N
1262	189	37	2024-03-07	2000000.00	\N	\N	\N	2024-03-07 14:05:06.857	2024-03-07 14:06:55.638	ad809168-2cef-4203-86a3-fa3a3778268f.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	234	t	2024-03-07	1765574368399671296.pdf	2025-09-30	\N	\N	\N
1285	210	122	2024-03-29	300000.00	\N	\N	\N	2024-04-03 17:11:27.24	2024-04-03 17:11:27.24	3984c7fa-1f24-4b99-a8c9-018407c081c0.pdf	\N	9 Derwent Avenue	North Wahroonga	NSW	2076	\N	\N	297	f	2024-03-29	1775405734658293760.pdf	\N	\N	\N	\N
1311	30	37	2024-04-23	250000.00	\N	\N	\N	2024-04-24 10:58:56.232	2024-04-24 11:00:34.46	650e4773-d2d0-41e2-a326-45ac437d366e.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	t	2024-04-23	1782937232403800064.pdf	2025-01-31	\N	\N	\N
1364	32	102	2024-06-11	2000000.00	\N	\N	\N	2024-06-11 16:40:40.016	2024-06-14 11:11:11.633	BCDIOF-Unit_Certificate-146252[Lei_Wu_And_Yiping_Cao_ATF_Value_Up_0508_Unit_Trust]20240814.pdf	\N	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	310	f	2024-06-11	1801421961021018112.pdf	2025-12-31	\N	\N	\N
1388	60	102	2024-06-26	2100000.00	\N	\N	\N	2024-06-27 16:39:31.535	2024-06-27 16:40:16.142	BCDIOF-Unit_Certificate-146056[Xiandong_GAO]20240814.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou,	Wulumuqi	Xinjiang, Uyghur, China	830063	\N	\N	176	f	2024-06-26	1806215767675297792.pdf	2025-12-31	\N	\N	\N
1339	164	127	2024-05-07	100000.00	\N	\N	\N	2024-05-07 12:13:45.916	2024-10-04 12:53:29.041	BCDIOF-Unit_Certificate-(79)-146131[Boyang_ZHENG]20241004.pdf	\N	47 Winfield Road	Balwyn North	VIC	3104	\N	\N	228	f	2024-05-07	1787667105760354304.pdf	2024-10-03	\N	\N	\N
1445	166	38	2023-09-01	800000.00	\N	\N	\N	2024-08-08 17:30:26.544	2024-08-08 17:30:26.544	0547395c-8764-4776-a994-ad2c8a5bccf7.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	275	f	2023-09-01	\N	2023-11-30	\N	\N	\N
1438	250	38	2024-08-01	250000.00	\N	\N	\N	2024-08-02 17:09:05.88	2024-08-02 17:09:05.88	BCDIOF-Unit_Certificate-146197[Shelford_Enterprise_Pty_Ltd_ATF_Shelford_Family_Trust]20240814.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1477	112	102	2024-08-22	1660000.00	\N	\N	\N	2024-08-22 10:36:23.924	2024-08-29 11:52:33.336	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240822.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	t	2024-08-22	\N	2026-02-28	\N	\N	\N
1446	166	37	2022-11-02	500000.00	\N	\N	\N	2024-08-08 17:35:39.461	2024-09-11 15:59:39.748	BCDIOF-Unit_Certificate-146107[Suzhen_ZHANG]20240911.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	275	f	2022-11-02	\N	2023-10-31	\N	\N	\N
1447	166	37	2022-12-02	500000.00	\N	\N	\N	2024-08-08 17:36:12.001	2024-09-11 15:59:48.921	BCDIOF-Unit_Certificate-146107[Suzhen_ZHANG]20240911.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	275	f	2022-12-02	\N	2023-10-31	\N	\N	\N
1516	171	38	2024-09-01	300000.00	\N	\N	\N	2024-09-19 21:15:49.931	2024-09-19 21:15:49.931	BCDIOF-Unit_Certificate-146151[Wei_CHEN]20240919.pdf	\N	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	277	f	2024-09-01	\N	2025-05-31	\N	\N	\N
1541	321	154	2023-11-16	450000.00	\N	\N	\N	2024-10-08 16:39:21.874	2024-10-08 16:39:21.874	BCDIOF-Unit_Certificate-(Class)-146214[Kenneth_George_COADY]20241008.pdf	\N	Unit 55/50 Kenthurst Rd	Dural	NSW	2158	\N	\N	345	f	2023-11-16	\N	2025-11-30	\N	\N	\N
1454	304	134	2024-08-13	100000.00	\N	\N	\N	2024-08-14 15:49:11.875	2024-11-05 10:37:04.808	BCDIOF-Unit_Certificate-(FUND)-146000[Entity_for_Test]20240814.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-13	\N	\N	\N	\N	\N
256	160	5	2022-09-23	100000.00	\N	\N	\N	2022-09-23 14:46:29.373487	2023-03-06 16:13:30.58	e5dd772f006143d39f959794c1e8579f.pdf	Emily ZHANG	Suite 1001B, 53 Walker Street 	North Sydney 	NSW	2060	\N	146999	\N	t	\N	\N	\N	\N	\N	\N
259	119	37	2022-10-20	500000.00	\N	\N	\N	2022-10-19 14:26:40.647543	2023-03-03 17:48:59.866	f2b352b9-4dcc-4d73-91f9-3cad864817bc.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	\N	\N	\N	\N	\N	\N	\N	t	2022-10-20	\N	2023-10-31	\N	\N	\N
1076	195	79	2023-08-23	300000.00	\N	\N	\N	2023-11-15 12:04:30.517	2023-11-22 15:29:09.386	99d48ed3-3ba4-485a-9b5e-97aa34b8f7fc.pdf	\N	25 Norway St	Sydney	NSW	2000	\N	\N	91	t	2023-08-23	\N	\N	\N	\N	\N
1077	195	74	2023-08-24	25000.00	\N	\N	\N	2023-11-15 12:07:00.447	2023-11-22 15:29:40.571	f43e9f97-b754-4a39-83c8-4b5a186686ed.pdf	\N	25 Norway St	Sydney	NSW	2000	\N	\N	91	t	2023-08-24	\N	\N	\N	\N	\N
1106	100	103	2023-11-28	39318.00	\N	\N	\N	2023-11-29 15:09:35.233	2024-05-20 09:23:41.624	373fc600-a7a5-4db1-912c-8a1179e5c686.pdf	\N	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	192	f	2023-11-28	\N	2024-05-03	\N	\N	\N
1478	257	118	2024-02-04	700000.00	\N	\N	\N	2024-08-22 15:47:45.821	2024-08-22 15:47:45.821	BCDIOF-Unit_Certificate-(69-A)-146201[Lijun_LIU]20240822.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-02-04	\N	2024-02-29	\N	\N	\N
1048	100	103	2023-10-12	100000.00	\N	\N	\N	2023-11-01 17:05:51.883	2023-11-29 15:14:12.525	27e421b9-f56e-4308-98d4-97297731e690.pdf	\N	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	192	f	2023-10-12	\N	2023-11-27	\N	\N	\N
270	165	29	2022-11-28	1000000.00	\N	\N	\N	2022-11-28 12:33:05.390031	2023-03-03 19:54:44.832	f0f2891419158cbd4d2af020bd312e5f.pdf						\N		\N	t	\N	\N	\N	\N	\N	\N
1104	31	103	2023-11-28	61729.00	\N	\N	\N	2023-11-29 15:03:07.765	2024-05-20 09:24:40.289	0efc9daa-ad03-4c6f-8948-c7cf9ba3a62c.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2023-11-28	\N	2024-05-03	\N	\N	\N
1108	231	103	2023-10-20	500000.00	\N	\N	\N	2023-11-29 15:19:33.846	2023-11-29 15:51:13.598	bd5e084d-a061-4d0c-ae69-da362c33fbcd.pdf	\N	\N	\N	\N	\N	\N	\N	241	f	2023-10-20	\N	2023-11-28	\N	\N	\N
1365	147	115	2022-09-15	100000.00	\N	\N	\N	2024-06-12 12:05:49.675	2024-06-12 12:05:49.675	2b9c8d4e-53f3-4c70-92bb-44d5104646b2.pdf	\N	11 Inglis Ct	Glen Waverley	VIC	3150	\N	\N	81	f	2022-09-15	\N	2022-10-14	\N	\N	\N
1345	301	38	2023-10-01	250000.00	\N	\N	\N	2024-05-10 15:28:47.189	2024-05-10 15:28:47.189	4da2d221-d270-46ad-b853-281f7f629a0f.pdf	\N	5 SHIELDS CT	BLACKBURN SOUTH	VIC	3130 	\N	\N	306	f	2023-10-01	\N	2024-07-31	\N	\N	\N
1183	118	38	2023-11-01	250000.00	\N	\N	\N	2024-01-04 14:09:14.533	2024-06-17 11:41:05.477	e5dce1f7-1bf6-4260-bc20-5207f5cdb2f7.pdf	\N	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2023-11-01	\N	2024-06-12	\N	\N	\N
1389	305	111	2023-12-08	250000.00	\N	\N	\N	2024-06-28 14:43:52.141	2024-06-28 14:43:52.141	55706055-4fec-4b18-81e8-a9b40a1ee42b.pdf	\N	2A Lochiel Ave	Campbelltown	SA	5074	\N	\N	312	f	2023-12-08	\N	\N	\N	\N	\N
1312	30	38	2024-04-23	250000.00	\N	\N	\N	2024-04-24 11:01:06.854	2024-07-12 14:49:12.829	e5544092-76ad-481b-bb91-a64f73875203.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2024-04-23	1782937780272177152.pdf	2024-07-11	\N	\N	\N
1098	176	38	2023-01-13	250000.00	\N	\N	\N	2023-11-23 14:39:28.977	2023-11-23 14:39:28.977	0d85717a-4650-4114-b0d3-c925fdfb729e.pdf	\N	\N	\N	\N	\N	\N	\N	32	f	2023-01-13	\N	2023-10-31	\N	\N	\N
1095	138	37	2023-11-01	500000.00	\N	\N	\N	2023-11-23 14:30:24.208	2023-11-29 15:56:24.623	9d45406c-269d-4195-9490-60eae383d537.pdf	\N	29A Parkers Rd.	Parkdale	VIC	3195	\N	\N	209	f	2023-11-01	\N	2024-11-30	\N	\N	\N
1151	281	111	2023-12-13	100000.00	\N	\N	\N	2023-12-15 10:31:49.205	2023-12-15 10:31:49.205	08e919af-ab49-455b-abde-08974ecfc81c.pdf	\N	52 Andromeda Pkwy	Box Hill 	NSW	2765	\N	\N	284	f	2023-12-13	1735442498274164736.pdf	\N	\N	\N	\N
1119	119	75	2023-06-01	150000.00	\N	\N	\N	2023-12-04 16:59:48.824	2024-02-02 11:21:22.971	cae7a9a1-d49f-4483-b7f0-2f5af3006bf9.pdf	\N	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	278	f	2023-06-01	1731553873547382784.pdf	2024-01-18	\N	\N	\N
1263	189	102	2024-03-07	2000000.00	\N	\N	\N	2024-03-07 14:08:12.297	2024-03-07 14:08:12.297	a71ba90c-cb4e-4ed8-afe6-2249cef4ad69.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	234	f	2024-03-07	1765575146149462016.pdf	2025-09-30	\N	\N	\N
1287	118	122	2024-03-26	150000.00	\N	\N	\N	2024-04-03 17:16:58.517	2024-04-03 17:16:58.517	c31876b2-f03c-446a-98c1-e0e2460d6845.pdf	\N	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2024-03-26	1775407124134739968.pdf	\N	\N	\N	\N
1209	57	110	2024-01-24	100000.00	\N	\N	\N	2024-01-24 13:58:41.596	2024-05-15 15:31:24.623	6c22e8f8-2e60-4f68-aa13-06762e75c812.pdf	\N	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2024-01-24	1749990074235195392.pdf	2024-05-06	\N	\N	\N
1517	184	2	2024-09-01	50000.00	\N	\N	\N	2024-09-19 21:16:40.202	2024-09-19 21:16:40.202	BCDIOF-Unit_Certificate-146152[Keya_LONG]20240919.pdf	\N	2/385 Blackburn Rd	Mount Waverley	VIC	3149	\N	\N	125	f	2024-09-01	\N	2025-05-31	\N	\N	\N
1518	186	38	2024-09-01	250000.00	\N	\N	\N	2024-09-19 21:17:26.429	2024-09-19 21:17:26.429	BCDIOF-Unit_Certificate-146156[Jianxin_HUANG]20240919.pdf	\N	11/77 Warrane Rd	North Willoughby  	NSW 	2068	\N	\N	126	f	2024-09-01	\N	2025-05-31	\N	\N	\N
1340	279	127	2024-05-08	100000.00	\N	\N	\N	2024-05-08 11:11:55.005	2024-10-04 12:54:37.463	BCDIOF-Unit_Certificate-(79)-146221[Tian_QIN]20241004.pdf	\N	2406/33 Mackenzie street	Melbourne 	VIC 	3000	\N	\N	282	f	2024-05-08	1788013928932909056.pdf	2024-10-03	\N	\N	\N
1448	304	135	2024-08-06	500000.00	\N	\N	\N	2024-08-08 17:53:42.162	2024-10-09 14:56:52.449	BCDIOF-Unit_Certificate-(85)-000001[TEST_ENTITY]20240814.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-08-06	\N	\N	\N	\N	\N
1413	304	130	2024-07-18	500001.00	\N	\N	\N	2024-07-19 11:07:40.24	2024-10-09 14:56:56.291	BCDIOF-Unit_Certificate-(82)-000001[TEST_ENTITY]20240814.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-07-18	1820048812639428608.png	\N	1820048812647817216.png	1820048812647817217.png	1820048812647817218.png
1622	304	155	2024-10-22	12345.00	\N	\N	\N	2024-10-22 14:17:03.655	2024-11-05 10:40:16.187	BCDIOF-Unit_Certificate-(A)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1237	284	37	2024-02-29	500000.00	\N	\N	\N	2024-02-29 16:26:21.993	2024-11-18 15:43:31.122	BCDIOF-Unit_Certificate-146234[Tao_XU]20241118.pdf	\N	1012 JIANDE NANJIAO VILLA,578 NANLIU ROAD	PUDONG	SHANGHAI, China	201314	\N	\N	290	f	2024-02-29	1763073200595353600.pdf	2025-02-28	\N	\N	\N
1576	304	155	2024-10-01	500000.00	\N	\N	\N	2024-10-14 14:34:41.435	2024-11-05 10:36:57.429	BCDIOF-Unit_Certificate-(A)-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-01	\N	2025-10-01	\N	\N	\N
1455	304	134	2024-08-13	100000.00	\N	\N	\N	2024-08-14 15:53:50.958	2024-11-05 10:37:30.483	BCDIOF-Unit_Certificate-(FUND)-000001[TEST_ENTITY]20240814.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-08-13	\N	\N	\N	\N	\N
1654	304	130	2024-07-05	300000.00	\N	\N	\N	2024-10-24 16:47:55.488	2024-11-05 10:38:06.891	BCDIOF-Unit_Certificate-(82)-145000[Entity_for_Test]20241024.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-07-05	\N	2024-08-14	\N	\N	\N
1621	304	151	2024-10-22	12345.00	\N	\N	\N	2024-10-22 13:21:38.982	2024-11-05 10:39:44.799	BCDIOF-Unit_Certificate-(93-B)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	2025-10-31	\N	\N	\N
1601	304	40	2024-10-20	7777777.00	\N	\N	\N	2024-10-20 16:41:52.907	2024-11-05 10:40:03.323	BCDIOF-Unit_Certificate-146999[test_company]20241020.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-20	\N	\N	\N	\N	\N
1078	195	72	2023-09-01	2000000.00	\N	\N	\N	2023-11-15 12:15:32.473	2023-11-22 15:29:33.242	838dd511-a570-4c74-8461-5143259170d4.pdf	\N	23 Young St	Sydney	NSW	2000	\N	\N	273	t	2023-09-01	\N	\N	\N	\N	\N
1152	31	110	2023-12-14	200000.00	\N	\N	\N	2023-12-15 18:17:15.676	2024-05-20 09:20:55.281	4d7fe7ff-75f1-458a-9789-884814aedec5.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2023-12-14	1735559630378991616.pdf	2024-05-06	\N	\N	\N
1575	304	2	2024-10-14	999999.00	\N	\N	\N	2024-10-14 14:32:43.12	2024-10-14 14:36:18.936	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-14	\N	\N	\N	\N	\N
988	31	103	2023-10-12	157000.00	\N	\N	\N	2023-10-12 10:57:04.741	2023-11-29 15:14:57.999	bbe285dd-e548-4638-bc13-ea125e223069.pdf	\N	47 ERICA AVE.\t	GLEN IRIS\t	VIC\t	3146	\N	\N	105	f	2023-10-12	1712256031487803392.pdf	2023-11-27	\N	\N	\N
1602	304	154	2024-10-20	111222.00	\N	\N	\N	2024-10-20 16:46:51.169	2024-11-05 10:40:01.574	BCDIOF-Unit_Certificate-(Class)-146999[test_company]20241020.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-20	\N	\N	\N	\N	\N
1390	187	37	2022-10-24	2000000.00	\N	\N	\N	2024-07-02 11:34:48.932	2024-07-02 11:34:48.932	902abd92-f741-4ea8-b840-c7ae5d4cffb6.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	313	f	2022-10-24	1807951024300699648.pdf	2023-10-31	\N	\N	\N
1097	171	38	2023-10-01	303000.00	\N	\N	\N	2023-11-23 14:37:45.682	2023-12-05 17:59:09.022	9a2b520a-252b-49c1-a31c-573dcc90e940.pdf	\N	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	90	f	2023-10-01	\N	2024-07-31	\N	\N	\N
1120	218	102	2023-12-05	50000.00	\N	\N	\N	2023-12-05 18:03:28.609	2023-12-05 18:03:28.609	934f103f-711b-4438-b467-9a2be35a8345.pdf	\N	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	240	f	2023-12-05	\N	\N	\N	\N	\N
1449	226	130	2024-07-12	150000.00	\N	\N	\N	2024-08-09 12:13:25.445	2024-08-09 12:17:43.351	BCDIOF-Unit_Certificate-(82)-146178[WANG_LUI]20240814.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2024-07-12	1821732560992935936.pdf	\N	\N	\N	\N
1184	15	38	2023-12-22	250000.00	\N	\N	\N	2024-01-04 14:33:38.55	2024-01-05 10:16:22.057	7ed695d3-6920-4b97-a52e-c985b2585a9d.pdf	\N	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	\N	88	f	2023-12-22	1742751112185667584.pdf	2024-09-30	\N	\N	\N
1210	283	37	2024-01-25	500000.00	\N	\N	\N	2024-01-25 13:45:15.125	2024-01-25 13:46:42.043	4200254f-e169-4c47-bcdc-2eff9596e21e.pdf	\N	1B LEEDON HEIGHTS	SINGAPORE	SINGAPORE	267941	\N	\N	288	f	2024-01-25	1750349079516254208.pdf	2025-01-31	\N	\N	\N
1238	226	39	2024-02-22	250000.00	\N	\N	\N	2024-03-01 15:29:02.828	2024-03-01 15:29:21.404	aa349ed3-3fbe-416f-a8b6-60dcb793c332.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	t	2024-02-22	\N	2025-02-28	\N	\N	\N
1264	287	38	2024-03-07	250000.00	\N	\N	\N	2024-03-08 11:50:24.569	2024-03-08 11:50:24.569	087fbfdc-00f9-41ff-b8dc-6e15400dc0f6.pdf	\N	16 Elwood St	Brighton	VIC	3186	\N	\N	293	f	2024-03-07	1765902856650440704.pdf	2024-12-31	\N	\N	\N
1288	29	121	2024-04-04	100000.00	\N	\N	\N	2024-04-05 12:11:47.802	2024-04-05 12:11:47.802	22c2d7f0-a271-4399-a029-fdb7b2b7c23e.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2024-04-04	1776055099227840512.pdf	\N	\N	\N	\N
1289	164	121	2024-04-05	100000.00	\N	\N	\N	2024-04-05 12:14:09.676	2024-04-05 12:14:09.676	0ed3742e-158a-4b48-a8f4-c6d9815f3843.pdf	\N	47 Winfield Road	Balwyn North	VIC	3104	\N	\N	228	f	2024-04-05	1776055694223417344.pdf	\N	\N	\N	\N
1087	275	90	2023-07-21	1930390.50	\N	\N	\N	2023-11-16 16:50:13.64	2024-04-08 11:05:18.375	464460b6-5182-4a02-998e-046b63a70a19.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2023-07-21	\N	2024-04-05	\N	\N	\N
379	179	19	2023-03-01	5000000.00	\N	\N	\N	2023-03-01 20:11:22.165	2023-03-01 20:12:25.327	b5967a31-1dea-478f-9e3e-9b44b2beba6d.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	12	\N	t	2023-03-01	\N	\N	\N	\N	\N
380	179	40	2023-03-01	5000000.00	\N	\N	\N	2023-03-01 20:55:10.882	2023-03-01 20:55:50.446	fa31af6e-8294-4c27-8ab0-6e78065e0fb9.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	\N	\N	\N	\N	\N	\N
1313	169	38	2024-04-12	100000.00	\N	\N	\N	2024-04-29 15:00:59.164	2024-05-01 16:55:54.389	c0f759c7-1dc1-4bbc-9e1a-5573c62efa4f.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	t	2024-04-12	\N	2024-07-31	\N	\N	\N
1366	276	119	2024-06-12	170000.00	\N	\N	\N	2024-06-12 15:11:04.521	2024-06-12 15:11:04.521	BCDIOF-Unit_Certificate-(69-B)-146216[Wenli_WANG]20240814.pdf	\N	40 Berith St	Auburn	NSW 	2144	\N	\N	276	f	2024-06-12	1800757690469634048.pdf	\N	\N	\N	\N
377	178	38	2023-02-21	250000.00	\N	\N	\N	2023-02-21 12:53:39.216037	2023-03-02 23:53:51.793	598a31fb-108c-4fd9-91ec-4ce736d21a25.pdf	Test	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1314	228	2	2024-04-01	50000.00	\N	\N	\N	2024-04-29 15:01:42.935	2024-10-14 16:00:58.084	BCDIOF-Unit_Certificate-146180[Qiao_ZHANG]20241014.pdf	\N	36A Birkinshaw Ave.	Tranmere	SA	5073	\N	\N	111	f	2024-04-01	\N	2024-04-30	\N	\N	\N
1456	312	130	2024-08-09	100000.00	\N	\N	\N	2024-08-15 12:03:38.382	2024-08-15 12:03:38.382	BCDIOF-Unit_Certificate-(82)-146256[Ying_ZHANG]20240815.pdf	\N	Unit 9 6 Third Avenue	Everard Park	SA	5035	\N	\N	327	f	2024-08-09	\N	\N	\N	\N	\N
378	178	2	2023-02-22	500000.00	\N	\N	\N	2023-02-22 12:45:03.161559	2023-03-03 15:01:57.798	2e78a7fe-979e-44df-8695-ed14b2bfbb08.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
1414	310	39	2024-07-19	150000.00	\N	\N	\N	2024-07-19 12:20:20.587	2024-08-21 15:03:59.637	BCDIOF-Unit_Certificate-146253[Xiaoyu_ZHU]20240821.pdf	\N	T20-C HUTANG XINCUNNANDU	CHANGZHOU	JIANGSU	000000	\N	\N	318	f	2024-07-19	\N	2024-08-20	\N	\N	\N
1479	279	118	2024-02-28	100000.00	\N	\N	\N	2024-08-22 15:50:49.525	2024-08-22 15:50:49.525	BCDIOF-Unit_Certificate-(69-A)-146221[Tian_QIN]20240822.pdf	\N	2406/33 Mackenzie street	Melbourne 	VIC 	3000	\N	\N	282	f	2024-02-28	\N	2024-05-27	\N	\N	\N
1519	176	38	2024-09-01	250000.00	\N	\N	\N	2024-09-19 21:30:08.902	2024-09-19 21:30:08.902	BCDIOF-Unit_Certificate-146118[Lofty_and_Steep_Pty_Ltd_ATF_DWW_Family_Trust]20240919.pdf	\N	2A White Avenue	Kensington Gardens	SA	5068	\N	\N	32	f	2024-09-01	\N	2025-05-31	\N	\N	\N
1341	77	127	2024-05-08	100000.00	\N	\N	\N	2024-05-08 11:13:11.563	2024-10-04 12:52:17.314	BCDIOF-Unit_Certificate-(79)-146072[Xian_LI]20241004.pdf	\N	42 Lewton Rd.	Mount Waverley	VIC 	3149	\N	\N	165	f	2024-05-08	1788014250040434688.pdf	2024-10-03	\N	\N	\N
1543	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 15:20:54.409	2024-10-09 15:35:27.61	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1624	304	122	2024-10-22	12345.00	\N	\N	\N	2024-10-22 14:26:40.052	2024-11-05 10:40:26.522	BCDIOF-Unit_Certificate-(76-B)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1623	304	155	2024-10-22	12345.00	\N	\N	\N	2024-10-22 14:22:34.55	2024-11-05 10:39:40.976	BCDIOF-Unit_Certificate-(A)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1683	30	2	2024-11-08	50000.00	\N	\N	\N	2024-11-08 14:08:19.075	2024-11-19 14:58:22.144	BCDIOF-Unit_Certificate-146035[Evergreen_SUN_Pty_Ltd_ATF_Evergreen_Spring_Trust]20241108.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	t	2024-11-08	\N	2025-08-31	\N	\N	\N
1265	288	120	2024-01-18	1000000.00	\N	\N	\N	2024-03-12 10:26:22.642	2024-03-12 10:28:21.888	d5d78ecb-81ee-4bd4-a637-f94f77bd2e0e.pdf	\N	58 Queen Victoria St	Bexley	NSW	2207	\N	\N	294	f	2024-01-18	1767331260742451200.pdf	\N	\N	\N	\N
373	177	2	2022-12-20	100000.00	\N	\N	\N	2023-02-20 07:32:29.321423	2023-03-03 18:48:03.634	2811f9a7a2a5c3bfc0dcb620ef2e8713.pdf	Rober CHEN	Suite 1001B, 53 Walker Street	North Sydeny	NSW	2060	\N	146200	\N	t	\N	\N	\N	\N	\N	\N
374	175	2	2023-02-10	500000.00	\N	\N	\N	2023-02-21 07:14:55.61009	2023-03-03 18:48:06.365	40ab6974405776378471abc3766e702f.pdf	Franka	Suite 1001B, 53 Walker Street	North Sydeny	NSW	2060	\N	146222	\N	t	\N	\N	\N	\N	\N	\N
1290	35	121	2024-04-05	100000.00	\N	\N	\N	2024-04-05 12:25:02.065	2024-04-05 12:25:02.065	461ef9e7-9ea3-4b36-bfd6-7bfac479c999.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	f	2024-04-05	1776058430541209600.pdf	\N	\N	\N	\N
1315	208	37	2024-04-01	500000.00	\N	\N	\N	2024-04-29 15:25:18.208	2024-04-29 15:25:18.208	c320bd6d-3bc6-4851-9901-f8fe9ba0f22d.pdf	\N	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2024-04-01	\N	2025-03-31	\N	\N	\N
1316	23	37	2024-04-01	780000.00	\N	\N	\N	2024-04-29 15:26:18.668	2024-04-29 15:26:18.668	9b3c3446-a57d-4348-a007-b304345d8e05.pdf	\N	Unit 602, 19 Shoreline Drive	Rhodes	NSW 	2138	\N	\N	137	f	2024-04-01	\N	2025-03-31	\N	\N	\N
1211	203	110	2024-01-26	100000.00	\N	\N	\N	2024-01-29 16:56:47.034	2024-05-15 15:30:44.872	22181de1-9945-41b4-b1a7-cda122d1dde0.pdf	\N	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	\N	107	f	2024-01-26	1751847105355288576.pdf	2024-05-06	\N	\N	\N
1153	282	110	2023-12-14	100000.00	\N	\N	\N	2023-12-15 18:21:12.218	2024-05-20 09:20:03.963	1e546009-ae2b-4cda-b221-5287728bdbb1.pdf	\N	6 Woodlands Avenue	Camberwell	VIC 	3124	\N	\N	285	f	2023-12-14	1735560622512242688.pdf	2024-05-06	\N	\N	\N
1122	210	110	2023-12-01	500000.00	\N	\N	\N	2023-12-07 12:49:38.176	2024-05-20 09:22:30.95	63cd34f4-63f2-4297-91c2-1c8c3d79ef00.pdf	\N	3 Dalwood Pl	Carlingford	NSW	2118	\N	\N	99	f	2023-12-01	1732578077923287040.pdf	2024-05-06	\N	\N	\N
1239	226	38	2024-02-22	250000.00	\N	\N	\N	2024-03-01 15:29:44.895	2024-05-29 14:16:17.71	a92d284b-39aa-45be-84fe-4f688390e245.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2024-02-22	\N	2024-11-30	\N	\N	\N
1391	187	102	2024-07-01	2000000.00	\N	\N	\N	2024-07-02 11:38:00.936	2024-07-02 14:02:55.157	BCDIOF-Unit_Certificate-146105[Chang_LIU_&_Lei_WU_ATF_Value_Up_1106_Unit_Trust_]20240814.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	313	f	2024-07-01	1807988295733268480.pdf	2025-12-31	\N	\N	\N
1121	132	110	2023-12-05	230000.00	\N	\N	\N	2023-12-07 12:45:56.655	2023-12-11 12:21:12.593	e1715a42-76ac-4bf2-8044-a122b3872eac.pdf	\N	13 West Terrace	Kensington Gardens	SA	5068	\N	\N	77	t	2023-12-05	1732577148817842176.pdf	\N	\N	\N	\N
1088	15	38	2023-11-01	250000.00	\N	\N	\N	2023-11-21 09:56:00.911	2023-11-21 09:56:00.911	955a1b87-27c2-4176-98c6-fcb6bd1d4d48.pdf	\N	608/4 Kiln Road	Kirrawee	NSW	2232	\N	\N	88	f	2023-11-01	\N	2024-08-31	\N	\N	\N
1367	208	119	2024-06-13	130000.00	\N	\N	\N	2024-06-13 11:21:32.578	2024-07-17 10:10:34.254	BCDIOF-Unit_Certificate-(69-B)-146159[Hiu_Hung_WONG]20240814.pdf	\N	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2024-06-13	1801062314611232768.pdf	2024-07-16	\N	\N	\N
1100	35	40	2023-11-24	150000.00	\N	\N	\N	2023-11-24 14:00:00.909	2023-11-30 10:22:39.893	515f3850-d3cc-4d2b-adc3-f5b861fcc8ef.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	f	2023-11-24	1727884747099906048.pdf	2024-03-31	\N	\N	\N
367	176	38	2023-01-13	250000.00	\N	\N	\N	2023-01-13 14:40:37.139898	2023-11-01 15:15:20.924	d5a0ec38-310f-43a1-b5af-2b53e3e07a7d.pdf	Lofty And Steep Pty Ltd	2A White Avenue	Kensington Gardens	SA	5068	\N	\N	\N	f	2023-01-13	1636238571066961920.pdf	2023-10-31	\N	\N	\N
1415	310	40	2024-07-19	50000.00	\N	\N	\N	2024-07-19 12:21:16.24	2024-07-19 12:21:16.24	BCDIOF-Unit_Certificate-146253[Xiaoyu_ZHU]20240814.pdf	\N	T20-C HUTANG XINCUNNANDU	CHANGZHOU	JIANGSU	000000	\N	\N	318	f	2024-07-19	\N	2024-11-30	\N	\N	\N
1185	125	44	2022-08-17	300000.00	\N	\N	\N	2024-01-05 10:42:39.583	2024-01-05 10:44:37.303	e73e8e95-71fd-4238-aa66-0bd3cce5bbf0.pdf	\N	88 John Rd 	Cherrybrook 	NSW 	2126	\N	\N	287	f	2022-08-17	\N	2023-10-05	\N	\N	\N
1457	233	135	2024-08-13	300000.00	\N	\N	\N	2024-08-15 12:10:03.644	2024-08-15 12:10:03.644	BCDIOF-Unit_Certificate-(85)-146183[Tina_Ywen_Pty_Ltd_ATF_Tinaewen_Superannuation_Fund]20240815.pdf	\N	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2024-08-13	\N	\N	\N	\N	\N
1480	31	141	2024-08-22	120000.00	\N	\N	\N	2024-08-22 16:08:07.213	2024-08-22 16:08:07.213	BCDIOF-Unit_Certificate-(90)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20240822.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-08-22	\N	\N	\N	\N	\N
1520	294	135	2024-09-19	300000.00	\N	\N	\N	2024-09-20 14:12:43.206	2024-09-20 14:13:01.181	BCDIOF-Unit_Certificate-(85)-146242[Xiaofeng_Zhang]20240920.pdf	\N	20 Mahar Street	Kensington Gardens	SA	5068	\N	\N	296	f	2024-09-19	1836981866827481088.pdf	\N	\N	\N	\N
1342	268	127	2024-05-08	100000.00	\N	\N	\N	2024-05-08 13:42:49.282	2024-10-04 12:53:59.909	BCDIOF-Unit_Certificate-(79)-146208[Huanghui_JIANG]20241004.pdf	\N	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	\N	264	f	2024-05-08	1788051905323147264.pdf	2024-10-03	\N	\N	\N
1544	304	149	2024-10-09	89898989.00	\N	\N	\N	2024-10-09 15:25:25.938	2024-10-09 15:45:54.426	BCDIOF-Unit_Certificate-(72-A)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	\N	\N	\N	\N
1577	304	2	2024-10-14	999999.00	\N	\N	\N	2024-10-14 14:36:37.061	2024-10-14 14:39:21.101	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-14	\N	\N	\N	\N	\N
1450	263	135	2024-08-09	100000.00	\N	\N	\N	2024-08-09 12:22:06.202	2024-08-13 18:54:15.943	BCDIOF-Unit_Certificate-(85)-146204[Thi_Thu_Hang_TRAN]20240814.pdf	\N	L6, C1 / 90 Nguyen Binh Khiem Street	Rach Gia City 	Kien Giang, Vietnam	920000 	\N	\N	261	f	2024-08-09	1821733715865182208.pdf	\N	\N	\N	\N
891	30	37	2023-07-19	500000.00	\N	\N	\N	2023-07-24 11:55:30.771	2024-10-10 15:16:22.341	BCDIOF-Unit_Certificate-146035[Evergreen_SUN_Pty_Ltd_ATF_Evergreen_Spring_Trust]20241010.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-07-19	1683294807087435776.pdf	2024-06-30	\N	\N	\N
1579	304	2	2024-10-14	999999.00	\N	\N	\N	2024-10-14 14:42:01.763	2024-11-05 10:36:55.81	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-14	\N	\N	\N	\N	\N
1656	304	93	2023-08-16	300000.00	\N	\N	\N	2024-10-24 17:10:48.801	2024-11-05 10:38:04.862	BCDIOF-Unit_Certificate-(52)-145000[Entity_for_Test]20241024.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-08-16	\N	2024-01-03	\N	\N	\N
1625	304	14	2024-10-22	1234.00	\N	\N	\N	2024-10-22 14:37:01.554	2024-11-05 10:40:24.905	BCDIOF-Unit_Certificate-(3-2)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1684	261	158	2024-11-13	100000.00	\N	\N	\N	2024-11-14 11:08:49.717	2024-11-14 11:08:49.717	BCDIOF-Unit_Certificate-(98)-146203[Guanyu_CHEN]20241114.pdf	\N	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	\N	266	f	2024-11-13	\N	\N	\N	\N	\N
762	119	75	2023-05-09	150000.00	\N	\N	\N	2023-05-10 11:25:55.898	2023-05-10 16:31:47.778	0334a628-21a6-4d38-b05e-f77c01f25591.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	BCFCT35B-146099	\N	t	2023-05-09	\N	\N	\N	\N	\N
1109	15	107	2023-11-30	100000.00	\N	\N	\N	2023-11-30 11:35:57.242	2023-11-30 11:35:57.242	e6d0e2eb-0797-43e3-8ba4-8741c90af366.pdf	\N	608/4 Kiln Road	Kirrawee	NSW	2232	\N	\N	88	f	2023-11-30	1730022820187172864.pdf	\N	\N	\N	\N
1186	125	44	2023-12-07	175500.00	\N	\N	\N	2024-01-05 10:43:55.534	2024-07-02 15:25:36.481	77151f1b-64f3-4bbb-adfd-ef48620d8e15.pdf	\N	88 John Rd 	Cherrybrook 	NSW 	2126	\N	\N	287	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1089	60	37	2023-11-20	500000.00	\N	\N	\N	2023-11-21 11:10:47.239	2023-11-21 11:10:47.239	0c0cd612-70a4-433c-ac6d-e6247458c273.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2023-11-20	1726754995927453696.pdf	2024-11-30	\N	\N	\N
1123	218	102	2023-12-07	50000.00	\N	\N	\N	2023-12-07 16:46:21.351	2023-12-07 16:46:21.351	6992f866-58a4-430a-a84c-4eb7dd8f3758.pdf	\N	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	240	f	2023-12-07	\N	\N	\N	\N	\N
1154	60	111	2023-12-14	300000.00	\N	\N	\N	2023-12-15 18:26:08.346	2023-12-15 18:26:08.346	f48566e6-ef65-4709-a0af-88ec64ddc3f3.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2023-12-14	1735561864558903296.pdf	\N	\N	\N	\N
1416	311	39	2024-07-15	150000.00	\N	\N	\N	2024-07-19 16:17:42.409	2024-07-19 16:17:42.409	BCDIOF-Unit_Certificate-146229[Tran_Nha_My_CHAU]20240814.pdf	\N	28 Griffiths Street	Sans Souci	NSW	2219	\N	\N	319	f	2024-07-15	1814182809850314752.pdf	2025-04-30	\N	\N	\N
1266	113	2	2023-05-01	165000.00	\N	\N	\N	2024-03-14 16:37:10.755	2024-03-14 16:37:30.051	98ca2c6a-4fc6-4fb2-b337-c7de0e249bb7.pdf	\N	38 Dalgetty Road	Beaumaris	VIC	3193	\N	\N	244	t	2023-05-01	\N	2024-02-29	\N	\N	\N
1291	275	121	2024-04-05	1940000.00	\N	\N	\N	2024-04-08 11:07:26.983	2024-04-08 14:26:35.018	c561cbc9-5139-4205-abc0-a01b2b315857.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2024-04-05	1777191282485960704.jpg	\N	\N	\N	\N
705	179	44	2023-03-16	500000.00	\N	\N	\N	2023-03-16 15:57:33.55	2023-03-21 09:54:31.886	17db87ee-bd94-40c1-ae7e-a56c56cc2b50.pdf	\N	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-16	1636259737290747904.pdf	\N	\N	\N	\N
1212	131	110	2024-01-25	100000.00	\N	\N	\N	2024-01-29 17:04:16.062	2024-05-15 15:30:01.614	b4f8a578-9471-473d-a84f-d050a0505c7b.pdf	\N	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	76	f	2024-01-25	1751848979701665792.pdf	2024-05-06	\N	\N	\N
1545	304	149	2024-10-09	999999.00	\N	\N	\N	2024-10-09 15:36:00.477	2024-10-09 15:41:15.033	BCDIOF-Unit_Certificate-(72-A)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1458	203	135	2024-08-15	100000.00	\N	\N	\N	2024-08-15 12:12:43.035	2024-08-15 12:12:43.035	BCDIOF-Unit_Certificate-(85)-146176[Worldlink_Group_pty_Ltd]20240815.pdf	\N	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	\N	107	f	2024-08-15	\N	\N	\N	\N	\N
650	179	44	2023-03-11	5000000.00	\N	\N	\N	2023-03-11 02:45:57.924	2023-03-15 10:10:11.852	7b70e98a-a875-4827-83f9-34afaeb10f46.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	2023-03-11	\N	\N	\N	\N	\N
675	199	70	2023-02-28	\N	\N	\N	\N	2023-03-14 17:36:50.36	2023-03-15 12:25:06.001	d95ce25e-5e59-4f3a-be9b-2b814575d9ae.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
676	198	69	2023-02-28	\N	\N	\N	\N	2023-03-14 17:37:00.94	2023-03-15 12:25:08.751	2b9a4386-23e0-4053-828c-334f4eb3db4f.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
677	198	44	2023-02-28	\N	\N	\N	\N	2023-03-14 17:37:18.248	2023-03-15 12:25:11.554	99497858-5699-40fb-9e99-b84138f8a46e.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-08	\N	\N	\N	\N	\N
693	199	69	2023-03-14	100000.00	\N	\N	\N	2023-03-15 10:19:15.701	2023-03-15 14:07:48.266	1d58641e-304a-4780-8110-11ed25d280de.pdf	test acc	9999 fake add	fake sub	fake state	2000	\N	1469999	\N	t	2023-03-14	\N	2023-09-14	\N	\N	\N
1393	306	111	2023-12-10	160000.00	\N	\N	\N	2024-07-02 15:07:03.565	2024-07-02 15:10:36.277	7749b6c8-60a0-4459-9564-d0ed97d50cee.pdf	\N	N/A	N/A	NSW	N/A	\N	\N	314	t	2023-12-10	\N	\N	\N	\N	\N
712	179	70	2023-03-22	5000000.00	\N	\N	\N	2023-03-22 10:45:19.649	2023-03-27 13:52:06.794	a12398c6-e1d1-4929-a1f8-f8a07365a208.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-22	1640152217455259648.pdf	\N	\N	\N	\N
1240	29	118	2024-03-01	100000.00	\N	\N	\N	2024-03-01 17:02:53.625	2024-08-22 12:25:18.618	BCDIOF-Unit_Certificate-(69-A)-146036[Chang_Liu_ATF_Chang_Family_Trust]20240822.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2024-03-01	1763444780831817728.pdf	2024-05-29	\N	\N	\N
1368	122	38	2024-06-13	310000.00	\N	\N	\N	2024-06-13 16:57:13.726	2024-10-02 10:36:21.062	BCDIOF-Unit_Certificate-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20241002.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2024-06-13	1801421342847717376.pdf	2024-09-19	\N	\N	\N
1578	304	2	2024-10-14	999999.00	\N	\N	\N	2024-10-14 14:39:59.496	2024-10-14 14:41:38.11	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241014.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-14	\N	\N	\N	\N	\N
1242	31	118	2024-03-01	400000.00	\N	\N	\N	2024-03-01 17:05:16.978	2024-08-22 12:28:20.734	BCDIOF-Unit_Certificate-(69-A)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20240822.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-03-01	1763445382097879040.pdf	2024-05-29	\N	\N	\N
1481	112	122	2024-08-20	100000.00	\N	\N	\N	2024-08-22 16:39:25.29	2024-08-23 11:03:44.442	BCDIOF-Unit_Certificate-(76-B)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240823.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-20	\N	\N	\N	\N	\N
1521	66	148	2023-12-06	500000.00	\N	\N	\N	2024-09-23 15:41:29.332	2024-09-23 15:41:29.332	BCDIOF-Unit_Certificate-(71-B)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240923.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-12-06	\N	2024-01-05	\N	\N	\N
1392	132	38	2024-06-26	250000.00	\N	\N	\N	2024-07-02 14:52:10.832	2024-07-02 15:03:16.03	BCDIOF-Unit_Certificate-146173[Evertree_Hw_Pty_Ltd_ATF_Evertree_Family_Super_Fund]20240814.pdf	\N	17 Holmwood Ave	Brighton	VIC	3186	\N	\N	281	f	2024-06-26	1808000692795699200.pdf	2025-03-31	\N	\N	\N
1451	110	135	2024-08-08	250000.00	\N	\N	\N	2024-08-09 17:10:16.846	2024-08-09 17:13:34.908	BCDIOF-Unit_Certificate-(85)-146083[Wenyan_Wu_Pty_Ltd_ATF_Wu_Superannuation_Fund]20240814.pdf	\N	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2024-08-08	1821806243690258432.pdf	\N	\N	\N	\N
1317	172	37	2024-04-01	510000.00	\N	\N	\N	2024-04-29 15:28:12.944	2024-10-02 12:06:03.248	BCDIOF-Unit_Certificate-146116[Bo_LI]20241002.pdf	\N	139/120 Sturt St	Southbank	VIC	3006	\N	\N	223	f	2024-04-01	\N	2024-09-05	\N	\N	\N
1343	122	127	2024-05-07	50000.00	\N	\N	\N	2024-05-09 09:43:09.446	2024-10-04 12:50:00.918	BCDIOF-Unit_Certificate-(79)-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20241004.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2024-05-07	1788353979785093120.pdf	2024-10-03	\N	\N	\N
1649	304	93	2024-10-24	12345.00	\N	\N	\N	2024-10-24 16:30:14.935	2024-10-24 17:11:59.406	BCDIOF-Unit_Certificate-(52)-145000[Entity_for_Test]20241024.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-24	\N	\N	\N	\N	\N
1604	304	37	2024-10-21	500000.00	\N	\N	\N	2024-10-21 15:14:11.059	2024-11-05 10:38:09.764	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241021.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-21	\N	2024-10-31	\N	\N	\N
1626	304	154	2024-10-22	1234.00	\N	\N	\N	2024-10-22 14:43:11.155	2024-11-05 10:39:39.278	BCDIOF-Unit_Certificate-(Class)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1685	304	134	2023-07-11	100000.00	\N	\N	\N	2024-11-14 11:16:28.879	2024-11-14 11:16:28.879	BCDIOF-Unit_Certificate-(FUND)-145000[Entity_for_Test]20241114.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	f	2023-07-11	\N	2024-11-20	\N	\N	\N
331	173	38	2022-12-24	260000.00	\N	\N	\N	2022-12-30 08:11:47.109281	2023-11-30 11:54:36.499	fc3ffa25-c13b-44c4-a2d3-f35023cff35d.pdf	\N	97 Holmes Street	Brunswick	VIC	3056	\N	\N	222	f	2022-12-24	1636231170016227328.pdf	2023-09-30	\N	\N	\N
96	98	2	2022-05-12	370000.00	\N	\N	\N	2022-05-12 08:32:58.037565	2023-03-03 17:02:05.657	c435515c-a753-47c0-8694-ba61041e1169.pdf	Han Family SMSF Pty Ltd ATF Han Family SMSF	63 Fernhill Road	Sandringham	VIC	3191	\N	\N	194	f	2022-05-12	\N	2022-12-08	\N	\N	\N
1155	256	80	2023-06-30	460000.00	\N	\N	\N	2023-12-18 14:54:54.529	2023-12-18 15:08:51.871	adf68ad1-70cc-4762-9dc6-32d83fbc6627.pdf	\N	 6 Greenwich Road	Greenwich	NSW	2065	\N	\N	286	f	2023-06-30	\N	2023-11-13	\N	\N	\N
1187	125	44	2023-10-06	270000.00	\N	\N	\N	2024-01-05 10:46:02.759	2024-01-05 10:46:02.759	57dafee2-3f50-4659-9958-7f4b7fce95c9.pdf	\N	88 John Rd 	Cherrybrook 	NSW 	2126	\N	\N	287	f	2023-10-06	\N	2023-12-06	\N	\N	\N
1605	304	40	2024-10-21	44553322.00	\N	\N	\N	2024-10-21 15:56:52.297	2024-10-21 16:01:12.046	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1213	142	114	2022-12-14	100000.00	\N	\N	\N	2024-01-31 10:27:17.9	2024-01-31 10:35:27.221	4c46ee0c-6098-4c68-b90a-604fa3072680.pdf	\N	355 Dandelion Dr.	Rowville	VIC 	3178	\N	\N	212	t	2023-06-17	\N	2023-12-09	\N	\N	\N
1267	113	39	2024-03-01	165000.00	\N	\N	\N	2024-03-14 16:38:01.447	2024-03-14 16:38:01.447	8758b5e8-596d-4efd-80c0-e35720ee26d4.pdf	\N	38 Dalgetty Road	Beaumaris	VIC	3193	\N	\N	244	f	2024-03-01	\N	2024-11-30	\N	\N	\N
1292	201	121	2024-04-05	100000.00	\N	\N	\N	2024-04-08 11:10:55.302	2024-04-08 11:10:55.302	06a40432-974a-4d20-be3a-765a1d790a79.pdf	\N	2 Woods St	Balwyn	VIC	3103	\N	\N	129	f	2024-04-05	1777142042552377344.pdf	\N	\N	\N	\N
1318	57	38	2024-04-01	250000.00	\N	\N	\N	2024-04-29 15:46:51.079	2024-05-08 11:54:46.461	fe97b2ab-e2c1-4bc9-b20f-18414bafa47c.pdf	\N	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2024-04-01	\N	2024-12-31	\N	\N	\N
1369	33	2	2021-12-17	50000.00	\N	\N	\N	2024-06-14 10:59:13.406	2024-06-14 10:59:13.406	82cffe7e-e4dd-4800-8f69-f76af037dd6a.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2021-12-17	\N	2022-09-30	\N	\N	\N
1241	29	119	2024-03-01	100000.00	\N	\N	\N	2024-03-01 17:03:31.807	2024-07-02 12:01:25.765	44b476c9-3f41-4bff-a9d1-c77a05e5d22c.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2024-03-01	1763444940978733056.pdf	2024-06-12	\N	\N	\N
1459	210	135	2024-08-15	200000.00	\N	\N	\N	2024-08-16 11:41:20.217	2024-08-16 17:55:20.781	BCDIOF-Unit_Certificate-(85)-146241[Kaer_Guan]20240816.pdf	\N	9 Derwent Avenue	North Wahroonga	NSW	2076	\N	\N	297	f	2024-08-15	\N	\N	\N	\N	\N
1522	112	148	2023-12-06	500000.00	\N	\N	\N	2024-09-23 15:42:52.349	2024-09-23 15:44:08.606	BCDIOF-Unit_Certificate-(71-B)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240923.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2023-12-06	\N	2024-01-05	\N	\N	\N
1394	21	38	2024-07-01	250000.00	\N	\N	\N	2024-07-02 15:19:09.705	2024-07-02 15:19:09.705	BCDIOF-Unit_Certificate-146028[Aussie_Essence_International_PTY_LTD]20240814.pdf	\N	83/209 Harris St	Pyrmont	NSW	2009	\N	\N	136	f	2024-07-01	\N	2025-03-31	\N	\N	\N
1417	66	119	2024-06-13	1000000.00	\N	\N	\N	2024-07-22 18:23:16.977	2024-08-02 11:14:11.402	BCDIOF-Unit_Certificate-(69-B)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240814.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-06-13	\N	2024-07-21	\N	\N	\N
416	178	2	2023-03-03	5000000.00	\N	\N	\N	2023-03-03 14:59:22.626	2023-03-06 15:11:41.673	f1353624-2a18-45bb-89c3-91b27e9390c8.pdf	1	\N	\N	\N	\N	\N	\N	\N	t	2023-03-03	\N	\N	\N	\N	\N
1523	112	150	2023-12-06	500000.00	\N	\N	\N	2024-09-23 15:45:26.166	2024-09-23 15:45:26.166	BCDIOF-Unit_Certificate-(72-B)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240923.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2023-12-06	\N	2024-01-05	\N	\N	\N
1344	195	39	2023-04-27	150000.00	\N	\N	\N	2024-05-10 15:00:13.163	2024-10-09 14:56:21.246	ffbd868b-d0a9-47b5-b792-0237c7853ec5.pdf	\N	25 Norway St	Sydney	NSW	2000	\N	\N	91	t	2023-04-27	\N	2023-09-30	\N	\N	\N
395	179	2	2023-03-02	5000000.00	\N	\N	\N	2023-03-02 22:15:06.647	2023-03-06 15:12:30.378	6e36a34d-60c7-4736-aaea-e718e5c3e3a3.pdf	1	\N	\N	\N	\N	\N	\N	\N	t	2023-03-02	\N	\N	\N	\N	\N
1546	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 15:41:58.591	2024-10-09 15:45:28.272	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1548	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 15:55:36.222	2024-10-09 16:00:48.583	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1549	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 16:01:05.658	2024-10-09 16:16:41.871	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1627	304	154	2024-10-22	1234.00	\N	\N	\N	2024-10-22 14:49:39.126	2024-11-05 10:36:42.041	BCDIOF-Unit_Certificate-(Class)-145000[Entity_for_Test]20241022.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-22	\N	\N	\N	\N	\N
1580	304	77	2023-05-16	100000.00	\N	\N	\N	2024-10-14 17:47:42.659	2024-11-05 10:40:32.209	BCDIOF-Unit_Certificate-(37-B)-146999[test_company]20241014.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2023-05-16	\N	2023-09-04	\N	\N	\N
1686	304	155	2024-11-03	200000.00	\N	\N	\N	2024-11-15 11:52:57.156	2024-11-15 11:52:57.156	BCDIOF-Unit_Certificate-(A)-145000[Entity_for_Test]20241115.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	f	2024-11-03	\N	\N	\N	\N	\N
1482	112	111	2024-08-21	100000.00	\N	\N	\N	2024-08-22 16:39:54.795	2024-11-29 16:59:40.031	BCDIOF-Unit_Certificate-(68)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20241129.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-21	\N	\N	\N	\N	\N
415	179	2	2023-03-03	5000000.00	\N	\N	\N	2023-03-03 14:58:52.706	2023-03-03 14:59:05.441	294fdf95-1751-4b7d-8210-f771dbb854d2.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	\N	\N	\N	\N	\N	\N
706	179	37	2023-03-16	5000000.00	\N	\N	\N	2023-03-16 19:29:41.519	2023-03-28 22:18:38.992	ebf6a74d-be6c-42ef-9c9b-222c06c51b66.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-16	\N	\N	\N	\N	\N
1188	189	37	2024-01-04	800000.00	\N	\N	\N	2024-01-05 16:31:41.373	2024-03-07 14:04:13.42	b6d6e256-da66-4825-9f7b-729b84b704b8.pdf	\N	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	234	f	2024-01-04	1743143207639695360.pdf	2024-03-06	\N	\N	\N
1268	227	2	2024-03-01	100000.00	\N	\N	\N	2024-03-14 16:39:41.263	2024-03-14 16:39:41.263	7b0ab39e-be74-4363-b1f3-5491792d0d8d.pdf	\N	90 Commodore Drive	Surfers Paradise	QLD	4217	\N	\N	110	f	2024-03-01	\N	2024-11-30	\N	\N	\N
1293	101	121	2024-04-05	100000.00	\N	\N	\N	2024-04-08 11:12:53.221	2024-04-08 11:12:53.221	29def039-d2b9-4db3-9002-2bb6faaaf5c7.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2024-04-05	1777142537140510720.pdf	\N	\N	\N	\N
1346	301	39	2023-04-27	150000.00	\N	\N	\N	2024-05-10 15:29:47.234	2024-05-10 15:29:47.234	e4c06af4-657a-4ffa-81ad-f9182182f0b2.pdf	\N	5 SHIELDS CT	BLACKBURN SOUTH	VIC	3130 	\N	\N	306	f	2023-04-27	\N	2023-09-30	\N	\N	\N
725	23	37	2023-03-29	780000.00	\N	\N	\N	2023-03-29 15:22:43.723	2023-03-29 15:22:43.723	2d1ba994-019d-4fd2-bd73-46a72497c2f9.pdf	Nathan Management PL ATF Ultimate Family Trust	Unit 602, 19 Shoreline Drive	Rhodes	NSW 	2138	\N	\N	137	f	2023-03-29	\N	2024-03-31	\N	\N	\N
673	199	69	2023-03-01	\N	\N	\N	\N	2023-03-14 17:36:14.24	2023-03-15 12:24:57.749	2c24161e-1f87-4703-b937-496223a7bf05.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
678	198	45	2023-03-01	\N	\N	\N	\N	2023-03-14 17:37:28.335	2023-03-15 12:25:15.077	2f3c799d-3f95-4f40-a23c-7248ea79ff34.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
418	31	37	2022-12-14	500000.00	\N	\N	\N	2023-03-03 15:04:35.342	2023-03-20 11:13:04.567	82eda370-983c-4db4-b272-af96aa61ae7b.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	\N	105	f	\N	1637608156974411776.pdf	2023-12-31	\N	\N	\N
918	73	37	2023-08-11	2000000.00	\N	\N	\N	2023-08-15 12:16:26.883	2023-11-01 15:21:31.919	45e62c35-04b4-43dc-86a8-b89a092ae2f1.pdf	Wins Republic Pty Ltd ATF Wins Republic Family Trust	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-08-11	1691272608646287360.pdf	2023-08-31	\N	\N	\N
78	32	2	2022-02-17	100000.00	\N	\N	\N	2022-03-29 15:20:07.016874	2023-03-03 16:47:40.407	93579545-31d5-487c-ad09-f61b85000ef2.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	139	f	2022-02-17	\N	2022-11-30	\N	\N	\N
144	128	2	2022-08-15	300000.00	\N	\N	\N	2022-08-19 15:37:59.737391	2023-03-03 17:31:07.187	b99a8b1c-6f2b-48c8-9932-b0de027fda6a.pdf	Xiaobo HAN ATF Han Investment Trust	\N	\N	\N	\N	\N	\N	75	f	2022-08-15	\N	2023-05-31	\N	\N	\N
655	179	40	2023-03-14	5000000.00	\N	\N	\N	2023-03-14 10:36:02.77	2023-03-14 11:03:27.146	3b1107f0-0185-40d2-8759-51b03f4ec8ed.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-14	\N	\N	\N	\N	\N
328	171	38	2022-12-29	303000.00	\N	\N	\N	2022-12-30 07:41:31.85116	2023-03-16 15:46:50.973	a525467f-b1df-4afd-b88d-006508b2ac55.pdf	ONE REED PTY LTD ATF ONE REED SUPER FUND	5 MIDDLEBROOK RISE	BELLA VISTA	NSW	2153	\N	\N	90	f	2022-12-29	1636227502852354048.pdf	2023-09-30	\N	\N	\N
1214	276	110	2024-01-31	100000.00	\N	\N	\N	2024-01-31 14:22:58.311	2024-05-15 15:29:30.916	11c40db7-09dc-487e-b27c-3beeda9311e9.pdf	\N	40 Berith St	Auburn	NSW 	2144	\N	\N	276	f	2024-01-31	1752532899199946752.pdf	2024-05-06	\N	\N	\N
1124	277	2	2023-12-07	50000.00	\N	\N	\N	2023-12-08 15:18:06.372	2023-12-20 11:13:22.237	ab71c807-3596-4959-a881-5c4299053200.pdf	\N	U16, 222-228 SUSSEX ST	SYDNEY	NSW	2000	\N	\N	279	f	2023-12-07	1737264894127849472.pdf	2024-09-30	\N	\N	\N
684	199	70	2023-03-01	\N	\N	\N	\N	2023-03-14 17:38:46.359	2023-03-15 10:12:05.734	8c22238b-faf4-4080-a57b-ca0360289b4a.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1243	285	74	2024-01-25	650000.00	\N	\N	\N	2024-03-04 14:09:01.06	2024-03-04 14:09:01.06	b54d6252-05a5-4281-950f-88b2d5eff4e0.pdf	\N	Room B6-3402, Vanke Opal, Nancun town	Panyu District\t	Guangzhou, China	510006	\N	\N	291	f	2024-01-25	\N	\N	\N	\N	\N
1156	15	110	2023-12-15	100000.00	\N	\N	\N	2023-12-19 09:53:36.199	2024-05-20 09:19:37.054	b592c7e5-682e-4d1b-93d8-373d87d47ec6.pdf	\N	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	\N	88	f	2023-12-15	1736882432176521216.pdf	2024-05-06	\N	\N	\N
686	199	43	2023-03-01	\N	\N	\N	\N	2023-03-14 17:39:08.491	2023-03-14 17:41:46.692	093adb83-6673-40b0-85f6-1cf439525adc.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1370	33	2	2022-10-01	50000.00	\N	\N	\N	2024-06-14 11:00:39.118	2024-06-14 11:39:13.018	1a9575b6-2be2-4ee3-94fb-28afa3aa4abe.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2022-10-01	\N	2022-12-08	\N	\N	\N
694	179	70	2023-03-15	500000.00	\N	\N	\N	2023-03-15 11:02:22.027	2023-03-15 11:02:36.698	e89f6ab1-3013-49ea-8e1a-be0aa01e2bbe.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-14	\N	\N	\N	\N	\N
1524	112	107	2023-11-06	1950000.00	\N	\N	\N	2024-09-23 16:59:40.513	2024-09-23 17:02:04.919	BCDIOF-Unit_Certificate-(67)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240923.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2023-11-06	\N	2023-11-06	\N	\N	\N
1319	60	38	2024-04-29	300000.00	\N	\N	\N	2024-04-29 16:14:09.487	2024-06-27 16:38:44.887	0fce52f7-ad04-4331-b4d9-7205878dc6fa.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2024-04-29	1785092316587827200.pdf	2024-06-25	\N	\N	\N
1418	255	119	2024-02-01	750000.00	\N	\N	\N	2024-07-22 18:46:21.729	2024-08-02 11:54:20.893	88b2f455-9584-4775-a0f8-401e84a1ad9f.pdf	\N	Ground Floor, 187 Thomas Street	HAYMARKET	NSW	2000	\N	\N	289	f	2024-02-01	\N	2024-07-21	\N	\N	\N
1395	163	2	2024-07-01	100000.00	\N	\N	\N	2024-07-02 15:59:30.85	2024-07-02 15:59:30.85	BCDIOF-Unit_Certificate-146108[Hong_MENG]20240814.pdf	\N	8-10  Fairthorne  Street	Keysborough	VIC	3173	\N	\N	224	f	2024-07-01	\N	2025-03-31	\N	\N	\N
1460	275	140	2024-08-15	5850000.00	\N	\N	\N	2024-08-16 11:59:59.088	2024-08-19 16:31:35.566	BCDIOF-Unit_Certificate-(89)-146177[Yinghong_XING]20240819.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2024-08-15	\N	\N	\N	\N	\N
1483	118	141	2024-08-23	130000.00	\N	\N	\N	2024-08-23 17:35:02.013	2024-08-23 17:35:17.263	BCDIOF-Unit_Certificate-(90)-146087[Shengling_HU]20240823.pdf	\N	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2024-08-23	1826885909009440768.pdf	\N	\N	\N	\N
1547	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 15:45:56.219	2024-10-09 15:47:08.523	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1687	327	158	2024-11-20	1500000.00	\N	\N	\N	2024-11-22 16:23:27.333	2024-11-22 16:23:27.333	BCDIOF-Unit_Certificate-(98)-42344233232432[25523]20241122.pdf	\N	rewrew	rewr	rweewr	werwer	\N	\N	353	f	2024-11-04	\N	\N	\N	\N	\N
1606	304	40	2024-10-21	999999.00	\N	\N	\N	2024-10-21 16:01:43.665	2024-10-21 16:03:54.669	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1660	304	93	2023-12-07	400000.00	\N	\N	\N	2024-10-24 17:14:42.778	2024-11-05 10:38:03.41	BCDIOF-Unit_Certificate-(52)-145000[Entity_for_Test]20241024.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-12-07	\N	2024-01-03	\N	\N	\N
1629	304	2	2024-10-22	12345.00	\N	\N	\N	2024-10-22 15:14:00.826	2024-11-05 10:36:34.619	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241028.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-22	\N	\N	\N	\N	\N
1628	304	154	2024-10-22	1234.00	\N	\N	\N	2024-10-22 15:06:29.482	2024-11-05 10:36:38.198	BCDIOF-Unit_Certificate-(Gold)-145000[Entity_for_Test]20241022.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-22	\N	\N	\N	\N	\N
1581	304	77	2023-09-05	200000.00	\N	\N	\N	2024-10-14 17:49:53.899	2024-11-05 10:40:30.706	BCDIOF-Unit_Certificate-(37-B)-146999[test_company]20241014.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2023-09-05	\N	2023-11-16	\N	\N	\N
483	183	37	2023-02-10	500000.00	\N	\N	\N	2023-03-03 19:08:53.477	2023-03-17 17:30:19.746	6b2fa40c-4e24-4954-8ef0-4942eadaa31a.pdf	\N	1 Larne Avenue   	Donvale	VIC	3111	\N	\N	233	f	2023-02-10	1636615932199383040.pdf	2024-02-29	\N	\N	\N
455	123	37	2022-10-20	500000.00	\N	\N	\N	2023-03-03 17:18:51.5	2023-11-01 15:59:16.658	0f255a06-12e9-4271-b26f-2c1fdbb597c1.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	1 Jean Street	McKinnon	VIC	3204	\N	\N	245	f	2022-10-20	1637598488638124032.pdf	2023-10-31	\N	\N	\N
1525	203	152	2023-09-01	100000.00	\N	\N	\N	2024-09-24 11:14:13.331	2024-09-24 11:14:13.331	BCDIOF-Unit_Certificate-(56)-146176[Worldlink_Group_pty_Ltd]20240924.pdf	\N	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	\N	107	f	2023-09-01	\N	2023-09-30	\N	\N	\N
1320	131	72	2023-03-27	200000.00	\N	\N	\N	2024-04-30 10:07:55.576	2024-04-30 10:09:25.477	43b6a537-c5f0-48d6-b6f7-07ecfbc4e697.pdf	\N	21 Acheron Ave	Camberwell	VIC 	3124	\N	\N	102	f	2023-03-27	\N	2023-10-05	\N	\N	\N
1158	131	43	2023-10-06	90000.00	\N	\N	\N	2023-12-19 10:24:06.029	2024-10-17 16:09:18.797	BCDIOF-Unit_Certificate-(3-1E)-146122[Golden_Life_Super_Investments_Pty_Ltd_ATF_Golden_Life_Superannuation_Fund]20241017.pdf	\N	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	76	f	2023-10-06	\N	2023-12-06	\N	\N	\N
1189	64	109	2023-03-24	100000.00	\N	\N	\N	2024-01-05 16:49:29.218	2024-02-29 11:02:27.113	6d485470-6250-47b3-ab23-14f45d3c902a.pdf	\N	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-03-24	\N	\N	\N	\N	\N
1484	315	135	2024-08-28	400000.00	\N	\N	\N	2024-08-29 09:43:55.97	2024-08-29 09:43:55.97	BCDIOF-Unit_Certificate-(85)-146259[Weijia_CHEN]20240829.pdf	\N	70A Pymble Ave	Pymble	NSW	2073	\N	\N	330	f	2024-08-28	\N	\N	\N	\N	\N
1244	166	102	2024-03-04	2100000.00	\N	\N	\N	2024-03-04 14:24:17.985	2024-03-04 14:24:17.985	fecc7d23-ca26-4cb9-9d53-8f2facd407b3.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	f	2024-03-04	1764492032941703168.pdf	2025-09-30	\N	\N	\N
1269	183	37	2024-03-01	500000.00	\N	\N	\N	2024-03-14 16:44:43.159	2024-03-14 16:44:43.159	73162d9e-189a-4bf8-a90b-6d3685e8fb3b.pdf	\N	1 Larne Avenue   	Donvale	VIC	3111	\N	\N	233	f	2024-03-01	\N	2025-02-28	\N	\N	\N
1215	254	110	2024-01-30	80000.00	\N	\N	\N	2024-01-31 16:15:48.257	2024-05-15 15:28:50.539	86724929-69e9-4d5a-bf84-fbbf5872a7c1.pdf	\N	5 Rubens Court\t	Wheelers Hill	VIC	3150	\N	\N	253	f	2024-01-30	1752561294528962560.pdf	2024-05-06	\N	\N	\N
1419	66	102	2024-05-07	4000000.00	\N	\N	\N	2024-07-30 12:23:14.119	2024-07-30 12:23:14.119	38c9b8a0-ef0f-45d2-b71d-b9579949a887.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-05-07	\N	2024-06-12	\N	\N	\N
1125	210	111	2023-12-08	300000.00	\N	\N	\N	2023-12-08 15:27:53.73	2023-12-08 15:27:53.73	cbbb4f24-13a6-40cb-8c59-4f083de69bc8.pdf	\N	3 Dalwood Pl	Carlingford	NSW	2118	\N	\N	99	f	2023-12-08	1732980293028990976.pdf	\N	\N	\N	\N
57	28	2	2022-03-15	100000.00	\N	\N	\N	2022-03-24 12:20:28.298837	2023-03-17 11:43:59.047	e4f6166b-7ad9-4b12-97db-d94029feefce.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-03-15	\N	2022-12-08	\N	\N	\N
296	28	37	2022-12-09	500000.00	\N	\N	\N	2022-12-13 13:27:20.099575	2023-03-20 11:26:42.73	f9fe6887-f3b6-45ae-8e95-4f0229f02aeb.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-12-09	1637611588598755328.pdf	2023-12-31	\N	\N	\N
507	181	2	2023-03-01	700000.00	\N	\N	\N	2023-03-06 14:44:11.147	2023-03-15 14:57:05.355	302ee8e5-66d9-4923-b941-d7db05df446d.pdf	Auriga International Group Pty Ltd	UNIT 1507 , 68 ELIZABETH STREET	ADELAIDE	SA	5000	\N	\N	48	f	2023-03-01	\N	2023-06-30	\N	\N	\N
33	14	2	2022-11-01	20000.00	\N	\N	\N	2022-01-04 12:47:00.257653	2023-03-17 12:01:39.986	153e2ab8-c573-4862-931e-76275813ada4.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	\N	\N	2022-12-21	\N	\N	\N
332	14	38	2022-12-21	250000.00	\N	\N	\N	2022-12-30 08:13:43.914263	2023-03-16 16:03:28.376	7aec1390-b319-40d5-bd46-9258e036af69.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	2022-12-21	1636231686263746560.pdf	2023-09-30	\N	\N	\N
403	18	2	2021-11-03	200000.00	\N	\N	\N	2023-03-03 14:07:27.153	2023-03-14 15:32:01.428	4626f06c-a540-461c-89d8-d65d9233a7e7.pdf	Hung Fung TONG	Unit 302, 80 Alfred St.	Milsons Point	NSW	2061	\N	\N	156	f	\N	\N	2022-09-30	\N	\N	\N
440	64	2	2023-01-01	100000.00	\N	\N	\N	2023-03-03 16:41:58.223	2023-11-01 14:39:28.683	731308c9-fbb4-48bc-96b6-d78a60e23472.pdf	Minghao GU ATF GU Family Trust	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-01-01	\N	2023-10-31	\N	\N	\N
1042	109	38	2023-10-01	250000.00	\N	\N	\N	2023-11-01 15:05:49.899	2023-11-01 15:05:49.899	73772c6f-eab4-45d2-9f36-1cfccd6ea60b.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	170	f	2023-10-01	\N	2024-07-31	\N	\N	\N
439	63	37	2022-12-15	700000.00	\N	\N	\N	2023-03-03 16:40:07.333	2023-11-01 15:45:22.473	d039f5ee-733f-4c63-a346-3d325a6858d4.pdf	Zongquan YU	Suite 407, Blk 18, Jianjin Street	Jiangyang City	Jiangsu Province	China	\N	\N	179	f	2022-12-15	1637600572032806912.pdf	2023-08-31	\N	\N	\N
448	98	37	2022-12-09	500000.00	\N	\N	\N	2023-03-03 17:03:14.44	2023-03-20 10:40:19.729	b3447b5a-8d82-47d0-96ac-6cd4a50848b9.pdf	\N	63 Fernhill Road	Sandringham	VIC	3191	\N	\N	194	f	2022-12-09	1637599915846529024.pdf	2023-12-31	\N	\N	\N
1347	240	123	2024-05-15	150000.00	\N	\N	\N	2024-05-17 10:57:31.933	2024-05-17 11:03:00.954	d7424749-deb8-4bc5-b512-c19630a3fd80.pdf	\N	17 Mulvihill Cres 	Denham Court 	NSW 	2565	\N	\N	121	f	2024-05-15	1791271799736983552.pdf	\N	\N	\N	\N
145	129	2	2022-08-18	50000.00	\N	\N	\N	2022-08-22 09:57:16.790691	2023-03-03 17:37:31.573	2867302d-f99d-455b-9419-dce3bf9a8812.pdf	\N	119 Balwyn Rd.	Balwyn	VIC	3103	\N	\N	217	f	2022-08-18	\N	2023-05-31	\N	\N	\N
330	168	37	2022-12-24	400000.00	\N	\N	\N	2022-12-30 08:07:49.413587	2023-03-20 11:29:31.883	c2a95578-ad2e-4c4d-b74b-f7c9534a7b37.pdf	Yingda XU	21 Acheron Avenue	Camberwell	VIC	3124	\N	\N	230	f	2022-12-24	1637612298077859840.pdf	2023-12-31	\N	\N	\N
1294	254	121	2024-04-08	100000.00	\N	\N	\N	2024-04-08 11:15:32.638	2024-04-08 11:15:32.638	d561b68c-f413-4fd0-bb9f-3ac830bbb8a4.pdf	\N	5 Rubens Court\t	Wheelers Hill	VIC	3150	\N	\N	253	f	2024-04-08	1777143205783871488.pdf	\N	\N	\N	\N
1396	262	2	2024-07-01	50000.00	\N	\N	\N	2024-07-02 16:02:14.383	2024-07-02 16:02:14.383	BCDIOF-Unit_Certificate-146202[Dongmei_HE]20240814.pdf	\N	15 Edison St	Belmore	NSW	2192	\N	\N	259	f	2024-07-01	\N	2025-03-31	\N	\N	\N
1371	33	2	2022-12-01	50000.00	\N	\N	\N	2024-06-14 11:29:35.063	2024-06-14 11:29:35.063	938f9f4d-ae57-4c9e-be46-c0a950989a15.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2022-12-01	\N	2022-12-08	\N	\N	\N
975	266	38	2023-10-11	500000.00	\N	\N	\N	2023-10-11 11:22:32.061	2024-09-11 11:06:53.825	BCDIOF-Unit_Certificate-146207[Wan_NG]20240911.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	999077	\N	\N	265	f	2023-10-11	1711900049662394368.pdf	2023-10-11	\N	\N	\N
931	166	38	2023-12-01	800000.00	\N	\N	\N	2023-09-05 10:41:59.617	2024-08-08 17:33:00.588	cfd4c1f8-ec09-4e8a-9deb-393027afcaf4.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	f	2023-09-01	1698858983587364864.pdf	2024-03-03	\N	\N	\N
1461	313	141	2024-08-15	300000.00	\N	\N	\N	2024-08-16 12:09:11.714	2024-08-16 12:09:11.714	BCDIOF-Unit_Certificate-(90)-146257[DONGYUE_XU]20240816.pdf	\N	12-1-1501, Qian Tang Chun Xiao	Binjiang District	Hangzhou	310052	\N	\N	328	f	2024-08-15	\N	\N	\N	\N	\N
1550	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 16:17:00.4	2024-10-09 16:18:54.418	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1551	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 16:19:12.486	2024-10-09 16:20:59.966	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1582	304	77	2023-11-17	150000.00	\N	\N	\N	2024-10-14 17:56:53.945	2024-11-05 10:40:29.414	BCDIOF-Unit_Certificate-(37-B)-146999[test_company]20241014.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2023-11-17	\N	2024-03-16	\N	\N	\N
1688	310	38	2024-08-21	400000.00	\N	\N	\N	2024-11-22 16:34:44.978	2024-11-22 16:34:44.978	BCDIOF-Unit_Certificate-146253[Xiaoyu_ZHU]20241122.pdf	\N	T20-C HUTANG XINCUNNANDU	CHANGZHOU	JIANGSU	000000	\N	\N	318	f	2024-08-21	\N	2025-05-31	\N	\N	\N
1485	314	135	2024-08-27	100000.00	\N	\N	\N	2024-08-29 11:14:52.226	2024-08-29 11:17:34.212	BCDIOF-Unit_Certificate-(85)-146258[Bing_SUN]20240829.pdf	\N	G81 37 Rothschild Ave	Rosebery	NSW	2018	\N	\N	331	f	2024-08-27	1828965180477579264.pdf	\N	\N	\N	\N
1110	110	107	2023-12-01	200000.00	\N	\N	\N	2023-12-01 13:54:53.297	2023-12-01 13:54:53.297	951d03ef-c6b6-4665-8b5d-192e1540f151.pdf	\N	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2023-12-01	1730420171938693120.pdf	\N	\N	\N	\N
1422	66	102	2024-07-19	200000.00	\N	\N	\N	2024-07-30 12:24:53.391	2024-08-29 14:08:08.984	BCDIOF-Unit_Certificate-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240829.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-07-19	\N	2024-08-11	\N	\N	\N
1245	259	110	2023-12-05	230000.00	\N	\N	\N	2024-03-04 16:34:30.406	2024-08-29 17:08:21.341	a90ee458-cce6-4aec-a93d-be4fd59ed5c3.pdf	\N	\N	\N	\N	\N	\N	\N	258	t	2023-12-05	1764524800618741760.pdf	2024-05-06	\N	\N	\N
1126	278	111	2023-12-08	250000.00	\N	\N	\N	2023-12-08 16:27:50.393	2023-12-08 16:27:50.393	d8a9df2e-a007-4f6d-bc47-e722b5affc2d.pdf	\N	2A Lochiel Ave \t	Campbelltown \t	SA \t	5074	\N	\N	280	f	2023-12-08	1732995378535387136.pdf	\N	\N	\N	\N
461	119	2	2022-07-19	100000.00	\N	\N	\N	2023-03-03 17:48:04.505	2023-03-14 11:53:09.81	d5249c37-5d36-4960-b6ec-e2c08feaf1cf.pdf	Wensheng ZENG	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-07-19	\N	2023-02-02	\N	\N	\N
497	187	37	2022-10-24	2000000.00	\N	\N	\N	2023-03-03 20:00:54.711	2023-11-01 16:00:47.224	28a7eba3-86e5-417e-a360-7bd6f85d26e7.pdf	CHANG LIU	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	\N	f	2022-10-24	1636615659129221120.pdf	2023-10-31	\N	\N	\N
1190	101	86	2023-07-10	100000.00	\N	\N	\N	2024-01-05 17:17:57.999	2024-01-05 17:17:57.999	6d0bac92-82d5-44f0-9028-0eadb0294ffd.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2023-07-10	\N	\N	\N	\N	\N
1270	289	121	2024-03-14	500000.00	\N	\N	\N	2024-03-15 14:24:24.5	2024-03-15 14:24:24.5	2074a8e7-60ad-4f47-9f62-9a21749804c8.pdf	\N	6 Glenroy Ave	Beaumont	SA	5066	\N	\N	295	f	2024-03-14	1768478326818480128.pdf	\N	\N	\N	\N
1295	242	121	2024-04-07	100000.00	\N	\N	\N	2024-04-08 11:18:37.814	2024-04-08 11:18:37.814	1992a369-484f-4b9f-93da-2b86b1405236.pdf	\N	108 Cityview Road	Balwyn North	VIC	3104	\N	\N	123	f	2024-04-07	1777143982468308992.pdf	\N	\N	\N	\N
1321	131	72	2023-10-06	160000.00	\N	\N	\N	2024-04-30 10:09:55.717	2024-04-30 10:09:55.717	79db8e54-7deb-40fb-96c6-19701cf5249c.pdf	\N	21 Acheron Ave	Camberwell	VIC 	3124	\N	\N	102	f	2023-10-06	\N	2023-11-24	\N	\N	\N
1607	304	40	2024-10-21	888888.00	\N	\N	\N	2024-10-21 16:07:32.671	2024-10-21 16:09:48.319	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1216	250	110	2024-02-01	100000.00	\N	\N	\N	2024-02-01 11:06:43.984	2024-05-15 15:28:05.864	d0336c2a-6879-4e41-b329-5f9aae68f5e9.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2024-02-01	1752845901962895360.pdf	2024-05-06	\N	\N	\N
1526	66	152	2023-09-01	500000.00	\N	\N	\N	2024-09-24 11:15:47.215	2024-09-24 11:15:47.215	BCDIOF-Unit_Certificate-(56)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240924.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-09-01	\N	2023-09-30	\N	\N	\N
1348	240	124	2024-05-16	150000.00	\N	\N	\N	2024-05-17 10:57:50.999	2024-05-17 11:02:53.67	2dd39931-6f7a-4983-bdd6-e2b489c17b68.pdf	\N	17 Mulvihill Cres 	Denham Court 	NSW 	2565	\N	\N	121	f	2024-05-16	1791271879705583616.pdf	\N	\N	\N	\N
506	152	2	2023-03-06	5000000.00	\N	\N	\N	2023-03-06 12:16:52.877	2023-03-06 12:27:00.83	eb7e775a-cd37-46e4-a0fa-96902b8b0c2a.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	\N	\N	\N	\N	\N	\N
1397	31	37	2024-07-05	550000.00	\N	\N	\N	2024-07-05 16:41:07.576	2024-10-02 11:29:48.474	BCDIOF-Unit_Certificate-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20241002.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-07-05	1809115273597243392.pdf	2024-09-19	\N	\N	\N
1159	131	43	2023-12-07	58500.00	\N	\N	\N	2023-12-19 10:28:23.382	2024-07-04 16:57:16.965	e31f43b8-e3be-43b4-9e5c-27cd91fd6286.pdf	\N	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	76	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1420	66	102	2024-06-13	3000000.00	\N	\N	\N	2024-07-30 12:23:52.243	2024-07-30 12:23:52.243	BCDIOF-Unit_Certificate-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240814.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-06-13	\N	2024-07-04	\N	\N	\N
1552	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 16:22:55.456	2024-10-09 16:23:41.75	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1553	304	107	2024-10-31	999999.00	\N	\N	\N	2024-10-09 16:24:00.347	2024-10-09 16:27:24.562	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1554	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 16:27:41.999	2024-10-09 16:28:57.334	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1372	257	119	2024-06-14	300000.00	\N	\N	\N	2024-06-14 14:30:01.652	2024-08-02 11:40:34.026	BCDIOF-Unit_Certificate-(69-B)-146201[Lijun_LIU]20240814.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-06-14	1801472136171147264.pdf	2024-07-21	\N	\N	\N
1630	304	156	2024-10-22	500000.00	\N	\N	\N	2024-10-22 16:48:03.571	2024-10-22 17:11:27.394	BCDIOF-Unit_Certificate-(A)-000001[TEST_ENTITY]20241022.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-10-22	\N	2026-10-31	\N	\N	\N
1462	304	137	2024-08-16	100000.00	\N	\N	\N	2024-08-16 17:24:41.408	2024-08-16 17:28:04.591	BCDIOF-Unit_Certificate-(86)-146000[Entity_for_Test]20240816.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-16	\N	\N	\N	\N	\N
1583	304	72	2023-03-24	200000.00	\N	\N	\N	2024-10-15 09:46:15.327	2024-10-15 09:47:06.492	BCDIOF-Unit_Certificate-(36-A)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-03-24	\N	2023-09-01	\N	\N	\N
1661	304	130	2024-08-15	200000.00	\N	\N	\N	2024-10-24 17:35:09.046	2024-11-05 10:38:01.97	BCDIOF-Unit_Certificate-(82)-145000[Entity_for_Test]20241024.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-15	\N	2024-09-19	\N	\N	\N
1556	304	153	2024-10-09	888888.00	\N	\N	\N	2024-10-09 16:30:58.081	2024-11-05 10:38:11.457	BCDIOF-Unit_Certificate-(66)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	\N	\N	\N	\N
1585	304	93	2023-08-24	200000.00	\N	\N	\N	2024-10-15 09:50:19.887	2024-11-05 10:38:30.152	BCDIOF-Unit_Certificate-(52)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-08-24	\N	2023-10-01	\N	\N	\N
1689	60	37	2024-11-26	633000.00	\N	\N	\N	2024-11-26 18:01:14.882	2024-11-26 18:01:14.882	BCDIOF-Unit_Certificate-146056[Xiandong_GAO]20241126.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou,	Wulumuqi	Xinjiang, Uyghur, China	830063	\N	\N	176	f	2024-11-26	\N	2025-11-30	\N	\N	\N
1111	123	107	2023-12-01	100000.00	\N	\N	\N	2023-12-01 13:57:12.838	2023-12-01 13:57:12.838	3cca6c93-6d7e-4f52-9de8-82b542bb23cb.pdf	\N	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	\N	245	f	2023-12-01	1730420757216067584.pdf	\N	\N	\N	\N
674	199	69	2023-03-01	\N	\N	\N	\N	2023-03-14 17:36:27.37	2023-03-15 12:25:02.453	3ebaf85b-fc50-4182-9329-5d95e2bb9ca0.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1127	130	111	2023-12-04	100000.00	\N	\N	\N	2023-12-08 16:49:48.865	2024-01-08 14:31:03.051	67ca8783-57d8-4cd0-9f69-6a95205623b0.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	t	2023-12-04	1733000908599382016.pdf	\N	\N	\N	\N
1191	130	107	2023-12-04	100000.00	\N	\N	\N	2024-01-08 14:31:37.869	2024-01-08 14:31:37.869	a6a006ae-9d04-4318-91ca-7f32812fcaff.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	f	2023-12-04	1744200157479550976.pdf	\N	\N	\N	\N
1486	112	102	2024-08-14	330000.00	\N	\N	\N	2024-08-29 11:53:02.494	2024-08-29 11:53:02.494	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240829.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-14	\N	2024-08-18	\N	\N	\N
1218	255	110	2023-12-01	1000000.00	\N	\N	\N	2024-02-01 14:00:46.8	2024-10-10 16:36:39.057	BCDIOF-Unit_Certificate-()-146219[WINS_COLLEGE_PTY_LTD]20241010.pdf	\N	Ground Floor, 187 Thomas Street	HAYMARKET	NSW	2000	\N	\N	289	f	2023-12-01	1752889702303621120.pdf	2024-05-06	\N	\N	\N
1407	30	37	2024-07-12	800000.00	\N	\N	\N	2024-07-12 14:49:47.805	2024-08-29 11:55:11.511	BCDIOF-Unit_Certificate-146035[Evergreen_SUN_Pty_Ltd_ATF_Evergreen_Spring_Trust]20240829.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2024-07-12	\N	2024-08-27	\N	\N	\N
1271	226	122	2024-03-15	150000.00	\N	\N	\N	2024-03-18 12:21:16.701	2024-03-19 10:02:08.429	0c44d4e8-6536-471b-be1e-352acba77eaa.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2024-03-15	1769861876381786112.pdf	\N	\N	\N	\N
1296	126	121	2024-04-05	100000.00	\N	\N	\N	2024-04-08 11:42:52.794	2024-04-08 11:42:52.794	963038b7-05a9-4cf1-982e-27b3c0918867.pdf	\N	19B Arlington Drive 	Glen Waverley	VIC	3150	\N	\N	190	f	2024-04-05	1777150085096742912.pdf	\N	\N	\N	\N
1489	30	38	2024-08-28	370000.00	\N	\N	\N	2024-08-29 11:55:46.131	2024-08-29 11:55:46.131	BCDIOF-Unit_Certificate-146035[Evergreen_SUN_Pty_Ltd_ATF_Evergreen_Spring_Trust]20240829.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2024-08-28	\N	2025-05-31	\N	\N	\N
1584	304	72	2023-09-02	100000.00	\N	\N	\N	2024-10-15 09:46:43.818	2024-10-15 09:47:10.179	BCDIOF-Unit_Certificate-(36-A)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-09-02	\N	2023-09-30	\N	\N	\N
1463	66	102	2024-08-19	100000.00	\N	\N	\N	2024-08-19 12:39:32.371	2024-08-29 14:07:12.506	BCDIOF-Unit_Certificate-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240819.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	t	2024-08-19	\N	2024-08-19	\N	\N	\N
1527	112	152	2023-09-01	1500000.00	\N	\N	\N	2024-09-24 11:18:26.514	2024-09-24 11:18:26.514	BCDIOF-Unit_Certificate-(56)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240924.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2023-09-01	\N	2023-09-30	\N	\N	\N
615	179	2	2023-03-08	500000.00	\N	\N	\N	2023-03-08 13:09:30.112	2023-03-28 22:18:33.042	4311f357-e86e-4afc-af42-c320865e2e1c.pdf	1	\N	\N	\N	\N	\N	\N	\N	t	2023-03-08	1635865291789250560.docx	2023-04-08	\N	\N	\N
1219	31	37	2024-02-01	500000.00	\N	\N	\N	2024-02-01 14:06:07.275	2024-10-02 11:29:39.477	BCDIOF-Unit_Certificate-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20241002.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-02-01	1752891046473195520.pdf	2024-09-19	\N	\N	\N
550	152	43	2023-03-01	100000.00	\N	\N	\N	2023-03-06 16:53:17.85	2023-03-06 16:53:45.225	32b467ad-a92d-425d-bf73-048e7f3d674f.pdf	test	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1160	191	43	2023-12-07	58500.00	\N	\N	\N	2023-12-19 10:54:06.526	2024-07-02 15:14:12.328	d4cf44d2-c1fe-4ae0-aaf3-699a83728099.pdf	\N	2B Wandella Ave	Roseville 	NSW 	2069	\N	\N	85	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1349	211	38	2024-05-16	300000.00	\N	\N	\N	2024-05-21 16:17:07.035	2024-07-04 15:09:59.713	65e92d0f-38c6-491a-8620-e9b0378e321a.pdf	\N	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2024-05-16	1792802942571470848.pdf	2024-06-30	\N	\N	\N
1322	124	37	2024-04-30	650000.00	\N	\N	\N	2024-04-30 12:07:04.66	2024-07-12 14:45:44.752	b0ecf58f-8585-4089-888c-49ef946a0ae4.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2024-04-30	1785177413169127424.pdf	2024-07-10	\N	\N	\N
772	119	75	2023-06-01	150000.00	\N	\N	\N	2023-06-01 16:47:11.308	2023-06-01 16:49:52.728	e2b78be5-0473-4b02-8b86-971819c364ca.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	 12 Smythe Avenue	Mont Albert	VIC\t	3127	\N	\N	\N	f	2023-06-01	1664162329827479552.pdf	\N	\N	\N	\N
1217	255	110	2023-11-02	1000000.00	\N	\N	\N	2024-02-01 13:56:26.342	2024-10-10 16:33:59.966	BCDIOF-Unit_Certificate-()-146200[Yufeng_MA]20241010.pdf	\N	 6 Greenwich Road\t	Greenwich 	NSW\t	2065	\N	\N	254	f	2023-11-02	1752888696480161792.pdf	2024-05-06	\N	\N	\N
1421	66	102	2024-07-05	500000.00	\N	\N	\N	2024-07-30 12:24:25.12	2024-07-30 12:24:25.12	BCDIOF-Unit_Certificate-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240814.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-07-05	\N	2024-07-18	\N	\N	\N
1608	304	40	2024-10-21	888888.00	\N	\N	\N	2024-10-21 16:10:13.946	2024-10-21 16:11:13.38	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1398	124	37	2024-07-01	500000.00	\N	\N	\N	2024-07-08 15:02:07.537	2024-07-12 14:45:51.637	BCDIOF-Unit_Certificate-146119[Evergreen_Forest_Pty_Ltd_ATF_Evergreen_Super_Fund]20240814.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2024-07-01	\N	2024-07-10	\N	\N	\N
1246	31	119	2024-02-28	1900000.00	\N	\N	\N	2024-03-04 17:11:10.154	2024-08-22 12:45:43.521	BCDIOF-Unit_Certificate-(69-B)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20240822.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-02-28	1764534027022188544.pdf	2024-06-12	\N	\N	\N
1373	210	119	2024-06-14	300000.00	\N	\N	\N	2024-06-14 14:36:19.197	2024-08-22 14:47:40.748	BCDIOF-Unit_Certificate-(69-B)-146241[Kaer_Guan]20240822.pdf	\N	9 Derwent Avenue	North Wahroonga	NSW	2076	\N	\N	297	f	2024-06-14	1801473719709650944.pdf	\N	\N	\N	\N
1632	118	156	2024-10-22	200000.00	\N	\N	\N	2024-10-22 17:27:54.172	2024-10-22 17:27:54.172	BCDIOF-Unit_Certificate-(A)-146087[Shengling_HU]20241022.pdf	\N	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2024-10-22	\N	2025-10-31	\N	\N	\N
1662	322	151	2024-10-04	237500.00	\N	\N	\N	2024-10-25 14:21:44.903	2024-10-25 14:21:44.903	BCDIOF-Unit_Certificate-(93-B)-146261[Ruizhen_WANG]20241025.pdf	\N	Building 15, Room 503	Xuchang City	Henan Province, China	450000	\N	\N	346	f	2024-10-04	\N	\N	\N	\N	\N
1559	304	107	2024-10-09	777777.00	\N	\N	\N	2024-10-09 16:35:40.39	2024-11-05 10:37:00.544	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-17	\N	\N	\N
1631	304	156	2024-10-22	200000.00	\N	\N	\N	2024-10-22 17:24:21.77	2024-11-05 10:37:25.563	BCDIOF-Unit_Certificate-(A)-000001[TEST_ENTITY]20241022.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-10-22	\N	2025-10-22	\N	\N	\N
1555	304	107	2024-10-09	999999.00	\N	\N	\N	2024-10-09 16:29:13.251	2024-11-05 10:38:13.125	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-31	\N	\N	\N
1589	304	93	2024-02-01	25000.00	\N	\N	\N	2024-10-15 09:54:33.94	2024-11-05 10:38:22.72	BCDIOF-Unit_Certificate-(52)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-02-01	\N	\N	\N	\N	\N
1588	304	93	2024-01-02	50000.00	\N	\N	\N	2024-10-15 09:53:58.708	2024-11-05 10:38:24.486	BCDIOF-Unit_Certificate-(52)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-01-02	\N	2024-01-31	\N	\N	\N
1690	125	137	2024-08-12	200000.00	\N	\N	\N	2024-11-26 18:18:20.862	2024-11-26 18:18:20.862	BCDIOF-Unit_Certificate-(86)-146264[Moncello_Investments_Group_Pty_Ltd_ATF_Pedra_Trust]20241126.pdf	\N	88 John Road	Cherrybrook	NSW	2126	\N	\N	355	f	2024-08-12	\N	\N	\N	\N	\N
1220	60	37	2024-01-01	560000.00	\N	\N	\N	2024-02-02 09:51:46.218	2024-02-02 09:51:46.218	7f788b91-3103-4dde-8143-0dd8a9c6bcf2.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2024-01-01	\N	2024-12-31	\N	\N	\N
1247	231	38	2023-10-06	250000.00	\N	\N	\N	2024-03-05 11:56:19.175	2024-03-05 11:56:19.175	70c47a32-b5c9-4b8a-a8d4-3a7e4eea86e8.pdf	\N	fake1	fake1	fake1	fake1	\N	\N	241	f	2023-10-06	\N	2024-07-31	\N	\N	\N
1272	226	121	2024-03-18	150000.00	\N	\N	\N	2024-03-18 16:34:05.942	2024-03-19 10:00:10.126	4629e9c2-3d45-49a4-8fee-d09eecf93926.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2024-03-18	1769861380183040000.pdf	\N	\N	\N	\N
1297	130	121	2024-04-05	100000.00	\N	\N	\N	2024-04-08 13:56:42.872	2024-04-08 13:56:42.872	46e79837-da8c-4205-8a9e-49caf51b7c3b.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	f	2024-04-05	1777183765685018624.pdf	\N	\N	\N	\N
1298	32	121	2024-04-06	100000.00	\N	\N	\N	2024-04-08 13:59:50.834	2024-04-08 13:59:50.834	bc8c7a99-a92a-4aaa-8d02-742b7bd20a71.pdf	\N	6 Woodlands Ave 	Camberwell	VIC	3124	\N	\N	298	f	2024-04-06	1777184554067369984.pdf	\N	\N	\N	\N
1112	15	108	2023-10-06	80000.00	\N	\N	\N	2023-12-01 14:52:44.667	2023-12-01 14:54:37.593	7a2082b0-b7d5-48a0-97dd-3a6ea3634f13.pdf	\N	608/4 Kiln Road	Kirrawee	NSW	2232	\N	\N	88	f	2023-10-20	\N	2023-11-24	\N	\N	\N
1323	169	2	2024-04-12	100000.00	\N	\N	\N	2024-05-01 16:56:22.502	2024-05-01 16:56:22.502	36fc567a-5ddc-477a-9441-4cbf92c83e94.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2024-04-12	\N	2024-04-30	\N	\N	\N
1192	129	110	2024-01-06	100000.00	\N	\N	\N	2024-01-08 14:36:11.166	2024-05-20 09:16:38.108	f924af3e-c800-4ca1-b131-f59cb6711e30.pdf	\N	48 Balladonia Rd 	Rowville 	VIC 	3178	\N	\N	217	f	2024-01-06	1744201303770251264.pdf	2024-05-06	\N	\N	\N
1528	318	38	2024-09-26	260000.00	\N	\N	\N	2024-09-26 14:30:34.126	2024-09-26 14:30:58.368	BCDIOF-Unit_Certificate-146262[William_Tomlinson_and_Gina_Tomlinson_ATF_Tomlinson_Superannuation_Fund]20240926.pdf	\N	50 Johnson Rd	One Tree Hill	SA	5114	\N	\N	338	f	2024-09-26	1839160712070930432.pdf	2025-06-30	\N	\N	\N
1374	304	11	2022-09-01	100000.00	\N	\N	\N	2024-06-14 15:02:39.1	2024-10-09 14:57:17.553	34af9483-9635-4d9a-b42e-9984f8a44a71.pdf	\N	TEST	TEST	TEST	0000	\N	\N	311	t	2022-09-01	\N	\N	\N	\N	\N
765	119	79	2023-05-11	150000.00	\N	\N	\N	2023-05-12 16:26:24.811	2023-06-01 16:51:13.227	2fd1b5c7-70af-4c00-985c-5494f821a208.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	 12 Smythe Avenue	Mont Albert	VIC\t	3127	\N	\N	\N	f	2023-05-11	\N	2023-06-10	\N	\N	\N
467	119	2	2022-10-01	250000.00	\N	\N	\N	2023-03-03 17:52:29.789	2023-03-14 11:48:20.47	71d2106e-94b0-4d33-9b56-6dd9ce013a51.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-10-01	\N	2022-10-19	\N	\N	\N
466	119	2	2022-10-19	250000.00	\N	\N	\N	2023-03-03 17:52:00.869	2023-03-14 11:48:45.994	6add76f0-4a21-4c52-b412-3ababcc23862.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-10-19	\N	2022-10-19	\N	\N	\N
465	119	2	2022-08-11	150000.00	\N	\N	\N	2023-03-03 17:51:33.94	2023-03-14 11:48:59.194	b4ceac6d-8916-4c49-a633-cc7519d8d391.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-08-11	\N	2022-10-19	\N	\N	\N
464	119	2	2022-07-19	100000.00	\N	\N	\N	2023-03-03 17:50:47.083	2023-03-14 11:49:14.652	f8056b65-a665-4433-b7bd-a3855dbf3d34.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-07-19	\N	2022-10-19	\N	\N	\N
463	119	37	2023-05-17	700000.00	\N	\N	\N	2023-03-03 17:49:48.314	2023-08-03 17:03:24.797	e8b85431-0578-4997-add7-ab5b1067697f.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2023-05-17	1637596753840435200.pdf	2024-05-31	\N	\N	\N
462	119	2	2022-08-11	150000.00	\N	\N	\N	2023-03-03 17:48:26.766	2023-03-14 11:52:47.62	46782a20-d9b7-4be7-994a-7837a3815729.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	\N	f	2022-08-11	\N	2023-02-02	\N	\N	\N
1128	211	38	2023-12-05	250000.00	\N	\N	\N	2023-12-11 10:04:52.913	2023-12-11 10:04:52.913	a9ee9648-dbb8-41fd-9dd3-514cb446fc30.pdf	\N	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2023-12-05	\N	2024-09-30	\N	\N	\N
1423	112	102	2024-06-27	3390000.00	\N	\N	\N	2024-07-30 12:29:54.528	2024-07-30 12:29:54.528	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240814.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-06-27	\N	2024-07-04	\N	\N	\N
1350	180	37	2024-03-25	601533.00	\N	\N	\N	2024-05-22 10:34:01.299	2024-06-27 12:20:21.233	e48903d2-456c-4b75-a5d9-3e1010f51246.pdf	\N	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2024-03-25	1793431077025439744.pdf	2024-06-24	\N	\N	\N
1161	73	43	2023-12-07	187200.00	\N	\N	\N	2023-12-19 10:57:04.535	2024-07-02 15:18:13.812	52b5cd67-72c8-43a6-a014-c4de901aa621.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1399	251	102	2024-07-01	2500000.00	\N	\N	\N	2024-07-09 15:51:02.363	2024-07-12 11:20:27.15	BCDIOF-Unit_Certificate-146193[Ziping_SI]20240814.pdf	\N	Unit 2, Level Building 4, 38 South Taoyuan Road	Lianhu \t	Xi'an	710000	\N	\N	250	f	2024-07-01	1810552220177829888.pdf	2024-07-09	\N	\N	\N
1558	304	107	2024-10-09	777777.00	\N	\N	\N	2024-10-09 16:33:42.727	2024-10-09 16:35:24.779	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	2024-10-17	\N	\N	\N
1464	112	102	2024-08-13	1990000.00	\N	\N	\N	2024-08-19 12:43:00.955	2024-08-29 11:51:56.732	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240829.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-13	\N	2024-08-13	\N	\N	\N
1487	112	102	2024-08-19	430000.00	\N	\N	\N	2024-08-29 11:53:26.533	2024-08-29 11:53:26.533	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240829.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-19	\N	2024-08-19	\N	\N	\N
1633	73	156	2024-07-22	750000.00	\N	\N	\N	2024-10-22 18:12:04.541	2024-10-22 18:12:04.541	BCDIOF-Unit_Certificate-(A)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20241022.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2024-07-22	\N	2026-07-31	\N	\N	\N
1663	226	156	2024-10-18	300000.00	\N	\N	\N	2024-10-25 14:43:42.015	2024-10-25 14:43:42.015	BCDIOF-Unit_Certificate-(A)-146178[WANG_LUI]20241025.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2024-10-18	\N	2025-10-31	\N	\N	\N
1557	304	107	2024-10-09	888888.00	\N	\N	\N	2024-10-09 16:31:30.106	2024-11-05 10:37:02.234	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	\N	\N	\N	\N
1586	304	93	2023-10-02	150000.00	\N	\N	\N	2024-10-15 09:50:50.784	2024-11-05 10:38:28.333	BCDIOF-Unit_Certificate-(52)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-10-02	\N	2023-10-31	\N	\N	\N
1609	304	2	2024-10-21	12345.00	\N	\N	\N	2024-10-21 16:39:00.325	2024-11-05 10:39:52.973	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1118	119	74	2023-05-09	150000.00	\N	\N	\N	2023-12-04 16:58:42.599	2024-11-29 16:43:28.991	BCDIOF-Unit_Certificate-(35-A)-146099[Orient_soar_Pty_Ltd_ATF_the_Zeng_Family_Trust]20241129.pdf	\N	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	278	f	2023-05-09	1731553969718579200.pdf	2024-11-27	\N	\N	\N
1113	28	108	2023-10-06	80000.00	\N	\N	\N	2023-12-01 15:03:03.202	2023-12-01 15:03:03.202	41a67672-8210-4b1f-833b-160f1c428613.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-10-21	\N	2023-11-24	\N	\N	\N
1635	66	156	2024-07-27	1000000.00	\N	\N	\N	2024-10-22 18:14:17.691	2024-10-22 18:14:17.691	BCDIOF-Unit_Certificate-(A)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20241022.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-07-27	\N	2026-07-31	\N	\N	\N
1129	209	37	2023-12-08	500000.00	\N	\N	\N	2023-12-11 10:41:25.999	2023-12-18 10:54:46.1	e1c8cbc7-2cec-46c9-bc35-8800c1b7caed.pdf	\N	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2023-12-08	1736535436978782208.pdf	2024-12-31	\N	\N	\N
664	199	69	2023-03-13	100000.00	\N	\N	\N	2023-03-14 17:04:47.063	2023-03-14 17:16:51.521	8e6167fb-feed-4915-8d95-a7740572c860.pdf	test_account_Frank	9999 Haymarket st	Haymarket	NSW	2000	\N	1469999	\N	t	2023-03-13	\N	2023-03-13	\N	\N	\N
168	125	14	2022-08-17	300000.00	\N	\N	\N	2022-08-26 09:07:16.4289	2023-03-14 18:08:13.317	4a3caa53-9f7a-40b1-91f6-3a75fd2622b4.pdf	Parque Edition P/L ATF Parque Edition Investment Trust 	88 John Road	Cherrybrook	NSW	2126	\N	BCFCT3-2-146029	\N	f	2022-08-17	\N	2023-02-18	\N	\N	\N
1221	174	37	2024-01-01	880000.00	\N	\N	\N	2024-02-02 10:11:51.542	2024-02-22 13:43:36.068	386135b0-b856-4dcf-ac76-cff620c9e126.pdf	\N	198 Pennant Hills Road	Oatlands	NSW	2117	\N	\N	229	f	2024-01-01	\N	2024-02-07	\N	\N	\N
1248	167	37	2024-03-01	500000.00	\N	\N	\N	2024-03-05 15:03:16.841	2024-03-05 15:03:16.841	0b184359-bea3-482d-b72e-d25cd5a80de1.pdf	\N	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2024-03-01	1764864230680379392.jpg	2025-02-28	\N	\N	\N
1273	69	122	2024-03-20	100000.00	\N	\N	\N	2024-03-20 13:33:24.931	2024-03-20 13:33:24.931	b136cb15-3992-430a-b4b5-99ced7f47ab6.pdf	\N	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2024-03-20	1770277433354625024.pdf	\N	\N	\N	\N
1299	295	121	2024-04-08	200000.00	\N	\N	\N	2024-04-08 14:36:29.813	2024-04-08 14:36:29.813	685a3d09-2594-41cd-b71a-33686aeda6ab.pdf	\N	6 Dight Avenue	Balwyn North	VIC	3104	\N	\N	299	f	2024-04-08	1777193777241202688.pdf	\N	\N	\N	\N
1324	66	118	2024-02-02	300000.00	\N	\N	\N	2024-05-02 11:46:43.168	2024-05-02 11:48:19.008	6d98ed7a-42d4-45cf-af53-84ba7d2d7a4f.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-02-02	\N	2024-02-29	\N	\N	\N
1193	240	110	2024-01-09	300000.00	\N	\N	\N	2024-01-09 17:04:19.876	2024-05-15 15:36:09.452	f1adea60-18d9-41f9-ada5-1f85b8bc2c5e.pdf	\N	17 Mulvihill Cres 	Denham Court 	NSW 	2565	\N	\N	121	f	2024-01-09	1744600973583564800.pdf	2024-05-06	\N	\N	\N
1351	210	123	2024-05-22	150000.00	\N	\N	\N	2024-05-23 10:11:45.851	2024-05-23 10:11:45.851	c44adff3-0990-4319-b7a0-5c5173286975.pdf	\N	9 Derwent Avenue	North Wahroonga	NSW	2076	\N	\N	297	f	2024-05-22	1793434609023672320.pdf	\N	\N	\N	\N
1162	190	43	2023-12-07	58500.00	\N	\N	\N	2023-12-19 10:59:17.329	2024-07-02 15:15:49.213	fd5b13b8-cd15-4cc9-b4f5-dba3b0dd3948.pdf	\N	Suite 302, 53 Walker St	North Sydney 	NSW 	2060	\N	\N	84	f	2023-12-07	\N	2024-06-27	\N	\N	\N
707	199	69	2023-03-15	100000.00	\N	\N	\N	2023-03-20 16:10:49.331	2023-03-20 17:08:42.46	4d807794-b7c6-43f7-869a-fd9401e0f252.pdf	Franktetst	12345	54231	123	2000	\N	12345	\N	t	2023-03-15	\N	2023-03-15	\N	\N	\N
1664	325	38	2024-10-28	250000.00	\N	\N	\N	2024-10-28 14:24:48.262	2024-10-28 14:24:48.262	BCDIOF-Unit_Certificate-146265[Genmei_HUANG]20241028.pdf	\N	18/1 Kensington St	Kogarah	NSW	2210	\N	\N	349	f	2024-10-28	\N	2025-07-31	\N	\N	\N
1376	158	39	2024-06-14	150000.00	\N	\N	\N	2024-06-17 11:57:51.749	2024-06-17 11:57:51.749	BCDIOF-Unit_Certificate-146130[Shunhua_ZHENG]20240814.pdf	\N	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2024-06-14	1802521006259040256.pdf	2025-03-31	\N	\N	\N
1375	118	37	2024-06-13	500000.00	\N	\N	\N	2024-06-17 11:41:33.737	2024-06-20 15:02:22.732	BCDIOF-Unit_Certificate-146087[Shengling_HU]20240814.pdf	\N	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2024-06-13	1803654604840218624.pdf	2025-06-30	\N	\N	\N
1424	112	102	2024-07-05	2390000.00	\N	\N	\N	2024-07-30 12:32:53.258	2024-08-19 12:40:30.867	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240819.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-07-05	\N	2024-08-12	\N	\N	\N
1465	118	135	2024-08-17	220000.00	\N	\N	\N	2024-08-19 16:43:12.975	2024-08-19 16:43:56.482	BCDIOF-Unit_Certificate-(85)-146087[Shengling_HU]20240819.pdf	\N	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2024-08-17	\N	\N	\N	\N	\N
1560	304	107	2024-10-09	6666666.00	\N	\N	\N	2024-10-09 23:33:32.442	2024-11-05 10:36:59.076	BCDIOF-Unit_Certificate-(67)-145000[Entity_for_Test]20241009.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-09	\N	\N	\N	\N	\N
1587	304	93	2023-11-01	100000.00	\N	\N	\N	2024-10-15 09:52:57.714	2024-11-05 10:38:26.105	BCDIOF-Unit_Certificate-(52)-000001[TEST_ENTITY]20241015.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2023-11-01	\N	2024-01-01	\N	\N	\N
1610	304	40	2024-10-21	54321.00	\N	\N	\N	2024-10-21 16:45:17.2	2024-11-05 10:39:59.741	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1488	112	102	2024-08-20	230000.00	\N	\N	\N	2024-08-29 11:53:43.52	2024-08-29 11:53:43.52	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240829.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-20	\N	2024-08-21	\N	\N	\N
1439	268	38	2024-08-01	500000.00	\N	\N	\N	2024-08-02 17:10:58.655	2024-09-30 14:11:30.017	BCDIOF-Unit_Certificate-146208[Huanghui_JIANG]20240930.pdf	\N	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	\N	264	f	2024-08-01	\N	2024-08-31	\N	\N	\N
1529	268	37	2024-09-01	500000.00	\N	\N	\N	2024-09-30 14:11:52.221	2024-09-30 14:11:52.221	BCDIOF-Unit_Certificate-146208[Huanghui_JIANG]20240930.pdf	\N	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	\N	264	f	2024-09-01	\N	2025-08-31	\N	\N	\N
576	152	44	2023-02-19	100000.00	\N	\N	\N	2023-03-06 17:24:36.054	2023-03-06 17:24:41.43	b640563b-434e-4e5d-b9ff-2d445b6f87fc.pdf	test	\N	\N	\N	\N	\N	\N	\N	t	2023-02-19	\N	\N	\N	\N	\N
1400	304	104	2023-11-04	500000.00	\N	\N	\N	2024-07-10 10:57:37.496	2024-10-09 14:57:14.963	57530834-0b26-4f85-a704-bd506809fdff.pdf	\N	TEST	TEST	TEST	0000	\N	\N	311	t	2023-11-04	\N	2024-07-14	\N	\N	\N
1634	66	156	2024-07-22	3300000.00	\N	\N	\N	2024-10-22 18:13:29.259	2024-10-22 18:13:29.259	BCDIOF-Unit_Certificate-(A)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20241022.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-07-22	\N	2024-07-26	\N	\N	\N
1691	304	155	2024-11-04	123243.00	\N	\N	\N	2024-11-29 16:47:59.671	2024-11-29 16:47:59.671	BCDIOF-Unit_Certificate-(A)-145000[Entity_for_Test]20241129.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	f	2024-11-07	\N	\N	\N	\N	\N
1636	112	156	2024-07-22	1500000.00	\N	\N	\N	2024-10-22 18:15:29.81	2024-12-02 10:29:46.824	BCDIOF-Unit_Certificate-(A)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20241202.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-07-22	\N	2024-11-11	\N	\N	\N
1114	64	108	2023-10-06	80000.00	\N	\N	\N	2023-12-01 15:03:50.073	2023-12-01 15:03:50.073	214aa82a-7cac-4d97-ad0a-740d2dc617b3.pdf	\N	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-10-21	\N	2023-11-24	\N	\N	\N
607	125	44	2023-02-19	300000.00	\N	\N	\N	2023-03-07 15:29:34.606	2023-10-12 11:20:53.902	12d17764-c5bf-42a7-b343-5f4d921ae072.pdf	Parque Edition P/L ATF Parque Edition Investment Trust 	85 Nurlendi Rd	Vermont	VIC 	3133	\N	\N	\N	f	2023-02-19	\N	2023-10-06	\N	\N	\N
592	131	43	2023-02-19	100000.00	\N	\N	\N	2023-03-07 14:14:00.553	2023-10-12 10:34:12.909	ff29bf73-afe7-4ab0-b0dd-924f4f72513f.pdf	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	21 Acheron Ave	Camberwell 	VIC	3124	\N	\N	\N	f	2023-02-19	\N	2023-10-06	\N	\N	\N
1195	33	37	2024-01-11	500000.00	\N	\N	\N	2024-01-11 14:35:17.129	2024-01-11 14:38:55.078	20162952-c74b-4907-9e49-27c8093d283b.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2024-01-11	1745289154855419904.pdf	2025-01-31	\N	\N	\N
520	179	2	2023-03-06	5000000.00	\N	\N	\N	2023-03-06 15:52:23.396	2023-03-06 17:42:51.991	ae596df8-bd80-4f64-901b-34a535212903.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	\N	\N	\N	\N	\N	\N
1466	112	102	2024-08-20	2090000.00	\N	\N	\N	2024-08-20 12:19:51.206	2024-08-29 11:52:22.397	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240821.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	t	2024-08-20	\N	2024-08-20	\N	\N	\N
1490	169	74	2024-05-01	400000.00	\N	\N	\N	2024-08-29 14:24:02.625	2024-08-29 14:24:02.625	BCDIOF-Unit_Certificate-(35-A)-146111[CASA_A_Pty_Ltd_ATF_CASA_1_Unit_Trust_]20240829.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2024-05-01	\N	2024-06-26	\N	\N	\N
1222	169	74	2024-01-29	500000.00	\N	\N	\N	2024-02-02 11:17:50.091	2024-08-29 14:24:43.387	BCDIOF-Unit_Certificate-(35-A)-146111[CASA_A_Pty_Ltd_ATF_CASA_1_Unit_Trust_]20240829.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2024-01-29	\N	2024-04-30	\N	\N	\N
1530	112	138	2024-09-20	1000000.00	\N	\N	\N	2024-09-30 14:51:16.449	2024-09-30 14:51:16.449	BCDIOF-Unit_Certificate-(87)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240930.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-09-20	\N	\N	\N	\N	\N
1194	33	38	2024-01-01	450000.00	\N	\N	\N	2024-01-11 14:31:00.083	2024-02-01 16:53:15.632	e53caaba-ff5b-49f5-9df9-db302910e558.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2024-01-01	\N	2024-01-10	\N	\N	\N
1249	286	119	2024-03-06	50000.00	\N	\N	\N	2024-03-06 11:06:48.319	2024-03-06 15:47:33.947	0111636d-ec22-4c9d-b78a-6bbb4c10b313.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2024-03-02	\N	\N	\N	\N	\N
1274	158	2	2024-03-21	60000.00	\N	\N	\N	2024-03-21 14:56:17.483	2024-03-21 14:56:17.483	e02c47a7-eb76-4e84-98de-f0a9376c6b45.pdf	\N	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2024-03-21	1770660677614968832.pdf	2024-12-31	\N	\N	\N
600	131	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:15:21.427	2023-03-07 15:21:27.625	3c81b992-5fcb-45fd-874c-ee05877ed8d4.pdf	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	21 Acheron Ave	Camberwell 	VIC 	3124	\N	\N	\N	t	2023-02-19	\N	\N	\N	\N	\N
1561	112	102	2024-05-07	5500000.00	\N	\N	\N	2024-10-10 09:46:52.217	2024-10-10 09:46:52.217	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20241010.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-05-07	\N	2024-06-18	\N	\N	\N
1300	296	39	2024-04-05	150000.00	\N	\N	\N	2024-04-08 14:46:55.89	2024-04-08 14:53:34.439	969ff88f-0969-49df-b130-20cf6bdf0460.pdf	\N	Unit 25 7 Liberman Close	Adelaide	SA	5000	\N	\N	300	f	2024-04-05	1777196403198468096.pdf	2025-01-31	\N	\N	\N
1130	132	110	2023-12-05	230000.00	\N	\N	\N	2023-12-11 12:22:07.093	2024-05-20 09:22:02.688	fb53f7d4-5b5d-40b6-b8c3-9cff2779b275.pdf	\N	13 West Terrace\t	Kensington Gardens\t	SA \t	5068	\N	\N	281	f	2023-12-05	1734020704241635328.pdf	2024-05-06	\N	\N	\N
1352	275	129	2024-05-24	5226318.84	\N	\N	\N	2024-05-24 13:41:17.849	2024-05-24 13:41:17.849	270c49db-375c-4efa-b5e5-c6abe6dba37c.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2024-05-24	1793849727674966016.pdf	\N	\N	\N	\N
1163	52	44	2023-12-07	58500.00	\N	\N	\N	2023-12-19 11:26:56.061	2024-07-02 15:29:05.092	5a6110a0-b07e-4653-9f77-7b045cc6bb31.pdf	\N	55 Salisbury Rd.	Ashwood	VIC	3147	\N	\N	148	f	2023-12-07	\N	2024-06-27	\N	\N	\N
619	197	5	2023-03-09	500000.00	\N	\N	\N	2023-03-09 19:40:32.978	2023-03-09 19:41:07.128	9e818110-23af-48db-8335-5c614e1cf0ab.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	\N	\N	2023-03-09	\N	\N	\N
1325	66	119	2024-03-01	300000.00	\N	\N	\N	2024-05-02 11:51:35.764	2024-08-02 11:14:26.299	0b71309e-0aea-4244-9299-15bc619b8d7a.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-03-01	\N	2024-07-21	\N	\N	\N
628	197	57	2023-03-09	6000000.00	\N	\N	\N	2023-03-09 19:43:04.421	2023-03-10 09:36:33.863	a89fd5df-95a7-4dc0-9e2d-f44ea0dbb2b1.pdf	\N	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-09	\N	2023-03-09	\N	\N	\N
1562	112	102	2024-06-19	5390000.00	\N	\N	\N	2024-10-10 09:55:42.059	2024-10-10 09:57:31.73	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20241010.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-06-19	\N	2024-06-26	\N	\N	\N
1563	112	102	2024-06-27	3390000.00	\N	\N	\N	2024-10-10 09:56:40.201	2024-10-10 09:58:45.621	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20241010.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	t	2024-06-27	\N	2024-07-04	\N	\N	\N
1590	266	37	2024-10-16	200000.00	\N	\N	\N	2024-10-16 09:35:40.053	2024-10-16 09:35:40.053	BCDIOF-Unit_Certificate-146207[Wan_NG]20241016.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	999077	\N	\N	265	f	2024-10-16	\N	2024-10-31	\N	\N	\N
1401	236	38	2024-07-08	325000.00	\N	\N	\N	2024-07-10 14:45:26.382	2024-07-11 11:15:13.233	BCDIOF-Unit_Certificate-146187[XIANG_LIANG]20240814.pdf	\N	3 GILMORE RD	DONCASTER	VIC\t	3108	\N	\N	117	f	2024-07-08	\N	2025-04-30	\N	\N	\N
1425	28	37	2024-07-31	500000.00	\N	\N	\N	2024-07-31 12:16:24.541	2024-07-31 12:16:24.541	BCDIOF-Unit_Certificate-146034[Han_Family_Investment_Pty_Ltd_ATF_Han_Trust]20240814.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2024-07-31	\N	2025-07-31	\N	\N	\N
1377	203	119	2024-06-14	100000.00	\N	\N	\N	2024-06-17 12:03:56.26	2024-06-17 12:03:56.26	BCDIOF-Unit_Certificate-(69-B)-146176[Worldlink_Group_pty_Ltd]20240814.pdf	\N	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	\N	107	f	2024-06-14	1802522535053488128.pdf	\N	\N	\N	\N
1611	304	2	2024-10-21	12345.00	\N	\N	\N	2024-10-21 16:56:53.991	2024-10-21 17:08:49.146	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1638	255	156	2024-07-22	750000.00	\N	\N	\N	2024-10-22 18:36:47.273	2024-10-31 14:50:27.7	BCDIOF-Unit_Certificate-(A)-146219[WINS_COLLEGE_PTY_LTD]20241031.pdf	\N	Ground Floor, 187 Thomas Street	HAYMARKET	NSW	2000	\N	\N	289	f	2024-07-22	\N	2025-07-31	\N	\N	\N
1591	304	2	2024-09-26	50000.00	\N	\N	\N	2024-10-16 09:44:16.132	2024-11-05 10:36:54.025	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241016.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-09-26	\N	\N	\N	\N	\N
1668	304	86	2024-01-12	100000.00	\N	\N	\N	2024-10-30 18:11:49.208	2024-11-05 10:37:55.536	BCDIOF-Unit_Certificate-(40)-145000[Entity_for_Test]20241030.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-01-12	\N	2024-04-24	\N	\N	\N
1665	304	86	2023-07-04	400000.00	\N	\N	\N	2024-10-30 18:09:14.748	2024-11-05 10:38:00.461	BCDIOF-Unit_Certificate-(40)-145000[Entity_for_Test]20241030.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-07-04	\N	2023-10-10	\N	\N	\N
1637	257	156	2024-07-22	1000000.00	\N	\N	\N	2024-10-22 18:35:51.019	2024-11-21 17:08:08.528	BCDIOF-Unit_Certificate-(A)-146201[Lijun_LIU]20241121.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-07-22	\N	2025-07-31	\N	\N	\N
1692	275	145	2024-09-25	2487500.00	\N	\N	\N	2024-11-29 16:56:27.568	2024-11-29 16:56:27.568	BCDIOF-Unit_Certificate-(93-A)-146177[Yinghong_XING]20241129.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2024-09-25	\N	\N	\N	\N	\N
1131	100	107	2023-12-12	100000.00	\N	\N	\N	2023-12-12 17:25:07.748	2023-12-12 17:25:07.748	321fdd65-8797-444c-928c-1f8ca2bb1cd4.pdf	\N	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	192	f	2023-12-12	1734459347427098624.pdf	\N	\N	\N	\N
1467	289	37	2024-08-21	1715000.00	\N	\N	\N	2024-08-21 12:40:14.295	2024-08-21 12:40:14.295	BCDIOF-Unit_Certificate-146251[Hou_Family_Wealth_Pty_Ltd_ATF_Hou_Family_Wealth_Superannuation_Fund]20240821.pdf	\N	6 Glenroy Ave \t	Beaumont  	SA	5066	\N	\N	309	f	2024-08-21	\N	2025-08-31	\N	\N	\N
759	119	74	2023-05-09	150000.00	\N	\N	\N	2023-05-09 16:36:29.359	2023-05-09 16:36:29.359	83d6e960-10f9-4d19-b3ee-965f04cb965d.pdf	Orient soar Pty Ltd ATF the Zeng Family Trust	 12 Smythe Avenue	Mont Albert	VIC\t	3127	\N	\N	\N	f	2023-05-09	1655824039349063680.pdf	\N	\N	\N	\N
1326	66	119	2024-02-02	2000000.00	\N	\N	\N	2024-05-02 11:52:00.393	2024-08-22 12:39:26.598	BCDIOF-Unit_Certificate-(69-B)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240822.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-02-02	\N	2024-07-21	\N	\N	\N
1252	286	118	2024-03-06	10000.00	\N	\N	\N	2024-03-06 11:09:07.163	2024-03-06 11:09:07.163	d7b740e9-53c4-4b56-91d6-7098305a847a.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2024-03-06	\N	\N	\N	\N	\N
1531	257	135	2024-09-20	1170000.00	\N	\N	\N	2024-09-30 15:05:43.179	2024-09-30 15:05:43.179	BCDIOF-Unit_Certificate-(85)-146201[Lijun_LIU]20240930.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-09-20	\N	\N	\N	\N	\N
1250	286	117	2024-03-02	50000.00	\N	\N	\N	2024-03-06 11:07:26.965	2024-03-07 11:52:18.67	340848e0-df98-4016-b0a6-29d14d1bad2e.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2024-03-02	\N	\N	\N	\N	\N
1275	35	39	2024-03-22	150000.00	\N	\N	\N	2024-03-25 14:54:24.535	2024-03-27 17:06:56.031	d7de854a-da03-4123-b7ba-c61a4396fc51.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	t	2024-03-22	1772109755427196928.pdf	2024-12-31	\N	\N	\N
1196	169	38	2024-01-18	400000.00	\N	\N	\N	2024-01-18 11:10:58.156	2024-04-02 15:08:51.43	7eb9e1af-f196-4445-abf2-02275eb60bfc.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2024-01-18	\N	2024-02-29	\N	\N	\N
1301	133	121	2024-04-08	100000.00	\N	\N	\N	2024-04-10 11:09:37.966	2024-04-10 11:10:44.929	80c15b1a-65d9-408b-9997-0c7ed517be66.pdf	\N	6 Casuarina Court 	Capalaba 	QLD 	4157	\N	\N	78	f	2024-04-08	1777866774771867648.pdf	\N	\N	\N	\N
1223	66	110	2023-11-02	4000000.00	\N	\N	\N	2024-02-02 12:29:10.177	2024-05-15 15:26:21.166	6084cb83-92e0-4e88-bf51-67598b2fd20d.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-11-02	1753229035661385728.pdf	2024-05-06	\N	\N	\N
1353	168	37	2024-01-01	700000.00	\N	\N	\N	2024-05-29 14:14:30.819	2024-05-29 14:14:30.819	3126ae10-70fd-4e02-b76f-394d6cf2852f.pdf	\N	21 Acheron Avenue	Camberwell	VIC	3124	\N	\N	230	f	2024-01-01	\N	2024-12-31	\N	\N	\N
1402	304	38	2024-04-02	100000.00	\N	\N	\N	2024-07-11 09:32:02.282	2024-10-09 14:56:59.058	f7e95da0-a370-4930-8837-d32d13e3269e.pdf	\N	TEST	TEST	TEST	0000	\N	\N	311	t	2024-04-02	\N	\N	\N	\N	\N
1164	69	44	2023-12-07	117000.00	\N	\N	\N	2023-12-19 11:28:41.961	2024-07-02 15:28:24.591	30322196-1831-4d89-ac9e-4140e37de78e.pdf	\N	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1564	275	74	2023-05-15	3300000.00	\N	\N	\N	2024-10-10 15:43:38.47	2024-10-10 15:43:38.47	BCDIOF-Unit_Certificate-(35-A)-146177[Yinghong_XING]20241010.pdf	\N	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng Distinct 	Hangzhou	310006	\N	\N	274	f	2023-05-15	\N	\N	\N	\N	\N
1592	324	155	2024-10-16	100000.00	\N	\N	\N	2024-10-16 10:05:44.793	2024-10-16 10:05:44.793	BCDIOF-Unit_Certificate-(A)-145001[test_IT]20241016.pdf	\N	sfw	wdf	feg	0000	\N	\N	347	f	2024-10-16	\N	\N	\N	\N	\N
1639	323	2	2024-09-26	50000.00	\N	\N	\N	2024-10-23 10:15:08.968	2024-10-23 10:16:34.724	BCDIOF-Unit_Certificate-146263[Zheng_LIU]20241023.pdf	\N	12 William St	Boxhill	VIC	3128	\N	\N	348	f	2024-09-26	\N	2025-06-30	\N	\N	\N
1491	169	74	2024-06-27	300000.00	\N	\N	\N	2024-08-29 14:24:31.171	2024-10-28 13:11:20.281	BCDIOF-Unit_Certificate-(35-A)-146111[CASA_A_Pty_Ltd_ATF_CASA_1_Unit_Trust_]20241028.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2024-06-27	\N	2024-09-09	\N	\N	\N
698	179	43	2023-03-15	500000.00	\N	\N	\N	2023-03-15 13:45:20.591	2023-03-15 13:47:00.221	58ed16a1-13bd-4f23-bd9c-6f92377ab960.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-13	\N	\N	\N	\N	\N
1378	257	131	2024-06-14	400000.00	\N	\N	\N	2024-06-17 16:35:45.054	2024-06-17 16:39:54.014	BCDIOF-Unit_Certificate-(83-B)-146201[Lijun_LIU]20240814.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-06-14	1802590939227598848.pdf	\N	\N	\N	\N
1426	14	38	2024-08-01	250000.00	\N	\N	\N	2024-08-01 09:55:30.772	2024-08-01 09:55:30.772	BCDIOF-Unit_Certificate-146022[Prosperity_2020_PL_ATF_Genesis_Family_Trust]20240814.pdf	\N	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1667	304	86	2023-10-26	200000.00	\N	\N	\N	2024-10-30 18:11:12.695	2024-11-05 10:37:57.459	BCDIOF-Unit_Certificate-(40)-145000[Entity_for_Test]20241030.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-10-26	\N	2024-01-11	\N	\N	\N
1666	304	86	2023-10-11	300000.00	\N	\N	\N	2024-10-30 18:10:40.81	2024-11-05 10:37:58.977	BCDIOF-Unit_Certificate-(40)-145000[Entity_for_Test]20241030.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-10-11	\N	2023-10-25	\N	\N	\N
1612	304	2	2024-10-21	98765.00	\N	\N	\N	2024-10-21 17:06:30.123	2024-11-05 10:39:51.445	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1693	316	41	2022-12-21	7149729.00	\N	\N	\N	2024-11-29 17:10:22.768	2024-11-29 17:10:22.768	BCDIOF-Unit_Certificate-(22-A)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	f	2022-12-21	\N	\N	\N	\N	\N
704	179	11	2023-03-16	500000.00	\N	\N	\N	2023-03-16 15:54:55.707	2023-03-21 09:54:18.422	0040f012-6844-4562-ba06-fb0095820b28.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-16	\N	\N	\N	\N	\N
1136	232	107	2023-12-12	150000.00	\N	\N	\N	2023-12-12 17:37:00.351	2023-12-12 17:37:00.351	6ff6bb85-4bb2-4b4e-a4bf-1cadfef04047.pdf	\N	5 Palm Beach Dr 	Patterson Lakes	VIC	3197	\N	\N	132	f	2023-12-12	1734462336174882816.pdf	\N	\N	\N	\N
1253	286	118	2024-03-06	10000.00	\N	\N	\N	2024-03-06 11:09:31.521	2024-03-06 11:09:31.521	514f8b23-1d28-42cc-b2f5-a28bacfd3ce5.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2024-03-06	\N	\N	\N	\N	\N
1251	286	118	2024-03-06	50000.00	\N	\N	\N	2024-03-06 11:08:33.263	2024-03-06 11:28:27.01	9d1d453d-a7a7-4a87-93cf-a4068e89a752.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2024-03-01	\N	\N	\N	\N	\N
1276	166	122	2024-03-22	300000.00	\N	\N	\N	2024-03-26 11:52:48.862	2024-03-26 12:11:23.543	4bcf3054-70b2-45f3-aadf-a300b8ff9264.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	f	2024-03-22	1772431118746652672.jpg	\N	\N	\N	\N
1302	297	121	2024-04-10	100000.00	\N	\N	\N	2024-04-10 14:25:46.568	2024-04-10 14:25:46.568	8b916c9f-809c-44a8-88f6-e06edc3117eb.pdf	\N	32A Sutton Street	Balwyn North	VIC	3104	\N	\N	301	f	2024-04-10	1777915855007326208.pdf	\N	\N	\N	\N
1224	112	110	2023-11-02	5500000.00	\N	\N	\N	2024-02-02 12:32:59.035	2024-05-15 15:24:22.676	93c3e893-6ef9-4219-8e8e-ef650844758e.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2023-11-02	\N	2024-05-06	\N	\N	\N
1565	255	110	2023-11-02	2000000.00	\N	\N	\N	2024-10-10 16:31:58.475	2024-10-10 16:33:48.573	BCDIOF-Unit_Certificate-()-146200[Yufeng_MA]20241010.pdf	\N	 6 Greenwich Road\t	Greenwich 	NSW\t	2065	\N	\N	254	t	2023-11-02	\N	2023-11-30	\N	\N	\N
1166	73	44	2023-12-07	46800.00	\N	\N	\N	2023-12-19 11:55:00.399	2024-07-02 15:26:33.782	b8f53785-b158-4db9-8a2d-02605a04e9a7.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1165	193	44	2023-12-07	58500.00	\N	\N	\N	2023-12-19 11:54:01.513	2024-07-02 15:27:31.787	b916146b-f3cd-4b59-bad3-5e5cf44ca9f2.pdf	\N	16 Joly Parade	Hunters Hill	NSW	2110	\N	\N	87	f	2023-12-07	\N	2024-06-27	\N	\N	\N
1157	131	43	2022-08-17	100000.00	\N	\N	\N	2023-12-19 10:23:25.342	2024-10-17 16:07:39.585	BCDIOF-Unit_Certificate-(3-1E)-146122[Golden_Life_Super_Investments_Pty_Ltd_ATF_Golden_Life_Superannuation_Fund]20241017.pdf	\N	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	76	f	2022-08-12	\N	2023-10-05	\N	\N	\N
629	198	30	2023-03-10	500000.00	\N	\N	\N	2023-03-10 09:37:38.365	2023-03-10 09:38:15.393	b254c529-474e-4e66-92f6-10d865009803.pdf	11	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	2023-03-09	\N	2023-03-10	\N	\N	\N
1327	257	119	2024-03-01	700000.00	\N	\N	\N	2024-05-02 15:32:34.251	2024-08-02 11:40:41.515	8bce226a-89a7-4d06-a6af-c658d94dc430.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-03-01	\N	2024-07-21	\N	\N	\N
630	198	44	2023-03-10	50000000.00	\N	\N	\N	2023-03-10 09:38:39.429	2023-03-10 16:10:54.925	7a6ffaf7-f123-4a1f-b6aa-8350ceb5f604.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	\N	t	2023-03-10	\N	2023-03-10	\N	\N	\N
1328	112	119	2024-02-02	1500000.00	\N	\N	\N	2024-05-02 15:33:54.26	2024-08-02 11:51:20.609	bb628120-1340-40b7-af5f-6c6283a0a61f.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-02-02	\N	2024-07-21	\N	\N	\N
652	179	45	2023-03-13	500000.00	\N	\N	\N	2023-03-13 16:53:24.277	2023-03-13 16:53:37.709	87c32318-086e-45e9-9f6b-b0d936851197.pdf	asd	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-13	\N	\N	\N	\N	\N
653	179	58	2023-03-13	500000.00	\N	\N	\N	2023-03-13 16:54:12.2	2023-03-13 16:54:17.152	bcf84413-fff0-4f16-8ec7-9faa5d1e70d4.pdf	quinn	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	\N	t	2023-03-13	\N	\N	\N	\N	\N
1427	257	125	2024-07-22	1300000.00	\N	\N	\N	2024-08-02 11:41:42.56	2024-08-02 11:41:42.56	BCDIOF-Unit_Certificate-(77-B)-146201[Lijun_LIU]20240814.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-07-22	\N	\N	\N	\N	\N
1428	112	125	2024-07-22	1690000.00	\N	\N	\N	2024-08-02 11:52:04.567	2024-08-02 11:52:04.567	BCDIOF-Unit_Certificate-(77-B)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240814.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-07-22	\N	\N	\N	\N	\N
1468	233	141	2024-08-21	150000.00	\N	\N	\N	2024-08-21 12:52:42.128	2024-08-21 12:52:42.128	BCDIOF-Unit_Certificate-(90)-146183[Tina_Ywen_Pty_Ltd_ATF_Tinaewen_Superannuation_Fund]20240821.pdf	\N	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2024-08-21	\N	\N	\N	\N	\N
1492	261	130	2024-08-24	100000.00	\N	\N	\N	2024-08-29 14:32:17.209	2024-08-29 14:32:17.209	BCDIOF-Unit_Certificate-(82)-146203[Guanyu_CHEN]20240829.pdf	\N	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	\N	266	f	2024-08-24	\N	\N	\N	\N	\N
1137	233	107	2023-12-11	200000.00	\N	\N	\N	2023-12-12 17:42:11.163	2024-09-23 16:17:51.959	BCDIOF-Unit_Certificate-(67)-146183[Tina_Ywen_Pty_Ltd_ATF_Tinaewen_Superannuation_Fund]20240923.pdf	\N	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2023-12-11	1734463639814897664.pdf	2024-06-07	\N	\N	\N
1133	279	107	2023-12-11	290000.00	\N	\N	\N	2023-12-12 17:32:01.734	2024-09-23 16:36:06.845	BCDIOF-Unit_Certificate-(67)-146221[Tian_QIN]20240923.pdf	\N	2406/33 Mackenzie street	Melbourne 	VIC 	3000	\N	\N	282	f	2023-12-11	1734461083684405248.pdf	2024-06-07	\N	\N	\N
1132	242	107	2023-12-12	100000.00	\N	\N	\N	2023-12-12 17:27:51.921	2024-09-23 16:39:08.705	BCDIOF-Unit_Certificate-(67)-146192[Xiumei_WU]20240923.pdf	\N	108 Cityview Road	Balwyn North	VIC	3104	\N	\N	123	f	2023-12-12	1734460035905323008.pdf	2024-06-07	\N	\N	\N
1532	268	121	2024-09-26	300000.00	\N	\N	\N	2024-09-30 15:09:33.355	2024-09-30 15:12:07.233	BCDIOF-Unit_Certificate-(76-A)-146208[Huanghui_JIANG]20240930.pdf	\N	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	\N	264	f	2024-09-26	1840620618703675392.pdf	\N	\N	\N	\N
1403	304	126	2024-07-10	100000.00	\N	\N	\N	2024-07-11 09:32:56.912	2024-10-09 14:57:11.761	BCDIOF-Unit_Certificate-(78)-000001[TEST_ENTITY]20240814.pdf	\N	TEST	TEST	TEST	0000	\N	\N	311	t	2024-07-10	\N	\N	\N	\N	\N
1379	282	132	2024-06-21	100000.00	\N	\N	\N	2024-06-21 14:22:48.55	2024-06-21 14:22:48.55	BCDIOF-Unit_Certificate-(83-A)-146223[Sulan_Wu]20240814.pdf	\N	6 Woodlands Avenue	Camberwell	VIC 	3124	\N	\N	285	f	2024-06-21	1804007034668953600.pdf	\N	\N	\N	\N
1354	302	2	2024-06-02	50000.00	\N	\N	\N	2024-06-03 15:13:19.793	2024-10-09 14:57:50.798	65bcb99b-2265-40ea-acfe-81a080ea32d6.pdf	\N	Fake add	Fake sub	Fake State	99999	\N	\N	307	t	2024-06-02	\N	2025-03-31	\N	\N	\N
1669	31	157	2024-09-20	3050000.00	\N	\N	\N	2024-10-31 14:34:15.627	2024-10-31 14:34:15.627	BCDIOF-Unit_Certificate-(95)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20241031.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-09-20	\N	\N	\N	\N	\N
1613	304	2	2024-10-21	12345.00	\N	\N	\N	2024-10-21 17:09:07.245	2024-11-05 10:39:55.505	BCDIOF-Unit_Certificate-146999[test_company]20241021.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-21	\N	\N	\N	\N	\N
1694	316	41	2022-12-21	7149729.00	\N	\N	\N	2024-11-29 17:12:17.267	2024-11-29 17:12:17.267	BCDIOF-Unit_Certificate-(22-A)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	f	2022-12-21	\N	\N	\N	\N	\N
1134	136	107	2023-12-12	200000.00	\N	\N	\N	2023-12-12 17:33:43.956	2023-12-12 17:33:43.956	9aede57c-c60c-476b-998f-84ede2be539c.pdf	\N	2/21 Albury Road	Balwyn North	VIC	3104	\N	\N	79	f	2023-12-12	1734461512434548736.pdf	\N	\N	\N	\N
702	199	45	2023-03-01	\N	\N	\N	\N	2023-03-15 14:30:39.281	2023-03-15 17:05:30.565	336c5df4-d6a6-4692-b99b-addf3ab7da39.pdf	\N	\N	\N	\N	\N	\N	\N	\N	t	2023-03-01	\N	\N	\N	\N	\N
1167	220	109	2023-04-25	50000.00	\N	\N	\N	2023-12-19 12:32:22.425	2023-12-19 12:32:22.425	e24daeb4-a8f1-4a50-950a-54c367df8e32.pdf	\N	58 Shaftesbury Rd	Burwood	NSW	2134	\N	\N	130	f	2023-04-25	\N	\N	\N	\N	\N
1225	66	111	2023-12-15	270000.00	\N	\N	\N	2024-02-02 12:59:53.172	2024-02-02 12:59:53.172	1093ad6d-55ba-42e2-9af8-f3c1c9605fbe.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-12-15	\N	\N	\N	\N	\N
1254	286	118	2022-03-01	50000.00	\N	\N	\N	2024-03-06 11:22:26.098	2024-03-06 11:26:47.533	a187c628-4d44-4880-bc22-9bacf346ecc3.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2022-03-01	\N	2022-06-01	\N	\N	\N
1277	35	39	2024-03-27	250000.00	\N	\N	\N	2024-03-27 17:08:27.008	2024-03-27 17:08:45.702	178c947a-64a1-4971-ae82-820f44f9c366.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	t	2024-03-27	1772868263646990336.pdf	2024-12-31	\N	\N	\N
1303	298	121	2024-04-05	100000.00	\N	\N	\N	2024-04-10 15:57:33.646	2024-04-10 15:57:33.646	ba597936-7d7c-466b-9e6b-58042d3089d0.pdf	\N	10 Chilcote Court	Box Hill South	VIC	3128	\N	\N	302	f	2024-04-05	1777938953370804224.pdf	\N	\N	\N	\N
1355	119	37	2024-06-03	500000.00	\N	\N	\N	2024-06-03 17:24:55.787	2024-06-03 17:24:55.787	7c8815f9-c00c-4304-a6cd-3b7f214d2892.pdf	\N	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	278	f	2024-06-03	1797529885241991168.pdf	2025-06-30	\N	\N	\N
1404	31	102	2024-07-11	2000000.00	\N	\N	\N	2024-07-12 11:13:46.702	2024-10-02 12:12:59.497	BCDIOF-Unit_Certificate-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20241002.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-07-11	1811569608767799296.pdf	2024-09-19	\N	\N	\N
1329	73	119	2024-02-01	750000.00	\N	\N	\N	2024-05-02 15:34:46.887	2024-08-02 11:54:02.459	f7803b27-2512-4e77-9b61-049471adbaa1.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2024-02-01	\N	2024-07-21	\N	\N	\N
1566	255	110	2023-11-02	2000000.00	\N	\N	\N	2024-10-10 16:35:21.594	2024-10-10 16:51:59.088	BCDIOF-Unit_Certificate-()-146219[WINS_COLLEGE_PTY_LTD]20241010.pdf	\N	Ground Floor, 187 Thomas Street	HAYMARKET	NSW	2000	\N	\N	289	f	2023-11-02	\N	2023-11-30	\N	\N	\N
1469	306	111	2023-12-10	160000.00	\N	\N	\N	2024-08-21 14:56:30.425	2024-08-23 10:50:05.735	BCDIOF-Unit_Certificate-(68)-146254[Athena_Capital_Invesment_Pty_Ltd]20240823.pdf	\N	N/A	N/A	NSW	N/A	\N	\N	329	f	2023-12-10	\N	2024-08-19	\N	\N	\N
1493	233	122	2024-03-20	150000.00	\N	\N	\N	2024-08-29 14:52:06.878	2024-08-29 14:52:06.878	BCDIOF-Unit_Certificate-(76-B)-146240[Chiu_Ying_Tsui_And_Yiwenlin_ATF_Tinaewen_Family_Trust]20240829.pdf	\N	898 Burke Rd	Canterbury 	VIC	3126	\N	\N	334	f	2024-03-20	\N	\N	\N	\N	\N
1494	170	121	2024-04-17	100000.00	\N	\N	\N	2024-08-29 14:54:40.951	2024-08-29 14:54:40.951	BCDIOF-Unit_Certificate-(76-A)-146146[South_Star_Australia_Group_Pty_Ltd_atf_Chen_Superannuation_Fund]20240829.pdf	\N	261 High St Rd 	Mount Waverley 	VIC 	3149	\N	\N	246	f	2024-04-17	\N	\N	\N	\N	\N
1593	170	72	2023-03-24	100000.00	\N	\N	\N	2024-10-18 10:25:37.709	2024-10-18 10:25:37.709	BCDIOF-Unit_Certificate-(36-A)-146148[South_Star_Australia_Group_Pty_Ltd_AS_TRUSTEES_FOR_THE_CHEN_ZHU_FAMILY_TRUST]20241018.pdf	\N	261 High St Rd 	Mount Waverley	VIC	3149	\N	\N	333	f	2023-03-24	\N	2023-10-05	\N	\N	\N
1594	170	72	2023-10-06	80000.00	\N	\N	\N	2024-10-18 10:26:11.319	2024-10-18 10:26:11.319	BCDIOF-Unit_Certificate-(36-A)-146148[South_Star_Australia_Group_Pty_Ltd_AS_TRUSTEES_FOR_THE_CHEN_ZHU_FAMILY_TRUST]20241018.pdf	\N	261 High St Rd 	Mount Waverley	VIC	3149	\N	\N	333	f	2023-10-06	\N	\N	\N	\N	\N
732	170	72	2023-03-24	100000.00	\N	\N	\N	2023-04-06 17:34:39.353	2024-10-18 10:27:09.436	BCDIOF-Unit_Certificate-(36-A)-146146[South_Star_Australia_Group_Pty_Ltd_atf_Chen_Superannuation_Fund]20241018.pdf	\N	261 High St Rd 	Mount Waverley 	VIC 	3149	\N	\N	246	t	2023-03-24	\N	2023-10-05	\N	\N	\N
1380	279	132	2024-06-21	135000.00	\N	\N	\N	2024-06-21 14:57:53.142	2024-06-21 14:57:53.142	BCDIOF-Unit_Certificate-(83-A)-146221[Tian_QIN]20240814.pdf	\N	2406/33 Mackenzie street	Melbourne 	VIC 	3000	\N	\N	282	f	2024-06-21	1804015861971791872.pdf	\N	\N	\N	\N
1429	73	135	2024-07-05	1000000.00	\N	\N	\N	2024-08-02 12:09:23.262	2024-08-29 14:59:48.907	BCDIOF-Unit_Certificate-(85)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20240829.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2024-07-05	\N	2024-08-21	\N	\N	\N
1496	73	138	2024-08-22	750000.00	\N	\N	\N	2024-08-29 15:03:29.536	2024-08-29 15:03:29.536	BCDIOF-Unit_Certificate-(87)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20240829.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2024-08-22	\N	\N	\N	\N	\N
1138	122	107	2023-12-09	150000.00	\N	\N	\N	2023-12-12 17:50:00.519	2024-09-23 16:14:27.389	BCDIOF-Unit_Certificate-(67)-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20240923.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2023-12-09	1734465608440840192.pdf	2024-06-07	\N	\N	\N
1135	148	107	2023-12-12	150000.00	\N	\N	\N	2023-12-12 17:35:26.396	2024-09-23 16:32:57.94	BCDIOF-Unit_Certificate-(67)-146127[Jingyuan_HUANG]20240923.pdf	\N	8 Murray Dr	Burwood 	VIC	3125	\N	\N	203	f	2023-12-12	1734461942103244800.pdf	2024-06-07	\N	\N	\N
1495	112	135	2024-08-22	430000.00	\N	\N	\N	2024-08-29 15:01:19.679	2024-09-30 16:33:16.843	BCDIOF-Unit_Certificate-(85)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240930.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-22	\N	2024-09-19	\N	\N	\N
1431	66	135	2024-07-05	300000.00	\N	\N	\N	2024-08-02 12:11:14.856	2024-09-30 16:35:02.689	BCDIOF-Unit_Certificate-(85)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240930.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-07-05	\N	2024-08-31	\N	\N	\N
1533	66	138	2024-09-01	300000.00	\N	\N	\N	2024-09-30 16:35:37.9	2024-09-30 16:35:37.9	BCDIOF-Unit_Certificate-(87)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240930.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-09-01	\N	\N	\N	\N	\N
1614	289	37	2024-10-21	500000.00	\N	\N	\N	2024-10-21 17:28:19.541	2024-10-23 09:40:51.433	BCDIOF-Unit_Certificate-146237[Yu_(Ade)_Pty_Ltd]20241023.pdf	\N	6 Glenroy Ave	Beaumont	SA	5066	\N	\N	295	f	2024-10-21	\N	2025-10-31	\N	\N	\N
1670	264	157	2024-09-20	2000000.00	\N	\N	\N	2024-10-31 14:34:49.903	2024-10-31 14:34:49.903	BCDIOF-Unit_Certificate-(95)-146205[Ci_ZHANG]20241031.pdf	\N	235 Kooyong Road\t	Elsternwic	VIC	3185	\N	\N	262	f	2024-09-20	\N	\N	\N	\N	\N
1470	306	111	2024-08-21	60000.00	\N	\N	\N	2024-08-21 14:56:55.48	2024-11-29 17:00:06.709	BCDIOF-Unit_Certificate-(68)-146254[Athena_Capital_Invesment_Pty_Ltd]20241129.pdf	\N	N/A	N/A	NSW	N/A	\N	\N	329	f	2024-08-21	\N	\N	\N	\N	\N
1695	316	41	2022-12-21	7149729.00	\N	\N	\N	2024-11-29 17:15:19.65	2024-11-29 17:15:19.65	BCDIOF-Unit_Certificate-(22-A)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	f	2022-12-21	\N	\N	\N	\N	\N
1697	304	151	2024-11-29	123.00	\N	\N	\N	2024-11-29 17:22:58.791	2024-11-29 17:22:58.791	BCDIOF-Unit_Certificate-(93-B)-145000[Entity_for_Test]20241129.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	f	2024-11-29	\N	\N	\N	\N	\N
981	131	43	2023-10-07	90000.00	\N	\N	\N	2023-10-11 16:18:28.992	2023-10-11 16:20:28.759	0a1e3065-c92c-4823-a6d0-83389d830d2f.pdf	Golden Life Super Investments Pty Ltd ATF Golden Life Superannuation Fund	21 Acheron Ave	Camberwell 	VIC	3124	\N	\N	\N	f	2023-10-07	\N	\N	\N	\N	\N
1226	257	111	2023-12-15	500000.00	\N	\N	\N	2024-02-02 13:00:28.163	2024-02-02 13:00:28.163	1d901ff3-66ee-4d32-9b5d-817c1c752dab.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2023-12-15	\N	\N	\N	\N	\N
1168	180	37	2023-12-18	690000.00	\N	\N	\N	2023-12-19 15:42:38.774	2024-02-29 15:36:55.839	4a4eb038-e6db-4f04-aadc-0ebfa3ae95be.pdf	\N	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2023-12-18	\N	2024-12-31	\N	\N	\N
1139	31	107	2023-12-10	350000.00	\N	\N	\N	2023-12-12 17:58:15.581	2024-09-23 11:59:29.765	BCDIOF-Unit_Certificate-(67)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20240923.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2023-12-10	1734467684877172736.pdf	2024-06-07	\N	\N	\N
1356	303	38	2024-06-03	250000.00	\N	\N	\N	2024-06-03 17:30:58.254	2024-10-02 10:42:39.848	BCDIOF-Unit_Certificate-146250[Wan_MEN]20241002.pdf	\N	42A Paxton St	Malvern East	VIC	3145	\N	\N	308	f	2024-06-03	1797531405538779136.pdf	2024-09-19	\N	\N	\N
1534	15	38	2024-10-01	250000.00	\N	\N	\N	2024-10-02 14:20:32.499	2024-10-02 14:20:32.499	BCDIOF-Unit_Certificate-146021[Jianxin_Liu]20241002.pdf	\N	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	\N	88	f	2024-10-01	\N	2025-06-30	\N	\N	\N
1255	286	44	2024-03-02	100000.00	\N	\N	\N	2024-03-06 11:24:04.08	2024-03-06 16:41:12.936	37126d50-996e-4cbf-a914-01d87b0f26f6.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2024-03-02	\N	\N	\N	\N	\N
1278	35	38	2024-03-27	250000.00	\N	\N	\N	2024-03-27 17:09:15.075	2024-03-27 17:09:15.075	e4e2dc15-edda-4e3c-8a12-a0365f404cb7.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	f	2024-03-27	1772868465258795008.pdf	2024-12-31	\N	\N	\N
1304	261	122	2024-04-10	60000.00	\N	\N	\N	2024-04-11 09:59:12.392	2024-04-11 09:59:12.392	ca35d0c2-0b10-4bed-bc47-784683a84ffd.pdf	\N	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	\N	266	f	2024-04-10	1778211158436552704.pdf	\N	\N	\N	\N
993	125	44	2023-10-07	270000.00	\N	\N	\N	2023-10-12 11:20:48.443	2023-10-12 11:21:10.683	f31835c6-8ed4-46b1-93b9-52f2b003f5f8.pdf	Parque Edition P/L ATF Parque Edition Investment Trust 	88 John Rd	Cherrybrook	NSW	2126	\N	\N	\N	f	2023-10-07	\N	\N	\N	\N	\N
1330	208	125	2024-03-30	100000.00	\N	\N	\N	2024-05-02 15:38:09.969	2024-07-22 12:27:16.554	aea938e8-a27b-4333-94af-0452f087a205.pdf	\N	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2024-03-30	\N	2024-07-19	\N	\N	\N
1333	257	125	2024-04-04	1900000.00	\N	\N	\N	2024-05-02 15:41:09.046	2024-08-02 11:41:03.39	24520690-d483-4772-adf7-45dfa989366b.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-04-04	\N	2024-07-21	\N	\N	\N
1331	112	125	2024-04-04	2740000.00	\N	\N	\N	2024-05-02 15:39:38.907	2024-08-02 11:51:41.668	d2a26e39-5ef5-423d-83e7-494e10df5fa7.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-04-04	\N	2024-07-21	\N	\N	\N
731	131	72	2023-03-27	200000.00	\N	\N	\N	2023-04-06 17:29:08.295	2023-10-12 11:39:47.228	3d3b59b7-21db-4545-80ae-af210ed05e3f.pdf	Fei Bo Associated Pty Ltd ATF C C Family Trust	21 Acheron Ave\t	Camberwell 	VIC	3124	\N	\N	\N	f	2023-03-27	\N	2023-10-06	\N	\N	\N
1405	251	102	2024-07-10	2550000.00	\N	\N	\N	2024-07-12 11:22:55.796	2024-07-12 11:22:55.796	BCDIOF-Unit_Certificate-146193[Ziping_SI]20240814.pdf	\N	Unit 2, Level Building 4, 38 South Taoyuan Road	Lianhu \t	Xi'an	710000	\N	\N	250	f	2024-07-10	1811571911759462400.pdf	2026-01-31	\N	\N	\N
1535	209	37	2024-10-01	500000.00	\N	\N	\N	2024-10-02 14:22:37.708	2024-10-02 14:25:43.65	BCDIOF-Unit_Certificate-146160[ANTHONY_DONATO_HOLDINGS_PTY_LTD_ATF_ANTHONY_DONATO_FAMILY_TRUST]20241002.pdf	\N	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2024-10-01	\N	2025-09-30	\N	\N	\N
1671	36	157	2024-09-20	250000.00	\N	\N	\N	2024-10-31 14:35:30.004	2024-10-31 14:35:30.004	BCDIOF-Unit_Certificate-(95)-146247[Shell_Family_Pty_Ltd_ATF_Shell_Family_Trust]20241031.pdf	\N	42A Paxton Street	Malvern East	VIC	3145	\N	\N	303	f	2024-09-20	\N	\N	\N	\N	\N
1567	304	110	2023-11-02	2000000.00	\N	\N	\N	2024-10-10 17:00:08.574	2024-11-05 10:36:07.398	BCDIOF-Unit_Certificate-()-145000[Entity_for_Test]20241010.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-11-02	\N	2023-11-30	\N	\N	\N
1471	112	102	2024-08-21	1890000.00	\N	\N	\N	2024-08-21 14:59:48.094	2024-08-29 11:52:28.383	BCDIOF-Unit_Certificate-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240822.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	t	2024-08-21	\N	2024-08-21	\N	\N	\N
1430	112	135	2024-07-05	1000000.00	\N	\N	\N	2024-08-02 12:10:32.202	2024-08-29 15:00:42.638	BCDIOF-Unit_Certificate-(85)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240829.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-07-05	\N	2024-08-21	\N	\N	\N
1497	112	138	2024-08-14	1660000.00	\N	\N	\N	2024-08-29 15:04:43.003	2024-08-29 15:04:43.003	BCDIOF-Unit_Certificate-(87)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240829.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-14	\N	\N	\N	\N	\N
1615	304	40	2024-10-21	55555.00	\N	\N	\N	2024-10-21 21:46:47.637	2024-11-05 10:36:48.492	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241021.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-21	\N	\N	\N	\N	\N
1595	304	40	2024-10-20	888888.00	\N	\N	\N	2024-10-20 12:55:31.681	2024-11-05 10:37:28.778	BCDIOF-Unit_Certificate-000001[TEST_ENTITY]20241020.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-10-20	\N	\N	\N	\N	\N
1381	31	132	2024-06-19	800000.00	\N	\N	\N	2024-06-26 14:56:46.29	2024-09-20 16:04:48.288	BCDIOF-Unit_Certificate-(83-A)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20240920.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-06-19	\N	\N	\N	\N	\N
1696	316	41	2022-12-21	7149729.00	\N	\N	\N	2024-11-29 17:20:24.797	2024-11-29 17:20:24.797	BCDIOF-Unit_Certificate-(22-A)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	f	2022-12-21	\N	\N	\N	\N	\N
1432	257	135	2024-07-26	1140000.00	\N	\N	\N	2024-08-02 12:12:10.596	2024-10-03 10:11:06.899	BCDIOF-Unit_Certificate-(85)-146201[Lijun_LIU]20241003.pdf	\N	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2024-07-26	\N	2024-09-01	\N	\N	\N
1673	122	157	2024-09-20	810000.00	\N	\N	\N	2024-10-31 14:36:26.924	2024-12-05 17:46:52.366	BCDIOF-Unit_Certificate-(95)-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20241205.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2024-09-20	\N	\N	\N	\N	\N
1005	131	72	2023-10-06	160000.00	\N	\N	\N	2023-10-12 11:39:43.432	2023-11-09 14:22:46.146	5eea9528-4a90-4876-81d8-1276d22f9ce2.pdf	Fei Bo Associated Pty Ltd ATF C C Family Trust	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	\N	f	2023-10-06	\N	\N	\N	\N	\N
1141	155	107	2023-12-12	100000.00	\N	\N	\N	2023-12-12 18:05:05.294	2023-12-12 18:05:05.294	0ca0d903-95de-42e9-bfab-c4fb8814f9ea.pdf	\N	PO Box 571	Glen Waverley	VIC	3150	\N	\N	70	f	2023-12-12	1734469403338047488.pdf	\N	\N	\N	\N
1170	212	111	2023-12-18	100000.00	\N	\N	\N	2023-12-19 16:07:42.906	2023-12-19 16:07:42.906	a5e2730d-0df6-4740-9df2-09d88719a6c0.pdf	\N	17 Davington Way	Burswood	Auckland, New Zealand	2013	\N	\N	101	f	2023-12-18	1736976580485267456.pdf	\N	\N	\N	\N
1140	52	107	2023-12-13	100000.00	\N	\N	\N	2023-12-12 18:03:11.573	2024-01-08 11:25:24.68	e378c6f1-f98b-4df1-8ee7-8b8dbf4c0d63.pdf	\N	55 Salisbury Rd.	Ashwood	VIC	3147	\N	\N	148	f	2023-12-13	1734468926357602304.pdf	\N	\N	\N	\N
1227	229	38	2024-02-07	750000.00	\N	\N	\N	2024-02-07 20:51:43.577	2024-02-07 20:51:52.193	7b568f1f-fab4-4ba1-8cf4-1cf2ea6475c0.pdf	\N	1/221 Henley Beach Rd	Torrensville	SA 	5031	\N	\N	112	t	2024-02-07	1755167447511425024.pdf	2025-02-28	\N	\N	\N
1228	229	37	2024-02-07	750000.00	\N	\N	\N	2024-02-07 20:52:24.258	2024-02-07 21:48:51.391	6cf55ab0-8542-49db-8baa-07b0374d9e47.pdf	\N	1/221 Henley Beach Rd	Torrensville	SA 	5031	\N	\N	112	t	2024-02-07	1755167618144100352.pdf	2025-02-28	\N	\N	\N
1256	286	115	2022-03-02	10000.00	\N	\N	\N	2024-03-06 11:34:09.523	2024-03-06 11:34:09.523	12279483-74a2-4598-8d65-a268eca30c9b.pdf	\N	Company_TEST	TEST	TEST	0000	\N	\N	292	f	2022-03-01	\N	2022-06-01	\N	\N	\N
1279	30	115	2022-09-15	320000.00	\N	\N	\N	2024-03-28 09:56:42.59	2024-03-28 09:58:11	5bc0c9e2-a156-4a29-a910-d8b5e0c36d9a.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	t	2022-09-15	\N	2022-10-14	\N	\N	\N
1305	36	121	2024-04-10	100000.00	\N	\N	\N	2024-04-11 10:22:07.892	2024-04-11 10:22:07.892	9d97ea40-76a0-4906-b376-093f233fba2f.pdf	\N	42A Paxton Street	Malvern East	VIC	3145	\N	\N	303	f	2024-04-10	1778216927701704704.pdf	\N	\N	\N	\N
1169	233	110	2023-12-18	100000.00	\N	\N	\N	2023-12-19 15:48:33.318	2024-05-20 09:18:48.08	2e6de94f-0ba8-44fd-b8bc-30d078366c75.pdf	\N	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2023-12-18	1736971758818246656.pdf	2024-05-06	\N	\N	\N
1357	266	37	2024-05-10	578636.00	\N	\N	\N	2024-06-04 12:04:08.567	2024-06-04 12:04:08.567	84d752d6-d9ad-43ba-83db-a5cce14d2e26.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	\N	\N	\N	265	f	2024-05-10	\N	2025-05-31	\N	\N	\N
1332	66	125	2024-04-04	500000.00	\N	\N	\N	2024-05-02 15:40:31.351	2024-08-02 11:14:39.36	823632c1-57c2-4eb6-b7d3-554f0f2d95da.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2024-04-04	\N	2024-07-21	\N	\N	\N
1498	112	138	2024-08-22	570000.00	\N	\N	\N	2024-08-29 15:04:59.867	2024-09-30 14:50:57.142	BCDIOF-Unit_Certificate-(87)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240930.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-08-22	\N	2024-09-19	\N	\N	\N
1536	250	38	2024-10-01	250000.00	\N	\N	\N	2024-10-02 14:24:38.412	2024-10-02 14:24:38.412	BCDIOF-Unit_Certificate-146197[Shelford_Enterprise_Pty_Ltd_ATF_Shelford_Family_Trust]20241002.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2024-10-01	\N	2025-06-30	\N	\N	\N
1382	31	131	2024-06-19	200000.00	\N	\N	\N	2024-06-26 14:57:19.845	2024-06-26 14:57:19.845	BCDIOF-Unit_Certificate-(83-B)-146037[Oasisun_Management_Pty_Ltd_ATF_Sean_Family_Trust]20240814.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	105	f	2024-06-19	\N	\N	\N	\N	\N
1406	124	102	2024-07-11	2000000.00	\N	\N	\N	2024-07-12 14:47:13.613	2024-07-12 14:47:13.613	BCDIOF-Unit_Certificate-146119[Evergreen_Forest_Pty_Ltd_ATF_Evergreen_Super_Fund]20240814.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2024-07-11	\N	2026-01-31	\N	\N	\N
1433	18	38	2024-08-01	250000.00	\N	\N	\N	2024-08-02 16:12:51.073	2024-08-02 16:12:51.073	BCDIOF-Unit_Certificate-146023[Hung_Fung_Tong]20240814.pdf	\N	Unit 302, 80 Alfred St.	Milsons Point 	NSW 	2061	\N	\N	156	f	2024-08-01	\N	2025-04-30	\N	\N	\N
1672	303	157	2024-09-20	250000.00	\N	\N	\N	2024-10-31 14:35:58.707	2024-10-31 14:35:58.707	BCDIOF-Unit_Certificate-(95)-146250[Wan_MEN]20241031.pdf	\N	42A Paxton St	Malvern East	VIC	3145	\N	\N	308	f	2024-09-20	\N	\N	\N	\N	\N
1568	304	110	2023-12-01	1000000.00	\N	\N	\N	2024-10-10 17:01:03.737	2024-11-05 10:36:07.398	BCDIOF-Unit_Certificate-()-145000[Entity_for_Test]20241010.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2023-12-01	\N	2024-05-06	\N	\N	\N
1616	304	154	2024-10-21	12345.00	\N	\N	\N	2024-10-21 22:32:39.613	2024-11-05 10:36:44.482	BCDIOF-Unit_Certificate-(Class)-145000[Entity_for_Test]20241021.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-21	\N	\N	\N	\N	\N
1596	304	39	2024-10-20	999999.00	\N	\N	\N	2024-10-20 12:56:35.626	2024-11-05 10:37:27.262	BCDIOF-Unit_Certificate-000001[TEST_ENTITY]20241020.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-10-20	\N	\N	\N	\N	\N
1472	310	39	2024-08-21	400000.00	\N	\N	\N	2024-08-21 15:05:57.075	2024-11-22 16:33:59.098	BCDIOF-Unit_Certificate-146253[Xiaoyu_ZHU]20240821.pdf	\N	T20-C HUTANG XINCUNNANDU	CHANGZHOU	JIANGSU	000000	\N	\N	318	t	2024-08-21	\N	2025-05-31	\N	\N	\N
1700	316	151	2024-11-29	1234.00	\N	\N	\N	2024-11-29 17:32:04.915	2024-11-29 17:32:27.15	BCDIOF-Unit_Certificate-(93-B)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	t	2024-11-29	\N	\N	\N	\N	\N
1698	316	151	2024-11-29	1234.00	\N	\N	\N	2024-11-29 17:30:38.821	2024-11-29 17:32:42.016	BCDIOF-Unit_Certificate-(93-B)-146001[BHG_ONE_PTY_LTD_ATF_BHG_Debt_Income_Master_Fund_(BDIMF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW	2060	\N	\N	339	t	2024-11-29	\N	\N	\N	\N	\N
1701	316	41	2022-12-31	23242.00	\N	\N	\N	2024-11-29 17:36:52.382	2024-11-29 17:36:52.382	BCDIOF-Unit_Certificate-(22-A)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	f	2022-12-31	\N	\N	\N	\N	\N
42	34	2	2022-01-20	100000.00	\N	\N	\N	2022-01-27 09:14:35.378318	2023-03-17 11:59:04.327	78353603-cc61-47c0-b4e6-5b7e68d6857d.pdf	Chunnian DING	7/82-86 Atherton Road	Oakleigh	VIC	3166	\N	\N	140	f	\N	\N	2022-10-31	\N	\N	\N
937	21	38	2023-09-27	250000.00	\N	\N	\N	2023-09-27 16:06:07.843	2023-09-27 16:06:07.843	b4f49579-1631-4574-8842-217bd286fdf2.pdf	Aussie Essence International PTY LTD	83/209 Harris St	Pyrmont	NSW	2009	\N	\N	136	f	2023-09-27	1706913088576970752.pdf	2024-06-30	\N	\N	\N
764	21	38	2023-05-11	250000.00	\N	\N	\N	2023-05-11 13:42:54.393	2023-09-27 16:04:00.232	8b494cec-ebd0-499c-8747-028ad2da69b8.pdf	Aussie Essence International PTY LTD	83/209 Harris St	Pyrmont	NSW	2009	\N	\N	136	f	2023-05-11	1656505131542515712.pdf	2024-02-29	\N	\N	\N
20	21	39	2022-12-09	150000.00	\N	\N	\N	2021-12-09 15:01:07.795824	2023-05-11 12:25:52.365	4a7cb4ea-ccc3-4a04-881b-e2d8ac81f7e8.pdf	\N	\N	\N	\N	\N	\N	\N	136	f	\N	\N	2023-05-10	\N	\N	\N
405	21	2	2021-12-08	200000.00	\N	\N	\N	2023-03-03 14:11:11.681	2023-03-14 15:30:02.094	1e4263f1-600e-43f1-9ced-da10d666ab03.pdf	Aussie Essence International PTY LTD	120/140 Pyrmont St.	Pyrmont 	NSW 	2009	\N	\N	136	f	\N	\N	2022-09-30	\N	\N	\N
406	21	2	2022-10-01	150000.00	\N	\N	\N	2023-03-03 14:12:30.607	2023-03-16 11:04:45.291	5d164e06-db61-4487-bdc7-c589eae4fd0f.pdf	Aussie Essence International PTY LTD	120/140 Pyrmont St.	Pyrmont 	NSW 	2009	\N	\N	136	f	2022-10-01	\N	2022-12-08	\N	\N	\N
1040	36	38	2023-10-01	250000.00	\N	\N	\N	2023-11-01 15:03:32.706	2023-11-01 15:03:32.706	ed999612-a280-40d4-85d3-41173652e852.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	2023-10-01	\N	2024-07-31	\N	\N	\N
427	36	38	2022-12-14	250000.00	\N	\N	\N	2023-03-03 15:29:52.908	2023-03-16 16:38:50.273	b8b3aa16-568b-4ca0-9627-5612eeaf605c.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	2022-12-14	1636240586144821248.pdf	2023-09-30	\N	\N	\N
426	36	38	2022-12-14	50000.00	\N	\N	\N	2023-03-03 15:29:32.337	2023-03-15 16:47:36.899	c531ef1a-f986-4e77-b16a-dd39a6107dfa.pdf	Chang Qin	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	\N	\N	2022-12-14	\N	\N	\N
95	36	2	2022-05-10	150000.00	\N	\N	\N	2022-05-10 10:18:49.597242	2023-03-03 15:28:57.638	d3cee6f1-6ad2-4b1e-bf25-868911b661d1.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	\N	\N	2022-12-13	\N	\N	\N
35	36	2	2022-01-11	50000.00	\N	\N	\N	2022-01-11 10:30:23.508717	2023-03-17 12:00:49.397	234c7a79-341b-4a9d-bf0f-1ee8415ecc14.pdf	Chang Qin	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	\N	\N	2022-10-31	\N	\N	\N
822	36	86	2023-07-07	200000.00	\N	\N	\N	2023-07-06 13:29:51.981	2023-07-07 14:52:48.502	51786b03-48c2-43dd-9436-a179a29dc741.pdf	Chang QIN	42A Paxton Street 	Malvern East	VIC	3145	\N	\N	142	f	2023-07-07	1677178831249870848.pdf	\N	\N	\N	\N
574	36	45	2023-03-01	200000.00	\N	\N	\N	2023-03-06 17:22:42.166	2023-03-17 12:13:02.454	6567b426-676d-4ba6-9fa7-08e941d3c368.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	BCFCT5-146023	142	f	2023-03-01	1636536084009398272.pdf	\N	\N	\N	\N
820	36	84	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:20:25	2023-07-07 12:02:28.323	e7a1947f-9235-4f24-9cfe-1f66e9bc9037.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	2023-07-06	1677135964712210432.pdf	\N	\N	\N	\N
132	36	9	2022-08-12	200000.00	\N	\N	\N	2022-08-12 15:38:57.315368	2023-03-17 10:10:49.624	40ccdbe8-0e02-4048-b124-a6d0fe0a9cff.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	146023	142	f	2022-08-12	1636505327891197952.pdf	2022-09-25	\N	\N	\N
265	36	18	2022-11-02	100000.00	\N	\N	\N	2022-11-07 07:41:56.342144	2023-03-14 16:07:17.995	7297980b-b9ae-4350-820e-5f3c4fa334fa.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	BCFCT6-146049	142	f	2022-11-02	\N	\N	\N	\N	\N
174	36	15	2022-08-30	200000.00	\N	\N	\N	2022-08-30 12:21:22.387777	2023-03-17 15:20:38.793	5d1458ea-bb5a-40ee-a389-0fc042bf590d.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	BCFCT5-146023	142	f	\N	1636583296517091328.pdf	\N	\N	\N	\N
61	36	2	2022-03-07	50000.00	\N	\N	\N	2022-03-24 12:26:50.902292	2023-03-17 11:42:17.752	d10677a1-e801-40e7-9272-3fc2d8a3b30a.pdf	Chang QIN	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	2022-03-07	\N	2022-12-13	\N	\N	\N
37	38	2	2022-01-12	100000.00	\N	\N	\N	2022-01-13 12:32:56.133961	2023-03-17 11:59:41.187	b5b5d160-0bf8-4a8c-9f94-22b29929cd41.pdf	Xue Han	45A Woonona Ave	Wahroonga	NSW	2076	\N	\N	143	f	\N	\N	2022-10-31	\N	\N	\N
500	38	2	2022-01-12	100000.00	\N	\N	\N	2023-03-03 20:23:01.264	2023-03-15 15:10:52.749	6c8844e3-6e89-4c9c-896b-e5bafb5894c8.pdf	Xue HAN	45A Woonona Ave	Wahroonga	NSW	2076	\N	\N	143	f	2022-01-12	\N	2022-10-31	\N	\N	\N
47	34	2	2022-02-14	100000.00	\N	\N	\N	2022-02-16 08:23:02.958488	2023-03-17 11:56:17.571	7839e1d1-1382-4b01-81ae-a9a0317fea52.pdf	Chunnian DING	7/82-86 Atherton Road	Oakleigh	VIC	3166	\N	\N	140	f	\N	\N	2022-11-30	\N	\N	\N
419	34	2	2022-10-01	100000.00	\N	\N	\N	2023-03-03 15:07:29.001	2023-03-03 15:07:29.001	084b4133-20a4-4519-b716-0902c780bf7d.pdf	Chunnian DING	\N	\N	\N	\N	\N	\N	140	f	\N	\N	2023-07-31	\N	\N	\N
420	34	2	2022-11-01	100000.00	\N	\N	\N	2023-03-03 15:07:56.551	2023-08-02 17:26:48.904	88e07774-787d-4258-b738-8e23a2f45414.pdf	Chunnian DING	\N	\N	\N	\N	\N	\N	140	f	2022-11-01	\N	2023-08-31	\N	\N	\N
421	34	2	2022-12-01	100000.00	\N	\N	\N	2023-03-03 15:08:19.476	2023-08-02 17:26:35.234	fedd931a-32ba-445a-835d-aa923b14a18b.pdf	Chunnian DING	\N	\N	\N	\N	\N	\N	140	f	2022-12-01	\N	2023-09-30	\N	\N	\N
27	34	2	2021-12-20	100000.00	\N	\N	\N	2021-12-20 20:04:26.229933	2023-03-03 15:06:29.146	86595f28-6da3-41c9-bf4d-f9a160ac61e2.pdf	Chunnian DING	\N	\N	\N	\N	\N	\N	140	f	\N	\N	2022-09-30	\N	\N	\N
1142	60	107	2023-12-12	500000.00	\N	\N	\N	2023-12-12 18:06:39.473	2023-12-12 18:06:39.473	464f78dd-1b88-481f-918c-32f74e3177bc.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2023-12-12	1734469798353403904.pdf	\N	\N	\N	\N
1229	229	38	2024-02-07	500000.00	\N	\N	\N	2024-02-07 21:49:25.617	2024-02-07 21:49:25.617	65cdac03-2bd5-49a9-b739-49f639aac134.pdf	\N	1/221 Henley Beach Rd	Torrensville	SA 	5031	\N	\N	112	f	2024-02-07	1755181968363839488.pdf	2024-11-30	\N	\N	\N
1257	30	37	2024-03-01	500000.00	\N	\N	\N	2024-03-06 15:20:39.167	2024-03-06 15:20:39.167	e6501a94-a300-45be-889c-6f6f0dd683a4.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2024-03-01	\N	2025-02-28	\N	\N	\N
1306	299	121	2024-04-12	100000.00	\N	\N	\N	2024-04-12 10:46:01.789	2024-04-12 10:46:01.789	f91b5191-d460-4aa4-989e-f0cbdf8acef0.pdf	\N	18 Astrolabe Street	RED HILL	ACT	2603	\N	\N	304	f	2024-04-12	1778585329767227392.pdf	\N	\N	\N	\N
1334	228	2	2024-05-02	80000.00	\N	\N	\N	2024-05-03 10:53:42.145	2024-05-03 10:55:06.44	04283e00-73f0-4860-bff8-0f409f29e5d5.pdf	\N	36A Birkinshaw Ave.	Tranmere	SA	5073	\N	\N	111	f	2024-05-02	1786197405817839616.jpg	2025-02-28	\N	\N	\N
1171	151	110	2023-12-19	100000.00	\N	\N	\N	2023-12-19 16:41:05.713	2024-05-20 09:18:14.439	b651e238-2590-41ac-a7ed-b6134bfe8cbf.pdf	\N	14 Bond Street	Mount Waverley	VIC	3149	\N	\N	215	f	2023-12-19	1736984980870873088.pdf	2024-05-06	\N	\N	\N
743	36	76	2023-05-08	125000.00	\N	\N	\N	2023-05-08 10:18:10.692	2024-10-18 12:36:26.507	BCDIOF-Unit_Certificate-(37-A)-146042[Chang_QIN]20241018.pdf	\N	42A Paxton Street	Malvern East	VIC	3145	\N	\N	142	f	2023-05-08	1655366446369476608.pdf	2024-03-18	\N	\N	\N
1280	122	39	2024-03-29	150000.00	\N	\N	\N	2024-04-02 09:57:59.254	2024-06-13 16:56:58.682	8150bf27-a913-4a2e-aa21-d98822e3f1de.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2024-03-29	\N	2024-06-12	\N	\N	\N
1143	158	107	2023-12-05	200000.00	\N	\N	\N	2023-12-12 18:09:54.262	2024-09-23 14:07:31.076	BCDIOF-Unit_Certificate-(67)-146130[Shunhua_ZHENG]20240923.pdf	\N	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2023-12-05	1734470615357685760.pdf	2024-06-07	\N	\N	\N
1358	289	37	2024-06-04	1500000.00	\N	\N	\N	2024-06-05 10:07:40.408	2024-08-21 12:38:53.306	BCDIOF-Unit_Certificate-146251[Hou_Family_Wealth_Pty_Ltd_ATF_Hou_Family_Wealth_Superannuation_Fund]20240821.pdf	\N	6 Glenroy Ave \t	Beaumont  	SA	5066	\N	\N	309	f	2024-06-04	1798144621906153472.pdf	2024-08-20	\N	\N	\N
1006	15	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:41:09.988	2023-11-09 14:22:35.357	cbc0d66c-575a-4980-8994-915311b88f31.pdf	Jianxin Liu	608/4 Kiln Road	Kirrawee	NSW	2232	\N	\N	88	f	2023-10-06	\N	\N	\N	\N	\N
324	15	34	2022-12-16	100000.00	\N	\N	\N	2022-12-20 10:16:05.121053	2023-03-17 12:31:25.992	0aa8b91f-7cf1-45df-baf3-690b45d1dc91.pdf	Jianxin LIU	UNIT 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	BCFCT14-146031	88	f	2022-12-16	1636540712583245824.pdf	\N	\N	\N	\N
613	15	18	2022-09-26	100000.00	\N	\N	\N	2023-03-08 11:24:20.533	2023-03-14 10:14:43.33	ff4638e4-bddf-4df8-9093-5387e38bda81.pdf	Jianxin Liu	UNIT 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	\N	88	f	2022-09-26	\N	\N	\N	\N	\N
724	23	37	2023-03-29	50000.00	\N	\N	\N	2023-03-29 15:21:14.786	2023-03-29 15:26:20.362	ff674df4-7f34-4bec-94a8-d9df63ce2a8d.pdf	Nathan Management PL ATF Ultimate Family Trust	Unit 602, 19 Shoreline Drive	Rhodes	NSW 	2138	\N	\N	137	t	2023-03-29	\N	2023-03-29	\N	\N	\N
397	23	37	2022-10-10	730000.00	\N	\N	\N	2023-03-03 13:52:00.743	2023-03-06 15:40:03.397	4ab1469f-419b-491f-bdef-410da1d4fb23.pdf	\N	\N	\N	\N	\N	\N	\N	137	t	\N	\N	2023-10-31	\N	\N	\N
282	23	32	2022-12-09	100000.00	\N	\N	\N	2022-12-10 16:47:19.538057	2023-03-17 14:34:10.573	ddff40e6-3035-4d61-9e6d-e37b01dec3fc.pdf	XI CHEN	Unit 602, 19 Shoreline Drive	 Rhodes	NSW 	2138	\N	\N	137	f	2022-12-09	1636571601874792448.pdf	\N	\N	\N	\N
836	30	86	2023-07-05	250000.00	\N	\N	\N	2023-07-06 14:30:39.976	2023-07-07 09:58:28.156	bf5cafdb-4357-42a8-917c-dc4383eecace.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund	27 BURROUGHS ROAD	BALWYN 	VIC	 3103	\N	\N	138	t	2023-07-05	\N	\N	\N	\N	\N
611	30	37	2022-10-20	300000.00	\N	\N	\N	2023-03-07 17:13:39.798	2023-03-07 17:19:18.739	68a4cfd5-e6e2-435c-be94-b44fb488c643.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	t	2022-10-20	\N	2023-10-31	\N	\N	\N
523	30	34	2022-12-14	100000.00	\N	\N	\N	2023-03-06 16:04:19.59	2023-05-08 14:13:26.174	ff5ac675-03b2-43da-9bb7-8f40b3829b5c.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2022-12-14	1655425650992091136.pdf	\N	\N	\N	\N
505	30	2	2022-12-14	100000.00	\N	\N	\N	2023-03-03 20:58:52.674	2023-03-06 12:36:17.867	95470df1-8258-40f7-897c-292ea49cafc7.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	\N	\N	\N	\N	\N	BCFCT14-146024	138	t	2022-12-14	\N	\N	\N	\N	\N
830	30	84	2023-07-10	150000.00	\N	\N	\N	2023-07-06 13:57:53.795	2023-10-18 10:12:17.597	14266ada-15d7-4dd9-a4be-407561ebbda1.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-07-12	1678634212039856128.pdf	\N	\N	\N	\N
804	30	83	2023-06-28	150000.00	\N	\N	\N	2023-06-29 11:17:44.957	2023-06-29 11:19:39.278	08a076a7-e63a-4a9d-b937-94594b834ade.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2023-06-28	\N	\N	\N	\N	\N
398	15	38	2023-01-19	300000.00	\N	\N	\N	2023-03-03 13:54:43.394	2023-11-01 15:10:43.391	9e5a74d7-5949-492c-9531-83005060e088.pdf	Jianxin LIU	UNIT 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	\N	88	f	2023-01-19	1636239711166869504.pdf	2023-10-31	\N	\N	\N
76	15	2	2021-11-01	100000.00	\N	\N	\N	2022-03-29 14:04:51.065813	2023-03-03 13:56:48.087	2cbbbc4a-2fbd-4d6e-a938-e9ba421492fe.pdf	Jianxin LIU	UNIT 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	\N	88	f	\N	\N	2022-08-31	\N	\N	\N
15	15	2	2022-09-01	100000.00	\N	\N	\N	2021-09-30 16:08:32.73321	2023-03-14 17:37:30.764	66d7ad3c-6a3d-4dbb-85ce-5e23d67bb2b4.pdf	Jianxin LIU	UNIT 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	\N	88	f	2022-09-01	\N	2023-06-30	\N	\N	\N
34	23	2	2022-01-07	450000.00	\N	\N	\N	2022-01-10 06:35:24.483214	2023-03-17 12:01:04.756	f42c0ed7-d549-4fe0-8b89-a4418ce27259.pdf	Xi Chen	Unit 602, 19 Shoreline Drive	 Rhodes	NSW 	2138	\N	\N	137	f	\N	\N	2022-10-09	\N	\N	\N
366	23	37	2022-10-10	730000.00	\N	\N	\N	2023-01-13 13:41:17.909724	2023-03-29 15:21:51.327	1eacac5e-3d50-4541-86c8-e54907b65247.pdf	Nathan Management PL ATF Ultimate Family Trust	Unit 602, 19 Shoreline Drive	 Rhodes	NSW 	2138	\N	\N	137	f	\N	\N	2023-03-28	\N	\N	\N
396	23	2	2022-10-01	400000.00	\N	\N	\N	2023-03-03 13:43:30.911	2023-03-14 15:37:44.068	893a0f99-ef99-4857-8a93-113074e1a8f8.pdf	Nathan Management PL ATF Ultimate Family Trust	Unit 602, 19 Shoreline Drive	 Rhodes	NSW 	2138	\N	\N	137	f	\N	\N	2022-10-10	\N	\N	\N
364	23	40	2022-11-01	120000.00	\N	\N	\N	2023-01-13 12:56:52.668869	2023-03-14 15:42:32.934	33893a34-317f-42b7-bd9c-4d3e143bfc37.pdf	Nathan Management PL ATF Ultimate Family Trust	Unit 602, 19 Shoreline Drive	 Rhodes	NSW 	2138	\N	\N	137	f	\N	\N	2023-02-28	\N	\N	\N
22	23	2	2021-12-10	400000.00	\N	\N	\N	2021-12-14 10:12:48.976961	2023-03-03 13:41:43.791	8ae41961-628c-40d0-9539-b2a7ef6ed2d7.pdf	\N	Unit 602, 19 Shoreline Drive	 Rhodes	NSW 	2138	\N	\N	137	f	\N	\N	2022-09-30	\N	\N	\N
428	46	2	2022-12-01	300000.00	\N	\N	\N	2023-03-03 15:39:23.014	2023-08-02 17:25:57.699	deed6501-9960-4004-b2d3-57fb20ac5b46.pdf	Xiaoyin Pty Ltd ATF Xiaoyin Family Trust	1009/ 7 Rider Boulevard	Rhodes	NSW	2138	\N	\N	145	f	2022-12-01	\N	2023-09-30	\N	\N	\N
62	46	2	2022-03-11	100000.00	\N	\N	\N	2022-03-24 12:27:58.762634	2023-03-17 11:41:28.821	86d248cd-238f-4d26-9590-2a190eb1b9f4.pdf	Xiaoyin Pty Ltd ATF Xiaoyin Family Trust	1009/ 7 Rider Boulevard	Rhodes	NSW	2138	\N	\N	145	f	2022-03-11	\N	2022-12-31	\N	\N	\N
44	46	2	2022-02-02	300000.00	\N	\N	\N	2022-02-07 08:35:16.925239	2023-03-17 11:58:18.713	15b8a253-cf6d-46e3-93b0-c5a74e269166.pdf	Xiaoyin Pty Ltd ATF Xiaoyin Family Trust	1009/ 7 Rider Boulevard	Rhodes	NSW	2138	\N	\N	145	f	\N	\N	2022-11-30	\N	\N	\N
502	47	2	2022-02-01	500000.00	\N	\N	\N	2023-03-03 20:38:05.776	2023-03-15 15:08:28.423	dc9b5647-c3ec-47ec-8ea6-221a99ef0374.pdf	Yufeng LU & Bingdi LI	64 Catherine St	ST IVES	NSW	2075	\N	\N	146	f	2022-02-01	\N	2022-11-30	\N	\N	\N
45	47	2	2022-02-01	500000.00	\N	\N	\N	2022-02-07 09:43:27.626462	2023-03-17 11:57:41.385	c92c447b-3d39-4059-8e40-da11318a707f.pdf	Yufeng LU & Bingdi LI	64 Catherine St	IVES	NSW	2075	\N	\N	146	f	\N	\N	2022-11-30	\N	\N	\N
424	30	37	2023-02-07	500000.00	\N	\N	\N	2023-03-03 15:22:19.955	2023-03-20 11:11:54.584	17bc5c67-8285-42ad-86c3-f34ad845da74.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2023-02-07	1637607863444434944.pdf	2024-02-29	\N	\N	\N
425	30	37	2023-01-01	300000.00	\N	\N	\N	2023-03-03 15:22:51.742	2023-03-20 11:08:51.43	a17c753c-1c14-4d9e-a30b-7c1823fe75c7.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2023-01-01	1637607095240880128.pdf	2024-01-31	\N	\N	\N
847	15	38	2023-07-11	250000.00	\N	\N	\N	2023-07-12 09:29:02.111	2023-07-12 09:33:42.93	486c2371-678a-4b84-8d06-1a23968ab296.pdf	 Jianxin Liu 	 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	\N	88	f	2023-07-11	1678910468228648960.pdf	2024-04-30	\N	\N	\N
399	15	2	2022-02-24	100000.00	\N	\N	\N	2023-03-03 13:57:50.586	2023-03-14 15:36:35.968	60cb6c75-7fc6-4cfb-834a-94a1bf0996e0.pdf	Jianxin LIU	UNIT 608/4 KILN ROAD	KIRRAWEE	NSW	2232	\N	\N	88	f	\N	\N	2022-11-30	\N	\N	\N
748	30	76	2023-05-08	300000.00	\N	\N	\N	2023-05-08 16:59:42.84	2024-03-27 12:08:45.108	45dfb3c5-28af-4a94-a82c-45abb69bd273.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-05-08	1655467496162201600.pdf	2024-03-18	\N	\N	\N
746	30	75	2023-05-05	150000.00	\N	\N	\N	2023-05-08 14:13:46.506	2024-02-02 11:19:13.742	16c0b027-c41f-497c-975d-2f5823980cca.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-05-05	1655425736270680064.pdf	2024-01-18	\N	\N	\N
799	30	69	2023-06-22	110000.00	\N	\N	\N	2023-06-22 16:21:40.142	2024-10-17 19:04:00.841	BCDIOF-Unit_Certificate-(26-A)-146035[Evergreen_SUN_Pty_Ltd_ATF_Evergreen_Spring_Trust]20241017.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-06-22	\N	2023-07-03	\N	\N	\N
730	15	72	2023-04-06	100000.00	\N	\N	\N	2023-04-06 11:29:56.261	2024-10-18 10:15:04.745	BCDIOF-Unit_Certificate-(36-A)-146021[Jianxin_Liu]20241018.pdf	\N	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	\N	88	f	2023-04-06	\N	2023-10-05	\N	\N	\N
293	30	33	2022-12-12	100000.00	\N	\N	\N	2022-12-12 14:53:26.68811	2023-03-17 14:21:12.206	a97b418c-3200-4d15-a205-aeaa6d17518e.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2022-12-12	1636568337166970880.pdf	\N	\N	\N	\N
292	30	31	2022-12-12	200000.00	\N	\N	\N	2022-12-12 14:51:10.730621	2023-03-17 14:42:41.105	1783ba61-cd8d-43ff-9d1b-1b3a15c84f97.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2022-12-12	1636573743201202176.pdf	\N	\N	\N	\N
294	30	34	2022-12-12	100000.00	\N	\N	\N	2022-12-12 15:04:31.375117	2023-03-17 12:35:09.383	23450ebb-f82f-458b-9de9-445126297efe.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2022-12-12	1636541649553010688.pdf	\N	\N	\N	\N
241	30	22	2022-09-15	320000.00	\N	\N	\N	2022-09-16 11:59:54.074778	2023-03-14 17:25:00.189	eefa9f94869347ecc1967378782cc4fa.pdf	EVERGREEN SUN PTY LTD	27 Burroughs Road	Balwyn	VIC	3103	\N	BCFCT7-146054	138	t	\N	\N	\N	\N	\N	\N
240	30	20	2022-09-15	30000.00	\N	\N	\N	2022-09-16 11:58:02.523127	2023-03-14 17:24:57.787	61936d725a59e615329e4745d67c13f7.pdf	EVERGREEN SUN PTY LTD	27 Burroughs Road	Balwyn	VIC	3103	\N	BCFCT7-146054	138	t	\N	\N	\N	\N	\N	\N
135	30	9	2022-08-12	150000.00	\N	\N	\N	2022-08-12 15:44:12.331866	2023-03-17 10:08:23.598	68a2f491-0c95-4e11-8142-60ee7e66129b.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2022-08-12	1636504715413762048.pdf	2022-09-25	\N	\N	\N
662	35	70	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:02:18.787	2023-10-12 10:12:20.305	c268108b-1c6c-4132-81dc-bfb03f4955a5.pdf	Yu Ping Wan	8 Murray Dr \t	Burwood\t	VIC 	3125	\N	BCFCT26B-146021	141	f	2023-03-14	\N	\N	\N	\N	\N
755	35	76	2023-05-08	100000.00	\N	\N	\N	2023-05-09 15:49:43.047	2023-10-12 10:31:53.885	c7d4faec-30bf-486f-b3ac-d4fd407affa3.pdf	Yu Ping Wan	8 Murray Dr 	Burwood 	VIC 	32043125	\N	\N	141	f	2023-05-08	1655816896721981440.jpg	\N	\N	\N	\N
154	35	11	2022-08-17	100000.00	\N	\N	\N	2022-08-25 15:49:50.840132	2023-03-14 17:58:42.64	0875b1e1-495f-4145-9d33-797c81c15516.pdf	Yu Ping WAN	Apt 107/ 5 Claire Street	Mckinnon	VIC	3204	\N	BCFCT3-1-146026	141	f	2022-08-17	\N	2023-02-18	\N	\N	\N
575	31	45	2023-03-01	200000.00	\N	\N	\N	2023-03-06 17:23:07.033	2023-03-17 12:12:47.525	b64666c7-5a65-4de6-9cff-6555d2aa4712.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT5-146024	105	f	2023-03-01	1636536021392633856.pdf	\N	\N	\N	\N
599	31	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:12:51.537	2023-03-07 15:21:36.154	d33b3b1a-5864-4bf2-93df-3d399aa46547.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	105	t	2023-02-19	\N	\N	\N	\N	\N
833	31	86	2023-07-04	200000.00	\N	\N	\N	2023-07-06 14:03:32.711	2023-07-06 14:21:56.674	564ebce8-dd29-4dbb-aafe-a111696721d8.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 Erica Ave.	Glen Iris	VIC	3146	\N	\N	105	f	2023-07-04	\N	\N	\N	\N	\N
30	30	2	2021-12-21	100000.00	\N	\N	\N	2021-12-21 18:48:35.087639	2023-03-17 12:02:23.488	779c4408-764d-4f89-b8bf-546652f3e588.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	\N	\N	2022-09-30	\N	\N	\N
60	33	2	2022-03-15	100000.00	\N	\N	\N	2022-03-24 12:25:23.847106	2024-06-14 11:44:32.378	4866d07d-7c51-4544-ad4f-fc244908cc7a.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2022-03-15	\N	2022-12-08	\N	\N	\N
711	33	38	2023-03-10	450000.00	\N	\N	\N	2023-03-22 10:25:20.315	2023-03-22 10:30:04.449	412be825-9c34-4570-bac1-95d1c40283b7.pdf	Calm & Harmony Pty Ltd ATF Forever Young Superfund	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	2023-03-10	\N	2023-12-31	\N	\N	\N
25	33	38	2022-12-09	250000.00	\N	\N	\N	2021-12-19 21:40:10.85233	2023-03-22 10:23:16.261	3b52a9a8-ec00-4aaf-8e27-e2610dee2589.pdf	Calm & Harmony Pty Ltd ATF Forever Young Superfund	\N	\N	\N	\N	\N	\N	43	f	\N	\N	2023-03-09	\N	\N	\N
414	33	2	2022-12-09	50000.00	\N	\N	\N	2023-03-03 14:45:08.359	2024-06-14 11:42:22.235	b44f3620-286b-47f0-bec5-9bf029882a59.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	t	\N	\N	2022-12-09	\N	\N	\N
1033	35	40	2023-10-18	100000.00	\N	\N	\N	2023-10-19 15:23:54.917	2023-11-01 14:10:48.22	62bd1292-53d0-4ac8-a8f0-4638a44c92ce.pdf	Yu Ping WAN	8 Murray Dr.	Burwood\t	VIC \t	3125	\N	\N	141	f	2023-10-18	1714859898088046592.pdf	2024-02-29	\N	\N	\N
1035	35	40	2023-10-25	150000.00	\N	\N	\N	2023-10-30 09:41:31.07	2023-10-30 09:42:51.393	66e009b1-cb2c-4801-9ed3-3e2669d79876.pdf	Yu Ping WAN	8 Murray Dr.	Burwood\t	VIC \t	3125	\N	\N	141	f	2023-10-25	1718759997469999104.pdf	2024-02-29	\N	\N	\N
974	35	38	2023-10-10	250000.00	\N	\N	\N	2023-10-10 14:35:59.291	2023-10-12 10:30:51.166	96d7814e-4846-4e71-9cfc-d52a69513f69.pdf	Yu Ping Wan	8 Murray Dr \t	Burwood\t	VIC \t	3125	\N	\N	141	f	2023-10-10	1711586346048012288.pdf	2024-07-31	\N	\N	\N
169	35	2	2022-08-25	100000.00	\N	\N	\N	2022-08-26 14:18:37.983705	2023-03-03 15:26:18.656	81d9f5d3-6805-4b99-adb0-67d01e131185.pdf	\N	Apt 107/ 5 Claire Street	Mckinnon	VIC	3204	\N	\N	141	f	\N	\N	2023-05-31	\N	\N	\N
55	35	2	2022-03-23	100000.00	\N	\N	\N	2022-03-23 11:40:39.713322	2023-03-17 11:44:51.654	730b6608-a352-41b3-958b-719182a53796.pdf	Yu Ping WAN	Apt 107/ 5 Claire Street	Mckinnon	VIC	3204	\N	\N	141	f	\N	\N	2022-12-31	\N	\N	\N
31	35	2	2021-12-21	100000.00	\N	\N	\N	2021-12-21 18:48:59.329809	2023-03-17 12:02:12.009	00f56f10-4497-4d61-b4cb-e4be9456ed4e.pdf	Yu Ping WAN	Apt 107/ 5 Claire Street	Mckinnon	VIC	3204	\N	\N	141	f	\N	\N	2022-09-30	\N	\N	\N
890	31	37	2023-07-22	500000.00	\N	\N	\N	2023-07-24 11:44:28.558	2023-07-24 11:52:27.897	0cf7ba2a-03eb-4ed1-9000-83ecca94a98e.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 Erica Ave.	Glen Iris	VIC	3146	\N	\N	105	f	2023-07-22	1683292029564801024.pdf	2024-07-31	\N	\N	\N
262	31	38	2022-12-08	300000.00	\N	\N	\N	2022-10-21 07:32:50.532541	2023-03-16 15:13:10.127	272181d1-5919-4d42-bb96-ab45d8c2a208.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCDIOF-146037	105	f	\N	1636219026809892864.pdf	2023-09-30	\N	\N	\N
104	31	2	2022-06-07	100000.00	\N	\N	\N	2022-06-13 14:16:39.830717	2023-03-17 11:39:08.49	deb207fa-7623-479d-80f8-4d5dabb50bd5.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	\N	105	f	\N	\N	2022-12-07	\N	\N	\N
417	31	37	2022-10-20	500000.00	\N	\N	\N	2023-03-03 15:03:35.93	2023-11-01 15:55:37.463	4c2a5665-b1a5-4326-9b1e-f76b3ac48428.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	\N	105	f	\N	1637608498776633344.pdf	2023-10-31	\N	\N	\N
264	30	37	2022-10-20	500000.00	\N	\N	\N	2022-10-21 07:39:36.012374	2023-11-01 15:54:16.966	b3c59d29-5045-475f-9ee8-d67537072fc2.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	2022-10-20	\N	2023-10-31	\N	\N	\N
94	30	2	2022-05-09	300000.00	\N	\N	\N	2022-05-09 16:07:15.961969	2023-03-03 15:23:09.351	a1cf8567-38aa-472c-a43e-aebb56250aa0.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	\N	138	f	\N	\N	2023-01-01	\N	\N	\N
524	35	43	2023-02-19	100000.00	\N	\N	\N	2023-03-06 16:16:57.852	2024-10-17 16:41:53.344	BCDIOF-Unit_Certificate-(3-1E)-146041[Yu_Ping_WAN]20241017.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	f	2023-02-19	1636539148221100032.jpg	2023-10-05	\N	\N	\N
803	30	69	2023-06-28	90000.00	\N	\N	\N	2023-06-28 11:39:37.062	2024-03-27 12:08:15.824	ac9163e9-0bce-4eec-a2be-15201ea9c4e9.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2023-06-28	1673868722440568832.pdf	2024-03-11	\N	\N	\N
51	33	2	2022-02-22	50000.00	\N	\N	\N	2022-02-22 11:59:22.14133	2024-06-14 11:41:41.673	aca8aef9-e789-45d8-a575-e976edda520d.pdf	\N	27B Toolambool Road	Carnegie	VIC	3163	\N	\N	43	f	\N	\N	2022-11-30	\N	\N	\N
985	35	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:37:01.29	2024-10-17 16:42:28.546	BCDIOF-Unit_Certificate-(3-1E)-146041[Yu_Ping_WAN]20241017.pdf	\N	8 Murray Dr	Burwood	VIC	3125	\N	\N	141	f	2023-10-06	\N	2023-10-27	\N	\N	\N
744	31	76	2023-05-08	360000.00	\N	\N	\N	2023-05-08 10:22:01.646	2023-05-08 10:22:01.646	2bf2e60b-2625-4b2a-846d-e875c966b6a7.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 Erica Ave.	Glen Iris	VIC 	3146	\N	\N	105	f	2023-05-08	1655367415064956928.pdf	\N	\N	\N	\N
922	31	93	2023-08-24	600000.00	\N	\N	\N	2023-08-28 09:45:41.033	2023-08-28 09:45:41.033	d5a74864-fb4e-445a-8c36-e718c6683c46.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 Erica Ave.	Glen Iris	VIC	3146	\N	\N	105	f	2023-08-24	1695945709854248960.pdf	\N	\N	\N	\N
893	31	85	2023-07-24	200000.00	\N	\N	\N	2023-07-24 16:09:16.088	2023-07-24 16:09:16.088	fade677e-bd4b-40a3-b2a3-525681c7e39a.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 Erica Ave.	Glen Iris	VIC	3146	\N	\N	105	f	2023-07-24	1683358666695430144.pdf	\N	\N	\N	\N
892	31	84	2023-07-22	100000.00	\N	\N	\N	2023-07-24 16:08:02.675	2023-07-24 16:10:05.479	4055996a-c26b-4d71-96d7-e98ee7978320.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 Erica Ave.	Glen Iris	VIC	3146	\N	\N	105	f	2023-07-22	1683358358778990592.pdf	\N	\N	\N	\N
669	31	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:19:12.865	2023-03-14 17:19:12.865	7ad24ccf-ec16-4c74-9f10-2742418cdfea.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT26A-146024	105	f	2023-03-14	\N	\N	\N	\N	\N
238	31	22	2022-09-15	350000.00	\N	\N	\N	2022-09-16 11:55:27.396762	2023-03-14 17:24:49.77	532361fac883d5973cabd5783d473760.pdf	Oasisun Management Pty ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT7-146032	105	t	\N	\N	\N	\N	\N	\N
237	31	20	2022-09-15	150000.00	\N	\N	\N	2022-09-16 11:54:20.335456	2023-03-14 17:24:34.235	812b99cf6c7ec2d9ec8944218a36b957.pdf	Oasisun Management Pty ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT7-146032	105	t	\N	\N	\N	\N	\N	\N
250	31	30	2022-09-20	100000.00	\N	\N	\N	2022-09-20 15:06:14.964111	2022-09-21 08:11:07.79871	1292a628b401d9cd0546612c3398cc61.pdf	Oasisun Management Pty ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT9B-146021	105	f	\N	\N	\N	\N	\N	\N
247	31	28	2022-09-20	100000.00	\N	\N	\N	2022-09-20 15:00:53.146307	2023-03-16 16:46:49.907	923886d1-144e-4f0a-b27b-a8ffb6ca7c5f.pdf	Oasisun Management Pty ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT8B-146021	105	f	2022-09-20	\N	\N	\N	\N	\N
193	31	18	2022-09-14	500000.00	\N	\N	\N	2022-09-14 16:14:13.618741	2023-03-16 17:38:23.769	77840224-302d-4485-8d02-5e9f1a832270.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	BCFCT6-146030	105	f	2022-09-14	1636255574473388032.pdf	\N	\N	\N	\N
429	48	38	2022-12-09	250000.00	\N	\N	\N	2023-03-03 16:02:36.67	2023-03-16 16:46:35.186	884b1a7e-922f-4aa3-8701-ef26ba304332.pdf	Yang LI	16 GOTTENHAM ST.	GLEBE	NSW	2037	\N	\N	135	t	2022-12-09	\N	2023-09-30	\N	\N	\N
776	73	80	2023-06-01	500000.00	\N	\N	\N	2023-06-06 11:39:09.035	2023-06-06 11:39:09.035	570673fa-b55c-424f-82d3-0d92dcb070a8.pdf	1	1001b 53	NORTH SYDNEY	New South Wales	2060	\N	1	133	f	2023-06-01	\N	2023-06-01	\N	\N	\N
254	73	28	2022-09-23	140000.00	\N	\N	\N	2022-09-23 14:03:57.176374	2023-03-14 16:13:40.177	dfbf4827-d966-4727-ad09-815f86d00d0b.pdf	Wins Republic Pty Ltd ATF Wins Republic Family Trust	6 Greenwich Road 	Greenwich 	NSW 	2065	\N	BCFCT8B-146023	133	f	2022-09-23	\N	\N	\N	\N	\N
1030	73	69	2023-10-02	500000.00	\N	\N	\N	2023-10-16 16:51:34.056	2023-10-16 17:19:27.05	ed6d7fe9-84fa-4263-a064-775f5a4eae74.pdf	we	2e2	32	rew	gfs	\N	fd	133	t	2023-10-02	\N	\N	\N	\N	\N
365	73	37	2022-12-12	1000000.00	\N	\N	\N	2023-01-13 13:32:52.297018	2023-03-06 17:46:27.461	b5d0552ea3fbe05f08d2c584a093cf63.pdf	Wins Republic Pty Ltd ATF for Wins Republic Family Trust	6 Greenwich Rd.	Greenwich 	NSW 	2065	\N	BCDIOF-146024	133	t	\N	\N	\N	\N	\N	\N
411	29	2	2022-08-04	100000.00	\N	\N	\N	2023-03-03 14:38:41.648	2023-03-03 19:43:04.145	fe0e597a-efdc-4204-a50c-921e68ffced8.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2023-05-31	\N	\N	\N
85	31	2	2022-04-04	100000.00	\N	\N	\N	2022-04-04 15:33:56.619914	2023-03-03 14:59:44.126	a2bbf6fa-09c8-416e-b8aa-396fb8ccf98e.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	\N	105	f	\N	\N	2022-12-07	\N	\N	\N
48	50	2	2022-02-11	100000.00	\N	\N	\N	2022-02-16 08:23:41.58518	2023-03-17 11:49:04.569	ec6ab012-b948-48f6-9e3b-13efd640666b.pdf	Ying DONG	18 Perch CT	 Kingston	TAS	7050	\N	\N	147	f	\N	\N	2022-11-30	\N	\N	\N
298	50	38	2022-12-09	250000.00	\N	\N	\N	2022-12-13 13:36:19.769319	2023-03-16 16:14:26.73	2939900e-c212-41fc-bc55-a1a4a2a64fab.pdf	Ying DONG	18 Perch CT	 Kingston	TAS	7050	\N	\N	147	f	2022-12-09	\N	2023-09-30	\N	\N	\N
46	48	2	2021-11-05	200000.00	\N	\N	\N	2022-02-07 09:47:55.300738	2023-03-17 11:57:01.606	ccb771fa-4db7-4197-b87f-be446c00b419.pdf	Yang LI	16 GOTTENHAM ST.	GLEBE	NSW	2037	\N	\N	135	f	\N	\N	2022-08-31	\N	\N	\N
18	19	2	2021-11-05	50000.00	\N	\N	\N	2021-11-08 07:02:17.511036	2023-03-03 12:20:41.782	368e54ec-5787-45a1-b216-194d38d97136.pdf	\N	\N	\N	\N	\N	\N	\N	134	f	2021-11-05	\N	2022-08-31	\N	\N	\N
503	73	42	2022-12-22	563808.50	\N	\N	\N	2023-03-03 20:47:32.748	2024-08-23 10:27:46.061	BCDIOF-Unit_Certificate-(22-B)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20240823.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2022-12-22	1636539674732081152.pdf	2024-07-21	\N	\N	\N
177	73	2	2022-09-02	1000000.00	\N	\N	\N	2022-09-02 12:33:17.325189	2023-03-16 17:44:50.415	76bce5c0-b1ba-4d2c-9d04-9e830c84d5a6.pdf	Wins Republic Pty Ltd ATF for Wins Republic Family Trust	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2022-09-02	\N	2022-12-12	\N	\N	\N
458	73	2	2021-11-03	250000.00	\N	\N	\N	2023-03-03 17:43:26.27	2023-03-03 17:43:26.27	21418206-bc59-4068-a81c-bf5acebef752.pdf	Wins Republic Pty Ltd ATF Wins Republic Family Trust	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2021-11-03	\N	2022-08-31	\N	\N	\N
459	73	37	2022-12-12	1000000.00	\N	\N	\N	2023-03-03 17:44:06.106	2023-08-15 12:19:22.975	583109c8-32fd-44dc-82be-bb9db4b6c016.pdf	Wins Republic Pty Ltd ATF Wins Republic Family Trust	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2022-12-12	\N	2023-08-10	\N	\N	\N
59	31	2	2022-03-07	100000.00	\N	\N	\N	2022-03-24 12:23:12.027937	2023-03-17 11:43:44.34	8b69cd4c-0b03-4485-8453-2975b7c989a7.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	\N	105	f	2022-03-07	\N	2022-12-07	\N	\N	\N
26	31	2	2021-12-20	100000.00	\N	\N	\N	2021-12-20 20:00:08.496842	2023-03-03 14:56:47.836	578a3235-9338-4cbf-8977-ba94d081e7f9.pdf	Oasisun Management Pty Ltd ATF Sean Family Trust	47 ERICA AVE.	GLEN IRIS	VIC	3146	\N	\N	105	f	\N	\N	2022-09-30	\N	\N	\N
519	73	44	2023-02-19	80000.00	\N	\N	\N	2023-03-06 15:06:42.974	2024-10-18 16:46:27.418	BCDIOF-Unit_Certificate-(3-2E)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20241018.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-02-19	\N	2023-10-05	\N	\N	\N
1047	73	37	2023-09-01	1000000.00	\N	\N	\N	2023-11-01 15:51:02.047	2024-07-05 14:21:37.317	e4f6dde2-a880-49f5-8c13-90ca85cbd16e.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-09-01	\N	2024-07-04	\N	\N	\N
518	73	43	2023-02-19	320000.00	\N	\N	\N	2023-03-06 15:03:52.52	2024-10-17 15:26:35.24	BCDIOF-Unit_Certificate-(3-1E)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20241017.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-02-19	\N	2023-10-05	\N	\N	\N
987	73	43	2023-10-06	288000.00	\N	\N	\N	2023-10-11 16:40:50.016	2024-10-17 15:26:49.426	BCDIOF-Unit_Certificate-(3-1E)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20241017.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-10-06	\N	2023-12-06	\N	\N	\N
1000	73	44	2023-10-06	72000.00	\N	\N	\N	2023-10-12 11:30:12.368	2024-10-18 16:46:39.927	BCDIOF-Unit_Certificate-(3-2E)-146024[Wins_Republic_Pty_Ltd_ATF_Wins_Republic_Family_Trust]20241018.pdf	\N	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2023-10-06	\N	2023-12-06	\N	\N	\N
255	73	30	2022-09-23	440000.00	\N	\N	\N	2022-09-23 14:05:25.907018	2023-03-14 16:13:30.764	e96696e6-6d8b-4cba-ace5-a9e074a4a0b5.pdf	Wins Republic Pty Ltd ATF Wins Republic Family Trust	6 Greenwich Rd.	Greenwich 	NSW	2065	\N	\N	133	f	2022-09-23	\N	2022-12-19	\N	\N	\N
699	32	69	2023-03-15	100000.00	\N	\N	\N	2023-03-15 14:02:15.356	2023-03-15 15:21:32.301	ca1572f8-3416-422e-8c1b-52c8ae61cb9c.pdf	Sunrise Development(AU) Pty Ltd 	6 Woodlands Avenue	Camberwell	VIC	3124	\N	BCFCT26A-146038	139	f	2023-03-15	1635858745214709760.pdf	\N	\N	\N	\N
444	32	37	2022-10-24	2000000.00	\N	\N	\N	2023-03-03 16:51:12.63	2023-03-06 15:00:10.49	20099962-3154-4cae-a785-ec4f83873fba.pdf	\N	\N	\N	\N	\N	\N	\N	139	t	2022-10-24	\N	2023-10-31	\N	\N	\N
504	32	34	2022-12-12	100000.00	\N	\N	\N	2023-03-03 20:50:43.735	2023-03-17 12:31:04.954	aafc764d-6d42-41ab-9b0f-0b069d290d61.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	BCFCT14-146020	139	f	2022-12-12	1636540624343478272.pdf	\N	\N	\N	\N
310	32	33	2022-12-15	100000.00	\N	\N	\N	2022-12-15 11:26:59.474703	2023-03-17 14:18:15.812	d196c13c-e5c6-4d38-893d-9416ab95de44.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	139	f	2022-12-15	1636567597316911104.pdf	\N	\N	\N	\N
291	32	34	2022-12-12	100000.00	\N	\N	\N	2022-12-12 12:05:15.375249	2023-03-08 11:30:25.992	20031ca6-ebc3-453f-976b-645d241531b7.pdf	Sunrise Development (AU) Pty Ltd	\N	\N	\N	\N	\N	\N	139	t	2022-12-12	\N	\N	\N	\N	\N
280	32	31	2022-12-09	100000.00	\N	\N	\N	2022-12-09 14:54:25.873054	2023-03-17 14:44:11.201	7eb4249f-1b27-43e7-8ff6-48f52dad10ce.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	139	f	2022-12-09	1636574121091215360.pdf	\N	\N	\N	\N
446	96	2	2023-02-01	200000.00	\N	\N	\N	2023-03-03 17:01:15.792	2023-03-15 15:52:16.201	8f37a1c5-35de-427e-8593-38fc72651501.pdf	Jianhong Du	3 Gianluca Avenue	Keysborough	VIC	3073	\N	\N	202	f	2023-02-01	\N	2023-02-13	\N	\N	\N
281	32	33	2022-12-09	100000.00	\N	\N	\N	2022-12-09 15:01:54.16821	2023-03-17 14:23:02.92	6cf54bf0-68e9-4cee-9c74-998063307517.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	139	f	2022-12-09	1636568801535143936.pdf	\N	\N	\N	\N
235	32	22	2022-09-15	100000.00	\N	\N	\N	2022-09-16 11:49:58.219458	2023-03-14 17:24:27.537	030343c3450a87fcb180ee9e69e7e117.pdf	Sunrise Development(AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	BCFCT7-146023	139	t	\N	\N	\N	\N	\N	\N
251	32	30	2022-09-20	100000.00	\N	\N	\N	2022-09-20 15:06:56.601887	2022-09-21 08:15:41.164243	f61782748ea883a3ff27604e0d7b3a30.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	BCFCT9B-146022	139	f	\N	\N	\N	\N	\N	\N
248	32	28	2022-09-20	100000.00	\N	\N	\N	2022-09-20 15:02:31.21794	2023-03-16 16:28:51.746	73cb6a4e-b2a6-4443-a9aa-6e822aa13df3.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	BCFCT8B-146022	139	f	2022-09-20	\N	\N	\N	\N	\N
186	32	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 15:48:10.383789	2023-03-16 17:42:02.282	6bde0a7a-9de5-4c12-81ea-e8c3b11d1aa7.pdf	Sunrise Development (AU) Pty Ltd	6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	139	f	2022-09-14	1636256490983337984.pdf	\N	\N	\N	\N
881	52	84	2023-07-12	100000.00	\N	\N	\N	2023-07-20 14:33:45.781	2023-07-20 14:33:45.781	843b2a74-af0a-4f95-b670-dcf813e5fafe.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2023-07-12	1681885080700899328.pdf	\N	\N	\N	\N
229	52	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:40:51.557953	2023-03-14 17:24:09.786	742e57e222aa1200055c84111056446f.pdf	Ling YUAN	55 Salisbury Rd.	Ashwood	VIC 	3147	\N	BCFCT7-146049	148	t	\N	\N	\N	\N	\N	\N
301	52	31	2022-12-14	100000.00	\N	\N	\N	2022-12-13 14:55:03.9004	2023-03-17 14:42:13.316	a40fdae8-c377-454f-8f4d-7ca68b4e4bba.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2022-12-14	1636573626645688320.pdf	\N	\N	\N	\N
196	52	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:22:01.622742	2023-03-16 17:37:09.3	8c2590a2-521b-4c3c-9f38-f32e4e58d60f.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2022-09-14	1636255262127763456.pdf	\N	\N	\N	\N
162	52	14	2022-08-17	100000.00	\N	\N	\N	2022-08-26 08:19:01.209338	2023-03-14 18:07:14.128	402a2fe0-e1ec-4187-8a85-8c652777daa8.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	BCFCT3-2-146023	148	f	2022-08-17	\N	2023-02-18	\N	\N	\N
1002	110	72	2023-10-06	120000.00	\N	\N	\N	2023-10-12 11:34:30.072	2023-11-09 14:23:20.711	8477c2e1-0967-4e3e-ac30-23b4e5be713b.pdf	WENYAN WU PTY LTD ATF WU SUPERANNUATION	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2023-10-06	\N	\N	\N	\N	\N
166	110	14	2022-08-17	80000.00	\N	\N	\N	2022-08-26 08:28:00.348382	2023-03-14 18:13:32.003	f4c0f40e-0a38-488b-8d32-e4147ade9955.pdf	Wenyan Wu Pty Ltd ATF Wu Super Fund 	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	BCFCT3-2-146027	82	f	2022-08-17	\N	2023-02-18	\N	\N	\N
165	132	14	2022-08-17	150000.00	\N	\N	\N	2022-08-26 08:26:36.604195	2023-03-14 18:11:45.491	bd6a3b62-7862-48dc-a3f4-95050f560015.pdf	Yangying Wang ATF HW Investment Trust	13 West Terrace	Kensington Gardens	SA	5068	\N	BCFCT3-2-146026	77	f	2022-08-17	\N	2023-02-18	\N	\N	\N
157	132	11	2022-08-17	150000.00	\N	\N	\N	2022-08-26 07:47:35.094139	2023-03-14 18:00:44.881	b33c40ed-9a80-4a11-90ea-3be8b5d767a8.pdf	Yangying Wang ATF HW Investment Trust	13 West Terracev	Kensington Gardens	SA	5068	\N	BCFCT3-1-146028	77	f	2022-08-16	\N	2023-02-18	\N	\N	\N
430	52	2	2022-12-13	50000.00	\N	\N	\N	2023-03-03 16:04:54.777	2023-03-15 16:11:21.55	025f9b41-66a2-497a-85ab-13cabbf6ac11.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2022-12-13	\N	2022-12-13	\N	\N	\N
110	52	2	2022-06-17	100000.00	\N	\N	\N	2022-06-17 14:04:56.156578	2023-03-17 11:36:18.942	e3108861-fc52-439c-884b-87d9fa40c2f8.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2022-06-17	\N	2022-12-12	\N	\N	\N
49	52	2	2022-02-18	100000.00	\N	\N	\N	2022-02-22 11:56:02.503107	2023-03-17 11:48:35.439	a82dfa35-bb99-4bde-8cca-1ad1548ddb3b.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2022-02-18	\N	2022-11-30	\N	\N	\N
106	110	2	2022-06-10	150000.00	\N	\N	\N	2022-06-13 14:19:02.178182	2023-03-17 11:38:49.267	0805bb1e-6961-434b-aa8c-eb3af8005ac6.pdf	Wenyan Wu Pty Ltd ATF Wu Superannuation Fund 	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2022-06-10	\N	2023-03-31	\N	\N	\N
934	132	38	2023-09-15	300000.00	\N	\N	\N	2023-09-15 14:26:27.846	2023-09-15 14:26:27.846	99ba7255-30b8-492c-aa2b-ad2159e68d71.pdf	Yangying Wang ATF HW Investment Trust	13 West Terrace	Kensington Gardens	SA	5068	\N	\N	77	f	2023-09-15	1702539352090132480.pdf	2024-06-30	\N	\N	\N
43	45	2	2022-01-31	350000.00	\N	\N	\N	2022-01-31 12:08:10.557547	2023-03-17 11:58:35.872	5beb714e-968b-4639-af05-1f375ba347de.pdf	Yanchao YANG	38 Dalgetty Road	 Beaumaris	VIC	3193	\N	\N	144	f	\N	\N	2022-10-31	\N	\N	\N
1013	52	38	2023-10-01	250000.00	\N	\N	\N	2023-10-12 14:28:46.846	2023-10-12 14:28:46.846	e0a0634e-15ac-4c09-88e1-d0a17daa9696.pdf	Ling YUAN	55 Salisbury Rd.	Ashwood	VIC	3147	\N	\N	148	f	2023-10-01	1712309307973419008.pdf	2024-07-31	\N	\N	\N
431	52	39	2022-12-13	150000.00	\N	\N	\N	2023-03-03 16:05:26.335	2023-03-16 17:24:26.389	6a97f9c4-114b-43d3-a008-f9b2afb21fe7.pdf	Ling YUAN	55 Salisbury Rd	Ashwood	VIC	3147	\N	\N	148	f	2022-12-13	1636252062247104512.pdf	2023-09-30	\N	\N	\N
155	110	11	2022-08-17	70000.00	\N	\N	\N	2022-08-25 15:53:10.79812	2024-05-09 11:25:15.642	d602498f-7136-46a7-a896-93b5cb467fa3.pdf	\N	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2022-08-17	\N	2023-02-18	\N	\N	\N
671	110	69	2023-03-15	150000.00	\N	\N	\N	2023-03-14 17:21:52.517	2024-05-09 11:45:15.474	7b5ac006-eb9a-42a3-8223-49fa98aea09d.pdf	\N	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2023-03-15	\N	\N	\N	\N	\N
734	110	72	2023-04-11	150000.00	\N	\N	\N	2023-04-12 10:10:26.231	2024-10-18 10:28:52.37	BCDIOF-Unit_Certificate-(36-A)-146083[Wenyan_Wu_Pty_Ltd_ATF_Wu_Superannuation_Fund]20241018.pdf	\N	25 CLARKE STREET	WEST RYDE	NSW	2114	\N	\N	82	f	2023-04-11	\N	2023-10-05	\N	\N	\N
525	52	44	2023-02-19	100000.00	\N	\N	\N	2023-03-06 16:23:00.104	2024-10-18 16:49:56.012	BCDIOF-Unit_Certificate-(3-2E)-146050[Ling_YUAN]20241018.pdf	\N	55 Salisbury Rd.	Ashwood	VIC	3147	\N	\N	148	f	2023-02-19	\N	2023-10-05	\N	\N	\N
998	52	44	2023-10-06	90000.00	\N	\N	\N	2023-10-12 11:27:21.104	2024-10-18 16:50:07.02	BCDIOF-Unit_Certificate-(3-2E)-146050[Ling_YUAN]20241018.pdf	\N	55 Salisbury Rd.	Ashwood	VIC	3147	\N	\N	148	f	2023-10-06	\N	2023-12-06	\N	\N	\N
228	45	20	2022-09-15	200000.00	\N	\N	\N	2022-09-16 09:40:01.899082	2023-03-14 17:24:06.65	eb067591be02237906cab43591f832f7.pdf	Yanchao YANG	38 Dalgetty Road	Beaumaris	VIC 	3193	\N	BCFCT7-146048	144	t	\N	\N	\N	\N	\N	\N
195	45	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:20:41.439573	2023-11-01 16:48:41.609	a852296e-45dc-4ca6-a2f9-2d867a934180.pdf	Yanchao YANG	38 Dalgetty Road	 Beaumaris	VIC	3193	\N	\N	144	f	2022-09-14	1636255357682397184.pdf	2023-10-17	\N	\N	\N
841	136	84	2023-07-07	100000.00	\N	\N	\N	2023-07-09 22:54:07.339	2023-07-09 22:54:07.339	7a13b438-67dc-460b-b48f-9dbf5767b4a0.pdf	BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust	2/21 Albury Road	Balwyn North	VIC	3104	\N	\N	79	f	2023-07-07	1678024733606809600.pdf	\N	\N	\N	\N
311	136	34	2022-12-15	100000.00	\N	\N	\N	2022-12-15 14:34:19.333872	2023-03-17 12:33:29.078	fca61b77-199c-49d8-b7ae-f89964c12ee0.pdf	BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust	2/21 Albury Road	Balwyn North	VIC	3104	\N	\N	79	f	2022-12-15	1636541228843347968.pdf	\N	\N	\N	\N
208	136	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:08:22.416116	2023-03-14 17:23:35.041	ef80f62a8b82eef3bed9adc6a628e5be.pdf	BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust	2/21 Albury Road 	Balwyn North 	VIC 	3104	\N	BCFCT7-146025	79	t	\N	\N	\N	\N	\N	\N
305	136	31	2022-12-14	100000.00	\N	\N	\N	2022-12-15 07:36:26.446745	2023-10-12 14:18:34.862	3e68e380-c3a9-4443-8aaf-e2bbcc51f6ce.pdf	BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust	2/21 Albury Road	Balwyn North	VIC	3104	\N	\N	79	f	2022-12-14	1636573233211584512.jpg	2023-07-10	\N	\N	\N
323	155	31	2022-12-19	100000.00	\N	\N	\N	2022-12-20 10:02:42.020898	2023-03-17 14:37:20.55	c651a531-c9cd-4435-b026-72a326ffcd4a.pdf	DT ANALYTICS Pty Ltd	PO Box 571	Glen Waverley	VIC	3150	\N	\N	70	f	2022-12-19	1636572398696083456.pdf	\N	\N	\N	\N
224	155	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:33:42.990979	2023-03-14 17:23:54.424	3f79304c707c32fa52bbb0af412f65f3.pdf	DT ANALYTICS Pty Ltd	PO Box 571	Glen Waverley	VIC 	3150	\N	BCFCT7-146042	70	t	\N	\N	\N	\N	\N	\N
221	143	20	2022-09-15	200000.00	\N	\N	\N	2022-09-16 08:59:19.708284	2023-03-14 17:23:46.282	f5073bd8-9c5e-4060-b1cb-cc620f04b84a.pdf	AF. Homey Pty Ltd ATF AF.Family Trust	Unit 3,13 Graham Place	Hill Box	VIC	3128	\N	BCFCT7-146039	80	t	2022-09-12	\N	\N	\N	\N	\N
190	143	18	2022-09-14	300000.00	\N	\N	\N	2022-09-14 16:04:52.295296	2023-11-01 16:47:59.012	86d37322-2c1a-44d8-9131-2b69238f7479.pdf	AF. Homey Pty Ltd ATF AF.Family Trust	Unit 3,13 Graham Place	Hill Box	VIC	3128	\N	\N	80	f	2022-09-14	1636256070202372096.pdf	2023-10-17	\N	\N	\N
617	153	11	2022-08-17	100000.00	\N	\N	\N	2023-03-08 16:57:10.962	2023-03-14 10:05:12.994	58b9d463-9f7a-4f68-ad6d-a5b61dbd73c7.pdf	Chuwen Lu ATF Bitquantum Investment Trust	85 Nurlendi Rd.	Vermont	VIC	3133	\N	\N	71	f	2022-08-17	\N	2023-02-18	\N	\N	\N
763	153	76	2023-05-08	100000.00	\N	\N	\N	2023-05-10 12:07:56.92	2023-05-10 12:07:56.92	544e9254-5460-4773-9cae-7be57f0651ef.pdf	Chuwen Lu ATF Bitquantum Investment Trust	85 Nurlendi Rd.	Vermont	VIC	3133	\N	\N	71	f	2023-05-08	1656118846743121920.pdf	\N	\N	\N	\N
327	153	31	2022-12-16	100000.00	\N	\N	\N	2022-12-29 16:49:48.526819	2023-03-17 14:36:37.427	58a56a59-a5da-4de2-a57a-19e3d9d5b2e2.pdf	Chuwen Lu ATF Bitquantum Investment Trust	85 Nurlendi Rd.	Vermont	VIC	3133	\N	BCFCT11-146028	71	f	2022-12-16	1636572217825112064.pdf	\N	\N	\N	\N
216	153	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:44:19.218074	2023-03-14 17:23:05.655	10ca68fce2b38cc4d8e038d8cce0a4ab.pdf	Chuwen Lu ATF Bitquantum Investment Trust	85 Nurlendi Rd	Vermont	Vic 	3133	\N	BCFCT7-146034	71	t	\N	\N	\N	\N	\N	\N
1051	29	104	2023-11-02	100000.00	\N	\N	\N	2023-11-03 10:09:14.953	2023-11-03 10:09:14.953	085fdaa3-c5fe-43b2-8504-c233fd3ebb27.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2023-11-02	1720216527764099072.pdf	\N	\N	\N	\N
287	29	34	2022-12-12	100000.00	\N	\N	\N	2022-12-12 08:29:24.631243	2023-03-17 12:35:47.414	754174ce-4fa6-47e9-8ae5-196ef807de98.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-12-12	1636541809066586112.pdf	\N	\N	\N	\N
749	29	77	2023-05-08	100000.00	\N	\N	\N	2023-05-09 10:54:32.62	2023-05-09 11:32:45.268	fe58ab3c-cdaf-493d-844a-f8df9ab8c551.pdf	Chang Liu ATF Chang Family Trust	 10B El Nido Grove	Carnegie	VIC	3163	\N	146036	50	f	2023-05-08	1655747601967091712.pdf	\N	\N	\N	\N
660	29	70	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:00:05.703	2023-03-14 17:00:05.703	0934d7e7-2fe6-4087-ad8a-298bb39fe302.pdf	Chang Liu ATF Chang Family Trust	 10B El Nido Grove	Carnegie	VIC	3163	\N	BCFCT26B-146023	50	f	2023-03-14	\N	\N	\N	\N	\N
923	29	93	2023-08-24	100000.00	\N	\N	\N	2023-08-28 09:48:44.241	2023-08-28 09:48:44.241	246ca09e-10b8-48f8-bf88-dbdfbcf0e7ef.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2023-08-24	1695946478284296192.pdf	\N	\N	\N	\N
573	29	45	2023-03-01	200000.00	\N	\N	\N	2023-03-06 17:22:16.087	2023-03-17 12:13:16.816	418a62df-6f1d-4926-982a-d50f0abfe6b6.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	BCFCT5-146022	50	f	2023-03-01	1636536144247992320.pdf	\N	\N	\N	\N
835	29	86	\N	100000.00	\N	\N	\N	2023-07-06 14:07:30.815	2023-07-06 14:26:21.023	405df157-4df0-42db-8c76-1691f90ddf25.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	t	\N	1676805044578832384.pdf	\N	\N	\N	\N
817	29	84	2023-07-05	100000.00	\N	\N	\N	2023-07-06 13:13:08.183	2023-11-03 10:08:39.507	8f5d933b-5a9f-4526-a6ef-ce1f314e07b3.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2023-07-05	1720216379092799488.pdf	2023-07-31	\N	\N	\N
805	29	86	2023-07-05	100000.00	\N	\N	\N	2023-07-05 15:31:36.2	2023-07-06 11:33:16.588	afc96e65-a568-4dec-9a26-92e621b3409a.pdf	Chang Liu ATF Chang Family Trust	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2023-07-05	\N	\N	\N	\N	\N
84	29	2	2022-04-04	100000.00	\N	\N	\N	2022-04-04 11:53:27.330521	2023-03-03 19:43:50.556	0bdc2b1b-7342-445a-9b50-71ebf6545ade.pdf	Chang Liu ATF Chang Family Trust	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2023-01-31	\N	\N	\N
412	29	37	2022-12-13	2000000.00	\N	\N	\N	2023-03-03 14:39:29.772	2023-03-03 19:42:53.483	0a09b6b6-6c5b-4bc1-b084-a3455a0d895d.pdf	Value Up 1123 Pty Ltd ATF for Value Up 1123 Trust 	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2023-12-31	\N	\N	\N
408	29	2	2022-07-13	50000.00	\N	\N	\N	2023-03-03 14:29:15.627	2023-03-03 19:43:22.339	93e0df67-8eb3-48ce-9b81-d4f002908ef3.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2022-12-07	\N	\N	\N
409	29	2	2022-05-16	100000.00	\N	\N	\N	2023-03-03 14:37:11.874	2023-03-03 19:43:17.978	49cad955-9ce2-43ff-bdfa-3b795b4474af.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2022-12-07	\N	\N	\N
410	29	2	2022-07-13	50000.00	\N	\N	\N	2023-03-03 14:38:08.565	2023-03-03 19:43:14.248	a79c528f-f41a-4f8c-b5ef-bbf7618f2e46.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2022-12-07	\N	\N	\N
489	29	2	2021-12-17	100000.00	\N	\N	\N	2023-03-03 19:50:29.75	2023-03-15 15:18:14.582	92b59b5b-e31e-4714-9916-b406d1823bb7.pdf	Chang LIU	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2021-12-17	\N	2022-09-30	\N	\N	\N
490	29	2	2022-03-14	100000.00	\N	\N	\N	2023-03-03 19:51:16.647	2023-03-03 19:51:16.647	214a04b4-4cbf-4a90-95df-3581ad6fc38b.pdf	Chang LIU	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-03-14	\N	2022-12-31	\N	\N	\N
491	29	2	2022-04-04	100000.00	\N	\N	\N	2023-03-03 19:52:18	2023-03-15 15:17:51.088	7ca238cd-41e6-4a44-8e4e-a922466d66b8.pdf	Chang LIU	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-04-04	\N	2022-12-31	\N	\N	\N
184	136	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 15:40:31.604884	2024-01-31 09:59:34.754	10e0c69a-55de-42d3-af31-1783954f9ad4.pdf	\N	2/21 Albury Road	Balwyn North	VIC	3104	\N	\N	79	f	2022-09-14	1636256714145476608.pdf	2023-12-08	\N	\N	\N
598	29	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:09:56.072	2024-10-18 16:52:08.225	BCDIOF-Unit_Certificate-(3-2E)-146036[Chang_Liu_ATF_Chang_Family_Trust]20241018.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2023-02-19	\N	2023-10-05	\N	\N	\N
997	29	44	2023-10-06	90000.00	\N	\N	\N	2023-10-12 11:26:16.793	2024-10-18 16:52:18.59	BCDIOF-Unit_Certificate-(3-2E)-146036[Chang_Liu_ATF_Chang_Family_Trust]20241018.pdf	\N	10B El Nido Grove 	Carnegie	VIC	3163	\N	\N	50	f	2023-10-06	\N	2023-10-27	\N	\N	\N
407	29	38	2022-12-08	300000.00	\N	\N	\N	2023-03-03 14:13:35.058	2023-03-03 19:43:32.468	f91b5dab-bcb3-45e9-8ba1-15b8d9765509.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2023-09-30	\N	\N	\N
285	29	31	2022-12-12	100000.00	\N	\N	\N	2022-12-12 08:24:51.272131	2023-03-17 14:43:38.658	6583e5a0-4437-43bb-8840-7d7428bd07a5.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-12-12	1636573984595980288.jpeg	\N	\N	\N	\N
309	29	33	2022-12-15	100000.00	\N	\N	\N	2022-12-15 11:15:09.319456	2023-03-17 14:18:48.552	27348f7e-f7c4-47e6-a29c-0cf083b0851d.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-12-15	1636567734638424064.pdf	\N	\N	\N	\N
286	29	33	2022-12-12	100000.00	\N	\N	\N	2022-12-12 08:27:56.510105	2023-03-16 15:58:23.063	14a847d2-4507-4b78-a5ef-383243d86c19.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-12-12	\N	\N	\N	\N	\N
239	29	22	2022-09-15	100000.00	\N	\N	\N	2022-09-16 11:56:55.969497	2023-03-14 17:24:52.306	70e441310485026e9906a39e6d7b212e.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	BCFCT7-146044	50	t	\N	\N	\N	\N	\N	\N
272	29	37	2022-10-24	2000000.00	\N	\N	\N	2022-12-06 08:00:52.104773	2023-03-03 19:43:43.931	b1114d7c-b961-401d-8cf2-ccb4c288e336.pdf	\N	\N	\N	\N	\N	\N	\N	50	t	2022-10-24	\N	2023-10-31	\N	\N	\N
249	29	30	2022-09-20	100000.00	\N	\N	\N	2022-09-20 15:05:28.339021	2022-09-21 08:11:04.595667	dd1c1fbdc2d629cacdd2020a40c49207.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	BCFCT9B-146020	50	f	\N	\N	\N	\N	\N	\N
246	29	28	2022-09-20	100000.00	\N	\N	\N	2022-09-20 14:58:34.229235	2023-03-16 16:47:18.529	246ab495-6be5-4311-93e4-a9390b19a86e.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	BCFCT8B-146020	50	f	2022-09-20	\N	\N	\N	\N	\N
191	29	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:07:52.485952	2023-03-16 17:39:59.012	3f44fd30-e998-44d2-92c9-0f6ad91758bb.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-09-14	1636255973951483904.pdf	\N	\N	\N	\N
160	29	14	2022-08-17	100000.00	\N	\N	\N	2022-08-26 08:14:15.457657	2023-03-14 18:08:58.722	4ad62e47-4ec0-4b0b-b998-a7a79d3a1405.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-08-17	\N	2023-02-18	\N	\N	\N
173	29	15	2022-08-30	200000.00	\N	\N	\N	2022-08-30 12:20:08.567696	2023-03-17 15:21:12.919	e9111b39-b267-45a5-bcaf-75b9e7a1f49e.pdf	Chang LIU ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	BCFCT5-146022	50	f	\N	1636583439651909632.pdf	\N	\N	\N	\N
131	29	9	2022-08-12	200000.00	\N	\N	\N	2022-08-12 15:36:04.425016	2023-03-03 17:07:35.292	903f8a08-ac60-46db-85fe-d7600d23c9dc.pdf	Chang Liu ATF Chang Family Trust	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	50	f	2022-08-12	\N	2022-09-25	\N	\N	\N
58	29	2	2022-03-14	100000.00	\N	\N	\N	2022-03-24 12:21:27.329321	2023-03-03 19:43:57.313	1f15937a-9524-4d5d-8c84-edf73f4bd036.pdf	Chang Liu ATF Chang Family Trust	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2022-12-31	\N	\N	\N
24	29	2	2021-12-17	100000.00	\N	\N	\N	2021-12-17 11:29:48.694715	2023-03-03 19:44:02.808	a328ff7e-2fc2-4a4f-9245-f2ca146208dd.pdf	Chang Liu ATF Chang Family Trust	\N	\N	\N	\N	\N	\N	50	t	\N	\N	2022-09-30	\N	\N	\N
219	130	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:51:16.343779	2023-03-14 17:23:14.001	c8633d0b-d89a-4f72-8d19-2c39e18ade2e.pdf	Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust	3 Gianluca Ave 	Keysborough 	VIC 	3173	\N	BCFCT7-146037	73	t	2022-09-12	\N	\N	\N	\N	\N
161	130	14	2022-08-17	100000.00	\N	\N	\N	2022-08-26 08:15:19.641315	2023-03-14 18:06:42.341	36ca4796-6d9e-40dd-abca-ac9ca064555e.pdf	Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust	3 Gianluca Ave 	Keysborough	VIC	3173	\N	BCFCT3-2-146022	73	f	2022-08-17	\N	2023-02-18	\N	\N	\N
149	130	11	2022-08-17	100000.00	\N	\N	\N	2022-08-25 15:24:04.543007	2023-03-14 17:55:31.98	8e9b3483-5dc3-466e-a98d-53c88ba84c0c.pdf	Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust	3 Gianluca Ave 	Keysborough	VIC	3173	\N	BCFCT3-1-146021	73	f	2022-08-17	\N	2023-02-18	\N	\N	\N
879	158	84	2023-07-17	100000.00	\N	\N	\N	2023-07-19 09:48:27.473	2023-07-19 09:50:22.417	8894ed58-6ddd-472a-912f-0ce20a225477.pdf	Shunhua Zheng	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2023-07-17	1681451375440171008.pdf	\N	\N	\N	\N
307	158	31	2022-12-14	100000.00	\N	\N	\N	2022-12-15 07:46:11.279563	2023-03-17 14:40:07.607	6e5a46fb-0f93-43b5-b672-1d1af492dce4.pdf	Shunhua ZHENG	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2022-12-14	1636573099383926784.pdf	\N	\N	\N	\N
308	158	33	2022-12-14	100000.00	\N	\N	\N	2022-12-15 07:48:00.974058	2023-03-17 14:19:39.479	7e2f2edf-3c48-4fb5-a95c-98403a25015d.pdf	Shunhua ZHENG	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2022-12-14	1636567948241743872.pdf	\N	\N	\N	\N
252	158	18	2022-09-20	100000.00	\N	\N	\N	2022-09-21 09:34:41.86265	2023-11-01 16:49:31.017	5a7658c6-8131-4e60-8e2c-142664307f03.pdf	Shunhua ZHENG	37 Driftwood Drive	Glen Waverley	VIC	3150	\N	\N	1	f	2022-09-20	\N	2023-10-17	\N	\N	\N
253	159	18	2022-09-21	500000.00	\N	\N	\N	2022-09-21 13:52:08.989367	2023-11-01 16:49:16.177	84733425-046c-42fc-bdbd-d359bc616134.pdf	Rui PAN ATF The Pan's Trust 	41 Fraser St.	Glen Waverley	VIC	3150	\N	\N	2	f	2022-09-21	\N	2023-10-17	\N	\N	\N
594	190	43	2023-02-19	\N	\N	\N	\N	2023-03-07 14:51:44.366	2023-03-08 11:13:40.581	0f230968-4f90-42d5-b900-a6bd0aad8b7b.pdf	World Tour Australia Pty Ltd	Suite 302, 53 Walker St	North Sydney 	NSW 	2060	\N	\N	84	t	2023-02-19	\N	\N	\N	\N	\N
996	130	44	2023-10-06	90000.00	\N	\N	\N	2023-10-12 11:25:28.328	2024-10-18 16:57:41.644	BCDIOF-Unit_Certificate-(3-2E)-146121[Sunfafa_Investment_Pty_Ltd_ATF_Sunfafa_Family_Trust]20241018.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	f	2023-10-06	\N	2023-10-27	\N	\N	\N
299	169	38	2022-12-09	1000000.00	\N	\N	\N	2022-12-13 14:04:40.694964	2023-03-16 16:14:57.457	17ee571a-9aa6-4503-aa34-61feabca6dfb.pdf	CASA A Pty Ltd ATF CASA 1 Unit Trust 	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2022-12-09	\N	2023-09-30	\N	\N	\N
82	76	2	2022-03-30	100000.00	\N	\N	\N	2022-03-31 06:53:21.655256	2023-03-03 16:54:58.534	9d27f625-ec79-4e78-8405-6f7f644e39b9.pdf	\N	28/38 Wells Street	Southbank	VIC	3006	\N	\N	168	f	2022-03-30	\N	2022-12-12	\N	\N	\N
475	162	39	2023-01-01	200000.00	\N	\N	\N	2023-03-03 18:06:09.236	2023-11-01 14:43:20.3	c5700b08-6bf9-494b-9007-57c1748f72d3.pdf	WZH PTY Ltd	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	29	f	2023-01-01	1636251717907329024.jpg	2023-10-31	\N	\N	\N
266	162	2	2022-10-27	200000.00	\N	\N	\N	2022-11-09 13:12:32.487894	2023-03-14 16:06:30.37	d59d27b3-ffb4-4e9d-9a76-44ad5f7497d4.pdf	WZH Pty Ltd	U 346, 8 LACHLAN STREET	WATERLOO	NSW	2017	\N	\N	29	f	2022-10-27	\N	2023-01-01	\N	\N	\N
590	130	43	2023-02-19	100000.00	\N	\N	\N	2023-03-07 14:11:14.614	2024-08-22 17:40:34.818	BCDIOF-Unit_Certificate-(3-1E)-146121[Sunfafa_Investment_Pty_Ltd_ATF_Sunfafa_Family_Trust]20240822.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	f	2023-02-19	1636538986572623872.pdf	2023-10-05	\N	\N	\N
983	130	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:35:16.133	2024-10-17 16:46:28.234	BCDIOF-Unit_Certificate-(3-1E)-146121[Sunfafa_Investment_Pty_Ltd_ATF_Sunfafa_Family_Trust]20241017.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	f	2023-10-06	\N	2023-10-27	\N	\N	\N
979	190	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:15:21.156	2024-10-17 15:16:55.584	BCDIOF-Unit_Certificate-(3-1E)-146158[World_Tour_Australia_Pty_Ltd]20241017.pdf	\N	Suite 302, 53 Walker St	North Sydney 	NSW 	2060	\N	\N	84	f	2023-10-06	\N	2023-12-06	\N	\N	\N
1043	169	38	2023-10-01	750000.00	\N	\N	\N	2023-11-01 15:06:55.783	2024-01-18 11:10:12.933	fd77927f-c06e-4744-b6f3-62939c63c526.pdf	\N	Suite 801, Level 8, 210 Clarence Street	Sydney	NSW	2000	\N	\N	30	f	2023-10-01	\N	2024-01-17	\N	\N	\N
602	130	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:25:17.296	2024-10-18 16:54:56.399	BCDIOF-Unit_Certificate-(3-2E)-146121[Sunfafa_Investment_Pty_Ltd_ATF_Sunfafa_Family_Trust]20241018.pdf	\N	3 Gianluca Ave	Keysborough	VIC	3173	\N	\N	73	f	2023-02-19	\N	2023-10-05	\N	\N	\N
1011	28	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:46:58.94	2023-11-09 14:21:35.993	9aa77d04-251b-4d5b-a166-59d82b4c22b9.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-10-06	\N	\N	\N	\N	\N
824	28	85	2023-07-05	100000.00	\N	\N	\N	2023-07-06 13:43:33.472	2023-07-07 14:45:51.134	105e2bce-6986-4246-8aba-9f7f1449f0d4.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-07-05	1677177080681598976.pdf	\N	\N	\N	\N
295	28	34	2022-12-12	100000.00	\N	\N	\N	2022-12-13 06:55:54.16918	2023-03-17 12:34:40.718	20bb7988-8488-4b4f-a6af-a3e7c0b12609.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT14-146023	83	f	2022-12-12	1636541529323286528.pdf	\N	\N	\N	\N
571	28	45	2023-03-01	100000.00	\N	\N	\N	2023-03-06 17:20:52.209	2023-03-17 12:13:48.633	a667fd60-5095-45e8-991f-fb2ddd401d00.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT5-146020	83	f	2023-03-01	1636536277698162688.pdf	\N	\N	\N	\N
422	28	37	2022-12-09	500000.00	\N	\N	\N	2023-03-03 15:18:11.228	2023-03-07 17:03:25.647	f96c6c06-e288-408a-9b8c-5402825107f3.pdf	Han Family SMSF Pty Ltd ATF Han Family SMSF	\N	\N	\N	\N	\N	\N	83	t	2022-12-09	\N	2023-12-31	\N	\N	\N
159	28	14	2022-08-17	120000.00	\N	\N	\N	2022-08-26 07:49:55.00454	2023-03-14 18:08:38.865	4cbc85bc-854a-4f32-a0ed-c75882605171.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT3-2-146020	83	f	2022-08-17	\N	2023-02-18	\N	\N	\N
130	28	9	2022-08-12	120000.00	\N	\N	\N	2022-08-12 15:30:54.673275	2023-03-17 10:11:32.637	446629f3-5d06-49fd-86ce-d4a8dc1ccae8.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-08-12	1636505508300795904.pdf	2022-09-25	\N	\N	\N
825	28	84	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:43:44.631	2023-07-07 14:45:09.463	a0823617-6a52-41f1-8493-f10b7fd89a6e.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-07-06	1677176905900756992.pdf	\N	\N	\N	\N
823	28	86	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:34:33.516	2023-07-07 10:20:43.311	d7a10e20-e8c6-4464-8f3a-d5cff31d66ed.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM	VIC	 3191	\N	\N	83	f	2023-07-06	1677110358435958784.pdf	\N	\N	\N	\N
171	28	15	2022-08-30	100000.00	\N	\N	\N	2022-08-30 12:01:04.172085	2023-03-17 15:26:27.96	b4a2c7c8-f315-4e06-a878-15c7ba7777c5.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT5-146020	83	f	\N	1636584761029636096.pdf	\N	\N	\N	\N
316	28	33	2022-12-14	50000.00	\N	\N	\N	2022-12-16 11:25:40.034882	2023-03-17 14:17:39.174	c9521343-7aa0-4d16-9c10-c6366c746d78.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-12-14	1636567443646001152.pdf	\N	\N	\N	\N
317	28	34	2022-12-14	50000.00	\N	\N	\N	2022-12-16 11:26:42.418523	2023-03-17 12:32:42.436	17e994c9-02ec-447f-8a23-0c18c3d5508a.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT14-146023	83	f	2022-12-14	1636541033212620800.pdf	\N	\N	\N	\N
297	28	37	2022-12-09	500000.00	\N	\N	\N	2022-12-13 13:34:05.656602	2023-03-06 15:44:47.338	f10e8894-7a6a-4869-ac93-546c01da6a64.pdf	Han Family SMSF Pty Ltd ATF Han Family SMSF	\N	\N	\N	\N	\N	\N	83	t	\N	\N	2023-12-31	\N	\N	\N
289	28	31	2022-12-08	100000.00	\N	\N	\N	2022-12-12 09:03:01.731772	2023-03-17 14:43:15.156	509833c2-acaf-46f7-8f5d-61f1ea39e0d0.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-12-08	1636573886021447680.pdf	\N	\N	\N	\N
290	28	33	2022-12-12	100000.00	\N	\N	\N	2022-12-12 09:12:01.914345	2023-03-16 15:59:43.08	7a173fba-338b-4cb1-beea-6b0eabb2d22a.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-12-12	\N	\N	\N	\N	\N
226	28	20	2022-09-15	200000.00	\N	\N	\N	2022-09-16 09:37:36.363663	2023-03-14 17:24:01.992	fcaa2541c647c4ede0d9fb38cb65e505.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT7-146046	83	t	\N	\N	\N	\N	\N	\N
194	28	18	2022-09-14	200000.00	\N	\N	\N	2022-09-14 16:15:48.625296	2023-03-16 17:37:56.713	5d66bfc4-87d5-4966-a1ab-243ab9a4cdf1.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-09-14	1636255460992299008.pdf	\N	\N	\N	\N
148	28	11	2022-08-17	80000.00	\N	\N	\N	2022-08-25 15:16:40.371945	2023-03-14 17:55:02.364	c1df3caf-6daa-4ab8-b427-6b65e2ebe1c0.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	BCFCT3-1-146020	83	f	2022-08-17	\N	2023-02-18	\N	\N	\N
123	28	2	2022-08-04	150000.00	\N	\N	\N	2022-08-04 16:18:16.872539	2023-03-17 11:29:43.824	ea7156fd-a671-433d-840c-61c2d11b7485.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	2022-08-04	\N	2022-12-08	\N	\N	\N
29	28	2	2021-12-21	100000.00	\N	\N	\N	2021-12-21 18:48:11.234961	2023-03-03 15:09:12.292	47c83309-cbf7-4bfe-a9be-39367004dff2.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	\N	\N	2022-09-30	\N	\N	\N
80	74	2	2022-03-29	50000.00	\N	\N	\N	2022-03-30 19:06:41.577548	2023-03-03 16:51:51.599	4ac7e6f5-a0a5-4a3f-bfdc-289a4d30b1e2.pdf	\N	\N	\N	\N	\N	\N	\N	169	f	2022-03-29	\N	2022-12-31	\N	\N	\N
423	28	2	2022-10-01	100000.00	\N	\N	\N	2023-03-03 15:19:16.671	2023-03-15 16:55:50.636	a88bb541-ceca-4e72-908c-7b0e856be896.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	\N	\N	2022-12-08	\N	\N	\N
86	28	2	2022-04-05	100000.00	\N	\N	\N	2022-04-05 07:58:48.661839	2023-03-03 15:10:19.551	8a8fbeb0-e646-48e9-bb3d-ddefabd417bf.pdf	Han Family Investment Pty Ltd ATF Han Trust	63 Fernhill Road	SANDRINGHAM 	VIC	3191	\N	\N	83	f	\N	\N	2022-12-08	\N	\N	\N
716	28	72	2023-03-24	100000.00	\N	\N	\N	2023-03-24 11:54:03.949	2024-10-18 10:14:07.71	BCDIOF-Unit_Certificate-(36-A)-146034[Han_Family_Investment_Pty_Ltd_ATF_Han_Trust]20241018.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-03-24	\N	2023-10-05	\N	\N	\N
899	190	75	2023-04-20	100000.00	\N	\N	\N	2023-08-01 15:44:52.198	2024-02-02 11:20:55.894	77ed3b50-3db0-4ca5-8094-d6f7bd1cf0cf.pdf	\N	Suite 302, 53 Walker St	North Sydney 	NSW 	2060	\N	\N	84	f	2023-04-20	\N	2024-01-18	\N	\N	\N
665	28	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:04:49.917	2024-03-18 16:04:45.354	532421e5-548e-4558-9f85-06f4ab2cd200.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-03-14	\N	2024-03-11	\N	\N	\N
521	28	43	2023-02-19	80000.00	\N	\N	\N	2023-03-06 15:57:23.692	2024-08-22 17:29:10.049	BCDIOF-Unit_Certificate-(3-1E)-146034[Han_Family_Investment_Pty_Ltd_ATF_Han_Trust]20240822.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-02-19	1636539234044948480.pdf	2023-10-05	\N	\N	\N
596	190	43	2023-02-19	100000.00	\N	\N	\N	2023-03-07 14:53:05.625	2024-10-17 15:11:58.531	BCDIOF-Unit_Certificate-(3-1E)-146158[World_Tour_Australia_Pty_Ltd]20241017.pdf	\N	Suite 302, 53 Walker St	North Sydney 	NSW 	2060	\N	\N	84	f	2023-02-19	\N	2023-10-05	\N	\N	\N
986	28	43	2023-10-06	72000.00	\N	\N	\N	2023-10-11 16:37:50.358	2024-10-17 16:13:57.216	BCDIOF-Unit_Certificate-(3-1E)-146034[Han_Family_Investment_Pty_Ltd_ATF_Han_Trust]20241017.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-10-06	\N	2023-10-27	\N	\N	\N
522	28	44	2023-02-19	120000.00	\N	\N	\N	2023-03-06 15:58:23.709	2024-10-18 16:51:02.143	BCDIOF-Unit_Certificate-(3-2E)-146034[Han_Family_Investment_Pty_Ltd_ATF_Han_Trust]20241018.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-02-19	\N	2023-10-05	\N	\N	\N
999	28	44	2023-10-06	108000.00	\N	\N	\N	2023-10-12 11:28:49.855	2024-10-18 16:51:14.198	BCDIOF-Unit_Certificate-(3-2E)-146034[Han_Family_Investment_Pty_Ltd_ATF_Han_Trust]20241018.pdf	\N	63 Fernhill Road	SANDRINGHAM	VIC	3191	\N	\N	83	f	2023-10-06	\N	2023-10-27	\N	\N	\N
904	192	37	2023-07-03	1000000.00	\N	\N	\N	2023-08-02 15:22:43.942	2023-08-02 15:24:36.547	a1421f5e-dc60-46a8-9673-3e3650d97b27.pdf	Lindatest	\N	\N	\N	\N	\N	\N	86	t	2023-07-03	\N	\N	\N	\N	\N
703	201	69	2023-03-15	100000.00	\N	\N	\N	2023-03-15 17:05:23.184	2023-03-17 12:10:09.402	8b81bf89-fc3e-44f9-b989-49348d0acc80.pdf	Wenhui WU	2 Woods St	Balwyn	VIC	3103	\N	BCFCT26A-146039	129	f	2023-03-15	\N	\N	\N	\N	\N
1052	133	104	2023-11-03	100000.00	\N	\N	\N	2023-11-03 11:47:12.068	2023-11-03 11:47:12.068	6f3b8316-ee91-46ab-9edd-ba0c4434a346.pdf	Chen246 Pty Ltd ATF Chen246 Superannuation Fund	6 Casuarina Court 	Capalaba 	QLD 	4157	\N	\N	78	f	2023-11-03	1720241178171052032.pdf	\N	\N	\N	\N
843	133	84	2023-07-10	100000.00	\N	\N	\N	2023-07-11 15:05:10.93	2023-11-03 11:45:49.15	4cf80850-8964-4a10-8b73-3817e95a85a0.pdf	Chen246 Pty Ltd ATF Chen246 Superannuation Fund	6 Casuarina Court 	Capalaba 	QLD 	4157	\N	\N	78	f	2023-07-10	1678631496681000960.pdf	\N	\N	\N	\N
176	133	11	2022-08-17	100000.00	\N	\N	\N	2022-08-31 10:19:07.258571	2023-03-16 17:46:59.288	e44ba3fc-f222-4f31-ab7e-6533a9e1135e.pdf	Chen246 Pty Ltd ATF Chen246 Superannuation Fund	6 Casuarina Court	Capalaba	QLD	4157	\N	\N	78	f	2022-08-17	1636257736716791808.pdf	2023-02-18	\N	\N	\N
690	193	69	2023-03-15	100000.00	\N	\N	\N	2023-03-15 10:12:39.764	2023-03-15 12:21:52.782	87967cc8-1546-4982-a6f7-cf8c4a35550d.pdf	\N	\N	\N	\N	\N	\N	\N	87	t	2023-03-15	\N	\N	\N	\N	\N
692	193	41	2023-03-14	100000.00	\N	\N	\N	2023-03-15 10:16:45.284	2023-03-15 12:21:46.497	6827a623-4934-4f40-adb5-ede0f0cfaa00.pdf	\N	\N	\N	\N	\N	\N	\N	87	t	2023-03-14	\N	\N	\N	\N	\N
691	193	70	2023-03-15	100000.00	\N	\N	\N	2023-03-15 10:12:55.745	2023-03-15 12:21:50.124	dcd69f83-0922-4fbc-b820-9a5199cf0ed7.pdf	\N	\N	\N	\N	\N	\N	\N	87	t	2023-03-15	\N	\N	\N	\N	\N
689	200	69	2023-03-15	100000.00	\N	\N	\N	2023-03-15 10:11:55.734	2023-03-15 15:23:59.994	574824a6-d227-4fc3-b9cf-1c26074c7345.pdf	Ling SONG	94 Sanctuary Lakes South Blvd	Point Cook	VIC	3030	\N	BCFCT26A-146035	128	f	2023-03-15	\N	\N	\N	\N	\N
970	195	102	2023-10-06	20.00	\N	\N	\N	2023-10-09 21:24:37.866	2023-10-09 21:26:28.035	0392206d-b642-44a0-8339-68f79f579b92.pdf	asd	asd	asd	asd	2000	\N	asd	91	t	2023-10-06	\N	2023-10-06	\N	\N	\N
679	195	41	2023-02-28	\N	\N	\N	\N	2023-03-14 17:37:38.858	2023-03-14 18:34:33.957	bd2368d0-86f1-4431-9b80-4712e57eec33.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-08	\N	\N	\N	\N	\N
636	195	37	2023-02-01	50000.00	\N	\N	\N	2023-03-10 15:17:54.676	2023-03-13 11:29:07.106	c2a6a0c8-1064-445a-b31c-132953ee2fb6.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-02-01	\N	2023-02-01	\N	\N	\N
631	195	49	2022-12-01	1000000.00	\N	\N	\N	2023-03-10 15:11:18.919	2023-03-10 16:10:49.043	68995bc9-bb29-40ad-b077-05ebd8aec67b.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-01-01	\N	\N	\N	\N	\N
969	195	102	\N	20.00	\N	\N	\N	2023-10-09 18:09:08.937	2023-10-09 18:43:12.458	2fdbb47e-c288-4832-ab1c-54ff76ac3ae2.pdf	dsa	fa	fdsa	dsa	fdsa	\N	fda	91	t	2023-10-06	\N	\N	\N	\N	\N
685	195	45	2023-03-01	\N	\N	\N	\N	2023-03-14 17:38:58.119	2023-03-14 17:43:54.798	60a0a4c6-e58f-4bd0-b539-b849a9c9f24a.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-01	\N	\N	\N	\N	\N
680	195	69	2023-03-14	1000000.00	\N	\N	\N	2023-03-14 17:37:57.617	2023-03-24 14:25:36.695	b19c0703-6fcb-470f-a3d9-8eb99241f8c0.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-14	1635856998823964672.pdf	\N	\N	\N	\N
682	195	45	2023-03-08	\N	\N	\N	\N	2023-03-14 17:38:23.543	2023-03-15 12:25:21.349	869d8dd5-1e5a-48b0-b807-349d865ef00a.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-08	\N	\N	\N	\N	\N
681	195	44	2023-03-08	\N	\N	\N	\N	2023-03-14 17:38:07.519	2023-03-15 12:25:18.877	26bdcba0-2cbe-4ac1-aa36-74969d825287.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-09	\N	\N	\N	\N	\N
896	195	37	2023-01-01	500000.00	\N	\N	\N	2023-07-25 17:29:48.217	2023-08-03 16:57:13.553	1ab70477-e520-4523-8a4c-d3e1db74e24c.pdf	Testingtesting	\N	\N	\N	\N	\N	\N	91	t	2023-01-01	\N	\N	\N	\N	\N
683	195	69	2023-03-01	10000.00	\N	\N	\N	2023-03-14 17:38:37.476	2023-03-24 14:25:23.012	f11c5a3c-2dfb-4439-b419-8848340b624e.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-01	1635833218915368960.pdf	\N	\N	\N	\N
895	195	79	\N	\N	\N	\N	\N	2023-07-25 17:27:16.942	2023-07-25 17:28:06.89	271a1e0c-c356-4b91-9288-4cccd6bbd6c5.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	\N	\N	\N	\N	\N	\N
643	195	58	2023-03-01	\N	\N	\N	\N	2023-03-10 16:38:29.574	2023-03-10 16:38:33.351	e004431f-24f1-4b17-99e3-b84c5955a6ee.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	\N	\N	2023-03-01	\N	\N	\N
614	195	55	2022-09-26	1000000.00	\N	\N	\N	2023-03-08 12:25:21.851	2023-03-10 16:11:07.794	5ce85ed0-edf7-4426-a613-72e4f8bbd797.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2022-09-26	\N	\N	\N	\N	\N
646	195	40	2023-03-01	500000.00	\N	\N	\N	2023-03-10 16:41:20.306	2023-03-10 16:41:24.545	917ea3ec-9d7b-4d2c-a3a2-e80fa9998516.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	\N	\N	2023-03-01	\N	\N	\N
647	195	2	2023-03-01	1000000.00	\N	\N	\N	2023-03-10 16:42:21.515	2023-03-10 16:42:33.844	81defd60-73eb-41a4-9645-163d4b3c2013.pdf	\N	\N	\N	\N	\N	\N	\N	91	t	2023-03-01	\N	\N	\N	\N	\N
1038	14	38	2023-10-01	250000.00	\N	\N	\N	2023-11-01 15:00:46.557	2023-11-01 15:00:46.557	835dd1c0-c14d-4551-b6b5-f3fbd8b240ac.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	2023-10-01	\N	2024-07-31	\N	\N	\N
32	14	2	2022-10-01	100000.00	\N	\N	\N	2022-01-02 11:46:06.423648	2023-03-17 12:01:53.047	30cc5308-411f-4fde-a33a-059743caee42.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	\N	\N	2022-12-21	\N	\N	\N
481	181	2	2022-09-23	1700000.00	\N	\N	\N	2023-03-03 18:54:53.663	2023-03-15 15:38:50.411	086a4a5f-9d61-4e4e-9a7c-f95f5199dc08.pdf	Auriga International Group Pty Ltd	UNIT 1507 , 68 ELIZABETH STREET	ADELAIDE	SA 	5000	\N	\N	48	f	2022-09-23	\N	2023-02-28	\N	\N	\N
484	184	2	2023-02-17	50000.00	\N	\N	\N	2023-03-03 19:13:16.179	2023-12-01 16:45:29.878	320b0384-7d8a-440f-9e14-2269d50ccc6e.pdf	\N	2/385 Blackburn Rd	Mount Waverley	VIC	3149	\N	\N	125	f	2023-02-17	\N	2023-11-30	\N	\N	\N
609	193	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:31:06.765	2024-10-18 16:47:50.116	BCDIOF-Unit_Certificate-(3-2E)-146155[Yaoqin_Wu_]20241018.pdf	\N	16 Joly Parade	Hunters Hill	NSW	2110	\N	\N	87	f	2023-02-19	\N	2023-10-05	\N	\N	\N
608	192	44	2023-02-19	50000.00	\N	\N	\N	2023-03-07 15:30:29.714	2024-10-18 16:59:59.061	BCDIOF-Unit_Certificate-(3-2E)-146154[Yi-Han_TENG]20241018.pdf	\N	22 Loftus Street	Ashfield	NSW 	2131	\N	\N	86	f	2023-02-19	\N	2023-10-05	\N	\N	\N
994	14	44	2023-10-06	45000.00	\N	\N	\N	2023-10-12 11:22:32.391	2024-10-18 16:59:01.707	BCDIOF-Unit_Certificate-(3-2E)-146022[Prosperity_2020_PL_ATF_Genesis_Family_Trust]20241018.pdf	\N	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	2023-10-06	\N	2023-10-27	\N	\N	\N
766	203	75	2023-05-10	100000.00	\N	\N	\N	2023-05-15 11:21:08.379	2024-02-02 11:23:00.089	7d8d6a62-801d-4422-8b10-ceb19dbeff0e.pdf	\N	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	\N	107	f	2023-05-10	\N	2024-01-18	\N	\N	\N
659	133	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 16:59:10.901	2024-06-24 16:43:04.893	5732501d-c8bb-48ba-913c-05af86167045.pdf	\N	6 Casuarina Court 	Capalaba 	QLD 	4157	\N	\N	78	f	2023-03-15	\N	\N	\N	\N	\N
306	133	34	2022-12-14	100000.00	\N	\N	\N	2022-12-15 07:41:43.712953	2024-06-24 17:00:17.816	90e8d659-e04e-4b16-a730-de6a7576301e.pdf	\N	6 Casuarina Court 	Capalaba 	QLD 	4157	\N	\N	78	f	2022-12-14	1636541307322970112.pdf	2023-06-23	\N	\N	\N
926	203	99	2023-09-01	100000.00	\N	\N	\N	2023-09-01 16:45:13.125	2024-09-24 11:13:27.809	3af1c1d1-e2de-4473-9fec-64a89d9cf936.pdf	Worldlink Group Pty Ltd	U32 19-21 Milner Road 	Artarmon 	NSW 	2064	\N	\N	107	t	2023-09-01	1697500840722743296.pdf	\N	\N	\N	\N
597	191	43	2023-02-19	100000.00	\N	\N	\N	2023-03-07 14:55:31.943	2024-10-17 16:03:27.416	BCDIOF-Unit_Certificate-(3-1E)-146157[Haibin_XI]20241017.pdf	\N	2B Wandella Ave	Roseville 	NSW 	2069	\N	\N	85	f	2023-02-19	1636538424024182784.pdf	2023-10-05	\N	\N	\N
978	191	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:13:53.262	2024-10-17 16:03:40.655	BCDIOF-Unit_Certificate-(3-1E)-146157[Haibin_XI]20241017.pdf	\N	2B Wandella Ave	Roseville 	NSW 	2069	\N	\N	85	f	2023-10-06	\N	2023-12-06	\N	\N	\N
991	193	44	2023-10-06	90000.00	\N	\N	\N	2023-10-12 11:13:59.066	2024-10-18 16:48:02.174	BCDIOF-Unit_Certificate-(3-2E)-146155[Yaoqin_Wu_]20241018.pdf	\N	16 Joly Parade	Hunters Hill	NSW	2110	\N	\N	87	f	2023-10-06	\N	2023-12-06	\N	\N	\N
992	192	44	2023-10-06	45000.00	\N	\N	\N	2023-10-12 11:15:05.462	2024-10-18 17:00:10.913	BCDIOF-Unit_Certificate-(3-2E)-146154[Yi-Han_TENG]20241018.pdf	\N	22 Loftus Street	Ashfield	NSW 	2131	\N	\N	86	f	2023-10-06	\N	2023-10-27	\N	\N	\N
167	14	14	2022-08-17	50000.00	\N	\N	\N	2022-08-26 08:29:20.081097	2023-03-14 18:13:08.584	1a849c74-511e-4d58-ba4c-d6fb532718b7.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	BCFCT3-2-146028	42	f	2022-08-17	\N	2023-02-18	\N	\N	\N
757	224	76	2023-05-08	100000.00	\N	\N	\N	2023-05-09 15:55:53.897	2023-08-01 17:28:04.298	2cf0e1e0-3720-4cb1-934f-5ac8c134d6fa.pdf	Siqing WANG	4 Hornbuckle CT.	Ferntree Gully	VIC\t	3156	\N	\N	131	f	2023-05-08	1655816262153146368.pdf	\N	\N	\N	\N
1008	208	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:44:06.574	2023-11-09 14:22:08.011	988eb760-52bd-443a-b270-c05fcb6a769f.pdf	Hiu Hung WONG	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2023-10-06	\N	\N	\N	\N	\N
721	208	72	2023-03-24	100000.00	\N	\N	\N	2023-03-24 15:17:49.326	2023-10-12 11:44:12.436	a0cf0f0e-bc90-48a2-a073-206023c81967.pdf	Hiu Hung WONG	1201/339 Sussex St	Sydney 	NSW 	2000	\N	BCFCT36A-146026	127	f	2023-03-24	\N	2023-10-06	\N	\N	\N
800	211	69	2023-06-22	50000.00	\N	\N	\N	2023-06-22 16:23:54.454	2023-06-22 16:23:54.454	31a57735-e441-468f-93c5-e9bb30efd2bf.pdf	Lihua Jiang	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2023-06-22	\N	\N	\N	\N	\N
728	211	69	2023-04-04	100000.00	\N	\N	\N	2023-04-05 10:28:06.123	2023-11-01 16:57:59.25	f80f9b91-0f53-4995-ab3f-e8bca3e8c205.pdf	Lihua Jiang	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2023-04-04	\N	2023-06-22	\N	\N	\N
747	211	69	2023-05-08	60000.00	\N	\N	\N	2023-05-08 16:20:51.948	2023-11-01 16:57:30.234	94eba7f4-cead-462f-9f87-62d1d22fdcb8.pdf	Lihua Jiang	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2023-05-08	\N	2023-06-22	\N	\N	\N
767	225	74	2023-05-15	3300000.00	\N	\N	\N	2023-05-15 11:33:21.373	2023-05-15 11:33:21.373	ad8e1cd5-8686-495f-a205-3ac296402d02.pdf	Yinghong XING	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng District 	Hangzhou	310006	\N	\N	108	f	2023-05-15	1657922080600231936.pdf	\N	\N	\N	\N
888	225	90	2023-07-21	1930390.49	\N	\N	\N	2023-07-21 15:37:33.674	2023-07-21 15:40:36.797	ce1bb740-4816-44ff-83e5-541290194604.pdf	Yinghong XING	Room 403, Unit 3, 22 Zhijietansi Ave	Xiacheng District 	Hangzhou	310006	\N	\N	108	f	2023-07-21	1682263754612723712.jpg	\N	\N	\N	\N
886	225	89	\N	\N	\N	\N	\N	2023-07-21 15:35:07.614	2023-07-21 15:36:55.968	66f3c3e5-e8b1-4917-80d2-fc50944f9509.pdf	\N	\N	\N	\N	\N	\N	\N	108	t	\N	\N	\N	\N	\N	\N
811	232	86	2023-07-06	200000.00	\N	\N	\N	2023-07-06 12:29:51.242	2023-07-07 21:04:02.643	405baddd-5756-4c10-b61c-439b12a4aba6.pdf	Changxing LIU	5 Palm Beach Dr 	Patterson Lakes	VIC	3197	\N	\N	132	f	2023-07-06	\N	\N	\N	\N	\N
1065	234	104	2023-11-06	200000.00	\N	\N	\N	2023-11-08 10:17:48.486	2023-11-08 10:17:48.486	5d8f779c-f14e-45e9-bca3-89cf59b4cf9f.pdf	YELLOW RIBBON CLH AUSTRALIA PTY LTD	31 Kirribilli Ave 	Keysborough 	VIC 	3173	\N	\N	115	f	2023-11-06	1722030621003960320.pdf	\N	\N	\N	\N
844	234	84	2023-07-10	100000.00	\N	\N	\N	2023-07-11 15:36:40.359	2023-11-07 11:34:29.385	3445d999-326a-4088-8cd1-e8dcd782774f.pdf	YELLOW RIBBON CLH AUSTRALIA PTY LTD	31 Kirribilli Ave 	Keysborough 	VIC 	3173	\N	\N	115	f	2023-07-10	1678639421520613376.pdf	\N	\N	\N	\N
708	207	69	2023-03-15	100000.00	\N	\N	\N	2023-03-20 17:09:46.058	2023-03-20 17:27:45.857	cdea04d0-0236-44a3-b7fb-41cc2c28ce81.pdf	Min LIANG	10 Boston Road	Balwyn	VIC	3103	\N	BCFCT26A-146040	92	f	2023-03-15	\N	\N	\N	\N	\N
880	207	85	2023-07-18	100000.00	\N	\N	\N	2023-07-19 10:31:39	2023-07-19 10:31:39	f974144d-cb1a-4a60-b842-3ce73dd2ee69.pdf	Min LIANG	10 Boston Road	Balwyn	VIC	3103	\N	\N	92	f	2023-07-18	1681461762982154240.pdf	\N	\N	\N	\N
710	207	69	2023-03-15	100000.00	\N	\N	\N	2023-03-21 11:41:10.803	2023-03-22 15:52:17.484	bb2206a3-382c-4169-a23d-e32323131656.pdf	Min Liang	10 Boston Road	Balwyn 	VIC 	3103	\N	BCFCT26A-146040	92	t	2023-03-15	\N	\N	\N	\N	\N
1007	210	72	2023-10-06	800000.00	\N	\N	\N	2023-10-12 11:43:15.1	2023-11-09 14:22:20.203	f926a759-ea92-4d06-b148-55c1183fad50.pdf	TX International Pty Ltd	3 Dalwood Pl	Carlingford	NSW	2118	\N	\N	99	f	2023-10-06	\N	\N	\N	\N	\N
758	222	75	2023-05-02	100000.00	\N	\N	\N	2023-05-09 16:26:29.907	2023-05-15 10:25:09.214	4bb8cc41-be33-4ff2-badf-5e6406de2642.pdf	Lihua TU	62A FITZWILLIAM ST	KEW	VIC	3101	\N	BCFCT35B-146171	104	t	2023-05-02	\N	\N	\N	\N	\N
1001	220	72	2023-10-06	40000.00	\N	\N	\N	2023-10-12 11:33:36.879	2023-11-09 14:23:38.294	038cf067-adee-41ef-9453-b0e5323830b6.pdf	Qidi WU	58 Shaftesbury Rd	Burwood	NSW	2134	\N	\N	130	f	2023-10-06	\N	\N	\N	\N	\N
729	212	69	2023-04-05	100000.00	\N	\N	\N	2023-04-05 11:29:30.552	2023-04-05 11:29:30.552	ba171e5b-fd80-402e-b492-00ed75910d3d.pdf	Rex Investment Consultants Limited	17 Davington Way	Burswood	Auckland, New Zealand	2013	\N	\N	101	f	2023-04-05	\N	\N	\N	\N	\N
402	14	2	2022-01-04	20000.00	\N	\N	\N	2023-03-03 14:06:24.991	2023-03-14 15:33:20.882	ec07d271-00d7-4367-9bf3-db76656c2f04.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	\N	\N	2022-10-31	\N	\N	\N
16	14	2	2021-12-24	100000.00	\N	\N	\N	2021-11-01 13:43:06.950957	2023-03-14 17:38:10.12	a4e170f9-0fbd-4f5f-8a33-69e1a49f37cf.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	\N	\N	2022-09-30	\N	\N	\N
720	208	37	2023-03-01	500000.00	\N	\N	\N	2023-03-24 15:15:24.621	2023-03-24 15:15:24.621	5ac6d9a3-4db7-4246-be76-969e48290ad4.pdf	Hiu Hung WONG	1201/339 Sussex St	Sydney 	NSW 	2000	\N	\N	127	f	2023-03-01	\N	2024-03-31	\N	\N	\N
771	227	2	2023-05-26	100000.00	\N	\N	\N	2023-05-29 10:04:16.785	2023-05-29 10:07:55.76	b1b63173-0c10-48c2-8205-62badf9c7d30.pdf	ZHOUS' CAPITAL Pty Ltd ATF ZHOUS' CAPITAL Superannuation Fund	90 Commodore Drive	Surfers Paradise	QLD	4217	\N	\N	110	f	2023-05-26	1662974012335329280.pdf	2024-02-29	\N	\N	\N
727	210	72	2023-04-04	1000000.00	\N	\N	\N	2023-04-05 09:44:27.548	2024-10-18 10:21:00.067	BCDIOF-Unit_Certificate-(36-A)-146166[TX_International_Pty_Ltd]20241018.pdf	\N	3 Dalwood Pl	Carlingford	NSW	2118	\N	\N	99	f	2023-04-04	\N	2023-10-05	\N	\N	\N
939	221	38	2023-10-01	250000.00	\N	\N	\N	2023-10-03 12:27:01.699	2023-10-03 12:27:01.699	d9b7be2c-964c-4c81-8d4e-6fba66e7c114.pdf	Yutong ZHANG	5 SHIELDS CT	BLACKBURN SOUTH	VIC	3130 	\N	\N	103	f	2023-10-01	1709017177175646208.pdf	2024-07-31	\N	\N	\N
17	18	2	2022-10-01	200000.00	\N	\N	\N	2021-11-05 13:03:23.862304	2023-03-14 17:38:31.286	614b4f49-50e8-4569-a452-1dc02713959f.pdf	Hung Fung TONG	Unit 302, 80 Alfred St.	Milsons Point	NSW	2061	\N	\N	156	f	\N	\N	2022-12-15	\N	\N	\N
401	14	2	2022-12-21	130000.00	\N	\N	\N	2023-03-03 14:00:25.573	2023-03-14 15:33:41.303	00b96eb3-a386-4fa7-86e6-0e8ad3e33ddd.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	\N	\N	2022-12-21	\N	\N	\N
400	14	2	2021-11-01	50000.00	\N	\N	\N	2023-03-03 13:59:01.421	2023-03-14 15:34:02.62	9712345a-2d97-428e-8c0f-ec39a38a0333.pdf	Prosperity 2020 PL ATF Genesis Family Trust	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	\N	\N	2022-08-31	\N	\N	\N
741	222	75	2023-05-02	100000.00	\N	\N	\N	2023-05-04 14:19:11.412	2024-02-02 11:21:50.303	1c9f8c79-57b7-4e25-87b9-f9d83bab1164.pdf	\N	62A FITZWILLIAM ST	KEW	VIC	3101	\N	\N	104	f	2023-05-02	1653977742707003392.pdf	2024-01-18	\N	\N	\N
739	220	73	2023-04-25	50000.00	\N	\N	\N	2023-04-26 10:27:31.614	2024-02-02 11:32:43.097	4e14dcf9-9ef4-41f7-b7dc-4fe2ffcb21cc.pdf	\N	58 Shaftesbury Rd	Burwood	NSW	2134	\N	\N	130	f	2023-04-25	1651020144659664896.pdf	2024-01-18	\N	\N	\N
770	226	39	2023-05-24	150000.00	\N	\N	\N	2023-05-25 11:46:51.242	2024-03-01 15:28:36.669	ab13a93f-5ca4-4efe-a0cf-8a2aadb7e0e0.pdf	\N	802/88 Alfred St. S	Milsons Point	NSW 	2061	\N	\N	109	f	2023-05-24	\N	2024-02-21	\N	\N	\N
738	220	72	2023-04-25	50000.00	\N	\N	\N	2023-04-26 10:26:41.016	2024-10-18 10:29:49.52	BCDIOF-Unit_Certificate-(36-A)-146169[Qidi_WU]20241018.pdf	\N	58 Shaftesbury Rd	Burwood	NSW	2134	\N	\N	130	f	2023-04-25	1651019932440465408.pdf	2023-10-05	\N	\N	\N
606	14	44	2023-02-19	50000.00	\N	\N	\N	2023-03-07 15:28:34.49	2024-10-18 16:58:50.375	BCDIOF-Unit_Certificate-(3-2E)-146022[Prosperity_2020_PL_ATF_Genesis_Family_Trust]20241018.pdf	\N	16 Justine Ave.	Baulkham Hills	NSW	2153	\N	\N	42	f	2023-02-19	\N	2023-10-05	\N	\N	\N
846	235	84	2023-07-10	200000.00	\N	\N	\N	2023-07-11 16:51:17.135	2023-07-11 16:51:17.135	93627e32-acd2-44e4-8947-157457b207e1.pdf	Xianfeng HUANG	55 Gordon St	Balwyn 	VIC 	3103	\N	\N	116	f	2023-07-10	1678658198480097280.pdf	\N	\N	\N	\N
760	223	75	2023-05-05	100000.00	\N	\N	\N	2023-05-09 16:44:01.902	2023-05-15 10:33:58.142	613df53a-e6fd-4939-a94b-6ab782114f81.pdf	AG Santorini Pty Ltd	SUITE 404 16 SHORELINE DRIVE 	RHODES	NSW	2138	\N	BCFCT35B-146172	106	t	2023-05-05	\N	\N	\N	\N	\N
853	237	89	2023-07-11	100000.00	\N	\N	\N	2023-07-13 15:34:40.496	2023-10-04 12:27:58.679	ddf6d9d1-ca55-4fc4-a3b9-b06f7e006e85.pdf	Fengye Wang	58 Shaftesbury Road	Burwood 	NSW	2134	\N	\N	118	f	2023-07-11	1709379804032688128.pdf	\N	\N	\N	\N
940	237	100	2023-09-06	153300.00	\N	\N	\N	2023-10-04 12:26:43.844	2023-10-04 13:44:44.203	ef91d2f2-77bb-4e46-b986-5e98f42ed7d7.pdf	Fengye Wang	58 Shaftesbury Road	Burwood 	NSW	2134	\N	\N	118	f	2023-09-06	1709379785149931520.pdf	\N	\N	\N	\N
857	242	84	2023-07-07	100000.00	\N	\N	\N	2023-07-14 15:10:16.578	2023-07-14 15:10:52.222	2aa95ed1-97ad-4bde-880a-0c7515db69e6.pdf	Xiumei WU	108 Cityview Road	Balwyn North	VIC	3104	\N	\N	123	f	2023-07-07	1679720091760201728.pdf	\N	\N	\N	\N
663	186	70	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:03:50.516	2023-03-14 17:11:32.93	bbccb116-e86f-45a8-b6a7-ad90dd373be4.pdf	Jianxin HUANG	11/77 Warrane Rd	North Willoughby  	NSW 	2068	\N	BCFCT26B-146020	126	f	2023-03-14	\N	\N	\N	\N	\N
578	186	44	2023-02-19	100000.00	\N	\N	\N	2023-03-06 17:26:43.744	2023-03-06 17:26:47.626	bea9ee01-de64-4006-95c3-2ca8e5119f02.pdf	test	\N	\N	\N	\N	\N	\N	126	t	2023-02-19	\N	\N	\N	\N	\N
672	186	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:22:50.07	2023-03-14 17:22:50.07	c6b8f817-dd8b-41e0-94f8-ca7d860be5df.pdf	Jianxin Huang	11/77 Warrane Rd	North Willoughby  	NSW 	2068	\N	BCFCT26A-146021	126	f	2023-03-14	\N	\N	\N	\N	\N
854	239	89	2023-07-11	150000.00	\N	\N	\N	2023-07-13 15:42:06.614	2023-07-13 15:42:06.614	efe0027f-505c-4e85-93c6-74f1f7372cc2.pdf	David Anthony BERRY and Joyce Ann BERRY	155 Bradley Street	Glenmore Park	NSW 	2745	\N	\N	120	f	2023-07-11	1679365565664464896.pdf	\N	\N	\N	\N
839	233	84	2023-07-04	100000.00	\N	\N	\N	2023-07-09 21:38:18.944	2023-07-09 21:38:18.944	5801c699-3220-4c2b-816e-7b1b38a7a286.pdf	Tina Ywen Pty Ltd ATF Tinaewen Superannuation Fund	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2023-07-04	1678005656251273216.pdf	\N	\N	\N	\N
838	233	86	2023-07-05	150000.00	\N	\N	\N	2023-07-07 10:11:51.192	2023-07-07 10:11:51.192	35b4abd2-740b-4c0e-9cf5-29a8ca9250f0.pdf	Tina Ywen Pty Ltd ATF Tinaewen Superannuation Fund	898 Burke Rd	Canterbury	VIC	3126	\N	\N	114	f	2023-07-05	1677108126567108608.pdf	\N	\N	\N	\N
848	236	84	2023-07-11	200000.00	\N	\N	\N	2023-07-12 09:42:11.821	2023-07-12 09:44:14.656	660b5815-1fd4-4bdd-99dd-e3e5591aaa26.pdf	XIANG LIANG	3 GILMORE RD	DONCASTER\t	VIC\t	3108	\N	\N	117	f	2023-07-11	1678913117879537664.pdf	\N	\N	\N	\N
813	147	84	2023-07-06	100000.00	\N	\N	\N	2023-07-06 12:42:09.065	2023-07-07 14:47:44.359	b5b38bf9-fb17-444c-916a-1aebb86b483b.pdf	AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust	11 Inglis Ct	Glen Waverley	VIC	3150	\N	\N	81	f	2023-07-06	1677177555581669376.pdf	\N	\N	\N	\N
230	147	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:44:18.140197	2023-03-14 17:24:13.003	77bc782e3ac568bd96bfeafe45c6b9c1.pdf	AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust	11 Inglis Ct.	Glen Waverley 	VIC 	3150	\N	BCFCT7-146050	81	t	\N	\N	\N	\N	\N	\N
855	240	83	2023-07-11	100000.00	\N	\N	\N	2023-07-14 11:39:28.408	2023-07-14 11:39:28.408	ebf3802f-b25f-45c2-a1f4-d828df36ca12.pdf	Jing YUAN	17 Mulvihill Cres 	Denham Court 	NSW 	2565	\N	\N	121	f	2023-07-11	1679666891988406272.pdf	\N	\N	\N	\N
852	238	84	2023-07-11	100000.00	\N	\N	\N	2023-07-13 12:24:51.651	2023-07-13 12:24:51.651	9a2f3abc-699d-4df5-b32d-df807a8675b9.pdf	MINGMING INVESTMENT PTY LTD ATF MINGMING FAMILY TRUST	u1/28 Danien St 	Glen Waverley 	VIC 	3150	\N	\N	119	f	2023-07-11	1679315926236008448.pdf	\N	\N	\N	\N
41	41	2	2021-12-17	500000.00	\N	\N		2022-01-18 11:52:18.001503	2023-03-03 15:35:23.829	\N	\N	\N	\N	\N	\N	\N	\N	150	t	\N	\N	\N	\N	\N	\N
39	40	2	2021-12-17	500000.00	\N	\N		2022-01-18 08:18:31.497471	2023-03-03 15:35:17.287	24a46d17328785cbe83264d6d5328437.pdf						\N	\N	153	t	\N	\N	\N	\N	\N	\N
933	209	37	2023-09-13	500000.00	\N	\N	\N	2023-09-12 14:12:27.642	2023-09-14 10:01:34.937	23d44e32-477a-46fe-b0b6-f84f54ad50e1.pdf	ANTHONY DONATO HOLDINGS PTY LTD ATF ANTHONY DONATO FAMILY TRUST	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2023-09-13	1702110304532742144.pdf	2024-09-30	\N	\N	\N
906	209	38	2023-06-29	250000.00	\N	\N	\N	2023-08-02 16:41:17.642	2023-09-14 09:57:24.212	e3bc2084-979f-40e6-a783-3be3a4b64ac1.pdf	ANTHONY DONATO HOLDINGS PTY LTD ATF ANTHONY DONATO FAMILY TRUST	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2023-06-29	1686628217067458560.pdf	2024-03-31	\N	\N	\N
777	228	2	2023-06-07	50000.00	\N	\N	\N	2023-06-08 11:34:24.782	2023-06-08 11:34:24.782	c446c755-63e8-4ee4-96d0-4df35dcd8e59.pdf	Qiao ZHANG	36A Birkinshaw Ave.\t	Tranmere \t	SA \t	5073	\N	\N	111	f	2023-06-07	1666619655411007488.pdf	2024-03-31	\N	\N	\N
921	235	39	2023-08-24	150000.00	\N	\N	\N	2023-08-24 16:34:41.941	2023-08-24 16:42:29.204	1d34eeb1-c765-43c3-bd13-0bc33687075e.pdf	Xianfeng HUANG	55 Gordon St	Balwyn 	VIC 	3103	\N	\N	116	f	2023-08-24	1694599090420436992.pdf	2024-05-31	\N	\N	\N
778	229	38	2023-06-12	250000.00	\N	\N	\N	2023-06-13 15:14:49.186	2024-03-01 15:38:17.582	cf928139-93aa-49cb-b47f-723258a9a306.pdf	\N	1/221 Henley Beach Rd	Torrensville	SA 	5031	\N	\N	112	f	2023-06-12	1668487061838299136.pdf	2024-03-31	\N	\N	\N
485	185	2	2023-02-17	50000.00	\N	\N	\N	2023-03-03 19:16:01.208	2023-12-01 16:44:59.465	5fd8edaa-9a15-4ffc-8a87-feee46e241bd.pdf	\N	42 Edward Street	Magill	SA	5072	\N	\N	124	f	2023-02-17	\N	2023-11-30	\N	\N	\N
486	186	38	2023-02-27	250000.00	\N	\N	\N	2023-03-03 19:19:04.798	2023-12-04 11:51:34.719	eaa45463-a8f7-4e1a-a8e4-1c2eb2ce6f2a.pdf	\N	11/77 Warrane Rd	North Willoughby  	NSW 	2068	\N	\N	126	f	2023-02-27	1636200536866631680.pdf	2023-11-30	\N	\N	\N
912	236	38	2023-08-05	250000.00	\N	\N	\N	2023-08-07 11:32:03.566	2023-08-07 11:32:16.946	fa5538ab-684f-4d45-aa9f-a053bcd00451.pdf	XIANG LIANG	3 GILMORE RD	DONCASTER	VIC\t	3108	\N	\N	117	f	2023-08-05	1688362334960340992.pdf	2024-05-31	\N	\N	\N
856	241	38	2023-07-13	250000.00	\N	\N	\N	2023-07-14 14:56:57.403	2023-07-14 14:57:51.096	d8b1fd01-ffd2-4cfd-80f3-7b224cef64f9.pdf	BLACK HORSES WEALTH PTY LTD ATF WINTER SWEET SUPER FUND	Unit 18/1 Kensington St	Kogarah	NSW	2217	\N	\N	122	f	2023-07-13	1679716815480295424.pdf	2024-04-30	\N	\N	\N
1039	18	38	2023-10-01	250000.00	\N	\N	\N	2023-11-01 15:02:26.921	2023-11-01 15:02:26.921	f72240bc-169e-466e-a5d8-59de8a81fdbc.pdf	Hung Fung TONG	Unit 302, 80 Alfred St.	Milsons Point 	NSW 	2061	\N	\N	156	f	2023-10-01	\N	2024-07-31	\N	\N	\N
404	18	38	2022-12-16	250000.00	\N	\N	\N	2023-03-03 14:09:22.457	2023-03-16 14:57:09.708	197bf1b2-6b0b-4ae6-8611-bab42075f505.pdf	Hung Fung TONG	Unit 302, 80 Alfred St.	Milsons Point 	NSW 	2061	\N	\N	156	f	2023-02-16	1636214998520639488.pdf	2023-09-30	\N	\N	\N
722	209	38	2023-03-02	250000.00	\N	\N	\N	2023-03-24 15:31:00.58	2023-12-11 10:40:50.29	c9c94198-2f73-443b-adf8-0af870d970ac.pdf	\N	29 Gleeson Cres	 Rostrevor	SA	5073	\N	\N	96	f	2023-03-02	\N	2023-12-07	\N	\N	\N
740	221	39	2023-04-27	150000.00	\N	\N	\N	2023-04-28 15:51:43.963	2023-10-03 12:19:09.424	cac41fc7-a350-4175-b772-74cc737a661e.pdf	Yutong ZHANG	5 SHIELDS CT	BLACKBURN SOUTH	VIC	3130 	\N	\N	103	f	2023-04-27	1651826509456084992.pdf	2023-09-30	\N	\N	\N
745	223	75	2023-05-05	100000.00	\N	\N	\N	2023-05-08 11:02:25.823	2024-02-02 11:22:14.905	29b06caf-de8e-4752-bbd4-a89d898fc91d.pdf	\N	SUITE 404 16 SHORELINE DRIVE 	RHODES	NSW	2138	\N	\N	106	f	2023-05-05	1655377582796050432.pdf	2024-01-18	\N	\N	\N
668	147	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:18:00.089	2024-11-20 12:28:06.18	BCDIOF-Unit_Certificate-(26-A)-146143[AO_Hai_Investment_Pty_Ltd_ATF_Hao_Yang_Investment_Family_Trust]20241120.pdf	\N	11 Inglis Ct	Glen Waverley	VIC	3150	\N	\N	81	f	2023-03-15	\N	2024-03-11	\N	\N	\N
334	18	2	2022-12-16	250000.00	\N	\N	\N	2022-12-30 08:19:05.380334	2023-08-10 14:43:52.438	e1ddbb2c-c5aa-4441-bdfb-1f8c50f40055.pdf	Hung Fung TONG	Unit 302, 80 Alfred St.	Milsons Point	NSW	2061	\N	\N	156	t	\N	\N	2023-09-30	\N	\N	\N
143	78	14	2022-08-17	100000.00	\N	\N	\N	2022-08-17 11:56:12.792496	2023-03-08 17:39:30.192	a295710b-afbd-4a7c-b208-7ab43bea7604.pdf	Beaver Capital 	\N	\N	\N	\N	\N	\N	160	t	2022-08-17	\N	2022-12-31	\N	\N	\N
667	64	69	2023-03-15	200000.00	\N	\N	\N	2023-03-14 17:15:39.512	2023-03-14 17:15:39.512	24366af6-9c58-48fa-bef6-600a7cf29527.pdf	Minghao Gu ATF Gu Family Trust	407, Blk 18, Jianjin Street	Jiangyang City	Jiangsu Province	\N	\N	BCFCT26A-146026	164	f	2023-03-14	\N	\N	\N	\N	\N
209	64	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:11:17.731518	2023-03-14 17:23:32.364	12b166e28f78c9ce4089f5522cb3ca9f.pdf	Minghao GU ATF GU Family Trust	8 Heaton CT 	Burwood East	VIC	3151	\N	BCFCT7-146026	164	t	\N	\N	\N	\N	\N	\N
188	64	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 15:59:10.690623	2023-03-16 17:41:19.029	4a2d07a2-4251-4f43-a9a3-b57d65e038a2.pdf	Minghao GU ATF GU Family Trust	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2022-09-14	1636256309567107072.pdf	\N	\N	\N	\N
1057	77	104	2023-11-04	100000.00	\N	\N	\N	2023-11-06 12:33:08.489	2023-11-06 12:33:08.489	d6201b79-a4f8-4357-b1e2-6e032a0e1329.pdf	Xian Li	42 Lewton Rd.	Mount Waverley	VIC 	3149	\N	\N	165	f	2023-11-04	1721339903035871232.pdf	\N	\N	\N	\N
687	77	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:41:39.767	2023-03-14 17:41:39.767	b1190642-016d-4808-a495-caffb2cc5ebb.pdf	Xian Li	42 Lewton Rd.	Mount Waverley	VIC 	3149	\N	BCFCT26A-146033	165	f	2023-03-14	\N	\N	\N	\N	\N
845	77	84	2023-07-10	100000.00	\N	\N	\N	2023-07-11 15:39:10.396	2023-07-11 15:39:10.396	5e3fb0de-eff0-4946-b740-ca5486fd351b.pdf	Xian Li	42 Lewton Rd.	Mount Waverley	VIC 	3149	\N	\N	165	f	2023-07-10	1678640050821402624.pdf	\N	\N	\N	\N
215	77	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:24:23.200734	2023-03-14 17:23:02.544	60da3d2c52e7b3d61d341cad63428064.pdf	Xian Li	42 Lewton Rd	Mount Waverley	VIC 	3149	\N	BCFCT7-146033	165	t	\N	\N	\N	\N	\N	\N
989	69	44	2023-10-07	\N	\N	\N	\N	2023-10-12 11:11:36.545	2023-10-12 11:12:03.919	c010fe4f-b63f-4fac-874f-b014b1c7d0e0.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street\t	The Ponds\t	NSW\t	2769	\N	\N	166	t	2023-10-07	\N	\N	\N	\N	\N
588	69	45	2023-01-19	200000.00	\N	\N	\N	2023-03-06 18:11:02.012	2023-03-06 18:11:51.114	3a162683-348d-4ab7-92b8-50906d95c0ec.pdf	Ethan	\N	\N	\N	\N	\N	\N	166	t	2023-02-19	\N	\N	\N	\N	\N
164	69	14	2022-08-17	200000.00	\N	\N	\N	2022-08-26 08:25:01.962207	2023-03-14 18:10:30.936	79090c17-befa-4db3-b960-144da718c645.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2022-08-17	\N	2023-02-18	\N	\N	\N
616	76	11	2022-08-17	100000.00	\N	\N	\N	2023-03-08 16:56:16.342	2023-03-14 10:05:24.576	76ae03c4-c23e-4ff6-a5ab-860de5384a23.pdf	Manli YANG	28/38 Wells Street	Southbank	VIC	3006	\N	BCFCT3-1-146023	168	f	2022-08-17	\N	2023-02-18	\N	\N	\N
72	67	2	2022-03-23	50000.00	\N	\N	\N	2022-03-24 14:23:43.458638	2023-03-03 16:45:19.317	977737a7-8b74-4202-b11b-71a4f067139c.pdf	\N	3/ 12 -14 Oak Avenue	 Boronia	VIC	3155	\N	\N	163	f	2022-03-23	\N	2022-12-31	\N	\N	\N
69	64	2	2022-03-16	100000.00	\N	\N	\N	2022-03-24 14:08:13.803533	2023-03-03 16:41:23.884	7abeba59-6fdd-4648-9dcc-51f65fdba894.pdf	Minghao GU ATF GU Family Trust	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2022-03-16	\N	2022-12-31	\N	\N	\N
125	77	2	2022-08-04	50000.00	\N	\N	\N	2022-08-04 16:22:58.877202	2023-03-17 11:28:43.461	d8f7ab51-29aa-45a9-a154-1ea27e0b2f31.pdf	\N	42 Lewton Rd	 Mount Waverley	VIC	3149	\N	\N	165	f	2022-08-04	\N	2023-05-31	\N	\N	\N
83	77	2	2022-03-31	100000.00	\N	\N	\N	2022-03-31 09:05:59.800513	2023-03-03 16:56:27.906	2cc3b529-41c7-47c7-adca-af27a0e0fb6c.pdf	\N	42 Lewton Rd	 Mount Waverley	VIC	3149	\N	\N	165	f	2022-03-31	\N	2022-12-31	\N	\N	\N
468	69	2	2022-03-25	300000.00	\N	\N	\N	2023-03-03 17:58:34.455	2023-03-14 11:46:31.501	51dcb929-4c37-491a-918e-d384e0087c0d.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2022-03-25	\N	2022-10-20	\N	\N	\N
472	69	37	2022-10-20	500000.00	\N	\N	\N	2023-03-03 18:00:12.247	2023-11-01 15:56:13.422	7e794d86-c93c-4359-8166-e7a06210e9b8.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2022-10-20	1636620753560219648.pdf	2023-10-31	\N	\N	\N
469	69	2	2022-05-12	100000.00	\N	\N	\N	2023-03-03 17:59:05.634	2023-03-14 11:46:21.497	de473c70-44eb-4ad7-8c5c-e02f370aa2c4.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2022-05-12	\N	2022-10-20	\N	\N	\N
470	69	2	2022-10-01	300000.00	\N	\N	\N	2023-03-03 17:59:27.792	2023-03-14 11:46:05.372	03297886-2451-40f2-97bc-462cd1127de8.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2022-10-01	\N	2022-10-20	\N	\N	\N
471	69	2	2022-10-01	100000.00	\N	\N	\N	2023-03-03 17:59:49.442	2023-03-14 11:45:50.206	a1564df8-4f9e-4d91-99f4-c1512e7cf5a8.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2022-10-01	\N	2022-10-20	\N	\N	\N
263	69	2	2022-10-20	500000.00	\N	\N	\N	2022-10-21 07:35:03.097035	2023-03-14 16:08:48.532	f1369816-5776-42f9-8d32-2e1aba1cda06.pdf	Ethan & Aurora Pty Ltd ATF Ethan & Aurora Family Trust	39 Tweed Street	The Ponds	NSW	2769	\N	BCDIOF-146067	166	f	2022-10-20	\N	2022-10-20	\N	\N	\N
151	76	39	2022-12-13	150000.00	\N	\N	\N	2022-08-25 15:36:07.283031	2023-03-16 17:32:23.229	4dbde81b-8886-4bed-abd2-24567e7994f5.pdf	Manli YANG	28/38 Wells Street	Southbank	VIC	3006	\N	\N	168	f	2022-12-13	1636254062259023872.pdf	2023-09-30	\N	\N	\N
120	76	2	2022-07-22	50000.00	\N	\N	\N	2022-07-22 15:41:42.840053	2023-03-17 11:31:38.152	ac0db0bb-39a0-4d84-92e1-72adf977a71b.pdf	\N	28/38 Wells Street	Southbank	VIC	3006	\N	\N	168	f	2022-07-22	\N	2022-12-12	\N	\N	\N
499	37	2	2022-01-12	100000.00	\N	\N	\N	2023-03-03 20:18:27.788	2023-03-15 15:11:57.715	46167a14-dad0-4148-a522-976825e40740.pdf	Lin TAN	1203/3 Haran Street	Mascot	NSW 	2020	\N	\N	159	f	2022-01-12	\N	2022-04-30	\N	\N	\N
350	67	2	2023-01-09	50000.00	\N	\N	\N	2023-01-11 08:55:04.523261	2023-11-01 14:41:49.119	5fdcfd29-5e05-4c88-a278-6ed783f3cf55.pdf	Dong Rong JIN	3/ 12 -14 Oak Avenue	 Boronia	VIC	3155	\N	\N	163	f	2023-01-09	\N	2023-10-31	\N	\N	\N
1009	64	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:45:00.41	2023-12-01 14:47:36.636	b7991e01-21dd-46b7-9642-fc8618eec143.pdf	\N	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-10-06	\N	\N	\N	\N	\N
546	76	43	2023-02-19	100000.00	\N	\N	\N	2023-03-06 16:51:02.961	2024-08-22 17:44:19.34	BCDIOF-Unit_Certificate-(3-1E)-146071[Manli_YANG]20240822.pdf	\N	28/38 Wells Street	Southbank	VIC	3006	\N	\N	168	f	2023-02-19	1636539069099749376.pdf	2023-10-05	\N	\N	\N
612	69	44	2023-02-19	200000.00	\N	\N	\N	2023-03-08 11:11:29.222	2023-12-19 11:29:04.919	65edde70-ef9d-480c-968f-d17ad10d91fd.pdf	\N	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2023-02-19	\N	2023-10-05	\N	\N	\N
719	64	73	2023-03-24	100000.00	\N	\N	\N	2023-03-24 15:01:49.655	2024-02-02 11:31:45.687	39f5c70e-fca1-48e6-ad13-2b1e9005d5da.pdf	\N	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-03-24	\N	2024-01-18	\N	\N	\N
718	64	72	2023-03-24	100000.00	\N	\N	\N	2023-03-24 15:00:56.192	2024-10-18 10:12:44.214	BCDIOF-Unit_Certificate-(36-A)-146061[Minghao_GU_ATF_GU_Family_Trust]20241018.pdf	\N	8 Heaton CT	Burwood East	VIC	3151	\N	\N	164	f	2023-03-24	\N	2023-10-05	\N	\N	\N
984	76	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:36:09.532	2024-10-17 16:44:32.86	BCDIOF-Unit_Certificate-(3-1E)-146071[Manli_YANG]20241017.pdf	\N	28/38 Wells Street	Southbank	VIC	3006	\N	\N	168	f	2023-10-06	\N	2023-10-27	\N	\N	\N
990	69	44	2023-10-06	180000.00	\N	\N	\N	2023-10-12 11:12:38.943	2024-10-18 16:48:59.912	BCDIOF-Unit_Certificate-(3-2E)-146067[Ethan_&_Aurora_Pty_Ltd_ATF_Ethan_&_Aurora_Family_Trust]20241018.pdf	\N	39 Tweed Street	The Ponds	NSW	2769	\N	\N	166	f	2023-10-06	\N	2023-12-06	\N	\N	\N
1069	109	104	2023-11-02	100000.00	\N	\N	\N	2023-11-13 10:35:54.3	2023-11-13 10:35:54.3	0042e59c-7971-447c-89d8-f469b3f50c8e.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	6 Woodlands avenue	Camberwell	VIC	3124	\N	\N	170	f	2023-11-02	1723847114818174976.pdf	\N	\N	\N	\N
834	109	86	2023-07-06	100000.00	\N	\N	\N	2023-07-06 14:05:15.898	2023-07-07 10:00:56.762	bf8f878b-166a-4c7d-9bd2-e3ad7ac4e3f1.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	6 Woodlands avenue	Camberwell	VIC	3124	\N	\N	170	f	2023-07-06	1677105381688741888.pdf	\N	\N	\N	\N
827	109	84	2023-07-07	100000.00	\N	\N	\N	2023-07-06 13:52:01.681	2023-07-07 18:07:55.543	4d767ba9-994c-4284-bff5-468882ebe6ac.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	6 Woodlands avenue	Camberwell	VIC	3124	\N	\N	170	f	2023-07-07	1677227934138765312.pdf	\N	\N	\N	\N
236	61	22	2022-09-15	150000.00	\N	\N	\N	2022-09-16 11:51:33.542701	2023-03-14 17:24:31.737	fbe4e55e8a3dd5ae94259257ef13540b.pdf	Xinyue Investment Group Pty Ltd ATF Xinyue Investment Trust	3 Wendyn Avenue	Keysborough	VIC	3173	\N	BCFCT7-146024	175	t	\N	\N	\N	\N	\N	\N
761	60	75	2023-05-05	150000.00	\N	\N	\N	2023-05-09 17:00:38.374	2023-05-10 15:28:41.673	3206ae43-ab66-40f8-b737-dcfca506877f.pdf	Evergreen SUN Pty Ltd ATF Evergreen Spring Trust	27 Burroughs Road	Balwyn	VIC	3103	\N	BCFCT35B-146035	176	t	2023-05-05	\N	\N	\N	\N	\N
750	60	77	2023-05-08	130000.00	\N	\N	\N	2023-05-09 11:37:11.669	2023-05-09 11:37:11.669	10692518-67aa-49ad-871f-ca82665736f1.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2023-05-08	1655748719333871616.pdf	\N	\N	\N	\N
902	60	85	2023-07-12	50000.00	\N	\N	\N	2023-08-01 17:14:17.948	2023-08-01 17:15:07.089	2de69cf3-be78-47c8-ae29-56f0a011710c.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2023-07-12	1686274341319516160.pdf	\N	\N	\N	\N
840	60	84	2023-07-08	100000.00	\N	\N	\N	2023-07-09 22:32:39.205	2023-07-09 22:32:39.205	c3fa0a9e-bb48-4a6b-a317-6cc4024a3e28.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2023-07-08	1678019330777026560.pdf	\N	\N	\N	\N
192	60	18	2022-09-14	500000.00	\N	\N	\N	2022-09-14 16:11:29.284222	2023-03-16 17:39:20.564	af3211f4-41cc-4de5-9909-f3bfb2a016ad.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Shuimogou	Uyghur	830063	\N	\N	176	f	2022-09-14	\N	\N	\N	\N	\N
697	70	31	2023-01-16	100000.00	\N	\N	\N	2023-03-15 13:41:54.857	2023-03-17 14:36:11.229	bcbb0a7a-cfdb-4c93-8f2a-5653cd28973a.pdf	Liping TAN	1/72 Willow Avenue	Glen Waverley	VIC	3150	\N	\N	177	f	2023-01-16	1636572107942735872.pdf	\N	\N	\N	\N
368	70	31	2023-01-16	100000.00	\N	\N	\N	2023-01-17 13:07:46.76648	2023-03-15 13:42:13.54	72e1990b-176c-41a3-8d88-0dde0a4d40d6.pdf	Liping TAN	1/72 Willow Avenue	Glen Waverley	VIC	3150	\N	\N	177	t	2023-01-16	1635833018700267520.pdf	\N	\N	\N	\N
114	109	2	2022-05-27	100000.00	\N	\N	\N	2022-07-11 15:25:28.197375	2023-03-17 11:33:50.734	cee136c1-69a6-45ae-b781-fbda71759005.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	170	f	2022-05-27	\N	2022-12-08	\N	\N	\N
121	109	2	2022-07-29	100000.00	\N	\N	\N	2022-07-29 15:33:43.254602	2023-03-17 11:31:08.061	2689a81c-438a-4bc1-84e8-a756eaa4f565.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	170	f	2022-07-29	\N	2022-12-08	\N	\N	\N
73	68	2	2022-03-23	700000.00	\N	\N	\N	2022-03-24 14:29:04.030475	2023-03-03 16:46:17.798	fedabc9b-6c85-4e1e-9ba5-02c510c293af.pdf	\N	\N	\N	\N	\N	\N	\N	171	f	2022-03-23	\N	2022-12-31	\N	\N	\N
70	65	2	2022-03-17	100000.00	\N	\N	\N	2022-03-24 14:11:40.37917	2023-03-03 16:42:37.159	bee30250-7ae6-4f06-a5d4-f0093f6322e4.pdf	Yaping LI ATF the Shengli  Family	\N	\N	\N	\N	\N	\N	172	f	2022-03-17	\N	2022-12-31	\N	\N	\N
89	80	2	2022-04-08	100000.00	\N	\N	\N	2022-04-08 14:57:13.355585	2023-03-03 16:57:31.305	096b2bec-3348-404b-82ea-b55d61d61791.pdf	IOK SP Holdings Pty Ltd ATF IOK SP Holdings Family Trust	Unit 2, 12 Lucas Road	 Burwood	NSW	2134	\N	\N	173	f	2022-04-08	\N	2023-01-31	\N	\N	\N
907	80	2	2023-04-01	100000.00	\N	\N	\N	2023-08-02 17:16:12.068	2023-08-02 17:16:12.068	a947e464-dab0-4fc5-881e-db6e10fa7919.pdf	IOK SP Holdings Pty Ltd ATF IOK SP Holdings Family Trust	Unit 2, 12 Lucas Road	 Burwood	NSW	2134	\N	\N	173	f	2023-04-01	\N	2024-01-31	\N	\N	\N
112	80	2	2022-06-29	100000.00	\N	\N	\N	2022-06-29 14:10:46.509271	2023-03-17 11:35:09.159	709581de-a319-4bc7-850f-75c02dc38cf4.pdf	IOK SP Holdings Pty Ltd ATF IOK SP Holdings Family Trust	Unit 2, 12 Lucas Road	 Burwood	NSW	2134	\N	\N	173	f	2022-06-29	\N	2023-03-31	\N	\N	\N
438	62	2	2023-01-01	50000.00	\N	\N	\N	2023-03-03 16:37:55.731	2023-03-15 16:00:14.594	d841b9c8-e1bd-4ae8-b45d-c8a5ab8f111e.pdf	Yanchao SHU	5 Rookwood Street	Balwyn North	VIC	3104	\N	\N	174	f	2023-01-01	\N	2023-01-31	\N	\N	\N
67	62	2	2022-03-09	50000.00	\N	\N	\N	2022-03-24 13:47:29.421721	2023-03-03 16:35:56.057	e1702d00-c0a4-4c6d-b2be-0a22d9b867ea.pdf	\N	\N	\N	\N	\N	\N	\N	174	f	2022-03-09	\N	2022-12-31	\N	\N	\N
66	61	2	2022-03-08	100000.00	\N	\N	\N	2022-03-24 13:16:56.226315	2023-03-03 16:32:29.688	09325509-2f01-4287-aa58-f9957ec8feb7.pdf	Xinyue Investment Group P/L ATF Xinyue Investment Trust	3 Wendyn Avenue	 Keysborough	VIC	3173	\N	\N	175	f	2022-03-08	\N	2022-12-31	\N	\N	\N
936	60	38	2023-09-18	400000.00	\N	\N	\N	2023-09-19 10:21:38.33	2024-03-07 12:10:58.611	87ca3d73-67ee-4e7a-8d2c-b8b7b52382b8.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2023-09-18	1703927291261009920.pdf	2024-02-29	\N	\N	\N
65	60	2	2022-03-08	250000.00	\N	\N	\N	2022-03-24 12:57:26.419614	2023-03-03 16:25:40.799	5c210ec3-0dfd-4ded-906f-8adb13a12c15.pdf	\N	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Shuimogou	Wulumuqi		\N	\N	176	f	2022-03-08	\N	2022-12-22	\N	\N	\N
434	60	38	2022-12-14	50000.00	\N	\N	\N	2023-03-03 16:26:53.874	2023-03-15 16:04:39.746	1177384e-c4cb-4d5b-baac-ceee6162151e.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2022-12-14	\N	2022-12-14	\N	\N	\N
437	60	37	2022-12-01	560000.00	\N	\N	\N	2023-03-03 16:31:21.009	2023-03-20 10:58:40.299	e19b5acc-6944-47b4-87f0-3649b539f28b.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2022-12-01	1637604531971682304.pdf	2023-12-31	\N	\N	\N
436	60	38	2022-12-14	300000.00	\N	\N	\N	2023-03-03 16:30:33.116	2023-03-16 16:49:00.871	ee9e74b6-efdb-4f79-82eb-0ac0d4d88278.pdf	Xiandong GAO 	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2022-12-14	1636243147178455040.pdf	2023-09-30	\N	\N	\N
435	60	38	2022-12-23	330000.00	\N	\N	\N	2023-03-03 16:27:25.418	2023-03-16 16:48:33.444	8e1a49c1-5883-45dc-b3f6-fb646bc3cad9.pdf	Xiandong GAO 	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Uyghur	Wulumuqi	830063	\N	\N	176	f	2022-12-23	1636243032141279232.pdf	2023-09-30	\N	\N	\N
93	60	2	2022-05-04	330000.00	\N	\N	\N	2022-05-05 08:57:59.53006	2023-03-03 16:26:13.443	635716b5-f110-418d-8c86-6fcfb433780a.pdf	Xiandong GAO	#601 Blk 3-1, District 2 of 31 Qidaowan Road	Shuimogou	Wulumuqi		\N	\N	176	f	2022-05-04	\N	2022-12-22	\N	\N	\N
442	109	38	2022-12-09	250000.00	\N	\N	\N	2023-03-03 16:49:29.273	2023-03-16 16:52:11.967	81d70838-ec39-4a17-866e-1e192a7d61cf.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	170	f	2022-12-09	1636243948693172224.pdf	2023-09-30	\N	\N	\N
115	109	2	2022-07-11	50000.00	\N	\N	\N	2022-07-11 15:26:06.502556	2023-03-17 11:33:27.742	42fe119e-69aa-4700-bccf-200d43fa010b.pdf	Wuxufamilysuperfund Pty Ltd ATF Wuxufamilysuperannuation	 6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	170	f	2022-07-11	\N	2022-12-08	\N	\N	\N
1054	60	104	2023-11-02	600000.00	\N	\N	\N	2023-11-03 11:51:19.745	2024-03-04 16:05:26.309	a474b8d8-5ed5-46db-883e-f7c2eaa225d8.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2023-11-02	1720242217007878144.pdf	\N	\N	\N	\N
319	70	34	2022-12-16	130000.00	\N	\N	\N	2022-12-16 11:52:15.350438	2023-03-17 12:31:58.847	e99d257a-9ea3-4c39-a6ad-f399f5b9ae27.pdf	Liping TAN	1/72 Willow Avenue	Glen Waverley	VIC	3150	\N	\N	177	f	2022-12-16	1636540850387103744.jpg	\N	\N	\N	\N
197	70	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:23:24.87167	2023-03-16 17:36:36.732	88c1c5b2-b259-421f-b11d-dc890f3f629c.pdf	Liping TAN	1/72 Willow Avenue	Glen Waverley	VIC	3150	\N	\N	177	f	2022-09-14	1636255125527670784.pdf	\N	\N	\N	\N
200	53	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:35:17.06343	2023-03-16 17:35:20.198	26613e4f-7d9f-4375-922e-bba401785012.pdf	Yang WU	1 Balgowlah Avenue	 Keysborough 	VIC	3173	\N	\N	183	f	2022-09-14	\N	\N	\N	\N	\N
828	126	86	2023-07-05	200000.00	\N	\N	\N	2023-07-06 13:54:13.091	2023-07-07 10:18:50.693	73b1fc99-17d1-4434-b018-8e112f9d4836.pdf	Zhiyuan FENG 	19B Arlington Drive 	Glen Waverley	VIC	3150	\N	\N	190	f	2023-07-05	1677109886081830912.pdf	\N	\N	\N	\N
742	126	76	2023-05-05	100000.00	\N	\N	\N	2023-05-08 10:09:58.964	2023-05-08 10:09:58.964	edff94ed-24f8-4a70-aa5f-ec519cc74429.pdf	Zhiyuan Feng	19B Arlington Drive\t	Glen Waverley	VIC	3150	\N	\N	190	f	2023-05-05	1655364383912759296.pdf	\N	\N	\N	\N
370	126	33	2022-12-16	100000.00	\N	\N	\N	2023-01-30 09:56:04.846298	2023-03-17 14:06:21.062	aa3b274a-ab39-43c9-bbae-50a098a50134.pdf	Zhiyuan FENG	19B Arlington Drive	Glen Waverley	VIC	3150	\N	\N	190	f	2022-12-16	1636564599438127104.pdf	\N	\N	\N	\N
243	126	18	2022-09-19	100000.00	\N	\N	\N	2022-09-20 10:33:17.260781	2023-03-16 17:32:26.255	0372ed50-9331-4198-b7d4-2e0fbd3818e4.pdf	Zhiyuan FENG	19B Arlington Drive	Glen Waverley	VIC	3150	\N	\N	190	f	2022-09-19	1636254074950987776.pdf	\N	\N	\N	\N
217	126	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:48:33.077744	2023-03-14 17:23:08.41	78ff48f37deff4fc2e23ab54e030c29d.pdf	Zhiyuan FENG	19B Arlington Drive 	Glen Waverley 	VIC 	3150	\N	BCFCT7-146035	190	t	\N	\N	\N	\N	\N	\N
203	145	20	2022-09-15	100000.00	\N	\N	\N	2022-09-15 14:33:51.593137	2023-03-14 17:23:42.959	e1d32e641204e1de9625a4051fc83797.pdf	Yicong GUO	3 GLADWYN AVENUE	BENTLEIGH EAST	VIC 	3165	\N	BCFCT7-146020	191	t	\N	\N	\N	\N	\N	\N
815	100	85	2023-07-05	100000.00	\N	\N	\N	2023-07-06 13:04:53.133	2023-07-07 12:08:14.231	4bf1e0bf-2141-465c-94e0-3b2d151d18d4.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	10B El Nido Grove	Carnegie	VIC	3163	\N	\N	192	f	2023-07-05	1677137415551324160.pdf	\N	\N	\N	\N
117	100	2	2022-07-12	50000.00	\N	\N	\N	2022-07-13 10:10:08.571713	2023-03-03 17:13:36.491	edd3a9d35811b89e5ba8cc74f5c4bad2.pdf						\N	\N	192	t	\N	\N	\N	\N	\N	\N
105	100	2	2022-06-09	50000.00	\N	\N	\N	2022-06-13 14:17:45.282965	2023-03-03 17:07:40.214	b32389cfbff9a5b719f198f6cc5aadb9.pdf						\N	\N	192	t	\N	\N	\N	\N	\N	\N
99	100	2	2022-05-16	100000.00	\N	\N	\N	2022-05-17 08:12:08.532859	2023-03-03 17:05:17.196	998deee8d07e942dc19306c3c89e4f71.pdf	Liu SMSF Pty Ltd ATF Liu SMSF	Suite 9, 6-8 Hamilton Place 	Mount Waverley	VIC 	3149	\N	\N	192	t	\N	\N	\N	\N	\N	\N
210	103	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:14:27.130709	2023-03-14 17:23:29.6	47e1611765b994afcf960a3d291562ec.pdf	Yong Zhang	No. 417, Fourth Gate, 11th Floor, Dongluoquan Hutong A	Dongcheng District	Beijing, China	100005	\N	BCFCT7-146027	193	t	\N	\N	\N	\N	\N	\N
101	63	2	2022-05-20	200000.00	\N	\N	\N	2022-05-23 15:44:23.321188	2023-03-03 16:40:21.57	6cd627e5-c811-4518-a478-bd5f12fa82bb.pdf	Zongquan YU	Suite 407, Blk 18, Jianjin Street	Jiangyang City	Jiangsu Province	China	\N	\N	179	f	2022-05-20	\N	2022-12-14	\N	\N	\N
68	63	2	2022-03-16	500000.00	\N	\N	\N	2022-03-24 14:00:18.600057	2023-03-03 16:40:33.658	9e27f8e0-b95a-4f3f-8a4f-a17b4aebc456.pdf	\N	Suite 407, Blk 18, Jianjin Street	Jiangyang City	Jiangsu Province	China	\N	\N	179	f	2022-03-16	\N	2022-12-14	\N	\N	\N
63	58	2	2022-03-03	150000.00	\N	\N	\N	2022-03-24 12:39:31.29008	2023-03-17 11:40:34.936	62a9a681-4770-43f6-ae32-a0b29975b66e.pdf	Norman Francis RAY 	28 Woodbury Road	St Ives 	NSW 	2075	\N	\N	180	f	2022-03-03	\N	2022-12-31	\N	\N	\N
64	59	2	2022-03-04	50000.00	\N	\N	\N	2022-03-24 12:46:56.577221	2023-03-17 11:40:03.048	b4eb03e2-de5a-42ab-8d36-32cb5feb0557.pdf	QI Property Pty Ltd ATF Q1 Family Trust 	L1/ 21 Shierlaw Avenue	Canterbury 	VIC	3126	\N	\N	181	f	2022-03-04	\N	2022-12-31	\N	\N	\N
109	54	2	2022-06-10	100000.00	\N	\N	\N	2022-06-15 16:14:21.470255	2023-03-17 11:36:58.487	63f3ed31-fa63-4ece-9bc6-726851e4dadc.pdf	LYNK Tech Pty Ltd	111 MILL ST	CARLTON	NSW	2218	\N	\N	182	f	2022-06-15	\N	2023-03-31	\N	\N	\N
53	54	2	2022-03-01	100000.00	\N	\N	\N	2022-03-23 08:57:47.209416	2023-03-17 11:46:04.484	11c37726-dce4-4fdc-b54f-ccac84004b37.pdf	LYNK Tech Pty Ltd	111 MILL ST	CARLTON	NSW	2218	\N	\N	182	f	2022-03-01	\N	2022-12-31	\N	\N	\N
52	53	2	2022-02-22	50000.00	\N	\N	\N	2022-02-22 11:59:52.38121	2023-03-17 11:46:29.744	143b97b4-afb2-4ebe-929f-ed430aadda4b.pdf	Yang WU	1 Balgowlah Avenue	 Keysborough 	VIC	3173	\N	\N	183	f	2022-02-22	\N	2022-11-30	\N	\N	\N
139	126	2	2022-08-12	100000.00	\N	\N	\N	2022-08-16 14:21:23.465679	2023-03-03 17:25:45.941	b6ec0c08-429f-4aae-959f-19bd8c327a5f.pdf	\N	19B Arlington Drive	Glen Waverley	VIC	3150	\N	\N	190	f	2022-08-12	\N	2023-05-31	\N	\N	\N
495	100	2	2022-08-04	100000.00	\N	\N	\N	2023-03-03 19:57:47.532	2023-03-15 15:17:08.891	22a08f98-524e-4171-8d05-96d9b596f75f.pdf	Chang LIU	Suite 9, 6-8 Hamilton Place	Mount Waverley	VIC	3149	\N	\N	192	f	2022-08-04	\N	2022-12-07	\N	\N	\N
493	100	2	2022-06-09	50000.00	\N	\N	\N	2023-03-03 19:56:26.749	2023-03-15 15:17:18.912	20073567-2c2b-4984-b981-1480d598bf98.pdf	CHANG LIU	Suite 9, 6-8 Hamilton Place	Mount Waverley	VIC	3149	\N	\N	192	f	2022-06-09	\N	2022-12-07	\N	\N	\N
496	100	38	2022-12-08	300000.00	\N	\N	\N	2023-03-03 19:58:23.424	2023-08-02 16:04:16.417	c6a37245-82c8-47dd-8d2a-e1f9d550bfa8.pdf	CHANG LIU	Suite 9, 6-8 Hamilton Place	Mount Waverley	VIC	3149	\N	\N	192	f	2022-12-08	1636216165136936960.jpg	2023-09-30	\N	\N	\N
494	100	2	2022-07-13	50000.00	\N	\N	\N	2023-03-03 19:57:05.614	2023-03-03 19:57:05.614	ce57f001-e282-4e3d-af87-710cae5f297a.pdf	Chang LIU	Suite 9, 6-8 Hamilton Place	Mount Waverley	VIC	3149	\N	\N	192	f	2022-07-13	\N	2022-12-07	\N	\N	\N
492	100	2	2022-05-16	100000.00	\N	\N	\N	2023-03-03 19:55:32.441	2023-03-15 15:17:28.844	71cdef5b-6333-4ef6-8109-2da38e26c199.pdf	CHANG LIU	Suite 9, 6-8 Hamilton Place	Mount Waverley	VIC	3149	\N	\N	192	f	2022-05-16	\N	2022-12-07	\N	\N	\N
124	100	2	2022-08-04	100000.00	\N	\N	\N	2022-08-04 16:21:48.315185	2023-03-17 11:29:22.802	0741ed25-8d1f-41b2-9dee-42b8c8639476.pdf	\N	Suite 9, 6-8 Hamilton Place	Mount Waverley	VIC	3149	\N	\N	192	f	2022-08-04	\N	2022-12-07	\N	\N	\N
551	103	2	2023-03-01	100000.00	\N	\N	\N	2023-03-06 17:07:58.772	2023-03-14 16:57:59.597	f1be5d10-dbb3-4c5e-b355-c3c25e9bdf96.pdf	Yong ZHANG	No. 417, Fourth Gate, 11th Floor, Dongluoquan Hutong A	Dongcheng District 	Beijing, China	100005	\N	\N	193	f	2023-03-01	\N	2023-12-31	\N	\N	\N
103	103	2	2022-05-26	100000.00	\N	\N	\N	2022-05-26 16:00:58.432616	2023-03-17 11:39:31.56	de4f5913-6f1f-42c7-ab5a-9cb51d73a286.pdf	Yong ZHANG	No. 417, Fourth Gate, 11th Floor, Dongluoquan Hutong A	Dongcheng District 	Beijing, China	100005	\N	\N	193	f	2022-05-26	\N	2023-02-28	\N	\N	\N
116	98	2	2022-07-11	80000.00	\N	\N	\N	2022-07-11 15:29:59.320122	2023-08-01 15:06:20.498	dfad19b7-3ea1-4b35-ba80-3e8b17e3c6ff.pdf	Han Family SMSF Pty Ltd ATF Han Family SMSF	63 Fernhill Road	Sandringham	VIC	3191	\N	\N	194	f	2022-07-11	\N	2022-12-08	\N	\N	\N
75	70	2	2022-03-28	50000.00	\N	\N	\N	2022-03-28 14:14:08.03046	2023-03-03 16:46:50.103	dd81f319-49ae-40c6-ad9d-a1af8f1292f0.pdf	\N	1/72 Willow Avenue	Glen Waverley	VIC	3150	\N	\N	177	f	2022-03-28	\N	2022-12-31	\N	\N	\N
54	56	2	2022-03-16	50000.00	\N	\N	\N	2022-03-23 10:36:35.252905	2023-03-17 11:45:31.871	3923520b-a412-44fc-8bc7-73316434f301.pdf	Gang LIU	26 Urban Drive	Williams Landing	VIC	3027	\N	\N	178	f	2022-03-16	\N	2022-12-31	\N	\N	\N
842	126	84	2023-07-10	120000.00	\N	\N	\N	2023-07-09 23:00:39.5	2024-10-18 11:38:49.875	BCDIOF-Unit_Certificate-(45-A)-146092[Zhiyuan_FENG]20241018.pdf	\N	19B Arlington Drive 	Glen Waverley	VIC	3150	\N	\N	190	f	2023-07-10	1678026378445066240.pdf	\N	\N	\N	\N
447	98	37	2022-12-09	50000.00	\N	\N	\N	2023-03-03 17:02:56.866	2023-03-20 10:42:04.384	f88216d7-5036-40d1-aa2c-76d7cb54eb86.pdf	\N	63 Fernhill Road	Sandringham	VIC	3191	\N	\N	194	t	2022-12-09	\N	2022-12-09	\N	\N	\N
572	99	45	2023-03-01	100000.00	\N	\N	\N	2023-03-06 17:21:48.763	2023-03-17 12:13:31.925	7645a27b-8733-48ae-81ea-24a6784162f2.pdf	Vathey Investment Pty Ltd	10 Dane St.	Box Hill North	VIC	3129	\N	BCFCT5-146020	198	f	2023-03-01	1636536207619731456.pdf	\N	\N	\N	\N
244	99	18	2022-09-19	100000.00	\N	\N	\N	2022-09-20 10:36:20.825275	2023-03-16 17:31:53.165	22324a49-072a-4e47-aa70-a9cf0c18c7dc.pdf	Vathey Investment Pty Ltd	10 Dane St.	Box Hill North	VIC	3129	\N	\N	198	f	2022-09-19	1636253936161468416.pdf	\N	\N	\N	\N
172	99	15	2022-08-30	100000.00	\N	\N	\N	2022-08-30 12:17:49.055886	2023-03-17 15:26:11.284	1843d456-975e-45d2-9e88-47afbaa95585.pdf	Vathey Investment Pty Ltd	10 Dane Street	Box Hill North	VIC	3129	\N	BCFCT5-146021	198	f	\N	1636584691085422592.pdf	\N	\N	\N	\N
133	99	9	2022-08-12	100000.00	\N	\N	\N	2022-08-12 15:42:04.037551	2023-03-17 10:09:10.457	bc7448a2-5d15-4639-98e4-66a5dfcac426.pdf	Vathey Investment Pty Ltd	10 Dane St.	Box Hill North	VIC	3129	\N	\N	198	f	2022-08-12	1636504911954653184.pdf	2022-09-25	\N	\N	\N
723	118	69	2023-03-29	50000.00	\N	\N	\N	2023-03-29 14:35:52.262	2023-03-31 15:40:33.202	3363bd64-5fb6-451c-8feb-f1fb5ae9f649.pdf	Shengling HU	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	BCFCT26A-146027	199	f	2023-03-29	\N	\N	\N	\N	\N
666	118	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:14:21.346	2023-03-14 17:14:21.346	11ea3bec-be71-4d0d-836b-9836403f4f16.pdf	Shengling HU	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	BCFCT26A-146027	199	f	2023-03-14	\N	\N	\N	\N	\N
810	148	84	2023-07-06	100000.00	\N	\N	\N	2023-07-06 12:24:06.638	2023-07-13 09:30:24.83	930632bf-ca6a-4f35-a573-40d7c771a308.pdf	Jingyuan HUANG	8 Murray Dr	Burwood 	VIC	3125	\N	\N	203	f	2023-07-06	\N	\N	\N	\N	\N
199	148	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:31:10.884038	2023-03-16 17:31:07.732	6764b743-3df2-4a7a-8f46-bdf5825fb20e.pdf	Jingyuan Huang	 8 Murray Drive	Burwood	VIC	3125	\N	\N	203	f	2022-09-14	1636253745601654784.pdf	\N	\N	\N	\N
816	148	86	2023-07-05	100000.00	\N	\N	\N	2023-07-06 13:09:10.116	2023-07-07 10:33:41.375	55d81d36-1578-4f94-9fa7-578a09d459f7.pdf	Jingyuan HUANG	8 Murray Dr	Burwood	VIC	3125	\N	\N	203	f	2023-07-05	1677113621872906240.pdf	\N	\N	\N	\N
320	148	31	2022-12-16	100000.00	\N	\N	\N	2022-12-16 13:30:43.057572	2023-03-17 14:39:37.203	520503d4-b3a4-4865-9c70-e24c1a395730.pdf	Jingyuan HUANG	 8 Murray Drive	Burwood	VIC	3125	\N	\N	203	f	2022-12-16	1636572971860307968.pdf	\N	\N	\N	\N
300	148	34	2022-12-13	100000.00	\N	\N	\N	2022-12-13 14:05:34.948296	2023-03-17 12:34:16.079	d04e93a7-828f-42f9-bd96-81a06a9dd43f.pdf	Jingyuan HUANG	 8 Murray Drive	Burwood	VIC	3125	\N	BCFCT14-146025	203	f	2022-12-13	1636541425979830272.pdf	\N	\N	\N	\N
218	148	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:49:55.386691	2023-03-14 17:23:11.113	236b411ecac905e309c8bb783a96781d.pdf	Jingyuan HUANG	8 Murray Dr	Burwood 	VIC 	3125	\N	BCFCT7-146036	203	t	\N	\N	\N	\N	\N	\N
233	150	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:50:04.693363	2023-03-14 17:24:22.25	0c6a696cf40960e027eca5c1c34d4dd3.pdf	QFH PTY LTD ATF QFH TRUST	57 ATHELSTAN RD.	CAMBERWELL	VIC	3124	\N	BCFCT7-146053	204	t	\N	\N	\N	\N	\N	\N
107	111	2	2022-06-10	100000.00	\N	\N	\N	2022-06-13 14:21:33.475863	2023-03-17 11:38:16.84	6fc30d44-aa0a-41a6-a0b2-98e9cd916312.pdf	Zhengrong Yongjuan Pty Ltd ATF Zhengrong Yongjuan Superannualtion Fund	3 Wendyn Avenue	Keysborough	VIC	3173	\N	\N	196	f	2022-06-10	\N	2023-03-31	\N	\N	\N
450	112	37	2022-10-07	1500000.00	\N	\N	\N	2023-03-03 17:11:16.666	2023-11-01 15:57:12.466	d234d750-0a93-47da-a8da-a55dca0c4a2a.pdf	SY Family Holding Pty Ltd ATF Song Family Trust	\N	\N	\N	\N	\N	\N	197	f	2022-10-07	1637598953488642048.pdf	2023-10-31	\N	\N	\N
449	112	2	2022-10-01	150000.00	\N	\N	\N	2023-03-03 17:10:35.23	2023-03-03 17:10:35.23	bde01a90-1e85-49e7-b948-aaf115e36954.pdf	SY Family Holding Pty Ltd ATF Song Family Trust	\N	\N	\N	\N	\N	\N	197	f	2022-10-01	\N	2022-10-06	\N	\N	\N
108	112	2	2022-06-14	1500000.00	\N	\N	\N	2022-06-14 13:32:48.184424	2023-03-17 11:37:28.875	e011dc86-399e-442b-950e-7764a2a296aa.pdf	SY Family Holding Pty Ltd ATF Song Family Trust	2a King Edward Street	Roseville	NSW 	2069	\N	\N	197	f	2022-06-14	\N	2022-10-06	\N	\N	\N
98	99	2	2022-05-13	200000.00	\N	\N	\N	2022-05-13 13:19:21.479217	2023-03-03 17:04:08.762	e74026cf-0225-4e24-82b6-79ef94dcbd14.pdf	Vathey Investment Pty Ltd	10 Dane St.	Box Hill North	VIC	3129	\N	\N	198	f	2022-05-13	\N	2023-02-28	\N	\N	\N
452	118	38	2023-01-03	250000.00	\N	\N	\N	2023-03-03 17:15:20.216	2023-11-01 15:12:27.626	596018f4-7f9d-481e-822e-12291d1023c5.pdf	Shengling HU	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2023-01-03	1636204955733667840.pdf	2023-11-01	\N	\N	\N
451	118	38	2023-01-03	50000.00	\N	\N	\N	2023-03-03 17:14:58.026	2023-03-14 15:20:02.976	cba7c591-bd22-4070-ab95-eb76041081fa.pdf	Shengling HU	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2023-01-03	\N	2023-01-03	\N	\N	\N
118	118	2	2022-07-19	200000.00	\N	\N	\N	2022-07-19 15:37:46.302409	2023-03-17 11:32:27.832	126ee0e4-8a42-4d92-8003-f48317fc97d7.pdf	Shengling HU	D-402, Yixin Yuan, Haoyu Garden, Sucheng district 	Suqian	Jiangsu	223865	\N	\N	199	f	2022-07-19	\N	2023-01-02	\N	\N	\N
36	97	2	2022-05-01	100000.00	\N	\N	\N	2022-01-12 11:55:02.961068	2023-03-17 12:00:34.17	4b17906c-7365-4d8b-8ba7-e551d2629d73.pdf	Setall Family Pty Ltd ATF Setall Family Trust	1203/3 Haran Street	Mascot	NSW 	2020	\N	\N	200	f	\N	\N	2022-10-31	\N	\N	\N
92	96	2	2022-04-28	200000.00	\N	\N	\N	2022-04-28 15:33:21.576612	2023-03-03 17:00:43.115	8ba3299b-0a30-4c89-a0c4-4bc58e0d1b4c.pdf	Jianhong DU	\N	\N	\N	\N	\N	\N	202	f	2022-04-28	\N	2023-01-31	\N	\N	\N
1050	148	40	2023-11-02	180000.00	\N	\N	\N	2023-11-02 15:40:58.709	2023-11-02 15:43:12.119	6abc0a5f-3e44-42bb-8781-eda1629cfed3.pdf	Jingyuan HUANG	8 Murray Dr	Burwood 	VIC	3125	\N	\N	203	f	2023-11-02	1719937622404157440.pdf	2024-03-31	\N	\N	\N
473	150	38	2022-12-16	100000.00	\N	\N	\N	2023-03-03 18:03:32.477	2023-03-14 10:59:38.559	22e9c8ed-7e7a-46c0-b633-359aed70fc62.pdf	QFH PTY LTD ATF QFH Trust	57 ATHELSTAN RD.	CAMBERWELL	VIC	3124	\N	\N	204	f	2022-12-16	\N	2022-12-16	\N	\N	\N
474	150	38	2022-12-16	300000.00	\N	\N	\N	2023-03-03 18:03:59.654	2023-03-16 17:19:51.73	83e91ee1-9d8b-44ae-b40f-8964673d1239.pdf	QFH PTY LTD ATF QFH Trust	57 ATHELSTAN RD.	CAMBERWELL	VIC	3124	\N	\N	204	f	2022-12-16	1636250910243762176.pdf	2023-09-30	\N	\N	\N
261	150	2	2022-10-20	200000.00	\N	\N	\N	2022-10-21 07:28:51.522244	2023-03-14 16:12:09.004	1709cb52-9b04-4936-bcfb-417e018e73cf.pdf	QFH PTY LTD ATF QFH TRUST	57 ATHELSTAN RD.	CAMBERWELL	VIC	3124	\N	\N	204	f	2022-10-20	\N	2022-12-15	\N	\N	\N
140	127	2	2022-08-15	200000.00	\N	\N	\N	2022-08-16 14:26:21.0474	2023-03-03 17:28:37.302	02dfe1ce-5295-4c5b-aac6-560a1455082a.pdf	\N	\N	\N	\N	\N	\N	\N	205	f	2022-08-15	\N	2023-05-31	\N	\N	\N
928	112	99	2023-09-01	1500000.00	\N	\N	\N	2023-09-01 17:07:08.563	2024-09-24 11:17:23.86	e47c5485-ecdc-45d8-82fc-0f1cd38af300.pdf	SY Family Holding Pty Ltd ATF Song Family Trust	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	t	2023-09-01	1697506358069608448.pdf	\N	\N	\N	\N
102	102	2	2022-05-24	50000.00	\N	\N	\N	2022-05-24 15:50:45.103313	2023-03-03 14:50:10.917	dd89861d-1941-4d21-bfde-892a1419c165.pdf	Minglan CHEN	27B Toolambool Road	 Carnegie	VIC	3163	\N	\N	195	f	\N	\N	2023-02-28	\N	\N	\N
1068	112	107	2023-11-07	2000000.00	\N	\N	\N	2023-11-10 12:48:01.271	2024-09-23 17:02:17.352	BCDIOF-Unit_Certificate-(67)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240923.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2023-11-07	1722793199230296064.pdf	\N	\N	\N	\N
769	166	78	2023-05-11	300000.00	\N	\N	\N	2023-05-24 14:58:57.886	2023-06-01 16:50:56.213	60efba25-9eff-4df3-966d-6fd28447d8f3.pdf	Suzhen ZHANG	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	BCFCT39A-146107	206	f	2023-05-11	\N	2023-06-10	\N	\N	\N
222	137	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:02:41.060913	2023-03-14 17:23:48.89	ce2affc14954b75132bc977a620b4ae4.pdf	HUIXIA GAO	1 Pascall St.	Mount Waverley 	VIC 	3149	\N	BCFCT7-146040	207	t	\N	\N	\N	\N	\N	\N
225	139	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:34:44.666154	2023-03-14 17:23:57.81	604053ec5117446d3e18d978e4a34d7f.pdf	Guige PIAO	7 Corunna Court	Glen Waverley 	VIC 	3150	\N	BCFCT7-146043	208	t	\N	\N	\N	\N	\N	\N
223	138	20	2022-09-15	200000.00	\N	\N	\N	2022-09-16 09:26:06.220148	2023-03-14 17:23:51.642	bd4c607f15ac2078efd2ee7e53e56c73.pdf	M&H Management Pty Ltd ATF Mo & Huang Family Trust	29A Parkers Rd.	Parkdale 	VIC 	3195	\N	BCFCT7-146041	209	t	\N	\N	\N	\N	\N	\N
851	140	84	2023-07-12	100000.00	\N	\N	\N	2023-07-13 11:26:20.605	2023-07-13 11:26:20.605	6a5530b9-5961-4449-bebc-11f090f01eec.pdf	Yan LIU	23 Hampstead Cres	Glen Waverley	VIC 	3150	\N	\N	210	f	2023-07-12	1679301199837532160.pdf	\N	\N	\N	\N
232	140	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:47:44.033413	2023-03-14 17:24:18.977	0fa1a81f1bccc38c4e6273e03f967a60.pdf	Yan LIU	23 Hampstead Crescent	Glen Waverley	VIC 	3150	\N	BCFCT7-146052	210	t	\N	\N	\N	\N	\N	\N
695	141	69	2023-03-15	100000.00	\N	\N	\N	2023-03-15 12:26:09.576	2023-05-09 11:47:37.312	af214f47-2efc-44f6-9e7a-291a4aaf04fe.pdf	Mei YANG	808/50 Haig St	Southbank	VIC	3006	\N	BCFCT26A-146036	211	f	2023-03-15	\N	\N	\N	\N	\N
752	141	76	2023-05-08	100000.00	\N	\N	\N	2023-05-09 11:48:23.566	2023-05-09 11:48:44.217	b750ba5c-d138-4451-8314-ae4fd375b108.pdf	Mei YANG	808/50 Haig St,	Southbank	VIC 	3006	\N	\N	211	f	2023-05-08	1655751624090718208.pdf	\N	\N	\N	\N
206	141	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:02:01.865467	2023-03-14 17:23:40.173	f5d529e894aa772ff476b5fae0ece0b0.pdf	Mei YANG	808/50 Haig St.	Southbank 	VIC 	3006	\N	BCFCT7-146021	211	t	\N	\N	\N	\N	\N	\N
183	141	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 15:34:51.610677	2023-03-16 17:43:52.793	8d3bcafd-ffe5-4ce2-b954-fe168cc730e8.pdf	Mei YANG 	808/50 Haig St.	Southbank	VIC	3006	\N	\N	211	f	2022-09-14	1636256954500067328.pdf	\N	\N	\N	\N
207	142	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:04:33.210969	2023-03-14 17:23:37.674	4a9cf90183ecb7af514c6e6051c09f43.pdf	Yue Chan LUO	355 Dandelion Dr.	Rowville	VIC 	3178	\N	BCFCT7-146022	212	t	\N	\N	\N	\N	\N	\N
231	149	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:46:05.465734	2023-03-14 17:24:16.066	a6ef1f1e511b4255c0600fc6f4a6ea9d.pdf	Haowen Xue 	2 BRIMAR CT.	MOUNT WAVERLY 	VIC 	3149	\N	BCFCT7-146051	213	t	\N	\N	\N	\N	\N	\N
198	144	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 16:29:45.082578	2023-11-01 16:48:58.134	1a6fee13-f02f-47bc-b89a-95bc134eaf23.pdf	Meifang JI	5 Winbourne Road	Mount Waverley	VIC	3149	\N	\N	214	f	2022-09-14	1636254978164994048.pdf	2023-10-17	\N	\N	\N
187	151	18	2022-09-14	150000.00	\N	\N	\N	2022-09-14 15:53:58.264511	2023-03-16 17:41:41.593	e07b6bdf-0efb-448c-b2de-de99a29d8aec.pdf	Meifang Zhang	14 Bond Street	Mount Waverley	VIC	3149	\N	\N	215	f	2022-09-14	1636256404207382528.pdf	\N	\N	\N	\N
322	146	33	2022-12-16	100000.00	\N	\N	\N	2022-12-16 13:45:22.887236	2023-05-24 10:54:16.994	14b80e05-08e1-496d-80dc-a522dc7a92a2.pdf	Tsui Chiu Ying	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2022-12-16	\N	2023-06-15	\N	\N	\N
618	146	37	2023-02-17	50000.00	\N	\N	\N	2023-03-08 17:13:04.172	2023-03-10 16:20:31.509	699682fe-8284-49d4-b93b-bfb8153fe337.pdf	Chiu Ying TSUI	\N	\N	\N	\N	\N	\N	216	t	2023-02-17	\N	2023-02-17	\N	\N	\N
831	146	86	2023-07-05	150000.00	\N	\N	\N	2023-07-06 14:00:40.882	2023-07-07 10:12:30.535	16202474-5c15-44ec-b106-bebd93f8bb8a.pdf	Tina Ywen Pty Ltd ATF Tinaewen Superannuation Fund	898 Burke Rd 	Canterbury	VIC	3126	\N	\N	216	t	2023-07-05	\N	\N	\N	\N	\N
321	146	31	2022-12-16	100000.00	\N	\N	\N	2022-12-16 13:43:40.903545	2023-03-17 14:39:04.387	374400ff-f056-45b1-8eac-1fb00c9312fd.pdf	Tsui Chiu Ying	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2022-12-16	1636572834220027904.pdf	\N	\N	\N	\N
288	146	34	2022-12-09	100000.00	\N	\N	\N	2022-12-12 08:40:34.205661	2023-03-17 12:35:29.324	e9fc40bd-ae69-46f1-a775-dc6fe4e2f49b.pdf	Tsui Chiu Ying	22 Barbara Cres	Avondale Heights	VIC	3034	\N	BCFCT14-146021	216	f	2022-12-09	1636541733191626752.pdf	\N	\N	\N	\N
284	146	33	2022-12-09	150000.00	\N	\N	\N	2022-12-10 17:05:50.816667	2023-03-17 14:22:39.812	dda2d9c1-efc3-415c-a992-18bafae82e2e.pdf	Tsui Chiu Ying	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2022-12-09	1636568704613167104.pdf	\N	\N	\N	\N
283	146	31	2022-12-09	100000.00	\N	\N	\N	2022-12-10 17:02:11.792742	2023-03-17 14:43:56.673	ea7c0de0-2010-46bd-9bd9-8b20d70e5c33.pdf	Tsui Chiu Ying	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2022-12-09	1636574060156366848.pdf	\N	\N	\N	\N
753	129	76	2023-05-08	100000.00	\N	\N	\N	2023-05-09 11:50:55.62	2023-05-09 11:50:55.62	ce425b3e-6d4f-47b4-aab8-c0fe30c21196.pdf	Mingshan YANG	119 Balwyn Rd.	Balwyn	VIC 	3103	\N	\N	217	f	2023-05-08	1655752175234846720.pdf	\N	\N	\N	\N
312	129	34	2022-12-15	100000.00	\N	\N	\N	2022-12-15 14:49:20.28883	2023-03-17 12:33:04.016	4ec595dd-7c6f-44c1-a931-1309cf2815c5.pdf	Mingshan YANG	119 Balwyn Rd.	Balwyn	VIC	3103	\N	BCFCT14-146026	217	f	2022-12-15	1636541123725701120.pdf	\N	\N	\N	\N
773	166	38	2023-06-01	300000.00	\N	\N	\N	2023-06-01 16:54:53.571	2024-08-08 17:28:17.766	e9ae99ba-a791-4b32-ba59-e686ce5a935e.pdf	Suzhen ZHANG	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	t	2023-06-01	1664163591683837952.jpg	2023-08-31	\N	\N	\N
919	146	37	2023-08-04	650000.00	\N	\N	\N	2023-08-15 12:20:55.172	2024-10-10 15:07:53.798	BCDIOF-Unit_Certificate-146101[Chiu_Ying_TSUI_]20241010.pdf	\N	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2023-08-04	\N	2023-11-30	\N	\N	\N
271	137	2	2022-10-20	100000.00	\N	\N	\N	2022-12-05 13:48:18.025821	2023-03-14 16:04:13.915	c21c73d6-b470-4080-92a0-984e3ff1e128.pdf	Huixia Gao	f 1 Pascall St.	Mount Waverley	VIC	3149	\N	\N	207	f	2022-10-20	\N	2023-07-31	\N	\N	\N
260	138	37	2022-10-19	500000.00	\N	\N	\N	2022-10-21 07:22:45.333432	2023-11-01 15:59:46.376	559dc65e-1133-48e0-8a40-83e46e5bfff3.pdf	M&H Management Pty Ltd ATF Mo & Huang Family Trust	29A Parkers Rd.	Parkdale	VIC	3195	\N	\N	209	f	2022-10-19	1637618506524389376.pdf	2023-10-31	\N	\N	\N
487	146	37	2022-10-18	500000.00	\N	\N	\N	2023-03-03 19:27:27.849	2023-03-15 15:18:42.55	f91b26c7-60d4-4507-87d9-554e98e4af57.pdf	\N	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2022-10-18	\N	2023-02-16	\N	\N	\N
488	146	37	2023-02-17	550000.00	\N	\N	\N	2023-03-03 19:27:52.577	2023-11-01 15:31:20.425	24ddfccf-4d3a-47cc-94f5-a0119ba947e8.pdf	\N	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2023-02-17	\N	2023-08-03	\N	\N	\N
274	166	2	2022-11-02	500000.00	\N	\N	\N	2022-12-06 08:19:58.971694	2024-08-08 17:25:07.089	d8942d21-fbbc-4b3d-bbae-1a029dee5e2c.pdf	Suzhen ZHANG	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	t	2022-11-02	\N	2023-08-31	\N	\N	\N
214	146	2	2022-10-18	500000.00	\N	\N	\N	2022-09-16 08:22:58.750314	2023-03-16 17:34:23.166	0fdadad9-4a7c-4d50-8a93-7ad60aac52d3.pdf	Tsui Chiu Ying	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2022-10-18	\N	2023-02-16	\N	\N	\N
275	166	37	2022-11-02	500000.00	\N	\N	\N	2022-12-06 08:23:09.044459	2024-09-11 15:55:16.969	827de321-4d3b-498c-ab8d-66c42c246ce6.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	t	2022-11-02	1637613612417544192.pdf	2023-11-30	\N	\N	\N
276	166	37	2023-12-01	500000.00	\N	\N	\N	2022-12-06 08:24:40.891188	2024-08-08 17:37:05.063	8185d629-5c53-4c0b-841f-4187ef4eab83.pdf	\N	2 Kalonga Ct.	Glen Waverley	VIC	3150	\N	\N	206	f	2023-12-01	1698859324978544640.pdf	2023-12-31	\N	\N	\N
185	142	18	2022-09-14	100000.00	\N	\N	\N	2022-09-14 15:46:11.31735	2024-01-31 10:21:45.428	844a67c7-8ba7-4d6e-a206-698ae481fed7.pdf	\N	355 Dandelion Dr.	Rowville	VIC 	3178	\N	\N	212	f	2022-09-14	1636256631169560576.pdf	2023-12-08	\N	\N	\N
832	146	84	2023-07-11	200000.00	\N	\N	\N	2023-07-06 14:02:03.025	2024-10-18 11:44:13.79	BCDIOF-Unit_Certificate-(45-A)-146101[Chiu_Ying_TSUI_]20241018.pdf	\N	22 Barbara Cres	Avondale Heights	VIC	3034	\N	\N	216	f	2023-07-11	\N	\N	\N	\N	\N
837	124	86	2023-07-05	250000.00	\N	\N	\N	2023-07-07 09:58:08.17	2023-07-13 11:05:25.218	3bb06b09-930a-4859-beab-cc851083f77d.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund	27 BURROUGHS ROAD	BALWYN 	VIC	 3103	\N	\N	218	f	2023-07-05	1679295934362816512.pdf	\N	\N	\N	\N
901	124	85	2023-07-18	200000.00	\N	\N	\N	2023-08-01 17:12:22.765	2023-08-01 17:12:22.765	47f40066-bbc2-4155-9b7c-5aea2e5e806b.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund 	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	218	f	2023-07-18	\N	\N	\N	\N	\N
900	124	85	2023-08-18	200000.00	\N	\N	\N	2023-08-01 17:09:32.583	2023-08-01 17:11:43.568	e69cf1ba-6884-4101-9803-bf03d2b81724.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund 	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	218	t	\N	1686272938299662336.pdf	\N	\N	\N	\N
134	124	9	2022-08-12	150000.00	\N	\N	\N	2022-08-12 15:43:04.865397	2023-03-17 10:08:47.029	6a4b0ccb-3357-49e5-a0f3-4c9e35cdee66.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	218	f	2022-08-12	1636504813690499072.pdf	2022-09-25	\N	\N	\N
234	124	20	2022-09-15	150000.00	\N	\N	\N	2022-09-16 09:51:50.804149	2023-03-14 17:24:24.881	e143b5fa3b6a0302ead9673da6c26c02.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund	27 BURROUGHS ROAD	BALWYN 	VIC	3103	\N	BCFCT7-146055	218	t	\N	\N	\N	\N	\N	\N
850	122	85	2023-07-07	100000.00	\N	\N	\N	2023-07-13 11:18:12.737	2023-07-13 11:19:28.316	a9d26998-9dbd-4f18-973d-8c2209004fe4.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	f	2023-07-07	1679299470572130304.pdf	\N	\N	\N	\N
849	122	84	2023-07-05	100000.00	\N	\N	\N	2023-07-13 11:17:05.629	2023-07-13 11:17:05.629	7ad17def-7b80-491f-b92f-56bd0f5e70b1.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	f	2023-07-05	1679298872099475456.pdf	\N	\N	\N	\N
756	122	76	2023-05-08	140000.00	\N	\N	\N	2023-05-09 15:52:00.968	2023-05-09 16:06:51.469	379be856-f551-43cc-984c-900dc430d75c.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	f	2023-05-08	1655816582333730816.pdf	\N	\N	\N	\N
128	122	9	2022-08-12	200000.00	\N	\N	\N	2022-08-12 15:06:14.610451	2023-03-17 10:12:57.057	d4c767b5-5443-472b-b6a0-31ba4fc138cc.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	146020	219	f	2022-08-12	\N	2022-09-25	\N	\N	\N
610	122	38	2022-12-15	300000.00	\N	\N	\N	2023-03-07 16:38:32.596	2023-08-04 10:03:12.535	ce2badd0-5af1-481e-a58b-729f8cdbe5fe.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	t	2022-12-15	1636215470824435712.pdf	2023-09-30	\N	\N	\N
175	122	15	2022-08-30	200000.00	\N	\N	\N	2022-08-30 12:22:51.348489	2023-03-17 15:15:32.881	93174f2f-8a70-4756-b81d-f77790cf2f57.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	BCFCT5-146024	219	f	\N	1636582013429166080.pdf	\N	\N	\N	\N
908	121	2	2023-06-01	\N	\N	\N	\N	2023-08-02 17:21:05.543	2023-08-02 17:22:37.26	5972078d-ad5e-4d26-b9a2-976e4ffdf414.pdf	\N	Unit 107, 5 Claire St	McKinnon	VIC	3127	\N	\N	220	t	2023-06-01	\N	2024-03-31	\N	\N	\N
670	121	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:20:18.922	2023-03-14 17:20:18.922	07ee5bb4-a4f9-422b-bb84-70651804ff36.pdf	Yanmei YU	107/ 5 Claire Street	Mckinnon	VIC	3127	\N	BCFCT26A-146023	220	f	2023-03-14	\N	\N	\N	\N	\N
227	121	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 09:39:09.660188	2023-03-14 17:24:04.185	fdaf7641cd3ed046e0c1591625543ff0.pdf	Yanmei YU	Unit 107, 5 Claire St	McKinnon 	VIC 	3204	\N	BCFCT7-146047	220	t	\N	\N	\N	\N	\N	\N
158	121	11	2022-08-17	100000.00	\N	\N	\N	2022-08-26 07:48:34.440105	2023-03-14 18:15:50.414	937c5cb0-22d3-4423-8532-70d798d2676f.pdf	Yanmei YU	Unit 107, 5 Claire St	McKinnon	VIC	3204	\N	BCFCT3-1-146029	220	f	2022-08-18	\N	2023-02-18	\N	\N	\N
146	122	2	2022-08-22	230000.00	\N	\N	\N	2022-08-23 08:10:18.775923	2024-01-10 14:42:56.107	a8242a55-6bdb-425f-a519-6b227cc9b95e.pdf	\N	47 ERICA AVE.GLEN IRIS	GLEN IRIS	VIC	3146	\N	\N	219	f	2022-08-22	\N	2022-12-07	\N	\N	\N
457	122	38	2022-12-15	300000.00	\N	\N	\N	2023-03-03 17:24:26.211	2023-08-04 10:03:47.752	6f515787-94fa-466b-96cf-382020bade2b.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	f	2022-12-15	1636246490072297472.pdf	2023-08-03	\N	\N	\N
910	122	37	2023-08-04	500000.00	\N	\N	\N	2023-08-04 10:02:22.367	2023-08-08 11:18:43.999	cc351a69-245b-4ba6-b460-87ede28afecf.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	f	2023-08-04	1688721369198874624.pdf	2024-08-31	\N	\N	\N
1034	124	38	2023-10-20	250000.00	\N	\N	\N	2023-10-20 10:45:38.279	2024-07-12 14:45:22.533	d8224307-b7e3-4e77-a851-457417eb435f.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2023-10-20	1715152255178096640.pdf	2024-07-10	\N	\N	\N
126	122	2	2022-08-09	130000.00	\N	\N	\N	2022-08-11 10:25:51.872203	2024-01-10 14:43:00.294	4b842e28-d556-4c5e-acc5-18606a24c5f1.pdf	\N	47 ERICA AVE.GLEN IRIS	GLEN IRIS	VIC	3146	\N	\N	219	f	2022-08-09	\N	2022-12-07	\N	\N	\N
178	122	2	2022-09-05	90000.00	\N	\N	\N	2022-09-08 14:04:07.447973	2024-01-10 14:42:49.701	5e6e8a55-bc6a-46e3-925d-9dd8f3a799dc.pdf	\N	47 ERICA AVE.GLEN IRIS	GLEN IRIS	VIC	3146	\N	\N	219	f	2022-09-05	\N	2022-12-07	\N	\N	\N
909	121	2	2023-06-01	100000.00	\N	\N	\N	2023-08-02 17:22:01.59	2023-08-02 17:22:01.59	ac21dc3d-5be9-41f8-aa9b-1ca724adbb05.pdf	Yanmei YU	Unit 107, 5 Claire St	McKinnon	VIC	3127	\N	\N	220	f	2023-06-01	\N	2024-03-31	\N	\N	\N
122	121	2	2022-08-03	100000.00	\N	\N	\N	2022-08-03 13:00:42.835696	2023-03-17 11:30:22.749	d5eb123e-1d61-4842-9d29-64fe24b64587.pdf	\N	Unit 107, 5 Claire St	McKinnon	VIC	3127	\N	\N	220	f	2022-08-03	\N	2023-05-31	\N	\N	\N
477	167	37	2023-02-22	370000.00	\N	\N	\N	2023-03-03 18:19:09.542	2023-03-17 17:39:12.487	c61be8ec-1878-4aa8-9795-dc19abf2e666.pdf	Ming LIU	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2023-02-22	1636618166677090304.pdf	2024-02-29	\N	\N	\N
829	124	85	2023-07-06	150000.00	\N	\N	\N	2023-07-06 13:57:41.503	2024-10-18 10:55:32.815	BCDIOF-Unit_Certificate-(45-B)-146119[Evergreen_Forest_Pty_Ltd_ATF_Evergreen_Super_Fund]20241018.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2023-07-06	1682206482473734144.pdf	2023-07-31	\N	\N	\N
913	124	38	2023-08-06	350000.00	\N	\N	\N	2023-08-07 11:44:39.226	2023-08-08 09:29:00.653	5b7e2fe9-8b6d-45b5-81ac-5e8d9ad36ce6.pdf	Evergreen Forest Pty Ltd ATF Evergreen Super Fund 	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	218	f	2023-08-06	1688693756644413440.pdf	2024-05-31	\N	\N	\N
591	122	43	2023-02-19	100000.00	\N	\N	\N	2023-03-07 14:12:39.447	2024-08-22 17:42:36.01	BCDIOF-Unit_Certificate-(3-1E)-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20240822.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2023-02-19	1636538892095926272.pdf	2023-10-05	\N	\N	\N
326	122	33	2022-12-23	100000.00	\N	\N	\N	2022-12-24 07:42:23.555448	2024-01-08 11:14:43.948	7475d72e-7f88-4b50-a9d7-a41b869e4d3a.pdf	\N	47 ERICA AVE.GLEN IRIS	GLEN IRIS	VIC	3146	\N	\N	219	f	2022-12-23	1636564707491786752.pdf	2023-06-22	\N	\N	\N
456	122	2	2022-08-22	230000.00	\N	\N	\N	2023-03-03 17:23:40.989	2024-01-09 16:38:35.634	3ab708bd-6816-4d14-a3b0-01f8a3439205.pdf	Titanium Titan Pty Ltd ATF Qin Self Managed Super Fund	47 Erica Avenue	Glen Iris	VIC	3146	\N	\N	219	t	2022-08-22	\N	2022-09-07	\N	\N	\N
150	122	11	2022-08-17	100000.00	\N	\N	\N	2022-08-25 15:33:42.155026	2024-01-11 13:45:28.465	e0c06e5c-ea2e-4bc8-a06c-41795409b691.pdf	\N	47 ERICA AVE.GLEN IRIS	GLEN IRIS	VIC	3146	\N	\N	219	f	2022-08-17	\N	2023-02-18	\N	\N	\N
982	122	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:21:34.234	2024-10-17 16:48:28.649	BCDIOF-Unit_Certificate-(3-1E)-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20241017.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2023-10-06	\N	2023-10-27	\N	\N	\N
713	172	37	2023-03-20	510000.00	\N	\N	\N	2023-03-22 12:25:50.176	2023-03-22 12:29:20.133	a1689fbf-50c7-49ab-945f-f0379c9f8bf5.pdf	Bo LI	U 709, 100 Harbour Esplanade	Docklands	VIC	3008	\N	BC	223	t	2023-03-20	\N	2024-03-31	\N	\N	\N
911	154	84	2023-07-12	100000.00	\N	\N	\N	2023-08-04 15:06:49.649	2023-08-04 15:07:38.888	a406729b-622a-4a87-a744-86cb742445d0.pdf	Haojie Wang	3 SMYTHE AVENUE 	MONT ALBERT	VIC 	3127	\N	\N	225	f	2023-07-12	1687329219584315392.jpg	2023-07-31	\N	\N	\N
658	154	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 16:58:17.705	2023-03-14 16:58:17.705	db1294c8-6057-41bd-b0e9-5915d2860dd4.pdf	Haojie Wang	3 SMYTHE AVENUE 	MONT ALBERT	VIC 	3127	\N	BCFCT26A-146030	225	f	2023-03-14	\N	\N	\N	\N	\N
220	154	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:57:25.114702	2023-03-14 17:23:17.005	14713198-96cf-4161-b075-a90b05791c36.pdf	Haojie Wang	3 SMYTHE AVENUE 	MONT ALBERT	VIC 	3127	\N	BCFCT7-146038	225	t	2022-09-12	\N	\N	\N	\N	\N
1003	164	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:35:25.111	2023-11-09 14:23:08.755	9928e24d-d2c8-4f76-b328-ab2b08fcd10f.pdf	Boyang ZHENG	47 Winfield Road	Balwyn North	VIC	3104	\N	\N	228	f	2023-10-06	\N	\N	\N	\N	\N
826	164	86	2023-07-08	100000.00	\N	\N	\N	2023-07-06 13:46:25.583	2023-07-09 21:24:49.488	e2e81624-5646-4c8e-acc7-b1029aed5e80.pdf	Boyang ZHENG 	47 Winfield Road 	Balwyn North	VIC	3104	\N	\N	228	f	2023-07-08	1678002261146734592.pdf	\N	\N	\N	\N
696	164	69	2023-03-15	100000.00	\N	\N	\N	2023-03-15 12:27:53.159	2023-03-30 14:58:14.387	032db2c8-cf33-4014-aa76-28fbb22a337a.pdf	Boyang ZHENG	47 Winfield Road	Balwyn North 	VIC	3104	\N	BCFCT26A-146037	228	f	2023-03-15	\N	\N	\N	\N	\N
751	164	76	2023-05-08	100000.00	\N	\N	\N	2023-05-09 11:40:27.641	2023-05-09 11:40:27.641	01af6617-070d-42fa-a2e7-8fd9c08c2f9e.pdf	Boyang ZHENG	47 Winfield Road	Balwyn North 	VIC 	3104	\N	\N	228	f	2023-05-08	1655749541300015104.pdf	\N	\N	\N	\N
269	164	18	2022-11-24	100000.00	\N	\N	\N	2022-11-24 13:55:11.00014	2023-03-14 16:04:39.081	4fada989-7dc4-41ad-847c-638d88c3fa52.pdf	Boyang ZHENG	47 Winfield Road	Balwyn North	VIC	3104	\N	\N	228	f	2022-11-24	\N	\N	\N	\N	\N
212	57	20	2022-09-15	100000.00	\N	\N	\N	2022-09-16 08:18:13.025451	2023-03-14 17:23:24.298	5af31a5dc377fc817d0306d768f0de1f.pdf	Aiping Huang	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	BCFCT7-146029	231	t	\N	\N	\N	\N	\N	\N
369	167	37	2023-01-23	270000.00	\N	\N	\N	2023-01-23 14:58:01.936893	2023-03-14 15:39:41.165	b1a56053-61dc-4385-9238-1aedfe7d1bb3.pdf	Ming LIU	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2023-01-23	\N	2023-02-21	\N	\N	\N
278	167	39	2022-12-13	150000.00	\N	\N	\N	2022-12-06 08:31:35.272479	2023-03-16 17:31:42.779	f65b1711-dfeb-44de-98a0-94046298ec08.pdf	Ming LIU	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2022-12-13	1636253892599427072.pdf	2023-09-30	\N	\N	\N
277	167	2	2022-11-21	150000.00	\N	\N	\N	2022-12-06 08:31:12.490106	2023-03-14 16:02:41.368	5b511cca-cb3f-448e-a141-65aaa2254ff2.pdf	Ming LIU	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2022-11-21	\N	2022-12-12	\N	\N	\N
726	86	38	2023-03-03	300000.00	\N	\N	\N	2023-04-04 15:22:02.171	2024-09-10 16:40:26.893	BCDIOF-Unit_Certificate-146074[Shanshan_ZHOU]20240910.pdf	\N	62 Wright St.	Paradise	SA	5075	\N	\N	226	f	2023-03-03	\N	2023-12-31	\N	\N	\N
1044	172	38	2023-10-01	415000.00	\N	\N	\N	2023-11-01 15:07:49.273	2023-11-01 15:07:49.273	1c99bd61-4fac-4910-8311-7eeef6d26166.pdf	Bo LI	U 709, 100 Harbour Esplanade	Docklands	VIC	3008	\N	\N	223	f	2023-10-01	\N	2024-07-31	\N	\N	\N
709	172	37	2023-03-20	510000.00	\N	\N	\N	2023-03-21 11:31:52.689	2023-03-24 17:06:40.541	959ff194-5f0b-4aae-8067-1acf4717bcea.pdf	Bo Li	U 709, 100 Harbour Esplanade	Docklands	VIC	3008	\N	\N	223	f	2023-03-20	1639146694681391104.jpg	2024-03-31	\N	\N	\N
329	172	38	2022-12-23	415000.00	\N	\N	\N	2022-12-30 08:05:14.343118	2023-03-16 15:48:55.662	3a04471e-1b2d-42c8-9b3b-b88a71502d11.pdf	Bo LI	U 709, 100 Harbour Esplanade	Docklands	VIC	3008	\N	\N	223	f	2022-12-23	1636228025835925504.pdf	2023-09-30	\N	\N	\N
932	163	2	2023-09-01	100000.00	\N	\N	\N	2023-09-11 14:53:54.006	2023-09-11 14:53:54.006	2ea05b81-cbce-4d93-b4c3-bacb093062c0.pdf	Hong MENG	8-10  Fairthorne  Street	Keysborough	VIC	3173	\N	\N	224	f	2023-09-01	\N	2024-06-30	\N	\N	\N
268	163	2	2022-11-10	100000.00	\N	\N	\N	2022-11-10 13:49:59.842989	2023-03-14 16:05:25.763	5b1a203d-be27-40d5-96e1-545218b8525c.pdf	Hong MENG	8-10  Fairthorne  Street	Keysborough	VIC	3173	\N	\N	224	f	2022-11-10	\N	2023-08-31	\N	\N	\N
733	164	72	2023-04-11	100000.00	\N	\N	\N	2023-04-12 10:09:15.649	2024-10-18 10:27:58.089	BCDIOF-Unit_Certificate-(36-A)-146131[Boyang_ZHENG]20241018.pdf	\N	47 Winfield Road	Balwyn North	VIC	3104	\N	\N	228	f	2023-04-11	\N	2023-10-05	\N	\N	\N
445	86	2	2023-03-01	300000.00	\N	\N	\N	2023-03-03 16:59:32.172	2023-04-04 15:20:00.832	6bff7175-5dd5-4011-a782-d75cdb4e0dbe.pdf	\N	62 Wright St.	Paradise	SA	5075	\N	\N	226	f	2023-03-01	\N	2023-03-02	\N	\N	\N
91	86	2	2022-04-13	200000.00	\N	\N	\N	2022-04-14 13:30:21.00587	2023-03-03 16:58:40.64	c86e88b7-1b28-410f-aae6-ff1c8d0ab35c.pdf	Shanshan ZHOU	62 Wright St.	Paradise	SA	5075	\N	\N	226	f	2022-04-13	\N	2023-01-31	\N	\N	\N
501	75	2	2022-03-30	100000.00	\N	\N	\N	2023-03-03 20:36:02.406	2023-03-15 15:09:55.202	a744a831-ca99-4c6c-a8d1-93faab90c5df.pdf	Mckesson Pty Ltd ATF Lucky Guo Family Trust	3 Gladwyn Avenue	Bentleigh East	VIC	3165	\N	\N	227	f	2022-03-30	\N	2022-12-31	\N	\N	\N
81	75	2	2022-03-30	100000.00	\N	\N	\N	2022-03-30 19:18:06.07877	2022-03-30 19:18:06.07877	f5e071a2-df4e-460e-9381-f770bec5e39e.pdf	\N	\N	\N	\N	\N	\N	\N	227	f	\N	\N	\N	\N	\N	\N
333	174	37	2022-12-20	880000.00	\N	\N	\N	2022-12-30 08:17:16.271556	2023-03-20 11:23:12.703	34ac2e25-3402-482d-97a4-9e9f6a355979.pdf	Zhimin HU	198 Pennant Hills Road	Oatlands	NSW	2117	\N	\N	229	f	2022-12-20	1637610707681669120.pdf	2023-12-31	\N	\N	\N
1045	173	38	2023-10-01	260000.00	\N	\N	\N	2023-11-01 15:13:59.063	2024-07-04 15:12:14.125	1c8b583c-1939-421e-955a-43d2a4b4e192.pdf	\N	97 Holmes Street	Brunswick	VIC	3056	\N	\N	222	f	2023-10-01	\N	2024-06-30	\N	\N	\N
279	168	37	2022-11-25	600000.00	\N	\N	\N	2022-12-06 08:41:19.272418	2023-12-04 17:21:49.327	eb755943-e117-4824-b625-432d08784373.pdf	\N	21 Acheron Avenue	Camberwell	VIC	3124	\N	\N	230	f	2022-11-25	1637612137557651456.pdf	2023-11-30	\N	\N	\N
905	57	38	2023-06-14	250000.00	\N	\N	\N	2023-08-02 16:09:01.455	2023-08-02 16:09:01.455	1714d6cc-8605-4bbc-b6d5-70724b2a601f.pdf	Aiping HUANG	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2023-06-14	1686620096110579712.pdf	2024-03-31	\N	\N	\N
56	57	2	2022-03-23	100000.00	\N	\N	\N	2022-03-23 11:52:55.675727	2023-03-17 11:44:20.797	95b3f559-7c88-4374-a129-9c769a5b23a1.pdf	Aiping HUANG	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2022-03-23	\N	2022-12-31	\N	\N	\N
433	57	2	2022-12-14	50000.00	\N	\N	\N	2023-03-03 16:20:48.472	2023-03-15 16:05:31.946	506f4989-8bd8-4e92-a92f-bcf4f4a165fa.pdf	Aiping HUANG	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2022-12-14	\N	2022-12-14	\N	\N	\N
302	57	39	2022-12-14	150000.00	\N	\N	\N	2022-12-14 12:21:03.229475	2023-08-01 11:42:04.883	8856ad01-16e2-4065-834b-46068a298347.pdf	Aiping HUANG	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2022-12-14	1635173532352442368.pdf	2023-06-13	\N	\N	\N
258	57	2	2022-10-19	100000.00	\N	\N	\N	2022-10-19 08:06:27.113971	2023-03-14 16:13:20.222	65e5a931-ec5d-4ca9-8de4-50c2375f4382.pdf	Aiping HUANG	U1/ 8 Duckham St.	Blackburn	VIC	3130	\N	\N	231	f	2022-10-19	\N	2022-12-13	\N	\N	\N
478	167	37	2023-01-19	500000.00	\N	\N	\N	2023-03-03 18:19:54.818	2023-03-17 17:34:19.797	4d151c4b-8bac-4563-827d-4dc9801c825f.pdf	Ming LIU	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2023-01-19	1636616939046252544.pdf	2024-01-31	\N	\N	\N
476	167	37	2023-02-22	100000.00	\N	\N	\N	2023-03-03 18:18:41.893	2023-03-14 10:54:48.011	aea501ff-332d-4527-a9ac-f2d48c01cba9.pdf	Ming LIU	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2023-02-22	\N	2023-02-22	\N	\N	\N
1046	168	37	2023-09-01	700000.00	\N	\N	\N	2023-11-01 15:46:31.741	2024-05-29 14:14:10.599	4ec50f10-f29f-4488-a0ba-a9ea9011b28a.pdf	\N	21 Acheron Avenue	Camberwell	VIC	3124	\N	\N	230	f	2023-09-01	\N	2023-12-31	\N	\N	\N
858	183	84	2023-07-07	100000.00	\N	\N	\N	2023-07-14 15:12:28.673	2023-07-14 15:12:28.673	4256a4e8-7544-471b-a128-2c0887798d81.pdf	Jianqun Liao	1 Larne Avenue   	Donvale	VIC	3111	\N	\N	233	f	2023-07-07	1679720496305016832.pdf	\N	\N	\N	\N
657	183	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 16:57:20.788	2023-03-14 16:57:20.788	4af5c00d-1d62-4859-91f6-5428012ee7ba.pdf	Jianqun Liao	1 Larne Avenue   	Donvale	VIC	3111	\N	BCFCT26A-146031	233	f	2023-03-14	\N	\N	\N	\N	\N
595	183	58	\N	\N	\N	\N	\N	2023-03-07 14:52:24.299	2023-03-07 14:52:27.536	a2b2e43d-e9fb-4058-aa8e-f729322c9522.pdf	\N	\N	\N	\N	\N	\N	\N	233	t	\N	\N	\N	\N	\N	\N
242	156	18	2022-09-15	100000.00	\N	\N	\N	2022-09-16 14:45:18.064121	2023-03-16 17:32:52.69	0c3a469a-e91f-4d49-b073-be8c84da1d37.pdf	Kaidi LIU	1 Pascall Street	Mount Waverley	VIC	3149	\N	\N	236	f	2022-09-14	1636254185827414016.pdf	\N	\N	\N	\N
898	180	69	2023-07-03	110000.00	\N	\N	\N	2023-08-01 15:10:39.864	2023-08-01 15:10:39.864	e367476d-0f75-48c8-857b-790e8e678b8f.pdf	Jingwen CUI	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2023-07-03	1686243021608493056.pdf	\N	\N	\N	\N
894	180	84	2023-07-24	140000.00	\N	\N	\N	2023-07-25 10:51:23.881	2023-07-25 10:51:23.881	e26f8d5b-8ea3-4638-a54e-8c6ca1362c26.pdf	Jingwen CUI	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2023-07-24	1683641059926921216.pdf	\N	\N	\N	\N
809	218	83	2023-07-05	50000.00	\N	\N	\N	2023-07-05 16:25:12.357	2023-07-05 16:29:07.127	6681d2fd-25ff-4c66-ac54-e5f9480098da.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	240	t	2023-07-05	\N	\N	\N	\N	\N
808	218	2	2023-07-05	500000.00	\N	\N	\N	2023-07-05 16:00:54.164	2023-07-05 16:01:29.367	66440c45-4c33-4931-bd50-3878c4ee6592.pdf	\N	\N	\N	\N	\N	\N	\N	240	t	2023-07-05	\N	\N	\N	\N	\N
798	218	2	2023-04-13	10.00	\N	\N	\N	2023-06-22 16:16:15.263	2023-06-22 16:16:48.009	9f5d1c62-b9c3-4fe8-a8f0-9a2d43e91833.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	240	t	\N	\N	2023-06-22	\N	\N	\N
775	218	80	2023-06-06	500000.00	\N	\N	\N	2023-06-06 10:26:24.505	2023-06-28 14:14:12.238	6c2e1b23-ea85-482b-b90e-3f560d3362af.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	240	t	2023-06-06	\N	2023-06-09	\N	\N	\N
774	218	80	2023-06-06	50000.00	\N	\N	\N	2023-06-06 10:20:50.411	2023-06-06 10:21:16.713	ba15051c-cb3f-4ac9-8cf6-e229888bd2f9.pdf	\N	\N	\N	\N	\N	\N	\N	240	t	2023-06-06	\N	2023-06-06	\N	\N	\N
735	218	73	2023-04-15	50000.00	\N	\N	\N	2023-04-17 10:34:51.21	2023-07-04 10:39:23.382	fd9f10b5-ea1c-405e-9a3b-988606a17e53.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	240	t	2023-04-12	\N	2023-04-16	\N	\N	\N
965	218	2	2023-10-04	100000.00	\N	\N	\N	2023-10-08 13:19:24.796	2023-10-09 10:06:55.238	6d7586c1-921b-4e49-aab9-d6f600300450.pdf	\N	\N	\N	\N	\N	\N	\N	240	t	2023-10-04	\N	\N	\N	\N	\N
964	218	99	2021-07-16	5000000.00	\N	\N	\N	2023-10-07 14:51:20.342	2023-10-07 14:51:45.464	0c57ff4f-3f2a-4b6c-aaa1-10347ecfcf7f.pdf	\N	\N	\N	\N	\N	\N	\N	240	t	\N	\N	\N	\N	\N	\N
971	218	102	2023-10-10	50000.00	\N	\N	\N	2023-10-10 09:35:57.329	2023-10-10 15:11:45.575	3fc95cfc-399d-4b25-ae57-8b95c994654a.pdf	\N	\N	\N	\N	\N	\N	\N	240	t	2023-10-10	\N	\N	\N	\N	\N
1015	218	34	2023-08-01	500000.00	\N	\N	\N	2023-10-13 17:00:22.848	2023-10-13 17:00:32.337	d42323eb-4bd4-45f3-b519-95910cb18d91.pdf	\N	\N	\N	\N	\N	\N	\N	240	t	2023-08-01	\N	\N	\N	\N	\N
897	218	2	2023-03-08	50000.00	\N	\N	\N	2023-07-26 09:59:28.519	2023-08-03 16:57:20.91	e96c4dbd-160b-43ae-a87f-b7d3e5f53841.pdf	testtwtsrwrwr	1	1	1	1	\N	1	240	t	2023-03-08	\N	2023-07-28	\N	\N	\N
802	218	34	2023-02-23	500000.00	\N	\N	\N	2023-06-26 18:06:23.72	2023-07-04 10:39:19.181	cba9a8c4-f6cf-410c-b281-cbdf690febb0.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	1	240	t	2023-02-22	\N	\N	\N	\N	\N
953	231	2	2023-10-05	100000.00	\N	\N	\N	2023-10-06 15:05:42.089	2023-10-06 15:06:06.608	562da226-4452-4e52-8eb3-5ea4b161b357.pdf	\N	\N	\N	\N	\N	\N	\N	241	t	2023-10-05	\N	\N	\N	\N	\N
801	231	37	2023-01-01	10000000.00	\N	\N	\N	2023-06-26 10:36:47.448	2023-08-03 16:57:33.891	9c01ae75-e6b2-4cf8-987d-3bf4976f1067.pdf	Frank test 22222	\N	\N	\N	\N	\N	\N	241	t	2023-01-01	\N	2023-12-31	\N	\N	\N
807	231	86	2023-07-04	\N	\N	\N	\N	2023-07-05 15:32:35.294	2023-07-06 11:24:37.038	d48e9e95-9f60-4704-94cb-9bf559330d67.pdf	\N	\N	\N	\N	\N	\N	\N	241	t	2023-07-04	\N	\N	\N	\N	\N
806	231	83	2023-07-05	\N	\N	\N	\N	2023-07-05 15:31:57.881	2023-07-06 11:24:39.454	c871b07b-ec94-4f4c-a143-3da8ccc1973f.pdf	\N	\N	\N	\N	\N	\N	\N	241	t	2023-07-05	\N	\N	\N	\N	\N
903	248	89	2023-06-16	280000.00	\N	\N	\N	2023-08-02 12:01:31.928	2023-08-02 12:01:31.928	2fb25637-0602-4e0c-a979-e6247b29d6aa.pdf	UCaptial International Pty Ltd As Trustee of UCapital Unit Trust	Level 26, 44 Market Street	SYDNEY 	NSW 	2000	\N	\N	242	f	2023-06-16	1686557812755582976.pdf	\N	\N	\N	\N
1053	123	104	2023-11-05	100000.00	\N	\N	\N	2023-11-03 11:49:18.653	2023-11-06 12:29:49.832	c4c2bd68-f3ae-4f33-aa26-15638481a674.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	\N	245	f	2023-11-05	1721339069808021504.pdf	\N	\N	\N	\N
498	72	2	2021-11-05	350000.00	\N	\N	\N	2023-03-03 20:13:10.458	2023-03-15 15:12:47.759	0eadb0cc-407d-4282-8af7-e84ae8a2be51.pdf	Xunao WANG	3 LEO ROAD	PENNANT HILL	NSW 	2120	\N	\N	237	f	2021-11-05	\N	2021-12-13	\N	\N	\N
79	72	2	2021-11-05	350000.00	\N	\N	\N	2022-03-29 15:42:15.828022	2022-03-29 15:42:15.828022	103691c9-5294-4d53-a8aa-3f336b463a5f.pdf	\N	\N	\N	\N	\N	\N	\N	237	f	\N	\N	\N	\N	\N	\N
917	218	2	2023-08-15	499991.00	\N	\N	\N	2023-08-15 11:11:53.543	2023-10-16 12:03:44.406	7a79be5f-8739-497f-87e7-00b13d758db0.pdf	1	703/458 forest road,2220	hurstville	NSW	2220	\N	\N	240	f	2023-08-15	\N	2023-12-20	\N	\N	\N
977	218	102	2023-10-11	50000.00	\N	\N	\N	2023-10-11 12:21:03.595	2023-10-11 12:21:03.595	a796a883-a0cc-46f7-baa8-0a7a3be6de2c.pdf	\N	\N	\N	\N	\N	\N	\N	240	f	2023-10-11	\N	\N	\N	\N	\N
930	231	37	2023-07-02	1000000.00	\N	\N	\N	2023-09-04 11:59:21.706	2023-10-03 16:09:27.771	5c7b0d80-f0cb-475d-86a7-63e06f3f4bb9.pdf	\N	\N	\N	\N	\N	\N	\N	241	f	2023-07-02	\N	2024-06-30	\N	\N	\N
1037	51	2	2023-10-01	50000.00	\N	\N	\N	2023-11-01 14:36:44.565	2023-11-01 14:36:44.565	2664150c-c509-44f4-81a1-a07541af4cba.pdf	Ling Huang and Yajun Liu ATF ARVOR Superannuation Fund	155 Connells Point Road	 Connells Point	NSW 	2221	\N	\N	243	f	2023-10-01	\N	2024-07-31	\N	\N	\N
432	51	2	2022-12-01	50000.00	\N	\N	\N	2023-03-03 16:12:24.961	2023-03-15 16:10:30.945	d15a11e0-d4a9-410e-9e28-03eca639e658.pdf	Ling Huang and Yajun Liu ATF ARVOR Superannuation Fund	155 Connells Point Road	 Connells Point	NSW 	2221	\N	\N	243	f	2022-12-01	\N	2023-09-30	\N	\N	\N
170	51	2	2022-08-24	10000.00	\N	\N	\N	2022-08-26 14:28:59.401326	2023-03-03 16:08:50.935	0f9e0ea3-75de-4a68-941c-c7189e66fc3a.pdf	Ling Huang and Yajun Liu ATF ARVOR Superannuation Fund	\N	\N	\N	\N	\N	\N	243	f	2022-08-24	\N	2023-05-31	\N	\N	\N
50	51	2	2022-02-21	50000.00	\N	\N	\N	2022-02-22 11:58:34.707215	2023-03-17 11:48:08.176	7676b95b-e0da-4af1-add8-c4ce2fc58d13.pdf	Ling Huang and Yajun Liu ATF ARVOR Superannuation Fund	155 Connells Point Road	 Connells Point	NSW 	2221	\N	\N	243	f	2022-02-21	\N	2022-11-30	\N	\N	\N
768	113	39	2023-05-01	165000.00	\N	\N	\N	2023-05-19 10:44:25.854	2023-05-19 10:44:25.854	eccfabf4-0091-4088-940f-d4c8c285fbd7.pdf	Yanchao YANG, Ruiqing YANG and Li XU ATF JRYX Superfund	38 Dalgetty Road	Beaumaris	VIC	3193	\N	\N	244	f	2023-05-01	1659359319599353856.pdf	2024-02-29	\N	\N	\N
113	113	2	2022-07-06	165000.00	\N	\N	\N	2022-07-06 15:29:49.634892	2023-03-17 11:34:30.511	fdf95f41-e48e-42a3-8730-c6bcd9071bf3.pdf	Yanchao YANG, Ruiqing YANG and Li XU ATF JRYX Superfund	38 Dalgetty Road	Beaumaris	VIC	3193	\N	\N	244	f	2022-07-06	\N	2023-04-30	\N	\N	\N
589	189	37	2022-12-13	2000000.00	\N	\N	\N	2023-03-06 18:22:02.849	2023-03-17 17:15:21.139	36e9b99b-b230-4253-9d03-26f8be968237.pdf	Value Up 1123 Pty Ltd ATF for Value Up 1123 Trust 	 10B El Nido Grove	Carnegie	VIC	3163	\N	\N	234	f	2022-12-13	1636612163168448512.jpg	2023-12-31	\N	\N	\N
482	182	38	2023-02-02	250000.00	\N	\N	\N	2023-03-03 19:03:53.652	2023-12-04 11:50:31.599	cd39a2a9-e7de-4cc8-bdbc-327b87c3a8b6.pdf	\N	6 Bethune Ave	Glenunga	SA	5064	\N	\N	235	f	2023-02-02	1636204275807629312.pdf	2023-11-30	\N	\N	\N
480	180	37	2022-12-16	500000.00	\N	\N	\N	2023-03-03 18:51:52.357	2023-12-19 16:08:43.176	a0b06876-1686-4615-aa4e-fa5dc977f0fb.pdf	\N	Unit 302, Level 3, No.5 Doufu Road	Xi'an	Shanxi	710033	\N	\N	238	f	2022-12-16	1636616331715227648.pdf	2023-12-17	\N	\N	\N
1010	123	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:46:08.057	2023-11-09 14:21:46.903	f5288099-8321-456d-82b9-4e479536382d.pdf	Qianxi Investment Pty ATF Wang Family	16 Elwood St	Brighton	VIC	3186	\N	\N	245	f	2023-10-06	\N	\N	\N	\N	\N
601	123	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:16:38.458	2023-03-07 15:21:19.595	575d205d-1f1a-4a3b-8026-7b92c982a040.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	 1 Jean Street	McKinnon	VIC	3204	\N	\N	245	t	2023-02-19	\N	\N	\N	\N	\N
814	123	84	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:01:06.084	2023-07-07 12:05:03.754	81223aef-f4c5-4f88-ade7-b8a462c2e787.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St 	Brighton	VIC	3186	\N	\N	245	f	2023-07-06	1677136616637075456.pdf	\N	\N	\N	\N
688	123	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:43:49.557	2023-03-14 17:43:49.557	3abb8e04-25f9-489c-a4ac-b5d77980d9fb.pdf	Qianxi Investment Pty Ltd ATF WANG Family Trust	 1 Jean Street	McKinnon	VIC	3204	\N	BCFCT26A-146034	245	f	2023-03-14	\N	\N	\N	\N	\N
754	123	76	2023-05-08	100000.00	\N	\N	\N	2023-05-09 11:53:10.061	2023-05-09 11:53:10.061	399f487f-1055-4ddc-9c96-8b47cc8d38c6.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St	Brighton 	VIC 	3186	\N	\N	245	f	2023-05-08	1655752739121270784.pdf	\N	\N	\N	\N
812	123	86	2023-07-06	100000.00	\N	\N	\N	2023-07-06 12:34:01.585	2023-07-07 10:36:53.534	940a1519-726f-4d8f-9a21-2d01bc385a0b.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust 	16 Elwood St	Brighton	VIC	3186	\N	\N	245	f	2023-07-06	1677114427846168576.pdf	\N	\N	\N	\N
189	123	18	2022-09-14	200000.00	\N	\N	\N	2022-09-14 16:01:06.41946	2023-03-16 17:40:42.843	02c792e2-e257-4762-be53-ec8d9d081424.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	1 Jean Street	McKinnon	VIC	3204	\N	BCFCT6-146026	245	f	2022-09-14	1636256157792022528.pdf	\N	\N	\N	\N
318	123	34	2022-12-16	100000.00	\N	\N	\N	2022-12-16 11:49:44.787307	2023-03-17 12:32:21.674	962326a3-ca83-4c5f-a1ce-b867d31c02a8.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St	Brighton	VIC	3186	\N	BCFCT14-146028	245	f	2022-12-16	1636540946130481152.pdf	\N	\N	\N	\N
304	123	33	2022-12-14	100000.00	\N	\N	\N	2022-12-15 07:09:16.75138	2023-03-17 14:20:18.02	ae93b842-a4ae-4214-a085-3258c3e39ce0.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St	Brighton	VIC	3186	\N	BCFCT13-146024	245	f	2022-12-14	1636568109894414336.pdf	\N	\N	\N	\N
303	123	31	2022-12-14	100000.00	\N	\N	\N	2022-12-15 06:47:59.342176	2023-03-17 14:41:05.268	083e92c7-41a0-4c22-ab04-96b5c7836904.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St	Brighton	VIC	3186	\N	BCFCT11-146026	245	f	2022-12-14	1636573341231689728.pdf	\N	\N	\N	\N
213	123	20	2022-09-15	500000.00	\N	\N	\N	2022-09-16 08:20:22.654321	2023-03-14 17:23:21.491	fe7f412737ccd7aed980ef76ab36944a.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	1 Jean Street	McKinnon	VIC	3204	\N	BCFCT7-146030	245	t	\N	\N	\N	\N	\N	\N
153	123	11	2022-08-17	100000.00	\N	\N	\N	2022-08-25 15:48:17.910708	2023-03-14 17:57:59.255	c89a80d3-b3be-4a79-bc99-3dfcab5679da.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	1 Jean Street	McKinnon	VIC	3204	\N	BCFCT3-1-146025	245	f	2022-08-17	\N	2023-02-18	\N	\N	\N
656	170	69	2023-03-15	100000.00	\N	\N	\N	2023-03-14 16:56:05.623	2023-03-14 16:56:05.623	91e3b862-3a4b-4ad7-a957-9e8e63b624e4.pdf	South Star Australia Group Pty Ltd atf Chen Superannuation Fund	261 High St Rd 	Mount Waverley  	VIC	3149	\N	BCFCT26A-146032	246	f	2023-03-14	\N	\N	\N	\N	\N
325	170	33	2022-12-23	100000.00	\N	\N	\N	2022-12-24 07:19:55.69986	2023-03-17 14:07:07.634	d882eb84-55d3-4b79-80c5-60c93f3460ae.pdf	South Star Australia Group Pty Ltd ATF The Chen Family	261 High Street Road	Mount  Waverley	VIC	3149	\N	\N	246	f	2022-12-23	1636564794775252992.pdf	\N	\N	\N	\N
889	243	90	2023-07-21	500000.00	\N	\N	\N	2023-07-21 15:40:31.264	2023-07-21 15:40:41.807	6a5d41a9-1190-4a10-9a24-600a1eceea9c.pdf	rew	rwqe	rq	rq	rqew	\N	qre	247	t	2023-07-21	\N	\N	\N	\N	\N
821	101	86	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:27:09.195	2023-07-07 11:34:02.79	c924d6b0-d6fc-4c4c-a38e-911ba47ba7f5.pdf	Autstrip Pty Ltd ATF Lu Family Trust	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	t	2023-07-06	1677128534544617472.pdf	\N	\N	\N	\N
127	123	2	2022-08-10	300000.00	\N	\N	\N	2022-08-12 13:23:08.928906	2023-03-17 11:26:55.016	d45f8301-802d-4950-83a1-a5a7c7e75acb.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	16 Elwood St	Brighton	VIC	3186	\N	\N	245	f	2022-08-10	\N	2022-10-19	\N	\N	\N
717	123	72	2023-03-24	100000.00	\N	\N	\N	2023-03-24 12:04:25.456	2024-10-18 10:19:12.651	BCDIOF-Unit_Certificate-(36-A)-146091[Qianxi_Investment_Pty_Ltd_ATF_Wang_Family_Trust]20241018.pdf	\N	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	\N	245	f	2023-03-24	\N	2023-10-05	\N	\N	\N
1036	250	38	2023-10-27	250000.00	\N	\N	\N	2023-10-30 09:46:10.691	2023-10-30 09:46:10.691	8a889d84-04a7-43f4-8d1d-83b2041a51af.pdf	Shelford Enterprise Pty Ltd ATF Shelford Family Trust	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2023-10-27	1718761170285477888.pdf	2024-07-31	\N	\N	\N
942	250	38	2023-10-06	250000.00	\N	\N	\N	2023-10-06 13:52:07.594	2023-10-06 15:07:05.876	2de7b47a-ea55-4f20-a254-180aafee6cac.pdf	Shelford Enterprise Pty Ltd ATF Shelford Family Trust	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2023-10-06	1710144623610454016.pdf	2024-07-31	\N	\N	\N
882	243	2	2022-07-01	1000000.00	\N	\N	\N	2023-07-21 09:34:54.665	2024-10-09 14:58:03.599	1d9b1516-cadb-423c-9806-4ff25886c1ee.pdf	Jerry	Fake Add	FAke sub	Fake State	Fake code	\N	\N	247	t	2023-07-02	\N	2023-07-03	\N	\N	\N
980	123	43	2023-10-06	90000.00	\N	\N	\N	2023-10-11 16:16:43.304	2024-10-18 17:51:43.486	BCDIOF-Unit_Certificate-(3-1E)-146091[Qianxi_Investment_Pty_Ltd_ATF_Wang_Family_Trust]20241018.pdf	\N	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	\N	245	f	2023-10-06	\N	2023-10-27	\N	\N	\N
915	251	37	2023-07-05	600000.00	\N	\N	\N	2023-08-10 09:59:11.907	2023-08-10 10:01:10.907	db8e83a4-cae7-4e06-870f-771b7ec07ade.pdf	Ziping SI	Unit 2, Level Building 4, 38 South Taoyuan Road\t	Lianhu 	Xi'an	710000	\N	\N	250	f	2023-07-05	1689426129325510656.pdf	2023-08-08	\N	\N	\N
453	123	2	2022-10-20	200000.00	\N	\N	\N	2023-03-03 17:17:40.852	2023-11-01 15:58:36.882	a16b2051-0c5f-4f50-91f6-f2f395ed0e75.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	1 Jean Street	McKinnon	VIC	3204	\N	\N	245	f	2022-10-20	\N	2022-11-20	\N	\N	\N
454	123	2	2022-10-01	300000.00	\N	\N	\N	2023-03-03 17:18:23.318	2023-03-14 15:17:54.678	467904c5-39bd-4436-936b-f1a0b9be4f57.pdf	Qianxi Investment Pty Ltd ATF Wang Family Trust	1 Jean Street	McKinnon	VIC	3204	\N	\N	245	f	2022-10-01	\N	2022-10-20	\N	\N	\N
914	250	38	2023-08-06	250000.00	\N	\N	\N	2023-08-07 11:51:37.813	2024-09-30 11:42:15.093	BCDIOF-Unit_Certificate-146197[Shelford_Enterprise_Pty_Ltd_ATF_Shelford_Family_Trust]20240930.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2023-08-04	1688367260109230080.pdf	2024-05-31	\N	\N	\N
916	251	37	2023-08-09	1030000.00	\N	\N	\N	2023-08-10 10:00:32.827	2024-07-09 15:50:03.873	20778dbe-8868-4f7f-9a9a-7a92d64ab7f7.pdf	\N	Unit 2, Level Building 4, 38 South Taoyuan Road	Lianhu \t	Xi'an	710000	\N	\N	250	f	2023-08-09	1689426468728590336.pdf	2024-06-30	\N	\N	\N
1004	170	72	2023-10-06	80000.00	\N	\N	\N	2023-10-12 11:38:31.799	2024-10-18 10:27:05.731	58d172e8-3291-4f78-a12d-000f97faf3b3.pdf	Minhui Zhu and Sen Chen ATF The Chen Zhu Family Trust	261 High St Rd 	Mount Waverley 	VIC 	3149	\N	\N	246	t	2023-10-06	\N	\N	\N	\N	\N
593	123	43	2023-02-19	100000.00	\N	\N	\N	2023-03-07 14:14:51.946	2024-10-18 17:50:01.238	BCDIOF-Unit_Certificate-(3-1E)-146091[Qianxi_Investment_Pty_Ltd_ATF_Wang_Family_Trust]20241018.pdf	\N	16 Elwood St\t	Brighton\t	VIC\t	3186	\N	\N	245	f	2023-02-19	1636538722574741504.pdf	2023-10-05	\N	\N	\N
661	101	70	2023-03-15	100000.00	\N	\N	\N	2023-03-14 17:01:25.044	2024-11-21 11:28:41.768	BCDIOF-Unit_Certificate-(26-B)-146079[Autstrip_Pty_Ltd_ATF_Lu_Family_Trust]20241121.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2023-03-14	\N	2024-03-11	\N	\N	\N
924	255	99	2023-08-31	689000.00	\N	\N	\N	2023-09-01 11:00:45.404	2023-09-01 11:01:42.509	b35d0df1-e46f-406e-a333-274681334d7d.pdf	Yufeng MA	 6 Greenwich Road\t	Greenwich 	NSW\t	2065	\N	\N	254	f	2023-08-31	1697414393533681664.pdf	\N	\N	\N	\N
925	256	99	2023-09-01	1000000.00	\N	\N	\N	2023-09-01 16:37:26.958	2023-09-01 16:38:28.622	e1171fbc-d797-4170-b31d-90226cc69972.pdf	Zongnan HAN	 6 Greenwich Road\t	Greenwich 	NSW\t	2065	\N	\N	255	f	2023-09-01	1697498885577293824.pdf	\N	\N	\N	\N
929	257	99	2023-09-01	500000.00	\N	\N	\N	2023-09-01 17:13:57.803	2023-09-01 17:13:57.803	7032c303-d05f-46a9-8dd3-d5d35325c94f.pdf	Lijun LIU	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	256	f	2023-09-01	1697508074546577408.pdf	\N	\N	\N	\N
714	66	72	2023-03-24	300000.00	\N	\N	\N	2023-03-24 11:34:27.313	2023-11-09 14:15:01.488	71bec09c-5fa4-4058-b5ef-d44b5145a51a.pdf	Gold Phoenix Holding Pry Ltd ATF Jing Hui Feng Liang Trust	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	BCFCT36A-146021	260	f	2023-03-24	\N	2023-10-05	\N	\N	\N
955	264	100	\N	\N	\N	\N	\N	2023-10-06 15:19:54.642	2023-10-06 15:20:07.641	bca4d4e6-be8b-44a8-a4d5-dfe1a1136717.pdf	\N	\N	\N	\N	\N	\N	\N	262	t	\N	\N	\N	\N	\N	\N
1056	261	104	2023-11-03	100000.00	\N	\N	\N	2023-11-06 12:28:00.548	2023-11-06 12:28:00.548	07dd776f-0d18-4baa-9eb5-26c7ff33b713.pdf	Guanyu CHEN	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	\N	266	f	2023-11-03	1721338611571920896.pdf	\N	\N	\N	\N
941	256	37	2023-10-05	1000000.00	\N	\N	\N	2023-10-05 17:26:02.456	2023-10-05 17:26:36.313	f710122f-f619-4116-9910-ea52209594a0.pdf	Zongnan HAN	 6 Greenwich Road\t	Greenwich 	NSW	2065	\N	\N	255	f	2023-10-05	1709817201895694336.pdf	2024-10-31	\N	\N	\N
935	262	2	2023-09-18	50000.00	\N	\N	\N	2023-09-19 09:36:47.421	2023-09-19 09:36:47.421	5cb0162d-06e1-4e37-83b5-ebe08575d93f.pdf	Dongmei HE	15 Edison St	Belmore	NSW	Australia	\N	\N	259	f	2023-09-18	1703916004766433280.pdf	2024-06-30	\N	\N	\N
737	66	75	2023-04-14	100000.00	\N	\N	\N	2023-04-18 09:50:40.724	2024-02-02 11:19:51.283	608269af-2406-4946-abcb-e3d95fa81527.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-04-14	\N	2024-01-18	\N	\N	\N
441	66	38	2022-12-16	300000.00	\N	\N	\N	2023-03-03 16:44:30.896	2023-03-16 16:50:18.904	e8665f43-4b13-4fb8-9ce2-3808272e3849.pdf	Gold Phoenix Holding Pty Ltd ATF Jing Hui Feng Liang Trust	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2022-12-16	1636243474472579072.jpg	2023-09-30	\N	\N	\N
71	66	2	2022-03-22	100000.00	\N	\N	\N	2022-03-24 14:20:24.88916	2023-03-03 16:44:45.14	5c14a709-ab11-4547-9aea-89a9a31588d5.pdf	Gold Phoenix Holding Pty Ltd ATF Jing Hui Feng Liang Trust	\N	\N	\N	\N	\N	\N	260	f	2022-03-22	\N	2022-12-15	\N	\N	\N
111	66	2	2022-06-17	200000.00	\N	\N	\N	2022-06-17 15:03:25.652093	2023-03-17 11:35:50.033	5e09fb98-e5b4-4f64-8f71-7d6784fc6926.pdf	Gold Phoenix Holding Pty Ltd ATF Jing Hui Feng Liang Trust	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2022-06-17	\N	2022-12-15	\N	\N	\N
1041	66	38	2023-10-01	300000.00	\N	\N	\N	2023-11-01 15:04:38.542	2024-01-04 12:17:47.769	db516f06-8efb-4faa-a92f-ca6d49233792.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-10-01	\N	2023-12-21	\N	\N	\N
1032	263	39	2023-10-18	150000.00	\N	\N	\N	2023-10-18 11:23:52.811	2023-12-22 10:44:44.955	4637e5d3-5a87-4eda-88cf-9ba6e09d0be0.pdf	\N	L6, C1 / 90 Nguyen Binh Khiem Street	Rach Gia City 	Kien Giang, Vietnam	920000 	\N	\N	261	f	2023-10-18	1714437169757143040.pdf	2023-12-13	\N	\N	\N
976	266	37	2023-10-11	500000.00	\N	\N	\N	2023-10-11 11:24:04.944	2024-10-16 09:35:20.61	BCDIOF-Unit_Certificate-146207[Wan_NG]20241016.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	999077	\N	\N	265	f	2023-10-11	1711900439246127104.pdf	2024-10-15	\N	\N	\N
973	265	102	2023-10-10	2000000.00	\N	\N	\N	2023-10-10 14:30:35.601	2023-10-10 14:30:35.601	fcf51774-f6e7-4a67-a897-3d7bd3d93fec.pdf	Lei WU and Yiwen LIN ATF ValueUp 0928 Unit Trust 	6 Woodlands Avenue	Camberwell	VIC	3124	\N	\N	263	f	2023-10-10	1711584988393750528.pdf	2025-04-30	\N	\N	\N
1064	261	106	2023-11-03	100000.00	\N	\N	\N	2023-11-07 11:52:06.052	2024-08-29 14:30:57.045	BCDIOF-Unit_Certificate-(62)-146203[Guanyu_CHEN]20240829.pdf	\N	76A Trimmer Parade\t	Seaton\t	SA \t	5023	\N	\N	266	f	2023-11-03	1721691962698452992.pdf	2024-08-23	\N	\N	\N
819	101	85	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:17:41.518	2024-10-18 11:08:10.013	BCDIOF-Unit_Certificate-(45-B)-146079[Autstrip_Pty_Ltd_ATF_Lu_Family_Trust]20241018.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2023-07-06	\N	2023-07-31	\N	\N	\N
100	101	2	2022-05-20	70000.00	\N	\N	\N	2022-05-20 09:41:03.431687	2023-03-03 17:05:49.23	ac1d5703-e6a0-47c9-9620-266639cd8875.pdf	Autstrip Pty Ltd ATF Lu Family Trust	44 Dunstan Parade	 Port Melbourne	VIC	3207	\N	\N	252	f	2022-05-20	\N	2023-02-28	\N	\N	\N
920	254	38	2023-08-22	250000.00	\N	\N	\N	2023-08-23 17:33:18.291	2023-08-23 17:33:18.291	c315660d-0a1a-45fd-bb42-04f5adff69b2.pdf	MICHAEL & PING PTY LTD ATF MICHAEL & PING FAMILY TRUST	5 Rubens Court\t	Wheelers Hill	VIC	3150	\N	\N	253	f	2023-08-22	1694251451199901696.pdf	2024-05-31	\N	\N	\N
927	66	99	2023-09-01	500000.00	\N	\N	\N	2023-09-01 16:49:02.357	2024-09-24 11:15:25.271	eaacef8b-637c-4818-85de-fcc67645c0c5.pdf	Gold Phoenix Holding Pty Ltd ATF Jing Hui Feng Liang Trust	7707/ 117 Bathurst Street	Sydney	NSW	2000	\N	\N	260	t	2023-09-01	1697501802195632128.pdf	\N	\N	\N	\N
1012	66	72	2023-10-06	240000.00	\N	\N	\N	2023-10-12 11:47:53.686	2024-09-18 16:13:00.633	BCDIOF-Unit_Certificate-(36-A)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240918.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-10-06	\N	2023-11-24	\N	\N	\N
938	263	2	2023-09-27	50000.00	\N	\N	\N	2023-09-27 16:27:58.938	2023-12-22 10:44:28.011	82428f85-889f-4709-9bee-3111d12ae8b9.pdf	\N	L6, C1 / 90 Nguyen Binh Khiem Street	Rach Gia City 	Kien Giang, Vietnam	920000 	\N	\N	261	f	2023-09-27	1706918587536007168.pdf	2023-12-13	\N	\N	\N
715	66	73	2023-03-24	150000.00	\N	\N	\N	2023-03-24 11:50:48.164	2024-02-02 11:32:19.182	9b008d32-166a-4d44-ae11-6972d7be709f.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-03-24	\N	2024-01-18	\N	\N	\N
1062	266	105	2023-10-12	500000.00	\N	\N	\N	2023-11-06 16:04:03.356	2024-05-20 09:25:12.042	c2627f85-b08a-42e3-81ae-9c985217ecb9.pdf	\N	Flat C, 32/F, The Arch, Moon Tower Block 2A, 1 Austin Road West	West Kowloon	HONG KONG - China	\N	\N	\N	265	f	2023-10-12	\N	2024-05-03	\N	\N	\N
1031	268	38	2023-10-16	500000.00	\N	\N	\N	2023-10-17 10:04:37.818	2024-05-29 14:19:39.399	ee192df4-58c9-48c4-b28a-3e0cb5897f6e.pdf	\N	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	\N	264	f	2023-10-16	1714054771659882496.pdf	2024-07-31	\N	\N	\N
736	66	74	2023-04-14	200000.00	\N	\N	\N	2023-04-18 09:49:13.247	2024-08-23 10:58:25.807	BCDIOF-Unit_Certificate-(35-A)-146063[Gold_Phoenix_Holding_Pty_Ltd_ATF_Jing_Hui_Feng_Liang_Trust]20240823.pdf	\N	7707/ 117 Bathurst Street	 Sydney	NSW	2000	\N	\N	260	f	2023-04-14	1648112536000925696.pdf	2024-08-20	\N	\N	\N
972	264	102	2023-10-05	2000000.00	\N	\N	\N	2023-10-10 09:41:19.671	2024-10-02 12:22:37.979	BCDIOF-Unit_Certificate-146205[Ci_ZHANG]20241002.pdf	\N	235 Kooyong Road\t	Elsternwic	VIC	3185	\N	\N	262	f	2023-10-05	1711512192431013888.pdf	2024-09-19	\N	\N	\N
818	101	84	2023-07-06	100000.00	\N	\N	\N	2023-07-06 13:15:56.643	2024-10-18 11:49:05.369	BCDIOF-Unit_Certificate-(45-A)-146079[Autstrip_Pty_Ltd_ATF_Lu_Family_Trust]20241018.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2023-07-06	1678020019783733248.pdf	2023-07-31	\N	\N	\N
267	101	18	2022-11-10	100000.00	\N	\N	\N	2022-11-10 13:42:00.302567	2024-11-21 11:27:25.323	BCDIOF-Unit_Certificate-(6)-146079[Autstrip_Pty_Ltd_ATF_Lu_Family_Trust]20241121.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2022-11-10	\N	2023-12-08	\N	\N	\N
1063	272	104	2023-11-06	100000.00	\N	\N	\N	2023-11-07 11:10:03.374	2023-11-07 11:10:03.374	7b9b2f70-4e86-45a6-93e2-1a86cca77020.pdf	Xiangjiang Wang	Unit 18/1 Kensington St\t	Kogarah\t	NSW\t	2217	\N	\N	269	f	2023-11-06	1721681381962633216.pdf	\N	\N	\N	\N
603	260	44	2023-02-19	100000.00	\N	\N	\N	2023-03-07 15:26:11.741	2023-10-12 11:24:26.878	a135408b-5b25-4162-937f-21665d6a3490.pdf	Wensheng ZENG	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	146088	270	f	2023-02-19	\N	2023-10-06	\N	\N	\N
1361	250	38	2024-06-01	250000.00	\N	\N	\N	2024-06-05 12:28:46.058	2024-06-05 12:28:46.058	dbc5296f-a213-4839-a997-a968a469376f.pdf	\N	3 Pescott Close	BURWOOD 	VIC 	3125	\N	\N	249	f	2024-06-01	\N	2025-02-28	\N	\N	\N
1434	36	38	2024-08-01	250000.00	\N	\N	\N	2024-08-02 16:59:01.184	2024-10-02 10:43:11.13	BCDIOF-Unit_Certificate-146247[Shell_Family_Pty_Ltd_ATF_Shell_Family_Trust]20241002.pdf	\N	42A Paxton Street	Malvern East	VIC	3145	\N	\N	303	f	2024-08-01	\N	2024-09-19	\N	\N	\N
1258	60	37	2024-03-01	730000.00	\N	\N	\N	2024-03-07 09:56:16.302	2024-06-27 16:38:26.24	9ec8340d-0f49-426d-afc5-5d233cb9da68.pdf	\N	601 Blk 3-1, District 2 of 31 Qidaowan Road, Shuimogou, , 	Wulumuqi\t	Xinjiang\tUyghur\tChina\t	830063	\N	\N	176	f	2024-03-01	1765545802832232448.pdf	2024-06-25	\N	\N	\N
1359	124	38	2024-06-01	350000.00	\N	\N	\N	2024-06-05 12:26:27.033	2024-07-12 14:45:13.357	04cf197a-7b65-467b-9f3d-86330510cbb7.pdf	\N	27 Burroughs Road 	Balwyn 	VIC\t	3103	\N	\N	218	f	2024-06-01	\N	2024-07-10	\N	\N	\N
1055	271	102	2023-11-03	2000000.00	\N	\N	\N	2023-11-03 13:52:51.933	2023-11-03 13:52:51.933	27072395-1023-4adc-b7da-3f78e38536bb.pdf	Lei WU and Chang LIU ATF ValueUp 1018 Unit Trust 	 10B El Nido Grove	Carnegie\t	VIC\t	3163	\N	\N	268	f	2023-11-03	\N	2025-05-31	\N	\N	\N
460	260	37	2023-02-03	500000.00	\N	\N	\N	2023-03-03 17:47:36.896	2023-09-08 10:20:44.4	f15d9588-aa7d-4221-a4e4-d21aadb51a43.pdf	Wensheng ZENG	12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	270	f	2023-02-03	1637597014994579456.pdf	2024-02-29	\N	\N	\N
1067	274	38	2023-10-27	250000.00	\N	\N	\N	2023-11-09 14:52:42.385	2023-11-09 14:52:42.385	e75fec89-9e0a-43e4-b303-cf56d9c7c77d.pdf	ACY Holding Pty Ltd	76A TRIMMER PDE\t	SEATON\t	SA\t	5023	\N	\N	272	f	2023-10-27	1722462189424091136.pdf	2024-07-31	\N	\N	\N
1144	101	107	2023-12-13	100000.00	\N	\N	\N	2023-12-13 10:34:37.846	2023-12-13 10:34:37.846	94326152-0fe6-49af-a5d7-1795f29dc72b.pdf	\N	44 Dunstan Parade	Port Melbourne	VIC	3207	\N	\N	252	f	2023-12-13	1734718429870391296.pdf	\N	\N	\N	\N
995	260	44	2023-10-07	90000.00	\N	\N	\N	2023-10-12 11:24:22.78	2023-12-19 11:16:22.421	42eba4c0-13f5-448f-80fd-8bdbac27b02d.pdf	\N	 12 Smythe Avenue	Mont Albert	VIC	3127	\N	\N	270	f	2023-10-07	\N	2023-10-27	\N	\N	\N
1230	30	115	2022-09-15	30000.00	\N	\N	\N	2024-02-20 10:35:48.759	2024-02-20 10:35:48.759	b547b825-da97-4165-8e32-6e91ff8e5257.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2022-09-15	\N	2022-10-14	\N	\N	\N
1231	30	116	2022-09-15	320000.00	\N	\N	\N	2024-02-20 10:40:35.797	2024-02-20 10:41:26.739	cff3cdc5-e817-42ff-befa-4b0f24bfad4c.pdf	\N	27 BURROUGHS ROAD	BALWYN	VIC	3103	\N	\N	138	f	2022-09-15	\N	2022-10-14	\N	\N	\N
1646	304	156	2024-08-09	300000.00	\N	\N	\N	2024-10-24 16:26:08.099	2024-11-05 10:38:08.212	BCDIOF-Unit_Certificate-(A)-145000[Entity_for_Test]20241024.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-08-09	\N	2024-05-02	\N	\N	\N
1281	167	37	2024-03-28	650000.00	\N	\N	\N	2024-04-02 15:04:45.096	2024-04-03 14:29:13.979	09aaf131-34b9-48c3-b1b5-33c84a013155.pdf	\N	11 Parsons Street	Oaklands Park	SA	5046	\N	\N	221	f	2024-03-28	1775364910394359808.jpg	2025-03-31	\N	\N	\N
1307	131	11	2022-08-17	100000.00	\N	\N	\N	2024-04-15 15:27:37.932	2024-04-15 15:28:11.298	1dcaf70b-0107-4b83-b067-1f7f761dfb43.pdf	\N	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	76	f	2022-08-17	\N	2023-10-06	\N	\N	\N
1335	15	38	2024-05-01	250000.00	\N	\N	\N	2024-05-06 10:00:55.239	2024-05-06 10:00:55.239	3a3763b2-3e0d-4ee8-bcc1-f0e0c1324eed.pdf	\N	U 26/25 PARK RD 	HURSTVILLE 	NSW	2220	\N	\N	88	f	2024-05-01	\N	2025-01-31	\N	\N	\N
1172	279	110	2023-12-19	100000.00	\N	\N	\N	2023-12-22 10:03:07.226	2024-05-20 09:17:39.41	14b698d8-4431-43b9-aa5d-8deb3965843a.pdf	\N	2406/33 Mackenzie street	Melbourne 	VIC 	3000	\N	\N	282	f	2023-12-19	\N	2024-05-06	\N	\N	\N
1499	122	37	2024-09-01	500000.00	\N	\N	\N	2024-09-02 12:37:07.129	2024-10-02 11:33:42.294	BCDIOF-Unit_Certificate-146090[Titanium_Titan_Pty_Ltd_ATF_Qin_Self_Managed_Super_Fund]20241002.pdf	\N	235 Kooyong Road	Elsternwick	VIC	3185	\N	\N	219	f	2024-09-01	\N	2024-09-19	\N	\N	\N
1537	211	38	2024-10-01	250000.00	\N	\N	\N	2024-10-02 14:27:13.474	2024-10-02 14:27:13.474	BCDIOF-Unit_Certificate-146167[LIHUA_JIANG_]20241002.pdf	\N	3/226 Belmore Road	Balwyn	VIC	3103	\N	\N	100	f	2024-10-01	\N	2025-06-30	\N	\N	\N
1384	112	131	2024-06-19	110000.00	\N	\N	\N	2024-06-26 14:59:31.143	2024-06-26 14:59:31.143	BCDIOF-Unit_Certificate-(83-B)-146085[SY_Family_Holding_Pty_Ltd_ATF_Song_Family_Trust]20240814.pdf	\N	2a King Edward Street\t	Roseville	NSW 	2069	\N	\N	197	f	2024-06-19	\N	\N	\N	\N	\N
1680	172	156	2024-09-06	510000.00	\N	\N	\N	2024-10-31 14:53:07.952	2024-10-31 14:53:07.952	BCDIOF-Unit_Certificate-(A)-146116[Bo_LI]20241031.pdf	\N	139/120 Sturt St	Southbank	VIC	3006	\N	\N	223	f	2024-09-06	\N	2025-09-30	\N	\N	\N
1066	273	104	2023-11-07	100000.00	\N	\N	\N	2023-11-08 10:27:24.835	2024-08-19 16:50:16.699	BCDIOF-Unit_Certificate-(61)-146212[Yan_Wang]20240819.pdf	\N	6 Bernborough Ave  \t	Balwyn \t	VIC \t	3103	\N	\N	271	f	2023-11-07	1722033038386876416.pdf	2024-08-01	\N	\N	\N
1473	109	141	2024-08-21	100000.00	\N	\N	\N	2024-08-21 16:02:22.889	2024-08-21 16:02:22.889	BCDIOF-Unit_Certificate-(90)-146082[Wuxufamilysuperfund_Pty_Ltd_ATF_Wuxufamilysuperannuation]20240821.pdf	\N	6 Woodlands avenue	Camberwell	VIC	3124	\N	\N	170	f	2024-08-21	\N	\N	\N	\N	\N
1597	304	2	2024-10-20	777777.00	\N	\N	\N	2024-10-20 12:57:34.84	2024-11-05 10:36:51.865	BCDIOF-Unit_Certificate-145000[Entity_for_Test]20241020.pdf	\N	guess	Sub	SAT	0000	\N	\N	320	t	2024-10-20	\N	\N	\N	\N	\N
1408	304	134	2022-07-13	500000.00	\N	\N	\N	2024-07-15 17:21:11.49	2024-11-05 10:37:41.526	2795e298-b671-4aa5-8997-90adc132ebe9.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2022-07-13	\N	2024-06-30	\N	\N	\N
1569	304	149	2024-09-02	100000.00	\N	\N	\N	2024-10-10 17:19:49.489	2024-11-05 10:38:38.297	BCDIOF-Unit_Certificate-(72-A)-000001[TEST_ENTITY]20241010.pdf	\N	TEST	NSW	TEST	0000	\N	\N	311	t	2024-09-02	\N	2024-09-30	\N	\N	\N
1617	304	126	2024-10-22	12345.00	\N	\N	\N	2024-10-22 12:47:15.8	2024-11-05 10:40:27.855	BCDIOF-Unit_Certificate-(78)-146999[test_company]20241022.pdf	\N	lalala	lala	VIC	2111	\N	\N	335	t	2024-10-22	\N	\N	\N	\N	\N
1677	210	158	2024-10-18	300000.00	\N	\N	\N	2024-10-31 14:45:18.632	2024-11-11 10:39:25.792	BCDIOF-Unit_Certificate-(98)-146241[Kaer_Guan]20241111.pdf	\N	9 Derwent Avenue	North Wahroonga	NSW	2076	\N	\N	297	f	2024-10-18	\N	\N	\N	\N	\N
1676	268	158	2024-10-18	300000.00	\N	\N	\N	2024-10-31 14:44:50.083	2024-11-11 10:41:27.482	BCDIOF-Unit_Certificate-(98)-146208[Huanghui_JIANG]20241111.pdf	\N	17 Xiajiang South Road, Xiajiang Village	Beituan Town	Lian Cheng County	Fujian	\N	\N	264	f	2024-10-18	\N	\N	\N	\N	\N
1675	212	158	2024-10-18	100000.00	\N	\N	\N	2024-10-31 14:44:16.464	2024-11-11 10:41:43.916	BCDIOF-Unit_Certificate-(98)-146165[Rex_Investment_Consultants_Limited]20241111.pdf	\N	17 Davington Way	Burswood	Auckland, New Zealand	2013	\N	\N	101	f	2024-10-18	\N	\N	\N	\N	\N
1674	131	158	2024-10-19	100000.00	\N	\N	\N	2024-10-31 14:43:44.828	2024-11-11 10:42:04.004	BCDIOF-Unit_Certificate-(98)-146122[Golden_Life_Super_Investments_Pty_Ltd_ATF_Golden_Life_Superannuation_Fund]20241111.pdf	\N	21 Acheron Ave	Camberwell	VIC	3124	\N	\N	76	f	2024-10-19	\N	\N	\N	\N	\N
1699	316	156	2024-11-20	20000453.00	\N	\N	\N	2024-11-29 17:31:57.409	2024-11-29 17:32:20.705	BCDIOF-Unit_Certificate-(A)-146000[BHG_ONE_PTY_LTD_ATF_Debt_Income_Opportunities_Fund_(BCDIOF)]20241129.pdf	\N	Suite 1001B Level 10, 53 Walker Street	North Sydney	NSW 	2060	\N	\N	332	t	2024-11-01	\N	\N	\N	\N	\N
1704	329	159	2025-03-06	10.00	\N	\N	\N	2025-03-07 10:42:47.769	2025-03-07 10:42:47.769	BCDIOF-Unit_Certificate-(11)-11[333]20250307.pdf	\N	UNIT 1003 152 CITY RD	Darlington	NSW	2016	\N	\N	357	f	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: referral; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referral (referral_id, entity_id, referral_entity_id, rate) FROM stdin;
1	146257	146229	0.1
2	146257	146254	0.1
3	146257	146222	0.1
4	146257	146258	0.1
5	146257	146256	0.1
6	146257	146168	0.1
7	146229	146222	0.1
8	146229	146256	0.1
9	146254	146258	0.1
10	146222	146256	0.1
11	146222	146168	0.1
\.


--
-- Data for Name: referral_structure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referral_structure (id, entity_id, referral_entity_id, root_id) FROM stdin;
1	146257	146229	146257
2	146257	146254	146257
3	146229	146222	146257
4	146254	146258	146257
5	146222	146256	146257
6	146222	146168	146257
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20210705062007
20210705063544
20210705071514
20210705073743
20210705074837
20210705075420
20210705080233
20210706131501
20210706131536
20210707044919
20210707084550
20210714001944
20210714020600
20210719062845
20210816051535
20220111031053
20220113011221
20210831060932
20210901015429
20220323040320
20220323054034
20220324023342
20220325011948
20220329042658
20220405055135
20220406015737
20220406054935
20220411015407
20220414054558
20220414054559
20220420074925
20220421020721
20220701002455
20220809045948
20220812063251
20220819035109
20220523060844
20220524002715
20220524004302
20220601004633
20220601055443
20220601065226
20220609041855
20220722074328
20220725064227
20220823052307
20220823055639
20220823061216
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (tag_id, name, abn) FROM stdin;
1	tag_test_1	123456789
2	tag_test_2	987654321
3	tag_test_3	543216789
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.versions (id, item_type, item_id, event, whodunnit, object, created_at) FROM stdin;
1	Client	1	create	\N	\N	2021-07-14 09:21:10.314112
2	Client	1	update	\N	---email: client@example.comupper_client_id: beaver_id: '0210001'name: Steve Xiaoclient_type: 0country_code: "+61"mobile: '0451901021'birth: 1993-10-21id: 1encrypted_password: "$2a$12$7z3lR7CIzmwQ/Lux1ETMR.ACzlgh1DZnaQ9hilJKsLSIbyic2fjS2"reset_password_token: reset_password_sent_at: sign_in_count: 0salt: a90cfb	2021-07-14 09:22:21.003812
3	Client	2	create	\N	\N	2021-07-14 09:36:22.439742
4	Client	2	update	\N	---email: zhang3@example.comupper_client_id: beaver_id: '0210002'name: 张三client_type: 1country_code: "+61"mobile: '123456789'birth: 1981-07-08id: 2encrypted_password: "$2a$12$SY8Ptn27rSH9qWEE/N9j9OJ9VEhr5ZHyvS4T.SS4NzpD1ruaJUjae"reset_password_token: reset_password_sent_at: sign_in_count: 0salt: '08ddef'	2021-07-14 09:36:52.146509
5	Client	2	update	\N	---email: zhang3@example.comupper_client_id: 210001beaver_id: '0210002'name: 张三client_type: 1country_code: "+61"mobile: '123456789'birth: 1981-07-08id: 2encrypted_password: "$2a$12$SY8Ptn27rSH9qWEE/N9j9OJ9VEhr5ZHyvS4T.SS4NzpD1ruaJUjae"reset_password_token: reset_password_sent_at: sign_in_count: 0salt: '08ddef'	2021-07-14 10:38:10.75252
6	Client	3	create	\N	\N	2021-07-14 11:30:45.719843
7	Client	4	create	\N	\N	2021-07-14 11:32:03.832398
8	Client	5	create	\N	\N	2021-07-14 11:33:18.69829
9	Client	6	create	\N	\N	2021-07-14 11:34:48.131244
11	Client	8	create	\N	\N	2021-08-12 15:01:45.563414
12	Client	8	update	\N	---\nencrypted_password: "$2a$12$TccAt8uBtIKJbQCDzn9VvukTibGZMK42a93NohGJ3s.QHWClR8gCS"\nemail: 123@example.com\nid: 8\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 1\nbeaver_id: ''\nname: 孙某\nclient_type: \ncountry_code: ''\nmobile: ''\nsalt: 0a8f93\nbirth: \n	2021-08-12 15:06:15.451465
13	Client	8	update	\N	---\nemail: 123@example.com\nupper_client_id: 1\nbeaver_id: ''\nname: 孙某\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nid: 8\nencrypted_password: "$2a$12$D1T3.h5gJzItJfqs6FGbUu8f1WSZFv0kIarrq7IZ.p.nbA/yaHWwi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0a8f93\n	2021-08-13 05:12:33.593457
14	Client	12	create	\N	\N	2021-09-09 14:54:59.432641
15	Client	13	create	\N	\N	2021-09-09 14:58:53.34541
16	Client	12	update	\N	---\nencrypted_password: "$2a$12$eBqGi79s.1BQ2vKFmcT83eI8HPZU1I9U/KMJ3VzJgZ1Zw/e/MzgVm"\nemail: 464715045@qq.com\nid: 12\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '005001'\nname: difu xiao\nclient_type: 1\ncountry_code: Australia\nmobile: '0451901021'\nsalt: df362d\nbirth: 2021-09-08\n	2021-09-09 15:05:05.54868
19	Client	14	create	\N	\N	2021-09-30 15:23:31.051255
20	Client	15	create	\N	\N	2021-09-30 15:27:48.076515
21	Client	16	create	\N	\N	2021-09-30 16:13:01.901907
22	Client	17	create	\N	\N	2021-09-30 16:14:58.526241
23	Client	15	update	\N	---\nencrypted_password: "$2a$12$nrbzDCQNRdtR/SiWir43JOXOLpjHfAo6GXSYw2fOjapQWV8xpeZDi"\nemail: jessieljx@qq.com\nid: 15\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 14\nbeaver_id: '005009'\nname: Jessie Liu\nclient_type: 0\ncountry_code: ''\nmobile: '0488334040'\nsalt: d37637\nbirth: 1968-06-22\n	2021-11-01 13:41:04.641053
24	Client	14	update	\N	---\nencrypted_password: "$2a$12$9jh4z5coaK7cB7jVWxdNb.JBeG3dT44ypWAcKj8aE/fCUjcbsWf9e"\nemail: jeffrey.liu@hippowealth.com.au\nid: 14\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '005008'\nname: Jeffrey Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0433886621'\nsalt: 18d962\nbirth: \n	2021-11-01 13:43:48.033298
25	Client	18	create	\N	\N	2021-11-05 13:00:04.586245
26	Client	18	update	\N	---\nencrypted_password: "$2a$12$0mly88XvZG9/npfszGHczOcqKdICkpe6GvcAhhBxLZUmalRWVHM6m"\nemail: bpi99409@163.com\nid: 18\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146023'\nname: Hung Fung Tong\nclient_type: 1\ncountry_code: ''\nmobile: '0451396527'\nsalt: '951795'\nbirth: 1963-09-11\n	2021-11-05 14:00:56.334534
27	Client	19	create	\N	\N	2021-11-08 06:59:20.392035
28	Client	19	update	\N	---\nencrypted_password: "$2a$12$q9VlaFPKG1aWwOj/zChFMuLdb3PnGm7SXn3ppoPPxF8A3W8foJiwm"\nemail: linawang218@hotmail.com\nid: 19\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146025'\nname: Li Wang\nclient_type: 0\ncountry_code: ''\nmobile: '0450560062'\nsalt: '675597'\nbirth: 1989-02-18\n	2021-11-08 07:08:29.094733
29	Client	20	create	\N	\N	2021-11-25 14:10:38.942902
33	Client	20	destroy	\N	---\nid: 20\nemail: tia.niu@beavercapital.com.au\nencrypted_password: "$2a$12$14oBy7AXQ/F461SsGwvoDOM6uqoI4AshiaVmAWw4Ch7SVbHztkLqK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 1\nbeaver_id: '00000900'\nname: Tia\nclient_type: 0\ncountry_code: '2017'\nmobile: '0450638802'\nsalt: '358979'\nbirth: 2021-08-02\n	2021-12-07 10:28:08.69892
34	Client	3	destroy	\N	---\nid: 3\nemail: li4@example.com\nencrypted_password: "$2a$12$AoBRljKTyJjAjwKPSl6WMe6ew6b4Fpi43Vj8rHwXNE3yk.Nuke.0O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 1\nbeaver_id: '0210003'\nname: 李四\nclient_type: 1\ncountry_code: "+61"\nmobile: '123456789'\nsalt: 3faa0b\nbirth: 1985-07-17\n	2021-12-07 10:28:21.831615
35	Client	6	update	\N	---\nupper_client_id: 3\nemail: david@example.com\nid: 6\nencrypted_password: "$2a$12$Blh7PXgG8Y6wrBx4cC1AlebuEQ9Ekup9IQTohfTwdAbB5rT0PGKzu"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nbeaver_id: '0210006'\nname: David\nclient_type: 0\ncountry_code: "+61"\nmobile: '123456789'\nsalt: f4980d\nbirth: 2001-02-07\n	2021-12-08 10:56:37.765933
36	Client	14	update	\N	---\nemail: jeffrey.liu@hippowealth.com.au\nupper_client_id: \nbeaver_id: '005008'\nname: Jeffrey Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0433886621'\nbirth: \nid: 14\nencrypted_password: "$2a$12$5/ymSwZhoOqghJyAPgoa.uEgFIWuw0ISEcWKx0DuV4ltDPQLv5s7S"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 18d962\n	2021-12-08 11:00:32.707886
37	Client	15	update	\N	---\nemail: jessieljx@qq.com\nupper_client_id: 14\nbeaver_id: '005009'\nname: Jessie Liu\nclient_type: 0\ncountry_code: ''\nmobile: '0488334040'\nbirth: 1968-06-22\nid: 15\nencrypted_password: "$2a$12$6rxPR6.UfqMg9qzWZbGEr.5WHEEtsHBRshC2BGwfohXoJ3sbXRGrG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d37637\n	2021-12-08 11:01:13.177487
38	Client	1	destroy	\N	---\nid: 1\nemail: steve.xiao@beavercapital.com.au\nencrypted_password: "$2a$12$7z3lR7CIzmwQ/Lux1ETMR.ACzlgh1DZnaQ9hilJKsLSIbyic2fjS2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '0210001'\nname: Steve Xiao\nclient_type: 0\ncountry_code: "+61"\nmobile: '0451901021'\nsalt: a90cfb\nbirth: 1993-10-21\n	2021-12-08 11:01:32.591427
39	Client	2	destroy	\N	---\nid: 2\nemail: zhang3@example.com\nencrypted_password: "$2a$12$SY8Ptn27rSH9qWEE/N9j9OJ9VEhr5ZHyvS4T.SS4NzpD1ruaJUjae"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '0210002'\nname: 张三\nclient_type: 1\ncountry_code: "+61"\nmobile: '123456789'\nsalt: '08ddef'\nbirth: 1981-07-08\n	2021-12-08 11:37:33.019129
40	Client	4	destroy	\N	---\nid: 4\nemail: liu@example.com\nencrypted_password: "$2a$12$/6kFy8e3c3gQtWHR.mwTHeJ5eWJpVgPrXpN5SwaPizzbrCIJOrMy."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '0210004'\nname: 刘某\nclient_type: 0\ncountry_code: "+61"\nmobile: '123456789'\nsalt: 0f9e27\nbirth: 1991-09-19\n	2021-12-08 11:37:37.587474
41	Client	5	destroy	\N	---\nid: 5\nemail: zhang@example.com\nencrypted_password: "$2a$12$mHcbu.3FtIwYw.H5AuSmIeKQW/eEP3zr5BzAaEHZCpA8ja04gBONm"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '0210005'\nname: 张某\nclient_type: 0\ncountry_code: "+61"\nmobile: '123456789'\nsalt: 2a1068\nbirth: 1993-12-23\n	2021-12-08 11:37:41.896892
42	Client	6	destroy	\N	---\nid: 6\nemail: david@example.com\nencrypted_password: "$2a$12$Blh7PXgG8Y6wrBx4cC1AlebuEQ9Ekup9IQTohfTwdAbB5rT0PGKzu"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '0210006'\nname: David\nclient_type: 0\ncountry_code: "+61"\nmobile: '123456789'\nsalt: f4980d\nbirth: 2001-02-07\n	2021-12-08 11:37:46.148155
43	Client	8	destroy	\N	---\nid: 8\nemail: 123@example.com\nencrypted_password: "$2a$12$D1T3.h5gJzItJfqs6FGbUu8f1WSZFv0kIarrq7IZ.p.nbA/yaHWwi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: 孙某\nclient_type: 0\ncountry_code: ''\nmobile: ''\nsalt: 0a8f93\nbirth: \n	2021-12-08 11:37:49.529033
44	Client	12	destroy	\N	---\nid: 12\nemail: 464715045@qq.com\nencrypted_password: "$2a$12$bxNcSSkB6TPiFeQHoNJsV.7d7GkTPcjRcyU0mlnvnnxcSTpk.MR8i"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '005001'\nname: difu xiao\nclient_type: 1\ncountry_code: Australia\nmobile: '0451901021'\nsalt: df362d\nbirth: 2021-09-08\n	2021-12-08 11:37:53.582877
45	Client	13	destroy	\N	---\nid: 13\nemail: 1234@example.com\nencrypted_password: "$2a$12$kqcgNmaZFEqG2wO/YFVkI.RR0ZtwiD160k.DT8OKMvluroQdM4l/6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: lili\nclient_type: 0\ncountry_code: ''\nmobile: ''\nsalt: 2c5889\nbirth: \n	2021-12-08 11:38:00.205406
46	Client	14	update	\N	---\nencrypted_password: "$2a$12$5/ymSwZhoOqghJyAPgoa.uEgFIWuw0ISEcWKx0DuV4ltDPQLv5s7S"\nemail: jeffrey.liu@hippowealth.com.au\nid: 14\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146022'\nname: Jeffrey Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0433886621'\nsalt: 18d962\nbirth: \n	2021-12-08 11:38:27.110639
47	Client	14	update	\N	---\nencrypted_password: "$2a$12$DTFiuOUE3wFLRR6nHDQLPOm4IoLG51IeazJlQZxPOCZvdFqJaWjWi"\nemail: jeffrey.liu@hippowealth.com.au\nid: 14\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146022'\nname: Jeffrey Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0433886621'\nsalt: 18d962\nbirth: \n	2021-12-08 11:38:42.75733
48	Client	21	create	\N	\N	2021-12-08 11:45:28.381461
49	Client	21	update	\N	---\nencrypted_password: "$2a$12$832rxBXojzk8Ma4lOCcce.hpcAZtMQjZLC8cRTvG907JgaRtni7dG"\nemail: invincibleandy@hotmail.com\nid: 21\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 14\nbeaver_id: '146028'\nname: Yanchi Wu\nclient_type: 0\ncountry_code: ''\nmobile: '0452366998'\nsalt: '593554'\nbirth: \n	2021-12-08 11:49:51.903251
50	Client	22	create	\N	\N	2021-12-13 07:29:19.791128
51	Client	22	update	\N	---\nemail: tia.niu@beavercapital.com.au\nupper_client_id: \nbeaver_id: '00000900'\nname: ''\nclient_type: 0\ncountry_code: ''\nmobile: ''\nbirth: \nid: 22\nencrypted_password: "$2a$12$GDobG/qY238b1qJwd1ogjOIyjd7dzKM/fkUvKrOg5en0r9bd1wXpG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '747921'\n	2021-12-13 07:33:21.410383
52	Client	23	create	\N	\N	2021-12-13 08:51:56.786106
53	Client	24	create	\N	\N	2021-12-13 09:37:18.299754
54	Client	24	update	\N	---\nemail: jason.wang@aufci.com\nupper_client_id: \nbeaver_id: '146030'\nname: Junguo Wang\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0430166819'\nbirth: \nid: 24\nencrypted_password: "$2a$12$JbFUS5OJCDcFNZVkjX01CuADvqHkwTk/Tg8./FABJ9Qq80dwlxdjK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b1eaab\n	2021-12-14 09:57:30.309242
55	Client	25	create	\N	\N	2021-12-15 07:19:17.257092
56	Client	17	update	\N	---\nemail: brianguo8283@gmail.com\nupper_client_id: \nbeaver_id: '005011'\nname: Zixuan Guo\nclient_type: 1\ncountry_code: ''\nmobile: '0426836189'\nbirth: \nid: 17\nencrypted_password: "$2a$12$zGSugN.TyQP.yY7pNriQ1OxohTJs.JTceEkbMUiu9h8xP0kHLovH6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 2f52fa\n	2021-12-15 07:19:51.325865
57	Client	26	create	\N	\N	2021-12-15 08:21:51.88944
58	Client	27	create	\N	\N	2021-12-15 11:55:14.155572
59	Client	28	create	\N	\N	2021-12-16 14:59:40.832529
60	Client	29	create	\N	\N	2021-12-16 15:01:01.219605
61	Client	28	update	\N	---\nemail: boxing.han@hotmail.com\nupper_client_id: \nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 1\ncountry_code: ''\nmobile: '0450029266'\nbirth: \nid: 28\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2c8cd\n	2021-12-16 15:01:19.539143
62	Client	30	create	\N	\N	2021-12-16 15:02:31.839463
63	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 29\nbeaver_id: '146035'\nname: ''\nclient_type: 1\ncountry_code: ''\nmobile: '0406779863'\nbirth: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\n	2021-12-16 15:03:08.709213
64	Client	31	create	\N	\N	2021-12-16 15:04:41.071024
65	Client	32	create	\N	\N	2021-12-16 15:06:05.552993
66	Client	33	create	\N	\N	2021-12-16 15:07:19.176994
67	Client	34	create	\N	\N	2021-12-16 15:08:50.003094
68	Client	34	update	\N	---\nencrypted_password: "$2a$12$4tHIKxVG47erWlasSc/EAOpdrAcIpVEAkcBbJWjk/xXdpWiFiGGje"\nemail: chunnianding@gmail.com\nid: 34\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146040'\nname: Chunnian Ding\nclient_type: 1\ncountry_code: ''\nmobile: '0409703433'\nsalt: 909dc8\nbirth: \n	2021-12-17 09:57:26.765892
69	Client	35	create	\N	\N	2021-12-21 18:36:51.434156
70	Client	36	create	\N	\N	2022-01-10 07:32:17.72097
71	Client	16	destroy	\N	---\nid: 16\nemail: jasmine.starsea@gmail.com\nencrypted_password: "$2a$12$hbQm4FdByNP8GvqaeblcQu7NlHRRJFqRla/1XG7EQCoArg1iRj0XO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '005010'\nname: Weiyang Zhou\nclient_type: 1\ncountry_code: ''\nmobile: '0406184666'\nsalt: 9b7185\nbirth: \n	2022-01-10 14:18:43.329268
72	Client	37	create	\N	\N	2022-01-10 14:44:09.743676
73	Client	22	update	\N	---\nemail: tianyaon@163.com\nupper_client_id: \nbeaver_id: '00000900'\nname: Tia Niu\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0450638802'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 22\nencrypted_password: "$2a$12$GDobG/qY238b1qJwd1ogjOIyjd7dzKM/fkUvKrOg5en0r9bd1wXpG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '747921'\n	2022-01-11 13:36:36.292816
74	Client	22	update	\N	---\nemail: tianyaon@163.com\nupper_client_id: 14\nbeaver_id: '00000900'\nname: Tia Niu\nclient_type: 1\ncountry_code: 澳大利亚\nmobile: '0450638802'\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nid: 22\nencrypted_password: "$2a$12$GDobG/qY238b1qJwd1ogjOIyjd7dzKM/fkUvKrOg5en0r9bd1wXpG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '747921'\n	2022-01-11 13:38:24.053704
75	Client	22	update	\N	---\nemail: tianyaon@163.com\nupper_client_id: 22\nbeaver_id: '00000900'\nname: Tia Niu\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0450638802'\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nid: 22\nencrypted_password: "$2a$12$GDobG/qY238b1qJwd1ogjOIyjd7dzKM/fkUvKrOg5en0r9bd1wXpG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '747921'\n	2022-01-11 13:39:38.288908
76	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: \nbeaver_id: '146043'\nname: Lin Tan\nclient_type: \ncountry_code: ''\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: \naccount_name: \naccount_number: \nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\n	2022-01-12 11:54:15.276403
77	Client	36	update	\N	---\nemail: 380817544@qq.com\nupper_client_id: 29\nbeaver_id: '146042'\nname: Chang Qin\nclient_type: 1\ncountry_code: ''\nmobile: '0484191561'\nbirth: 1973-10-14\nbsb: \naccount_name: \naccount_number: \nid: 36\nencrypted_password: "$2a$12$HaKHCRMJzthpRLwoqQFq1u1oxHxqqQZwunfd4L/8eGEpIlw.sB9Pi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '592097'\n	2022-01-12 11:56:14.267212
78	Client	35	update	\N	---\nemail: wanyp@yahoo.com\nupper_client_id: 29\nbeaver_id: '146041'\nname: Yuping Wan\nclient_type: 1\ncountry_code: ''\nmobile: '0481991606'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 35\nencrypted_password: "$2a$12$pfZB4W1YgFVIeG0gDj7ToOsvAxXCySLKCdXbJVbNoSHV7lGI3a0X6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0c971d\n	2022-01-12 11:57:40.69329
79	Client	34	update	\N	---\nemail: chunnianding@gmail.com\nupper_client_id: 29\nbeaver_id: '146040'\nname: Chunnian Ding\nclient_type: 1\ncountry_code: ''\nmobile: '0409703433'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 34\nencrypted_password: "$2a$12$WH4aF8otGtxc9OfPx7cH..JdMQzH2.kF7yDHo3PthBfoES3ETWe3q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 909dc8\n	2022-01-12 11:58:10.572838
80	Client	33	update	\N	---\nemail: lanwatts3@gmail.com\nupper_client_id: 29\nbeaver_id: '146039'\nname: Minglan Chen\nclient_type: 1\ncountry_code: ''\nmobile: '0430032484'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 33\nencrypted_password: "$2a$12$XKLvOKd5kWDDrkm5TwCpZ.r4Z73OVL5b6JTxk4o2ZgXTIC6I1geBa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 66b4cf\n	2022-01-12 11:58:40.303744
81	Client	31	update	\N	---\nemail: cizhang2017@foxmail.com\nupper_client_id: 29\nbeaver_id: '146037'\nname: Ci Zhang\nclient_type: 1\ncountry_code: ''\nmobile: '0481735199'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 31\nencrypted_password: "$2a$12$1fROJsjVNQAkdd5vsLZKC.yHSjH8.qbR5sRkdnUna2JasjWI.PcFO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f02cb8\n	2022-01-12 11:59:13.64187
82	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 29\nbeaver_id: '146035'\nname: Yijun Sun\nclient_type: 1\ncountry_code: ''\nmobile: '0406779863'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\n	2022-01-12 11:59:59.765463
83	Client	29	update	\N	---\nemail: changfamily608@gmail.com\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0430086816'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 29\nencrypted_password: "$2a$12$d5.1abl5ukfxC68qi6G3.OahixFrXOj.C4VHkw0oHmbAuFSLdonxS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9624b\n	2022-01-12 12:00:40.454026
84	Client	28	update	\N	---\nemail: boxing.han@hotmail.com\nupper_client_id: 29\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 1\ncountry_code: ''\nmobile: '0450029266'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 28\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2c8cd\n	2022-01-12 12:01:27.146955
85	Client	15	update	\N	---\nemail: jessieljx@qq.com\nupper_client_id: 14\nbeaver_id: '146021'\nname: Jessie Liu\nclient_type: 0\ncountry_code: ''\nmobile: '0488334040'\nbirth: 1968-06-22\nbsb: \naccount_name: \naccount_number: \nid: 15\nencrypted_password: "$2a$12$6rxPR6.UfqMg9qzWZbGEr.5WHEEtsHBRshC2BGwfohXoJ3sbXRGrG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d37637\n	2022-01-12 12:03:25.265255
86	Client	14	update	\N	---\nemail: jeffrey.liu@hippowealth.com.au\nupper_client_id: \nbeaver_id: '146022'\nname: Jeffrey Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0433886621'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 14\nencrypted_password: "$2a$12$kwgT50H2lbYyfArpeZ7yzee1DTYC.gS7oncY6Rhx.NE1QIp97//wi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 18d962\n	2022-01-12 12:04:04.872922
87	Client	18	update	\N	---\nemail: bpi99409@163.com\nupper_client_id: \nbeaver_id: '146023'\nname: Hung Fung Tong\nclient_type: 1\ncountry_code: ''\nmobile: '0451396527'\nbirth: 1963-09-11\nbsb: \naccount_name: \naccount_number: \nid: 18\nencrypted_password: "$2a$12$8/6mrI.UOSwZHrh9g.1pM.1.1UZnTF4nG/RFlBOhqww27ytGkL63e"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '951795'\n	2022-01-12 12:18:45.664631
88	Client	19	update	\N	---\nemail: linawang218@hotmail.com\nupper_client_id: \nbeaver_id: '146025'\nname: Li Wang\nclient_type: 0\ncountry_code: ''\nmobile: '0450560062'\nbirth: 1989-02-18\nbsb: \naccount_name: \naccount_number: \nid: 19\nencrypted_password: "$2a$12$tfuGo8T9/1b8/FsuoSa.qe7a.veVEJHDJLPiy65WDdA85GeB3S.qa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '675597'\n	2022-01-12 12:19:42.255527
89	Client	21	update	\N	---\nemail: invincibleandy@hotmail.com\nupper_client_id: 14\nbeaver_id: '146028'\nname: Yanchi Wu\nclient_type: 0\ncountry_code: ''\nmobile: '0452366998'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 21\nencrypted_password: "$2a$12$JGA7YKtGX9bfQosnADa5euURerD00GEBiFKswYJXHzJLBKNEBNxwW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '593554'\n	2022-01-12 12:20:28.255694
90	Client	23	update	\N	---\nemail: nathancx86@gmail.com\nupper_client_id: 14\nbeaver_id: '146029'\nname: Xi Chen\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0401535201'\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 23\nencrypted_password: "$2a$12$eWDhzEwjuULQUEthx6Wy2ezt9YLr0IzTDBjgvB7QO.WpoLuAVKKiy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 6f683b\n	2022-01-12 12:21:39.990794
91	Client	22	destroy	\N	---\nid: 22\nemail: tianyaon@163.com\nencrypted_password: "$2a$12$GDobG/qY238b1qJwd1ogjOIyjd7dzKM/fkUvKrOg5en0r9bd1wXpG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '00000900'\nname: Tia Niu\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0450638802'\nsalt: '747921'\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\n	2022-01-12 13:13:04.81773
92	Client	38	create	\N	\N	2022-01-13 12:30:10.95546
93	Client	38	update	\N	---\nemail: xuefhan@hotmail.com\nupper_client_id: \nbeaver_id: '146044'\nname: Xue Han\nclient_type: \ncountry_code: ''\nmobile: '0410006678'\nbirth: 1979-03-09\nbsb: 732-135\naccount_name: Christina Han\naccount_number: '833169'\nid: 38\nencrypted_password: "$2a$12$XDqf.HgyX.nWfST7b8rVbuPcqg0JBBY0t26JjTtdmSH28ST/COtja"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8aeb86\n	2022-01-13 12:32:29.287277
94	Client	39	create	\N	\N	2022-01-14 06:40:08.716554
95	Client	27	update	\N	---\nemail: zhigang.u@foxmail.com\nupper_client_id: \nbeaver_id: ''\nname: Henry Yu\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nbsb: \naccount_name: \naccount_number: \nid: 27\nencrypted_password: "$2a$12$c7iZxWkhsU/nAs5/WkUiD.e.k98WczHV3D2gVm/ls/sdg3632ltTe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5553db\n	2022-01-14 09:15:38.482924
96	Client	40	create	\N	\N	2022-01-18 08:17:46.420215
97	Client	41	create	\N	\N	2022-01-18 11:51:56.751766
98	Client	44	create	\N	\N	2022-01-25 08:45:33.868535
99	Client	45	create	\N	\N	2022-01-28 17:59:26.865098
100	Client	46	create	\N	\N	2022-01-28 18:15:10.594069
101	Client	46	update	\N	---\nemail: zhou.yinhui@gmail.com\nupper_client_id: 14\nbeaver_id: '146046'\nname: Yinhui Zhou\nclient_type: 1\ncountry_code: ''\nmobile: '0421505234'\nbirth: 1986-02-21\nbsb: 062-475\naccount_name: XIAOYIN FAMILY TRUST\naccount_number: '10338006'\nend_date: \nid: 46\nencrypted_password: "$2a$12$jsYUAyL4N6kYxnacTMNgE.DS.N3OM8FSrrya3itEzgiuUemkCMFcK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ba0ae9\n	2022-02-04 08:39:48.754256
102	Client	45	update	\N	---\nemail: jerryyanchao77@gmail.com\nupper_client_id: 29\nbeaver_id: '146045'\nname: Yanchao Yang\nclient_type: 1\ncountry_code: ''\nmobile: '0414153421'\nbirth: 1995-09-01\nbsb: '083-019'\naccount_name: Yanchao Yang\naccount_number: '471967971'\nend_date: \nid: 45\nencrypted_password: "$2a$12$0Xkh51VvKFqizUYKGm/6muRVvaHxUz5ScLmBVZdhxnWcDwocgkthq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 14b152\n	2022-02-04 08:40:03.731301
103	Client	36	update	\N	---\nemail: 380817544@qq.com\nupper_client_id: 29\nbeaver_id: '146042'\nname: Chang Qin\nclient_type: 1\ncountry_code: ''\nmobile: '0484191561'\nbirth: 1973-10-14\nbsb: 063-109\naccount_name: Chang Qin\naccount_number: '11687388'\nend_date: \nid: 36\nencrypted_password: "$2a$12$HaKHCRMJzthpRLwoqQFq1u1oxHxqqQZwunfd4L/8eGEpIlw.sB9Pi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '592097'\n	2022-02-04 08:40:29.363223
104	Client	28	update	\N	---\nemail: boxing.han@hotmail.com\nupper_client_id: 29\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 1\ncountry_code: ''\nmobile: '0450029266'\nbirth: \nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \nid: 28\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2c8cd\n	2022-02-04 08:59:39.376503
105	Client	29	update	\N	---\nemail: changfamily608@gmail.com\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0430086816'\nbirth: \nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \nid: 29\nencrypted_password: "$2a$12$d5.1abl5ukfxC68qi6G3.OahixFrXOj.C4VHkw0oHmbAuFSLdonxS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9624b\n	2022-02-04 12:27:02.649968
106	Client	35	update	\N	---\nemail: wanyp@yahoo.com\nupper_client_id: 29\nbeaver_id: '146041'\nname: Yuping Wan\nclient_type: 1\ncountry_code: ''\nmobile: '0481991606'\nbirth: \nbsb: '085-458'\naccount_name: Yu Ping Wan\naccount_number: '452488246'\nend_date: \nid: 35\nencrypted_password: "$2a$12$pfZB4W1YgFVIeG0gDj7ToOsvAxXCySLKCdXbJVbNoSHV7lGI3a0X6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0c971d\n	2022-02-04 12:27:18.276096
107	Client	33	update	\N	---\nemail: lanwatts3@gmail.com\nupper_client_id: 29\nbeaver_id: '146039'\nname: Minglan Chen\nclient_type: 1\ncountry_code: ''\nmobile: '0430032484'\nbirth: \nbsb: 063-154\naccount_name: Calm & Harmony Pty Ltd Trustee For Forever Young Superfund\naccount_number: '10791817'\nend_date: \nid: 33\nencrypted_password: "$2a$12$XKLvOKd5kWDDrkm5TwCpZ.r4Z73OVL5b6JTxk4o2ZgXTIC6I1geBa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 66b4cf\n	2022-02-04 12:27:32.91815
108	Client	31	update	\N	---\nemail: cizhang2017@foxmail.com\nupper_client_id: 29\nbeaver_id: '146037'\nname: Ci Zhang\nclient_type: 1\ncountry_code: ''\nmobile: '0481735199'\nbirth: \nbsb: 033-172\naccount_name: Oasisun Management Pty Ltd ATF Sean Family Trust\naccount_number: '914168'\nend_date: \nid: 31\nencrypted_password: "$2a$12$1fROJsjVNQAkdd5vsLZKC.yHSjH8.qbR5sRkdnUna2JasjWI.PcFO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f02cb8\n	2022-02-04 12:27:51.919787
109	Client	34	update	\N	---\nemail: chunnianding@gmail.com\nupper_client_id: 29\nbeaver_id: '146040'\nname: Chunnian Ding\nclient_type: 1\ncountry_code: ''\nmobile: '0409703433'\nbirth: \nbsb: 733-173\naccount_name: Chunnian Ding\naccount_number: '644056'\nend_date: \nid: 34\nencrypted_password: "$2a$12$WH4aF8otGtxc9OfPx7cH..JdMQzH2.kF7yDHo3PthBfoES3ETWe3q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 909dc8\n	2022-02-04 12:28:21.548622
110	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 29\nbeaver_id: '146035'\nname: Yijun Sun\nclient_type: 1\ncountry_code: ''\nmobile: '0406779863'\nbirth: \nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\n	2022-02-04 12:28:37.95889
111	Client	47	create	\N	\N	2022-02-07 08:38:10.612159
112	Client	38	update	\N	---\nemail: xuefhan@hotmail.com\nupper_client_id: \nbeaver_id: '146044'\nname: Christina Han\nclient_type: \ncountry_code: ''\nmobile: '0410006678'\nbirth: 1979-03-09\nbsb: 732-135\naccount_name: Christina Han\naccount_number: '833169'\nend_date: \nid: 38\nencrypted_password: "$2a$12$XDqf.HgyX.nWfST7b8rVbuPcqg0JBBY0t26JjTtdmSH28ST/COtja"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8aeb86\n	2022-02-07 09:40:11.046932
113	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: \nbeaver_id: '146043'\nname: Lin Tan\nclient_type: \ncountry_code: ''\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-190\naccount_name: Lin Tan\naccount_number: '10557239'\nend_date: \nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\n	2022-02-07 09:42:44.660159
114	Client	48	create	\N	\N	2022-02-07 09:46:49.191472
115	Client	48	update	\N	---\nemail: lisunshine2008@126.com\nupper_client_id: \nbeaver_id: '146027'\nname: Yang LI\nclient_type: 0\ncountry_code: ''\nmobile: '0410073777'\nbirth: \nbsb: 980-205\naccount_name: admin@example.com\naccount_number: '900172140'\nend_date: \nid: 48\nencrypted_password: "$2a$12$lGZjIi6ufg6ipRsVw2kORuljv4/.rlMWNqbYEX0YbO6xczUN3xv.y"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: da0fa7\n	2022-02-07 09:47:02.670508
116	Client	29	update	\N	---\nid: 29\nemail: changfamily608@gmail.com\nencrypted_password: "$2a$12$d5.1abl5ukfxC68qi6G3.OahixFrXOj.C4VHkw0oHmbAuFSLdonxS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 0\ncountry_code: ''\nmobile: '0430086816'\nsalt: c9624b\nbirth: \nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \n	2022-02-07 14:55:00.83144
117	Client	35	update	\N	---\nemail: wanyp@yahoo.com\nupper_client_id: 29\nbeaver_id: '146041'\nname: Yuping Wan\nclient_type: 0\ncountry_code: ''\nmobile: '0481991606'\nbirth: \nbsb: '085-458'\naccount_name: Yu Ping Wan\naccount_number: '452488246'\nend_date: \nid: 35\nencrypted_password: "$2a$12$pfZB4W1YgFVIeG0gDj7ToOsvAxXCySLKCdXbJVbNoSHV7lGI3a0X6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0c971d\n	2022-02-09 13:42:46.392147
118	Client	24	update	\N	---\nemail: jason.wang@aufci.com\nupper_client_id: \nbeaver_id: '146030'\nname: Junguo Wang\nclient_type: 1\ncountry_code: 澳大利亚\nmobile: '0430166819'\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \nid: 24\nencrypted_password: "$2a$12$JbFUS5OJCDcFNZVkjX01CuADvqHkwTk/Tg8./FABJ9Qq80dwlxdjK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b1eaab\n	2022-02-10 14:41:53.960619
119	Client	24	update	\N	---\nemail: jason.wang@aufci.com\nupper_client_id: 14\nbeaver_id: '146030'\nname: Junguo Wang\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0430166819'\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \nid: 24\nencrypted_password: "$2a$12$JbFUS5OJCDcFNZVkjX01CuADvqHkwTk/Tg8./FABJ9Qq80dwlxdjK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b1eaab\n	2022-02-10 14:47:06.603794
120	Client	49	create	\N	\N	2022-02-10 14:56:01.703338
121	Client	49	update	\N	---\nemail: jason.xu@boanco.com.au\nupper_client_id: 14\nbeaver_id: '146048'\nname: Jason XU\nclient_type: 0\ncountry_code: ''\nmobile: '0430013996'\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \nid: 49\nencrypted_password: "$2a$12$rAu8d8c108678mihWLSaLO/yzEPe.YLpLMFowW0jwyCuHRtBshCYe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 6b55f3\n	2022-02-14 12:57:26.236302
122	Client	50	create	\N	\N	2022-02-16 08:22:30.583418
123	Client	32	update	\N	---\nemail: wulei_1@hotmail.com\nupper_client_id: 29\nbeaver_id: '146038'\nname: Lei Wu\nclient_type: 1\ncountry_code: ''\nmobile: '0449896346'\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \nid: 32\nencrypted_password: "$2a$12$lDIG1eKjlGByV5RRvo2Zm.KR7y.hfC4IRXv4I7roHMzpKS80Cgcd2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ef4ae8\n	2022-02-16 08:27:36.51895
124	Client	47	update	\N	---\nemail: libingdi@163.com\nupper_client_id: 38\nbeaver_id: '146047'\nname: Yufeng Lu& Bingdi Li\nclient_type: 0\ncountry_code: ''\nmobile: '0421952353'\nbirth: \nbsb: 733-073\naccount_name: Yufeng Lu& Bingdi Li\naccount_number: '847788'\nend_date: \nid: 47\nencrypted_password: "$2a$12$xaCZ6I7tdpPutYh96Mt1d.nhHcRKR65FxwfN/6PgAl6Bu4gRHzSU2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 1ddb53\n	2022-02-16 08:27:51.578028
125	Client	45	update	\N	---\nemail: jerryyanchao77@gmail.com\nupper_client_id: 29\nbeaver_id: '146045'\nname: Yanchao Yang\nclient_type: 0\ncountry_code: ''\nmobile: '0414153421'\nbirth: 1995-09-01\nbsb: '083-019'\naccount_name: Yanchao Yang\naccount_number: '471967971'\nend_date: \nid: 45\nencrypted_password: "$2a$12$0Xkh51VvKFqizUYKGm/6muRVvaHxUz5ScLmBVZdhxnWcDwocgkthq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 14b152\n	2022-02-16 08:28:04.345044
126	Client	51	create	\N	\N	2022-02-18 13:17:36.001122
127	Client	51	update	\N	---\nemail: christinemelbar@gmail.com\nupper_client_id: \nbeaver_id: '146049'\nname: Ling HUANG\nclient_type: \ncountry_code: ''\nmobile: '0411587938'\nbirth: \nbsb: 012-406\naccount_name: ARVOR Superannuation Fund\naccount_number: '228286324'\nend_date: \nid: 51\nencrypted_password: "$2a$12$7xJ85ciuQfXNGUmLK/ZeeuKtgbmuqoaKALj6EDr4LOo5X/JJPywo2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b41dd6\n	2022-02-18 13:18:09.935895
128	Client	52	create	\N	\N	2022-02-18 13:19:41.128732
129	Client	52	update	\N	---\nemail: ling.abid@gmail.com\nupper_client_id: \nbeaver_id: '146049'\nname: Ling YUAN\nclient_type: \ncountry_code: ''\nmobile: '0452181678'\nbirth: 1971-06-25\nbsb: '083-343 '\naccount_name: Ling YUAN\naccount_number: '187071326'\nend_date: \nid: 52\nencrypted_password: "$2a$12$PR2JV4qWVoB99OsrMQtxAO/wJXQT6OU1aYKXzs1jPDblELNBPAScq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8f5edd\n	2022-02-18 13:21:27.032908
130	Client	51	update	\N	---\nemail: christinemelbar@gmail.com\nupper_client_id: \nbeaver_id: '146050'\nname: Ling HUANG\nclient_type: \ncountry_code: ''\nmobile: '0411587938'\nbirth: \nbsb: 012-406\naccount_name: ARVOR Superannuation Fund\naccount_number: '228286324'\nend_date: \nid: 51\nencrypted_password: "$2a$12$7xJ85ciuQfXNGUmLK/ZeeuKtgbmuqoaKALj6EDr4LOo5X/JJPywo2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b41dd6\n	2022-02-18 13:21:38.537544
131	Client	53	create	\N	\N	2022-02-22 11:51:48.209508
132	Client	52	update	\N	---\nemail: ling.abid@gmail.com\nupper_client_id: \nbeaver_id: '146050'\nname: Ling YUAN\nclient_type: \ncountry_code: ''\nmobile: '0452181678'\nbirth: 1971-06-25\nbsb: '083-343 '\naccount_name: Ling YUAN\naccount_number: '187071326'\nend_date: \nid: 52\nencrypted_password: "$2a$12$PR2JV4qWVoB99OsrMQtxAO/wJXQT6OU1aYKXzs1jPDblELNBPAScq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8f5edd\n	2022-02-22 11:56:51.065789
133	Client	54	create	\N	\N	2022-03-23 08:55:57.721103
134	Client	54	update	\N	---\nemail: ryan@ppta.com.au\nupper_client_id: \nbeaver_id: '146053'\nname: Yu PEI (Ryan)\nclient_type: 0\ncountry_code: '61'\nmobile: '0433129566'\nbirth: 1979-08-11\nbsb: '082356'\naccount_name: LYNK Tech Pty Ltd\naccount_number: '359670721'\nend_date: 2022-12-31\nid: 54\nencrypted_password: "$2a$12$Lx.bvD4thRDxSL.zVokrHOaasO7SAVzfcgI64ZcltY80M5IR91dWi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 371f8c\n	2022-03-23 09:16:57.093731
135	Client	54	update	\N	---\nemail: ryan@ppta.com.au\nupper_client_id: 54\nbeaver_id: '146053'\nname: Yu PEI (Ryan)\nclient_type: 0\ncountry_code: '61'\nmobile: '0433129566'\nbirth: 1979-08-11\nbsb: '082356'\naccount_name: LYNK Tech Pty Ltd\naccount_number: '359670721'\nend_date: 2022-12-31\nid: 54\nencrypted_password: "$2a$12$Lx.bvD4thRDxSL.zVokrHOaasO7SAVzfcgI64ZcltY80M5IR91dWi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 371f8c\n	2022-03-23 09:18:01.765725
136	Client	54	update	\N	---\nemail: ryan@ppta.com.au\nupper_client_id: 54\nbeaver_id: '146053'\nname: Yu PEI (Ryan)\nclient_type: 1\ncountry_code: '61'\nmobile: '0433129566'\nbirth: 1979-08-11\nbsb: '082356'\naccount_name: LYNK Tech Pty Ltd\naccount_number: '359670721'\nend_date: 2022-12-31\nid: 54\nencrypted_password: "$2a$12$Lx.bvD4thRDxSL.zVokrHOaasO7SAVzfcgI64ZcltY80M5IR91dWi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 371f8c\n	2022-03-23 09:19:31.564311
137	Client	55	create	\N	\N	2022-03-23 09:34:13.435681
138	Client	54	update	\N	---\nemail: ryan@ppta.com.au\nupper_client_id: \nbeaver_id: '146053'\nname: Yu PEI (Ryan)\nclient_type: 0\ncountry_code: '61'\nmobile: '0433129566'\nbirth: 1979-08-11\nbsb: '082356'\naccount_name: LYNK Tech Pty Ltd\naccount_number: '359670721'\nend_date: 2022-12-31\nid: 54\nencrypted_password: "$2a$12$Lx.bvD4thRDxSL.zVokrHOaasO7SAVzfcgI64ZcltY80M5IR91dWi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 371f8c\n	2022-03-23 09:34:49.581807
139	Client	55	update	\N	---\nemail: rainpei@hotmail.com\nupper_client_id: 54\nbeaver_id: ''\nname: Paramount Tax - Yu PEI Partner\nclient_type: 1\ncountry_code: "+61 "\nmobile: '433129566'\nbirth: 2022-08-11\nbsb: '062223 '\naccount_name: operations@beavercapital.com.au\naccount_number: '11181711'\nend_date: \nid: 55\nencrypted_password: "$2a$12$rNBR8OEl6Ywbk3Kx6YivEOn0iz6MeuV5jIXlRo5d2OiJvP2Bu6VQi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: fcf00c\n	2022-03-23 09:35:06.636484
140	Client	55	update	\N	---\nemail: rainpei@hotmail.com\nupper_client_id: \nbeaver_id: ''\nname: Paramount Tax - Yu PEI Partner\nclient_type: 0\ncountry_code: "+61 "\nmobile: '433129566'\nbirth: 2022-08-11\nbsb: '062223 '\naccount_name: operations@beavercapital.com.au\naccount_number: '11181711'\nend_date: \nid: 55\nencrypted_password: "$2a$12$rNBR8OEl6Ywbk3Kx6YivEOn0iz6MeuV5jIXlRo5d2OiJvP2Bu6VQi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: fcf00c\n	2022-03-23 09:37:51.252967
141	Client	54	update	\N	---\nemail: ryan@ppta.com.au\nupper_client_id: 55\nbeaver_id: '146053'\nname: Yu PEI (Ryan)\nclient_type: 1\ncountry_code: '61'\nmobile: '0433129566'\nbirth: 1979-08-11\nbsb: '082356'\naccount_name: LYNK Tech Pty Ltd\naccount_number: '359670721'\nend_date: 2022-12-31\nid: 54\nencrypted_password: "$2a$12$Lx.bvD4thRDxSL.zVokrHOaasO7SAVzfcgI64ZcltY80M5IR91dWi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 371f8c\n	2022-03-23 09:38:04.299508
142	Client	55	update	\N	---\nemail: rainpei@hotmail.com\nupper_client_id: 54\nbeaver_id: ''\nname: Paramount Tax - Yu PEI Partner\nclient_type: 1\ncountry_code: "+61 "\nmobile: '433129566'\nbirth: 2022-08-11\nbsb: '062223 '\naccount_name: operations@beavercapital.com.au\naccount_number: '11181711'\nend_date: \nid: 55\nencrypted_password: "$2a$12$rNBR8OEl6Ywbk3Kx6YivEOn0iz6MeuV5jIXlRo5d2OiJvP2Bu6VQi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: fcf00c\n	2022-03-23 09:38:46.63743
143	Client	56	create	\N	\N	2022-03-23 10:35:10.487992
144	Client	57	create	\N	\N	2022-03-23 11:52:20.011379
145	Client	57	update	\N	---\nemail: qiantai1953@163.com\nupper_client_id: 29\nbeaver_id: '146065'\nname: Aiping HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '490740992'\nbirth: 2022-12-29\nbsb: '083251'\naccount_name: AIPING HUANG\naccount_number: '783354998'\nend_date: 2022-12-31\nid: 57\nencrypted_password: "$2a$12$Fte7g5lTbBztu8P95uUoReRJcYIhMNa8ANE3OKeR5IYLvxb7gy9GS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 02a82d\n	2022-03-23 15:25:48.473558
146	Client	58	create	\N	\N	2022-03-24 12:36:19.903041
147	Client	59	create	\N	\N	2022-03-24 12:45:43.216041
148	Client	60	create	\N	\N	2022-03-24 12:56:14.768142
149	Client	61	create	\N	\N	2022-03-24 13:14:51.077845
150	Client	62	create	\N	\N	2022-03-24 13:46:50.29939
151	Client	63	create	\N	\N	2022-03-24 13:59:23.058939
152	Client	64	create	\N	\N	2022-03-24 14:04:03.714748
153	Client	65	create	\N	\N	2022-03-24 14:10:58.418805
154	Client	65	update	\N	---\nemail: yaping.li@fxplus.com.au\nupper_client_id: \nbeaver_id: '146062'\nname: Yaping Li\nclient_type: 0\ncountry_code: "+61 "\nmobile: '413833135'\nbirth: 1973-02-05\nbsb: '015025'\naccount_name: The trustee for Shengli Family Trust\naccount_number: '528730466'\nend_date: 2022-12-31\nid: 65\nencrypted_password: "$2a$12$CP1gbcH11bF.DnkYEbF/0.Uxj.OP54ALZ/gvFtHKIySEHRBGk99Sa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ab1ae7\n	2022-03-24 14:12:01.737778
155	Client	66	create	\N	\N	2022-03-24 14:19:35.397943
156	Client	67	create	\N	\N	2022-03-24 14:22:37.405868
157	Client	68	create	\N	\N	2022-03-24 14:27:26.40748
158	Client	69	create	\N	\N	2022-03-25 18:37:38.942789
159	Client	70	create	\N	\N	2022-03-28 14:12:51.990259
160	Client	55	destroy	\N	---\nid: 55\nemail: rainpei@hotmail.com\nencrypted_password: "$2a$12$rNBR8OEl6Ywbk3Kx6YivEOn0iz6MeuV5jIXlRo5d2OiJvP2Bu6VQi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: Paramount Tax - Yu PEI Partner\nclient_type: 1\ncountry_code: "+61 "\nmobile: '433129566'\nsalt: fcf00c\nbirth: 2022-08-11\nbsb: '062223 '\naccount_name: operations@beavercapital.com.au\naccount_number: '11181711'\nend_date: \n	2022-03-29 09:29:32.172523
161	Client	54	update	\N	---\nemail: ryan@ppta.com.au\nupper_client_id: \nbeaver_id: '146053'\nname: Yu PEI (Ryan)\nclient_type: 0\ncountry_code: '61'\nmobile: '0433129566'\nbirth: 1979-08-11\nbsb: '082356'\naccount_name: LYNK Tech Pty Ltd\naccount_number: '359670721'\nend_date: 2022-12-31\nid: 54\nencrypted_password: "$2a$12$Lx.bvD4thRDxSL.zVokrHOaasO7SAVzfcgI64ZcltY80M5IR91dWi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 371f8c\n	2022-03-29 09:41:03.386537
162	Client	71	create	\N	\N	2022-03-29 10:32:25.581606
163	Client	68	update	\N	---\nemail: landyxhl1210@gmail.com\nupper_client_id: \nbeaver_id: '146066'\nname: Xiaoping CAO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '410899916'\nbirth: 1953-11-20\nbsb: '012260'\naccount_name: Xiaoping CAO\naccount_number: '303634748'\nend_date: 2022-12-31\nid: 68\nencrypted_password: "$2a$12$j8fpncUqZkHUkOxGITypWObpgFt5K5KbTOLf1KBHqjHVhcu1W.t8S"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 92c4df\n	2022-03-29 10:44:03.301516
164	Client	59	update	\N	---\nemail: denghuawu@yahoo.com\nupper_client_id: \nbeaver_id: '146055'\nname: Denghua WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '413599953'\nbirth: \nbsb: 063-106\naccount_name: QI Property PL ATF Q1 Family Trust\naccount_number: '10794876'\nend_date: 2022-12-31\nid: 59\nencrypted_password: "$2a$12$47KYIpCtKhbdP/LQ87IJIOIfzR8cF5Oo2lXL1rG48sqTpbgvNhXZy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5796f4\n	2022-03-29 10:57:46.177476
165	Client	51	update	\N	---\nemail: christinemelbar@gmail.com\nupper_client_id: \nbeaver_id: '146051'\nname: Ling HUANG\nclient_type: \ncountry_code: ''\nmobile: '0411587938'\nbirth: \nbsb: 012-406\naccount_name: ARVOR Superannuation Fund\naccount_number: '228286324'\nend_date: \nid: 51\nencrypted_password: "$2a$12$7xJ85ciuQfXNGUmLK/ZeeuKtgbmuqoaKALj6EDr4LOo5X/JJPywo2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b41dd6\n	2022-03-29 11:22:11.347695
166	Client	53	update	\N	---\nemail: wuyang900627@gmail.com\nupper_client_id: 29\nbeaver_id: '146052'\nname: Yang WU\nclient_type: 0\ncountry_code: ''\nmobile: '0401877559'\nbirth: 1990-06-27\nbsb: '083004'\naccount_name: Yang Wu\naccount_number: '534625451'\nend_date: \nid: 53\nencrypted_password: "$2a$12$ITerLJC/DNnCch8Gsdk3SuMVvAN2Y/cl1/F2TJtm6XxWzNsiO1zFW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 2eea74\n	2022-03-29 11:22:35.833137
167	Client	52	update	\N	---\nemail: ling.abid@gmail.com\nupper_client_id: 29\nbeaver_id: '146050'\nname: Ling YUAN\nclient_type: 0\ncountry_code: ''\nmobile: '0452181678'\nbirth: 1971-06-25\nbsb: '083-343 '\naccount_name: Ling YUAN\naccount_number: '187071326'\nend_date: \nid: 52\nencrypted_password: "$2a$12$PR2JV4qWVoB99OsrMQtxAO/wJXQT6OU1aYKXzs1jPDblELNBPAScq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8f5edd\n	2022-03-29 11:26:04.185833
168	Client	50	update	\N	---\nemail: elainedy39@gmail.com\nupper_client_id: \nbeaver_id: '146048'\nname: Ying DONG\nclient_type: 0\ncountry_code: ''\nmobile: '0483094114 '\nbirth: 1996-11-05\nbsb: 737-015\naccount_name: Ying DONG\naccount_number: '618651'\nend_date: \nid: 50\nencrypted_password: "$2a$12$JDIXfGfACmQjt4MNaf002ewPTTZugvbrlnerNmUiP3ymuEs3DZru2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: cd5dba\n	2022-03-29 12:01:54.061416
169	Client	47	update	\N	---\nemail: libingdi@163.com\nupper_client_id: 38\nbeaver_id: '146047'\nname: Yufeng LU& Bingdi LI\nclient_type: 0\ncountry_code: ''\nmobile: '0421952353'\nbirth: \nbsb: 733-073\naccount_name: Yufeng Lu& Bingdi Li\naccount_number: '847788'\nend_date: \nid: 47\nencrypted_password: "$2a$12$xaCZ6I7tdpPutYh96Mt1d.nhHcRKR65FxwfN/6PgAl6Bu4gRHzSU2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 1ddb53\n	2022-03-29 12:09:42.856141
170	Client	46	update	\N	---\nemail: zhou.yinhui@gmail.com\nupper_client_id: 14\nbeaver_id: '146046'\nname: Yinhui Zhou\nclient_type: 0\ncountry_code: ''\nmobile: '0421505234'\nbirth: 1986-02-21\nbsb: 062-475\naccount_name: XIAOYIN FAMILY TRUST\naccount_number: '10338006'\nend_date: \nid: 46\nencrypted_password: "$2a$12$jsYUAyL4N6kYxnacTMNgE.DS.N3OM8FSrrya3itEzgiuUemkCMFcK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ba0ae9\n	2022-03-29 12:10:57.945747
171	Client	45	update	\N	---\nemail: jerryyanchao77@gmail.com\nupper_client_id: 29\nbeaver_id: '146045'\nname: Yanchao YANG\nclient_type: 0\ncountry_code: ''\nmobile: '0414153421'\nbirth: 1995-09-01\nbsb: '083-019'\naccount_name: Yanchao Yang\naccount_number: '471967971'\nend_date: \nid: 45\nencrypted_password: "$2a$12$0Xkh51VvKFqizUYKGm/6muRVvaHxUz5ScLmBVZdhxnWcDwocgkthq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 14b152\n	2022-03-29 12:14:56.852561
172	Client	38	update	\N	---\nemail: xuefhan@hotmail.com\nupper_client_id: 38\nbeaver_id: '146044'\nname: Christina Han\nclient_type: 0\ncountry_code: ''\nmobile: '0410006678'\nbirth: 1979-03-09\nbsb: 732-135\naccount_name: Christina Han\naccount_number: '833169'\nend_date: \nid: 38\nencrypted_password: "$2a$12$XDqf.HgyX.nWfST7b8rVbuPcqg0JBBY0t26JjTtdmSH28ST/COtja"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8aeb86\n	2022-03-29 12:16:02.352179
173	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: 37\nbeaver_id: '146043'\nname: Lin Tan\nclient_type: 0\ncountry_code: ''\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-190\naccount_name: Lin Tan\naccount_number: '10557239'\nend_date: \nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\n	2022-03-29 12:20:56.346115
174	Client	36	update	\N	---\nemail: 380817544@qq.com\nupper_client_id: 29\nbeaver_id: '146042'\nname: Chang Qin\nclient_type: 0\ncountry_code: ''\nmobile: '0484191561'\nbirth: 1973-10-14\nbsb: 063-109\naccount_name: Chang Qin\naccount_number: '11687388'\nend_date: \nid: 36\nencrypted_password: "$2a$12$HaKHCRMJzthpRLwoqQFq1u1oxHxqqQZwunfd4L/8eGEpIlw.sB9Pi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '592097'\n	2022-03-29 12:28:03.865133
175	Client	38	update	\N	---\nemail: xuefhan@hotmail.com\nupper_client_id: 38\nbeaver_id: '146044'\nname: Christina Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0410006678'\nbirth: 1979-03-09\nbsb: 732-135\naccount_name: Christina Han\naccount_number: '833169'\nend_date: 2022-10-31\nid: 38\nencrypted_password: "$2a$12$XDqf.HgyX.nWfST7b8rVbuPcqg0JBBY0t26JjTtdmSH28ST/COtja"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8aeb86\n	2022-03-29 12:29:31.166139
176	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: 37\nbeaver_id: '146043'\nname: Lin Tan\nclient_type: 0\ncountry_code: "+61"\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-190\naccount_name: Lin Tan\naccount_number: '10557239'\nend_date: 2022-10-31\nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\n	2022-03-29 12:30:52.393967
177	Client	35	update	\N	---\nemail: wanyp@yahoo.com\nupper_client_id: 29\nbeaver_id: '146041'\nname: Yu Ping Wan\nclient_type: 0\ncountry_code: ''\nmobile: '0481991606'\nbirth: \nbsb: '085-458'\naccount_name: Yu Ping Wan\naccount_number: '452488246'\nend_date: \nid: 35\nencrypted_password: "$2a$12$pfZB4W1YgFVIeG0gDj7ToOsvAxXCySLKCdXbJVbNoSHV7lGI3a0X6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0c971d\n	2022-03-29 12:36:07.546546
178	Client	34	update	\N	---\nemail: chunnianding@gmail.com\nupper_client_id: 29\nbeaver_id: '146040'\nname: Chunnian Ding\nclient_type: 0\ncountry_code: ''\nmobile: '0409703433'\nbirth: \nbsb: 733-173\naccount_name: Chunnian Ding\naccount_number: '644056'\nend_date: \nid: 34\nencrypted_password: "$2a$12$WH4aF8otGtxc9OfPx7cH..JdMQzH2.kF7yDHo3PthBfoES3ETWe3q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 909dc8\n	2022-03-29 12:38:22.754351
179	Client	70	update	\N	---\nemail: 732672012@qq.com\nupper_client_id: 29\nbeaver_id: '146068'\nname: Liping TAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '415066168'\nbirth: 1972-11-27\nbsb: '063182'\naccount_name: Liping TAN\naccount_number: '11353113'\nend_date: 2022-12-31\nid: 70\nencrypted_password: "$2a$12$cvw2ubfR2tcy02inlFNXx.dE4D4Wdv8Gr5dUH3Hwr8f7W/3O351by"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9b118\n	2022-03-29 12:38:32.885522
180	Client	69	update	\N	---\nemail: fz0207@hotmail.com\nupper_client_id: 14\nbeaver_id: '146067'\nname: Fang ZHENG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411068843'\nbirth: 1973-02-07\nbsb: '032382'\naccount_name: Ethan & Aurora Family Trust\naccount_number: '469440'\nend_date: 2022-12-31\nid: 69\nencrypted_password: "$2a$12$E2/8w1GI4WJswB7qd.MyoeKDjgsqCdFhxAYEHpTt6EhfVz/2GQ7w6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: be806d\n	2022-03-29 12:38:41.977974
181	Client	68	update	\N	---\nemail: landyxhl1210@gmail.com\nupper_client_id: 71\nbeaver_id: '146066'\nname: Xiaoping CAO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '410899916'\nbirth: 1953-11-20\nbsb: '012260'\naccount_name: Xiaoping CAO\naccount_number: '303634748'\nend_date: 2022-12-31\nid: 68\nencrypted_password: "$2a$12$j8fpncUqZkHUkOxGITypWObpgFt5K5KbTOLf1KBHqjHVhcu1W.t8S"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 92c4df\n	2022-03-29 12:38:51.466719
182	Client	67	update	\N	---\nemail: dongrjin@hotmail.com\nupper_client_id: 29\nbeaver_id: '146064'\nname: Dong Rong JIN\nclient_type: 0\ncountry_code: "+61"\nmobile: " 421026554"\nbirth: 1979-04-02\nbsb: '733340'\naccount_name: Dongrong Jin\naccount_number: '525047'\nend_date: 2022-12-31\nid: 67\nencrypted_password: "$2a$12$nDrCIGYB8mTSmvrBrKedLu9Dlw0jZUy3IytV7dTC0wxVp3iiXaRQW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: df6f9a\n	2022-03-29 12:38:59.720715
183	Client	66	update	\N	---\nemail: hlgs3030@outlook.com\nupper_client_id: \nbeaver_id: '146063'\nname: Kangjun ZHU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '436335777'\nbirth: 1968-11-17\nbsb: '112879'\naccount_name: Gold Phoenix Holding Pry Ltd ATF Jing Hui Feng Liang Trust\naccount_number: '416697737'\nend_date: 2022-12-31\nid: 66\nencrypted_password: "$2a$12$L5kaM9HvCVnhX/hxMwqeQucEnN/eiVtnT4CjPpwayHtdvGz.TKM6G"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3a0f53\n	2022-03-29 12:39:07.322413
184	Client	32	update	\N	---\nemail: wulei_1@hotmail.com\nupper_client_id: 29\nbeaver_id: '146038'\nname: Lei WU\nclient_type: 1\ncountry_code: ''\nmobile: '0449896346'\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \nid: 32\nencrypted_password: "$2a$12$lDIG1eKjlGByV5RRvo2Zm.KR7y.hfC4IRXv4I7roHMzpKS80Cgcd2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ef4ae8\n	2022-03-29 12:48:21.856394
185	Client	31	update	\N	---\nemail: cizhang2017@foxmail.com\nupper_client_id: 29\nbeaver_id: '146037'\nname: Ci Zhang\nclient_type: 0\ncountry_code: ''\nmobile: '0481735199'\nbirth: \nbsb: 033-172\naccount_name: Oasisun Management Pty Ltd ATF Sean Family Trust\naccount_number: '914168'\nend_date: \nid: 31\nencrypted_password: "$2a$12$1fROJsjVNQAkdd5vsLZKC.yHSjH8.qbR5sRkdnUna2JasjWI.PcFO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f02cb8\n	2022-03-29 12:53:48.201616
186	Client	29	update	\N	---\nemail: changfamily608@gmail.com\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 0\ncountry_code: ''\nmobile: '0430086816'\nbirth: \nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \nid: 29\nencrypted_password: "$2a$12$d5.1abl5ukfxC68qi6G3.OahixFrXOj.C4VHkw0oHmbAuFSLdonxS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9624b\n	2022-03-29 12:57:45.372199
187	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 29\nbeaver_id: '146035'\nname: Yijun Sun\nclient_type: 0\ncountry_code: ''\nmobile: '0406779863'\nbirth: \nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\n	2022-03-29 13:01:40.356056
188	Client	28	update	\N	---\nemail: boxing.han@hotmail.com\nupper_client_id: 29\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 0\ncountry_code: ''\nmobile: '0450029266'\nbirth: \nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \nid: 28\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2c8cd\n	2022-03-29 13:06:50.339849
189	Client	23	update	\N	---\nemail: nathancx86@gmail.com\nupper_client_id: 14\nbeaver_id: '146029'\nname: Xi Chen\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0401535201'\nbirth: \nbsb: 032-282\naccount_name: Xi Chen\naccount_number: '437804'\nend_date: \nid: 23\nencrypted_password: "$2a$12$eWDhzEwjuULQUEthx6Wy2ezt9YLr0IzTDBjgvB7QO.WpoLuAVKKiy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 6f683b\n	2022-03-29 13:15:25.207717
190	Client	21	update	\N	---\nemail: invincibleandy@hotmail.com\nupper_client_id: 14\nbeaver_id: '146028'\nname: Yanchi Wu\nclient_type: 0\ncountry_code: ''\nmobile: '0452366998'\nbirth: \nbsb: 032-090\naccount_name: Aussie Essence International PTY LTD\naccount_number: '134868'\nend_date: \nid: 21\nencrypted_password: "$2a$12$JGA7YKtGX9bfQosnADa5euURerD00GEBiFKswYJXHzJLBKNEBNxwW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '593554'\n	2022-03-29 13:18:22.026121
191	Client	23	update	\N	---\nemail: nathancx86@gmail.com\nupper_client_id: 14\nbeaver_id: '146029'\nname: Xi Chen\nclient_type: 0\ncountry_code: 澳大利亚\nmobile: '0401535201'\nbirth: 1986-11-02\nbsb: 032-282\naccount_name: Xi Chen\naccount_number: '437804'\nend_date: \nid: 23\nencrypted_password: "$2a$12$eWDhzEwjuULQUEthx6Wy2ezt9YLr0IzTDBjgvB7QO.WpoLuAVKKiy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 6f683b\n	2022-03-29 13:18:53.921816
192	Client	48	update	\N	---\nemail: lisunshine2008@126.com\nupper_client_id: 48\nbeaver_id: '146027'\nname: Yang LI\nclient_type: 0\ncountry_code: ''\nmobile: '0410073777'\nbirth: \nbsb: 980-205\naccount_name: admin@example.com\naccount_number: '900172140'\nend_date: \nid: 48\nencrypted_password: "$2a$12$lGZjIi6ufg6ipRsVw2kORuljv4/.rlMWNqbYEX0YbO6xczUN3xv.y"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: da0fa7\n	2022-03-29 13:25:06.436389
193	Client	72	create	\N	\N	2022-03-29 13:37:17.372633
194	Client	73	create	\N	\N	2022-03-29 13:40:48.240848
195	Client	18	update	\N	---\nemail: bpi99409@163.com\nupper_client_id: \nbeaver_id: '146023'\nname: Hung Fung Tong\nclient_type: 1\ncountry_code: ''\nmobile: '0451396527'\nbirth: 1963-09-11\nbsb: 062-009\naccount_name: Hung Fung Tong\naccount_number: '10991049'\nend_date: \nid: 18\nencrypted_password: "$2a$12$8/6mrI.UOSwZHrh9g.1pM.1.1UZnTF4nG/RFlBOhqww27ytGkL63e"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '951795'\n	2022-03-29 13:41:31.72203
196	Client	19	update	\N	---\nemail: linawang218@hotmail.com\nupper_client_id: \nbeaver_id: '146025'\nname: Li Wang\nclient_type: 0\ncountry_code: ''\nmobile: '0450560062'\nbirth: 1989-02-18\nbsb: 732-062\naccount_name: Li Wang\naccount_number: '580550'\nend_date: \nid: 19\nencrypted_password: "$2a$12$tfuGo8T9/1b8/FsuoSa.qe7a.veVEJHDJLPiy65WDdA85GeB3S.qa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '675597'\n	2022-03-29 13:45:15.20446
197	Client	14	update	\N	---\nemail: jeffrey.liu@hippowealth.com.au\nupper_client_id: \nbeaver_id: '146022'\nname: Jeffrey Liu\nclient_type: 1\ncountry_code: ''\nmobile: '0433886621'\nbirth: \nbsb: 062-799\naccount_name: Daxia Ge\naccount_number: '13076828'\nend_date: \nid: 14\nencrypted_password: "$2a$12$kwgT50H2lbYyfArpeZ7yzee1DTYC.gS7oncY6Rhx.NE1QIp97//wi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 18d962\n	2022-03-29 13:50:38.589064
198	Client	15	update	\N	---\nemail: jessieljx@qq.com\nupper_client_id: 14\nbeaver_id: '146021'\nname: Jessie Liu\nclient_type: 0\ncountry_code: ''\nmobile: '0488334040'\nbirth: 1968-06-22\nbsb: 012-125\naccount_name: Jianxin Liu\naccount_number: '466906541'\nend_date: \nid: 15\nencrypted_password: "$2a$12$6rxPR6.UfqMg9qzWZbGEr.5WHEEtsHBRshC2BGwfohXoJ3sbXRGrG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d37637\n	2022-03-29 13:53:29.300425
199	Client	66	update	\N	---\nemail: hlgs3030@outlook.com\nupper_client_id: \nbeaver_id: '146063'\nname: Kangjun ZHU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '436335777'\nbirth: 1968-11-17\nbsb: '112879'\naccount_name: Gold Phoenix Holding Pry Ltd ATF Jing Hui Feng Liang Trust\naccount_number: '416697737'\nend_date: \nid: 66\nencrypted_password: "$2a$12$L5kaM9HvCVnhX/hxMwqeQucEnN/eiVtnT4CjPpwayHtdvGz.TKM6G"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3a0f53\n	2022-03-29 15:30:04.356162
200	Client	60	update	\N	---\nemail: 525196937@qq.com\nupper_client_id: \nbeaver_id: '146056'\nname: Xiandong GAO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '402127828'\nbirth: 1971-02-01\nbsb: '062692'\naccount_name: Xiandong GAO\naccount_number: '46930314'\nend_date: 2022-12-31\nid: 60\nencrypted_password: "$2a$12$LH/6smX5KVaZ7zDETGaMOuWIHf7dMCT3BdxL8uS5OI41qrpSUbb.."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bcfa9e\n	2022-03-29 15:31:03.962792
201	Client	59	update	\N	---\nemail: denghuawu@yahoo.com\nupper_client_id: \nbeaver_id: '146055'\nname: Denghua WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '413599953'\nbirth: 1972-03-24\nbsb: 063-106\naccount_name: QI Property PL ATF Q1 Family Trust\naccount_number: '10794876'\nend_date: 2022-12-31\nid: 59\nencrypted_password: "$2a$12$47KYIpCtKhbdP/LQ87IJIOIfzR8cF5Oo2lXL1rG48sqTpbgvNhXZy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5796f4\n	2022-03-29 15:33:11.385261
202	Client	58	update	\N	---\nemail: dongxia1968@gmail.com\nupper_client_id: \nbeaver_id: '146054'\nname: Dong XIA\nclient_type: 0\ncountry_code: "+61 "\nmobile: '408257323'\nbirth: 1968-12-22\nbsb: '082001'\naccount_name: Norman RAY\naccount_number: '776937917'\nend_date: 2022-12-31\nid: 58\nencrypted_password: "$2a$12$YYmgAjwoOPSLJDlheSXFHO.dtClQqbzCps..ic6MtBME0Q5h8S4aO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2fae2\n	2022-03-29 15:33:29.468993
203	Client	56	update	\N	---\nemail: lgliugangfff@gmail.com\nupper_client_id: \nbeaver_id: '146059'\nname: Gang LIU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '433912389'\nbirth: 1975-04-20\nbsb: '013271'\naccount_name: Gang Liu\naccount_number: '283165576'\nend_date: 2022-12-31\nid: 56\nencrypted_password: "$2a$12$9duBvD1DC3O1gcY6yK0oc.d/5CsCO9pMAoh1/nzZ9ue0AzOZvgaaC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bc6b97\n	2022-03-29 15:33:56.659974
204	Client	73	update	\N	---\nencrypted_password: "$2a$12$tsxK.2NWGNv5TFiIyNnU4.Rsww.nNB2dqpY6n8ORh84pRdPiRD4RG"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \n	2022-03-29 15:44:32.19115
205	Client	73	update	\N	---\nencrypted_password: "$2a$12$rS8OuaaPcQhASpnMGPSZCOXEwr/e7fXvpmwh1q.NUqJH46DQSwaaK"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \n	2022-03-29 15:44:39.804128
206	Client	73	update	\N	---\nencrypted_password: "$2a$12$BW1mG77W/pTKVuqTaxeUxOOCZ2ByRj/6VazTe/AN/dCWspCdwhNGa"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \n	2022-03-29 15:44:43.171653
207	Client	73	update	\N	---\nencrypted_password: "$2a$12$LIKtellWQXPazTEz4F.5s.w9HjRLeyYYwWNYveMKD6hwCt1Fz/cmu"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \n	2022-03-29 15:44:50.111124
208	Client	73	update	\N	---\nencrypted_password: "$2a$12$ytpGlceA8Ve4O0P90MkjjOAfXtO.G9REGYkqtXaMgFoyRC/iF4GJK"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \n	2022-03-29 15:44:56.837442
209	Client	73	update	\N	---\nencrypted_password: "$2a$12$iD/TQXhAe.OHIdwC7e2nW.hHbOCak/jRMtexzmLC1HWln2QOfwi2m"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \n	2022-03-29 15:45:08.35086
210	Client	29	update	\N	---\nencrypted_password: "$2a$12$d5.1abl5ukfxC68qi6G3.OahixFrXOj.C4VHkw0oHmbAuFSLdonxS"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \n	2022-03-29 16:00:02.284732
211	Client	62	update	\N	---\nemail: pwy20081222@163.com\nupper_client_id: 30\nbeaver_id: '146058'\nname: Yanchao SHU\nclient_type: 0\ncountry_code: "+61"\nmobile: '420217659'\nbirth: 1976-01-29\nbsb: 063-109\naccount_name: Yanchao SHU\naccount_number: '11657760'\nend_date: 2022-12-31\nid: 62\nencrypted_password: "$2a$12$s6L3dFCW7mRH.FDvdsVh7eOLm4ofXNku7lE6n3dniGRkYAh23Q6/O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b9ab02\n	2022-03-30 07:43:32.744208
212	Client	29	update	\N	---\nencrypted_password: "$2a$12$wyMd1ibSvw1BOVZ2yuDRfO/cLeGdftMNip4GgXzhusnNB42pkBNyG"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \n	2022-03-30 14:54:48.531785
213	Client	32	update	\N	---\nemail: wulei_1@hotmail.com\nupper_client_id: 29\nbeaver_id: '146038'\nname: Lei WU\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0449896346'\nbirth: 2022-11-06\nbsb: 063-113\naccount_name: Sunrise Development (AU) Pty Ltd\naccount_number: '11270858'\nend_date: \nid: 32\nencrypted_password: "$2a$12$lDIG1eKjlGByV5RRvo2Zm.KR7y.hfC4IRXv4I7roHMzpKS80Cgcd2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ef4ae8\n	2022-03-30 15:09:49.031463
214	Client	74	create	\N	\N	2022-03-30 19:06:03.326914
215	Client	75	create	\N	\N	2022-03-30 19:17:24.462051
216	Client	76	create	\N	\N	2022-03-31 06:52:36.683589
217	Client	77	create	\N	\N	2022-03-31 09:05:24.858664
218	Client	51	update	\N	---\nname: Ling HUANG\nbirth: 2022-08-11\nencrypted_password: "$2a$12$7xJ85ciuQfXNGUmLK/ZeeuKtgbmuqoaKALj6EDr4LOo5X/JJPywo2"\nemail: christinemelbar@gmail.com\nid: 51\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 14\nbeaver_id: '146051'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0411587938'\nsalt: b41dd6\nbsb: 012-406\naccount_name: ARVOR Superannuation Fund\naccount_number: '228286324'\nend_date: 2022-11-30\n	2022-04-01 11:32:04.355446
219	Client	51	update	\N	---\nname: Ling Huang\nbirth: 1962-08-11\nencrypted_password: "$2a$12$FmY1repR34Z216iCNpWH5e/ZfyxSMbuZ2k/pqDWSuH6D8NF0szh76"\nemail: christinemelbar@gmail.com\nid: 51\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 14\nbeaver_id: '146051'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0411587938'\nsalt: b41dd6\nbsb: 012-406\naccount_name: ARVOR Superannuation Fund\naccount_number: '228286324'\nend_date: 2022-11-30\n	2022-04-01 11:32:04.892727
220	Client	17	update	\N	---\nemail: brianguo8283@gmail.com\nupper_client_id: \nbeaver_id: '146032'\nname: Zixuan Guo\nclient_type: 1\ncountry_code: ''\nmobile: '0426836189'\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \nid: 17\nencrypted_password: "$2a$12$zGSugN.TyQP.yY7pNriQ1OxohTJs.JTceEkbMUiu9h8xP0kHLovH6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 2f52fa\n	2022-04-04 13:17:25.700524
221	Client	17	update	\N	---\nencrypted_password: "$2a$12$zGSugN.TyQP.yY7pNriQ1OxohTJs.JTceEkbMUiu9h8xP0kHLovH6"\nemail: brianguo8283@gmail.com\nid: 17\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146032'\nname: Ausgreen Investment Consultation Pty Ltd - Zixuan Guo\nclient_type: 1\ncountry_code: "+61"\nmobile: '0426836189'\nsalt: 2f52fa\nbirth: \nbsb: '062256'\naccount_name: Ausgreen Investment Consultation Pty Ltd\naccount_number: '11182306'\nend_date: \n	2022-04-04 13:20:44.678322
222	Client	78	create	\N	\N	2022-04-07 08:31:02.235211
223	Client	79	create	\N	\N	2022-04-08 13:56:06.989012
224	Client	80	create	\N	\N	2022-04-08 14:54:35.757096
225	Client	81	create	\N	\N	2022-04-11 08:05:03.874494
226	Client	79	destroy	\N	---\nid: 79\nemail: dingzijin93@gmail.com\nencrypted_password: "$2a$12$D/syr9C2u5rEQmBR3x3jve.JSV8AjmKIcIvV2GDcIzRVwbxkiBaw6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: Jennie\nclient_type: \ncountry_code: '61'\nmobile: '0421102642'\nsalt: 5316aa\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '0'\ninvest_entity: 0\ninvest_status: 0\n	2022-04-11 09:18:21.306066
227	Client	82	create	\N	\N	2022-04-11 13:41:15.729168
228	Client	40	update	\N	---\nemail: andy.chen@beavercapital.com.au\nupper_client_id: \nbeaver_id: '00000908'\nname: Andy Chen\nclient_type: \ncountry_code: ''\nmobile: '0411332899'\nbirth: \nbsb: ''\naccount_name: admin@example.com\naccount_number: ''\nend_date: \nid: 40\nencrypted_password: "$2a$12$TbH/OubhguA3tgXkUidoQ.QCr2Tww.ZKhw3gZVQH5RQAaj/pnmnGy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: dffcdb\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-04-11 13:52:25.418325
229	Client	83	create	\N	\N	2022-04-12 09:01:51.25847
230	Client	84	create	\N	\N	2022-04-12 09:08:29.713813
231	Client	85	create	\N	\N	2022-04-12 12:15:34.778074
232	Client	85	destroy	\N	---\nid: 85\nemail: dingzijin93@gmail.com\nencrypted_password: "$2a$12$g1/9R9mrDsxl2tSjqdaq1ez1RUJ2mIbwJTUuqpXdBQ77gJ4ua.xLm"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: Jennie\nclient_type: \ncountry_code: '61'\nmobile: '0421102642'\nsalt: 86788c\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '1 2 '\ninvest_entity: 0\ninvest_status: 0\n	2022-04-13 07:59:58.706309
233	Client	84	destroy	\N	---\nid: 84\nemail: djio@gmail.com\nencrypted_password: "$2a$12$wedBxjqvaJ0N/EZ2pLg7qOgELtfZG.T698kjgw.OMEbqMKeRxAkJ2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: dwqjkl\nclient_type: \ncountry_code: '61'\nmobile: '0416502123'\nsalt: 94e6ae\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '1 '\ninvest_entity: 2\ninvest_status: 0\n	2022-04-13 08:00:11.265806
234	Client	83	destroy	\N	---\nid: 83\nemail: 2189@gmail.com\nencrypted_password: "$2a$12$u8KSRPONLZfhAwYka0OYOO7JuTs6rjVGzHOgh143MdoQrUQXwKwJu"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: dsjak2\nclient_type: \ncountry_code: '61'\nmobile: '0416502123'\nsalt: '799334'\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '2 '\ninvest_entity: 0\ninvest_status: 0\n	2022-04-13 08:00:18.615298
235	Client	82	destroy	\N	---\nid: 82\nemail: 3218589@gmail.com\nencrypted_password: "$2a$12$PWyACnbTqgTRgLyclfa/Xu.8Xnq8MaU.DekbXCelchG8fJS1zo0ga"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: usname\nclient_type: \ncountry_code: '61'\nmobile: '0416502123'\nsalt: b9dfed\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '1 2 '\ninvest_entity: 1\ninvest_status: 0\n	2022-04-13 08:00:23.156329
236	Client	81	destroy	\N	---\nid: 81\nemail: mia.li@beavercapital.com.au\nencrypted_password: "$2a$12$nZul85ySVqqVkfshg3gUr.Bq.RqtfhtKXbckXxjWhJMf0kqRPiqOW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: Mia\nclient_type: \ncountry_code: '61'\nmobile: '0426762820'\nsalt: 1dcbe0\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '0'\ninvest_entity: 0\ninvest_status: 0\n	2022-04-14 13:26:18.936129
237	Client	86	create	\N	\N	2022-04-14 13:28:39.615524
238	Client	15	update	\N	---\nemail: jessieljx@qq.com\nupper_client_id: 14\nbeaver_id: '146021'\nname: Jessie Liu\nclient_type: 0\ncountry_code: "+61 "\nmobile: '488334040'\nbirth: 1968-06-22\nbsb: 012-125\naccount_name: Jianxin Liu\naccount_number: '466906541'\nend_date: \nid: 15\nencrypted_password: "$2a$12$6rxPR6.UfqMg9qzWZbGEr.5WHEEtsHBRshC2BGwfohXoJ3sbXRGrG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d37637\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-04-20 10:12:50.571205
239	Client	87	create	\N	\N	2022-04-20 18:20:40.351572
240	Client	88	create	\N	\N	2022-04-20 18:21:01.821358
241	Client	89	create	\N	\N	2022-04-20 18:24:56.593556
242	Client	90	create	\N	\N	2022-04-20 18:43:08.406328
243	Client	91	create	\N	\N	2022-04-21 08:09:10.903564
244	Client	92	create	\N	\N	2022-04-21 14:19:59.884294
245	Client	93	create	\N	\N	2022-04-21 14:36:03.140322
246	Client	94	create	\N	\N	2022-04-22 15:44:19.08029
247	Client	95	create	\N	\N	2022-04-27 07:37:05.892399
248	Client	96	create	\N	\N	2022-04-28 15:32:34.584423
249	Client	72	update	\N	---\nname: Xunao WANG\nbirth: 1983-10-09\nemail: emma.wang@beavercapital.com.au\nid: 72\nencrypted_password: "$2a$12$H33T1X7bDLC50UpiMHQmieDzElcINFAEi7cLg1tn5o1WF63FhYjhm"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146026'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '422810308'\nsalt: b48723\nbsb: 062-217\naccount_name: Harmony & LOVE Pty Ltd\naccount_number: '10912089'\nend_date: 2021-12-13\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-02 18:38:35.97303
250	Client	29	update	\N	---\nencrypted_password: "$2a$12$BYJYcp6yoldLazVyA.hZqOB.BsExJM0IS4qnOfCk3BnvGH4dtm64W"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-02 18:51:23.517667
251	Client	29	update	\N	---\nencrypted_password: "$2a$12$lmRLOEtBfRXQBJpHzHl/.uOLPXnC6Pi4l.Ja.YVG9CX.GgqFW5Ezu"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-02 18:51:26.831472
252	Client	29	update	\N	---\nencrypted_password: "$2a$12$Yt1bmmFY.phzBeQRqtqbMOZAjR.VuP9tZJr0oMXyVLBwNFOBstQTO"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-02 18:51:28.153201
253	Client	95	destroy	\N	---\nid: 95\nemail: jewel.tan@beavercapital.com.au\nencrypted_password: "$2a$12$g4H7co3d3hicuMg4F27N1Ojsc0MOc2cGGjl3MQZ2KRaGb6pdruhKa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: Test\nclient_type: \ncountry_code: '61'\nmobile: '0402778220'\nsalt: '09412f'\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '2 '\ninvest_entity: 1\ninvest_status: 0\n	2022-05-04 15:32:39.701511
254	Client	94	destroy	\N	---\nid: 94\nemail: contact.andychen@gmail.com\nencrypted_password: "$2a$12$kLMhmFNiejGvXevQfI5oHOMzTRNdOPgra/oCOad5l1DzBGyWfPSPK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: Andy\nclient_type: \ncountry_code: '61'\nmobile: '0411332899'\nsalt: 19cf70\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '2 '\ninvest_entity: 0\ninvest_status: 0\n	2022-05-04 15:32:47.291523
255	Client	86	update	\N	---\nemail: shanshan871201@hotmail.com\nupper_client_id: \nbeaver_id: '146074'\nname: Shanshan ZHOU\nclient_type: 0\ncountry_code: "+61"\nmobile: '433591201'\nbirth: 1987-12-01\nbsb: '105029'\naccount_name: Shanshan ZHOU\naccount_number: '090350740'\nend_date: \nid: 86\nencrypted_password: "$2a$12$FolwEQGDNjxA4Bet7YJsTuZjA6JUlB0T2E2YWRL7I1YjytV.4IT4O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 4a1e07\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 15:37:17.701775
256	Client	86	update	\N	---\nemail: shanshan871201@hotmail.com\nupper_client_id: \nbeaver_id: '146074'\nname: Shanshan ZHOU\nclient_type: 1\ncountry_code: "+61"\nmobile: '433591201'\nbirth: 1987-12-01\nbsb: '105029'\naccount_name: Shanshan ZHOU\naccount_number: '090350740'\nend_date: \nid: 86\nencrypted_password: "$2a$12$FolwEQGDNjxA4Bet7YJsTuZjA6JUlB0T2E2YWRL7I1YjytV.4IT4O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 4a1e07\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 15:40:14.785991
257	Client	80	update	\N	---\nemail: lmkgeorge@gmail.com\nupper_client_id: \nbeaver_id: '146073'\nname: Man Kit George LAM\nclient_type: 0\ncountry_code: "+61"\nmobile: '402534198'\nbirth: 1991-03-17\nbsb: '062759'\naccount_name: IOK SP Holdings Pty Ltd\naccount_number: '10586365'\nend_date: \nid: 80\nencrypted_password: "$2a$12$ZmhvRK1kn7Q2kjPaKXqG3.Ut0RDDgF/ggpMsLp.NKFpQ4vCMiwx.q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 11160c\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 15:49:51.970689
258	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: 37\nbeaver_id: '146043'\nname: Lin Tan\nclient_type: 1\ncountry_code: "+61"\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-190\naccount_name: Lin Tan\naccount_number: '10557239'\nend_date: 2022-10-31\nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 17:28:03.019485
259	Client	97	create	\N	\N	2022-05-04 17:29:40.349687
260	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: 37\nbeaver_id: '146043'\nname: Setall Family Pty Ltd ATF Setall Family Trust\nclient_type: 1\ncountry_code: "+61"\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-759\naccount_name: Setall Family Trust\naccount_number: '10598390'\nend_date: 2022-10-31\nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 17:30:24.770468
261	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: 97\nbeaver_id: '146043'\nname: Setall Family Pty Ltd ATF Setall Family Trust\nclient_type: 1\ncountry_code: "+61"\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-759\naccount_name: Setall Family Trust\naccount_number: '10598390'\nend_date: 2022-10-31\nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 17:34:39.276829
262	Client	97	update	\N	---\nemail: 55858058@qq.com\nupper_client_id: \nbeaver_id: ''\nname: Lin TAN\nclient_type: 1\ncountry_code: "+61 "\nmobile: '402778220'\nbirth: 1986-07-30\nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \nid: 97\nencrypted_password: "$2a$12$0Xkc36vEiWtAN.MSaSKx7OA2UkXWmUyWh1oPTjaPGqNtfeLg0DWfi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f525dd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 17:39:02.572023
263	Client	37	update	\N	---\nemail: jewel00tl@gmail.com\nupper_client_id: 97\nbeaver_id: '146043'\nname: Setall Family Pty Ltd ATF Setall Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '0402778220'\nbirth: 1986-07-30\nbsb: 062-759\naccount_name: Setall Family Trust\naccount_number: '10598390'\nend_date: 2022-10-31\nid: 37\nencrypted_password: "$2a$12$trsf8X7S9KOpoS9Anw6uDeSjV6nukge8vkWUbqAD/lFVH5EUIeoBC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c6ede3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 17:40:20.012715
264	Client	97	update	\N	---\nemail: 55858058@qq.com\nupper_client_id: \nbeaver_id: '146043'\nname: Setall Family Pty Ltd ATF Setall Family Trust\nclient_type: 0\ncountry_code: "+61 "\nmobile: '402778220'\nbirth: 1986-07-30\nbsb: 062-759\naccount_name: Setall Family Trust\naccount_number: '10598390'\nend_date: \nid: 97\nencrypted_password: "$2a$12$0Xkc36vEiWtAN.MSaSKx7OA2UkXWmUyWh1oPTjaPGqNtfeLg0DWfi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f525dd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-04 17:41:01.210806
265	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 29\nbeaver_id: '146035'\nname: Yijun Sun\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0406779863'\nbirth: 1970-10-23\nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-09 16:05:35.442045
266	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 29\nbeaver_id: '146035'\nname: Evergreen SUN Pty Ltd ATF Evergreen Spring Trust\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0406779863'\nbirth: 1970-10-23\nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-10 13:41:01.983042
267	Client	60	update	\N	---\nemail: 525196937@qq.com\nupper_client_id: 29\nbeaver_id: '146056'\nname: Xiandong GAO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '402127828'\nbirth: 1971-02-01\nbsb: '062692'\naccount_name: Xiandong GAO\naccount_number: '46930314'\nend_date: 2022-12-31\nid: 60\nencrypted_password: "$2a$12$LH/6smX5KVaZ7zDETGaMOuWIHf7dMCT3BdxL8uS5OI41qrpSUbb.."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bcfa9e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-10 13:41:41.48877
268	Client	62	update	\N	---\nemail: pwy20081222@163.com\nupper_client_id: 29\nbeaver_id: '146058'\nname: Yanchao SHU\nclient_type: 0\ncountry_code: "+61"\nmobile: '420217659'\nbirth: 1976-01-29\nbsb: 063-109\naccount_name: Yanchao SHU\naccount_number: '11657760'\nend_date: 2022-12-31\nid: 62\nencrypted_password: "$2a$12$s6L3dFCW7mRH.FDvdsVh7eOLm4ofXNku7lE6n3dniGRkYAh23Q6/O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b9ab02\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-10 13:42:05.346539
269	Client	98	create	\N	\N	2022-05-12 08:31:04.531093
270	Client	69	update	\N	---\nemail: fz0207@hotmail.com\nupper_client_id: 14\nbeaver_id: '146067'\nname: Fang ZHENG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411068843'\nbirth: 1973-02-07\nbsb: '032382'\naccount_name: Ethan & Aurora Family Trust\naccount_number: '469440'\nend_date: \nid: 69\nencrypted_password: "$2a$12$E2/8w1GI4WJswB7qd.MyoeKDjgsqCdFhxAYEHpTt6EhfVz/2GQ7w6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: be806d\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-12 14:22:34.611983
271	Client	99	create	\N	\N	2022-05-13 13:17:42.970184
272	Client	100	create	\N	\N	2022-05-17 08:09:14.683015
273	Client	29	update	\N	---\nencrypted_password: "$2a$12$kO2Ogs91wiArpY78J.fnNOG/rks.htBRrRBrw/zQTspoyRPre.sJG"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-17 09:15:23.411356
274	Client	29	update	\N	---\nencrypted_password: "$2a$12$gj.65mJOFqDNLVaNZEvDbumCrqFcPD8hb0k7YhhIBkgr6LRDP25r."\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-17 09:15:30.629761
275	Client	101	create	\N	\N	2022-05-20 09:39:23.828222
276	Client	102	create	\N	\N	2022-05-24 15:48:25.657294
277	Client	103	create	\N	\N	2022-05-26 15:59:34.430455
278	Client	57	update	\N	---\nname: Aiping HUANG\nbirth: 1953-12-29\nencrypted_password: "$2a$12$Fte7g5lTbBztu8P95uUoReRJcYIhMNa8ANE3OKeR5IYLvxb7gy9GS"\nemail: qiantai1953@163.com\nid: 57\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146065'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '490740992'\nsalt: 02a82d\nbsb: '083251'\naccount_name: AIPING HUANG\naccount_number: '783354998'\nend_date: 2022-12-31\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 10:06:16.187071
279	Client	57	update	\N	---\nname: Aiping HUANG\nbirth: 1953-12-29\nencrypted_password: "$2a$12$Un5aMKAi5LHMR6RxjGnfMeBhkwUVOGxM7kvhLrfp2xR4z/CDnLJVm"\nemail: qiantai1953@163.com\nid: 57\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146065'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '490740992'\nsalt: 02a82d\nbsb: '083251'\naccount_name: AIPING HUANG\naccount_number: '783354998'\nend_date: 2022-12-31\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 10:08:09.162175
280	Client	29	update	\N	---\nencrypted_password: "$2a$12$SaF0xK5cAsgGpXM8M9ZaEuyO.nEDxyijC5Stc2MP0DPYpZhDeCv0S"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 14:00:54.006508
281	Client	29	update	\N	---\nencrypted_password: "$2a$12$6ac..nKwYZ8BVJJO3U69i.5TOjuaFs8zD5qzFSew5N7v7gDdzz3qu"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 14:00:58.581119
282	Client	29	update	\N	---\nencrypted_password: "$2a$12$yC/p5/6MSDXdy6b1heo8Zu55sLazmPYkR58w0zy8PnRihkBr9fR9G"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 14:00:59.556131
283	Client	104	create	\N	\N	2022-05-30 14:07:57.516589
284	Client	105	create	\N	\N	2022-05-30 14:09:51.223224
285	Client	106	create	\N	\N	2022-05-30 14:15:54.322929
286	Client	107	create	\N	\N	2022-05-30 14:22:52.828994
287	Client	108	create	\N	\N	2022-05-30 15:06:23.902384
288	Client	28	update	\N	---\nemail: boxing.han@hotmail.com\nupper_client_id: 29\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nbirth: \nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \nid: 28\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2c8cd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:11:59.828749
289	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 30\nbeaver_id: '146035'\nname: Evergreen SUN Pty Ltd ATF Evergreen Spring Trust\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0406779863'\nbirth: 1970-10-23\nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:13:01.092628
290	Client	29	update	\N	---\nemail: changfamily608@gmail.com\nupper_client_id: \nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \nid: 29\nencrypted_password: "$2a$12$YYTS1SVDiiTT0YpeES4y7OQly.c2O7PpnDV2Zy9DQS8vT7jA16XqG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9624b\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:13:49.180135
291	Client	31	update	\N	---\nemail: cizhang2017@foxmail.com\nupper_client_id: 29\nbeaver_id: '146037'\nname: Ci Zhang\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0481735199'\nbirth: 2022-09-01\nbsb: 033-172\naccount_name: Oasisun Management Pty Ltd ATF Sean Family Trust\naccount_number: '914168'\nend_date: \nid: 31\nencrypted_password: "$2a$12$1fROJsjVNQAkdd5vsLZKC.yHSjH8.qbR5sRkdnUna2JasjWI.PcFO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f02cb8\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:14:15.235049
292	Client	33	update	\N	---\nemail: lanwatts3@gmail.com\nupper_client_id: 29\nbeaver_id: '146039'\nname: Minglan Chen\nclient_type: 0\ncountry_code: ''\nmobile: '0430032484'\nbirth: \nbsb: 063-154\naccount_name: Calm & Harmony Pty Ltd Trustee For Forever Young Superfund\naccount_number: '10791817'\nend_date: \nid: 33\nencrypted_password: "$2a$12$XKLvOKd5kWDDrkm5TwCpZ.r4Z73OVL5b6JTxk4o2ZgXTIC6I1geBa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 66b4cf\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:15:02.981514
293	Client	34	update	\N	---\nemail: chunnianding@gmail.com\nupper_client_id: 29\nbeaver_id: '146040'\nname: Chunnian Ding\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0409703433'\nbirth: 2022-02-07\nbsb: 733-173\naccount_name: Chunnian Ding\naccount_number: '644056'\nend_date: \nid: 34\nencrypted_password: "$2a$12$WH4aF8otGtxc9OfPx7cH..JdMQzH2.kF7yDHo3PthBfoES3ETWe3q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 909dc8\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:19:47.435301
294	Client	35	update	\N	---\nemail: wanyp@yahoo.com\nupper_client_id: 29\nbeaver_id: '146041'\nname: Yu Ping Wan\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0481991606'\nbirth: 2022-06-28\nbsb: '085-458'\naccount_name: Yu Ping Wan\naccount_number: '452488246'\nend_date: 2022-09-30\nid: 35\nencrypted_password: "$2a$12$pfZB4W1YgFVIeG0gDj7ToOsvAxXCySLKCdXbJVbNoSHV7lGI3a0X6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0c971d\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:20:05.747863
295	Client	36	update	\N	---\nemail: 380817544@qq.com\nupper_client_id: 29\nbeaver_id: '146042'\nname: Chang Qin\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0484191561'\nbirth: 1973-10-14\nbsb: 063-109\naccount_name: Chang Qin\naccount_number: '11687388'\nend_date: 2022-10-31\nid: 36\nencrypted_password: "$2a$12$HaKHCRMJzthpRLwoqQFq1u1oxHxqqQZwunfd4L/8eGEpIlw.sB9Pi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '592097'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:20:22.148368
296	Client	45	update	\N	---\nemail: jerryyanchao77@gmail.com\nupper_client_id: 29\nbeaver_id: '146045'\nname: Yanchao YANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0414153421'\nbirth: 1995-09-01\nbsb: '083-019'\naccount_name: Yanchao Yang\naccount_number: '471967971'\nend_date: 2022-10-31\nid: 45\nencrypted_password: "$2a$12$0Xkh51VvKFqizUYKGm/6muRVvaHxUz5ScLmBVZdhxnWcDwocgkthq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 14b152\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:21:56.99257
297	Client	32	update	\N	---\nemail: wulei_1@hotmail.com\nupper_client_id: 29\nbeaver_id: '146038'\nname: Lei WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0449896346'\nbirth: 2022-11-06\nbsb: 063-113\naccount_name: Sunrise Development (AU) Pty Ltd\naccount_number: '11270858'\nend_date: \nid: 32\nencrypted_password: "$2a$12$lDIG1eKjlGByV5RRvo2Zm.KR7y.hfC4IRXv4I7roHMzpKS80Cgcd2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ef4ae8\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:22:15.639806
298	Client	52	update	\N	---\nemail: ling.abid@gmail.com\nupper_client_id: 29\nbeaver_id: '146050'\nname: Ling YUAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0452181678'\nbirth: 1971-06-25\nbsb: '083-343 '\naccount_name: Ling YUAN\naccount_number: '187071326'\nend_date: 2022-11-30\nid: 52\nencrypted_password: "$2a$12$PR2JV4qWVoB99OsrMQtxAO/wJXQT6OU1aYKXzs1jPDblELNBPAScq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8f5edd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:22:34.377905
299	Client	53	update	\N	---\nemail: wuyang900627@gmail.com\nupper_client_id: 29\nbeaver_id: '146052'\nname: Yang WU\nclient_type: 0\ncountry_code: ''\nmobile: '0401877559'\nbirth: 1990-06-27\nbsb: '083004'\naccount_name: Yang Wu\naccount_number: '534625451'\nend_date: 2022-11-30\nid: 53\nencrypted_password: "$2a$12$ITerLJC/DNnCch8Gsdk3SuMVvAN2Y/cl1/F2TJtm6XxWzNsiO1zFW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 2eea74\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:23:42.573186
300	Client	59	update	\N	---\nemail: denghuawu@yahoo.com\nupper_client_id: 29\nbeaver_id: '146055'\nname: Denghua WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '413599953'\nbirth: 1972-03-24\nbsb: 063-106\naccount_name: QI Property PL ATF Q1 Family Trust\naccount_number: '10794876'\nend_date: 2022-12-31\nid: 59\nencrypted_password: "$2a$12$47KYIpCtKhbdP/LQ87IJIOIfzR8cF5Oo2lXL1rG48sqTpbgvNhXZy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5796f4\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:24:13.015908
301	Client	60	update	\N	---\nemail: 525196937@qq.com\nupper_client_id: 30\nbeaver_id: '146056'\nname: Xiandong GAO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '402127828'\nbirth: 1971-02-01\nbsb: '062692'\naccount_name: Xiandong GAO\naccount_number: '46930314'\nend_date: 2022-12-31\nid: 60\nencrypted_password: "$2a$12$LH/6smX5KVaZ7zDETGaMOuWIHf7dMCT3BdxL8uS5OI41qrpSUbb.."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bcfa9e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:24:34.097477
302	Client	61	update	\N	---\nemail: mikehuang166@gmail.com\nupper_client_id: 29\nbeaver_id: '146057'\nname: Zhengrong HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '431999636'\nbirth: 1977-01-16\nbsb: 033-084\naccount_name: 'Xinyue Investment Group '\naccount_number: '526085'\nend_date: 2022-12-31\nid: 61\nencrypted_password: "$2a$12$irvl936TDFbjlNGXWrHkteuGq7Bl/B2jO7lfDfcP.K1MefG/pdfGS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3ab932\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:33:55.111616
303	Client	62	update	\N	---\nemail: pwy20081222@163.com\nupper_client_id: 30\nbeaver_id: '146058'\nname: Yanchao SHU\nclient_type: 0\ncountry_code: "+61"\nmobile: '420217659'\nbirth: 1976-01-29\nbsb: 063-109\naccount_name: Yanchao SHU\naccount_number: '11657760'\nend_date: 2022-12-31\nid: 62\nencrypted_password: "$2a$12$s6L3dFCW7mRH.FDvdsVh7eOLm4ofXNku7lE6n3dniGRkYAh23Q6/O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b9ab02\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:34:16.611241
304	Client	56	update	\N	---\nemail: lgliugangfff@gmail.com\nupper_client_id: 29\nbeaver_id: '146059'\nname: Gang LIU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '433912389'\nbirth: 1975-04-20\nbsb: '013271'\naccount_name: Gang Liu\naccount_number: '283165576'\nend_date: 2022-12-31\nid: 56\nencrypted_password: "$2a$12$9duBvD1DC3O1gcY6yK0oc.d/5CsCO9pMAoh1/nzZ9ue0AzOZvgaaC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bc6b97\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:34:36.503011
305	Client	63	update	\N	---\nemail: fei_bob@yahoo.com.au\nupper_client_id: 29\nbeaver_id: '146060'\nname: Zongquan YU\nclient_type: 0\ncountry_code: "+86 "\nmobile: '15312280884'\nbirth: 1936-03-26\nbsb: '033385'\naccount_name: Zhongquan YU\naccount_number: '608172'\nend_date: 2022-12-31\nid: 63\nencrypted_password: "$2a$12$QNmagvNm729y63o5bBvvNuOtezqd2TaYSnLV810NIfXSADS157CJq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: edbe5a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:34:53.523449
306	Client	64	update	\N	---\nemail: colingugo@gmail.com\nupper_client_id: 29\nbeaver_id: '146061'\nname: Minghao GU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430888660 '\nbirth: 1984-05-13\nbsb: '033090'\naccount_name: 'Colin Family Trust '\naccount_number: '593292'\nend_date: 2022-03-31\nid: 64\nencrypted_password: "$2a$12$XyEUco2tUSA7zBxtWgUHbu6facSmI5xvFKQShjHvULciIket3dKQe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 78c67f\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:35:10.128562
307	Client	67	update	\N	---\nemail: dongrjin@hotmail.com\nupper_client_id: 29\nbeaver_id: '146064'\nname: Dong Rong JIN\nclient_type: 0\ncountry_code: "+61"\nmobile: " 421026554"\nbirth: 1979-04-02\nbsb: '733340'\naccount_name: Dongrong Jin\naccount_number: '525047'\nend_date: \nid: 67\nencrypted_password: "$2a$12$nDrCIGYB8mTSmvrBrKedLu9Dlw0jZUy3IytV7dTC0wxVp3iiXaRQW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: df6f9a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:35:29.149574
308	Client	57	update	\N	---\nemail: qiantai1953@163.com\nupper_client_id: 29\nbeaver_id: '146065'\nname: Aiping HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '490740992'\nbirth: 1953-12-29\nbsb: '083251'\naccount_name: AIPING HUANG\naccount_number: '783354998'\nend_date: 2022-12-31\nid: 57\nencrypted_password: "$2a$12$vl7YYtWbB9Ef8U3L6JQm3ObhAzjHbB8VWOgxKzCPTD1l4Ha/EzK6e"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 02a82d\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:35:54.385663
309	Client	70	update	\N	---\nemail: 732672012@qq.com\nupper_client_id: 29\nbeaver_id: '146068'\nname: Liping TAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '415066168'\nbirth: 1972-11-27\nbsb: '063182'\naccount_name: Liping TAN\naccount_number: '11353113'\nend_date: \nid: 70\nencrypted_password: "$2a$12$cvw2ubfR2tcy02inlFNXx.dE4D4Wdv8Gr5dUH3Hwr8f7W/3O351by"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9b118\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:36:11.971856
310	Client	74	update	\N	---\nemail: znguo@hotmail.com\nupper_client_id: 29\nbeaver_id: '146069'\nname: Zining Guo\nclient_type: 0\ncountry_code: "+61 "\nmobile: "+61 433551026"\nbirth: 1971-10-24\nbsb: '193879'\naccount_name: Zining GUO\naccount_number: '421753115'\nend_date: \nid: 74\nencrypted_password: "$2a$12$rBGwWyEXJNMLBVBZ.T7raewC6gs8g0fhS1eigtevLynN69F22Scuy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c187b3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:36:34.667038
311	Client	75	update	\N	---\nemail: luckyguo666@gmail.com\nupper_client_id: 29\nbeaver_id: '146070'\nname: Shuangqin GUO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '491458888'\nbirth: 1972-04-30\nbsb: '063109'\naccount_name: Lucky Guo Family Trust\naccount_number: '13340337'\nend_date: \nid: 75\nencrypted_password: "$2a$12$qmmOwLAt.yjWPEIPbnxMYuytiYzNcbh7nn3qROaPfRmqcirOa8T7."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d0f40e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:37:46.404601
312	Client	76	update	\N	---\nemail: yeungmandy2009@hotmail.com\nupper_client_id: 29\nbeaver_id: '146071'\nname: Manli YANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '405802733'\nbirth: 1958-03-06\nbsb: '063157'\naccount_name: Manli Yang\naccount_number: '10079645'\nend_date: \nid: 76\nencrypted_password: "$2a$12$kS4BT.B2UCG8RBytPbPlRuBtgFYXqOviquFMeCNL6k5OndqNFwlHW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 6e1a8a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:38:02.927377
313	Client	77	update	\N	---\nemail: xianli612@yahoo.com.au\nupper_client_id: 29\nbeaver_id: '146072'\nname: Xian LI\nclient_type: 0\ncountry_code: "+61 "\nmobile: '410702922'\nbirth: 1971-12-06\nbsb: '733173'\naccount_name: Xian Li\naccount_number: '682028'\nend_date: \nid: 77\nencrypted_password: "$2a$12$25BuLaqGoUKLjDzb.ZOYjeBX1Jq/K2IWz3iQ7USOHxyMYfLbQFKge"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3e8911\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:38:28.242162
314	Client	96	update	\N	---\nemail: sunrising@vip.163.com\nupper_client_id: 29\nbeaver_id: '146075'\nname: Jianhong DU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411326152'\nbirth: 1974-12-08\nbsb: '083 231'\naccount_name: Jianhong DU\naccount_number: '395996550'\nend_date: \nid: 96\nencrypted_password: "$2a$12$Vix0TU0bBNS3LgtnlSubUO6IVk.nEzPs1DqnUSNTjzioenWvkVN7m"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: be5e46\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:38:45.29598
315	Client	98	update	\N	---\nemail: boxing.han@icloud.com\nupper_client_id: 29\nbeaver_id: '146076'\nname: Han Family SMSF Pty Ltd ATF Han Family SMSF\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450029266'\nbirth: 1967-03-20\nbsb: 033 358\naccount_name: Han Family SMSF Pty Ltd ATF Han Family SMSF\naccount_number: '650260'\nend_date: \nid: 98\nencrypted_password: "$2a$12$U0v8arUWGeVuiin5YMIzZOH6ogAvZwke17NHYdVMxm0XAIvSA7JtW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bc7224\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:39:08.459236
316	Client	99	update	\N	---\nemail: liang84926@hotmail.com\nupper_client_id: 29\nbeaver_id: '146077'\nname: Vathey Investment Pty Ltd\nclient_type: 0\ncountry_code: "+61 "\nmobile: '433500614'\nbirth: 1984-05-20\nbsb: '063109'\naccount_name: Vathey Investment Pty Ltd\naccount_number: '13376428'\nend_date: \nid: 99\nencrypted_password: "$2a$12$ufFuYQCIbgD3LKrtiO8yeeBpmIkBTPrQLhi5cwzTxqC3plIgA9V.O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 80d5e5\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:39:26.854044
317	Client	99	update	\N	---\nemail: liang84926@hotmail.com\nupper_client_id: 108\nbeaver_id: '146077'\nname: Vathey Investment Pty Ltd\nclient_type: 0\ncountry_code: "+61 "\nmobile: '433500614'\nbirth: 1984-05-20\nbsb: '063109'\naccount_name: Vathey Investment Pty Ltd\naccount_number: '13376428'\nend_date: \nid: 99\nencrypted_password: "$2a$12$ufFuYQCIbgD3LKrtiO8yeeBpmIkBTPrQLhi5cwzTxqC3plIgA9V.O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 80d5e5\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:39:56.8645
398	Client	135	destroy	\N	---\nid: 135\nemail: frank.mai@beavercapital.com.au\nencrypted_password: "$2a$12$9lWlPmF3a7nlR9idq9joI.p5Ov/8FKmyTExEQAugY91udkRGMl3/S"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: frank\nclient_type: \ncountry_code: ''\nmobile: ''\nsalt: 7fdfdb\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 14:55:39.054416
318	Client	100	update	\N	---\nemail: dadudie88@gmail.com\nupper_client_id: 29\nbeaver_id: '146078'\nname: Liu SMSF Pty Ltd ATF Liu SMSF\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430086816'\nbirth: 1970-01-08\nbsb: 193 879\naccount_name: Liu SMSF Pty Ltd ATF Liu SMSF\naccount_number: '440350080'\nend_date: \nid: 100\nencrypted_password: "$2a$12$T35df/Y.9MSc4TvC3aKO8OajEi5MbeWbLCBKdNM9k2U1YbpStxov2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3a162f\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:40:13.922716
319	Client	101	update	\N	---\nemail: ivanlu@me.com\nupper_client_id: 29\nbeaver_id: '146079'\nname: Yifan LU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '478586867'\nbirth: 1974-10-16\nbsb: '063619'\naccount_name: Autstrip Pty Ltd ATF Lu Family Trust\naccount_number: '10435170'\nend_date: \nid: 101\nencrypted_password: "$2a$12$1aKn0gcrg4Obrquaiy.T2ubo4AT703mfCRQkct2.Jjoh50BIeqbaW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ae7cef\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:40:30.427217
406	Client	139	update	\N	---\nemail: " pgg100@163.com"\nupper_client_id: \nbeaver_id: ''\nname: Guige PIAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '426289960'\nbirth: \nbsb: '063182'\naccount_name: Guige PIAO\naccount_number: '11426474'\nend_date: \nid: 139\nencrypted_password: "$2a$12$wCaSdezLprkMAlPFwU62p..CvwDWMrkdGfiT7M3KvEOoHOCBWtTSa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d6864e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 15:25:09.312467
320	Client	102	update	\N	---\nemail: lanchenlan@hotmail.com\nupper_client_id: 29\nbeaver_id: '146080'\nname: Minglan CHEN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430032484'\nbirth: 1954-05-04\nbsb: 063 154\naccount_name: Minglan CHEN\naccount_number: 1057 2614\nend_date: \nid: 102\nencrypted_password: "$2a$12$bwuswOiiUioIN7m1BTYzF.RrwBVRkYCOy/h9rjz/TuoUp99I6HMHG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 702acb\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:40:54.624579
321	Client	103	update	\N	---\nemail: zhoufangde@163.com\nupper_client_id: 29\nbeaver_id: '146081'\nname: Yong ZHANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '474324185'\nbirth: 1968-11-25\nbsb: '343002'\naccount_name: Yong ZHANG\naccount_number: '541274439'\nend_date: \nid: 103\nencrypted_password: "$2a$12$BlKTqPauD3.rGgALz2CFw.nJeSvgj1mCT3uwdvIe/PoeD4zWgquVy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c67257\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-30 15:42:17.185652
322	Client	30	update	\N	---\nemail: gxsyj1970@163.com\nupper_client_id: 108\nbeaver_id: '146035'\nname: Yijun SUN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0406779863'\nbirth: 1970-10-23\nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \nid: 30\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 12d52b\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 08:20:55.724533
323	Client	60	update	\N	---\nemail: 525196937@qq.com\nupper_client_id: 108\nbeaver_id: '146056'\nname: Xiandong GAO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '402127828'\nbirth: 1971-02-01\nbsb: '062692'\naccount_name: Xiandong GAO\naccount_number: '46930314'\nend_date: 2022-12-31\nid: 60\nencrypted_password: "$2a$12$LH/6smX5KVaZ7zDETGaMOuWIHf7dMCT3BdxL8uS5OI41qrpSUbb.."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bcfa9e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 08:21:22.094847
324	Client	62	update	\N	---\nemail: pwy20081222@163.com\nupper_client_id: 108\nbeaver_id: '146058'\nname: Yanchao SHU\nclient_type: 0\ncountry_code: "+61"\nmobile: '420217659'\nbirth: 1976-01-29\nbsb: 063-109\naccount_name: Yanchao SHU\naccount_number: '11657760'\nend_date: 2022-12-31\nid: 62\nencrypted_password: "$2a$12$s6L3dFCW7mRH.FDvdsVh7eOLm4ofXNku7lE6n3dniGRkYAh23Q6/O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b9ab02\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 08:21:42.789679
325	Client	28	update	\N	---\nemail: boxing.han@hotmail.com\nupper_client_id: 108\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nbirth: \nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \nid: 28\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b2c8cd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 08:26:51.859222
326	Client	29	update	\N	---\nemail: changfamily608@gmail.com\nupper_client_id: 108\nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0430086816'\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \nid: 29\nencrypted_password: "$2a$12$YYTS1SVDiiTT0YpeES4y7OQly.c2O7PpnDV2Zy9DQS8vT7jA16XqG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9624b\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 09:14:12.796106
327	Client	31	update	\N	---\nemail: cizhang2017@foxmail.com\nupper_client_id: 108\nbeaver_id: '146037'\nname: Ci Zhang\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0481735199'\nbirth: 2022-09-01\nbsb: 033-172\naccount_name: Oasisun Management Pty Ltd ATF Sean Family Trust\naccount_number: '914168'\nend_date: \nid: 31\nencrypted_password: "$2a$12$1fROJsjVNQAkdd5vsLZKC.yHSjH8.qbR5sRkdnUna2JasjWI.PcFO"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f02cb8\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 09:14:35.691181
328	Client	33	update	\N	---\nemail: lanwatts3@gmail.com\nupper_client_id: 108\nbeaver_id: '146039'\nname: Minglan Chen\nclient_type: 0\ncountry_code: ''\nmobile: '0430032484'\nbirth: 1954-05-03\nbsb: 063-154\naccount_name: Calm & Harmony Pty Ltd Trustee For Forever Young Superfund\naccount_number: '10791817'\nend_date: \nid: 33\nencrypted_password: "$2a$12$XKLvOKd5kWDDrkm5TwCpZ.r4Z73OVL5b6JTxk4o2ZgXTIC6I1geBa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 66b4cf\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 09:15:34.051411
329	Client	34	update	\N	---\nemail: chunnianding@gmail.com\nupper_client_id: 108\nbeaver_id: '146040'\nname: Chunnian Ding\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0409703433'\nbirth: 2022-02-07\nbsb: 733-173\naccount_name: Chunnian Ding\naccount_number: '644056'\nend_date: \nid: 34\nencrypted_password: "$2a$12$WH4aF8otGtxc9OfPx7cH..JdMQzH2.kF7yDHo3PthBfoES3ETWe3q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 909dc8\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 10:24:06.17013
330	Client	35	update	\N	---\nemail: wanyp@yahoo.com\nupper_client_id: 108\nbeaver_id: '146041'\nname: Yu Ping Wan\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0481991606'\nbirth: 2022-06-28\nbsb: '085-458'\naccount_name: Yu Ping Wan\naccount_number: '452488246'\nend_date: 2022-09-30\nid: 35\nencrypted_password: "$2a$12$pfZB4W1YgFVIeG0gDj7ToOsvAxXCySLKCdXbJVbNoSHV7lGI3a0X6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0c971d\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 10:24:30.100408
331	Client	36	update	\N	---\nemail: 380817544@qq.com\nupper_client_id: 108\nbeaver_id: '146042'\nname: Chang Qin\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0484191561'\nbirth: 1973-10-14\nbsb: 063-109\naccount_name: Chang Qin\naccount_number: '11687388'\nend_date: 2022-10-31\nid: 36\nencrypted_password: "$2a$12$HaKHCRMJzthpRLwoqQFq1u1oxHxqqQZwunfd4L/8eGEpIlw.sB9Pi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '592097'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 10:24:44.9333
399	Client	136	create	\N	\N	2022-09-12 15:04:35.816426
400	Client	137	create	\N	\N	2022-09-12 15:07:49.599765
332	Client	45	update	\N	---\nemail: jerryyanchao77@gmail.com\nupper_client_id: 108\nbeaver_id: '146045'\nname: Yanchao YANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0414153421'\nbirth: 1995-09-01\nbsb: '083-019'\naccount_name: Yanchao Yang\naccount_number: '471967971'\nend_date: 2022-10-31\nid: 45\nencrypted_password: "$2a$12$0Xkh51VvKFqizUYKGm/6muRVvaHxUz5ScLmBVZdhxnWcDwocgkthq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 14b152\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 10:25:01.177658
333	Client	52	update	\N	---\nemail: ling.abid@gmail.com\nupper_client_id: 108\nbeaver_id: '146050'\nname: Ling YUAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0452181678'\nbirth: 1971-06-25\nbsb: '083-343 '\naccount_name: Ling YUAN\naccount_number: '187071326'\nend_date: 2022-11-30\nid: 52\nencrypted_password: "$2a$12$PR2JV4qWVoB99OsrMQtxAO/wJXQT6OU1aYKXzs1jPDblELNBPAScq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 8f5edd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 10:26:02.059029
407	Client	140	create	\N	\N	2022-09-12 15:26:55.498929
334	Client	102	update	\N	---\nemail: lanchenlan@hotmail.com\nupper_client_id: 108\nbeaver_id: '146080'\nname: Minglan CHEN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430032484'\nbirth: 1954-05-04\nbsb: 063 154\naccount_name: Minglan CHEN\naccount_number: 1057 2614\nend_date: \nid: 102\nencrypted_password: "$2a$12$bwuswOiiUioIN7m1BTYzF.RrwBVRkYCOy/h9rjz/TuoUp99I6HMHG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 702acb\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:02:29.950081
335	Client	101	update	\N	---\nemail: ivanlu@me.com\nupper_client_id: 108\nbeaver_id: '146079'\nname: Yifan LU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '478586867'\nbirth: 1974-10-16\nbsb: '063619'\naccount_name: Autstrip Pty Ltd ATF Lu Family Trust\naccount_number: '10435170'\nend_date: \nid: 101\nencrypted_password: "$2a$12$1aKn0gcrg4Obrquaiy.T2ubo4AT703mfCRQkct2.Jjoh50BIeqbaW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ae7cef\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:02:44.143129
336	Client	100	update	\N	---\nemail: dadudie88@gmail.com\nupper_client_id: 108\nbeaver_id: '146078'\nname: Liu SMSF Pty Ltd ATF Liu SMSF\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430086816'\nbirth: 1970-01-08\nbsb: 193 879\naccount_name: Liu SMSF Pty Ltd ATF Liu SMSF\naccount_number: '440350080'\nend_date: \nid: 100\nencrypted_password: "$2a$12$T35df/Y.9MSc4TvC3aKO8OajEi5MbeWbLCBKdNM9k2U1YbpStxov2"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3a162f\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:03:01.836759
337	Client	99	update	\N	---\nemail: liang84926@hotmail.com\nupper_client_id: 108\nbeaver_id: '146077'\nname: 'Ju LIANG '\nclient_type: 0\ncountry_code: "+61 "\nmobile: '433500614'\nbirth: 1984-05-20\nbsb: '063109'\naccount_name: Vathey Investment Pty Ltd\naccount_number: '13376428'\nend_date: \nid: 99\nencrypted_password: "$2a$12$ufFuYQCIbgD3LKrtiO8yeeBpmIkBTPrQLhi5cwzTxqC3plIgA9V.O"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 80d5e5\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:03:17.097954
338	Client	98	update	\N	---\nemail: boxing.han@icloud.com\nupper_client_id: 108\nbeaver_id: '146076'\nname: Han Family SMSF Pty Ltd ATF Han Family SMSF\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450029266'\nbirth: 1967-03-20\nbsb: 033 358\naccount_name: Han Family SMSF Pty Ltd ATF Han Family SMSF\naccount_number: '650260'\nend_date: \nid: 98\nencrypted_password: "$2a$12$U0v8arUWGeVuiin5YMIzZOH6ogAvZwke17NHYdVMxm0XAIvSA7JtW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bc7224\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:03:33.699131
339	Client	75	update	\N	---\nemail: luckyguo666@gmail.com\nupper_client_id: 108\nbeaver_id: '146070'\nname: Shuangqin GUO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '491458888'\nbirth: 1972-04-30\nbsb: '063109'\naccount_name: Lucky Guo Family Trust\naccount_number: '13340337'\nend_date: \nid: 75\nencrypted_password: "$2a$12$qmmOwLAt.yjWPEIPbnxMYuytiYzNcbh7nn3qROaPfRmqcirOa8T7."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d0f40e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:03:50.759021
340	Client	74	update	\N	---\nemail: znguo@hotmail.com\nupper_client_id: 108\nbeaver_id: '146069'\nname: Zining Guo\nclient_type: 0\ncountry_code: "+61 "\nmobile: "+61 433551026"\nbirth: 1971-10-24\nbsb: '193879'\naccount_name: Zining GUO\naccount_number: '421753115'\nend_date: \nid: 74\nencrypted_password: "$2a$12$rBGwWyEXJNMLBVBZ.T7raewC6gs8g0fhS1eigtevLynN69F22Scuy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c187b3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:04:05.296182
341	Client	70	update	\N	---\nemail: 732672012@qq.com\nupper_client_id: 108\nbeaver_id: '146068'\nname: Liping TAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '415066168'\nbirth: 1972-11-27\nbsb: '063182'\naccount_name: Liping TAN\naccount_number: '11353113'\nend_date: \nid: 70\nencrypted_password: "$2a$12$cvw2ubfR2tcy02inlFNXx.dE4D4Wdv8Gr5dUH3Hwr8f7W/3O351by"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c9b118\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:04:21.823588
342	Client	57	update	\N	---\nemail: qiantai1953@163.com\nupper_client_id: 108\nbeaver_id: '146065'\nname: Aiping HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '490740992'\nbirth: 1953-12-29\nbsb: '083251'\naccount_name: AIPING HUANG\naccount_number: '783354998'\nend_date: 2022-12-31\nid: 57\nencrypted_password: "$2a$12$vl7YYtWbB9Ef8U3L6JQm3ObhAzjHbB8VWOgxKzCPTD1l4Ha/EzK6e"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 02a82d\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:04:37.574236
343	Client	67	update	\N	---\nemail: dongrjin@hotmail.com\nupper_client_id: 108\nbeaver_id: '146064'\nname: Dong Rong JIN\nclient_type: 0\ncountry_code: "+61"\nmobile: " 421026554"\nbirth: 1979-04-02\nbsb: '733340'\naccount_name: Dongrong Jin\naccount_number: '525047'\nend_date: \nid: 67\nencrypted_password: "$2a$12$nDrCIGYB8mTSmvrBrKedLu9Dlw0jZUy3IytV7dTC0wxVp3iiXaRQW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: df6f9a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:04:55.053939
344	Client	64	update	\N	---\nemail: colingugo@gmail.com\nupper_client_id: 108\nbeaver_id: '146061'\nname: Minghao GU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430888660 '\nbirth: 1984-05-13\nbsb: '033090'\naccount_name: 'Colin Family Trust '\naccount_number: '593292'\nend_date: 2022-03-31\nid: 64\nencrypted_password: "$2a$12$XyEUco2tUSA7zBxtWgUHbu6facSmI5xvFKQShjHvULciIket3dKQe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 78c67f\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:05:11.424322
345	Client	63	update	\N	---\nemail: fei_bob@yahoo.com.au\nupper_client_id: 108\nbeaver_id: '146060'\nname: Zongquan YU\nclient_type: 0\ncountry_code: "+86 "\nmobile: '15312280884'\nbirth: 1936-03-26\nbsb: '033385'\naccount_name: Zhongquan YU\naccount_number: '608172'\nend_date: 2022-12-31\nid: 63\nencrypted_password: "$2a$12$QNmagvNm729y63o5bBvvNuOtezqd2TaYSnLV810NIfXSADS157CJq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: edbe5a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:05:27.779208
346	Client	61	update	\N	---\nemail: mikehuang166@gmail.com\nupper_client_id: 108\nbeaver_id: '146057'\nname: Zhengrong HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '431999636'\nbirth: 1977-01-16\nbsb: 033-084\naccount_name: 'Xinyue Investment Group '\naccount_number: '526085'\nend_date: 2022-12-31\nid: 61\nencrypted_password: "$2a$12$irvl936TDFbjlNGXWrHkteuGq7Bl/B2jO7lfDfcP.K1MefG/pdfGS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3ab932\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:05:43.67482
347	Client	53	update	\N	---\nemail: wuyang900627@gmail.com\nupper_client_id: 108\nbeaver_id: '146052'\nname: Yang WU\nclient_type: 0\ncountry_code: ''\nmobile: '0401877559'\nbirth: 1990-06-27\nbsb: '083004'\naccount_name: Yang Wu\naccount_number: '534625451'\nend_date: 2022-11-30\nid: 53\nencrypted_password: "$2a$12$ITerLJC/DNnCch8Gsdk3SuMVvAN2Y/cl1/F2TJtm6XxWzNsiO1zFW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 2eea74\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-05-31 12:05:58.46596
348	Client	109	create	\N	\N	2022-06-01 14:53:17.420164
349	Client	110	create	\N	\N	2022-06-10 09:41:20.396372
350	Client	111	create	\N	\N	2022-06-10 15:59:30.909861
351	Client	109	update	\N	---\nemail: susanxu70@gmail.com\nupper_client_id: 108\nbeaver_id: '146082'\nname: Lei WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '435998867'\nbirth: 1968-11-06\nbsb: 063 010\naccount_name: wuxufamilysuperfund pty ltd ATF wuxufamilysuperannuation\naccount_number: '14628244'\nend_date: \nid: 109\nencrypted_password: "$2a$12$KtpSEXiw1hEwfc3yGMoZQ.mkx/x6UHkktB2/ryr6Gzt/qcOW8tAZC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 460adc\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-06-13 14:07:18.450816
352	Client	111	update	\N	---\nemail: taoyongjuan@gmail.com\nupper_client_id: 29\nbeaver_id: '146084'\nname: Zhenrong HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '431999636'\nbirth: 1977-01-16\nbsb: 033 084\naccount_name: Zhengrong Yongjuan Pty Ltd ATF Zhengrong Yongjuan Superannuation Fund\naccount_number: '526106'\nend_date: \nid: 111\nencrypted_password: "$2a$12$ikSBm65PhgMNnngkP328OOx0hUcgvSAhAkyOfBWIv6lOvztBuQu/K"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 9df6db\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-06-13 14:20:21.453606
353	Client	112	create	\N	\N	2022-06-14 13:01:32.508013
354	Client	110	update	\N	---\nname: Wenyan WU\nbirth: 1973-09-30\nencrypted_password: "$2a$12$aWs585XEGYpszm2HHd2bBeH5v/8v7ChLI4o44bPsYd0UqjkuIyrZS"\nemail: cindyyan73@gmail.com\nid: 110\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 14\nbeaver_id: '146083'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '423245522'\nsalt: e3af49\nbsb: 182-512\naccount_name: Wenyan Wu Pty Ltd ATF Wu Superannuation Fund\naccount_number: '960584316'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-06-14 21:40:42.931542
355	Client	108	update	\N	---\nencrypted_password: "$2a$12$FRBmtVK4CaxOvBp5siT5CO1eGUKQ2t7EkHMfRjxSmwHggtJa97Lhe"\nemail: valueup88@gmail.com\nid: 108\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: Value Up\nclient_type: 1\ncountry_code: "+61"\nmobile: '452535677'\nsalt: 291dd5\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-06-29 19:05:36.202687
356	Client	29	update	\N	---\nencrypted_password: "$2a$12$YYTS1SVDiiTT0YpeES4y7OQly.c2O7PpnDV2Zy9DQS8vT7jA16XqG"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-06-30 10:12:22.073084
357	Client	100	update	\N	---\nencrypted_password: "$2a$12$T35df/Y.9MSc4TvC3aKO8OajEi5MbeWbLCBKdNM9k2U1YbpStxov2"\nemail: dadudie88@gmail.com\nid: 100\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146078'\nname: Liu SMSF Pty Ltd ATF Liu SMSF\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430086816'\nsalt: 3a162f\nbirth: 1970-01-08\nbsb: 193 879\naccount_name: Liu SMSF Pty Ltd ATF Liu SMSF\naccount_number: '440350080'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-06-30 12:33:16.135934
358	Client	113	create	\N	\N	2022-07-06 15:29:05.681087
359	Client	114	create	\N	\N	2022-07-07 14:32:51.279776
360	Client	115	create	\N	\N	2022-07-07 19:59:24.383876
361	Client	116	create	\N	\N	2022-07-08 12:06:29.958884
362	Client	116	update	\N	---\nencrypted_password: "$2a$12$ODVOoUdCyHnTJn/zJ3qmluPDX/SjquJUZ93U1c1Z8UYgroMq8QD5C"\nemail: kelly.li37942@gmail.com\nid: 116\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: number1\nclient_type: \ncountry_code: '61'\nmobile: '0451098006'\nsalt: 8e9908\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '2'\ninvest_entity: 0\ninvest_status: 0\n	2022-07-08 15:34:24.192458
363	Client	117	create	\N	\N	2022-07-13 09:49:23.148535
364	Client	118	create	\N	\N	2022-07-19 15:34:41.889663
365	Client	118	update	\N	---\nemail: caobinger@163.com\nupper_client_id: \nbeaver_id: ''\nname: 'Shengling '\nclient_type: \ncountry_code: "+61 "\nmobile: '450491770'\nbirth: \nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \nid: 118\nencrypted_password: "$2a$12$SUW8KNVmndX02c91G.wrheQzx3zOZurz0wW7O4wl7CAeTnSYi1.da"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 0ff910\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-07-19 15:37:14.553857
366	Client	119	create	\N	\N	2022-07-19 15:49:04.881874
367	Client	120	create	\N	\N	2022-07-25 07:51:42.135453
368	Client	66	update	\N	---\nencrypted_password: "$2a$12$L5kaM9HvCVnhX/hxMwqeQucEnN/eiVtnT4CjPpwayHtdvGz.TKM6G"\nemail: hlgs3030@outlook.com\nid: 66\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 54\nbeaver_id: '146063'\nname: Kangjun ZHU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '436335777'\nsalt: 3a0f53\nbirth: 1968-11-17\nbsb: '112879'\naccount_name: Gold Phoenix Holding Pry Ltd ATF Jing Hui Feng Liang Trust\naccount_number: '416697737'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-07-28 09:03:00.17358
369	Client	121	create	\N	\N	2022-08-03 13:00:15.048051
370	Client	30	update	\N	---\nencrypted_password: "$2a$12$wKKhnEFdQuVd.zWMtYGJo.mQGAZnKhV7y4e3BXW/Z3JEjw2M9.jry"\nemail: gxsyj1970@163.com\nid: 30\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 30\nbeaver_id: '146035'\nname: Yijun SUN\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0406779863'\nsalt: 12d52b\nbirth: 1970-10-23\nbsb: 033-089\naccount_name: EVERGREEN SUN PTY LTD\naccount_number: '623802'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-05 17:27:47.711449
371	Client	122	create	\N	\N	2022-08-11 10:24:41.357975
372	Client	123	create	\N	\N	2022-08-12 13:22:28.125217
373	Client	124	create	\N	\N	2022-08-12 15:37:32.767643
374	Client	125	create	\N	\N	2022-08-12 15:41:24.818784
375	Client	123	update	\N	---\nname: Qi WANG\nbirth: 1977-08-03\nencrypted_password: "$2a$12$ezc2Yv8qpQhWmrDavhNmQ.8K9GBABGyNbka3jsD5AaT7tCRg.T7d."\nemail: steven.qiwang@gmail.com\nid: 123\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146091'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '416560766'\nsalt: fc85cd\nbsb: '083028'\naccount_name: Qianxi Investment Pty Ltd ATF Wang Family Trust\naccount_number: '442078614'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-12 17:51:24.692862
376	Client	126	create	\N	\N	2022-08-16 14:20:46.684958
377	Client	127	create	\N	\N	2022-08-16 14:25:51.097587
378	Client	128	create	\N	\N	2022-08-19 15:37:27.76877
379	Client	128	update	\N	---\nname: 'Xiaobo HAN '\nbirth: \nencrypted_password: "$2a$12$hmjKTuAx6hV6NRftSAVT0OdBgswjhIiaXtwb.8Ls2WraLFOgIinIS"\nemail: charliehan74@gmail.com\nid: 128\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 14\nbeaver_id: ''\nclient_type: 0\ncountry_code: "+61 "\nmobile: '422849728'\nsalt: fb52b4\nbsb: 065-005\naccount_name: Xiaobo HAN ATF Han Investment Trust\naccount_number: '10836693'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-20 10:24:48.421854
380	Client	129	create	\N	\N	2022-08-22 09:55:48.034798
381	Client	130	create	\N	\N	2022-08-25 15:22:48.3441
382	Client	63	update	\N	---\nemail: fei_bob@yahoo.com.au\nupper_client_id: 29\nbeaver_id: '146060'\nname: Zongquan YU\nclient_type: 0\ncountry_code: "+86 "\nmobile: '15312280884'\nbirth: 1936-03-26\nbsb: '033385'\naccount_name: Zhongquan YU\naccount_number: '608172'\nend_date: 2022-12-31\nid: 63\nencrypted_password: "$2a$12$QNmagvNm729y63o5bBvvNuOtezqd2TaYSnLV810NIfXSADS157CJq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: edbe5a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-25 15:39:29.858256
383	Client	131	create	\N	\N	2022-08-25 15:41:29.514371
384	Client	110	update	\N	---\nemail: cindyyan73@gmail.com\nupper_client_id: 14\nbeaver_id: '146083'\nname: cindyyan73@gmail.com\nclient_type: 0\ncountry_code: "+61 "\nmobile: '423245522'\nbirth: 1973-09-30\nbsb: 182-512\naccount_name: Wenyan Wu Pty Ltd ATF Wu Superannuation Fund\naccount_number: '960584316'\nend_date: \nid: 110\nencrypted_password: "$2a$12$gygy23xDaG5zAPiyw2IlXOjxHWZQDatH4I1lsd9PBFk9DUxNC3Uvq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: e3af49\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-25 15:51:30.481386
385	Client	132	create	\N	\N	2022-08-25 15:55:20.716269
386	Client	133	create	\N	\N	2022-08-31 10:09:55.783112
387	Client	133	update	\N	---\nemail: anxiangau@qq.com\nupper_client_id: 29\nbeaver_id: '146030'\nname: Mandy CHEN\nclient_type: 0\ncountry_code: "+61"\nmobile: '424508766'\nbirth: 1964-01-23\nbsb: 034-069\naccount_name: Chen246 Pty Ltd ATF Chen246 Superannuation Fund\naccount_number: '459720'\nend_date: \nid: 133\nencrypted_password: "$2a$12$LCUJ2zywzdwexHuaRcPrTOAZjzDlTs2HYps6MstOzwD1gtPsHOpkC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '320128'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-31 10:14:04.115435
388	Client	133	update	\N	---\nemail: anxiangau@qq.com\nupper_client_id: 29\nbeaver_id: ''\nname: Mandy CHEN\nclient_type: 0\ncountry_code: "+61"\nmobile: '424508766'\nbirth: 1964-01-23\nbsb: 034-069\naccount_name: Chen246 Pty Ltd ATF Chen246 Superannuation Fund\naccount_number: '459720'\nend_date: \nid: 133\nencrypted_password: "$2a$12$LCUJ2zywzdwexHuaRcPrTOAZjzDlTs2HYps6MstOzwD1gtPsHOpkC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '320128'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-08-31 10:15:15.097115
389	Client	73	update	\N	---\nencrypted_password: "$2a$12$vsCT6fgCL1NnN9ErLEL/6e8I6WP0W5.vObNn0396TRqN8NU28UsM2"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-02 14:42:58.59732
390	Client	28	update	\N	---\nencrypted_password: "$2a$12$Wk8klaY0z2ro9rkhtCqKeOHRI4Lomxus8JOf4K5fibXloR35GZXhe"\nemail: boxing.han@hotmail.com\nid: 28\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nsalt: b2c8cd\nbirth: \nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-08 20:11:27.603947
391	Client	28	update	\N	---\nencrypted_password: "$2a$12$P8yzEEQQRgvu9kwj9lzbUulnarfVW2EdQoLFx0WBl9QFFcWoHsD8K"\nemail: boxing.han@hotmail.com\nid: 28\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146034'\nname: Boxing Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nsalt: b2c8cd\nbirth: \nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-08 20:11:27.893545
392	Client	73	update	\N	---\nencrypted_password: "$2a$12$ab2caJmK3gdyGrQPxUwUDuesNs/VsZWe53HXiZsYpKYkyq08N0a.m"\nemail: hans@beavercapital.com.au\nid: 73\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '146024'\nname: JIANG HAN\nclient_type: 0\ncountry_code: "+61 "\nmobile: '450099688'\nsalt: b13287\nbirth: 1979-03-24\nbsb: '082-309'\naccount_name: Wins republic pty ltd\naccount_number: '764275848'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-08 20:44:53.639739
393	Client	28	update	\N	---\nname: Boxing Han\nbirth: \nencrypted_password: "$2a$12$dkizza95.NbNtMRVadAvfulT0J1nRXmfveV/89nnn8kvqM23X7C0m"\nemail: boxing.han@hotmail.com\nid: 28\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146034'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nsalt: b2c8cd\nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-08 20:56:08.201317
394	Client	134	create	\N	\N	2022-09-09 13:00:54.064419
395	Client	134	update	\N	---\nemail: frank.mai@beavercapital.com.au\nupper_client_id: \nbeaver_id: ''\nname: Frank\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \nid: 134\nencrypted_password: "$2a$12$uyrOyksFHNDfM6aPbMP9deR7mNPSgDZJToDfnNsj9defRyiW04L7G"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: fa4574\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-09 13:01:07.105093
396	Client	134	destroy	\N	---\nid: 134\nemail: frank.mai@beavercapital.com.au\nencrypted_password: "$2a$12$uyrOyksFHNDfM6aPbMP9deR7mNPSgDZJToDfnNsj9defRyiW04L7G"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: '999999999'\nname: Frank\nclient_type: \ncountry_code: ''\nmobile: ''\nsalt: fa4574\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-09 13:02:45.876427
397	Client	135	create	\N	\N	2022-09-12 14:49:49.629331
401	Client	138	create	\N	\N	2022-09-12 15:19:21.698156
402	Client	136	update	\N	---\nemail: 1633040554@qq.com\nupper_client_id: 29\nbeaver_id: ''\nname: Jialu YANG\nclient_type: 0\ncountry_code: "+61"\nmobile: '406571889'\nbirth: 1994-09-28\nbsb: '033173'\naccount_name: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\naccount_number: '104917'\nend_date: \nid: 136\nencrypted_password: "$2a$12$BDY0oF07aUT3FN7wXYme/Oc7FASwZodIczYUUiO1czxIaZM1Evtxe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ee55e3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 15:21:23.356754
403	Client	137	update	\N	---\nemail: sandygaohx@hotmail.com\nupper_client_id: 29\nbeaver_id: ''\nname: HUIXIA GAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '422403797'\nbirth: 1972-10-05\nbsb: '083266'\naccount_name: Huixia GAO\naccount_number: '773855617'\nend_date: \nid: 137\nencrypted_password: "$2a$12$IUaUcNVyf9nJTNkGWogLuuUKPCPtL6n6T5snZH867vaO6RdroCERq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: a85e80\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 15:21:41.44281
404	Client	138	update	\N	---\nemail: " 13906264851@163.com"\nupper_client_id: 29\nbeaver_id: ''\nname: Weihai MO\nclient_type: 0\ncountry_code: "+61"\nmobile: '481161576'\nbirth: 1973-03-28\nbsb: '083153'\naccount_name: M&H Management Pty Ltd ATF Mo & Huang Family Trust\naccount_number: '763182527'\nend_date: \nid: 138\nencrypted_password: "$2a$12$I4G0Ys/asziKuw3//fCNSudCiU6ul4hobvDMTqfpx8G1.kza1zFNq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ecc999\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 15:21:53.324546
405	Client	139	create	\N	\N	2022-09-12 15:24:40.349744
408	Client	136	update	\N	---\nemail: 1633040554@qq.com\nupper_client_id: 72\nbeaver_id: ''\nname: Jialu YANG\nclient_type: 0\ncountry_code: "+61"\nmobile: '406571889'\nbirth: 1994-09-28\nbsb: '033173'\naccount_name: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\naccount_number: '104917'\nend_date: \nid: 136\nencrypted_password: "$2a$12$BDY0oF07aUT3FN7wXYme/Oc7FASwZodIczYUUiO1czxIaZM1Evtxe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ee55e3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 15:31:02.796244
409	Client	138	update	\N	---\nemail: " 13906264851@163.com"\nupper_client_id: 72\nbeaver_id: ''\nname: Weihai MO\nclient_type: 0\ncountry_code: "+61"\nmobile: '481161576'\nbirth: 1973-03-28\nbsb: '083153'\naccount_name: M&H Management Pty Ltd ATF Mo & Huang Family Trust\naccount_number: '763182527'\nend_date: \nid: 138\nencrypted_password: "$2a$12$I4G0Ys/asziKuw3//fCNSudCiU6ul4hobvDMTqfpx8G1.kza1zFNq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ecc999\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-12 15:31:14.337928
410	Client	141	create	\N	\N	2022-09-13 11:41:05.744178
411	Client	136	update	\N	---\nemail: 1633040554@qq.com\nupper_client_id: 72\nbeaver_id: ''\nname: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '406571889'\nbirth: 1994-09-28\nbsb: '033173'\naccount_name: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\naccount_number: '104917'\nend_date: \nid: 136\nencrypted_password: "$2a$12$BDY0oF07aUT3FN7wXYme/Oc7FASwZodIczYUUiO1czxIaZM1Evtxe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ee55e3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 11:41:27.542839
412	Client	137	update	\N	---\nemail: sandygaohx@hotmail.com\nupper_client_id: 72\nbeaver_id: ''\nname: HUIXIA GAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '422403797'\nbirth: 1972-10-05\nbsb: '083266'\naccount_name: Huixia GAO\naccount_number: '773855617'\nend_date: \nid: 137\nencrypted_password: "$2a$12$IUaUcNVyf9nJTNkGWogLuuUKPCPtL6n6T5snZH867vaO6RdroCERq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: a85e80\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 11:42:05.563979
413	Client	138	update	\N	---\nemail: " 13906264851@163.com"\nupper_client_id: 72\nbeaver_id: ''\nname: M&H Management Pty Ltd ATF Mo & Huang Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '481161576'\nbirth: 1973-03-28\nbsb: '083153'\naccount_name: M&H Management Pty Ltd ATF Mo & Huang Family Trust\naccount_number: '763182527'\nend_date: \nid: 138\nencrypted_password: "$2a$12$I4G0Ys/asziKuw3//fCNSudCiU6ul4hobvDMTqfpx8G1.kza1zFNq"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ecc999\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 11:42:41.978324
414	Client	139	update	\N	---\nemail: " pgg100@163.com"\nupper_client_id: \nbeaver_id: ''\nname: Guige PIAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '426289960'\nbirth: 1972-11-27\nbsb: '063182'\naccount_name: Guige PIAO\naccount_number: '11426474'\nend_date: \nid: 139\nencrypted_password: "$2a$12$wCaSdezLprkMAlPFwU62p..CvwDWMrkdGfiT7M3KvEOoHOCBWtTSa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d6864e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 11:43:11.43111
415	Client	140	update	\N	---\nemail: happyliu5200@gmail.com\nupper_client_id: \nbeaver_id: ''\nname: Yan LIU\nclient_type: 0\ncountry_code: "+61"\nmobile: '410806669'\nbirth: 1976-02-02\nbsb: '733385'\naccount_name: Yan LIU\naccount_number: '866734'\nend_date: \nid: 140\nencrypted_password: "$2a$12$pJT8JSQ3Nknn9es65vXxxuVUIB8FsByXY9AHJe.6ZLf/ye0MU/SLG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 18881a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 11:43:27.68866
416	Client	142	create	\N	\N	2022-09-13 11:46:26.015892
417	Client	143	create	\N	\N	2022-09-13 11:47:53.024002
418	Client	144	create	\N	\N	2022-09-13 11:51:58.836579
419	Client	145	create	\N	\N	2022-09-13 12:03:25.157481
420	Client	145	update	\N	---\nemail: 13301014134@163.com\nupper_client_id: \nbeaver_id: ''\nname: Maggie Guo\nclient_type: \ncountry_code: "+61"\nmobile: '491458888'\nbirth: 1995-07-11\nbsb: '063121'\naccount_name: Yicong GUO\naccount_number: '10945374'\nend_date: \nid: 145\nencrypted_password: "$2a$12$V1mfkYK5SV3m1rWSsBebM.kUro6BKbjMb4X7kceSQTK4AHjKUvm0."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ac3ff3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 12:03:38.783534
421	Client	146	create	\N	\N	2022-09-13 12:05:04.278781
422	Client	147	create	\N	\N	2022-09-13 12:58:13.276777
423	Client	148	create	\N	\N	2022-09-13 13:07:43.197309
424	Client	143	update	\N	---\nemail: xizewrichard@gmail.com\nupper_client_id: 29\nbeaver_id: ''\nname: AF. Homey Pty Ltd ATF AF.Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '449728868'\nbirth: \nbsb: '033172'\naccount_name: AF. Homey Pty Ltd ATF AF.Family Trust\naccount_number: '882522'\nend_date: \nid: 143\nencrypted_password: "$2a$12$CElgLoGDlVUKzjCWU5bwa.FXhqe0TSP10AfVMv1zZsXs9mIKgHO3a"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '0798c7'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 13:20:01.255776
425	Client	147	update	\N	---\nemail: hyinvestment@hotmail.com\nupper_client_id: 60\nbeaver_id: ''\nname: Wenli WANG\nclient_type: 0\ncountry_code: "+61"\nmobile: '433946106'\nbirth: 1957-04-21\nbsb: '083004'\naccount_name: AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust\naccount_number: '364501615'\nend_date: \nid: 147\nencrypted_password: "$2a$12$HD3nkYmR3LcB7KWTkDuovu6AI/R1eWffNNVh3gVMk9NxfpvDX9G/i"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: a76f27\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 13:38:01.151974
426	Client	149	create	\N	\N	2022-09-13 13:50:36.372518
427	Client	149	update	\N	---\nemail: mr.xue1658@gmail.com\nupper_client_id: 29\nbeaver_id: ''\nname: Haowen Xue\nclient_type: 0\ncountry_code: "+61"\nmobile: '0416936678'\nbirth: \nbsb: '733065'\naccount_name: Haowen Xue\naccount_number: '722790'\nend_date: \nid: 149\nencrypted_password: "$2a$12$1JJxNxjrGtQvsTYNisANQ.zJ4yW1f80F5hQYd60iB3Ha0PSSWJfPG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b3b1e6\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 13:51:47.174371
428	Client	147	update	\N	---\nemail: hyinvestment@hotmail.com\nupper_client_id: 60\nbeaver_id: ''\nname: AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '433946106'\nbirth: 1957-04-21\nbsb: '083004'\naccount_name: AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust\naccount_number: '364501615'\nend_date: \nid: 147\nencrypted_password: "$2a$12$HD3nkYmR3LcB7KWTkDuovu6AI/R1eWffNNVh3gVMk9NxfpvDX9G/i"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: a76f27\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 13:53:14.477855
429	Client	150	create	\N	\N	2022-09-13 14:45:20.185037
430	Client	150	update	\N	---\nemail: kmbonnie06264@gmail.com\nupper_client_id: 29\nbeaver_id: ''\nname: YUNXIA ZHANG\nclient_type: 0\ncountry_code: "+61"\nmobile: '492800872'\nbirth: 1963-12-30\nbsb: '063113'\naccount_name: QFH PTY LTD ATF QFH TRUST\naccount_number: '11274533'\nend_date: \nid: 150\nencrypted_password: "$2a$12$PeBbqFYztEFUdDayoDn1Aujq94R1z8xiNHtF.UlKr2r7BbK3HNv3W"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 6fe0a2\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-13 14:45:28.077972
431	Client	151	create	\N	\N	2022-09-14 15:52:44.903131
432	Client	152	create	\N	\N	2022-09-15 10:15:23.221399
433	Client	32	update	\N	---\nencrypted_password: "$2a$12$lDIG1eKjlGByV5RRvo2Zm.KR7y.hfC4IRXv4I7roHMzpKS80Cgcd2"\nemail: wulei_1@hotmail.com\nid: 32\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 108\nbeaver_id: '146038'\nname: Lei WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0449896346'\nsalt: ef4ae8\nbirth: 2022-11-06\nbsb: 063-113\naccount_name: Sunrise Development (AU) Pty Ltd\naccount_number: '11270858'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-15 10:48:17.729525
434	Client	153	create	\N	\N	2022-09-16 08:39:20.269487
435	Client	154	create	\N	\N	2022-09-16 08:56:12.429079
436	Client	155	create	\N	\N	2022-09-16 09:31:42.229665
437	Client	136	update	\N	---\nemail: 1633040554@qq.com\nupper_client_id: 29\nbeaver_id: ''\nname: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '406571889'\nbirth: 1994-09-28\nbsb: '033173'\naccount_name: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\naccount_number: '104917'\nend_date: \nid: 136\nencrypted_password: "$2a$12$BDY0oF07aUT3FN7wXYme/Oc7FASwZodIczYUUiO1czxIaZM1Evtxe"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ee55e3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-16 14:18:17.911357
438	Client	156	create	\N	\N	2022-09-16 14:23:26.571991
439	Client	139	update	\N	---\nencrypted_password: "$2a$12$wCaSdezLprkMAlPFwU62p..CvwDWMrkdGfiT7M3KvEOoHOCBWtTSa"\nemail: " pgg100@163.com"\nid: 139\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: Guige PIAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '426289960'\nsalt: d6864e\nbirth: 1972-11-27\nbsb: '063182'\naccount_name: Guige PIAO\naccount_number: '11426474'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-19 08:42:11.769781
440	Client	139	update	\N	---\nemail: " pgg100@163.com"\nupper_client_id: 29\nbeaver_id: ''\nname: Guige PIAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '426289960'\nbirth: 1972-11-27\nbsb: '063182'\naccount_name: Guige PIAO\naccount_number: '11426474'\nend_date: \nid: 139\nencrypted_password: "$2a$12$CiPEXan/RryDfNY0MqP0t.VNopKbg01bC7bhrE6KNq/eXKy0Z/biC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d6864e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-19 08:54:35.774293
441	Client	141	update	\N	---\nencrypted_password: "$2a$12$cCua0vYbuK/zn/kLUMJbQ.VMtvpYfIlB0AxLyg6N56Y23P9RyRs3C"\nemail: meiyang8@hotmail.com\nid: 141\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: Mei YANG\nclient_type: 0\ncountry_code: "+61"\nmobile: '419320876'\nsalt: bd7613\nbirth: 1960-11-08\nbsb: '013255'\naccount_name: 'Mei YANG '\naccount_number: '210600629'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-19 08:56:00.563232
442	Client	141	update	\N	---\nencrypted_password: "$2a$12$bs5Dyu4mw1P2pLvhL9sGSunMxyoyugCODxHjhTyb4hcO9foKxv4Aa"\nemail: meiyang8@hotmail.com\nid: 141\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: Mei YANG\nclient_type: 0\ncountry_code: "+61"\nmobile: '419320876'\nsalt: bd7613\nbirth: 1960-11-08\nbsb: '013255'\naccount_name: 'Mei YANG '\naccount_number: '210600629'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-19 08:59:40.162913
443	Client	137	update	\N	---\nencrypted_password: "$2a$12$IUaUcNVyf9nJTNkGWogLuuUKPCPtL6n6T5snZH867vaO6RdroCERq"\nemail: sandygaohx@hotmail.com\nid: 137\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: HUIXIA GAO\nclient_type: 0\ncountry_code: "+61"\nmobile: '422403797'\nsalt: a85e80\nbirth: 1972-10-05\nbsb: '083266'\naccount_name: Huixia GAO\naccount_number: '773855617'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-20 07:09:20.006153
444	Client	156	update	\N	---\nemail: davidkaidiliu@gmail.com\nupper_client_id: 29\nbeaver_id: ''\nname: Kaidi LIU\nclient_type: 0\ncountry_code: "+61 448757567"\nmobile: '448757567'\nbirth: 2000-02-04\nbsb: '083323'\naccount_name: Kaidi LIU\naccount_number: '273270057'\nend_date: \nid: 156\nencrypted_password: "$2a$12$XeHv/LoeqPfv5kvWIVyTpOPUYdzOiPnhFoJwFIeTdtZxvHZ0WyHAS"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: f33596\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-20 10:09:20.6384
445	Client	157	create	\N	\N	2022-09-20 15:08:14.758757
446	Client	157	update	\N	---\nencrypted_password: "$2a$12$PbJc9dVWetbelVFR983ywurxmZm2/2goDxm8As7X3Rk5ebkO/TbYG"\nemail: lisirue@gmail.com\nid: 157\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nname: lisirue\nclient_type: \ncountry_code: '61'\nmobile: '0435743593'\nsalt: 5ef4cc\nbirth: \nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '19'\ninvest_entity: 0\ninvest_status: 0\n	2022-09-20 15:10:45.807008
447	Client	157	update	\N	---\nname: lisirue\nbirth: \nencrypted_password: "$2a$12$iUn3mDJ2X45coF/9/jjbA.3T7ffZlhThKbZqOQeMMfjsTZkwn5C42"\nemail: lisirue@gmail.com\nid: 157\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: \nclient_type: \ncountry_code: '61'\nmobile: '0435743593'\nsalt: 5ef4cc\nbsb: \naccount_name: \naccount_number: \nend_date: \ninterested_fund: '19'\ninvest_entity: 0\ninvest_status: 0\n	2022-09-20 15:11:47.029909
448	Client	158	create	\N	\N	2022-09-21 09:29:13.627035
449	Client	158	update	\N	---\nname: Shunhua ZHENG\nbirth: 1968-04-18\nencrypted_password: "$2a$12$vz8UFSjwbEOiQ8Hpip0d3egXytNoLwLBwDh3fxa3XW3IX17SVAJYK"\nemail: 826606048@qq.com\nid: 158\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nclient_type: 0\ncountry_code: "+61 "\nmobile: '431207123'\nsalt: 0dd4f5\nbsb: '343003'\naccount_name: Shunhua ZHENG\naccount_number: '338746439'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-09-21 10:56:41.175608
450	Client	159	create	\N	\N	2022-09-21 13:50:54.783951
451	Client	159	update	\N	---\nemail: tw0210@yahoo.com\nupper_client_id: 29\nbeaver_id: ''\nname: Rui PAN\nclient_type: 0\ncountry_code: "+61"\nmobile: '405288652'\nbirth: \nbsb: '033135'\naccount_name: Rui PAN ATF The Pan's Trust\naccount_number: '569166'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 159\nencrypted_password: "$2a$12$9ZJYioz00Fu60A.8J9H6hO0MUgQhr6EjzTaen/IYcvmsIoTrV61t6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 42688d\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-21 14:45:31.031256
452	Client	130	update	\N	---\nemail: sunrising@vip.16.com\nupper_client_id: 108\nbeaver_id: ''\nname: Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411326152'\nbirth: \nbsb: '083004'\naccount_name: Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust\naccount_number: '759658262'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 130\nencrypted_password: "$2a$12$LtejmzQbKfdVWCo4ZUjYq.OETRyS34elvxbiTh.OFA.DS4NupDsdi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c8eb6a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-21 14:47:07.697811
482	Client	162	update	\N	---\nemail: 1823547847@qq.com\nupper_client_id: \nbeaver_id: ''\nname: Heping ZHANG\nclient_type: 0\ncountry_code: "+86"\nmobile: '13301757388'\nbirth: 1970-09-11\nbsb: '082-309'\naccount_name: WZH Pty Ltd\naccount_number: '385517907'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 162\nencrypted_password: "$2a$12$bq5bsteI8U48s6.gctFVEu/vpC17Fu/k9vmyfI/2/fzLiFpyRkxAa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b9c974\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-11-09 13:08:40.13747
453	Client	124	update	\N	---\nemail: gaoxiang64@163.com\nupper_client_id: \nbeaver_id: ''\nname: Evergreen Forest Pty Ltd ATF Evergreen Super Fund\nclient_type: 0\ncountry_code: "+61 "\nmobile: '406779863'\nbirth: \nbsb: '182512'\naccount_name: Evergreen Forest Pty Ltd ATF Evergreen Super Fund\naccount_number: '966346744'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 124\nencrypted_password: "$2a$12$xsEh9ekhtZZjTccu7u.ct.EhKdYFEFSOhVhTQeMCbtyCSL5TyRDDa"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5ca706\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-21 14:49:07.515566
454	Client	125	update	\N	---\nemail: monika@lamafamilylawyer.com.au\nupper_client_id: \nbeaver_id: ''\nname: 'Parque Edition ATF Parque Edition Investment Trust '\nclient_type: \ncountry_code: "+61 "\nmobile: '404415760'\nbirth: \nbsb: '012140'\naccount_name: 'Parque Edition ATF Parque Edition Investment Trust '\naccount_number: '640898787'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 125\nencrypted_password: "$2a$12$.D0RJXTl.0YffkvxiudQh.3jHrK4tbqNhkzfZZjGh8lcVWc.M8Eve"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: bc6211\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-21 14:49:44.68458
455	Client	146	update	\N	---\nencrypted_password: "$2a$12$2flDWstXhBdfwwTSdI6XWu5OXqLlUEO0kfOAfRD8TInKiiqwF5hpO"\nemail: tinatsui605@gmail.com\nid: 146\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: Tsui Chiu Ying\nclient_type: 0\ncountry_code: "+61"\nmobile: '413779048'\nsalt: '152845'\nbirth: 1960-05-09\nbsb: '343003'\naccount_name: Tsui Chiu Ying\naccount_number: '347689439'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-09-21 18:10:20.375456
456	Client	160	create	\N	\N	2022-09-23 14:43:25.926921
457	Client	160	update	\N	---\nemail: emily.zhang@beavercapital.com.au\nupper_client_id: \nbeaver_id: ''\nname: ''\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 160\nencrypted_password: "$2a$12$N1Ql3UsSOYC0fgSIDbJOFOnMsMUqdwmQ3TzBoTHGf6VMG6hM0xErG"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 308b80\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-23 14:43:49.923925
458	Client	32	update	\N	---\nemail: wulei_1@hotmail.com\nupper_client_id: 108\nbeaver_id: '146038'\nname: Lei WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0449896346'\nbirth: 2022-11-06\nbsb: 063-113\naccount_name: Sunrise Development (AU) Pty Ltd\naccount_number: '11270858'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 32\nencrypted_password: "$2a$12$gy8r8LT0qRubwX/Lp6WS.udEh85DR9HIY1UcI7bQ61lMxfDG7X96a"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ef4ae8\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 12:38:37.060176
459	Client	109	update	\N	---\nemail: susanxu70@gmail.com\nupper_client_id: 108\nbeaver_id: '146082'\nname: Lei WU (SMSF)\nclient_type: 0\ncountry_code: "+61 "\nmobile: '435998867'\nbirth: 1968-11-06\nbsb: 063 010\naccount_name: wuxufamilysuperfund pty ltd ATF wuxufamilysuperannuation\naccount_number: '14628244'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 109\nencrypted_password: "$2a$12$KtpSEXiw1hEwfc3yGMoZQ.mkx/x6UHkktB2/ryr6Gzt/qcOW8tAZC"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 460adc\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 12:38:59.237964
460	Client	77	update	\N	---\nemail: xianli612@yahoo.com.au\nupper_client_id: 108\nbeaver_id: '146072'\nname: Xian LI\nclient_type: 0\ncountry_code: "+61 "\nmobile: '410702922'\nbirth: 1971-12-06\nbsb: '733173'\naccount_name: Xian Li\naccount_number: '682028'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 77\nencrypted_password: "$2a$12$25BuLaqGoUKLjDzb.ZOYjeBX1Jq/K2IWz3iQ7USOHxyMYfLbQFKge"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 3e8911\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 12:40:38.941709
461	Client	75	update	\N	---\nemail: luckyguo666@gmail.com\nupper_client_id: 29\nbeaver_id: '146070'\nname: Shuangqin GUO\nclient_type: 0\ncountry_code: "+61 "\nmobile: '491458888'\nbirth: 1972-04-30\nbsb: '063109'\naccount_name: Lucky Guo Family Trust\naccount_number: '13340337'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 75\nencrypted_password: "$2a$12$qmmOwLAt.yjWPEIPbnxMYuytiYzNcbh7nn3qROaPfRmqcirOa8T7."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: d0f40e\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 12:48:05.88537
462	Client	59	update	\N	---\nemail: denghuawu@yahoo.com\nupper_client_id: 108\nbeaver_id: '146055'\nname: Denghua WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '413599953'\nbirth: 1972-03-24\nbsb: 063-106\naccount_name: QI Property PL ATF Q1 Family Trust\naccount_number: '10794876'\nend_date: 2022-12-31\ntarget_amount: \nlink_to_valueup: false\nid: 59\nencrypted_password: "$2a$12$47KYIpCtKhbdP/LQ87IJIOIfzR8cF5Oo2lXL1rG48sqTpbgvNhXZy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5796f4\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 12:48:43.819169
463	Client	103	update	\N	---\nemail: zhoufangde@163.com\nupper_client_id: 108\nbeaver_id: '146081'\nname: Yong ZHANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '474324185'\nbirth: 1968-11-25\nbsb: '343002'\naccount_name: Yong ZHANG\naccount_number: '541274439'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 103\nencrypted_password: "$2a$12$BlKTqPauD3.rGgALz2CFw.nJeSvgj1mCT3uwdvIe/PoeD4zWgquVy"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c67257\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 13:01:38.266957
464	Client	96	update	\N	---\nemail: sunrising@vip.163.com\nupper_client_id: 108\nbeaver_id: '146075'\nname: Jianhong DU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411326152'\nbirth: 1974-12-08\nbsb: '083 231'\naccount_name: Jianhong DU\naccount_number: '395996550'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 96\nencrypted_password: "$2a$12$Vix0TU0bBNS3LgtnlSubUO6IVk.nEzPs1DqnUSNTjzioenWvkVN7m"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: be5e46\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 13:03:11.065465
465	Client	130	update	\N	---\nemail: sunrising@vip.16.com\nupper_client_id: 108\nbeaver_id: ''\nname: Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411326152'\nbirth: 1974-12-08\nbsb: '083004'\naccount_name: Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust\naccount_number: '759658262'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 130\nencrypted_password: "$2a$12$LtejmzQbKfdVWCo4ZUjYq.OETRyS34elvxbiTh.OFA.DS4NupDsdi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c8eb6a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 13:03:55.881672
466	Client	145	update	\N	---\nemail: 13301014134@163.com\nupper_client_id: \nbeaver_id: ''\nname: Yicong GUO\nclient_type: \ncountry_code: "+61"\nmobile: '491458888'\nbirth: 1995-07-11\nbsb: '063121'\naccount_name: Yicong GUO\naccount_number: '10945374'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 145\nencrypted_password: "$2a$12$V1mfkYK5SV3m1rWSsBebM.kUro6BKbjMb4X7kceSQTK4AHjKUvm0."\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: ac3ff3\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-27 13:06:00.987668
483	Client	163	create	\N	\N	2022-11-10 13:48:57.363625
484	Client	164	create	\N	\N	2022-11-24 13:50:12.51638
485	Client	165	create	\N	\N	2022-11-28 12:32:28.115815
467	Client	123	update	\N	---\nemail: steven.qiwang@gmail.com\nupper_client_id: 29\nbeaver_id: '146091'\nname: Qi WANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '416560766'\nbirth: 1977-08-03\nbsb: '083028'\naccount_name: Qianxi Investment Pty Ltd ATF Wang Family Trust\naccount_number: '442078614'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 123\nencrypted_password: "$2a$12$w7Q5W/6Cgk878z1nJrXzG.MjR2rnlKLBH.x0vTZ709JSAEnChR3tW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: fc85cd\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-28 08:55:07.637246
468	Client	130	update	\N	---\nemail: sunrising@vip.16.com\nupper_client_id: 75\nbeaver_id: ''\nname: Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust\nclient_type: 0\ncountry_code: "+61 "\nmobile: '411326152'\nbirth: 1974-12-08\nbsb: '083004'\naccount_name: Sunfafa Investment Pty Ltd ATF Sunfafa Family Trust\naccount_number: '759658262'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 130\nencrypted_password: "$2a$12$LtejmzQbKfdVWCo4ZUjYq.OETRyS34elvxbiTh.OFA.DS4NupDsdi"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: c8eb6a\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-09-30 14:39:20.60109
469	Client	100	update	\N	---\nencrypted_password: "$2a$12$YnYIBidsUIkUwAgiL8pIBugTzPr/oPbhGaunCF6jDLSvko7WVS6QK"\nemail: dadudie88@gmail.com\nid: 100\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146078'\nname: Liu SMSF Pty Ltd ATF Liu SMSF\nclient_type: 0\ncountry_code: "+61 "\nmobile: '430086816'\nsalt: 3a162f\nbirth: 1970-01-08\nbsb: 193 879\naccount_name: Liu SMSF Pty Ltd ATF Liu SMSF\naccount_number: '440350080'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-02 12:59:48.775424
470	Client	29	update	\N	---\nencrypted_password: "$2a$12$296ZT2RiQ.SiUGr5yCZV1.XpVMzgbb4yRkdg228tb4tzmI8GSMzzG"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-02 13:04:24.615585
471	Client	154	update	\N	---\nencrypted_password: "$2a$12$F9nDsRGAUxGdZ1uAn06oWO/ZpegSfb0tsA9OXD6j13tKLUELOrhxe"\nemail: shinewanghaojie@gmail.com\nid: 154\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 32\nbeaver_id: ''\nname: Haojie Wang\nclient_type: 0\ncountry_code: "+61"\nmobile: '451786668'\nsalt: 5eb01c\nbirth: 1969-07-28\nbsb: '303438'\naccount_name: HAOJIE WANG\naccount_number: '0216604'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-05 13:30:59.717926
472	Client	147	update	\N	---\nencrypted_password: "$2a$12$HD3nkYmR3LcB7KWTkDuovu6AI/R1eWffNNVh3gVMk9NxfpvDX9G/i"\nemail: hyinvestment@hotmail.com\nid: 147\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 72\nbeaver_id: ''\nname: AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '433946106'\nsalt: a76f27\nbirth: 1957-04-21\nbsb: '083004'\naccount_name: AO Hai Investment Pty Ltd ATF Hao Yang Investment Family Trust\naccount_number: '364501615'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-06 11:14:26.791419
473	Client	146	update	\N	---\nname: Tsui Chiu Ying\nbirth: 1960-05-09\nencrypted_password: "$2a$12$QQcS5bxJTVUDG/yZhNbZVOuOobzMRPinW6CKrDzdIYb6Aa2l.f21m"\nemail: tinatsui605@gmail.com\nid: 146\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nclient_type: 0\ncountry_code: "+61"\nmobile: '413779048'\nsalt: '152845'\nbsb: '343003'\naccount_name: Tsui Chiu Ying\naccount_number: '347689439'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-07 08:33:10.234524
474	Client	146	update	\N	---\nname: Tsui Chiu Ying\nbirth: 1960-05-09\nencrypted_password: "$2a$12$EDMjH7w9v6zyuQVArhVpWOLOrs.hc2kK7.D/AvkxipuAMWQmlKyPG"\nemail: tinatsui605@gmail.com\nid: 146\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nclient_type: 0\ncountry_code: "+61"\nmobile: '413779048'\nsalt: '152845'\nbsb: '343003'\naccount_name: Tsui Chiu Ying\naccount_number: '347689439'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-07 08:33:12.177736
475	Client	61	update	\N	---\nencrypted_password: "$2a$12$irvl936TDFbjlNGXWrHkteuGq7Bl/B2jO7lfDfcP.K1MefG/pdfGS"\nemail: mikehuang166@gmail.com\nid: 61\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146057'\nname: Zhengrong HUANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '431999636'\nsalt: 3ab932\nbirth: 1977-01-16\nbsb: 033-084\naccount_name: 'Xinyue Investment Group '\naccount_number: '526085'\nend_date: 2022-12-31\ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-13 14:41:58.787119
476	Client	61	update	\N	---\nname: Zhengrong HUANG\nbirth: 1977-01-16\nencrypted_password: "$2a$12$PhxUyMX/0iV2g7kHiaRvqu5XpiCCag/SI0mAu6uInp46vVViJQPE6"\nemail: mikehuang166@gmail.com\nid: 61\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146057'\nclient_type: 0\ncountry_code: "+61 "\nmobile: '431999636'\nsalt: 3ab932\nbsb: 033-084\naccount_name: 'Xinyue Investment Group '\naccount_number: '526085'\nend_date: 2022-12-31\ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-13 14:44:23.985129
477	Client	161	create	\N	\N	2022-10-18 07:15:05.15715
478	Client	32	update	\N	---\nencrypted_password: "$2a$12$gy8r8LT0qRubwX/Lp6WS.udEh85DR9HIY1UcI7bQ61lMxfDG7X96a"\nemail: wulei_1@hotmail.com\nid: 32\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 32\nbeaver_id: '146038'\nname: Lei WU\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0449896346'\nsalt: ef4ae8\nbirth: 2022-11-06\nbsb: 063-113\naccount_name: Sunrise Development (AU) Pty Ltd\naccount_number: '11270858'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-19 16:22:12.696747
479	Client	136	update	\N	---\nencrypted_password: "$2a$12$BDY0oF07aUT3FN7wXYme/Oc7FASwZodIczYUUiO1czxIaZM1Evtxe"\nemail: 1633040554@qq.com\nid: 136\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 30\nbeaver_id: ''\nname: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\nclient_type: 0\ncountry_code: "+61"\nmobile: '406571889'\nsalt: ee55e3\nbirth: 1994-09-28\nbsb: '033173'\naccount_name: BMJY Australia Pty Ltd ATF Wang and Yang 2022 Family Trust\naccount_number: '104917'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-10-28 03:45:11.032069
480	Client	161	destroy	\N	---\nid: 161\nemail: frank.mai@beavercapital.com.au\nencrypted_password: "$2a$12$zc5YwfcBXEnunN7KNiTAn.5GneK2n2b9qcDJ7pMlnsV2wju5YAvny"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: Test 000001\nclient_type: \ncountry_code: ''\nmobile: ''\nsalt: 5e03d6\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-11-09 13:03:24.065567
481	Client	162	create	\N	\N	2022-11-09 13:08:10.683776
486	Client	146	update	\N	---\nencrypted_password: "$2a$12$FAaIOjVn49k221Jd.ZhnxO9C3U3sqdIlPmRu5t4R56gP5ay/BjSOa"\nemail: tinatsui605@gmail.com\nid: 146\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: Tsui Chiu Ying\nclient_type: 0\ncountry_code: "+61"\nmobile: '413779048'\nsalt: '152845'\nbirth: 1960-05-09\nbsb: '343003'\naccount_name: Tsui Chiu Ying\naccount_number: '347689439'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-12-01 18:54:17.451127
487	Client	166	create	\N	\N	2022-12-06 08:17:57.674683
488	Client	167	create	\N	\N	2022-12-06 08:28:06.077598
489	Client	168	create	\N	\N	2022-12-06 08:39:11.429674
490	Client	29	update	\N	---\nencrypted_password: "$2a$12$nG4PWpwJ3oH8JJk.pmm./efihaxjRSUIdbc4KFBKoM0pqJzu14sjK"\nemail: changfamily608@gmail.com\nid: 29\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146036'\nname: Chang Liu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0430086816'\nsalt: c9624b\nbirth: 2022-01-08\nbsb: 733-040\naccount_name: CHANG LIU ATF CHANGE FAMILY TRUST\naccount_number: '694500'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-12-06 11:23:02.684809
491	Client	28	update	\N	---\nencrypted_password: "$2a$12$r1.4fMIRw9zvZxf9Q2g0zOctUVvVIdVNP4sl55O7D0U/qr77UZutq"\nemail: boxing.han@hotmail.com\nid: 28\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146034'\nname: Allen Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nsalt: b2c8cd\nbirth: 1967-03-20\nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-12-09 08:22:16.235321
492	Client	28	update	\N	---\nencrypted_password: "$2a$12$IbhHlfnVRLbMBgP1PUU9Y.Cpq9vDrc8tIlGT4gTpIAA0G3VTjaPGu"\nemail: boxing.han@hotmail.com\nid: 28\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146034'\nname: Allen Han\nclient_type: 0\ncountry_code: "+61 "\nmobile: '0450029266'\nsalt: b2c8cd\nbirth: 1967-03-20\nbsb: 063-185\naccount_name: Han Family Trust\naccount_number: '11214633'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-12-09 08:24:51.66466
493	Client	169	create	\N	\N	2022-12-13 14:00:34.374456
494	Client	146	update	\N	---\nencrypted_password: "$2a$12$uILSAJ7H0/qI49.G9LuSGOUSN8Wrpe6SejPbVz1yoLdi0LvKGTD9a"\nemail: tinatsui605@gmail.com\nid: 146\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: ''\nname: Tsui Chiu Ying\nclient_type: 0\ncountry_code: "+61"\nmobile: '413779048'\nsalt: '152845'\nbirth: 1960-05-09\nbsb: '343003'\naccount_name: Tsui Chiu Ying\naccount_number: '347689439'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2022-12-16 12:32:30.354044
495	Client	170	create	\N	\N	2022-12-24 07:15:29.099471
496	Client	168	update	\N	---\nemail: congcong1120@outlook.com\nupper_client_id: 29\nbeaver_id: '146110'\nname: Yingda Xu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0412846738'\nbirth: 2020-11-20\nbsb: '062948'\naccount_name: Retrieving data. Wait a few seconds and try to cut or copy again.\naccount_number: '32397799'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 168\nencrypted_password: "$2a$12$uVL77YdMR594L9MSImsnxO4NI0idGnog7CT0Hfaoci8yOmmyVS/HW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5d3e34\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-12-30 07:32:22.354153
497	Client	168	update	\N	---\nemail: congcong1120@outlook.com\nupper_client_id: 29\nbeaver_id: '146110'\nname: Yingda Xu\nclient_type: 1\ncountry_code: "+61 "\nmobile: '0412846738'\nbirth: \nbsb: '062948'\naccount_name: Retrieving data. Wait a few seconds and try to cut or copy again.\naccount_number: '32397799'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 168\nencrypted_password: "$2a$12$uVL77YdMR594L9MSImsnxO4NI0idGnog7CT0Hfaoci8yOmmyVS/HW"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 5d3e34\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2022-12-30 07:33:28.596773
498	Client	171	create	\N	\N	2022-12-30 07:35:00.440503
499	Client	172	create	\N	\N	2022-12-30 07:55:28.826401
500	Client	173	create	\N	\N	2022-12-30 08:10:36.290781
501	Client	174	create	\N	\N	2022-12-30 08:16:11.095831
502	Client	129	update	\N	---\nencrypted_password: "$2a$12$bBwiXrK7lIdNvFL3cPM1VOwxSFf2We6Y.QgQTjAIxLLZUqezuawWW"\nemail: yms2022424@gmail.com\nid: 129\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 29\nbeaver_id: '146095'\nname: Mingshan YANG\nclient_type: 0\ncountry_code: "+61 "\nmobile: '449519959 '\nsalt: cfdca3\nbirth: 1984-06-26\nbsb: '735102 '\naccount_name: Mingshan YANG\naccount_number: '771612'\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2023-01-05 08:06:09.078156
503	Client	175	create	\N	\N	2023-01-09 07:49:46.694089
504	Client	165	update	\N	---\nemail: mia.li@beavercapital.com.au\nupper_client_id: \nbeaver_id: ''\nname: Mia testing account\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 165\nencrypted_password: "$2a$12$Ziu7PZu2KuYif6XGGA8BQued0tzxo5B6zzyVvKYWP50CR093z.st6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 9a0cea\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-01-11 11:54:54.934006
505	Client	175	update	\N	---\nencrypted_password: "$2a$12$qqyiZN3vxDLsomHiEeVWH..9Ngibq.jyQLrfZusyCs841KZsF2DaW"\nemail: frank.mai@beavercapital.com.au\nid: 175\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: \nbeaver_id: ''\nname: Frank's test account\nclient_type: 0\ncountry_code: "+61"\nmobile: '484940608'\nsalt: '696103'\nbirth: 1960-01-01\nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2023-01-12 14:15:25.813762
506	Client	176	create	\N	\N	2023-01-13 14:39:03.353149
507	Client	152	update	\N	---\nemail: test002@gmail.com\nupper_client_id: \nbeaver_id: ''\nname: Test Account\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 152\nencrypted_password: "$2a$12$BB/wrEbsWXka/dj6gBXJ6.8KShrlhE5dNcdvkLcrIQXM3Xyo0dN42"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 9614c6\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-01-30 08:24:05.695987
508	Client	175	update	\N	---\nemail: frank.mai@beavercapital.com.au\nupper_client_id: \nbeaver_id: ''\nname: Frank's test account\nclient_type: 0\ncountry_code: "+61"\nmobile: '484940608'\nbirth: 1960-01-01\nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 175\nencrypted_password: "$2a$12$Yb8bR1ptJCQ.pIwKD3SvBezCvpXbcPeuUL3M7jUOcMzdddPs3i4be"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '696103'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-07 12:56:36.8814
509	Client	165	update	\N	---\nemail: mia.li@beavercapital.com.au\nupper_client_id: \nbeaver_id: ''\nname: Mia testing account\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: 1996-01-11\nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 165\nencrypted_password: "$2a$12$Ziu7PZu2KuYif6XGGA8BQued0tzxo5B6zzyVvKYWP50CR093z.st6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 9a0cea\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-07 12:56:54.473911
510	Client	177	create	\N	\N	2023-02-20 07:30:13.062175
511	Client	165	update	\N	---\nemail: mia.li@beavercapital.com.au\nupper_client_id: 152\nbeaver_id: ''\nname: Mia testing account\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: 1996-01-11\nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 165\nencrypted_password: "$2a$12$Ziu7PZu2KuYif6XGGA8BQued0tzxo5B6zzyVvKYWP50CR093z.st6"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 9a0cea\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-20 07:32:53.645121
512	Client	177	update	\N	---\nemail: rober.chen@bhgglobal.com.au\nupper_client_id: \nbeaver_id: ''\nname: Rober CHEN\nclient_type: 1\ncountry_code: ''\nmobile: ''\nbirth: \nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 177\nencrypted_password: "$2a$12$8witCe6PS8fBIPFQAB4TReKXIP/wK9NY4RcasKhoS/nvE3kAlq5jK"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: b58903\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-20 07:38:37.135745
513	Client	175	update	\N	---\nemail: frank.mai@beavercapital.com.au\nupper_client_id: 152\nbeaver_id: ''\nname: Frank's test account\nclient_type: 0\ncountry_code: "+61"\nmobile: '484940608'\nbirth: 1960-01-01\nbsb: ''\naccount_name: ''\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 175\nencrypted_password: "$2a$12$Yb8bR1ptJCQ.pIwKD3SvBezCvpXbcPeuUL3M7jUOcMzdddPs3i4be"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: '696103'\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-21 07:12:21.604899
514	Client	152	update	\N	---\nemail: test002@gmail.com\nupper_client_id: \nbeaver_id: '1111111'\nname: Test Account\nclient_type: \ncountry_code: ''\nmobile: ''\nbirth: \nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 152\nencrypted_password: "$2a$12$BB/wrEbsWXka/dj6gBXJ6.8KShrlhE5dNcdvkLcrIQXM3Xyo0dN42"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 9614c6\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-21 07:13:00.13864
515	Client	178	create	\N	\N	2023-02-21 12:47:19.348705
516	Client	178	update	\N	---\nemail: testing1@bhgglobal.com.au\nupper_client_id: \nbeaver_id: ''\nname: Test\nclient_type: 0\ncountry_code: '61'\nmobile: '123321123'\nbirth: 2023-02-01\nbsb: '123456'\naccount_name: robert.chen@bhgglobal.com.au\naccount_number: '12345678'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 178\nencrypted_password: "$2a$12$yVpXO6JhtNrNQcesU7D.rO65DA4AWDjS7HrF58ycxDtAX5nRKb9.q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 1d8b06\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-21 12:48:06.573561
517	Client	178	update	\N	---\nemail: testing1@bhgglobal.com.au\nupper_client_id: 165\nbeaver_id: ''\nname: Test\nclient_type: 0\ncountry_code: '61'\nmobile: '123321123'\nbirth: 2023-02-01\nbsb: '123456'\naccount_name: robert.chen@bhgglobal.com.au\naccount_number: '12345678'\nend_date: \ntarget_amount: \nlink_to_valueup: false\nid: 178\nencrypted_password: "$2a$12$yVpXO6JhtNrNQcesU7D.rO65DA4AWDjS7HrF58ycxDtAX5nRKb9.q"\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nsalt: 1d8b06\ninterested_fund: \ninvest_entity: \ninvest_status: \n	2023-02-22 12:44:11.878085
518	Client	152	update	\N	---\nname: Test Account\nbirth: \nencrypted_password: "$2a$12$BB/wrEbsWXka/dj6gBXJ6.8KShrlhE5dNcdvkLcrIQXM3Xyo0dN42"\nemail: test002@gmail.com\nid: 152\nreset_password_token: \nreset_password_sent_at: \nsign_in_count: 0\nupper_client_id: 165\nbeaver_id: '1111111'\nclient_type: \ncountry_code: ''\nmobile: ''\nsalt: 9614c6\nbsb: ''\naccount_name: operations@beavercapital.com.au\naccount_number: ''\nend_date: \ninterested_fund: \ninvest_entity: \ninvest_status: \nlink_to_valueup: false\ntarget_amount: \n	2023-02-24 13:18:44.206188
\.


--
-- Data for Name: visitor_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.visitor_log (id, email, login_time, status) FROM stdin;
\.


--
-- Name: action_text_rich_texts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.action_text_rich_texts_id_seq', 1, false);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_admin_comments_id_seq', 1, false);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 1, false);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 1, false);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 34, true);


--
-- Name: annual_approve_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annual_approve_id_seq', 8, true);


--
-- Name: audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_id_seq', 40, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 27, true);


--
-- Name: auth_permission_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_role_id_seq', 80, true);


--
-- Name: auth_permission_role_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_role_permission_id_seq', 1, false);


--
-- Name: auth_permission_role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_role_role_id_seq', 1, false);


--
-- Name: auth_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_role_id_seq', 4, true);


--
-- Name: borrow_proposed_security_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.borrow_proposed_security_id_seq', 13, true);


--
-- Name: ckeditor_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ckeditor_assets_id_seq', 1, false);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 329, true);


--
-- Name: dictionary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dictionary_id_seq', 62, true);


--
-- Name: dividend_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dividend_histories_id_seq', 1, true);


--
-- Name: enquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enquiries_id_seq', 143, true);


--
-- Name: event_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_client_id_seq', 1, false);


--
-- Name: event_registrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_registrations_id_seq', 11, true);


--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 138, true);


--
-- Name: finance_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_reference_id_seq', 111, true);


--
-- Name: financings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.financings_id_seq', 30, true);


--
-- Name: fund_tag_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fund_tag_tag_id_seq', 1, false);


--
-- Name: funds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.funds_id_seq', 159, true);


--
-- Name: investment_entities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.investment_entities_id_seq', 357, true);


--
-- Name: investment_entities_kyc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.investment_entities_kyc_id_seq', 175, true);


--
-- Name: loan_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loan_items_id_seq', 1, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_id_seq', 75, true);


--
-- Name: news_imgs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_imgs_id_seq', 17, true);


--
-- Name: notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_seq', 19, true);


--
-- Name: notify_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notify_client_id_seq', 31, true);


--
-- Name: operate_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.operate_log_id_seq', 1239, true);


--
-- Name: purchased_funds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.purchased_funds_id_seq', 1704, true);


--
-- Name: referral_referral_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referral_referral_id_seq', 11, true);


--
-- Name: referral_structure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.referral_structure_id_seq', 6, true);


--
-- Name: tags_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tags_tag_id_seq', 6, true);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.versions_id_seq', 518, true);


--
-- Name: visitor_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.visitor_log_id_seq', 13, true);


--
-- Name: annual_approve annual_approve_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_approve
    ADD CONSTRAINT annual_approve_pkey PRIMARY KEY (id);


--
-- Name: audit audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit
    ADD CONSTRAINT audit_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pk PRIMARY KEY (id);


--
-- Name: auth_permission_role auth_permission_role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission_role
    ADD CONSTRAINT auth_permission_role_pk PRIMARY KEY (id);


--
-- Name: auth_role auth_role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_role
    ADD CONSTRAINT auth_role_pk PRIMARY KEY (id);


--
-- Name: borrow_proposed_security borrow_proposed_security_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.borrow_proposed_security
    ADD CONSTRAINT borrow_proposed_security_pkey PRIMARY KEY (id);


--
-- Name: dictionary dictionary_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dictionary
    ADD CONSTRAINT dictionary_pk PRIMARY KEY (id);


--
-- Name: event_client event_client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_client
    ADD CONSTRAINT event_client_pkey PRIMARY KEY (id);


--
-- Name: finance_reference finance_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_reference
    ADD CONSTRAINT finance_reference_pkey PRIMARY KEY (id);


--
-- Name: fund_tag fund_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_tag
    ADD CONSTRAINT fund_tag_pkey PRIMARY KEY (tag_id, fund_id);


--
-- Name: investment_entities_kyc investment_entities_kyc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investment_entities_kyc
    ADD CONSTRAINT investment_entities_kyc_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: notify_client notify_client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notify_client
    ADD CONSTRAINT notify_client_pkey PRIMARY KEY (id);


--
-- Name: operate_log operate_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operate_log
    ADD CONSTRAINT operate_log_pkey PRIMARY KEY (id);


--
-- Name: referral referral_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral
    ADD CONSTRAINT referral_pkey PRIMARY KEY (referral_id);


--
-- Name: referral_structure referral_structure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referral_structure
    ADD CONSTRAINT referral_structure_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: visitor_log visitor_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.visitor_log
    ADD CONSTRAINT visitor_log_pkey PRIMARY KEY (id);


--
-- Name: dictionary_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dictionary_type_idx ON public.dictionary USING btree (type, sort);


--
-- Name: fund_tag fund_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_tag
    ADD CONSTRAINT fund_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id);


--
-- PostgreSQL database dump complete
--

