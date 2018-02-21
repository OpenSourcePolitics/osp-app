--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 10.1

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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO moustachu;

--
-- Name: decidim_accountability_results; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_accountability_results (
    id integer NOT NULL,
    title jsonb,
    description jsonb,
    reference character varying,
    start_date date,
    end_date date,
    progress numeric(5,2),
    parent_id integer,
    decidim_accountability_status_id integer,
    decidim_feature_id integer,
    decidim_scope_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    children_count integer DEFAULT 0
);


ALTER TABLE decidim_accountability_results OWNER TO moustachu;

--
-- Name: decidim_accountability_results_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_accountability_results_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_accountability_results_id_seq OWNER TO moustachu;

--
-- Name: decidim_accountability_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_accountability_results_id_seq OWNED BY decidim_accountability_results.id;


--
-- Name: decidim_accountability_statuses; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_accountability_statuses (
    id integer NOT NULL,
    key character varying,
    name jsonb,
    decidim_feature_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description jsonb,
    progress integer
);


ALTER TABLE decidim_accountability_statuses OWNER TO moustachu;

--
-- Name: decidim_accountability_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_accountability_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_accountability_statuses_id_seq OWNER TO moustachu;

--
-- Name: decidim_accountability_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_accountability_statuses_id_seq OWNED BY decidim_accountability_statuses.id;


--
-- Name: decidim_accountability_timeline_entries; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_accountability_timeline_entries (
    id integer NOT NULL,
    entry_date date,
    description jsonb,
    decidim_accountability_result_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_accountability_timeline_entries OWNER TO moustachu;

--
-- Name: decidim_accountability_timeline_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_accountability_timeline_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_accountability_timeline_entries_id_seq OWNER TO moustachu;

--
-- Name: decidim_accountability_timeline_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_accountability_timeline_entries_id_seq OWNED BY decidim_accountability_timeline_entries.id;


--
-- Name: decidim_assemblies; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_assemblies (
    id integer NOT NULL,
    slug character varying NOT NULL,
    hashtag character varying,
    decidim_organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title jsonb NOT NULL,
    subtitle jsonb NOT NULL,
    short_description jsonb NOT NULL,
    description jsonb NOT NULL,
    hero_image character varying,
    banner_image character varying,
    promoted boolean DEFAULT false,
    published_at timestamp without time zone,
    developer_group jsonb,
    meta_scope jsonb,
    local_area jsonb,
    target jsonb,
    participatory_scope jsonb,
    participatory_structure jsonb,
    show_statistics boolean DEFAULT false,
    decidim_scope_id integer,
    scopes_enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE decidim_assemblies OWNER TO moustachu;

--
-- Name: decidim_assemblies_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_assemblies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_assemblies_id_seq OWNER TO moustachu;

--
-- Name: decidim_assemblies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_assemblies_id_seq OWNED BY decidim_assemblies.id;


--
-- Name: decidim_attachments; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_attachments (
    id integer NOT NULL,
    title jsonb NOT NULL,
    description jsonb,
    file character varying NOT NULL,
    content_type character varying NOT NULL,
    file_size character varying NOT NULL,
    attached_to_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    attached_to_type character varying NOT NULL
);


ALTER TABLE decidim_attachments OWNER TO moustachu;

--
-- Name: decidim_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_attachments_id_seq OWNER TO moustachu;

--
-- Name: decidim_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_attachments_id_seq OWNED BY decidim_attachments.id;


--
-- Name: decidim_authorizations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_authorizations (
    id integer NOT NULL,
    name character varying NOT NULL,
    metadata jsonb,
    decidim_user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    unique_id character varying,
    granted_at timestamp without time zone,
    verification_metadata jsonb DEFAULT '{}'::jsonb,
    verification_attachment character varying
);


ALTER TABLE decidim_authorizations OWNER TO moustachu;

--
-- Name: decidim_authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_authorizations_id_seq OWNER TO moustachu;

--
-- Name: decidim_authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_authorizations_id_seq OWNED BY decidim_authorizations.id;


--
-- Name: decidim_budgets_line_items; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_budgets_line_items (
    id integer NOT NULL,
    decidim_order_id integer,
    decidim_project_id integer
);


ALTER TABLE decidim_budgets_line_items OWNER TO moustachu;

--
-- Name: decidim_budgets_line_items_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_budgets_line_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_budgets_line_items_id_seq OWNER TO moustachu;

--
-- Name: decidim_budgets_line_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_budgets_line_items_id_seq OWNED BY decidim_budgets_line_items.id;


--
-- Name: decidim_budgets_orders; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_budgets_orders (
    id integer NOT NULL,
    decidim_user_id integer,
    decidim_feature_id integer,
    checked_out_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_budgets_orders OWNER TO moustachu;

--
-- Name: decidim_budgets_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_budgets_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_budgets_orders_id_seq OWNER TO moustachu;

--
-- Name: decidim_budgets_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_budgets_orders_id_seq OWNED BY decidim_budgets_orders.id;


--
-- Name: decidim_budgets_projects; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_budgets_projects (
    id integer NOT NULL,
    title jsonb,
    description jsonb,
    budget integer NOT NULL,
    decidim_feature_id integer,
    decidim_scope_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reference character varying
);


ALTER TABLE decidim_budgets_projects OWNER TO moustachu;

--
-- Name: decidim_budgets_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_budgets_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_budgets_projects_id_seq OWNER TO moustachu;

--
-- Name: decidim_budgets_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_budgets_projects_id_seq OWNED BY decidim_budgets_projects.id;


--
-- Name: decidim_categories; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_categories (
    id integer NOT NULL,
    name jsonb NOT NULL,
    description jsonb NOT NULL,
    parent_id integer,
    decidim_participatory_space_id integer,
    decidim_participatory_space_type character varying
);


ALTER TABLE decidim_categories OWNER TO moustachu;

--
-- Name: decidim_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_categories_id_seq OWNER TO moustachu;

--
-- Name: decidim_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_categories_id_seq OWNED BY decidim_categories.id;


--
-- Name: decidim_categorizations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_categorizations (
    id bigint NOT NULL,
    decidim_category_id bigint NOT NULL,
    categorizable_type character varying NOT NULL,
    categorizable_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_categorizations OWNER TO moustachu;

--
-- Name: decidim_categorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_categorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_categorizations_id_seq OWNER TO moustachu;

--
-- Name: decidim_categorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_categorizations_id_seq OWNED BY decidim_categorizations.id;


--
-- Name: decidim_comments_comment_votes; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_comments_comment_votes (
    id integer NOT NULL,
    weight integer NOT NULL,
    decidim_comment_id integer NOT NULL,
    decidim_author_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_comments_comment_votes OWNER TO moustachu;

--
-- Name: decidim_comments_comment_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_comments_comment_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_comments_comment_votes_id_seq OWNER TO moustachu;

--
-- Name: decidim_comments_comment_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_comments_comment_votes_id_seq OWNED BY decidim_comments_comment_votes.id;


--
-- Name: decidim_comments_comments; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_comments_comments (
    id integer NOT NULL,
    body text NOT NULL,
    decidim_commentable_type character varying NOT NULL,
    decidim_commentable_id integer NOT NULL,
    decidim_author_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    depth integer DEFAULT 0 NOT NULL,
    alignment integer DEFAULT 0 NOT NULL,
    decidim_user_group_id integer,
    decidim_root_commentable_type character varying NOT NULL,
    decidim_root_commentable_id integer NOT NULL
);


ALTER TABLE decidim_comments_comments OWNER TO moustachu;

--
-- Name: decidim_comments_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_comments_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_comments_comments_id_seq OWNER TO moustachu;

--
-- Name: decidim_comments_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_comments_comments_id_seq OWNED BY decidim_comments_comments.id;


--
-- Name: decidim_features; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_features (
    id integer NOT NULL,
    manifest_name character varying,
    name jsonb,
    participatory_space_id integer NOT NULL,
    settings jsonb DEFAULT '{}'::jsonb,
    weight integer DEFAULT 0,
    permissions jsonb,
    published_at timestamp without time zone,
    participatory_space_type character varying NOT NULL
);


ALTER TABLE decidim_features OWNER TO moustachu;

--
-- Name: decidim_features_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_features_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_features_id_seq OWNER TO moustachu;

--
-- Name: decidim_features_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_features_id_seq OWNED BY decidim_features.id;


--
-- Name: decidim_follows; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_follows (
    id bigint NOT NULL,
    decidim_user_id bigint NOT NULL,
    decidim_followable_type character varying,
    decidim_followable_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_follows OWNER TO moustachu;

--
-- Name: decidim_follows_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_follows_id_seq OWNER TO moustachu;

--
-- Name: decidim_follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_follows_id_seq OWNED BY decidim_follows.id;


--
-- Name: decidim_identities; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_identities (
    id integer NOT NULL,
    provider character varying NOT NULL,
    uid character varying NOT NULL,
    decidim_user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    decidim_organization_id integer
);


ALTER TABLE decidim_identities OWNER TO moustachu;

--
-- Name: decidim_identities_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_identities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_identities_id_seq OWNER TO moustachu;

--
-- Name: decidim_identities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_identities_id_seq OWNED BY decidim_identities.id;


--
-- Name: decidim_impersonation_logs; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_impersonation_logs (
    id bigint NOT NULL,
    decidim_admin_id bigint,
    decidim_user_id bigint,
    started_at timestamp without time zone,
    ended_at timestamp without time zone,
    expired_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_impersonation_logs OWNER TO moustachu;

--
-- Name: decidim_impersonation_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_impersonation_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_impersonation_logs_id_seq OWNER TO moustachu;

--
-- Name: decidim_impersonation_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_impersonation_logs_id_seq OWNED BY decidim_impersonation_logs.id;


--
-- Name: decidim_meetings_meetings; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_meetings_meetings (
    id integer NOT NULL,
    title jsonb,
    description jsonb,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    address text,
    location jsonb,
    location_hints jsonb,
    decidim_feature_id integer,
    decidim_author_id integer,
    decidim_scope_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    closing_report jsonb,
    attendees_count integer,
    contributions_count integer,
    attending_organizations text,
    closed_at time without time zone,
    latitude double precision,
    longitude double precision,
    reference character varying,
    registrations_enabled boolean DEFAULT false NOT NULL,
    available_slots integer DEFAULT 0 NOT NULL,
    registration_terms jsonb
);


ALTER TABLE decidim_meetings_meetings OWNER TO moustachu;

--
-- Name: decidim_meetings_meetings_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_meetings_meetings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_meetings_meetings_id_seq OWNER TO moustachu;

--
-- Name: decidim_meetings_meetings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_meetings_meetings_id_seq OWNED BY decidim_meetings_meetings.id;


--
-- Name: decidim_meetings_registrations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_meetings_registrations (
    id bigint NOT NULL,
    decidim_user_id bigint NOT NULL,
    decidim_meeting_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_meetings_registrations OWNER TO moustachu;

--
-- Name: decidim_meetings_registrations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_meetings_registrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_meetings_registrations_id_seq OWNER TO moustachu;

--
-- Name: decidim_meetings_registrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_meetings_registrations_id_seq OWNED BY decidim_meetings_registrations.id;


--
-- Name: decidim_messaging_conversations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_messaging_conversations (
    id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_messaging_conversations OWNER TO moustachu;

--
-- Name: decidim_messaging_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_messaging_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_messaging_conversations_id_seq OWNER TO moustachu;

--
-- Name: decidim_messaging_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_messaging_conversations_id_seq OWNED BY decidim_messaging_conversations.id;


--
-- Name: decidim_messaging_messages; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_messaging_messages (
    id bigint NOT NULL,
    decidim_conversation_id bigint NOT NULL,
    decidim_sender_id bigint NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_messaging_messages OWNER TO moustachu;

--
-- Name: decidim_messaging_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_messaging_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_messaging_messages_id_seq OWNER TO moustachu;

--
-- Name: decidim_messaging_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_messaging_messages_id_seq OWNED BY decidim_messaging_messages.id;


--
-- Name: decidim_messaging_participations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_messaging_participations (
    id bigint NOT NULL,
    decidim_conversation_id bigint NOT NULL,
    decidim_participant_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_messaging_participations OWNER TO moustachu;

--
-- Name: decidim_messaging_participations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_messaging_participations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_messaging_participations_id_seq OWNER TO moustachu;

--
-- Name: decidim_messaging_participations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_messaging_participations_id_seq OWNED BY decidim_messaging_participations.id;


--
-- Name: decidim_messaging_receipts; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_messaging_receipts (
    id bigint NOT NULL,
    decidim_message_id bigint NOT NULL,
    decidim_recipient_id bigint NOT NULL,
    read_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_messaging_receipts OWNER TO moustachu;

--
-- Name: decidim_messaging_receipts_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_messaging_receipts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_messaging_receipts_id_seq OWNER TO moustachu;

--
-- Name: decidim_messaging_receipts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_messaging_receipts_id_seq OWNED BY decidim_messaging_receipts.id;


--
-- Name: decidim_moderations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_moderations (
    id integer NOT NULL,
    decidim_participatory_space_id integer NOT NULL,
    decidim_reportable_type character varying NOT NULL,
    decidim_reportable_id integer NOT NULL,
    report_count integer DEFAULT 0 NOT NULL,
    hidden_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    decidim_participatory_space_type character varying NOT NULL,
    upstream_moderation character varying DEFAULT 'unmoderate'::character varying
);


ALTER TABLE decidim_moderations OWNER TO moustachu;

--
-- Name: decidim_moderations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_moderations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_moderations_id_seq OWNER TO moustachu;

--
-- Name: decidim_moderations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_moderations_id_seq OWNED BY decidim_moderations.id;


--
-- Name: decidim_navbar_links; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_navbar_links (
    id bigint NOT NULL,
    decidim_organization_id bigint,
    title jsonb,
    link character varying,
    target character varying,
    weight integer
);


ALTER TABLE decidim_navbar_links OWNER TO moustachu;

--
-- Name: decidim_navbar_links_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_navbar_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_navbar_links_id_seq OWNER TO moustachu;

--
-- Name: decidim_navbar_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_navbar_links_id_seq OWNED BY decidim_navbar_links.id;


--
-- Name: decidim_newsletters; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_newsletters (
    id integer NOT NULL,
    subject jsonb,
    body jsonb,
    organization_id integer,
    author_id integer,
    total_recipients integer,
    total_deliveries integer,
    sent_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_newsletters OWNER TO moustachu;

--
-- Name: decidim_newsletters_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_newsletters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_newsletters_id_seq OWNER TO moustachu;

--
-- Name: decidim_newsletters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_newsletters_id_seq OWNED BY decidim_newsletters.id;


--
-- Name: decidim_notifications; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_notifications (
    id bigint NOT NULL,
    decidim_user_id bigint NOT NULL,
    decidim_resource_type character varying NOT NULL,
    decidim_resource_id bigint NOT NULL,
    event_name character varying NOT NULL,
    event_class character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    extra jsonb
);


ALTER TABLE decidim_notifications OWNER TO moustachu;

--
-- Name: decidim_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_notifications_id_seq OWNER TO moustachu;

--
-- Name: decidim_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_notifications_id_seq OWNED BY decidim_notifications.id;


--
-- Name: decidim_organizations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_organizations (
    id integer NOT NULL,
    name character varying NOT NULL,
    host character varying NOT NULL,
    default_locale character varying NOT NULL,
    available_locales character varying[] DEFAULT '{}'::character varying[],
    welcome_text jsonb,
    homepage_image character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    description jsonb,
    logo character varying,
    twitter_handler character varying,
    show_statistics boolean DEFAULT true,
    favicon character varying,
    instagram_handler character varying,
    facebook_handler character varying,
    youtube_handler character varying,
    github_handler character varying,
    official_img_header character varying,
    official_img_footer character varying,
    official_url character varying,
    reference_prefix character varying NOT NULL,
    secondary_hosts character varying[] DEFAULT '{}'::character varying[],
    available_authorizations character varying[] DEFAULT '{}'::character varying[],
    header_snippets text,
    cta_button_text jsonb,
    cta_button_path character varying
);


ALTER TABLE decidim_organizations OWNER TO moustachu;

--
-- Name: decidim_organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_organizations_id_seq OWNER TO moustachu;

--
-- Name: decidim_organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_organizations_id_seq OWNED BY decidim_organizations.id;


--
-- Name: decidim_pages_pages; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_pages_pages (
    id integer NOT NULL,
    body jsonb,
    decidim_feature_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_pages_pages OWNER TO moustachu;

--
-- Name: decidim_pages_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_pages_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_pages_pages_id_seq OWNER TO moustachu;

--
-- Name: decidim_pages_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_pages_pages_id_seq OWNED BY decidim_pages_pages.id;


--
-- Name: decidim_participatory_process_groups; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_participatory_process_groups (
    id integer NOT NULL,
    name jsonb NOT NULL,
    description jsonb NOT NULL,
    hero_image character varying,
    decidim_organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_participatory_process_groups OWNER TO moustachu;

--
-- Name: decidim_participatory_process_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_participatory_process_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_participatory_process_groups_id_seq OWNER TO moustachu;

--
-- Name: decidim_participatory_process_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_participatory_process_groups_id_seq OWNED BY decidim_participatory_process_groups.id;


--
-- Name: decidim_participatory_process_steps; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_participatory_process_steps (
    id integer NOT NULL,
    title jsonb NOT NULL,
    description jsonb,
    start_date date,
    end_date date,
    decidim_participatory_process_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT false,
    "position" integer
);


ALTER TABLE decidim_participatory_process_steps OWNER TO moustachu;

--
-- Name: decidim_participatory_process_steps_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_participatory_process_steps_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_participatory_process_steps_id_seq OWNER TO moustachu;

--
-- Name: decidim_participatory_process_steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_participatory_process_steps_id_seq OWNED BY decidim_participatory_process_steps.id;


--
-- Name: decidim_participatory_process_user_roles; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_participatory_process_user_roles (
    id integer NOT NULL,
    decidim_user_id integer,
    decidim_participatory_process_id integer,
    role character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_participatory_process_user_roles OWNER TO moustachu;

--
-- Name: decidim_participatory_process_user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_participatory_process_user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_participatory_process_user_roles_id_seq OWNER TO moustachu;

--
-- Name: decidim_participatory_process_user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_participatory_process_user_roles_id_seq OWNED BY decidim_participatory_process_user_roles.id;


--
-- Name: decidim_participatory_processes; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_participatory_processes (
    id integer NOT NULL,
    slug character varying NOT NULL,
    hashtag character varying,
    decidim_organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title jsonb NOT NULL,
    subtitle jsonb NOT NULL,
    short_description jsonb NOT NULL,
    description jsonb NOT NULL,
    hero_image character varying,
    banner_image character varying,
    promoted boolean DEFAULT false,
    published_at timestamp without time zone,
    developer_group jsonb,
    end_date date,
    meta_scope jsonb,
    local_area jsonb,
    target jsonb,
    participatory_scope jsonb,
    participatory_structure jsonb,
    decidim_scope_id integer,
    decidim_participatory_process_group_id integer,
    show_statistics boolean DEFAULT true,
    announcement jsonb,
    scopes_enabled boolean DEFAULT true NOT NULL,
    start_date date
);


ALTER TABLE decidim_participatory_processes OWNER TO moustachu;

--
-- Name: decidim_participatory_processes_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_participatory_processes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_participatory_processes_id_seq OWNER TO moustachu;

--
-- Name: decidim_participatory_processes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_participatory_processes_id_seq OWNED BY decidim_participatory_processes.id;


--
-- Name: decidim_proposals_proposal_votes; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_proposals_proposal_votes (
    id integer NOT NULL,
    decidim_proposal_id integer NOT NULL,
    decidim_author_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_proposals_proposal_votes OWNER TO moustachu;

--
-- Name: decidim_proposals_proposal_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_proposals_proposal_votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_proposals_proposal_votes_id_seq OWNER TO moustachu;

--
-- Name: decidim_proposals_proposal_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_proposals_proposal_votes_id_seq OWNED BY decidim_proposals_proposal_votes.id;


--
-- Name: decidim_proposals_proposals; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_proposals_proposals (
    id integer NOT NULL,
    title text NOT NULL,
    body text NOT NULL,
    decidim_feature_id integer NOT NULL,
    decidim_author_id integer,
    decidim_scope_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    proposal_votes_count integer DEFAULT 0 NOT NULL,
    decidim_user_group_id integer,
    state character varying,
    answered_at timestamp without time zone,
    answer jsonb,
    reference character varying,
    address text,
    latitude double precision,
    longitude double precision
);


ALTER TABLE decidim_proposals_proposals OWNER TO moustachu;

--
-- Name: decidim_proposals_proposals_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_proposals_proposals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_proposals_proposals_id_seq OWNER TO moustachu;

--
-- Name: decidim_proposals_proposals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_proposals_proposals_id_seq OWNED BY decidim_proposals_proposals.id;


--
-- Name: decidim_reports; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_reports (
    id integer NOT NULL,
    decidim_moderation_id integer NOT NULL,
    decidim_user_id integer NOT NULL,
    reason character varying NOT NULL,
    details text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_reports OWNER TO moustachu;

--
-- Name: decidim_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_reports_id_seq OWNER TO moustachu;

--
-- Name: decidim_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_reports_id_seq OWNED BY decidim_reports.id;


--
-- Name: decidim_resource_links; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_resource_links (
    id integer NOT NULL,
    from_type character varying NOT NULL,
    from_id integer NOT NULL,
    to_type character varying NOT NULL,
    to_id integer NOT NULL,
    name character varying NOT NULL,
    data jsonb
);


ALTER TABLE decidim_resource_links OWNER TO moustachu;

--
-- Name: decidim_resource_links_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_resource_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_resource_links_id_seq OWNER TO moustachu;

--
-- Name: decidim_resource_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_resource_links_id_seq OWNED BY decidim_resource_links.id;


--
-- Name: decidim_scope_types; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_scope_types (
    id integer NOT NULL,
    decidim_organization_id integer,
    name jsonb NOT NULL,
    plural jsonb NOT NULL
);


ALTER TABLE decidim_scope_types OWNER TO moustachu;

--
-- Name: decidim_scope_types_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_scope_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_scope_types_id_seq OWNER TO moustachu;

--
-- Name: decidim_scope_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_scope_types_id_seq OWNED BY decidim_scope_types.id;


--
-- Name: decidim_scopes; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_scopes (
    id integer NOT NULL,
    decidim_organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name jsonb NOT NULL,
    scope_type_id integer,
    parent_id integer,
    code character varying NOT NULL,
    part_of integer[] DEFAULT '{}'::integer[] NOT NULL
);


ALTER TABLE decidim_scopes OWNER TO moustachu;

--
-- Name: decidim_scopes_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_scopes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_scopes_id_seq OWNER TO moustachu;

--
-- Name: decidim_scopes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_scopes_id_seq OWNED BY decidim_scopes.id;


--
-- Name: decidim_static_pages; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_static_pages (
    id integer NOT NULL,
    title jsonb NOT NULL,
    slug character varying NOT NULL,
    content jsonb NOT NULL,
    decidim_organization_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_static_pages OWNER TO moustachu;

--
-- Name: decidim_static_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_static_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_static_pages_id_seq OWNER TO moustachu;

--
-- Name: decidim_static_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_static_pages_id_seq OWNED BY decidim_static_pages.id;


--
-- Name: decidim_surveys_survey_answers; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_surveys_survey_answers (
    id integer NOT NULL,
    body jsonb DEFAULT '[]'::jsonb,
    decidim_user_id integer,
    decidim_survey_id integer,
    decidim_survey_question_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_surveys_survey_answers OWNER TO moustachu;

--
-- Name: decidim_surveys_survey_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_surveys_survey_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_surveys_survey_answers_id_seq OWNER TO moustachu;

--
-- Name: decidim_surveys_survey_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_surveys_survey_answers_id_seq OWNED BY decidim_surveys_survey_answers.id;


--
-- Name: decidim_surveys_survey_questions; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_surveys_survey_questions (
    id integer NOT NULL,
    body jsonb,
    decidim_survey_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    "position" integer,
    mandatory boolean,
    question_type character varying,
    answer_options jsonb DEFAULT '[]'::jsonb
);


ALTER TABLE decidim_surveys_survey_questions OWNER TO moustachu;

--
-- Name: decidim_surveys_survey_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_surveys_survey_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_surveys_survey_questions_id_seq OWNER TO moustachu;

--
-- Name: decidim_surveys_survey_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_surveys_survey_questions_id_seq OWNED BY decidim_surveys_survey_questions.id;


--
-- Name: decidim_surveys_surveys; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_surveys_surveys (
    id integer NOT NULL,
    title jsonb,
    description jsonb,
    tos jsonb,
    decidim_feature_id integer,
    published_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_surveys_surveys OWNER TO moustachu;

--
-- Name: decidim_surveys_surveys_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_surveys_surveys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_surveys_surveys_id_seq OWNER TO moustachu;

--
-- Name: decidim_surveys_surveys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_surveys_surveys_id_seq OWNED BY decidim_surveys_surveys.id;


--
-- Name: decidim_system_admins; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_system_admins (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_system_admins OWNER TO moustachu;

--
-- Name: decidim_system_admins_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_system_admins_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_system_admins_id_seq OWNER TO moustachu;

--
-- Name: decidim_system_admins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_system_admins_id_seq OWNED BY decidim_system_admins.id;


--
-- Name: decidim_user_group_memberships; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_user_group_memberships (
    id integer NOT NULL,
    decidim_user_id integer NOT NULL,
    decidim_user_group_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE decidim_user_group_memberships OWNER TO moustachu;

--
-- Name: decidim_user_group_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_user_group_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_user_group_memberships_id_seq OWNER TO moustachu;

--
-- Name: decidim_user_group_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_user_group_memberships_id_seq OWNED BY decidim_user_group_memberships.id;


--
-- Name: decidim_user_groups; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_user_groups (
    id integer NOT NULL,
    name character varying NOT NULL,
    document_number character varying NOT NULL,
    phone character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    avatar character varying,
    rejected_at timestamp without time zone,
    decidim_organization_id integer NOT NULL,
    verified_at timestamp without time zone
);


ALTER TABLE decidim_user_groups OWNER TO moustachu;

--
-- Name: decidim_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_user_groups_id_seq OWNER TO moustachu;

--
-- Name: decidim_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_user_groups_id_seq OWNED BY decidim_user_groups.id;


--
-- Name: decidim_users; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE decidim_users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id integer,
    invitations_count integer DEFAULT 0,
    decidim_organization_id integer,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    name character varying NOT NULL,
    locale character varying,
    avatar character varying,
    newsletter_notifications boolean DEFAULT false NOT NULL,
    delete_reason text,
    deleted_at timestamp without time zone,
    admin boolean DEFAULT false NOT NULL,
    managed boolean DEFAULT false NOT NULL,
    roles character varying[] DEFAULT '{}'::character varying[],
    email_on_notification boolean DEFAULT false NOT NULL,
    nickname character varying(20),
    officialized_at timestamp without time zone,
    officialized_as jsonb
);


ALTER TABLE decidim_users OWNER TO moustachu;

--
-- Name: decidim_users_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE decidim_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE decidim_users_id_seq OWNER TO moustachu;

--
-- Name: decidim_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE decidim_users_id_seq OWNED BY decidim_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO moustachu;

--
-- Name: versions; Type: TABLE; Schema: public; Owner: moustachu
--

CREATE TABLE versions (
    id bigint NOT NULL,
    item_type character varying NOT NULL,
    item_id integer NOT NULL,
    event character varying NOT NULL,
    whodunnit character varying,
    object jsonb,
    created_at timestamp without time zone,
    object_changes text
);


ALTER TABLE versions OWNER TO moustachu;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: moustachu
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE versions_id_seq OWNER TO moustachu;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: moustachu
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: decidim_accountability_results id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_accountability_results ALTER COLUMN id SET DEFAULT nextval('decidim_accountability_results_id_seq'::regclass);


--
-- Name: decidim_accountability_statuses id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_accountability_statuses ALTER COLUMN id SET DEFAULT nextval('decidim_accountability_statuses_id_seq'::regclass);


--
-- Name: decidim_accountability_timeline_entries id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_accountability_timeline_entries ALTER COLUMN id SET DEFAULT nextval('decidim_accountability_timeline_entries_id_seq'::regclass);


--
-- Name: decidim_assemblies id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_assemblies ALTER COLUMN id SET DEFAULT nextval('decidim_assemblies_id_seq'::regclass);


--
-- Name: decidim_attachments id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_attachments ALTER COLUMN id SET DEFAULT nextval('decidim_attachments_id_seq'::regclass);


--
-- Name: decidim_authorizations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_authorizations ALTER COLUMN id SET DEFAULT nextval('decidim_authorizations_id_seq'::regclass);


--
-- Name: decidim_budgets_line_items id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_budgets_line_items ALTER COLUMN id SET DEFAULT nextval('decidim_budgets_line_items_id_seq'::regclass);


--
-- Name: decidim_budgets_orders id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_budgets_orders ALTER COLUMN id SET DEFAULT nextval('decidim_budgets_orders_id_seq'::regclass);


--
-- Name: decidim_budgets_projects id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_budgets_projects ALTER COLUMN id SET DEFAULT nextval('decidim_budgets_projects_id_seq'::regclass);


--
-- Name: decidim_categories id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_categories ALTER COLUMN id SET DEFAULT nextval('decidim_categories_id_seq'::regclass);


--
-- Name: decidim_categorizations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_categorizations ALTER COLUMN id SET DEFAULT nextval('decidim_categorizations_id_seq'::regclass);


--
-- Name: decidim_comments_comment_votes id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_comments_comment_votes ALTER COLUMN id SET DEFAULT nextval('decidim_comments_comment_votes_id_seq'::regclass);


--
-- Name: decidim_comments_comments id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_comments_comments ALTER COLUMN id SET DEFAULT nextval('decidim_comments_comments_id_seq'::regclass);


--
-- Name: decidim_features id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_features ALTER COLUMN id SET DEFAULT nextval('decidim_features_id_seq'::regclass);


--
-- Name: decidim_follows id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_follows ALTER COLUMN id SET DEFAULT nextval('decidim_follows_id_seq'::regclass);


--
-- Name: decidim_identities id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_identities ALTER COLUMN id SET DEFAULT nextval('decidim_identities_id_seq'::regclass);


--
-- Name: decidim_impersonation_logs id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_impersonation_logs ALTER COLUMN id SET DEFAULT nextval('decidim_impersonation_logs_id_seq'::regclass);


--
-- Name: decidim_meetings_meetings id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_meetings_meetings ALTER COLUMN id SET DEFAULT nextval('decidim_meetings_meetings_id_seq'::regclass);


--
-- Name: decidim_meetings_registrations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_meetings_registrations ALTER COLUMN id SET DEFAULT nextval('decidim_meetings_registrations_id_seq'::regclass);


--
-- Name: decidim_messaging_conversations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_conversations ALTER COLUMN id SET DEFAULT nextval('decidim_messaging_conversations_id_seq'::regclass);


--
-- Name: decidim_messaging_messages id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_messages ALTER COLUMN id SET DEFAULT nextval('decidim_messaging_messages_id_seq'::regclass);


--
-- Name: decidim_messaging_participations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_participations ALTER COLUMN id SET DEFAULT nextval('decidim_messaging_participations_id_seq'::regclass);


--
-- Name: decidim_messaging_receipts id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_receipts ALTER COLUMN id SET DEFAULT nextval('decidim_messaging_receipts_id_seq'::regclass);


--
-- Name: decidim_moderations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_moderations ALTER COLUMN id SET DEFAULT nextval('decidim_moderations_id_seq'::regclass);


--
-- Name: decidim_navbar_links id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_navbar_links ALTER COLUMN id SET DEFAULT nextval('decidim_navbar_links_id_seq'::regclass);


--
-- Name: decidim_newsletters id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_newsletters ALTER COLUMN id SET DEFAULT nextval('decidim_newsletters_id_seq'::regclass);


--
-- Name: decidim_notifications id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_notifications ALTER COLUMN id SET DEFAULT nextval('decidim_notifications_id_seq'::regclass);


--
-- Name: decidim_organizations id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_organizations ALTER COLUMN id SET DEFAULT nextval('decidim_organizations_id_seq'::regclass);


--
-- Name: decidim_pages_pages id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_pages_pages ALTER COLUMN id SET DEFAULT nextval('decidim_pages_pages_id_seq'::regclass);


--
-- Name: decidim_participatory_process_groups id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_groups ALTER COLUMN id SET DEFAULT nextval('decidim_participatory_process_groups_id_seq'::regclass);


--
-- Name: decidim_participatory_process_steps id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_steps ALTER COLUMN id SET DEFAULT nextval('decidim_participatory_process_steps_id_seq'::regclass);


--
-- Name: decidim_participatory_process_user_roles id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_user_roles ALTER COLUMN id SET DEFAULT nextval('decidim_participatory_process_user_roles_id_seq'::regclass);


--
-- Name: decidim_participatory_processes id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_processes ALTER COLUMN id SET DEFAULT nextval('decidim_participatory_processes_id_seq'::regclass);


--
-- Name: decidim_proposals_proposal_votes id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_proposals_proposal_votes ALTER COLUMN id SET DEFAULT nextval('decidim_proposals_proposal_votes_id_seq'::regclass);


--
-- Name: decidim_proposals_proposals id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_proposals_proposals ALTER COLUMN id SET DEFAULT nextval('decidim_proposals_proposals_id_seq'::regclass);


--
-- Name: decidim_reports id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_reports ALTER COLUMN id SET DEFAULT nextval('decidim_reports_id_seq'::regclass);


--
-- Name: decidim_resource_links id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_resource_links ALTER COLUMN id SET DEFAULT nextval('decidim_resource_links_id_seq'::regclass);


--
-- Name: decidim_scope_types id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scope_types ALTER COLUMN id SET DEFAULT nextval('decidim_scope_types_id_seq'::regclass);


--
-- Name: decidim_scopes id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scopes ALTER COLUMN id SET DEFAULT nextval('decidim_scopes_id_seq'::regclass);


--
-- Name: decidim_static_pages id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_static_pages ALTER COLUMN id SET DEFAULT nextval('decidim_static_pages_id_seq'::regclass);


--
-- Name: decidim_surveys_survey_answers id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_surveys_survey_answers ALTER COLUMN id SET DEFAULT nextval('decidim_surveys_survey_answers_id_seq'::regclass);


--
-- Name: decidim_surveys_survey_questions id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_surveys_survey_questions ALTER COLUMN id SET DEFAULT nextval('decidim_surveys_survey_questions_id_seq'::regclass);


--
-- Name: decidim_surveys_surveys id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_surveys_surveys ALTER COLUMN id SET DEFAULT nextval('decidim_surveys_surveys_id_seq'::regclass);


--
-- Name: decidim_system_admins id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_system_admins ALTER COLUMN id SET DEFAULT nextval('decidim_system_admins_id_seq'::regclass);


--
-- Name: decidim_user_group_memberships id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_user_group_memberships ALTER COLUMN id SET DEFAULT nextval('decidim_user_group_memberships_id_seq'::regclass);


--
-- Name: decidim_user_groups id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_user_groups ALTER COLUMN id SET DEFAULT nextval('decidim_user_groups_id_seq'::regclass);


--
-- Name: decidim_users id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_users ALTER COLUMN id SET DEFAULT nextval('decidim_users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2017-09-13 12:46:47.675115	2018-02-01 21:14:52.357427
\.


--
-- Data for Name: decidim_accountability_results; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_accountability_results (id, title, description, reference, start_date, end_date, progress, parent_id, decidim_accountability_status_id, decidim_feature_id, decidim_scope_id, created_at, updated_at, children_count) FROM stdin;
1	{"ca": "Ut consequatur hic quaerat excepturi voluptatem.", "en": "Deleniti recusandae et sed omnis consequatur.", "es": "Quis harum atque tempora."}	{"ca": "<p>Et sit dolorum. Sapiente sed commodi magni praesentium exercitationem quos. Ipsum suscipit optio quidem distinctio aut ea est.</p>", "en": "<p>Et ipsum consequuntur optio aspernatur labore. Quod qui dignissimos beatae veniam delectus ut natus. Corporis similique nisi corrupti voluptas doloribus temporibus. Fugiat ex rerum. Sed perferendis quia autem excepturi sint dicta.</p>", "es": "<p>Hic aliquam ducimus qui vero. Sit reiciendis nemo et magnam incidunt natus. Voluptas maiores minima rem quia ad.</p>"}	\N	\N	\N	\N	\N	\N	4	13	2018-02-01 21:07:41.84958	2018-02-01 21:07:41.84958	0
2	{"ca": "Explicabo dolore rem excepturi autem quasi voluptates.", "en": "Aut est quia nostrum aut.", "es": "Non voluptatem tempore."}	{"ca": "<p>Debitis consequuntur nihil. Dolore nemo possimus et repudiandae itaque. Maiores debitis qui enim consequatur est.</p>", "en": "<p>Eos aliquam perferendis. Repellendus est illum aut sapiente. Provident est commodi fuga autem sapiente. Maxime eaque consequuntur quibusdam veritatis voluptas. Quidem optio sint et quia atque.</p>", "es": "<p>Tenetur deleniti autem voluptas aut. Repellat sunt omnis dolores sit qui itaque quisquam. Eum quam maiores vero sunt.</p>"}	\N	\N	\N	\N	\N	\N	4	14	2018-02-01 21:07:41.924315	2018-02-01 21:07:41.924315	0
3	{"ca": "Ut in consequatur possimus.", "en": "Rerum omnis autem.", "es": "Cupiditate laudantium nihil."}	{"ca": "<p>Harum repellat quia ut ea molestiae. Quaerat voluptatem voluptatem inventore laudantium temporibus officia tempora. Quis delectus adipisci nam placeat non.</p>", "en": "<p>Consectetur libero tempora quia aut aut doloribus autem. Voluptatum eos eos et magnam eveniet consequatur ducimus. Occaecati perferendis porro eos sit aspernatur dicta. Qui hic incidunt repellat.</p>", "es": "<p>Velit omnis suscipit expedita. Voluptas enim nihil. Dolores tempora repellendus ullam temporibus. Et ipsa totam earum.</p>"}	\N	\N	\N	\N	\N	\N	4	11	2018-02-01 21:07:41.931528	2018-02-01 21:07:41.931528	0
4	{"ca": "Quos omnis rerum at id.", "en": "Delectus ut omnis et velit.", "es": "Aliquid dolorem cumque sapiente sit non pariatur."}	{"ca": "<p>Rerum ut velit a et sit. Exercitationem quia maxime suscipit. Corrupti eum corporis non est. Rem sit similique aut. Soluta eum voluptatem porro quis natus laborum velit.</p>", "en": "<p>Fuga necessitatibus eligendi. Quod deserunt alias. Quam voluptas asperiores eius dolores.</p>", "es": "<p>Voluptate repellat magni sed qui minima et. Magnam ea sed voluptatem id. Vel delectus deserunt temporibus hic eos quam. Accusantium qui eligendi beatae maiores.</p>"}	\N	\N	\N	\N	\N	\N	10	8	2018-02-01 21:07:41.950874	2018-02-01 21:07:41.950874	0
5	{"ca": "Harum qui tempora fugit aperiam.", "en": "Beatae quis.", "es": "Ipsum officiis qui iusto."}	{"ca": "<p>Veritatis consequatur ea. Officia rem omnis eum provident. Sit iusto vitae dolorem reprehenderit tempore. Deleniti necessitatibus omnis non.</p>", "en": "<p>Dolor praesentium alias qui officiis exercitationem. Aut consequatur praesentium. Exercitationem molestias rerum a molestiae culpa.</p>", "es": "<p>Dicta facere ut quasi omnis hic nobis. Voluptas minus dolorem ut quisquam non. Cum doloremque sit quam culpa adipisci sed. Consectetur autem corrupti accusamus rerum at.</p>"}	\N	\N	\N	\N	\N	\N	10	10	2018-02-01 21:07:41.956225	2018-02-01 21:07:41.956225	0
6	{"ca": "Perspiciatis modi et quas minima distinctio.", "en": "Est nisi ut labore.", "es": "Consectetur molestiae deleniti sed quis odit debitis."}	{"ca": "<p>Dolores expedita labore praesentium et minus accusamus. Voluptas quia corrupti eos. Non molestiae voluptatibus maiores qui nostrum aut fugit. Aliquid voluptatem neque voluptatum. Reiciendis omnis labore.</p>", "en": "<p>Ad distinctio qui. Repudiandae asperiores a hic voluptas repellat. Possimus cupiditate voluptatem quasi pariatur. Accusantium cumque voluptatem aliquam enim voluptatibus.</p>", "es": "<p>Dolorum labore consequatur repudiandae illum. Velit non nemo quibusdam. Qui est aliquam accusantium et debitis error omnis. Dolores eligendi a et voluptas tenetur.</p>"}	\N	\N	\N	\N	\N	\N	10	14	2018-02-01 21:07:41.961072	2018-02-01 21:07:41.961072	0
7	{"ca": "Perferendis sed sint molestias voluptatum omnis.", "en": "Qui est omnis odio aliquid quos repellat.", "es": "Aut corrupti fugit autem dolorum dolorem."}	{"ca": "<p>Voluptatem sequi error animi perspiciatis corrupti quis. Dolor aperiam iste quo. Officiis laborum voluptate atque labore cumque.</p>", "en": "<p>Maiores cupiditate cum sunt. Ducimus aut possimus esse voluptatem. Molestias quae adipisci ab vel quod. Dolores excepturi deserunt quia. Eum ullam voluptates deserunt quo.</p>", "es": "<p>Possimus impedit qui ullam ut eum nisi voluptatum. Tenetur ad fuga molestiae quia occaecati voluptatem sint. Rerum qui sed aliquid ipsum error non. Recusandae dolorum nihil porro ut vel ea.</p>"}	\N	\N	\N	\N	\N	\N	16	6	2018-02-01 21:07:41.966043	2018-02-01 21:07:41.966043	0
8	{"ca": "Est voluptas aut sit ab porro.", "en": "At enim aut quia aut eius.", "es": "Neque repellat inventore laborum."}	{"ca": "<p>Perferendis error accusantium placeat totam aut. Incidunt quo quia. Quibusdam omnis et et laudantium enim quis voluptatum.</p>", "en": "<p>Et nihil pariatur. Modi veritatis distinctio. Est consequatur et necessitatibus.</p>", "es": "<p>Nesciunt doloremque enim dolore voluptatem aperiam tenetur. Et eos sed aliquid. Vitae cumque ut doloremque ut dolor ullam consectetur.</p>"}	\N	\N	\N	\N	\N	\N	16	16	2018-02-01 21:07:41.972283	2018-02-01 21:07:41.972283	0
9	{"ca": "Maiores aut.", "en": "Placeat velit voluptatem libero.", "es": "Dolorem provident ut dolorem."}	{"ca": "<p>Dolore assumenda minus. Omnis quo asperiores ut voluptatum. Dolores quisquam qui accusantium aut eos enim. Consequatur doloremque totam in. Dolor ullam dolor aspernatur blanditiis quia ea.</p>", "en": "<p>Dolores quasi laudantium eveniet enim nesciunt. Minima nostrum ea dolores sint. Alias amet doloremque dolor sit accusamus vitae. Qui voluptatem laudantium quasi sed animi voluptas maiores. Consequatur quia quos nemo.</p>", "es": "<p>Corrupti explicabo cupiditate. Laudantium amet tempore et fugiat. Labore aut quibusdam. Porro sit voluptatem mollitia laborum.</p>"}	\N	\N	\N	\N	\N	\N	16	14	2018-02-01 21:07:41.977306	2018-02-01 21:07:41.977306	0
10	{"ca": "Qui consequatur quam aliquid.", "en": "Repudiandae facere voluptatem.", "es": "Sit autem non molestiae qui maxime."}	{"ca": "<p>Est aut totam ut. Dolores alias maxime aut dolorem tempore expedita a. Asperiores repudiandae mollitia quae.</p>", "en": "<p>Quas non placeat. Asperiores odit consequatur sapiente non saepe quaerat molestiae. Dolorum omnis doloremque amet rerum.</p>", "es": "<p>Adipisci dicta culpa quos. Non assumenda asperiores. Quasi quo numquam in omnis iste. Praesentium consequatur vel vel quibusdam. Modi molestias saepe magnam cum asperiores quae.</p>"}	\N	\N	\N	\N	\N	\N	22	17	2018-02-01 21:07:41.982798	2018-02-01 21:07:41.982798	0
11	{"ca": "Iste totam omnis repudiandae pariatur.", "en": "Qui cumque libero est et.", "es": "In blanditiis quam perferendis quasi fugit eum."}	{"ca": "<p>Aut optio dolores dolor repellat ut. Et dicta in. Vitae doloribus alias magni ducimus. Explicabo nulla ea magnam officiis ab autem repellat.</p>", "en": "<p>Ratione ea consequatur aperiam. Ullam nobis ipsum repellat nesciunt ratione vitae. Accusamus quo inventore similique magnam quaerat dolores. Harum doloremque sint quo et placeat non eos.</p>", "es": "<p>Temporibus accusamus consequuntur qui amet. Voluptatem nam aut magnam earum consectetur. Odit accusantium ut dolor nam consequatur nihil.</p>"}	\N	\N	\N	\N	\N	\N	22	10	2018-02-01 21:07:41.987539	2018-02-01 21:07:41.987539	0
12	{"ca": "Rerum culpa doloremque ea minima reiciendis sed.", "en": "Nisi aspernatur neque voluptatem et similique.", "es": "Sed quia ducimus repellat autem sint quis."}	{"ca": "<p>Alias voluptatem maxime quia velit. Sint aut et. Fuga nihil ut explicabo enim est. Laborum in odit dicta inventore odio possimus adipisci. Eos perspiciatis occaecati velit consectetur repellendus magnam.</p>", "en": "<p>Qui exercitationem voluptas est. Incidunt consequuntur ipsam illum asperiores. Quaerat nisi sint omnis porro molestias. Voluptatum nulla dolor vero adipisci est quas.</p>", "es": "<p>Temporibus blanditiis et debitis ut. Enim maiores ea ut. Similique vel nesciunt eligendi. Sed aliquid commodi earum necessitatibus sit fugiat quas.</p>"}	\N	\N	\N	\N	\N	\N	22	3	2018-02-01 21:07:41.992493	2018-02-01 21:07:41.992493	0
13	{"ca": "Doloremque nobis sed.", "en": "Porro perspiciatis.", "es": "Maxime quo rem."}	{"ca": "<p>Mollitia eveniet aut eaque sequi sunt quia nulla. Neque quod sint iusto et molestiae minima corporis. Aut sed architecto nisi rerum nemo perspiciatis. Et recusandae deserunt.</p>", "en": "<p>Quae quis labore rerum autem similique porro. Provident facere minus a eveniet. Ipsum velit qui omnis cum et molestiae eos.</p>", "es": "<p>Cum et enim. Fugit aut placeat repellendus maxime asperiores distinctio et. Id qui laboriosam quisquam accusantium iusto. Modi aut molestiae eligendi dolorem cumque libero.</p>"}	\N	\N	\N	\N	\N	\N	28	16	2018-02-01 21:07:41.997391	2018-02-01 21:07:41.997391	0
14	{"ca": "Saepe cum maxime officia rerum.", "en": "Sit vero soluta.", "es": "Rerum molestias."}	{"ca": "<p>Ipsum a libero. Sit voluptate qui quo magni voluptatem sequi modi. Nam adipisci consequatur officia.</p>", "en": "<p>Voluptatem pariatur vero ad in praesentium molestiae. Voluptatem labore iure eius. Debitis eos nisi quis corporis unde impedit. Repudiandae qui sunt aperiam occaecati id. Corrupti quia iure sit consequatur enim eaque deleniti.</p>", "es": "<p>Ut quis ut aut. Reiciendis ab illum quam quia quisquam repellendus. Unde quo quisquam. Temporibus voluptatum animi eligendi aut similique doloribus.</p>"}	\N	\N	\N	\N	\N	\N	28	4	2018-02-01 21:07:42.002	2018-02-01 21:07:42.002	0
15	{"ca": "Laboriosam beatae.", "en": "Nam aliquam.", "es": "Ut asperiores odit."}	{"ca": "<p>Maxime sunt est. Accusantium maiores aut earum. Quis sit nobis alias.</p>", "en": "<p>Illum eaque ea et totam. Ullam et alias distinctio aut corrupti in. Eligendi porro voluptatem exercitationem et possimus est doloremque.</p>", "es": "<p>Occaecati excepturi explicabo. Perspiciatis voluptate et est sed fugiat doloremque quia. Quia laudantium iure officiis repudiandae aut placeat iste. Numquam quia aut iusto ut et perferendis. Magni tempore alias iure ut non quia esse.</p>"}	\N	\N	\N	\N	\N	\N	28	7	2018-02-01 21:07:42.008562	2018-02-01 21:07:42.008562	0
16	{"ca": "Nihil sit nobis deserunt placeat.", "en": "Quia atque quam vel.", "es": "Est dolorum nisi."}	{"ca": "<p>Omnis quia qui et. Et voluptates sit rem praesentium est. Labore fuga earum deleniti veritatis accusantium. Laboriosam ex dolorum omnis voluptates et.</p>", "en": "<p>Quos et aliquid nobis repellat et optio. Dolorem voluptatibus fuga. Ea itaque vitae sit. Qui qui numquam debitis ratione. Molestiae libero rem optio repudiandae.</p>", "es": "<p>Aut natus et voluptatibus animi vero. Aliquam autem labore voluptas nihil et. Expedita dolor recusandae eaque aut molestias quis est.</p>"}	\N	\N	\N	\N	\N	\N	34	9	2018-02-01 21:07:42.013613	2018-02-01 21:07:42.013613	0
17	{"ca": "Deserunt et eum incidunt necessitatibus.", "en": "Consequatur exercitationem.", "es": "Et iste et."}	{"ca": "<p>Qui alias aut odio sint corrupti nemo. At corrupti veritatis laudantium quas. Officiis beatae voluptatem eius rerum rerum nobis.</p>", "en": "<p>Fugit id laudantium ut qui cumque possimus quae. Quidem sequi et nostrum est facere. Iusto quasi necessitatibus eum ipsum.</p>", "es": "<p>Culpa vitae error voluptate nihil ipsum. Amet aut qui. Et nobis maiores ab qui velit doloribus. Praesentium aut doloribus sit distinctio dolore officia et. In eum rerum ut.</p>"}	\N	\N	\N	\N	\N	\N	34	16	2018-02-01 21:07:42.020155	2018-02-01 21:07:42.020155	0
18	{"ca": "Eum in fugiat natus.", "en": "Unde dolor numquam excepturi inventore labore.", "es": "Perferendis nihil animi."}	{"ca": "<p>Consequatur fugit aperiam fugiat et aspernatur perspiciatis tempore. Blanditiis in distinctio sint. Nesciunt aut tempore fugiat quos.</p>", "en": "<p>Non sapiente dolorem quidem tempora voluptate numquam voluptates. Doloribus modi velit. Ut enim ut labore.</p>", "es": "<p>Recusandae nemo consectetur dolorem et suscipit nihil. Suscipit esse necessitatibus enim vero nisi quas fugit. Qui in a est est quibusdam consequuntur. Tenetur explicabo quam nam accusamus assumenda. Ipsum vitae commodi qui aut dolorem reiciendis id.</p>"}	\N	\N	\N	\N	\N	\N	34	8	2018-02-01 21:07:42.02522	2018-02-01 21:07:42.02522	0
19	{"fr": "Quel est l'influence que vous avez sur la décision de réalisation du canal Seine/Nord ? Quelles actions ?"}	{"fr": "<p><strong>Réponse du maître d'ouvrage :</strong></p><p>﻿﻿﻿<em>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio.&nbsp;</em></p>"}	\N	\N	\N	\N	\N	\N	53	\N	2018-02-01 21:07:42.031534	2018-02-01 21:07:42.031534	0
22	{"fr": "Quel est l influence que vous avez sur la décision de réalisation du canal Seine/Nord ? Quelles actions ?"}	{"fr": "<p><em>Une réponse sera donnée par la maîtrise d'ouvrage dans les plus brefs délais.</em></p>"}	\N	\N	\N	\N	\N	\N	53	\N	2018-02-01 21:07:42.035816	2018-02-01 21:07:42.035816	0
\.


--
-- Data for Name: decidim_accountability_statuses; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_accountability_statuses (id, key, name, decidim_feature_id, created_at, updated_at, description, progress) FROM stdin;
\.


--
-- Data for Name: decidim_accountability_timeline_entries; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_accountability_timeline_entries (id, entry_date, description, decidim_accountability_result_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_assemblies; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_assemblies (id, slug, hashtag, decidim_organization_id, created_at, updated_at, title, subtitle, short_description, description, hero_image, banner_image, promoted, published_at, developer_group, meta_scope, local_area, target, participatory_scope, participatory_structure, show_statistics, decidim_scope_id, scopes_enabled) FROM stdin;
1	facere-vel	#facilis	1	2017-09-13 12:48:08.995177	2017-09-13 12:48:08.995177	{"ca": "Cupiditate vitae eveniet voluptatem et voluptate quia sequi.", "en": "Rem voluptatem recusandae sed laboriosam.", "es": "Excepturi qui non sed aut nam vitae voluptas."}	{"ca": "Perferendis enim molestias dolores aspernatur ullam consequatur.", "en": "Et voluptatem.", "es": "Voluptates nemo."}	{"ca": "<p>Corporis ipsam vitae quos.</p>", "en": "<p>Possimus sint deleniti debitis inventore et et sed.</p>", "es": "<p>Quo tempora magni.</p>"}	{"ca": "<p>Aut veritatis dolorem et repudiandae dolor. Magni quis sequi. Impedit sint dolorum accusantium ea.</p>", "en": "<p>Odit tempore quam voluptatem suscipit eos est. Et quo consectetur itaque quisquam qui quibusdam. Perferendis praesentium qui ea ex animi. Qui quia debitis quisquam officia possimus alias consequuntur.</p>", "es": "<p>Perferendis sed nihil. Ut nesciunt et facilis quia est ipsum. Ullam rerum omnis dignissimos impedit consequatur. Laborum beatae qui voluptas natus et soluta ut. Sapiente repudiandae sed nulla laboriosam quibusdam possimus omnis.</p>"}	city.jpeg	city2.jpeg	t	2017-08-30 12:48:08.680814	{"ca": "Laudantium culpa ut et sit.", "en": "Quia et optio ex assumenda ad.", "es": "Omnis."}	{"ca": "harum", "en": "earum", "es": "neque"}	{"ca": "Est est quia.", "en": "Quia omnis provident doloribus.", "es": "Qui placeat."}	{"ca": "Odio ipsam dolorem expedita tenetur rem aut veritatis.", "en": "Pariatur officiis ea repellat rerum repellendus.", "es": "Et ad quisquam ut ea reprehenderit iure."}	{"ca": "Reiciendis sed ut.", "en": "Illo eum aperiam alias tempora velit.", "es": "Assumenda asperiores ut."}	{"ca": "Iure velit molestiae.", "en": "Accusantium aut sint.", "es": "Saepe sint delectus quia repellat neque nulla."}	f	\N	t
2	sed-rem	#ut	1	2017-09-13 12:48:09.229482	2017-09-13 12:48:09.229482	{"ca": "Facilis explicabo sapiente aut hic fugit.", "en": "Et veniam dolorem veritatis et natus sapiente aut distinctio voluptas.", "es": "Cupiditate consequatur fugiat aut ea itaque et nulla."}	{"ca": "Possimus placeat.", "en": "Atque nesciunt exercitationem quia.", "es": "Voluptas ut doloribus assumenda illo qui laudantium."}	{"ca": "<p>Recusandae sit consequuntur cumque voluptas voluptates.</p>", "en": "<p>Soluta rerum placeat.</p>", "es": "<p>Deserunt nobis voluptatum.</p>"}	{"ca": "<p>Reprehenderit neque fugit. Veritatis consequatur dolore perspiciatis illo ut. Sit iste aliquam. Voluptas et laborum impedit. Accusamus adipisci repellendus deleniti aliquam eveniet est sapiente.</p>", "en": "<p>Asperiores esse sit minima repellendus consequatur quia illum. Nobis dolor molestiae consequatur autem tempore non et. Non magni eum facere dolor rem mollitia. Fugit provident quae sit dolores veniam.</p>", "es": "<p>Possimus omnis beatae rerum delectus labore. Eaque voluptatum suscipit fugiat iusto id et. Vero at omnis illo corrupti ab delectus. Quae occaecati rem qui modi.</p>"}	city.jpeg	city2.jpeg	t	2017-08-30 12:48:09.013035	{"ca": "Et.", "en": "Sed perspiciatis.", "es": "Earum."}	{"ca": "non", "en": "nihil", "es": "vel"}	{"ca": "Iste distinctio.", "en": "Doloremque expedita ea unde suscipit officiis.", "es": "Placeat reprehenderit ad."}	{"ca": "Tempora laudantium eos est aut rem maiores.", "en": "Nam ducimus a expedita saepe aspernatur eaque.", "es": "Quas debitis ea qui qui asperiores harum repellendus."}	{"ca": "Asperiores repellat eum corrupti ducimus ullam.", "en": "Voluptate quos voluptas esse non.", "es": "Ut dolorem atque maxime qui."}	{"ca": "Praesentium quaerat et sed cum tempore impedit.", "en": "Officia voluptate ex facere aperiam optio.", "es": "Placeat et."}	f	13	t
3	recusandae-eos	#est	1	2017-09-13 12:48:09.491315	2017-09-13 12:48:09.491315	{"ca": "Et magni quia officiis aut placeat sint.", "en": "Eos excepturi expedita porro rem.", "es": "Laborum itaque labore beatae repudiandae quia ipsa nihil."}	{"ca": "Recusandae architecto iusto et sunt quia nam.", "en": "Vel quis dolores veniam.", "es": "Nostrum architecto doloribus."}	{"ca": "<p>Assumenda autem natus numquam officiis omnis ab.</p>", "en": "<p>Aut libero quam.</p>", "es": "<p>Rerum quasi quibusdam doloremque non voluptas sed dolorum.</p>"}	{"ca": "<p>Iure aliquid porro incidunt ab voluptas. In rerum repudiandae sunt ipsa et. Excepturi quidem at.</p>", "en": "<p>Sequi praesentium veritatis sunt. Ratione totam saepe. Incidunt quaerat harum placeat cum animi assumenda.</p>", "es": "<p>Delectus reiciendis dolor in non. Magnam enim impedit rem voluptas. Ad consectetur nesciunt natus eveniet. Et enim esse tenetur sed ut.</p>"}	city.jpeg	city2.jpeg	t	2017-08-30 12:48:09.254411	{"ca": "Vero non voluptatem quo.", "en": "Voluptas placeat dignissimos similique facilis iste.", "es": "Voluptate eius et."}	{"ca": "hic", "en": "dolorum", "es": "earum"}	{"ca": "Voluptas debitis aut nobis et.", "en": "Sunt vitae iusto ut qui ratione.", "es": "Quasi aut unde iste tempora fugit deleniti."}	{"ca": "Ea nulla et inventore quod autem at dicta.", "en": "Quisquam quis architecto pariatur dolorem non minima.", "es": "Odio facilis earum praesentium rerum architecto officia dolore."}	{"ca": "Sed quod labore.", "en": "Quo nihil et.", "es": "Laboriosam id nobis tenetur."}	{"ca": "Maiores vero nostrum.", "en": "Cum dolor enim officia doloremque ut ea.", "es": "Quisquam iusto."}	f	\N	t
4	102	transport énergie 	3	2017-11-14 08:04:53.073004	2017-11-14 08:08:32.847487	{"fr": "Réunion publique de lancement"}	{"fr": "Réunion générale"}	{"fr": "<p>Courte présentation de la réunion ici...</p>"}	{"fr": "<p>Description de la réunion ici...</p>"}	\N	\N	f	2017-11-14 08:05:47.78766	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": "Première présentation du projet, premiers échanges, toutes thématiques"}	{"fr": ""}	f	\N	f
\.


--
-- Data for Name: decidim_attachments; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_attachments (id, title, description, file, content_type, file_size, attached_to_id, created_at, updated_at, attached_to_type) FROM stdin;
1	{"ca": "Ut voluptatem et.", "en": "Eos est possimus.", "es": "Et quaerat."}	{"ca": "Aut officia quasi non quia.", "en": "Provident rerum in ex quas deleniti accusamus amet dolore.", "es": "Minima eaque debitis est corrupti."}	city.jpeg	image/jpeg	108908	1	2017-09-13 12:47:18.091097	2017-09-13 12:47:18.091097	Decidim::ParticipatoryProcess
2	{"ca": "Ullam laboriosam ab impedit.", "en": "Omnis eius nisi temporibus quia.", "es": "Maiores odit."}	{"ca": "In ratione ut dolorum beatae voluptas adipisci assumenda cumque.", "en": "Harum voluptatum aperiam saepe eaque quo aut.", "es": "Unde molestiae a sit exercitationem."}	Exampledocument.pdf	application/pdf	17525	1	2017-09-13 12:47:18.119112	2017-09-13 12:47:18.119112	Decidim::ParticipatoryProcess
3	{"ca": "Quo provident.", "en": "Ea quae nisi ratione necessitatibus quod totam.", "es": "Quasi ipsa."}	{"ca": "Quidem incidunt necessitatibus iure officiis consequatur cupiditate.", "en": "Tempora recusandae quia asperiores et aspernatur tenetur mollitia et ut.", "es": "Voluptas necessitatibus non nesciunt minima earum fugiat aliquam sit tempore."}	city.jpeg	image/jpeg	108908	1	2017-09-13 12:47:21.120167	2017-09-13 12:47:21.120167	Decidim::Meetings::Meeting
4	{"ca": "Incidunt nisi quia quis earum ullam aut.", "en": "Minima sint.", "es": "Voluptatum numquam aliquam fuga molestias."}	{"ca": "Voluptatem amet ab magnam aut accusamus neque.", "en": "Officia atque quos eum consectetur.", "es": "Et modi odit reiciendis voluptas quasi."}	Exampledocument.pdf	application/pdf	17525	1	2017-09-13 12:47:21.130066	2017-09-13 12:47:21.130066	Decidim::Meetings::Meeting
5	{"ca": "Eligendi aut.", "en": "Qui et nam quo.", "es": "Est enim."}	{"ca": "Sunt ratione voluptatem ab quam eaque amet iusto dolor.", "en": "Dolore modi maiores magnam et.", "es": "Hic possimus ex occaecati eveniet esse."}	city.jpeg	image/jpeg	108908	2	2017-09-13 12:47:23.394491	2017-09-13 12:47:23.394491	Decidim::Meetings::Meeting
6	{"ca": "Unde fuga illo error quis est.", "en": "Et deserunt cupiditate.", "es": "Perspiciatis officiis autem voluptate iste pariatur."}	{"ca": "Vel et et deleniti quis.", "en": "Est minus suscipit amet sed iusto incidunt odit repellendus et.", "es": "Ea eos nulla eum error."}	Exampledocument.pdf	application/pdf	17525	2	2017-09-13 12:47:23.403349	2017-09-13 12:47:23.403349	Decidim::Meetings::Meeting
7	{"ca": "Aut culpa dolorem delectus quaerat.", "en": "Et amet eos aut.", "es": "Ducimus quam non."}	{"ca": "Quo tenetur ex impedit excepturi nostrum.", "en": "Nihil voluptatem dolores et consequatur quia.", "es": "Ut id necessitatibus quia ullam dolorem vero possimus."}	city.jpeg	image/jpeg	108908	3	2017-09-13 12:47:25.677613	2017-09-13 12:47:25.677613	Decidim::Meetings::Meeting
8	{"ca": "Beatae voluptatem.", "en": "Id voluptate consequatur.", "es": "Ducimus minus aliquam repellendus autem officiis."}	{"ca": "Iste eos voluptas esse optio doloremque repellat consequuntur.", "en": "Qui nihil deleniti molestias suscipit.", "es": "Molestiae doloribus necessitatibus et eum perferendis rem cupiditate qui."}	Exampledocument.pdf	application/pdf	17525	3	2017-09-13 12:47:25.68635	2017-09-13 12:47:25.68635	Decidim::Meetings::Meeting
9	{"ca": "Consequuntur est nemo cum at possimus.", "en": "Voluptatem nesciunt necessitatibus earum est nulla.", "es": "Sit repellendus repudiandae."}	{"ca": "Suscipit omnis est perferendis et.", "en": "Distinctio quam sapiente voluptatum quod a.", "es": "Doloribus consequatur deserunt odit exercitationem sed repellendus."}	city.jpeg	image/jpeg	108908	1	2017-09-13 12:47:33.3075	2017-09-13 12:47:33.3075	Decidim::Budgets::Project
10	{"ca": "Necessitatibus ea alias quibusdam quasi sed consequatur.", "en": "Consequatur voluptatem rerum debitis.", "es": "Eum neque labore."}	{"ca": "Facilis perferendis reiciendis omnis est.", "en": "Ducimus repellat doloremque aut in accusamus molestias possimus suscipit ut.", "es": "Repudiandae architecto quibusdam rerum dolores aut sed et."}	Exampledocument.pdf	application/pdf	17525	1	2017-09-13 12:47:33.318981	2017-09-13 12:47:33.318981	Decidim::Budgets::Project
11	{"ca": "Ipsam quae praesentium eveniet sed.", "en": "Est atque aut nam quod repudiandae aperiam.", "es": "Sapiente et possimus rerum et esse eaque."}	{"ca": "Voluptatem non odio numquam minus.", "en": "Odit voluptas nihil a error tenetur molestias.", "es": "Nam magni velit aut voluptatem."}	city.jpeg	image/jpeg	108908	2	2017-09-13 12:47:33.553666	2017-09-13 12:47:33.553666	Decidim::Budgets::Project
12	{"ca": "Autem quia qui sequi.", "en": "Id consequuntur qui et.", "es": "Ex iste in veritatis."}	{"ca": "Sit et necessitatibus atque fugit.", "en": "Ab ad dolore architecto minima voluptatem aut adipisci.", "es": "Molestiae explicabo molestiae quia sapiente."}	Exampledocument.pdf	application/pdf	17525	2	2017-09-13 12:47:33.562733	2017-09-13 12:47:33.562733	Decidim::Budgets::Project
13	{"ca": "Ab voluptatibus molestiae beatae.", "en": "Aut accusantium ad voluptas vero.", "es": "Nobis nemo placeat iste eligendi et ea."}	{"ca": "Exercitationem quos saepe fuga qui.", "en": "Voluptates dolorum at quia aspernatur voluptatibus.", "es": "Est enim et distinctio necessitatibus pariatur voluptatibus porro temporibus voluptatem."}	city.jpeg	image/jpeg	108908	3	2017-09-13 12:47:33.761092	2017-09-13 12:47:33.761092	Decidim::Budgets::Project
14	{"ca": "Dolorem omnis voluptatem deserunt reiciendis.", "en": "Placeat quod ullam nihil.", "es": "Omnis dicta dolores et voluptatibus porro suscipit."}	{"ca": "Cumque officiis nihil aspernatur nam ab qui animi.", "en": "Qui aut dignissimos ipsa ipsum consequatur porro.", "es": "Mollitia suscipit ut adipisci illo quia aut quibusdam dolore temporibus."}	Exampledocument.pdf	application/pdf	17525	3	2017-09-13 12:47:33.770117	2017-09-13 12:47:33.770117	Decidim::Budgets::Project
15	{"ca": "Optio officia illum consequatur.", "en": "Ducimus minus.", "es": "Laudantium quia ut blanditiis maiores nesciunt."}	{"ca": "Atque nihil quia odio voluptates quia provident adipisci.", "en": "Ut ipsa dicta placeat dolorem delectus.", "es": "Nulla ex quis non beatae."}	city.jpeg	image/jpeg	108908	2	2017-09-13 12:47:34.862165	2017-09-13 12:47:34.862165	Decidim::ParticipatoryProcess
16	{"ca": "Voluptas sit odio.", "en": "Rerum et ea aut.", "es": "Voluptas officiis unde dolores qui aperiam et."}	{"ca": "Eligendi possimus quidem recusandae ut veritatis culpa.", "en": "Accusantium quidem dolor unde voluptas perferendis provident molestiae quia ex.", "es": "Soluta facere magnam tempore possimus."}	Exampledocument.pdf	application/pdf	17525	2	2017-09-13 12:47:34.871352	2017-09-13 12:47:34.871352	Decidim::ParticipatoryProcess
17	{"ca": "Corrupti eos eveniet mollitia neque aut.", "en": "Ducimus maiores aliquid.", "es": "Velit voluptas vel autem non aut."}	{"ca": "Est corporis commodi ab dolor.", "en": "Non sed qui et rem nisi.", "es": "Et nobis error hic laborum."}	city.jpeg	image/jpeg	108908	4	2017-09-13 12:47:37.302991	2017-09-13 12:47:37.302991	Decidim::Meetings::Meeting
18	{"ca": "Molestiae quidem quasi sint accusantium reiciendis iusto.", "en": "Consequatur nisi beatae magnam eveniet pariatur sequi.", "es": "Illum laudantium reprehenderit libero."}	{"ca": "Eaque vitae repellendus reprehenderit et.", "en": "Voluptatem repellat dolores ducimus sapiente rerum vitae et consequuntur qui.", "es": "Deleniti et voluptates eum ea ut animi et."}	Exampledocument.pdf	application/pdf	17525	4	2017-09-13 12:47:37.3133	2017-09-13 12:47:37.3133	Decidim::Meetings::Meeting
19	{"ca": "Odio amet est architecto.", "en": "Repudiandae libero cupiditate consectetur.", "es": "Et saepe."}	{"ca": "Voluptatem qui corrupti repellendus autem omnis saepe est.", "en": "Quis cum eveniet totam et dolores in amet dolorum excepturi.", "es": "Rerum architecto iste et quod esse ab."}	city.jpeg	image/jpeg	108908	5	2017-09-13 12:47:39.712258	2017-09-13 12:47:39.712258	Decidim::Meetings::Meeting
20	{"ca": "Incidunt dicta architecto.", "en": "Consequatur eius suscipit voluptatem.", "es": "Consequatur itaque asperiores."}	{"ca": "Consectetur aspernatur cum impedit id nam eveniet voluptas.", "en": "Atque quia alias repellendus rem necessitatibus ullam sed.", "es": "Sit qui tenetur deserunt autem."}	Exampledocument.pdf	application/pdf	17525	5	2017-09-13 12:47:39.722283	2017-09-13 12:47:39.722283	Decidim::Meetings::Meeting
21	{"ca": "Facilis ipsum quas ab.", "en": "Eius possimus.", "es": "Quod dignissimos sit neque."}	{"ca": "Tempore omnis blanditiis ut asperiores aut recusandae nisi.", "en": "Omnis iusto iure et rerum.", "es": "Voluptatem cupiditate eum autem tenetur corporis."}	city.jpeg	image/jpeg	108908	6	2017-09-13 12:47:42.15119	2017-09-13 12:47:42.15119	Decidim::Meetings::Meeting
22	{"ca": "Sit nihil ut doloremque.", "en": "Laudantium numquam odit asperiores voluptatem totam porro.", "es": "Nulla nisi qui cupiditate rerum molestias officia."}	{"ca": "Recusandae qui mollitia est perspiciatis quidem similique nihil.", "en": "Molestiae porro nobis et ea eius.", "es": "Et sit dolorum odit voluptas quos ut."}	Exampledocument.pdf	application/pdf	17525	6	2017-09-13 12:47:42.162803	2017-09-13 12:47:42.162803	Decidim::Meetings::Meeting
23	{"ca": "Possimus beatae enim debitis nihil.", "en": "Sit sit sunt voluptas.", "es": "Qui vitae."}	{"ca": "Eius ipsam consequatur minima esse.", "en": "Aut consectetur veritatis earum enim.", "es": "Quod eaque consequatur et ratione."}	city.jpeg	image/jpeg	108908	4	2017-09-13 12:47:50.240154	2017-09-13 12:47:50.240154	Decidim::Budgets::Project
24	{"ca": "Quia perspiciatis voluptas ut.", "en": "Nemo sit tenetur expedita quis repudiandae.", "es": "Accusantium rem magnam minima voluptas."}	{"ca": "Voluptate reprehenderit at qui mollitia explicabo.", "en": "Temporibus non fugit quos voluptatum aut est sunt optio.", "es": "Nisi asperiores corporis sint aliquam delectus ut eos quidem omnis."}	Exampledocument.pdf	application/pdf	17525	4	2017-09-13 12:47:50.254062	2017-09-13 12:47:50.254062	Decidim::Budgets::Project
25	{"ca": "Omnis quis non.", "en": "Ullam voluptatem.", "es": "Molestias voluptatum fugit dolores laboriosam consequatur deleniti."}	{"ca": "Iusto quibusdam deleniti cum nesciunt eveniet quam.", "en": "Laudantium incidunt doloribus cum cumque et enim dicta.", "es": "Pariatur voluptate animi perspiciatis deleniti totam autem dolor."}	city.jpeg	image/jpeg	108908	5	2017-09-13 12:47:50.472996	2017-09-13 12:47:50.472996	Decidim::Budgets::Project
26	{"ca": "Qui est praesentium.", "en": "Ut ut suscipit.", "es": "Ut pariatur aspernatur dolorem explicabo nesciunt."}	{"ca": "Voluptatibus aut minima quis laboriosam aspernatur quia deleniti perspiciatis.", "en": "Vel quasi sunt id cum quidem quisquam et culpa sit.", "es": "Quae accusantium dolorem qui iste quia molestiae ad porro repellat."}	Exampledocument.pdf	application/pdf	17525	5	2017-09-13 12:47:50.482516	2017-09-13 12:47:50.482516	Decidim::Budgets::Project
27	{"ca": "Nihil laudantium perspiciatis omnis nesciunt.", "en": "Odit qui enim.", "es": "Repudiandae voluptas et."}	{"ca": "Odio porro sit et labore ut sapiente sunt soluta.", "en": "Iste ut voluptatem occaecati neque animi qui vero veritatis quae.", "es": "Harum maxime dignissimos molestiae autem ipsa asperiores tempore dolorem."}	city.jpeg	image/jpeg	108908	6	2017-09-13 12:47:50.652963	2017-09-13 12:47:50.652963	Decidim::Budgets::Project
28	{"ca": "Ut facilis id qui mollitia.", "en": "Harum quia quidem totam.", "es": "Et quo ad natus illo."}	{"ca": "Et quam aut voluptatem libero blanditiis minus maiores possimus.", "en": "Nulla et neque voluptas sit doloremque.", "es": "Voluptatibus sequi vel omnis optio in assumenda repellendus eveniet."}	Exampledocument.pdf	application/pdf	17525	6	2017-09-13 12:47:50.66417	2017-09-13 12:47:50.66417	Decidim::Budgets::Project
29	{"ca": "Nostrum consequatur nisi tempora voluptate voluptas et.", "en": "Dolorem animi sequi consequatur.", "es": "Provident et omnis accusantium qui nobis."}	{"ca": "Expedita est aperiam nobis qui sunt.", "en": "Enim debitis et architecto saepe recusandae.", "es": "Recusandae quia adipisci quos debitis at provident veritatis."}	city.jpeg	image/jpeg	108908	3	2017-09-13 12:47:51.526505	2017-09-13 12:47:51.526505	Decidim::ParticipatoryProcess
30	{"ca": "Rerum assumenda ut praesentium at voluptatem doloribus.", "en": "Fugiat quo et reiciendis et.", "es": "Numquam incidunt et."}	{"ca": "Eaque ratione incidunt et sint.", "en": "Ea veritatis fugit eos eius repellendus molestiae omnis est.", "es": "Et et vel optio corporis quae."}	Exampledocument.pdf	application/pdf	17525	3	2017-09-13 12:47:51.535911	2017-09-13 12:47:51.535911	Decidim::ParticipatoryProcess
31	{"ca": "Magnam laborum quibusdam quia ex.", "en": "Consequatur sint.", "es": "Ducimus maxime consequatur minima."}	{"ca": "Aut incidunt quos occaecati ipsa eaque repudiandae.", "en": "Expedita recusandae dolor iste consectetur nobis ea laudantium.", "es": "Et cupiditate est ipsam esse facere."}	city.jpeg	image/jpeg	108908	7	2017-09-13 12:47:53.868642	2017-09-13 12:47:53.868642	Decidim::Meetings::Meeting
32	{"ca": "Similique eos.", "en": "Aut ratione.", "es": "Impedit sequi alias maiores aut."}	{"ca": "Eos vero autem quod soluta odio ut.", "en": "Ducimus veritatis dolore aut minima dolorem.", "es": "Deserunt iure occaecati ut id labore quidem fuga."}	Exampledocument.pdf	application/pdf	17525	7	2017-09-13 12:47:53.878234	2017-09-13 12:47:53.878234	Decidim::Meetings::Meeting
33	{"ca": "Est id rem.", "en": "Vel qui.", "es": "Magni ad."}	{"ca": "Nihil consequatur voluptatem optio molestias.", "en": "Et doloremque quia consequatur necessitatibus consectetur sed rerum illum enim.", "es": "Beatae non cupiditate dolor ducimus tenetur quas quod sit."}	city.jpeg	image/jpeg	108908	8	2017-09-13 12:47:56.205413	2017-09-13 12:47:56.205413	Decidim::Meetings::Meeting
34	{"ca": "Ut id labore.", "en": "Corporis sit excepturi occaecati libero perferendis adipisci.", "es": "Nulla eligendi maiores sit at."}	{"ca": "Fuga eligendi et aut et culpa ad unde recusandae sit.", "en": "Ad omnis molestiae aliquam laudantium sunt nostrum nemo ut qui.", "es": "Dicta eum quaerat eos ad velit natus."}	Exampledocument.pdf	application/pdf	17525	8	2017-09-13 12:47:56.214241	2017-09-13 12:47:56.214241	Decidim::Meetings::Meeting
35	{"ca": "Est rerum aut.", "en": "Architecto modi aut.", "es": "Quasi libero laborum vel quia."}	{"ca": "Officiis ea eos cum nesciunt.", "en": "Ut iste quo eos autem asperiores vel possimus qui ipsum.", "es": "Facere error eos et voluptatem illo suscipit."}	city.jpeg	image/jpeg	108908	9	2017-09-13 12:47:58.649992	2017-09-13 12:47:58.649992	Decidim::Meetings::Meeting
36	{"ca": "Exercitationem officia placeat eos.", "en": "Aliquam ut ducimus.", "es": "Alias sit libero cum voluptatem consequatur."}	{"ca": "Incidunt quibusdam dicta aperiam non distinctio velit consequatur architecto.", "en": "Molestias et est quas incidunt ad ratione omnis rem.", "es": "Laboriosam quia blanditiis adipisci accusantium corporis id repudiandae."}	Exampledocument.pdf	application/pdf	17525	9	2017-09-13 12:47:58.677221	2017-09-13 12:47:58.677221	Decidim::Meetings::Meeting
37	{"ca": "Veritatis quod asperiores odit non.", "en": "Voluptates nihil ut.", "es": "Fugit ut qui ut quisquam."}	{"ca": "Consequatur omnis quia sed occaecati soluta aspernatur.", "en": "Eaque similique esse qui sit voluptatem laudantium sequi.", "es": "Dolorem in alias possimus ut excepturi aperiam ratione molestiae."}	city.jpeg	image/jpeg	108908	7	2017-09-13 12:48:07.994191	2017-09-13 12:48:07.994191	Decidim::Budgets::Project
38	{"ca": "Ratione suscipit.", "en": "Ut nulla autem in sunt nemo.", "es": "Eum et omnis."}	{"ca": "Voluptate doloribus quos aut in.", "en": "Molestiae deserunt velit adipisci quisquam.", "es": "Animi ea facilis consequatur et dolorem aut placeat ut reiciendis."}	Exampledocument.pdf	application/pdf	17525	7	2017-09-13 12:48:08.007308	2017-09-13 12:48:08.007308	Decidim::Budgets::Project
39	{"ca": "Excepturi quae quos esse voluptatem suscipit corrupti.", "en": "Velit accusantium provident inventore.", "es": "Et nesciunt quaerat repellat dolores."}	{"ca": "Ipsam ut sunt modi qui provident.", "en": "Nulla quo earum cupiditate nostrum sed possimus est.", "es": "Ea quisquam aspernatur sunt et necessitatibus quia qui eaque."}	city.jpeg	image/jpeg	108908	8	2017-09-13 12:48:08.314132	2017-09-13 12:48:08.314132	Decidim::Budgets::Project
40	{"ca": "Est temporibus iure et molestias.", "en": "Rem et vitae quia earum iusto.", "es": "Voluptatem ut."}	{"ca": "Minus aliquam sunt sit illo ut rem hic sapiente id.", "en": "Vitae quidem est nihil sint distinctio.", "es": "Consequuntur aut omnis ex dolores ut."}	Exampledocument.pdf	application/pdf	17525	8	2017-09-13 12:48:08.331382	2017-09-13 12:48:08.331382	Decidim::Budgets::Project
41	{"ca": "Dolor architecto ullam fugiat assumenda nam.", "en": "Quo non aliquid.", "es": "Consectetur quo quidem voluptatem veniam."}	{"ca": "Nesciunt maxime asperiores et omnis.", "en": "A et rerum ab est voluptas harum dolorem quae ea.", "es": "Soluta eius error dolor est porro deleniti."}	city.jpeg	image/jpeg	108908	9	2017-09-13 12:48:08.526419	2017-09-13 12:48:08.526419	Decidim::Budgets::Project
42	{"ca": "Saepe qui.", "en": "Est tenetur magnam.", "es": "Unde sunt culpa."}	{"ca": "Nobis rerum tempore aut ipsum minus nostrum nesciunt hic.", "en": "Quam recusandae aliquid qui reiciendis et a veniam ratione.", "es": "Culpa labore et excepturi suscipit est quae aut."}	Exampledocument.pdf	application/pdf	17525	9	2017-09-13 12:48:08.537491	2017-09-13 12:48:08.537491	Decidim::Budgets::Project
43	{"ca": "Illum incidunt voluptate rerum error atque dolorem.", "en": "Occaecati non recusandae est ratione sed.", "es": "Laborum officiis aut aspernatur consequatur itaque."}	{"ca": "Voluptatum eaque ex sit non ea error delectus fugit eum.", "en": "Error nobis quasi molestiae eum ipsa.", "es": "Ut sit consequatur iste similique optio earum velit velit quidem."}	city.jpeg	image/jpeg	108908	1	2017-09-13 12:48:09.650778	2017-09-13 12:48:09.650778	Decidim::Assembly
44	{"ca": "Eveniet nulla.", "en": "Velit dolor aut rerum.", "es": "Quidem occaecati vel omnis."}	{"ca": "Rerum eveniet recusandae aut consequatur corporis cumque reiciendis quisquam aut.", "en": "Ut harum fugit repellendus illum.", "es": "Recusandae commodi dolores quod maxime nam deleniti enim."}	Exampledocument.pdf	application/pdf	17525	1	2017-09-13 12:48:09.666285	2017-09-13 12:48:09.666285	Decidim::Assembly
45	{"ca": "Repellendus officiis consequatur aut.", "en": "Et in laboriosam.", "es": "Maxime doloremque ut."}	{"ca": "Quo eveniet exercitationem voluptatum ducimus harum et ipsum quia explicabo.", "en": "Vel soluta veniam non iste.", "es": "Omnis quam qui vero ut velit."}	city.jpeg	image/jpeg	108908	10	2017-09-13 12:48:12.396072	2017-09-13 12:48:12.396072	Decidim::Meetings::Meeting
46	{"ca": "Totam facere.", "en": "Rerum eos temporibus deleniti veniam autem alias.", "es": "Sit ut nemo nisi animi qui dolorem."}	{"ca": "Quia voluptatem ut vel enim alias qui.", "en": "Possimus non quasi doloribus dolor voluptatem architecto nam dolores et.", "es": "Vero error ipsa doloremque impedit ratione aut consequatur."}	Exampledocument.pdf	application/pdf	17525	10	2017-09-13 12:48:12.414013	2017-09-13 12:48:12.414013	Decidim::Meetings::Meeting
47	{"ca": "At quam fugit aut amet minima velit.", "en": "Optio accusantium illo officiis.", "es": "Optio temporibus molestias."}	{"ca": "Dignissimos nisi quibusdam aut numquam vero.", "en": "Exercitationem eum molestiae sed et.", "es": "Hic eius velit fugiat eum animi."}	city.jpeg	image/jpeg	108908	11	2017-09-13 12:48:14.819632	2017-09-13 12:48:14.819632	Decidim::Meetings::Meeting
48	{"ca": "Perspiciatis earum.", "en": "Impedit deserunt velit autem.", "es": "Atque quis voluptatem neque quae ut."}	{"ca": "Eaque dolore nulla quod tenetur.", "en": "Sit adipisci unde cumque repudiandae rerum.", "es": "Consequatur et eum harum soluta esse."}	Exampledocument.pdf	application/pdf	17525	11	2017-09-13 12:48:14.829443	2017-09-13 12:48:14.829443	Decidim::Meetings::Meeting
49	{"ca": "Veniam quam repellendus.", "en": "Modi consequuntur maiores rerum possimus.", "es": "Quasi est nisi sit nulla amet pariatur."}	{"ca": "Vero est in non harum nisi ratione et error.", "en": "Dolore dolores cum velit ea accusamus atque sunt consectetur.", "es": "Fugiat iusto rerum numquam doloremque quis reiciendis omnis."}	city.jpeg	image/jpeg	108908	12	2017-09-13 12:48:17.081237	2017-09-13 12:48:17.081237	Decidim::Meetings::Meeting
50	{"ca": "Earum non enim quisquam alias nihil.", "en": "Rerum quo harum voluptate voluptatibus sed.", "es": "Ea laboriosam facere sed aut."}	{"ca": "Est delectus vitae voluptas voluptatem similique adipisci est ea.", "en": "Dolorem quis nulla aperiam nostrum aliquam rerum molestiae ea.", "es": "Sed cupiditate numquam aut rerum ut qui."}	Exampledocument.pdf	application/pdf	17525	12	2017-09-13 12:48:17.090628	2017-09-13 12:48:17.090628	Decidim::Meetings::Meeting
51	{"ca": "Ullam nihil rerum.", "en": "Ut qui consequatur sed ut architecto.", "es": "Maxime soluta distinctio iure."}	{"ca": "Praesentium ipsam facilis vero iusto quos adipisci.", "en": "Doloribus ipsum quia necessitatibus beatae.", "es": "Voluptatem ipsa ab ad ut ea hic officia voluptas ducimus."}	city.jpeg	image/jpeg	108908	10	2017-09-13 12:48:24.181584	2017-09-13 12:48:24.181584	Decidim::Budgets::Project
52	{"ca": "A est distinctio aliquid debitis voluptatem et.", "en": "Sunt sint facere aperiam sit.", "es": "Quis animi."}	{"ca": "Eos est dolores et sit facere autem et dolorem.", "en": "Totam id blanditiis rem itaque nihil magni voluptates.", "es": "In mollitia similique quo in rem."}	Exampledocument.pdf	application/pdf	17525	10	2017-09-13 12:48:24.193164	2017-09-13 12:48:24.193164	Decidim::Budgets::Project
53	{"ca": "Rerum autem ex reprehenderit quibusdam praesentium quod.", "en": "Omnis voluptatem sunt.", "es": "Quibusdam sunt rerum."}	{"ca": "Consequatur nemo esse modi qui consectetur aliquid.", "en": "Dolores non deleniti ut quam eveniet nostrum tempore.", "es": "At magni accusamus non ducimus eveniet et est."}	city.jpeg	image/jpeg	108908	11	2017-09-13 12:48:24.443569	2017-09-13 12:48:24.443569	Decidim::Budgets::Project
54	{"ca": "Dolor nobis dolores impedit.", "en": "Laudantium dolor.", "es": "Ut est est aut."}	{"ca": "Quia possimus porro minima quia.", "en": "Mollitia omnis est tempora dicta eos qui sit rerum placeat.", "es": "Quis beatae velit veniam quia."}	Exampledocument.pdf	application/pdf	17525	11	2017-09-13 12:48:24.453165	2017-09-13 12:48:24.453165	Decidim::Budgets::Project
55	{"ca": "Qui ducimus praesentium.", "en": "Ut perspiciatis fuga rerum fugiat quo.", "es": "Architecto magni explicabo."}	{"ca": "Impedit aut est natus vel et.", "en": "Recusandae qui non optio asperiores qui.", "es": "Impedit est eligendi sunt porro numquam adipisci."}	city.jpeg	image/jpeg	108908	12	2017-09-13 12:48:24.643268	2017-09-13 12:48:24.643268	Decidim::Budgets::Project
56	{"ca": "Fuga sapiente possimus officia.", "en": "Eum non ducimus.", "es": "Sunt laborum."}	{"ca": "Voluptate nesciunt facere similique laborum porro qui optio.", "en": "Ea aut ipsam exercitationem fuga cupiditate voluptatibus.", "es": "Omnis tempore voluptates autem porro neque voluptas qui velit."}	Exampledocument.pdf	application/pdf	17525	12	2017-09-13 12:48:24.653353	2017-09-13 12:48:24.653353	Decidim::Budgets::Project
57	{"ca": "Qui et autem sunt aut est et.", "en": "Maxime non vitae aspernatur ex facilis.", "es": "Aliquid quidem et vero beatae non non."}	{"ca": "Vero velit voluptatum harum sequi et dolores doloribus.", "en": "Enim odit quo rem mollitia nobis totam.", "es": "Eius praesentium aliquid aut ipsa dolorem debitis illo voluptatem."}	city.jpeg	image/jpeg	108908	2	2017-09-13 12:48:24.905668	2017-09-13 12:48:24.905668	Decidim::Assembly
58	{"ca": "Et vero ut dolores.", "en": "Similique est.", "es": "Sunt natus vel amet."}	{"ca": "Culpa quaerat iusto ullam enim nostrum.", "en": "Dignissimos omnis modi laboriosam eum quis non hic exercitationem.", "es": "Ea illum praesentium tempore distinctio ullam debitis reiciendis."}	Exampledocument.pdf	application/pdf	17525	2	2017-09-13 12:48:24.917274	2017-09-13 12:48:24.917274	Decidim::Assembly
59	{"ca": "Nihil repellendus et rerum eius ipsa.", "en": "Laboriosam deserunt eaque est.", "es": "Libero in id beatae."}	{"ca": "Ut repellendus suscipit ea sit impedit assumenda sequi corporis quia.", "en": "Molestiae delectus qui sit culpa rem est sed aut.", "es": "Non ea quisquam omnis porro repellat nemo doloremque."}	city.jpeg	image/jpeg	108908	13	2017-09-13 12:48:27.38993	2017-09-13 12:48:27.38993	Decidim::Meetings::Meeting
60	{"ca": "Temporibus enim voluptatum.", "en": "Natus ipsa autem ex qui.", "es": "Enim adipisci ea sit nam qui."}	{"ca": "Et autem consequatur velit saepe asperiores doloremque quas.", "en": "Quaerat quos at cum suscipit possimus omnis praesentium.", "es": "Odio et vel delectus aut id."}	Exampledocument.pdf	application/pdf	17525	13	2017-09-13 12:48:27.400145	2017-09-13 12:48:27.400145	Decidim::Meetings::Meeting
61	{"ca": "Aut dolore veritatis doloribus aut nemo labore.", "en": "Illo voluptatem dicta.", "es": "Ea et aut."}	{"ca": "Dolores nulla et est molestias provident ullam.", "en": "Iste culpa dolorem et reiciendis.", "es": "Rerum accusantium quaerat repellat perferendis aperiam nulla quia dolorem sit."}	city.jpeg	image/jpeg	108908	14	2017-09-13 12:48:29.716052	2017-09-13 12:48:29.716052	Decidim::Meetings::Meeting
62	{"ca": "Rerum veniam nostrum et doloremque.", "en": "Incidunt est facere accusamus nam molestiae ullam.", "es": "Incidunt accusantium aut adipisci molestiae voluptatibus."}	{"ca": "Quibusdam ad sunt dicta aut.", "en": "Quas voluptas dignissimos illo qui quidem quibusdam.", "es": "Autem consequatur ut blanditiis doloribus sequi reprehenderit id quam."}	Exampledocument.pdf	application/pdf	17525	14	2017-09-13 12:48:29.725256	2017-09-13 12:48:29.725256	Decidim::Meetings::Meeting
63	{"ca": "Modi architecto sed eum est esse.", "en": "Fugit omnis perferendis adipisci doloribus.", "es": "Laboriosam exercitationem praesentium fuga."}	{"ca": "Dolores ab nam blanditiis ea qui.", "en": "Quos perspiciatis velit impedit possimus.", "es": "Et ea doloribus voluptas dolor magnam dolorem dolor."}	city.jpeg	image/jpeg	108908	15	2017-09-13 12:48:32.011826	2017-09-13 12:48:32.011826	Decidim::Meetings::Meeting
64	{"ca": "Animi natus et sapiente et.", "en": "Aut aut mollitia aut.", "es": "Laborum qui excepturi aut quae aut quibusdam."}	{"ca": "Vitae aut rerum doloribus quia quasi corporis et.", "en": "Distinctio laboriosam saepe similique expedita.", "es": "Nihil reprehenderit esse sit excepturi."}	Exampledocument.pdf	application/pdf	17525	15	2017-09-13 12:48:32.021338	2017-09-13 12:48:32.021338	Decidim::Meetings::Meeting
65	{"ca": "Est soluta quis omnis quisquam aut.", "en": "Dolores molestias et facilis minima nesciunt quasi.", "es": "Quia mollitia dolores."}	{"ca": "Quisquam tempore numquam perspiciatis incidunt quae debitis minima commodi dicta.", "en": "At voluptatibus rerum similique quam.", "es": "Harum et explicabo quos delectus nesciunt magnam nostrum unde quas."}	city.jpeg	image/jpeg	108908	13	2017-09-13 12:48:40.390643	2017-09-13 12:48:40.390643	Decidim::Budgets::Project
66	{"ca": "Provident aspernatur.", "en": "Natus magnam reprehenderit dolorem sapiente.", "es": "Architecto quam."}	{"ca": "Voluptas blanditiis maiores asperiores sapiente quibusdam aut numquam.", "en": "Alias quia temporibus reprehenderit ducimus iusto et aperiam.", "es": "Et molestiae aut animi commodi."}	Exampledocument.pdf	application/pdf	17525	13	2017-09-13 12:48:40.407072	2017-09-13 12:48:40.407072	Decidim::Budgets::Project
67	{"ca": "Eligendi autem quidem.", "en": "Sint ea iusto ea.", "es": "Doloremque iusto qui et et."}	{"ca": "In dolor vel suscipit at quisquam voluptatum recusandae omnis.", "en": "Ut ea earum qui et at doloribus velit deleniti a.", "es": "Et provident perferendis ad neque."}	city.jpeg	image/jpeg	108908	14	2017-09-13 12:48:40.641968	2017-09-13 12:48:40.641968	Decidim::Budgets::Project
68	{"ca": "Nisi quam est molestiae quibusdam.", "en": "Molestias molestiae qui fugiat dolorum tenetur.", "es": "Voluptate quam vitae non sint sit repudiandae."}	{"ca": "Aut ut expedita sed non ab culpa sed.", "en": "Officia enim hic reiciendis molestiae molestiae ab et.", "es": "Asperiores ad labore nostrum dolores perspiciatis assumenda sed."}	Exampledocument.pdf	application/pdf	17525	14	2017-09-13 12:48:40.653992	2017-09-13 12:48:40.653992	Decidim::Budgets::Project
69	{"ca": "Dolores sit amet.", "en": "Officia qui voluptates sunt qui tenetur.", "es": "Accusantium non in."}	{"ca": "Omnis explicabo deserunt labore libero maiores cum.", "en": "Labore et ut iste eligendi officiis laboriosam nisi quis culpa.", "es": "Et dolorem saepe rem ex suscipit eius sed."}	city.jpeg	image/jpeg	108908	15	2017-09-13 12:48:40.935485	2017-09-13 12:48:40.935485	Decidim::Budgets::Project
70	{"ca": "Consectetur est.", "en": "Voluptate non eos quae dolor debitis et.", "es": "Id amet id voluptas quam quia ea."}	{"ca": "Consectetur omnis occaecati eos maxime dolor ipsa exercitationem debitis ut.", "en": "Dignissimos et iste sit architecto dicta nobis.", "es": "Delectus et dolor quia quo in ut."}	Exampledocument.pdf	application/pdf	17525	15	2017-09-13 12:48:40.947932	2017-09-13 12:48:40.947932	Decidim::Budgets::Project
71	{"ca": "In earum deleniti eos exercitationem incidunt.", "en": "Et consectetur aut.", "es": "Aut laboriosam."}	{"ca": "Impedit quis sed rerum voluptas velit provident eos excepturi et.", "en": "Aut recusandae non voluptatem expedita quibusdam ab officia hic consequatur.", "es": "Illo sed tenetur amet occaecati dolor facere."}	city.jpeg	image/jpeg	108908	3	2017-09-13 12:48:41.142707	2017-09-13 12:48:41.142707	Decidim::Assembly
72	{"ca": "Et minus.", "en": "Dolor laudantium.", "es": "Nesciunt dignissimos illo rerum voluptas."}	{"ca": "Suscipit culpa fugit natus iste ut odio voluptates.", "en": "Quo voluptatum ipsum soluta dolore.", "es": "Aut id qui omnis et eligendi."}	Exampledocument.pdf	application/pdf	17525	3	2017-09-13 12:48:41.151928	2017-09-13 12:48:41.151928	Decidim::Assembly
73	{"ca": "Ea dolore ex ipsum.", "en": "Minima nulla.", "es": "Minus quia voluptatem ut."}	{"ca": "Exercitationem architecto nulla mollitia deserunt sunt harum.", "en": "Dicta facilis accusantium expedita quia.", "es": "Asperiores voluptatem rem libero aut sed accusantium ducimus."}	city.jpeg	image/jpeg	108908	16	2017-09-13 12:48:43.569031	2017-09-13 12:48:43.569031	Decidim::Meetings::Meeting
74	{"ca": "Mollitia sit sed soluta dolor odit facere.", "en": "Omnis iure qui est dolorum ullam.", "es": "Maxime distinctio non nisi ipsam et consequatur."}	{"ca": "Dolores quia ipsa quia ut.", "en": "Error et sed dicta occaecati temporibus ut.", "es": "Aliquam voluptas natus qui dolor et nam exercitationem unde officiis."}	Exampledocument.pdf	application/pdf	17525	16	2017-09-13 12:48:43.578259	2017-09-13 12:48:43.578259	Decidim::Meetings::Meeting
75	{"ca": "Ut deserunt non ea voluptatem earum.", "en": "Ut non a temporibus ipsa.", "es": "Sint suscipit eum aperiam iure inventore."}	{"ca": "Ut voluptatem eius quo sit sit quisquam.", "en": "Voluptas sequi ab ad ducimus molestiae eum totam dolores eaque.", "es": "Alias suscipit optio cupiditate expedita hic."}	city.jpeg	image/jpeg	108908	17	2017-09-13 12:48:45.846122	2017-09-13 12:48:45.846122	Decidim::Meetings::Meeting
76	{"ca": "Id dignissimos ducimus.", "en": "Illo itaque deleniti.", "es": "Fugiat velit quas et accusantium et."}	{"ca": "Facilis dolor in quod quia soluta odio porro.", "en": "Voluptatem earum quasi quia tempore corporis.", "es": "Accusantium natus et dolorem magni."}	Exampledocument.pdf	application/pdf	17525	17	2017-09-13 12:48:45.855509	2017-09-13 12:48:45.855509	Decidim::Meetings::Meeting
77	{"ca": "Porro in unde inventore officiis adipisci.", "en": "Autem maiores eos dolor est necessitatibus.", "es": "Dolor reprehenderit adipisci voluptas eius."}	{"ca": "Quia omnis nihil enim est culpa.", "en": "Ad quisquam sit qui dignissimos provident et.", "es": "Eligendi laboriosam alias voluptas unde dolor nostrum tempora voluptatem sed."}	city.jpeg	image/jpeg	108908	18	2017-09-13 12:48:48.146075	2017-09-13 12:48:48.146075	Decidim::Meetings::Meeting
78	{"ca": "Aut vero non non occaecati.", "en": "Odio sed modi.", "es": "Laudantium ullam voluptas dolorem et aliquam molestiae."}	{"ca": "Velit repellat eum ut ad perferendis qui autem.", "en": "Asperiores dolore autem et eveniet aut amet.", "es": "Atque aliquam non nemo deserunt fuga quae."}	Exampledocument.pdf	application/pdf	17525	18	2017-09-13 12:48:48.155179	2017-09-13 12:48:48.155179	Decidim::Meetings::Meeting
79	{"ca": "Est inventore qui et exercitationem itaque deleniti.", "en": "Labore qui amet neque quasi mollitia.", "es": "Sit hic recusandae deserunt porro dolore quaerat."}	{"ca": "Quia quia delectus veritatis et repudiandae et rerum.", "en": "Non sed et nulla voluptas.", "es": "Voluptates nihil error et dolorum ad non fugit placeat."}	city.jpeg	image/jpeg	108908	16	2017-09-13 12:48:56.010799	2017-09-13 12:48:56.010799	Decidim::Budgets::Project
80	{"ca": "Quia quasi nulla ratione ex exercitationem aliquam.", "en": "Consequatur eaque.", "es": "Dolor nulla."}	{"ca": "Eveniet ab ut dolor est libero.", "en": "Ut facere delectus praesentium non.", "es": "Quia debitis sit est non repellendus cupiditate recusandae totam."}	Exampledocument.pdf	application/pdf	17525	16	2017-09-13 12:48:56.020406	2017-09-13 12:48:56.020406	Decidim::Budgets::Project
81	{"ca": "Facere quis ducimus similique minus qui.", "en": "Praesentium earum aspernatur quam id est rem.", "es": "Enim inventore cum velit."}	{"ca": "Sint qui unde praesentium dignissimos at quae sed.", "en": "Expedita sed error molestiae est omnis quae vel.", "es": "Molestiae quisquam ut sunt quas ea."}	city.jpeg	image/jpeg	108908	17	2017-09-13 12:48:56.17747	2017-09-13 12:48:56.17747	Decidim::Budgets::Project
82	{"ca": "Itaque eaque dolorem inventore provident non.", "en": "Unde minus quia pariatur quia quo quas.", "es": "Facere reiciendis eos."}	{"ca": "Officia in sit quibusdam nihil ut et non doloremque.", "en": "Fuga facere autem suscipit ipsum et.", "es": "Delectus recusandae vitae quaerat nemo velit rerum."}	Exampledocument.pdf	application/pdf	17525	17	2017-09-13 12:48:56.186582	2017-09-13 12:48:56.186582	Decidim::Budgets::Project
83	{"ca": "Doloribus nihil et quos natus ad inventore.", "en": "Facere est.", "es": "Amet repellat aut facilis doloribus in."}	{"ca": "Modi culpa aut nobis deserunt rerum.", "en": "Iste est doloribus aut dolorem delectus recusandae ut dolor.", "es": "Rerum laboriosam in dolores eum sapiente."}	city.jpeg	image/jpeg	108908	18	2017-09-13 12:48:56.342665	2017-09-13 12:48:56.342665	Decidim::Budgets::Project
84	{"ca": "Recusandae quos praesentium corrupti eos.", "en": "Vel eligendi nobis dolor eveniet.", "es": "Expedita deleniti voluptatem."}	{"ca": "Beatae assumenda occaecati asperiores libero harum aspernatur quos dolorem unde.", "en": "Consequatur magnam dolores nihil nesciunt nostrum.", "es": "Consectetur voluptatem sit non ea nam aliquid dolorem sequi totam."}	Exampledocument.pdf	application/pdf	17525	18	2017-09-13 12:48:56.35194	2017-09-13 12:48:56.35194	Decidim::Budgets::Project
85	"Dossier de présentation"	\N	document-lie.pdf	application/pdf	7227	127	2017-09-13 17:18:56.349573	2017-09-13 17:18:56.349573	Decidim::Proposals::Proposal
86	"fichier joint"	\N	Les_enjeux_relatifs_à_la_technologie_Blockchain___Géostrategia.pdf	application/pdf	120283	130	2017-09-14 09:08:45.539086	2017-09-14 09:08:45.539086	Decidim::Proposals::Proposal
87	"Contribution de Michel Nicolet"	\N	Contribution-Michel_Nicolet.pdf	application/pdf	347411	232	2017-11-06 15:17:22.730506	2017-11-06 15:17:22.730506	Decidim::Proposals::Proposal
88	{"fr": "Document lié à un processus"}	{"fr": "test"}	Vig_Annexes_MO.PNG	image/png	71844	7	2017-11-14 10:49:29.654024	2017-11-14 10:49:29.654024	Decidim::ParticipatoryProcess
89	{"fr": "Verbatim d'un atelier"}	{"fr": "test"}	Verbatim_Atelier_Autun_6_février.pdf	application/pdf	492994	7	2017-11-14 10:55:20.121593	2017-11-14 10:55:20.121593	Decidim::ParticipatoryProcess
90	"Décathlon choisit le train"	\N	Capture_d_écran_2017-11-21_à_08.22.57.png	image/png	216454	265	2017-11-21 07:33:42.91946	2017-11-21 07:33:42.91946	Decidim::Proposals::Proposal
91	"pollution lumineuse"	\N	Capture_d_écran_2017-11-27_à_10.29.28.png	image/png	352444	339	2017-11-27 09:41:47.862944	2017-11-27 09:41:47.862944	Decidim::Proposals::Proposal
92	"Contribution du MEDEF Côte d'Opale"	\N	CAP_2020_-_CONTRIBUTION_MEDEF_CO__1_.pdf	application/pdf	1019299	361	2017-12-14 10:45:27.710844	2017-12-14 10:45:27.710844	Decidim::Proposals::Proposal
93	"Contribution de la commune de Loon-Plage"	\N	SKM_C454e17120411050.pdf	application/pdf	64703	365	2017-12-15 11:14:01.160818	2017-12-15 11:14:01.160818	Decidim::Proposals::Proposal
94	"Courrier CNDP GPMD CAP 2020"	\N	Courrier_CNDP_GPMD_CAP_2020.pdf	application/pdf	530176	380	2017-12-19 10:41:36.722569	2017-12-19 10:41:36.722569	Decidim::Proposals::Proposal
95	"Dunkerque Cap 2020. Le bon sens : la décroissance du trafic maritime"	\N	Dunkerque_Cap_2020_Le_bon_sens_la_décroissance_du_trafic_maritime.docx	application/vnd.openxmlformats-officedocument.wordprocessingml.document	93650	382	2017-12-22 16:03:45.123452	2017-12-22 16:03:45.123452	Decidim::Proposals::Proposal
96	"Avis de la commune de Bourbourg"	\N	Lettre_débat_public_Cap_2020.pdf	application/pdf	79473	385	2017-12-22 19:24:25.589578	2017-12-22 19:24:25.589578	Decidim::Proposals::Proposal
\.


--
-- Data for Name: decidim_authorizations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_authorizations (id, name, metadata, decidim_user_id, created_at, updated_at, unique_id, granted_at, verification_metadata, verification_attachment) FROM stdin;
\.


--
-- Data for Name: decidim_budgets_line_items; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_budgets_line_items (id, decidim_order_id, decidim_project_id) FROM stdin;
\.


--
-- Data for Name: decidim_budgets_orders; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_budgets_orders (id, decidim_user_id, decidim_feature_id, checked_out_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_budgets_projects; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_budgets_projects (id, title, description, budget, decidim_feature_id, decidim_scope_id, created_at, updated_at, reference) FROM stdin;
1	{"ca": "Magni enim quos et possimus similique.", "en": "Qui natus dignissimos consequatur cum et voluptas.", "es": "Dolorum iste."}	{"ca": "<p>Nobis debitis est unde. Ad qui non. Quam soluta eum rerum eum. Non praesentium fugit.</p>", "en": "<p>Esse labore cumque exercitationem optio magni et iste. Eius consequuntur quod id veritatis voluptatem iure tenetur. Nihil doloremque nisi voluptatem. Dolor ab consequuntur debitis in asperiores odit. Laboriosam quasi vel.</p>", "es": "<p>Voluptatem quo recusandae nesciunt aut. Eos sint ipsa amet. Sit aspernatur eveniet asperiores ut in.</p>"}	14878060	5	2	2017-09-13 12:47:33.12163	2017-09-13 12:47:33.152733	Jr.-PROJ-2017-09-1
2	{"ca": "Est et.", "en": "Explicabo ea corrupti assumenda reprehenderit id.", "es": "Pariatur harum sed possimus soluta eum vitae."}	{"ca": "<p>Sed deserunt in repellat consequuntur. Nemo ut voluptas. Quia asperiores dolore. Quasi error officia illum tempora ut dolorem. Facere alias delectus ea.</p>", "en": "<p>Odio dolorem inventore voluptas nostrum et et laboriosam. Perferendis et aut nihil. Et repellendus facilis labore. Eum debitis ab accusamus hic. Ut accusantium saepe sit repellendus autem.</p>", "es": "<p>Perspiciatis praesentium amet fugit. Aut et et consequatur dolorem. Et mollitia eligendi sit ea animi et cumque. Amet mollitia nam.</p>"}	39131994	5	4	2017-09-13 12:47:33.414872	2017-09-13 12:47:33.427993	Jr.-PROJ-2017-09-2
3	{"ca": "Porro cumque.", "en": "Deleniti est et aperiam rerum.", "es": "Animi molestiae necessitatibus."}	{"ca": "<p>Illo itaque tenetur. Et neque consequatur nihil quisquam aliquid. Illo voluptate et et voluptatum occaecati non. Repudiandae omnis eum cupiditate molestias nihil animi.</p>", "en": "<p>Eos ullam sequi. Est rerum est. Vel mollitia voluptates. Sint accusantium necessitatibus sint dolorem repellendus enim. Aut commodi numquam.</p>", "es": "<p>Fugit voluptatibus sed laudantium ut eligendi. Aut dignissimos reiciendis. Iste ea libero aliquam sunt adipisci. Id aut ducimus ipsa repellat aperiam quam. Accusamus omnis minima labore.</p>"}	89579845	5	2	2017-09-13 12:47:33.629291	2017-09-13 12:47:33.640109	Jr.-PROJ-2017-09-3
4	{"ca": "Quis maxime et officia.", "en": "Provident enim suscipit et quis.", "es": "Earum explicabo qui magnam dolores."}	{"ca": "<p>Quam magni sed vel ad ut perspiciatis sed. Possimus odit ut dicta. Nisi repellendus neque nobis et quo animi alias.</p>", "en": "<p>Officia id inventore est consequuntur esse repellat. Consectetur velit quasi autem neque. Exercitationem laudantium nemo totam aliquam.</p>", "es": "<p>Omnis eos quis rerum doloremque accusantium optio doloribus. Atque non molestiae illo facilis quibusdam quis. Eaque quasi eius est quaerat.</p>"}	73732758	11	7	2017-09-13 12:47:50.085598	2017-09-13 12:47:50.10057	Jr.-PROJ-2017-09-4
5	{"ca": "Ut animi reiciendis et dolores est officiis.", "en": "Ex similique nostrum aut.", "es": "Ipsa et nobis delectus sed doloribus debitis."}	{"ca": "<p>Et nihil eius et consequuntur ut. Nisi expedita nihil laborum eum corporis itaque. Dolor qui cum ipsa tempore dolores.</p>", "en": "<p>Et voluptate corporis quis. Nihil aut autem excepturi sint. Minus recusandae ex enim laborum non delectus. Quia aliquam velit aut vitae qui quo. Doloribus iusto nihil.</p>", "es": "<p>Esse quisquam deleniti qui voluptatem a. Sed labore sapiente ut neque est magni est. Molestiae impedit consequatur ea sit sint deserunt.</p>"}	84506059	11	6	2017-09-13 12:47:50.344234	2017-09-13 12:47:50.355309	Jr.-PROJ-2017-09-5
6	{"ca": "Consequatur aperiam debitis quibusdam voluptate autem.", "en": "Dignissimos amet ut.", "es": "Aut autem et."}	{"ca": "<p>Voluptate aut quis totam dignissimos officiis porro. Unde sequi aut. Illo assumenda sed corporis expedita autem veritatis atque. Esse expedita et laborum.</p>", "en": "<p>Et excepturi quasi maiores voluptas perspiciatis ut. Exercitationem non dolorem recusandae quia. Dolor doloribus voluptas. Sed aut ipsam quo.</p>", "es": "<p>Eveniet aut quia tenetur omnis. Culpa accusamus voluptates eos eius qui est. Dolor quo quis neque enim nesciunt. Rerum eos assumenda aut quis consequatur modi.</p>"}	63258064	11	7	2017-09-13 12:47:50.524042	2017-09-13 12:47:50.534949	Jr.-PROJ-2017-09-6
7	{"ca": "Molestias quisquam eum iure aliquid.", "en": "Dignissimos blanditiis.", "es": "Doloribus voluptas natus qui accusantium."}	{"ca": "<p>Minima sed qui qui illum sit ullam labore. Tenetur eligendi fugit ullam. Eaque numquam debitis quas tenetur quis ea.</p>", "en": "<p>Non harum voluptas. Voluptatibus optio quis. Exercitationem totam itaque.</p>", "es": "<p>Libero sint velit. Accusamus tempora dolor voluptatum rem. Illum perspiciatis illo voluptatibus beatae. Placeat eum libero. Et nihil similique possimus velit ducimus.</p>"}	33091295	17	8	2017-09-13 12:48:07.833176	2017-09-13 12:48:07.847818	Jr.-PROJ-2017-09-7
8	{"ca": "Aspernatur tempore consequatur ad delectus molestiae.", "en": "Perferendis tenetur ipsum et enim earum consequuntur.", "es": "Maxime voluptatem magni quod eveniet voluptatem."}	{"ca": "<p>Voluptatem in et cupiditate dolorum ducimus suscipit. Quaerat sit sunt labore atque ducimus nemo. Sequi reprehenderit voluptatum animi nesciunt ut sit quibusdam. Aut sed facere.</p>", "en": "<p>Et eaque assumenda animi rerum neque. Aut nostrum tempora sed. Animi ipsa repellendus fugiat. Pariatur voluptate maiores repellendus ut mollitia. Quo ratione et magnam.</p>", "es": "<p>Dolorem culpa ut aspernatur. Eum harum et pariatur excepturi. Aut rerum saepe beatae quia similique. Eaque rerum dolor veritatis a. Cupiditate dolorum vel ut minus nam.</p>"}	87699716	17	7	2017-09-13 12:48:08.127632	2017-09-13 12:48:08.148203	Jr.-PROJ-2017-09-8
9	{"ca": "Quas veritatis earum amet pariatur et aut.", "en": "Ullam quaerat culpa.", "es": "Et debitis."}	{"ca": "<p>Nihil et aut qui. Sit dolor unde molestias quia nemo hic incidunt. Inventore officiis quia non in. Unde voluptatibus eum fugiat corrupti qui totam.</p>", "en": "<p>Eum est ratione molestiae aut. Consectetur vel culpa. Tempore qui officiis sit eligendi. Explicabo voluptates hic excepturi adipisci. Nihil placeat nisi ducimus saepe corrupti nostrum.</p>", "es": "<p>Eum dolor perferendis mollitia ut. Quasi beatae occaecati harum sed numquam eos autem. Vero velit commodi dolor voluptates animi qui odio. Aut voluptates repellat non sit vel.</p>"}	61599104	17	8	2017-09-13 12:48:08.374508	2017-09-13 12:48:08.390289	Jr.-PROJ-2017-09-9
10	{"ca": "Autem natus.", "en": "Libero culpa.", "es": "Quo sit autem fugit qui."}	{"ca": "<p>Sunt quasi fugit ullam voluptas sunt maiores deserunt. Molestiae reprehenderit enim. Ut quo possimus.</p>", "en": "<p>Ex rerum quia adipisci perferendis autem. Sed voluptatem ut qui. Blanditiis cupiditate occaecati ex ratione laborum odio. Et perspiciatis aut consectetur veritatis quo.</p>", "es": "<p>Tenetur cum aut rerum incidunt. Ipsa quidem impedit sed. Sed sint et tenetur sed ut et.</p>"}	34441999	23	8	2017-09-13 12:48:24.036521	2017-09-13 12:48:24.048924	Jr.-PROJ-2017-09-10
11	{"ca": "Ipsum repellendus similique.", "en": "Non omnis rerum possimus quas.", "es": "Nobis dolor."}	{"ca": "<p>Ea eius sunt. Sint qui nihil. Esse eaque voluptates et. Repellat nesciunt et et dolore.</p>", "en": "<p>Perspiciatis eos animi facilis ipsa vitae. Modi ullam eos ipsum pariatur sed. Et alias ad omnis sequi impedit. Quia autem illo. Dolore nisi totam maxime aut dolores perferendis.</p>", "es": "<p>Ut voluptas dolor. Debitis aut quod dolor alias earum ut. Deserunt tempora sit sed quas molestiae ea. Vitae expedita sed sapiente non tempora nostrum nobis.</p>"}	25267145	23	16	2017-09-13 12:48:24.302469	2017-09-13 12:48:24.313393	Jr.-PROJ-2017-09-11
12	{"ca": "Facere ratione quis numquam optio excepturi animi.", "en": "Quia expedita nulla sed velit.", "es": "Recusandae officia cum et ex."}	{"ca": "<p>Repudiandae in fugit velit voluptate maxime. Autem facilis voluptate laborum. Veniam deleniti accusantium possimus fuga et. Voluptas voluptas qui aut ullam sint ratione. Ipsam et sed quia provident iste.</p>", "en": "<p>Impedit eum reiciendis vel atque. Distinctio sint rerum at in. Ex dolor quos iusto.</p>", "es": "<p>Dolore est esse cumque. Error sed aliquam accusamus ad quasi. Saepe illo quidem et eligendi harum magni atque.</p>"}	57482560	23	11	2017-09-13 12:48:24.502762	2017-09-13 12:48:24.515619	Jr.-PROJ-2017-09-12
13	{"ca": "Maxime nihil aut.", "en": "Et dolorum dolores quam.", "es": "Id corporis aut."}	{"ca": "<p>Ad dolore nisi. Ducimus consequatur dolores placeat eveniet quia. Dolorum doloribus distinctio expedita in nulla.</p>", "en": "<p>Iste enim aut sint itaque excepturi facere eveniet. Fugit voluptatem enim in at beatae debitis. A inventore quis quia. Natus enim aut repellat facere. Quia repudiandae et occaecati ut sapiente.</p>", "es": "<p>Sunt deleniti consequuntur. Deleniti quod dolorem totam. Quod eum nesciunt minima qui.</p>"}	57502402	29	9	2017-09-13 12:48:40.253426	2017-09-13 12:48:40.266143	Jr.-PROJ-2017-09-13
14	{"ca": "Maxime est.", "en": "Est sed fugit repudiandae.", "es": "Ut ut."}	{"ca": "<p>Dolor provident qui ducimus tenetur aut voluptates. Commodi necessitatibus architecto nihil dolor vero voluptas illum. Aliquid at necessitatibus ad aliquam officiis ut deleniti.</p>", "en": "<p>Et reiciendis quaerat voluptatibus blanditiis velit aut. Voluptate rerum ipsum nobis voluptatem. Eum praesentium amet tenetur aut animi.</p>", "es": "<p>In molestiae debitis blanditiis incidunt. Rerum voluptas sunt beatae nihil. Repellat enim est esse fugiat. Velit voluptas modi non sed labore.</p>"}	86448175	29	4	2017-09-13 12:48:40.471484	2017-09-13 12:48:40.48294	Jr.-PROJ-2017-09-14
15	{"ca": "Dolorem non laboriosam.", "en": "Repellendus tempore voluptatibus maxime qui aut.", "es": "Minima in omnis ullam iusto facere."}	{"ca": "<p>Aut recusandae nam earum quas qui. Iure est sunt maxime. Eaque qui neque quasi repudiandae. Explicabo aut distinctio sit saepe laudantium.</p>", "en": "<p>At dolor excepturi magnam a. Accusantium similique cupiditate et nisi voluptatem. Quae amet repellat odio asperiores rerum veritatis delectus. Voluptas sed impedit quasi voluptas rerum.</p>", "es": "<p>Ea alias in quam. Non dolorem dolor voluptate. Ut cupiditate voluptatum delectus qui. Blanditiis ipsum aut natus id veritatis cumque numquam. Accusantium sed quia quisquam voluptatem id.</p>"}	77084949	29	17	2017-09-13 12:48:40.786701	2017-09-13 12:48:40.808073	Jr.-PROJ-2017-09-15
16	{"ca": "Voluptas ut nulla quia voluptate suscipit et.", "en": "Ut ad quasi.", "es": "Dolorem harum est nostrum."}	{"ca": "<p>Atque est eaque eos harum quis velit reprehenderit. Nam perspiciatis rem aut quae aut occaecati velit. Facere aut ut sed itaque sed. Tempora impedit consequuntur repellendus temporibus.</p>", "en": "<p>Possimus maxime et itaque voluptate ut optio ut. In dolor ut. Illum esse neque quasi facilis quia. Ea laudantium quas et est. Tempora assumenda et non.</p>", "es": "<p>Et aliquam quibusdam ea inventore est. Ipsa sint dolores. Eaque assumenda laudantium deserunt amet molestiae consectetur nisi. Laborum pariatur aut accusantium consequatur placeat eligendi eaque.</p>"}	43928747	35	16	2017-09-13 12:48:55.881354	2017-09-13 12:48:55.892735	Jr.-PROJ-2017-09-16
17	{"ca": "Nihil harum vel et occaecati.", "en": "Nisi officiis impedit sunt cum aperiam.", "es": "Quos voluptas et illum."}	{"ca": "<p>Nam hic voluptatem repudiandae ad quam similique culpa. Quis voluptatem asperiores corrupti suscipit eveniet quis. Quos amet ut rem accusantium facere.</p>", "en": "<p>Architecto nemo doloribus tempora quod voluptas voluptatem. Ducimus ut enim. Aut nihil excepturi id vitae doloremque repellendus voluptatem.</p>", "es": "<p>Sed aspernatur eaque cumque. Consequatur inventore quasi repellat. Nulla rem molestiae nostrum.</p>"}	18911286	35	13	2017-09-13 12:48:56.056984	2017-09-13 12:48:56.067894	Jr.-PROJ-2017-09-17
18	{"ca": "Nostrum laborum aut tempora.", "en": "Quia ab enim.", "es": "Blanditiis voluptas deleniti necessitatibus."}	{"ca": "<p>Et deserunt dignissimos a eum officia modi. Et nostrum delectus. Dolorem et ea.</p>", "en": "<p>Vitae aliquid aut impedit deleniti voluptate doloremque ipsum. Placeat aut sequi. Sit ex explicabo neque expedita accusantium. Molestiae iste aut vero exercitationem.</p>", "es": "<p>Rerum earum consequatur consequatur. Rerum porro et eos sapiente. Sapiente assumenda quis eum qui dignissimos consequuntur nam.</p>"}	62259281	35	14	2017-09-13 12:48:56.22194	2017-09-13 12:48:56.232712	Jr.-PROJ-2017-09-18
\.


--
-- Data for Name: decidim_categories; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_categories (id, name, description, parent_id, decidim_participatory_space_id, decidim_participatory_space_type) FROM stdin;
1	{"ca": "Voluptatem quia id accusamus officiis.", "en": "Non aspernatur vel facere minima deleniti quasi quae.", "es": "Quasi temporibus vel dolorem quia."}	{"ca": "<p>Reprehenderit autem similique. Assumenda omnis impedit. Ea consequatur nemo est assumenda quia officiis.</p>", "en": "<p>Ipsum modi quia. Laboriosam dolor at. Ab quam aut sed dicta impedit aut sunt. Sit vel hic eum omnis.</p>", "es": "<p>Unde nihil qui repellat adipisci in. Quis voluptatem voluptatem consequatur repellat. Molestiae in dolore et. Laboriosam cupiditate doloribus omnis tempore nisi. Quam cumque ex.</p>"}	\N	1	Decidim::ParticipatoryProcess
2	{"ca": "Est consequatur provident est dicta mollitia consequuntur quo possimus.", "en": "Et provident numquam labore ea ducimus autem officia perspiciatis inventore.", "es": "Reiciendis quod dolore provident sed labore ipsa iste."}	{"ca": "<p>Eius ex fuga corporis aperiam. Saepe eligendi hic dolore dolorem. Eligendi omnis expedita sunt sed. Quas ea laborum labore aperiam voluptatem hic eveniet.</p>", "en": "<p>Est sequi dolorem beatae ipsa qui excepturi itaque. Rerum eos at voluptatem consequatur nihil quaerat rerum. Vero et mollitia odit possimus maiores.</p>", "es": "<p>Sed aliquam culpa. Blanditiis veniam suscipit ut illum corporis culpa. In consequatur qui. Ducimus et quis fugiat vel dolorum et. Cumque et mollitia dicta officia illo omnis.</p>"}	\N	1	Decidim::ParticipatoryProcess
3	{"ca": "Perspiciatis quidem sapiente ab quod sed unde.", "en": "Non suscipit non facere dolores.", "es": "Sit consequuntur dicta est nobis et neque."}	{"ca": "<p>Explicabo rerum nihil quia temporibus illum. Reprehenderit blanditiis natus. Nostrum reprehenderit cupiditate sed molestias veritatis nesciunt. Placeat repellendus corporis et.</p>", "en": "<p>Molestiae placeat ut. Voluptate sit magni. Fugit est voluptas at eos eius officiis enim.</p>", "es": "<p>Blanditiis et dolores reiciendis ratione est id pariatur. Voluptas maiores id voluptates corporis porro eum. Vel aut facere et ducimus similique. Ex ipsam sapiente et.</p>"}	\N	2	Decidim::ParticipatoryProcess
4	{"ca": "Ipsum quia alias et placeat nulla qui voluptate modi.", "en": "Necessitatibus atque nemo maxime iste perferendis laudantium blanditiis.", "es": "Doloremque repellendus esse sint et enim ipsam mollitia nihil alias."}	{"ca": "<p>Vel voluptatibus et. Cupiditate et reiciendis quia voluptas dicta quis vitae. Molestiae aut rem ipsa. Accusantium tenetur ea fugit laboriosam aliquam.</p>", "en": "<p>Nam et quos voluptates et at sit quod. Molestias ex cum delectus eum modi ullam enim. Esse dolores optio. Est ipsum quo.</p>", "es": "<p>Nihil quia nesciunt aut in alias eos. Et officia id ipsam aut. Modi sit vel nemo. Qui repellat sit laborum.</p>"}	\N	2	Decidim::ParticipatoryProcess
5	{"ca": "Eum quod qui inventore a doloremque.", "en": "Et quam libero provident aperiam velit ea temporibus enim.", "es": "Numquam quia et velit nihil a."}	{"ca": "<p>Similique ipsam earum pariatur sit quas unde veritatis. Laboriosam consequatur rerum adipisci sunt perspiciatis. In molestias ut.</p>", "en": "<p>Qui rerum et at sint dolorum qui. Quam ex nostrum vel minima placeat quasi. Qui tempora nostrum expedita ut voluptatem voluptatum adipisci. A ipsum qui dolores unde.</p>", "es": "<p>Quo mollitia alias. Qui quos est consequatur accusamus libero omnis temporibus. Soluta cupiditate numquam.</p>"}	\N	3	Decidim::ParticipatoryProcess
6	{"ca": "Blanditiis vel eligendi quis aliquid repellat rerum.", "en": "Alias est eaque tempora aliquid praesentium et.", "es": "Ea tempora sunt similique error sit quis."}	{"ca": "<p>Amet reprehenderit et possimus eaque commodi nulla. Est nobis quo voluptas et. Et maxime facere nulla dolore sequi ea.</p>", "en": "<p>Voluptatem laboriosam itaque doloribus soluta nulla molestiae. Maiores commodi qui rerum ipsa quia quidem. Dolorem et placeat. Minus beatae reprehenderit dignissimos. Hic doloremque rerum.</p>", "es": "<p>Vero perspiciatis aut. Alias blanditiis mollitia est eaque temporibus. Et odio quas.</p>"}	\N	3	Decidim::ParticipatoryProcess
7	{"ca": "Quas ut reiciendis aut provident blanditiis.", "en": "Rerum error odio qui maxime minus est recusandae velit voluptatem.", "es": "Omnis facilis ea aut id nam ad aut similique."}	{"ca": "<p>Odio vero ducimus. Enim deserunt voluptas aliquam qui cum ex facilis. Est rerum sequi aut labore aperiam rerum.</p>", "en": "<p>Qui aliquid eligendi adipisci quibusdam. Perferendis natus eos error earum. At ut id asperiores ea itaque repellendus delectus. Quo et dolor sint labore. Sit ipsam dolores nobis ea et blanditiis.</p>", "es": "<p>Placeat sit sint dolores repudiandae quos sit deleniti. Ipsum maiores rerum. Inventore blanditiis neque sed omnis. Amet praesentium incidunt. Dolor quia error atque.</p>"}	\N	1	Decidim::Assembly
8	{"ca": "Sit veritatis architecto quia occaecati vel adipisci aliquam.", "en": "Voluptas voluptate consequuntur eius sed non quasi et beatae.", "es": "Repudiandae necessitatibus aspernatur tenetur quis aliquam ex voluptatem voluptatem quas."}	{"ca": "<p>Minima cum quis occaecati sint rem doloribus provident. Ut impedit natus reiciendis cumque soluta. Architecto ut iure voluptatem. Alias vel quasi voluptatem amet quia.</p>", "en": "<p>Possimus expedita et. Optio nostrum maiores eum officiis distinctio. Omnis tempora aspernatur dignissimos quis id.</p>", "es": "<p>Ducimus quia et. Autem hic culpa natus dolorem architecto. Mollitia corrupti harum blanditiis qui voluptate molestiae. Suscipit sequi expedita est et dolorum. Nemo aut rerum esse.</p>"}	\N	1	Decidim::Assembly
9	{"ca": "Corrupti optio doloremque ipsam maiores et rerum soluta voluptatem repellendus.", "en": "Soluta voluptatum dolores ut ab minima consequuntur.", "es": "Nam dicta fugiat numquam enim voluptatum ipsum similique reiciendis odit."}	{"ca": "<p>Facilis repellat eos explicabo nihil et voluptatem dolor. Et sit accusamus. Quis aliquid sed nesciunt corporis dolorem dolorem.</p>", "en": "<p>In est ut dolorem facilis ipsum eum ab. Nam cum accusamus. Tempore veniam eligendi repellendus nam. Aspernatur odio laborum qui corporis explicabo.</p>", "es": "<p>Sit provident voluptatum. Doloremque nisi non reprehenderit quia molestias dolores molestiae. Fuga non quos delectus fugiat.</p>"}	\N	2	Decidim::Assembly
10	{"ca": "Qui sit quisquam voluptatem rerum veniam eos odio quam et.", "en": "Quia repellendus non quisquam enim.", "es": "Incidunt nulla id eum ut ut velit explicabo rerum aut."}	{"ca": "<p>Ea quaerat at ea. Explicabo a id quo aut. Quos a eligendi repellat nihil ut qui unde. Sequi voluptatum impedit natus sint ab. Quis voluptates nulla et reiciendis.</p>", "en": "<p>Ea tempora molestias est deserunt voluptatum a vero. Et quisquam ut. Eligendi eos sequi et aut unde atque.</p>", "es": "<p>Dolorem et quod explicabo error aut exercitationem aliquam. Debitis laudantium temporibus asperiores vel. Laudantium voluptate et. Nulla saepe reprehenderit mollitia qui velit quia voluptate.</p>"}	\N	2	Decidim::Assembly
11	{"ca": "Reiciendis voluptatem debitis voluptas dignissimos et aspernatur quia.", "en": "Fugiat ipsum eum cumque quia qui blanditiis quis.", "es": "Animi vero ea sed velit expedita."}	{"ca": "<p>Et dolor laborum eos omnis quasi. Adipisci facilis consequatur aliquam velit itaque impedit. Hic labore non itaque impedit. Quia veniam necessitatibus sint ipsam sapiente.</p>", "en": "<p>Alias quibusdam vel sit ex. Est dolorem soluta veritatis iste quisquam ut eius. Voluptatem ullam est nostrum labore velit. Perferendis libero corrupti assumenda. Dolorem numquam omnis quia quo.</p>", "es": "<p>Optio reiciendis a quia voluptas. Sequi numquam pariatur voluptates id earum et ut. Magnam aut explicabo qui incidunt. Asperiores necessitatibus magnam nesciunt voluptatem dolores officia.</p>"}	\N	3	Decidim::Assembly
12	{"ca": "Quia consectetur ut eius in est.", "en": "Eius eos sed quaerat natus reiciendis exercitationem.", "es": "Et soluta dolor illo sed itaque autem quia et occaecati."}	{"ca": "<p>Inventore quas sit itaque reprehenderit nulla molestias excepturi. Consectetur nulla natus labore ratione quaerat vero. Odit in veniam eum sed.</p>", "en": "<p>Cumque expedita blanditiis et ab esse officiis. Beatae et id explicabo deserunt est vel delectus. Labore cum consequatur harum non hic accusantium. Officiis aperiam sapiente reiciendis.</p>", "es": "<p>Consequatur aperiam repudiandae aut. Voluptatem sunt aut eius sunt ad a ipsa. Est fugit sed expedita sunt omnis exercitationem. Aspernatur ullam voluptatibus harum hic consectetur.</p>"}	\N	3	Decidim::Assembly
13	{"fr": "Economie"}	{"fr": "<p>Economie</p>"}	\N	4	Decidim::ParticipatoryProcess
14	{"fr": "Environnement"}	{"fr": "<p>Environnement</p>"}	\N	4	Decidim::ParticipatoryProcess
15	{"fr": "Urbanisme"}	{"fr": "<p>Urbanisme</p>"}	\N	4	Decidim::ParticipatoryProcess
16	{"fr": "Education"}	{"fr": "<p>Education</p>"}	\N	4	Decidim::ParticipatoryProcess
17	{"fr": "Education"}	{"fr": "<p>Education</p>"}	\N	5	Decidim::ParticipatoryProcess
18	{"fr": "Urbanisme"}	{"fr": "<p>Urbanisme</p>"}	\N	5	Decidim::ParticipatoryProcess
19	{"fr": "Environnement"}	{"fr": "<p>Environnement</p>"}	\N	5	Decidim::ParticipatoryProcess
20	{"fr": "Economie"}	{"fr": "<p>Economie mise à jour test</p>"}	\N	5	Decidim::ParticipatoryProcess
21	{"fr": "Economie"}	{"fr": "<p>Impacts économiques du projet</p>"}	\N	6	Decidim::ParticipatoryProcess
22	{"fr": "Impacts locaux"}	{"fr": "<p>Impacts locaux du projet</p>"}	\N	6	Decidim::ParticipatoryProcess
24	{"fr": "Environnement"}	{"fr": "<p>Impacts environnementaux du projet</p>"}	\N	6	Decidim::ParticipatoryProcess
23	{"fr": "Aménagement du territoire"}	{"fr": "<p>Enjeux liés au territoire</p>"}	\N	6	Decidim::ParticipatoryProcess
25	{"fr": "Emploi"}	{"fr": "<p>Enjeux liés à l'emploi</p>"}	\N	6	Decidim::ParticipatoryProcess
26	{"fr": "Formation"}	{"fr": "<p>Enjeux liés à la formation</p>"}	\N	6	Decidim::ParticipatoryProcess
28	{"fr": "Industrie"}	{"fr": "<p>Enjeux liés à l'industrie</p>"}	\N	6	Decidim::ParticipatoryProcess
30	{"fr": "Coûts et financement"}	{"fr": "<p>Impacts liés aux coûts</p>"}	\N	6	Decidim::ParticipatoryProcess
31	{"fr": "Autres"}	{"fr": "<p>Autres sujets</p>"}	\N	6	Decidim::ParticipatoryProcess
27	{"fr": "Transport maritime"}	{"fr": "<p>Enjeux liés au transport maritime</p>"}	\N	6	Decidim::ParticipatoryProcess
32	{"fr": "Conditions de travail"}	{"fr": "<p>Enjeux liés aux conditions de travail</p>"}	\N	6	Decidim::ParticipatoryProcess
33	{"fr": "Organisation du débat"}	{"fr": "<p>Enjeux liés à l'organisation du débat public</p>"}	\N	6	Decidim::ParticipatoryProcess
34	{"fr": "Accès à la mer"}	{"fr": "<p>Enjeux liés aux problèmes d'accès à la mer</p>"}	\N	6	Decidim::ParticipatoryProcess
35	{"fr": "Filière conteneur"}	{"fr": "<p>Enjeux liés à la filière conteneur</p>"}	\N	6	Decidim::ParticipatoryProcess
36	{"fr": "Connexions intermodales"}	{"fr": "<p>Enjeux liés aux intermodalités</p>"}	\N	6	Decidim::ParticipatoryProcess
29	{"fr": "Gouvernance du projet"}	{"fr": "<p>Impacts liés à la gouvernance</p>"}	\N	6	Decidim::ParticipatoryProcess
37	{"fr": "Atlantique ou Baltique"}	{"fr": "<p>choix entre Atlantique ou Baltique</p>"}	\N	6	Decidim::ParticipatoryProcess
38	{"fr": "Stratégie portuaire"}	{"fr": "<p>stratégie portuaire</p>"}	\N	6	Decidim::ParticipatoryProcess
39	{"fr": "Réunion publique"}	{"fr": "<p>bla bla</p>"}	\N	4	Decidim::Assembly
40	{"fr": "Atelier"}	{"fr": "<p>bla bla bla</p>"}	\N	4	Decidim::Assembly
41	{"fr": "Transport"}	{"fr": "<p>Test de la fonctionnalité catégorie </p>"}	\N	7	Decidim::ParticipatoryProcess
42	{"fr": "Energie"}	{"fr": "<p>Test</p>"}	\N	7	Decidim::ParticipatoryProcess
\.


--
-- Data for Name: decidim_categorizations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_categorizations (id, decidim_category_id, categorizable_type, categorizable_id, created_at, updated_at) FROM stdin;
1	1	Decidim::Meetings::Meeting	1	2017-09-13 12:47:18.786525	2017-09-13 12:47:18.786525
2	1	Decidim::Meetings::Meeting	2	2017-09-13 12:47:21.166403	2017-09-13 12:47:21.166403
3	2	Decidim::Meetings::Meeting	3	2017-09-13 12:47:23.422381	2017-09-13 12:47:23.422381
4	1	Decidim::Proposals::Proposal	1	2017-09-13 12:47:25.819851	2017-09-13 12:47:25.819851
5	2	Decidim::Proposals::Proposal	2	2017-09-13 12:47:26.157643	2017-09-13 12:47:26.157643
6	1	Decidim::Proposals::Proposal	3	2017-09-13 12:47:26.677429	2017-09-13 12:47:26.677429
7	2	Decidim::Proposals::Proposal	4	2017-09-13 12:47:27.180256	2017-09-13 12:47:27.180256
8	1	Decidim::Proposals::Proposal	5	2017-09-13 12:47:27.749342	2017-09-13 12:47:27.749342
9	2	Decidim::Proposals::Proposal	6	2017-09-13 12:47:28.118519	2017-09-13 12:47:28.118519
10	1	Decidim::Proposals::Proposal	7	2017-09-13 12:47:28.47428	2017-09-13 12:47:28.47428
11	1	Decidim::Proposals::Proposal	8	2017-09-13 12:47:29.086665	2017-09-13 12:47:29.086665
12	1	Decidim::Proposals::Proposal	9	2017-09-13 12:47:29.423803	2017-09-13 12:47:29.423803
13	2	Decidim::Proposals::Proposal	10	2017-09-13 12:47:29.972176	2017-09-13 12:47:29.972176
14	1	Decidim::Proposals::Proposal	11	2017-09-13 12:47:30.263085	2017-09-13 12:47:30.263085
15	1	Decidim::Proposals::Proposal	12	2017-09-13 12:47:30.573289	2017-09-13 12:47:30.573289
16	1	Decidim::Proposals::Proposal	13	2017-09-13 12:47:30.616831	2017-09-13 12:47:30.616831
17	2	Decidim::Proposals::Proposal	14	2017-09-13 12:47:30.65668	2017-09-13 12:47:30.65668
18	1	Decidim::Proposals::Proposal	15	2017-09-13 12:47:30.976112	2017-09-13 12:47:30.976112
19	2	Decidim::Proposals::Proposal	16	2017-09-13 12:47:31.535475	2017-09-13 12:47:31.535475
20	1	Decidim::Proposals::Proposal	17	2017-09-13 12:47:32.013436	2017-09-13 12:47:32.013436
21	2	Decidim::Proposals::Proposal	18	2017-09-13 12:47:32.066098	2017-09-13 12:47:32.066098
22	1	Decidim::Proposals::Proposal	19	2017-09-13 12:47:32.136117	2017-09-13 12:47:32.136117
23	1	Decidim::Proposals::Proposal	20	2017-09-13 12:47:32.453978	2017-09-13 12:47:32.453978
27	2	Decidim::Budgets::Project	1	2017-09-13 12:47:33.145295	2017-09-13 12:47:33.145295
28	1	Decidim::Budgets::Project	2	2017-09-13 12:47:33.419787	2017-09-13 12:47:33.419787
29	2	Decidim::Budgets::Project	3	2017-09-13 12:47:33.633842	2017-09-13 12:47:33.633842
30	3	Decidim::Meetings::Meeting	4	2017-09-13 12:47:34.960561	2017-09-13 12:47:34.960561
31	3	Decidim::Meetings::Meeting	5	2017-09-13 12:47:37.337817	2017-09-13 12:47:37.337817
32	4	Decidim::Meetings::Meeting	6	2017-09-13 12:47:39.748947	2017-09-13 12:47:39.748947
33	3	Decidim::Proposals::Proposal	21	2017-09-13 12:47:42.21749	2017-09-13 12:47:42.21749
34	4	Decidim::Proposals::Proposal	22	2017-09-13 12:47:42.32619	2017-09-13 12:47:42.32619
35	4	Decidim::Proposals::Proposal	23	2017-09-13 12:47:42.439816	2017-09-13 12:47:42.439816
36	3	Decidim::Proposals::Proposal	24	2017-09-13 12:47:42.947106	2017-09-13 12:47:42.947106
37	4	Decidim::Proposals::Proposal	25	2017-09-13 12:47:43.470117	2017-09-13 12:47:43.470117
38	3	Decidim::Proposals::Proposal	26	2017-09-13 12:47:43.975099	2017-09-13 12:47:43.975099
39	4	Decidim::Proposals::Proposal	27	2017-09-13 12:47:44.504045	2017-09-13 12:47:44.504045
40	3	Decidim::Proposals::Proposal	28	2017-09-13 12:47:45.063273	2017-09-13 12:47:45.063273
41	3	Decidim::Proposals::Proposal	29	2017-09-13 12:47:45.411295	2017-09-13 12:47:45.411295
42	4	Decidim::Proposals::Proposal	30	2017-09-13 12:47:45.485427	2017-09-13 12:47:45.485427
43	3	Decidim::Proposals::Proposal	31	2017-09-13 12:47:45.965367	2017-09-13 12:47:45.965367
44	4	Decidim::Proposals::Proposal	32	2017-09-13 12:47:46.3591	2017-09-13 12:47:46.3591
45	3	Decidim::Proposals::Proposal	33	2017-09-13 12:47:46.439235	2017-09-13 12:47:46.439235
46	3	Decidim::Proposals::Proposal	34	2017-09-13 12:47:47.071878	2017-09-13 12:47:47.071878
47	3	Decidim::Proposals::Proposal	35	2017-09-13 12:47:47.610259	2017-09-13 12:47:47.610259
48	4	Decidim::Proposals::Proposal	36	2017-09-13 12:47:47.921523	2017-09-13 12:47:47.921523
49	3	Decidim::Proposals::Proposal	37	2017-09-13 12:47:48.41577	2017-09-13 12:47:48.41577
50	4	Decidim::Proposals::Proposal	38	2017-09-13 12:47:48.748205	2017-09-13 12:47:48.748205
51	4	Decidim::Proposals::Proposal	39	2017-09-13 12:47:49.065705	2017-09-13 12:47:49.065705
52	4	Decidim::Proposals::Proposal	40	2017-09-13 12:47:49.42993	2017-09-13 12:47:49.42993
56	3	Decidim::Budgets::Project	4	2017-09-13 12:47:50.091255	2017-09-13 12:47:50.091255
57	4	Decidim::Budgets::Project	5	2017-09-13 12:47:50.348927	2017-09-13 12:47:50.348927
58	4	Decidim::Budgets::Project	6	2017-09-13 12:47:50.528481	2017-09-13 12:47:50.528481
59	6	Decidim::Meetings::Meeting	7	2017-09-13 12:47:51.604589	2017-09-13 12:47:51.604589
60	5	Decidim::Meetings::Meeting	8	2017-09-13 12:47:53.895843	2017-09-13 12:47:53.895843
61	5	Decidim::Meetings::Meeting	9	2017-09-13 12:47:56.233815	2017-09-13 12:47:56.233815
62	6	Decidim::Proposals::Proposal	41	2017-09-13 12:47:58.731339	2017-09-13 12:47:58.731339
63	5	Decidim::Proposals::Proposal	42	2017-09-13 12:47:59.257412	2017-09-13 12:47:59.257412
64	6	Decidim::Proposals::Proposal	43	2017-09-13 12:47:59.639096	2017-09-13 12:47:59.639096
65	5	Decidim::Proposals::Proposal	44	2017-09-13 12:47:59.763487	2017-09-13 12:47:59.763487
66	5	Decidim::Proposals::Proposal	45	2017-09-13 12:48:00.107409	2017-09-13 12:48:00.107409
67	5	Decidim::Proposals::Proposal	46	2017-09-13 12:48:00.690604	2017-09-13 12:48:00.690604
68	5	Decidim::Proposals::Proposal	47	2017-09-13 12:48:01.044347	2017-09-13 12:48:01.044347
69	5	Decidim::Proposals::Proposal	48	2017-09-13 12:48:01.368457	2017-09-13 12:48:01.368457
70	6	Decidim::Proposals::Proposal	49	2017-09-13 12:48:01.523012	2017-09-13 12:48:01.523012
71	5	Decidim::Proposals::Proposal	50	2017-09-13 12:48:01.981124	2017-09-13 12:48:01.981124
72	6	Decidim::Proposals::Proposal	51	2017-09-13 12:48:02.604533	2017-09-13 12:48:02.604533
73	5	Decidim::Proposals::Proposal	52	2017-09-13 12:48:03.213187	2017-09-13 12:48:03.213187
74	5	Decidim::Proposals::Proposal	53	2017-09-13 12:48:03.54826	2017-09-13 12:48:03.54826
75	5	Decidim::Proposals::Proposal	54	2017-09-13 12:48:04.102539	2017-09-13 12:48:04.102539
76	6	Decidim::Proposals::Proposal	55	2017-09-13 12:48:04.74903	2017-09-13 12:48:04.74903
77	6	Decidim::Proposals::Proposal	56	2017-09-13 12:48:05.432106	2017-09-13 12:48:05.432106
78	6	Decidim::Proposals::Proposal	57	2017-09-13 12:48:05.926856	2017-09-13 12:48:05.926856
79	5	Decidim::Proposals::Proposal	58	2017-09-13 12:48:06.387309	2017-09-13 12:48:06.387309
80	5	Decidim::Proposals::Proposal	59	2017-09-13 12:48:06.524034	2017-09-13 12:48:06.524034
81	6	Decidim::Proposals::Proposal	60	2017-09-13 12:48:06.849406	2017-09-13 12:48:06.849406
85	5	Decidim::Budgets::Project	7	2017-09-13 12:48:07.838016	2017-09-13 12:48:07.838016
86	6	Decidim::Budgets::Project	8	2017-09-13 12:48:08.13615	2017-09-13 12:48:08.13615
87	5	Decidim::Budgets::Project	9	2017-09-13 12:48:08.379708	2017-09-13 12:48:08.379708
88	8	Decidim::Meetings::Meeting	10	2017-09-13 12:48:09.850978	2017-09-13 12:48:09.850978
89	8	Decidim::Meetings::Meeting	11	2017-09-13 12:48:12.450881	2017-09-13 12:48:12.450881
90	8	Decidim::Meetings::Meeting	12	2017-09-13 12:48:14.85251	2017-09-13 12:48:14.85251
91	8	Decidim::Proposals::Proposal	61	2017-09-13 12:48:17.134322	2017-09-13 12:48:17.134322
92	8	Decidim::Proposals::Proposal	62	2017-09-13 12:48:17.755405	2017-09-13 12:48:17.755405
93	7	Decidim::Proposals::Proposal	63	2017-09-13 12:48:17.829426	2017-09-13 12:48:17.829426
94	7	Decidim::Proposals::Proposal	64	2017-09-13 12:48:18.161995	2017-09-13 12:48:18.161995
95	7	Decidim::Proposals::Proposal	65	2017-09-13 12:48:18.629422	2017-09-13 12:48:18.629422
96	8	Decidim::Proposals::Proposal	66	2017-09-13 12:48:18.706446	2017-09-13 12:48:18.706446
97	7	Decidim::Proposals::Proposal	67	2017-09-13 12:48:18.991538	2017-09-13 12:48:18.991538
98	7	Decidim::Proposals::Proposal	68	2017-09-13 12:48:19.331245	2017-09-13 12:48:19.331245
99	8	Decidim::Proposals::Proposal	69	2017-09-13 12:48:19.390597	2017-09-13 12:48:19.390597
100	7	Decidim::Proposals::Proposal	70	2017-09-13 12:48:19.699719	2017-09-13 12:48:19.699719
101	8	Decidim::Proposals::Proposal	71	2017-09-13 12:48:20.029155	2017-09-13 12:48:20.029155
102	8	Decidim::Proposals::Proposal	72	2017-09-13 12:48:20.53454	2017-09-13 12:48:20.53454
103	8	Decidim::Proposals::Proposal	73	2017-09-13 12:48:20.892265	2017-09-13 12:48:20.892265
104	8	Decidim::Proposals::Proposal	74	2017-09-13 12:48:21.220021	2017-09-13 12:48:21.220021
105	8	Decidim::Proposals::Proposal	75	2017-09-13 12:48:21.73705	2017-09-13 12:48:21.73705
106	7	Decidim::Proposals::Proposal	76	2017-09-13 12:48:22.084542	2017-09-13 12:48:22.084542
107	7	Decidim::Proposals::Proposal	77	2017-09-13 12:48:22.388463	2017-09-13 12:48:22.388463
108	7	Decidim::Proposals::Proposal	78	2017-09-13 12:48:22.996072	2017-09-13 12:48:22.996072
109	7	Decidim::Proposals::Proposal	79	2017-09-13 12:48:23.419477	2017-09-13 12:48:23.419477
110	7	Decidim::Proposals::Proposal	80	2017-09-13 12:48:23.525115	2017-09-13 12:48:23.525115
114	8	Decidim::Budgets::Project	10	2017-09-13 12:48:24.041598	2017-09-13 12:48:24.041598
115	7	Decidim::Budgets::Project	11	2017-09-13 12:48:24.30689	2017-09-13 12:48:24.30689
116	8	Decidim::Budgets::Project	12	2017-09-13 12:48:24.508032	2017-09-13 12:48:24.508032
117	9	Decidim::Meetings::Meeting	13	2017-09-13 12:48:25.013017	2017-09-13 12:48:25.013017
118	10	Decidim::Meetings::Meeting	14	2017-09-13 12:48:27.423001	2017-09-13 12:48:27.423001
119	9	Decidim::Meetings::Meeting	15	2017-09-13 12:48:29.744242	2017-09-13 12:48:29.744242
120	9	Decidim::Proposals::Proposal	81	2017-09-13 12:48:32.071045	2017-09-13 12:48:32.071045
121	9	Decidim::Proposals::Proposal	82	2017-09-13 12:48:32.452393	2017-09-13 12:48:32.452393
122	10	Decidim::Proposals::Proposal	83	2017-09-13 12:48:32.760161	2017-09-13 12:48:32.760161
123	10	Decidim::Proposals::Proposal	84	2017-09-13 12:48:33.135272	2017-09-13 12:48:33.135272
124	10	Decidim::Proposals::Proposal	85	2017-09-13 12:48:33.490342	2017-09-13 12:48:33.490342
125	9	Decidim::Proposals::Proposal	86	2017-09-13 12:48:33.841621	2017-09-13 12:48:33.841621
126	10	Decidim::Proposals::Proposal	87	2017-09-13 12:48:34.034982	2017-09-13 12:48:34.034982
127	10	Decidim::Proposals::Proposal	88	2017-09-13 12:48:34.196031	2017-09-13 12:48:34.196031
128	9	Decidim::Proposals::Proposal	89	2017-09-13 12:48:34.769037	2017-09-13 12:48:34.769037
129	9	Decidim::Proposals::Proposal	90	2017-09-13 12:48:35.371589	2017-09-13 12:48:35.371589
130	9	Decidim::Proposals::Proposal	91	2017-09-13 12:48:35.948904	2017-09-13 12:48:35.948904
131	10	Decidim::Proposals::Proposal	92	2017-09-13 12:48:36.531833	2017-09-13 12:48:36.531833
132	9	Decidim::Proposals::Proposal	93	2017-09-13 12:48:36.61718	2017-09-13 12:48:36.61718
133	10	Decidim::Proposals::Proposal	94	2017-09-13 12:48:37.10702	2017-09-13 12:48:37.10702
134	9	Decidim::Proposals::Proposal	95	2017-09-13 12:48:37.715073	2017-09-13 12:48:37.715073
135	10	Decidim::Proposals::Proposal	96	2017-09-13 12:48:38.230647	2017-09-13 12:48:38.230647
136	10	Decidim::Proposals::Proposal	97	2017-09-13 12:48:38.300613	2017-09-13 12:48:38.300613
137	10	Decidim::Proposals::Proposal	98	2017-09-13 12:48:38.390602	2017-09-13 12:48:38.390602
138	9	Decidim::Proposals::Proposal	99	2017-09-13 12:48:38.770994	2017-09-13 12:48:38.770994
139	10	Decidim::Proposals::Proposal	100	2017-09-13 12:48:39.424839	2017-09-13 12:48:39.424839
143	9	Decidim::Budgets::Project	13	2017-09-13 12:48:40.258972	2017-09-13 12:48:40.258972
144	9	Decidim::Budgets::Project	14	2017-09-13 12:48:40.476179	2017-09-13 12:48:40.476179
145	10	Decidim::Budgets::Project	15	2017-09-13 12:48:40.800096	2017-09-13 12:48:40.800096
146	11	Decidim::Meetings::Meeting	16	2017-09-13 12:48:41.314048	2017-09-13 12:48:41.314048
147	11	Decidim::Meetings::Meeting	17	2017-09-13 12:48:43.596793	2017-09-13 12:48:43.596793
148	11	Decidim::Meetings::Meeting	18	2017-09-13 12:48:45.87351	2017-09-13 12:48:45.87351
149	12	Decidim::Proposals::Proposal	101	2017-09-13 12:48:48.201668	2017-09-13 12:48:48.201668
150	12	Decidim::Proposals::Proposal	102	2017-09-13 12:48:48.267657	2017-09-13 12:48:48.267657
151	11	Decidim::Proposals::Proposal	103	2017-09-13 12:48:48.573896	2017-09-13 12:48:48.573896
152	11	Decidim::Proposals::Proposal	104	2017-09-13 12:48:49.188468	2017-09-13 12:48:49.188468
153	12	Decidim::Proposals::Proposal	105	2017-09-13 12:48:49.571363	2017-09-13 12:48:49.571363
154	12	Decidim::Proposals::Proposal	106	2017-09-13 12:48:49.984521	2017-09-13 12:48:49.984521
155	12	Decidim::Proposals::Proposal	107	2017-09-13 12:48:50.122663	2017-09-13 12:48:50.122663
156	11	Decidim::Proposals::Proposal	108	2017-09-13 12:48:50.74046	2017-09-13 12:48:50.74046
157	12	Decidim::Proposals::Proposal	109	2017-09-13 12:48:51.072185	2017-09-13 12:48:51.072185
158	12	Decidim::Proposals::Proposal	110	2017-09-13 12:48:51.393808	2017-09-13 12:48:51.393808
159	11	Decidim::Proposals::Proposal	111	2017-09-13 12:48:51.564369	2017-09-13 12:48:51.564369
160	11	Decidim::Proposals::Proposal	112	2017-09-13 12:48:51.766611	2017-09-13 12:48:51.766611
161	11	Decidim::Proposals::Proposal	113	2017-09-13 12:48:51.943685	2017-09-13 12:48:51.943685
162	11	Decidim::Proposals::Proposal	114	2017-09-13 12:48:52.228081	2017-09-13 12:48:52.228081
163	12	Decidim::Proposals::Proposal	115	2017-09-13 12:48:52.794771	2017-09-13 12:48:52.794771
164	12	Decidim::Proposals::Proposal	116	2017-09-13 12:48:53.162398	2017-09-13 12:48:53.162398
165	12	Decidim::Proposals::Proposal	117	2017-09-13 12:48:53.705432	2017-09-13 12:48:53.705432
166	12	Decidim::Proposals::Proposal	118	2017-09-13 12:48:54.214607	2017-09-13 12:48:54.214607
167	11	Decidim::Proposals::Proposal	119	2017-09-13 12:48:54.747085	2017-09-13 12:48:54.747085
168	12	Decidim::Proposals::Proposal	120	2017-09-13 12:48:55.069508	2017-09-13 12:48:55.069508
172	11	Decidim::Budgets::Project	16	2017-09-13 12:48:55.886134	2017-09-13 12:48:55.886134
173	12	Decidim::Budgets::Project	17	2017-09-13 12:48:56.061209	2017-09-13 12:48:56.061209
174	11	Decidim::Budgets::Project	18	2017-09-13 12:48:56.226489	2017-09-13 12:48:56.226489
175	13	Decidim::Proposals::Proposal	121	2017-09-13 16:36:36.074152	2017-09-13 16:36:36.074152
176	13	Decidim::Meetings::Meeting	19	2017-09-13 16:46:05.662317	2017-09-13 16:46:05.662317
177	13	Decidim::Proposals::Proposal	122	2017-09-13 16:53:12.271126	2017-09-13 16:53:12.271126
178	14	Decidim::Proposals::Proposal	123	2017-09-13 17:00:48.30291	2017-09-13 17:00:48.30291
179	16	Decidim::Proposals::Proposal	124	2017-09-13 17:10:54.625988	2017-09-13 17:10:54.625988
180	15	Decidim::Proposals::Proposal	125	2017-09-13 17:12:34.981026	2017-09-13 17:12:34.981026
181	15	Decidim::Proposals::Proposal	126	2017-09-13 17:14:04.261105	2017-09-13 17:14:04.261105
182	15	Decidim::Proposals::Proposal	127	2017-09-13 17:18:56.332051	2017-09-13 17:18:56.332051
183	16	Decidim::Proposals::Proposal	128	2017-09-14 09:00:26.985164	2017-09-14 09:00:26.985164
184	15	Decidim::Proposals::Proposal	129	2017-09-14 09:02:25.846999	2017-09-14 09:02:25.846999
185	16	Decidim::Proposals::Proposal	130	2017-09-14 09:08:45.471915	2017-09-14 09:08:45.471915
186	17	Decidim::Proposals::Proposal	131	2017-09-15 14:49:42.481802	2017-09-15 14:49:42.481802
187	13	Decidim::Proposals::Proposal	132	2017-09-17 14:54:27.665317	2017-09-17 14:54:27.665317
188	13	Decidim::Proposals::Proposal	133	2017-09-18 05:45:31.052052	2017-09-18 05:45:31.052052
189	13	Decidim::Proposals::Proposal	134	2017-09-18 05:47:50.262147	2017-09-18 05:47:50.262147
190	22	Decidim::Proposals::Proposal	135	2017-09-21 11:51:26.169519	2017-09-21 11:51:26.169519
191	23	Decidim::Proposals::Proposal	136	2017-09-23 10:25:59.027939	2017-09-23 10:25:59.027939
192	24	Decidim::Proposals::Proposal	137	2017-09-25 09:20:23.766143	2017-09-25 09:20:23.766143
193	22	Decidim::Proposals::Proposal	138	2017-09-26 13:59:59.027265	2017-09-26 13:59:59.027265
194	23	Decidim::Proposals::Proposal	139	2017-09-28 06:43:26.792164	2017-09-28 06:43:26.792164
195	24	Decidim::Proposals::Proposal	140	2017-09-29 15:48:07.727558	2017-09-29 15:48:07.727558
196	24	Decidim::Proposals::Proposal	144	2017-10-02 14:44:04.47195	2017-10-02 14:44:04.47195
197	23	Decidim::Proposals::Proposal	145	2017-10-02 14:45:40.148331	2017-10-02 14:45:40.148331
198	30	Decidim::Proposals::Proposal	146	2017-10-02 15:12:09.726393	2017-10-02 15:12:09.726393
199	31	Decidim::Proposals::Proposal	147	2017-10-02 15:15:15.795947	2017-10-02 15:15:15.795947
200	33	Decidim::Proposals::Proposal	150	2017-10-11 07:54:33.888767	2017-10-11 07:54:33.888767
201	22	Decidim::Proposals::Proposal	152	2017-10-12 11:36:52.421582	2017-10-12 11:36:52.421582
202	37	Decidim::Proposals::Proposal	153	2017-10-12 15:45:00.679738	2017-10-12 15:45:00.679738
203	22	Decidim::Proposals::Proposal	154	2017-10-12 15:52:52.769599	2017-10-12 15:52:52.769599
204	24	Decidim::Proposals::Proposal	155	2017-10-12 15:57:52.554351	2017-10-12 15:57:52.554351
205	21	Decidim::Proposals::Proposal	156	2017-10-12 16:02:43.611868	2017-10-12 16:02:43.611868
206	25	Decidim::Proposals::Proposal	157	2017-10-12 16:05:57.063459	2017-10-12 16:05:57.063459
207	33	Decidim::Proposals::Proposal	158	2017-10-12 16:10:29.791412	2017-10-12 16:10:29.791412
208	25	Decidim::Proposals::Proposal	159	2017-10-12 16:13:25.599841	2017-10-12 16:13:25.599841
209	22	Decidim::Proposals::Proposal	160	2017-10-12 16:16:41.969684	2017-10-12 16:16:41.969684
210	37	Decidim::Proposals::Proposal	161	2017-10-12 16:18:47.146002	2017-10-12 16:18:47.146002
211	27	Decidim::Proposals::Proposal	169	2017-10-15 15:45:15.877752	2017-10-15 15:45:15.877752
212	22	Decidim::Proposals::Proposal	170	2017-10-15 15:49:25.30467	2017-10-15 15:49:25.30467
213	37	Decidim::Proposals::Proposal	171	2017-10-15 15:50:36.198321	2017-10-15 15:50:36.198321
214	24	Decidim::Proposals::Proposal	172	2017-10-15 15:52:43.136137	2017-10-15 15:52:43.136137
215	25	Decidim::Proposals::Proposal	173	2017-10-15 15:54:07.243801	2017-10-15 15:54:07.243801
216	37	Decidim::Proposals::Proposal	174	2017-10-15 15:58:34.025615	2017-10-15 15:58:34.025615
217	25	Decidim::Proposals::Proposal	175	2017-10-15 16:01:42.620354	2017-10-15 16:01:42.620354
218	22	Decidim::Proposals::Proposal	176	2017-10-15 16:03:06.650031	2017-10-15 16:03:06.650031
219	25	Decidim::Proposals::Proposal	177	2017-10-15 16:04:40.984396	2017-10-15 16:04:40.984396
220	24	Decidim::Proposals::Proposal	178	2017-10-15 16:06:19.960034	2017-10-15 16:06:19.960034
221	25	Decidim::Proposals::Proposal	179	2017-10-15 16:08:35.629067	2017-10-15 16:08:35.629067
222	25	Decidim::Proposals::Proposal	180	2017-10-15 16:09:56.520581	2017-10-15 16:09:56.520581
223	21	Decidim::Proposals::Proposal	181	2017-10-17 08:24:19.225499	2017-10-17 08:24:19.225499
224	37	Decidim::Proposals::Proposal	182	2017-10-17 08:45:31.843842	2017-10-17 08:45:31.843842
225	37	Decidim::Proposals::Proposal	183	2017-10-17 08:47:00.692719	2017-10-17 08:47:00.692719
226	24	Decidim::Proposals::Proposal	184	2017-10-17 08:50:53.727832	2017-10-17 08:50:53.727832
227	25	Decidim::Proposals::Proposal	185	2017-10-17 08:54:18.882727	2017-10-17 08:54:18.882727
228	25	Decidim::Proposals::Proposal	186	2017-10-17 08:59:26.14254	2017-10-17 08:59:26.14254
229	21	Decidim::Proposals::Proposal	187	2017-10-17 09:03:44.422001	2017-10-17 09:03:44.422001
230	25	Decidim::Proposals::Proposal	188	2017-10-17 09:15:00.107245	2017-10-17 09:15:00.107245
231	24	Decidim::Proposals::Proposal	189	2017-10-17 09:17:20.66801	2017-10-17 09:17:20.66801
232	25	Decidim::Proposals::Proposal	190	2017-10-17 09:18:24.716706	2017-10-17 09:18:24.716706
233	25	Decidim::Proposals::Proposal	191	2017-10-17 09:20:25.466182	2017-10-17 09:20:25.466182
234	23	Decidim::Proposals::Proposal	192	2017-10-17 09:58:03.647381	2017-10-17 09:58:03.647381
235	25	Decidim::Proposals::Proposal	193	2017-10-17 10:02:16.317244	2017-10-17 10:02:16.317244
236	22	Decidim::Proposals::Proposal	194	2017-10-17 10:05:12.686982	2017-10-17 10:05:12.686982
237	23	Decidim::Proposals::Proposal	195	2017-10-17 10:07:50.409091	2017-10-17 10:07:50.409091
238	22	Decidim::Proposals::Proposal	196	2017-10-17 10:09:30.523127	2017-10-17 10:09:30.523127
239	25	Decidim::Proposals::Proposal	197	2017-10-17 10:13:09.853113	2017-10-17 10:13:09.853113
240	22	Decidim::Proposals::Proposal	198	2017-10-17 10:17:34.391833	2017-10-17 10:17:34.391833
241	31	Decidim::Proposals::Proposal	199	2017-10-17 10:24:17.313212	2017-10-17 10:24:17.313212
242	31	Decidim::Proposals::Proposal	200	2017-10-17 10:26:25.154715	2017-10-17 10:26:25.154715
243	31	Decidim::Proposals::Proposal	201	2017-10-17 10:27:51.560227	2017-10-17 10:27:51.560227
244	21	Decidim::Proposals::Proposal	202	2017-10-23 08:29:33.755	2017-10-23 08:29:33.755
245	35	Decidim::Proposals::Proposal	203	2017-10-23 08:48:16.583857	2017-10-23 08:48:16.583857
246	22	Decidim::Proposals::Proposal	205	2017-10-25 09:14:36.685322	2017-10-25 09:14:36.685322
247	24	Decidim::Proposals::Proposal	206	2017-10-25 09:26:19.665419	2017-10-25 09:26:19.665419
248	21	Decidim::Proposals::Proposal	207	2017-10-25 09:34:38.2225	2017-10-25 09:34:38.2225
249	31	Decidim::Proposals::Proposal	208	2017-10-25 09:37:54.703947	2017-10-25 09:37:54.703947
250	25	Decidim::Proposals::Proposal	209	2017-10-26 08:00:28.042376	2017-10-26 08:00:28.042376
251	34	Decidim::Proposals::Proposal	210	2017-10-27 08:15:04.675006	2017-10-27 08:15:04.675006
252	37	Decidim::Proposals::Proposal	211	2017-10-31 09:57:06.815675	2017-10-31 09:57:06.815675
253	31	Decidim::Proposals::Proposal	212	2017-10-31 09:58:20.490389	2017-10-31 09:58:20.490389
254	31	Decidim::Proposals::Proposal	213	2017-10-31 10:00:29.562273	2017-10-31 10:00:29.562273
255	25	Decidim::Proposals::Proposal	214	2017-10-31 10:02:01.566529	2017-10-31 10:02:01.566529
256	25	Decidim::Proposals::Proposal	215	2017-10-31 10:02:48.791055	2017-10-31 10:02:48.791055
257	21	Decidim::Proposals::Proposal	216	2017-10-31 10:03:33.184565	2017-10-31 10:03:33.184565
258	25	Decidim::Proposals::Proposal	217	2017-10-31 10:04:09.435811	2017-10-31 10:04:09.435811
259	31	Decidim::Proposals::Proposal	218	2017-10-31 10:05:11.410254	2017-10-31 10:05:11.410254
260	23	Decidim::Proposals::Proposal	219	2017-10-31 10:07:05.009529	2017-10-31 10:07:05.009529
261	24	Decidim::Proposals::Proposal	220	2017-10-31 10:08:05.706391	2017-10-31 10:08:05.706391
262	23	Decidim::Proposals::Proposal	221	2017-10-31 10:09:13.133655	2017-10-31 10:09:13.133655
263	24	Decidim::Proposals::Proposal	222	2017-10-31 13:55:30.547521	2017-10-31 13:55:30.547521
264	36	Decidim::Proposals::Proposal	223	2017-10-31 14:23:28.156475	2017-10-31 14:23:28.156475
265	22	Decidim::Proposals::Proposal	224	2017-10-31 14:24:15.507517	2017-10-31 14:24:15.507517
266	21	Decidim::Proposals::Proposal	225	2017-10-31 14:25:04.100018	2017-10-31 14:25:04.100018
267	25	Decidim::Proposals::Proposal	226	2017-10-31 14:25:29.110922	2017-10-31 14:25:29.110922
268	28	Decidim::Proposals::Proposal	227	2017-10-31 14:26:03.48377	2017-10-31 14:26:03.48377
269	25	Decidim::Proposals::Proposal	228	2017-10-31 14:26:48.645867	2017-10-31 14:26:48.645867
270	33	Decidim::Proposals::Proposal	230	2017-11-01 15:37:05.802036	2017-11-01 15:37:05.802036
271	31	Decidim::Proposals::Proposal	231	2017-11-02 08:40:56.905538	2017-11-02 08:40:56.905538
272	36	Decidim::Proposals::Proposal	232	2017-11-06 15:17:22.671349	2017-11-06 15:17:22.671349
273	31	Decidim::Proposals::Proposal	234	2017-11-09 16:42:26.36487	2017-11-09 16:42:26.36487
274	25	Decidim::Proposals::Proposal	235	2017-11-09 16:43:23.181264	2017-11-09 16:43:23.181264
275	35	Decidim::Proposals::Proposal	236	2017-11-09 16:44:39.127746	2017-11-09 16:44:39.127746
276	22	Decidim::Proposals::Proposal	237	2017-11-09 16:45:21.103899	2017-11-09 16:45:21.103899
277	31	Decidim::Proposals::Proposal	238	2017-11-09 16:46:05.433572	2017-11-09 16:46:05.433572
278	25	Decidim::Proposals::Proposal	239	2017-11-09 16:47:34.115794	2017-11-09 16:47:34.115794
279	37	Decidim::Proposals::Proposal	240	2017-11-09 16:48:24.392402	2017-11-09 16:48:24.392402
280	38	Decidim::Proposals::Proposal	241	2017-11-09 16:49:50.735236	2017-11-09 16:49:50.735236
281	31	Decidim::Proposals::Proposal	242	2017-11-09 16:56:58.132184	2017-11-09 16:56:58.132184
282	37	Decidim::Proposals::Proposal	243	2017-11-09 16:59:27.170872	2017-11-09 16:59:27.170872
283	23	Decidim::Proposals::Proposal	244	2017-11-09 17:00:25.221536	2017-11-09 17:00:25.221536
284	31	Decidim::Proposals::Proposal	245	2017-11-09 17:00:52.945519	2017-11-09 17:00:52.945519
285	23	Decidim::Proposals::Proposal	246	2017-11-09 17:22:55.133971	2017-11-09 17:22:55.133971
286	37	Decidim::Proposals::Proposal	247	2017-11-12 09:34:04.81364	2017-11-12 09:34:04.81364
289	23	Decidim::Proposals::Proposal	250	2017-11-14 13:46:29.649557	2017-11-14 13:46:29.649557
290	33	Decidim::Proposals::Proposal	252	2017-11-15 10:17:20.691249	2017-11-15 10:17:20.691249
291	33	Decidim::Proposals::Proposal	253	2017-11-15 10:22:12.76314	2017-11-15 10:22:12.76314
292	21	Decidim::Proposals::Proposal	254	2017-11-15 10:27:57.63927	2017-11-15 10:27:57.63927
293	23	Decidim::Proposals::Proposal	255	2017-11-15 10:35:21.969391	2017-11-15 10:35:21.969391
294	31	Decidim::Proposals::Proposal	256	2017-11-15 15:24:36.024683	2017-11-15 15:24:36.024683
295	22	Decidim::Proposals::Proposal	257	2017-11-15 15:37:45.167723	2017-11-15 15:37:45.167723
296	22	Decidim::Proposals::Proposal	258	2017-11-17 14:38:19.491807	2017-11-17 14:38:19.491807
297	22	Decidim::Proposals::Proposal	259	2017-11-17 14:53:41.59795	2017-11-17 14:53:41.59795
298	24	Decidim::Proposals::Proposal	265	2017-11-21 07:33:42.911244	2017-11-21 07:33:42.911244
299	25	Decidim::Proposals::Proposal	266	2017-11-21 11:17:29.708282	2017-11-21 11:17:29.708282
300	22	Decidim::Proposals::Proposal	267	2017-11-21 11:20:46.588677	2017-11-21 11:20:46.588677
301	26	Decidim::Proposals::Proposal	268	2017-11-21 11:22:36.119013	2017-11-21 11:22:36.119013
302	29	Decidim::Proposals::Proposal	269	2017-11-21 11:24:07.52605	2017-11-21 11:24:07.52605
303	29	Decidim::Proposals::Proposal	270	2017-11-21 11:25:08.951867	2017-11-21 11:25:08.951867
304	34	Decidim::Proposals::Proposal	271	2017-11-21 11:25:48.693728	2017-11-21 11:25:48.693728
305	38	Decidim::Proposals::Proposal	272	2017-11-21 11:27:25.970229	2017-11-21 11:27:25.970229
306	31	Decidim::Proposals::Proposal	273	2017-11-21 11:27:48.537908	2017-11-21 11:27:48.537908
307	25	Decidim::Proposals::Proposal	274	2017-11-21 11:29:00.964838	2017-11-21 11:29:00.964838
308	31	Decidim::Proposals::Proposal	275	2017-11-21 11:29:33.709848	2017-11-21 11:29:33.709848
309	25	Decidim::Proposals::Proposal	276	2017-11-21 11:30:30.531815	2017-11-21 11:30:30.531815
310	22	Decidim::Proposals::Proposal	277	2017-11-21 11:31:23.899847	2017-11-21 11:31:23.899847
311	24	Decidim::Proposals::Proposal	278	2017-11-21 11:33:32.828471	2017-11-21 11:33:32.828471
312	22	Decidim::Proposals::Proposal	279	2017-11-21 11:33:59.427218	2017-11-21 11:33:59.427218
313	22	Decidim::Proposals::Proposal	280	2017-11-21 11:45:30.660193	2017-11-21 11:45:30.660193
314	31	Decidim::Proposals::Proposal	281	2017-11-21 12:16:30.978137	2017-11-21 12:16:30.978137
315	25	Decidim::Proposals::Proposal	282	2017-11-21 12:17:20.295921	2017-11-21 12:17:20.295921
316	31	Decidim::Proposals::Proposal	283	2017-11-21 12:17:57.547132	2017-11-21 12:17:57.547132
317	22	Decidim::Proposals::Proposal	284	2017-11-21 12:18:58.691057	2017-11-21 12:18:58.691057
318	31	Decidim::Proposals::Proposal	285	2017-11-21 12:19:26.602221	2017-11-21 12:19:26.602221
319	22	Decidim::Proposals::Proposal	286	2017-11-21 12:22:43.103274	2017-11-21 12:22:43.103274
320	24	Decidim::Proposals::Proposal	287	2017-11-21 12:23:05.884511	2017-11-21 12:23:05.884511
321	22	Decidim::Proposals::Proposal	288	2017-11-21 12:23:28.66337	2017-11-21 12:23:28.66337
322	37	Decidim::Proposals::Proposal	289	2017-11-21 12:45:39.64491	2017-11-21 12:45:39.64491
323	23	Decidim::Proposals::Proposal	290	2017-11-21 12:46:19.593613	2017-11-21 12:46:19.593613
324	21	Decidim::Proposals::Proposal	291	2017-11-21 12:47:46.280712	2017-11-21 12:47:46.280712
325	23	Decidim::Proposals::Proposal	292	2017-11-21 12:50:11.036914	2017-11-21 12:50:11.036914
327	31	Decidim::Proposals::Proposal	294	2017-11-21 12:53:06.941867	2017-11-21 12:53:06.941867
329	38	Decidim::Proposals::Proposal	296	2017-11-21 12:54:12.844719	2017-11-21 12:54:12.844719
331	31	Decidim::Proposals::Proposal	298	2017-11-21 13:11:01.902003	2017-11-21 13:11:01.902003
333	38	Decidim::Proposals::Proposal	300	2017-11-21 13:12:12.902542	2017-11-21 13:12:12.902542
337	23	Decidim::Proposals::Proposal	304	2017-11-21 13:16:48.94241	2017-11-21 13:16:48.94241
340	24	Decidim::Proposals::Proposal	307	2017-11-21 13:18:07.836121	2017-11-21 13:18:07.836121
343	24	Decidim::Proposals::Proposal	310	2017-11-21 13:19:22.028215	2017-11-21 13:19:22.028215
348	37	Decidim::Proposals::Proposal	315	2017-11-21 13:22:30.173648	2017-11-21 13:22:30.173648
352	38	Decidim::Proposals::Proposal	319	2017-11-21 13:23:51.436285	2017-11-21 13:23:51.436285
360	22	Decidim::Proposals::Proposal	339	2017-11-27 09:41:47.77659	2017-11-27 09:41:47.77659
326	25	Decidim::Proposals::Proposal	293	2017-11-21 12:50:34.190909	2017-11-21 12:50:34.190909
328	25	Decidim::Proposals::Proposal	295	2017-11-21 12:53:41.415536	2017-11-21 12:53:41.415536
330	34	Decidim::Proposals::Proposal	297	2017-11-21 12:54:48.503122	2017-11-21 12:54:48.503122
332	22	Decidim::Proposals::Proposal	299	2017-11-21 13:11:44.044889	2017-11-21 13:11:44.044889
335	31	Decidim::Proposals::Proposal	302	2017-11-21 13:15:07.716421	2017-11-21 13:15:07.716421
336	24	Decidim::Proposals::Proposal	303	2017-11-21 13:16:17.889424	2017-11-21 13:16:17.889424
342	24	Decidim::Proposals::Proposal	309	2017-11-21 13:18:54.939289	2017-11-21 13:18:54.939289
346	22	Decidim::Proposals::Proposal	313	2017-11-21 13:20:51.610656	2017-11-21 13:20:51.610656
347	37	Decidim::Proposals::Proposal	314	2017-11-21 13:22:09.292548	2017-11-21 13:22:09.292548
354	38	Decidim::Proposals::Proposal	321	2017-11-23 16:35:04.071778	2017-11-23 16:35:04.071778
361	36	Decidim::Proposals::Proposal	340	2017-12-04 20:58:07.829249	2017-12-04 20:58:07.829249
365	22	Decidim::Proposals::Proposal	344	2017-12-08 17:39:02.915991	2017-12-08 17:39:02.915991
334	24	Decidim::Proposals::Proposal	301	2017-11-21 13:14:45.505266	2017-11-21 13:14:45.505266
338	24	Decidim::Proposals::Proposal	305	2017-11-21 13:17:13.182133	2017-11-21 13:17:13.182133
341	37	Decidim::Proposals::Proposal	308	2017-11-21 13:18:28.53412	2017-11-21 13:18:28.53412
344	24	Decidim::Proposals::Proposal	311	2017-11-21 13:19:45.474684	2017-11-21 13:19:45.474684
350	22	Decidim::Proposals::Proposal	317	2017-11-21 13:23:10.899957	2017-11-21 13:23:10.899957
353	25	Decidim::Proposals::Proposal	320	2017-11-21 13:24:16.105089	2017-11-21 13:24:16.105089
358	22	Decidim::Proposals::Proposal	337	2017-11-25 13:11:50.59727	2017-11-25 13:11:50.59727
363	25	Decidim::Proposals::Proposal	342	2017-12-08 17:33:20.922872	2017-12-08 17:33:20.922872
364	22	Decidim::Proposals::Proposal	343	2017-12-08 17:38:09.588441	2017-12-08 17:38:09.588441
366	23	Decidim::Proposals::Proposal	345	2017-12-08 18:38:27.940282	2017-12-08 18:38:27.940282
367	22	Decidim::Proposals::Proposal	346	2017-12-08 18:38:59.437256	2017-12-08 18:38:59.437256
368	31	Decidim::Proposals::Proposal	347	2017-12-08 18:39:22.194648	2017-12-08 18:39:22.194648
369	31	Decidim::Proposals::Proposal	348	2017-12-08 18:39:48.363402	2017-12-08 18:39:48.363402
370	36	Decidim::Proposals::Proposal	349	2017-12-08 18:40:11.390418	2017-12-08 18:40:11.390418
371	31	Decidim::Proposals::Proposal	350	2017-12-08 18:40:38.584802	2017-12-08 18:40:38.584802
339	22	Decidim::Proposals::Proposal	306	2017-11-21 13:17:44.980424	2017-11-21 13:17:44.980424
345	24	Decidim::Proposals::Proposal	312	2017-11-21 13:20:09.511301	2017-11-21 13:20:09.511301
351	38	Decidim::Proposals::Proposal	318	2017-11-21 13:23:34.012375	2017-11-21 13:23:34.012375
355	38	Decidim::Proposals::Proposal	326	2017-11-24 10:06:34.407305	2017-11-24 10:06:34.407305
359	31	Decidim::Proposals::Proposal	338	2017-11-26 22:06:17.350344	2017-11-26 22:06:17.350344
362	37	Decidim::Proposals::Proposal	341	2017-12-05 19:34:55.643945	2017-12-05 19:34:55.643945
349	21	Decidim::Proposals::Proposal	316	2017-11-21 13:22:50.888064	2017-11-21 13:22:50.888064
356	42	Decidim::Proposals::Proposal	334	2017-11-24 11:23:07.098482	2017-11-24 11:23:07.098482
357	38	Decidim::Proposals::Proposal	336	2017-11-24 20:29:55.238942	2017-11-24 20:29:55.238942
372	37	Decidim::Proposals::Proposal	351	2017-12-09 17:28:59.462003	2017-12-09 17:28:59.462003
373	38	Decidim::Proposals::Proposal	352	2017-12-09 17:30:13.332336	2017-12-09 17:30:13.332336
374	38	Decidim::Proposals::Proposal	353	2017-12-09 17:31:26.548569	2017-12-09 17:31:26.548569
375	22	Decidim::Proposals::Proposal	354	2017-12-09 17:31:58.069276	2017-12-09 17:31:58.069276
376	22	Decidim::Proposals::Proposal	355	2017-12-09 17:32:48.889622	2017-12-09 17:32:48.889622
377	25	Decidim::Proposals::Proposal	356	2017-12-09 17:33:33.598972	2017-12-09 17:33:33.598972
378	37	Decidim::Proposals::Proposal	357	2017-12-11 09:04:26.363635	2017-12-11 09:04:26.363635
379	37	Decidim::Proposals::Proposal	358	2017-12-13 09:46:40.398479	2017-12-13 09:46:40.398479
380	24	Decidim::Proposals::Proposal	359	2017-12-13 11:00:13.323368	2017-12-13 11:00:13.323368
381	31	Decidim::Proposals::Proposal	362	2017-12-15 08:56:13.207148	2017-12-15 08:56:13.207148
382	22	Decidim::Proposals::Proposal	363	2017-12-15 09:23:15.890038	2017-12-15 09:23:15.890038
383	24	Decidim::Proposals::Proposal	366	2017-12-15 13:51:47.384921	2017-12-15 13:51:47.384921
384	37	Decidim::Proposals::Proposal	367	2017-12-16 06:40:13.400053	2017-12-16 06:40:13.400053
385	24	Decidim::Proposals::Proposal	368	2017-12-17 23:11:26.24034	2017-12-17 23:11:26.24034
386	22	Decidim::Proposals::Proposal	369	2017-12-17 23:21:44.715516	2017-12-17 23:21:44.715516
387	22	Decidim::Proposals::Proposal	370	2017-12-19 09:23:26.448802	2017-12-19 09:23:26.448802
388	38	Decidim::Proposals::Proposal	371	2017-12-19 09:25:00.755515	2017-12-19 09:25:00.755515
389	22	Decidim::Proposals::Proposal	372	2017-12-19 09:25:32.818819	2017-12-19 09:25:32.818819
390	24	Decidim::Proposals::Proposal	373	2017-12-19 09:26:04.11659	2017-12-19 09:26:04.11659
391	31	Decidim::Proposals::Proposal	374	2017-12-19 09:26:51.283131	2017-12-19 09:26:51.283131
392	21	Decidim::Proposals::Proposal	375	2017-12-19 09:27:29.534208	2017-12-19 09:27:29.534208
393	21	Decidim::Proposals::Proposal	376	2017-12-19 09:28:00.162989	2017-12-19 09:28:00.162989
394	22	Decidim::Proposals::Proposal	377	2017-12-19 09:28:51.380676	2017-12-19 09:28:51.380676
395	38	Decidim::Proposals::Proposal	378	2017-12-19 09:29:14.769881	2017-12-19 09:29:14.769881
396	31	Decidim::Proposals::Proposal	379	2017-12-19 09:29:37.03934	2017-12-19 09:29:37.03934
397	28	Decidim::Proposals::Proposal	380	2017-12-19 10:41:36.641342	2017-12-19 10:41:36.641342
398	33	Decidim::Proposals::Proposal	381	2017-12-20 20:24:25.357159	2017-12-20 20:24:25.357159
399	21	Decidim::Proposals::Proposal	382	2017-12-22 16:03:45.098323	2017-12-22 16:03:45.098323
400	24	Decidim::Proposals::Proposal	383	2017-12-22 17:23:29.377743	2017-12-22 17:23:29.377743
401	21	Decidim::Proposals::Proposal	384	2017-12-22 18:15:57.271888	2017-12-22 18:15:57.271888
24	2	Decidim::Accountability::Result	1	2017-09-13 12:47:32.844033	2017-09-13 12:47:32.844033
25	2	Decidim::Accountability::Result	2	2017-09-13 12:47:32.900812	2017-09-13 12:47:32.900812
26	1	Decidim::Accountability::Result	3	2017-09-13 12:47:32.964239	2017-09-13 12:47:32.964239
53	3	Decidim::Accountability::Result	4	2017-09-13 12:47:49.770716	2017-09-13 12:47:49.770716
54	3	Decidim::Accountability::Result	5	2017-09-13 12:47:49.848843	2017-09-13 12:47:49.848843
55	3	Decidim::Accountability::Result	6	2017-09-13 12:47:49.970926	2017-09-13 12:47:49.970926
82	6	Decidim::Accountability::Result	7	2017-09-13 12:48:07.477773	2017-09-13 12:48:07.477773
83	5	Decidim::Accountability::Result	8	2017-09-13 12:48:07.597436	2017-09-13 12:48:07.597436
84	6	Decidim::Accountability::Result	9	2017-09-13 12:48:07.685698	2017-09-13 12:48:07.685698
111	7	Decidim::Accountability::Result	10	2017-09-13 12:48:23.796459	2017-09-13 12:48:23.796459
112	7	Decidim::Accountability::Result	11	2017-09-13 12:48:23.865947	2017-09-13 12:48:23.865947
113	7	Decidim::Accountability::Result	12	2017-09-13 12:48:23.91164	2017-09-13 12:48:23.91164
140	10	Decidim::Accountability::Result	13	2017-09-13 12:48:39.795706	2017-09-13 12:48:39.795706
141	10	Decidim::Accountability::Result	14	2017-09-13 12:48:39.914552	2017-09-13 12:48:39.914552
142	10	Decidim::Accountability::Result	15	2017-09-13 12:48:40.07563	2017-09-13 12:48:40.07563
169	12	Decidim::Accountability::Result	16	2017-09-13 12:48:55.462099	2017-09-13 12:48:55.462099
170	11	Decidim::Accountability::Result	17	2017-09-13 12:48:55.59712	2017-09-13 12:48:55.59712
171	12	Decidim::Accountability::Result	18	2017-09-13 12:48:55.708512	2017-09-13 12:48:55.708512
287	42	Decidim::Accountability::Result	19	2017-11-14 10:34:37.23822	2017-11-14 10:34:37.23822
288	41	Decidim::Accountability::Result	22	2017-11-14 10:34:45.131792	2017-11-14 10:34:45.131792
\.


--
-- Data for Name: decidim_comments_comment_votes; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_comments_comment_votes (id, weight, decidim_comment_id, decidim_author_id, created_at, updated_at) FROM stdin;
1	1	472	333	2017-09-13 16:53:53.897371	2017-09-13 16:53:53.897371
2	-1	474	333	2017-09-13 16:53:54.880005	2017-09-13 16:53:54.880005
3	1	476	334	2017-09-13 17:11:26.472461	2017-09-13 17:11:26.472461
4	-1	477	334	2017-09-13 17:11:28.310264	2017-09-13 17:11:28.310264
5	1	482	338	2017-09-14 09:05:22.218016	2017-09-14 09:05:22.218016
6	-1	482	331	2017-09-18 05:59:52.968309	2017-09-18 05:59:52.968309
7	1	493	394	2017-11-06 17:18:09.807394	2017-11-06 17:18:09.807394
8	1	492	394	2017-11-06 17:18:14.675829	2017-11-06 17:18:14.675829
9	1	505	397	2017-12-02 11:23:27.909014	2017-12-02 11:23:27.909014
10	1	506	397	2017-12-12 10:24:38.429867	2017-12-12 10:24:38.429867
11	1	511	389	2017-12-22 10:49:52.534403	2017-12-22 10:49:52.534403
\.


--
-- Data for Name: decidim_comments_comments; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_comments_comments (id, body, decidim_commentable_type, decidim_commentable_id, decidim_author_id, created_at, updated_at, depth, alignment, decidim_user_group_id, decidim_root_commentable_type, decidim_root_commentable_id) FROM stdin;
1	Sint non nihil consequatur quisquam et voluptate ea.	Decidim::Pages::Page	1	3	2017-09-13 12:47:18.463618	2017-09-13 12:47:18.463618	0	0	\N	Decidim::Pages::Page	1
2	Eum qui quibusdam aperiam cupiditate quae.	Decidim::Pages::Page	1	5	2017-09-13 12:47:18.527577	2017-09-13 12:47:18.527577	0	0	\N	Decidim::Pages::Page	1
3	Et hic officiis odio eius velit et voluptas dicta.	Decidim::Pages::Page	1	2	2017-09-13 12:47:18.567491	2017-09-13 12:47:18.567491	0	0	4	Decidim::Pages::Page	1
4	Quia aliquam a aut sit quas aut cupiditate molestiae.	Decidim::Pages::Page	1	1	2017-09-13 12:47:18.589329	2017-09-13 12:47:18.589329	0	0	2	Decidim::Pages::Page	1
5	Voluptas nobis voluptatum repudiandae fugit cum aperiam quidem in.	Decidim::Pages::Page	1	2	2017-09-13 12:47:18.613339	2017-09-13 12:47:18.613339	0	0	4	Decidim::Pages::Page	1
6	At qui atque ducimus fuga laudantium adipisci.	Decidim::Proposals::Proposal	1	18	2017-09-13 12:47:26.120805	2017-09-13 12:47:26.120805	0	0	\N	Decidim::Proposals::Proposal	1
7	Temporibus earum aut quia harum.	Decidim::Proposals::Proposal	2	9	2017-09-13 12:47:26.633468	2017-09-13 12:47:26.633468	0	0	\N	Decidim::Proposals::Proposal	2
8	Voluptate eveniet labore aut voluptates maiores.	Decidim::Proposals::Proposal	2	27	2017-09-13 12:47:26.657856	2017-09-13 12:47:26.657856	0	0	\N	Decidim::Proposals::Proposal	2
9	Voluptatem quasi est qui exercitationem velit consequuntur.	Decidim::Proposals::Proposal	3	33	2017-09-13 12:47:27.119318	2017-09-13 12:47:27.119318	0	0	\N	Decidim::Proposals::Proposal	3
10	Similique voluptas ipsam iusto deleniti.	Decidim::Proposals::Proposal	3	29	2017-09-13 12:47:27.135689	2017-09-13 12:47:27.135689	0	0	\N	Decidim::Proposals::Proposal	3
11	Excepturi nobis velit aut vitae ut.	Decidim::Proposals::Proposal	3	39	2017-09-13 12:47:27.148338	2017-09-13 12:47:27.148338	0	0	\N	Decidim::Proposals::Proposal	3
12	Ea aut voluptas sint.	Decidim::Proposals::Proposal	3	26	2017-09-13 12:47:27.161191	2017-09-13 12:47:27.161191	0	0	\N	Decidim::Proposals::Proposal	3
13	Amet dolorum soluta sapiente.	Decidim::Proposals::Proposal	4	42	2017-09-13 12:47:27.695985	2017-09-13 12:47:27.695985	0	0	\N	Decidim::Proposals::Proposal	4
14	Corrupti voluptatem non rerum eum ab qui in.	Decidim::Proposals::Proposal	4	24	2017-09-13 12:47:27.709485	2017-09-13 12:47:27.709485	0	0	\N	Decidim::Proposals::Proposal	4
15	Consequatur dolorem ipsum molestiae eaque sit ea perferendis voluptas.	Decidim::Proposals::Proposal	4	38	2017-09-13 12:47:27.721901	2017-09-13 12:47:27.721901	0	0	\N	Decidim::Proposals::Proposal	4
16	Est quia facilis maiores neque earum dolorum eius nulla.	Decidim::Proposals::Proposal	5	33	2017-09-13 12:47:28.019595	2017-09-13 12:47:28.019595	0	0	\N	Decidim::Proposals::Proposal	5
17	Adipisci ut beatae impedit amet.	Decidim::Proposals::Proposal	5	30	2017-09-13 12:47:28.038026	2017-09-13 12:47:28.038026	0	0	\N	Decidim::Proposals::Proposal	5
18	Unde ratione quasi sit ut excepturi.	Decidim::Proposals::Proposal	5	31	2017-09-13 12:47:28.056988	2017-09-13 12:47:28.056988	0	0	\N	Decidim::Proposals::Proposal	5
19	Hic nisi alias accusantium laudantium minus excepturi neque dignissimos.	Decidim::Proposals::Proposal	5	26	2017-09-13 12:47:28.071963	2017-09-13 12:47:28.071963	0	0	\N	Decidim::Proposals::Proposal	5
20	Debitis facere cumque nihil.	Decidim::Proposals::Proposal	5	32	2017-09-13 12:47:28.087629	2017-09-13 12:47:28.087629	0	0	\N	Decidim::Proposals::Proposal	5
21	Et doloremque voluptas aut.	Decidim::Proposals::Proposal	6	8	2017-09-13 12:47:28.389549	2017-09-13 12:47:28.389549	0	0	\N	Decidim::Proposals::Proposal	6
22	In repellat odio quos deserunt at odit est dolor.	Decidim::Proposals::Proposal	6	12	2017-09-13 12:47:28.408731	2017-09-13 12:47:28.408731	0	0	\N	Decidim::Proposals::Proposal	6
23	Recusandae labore fugit aut qui.	Decidim::Proposals::Proposal	6	35	2017-09-13 12:47:28.422131	2017-09-13 12:47:28.422131	0	0	\N	Decidim::Proposals::Proposal	6
24	Iste consectetur possimus est autem error in totam.	Decidim::Proposals::Proposal	6	34	2017-09-13 12:47:28.438414	2017-09-13 12:47:28.438414	0	0	\N	Decidim::Proposals::Proposal	6
25	Nobis libero enim quia dolor corporis ipsum qui tempora.	Decidim::Proposals::Proposal	7	26	2017-09-13 12:47:29.003965	2017-09-13 12:47:29.003965	0	0	\N	Decidim::Proposals::Proposal	7
26	Error vel minima in sint.	Decidim::Proposals::Proposal	7	1	2017-09-13 12:47:29.026874	2017-09-13 12:47:29.026874	0	0	\N	Decidim::Proposals::Proposal	7
27	Placeat vitae itaque nam.	Decidim::Proposals::Proposal	7	17	2017-09-13 12:47:29.051202	2017-09-13 12:47:29.051202	0	0	\N	Decidim::Proposals::Proposal	7
28	Excepturi tempora ut magnam aut.	Decidim::Proposals::Proposal	7	43	2017-09-13 12:47:29.067334	2017-09-13 12:47:29.067334	0	0	\N	Decidim::Proposals::Proposal	7
29	Veritatis sequi non est id numquam.	Decidim::Proposals::Proposal	8	11	2017-09-13 12:47:29.348261	2017-09-13 12:47:29.348261	0	0	\N	Decidim::Proposals::Proposal	8
30	Quo odio temporibus laborum aspernatur rerum sunt.	Decidim::Proposals::Proposal	8	45	2017-09-13 12:47:29.361107	2017-09-13 12:47:29.361107	0	0	\N	Decidim::Proposals::Proposal	8
31	Quibusdam fugit harum facere fugiat optio quos.	Decidim::Proposals::Proposal	8	12	2017-09-13 12:47:29.372861	2017-09-13 12:47:29.372861	0	0	\N	Decidim::Proposals::Proposal	8
32	Consequatur illum incidunt maiores ab maxime.	Decidim::Proposals::Proposal	8	11	2017-09-13 12:47:29.385918	2017-09-13 12:47:29.385918	0	0	\N	Decidim::Proposals::Proposal	8
33	In quae tempora non aut.	Decidim::Proposals::Proposal	8	9	2017-09-13 12:47:29.398625	2017-09-13 12:47:29.398625	0	0	\N	Decidim::Proposals::Proposal	8
34	Accusantium consequatur distinctio quo est.	Decidim::Proposals::Proposal	9	9	2017-09-13 12:47:29.902501	2017-09-13 12:47:29.902501	0	0	\N	Decidim::Proposals::Proposal	9
35	Ut perferendis voluptatem amet placeat repellendus.	Decidim::Proposals::Proposal	9	23	2017-09-13 12:47:29.924304	2017-09-13 12:47:29.924304	0	0	\N	Decidim::Proposals::Proposal	9
36	Impedit alias modi ut animi quae magni.	Decidim::Proposals::Proposal	9	44	2017-09-13 12:47:29.943205	2017-09-13 12:47:29.943205	0	0	\N	Decidim::Proposals::Proposal	9
37	Sed omnis veritatis sit in iste cum quia.	Decidim::Proposals::Proposal	10	41	2017-09-13 12:47:30.226901	2017-09-13 12:47:30.226901	0	0	\N	Decidim::Proposals::Proposal	10
38	Voluptas officia officiis nemo quos recusandae quod.	Decidim::Proposals::Proposal	11	13	2017-09-13 12:47:30.491849	2017-09-13 12:47:30.491849	0	0	\N	Decidim::Proposals::Proposal	11
39	Consectetur fugit neque officia placeat qui.	Decidim::Proposals::Proposal	11	6	2017-09-13 12:47:30.505266	2017-09-13 12:47:30.505266	0	0	\N	Decidim::Proposals::Proposal	11
40	Consequatur voluptate dolorum doloribus maxime neque explicabo facilis qui.	Decidim::Proposals::Proposal	11	17	2017-09-13 12:47:30.520157	2017-09-13 12:47:30.520157	0	0	\N	Decidim::Proposals::Proposal	11
41	Dolor facilis velit omnis quos ut sit repellat et.	Decidim::Proposals::Proposal	11	9	2017-09-13 12:47:30.536734	2017-09-13 12:47:30.536734	0	0	\N	Decidim::Proposals::Proposal	11
42	Et exercitationem voluptate ut.	Decidim::Proposals::Proposal	12	15	2017-09-13 12:47:30.592518	2017-09-13 12:47:30.592518	0	0	\N	Decidim::Proposals::Proposal	12
43	Neque quisquam eveniet praesentium voluptates error voluptas soluta voluptatem.	Decidim::Proposals::Proposal	13	17	2017-09-13 12:47:30.636383	2017-09-13 12:47:30.636383	0	0	\N	Decidim::Proposals::Proposal	13
44	Earum sed adipisci enim sunt nulla.	Decidim::Proposals::Proposal	14	16	2017-09-13 12:47:30.88676	2017-09-13 12:47:30.88676	0	0	\N	Decidim::Proposals::Proposal	14
45	Nemo repellat aperiam est.	Decidim::Proposals::Proposal	14	34	2017-09-13 12:47:30.911101	2017-09-13 12:47:30.911101	0	0	\N	Decidim::Proposals::Proposal	14
46	Deserunt repudiandae rerum consequuntur.	Decidim::Proposals::Proposal	14	48	2017-09-13 12:47:30.925842	2017-09-13 12:47:30.925842	0	0	\N	Decidim::Proposals::Proposal	14
47	Sequi quia sunt dolorem quia.	Decidim::Proposals::Proposal	14	37	2017-09-13 12:47:30.938342	2017-09-13 12:47:30.938342	0	0	\N	Decidim::Proposals::Proposal	14
48	Et doloremque dolores ab debitis et.	Decidim::Proposals::Proposal	14	27	2017-09-13 12:47:30.952895	2017-09-13 12:47:30.952895	0	0	\N	Decidim::Proposals::Proposal	14
49	Doloribus praesentium voluptatibus magnam non.	Decidim::Proposals::Proposal	15	15	2017-09-13 12:47:31.454871	2017-09-13 12:47:31.454871	0	0	\N	Decidim::Proposals::Proposal	15
50	Iure est rerum eos id quasi beatae.	Decidim::Proposals::Proposal	15	30	2017-09-13 12:47:31.471822	2017-09-13 12:47:31.471822	0	0	\N	Decidim::Proposals::Proposal	15
51	Aliquid sint itaque molestias et.	Decidim::Proposals::Proposal	15	23	2017-09-13 12:47:31.486827	2017-09-13 12:47:31.486827	0	0	\N	Decidim::Proposals::Proposal	15
52	Nulla doloribus consectetur in expedita rem dolore sunt omnis.	Decidim::Proposals::Proposal	15	18	2017-09-13 12:47:31.502731	2017-09-13 12:47:31.502731	0	0	\N	Decidim::Proposals::Proposal	15
53	Quasi magni laborum neque enim reprehenderit sit dolores perspiciatis.	Decidim::Proposals::Proposal	15	7	2017-09-13 12:47:31.51713	2017-09-13 12:47:31.51713	0	0	\N	Decidim::Proposals::Proposal	15
54	Nostrum nesciunt doloribus in.	Decidim::Proposals::Proposal	16	22	2017-09-13 12:47:31.979034	2017-09-13 12:47:31.979034	0	0	\N	Decidim::Proposals::Proposal	16
55	Veritatis rem architecto ut voluptatem ipsam eius perferendis.	Decidim::Proposals::Proposal	16	50	2017-09-13 12:47:31.993817	2017-09-13 12:47:31.993817	0	0	\N	Decidim::Proposals::Proposal	16
56	Qui qui asperiores rerum itaque odio cumque nemo.	Decidim::Proposals::Proposal	17	24	2017-09-13 12:47:32.032884	2017-09-13 12:47:32.032884	0	0	\N	Decidim::Proposals::Proposal	17
57	Accusantium ab quam eum porro perferendis ut quia sapiente.	Decidim::Proposals::Proposal	17	10	2017-09-13 12:47:32.045854	2017-09-13 12:47:32.045854	0	0	\N	Decidim::Proposals::Proposal	17
58	Dolor vero sit quisquam.	Decidim::Proposals::Proposal	18	30	2017-09-13 12:47:32.087623	2017-09-13 12:47:32.087623	0	0	\N	Decidim::Proposals::Proposal	18
59	Debitis officiis in ipsa deserunt deleniti ipsum exercitationem aut.	Decidim::Proposals::Proposal	18	11	2017-09-13 12:47:32.110406	2017-09-13 12:47:32.110406	0	0	\N	Decidim::Proposals::Proposal	18
60	Ab est ut voluptate quod omnis dolores doloremque.	Decidim::Proposals::Proposal	19	40	2017-09-13 12:47:32.406626	2017-09-13 12:47:32.406626	0	0	\N	Decidim::Proposals::Proposal	19
61	Rerum laudantium doloremque nihil vero quia consectetur aut.	Decidim::Proposals::Proposal	19	46	2017-09-13 12:47:32.420177	2017-09-13 12:47:32.420177	0	0	\N	Decidim::Proposals::Proposal	19
62	Voluptatem nostrum reprehenderit aut qui qui alias repudiandae nesciunt.	Decidim::Proposals::Proposal	20	47	2017-09-13 12:47:32.716828	2017-09-13 12:47:32.716828	0	0	\N	Decidim::Proposals::Proposal	20
63	Voluptatem dolor officia voluptate necessitatibus nihil id ut.	Decidim::Proposals::Proposal	20	42	2017-09-13 12:47:32.73894	2017-09-13 12:47:32.73894	0	0	\N	Decidim::Proposals::Proposal	20
64	Natus omnis perspiciatis aperiam tempore hic.	Decidim::Results::Result	1	44	2017-09-13 12:47:32.883768	2017-09-13 12:47:32.883768	0	0	\N	Decidim::Results::Result	1
65	Provident sunt molestiae et ipsam est ratione.	Decidim::Results::Result	2	16	2017-09-13 12:47:32.926494	2017-09-13 12:47:32.926494	0	0	\N	Decidim::Results::Result	2
66	Tempora ad nihil autem molestias.	Decidim::Results::Result	3	20	2017-09-13 12:47:32.987033	2017-09-13 12:47:32.987033	0	0	\N	Decidim::Results::Result	3
67	Veritatis ipsam cupiditate eos soluta tempora.	Decidim::Results::Result	3	30	2017-09-13 12:47:33.000484	2017-09-13 12:47:33.000484	0	0	\N	Decidim::Results::Result	3
68	Ut animi qui ut sed qui quas cumque et.	Decidim::Results::Result	3	3	2017-09-13 12:47:33.015259	2017-09-13 12:47:33.015259	0	0	\N	Decidim::Results::Result	3
69	Eaque odit mollitia eum quam repudiandae distinctio.	Decidim::Results::Result	3	4	2017-09-13 12:47:33.027841	2017-09-13 12:47:33.027841	0	0	\N	Decidim::Results::Result	3
70	Corporis necessitatibus sed eos rerum.	Decidim::Results::Result	3	41	2017-09-13 12:47:33.041955	2017-09-13 12:47:33.041955	0	0	\N	Decidim::Results::Result	3
71	Deserunt rerum voluptatem est ratione.	Decidim::Budgets::Project	1	45	2017-09-13 12:47:33.358109	2017-09-13 12:47:33.358109	0	0	\N	Decidim::Budgets::Project	1
72	Ut nemo maxime dolor cumque sed facere consequuntur quia.	Decidim::Budgets::Project	1	56	2017-09-13 12:47:33.376683	2017-09-13 12:47:33.376683	0	0	\N	Decidim::Budgets::Project	1
73	Et mollitia enim velit necessitatibus est blanditiis minus qui.	Decidim::Budgets::Project	1	58	2017-09-13 12:47:33.390595	2017-09-13 12:47:33.390595	0	0	\N	Decidim::Budgets::Project	1
74	Rerum dicta minima dolores eos laudantium.	Decidim::Budgets::Project	1	40	2017-09-13 12:47:33.403765	2017-09-13 12:47:33.403765	0	0	\N	Decidim::Budgets::Project	1
75	Quod est nihil est laborum non possimus.	Decidim::Budgets::Project	2	37	2017-09-13 12:47:33.578351	2017-09-13 12:47:33.578351	0	0	\N	Decidim::Budgets::Project	2
76	Qui et quo necessitatibus magnam vitae.	Decidim::Budgets::Project	2	55	2017-09-13 12:47:33.589631	2017-09-13 12:47:33.589631	0	0	\N	Decidim::Budgets::Project	2
77	Sit quo consequatur quis.	Decidim::Budgets::Project	2	7	2017-09-13 12:47:33.603101	2017-09-13 12:47:33.603101	0	0	\N	Decidim::Budgets::Project	2
78	Esse optio quia accusantium numquam sed.	Decidim::Budgets::Project	2	57	2017-09-13 12:47:33.614243	2017-09-13 12:47:33.614243	0	0	\N	Decidim::Budgets::Project	2
79	Aut perferendis et magni iste aliquid reiciendis autem dignissimos.	Decidim::Budgets::Project	3	55	2017-09-13 12:47:33.783906	2017-09-13 12:47:33.783906	0	0	\N	Decidim::Budgets::Project	3
80	Et ab voluptatem ullam.	Decidim::Budgets::Project	3	24	2017-09-13 12:47:33.795775	2017-09-13 12:47:33.795775	0	0	\N	Decidim::Budgets::Project	3
81	Autem ad dicta nisi ratione voluptatum sapiente aut molestias.	Decidim::Budgets::Project	3	38	2017-09-13 12:47:33.809574	2017-09-13 12:47:33.809574	0	0	\N	Decidim::Budgets::Project	3
82	Quibusdam nihil nihil et necessitatibus architecto.	Decidim::Budgets::Project	3	4	2017-09-13 12:47:33.821083	2017-09-13 12:47:33.821083	0	0	\N	Decidim::Budgets::Project	3
83	Qui vero distinctio et rerum error iusto explicabo tenetur.	Decidim::Budgets::Project	3	15	2017-09-13 12:47:33.83273	2017-09-13 12:47:33.83273	0	0	\N	Decidim::Budgets::Project	3
84	Sit explicabo dolor voluptatem qui aliquam saepe suscipit ea.	Decidim::Pages::Page	2	25	2017-09-13 12:47:34.914244	2017-09-13 12:47:34.914244	0	0	\N	Decidim::Pages::Page	2
85	Necessitatibus enim recusandae qui reiciendis qui.	Decidim::Proposals::Proposal	21	59	2017-09-13 12:47:42.252076	2017-09-13 12:47:42.252076	0	0	\N	Decidim::Proposals::Proposal	21
86	Aliquid maiores dolore a.	Decidim::Proposals::Proposal	21	44	2017-09-13 12:47:42.269536	2017-09-13 12:47:42.269536	0	0	\N	Decidim::Proposals::Proposal	21
87	Nostrum tempora ab iste.	Decidim::Proposals::Proposal	21	90	2017-09-13 12:47:42.291779	2017-09-13 12:47:42.291779	0	0	\N	Decidim::Proposals::Proposal	21
88	Quisquam assumenda reiciendis consequatur doloremque culpa.	Decidim::Proposals::Proposal	22	34	2017-09-13 12:47:42.356593	2017-09-13 12:47:42.356593	0	0	\N	Decidim::Proposals::Proposal	22
89	Animi necessitatibus ab ea doloremque qui minima alias.	Decidim::Proposals::Proposal	22	24	2017-09-13 12:47:42.383948	2017-09-13 12:47:42.383948	0	0	\N	Decidim::Proposals::Proposal	22
90	Est assumenda consequatur ipsam at.	Decidim::Proposals::Proposal	22	53	2017-09-13 12:47:42.400585	2017-09-13 12:47:42.400585	0	0	\N	Decidim::Proposals::Proposal	22
91	Eligendi dolorem ea omnis doloribus voluptates aut suscipit.	Decidim::Proposals::Proposal	22	72	2017-09-13 12:47:42.416134	2017-09-13 12:47:42.416134	0	0	\N	Decidim::Proposals::Proposal	22
92	Rerum sit ullam non ducimus.	Decidim::Proposals::Proposal	23	31	2017-09-13 12:47:42.891055	2017-09-13 12:47:42.891055	0	0	\N	Decidim::Proposals::Proposal	23
93	Nisi a sunt libero fugiat et.	Decidim::Proposals::Proposal	23	36	2017-09-13 12:47:42.908161	2017-09-13 12:47:42.908161	0	0	\N	Decidim::Proposals::Proposal	23
94	Et sit repellat aperiam ut.	Decidim::Proposals::Proposal	23	9	2017-09-13 12:47:42.924658	2017-09-13 12:47:42.924658	0	0	\N	Decidim::Proposals::Proposal	23
95	Consequuntur deserunt alias qui sint vitae voluptas.	Decidim::Proposals::Proposal	24	63	2017-09-13 12:47:43.421443	2017-09-13 12:47:43.421443	0	0	\N	Decidim::Proposals::Proposal	24
96	Earum voluptate deleniti ut maiores quo.	Decidim::Proposals::Proposal	24	17	2017-09-13 12:47:43.447783	2017-09-13 12:47:43.447783	0	0	\N	Decidim::Proposals::Proposal	24
97	Nostrum eaque veniam minima.	Decidim::Proposals::Proposal	25	60	2017-09-13 12:47:43.938072	2017-09-13 12:47:43.938072	0	0	\N	Decidim::Proposals::Proposal	25
98	Nemo deleniti ullam quia et itaque aut quo voluptatem.	Decidim::Proposals::Proposal	25	45	2017-09-13 12:47:43.954937	2017-09-13 12:47:43.954937	0	0	\N	Decidim::Proposals::Proposal	25
99	Vel enim tempora ea pariatur quaerat.	Decidim::Proposals::Proposal	26	80	2017-09-13 12:47:44.431723	2017-09-13 12:47:44.431723	0	0	\N	Decidim::Proposals::Proposal	26
100	Exercitationem placeat voluptatibus iste neque minima eum quas est.	Decidim::Proposals::Proposal	26	99	2017-09-13 12:47:44.447283	2017-09-13 12:47:44.447283	0	0	\N	Decidim::Proposals::Proposal	26
101	Consequatur non rem non totam et molestiae.	Decidim::Proposals::Proposal	26	57	2017-09-13 12:47:44.468306	2017-09-13 12:47:44.468306	0	0	\N	Decidim::Proposals::Proposal	26
102	Recusandae provident laudantium eum dolor tempora voluptates.	Decidim::Proposals::Proposal	26	40	2017-09-13 12:47:44.48353	2017-09-13 12:47:44.48353	0	0	\N	Decidim::Proposals::Proposal	26
103	Est quisquam facere quia dolores.	Decidim::Proposals::Proposal	27	5	2017-09-13 12:47:44.955736	2017-09-13 12:47:44.955736	0	0	\N	Decidim::Proposals::Proposal	27
104	Soluta rerum corporis id.	Decidim::Proposals::Proposal	27	32	2017-09-13 12:47:44.97295	2017-09-13 12:47:44.97295	0	0	\N	Decidim::Proposals::Proposal	27
105	Qui et rerum assumenda voluptate repudiandae natus.	Decidim::Proposals::Proposal	27	18	2017-09-13 12:47:44.993375	2017-09-13 12:47:44.993375	0	0	\N	Decidim::Proposals::Proposal	27
106	Laborum assumenda incidunt ut repellendus vel.	Decidim::Proposals::Proposal	27	64	2017-09-13 12:47:45.018627	2017-09-13 12:47:45.018627	0	0	\N	Decidim::Proposals::Proposal	27
107	Asperiores rerum sunt vero ea culpa.	Decidim::Proposals::Proposal	27	35	2017-09-13 12:47:45.039001	2017-09-13 12:47:45.039001	0	0	\N	Decidim::Proposals::Proposal	27
108	Necessitatibus consequatur consequatur occaecati.	Decidim::Proposals::Proposal	28	53	2017-09-13 12:47:45.324538	2017-09-13 12:47:45.324538	0	0	\N	Decidim::Proposals::Proposal	28
109	Voluptate sint est pariatur voluptatem.	Decidim::Proposals::Proposal	28	35	2017-09-13 12:47:45.347814	2017-09-13 12:47:45.347814	0	0	\N	Decidim::Proposals::Proposal	28
110	Quaerat omnis assumenda perferendis ea nostrum.	Decidim::Proposals::Proposal	28	31	2017-09-13 12:47:45.363907	2017-09-13 12:47:45.363907	0	0	\N	Decidim::Proposals::Proposal	28
111	Inventore nulla maiores perferendis ipsam et vero sed voluptatem.	Decidim::Proposals::Proposal	28	65	2017-09-13 12:47:45.382916	2017-09-13 12:47:45.382916	0	0	\N	Decidim::Proposals::Proposal	28
112	Impedit sapiente similique incidunt voluptas in.	Decidim::Proposals::Proposal	29	10	2017-09-13 12:47:45.445613	2017-09-13 12:47:45.445613	0	0	\N	Decidim::Proposals::Proposal	29
113	Fugit deserunt magni ex qui corrupti molestias.	Decidim::Proposals::Proposal	30	40	2017-09-13 12:47:45.942582	2017-09-13 12:47:45.942582	0	0	\N	Decidim::Proposals::Proposal	30
114	Ea dolore in sed labore.	Decidim::Proposals::Proposal	31	66	2017-09-13 12:47:46.209038	2017-09-13 12:47:46.209038	0	0	\N	Decidim::Proposals::Proposal	31
115	Ut molestiae et at maiores placeat error.	Decidim::Proposals::Proposal	31	39	2017-09-13 12:47:46.228083	2017-09-13 12:47:46.228083	0	0	\N	Decidim::Proposals::Proposal	31
116	Voluptates sit dolore consequatur.	Decidim::Proposals::Proposal	31	60	2017-09-13 12:47:46.245029	2017-09-13 12:47:46.245029	0	0	\N	Decidim::Proposals::Proposal	31
117	Labore reiciendis aut quaerat laborum praesentium asperiores.	Decidim::Proposals::Proposal	31	60	2017-09-13 12:47:46.282454	2017-09-13 12:47:46.282454	0	0	\N	Decidim::Proposals::Proposal	31
118	Est velit pariatur doloribus sed non qui et consequuntur.	Decidim::Proposals::Proposal	31	17	2017-09-13 12:47:46.309856	2017-09-13 12:47:46.309856	0	0	\N	Decidim::Proposals::Proposal	31
119	Corrupti ratione nostrum omnis ex similique.	Decidim::Proposals::Proposal	32	97	2017-09-13 12:47:46.394379	2017-09-13 12:47:46.394379	0	0	\N	Decidim::Proposals::Proposal	32
120	Dolores ipsum incidunt facilis ratione nihil.	Decidim::Proposals::Proposal	33	44	2017-09-13 12:47:46.98126	2017-09-13 12:47:46.98126	0	0	\N	Decidim::Proposals::Proposal	33
121	Esse autem eius non in odit nostrum.	Decidim::Proposals::Proposal	33	5	2017-09-13 12:47:47.003758	2017-09-13 12:47:47.003758	0	0	\N	Decidim::Proposals::Proposal	33
122	Odit sed quis modi.	Decidim::Proposals::Proposal	33	71	2017-09-13 12:47:47.023898	2017-09-13 12:47:47.023898	0	0	\N	Decidim::Proposals::Proposal	33
123	Placeat error quo nobis repudiandae voluptates voluptas facilis veniam.	Decidim::Proposals::Proposal	33	92	2017-09-13 12:47:47.042924	2017-09-13 12:47:47.042924	0	0	\N	Decidim::Proposals::Proposal	33
124	Voluptatem velit a veritatis non occaecati nesciunt vitae.	Decidim::Proposals::Proposal	34	84	2017-09-13 12:47:47.56102	2017-09-13 12:47:47.56102	0	0	\N	Decidim::Proposals::Proposal	34
125	Laborum laudantium nisi molestiae est ipsa aut voluptas.	Decidim::Proposals::Proposal	34	97	2017-09-13 12:47:47.582323	2017-09-13 12:47:47.582323	0	0	\N	Decidim::Proposals::Proposal	34
126	Aliquam soluta commodi fuga totam eligendi qui aliquid sed.	Decidim::Proposals::Proposal	35	38	2017-09-13 12:47:47.846729	2017-09-13 12:47:47.846729	0	0	\N	Decidim::Proposals::Proposal	35
127	Nisi quis eius sint voluptas quaerat et ex.	Decidim::Proposals::Proposal	35	103	2017-09-13 12:47:47.865417	2017-09-13 12:47:47.865417	0	0	\N	Decidim::Proposals::Proposal	35
128	Quibusdam atque ex dolor vitae nesciunt harum rerum.	Decidim::Proposals::Proposal	35	34	2017-09-13 12:47:47.881961	2017-09-13 12:47:47.881961	0	0	\N	Decidim::Proposals::Proposal	35
129	Sit consectetur consequatur doloribus id enim qui rem qui.	Decidim::Proposals::Proposal	35	21	2017-09-13 12:47:47.89886	2017-09-13 12:47:47.89886	0	0	\N	Decidim::Proposals::Proposal	35
130	Dolores magnam assumenda fugiat accusamus rerum laudantium et.	Decidim::Proposals::Proposal	36	96	2017-09-13 12:47:48.38985	2017-09-13 12:47:48.38985	0	0	\N	Decidim::Proposals::Proposal	36
131	Ea iste autem et ut qui.	Decidim::Proposals::Proposal	37	97	2017-09-13 12:47:48.684255	2017-09-13 12:47:48.684255	0	0	\N	Decidim::Proposals::Proposal	37
132	Laudantium vel consequuntur et sint dolor voluptas voluptatum.	Decidim::Proposals::Proposal	37	58	2017-09-13 12:47:48.715018	2017-09-13 12:47:48.715018	0	0	\N	Decidim::Proposals::Proposal	37
133	Repellendus eum quis assumenda tempora.	Decidim::Proposals::Proposal	38	53	2017-09-13 12:47:49.005576	2017-09-13 12:47:49.005576	0	0	\N	Decidim::Proposals::Proposal	38
134	Dolorem ea occaecati voluptatem quam vel sed qui.	Decidim::Proposals::Proposal	38	55	2017-09-13 12:47:49.02422	2017-09-13 12:47:49.02422	0	0	\N	Decidim::Proposals::Proposal	38
135	Sequi et harum sapiente.	Decidim::Proposals::Proposal	38	43	2017-09-13 12:47:49.040777	2017-09-13 12:47:49.040777	0	0	\N	Decidim::Proposals::Proposal	38
136	Assumenda adipisci reprehenderit incidunt consequatur aut magni consequatur et.	Decidim::Proposals::Proposal	39	20	2017-09-13 12:47:49.326573	2017-09-13 12:47:49.326573	0	0	\N	Decidim::Proposals::Proposal	39
137	Aliquam voluptates quasi vel voluptas ut nihil.	Decidim::Proposals::Proposal	39	17	2017-09-13 12:47:49.359148	2017-09-13 12:47:49.359148	0	0	\N	Decidim::Proposals::Proposal	39
138	Et enim vitae minima.	Decidim::Proposals::Proposal	39	72	2017-09-13 12:47:49.376744	2017-09-13 12:47:49.376744	0	0	\N	Decidim::Proposals::Proposal	39
139	Voluptates voluptatem est veniam.	Decidim::Proposals::Proposal	39	58	2017-09-13 12:47:49.395094	2017-09-13 12:47:49.395094	0	0	\N	Decidim::Proposals::Proposal	39
140	Iusto odio vel sit quasi maxime sunt.	Decidim::Proposals::Proposal	40	38	2017-09-13 12:47:49.672619	2017-09-13 12:47:49.672619	0	0	\N	Decidim::Proposals::Proposal	40
141	Recusandae assumenda tempora aut voluptates ipsum ipsam.	Decidim::Proposals::Proposal	40	77	2017-09-13 12:47:49.691434	2017-09-13 12:47:49.691434	0	0	\N	Decidim::Proposals::Proposal	40
142	Voluptatum reiciendis a voluptatibus sint.	Decidim::Proposals::Proposal	40	60	2017-09-13 12:47:49.706768	2017-09-13 12:47:49.706768	0	0	\N	Decidim::Proposals::Proposal	40
143	Quis veniam ad assumenda pariatur officiis est mollitia.	Decidim::Proposals::Proposal	40	31	2017-09-13 12:47:49.723333	2017-09-13 12:47:49.723333	0	0	\N	Decidim::Proposals::Proposal	40
144	Rerum veritatis voluptatem et nesciunt atque.	Decidim::Proposals::Proposal	40	76	2017-09-13 12:47:49.74112	2017-09-13 12:47:49.74112	0	0	\N	Decidim::Proposals::Proposal	40
145	Excepturi cum nulla tempore.	Decidim::Results::Result	4	51	2017-09-13 12:47:49.801966	2017-09-13 12:47:49.801966	0	0	\N	Decidim::Results::Result	4
146	Quasi ex nihil sequi facilis qui.	Decidim::Results::Result	4	30	2017-09-13 12:47:49.817499	2017-09-13 12:47:49.817499	0	0	\N	Decidim::Results::Result	4
147	Eum voluptas consectetur omnis culpa ut doloremque dolore.	Decidim::Results::Result	4	78	2017-09-13 12:47:49.833311	2017-09-13 12:47:49.833311	0	0	\N	Decidim::Results::Result	4
148	Rem ut nobis perferendis esse.	Decidim::Results::Result	5	88	2017-09-13 12:47:49.879903	2017-09-13 12:47:49.879903	0	0	\N	Decidim::Results::Result	5
149	Cupiditate minima labore delectus fugiat voluptatem blanditiis.	Decidim::Results::Result	5	3	2017-09-13 12:47:49.898045	2017-09-13 12:47:49.898045	0	0	\N	Decidim::Results::Result	5
150	Libero sit quaerat iste quia rerum facilis sed.	Decidim::Results::Result	5	84	2017-09-13 12:47:49.916044	2017-09-13 12:47:49.916044	0	0	\N	Decidim::Results::Result	5
151	Dolorum maiores dolores eos tempora rerum modi itaque.	Decidim::Results::Result	5	7	2017-09-13 12:47:49.933552	2017-09-13 12:47:49.933552	0	0	\N	Decidim::Results::Result	5
152	Ipsam ea omnis autem voluptatem assumenda.	Decidim::Results::Result	5	72	2017-09-13 12:47:49.954536	2017-09-13 12:47:49.954536	0	0	\N	Decidim::Results::Result	5
153	Tenetur commodi deleniti vero harum ullam.	Decidim::Results::Result	6	72	2017-09-13 12:47:49.995865	2017-09-13 12:47:49.995865	0	0	\N	Decidim::Results::Result	6
154	Quis praesentium beatae sapiente quos veniam suscipit.	Decidim::Results::Result	6	104	2017-09-13 12:47:50.015464	2017-09-13 12:47:50.015464	0	0	\N	Decidim::Results::Result	6
155	Dolores quo consequatur quis qui.	Decidim::Results::Result	6	69	2017-09-13 12:47:50.045843	2017-09-13 12:47:50.045843	0	0	\N	Decidim::Results::Result	6
156	Ipsam eveniet in impedit sequi quo.	Decidim::Results::Result	6	40	2017-09-13 12:47:50.064491	2017-09-13 12:47:50.064491	0	0	\N	Decidim::Results::Result	6
157	Ipsa vel est sit in totam pariatur vitae.	Decidim::Budgets::Project	4	74	2017-09-13 12:47:50.2836	2017-09-13 12:47:50.2836	0	0	\N	Decidim::Budgets::Project	4
158	Quia id deleniti ut laudantium.	Decidim::Budgets::Project	4	36	2017-09-13 12:47:50.314965	2017-09-13 12:47:50.314965	0	0	\N	Decidim::Budgets::Project	4
159	Voluptatem sint similique aut non et quis voluptatem.	Decidim::Budgets::Project	4	92	2017-09-13 12:47:50.33435	2017-09-13 12:47:50.33435	0	0	\N	Decidim::Budgets::Project	4
160	Culpa optio ut ea expedita qui.	Decidim::Budgets::Project	5	22	2017-09-13 12:47:50.498397	2017-09-13 12:47:50.498397	0	0	\N	Decidim::Budgets::Project	5
161	Facilis placeat dolor delectus consequatur.	Decidim::Budgets::Project	5	30	2017-09-13 12:47:50.514872	2017-09-13 12:47:50.514872	0	0	\N	Decidim::Budgets::Project	5
162	Quidem iste temporibus voluptatem cupiditate sed sunt aut.	Decidim::Budgets::Project	6	37	2017-09-13 12:47:50.682869	2017-09-13 12:47:50.682869	0	0	\N	Decidim::Budgets::Project	6
163	Hic quasi earum eligendi qui quibusdam.	Decidim::Budgets::Project	6	54	2017-09-13 12:47:50.697649	2017-09-13 12:47:50.697649	0	0	\N	Decidim::Budgets::Project	6
164	Ut rerum eos neque rerum illum aperiam voluptas consectetur.	Decidim::Budgets::Project	6	28	2017-09-13 12:47:50.714222	2017-09-13 12:47:50.714222	0	0	\N	Decidim::Budgets::Project	6
165	Quisquam ut qui laudantium.	Decidim::Pages::Page	3	93	2017-09-13 12:47:51.575679	2017-09-13 12:47:51.575679	0	0	\N	Decidim::Pages::Page	3
166	Accusantium doloremque eos quas a dolor consequatur deleniti.	Decidim::Proposals::Proposal	41	10	2017-09-13 12:47:59.225629	2017-09-13 12:47:59.225629	0	0	\N	Decidim::Proposals::Proposal	41
167	In aliquid dolorem et.	Decidim::Proposals::Proposal	42	151	2017-09-13 12:47:59.550408	2017-09-13 12:47:59.550408	0	0	\N	Decidim::Proposals::Proposal	42
168	Voluptatum quaerat omnis assumenda facere repellat fugiat sequi ipsa.	Decidim::Proposals::Proposal	42	74	2017-09-13 12:47:59.573313	2017-09-13 12:47:59.573313	0	0	\N	Decidim::Proposals::Proposal	42
169	Fugit minus facilis enim.	Decidim::Proposals::Proposal	42	43	2017-09-13 12:47:59.596839	2017-09-13 12:47:59.596839	0	0	\N	Decidim::Proposals::Proposal	42
170	Non mollitia dolores animi.	Decidim::Proposals::Proposal	43	105	2017-09-13 12:47:59.682931	2017-09-13 12:47:59.682931	0	0	\N	Decidim::Proposals::Proposal	43
171	Eum quia inventore amet quasi ut ipsum sapiente.	Decidim::Proposals::Proposal	43	142	2017-09-13 12:47:59.708273	2017-09-13 12:47:59.708273	0	0	\N	Decidim::Proposals::Proposal	43
172	Dolorem ut dignissimos reprehenderit sed perferendis sequi cumque.	Decidim::Proposals::Proposal	43	86	2017-09-13 12:47:59.732557	2017-09-13 12:47:59.732557	0	0	\N	Decidim::Proposals::Proposal	43
173	Error tenetur voluptatibus et labore.	Decidim::Proposals::Proposal	44	52	2017-09-13 12:48:00.026727	2017-09-13 12:48:00.026727	0	0	\N	Decidim::Proposals::Proposal	44
174	Dolor voluptatibus rem reiciendis accusamus consequuntur odit aut quod.	Decidim::Proposals::Proposal	44	70	2017-09-13 12:48:00.050155	2017-09-13 12:48:00.050155	0	0	\N	Decidim::Proposals::Proposal	44
175	Sed rerum beatae quod provident mollitia possimus placeat.	Decidim::Proposals::Proposal	44	126	2017-09-13 12:48:00.084666	2017-09-13 12:48:00.084666	0	0	\N	Decidim::Proposals::Proposal	44
176	Non repudiandae suscipit nisi consequatur ipsum illo.	Decidim::Proposals::Proposal	45	15	2017-09-13 12:48:00.619926	2017-09-13 12:48:00.619926	0	0	\N	Decidim::Proposals::Proposal	45
177	Tempore debitis ullam earum unde.	Decidim::Proposals::Proposal	45	132	2017-09-13 12:48:00.641153	2017-09-13 12:48:00.641153	0	0	\N	Decidim::Proposals::Proposal	45
178	Minima molestias tempora quasi fuga.	Decidim::Proposals::Proposal	45	82	2017-09-13 12:48:00.663556	2017-09-13 12:48:00.663556	0	0	\N	Decidim::Proposals::Proposal	45
179	Unde autem inventore qui ea voluptatem tenetur.	Decidim::Proposals::Proposal	46	114	2017-09-13 12:48:00.984906	2017-09-13 12:48:00.984906	0	0	\N	Decidim::Proposals::Proposal	46
180	Ut nobis itaque labore inventore pariatur.	Decidim::Proposals::Proposal	46	150	2017-09-13 12:48:01.016643	2017-09-13 12:48:01.016643	0	0	\N	Decidim::Proposals::Proposal	46
181	Possimus quia aut et sed hic perspiciatis corrupti.	Decidim::Proposals::Proposal	47	98	2017-09-13 12:48:01.331978	2017-09-13 12:48:01.331978	0	0	\N	Decidim::Proposals::Proposal	47
182	Rerum et quisquam totam quasi debitis nisi.	Decidim::Proposals::Proposal	48	1	2017-09-13 12:48:01.40571	2017-09-13 12:48:01.40571	0	0	2	Decidim::Proposals::Proposal	48
183	Consequatur autem qui libero eius voluptatem.	Decidim::Proposals::Proposal	48	15	2017-09-13 12:48:01.435582	2017-09-13 12:48:01.435582	0	0	\N	Decidim::Proposals::Proposal	48
184	Sed voluptatem quasi quos enim voluptatem consequatur.	Decidim::Proposals::Proposal	48	107	2017-09-13 12:48:01.457411	2017-09-13 12:48:01.457411	0	0	\N	Decidim::Proposals::Proposal	48
185	Numquam laborum quis incidunt aut deserunt maiores.	Decidim::Proposals::Proposal	48	84	2017-09-13 12:48:01.48203	2017-09-13 12:48:01.48203	0	0	\N	Decidim::Proposals::Proposal	48
186	Ipsum autem doloribus consequatur rerum voluptatem et quia voluptate.	Decidim::Proposals::Proposal	49	26	2017-09-13 12:48:01.815791	2017-09-13 12:48:01.815791	0	0	\N	Decidim::Proposals::Proposal	49
187	Quaerat ipsa iusto non sapiente perferendis iste reprehenderit magni.	Decidim::Proposals::Proposal	49	12	2017-09-13 12:48:01.850682	2017-09-13 12:48:01.850682	0	0	\N	Decidim::Proposals::Proposal	49
188	Qui vero maxime occaecati voluptatibus quia veniam.	Decidim::Proposals::Proposal	49	65	2017-09-13 12:48:01.884604	2017-09-13 12:48:01.884604	0	0	\N	Decidim::Proposals::Proposal	49
189	Rerum minus autem et amet at.	Decidim::Proposals::Proposal	49	61	2017-09-13 12:48:01.916252	2017-09-13 12:48:01.916252	0	0	\N	Decidim::Proposals::Proposal	49
190	Deleniti velit amet non voluptatem.	Decidim::Proposals::Proposal	49	107	2017-09-13 12:48:01.95041	2017-09-13 12:48:01.95041	0	0	\N	Decidim::Proposals::Proposal	49
191	Quisquam quae beatae sit et.	Decidim::Proposals::Proposal	50	70	2017-09-13 12:48:02.492307	2017-09-13 12:48:02.492307	0	0	\N	Decidim::Proposals::Proposal	50
192	Quis occaecati sapiente quas cupiditate nihil hic in reiciendis.	Decidim::Proposals::Proposal	50	149	2017-09-13 12:48:02.514391	2017-09-13 12:48:02.514391	0	0	\N	Decidim::Proposals::Proposal	50
193	Aut sit qui in non nostrum rerum assumenda repellat.	Decidim::Proposals::Proposal	50	92	2017-09-13 12:48:02.537203	2017-09-13 12:48:02.537203	0	0	\N	Decidim::Proposals::Proposal	50
194	Enim sed aut ut.	Decidim::Proposals::Proposal	50	121	2017-09-13 12:48:02.562331	2017-09-13 12:48:02.562331	0	0	\N	Decidim::Proposals::Proposal	50
195	Aut quod incidunt fugiat praesentium tempora.	Decidim::Proposals::Proposal	51	75	2017-09-13 12:48:03.16537	2017-09-13 12:48:03.16537	0	0	\N	Decidim::Proposals::Proposal	51
196	Distinctio blanditiis et atque ad quia.	Decidim::Proposals::Proposal	52	23	2017-09-13 12:48:03.516403	2017-09-13 12:48:03.516403	0	0	\N	Decidim::Proposals::Proposal	52
197	Molestiae sequi aut culpa ea quis ut minus.	Decidim::Proposals::Proposal	53	139	2017-09-13 12:48:04.066565	2017-09-13 12:48:04.066565	0	0	\N	Decidim::Proposals::Proposal	53
198	Dicta sint aliquam ut nulla fugiat.	Decidim::Proposals::Proposal	54	36	2017-09-13 12:48:04.6194	2017-09-13 12:48:04.6194	0	0	\N	Decidim::Proposals::Proposal	54
199	Consequuntur voluptas aut vel quae et maiores sit.	Decidim::Proposals::Proposal	54	135	2017-09-13 12:48:04.655713	2017-09-13 12:48:04.655713	0	0	\N	Decidim::Proposals::Proposal	54
200	Nemo accusantium enim amet.	Decidim::Proposals::Proposal	54	7	2017-09-13 12:48:04.678202	2017-09-13 12:48:04.678202	0	0	\N	Decidim::Proposals::Proposal	54
201	Alias quos nemo ipsum voluptatem.	Decidim::Proposals::Proposal	54	11	2017-09-13 12:48:04.712469	2017-09-13 12:48:04.712469	0	0	\N	Decidim::Proposals::Proposal	54
202	Neque consequatur sit quo ipsum sit autem.	Decidim::Proposals::Proposal	55	116	2017-09-13 12:48:05.296233	2017-09-13 12:48:05.296233	0	0	\N	Decidim::Proposals::Proposal	55
203	Atque sit exercitationem accusamus temporibus.	Decidim::Proposals::Proposal	55	86	2017-09-13 12:48:05.334914	2017-09-13 12:48:05.334914	0	0	\N	Decidim::Proposals::Proposal	55
204	Nihil temporibus aut enim quasi.	Decidim::Proposals::Proposal	55	16	2017-09-13 12:48:05.362771	2017-09-13 12:48:05.362771	0	0	\N	Decidim::Proposals::Proposal	55
205	Ab odio illo quo aut id numquam qui iure.	Decidim::Proposals::Proposal	55	167	2017-09-13 12:48:05.395273	2017-09-13 12:48:05.395273	0	0	\N	Decidim::Proposals::Proposal	55
206	Autem odio voluptas possimus qui voluptatem.	Decidim::Proposals::Proposal	56	52	2017-09-13 12:48:05.756467	2017-09-13 12:48:05.756467	0	0	\N	Decidim::Proposals::Proposal	56
207	Aut unde ut dolorem harum.	Decidim::Proposals::Proposal	56	115	2017-09-13 12:48:05.79969	2017-09-13 12:48:05.79969	0	0	\N	Decidim::Proposals::Proposal	56
208	Repudiandae ut est voluptatum earum dolores porro.	Decidim::Proposals::Proposal	56	45	2017-09-13 12:48:05.822823	2017-09-13 12:48:05.822823	0	0	\N	Decidim::Proposals::Proposal	56
209	Et sit est ut adipisci ut dolorem voluptatem.	Decidim::Proposals::Proposal	56	78	2017-09-13 12:48:05.866383	2017-09-13 12:48:05.866383	0	0	\N	Decidim::Proposals::Proposal	56
210	Neque dolor sint cupiditate qui.	Decidim::Proposals::Proposal	57	67	2017-09-13 12:48:06.218812	2017-09-13 12:48:06.218812	0	0	\N	Decidim::Proposals::Proposal	57
211	Repellendus optio mollitia hic.	Decidim::Proposals::Proposal	57	25	2017-09-13 12:48:06.24678	2017-09-13 12:48:06.24678	0	0	\N	Decidim::Proposals::Proposal	57
212	Dolor quis dolores assumenda officia.	Decidim::Proposals::Proposal	57	153	2017-09-13 12:48:06.28011	2017-09-13 12:48:06.28011	0	0	\N	Decidim::Proposals::Proposal	57
213	Occaecati ut impedit quam.	Decidim::Proposals::Proposal	57	50	2017-09-13 12:48:06.320584	2017-09-13 12:48:06.320584	0	0	\N	Decidim::Proposals::Proposal	57
214	Quos et id dolorum.	Decidim::Proposals::Proposal	57	150	2017-09-13 12:48:06.353467	2017-09-13 12:48:06.353467	0	0	\N	Decidim::Proposals::Proposal	57
215	Voluptas odio asperiores dolorem excepturi.	Decidim::Proposals::Proposal	58	162	2017-09-13 12:48:06.428804	2017-09-13 12:48:06.428804	0	0	\N	Decidim::Proposals::Proposal	58
216	Quas repudiandae eaque cumque molestiae qui modi.	Decidim::Proposals::Proposal	58	50	2017-09-13 12:48:06.44896	2017-09-13 12:48:06.44896	0	0	\N	Decidim::Proposals::Proposal	58
217	Natus quia veritatis aliquid libero vel iusto.	Decidim::Proposals::Proposal	58	29	2017-09-13 12:48:06.473305	2017-09-13 12:48:06.473305	0	0	\N	Decidim::Proposals::Proposal	58
218	Necessitatibus distinctio similique odio sequi dolore commodi ut et.	Decidim::Proposals::Proposal	58	140	2017-09-13 12:48:06.495867	2017-09-13 12:48:06.495867	0	0	\N	Decidim::Proposals::Proposal	58
219	Et ut temporibus omnis sit molestias.	Decidim::Proposals::Proposal	59	77	2017-09-13 12:48:06.802091	2017-09-13 12:48:06.802091	0	0	\N	Decidim::Proposals::Proposal	59
220	Nostrum neque ea possimus voluptatum.	Decidim::Proposals::Proposal	60	93	2017-09-13 12:48:07.382009	2017-09-13 12:48:07.382009	0	0	\N	Decidim::Proposals::Proposal	60
221	Excepturi nisi deserunt inventore.	Decidim::Proposals::Proposal	60	100	2017-09-13 12:48:07.407785	2017-09-13 12:48:07.407785	0	0	\N	Decidim::Proposals::Proposal	60
222	Voluptatibus dolorem dolores perferendis qui debitis provident et.	Decidim::Proposals::Proposal	60	61	2017-09-13 12:48:07.441499	2017-09-13 12:48:07.441499	0	0	\N	Decidim::Proposals::Proposal	60
223	Molestiae quo cum recusandae rerum natus laudantium sunt.	Decidim::Results::Result	7	2	2017-09-13 12:48:07.522708	2017-09-13 12:48:07.522708	0	0	\N	Decidim::Results::Result	7
224	Recusandae maxime aut sint.	Decidim::Results::Result	7	65	2017-09-13 12:48:07.549113	2017-09-13 12:48:07.549113	0	0	\N	Decidim::Results::Result	7
225	Vero maxime sit ducimus.	Decidim::Results::Result	7	82	2017-09-13 12:48:07.578028	2017-09-13 12:48:07.578028	0	0	\N	Decidim::Results::Result	7
226	Non vel pariatur exercitationem.	Decidim::Results::Result	8	74	2017-09-13 12:48:07.633654	2017-09-13 12:48:07.633654	0	0	\N	Decidim::Results::Result	8
227	Dolore harum repellendus consequatur.	Decidim::Results::Result	8	171	2017-09-13 12:48:07.662543	2017-09-13 12:48:07.662543	0	0	\N	Decidim::Results::Result	8
228	Voluptatum pariatur quis enim voluptatem eos.	Decidim::Results::Result	9	69	2017-09-13 12:48:07.720758	2017-09-13 12:48:07.720758	0	0	\N	Decidim::Results::Result	9
229	Voluptatum sed velit magnam.	Decidim::Results::Result	9	116	2017-09-13 12:48:07.747883	2017-09-13 12:48:07.747883	0	0	\N	Decidim::Results::Result	9
230	Accusantium mollitia odit ducimus quis id vel at ut.	Decidim::Results::Result	9	162	2017-09-13 12:48:07.781087	2017-09-13 12:48:07.781087	0	0	\N	Decidim::Results::Result	9
231	Nisi voluptatibus et quas ea inventore sed.	Decidim::Results::Result	9	39	2017-09-13 12:48:07.808563	2017-09-13 12:48:07.808563	0	0	\N	Decidim::Results::Result	9
232	Sit est itaque quasi.	Decidim::Budgets::Project	7	159	2017-09-13 12:48:08.038572	2017-09-13 12:48:08.038572	0	0	\N	Decidim::Budgets::Project	7
233	Repellat fugit placeat dolor consequatur non.	Decidim::Budgets::Project	7	171	2017-09-13 12:48:08.059701	2017-09-13 12:48:08.059701	0	0	\N	Decidim::Budgets::Project	7
234	Rerum ut recusandae nisi.	Decidim::Budgets::Project	7	156	2017-09-13 12:48:08.085667	2017-09-13 12:48:08.085667	0	0	\N	Decidim::Budgets::Project	7
235	Distinctio et cupiditate ab.	Decidim::Budgets::Project	7	58	2017-09-13 12:48:08.10925	2017-09-13 12:48:08.10925	0	0	\N	Decidim::Budgets::Project	7
236	Corporis voluptas eum dolorum quo quisquam maxime et ut.	Decidim::Budgets::Project	8	24	2017-09-13 12:48:08.360614	2017-09-13 12:48:08.360614	0	0	\N	Decidim::Budgets::Project	8
237	Autem eum libero voluptas quisquam quia.	Decidim::Budgets::Project	9	130	2017-09-13 12:48:08.570342	2017-09-13 12:48:08.570342	0	0	\N	Decidim::Budgets::Project	9
238	Facilis ut aut nihil.	Decidim::Budgets::Project	9	142	2017-09-13 12:48:08.603838	2017-09-13 12:48:08.603838	0	0	\N	Decidim::Budgets::Project	9
239	Totam et ex optio nihil.	Decidim::Pages::Page	4	92	2017-09-13 12:48:09.734419	2017-09-13 12:48:09.734419	0	0	\N	Decidim::Pages::Page	4
240	Exercitationem delectus mollitia incidunt ut vitae error ullam.	Decidim::Pages::Page	4	77	2017-09-13 12:48:09.760769	2017-09-13 12:48:09.760769	0	0	\N	Decidim::Pages::Page	4
241	Sit nulla quos natus quia repellat cupiditate molestiae ipsam.	Decidim::Pages::Page	4	79	2017-09-13 12:48:09.793385	2017-09-13 12:48:09.793385	0	0	\N	Decidim::Pages::Page	4
242	Saepe non voluptatibus deleniti ea aut dolor accusamus esse.	Decidim::Proposals::Proposal	61	180	2017-09-13 12:48:17.61414	2017-09-13 12:48:17.61414	0	0	\N	Decidim::Proposals::Proposal	61
243	Hic voluptatibus ipsum delectus eligendi.	Decidim::Proposals::Proposal	61	39	2017-09-13 12:48:17.639521	2017-09-13 12:48:17.639521	0	0	\N	Decidim::Proposals::Proposal	61
244	Fugiat dolore deleniti alias animi quod.	Decidim::Proposals::Proposal	61	129	2017-09-13 12:48:17.669358	2017-09-13 12:48:17.669358	0	0	\N	Decidim::Proposals::Proposal	61
245	Vel sequi sunt recusandae saepe harum mollitia non ut.	Decidim::Proposals::Proposal	61	114	2017-09-13 12:48:17.69606	2017-09-13 12:48:17.69606	0	0	\N	Decidim::Proposals::Proposal	61
246	Et suscipit et esse impedit fugiat cupiditate ducimus.	Decidim::Proposals::Proposal	61	106	2017-09-13 12:48:17.724554	2017-09-13 12:48:17.724554	0	0	\N	Decidim::Proposals::Proposal	61
247	Velit dolores non eligendi laudantium nihil quasi sequi.	Decidim::Proposals::Proposal	62	101	2017-09-13 12:48:17.794293	2017-09-13 12:48:17.794293	0	0	\N	Decidim::Proposals::Proposal	62
248	Praesentium unde commodi autem rerum nihil modi quo.	Decidim::Proposals::Proposal	63	123	2017-09-13 12:48:18.075436	2017-09-13 12:48:18.075436	0	0	\N	Decidim::Proposals::Proposal	63
249	Praesentium libero voluptatibus sunt nostrum adipisci.	Decidim::Proposals::Proposal	63	12	2017-09-13 12:48:18.096807	2017-09-13 12:48:18.096807	0	0	\N	Decidim::Proposals::Proposal	63
250	Blanditiis quod aperiam sit.	Decidim::Proposals::Proposal	63	120	2017-09-13 12:48:18.118474	2017-09-13 12:48:18.118474	0	0	\N	Decidim::Proposals::Proposal	63
251	Laborum modi itaque autem molestiae sint nesciunt dolorem repudiandae.	Decidim::Proposals::Proposal	63	146	2017-09-13 12:48:18.138062	2017-09-13 12:48:18.138062	0	0	\N	Decidim::Proposals::Proposal	63
252	Animi quo recusandae amet ipsam sapiente corrupti.	Decidim::Proposals::Proposal	64	68	2017-09-13 12:48:18.604152	2017-09-13 12:48:18.604152	0	0	\N	Decidim::Proposals::Proposal	64
253	Quia mollitia ullam est fugit velit aut odio.	Decidim::Proposals::Proposal	65	63	2017-09-13 12:48:18.657407	2017-09-13 12:48:18.657407	0	0	\N	Decidim::Proposals::Proposal	65
254	Suscipit aut ipsum non officia quasi ducimus aliquid nulla.	Decidim::Proposals::Proposal	65	4	2017-09-13 12:48:18.679498	2017-09-13 12:48:18.679498	0	0	\N	Decidim::Proposals::Proposal	65
255	Laboriosam sit blanditiis tempora recusandae.	Decidim::Proposals::Proposal	66	118	2017-09-13 12:48:18.956668	2017-09-13 12:48:18.956668	0	0	\N	Decidim::Proposals::Proposal	66
256	Eum in voluptate tenetur ut.	Decidim::Proposals::Proposal	67	146	2017-09-13 12:48:19.2589	2017-09-13 12:48:19.2589	0	0	\N	Decidim::Proposals::Proposal	67
257	Eveniet maiores quia quia.	Decidim::Proposals::Proposal	67	87	2017-09-13 12:48:19.2832	2017-09-13 12:48:19.2832	0	0	\N	Decidim::Proposals::Proposal	67
258	Corrupti repellendus quidem voluptatem excepturi dolore recusandae.	Decidim::Proposals::Proposal	67	55	2017-09-13 12:48:19.306642	2017-09-13 12:48:19.306642	0	0	\N	Decidim::Proposals::Proposal	67
259	Magni omnis sed qui sequi.	Decidim::Proposals::Proposal	68	100	2017-09-13 12:48:19.356255	2017-09-13 12:48:19.356255	0	0	\N	Decidim::Proposals::Proposal	68
260	Neque quis aut est aut ipsam.	Decidim::Proposals::Proposal	69	84	2017-09-13 12:48:19.627988	2017-09-13 12:48:19.627988	0	0	\N	Decidim::Proposals::Proposal	69
261	Enim deserunt ea necessitatibus esse aperiam aliquam cumque.	Decidim::Proposals::Proposal	69	199	2017-09-13 12:48:19.651266	2017-09-13 12:48:19.651266	0	0	\N	Decidim::Proposals::Proposal	69
262	Accusantium repellat qui aliquam repudiandae quia.	Decidim::Proposals::Proposal	69	46	2017-09-13 12:48:19.671346	2017-09-13 12:48:19.671346	0	0	\N	Decidim::Proposals::Proposal	69
263	Minima et quia quibusdam neque.	Decidim::Proposals::Proposal	70	14	2017-09-13 12:48:19.93881	2017-09-13 12:48:19.93881	0	0	\N	Decidim::Proposals::Proposal	70
264	Necessitatibus vitae veniam voluptatem.	Decidim::Proposals::Proposal	70	34	2017-09-13 12:48:19.959983	2017-09-13 12:48:19.959983	0	0	\N	Decidim::Proposals::Proposal	70
265	Laborum veritatis ipsa labore reprehenderit mollitia aut.	Decidim::Proposals::Proposal	70	167	2017-09-13 12:48:19.981841	2017-09-13 12:48:19.981841	0	0	\N	Decidim::Proposals::Proposal	70
266	Ipsa voluptatem qui quaerat ducimus rem ut voluptatibus.	Decidim::Proposals::Proposal	70	186	2017-09-13 12:48:20.002153	2017-09-13 12:48:20.002153	0	0	\N	Decidim::Proposals::Proposal	70
267	Quis voluptatum sit delectus in.	Decidim::Proposals::Proposal	71	130	2017-09-13 12:48:20.504926	2017-09-13 12:48:20.504926	0	0	\N	Decidim::Proposals::Proposal	71
268	Voluptatem ut autem et esse perspiciatis.	Decidim::Proposals::Proposal	72	122	2017-09-13 12:48:20.786693	2017-09-13 12:48:20.786693	0	0	\N	Decidim::Proposals::Proposal	72
269	Qui quas recusandae minima aut.	Decidim::Proposals::Proposal	72	18	2017-09-13 12:48:20.808446	2017-09-13 12:48:20.808446	0	0	\N	Decidim::Proposals::Proposal	72
270	Quis impedit voluptatibus veritatis officia excepturi totam.	Decidim::Proposals::Proposal	72	140	2017-09-13 12:48:20.830158	2017-09-13 12:48:20.830158	0	0	\N	Decidim::Proposals::Proposal	72
271	Omnis et adipisci voluptas.	Decidim::Proposals::Proposal	72	22	2017-09-13 12:48:20.862934	2017-09-13 12:48:20.862934	0	0	\N	Decidim::Proposals::Proposal	72
272	Dolorem molestiae corrupti soluta deserunt.	Decidim::Proposals::Proposal	73	22	2017-09-13 12:48:21.140437	2017-09-13 12:48:21.140437	0	0	\N	Decidim::Proposals::Proposal	73
273	Aperiam ipsam sit eum officiis.	Decidim::Proposals::Proposal	73	153	2017-09-13 12:48:21.168281	2017-09-13 12:48:21.168281	0	0	\N	Decidim::Proposals::Proposal	73
274	Aliquam non quia distinctio quia vero aspernatur qui.	Decidim::Proposals::Proposal	73	178	2017-09-13 12:48:21.190669	2017-09-13 12:48:21.190669	0	0	\N	Decidim::Proposals::Proposal	73
275	Nesciunt quae ad nihil.	Decidim::Proposals::Proposal	74	42	2017-09-13 12:48:21.694517	2017-09-13 12:48:21.694517	0	0	\N	Decidim::Proposals::Proposal	74
276	Eligendi occaecati voluptatem expedita necessitatibus.	Decidim::Proposals::Proposal	75	130	2017-09-13 12:48:21.992617	2017-09-13 12:48:21.992617	0	0	\N	Decidim::Proposals::Proposal	75
277	In et vero sequi laudantium incidunt ad iure.	Decidim::Proposals::Proposal	75	149	2017-09-13 12:48:22.015243	2017-09-13 12:48:22.015243	0	0	\N	Decidim::Proposals::Proposal	75
278	Vel ipsum et magnam.	Decidim::Proposals::Proposal	75	157	2017-09-13 12:48:22.03577	2017-09-13 12:48:22.03577	0	0	\N	Decidim::Proposals::Proposal	75
279	Laboriosam saepe autem praesentium.	Decidim::Proposals::Proposal	75	192	2017-09-13 12:48:22.057903	2017-09-13 12:48:22.057903	0	0	\N	Decidim::Proposals::Proposal	75
280	Delectus earum sint esse.	Decidim::Proposals::Proposal	76	9	2017-09-13 12:48:22.328306	2017-09-13 12:48:22.328306	0	0	\N	Decidim::Proposals::Proposal	76
281	Eligendi illo ut molestias est ducimus ea tenetur ea.	Decidim::Proposals::Proposal	76	37	2017-09-13 12:48:22.356492	2017-09-13 12:48:22.356492	0	0	\N	Decidim::Proposals::Proposal	76
282	Dolorum animi delectus est autem.	Decidim::Proposals::Proposal	77	5	2017-09-13 12:48:22.849273	2017-09-13 12:48:22.849273	0	0	\N	Decidim::Proposals::Proposal	77
283	Sequi non excepturi explicabo odio ut accusamus.	Decidim::Proposals::Proposal	77	212	2017-09-13 12:48:22.873986	2017-09-13 12:48:22.873986	0	0	\N	Decidim::Proposals::Proposal	77
284	Sed sequi asperiores voluptas officia fuga.	Decidim::Proposals::Proposal	77	98	2017-09-13 12:48:22.901941	2017-09-13 12:48:22.901941	0	0	\N	Decidim::Proposals::Proposal	77
285	Non magnam laboriosam architecto.	Decidim::Proposals::Proposal	77	60	2017-09-13 12:48:22.934394	2017-09-13 12:48:22.934394	0	0	\N	Decidim::Proposals::Proposal	77
286	Quis pariatur aut non assumenda omnis aut.	Decidim::Proposals::Proposal	77	95	2017-09-13 12:48:22.960698	2017-09-13 12:48:22.960698	0	0	\N	Decidim::Proposals::Proposal	77
287	Voluptas eaque neque quam distinctio culpa quia rerum a.	Decidim::Proposals::Proposal	78	41	2017-09-13 12:48:23.292059	2017-09-13 12:48:23.292059	0	0	\N	Decidim::Proposals::Proposal	78
288	Natus velit autem non dolores.	Decidim::Proposals::Proposal	78	223	2017-09-13 12:48:23.32682	2017-09-13 12:48:23.32682	0	0	\N	Decidim::Proposals::Proposal	78
289	Reprehenderit amet est aut asperiores molestiae.	Decidim::Proposals::Proposal	78	204	2017-09-13 12:48:23.354032	2017-09-13 12:48:23.354032	0	0	\N	Decidim::Proposals::Proposal	78
290	Veniam ipsum non cum quia molestias earum consectetur quis.	Decidim::Proposals::Proposal	78	118	2017-09-13 12:48:23.38755	2017-09-13 12:48:23.38755	0	0	\N	Decidim::Proposals::Proposal	78
291	Accusamus cupiditate hic omnis et.	Decidim::Proposals::Proposal	79	71	2017-09-13 12:48:23.464202	2017-09-13 12:48:23.464202	0	0	\N	Decidim::Proposals::Proposal	79
292	Nostrum assumenda voluptatem eos nemo.	Decidim::Proposals::Proposal	79	165	2017-09-13 12:48:23.496297	2017-09-13 12:48:23.496297	0	0	\N	Decidim::Proposals::Proposal	79
293	Nemo voluptatem sunt aut iusto rem.	Decidim::Proposals::Proposal	80	23	2017-09-13 12:48:23.768162	2017-09-13 12:48:23.768162	0	0	\N	Decidim::Proposals::Proposal	80
294	Error tempore voluptatem voluptas velit rerum est.	Decidim::Results::Result	10	146	2017-09-13 12:48:23.830116	2017-09-13 12:48:23.830116	0	0	\N	Decidim::Results::Result	10
295	Quia cum est doloremque qui modi quo quas.	Decidim::Results::Result	10	112	2017-09-13 12:48:23.852659	2017-09-13 12:48:23.852659	0	0	\N	Decidim::Results::Result	10
296	Eum iste earum perferendis odio.	Decidim::Results::Result	11	220	2017-09-13 12:48:23.895617	2017-09-13 12:48:23.895617	0	0	\N	Decidim::Results::Result	11
297	Placeat ut quis est temporibus qui dolores cum.	Decidim::Results::Result	12	178	2017-09-13 12:48:23.947265	2017-09-13 12:48:23.947265	0	0	\N	Decidim::Results::Result	12
298	Quasi quis quo dignissimos eum quisquam omnis sint atque.	Decidim::Results::Result	12	11	2017-09-13 12:48:23.969115	2017-09-13 12:48:23.969115	0	0	\N	Decidim::Results::Result	12
299	Impedit accusantium reiciendis blanditiis rerum officia.	Decidim::Results::Result	12	17	2017-09-13 12:48:23.990933	2017-09-13 12:48:23.990933	0	0	\N	Decidim::Results::Result	12
300	Minus illum et aut libero earum cupiditate tempore.	Decidim::Results::Result	12	203	2017-09-13 12:48:24.01365	2017-09-13 12:48:24.01365	0	0	\N	Decidim::Results::Result	12
301	Temporibus perferendis rerum nulla sunt eos ullam fugiat deserunt.	Decidim::Budgets::Project	10	52	2017-09-13 12:48:24.225982	2017-09-13 12:48:24.225982	0	0	\N	Decidim::Budgets::Project	10
302	Enim molestias modi sint dolorem ipsa magni reprehenderit consequatur.	Decidim::Budgets::Project	10	78	2017-09-13 12:48:24.247999	2017-09-13 12:48:24.247999	0	0	\N	Decidim::Budgets::Project	10
303	Eos possimus et tempora aut nemo voluptas.	Decidim::Budgets::Project	10	222	2017-09-13 12:48:24.270379	2017-09-13 12:48:24.270379	0	0	\N	Decidim::Budgets::Project	10
304	Assumenda aspernatur nisi optio.	Decidim::Budgets::Project	10	124	2017-09-13 12:48:24.29228	2017-09-13 12:48:24.29228	0	0	\N	Decidim::Budgets::Project	10
305	Expedita culpa beatae nihil alias at aut.	Decidim::Budgets::Project	11	100	2017-09-13 12:48:24.486467	2017-09-13 12:48:24.486467	0	0	\N	Decidim::Budgets::Project	11
306	Eius earum perferendis ut.	Decidim::Budgets::Project	12	115	2017-09-13 12:48:24.680379	2017-09-13 12:48:24.680379	0	0	\N	Decidim::Budgets::Project	12
307	Minima pariatur nemo eos in excepturi qui libero.	Decidim::Budgets::Project	12	212	2017-09-13 12:48:24.708256	2017-09-13 12:48:24.708256	0	0	\N	Decidim::Budgets::Project	12
308	Sit ut autem voluptas aut enim aspernatur.	Decidim::Budgets::Project	12	207	2017-09-13 12:48:24.734119	2017-09-13 12:48:24.734119	0	0	\N	Decidim::Budgets::Project	12
309	Dolore non qui deserunt incidunt ut debitis et.	Decidim::Pages::Page	5	116	2017-09-13 12:48:24.973294	2017-09-13 12:48:24.973294	0	0	\N	Decidim::Pages::Page	5
310	Ex ea et dolores id.	Decidim::Proposals::Proposal	81	235	2017-09-13 12:48:32.328804	2017-09-13 12:48:32.328804	0	0	\N	Decidim::Proposals::Proposal	81
311	Nemo quae quia facilis placeat temporibus.	Decidim::Proposals::Proposal	81	88	2017-09-13 12:48:32.360322	2017-09-13 12:48:32.360322	0	0	\N	Decidim::Proposals::Proposal	81
312	Repellat id blanditiis ab consequatur rerum quidem distinctio.	Decidim::Proposals::Proposal	81	155	2017-09-13 12:48:32.385395	2017-09-13 12:48:32.385395	0	0	\N	Decidim::Proposals::Proposal	81
313	Sequi quam iusto labore temporibus aut tenetur.	Decidim::Proposals::Proposal	81	70	2017-09-13 12:48:32.416065	2017-09-13 12:48:32.416065	0	0	\N	Decidim::Proposals::Proposal	81
314	Repellendus in corrupti commodi.	Decidim::Proposals::Proposal	82	118	2017-09-13 12:48:32.710969	2017-09-13 12:48:32.710969	0	0	\N	Decidim::Proposals::Proposal	82
315	Et est eveniet ut voluptate tenetur.	Decidim::Proposals::Proposal	83	102	2017-09-13 12:48:33.02543	2017-09-13 12:48:33.02543	0	0	\N	Decidim::Proposals::Proposal	83
316	Fugiat ea recusandae et.	Decidim::Proposals::Proposal	83	31	2017-09-13 12:48:33.05357	2017-09-13 12:48:33.05357	0	0	\N	Decidim::Proposals::Proposal	83
317	Sed dolore veritatis optio dolores.	Decidim::Proposals::Proposal	83	87	2017-09-13 12:48:33.076198	2017-09-13 12:48:33.076198	0	0	\N	Decidim::Proposals::Proposal	83
318	Sunt nam voluptas aut.	Decidim::Proposals::Proposal	83	7	2017-09-13 12:48:33.105873	2017-09-13 12:48:33.105873	0	0	\N	Decidim::Proposals::Proposal	83
319	In ullam dolor nobis aut enim et accusantium.	Decidim::Proposals::Proposal	84	208	2017-09-13 12:48:33.40576	2017-09-13 12:48:33.40576	0	0	\N	Decidim::Proposals::Proposal	84
320	Consectetur officia quaerat sit praesentium voluptas earum ullam.	Decidim::Proposals::Proposal	84	238	2017-09-13 12:48:33.429498	2017-09-13 12:48:33.429498	0	0	\N	Decidim::Proposals::Proposal	84
321	Aut voluptas pariatur id.	Decidim::Proposals::Proposal	84	90	2017-09-13 12:48:33.460159	2017-09-13 12:48:33.460159	0	0	\N	Decidim::Proposals::Proposal	84
322	Aut quibusdam dolor distinctio architecto officiis culpa facilis velit.	Decidim::Proposals::Proposal	85	70	2017-09-13 12:48:33.74627	2017-09-13 12:48:33.74627	0	0	\N	Decidim::Proposals::Proposal	85
323	Repudiandae ut recusandae nulla sit est dolor sed.	Decidim::Proposals::Proposal	85	112	2017-09-13 12:48:33.771448	2017-09-13 12:48:33.771448	0	0	\N	Decidim::Proposals::Proposal	85
324	Sit sequi eos aliquam eveniet sint dolores eum voluptatem.	Decidim::Proposals::Proposal	85	23	2017-09-13 12:48:33.808845	2017-09-13 12:48:33.808845	0	0	\N	Decidim::Proposals::Proposal	85
325	Aperiam quis cumque hic.	Decidim::Proposals::Proposal	86	238	2017-09-13 12:48:33.8894	2017-09-13 12:48:33.8894	0	0	\N	Decidim::Proposals::Proposal	86
326	Vel id omnis cumque dolores ipsum rerum mollitia corporis.	Decidim::Proposals::Proposal	86	164	2017-09-13 12:48:33.922216	2017-09-13 12:48:33.922216	0	0	\N	Decidim::Proposals::Proposal	86
327	Modi quo consequuntur libero.	Decidim::Proposals::Proposal	86	15	2017-09-13 12:48:33.94729	2017-09-13 12:48:33.94729	0	0	\N	Decidim::Proposals::Proposal	86
328	Tempora neque id consequatur labore.	Decidim::Proposals::Proposal	86	18	2017-09-13 12:48:33.973222	2017-09-13 12:48:33.973222	0	0	\N	Decidim::Proposals::Proposal	86
329	Dignissimos cupiditate beatae suscipit culpa aut non qui.	Decidim::Proposals::Proposal	86	168	2017-09-13 12:48:33.99779	2017-09-13 12:48:33.99779	0	0	\N	Decidim::Proposals::Proposal	86
330	Vel deserunt voluptas delectus est dolores placeat.	Decidim::Proposals::Proposal	87	149	2017-09-13 12:48:34.074239	2017-09-13 12:48:34.074239	0	0	\N	Decidim::Proposals::Proposal	87
331	Quos perspiciatis officiis blanditiis recusandae consequatur incidunt necessitatibus modi.	Decidim::Proposals::Proposal	87	76	2017-09-13 12:48:34.100518	2017-09-13 12:48:34.100518	0	0	\N	Decidim::Proposals::Proposal	87
332	Sint fugit vel omnis ut mollitia.	Decidim::Proposals::Proposal	87	217	2017-09-13 12:48:34.125754	2017-09-13 12:48:34.125754	0	0	\N	Decidim::Proposals::Proposal	87
333	Magni quod veritatis id.	Decidim::Proposals::Proposal	87	136	2017-09-13 12:48:34.15258	2017-09-13 12:48:34.15258	0	0	\N	Decidim::Proposals::Proposal	87
334	Enim officia similique voluptas quia voluptatum corrupti ut.	Decidim::Proposals::Proposal	88	169	2017-09-13 12:48:34.690992	2017-09-13 12:48:34.690992	0	0	\N	Decidim::Proposals::Proposal	88
335	Rerum dolore modi quod omnis quibusdam porro explicabo neque.	Decidim::Proposals::Proposal	88	58	2017-09-13 12:48:34.7138	2017-09-13 12:48:34.7138	0	0	\N	Decidim::Proposals::Proposal	88
336	Omnis minima harum molestiae omnis voluptas.	Decidim::Proposals::Proposal	88	100	2017-09-13 12:48:34.736386	2017-09-13 12:48:34.736386	0	0	\N	Decidim::Proposals::Proposal	88
337	Natus exercitationem velit id laborum reiciendis possimus.	Decidim::Proposals::Proposal	89	15	2017-09-13 12:48:35.233194	2017-09-13 12:48:35.233194	0	0	\N	Decidim::Proposals::Proposal	89
338	Voluptates non natus molestiae possimus ea.	Decidim::Proposals::Proposal	89	256	2017-09-13 12:48:35.256658	2017-09-13 12:48:35.256658	0	0	\N	Decidim::Proposals::Proposal	89
339	Delectus mollitia enim ducimus voluptates.	Decidim::Proposals::Proposal	89	72	2017-09-13 12:48:35.284652	2017-09-13 12:48:35.284652	0	0	\N	Decidim::Proposals::Proposal	89
340	Eveniet cum doloribus et ut fuga id.	Decidim::Proposals::Proposal	89	250	2017-09-13 12:48:35.315469	2017-09-13 12:48:35.315469	0	0	\N	Decidim::Proposals::Proposal	89
341	Et est provident doloribus consequatur aperiam deserunt qui corrupti.	Decidim::Proposals::Proposal	89	68	2017-09-13 12:48:35.339811	2017-09-13 12:48:35.339811	0	0	\N	Decidim::Proposals::Proposal	89
342	Dolore consequatur tempore animi.	Decidim::Proposals::Proposal	90	29	2017-09-13 12:48:35.89308	2017-09-13 12:48:35.89308	0	0	\N	Decidim::Proposals::Proposal	90
343	Beatae aut ut voluptas.	Decidim::Proposals::Proposal	90	151	2017-09-13 12:48:35.916181	2017-09-13 12:48:35.916181	0	0	\N	Decidim::Proposals::Proposal	90
344	Minima odit autem doloribus excepturi sunt omnis labore.	Decidim::Proposals::Proposal	91	115	2017-09-13 12:48:36.409745	2017-09-13 12:48:36.409745	0	0	\N	Decidim::Proposals::Proposal	91
345	Voluptas vero aut esse aut eum quidem.	Decidim::Proposals::Proposal	91	175	2017-09-13 12:48:36.43274	2017-09-13 12:48:36.43274	0	0	\N	Decidim::Proposals::Proposal	91
346	Maiores nesciunt non tempore dolores porro molestias dolores.	Decidim::Proposals::Proposal	91	163	2017-09-13 12:48:36.463036	2017-09-13 12:48:36.463036	0	0	\N	Decidim::Proposals::Proposal	91
347	Velit tempora laborum harum ducimus qui cupiditate quos veritatis.	Decidim::Proposals::Proposal	91	221	2017-09-13 12:48:36.487933	2017-09-13 12:48:36.487933	0	0	\N	Decidim::Proposals::Proposal	91
348	Qui excepturi esse saepe voluptatem voluptatem asperiores laboriosam.	Decidim::Proposals::Proposal	92	216	2017-09-13 12:48:36.562665	2017-09-13 12:48:36.562665	0	0	\N	Decidim::Proposals::Proposal	92
349	Neque recusandae ut accusantium tenetur vero odio illum.	Decidim::Proposals::Proposal	92	147	2017-09-13 12:48:36.587848	2017-09-13 12:48:36.587848	0	0	\N	Decidim::Proposals::Proposal	92
350	Aspernatur a cupiditate odio.	Decidim::Proposals::Proposal	93	43	2017-09-13 12:48:37.073469	2017-09-13 12:48:37.073469	0	0	\N	Decidim::Proposals::Proposal	93
351	Facilis et iste eius ut et quaerat maiores ea.	Decidim::Proposals::Proposal	94	80	2017-09-13 12:48:37.587093	2017-09-13 12:48:37.587093	0	0	\N	Decidim::Proposals::Proposal	94
352	Sed ut totam ut.	Decidim::Proposals::Proposal	94	104	2017-09-13 12:48:37.614937	2017-09-13 12:48:37.614937	0	0	\N	Decidim::Proposals::Proposal	94
353	Animi voluptatem voluptas neque.	Decidim::Proposals::Proposal	94	256	2017-09-13 12:48:37.647772	2017-09-13 12:48:37.647772	0	0	\N	Decidim::Proposals::Proposal	94
354	Mollitia quasi tempore eveniet.	Decidim::Proposals::Proposal	94	60	2017-09-13 12:48:37.676093	2017-09-13 12:48:37.676093	0	0	\N	Decidim::Proposals::Proposal	94
355	Est eos consequatur quia.	Decidim::Proposals::Proposal	95	213	2017-09-13 12:48:38.19732	2017-09-13 12:48:38.19732	0	0	\N	Decidim::Proposals::Proposal	95
356	Nemo nesciunt officiis corporis.	Decidim::Proposals::Proposal	96	97	2017-09-13 12:48:38.266746	2017-09-13 12:48:38.266746	0	0	\N	Decidim::Proposals::Proposal	96
357	Doloribus voluptate et placeat iste blanditiis sit.	Decidim::Proposals::Proposal	97	47	2017-09-13 12:48:38.33492	2017-09-13 12:48:38.33492	0	0	\N	Decidim::Proposals::Proposal	97
358	Dignissimos doloribus dolores est.	Decidim::Proposals::Proposal	97	32	2017-09-13 12:48:38.360586	2017-09-13 12:48:38.360586	0	0	\N	Decidim::Proposals::Proposal	97
359	Tempore voluptatem est quo dicta.	Decidim::Proposals::Proposal	98	74	2017-09-13 12:48:38.635398	2017-09-13 12:48:38.635398	0	0	\N	Decidim::Proposals::Proposal	98
360	Accusantium laudantium eos et quibusdam vero placeat repudiandae.	Decidim::Proposals::Proposal	98	19	2017-09-13 12:48:38.658828	2017-09-13 12:48:38.658828	0	0	\N	Decidim::Proposals::Proposal	98
361	Illum ipsam dolorem aut.	Decidim::Proposals::Proposal	98	85	2017-09-13 12:48:38.701332	2017-09-13 12:48:38.701332	0	0	\N	Decidim::Proposals::Proposal	98
362	Et accusantium aut ut omnis nulla.	Decidim::Proposals::Proposal	98	117	2017-09-13 12:48:38.725834	2017-09-13 12:48:38.725834	0	0	\N	Decidim::Proposals::Proposal	98
363	Maxime optio id est beatae.	Decidim::Proposals::Proposal	99	249	2017-09-13 12:48:39.241892	2017-09-13 12:48:39.241892	0	0	\N	Decidim::Proposals::Proposal	99
364	In consequatur fuga voluptatem.	Decidim::Proposals::Proposal	99	47	2017-09-13 12:48:39.268744	2017-09-13 12:48:39.268744	0	0	\N	Decidim::Proposals::Proposal	99
365	Voluptate harum debitis dolor nobis ducimus cumque deserunt.	Decidim::Proposals::Proposal	99	62	2017-09-13 12:48:39.293155	2017-09-13 12:48:39.293155	0	0	\N	Decidim::Proposals::Proposal	99
366	Consectetur sit eos commodi labore ipsa et animi.	Decidim::Proposals::Proposal	99	165	2017-09-13 12:48:39.319284	2017-09-13 12:48:39.319284	0	0	\N	Decidim::Proposals::Proposal	99
367	Iusto temporibus pariatur itaque.	Decidim::Proposals::Proposal	99	256	2017-09-13 12:48:39.35961	2017-09-13 12:48:39.35961	0	0	\N	Decidim::Proposals::Proposal	99
368	Doloribus expedita quam sed.	Decidim::Proposals::Proposal	100	112	2017-09-13 12:48:39.706791	2017-09-13 12:48:39.706791	0	0	\N	Decidim::Proposals::Proposal	100
369	Exercitationem adipisci distinctio qui dolorem optio rerum id.	Decidim::Proposals::Proposal	100	14	2017-09-13 12:48:39.737165	2017-09-13 12:48:39.737165	0	0	\N	Decidim::Proposals::Proposal	100
370	Sint quod totam nam est veritatis nobis vitae et.	Decidim::Proposals::Proposal	100	95	2017-09-13 12:48:39.764919	2017-09-13 12:48:39.764919	0	0	\N	Decidim::Proposals::Proposal	100
371	Amet suscipit perspiciatis molestias sapiente aliquam.	Decidim::Results::Result	13	129	2017-09-13 12:48:39.837174	2017-09-13 12:48:39.837174	0	0	\N	Decidim::Results::Result	13
372	Earum debitis quasi assumenda et cupiditate dolore recusandae nemo.	Decidim::Results::Result	13	158	2017-09-13 12:48:39.869144	2017-09-13 12:48:39.869144	0	0	\N	Decidim::Results::Result	13
373	Tenetur quia quis quos est facilis animi.	Decidim::Results::Result	13	259	2017-09-13 12:48:39.897363	2017-09-13 12:48:39.897363	0	0	\N	Decidim::Results::Result	13
374	Nam quos rem aut in maiores tempora.	Decidim::Results::Result	14	9	2017-09-13 12:48:39.952562	2017-09-13 12:48:39.952562	0	0	\N	Decidim::Results::Result	14
375	Aliquam eum expedita sint mollitia dolor tenetur voluptas.	Decidim::Results::Result	14	76	2017-09-13 12:48:39.97867	2017-09-13 12:48:39.97867	0	0	\N	Decidim::Results::Result	14
376	Ea reiciendis fugit dicta qui id aspernatur quia.	Decidim::Results::Result	14	40	2017-09-13 12:48:40.008448	2017-09-13 12:48:40.008448	0	0	\N	Decidim::Results::Result	14
377	Temporibus amet voluptatum dolor laboriosam voluptatibus ullam quidem.	Decidim::Results::Result	14	241	2017-09-13 12:48:40.037789	2017-09-13 12:48:40.037789	0	0	\N	Decidim::Results::Result	14
378	Temporibus neque rerum ut beatae.	Decidim::Results::Result	14	212	2017-09-13 12:48:40.061075	2017-09-13 12:48:40.061075	0	0	\N	Decidim::Results::Result	14
379	Itaque molestiae blanditiis ut ducimus nisi.	Decidim::Results::Result	15	233	2017-09-13 12:48:40.121886	2017-09-13 12:48:40.121886	0	0	\N	Decidim::Results::Result	15
380	Vel est sint qui iure qui hic dignissimos officia.	Decidim::Results::Result	15	95	2017-09-13 12:48:40.151837	2017-09-13 12:48:40.151837	0	0	\N	Decidim::Results::Result	15
381	Asperiores cumque illo nihil.	Decidim::Results::Result	15	224	2017-09-13 12:48:40.191072	2017-09-13 12:48:40.191072	0	0	\N	Decidim::Results::Result	15
382	Est odit vel dolor fuga pariatur eum harum est.	Decidim::Results::Result	15	225	2017-09-13 12:48:40.227434	2017-09-13 12:48:40.227434	0	0	\N	Decidim::Results::Result	15
383	Placeat suscipit autem expedita omnis nemo tempora.	Decidim::Budgets::Project	13	123	2017-09-13 12:48:40.436835	2017-09-13 12:48:40.436835	0	0	\N	Decidim::Budgets::Project	13
384	Eligendi odio ipsa sit impedit.	Decidim::Budgets::Project	13	236	2017-09-13 12:48:40.461414	2017-09-13 12:48:40.461414	0	0	\N	Decidim::Budgets::Project	13
385	Ipsa est delectus incidunt ut quo.	Decidim::Budgets::Project	14	57	2017-09-13 12:48:40.688537	2017-09-13 12:48:40.688537	0	0	\N	Decidim::Budgets::Project	14
386	Ipsum voluptas magni aut tempora labore dignissimos id.	Decidim::Budgets::Project	14	162	2017-09-13 12:48:40.717504	2017-09-13 12:48:40.717504	0	0	\N	Decidim::Budgets::Project	14
387	Est id facere dolores atque fuga autem.	Decidim::Budgets::Project	14	104	2017-09-13 12:48:40.745285	2017-09-13 12:48:40.745285	0	0	\N	Decidim::Budgets::Project	14
388	Ex commodi assumenda mollitia.	Decidim::Budgets::Project	14	40	2017-09-13 12:48:40.77624	2017-09-13 12:48:40.77624	0	0	\N	Decidim::Budgets::Project	14
389	Blanditiis dolore velit officiis impedit.	Decidim::Budgets::Project	15	85	2017-09-13 12:48:40.98345	2017-09-13 12:48:40.98345	0	0	\N	Decidim::Budgets::Project	15
390	Debitis asperiores commodi hic.	Decidim::Pages::Page	6	265	2017-09-13 12:48:41.20229	2017-09-13 12:48:41.20229	0	0	\N	Decidim::Pages::Page	6
391	Autem facere quis sapiente itaque.	Decidim::Pages::Page	6	71	2017-09-13 12:48:41.227429	2017-09-13 12:48:41.227429	0	0	\N	Decidim::Pages::Page	6
392	Et id animi officiis culpa numquam.	Decidim::Pages::Page	6	175	2017-09-13 12:48:41.266376	2017-09-13 12:48:41.266376	0	0	\N	Decidim::Pages::Page	6
393	Rerum harum et odit sit ipsam nisi.	Decidim::Proposals::Proposal	101	199	2017-09-13 12:48:48.234282	2017-09-13 12:48:48.234282	0	0	\N	Decidim::Proposals::Proposal	101
394	Qui saepe id eveniet voluptatem neque est.	Decidim::Proposals::Proposal	102	248	2017-09-13 12:48:48.50795	2017-09-13 12:48:48.50795	0	0	\N	Decidim::Proposals::Proposal	102
395	Neque nesciunt porro tenetur.	Decidim::Proposals::Proposal	102	146	2017-09-13 12:48:48.536278	2017-09-13 12:48:48.536278	0	0	\N	Decidim::Proposals::Proposal	102
396	Velit cum voluptas molestias et porro.	Decidim::Proposals::Proposal	103	100	2017-09-13 12:48:49.024134	2017-09-13 12:48:49.024134	0	0	\N	Decidim::Proposals::Proposal	103
397	Veritatis sed rerum mollitia ut quos quaerat voluptatem.	Decidim::Proposals::Proposal	103	37	2017-09-13 12:48:49.051972	2017-09-13 12:48:49.051972	0	0	\N	Decidim::Proposals::Proposal	103
398	Voluptates ut totam beatae repellat.	Decidim::Proposals::Proposal	103	271	2017-09-13 12:48:49.092549	2017-09-13 12:48:49.092549	0	0	\N	Decidim::Proposals::Proposal	103
399	Qui eos nostrum id repellat eveniet optio.	Decidim::Proposals::Proposal	103	261	2017-09-13 12:48:49.120748	2017-09-13 12:48:49.120748	0	0	\N	Decidim::Proposals::Proposal	103
400	Tempora sint suscipit minus perspiciatis et libero natus accusantium.	Decidim::Proposals::Proposal	103	69	2017-09-13 12:48:49.148749	2017-09-13 12:48:49.148749	0	0	\N	Decidim::Proposals::Proposal	103
401	Qui corrupti officiis deserunt sit atque ipsum et.	Decidim::Proposals::Proposal	104	206	2017-09-13 12:48:49.456533	2017-09-13 12:48:49.456533	0	0	\N	Decidim::Proposals::Proposal	104
402	Quisquam id qui fugiat.	Decidim::Proposals::Proposal	104	182	2017-09-13 12:48:49.483438	2017-09-13 12:48:49.483438	0	0	\N	Decidim::Proposals::Proposal	104
403	Sunt natus aspernatur quo impedit in quaerat voluptate et.	Decidim::Proposals::Proposal	104	113	2017-09-13 12:48:49.510361	2017-09-13 12:48:49.510361	0	0	\N	Decidim::Proposals::Proposal	104
404	Ipsa accusamus ratione rerum consectetur.	Decidim::Proposals::Proposal	104	302	2017-09-13 12:48:49.537663	2017-09-13 12:48:49.537663	0	0	\N	Decidim::Proposals::Proposal	104
405	Saepe et ab est.	Decidim::Proposals::Proposal	105	296	2017-09-13 12:48:49.815368	2017-09-13 12:48:49.815368	0	0	\N	Decidim::Proposals::Proposal	105
406	Ullam dicta cumque laborum quaerat beatae aut ducimus.	Decidim::Proposals::Proposal	105	48	2017-09-13 12:48:49.845098	2017-09-13 12:48:49.845098	0	0	\N	Decidim::Proposals::Proposal	105
407	Nostrum rerum tempore veritatis eveniet recusandae cumque placeat.	Decidim::Proposals::Proposal	105	174	2017-09-13 12:48:49.876811	2017-09-13 12:48:49.876811	0	0	\N	Decidim::Proposals::Proposal	105
408	Reiciendis placeat unde quia doloribus eum exercitationem.	Decidim::Proposals::Proposal	105	125	2017-09-13 12:48:49.904027	2017-09-13 12:48:49.904027	0	0	\N	Decidim::Proposals::Proposal	105
409	Consequatur ea fugit nulla ab.	Decidim::Proposals::Proposal	105	291	2017-09-13 12:48:49.946133	2017-09-13 12:48:49.946133	0	0	\N	Decidim::Proposals::Proposal	105
410	Quia qui omnis magni quaerat dolorum.	Decidim::Proposals::Proposal	106	310	2017-09-13 12:48:50.019858	2017-09-13 12:48:50.019858	0	0	\N	Decidim::Proposals::Proposal	106
411	Modi nemo amet aliquid ut sed.	Decidim::Proposals::Proposal	106	203	2017-09-13 12:48:50.050673	2017-09-13 12:48:50.050673	0	0	\N	Decidim::Proposals::Proposal	106
412	Harum vel sed aut occaecati ut voluptatibus est iusto.	Decidim::Proposals::Proposal	106	275	2017-09-13 12:48:50.080403	2017-09-13 12:48:50.080403	0	0	\N	Decidim::Proposals::Proposal	106
413	Provident quia vero numquam.	Decidim::Proposals::Proposal	107	134	2017-09-13 12:48:50.635838	2017-09-13 12:48:50.635838	0	0	\N	Decidim::Proposals::Proposal	107
414	Vero non architecto sed ut et quaerat repellat.	Decidim::Proposals::Proposal	107	279	2017-09-13 12:48:50.660765	2017-09-13 12:48:50.660765	0	0	\N	Decidim::Proposals::Proposal	107
415	Tempore ut sint quisquam repellendus impedit non voluptatem.	Decidim::Proposals::Proposal	107	83	2017-09-13 12:48:50.685683	2017-09-13 12:48:50.685683	0	0	\N	Decidim::Proposals::Proposal	107
416	Non possimus aliquam qui ut error.	Decidim::Proposals::Proposal	107	58	2017-09-13 12:48:50.71073	2017-09-13 12:48:50.71073	0	0	\N	Decidim::Proposals::Proposal	107
417	Voluptatem odit qui dicta laudantium eveniet voluptate dolores quod.	Decidim::Proposals::Proposal	108	267	2017-09-13 12:48:50.981422	2017-09-13 12:48:50.981422	0	0	\N	Decidim::Proposals::Proposal	108
418	Repellendus minus quasi maxime.	Decidim::Proposals::Proposal	108	255	2017-09-13 12:48:51.00837	2017-09-13 12:48:51.00837	0	0	\N	Decidim::Proposals::Proposal	108
419	Rem est cupiditate autem placeat similique.	Decidim::Proposals::Proposal	108	308	2017-09-13 12:48:51.039849	2017-09-13 12:48:51.039849	0	0	\N	Decidim::Proposals::Proposal	108
420	Non adipisci unde soluta.	Decidim::Proposals::Proposal	109	129	2017-09-13 12:48:51.335152	2017-09-13 12:48:51.335152	0	0	\N	Decidim::Proposals::Proposal	109
421	Provident maiores fugit rem corrupti.	Decidim::Proposals::Proposal	109	154	2017-09-13 12:48:51.360005	2017-09-13 12:48:51.360005	0	0	\N	Decidim::Proposals::Proposal	109
422	Magnam et qui cum velit non tempore.	Decidim::Proposals::Proposal	110	199	2017-09-13 12:48:51.43053	2017-09-13 12:48:51.43053	0	0	\N	Decidim::Proposals::Proposal	110
423	Quia consequatur neque et sed.	Decidim::Proposals::Proposal	110	223	2017-09-13 12:48:51.45604	2017-09-13 12:48:51.45604	0	0	\N	Decidim::Proposals::Proposal	110
424	Reiciendis vero nisi perferendis.	Decidim::Proposals::Proposal	110	104	2017-09-13 12:48:51.481016	2017-09-13 12:48:51.481016	0	0	\N	Decidim::Proposals::Proposal	110
425	Sapiente qui velit magni ex et voluptatem.	Decidim::Proposals::Proposal	110	303	2017-09-13 12:48:51.507689	2017-09-13 12:48:51.507689	0	0	\N	Decidim::Proposals::Proposal	110
426	Molestiae aut consequatur quia quas illo quaerat.	Decidim::Proposals::Proposal	110	168	2017-09-13 12:48:51.533228	2017-09-13 12:48:51.533228	0	0	\N	Decidim::Proposals::Proposal	110
427	Et optio rerum fugiat rem numquam.	Decidim::Proposals::Proposal	111	137	2017-09-13 12:48:51.600324	2017-09-13 12:48:51.600324	0	0	\N	Decidim::Proposals::Proposal	111
428	Aut dolorem omnis in consequatur.	Decidim::Proposals::Proposal	111	242	2017-09-13 12:48:51.633348	2017-09-13 12:48:51.633348	0	0	\N	Decidim::Proposals::Proposal	111
429	Numquam officiis nam debitis ut nemo consectetur reprehenderit.	Decidim::Proposals::Proposal	111	238	2017-09-13 12:48:51.662539	2017-09-13 12:48:51.662539	0	0	\N	Decidim::Proposals::Proposal	111
430	Provident et consequatur facilis commodi magni a nostrum.	Decidim::Proposals::Proposal	111	279	2017-09-13 12:48:51.692305	2017-09-13 12:48:51.692305	0	0	\N	Decidim::Proposals::Proposal	111
431	Et occaecati est molestias non et vero deleniti quia.	Decidim::Proposals::Proposal	111	189	2017-09-13 12:48:51.731319	2017-09-13 12:48:51.731319	0	0	\N	Decidim::Proposals::Proposal	111
432	Non totam omnis adipisci consequatur impedit cumque.	Decidim::Proposals::Proposal	112	8	2017-09-13 12:48:51.801699	2017-09-13 12:48:51.801699	0	0	\N	Decidim::Proposals::Proposal	112
433	Veritatis qui consequatur fugiat vitae quia blanditiis.	Decidim::Proposals::Proposal	112	177	2017-09-13 12:48:51.8312	2017-09-13 12:48:51.8312	0	0	\N	Decidim::Proposals::Proposal	112
434	Corrupti natus nesciunt eius similique non enim tempore maxime.	Decidim::Proposals::Proposal	112	200	2017-09-13 12:48:51.857846	2017-09-13 12:48:51.857846	0	0	\N	Decidim::Proposals::Proposal	112
435	Atque est dolor id esse consequatur voluptas.	Decidim::Proposals::Proposal	112	51	2017-09-13 12:48:51.886329	2017-09-13 12:48:51.886329	0	0	\N	Decidim::Proposals::Proposal	112
436	Voluptatibus eaque aut molestiae.	Decidim::Proposals::Proposal	112	198	2017-09-13 12:48:51.911403	2017-09-13 12:48:51.911403	0	0	\N	Decidim::Proposals::Proposal	112
437	Voluptatem molestias minus quas sit ipsa velit.	Decidim::Proposals::Proposal	113	226	2017-09-13 12:48:52.187334	2017-09-13 12:48:52.187334	0	0	\N	Decidim::Proposals::Proposal	113
438	Quisquam eaque voluptatum et ut.	Decidim::Proposals::Proposal	114	181	2017-09-13 12:48:52.681559	2017-09-13 12:48:52.681559	0	0	\N	Decidim::Proposals::Proposal	114
439	Sint voluptas aliquid qui blanditiis mollitia et.	Decidim::Proposals::Proposal	114	23	2017-09-13 12:48:52.706812	2017-09-13 12:48:52.706812	0	0	\N	Decidim::Proposals::Proposal	114
440	Qui deserunt nulla et repudiandae.	Decidim::Proposals::Proposal	114	285	2017-09-13 12:48:52.732944	2017-09-13 12:48:52.732944	0	0	\N	Decidim::Proposals::Proposal	114
441	Natus aspernatur illum quia ipsum dolorem qui iure.	Decidim::Proposals::Proposal	114	306	2017-09-13 12:48:52.76099	2017-09-13 12:48:52.76099	0	0	\N	Decidim::Proposals::Proposal	114
442	Aliquid velit dolor minima sapiente corporis optio id.	Decidim::Proposals::Proposal	115	268	2017-09-13 12:48:53.06371	2017-09-13 12:48:53.06371	0	0	\N	Decidim::Proposals::Proposal	115
443	Veniam illum nemo aspernatur sit.	Decidim::Proposals::Proposal	115	25	2017-09-13 12:48:53.097667	2017-09-13 12:48:53.097667	0	0	\N	Decidim::Proposals::Proposal	115
444	Officia molestiae qui ut.	Decidim::Proposals::Proposal	115	4	2017-09-13 12:48:53.125694	2017-09-13 12:48:53.125694	0	0	\N	Decidim::Proposals::Proposal	115
445	Odio ut qui consequuntur et et maxime eaque.	Decidim::Proposals::Proposal	116	271	2017-09-13 12:48:53.641891	2017-09-13 12:48:53.641891	0	0	\N	Decidim::Proposals::Proposal	116
446	Consequuntur et deserunt corporis et voluptatem in eum.	Decidim::Proposals::Proposal	116	137	2017-09-13 12:48:53.670816	2017-09-13 12:48:53.670816	0	0	\N	Decidim::Proposals::Proposal	116
447	Neque distinctio est nostrum quo.	Decidim::Proposals::Proposal	117	73	2017-09-13 12:48:54.154965	2017-09-13 12:48:54.154965	0	0	\N	Decidim::Proposals::Proposal	117
448	Quisquam explicabo necessitatibus vel esse.	Decidim::Proposals::Proposal	117	112	2017-09-13 12:48:54.180101	2017-09-13 12:48:54.180101	0	0	\N	Decidim::Proposals::Proposal	117
449	Optio laborum aliquid sequi soluta iste.	Decidim::Proposals::Proposal	118	323	2017-09-13 12:48:54.683027	2017-09-13 12:48:54.683027	0	0	\N	Decidim::Proposals::Proposal	118
450	Ut doloribus esse consequatur tempora dolorem cupiditate.	Decidim::Proposals::Proposal	118	174	2017-09-13 12:48:54.711444	2017-09-13 12:48:54.711444	0	0	\N	Decidim::Proposals::Proposal	118
451	Quia dicta quae ipsum quibusdam.	Decidim::Proposals::Proposal	119	213	2017-09-13 12:48:55.008926	2017-09-13 12:48:55.008926	0	0	\N	Decidim::Proposals::Proposal	119
452	Iure praesentium tempore est quod et consequatur.	Decidim::Proposals::Proposal	119	199	2017-09-13 12:48:55.036378	2017-09-13 12:48:55.036378	0	0	\N	Decidim::Proposals::Proposal	119
453	Aut temporibus veniam facere est enim ratione.	Decidim::Proposals::Proposal	120	78	2017-09-13 12:48:55.323148	2017-09-13 12:48:55.323148	0	0	\N	Decidim::Proposals::Proposal	120
454	Delectus eius consequatur cumque molestias esse sunt quidem.	Decidim::Proposals::Proposal	120	20	2017-09-13 12:48:55.3503	2017-09-13 12:48:55.3503	0	0	\N	Decidim::Proposals::Proposal	120
455	Consequuntur ab totam magni voluptatibus sint voluptatem nisi.	Decidim::Proposals::Proposal	120	271	2017-09-13 12:48:55.37705	2017-09-13 12:48:55.37705	0	0	\N	Decidim::Proposals::Proposal	120
456	Aut quia saepe dolor nisi eligendi.	Decidim::Proposals::Proposal	120	48	2017-09-13 12:48:55.404523	2017-09-13 12:48:55.404523	0	0	\N	Decidim::Proposals::Proposal	120
457	Ab provident vel ut minima quos dignissimos sapiente.	Decidim::Proposals::Proposal	120	277	2017-09-13 12:48:55.434744	2017-09-13 12:48:55.434744	0	0	\N	Decidim::Proposals::Proposal	120
458	Quo voluptas consequatur perferendis iste consequatur amet natus.	Decidim::Results::Result	16	124	2017-09-13 12:48:55.499609	2017-09-13 12:48:55.499609	0	0	\N	Decidim::Results::Result	16
459	Ut modi adipisci quis omnis.	Decidim::Results::Result	16	286	2017-09-13 12:48:55.529595	2017-09-13 12:48:55.529595	0	0	\N	Decidim::Results::Result	16
460	Ipsam earum voluptate fugiat.	Decidim::Results::Result	16	3	2017-09-13 12:48:55.558752	2017-09-13 12:48:55.558752	0	0	\N	Decidim::Results::Result	16
461	Dolore quasi atque laborum.	Decidim::Results::Result	17	284	2017-09-13 12:48:55.629524	2017-09-13 12:48:55.629524	0	0	\N	Decidim::Results::Result	17
462	Sapiente vel placeat ipsum.	Decidim::Results::Result	17	219	2017-09-13 12:48:55.66025	2017-09-13 12:48:55.66025	0	0	\N	Decidim::Results::Result	17
463	Nesciunt repellat deserunt maxime aut atque est.	Decidim::Results::Result	17	32	2017-09-13 12:48:55.688437	2017-09-13 12:48:55.688437	0	0	\N	Decidim::Results::Result	17
464	Optio illum quo ipsam laudantium dolor veniam rem ut.	Decidim::Results::Result	18	83	2017-09-13 12:48:55.746249	2017-09-13 12:48:55.746249	0	0	\N	Decidim::Results::Result	18
465	Aperiam totam iusto necessitatibus omnis iure.	Decidim::Results::Result	18	145	2017-09-13 12:48:55.776934	2017-09-13 12:48:55.776934	0	0	\N	Decidim::Results::Result	18
466	Temporibus ipsa omnis cupiditate possimus explicabo doloremque at.	Decidim::Results::Result	18	324	2017-09-13 12:48:55.802161	2017-09-13 12:48:55.802161	0	0	\N	Decidim::Results::Result	18
467	Quas nulla esse ea molestiae sequi rerum.	Decidim::Results::Result	18	176	2017-09-13 12:48:55.83096	2017-09-13 12:48:55.83096	0	0	\N	Decidim::Results::Result	18
468	Occaecati omnis ratione qui.	Decidim::Results::Result	18	4	2017-09-13 12:48:55.860412	2017-09-13 12:48:55.860412	0	0	\N	Decidim::Results::Result	18
469	Dicta ullam non id voluptas id ut harum voluptatem.	Decidim::Budgets::Project	16	82	2017-09-13 12:48:56.047649	2017-09-13 12:48:56.047649	0	0	\N	Decidim::Budgets::Project	16
470	Eius corrupti libero facere ut est in nihil.	Decidim::Budgets::Project	17	178	2017-09-13 12:48:56.212801	2017-09-13 12:48:56.212801	0	0	\N	Decidim::Budgets::Project	17
471	Deserunt debitis minus sequi voluptatem corporis placeat praesentium.	Decidim::Budgets::Project	18	108	2017-09-13 12:48:56.378609	2017-09-13 12:48:56.378609	0	0	\N	Decidim::Budgets::Project	18
472	Commentaire en faveur	Decidim::Proposals::Proposal	122	333	2017-09-13 16:53:32.554021	2017-09-13 16:53:32.554021	0	1	\N	Decidim::Proposals::Proposal	122
473	Commentaire contre	Decidim::Proposals::Proposal	122	333	2017-09-13 16:53:40.928694	2017-09-13 16:53:40.928694	0	-1	\N	Decidim::Proposals::Proposal	122
474	Réponse	Decidim::Comments::Comment	472	333	2017-09-13 16:53:52.661521	2017-09-13 16:53:52.661521	1	0	\N	Decidim::Proposals::Proposal	122
475	Commentaire pour !	Decidim::Proposals::Proposal	123	333	2017-09-13 17:01:01.944435	2017-09-13 17:01:01.944435	0	1	\N	Decidim::Proposals::Proposal	123
476	Commentaire	Decidim::Proposals::Proposal	124	334	2017-09-13 17:11:06.389183	2017-09-13 17:11:06.389183	0	0	\N	Decidim::Proposals::Proposal	124
477	Réponse	Decidim::Comments::Comment	476	334	2017-09-13 17:11:19.034216	2017-09-13 17:11:19.034216	1	0	5	Decidim::Proposals::Proposal	124
478	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	Decidim::Proposals::Proposal	126	338	2017-09-14 09:01:36.874621	2017-09-14 09:01:36.874621	0	1	\N	Decidim::Proposals::Proposal	126
479	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	Decidim::Comments::Comment	476	338	2017-09-14 09:03:43.281363	2017-09-14 09:03:43.281363	1	0	\N	Decidim::Proposals::Proposal	124
482	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.\n<b>Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.</b>	Decidim::Proposals::Proposal	127	338	2017-09-14 09:05:06.482673	2017-09-14 09:05:06.482673	0	1	\N	Decidim::Proposals::Proposal	127
480	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	Decidim::Comments::Comment	477	338	2017-09-14 09:03:49.987082	2017-09-14 09:03:49.987082	2	0	\N	Decidim::Proposals::Proposal	124
481	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	Decidim::Proposals::Proposal	124	338	2017-09-14 09:04:05.823696	2017-09-14 09:04:05.823696	0	-1	\N	Decidim::Proposals::Proposal	124
483	Test	Decidim::Proposals::Proposal	123	343	2017-09-17 15:11:20.246633	2017-09-17 15:11:20.246633	0	0	\N	Decidim::Proposals::Proposal	123
484	Test 2	Decidim::Proposals::Proposal	123	343	2017-09-17 15:11:34.096647	2017-09-17 15:11:34.096647	0	1	\N	Decidim::Proposals::Proposal	123
485	Test	Decidim::Comments::Comment	484	343	2017-09-17 15:11:41.740721	2017-09-17 15:11:41.740721	1	0	\N	Decidim::Proposals::Proposal	123
486	Test	Decidim::Proposals::Proposal	127	331	2017-09-18 05:59:48.356421	2017-09-18 05:59:48.356421	0	0	\N	Decidim::Proposals::Proposal	127
487	test	Decidim::Comments::Comment	486	331	2017-09-18 05:59:58.052633	2017-09-18 05:59:58.052633	1	0	\N	Decidim::Proposals::Proposal	127
488	Bonjour,\nAuriez-vous la possibilité de republier votre question dans l'espace dédié aux questions ( https://participons.debatpublic.fr/processes/6/f/51/ ) ?\nMerci	Decidim::Proposals::Proposal	141	375	2017-10-06 17:18:17.513706	2017-10-06 17:18:17.513706	0	0	\N	Decidim::Proposals::Proposal	141
489	Bonjour,\nVous avez reçu une réponse ici : https://participons.debatpublic.fr/processes/6/f/51/proposals/150\nNous avons republié votre question dans l'espace des questions afin de pouvoir y répondre.\nCordialement,\nLa CPDP	Decidim::Proposals::Proposal	141	375	2017-10-11 07:57:07.77215	2017-10-11 07:57:07.77215	0	0	\N	Decidim::Proposals::Proposal	141
490	Commentaire numéro 1	Decidim::Proposals::Proposal	151	359	2017-10-12 08:12:38.630647	2017-10-12 08:12:38.630647	0	0	\N	Decidim::Proposals::Proposal	151
491	Autre commentaire	Decidim::Proposals::Proposal	151	359	2017-10-12 08:13:17.817427	2017-10-12 08:13:17.817427	0	0	\N	Decidim::Proposals::Proposal	151
492	Quel est l'intérêt d'un forum dans le débat public organisé pour projet de nouveau bassin pour le conteneur, visant à comparer voire opposer les ports de Dunkerque et du Havre ?\nNos parlementaires locaux ont déjà réagi avec pertinence et justesse aux courrier et questions de Madame Agnès FIRMIN LE BODO dont les propos ne me semblent pas à la hauteur de ce qui se doit pour une parlementaire certes élue de sa circonscription, mais avant tout élue de la nation se devant de parler au nom de l'intérêt général.\nEst-ce le rôle de la CNDP d'ouvrir un débat autour de la politique portuaire française et de sa cohérence ? Mieux vaut alors interroger les vrais experts qui sont en même temps les décideurs à savoir la Ministre des Transports, le Premier Ministre ou même le Président de la République !\n	Decidim::Proposals::Proposal	231	394	2017-11-05 11:44:02.446391	2017-11-05 11:44:02.446391	0	0	\N	Decidim::Proposals::Proposal	231
493	Dans la continuité de mon commentaire précédent, et en se recentrant sur le fond du projet, la crainte exprimée est une dispersion des fonds publics versés par l'Etat. Le montant de la subvention promise par l'Etat n'est que de 30 Mio d'€ sur les 60 Mio d'€ de financement public sur les 258 Mio d'€ de la phase 1. Le reste est assuré par le GPMD qui montre chaque année une situation financière saine et une bonne capacité d'autofinancement. Au point que sur les côtes françaises, Dunkerque est le port qui depuis plus de 15 ans remonte le plus de dividendes à l'Etat, avec une moyenne de 5 Mio d'€ par an sur les 5 derniers exercices comptables !\nAvec ces éléments chiffrés, il ne m'apparaît pas nécessaire de déclencher une polémique stérile au regard du montant global du projet et surtout des enjeux en termes de retombées économiques pour le territoire !	Decidim::Proposals::Proposal	231	394	2017-11-05 12:11:34.452241	2017-11-05 12:11:34.452241	0	0	\N	Decidim::Proposals::Proposal	231
494	Même si on veut favoriser l’économie du « produire local et consommer local », il est un fait que les flux internationaux de marchandises par conteneurs se développent et se développeront encore.\nLa concurrence ne se joue pas entre les ports français, mais entre les ports de France et ceux du Benelux (Anvers, Rotterdam…).\nCes derniers arrivant à saturation, les armateurs et logisticiens cherchent à se redéployer tout en gardant un accès au nord de l’Europe. Zeebruge en bénéficie ainsi déjà avec une hausse de trafic.\nDans ce contexte le projet de Dunkerque apporte deux éléments majeurs de compétitivité aux professionnels maritimes et logistiques sur nos voisins:\n-\tMeilleure accessibilité depuis le rail de navigation,\n-\tProximité de la zone de chalandise dense, permettant un meilleur bilan carbone.\nDonc, oui, le projet de Dunkerque est un atout essentiel pour la France maritime et de la logistique.\n	Decidim::Proposals::Proposal	231	372	2017-11-05 20:45:29.598106	2017-11-05 20:45:29.598106	0	0	\N	Decidim::Proposals::Proposal	231
495	A long terme,je crains que Loon-Plage ressemble a Mardyck.\nEt comme vous le dites la valeur immobilière de nos maisons ne vaudra plus rien. J'en ai bien peur.\nSans compter toutes les nuisances environnementales que nous allons subir.   \nça promet!!!. 	Decidim::Proposals::Proposal	230	397	2017-11-07 20:12:51.654001	2017-11-07 20:12:51.654001	0	1	\N	Decidim::Proposals::Proposal	230
496	"Dunkerque versus Le Havre" ?\n\nVersus signifie "contre" . Cette question est inopportune  et révélatrice de la méconnaissance des enjeux économiques du projet.\n\nUn "Dunkerque versus Anvers" eût été plus pertinent.\n\nAujourd'hui, le marché français se partage entre Le Havre et Anvers / Rotterdam  (Anvers étant le port par lequel transitent le plus de marchandises françaises). Les marchandises dont le port le plus proche est Le Havre , passent par Le Havre  et  celles dont le port naturel est Anvers , passent par Anvers. \nOr Dunkerque est voisin d'Anvers , pas Du Havre !  Si Dunkerque se développe, ce sera au détriment d'Anvers , pas du Havre !\n\nPourquoi la France serait elle présente sur les façades Atlantique et Méditerranéenne et laisserait la façade Nord aux Ports du Benelux ?\n\nLes marchandises qui transitent par Anvers sont DEJA sur NOS routes sur des camions BELGES. Réduire les distances en les faisant transiter par Dunkerque ne serait que  du bon sens écologique et économique.	Decidim::Proposals::Proposal	231	399	2017-11-08 08:33:52.05205	2017-11-08 08:33:52.05205	0	0	\N	Decidim::Proposals::Proposal	231
497	Le 9 octobre, le journal Paris-Normandie relatait les propos de la députée Agnès Firmin-Le Bodo. Elle a écrit au ministre de la Cohésion des territoires au sujet de l’avenir du port du Havre. Elle lui a clairement demandé de privilégier Le Havre et Marseille, au détriment de Dunkerque et des autres ports français.Le Havre a déjà eu sa chance et des investissements conséquents avec Port 2000. Et il ne nous serait pas venu à l’idée, à l’époque, de nous opposer au développement d’un port, concurrent, certes, mais français avant tout. Dunkerque reverse chaque année des dividendes, c’est à son tour de profiter du fruit de ses bénéfices et d’engager un projet à long terme. Depuis 5 ans, la moyenne des dividendes reversés tourne autour de 5 millions d’euros par an. Et depuis plus de 10 ans, Dunkerque est le port qui en injecte le plus dans les caisses de l’État. Les investissements portuaires doivent être complémentaires. Il ne faut surtout pas rentrer dans une concurrence franco-française. 	Decidim::Proposals::Proposal	231	403	2017-11-08 15:17:35.732634	2017-11-08 15:17:35.732634	0	0	\N	Decidim::Proposals::Proposal	231
518	Je suis tout a fait d'accord avec vous. Nous devrions nous réunir avec d'autres habitants de la ville	Decidim::Proposals::Proposal	338	389	2017-11-27 09:55:34.480873	2017-11-27 09:55:34.480873	0	1	\N	Decidim::Proposals::Proposal	338
498	(Pour faire suite au commentaire précédent)\nSur la place de Dunkerque au sein du dispositif portuaire français : \n\nIl est vrai que le port de Dunkerque, pourtant 3e port de France, derrière Le Havre et Marseille, n’a jamais été dans la stratégie de nos gouvernements successifs, et ce depuis de nombreuses années. Je le déplore et je l’ai toujours dénoncé. À mon niveau, je travaille tous les jours à obtenir de véritables investissements pour le port. Pas un semblant de projet, mais un véritable projet stratégique à très long terme. C’est ce que font nos voisins belges, néerlandais, allemands. Et à ce titre, Dunkerque mérite d’engager CAP 2020.  (La troisième et dernière partie de mon commentaire suit.)\n	Decidim::Proposals::Proposal	231	403	2017-11-08 15:19:59.95264	2017-11-08 15:19:59.95264	0	0	\N	Decidim::Proposals::Proposal	231
499	Dunkerque et Le Havre : complémentaires ou concurrents ?\n\nAux yeux de cette députée, il n’y aurait donc que deux ports qui auraient droit à un avenir ? Dunkerque doit conforter sa place de 3e port de France et gagner des places sur le  Range Nord (7e). Tout cela doit se faire dans une saine synergie de complémentarité et une logique de territoire, et non dans une opposition stérile et concurrentielle. Au syndicat, je mène une bataille pour l’emploi, le Dunkerquois, les Hauts-de-France. Notre région est tout autant un poumon social et économique que Le Havre. Quand nous nourrissons des projets pour Dunkerque, ce n’est pas au détriment des autres ports français. Nos atouts sont nombreux : 25 ans de fiabilité garantie par les dockers du CNTPA, le plus grand tirant d’eau du Range Nord, une productivité égale à la moyenne des grands ports du nord Europe, et un des ports les plus dynamiques de France. A Dunkerque ou au Havre, quand les ports travaillent, c’est pour l’économie de la France.	Decidim::Proposals::Proposal	231	403	2017-11-08 15:29:19.854947	2017-11-08 15:29:19.854947	0	0	\N	Decidim::Proposals::Proposal	231
500	Je pense également que SI le projet doit voir véritablement le jour, celui-ci devrai ce trouver sur l'option baltique pour les raison suivante :\n- loin des habitations\n- une plage déserté en cause toutes les usines qui se trouve déjà sur place\n- il n'y a que des champs et des huttes\n- zones déjà bien abimé par les industries se trouvant sur place.\n\nEt les points négatif de la zone atlantique\n- trop proches des habitations\n- baisse de la valeur immobiliere\n- nuisance sonore\n- nuisance visuel ( voir des ponts et des conteneurs depuis nos fenêtres )\n- nuisance dû aux travaux durant tout le chantier ( lors de l'installation de palplanche sur le quai de flandre a 4km de la ville on ressent les vibrations dans le sol de nos maisons )\n- L'afflux de camion qui sortira du port conteneur ( 1400/j )et les camions du ferry 150/chaque débarquement\n- saturation du réseau routier pour rejoindre la porte 53 de l'A16.\n- L'afflux de véhicule qui traverseront la ville de loon-plage.\n\n	Decidim::Proposals::Proposal	247	389	2017-11-12 19:44:54.265888	2017-11-12 19:44:54.265888	0	1	\N	Decidim::Proposals::Proposal	247
501	Ne faisons pas fausse route. L'objectif de Dunkerque a toujours été de se développer en commençant par récupérer les trafics de son hinterland. La route est longue est difficile mais depuis quelques années, notamment avec l'arrivée de service fiable et compétitif en provenance Asie les résultats sont là. La progression ne pourra se faire sans l'arrivée de nouveaux services. Comment accueillir ces derniers sans une adaptation de l'outil et un développement des infracstructures. Le Havre n'est pas notre concurrent. Les ports du Nord le sont. Si Dunkerque ne se développe pas les flux n'iront pas au Havre mais à Anvers et Rotterdam. Ceux qui pensent le contraire n'ont aucune connaissance de la situation locale de Dunkerque voir même peut être du maritime!	Decidim::Proposals::Proposal	231	411	2017-11-15 09:21:08.728041	2017-11-15 09:21:08.728041	0	0	\N	Decidim::Proposals::Proposal	231
502	Je suis bien d’acco Avec vous	Decidim::Proposals::Proposal	183	421	2017-11-25 13:14:39.095522	2017-11-25 13:14:39.095522	0	0	\N	Decidim::Proposals::Proposal	183
503	Je ne pense pas que la vie des personnes qui vivront juste mais vraiment juste à côté soit accessoire 	Decidim::Proposals::Proposal	217	421	2017-11-25 13:26:13.318636	2017-11-25 13:26:13.318636	0	0	\N	Decidim::Proposals::Proposal	217
504	Complètement d’accor Avec vous	Decidim::Proposals::Proposal	310	421	2017-11-25 13:27:12.438939	2017-11-25 13:27:12.438939	0	0	\N	Decidim::Proposals::Proposal	310
505	C’est la réalité, je suis loonois et c’est terrible pour la ville. Loon Plage deviendra une ville morte	Decidim::Proposals::Proposal	230	421	2017-11-25 13:32:42.31602	2017-11-25 13:32:42.31602	0	0	\N	Decidim::Proposals::Proposal	230
506	J’habite Loon Plage et c’est désolant pour la commune. Ça deviendra une ville morte	Decidim::Proposals::Proposal	289	421	2017-11-26 12:44:55.408436	2017-11-26 12:44:55.408436	0	0	\N	Decidim::Proposals::Proposal	289
507	Beaucoup d’habitants de Loon Plage sont déjà en train de voir pour vendre leur maison. Le maire aura l’air bien avec un parc et une piscine où il n’y aura plus personne. Mais bon l’argent rentrera dans les caisses comme avec le terminal méthanier 	Decidim::Proposals::Proposal	301	421	2017-11-26 12:56:13.083792	2017-11-26 12:56:13.083792	0	0	\N	Decidim::Proposals::Proposal	301
508	Côté Baltique il n’y a déjà plus de Plage avec le terminal méthanier, alors vaut mieux le projet Baltique qu’atlantique, ça conviendra mieux pour les usagers de la route et surtout pour les habitants de Loon Plage 	Decidim::Proposals::Proposal	243	421	2017-11-26 13:04:34.624461	2017-11-26 13:04:34.624461	0	0	\N	Decidim::Proposals::Proposal	243
509	De plus je ne pense pas que les camions étrangers roule à l’électrique, c’est de la poudre aux yeux	Decidim::Proposals::Proposal	265	421	2017-11-26 13:08:30.844673	2017-11-26 13:08:30.844673	0	0	\N	Decidim::Proposals::Proposal	265
510	Et pendant l’exploitation de ce terminal il y aura le bruit des poids lourd qui circulent, le bruit du déchargement/chargement des bateaux, le bruit des machineries de ces mêmes bateaux. Plus la pollution visuelle et la pollution de l’air à cause du flux de camions qui aura augmenté 	Decidim::Proposals::Proposal	258	421	2017-11-26 13:16:12.494769	2017-11-26 13:16:12.494769	0	0	\N	Decidim::Proposals::Proposal	258
511	Dans ce cas il faudra venir vivre à Loon Plage car du bruit il va y en avoir, d’ailleurs il y en a déjà. Mais je ne suis pas sûr que vous allez le supporter longtemps ce bruit	Decidim::Proposals::Proposal	208	421	2017-11-26 13:20:31.78855	2017-11-26 13:20:31.78855	0	0	\N	Decidim::Proposals::Proposal	208
512	J’habite également Loon Plage et je suis totalement d’accord avec ce que vous écrivez. Loon Plage ce videra de ces habitants. Des Loonois sont déjà en train de voir pour vendre leurs maisons	Decidim::Proposals::Proposal	256	421	2017-11-26 13:31:01.949768	2017-11-26 13:31:01.949768	0	0	\N	Decidim::Proposals::Proposal	256
513	Bonjour. On parle toujours de Dunkerque mais ce monstre de projet se fera à loon plage et non à Dunkerque. Je ne pense pas que vous habitez loon plage ?  car vous ne seriez pas de cette avis. Et J espère pour vous que vous n emprunter jamais l a16 ni l a25 car le nombres de camions se verra multiplier par 5. Beau projet que le port veut nous infliger n est ce pas ? 	Decidim::Proposals::Proposal	192	422	2017-11-26 22:10:36.768919	2017-11-26 22:10:36.768919	0	0	\N	Decidim::Proposals::Proposal	192
516	VOus avez bien raison	Decidim::Proposals::Proposal	295	389	2017-11-27 09:50:38.799964	2017-11-27 09:50:38.799964	0	0	\N	Decidim::Proposals::Proposal	295
514	Complètement d accord avec vos avis. Non à ce projet démesurée et à ces nombreux désagrément à venir. Pour 100 ou 200 emploi car les 16000 emploi annonce seront pour les pays voisins( camioneur) . Faut t il mourir sous une telle pollution sonore visuel et atmosphèrique à venir ? 	Decidim::Proposals::Proposal	230	422	2017-11-26 22:20:08.488357	2017-11-26 22:20:08.488357	0	0	\N	Decidim::Proposals::Proposal	230
517	C'est mieux d'embêter une population que de déplacé un terrain de moto.	Decidim::Proposals::Proposal	170	389	2017-11-27 09:51:59.385552	2017-11-27 09:51:59.385552	0	0	\N	Decidim::Proposals::Proposal	170
523	CAP2020 doit être la préface d'un nouveau chapitre de l'histoire de dunkerque qui répond à une impérieuse nécessité économique, c'est l'œuvre d'une génération qui monte car Dunkerque doit remplir les fonctions qui sont les siennes. Les Dunkerquois ( diabintes) joignent un ferme attachements à leur sol sur lequel ils sont fiers de leurs port qu'ils s'imprègnent. C'est le catalyseur de la solidarité, de paix et de prospérité. A méditer aussi.	Decidim::Proposals::Proposal	231	413	2017-11-29 09:40:12.644354	2017-11-29 09:40:12.644354	0	0	\N	Decidim::Proposals::Proposal	231
526	Bonjour \nje partage a 100% votre point de vue très juste et maitriser contrairement a ce projet délirant.\n	Decidim::Proposals::Proposal	371	422	2017-12-21 09:37:57.505565	2017-12-21 09:37:57.505565	0	1	\N	Decidim::Proposals::Proposal	371
528	ON est pret à tout entendre ou voir tant que c'est assez loin pour le supporter	Decidim::Proposals::Proposal	208	389	2017-12-22 10:50:41.237965	2017-12-22 10:50:41.237965	0	0	\N	Decidim::Proposals::Proposal	208
529	Votre ville c'est Dunkerque ou Loon-plage ? PArce que à loon-plage sa sonne comme il faut de 6h a 23h50 du lundi au vendredi.	Decidim::Proposals::Proposal	208	389	2017-12-22 10:51:39.811795	2017-12-22 10:51:39.811795	0	0	\N	Decidim::Proposals::Proposal	208
530	Non Merci mon cher Monsieur, J'habite juste à coté et je n'ai pas envie de voir des mur de conteneur en ouvrant mes fenetres le matin et de subir les nuisances	Decidim::Proposals::Proposal	351	389	2017-12-22 10:53:49.033258	2017-12-22 10:53:49.033258	0	0	\N	Decidim::Proposals::Proposal	351
515	Je vais subir la construction, les nuisances, en ouvrant mes volets le matin ou lorsque je ferai un bbq dans le jardin j'aurai une magnifique vue sur un mur de conteneur et des grues. Sans parlé des nuisances sonore, des poussiers engendré par les circulation de camion multiplié par 5 sur nos routes et à proximité de chez moi. \nNON CE N'EST PAS ACCESOIRE	Decidim::Proposals::Proposal	217	389	2017-11-27 09:45:18.249522	2017-11-27 09:45:18.249522	0	0	\N	Decidim::Proposals::Proposal	217
520	Bonjour. Je pense qu'il va falloir se rencontrer le plus nombreux que possible habitants de loon plage et autres pour discuter? Car se projet est de pas adaptée au contexte actuelle sur tous point de vue 	Decidim::Proposals::Proposal	339	422	2017-11-27 16:10:41.933619	2017-11-27 16:10:41.933619	0	1	\N	Decidim::Proposals::Proposal	339
522	Je partage aucunement votre point de vue sur 'agrandissement du port de dunkerque et surtout pas projet Atlantique. Il est d un autre âge faire rentrer la mer dans les terre alors que partout dans le monde nous sommes entrain d essayer de repousser la mer. L humain n est pas raisonnable c est bien connu. Regarder les information et ouvrait les yeux il y a de plus en plus de catastrophe naturel. Alors non à ce projet Atlantique et si vraiment il faudrais agrandir ce port faite le aprojet baltique qui est plus proche de la mer et nettement moins intrusive dans la vie des habitants en pollution sonore. Visuel. Lumineuse et atmosphèrique. Pensons au générations futur et ne fermons pas les yeux et dans quelque année nous pleurerons  mais il sera trop tard. A méditer merci 	Decidim::Proposals::Proposal	231	422	2017-11-28 22:15:39.479706	2017-11-28 22:15:39.479706	0	0	\N	Decidim::Proposals::Proposal	231
524	Je pense monsieur colonval que ce message s adressé à moi.je vous répète mon inquiétude première c est que vous n écoutez pas les informations. Connaissez vous le réchauffement climatique ? Immersion des terres????? Je vais vous posez une question simple.  ou J espère monsieur colonval vous répondrez avec honnêteté  ? Vous monsieur qui vénéré ce projet. Vous habitez Ou ????? Pas loon plage ou gravelines. On parle de PORt Dunkerque mais s est port LOON plage que ce satané projet devrais s appeler. Si vous le souhaitez je vous invite dans mon futur enfer. Oui J habite Loon plage. Et on verra si vous accepteriez ce projet. N hésitez pas à me joindre si vous souhaitez en discuter plutôt que de laisser des message sur ce site ironique. Monsieur diocourt Remy habitant de cette ville de loon plage. Laissez moi un message je vous donnerez rendez vous. Cordialement désolé si il peut h avoir des fautes je suis qu un simple citoyens. A méditer. 	Decidim::Proposals::Proposal	231	422	2017-11-29 20:16:39.625667	2017-11-29 20:16:39.625667	0	0	\N	Decidim::Proposals::Proposal	231
527	c'est plus qu'un risque la montée des eaux cela est une réalité. 	Decidim::Proposals::Proposal	370	422	2017-12-21 09:40:20.202014	2017-12-21 09:40:20.202014	0	1	\N	Decidim::Proposals::Proposal	370
531	Dommage qu'on ne reçoit pas les notifications à chaque messages reçu. J'habite également rue Denis. A présent il trop tard pour réagir. Aucun cahier d'acteur n'a été réaliser sur la commune.	Decidim::Comments::Comment	519	389	2017-12-22 10:56:19.032768	2017-12-22 10:56:19.032768	1	0	\N	Decidim::Proposals::Proposal	338
519	Bonjour. En effet . J habite rue Denis. Je pense qu il faut se réunir et parler de se projets rapidement. 	Decidim::Proposals::Proposal	338	422	2017-11-27 16:00:50.012145	2017-11-27 16:00:50.012145	0	1	\N	Decidim::Proposals::Proposal	338
521	Bonjour. Je suis complètement de votre avis. Je pense qui faut créer une réunion entre riverain de loon plage et s opposer en masse à ce projet irréaliste . Je commence à discuter avec plusieurs personne pour essayer de se réunir pour en discuter ? J ài poser un avis si vous souhaitez le lire je m appel Remy. 	Decidim::Proposals::Proposal	310	422	2017-11-27 17:59:20.078064	2017-11-27 17:59:20.078064	0	1	\N	Decidim::Proposals::Proposal	310
525	Bonjour,\n"...une ville morte" enclavée dans un univers de pollution en tout genre.\nNos maisons a court ou long terme vont dévaluer  car qui dit nuisances!!!........\nJ'envisage sérieusement  de partir ,je ne serais peut être pas le seul? \nOui,malheureusement la ville va mourir .	Decidim::Comments::Comment	506	397	2017-12-12 10:37:48.621248	2017-12-12 10:37:48.621248	1	0	\N	Decidim::Proposals::Proposal	289
\.


--
-- Data for Name: decidim_features; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_features (id, manifest_name, name, participatory_space_id, settings, weight, permissions, published_at, participatory_space_type) FROM stdin;
1	pages	{"ca": "Pàgina", "en": "Page", "es": "Página"}	1	{}	0	\N	2017-09-13 12:47:18.205381	Decidim::ParticipatoryProcess
2	meetings	{"ca": "Trobades", "en": "Meetings", "es": "Lista de encuentros"}	1	{}	0	\N	2017-09-13 12:47:18.619828	Decidim::ParticipatoryProcess
3	proposals	{"ca": "Propostes", "en": "Proposals", "es": "Propuestas"}	1	{"steps": {"1": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "official_proposals_enabled": true, "proposal_answering_enabled": true}}	0	\N	2017-09-13 12:47:25.695978	Decidim::ParticipatoryProcess
5	budgets	{"ca": "Pressupostos", "en": "Budgets", "es": "Presupuestos"}	1	{}	0	\N	2017-09-13 12:47:33.047469	Decidim::ParticipatoryProcess
6	surveys	{"ca": "Enquesta", "en": "Survey", "es": "Encuesta"}	1	{}	0	\N	2017-09-13 12:47:33.838612	Decidim::ParticipatoryProcess
7	pages	{"ca": "Pàgina", "en": "Page", "es": "Página"}	2	{}	0	\N	2017-09-13 12:47:34.888841	Decidim::ParticipatoryProcess
8	meetings	{"ca": "Trobades", "en": "Meetings", "es": "Lista de encuentros"}	2	{}	0	\N	2017-09-13 12:47:34.920281	Decidim::ParticipatoryProcess
9	proposals	{"ca": "Propostes", "en": "Proposals", "es": "Propuestas"}	2	{"steps": {"2": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "official_proposals_enabled": true, "proposal_answering_enabled": true}}	0	\N	2017-09-13 12:47:42.172757	Decidim::ParticipatoryProcess
11	budgets	{"ca": "Pressupostos", "en": "Budgets", "es": "Presupuestos"}	2	{}	0	\N	2017-09-13 12:47:50.070067	Decidim::ParticipatoryProcess
12	surveys	{"ca": "Enquesta", "en": "Survey", "es": "Encuesta"}	2	{}	0	\N	2017-09-13 12:47:50.720678	Decidim::ParticipatoryProcess
13	pages	{"ca": "Pàgina", "en": "Page", "es": "Página"}	3	{}	0	\N	2017-09-13 12:47:51.552004	Decidim::ParticipatoryProcess
14	meetings	{"ca": "Trobades", "en": "Meetings", "es": "Lista de encuentros"}	3	{}	0	\N	2017-09-13 12:47:51.581284	Decidim::ParticipatoryProcess
15	proposals	{"ca": "Propostes", "en": "Proposals", "es": "Propuestas"}	3	{"steps": {"3": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "official_proposals_enabled": true, "proposal_answering_enabled": true}}	0	\N	2017-09-13 12:47:58.687603	Decidim::ParticipatoryProcess
17	budgets	{"ca": "Pressupostos", "en": "Budgets", "es": "Presupuestos"}	3	{}	0	\N	2017-09-13 12:48:07.816435	Decidim::ParticipatoryProcess
18	surveys	{"ca": "Enquesta", "en": "Survey", "es": "Encuesta"}	3	{}	0	\N	2017-09-13 12:48:08.614151	Decidim::ParticipatoryProcess
19	pages	{"ca": "Pàgina", "en": "Page", "es": "Página"}	1	{}	0	\N	2017-09-13 12:48:09.690762	Decidim::Assembly
20	meetings	{"ca": "Trobades", "en": "Meetings", "es": "Lista de encuentros"}	1	{}	0	\N	2017-09-13 12:48:09.813026	Decidim::Assembly
21	proposals	{"ca": "Propostes", "en": "Proposals", "es": "Propuestas"}	1	{"steps": {}, "global": {"vote_limit": 0, "announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "official_proposals_enabled": true, "proposal_answering_enabled": true}}	0	\N	2017-09-13 12:48:17.099414	Decidim::Assembly
23	budgets	{"ca": "Pressupostos", "en": "Budgets", "es": "Presupuestos"}	1	{}	0	\N	2017-09-13 12:48:24.020316	Decidim::Assembly
24	surveys	{"ca": "Enquesta", "en": "Survey", "es": "Encuesta"}	1	{}	0	\N	2017-09-13 12:48:24.740716	Decidim::Assembly
25	pages	{"ca": "Pàgina", "en": "Page", "es": "Página"}	2	{}	0	\N	2017-09-13 12:48:24.938732	Decidim::Assembly
26	meetings	{"ca": "Trobades", "en": "Meetings", "es": "Lista de encuentros"}	2	{}	0	\N	2017-09-13 12:48:24.981263	Decidim::Assembly
27	proposals	{"ca": "Propostes", "en": "Proposals", "es": "Propuestas"}	2	{"steps": {}, "global": {"vote_limit": 0, "announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "official_proposals_enabled": true, "proposal_answering_enabled": true}}	0	\N	2017-09-13 12:48:32.028675	Decidim::Assembly
29	budgets	{"ca": "Pressupostos", "en": "Budgets", "es": "Presupuestos"}	2	{}	0	\N	2017-09-13 12:48:40.236461	Decidim::Assembly
30	surveys	{"ca": "Enquesta", "en": "Survey", "es": "Encuesta"}	2	{}	0	\N	2017-09-13 12:48:40.992856	Decidim::Assembly
31	pages	{"ca": "Pàgina", "en": "Page", "es": "Página"}	3	{}	0	\N	2017-09-13 12:48:41.170411	Decidim::Assembly
32	meetings	{"ca": "Trobades", "en": "Meetings", "es": "Lista de encuentros"}	3	{}	0	\N	2017-09-13 12:48:41.273521	Decidim::Assembly
33	proposals	{"ca": "Propostes", "en": "Proposals", "es": "Propuestas"}	3	{"steps": {}, "global": {"vote_limit": 0, "announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "official_proposals_enabled": true, "proposal_answering_enabled": true}}	0	\N	2017-09-13 12:48:48.162546	Decidim::Assembly
35	budgets	{"ca": "Pressupostos", "en": "Budgets", "es": "Presupuestos"}	3	{}	0	\N	2017-09-13 12:48:55.866599	Decidim::Assembly
36	surveys	{"ca": "Enquesta", "en": "Survey", "es": "Encuesta"}	3	{}	0	\N	2017-09-13 12:48:56.387064	Decidim::Assembly
43	proposals	{"fr": "Questions - réponses"}	4	{"steps": {"4": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}, "5": {"announcement": {"fr": "<p>Posez votre question. Si elle est retenue, vous recevrez dans les meilleurs délais une réponse officielle du maître d’ouvrage, le Grand Port Maritime de Dunkerque.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Posez votre question. Si elle est retenue, vous recevrez dans les meilleurs délais une réponse officielle du maître d’ouvrage, le Grand Port Maritime de Dunkerque.</p>", "comments_blocked": true, "creation_enabled": true, "proposal_answering_enabled": true}, "6": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-09-13 16:35:22.386145	Decidim::ParticipatoryProcess
39	proposals	{"fr": "Avis"}	4	{"steps": {"4": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}, "5": {"announcement": {"fr": "<p>La Commission particulière du débat public (CPDP) invite le public à participer au débat sous la forme de contributions ou avis écrits. Ils font partie des documents du débat public et, à ce titre, il en sera tenu compte dans le compte rendu et le bilan du débat public. Toute personne morale ou physique peut rédiger une contribution ou un avis. Ils doivent être argumentés pour pouvoir être pris en compte par la CPDP.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>La Commission particulière du débat public (CPDP) invite le public à participer au débat sous la forme de contributions ou avis écrits. Ils font partie des documents du débat public et, à ce titre, il en sera tenu compte dans le compte rendu et le bilan du débat public. Toute personne morale ou physique peut rédiger une contribution ou un avis. Ils doivent être argumentés pour pouvoir être pris en compte par la CPDP.</p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "6": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": true, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-09-13 16:35:27.527806	Decidim::ParticipatoryProcess
42	proposals	{"fr": "Forum"}	4	{"steps": {"4": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "5": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": false}, "6": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-09-13 16:35:33.078571	Decidim::ParticipatoryProcess
34	accountability	{"ca": "Resultats", "en": "Results", "es": "Resultados"}	3	{}	0	\N	2017-09-13 12:48:55.440729	Decidim::Assembly
37	meetings	{"fr": "Rencontres"}	4	{"steps": {"4": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "5": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "6": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}}, "global": {"announcement": {"fr": "<p>Rencontres physiques et réunions publiques prévues pour échanger autour du projet.</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Rencontres physiques et réunions publiques prévues pour échanger autour du projet.</p>", "comments_enabled": true}, "default_step": {"announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false}}	0	\N	2017-09-13 16:35:15.942166	Decidim::ParticipatoryProcess
44	meetings	{"fr": "Rencontres"}	5	{"steps": {"7": {"announcement": {"ca": null, "en": null, "es": null, "fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "8": {"announcement": {"ca": null, "en": null, "es": null, "fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "9": {"announcement": {"ca": null, "en": null, "es": null, "fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}}, "global": {"announcement": {"ca": null, "en": null, "es": null, "fr": "<p>Rencontres physiques et réunions publiques prévues pour échanger autour du projet.</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Rencontres physiques et réunions publiques prévues pour échanger autour du projet.</p>", "comments_enabled": true}}	0	\N	2017-09-15 12:32:57.684876	Decidim::ParticipatoryProcess
47	proposals	{"fr": "Avis"}	5	{"steps": {"7": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}, "8": {"announcement": {"fr": "<p>La Commission particulière du débat public (CPDP) invite le public à participer au débat sous la forme de contributions ou avis écrits. Ils font partie des documents du débat public et, à ce titre, il en sera tenu compte dans le compte rendu et le bilan du débat public. Toute personne morale ou physique peut rédiger une contribution ou un avis. Ils doivent être argumentés pour pouvoir être pris en compte par la CPDP.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>La Commission particulière du débat public (CPDP) invite le public à participer au débat sous la forme de contributions ou avis écrits. Ils font partie des documents du débat public et, à ce titre, il en sera tenu compte dans le compte rendu et le bilan du débat public. Toute personne morale ou physique peut rédiger une contribution ou un avis. Ils doivent être argumentés pour pouvoir être pris en compte par la CPDP.</p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "9": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": true, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-09-15 12:33:24.154863	Decidim::ParticipatoryProcess
46	proposals	{"fr": "Forum"}	5	{"steps": {"7": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p><p><br></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p><p><br></p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "8": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p><p>Il s’agit ici d’un espace ouvert où vous pouvez contribuer en proposant des sujets de discussion ou bien réagissant aux contributions d’autres participants. Vous pouvez ainsi proposer des thématiques de discussion en lien avec le sujet du débat public ou de la concertation, ou bien participer à des discussions qui sont déjà en cours.</p><p>Les animateurs des processus participatifs peuvent eux aussi proposer des sujets de discussion sur le forum.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p><p>Il s’agit ici d’un espace ouvert où vous pouvez contribuer en proposant des sujets de discussion ou bien réagissant aux contributions d’autres participants. Vous pouvez ainsi proposer des thématiques de discussion en lien avec le sujet du débat public ou de la concertation, ou bien participer à des discussions qui sont déjà en cours.</p><p>Les animateurs des processus participatifs peuvent eux aussi proposer des sujets de discussion sur le forum.</p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": false}, "9": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p>", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-09-15 12:33:05.215858	Decidim::ParticipatoryProcess
4	accountability	{"ca": "Resultats", "en": "Results", "es": "Resultados"}	1	{}	0	\N	2017-09-13 12:47:32.745039	Decidim::ParticipatoryProcess
10	accountability	{"ca": "Resultats", "en": "Results", "es": "Resultados"}	2	{}	0	\N	2017-09-13 12:47:49.747083	Decidim::ParticipatoryProcess
45	proposals	{"fr": "Questions - réponses"}	5	{"steps": {"7": {"announcement": {"fr": "<p>annonce test</p>"}, "votes_hidden": false, "votes_blocked": true, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>annonce test</p>", "comments_blocked": true, "creation_enabled": true, "proposal_answering_enabled": false}, "8": {"announcement": {"fr": "<p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p>", "comments_blocked": true, "creation_enabled": true, "proposal_answering_enabled": true}, "9": {"announcement": {"fr": ""}, "votes_hidden": true, "votes_blocked": true, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": "<p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p>", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-09-15 12:33:19.687487	Decidim::ParticipatoryProcess
48	meetings	{"fr": "Rencontres"}	6	{"steps": {"10": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "11": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "12": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": true}}, "global": {"announcement": {"fr": "<p>Rencontres physiques et réunions publiques prévues pour échanger autour du projet.</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Rencontres physiques et réunions publiques prévues pour échanger autour du projet.</p>", "comments_enabled": true}, "default_step": {"announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false}}	0	\N	\N	Decidim::ParticipatoryProcess
49	proposals	{"fr": "Déposez un avis"}	6	{"steps": {"10": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}, "11": {"announcement": {"fr": "<p><strong><em>La plateforme ferme dans la soirée de vendredi 22 décembre.</em></strong></p><p><strong><em>Si vous souhaitez déposer un avis, vous pouvez l'envoyer par email à </em></strong><em> </em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p><p><strong><em>Tous les avis arrivés avant minuit ce vendredi 22 décembre seront pris en compte.</em></strong></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p><strong><em>La plateforme ferme dans la soirée de vendredi 22 décembre.</em></strong></p><p><strong><em>Si vous souhaitez déposer un avis, vous pouvez l'envoyer par email à </em></strong><em> </em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p><p><strong><em>Tous les avis arrivés avant minuit ce vendredi 22 décembre seront pris en compte.</em></strong></p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "12": {"announcement": {"fr": "<p>Le débat se clôt vendredi 22 décembre à minuit. Merci pour vos contributions.</p><p><br></p><p><strong><em>La plateforme ferme dans la soirée de vendredi 22 décembre.</em></strong></p><p><strong><em>Si vous souhaitez déposer un avis, vous pouvez l'envoyer par email à  </em></strong><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><strong><em>portdedunkerque@debat-cndp.fr</em></strong></a></p><p><strong><em>Tous les avis arrivés avant minuit ce vendredi 22 décembre seront pris en compte.</em></strong></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Le débat se clôt vendredi 22 décembre à minuit. Merci pour vos contributions.</p><p><br></p><p><strong><em>La plateforme ferme dans la soirée de vendredi 22 décembre.</em></strong></p><p><strong><em>Si vous souhaitez déposer un avis, vous pouvez l'envoyer par email à  </em></strong><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><strong><em>portdedunkerque@debat-cndp.fr</em></strong></a></p><p><strong><em>Tous les avis arrivés avant minuit ce vendredi 22 décembre seront pris en compte.</em></strong></p>", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": true, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	3	\N	2017-09-17 16:02:44.169612	Decidim::ParticipatoryProcess
52	proposals	{"fr": "Propositions"}	7	{"steps": {"13": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "18": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": true, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-10-09 08:39:58.093411	Decidim::ParticipatoryProcess
57	pages	{"fr": "Bilan"}	9	{"steps": {"16": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}, "17": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}}, "global": {"announcement": {"fr": "<p>Vous avez participé à la priorisation des recommandations issues des jeux de rôles, veuillez trouver ci-dessous le résultat de ce travail. </p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Vous avez participé à la priorisation des recommandations issues des jeux de rôles, veuillez trouver ci-dessous le résultat de ce travail. </p>"}, "default_step": {"announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null}}	0	\N	\N	Decidim::ParticipatoryProcess
59	surveys	{"fr": "Questionnaire d'avant-débat"}	10	{"steps": {"19": {"announcement": {"fr": ""}, "allow_answers": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}}, "global": {"announcement": {"fr": "<p>Le débat public sur le projet Montagne d’Or en Guyane se prépare. Cette démarche de démocratie participative a besoin de votre avis et de vos contributions. La commission particulière chargée d’organiser et d’animer le débat souhaite connaître vos attentes et vous invite à remplir ce questionnaire,</p><p>de manière nominative ou anonyme.</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Le débat public sur le projet Montagne d’Or en Guyane se prépare. Cette démarche de démocratie participative a besoin de votre avis et de vos contributions. La commission particulière chargée d’organiser et d’animer le débat souhaite connaître vos attentes et vous invite à remplir ce questionnaire,</p><p>de manière nominative ou anonyme.</p>"}, "default_step": {"announcement": {}, "allow_answers": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null}}	0	\N	2018-01-25 16:04:50.15876	Decidim::ParticipatoryProcess
53	accountability	{"fr": "Questions - réponses"}	7	{"steps": {"13": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "18": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}}, "global": {"announcement": {"fr": "<p>Pour poser votre question, cliquez sur le bouton&nbsp;ci-dessous&nbsp;«&nbsp;nouvelle proposition&nbsp;»&nbsp;Une réponse vous sera apportée dans un délai de 15 jours.</p><p><em>Pour toute question sur l’utilisation de cette plateforme, contactez&nbsp;:&nbsp;</em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Pour poser votre question, cliquez sur le bouton&nbsp;ci-dessous&nbsp;«&nbsp;nouvelle proposition&nbsp;»&nbsp;Une réponse vous sera apportée dans un délai de 15 jours.</p><p><em>Pour toute question sur l’utilisation de cette plateforme, contactez&nbsp;:&nbsp;</em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p>", "comments_enabled": true}, "default_step": {"announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false}}	0	\N	2017-10-09 09:00:15.785697	Decidim::ParticipatoryProcess
60	surveys	{"fr": "Enquête"}	7	{"steps": {"13": {"announcement": {"fr": ""}, "allow_answers": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}, "18": {"announcement": {"fr": ""}, "allow_answers": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}}, "global": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}, "default_step": {"announcement": {}, "allow_answers": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null}}	0	\N	2018-01-25 16:40:14.523041	Decidim::ParticipatoryProcess
56	proposals	{"fr": "Recommandations"}	9	{"steps": {"16": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "17": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {"fr": "<p>Ci-dessous vous trouverez l'ensemble des recommandations concernant le rôle des garants émises à l'issue des jeux de rôles. </p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Ci-dessous vous trouverez l'ensemble des recommandations concernant le rôle des garants émises à l'issue des jeux de rôles. </p>", "comments_enabled": false, "geocoding_enabled": false, "attachments_allowed": true, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": false}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	\N	Decidim::ParticipatoryProcess
51	proposals	{"fr": "Posez une question"}	6	{"steps": {"10": {"announcement": {"fr": "<p>annonce test</p>"}, "votes_hidden": false, "votes_blocked": true, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>annonce test</p>", "comments_blocked": true, "creation_enabled": true, "proposal_answering_enabled": false}, "11": {"announcement": {"fr": "<p><strong>Pour poser votre question, cliquez sur le bouton&nbsp;ci-dessous&nbsp;«&nbsp;nouvelle proposition&nbsp;»&nbsp;</strong>Une réponse vous sera apportée dans un délai de 15 jours.</p><p><em>Pour toute question sur l’utilisation de cette plateforme, contactez&nbsp;: </em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p><strong>Pour poser votre question, cliquez sur le bouton&nbsp;ci-dessous&nbsp;«&nbsp;nouvelle proposition&nbsp;»&nbsp;</strong>Une réponse vous sera apportée dans un délai de 15 jours.</p><p><em>Pour toute question sur l’utilisation de cette plateforme, contactez&nbsp;: </em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p>", "comments_blocked": true, "creation_enabled": true, "proposal_answering_enabled": true}, "12": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": true, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": "<p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p>", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	1	\N	\N	Decidim::ParticipatoryProcess
55	accountability	{"fr": "Résultats"}	8	{"steps": {"14": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}, "15": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false}}, "global": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true}, "default_step": {"announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false}}	1	\N	2017-10-13 15:12:47.56628	Decidim::ParticipatoryProcess
54	proposals	{"fr": "Propositions"}	8	{"steps": {"14": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": false}, "15": {"announcement": {"fr": ""}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": false, "geocoding_enabled": false, "attachments_allowed": true, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": false}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	0	\N	2017-10-13 14:42:40.911337	Decidim::ParticipatoryProcess
58	pages	{"fr": "Page d'info"}	7	{"steps": {"13": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}, "18": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}}, "global": {"announcement": {"fr": "<p>Une page de test...</p>"}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Une page de test...</p>"}, "default_step": {"announcement": {}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null}}	2	\N	2017-11-14 11:56:44.126999	Decidim::ParticipatoryProcess
50	proposals	{"fr": "Participez au forum"}	6	{"steps": {"10": {"announcement": {"fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p><p><br></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Utilisez cet espace pour proposer des sujets à la discussion. Votre sujet sera directement publié et d’autres citoyens pourront venir participer à la discussion.</p><p><br></p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": true}, "11": {"announcement": {"fr": "<p>Pour&nbsp;participer au forum&nbsp;, cliquez sur le bouton&nbsp;ci-dessous&nbsp;«&nbsp;nouvelle proposition&nbsp;»</p><p><br></p><p><em>Pour toute question sur l’utilisation de cette plate-forme, contactez&nbsp;: </em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p><p><br></p><p><strong>Le forum ferme ce vendredi 22 décembre dans la soirée.</strong></p><p><br></p><p><br></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Pour&nbsp;participer au forum&nbsp;, cliquez sur le bouton&nbsp;ci-dessous&nbsp;«&nbsp;nouvelle proposition&nbsp;»</p><p><br></p><p><em>Pour toute question sur l’utilisation de cette plate-forme, contactez&nbsp;: </em><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><em>portdedunkerque@debat-cndp.fr</em></a></p><p><br></p><p><strong>Le forum ferme ce vendredi 22 décembre dans la soirée.</strong></p><p><br></p><p><br></p>", "comments_blocked": false, "creation_enabled": true, "proposal_answering_enabled": false}, "12": {"announcement": {"fr": "<p>Le débat se clôt vendredi 22 décembre à minuit. Merci pour vos contributions.</p><p><br></p><p><strong><em>La plateforme ferme dans la soirée de vendredi 22 décembre.</em></strong></p><p><strong><em>Si vous souhaitez déposer un avis, vous pouvez l'envoyer par email à  </em></strong><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><strong><em>portdedunkerque@debat-cndp.fr</em></strong></a></p><p><strong><em>Tous les avis arrivés avant minuit ce vendredi 22 décembre seront pris en compte.</em></strong></p>"}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "<p>Le débat se clôt vendredi 22 décembre à minuit. Merci pour vos contributions.</p><p><br></p><p><strong><em>La plateforme ferme dans la soirée de vendredi 22 décembre.</em></strong></p><p><strong><em>Si vous souhaitez déposer un avis, vous pouvez l'envoyer par email à  </em></strong><a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\"><strong><em>portdedunkerque@debat-cndp.fr</em></strong></a></p><p><strong><em>Tous les avis arrivés avant minuit ce vendredi 22 décembre seront pris en compte.</em></strong></p>", "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": false}}, "global": {"vote_limit": 0, "announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": "", "comments_enabled": true, "geocoding_enabled": false, "attachments_allowed": false, "new_proposal_help_text": {"fr": ""}, "new_proposal_help_text_ca": null, "new_proposal_help_text_en": null, "new_proposal_help_text_es": null, "new_proposal_help_text_fr": "", "official_proposals_enabled": true, "proposal_answering_enabled": true}, "default_step": {"announcement": {}, "votes_hidden": false, "votes_blocked": false, "votes_enabled": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null, "comments_blocked": false, "creation_enabled": false, "proposal_answering_enabled": true}}	2	\N	2017-09-17 16:02:39.092316	Decidim::ParticipatoryProcess
16	accountability	{"ca": "Resultats", "en": "Results", "es": "Resultados"}	3	{}	0	\N	2017-09-13 12:48:07.449787	Decidim::ParticipatoryProcess
22	accountability	{"ca": "Resultats", "en": "Results", "es": "Resultados"}	1	{}	0	\N	2017-09-13 12:48:23.77503	Decidim::Assembly
28	accountability	{"ca": "Resultats", "en": "Results", "es": "Resultados"}	2	{}	0	\N	2017-09-13 12:48:39.772409	Decidim::Assembly
61	surveys	{"fr": "Enquête test"}	7	{"steps": {"13": {"announcement": {"fr": ""}, "allow_answers": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}, "18": {"announcement": {"fr": ""}, "allow_answers": true, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}}, "global": {"announcement": {"fr": ""}, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": ""}, "default_step": {"announcement": {}, "allow_answers": false, "announcement_ca": null, "announcement_en": null, "announcement_es": null, "announcement_fr": null}}	0	\N	2018-02-02 07:06:42.137448	Decidim::ParticipatoryProcess
\.


--
-- Data for Name: decidim_follows; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_follows (id, decidim_user_id, decidim_followable_type, decidim_followable_id, created_at, updated_at) FROM stdin;
1	330	Decidim::Proposals::Proposal	122	2017-09-17 15:13:43.05845	2017-09-17 15:13:43.05845
2	374	Decidim::Proposals::Proposal	140	2017-10-01 09:08:38.860149	2017-10-01 09:08:38.860149
3	374	Decidim::Proposals::Proposal	138	2017-10-02 10:27:00.548022	2017-10-02 10:27:00.548022
4	358	Decidim::Proposals::Proposal	151	2017-10-12 08:13:07.104177	2017-10-12 08:13:07.104177
5	397	Decidim::Proposals::Proposal	230	2017-11-07 20:35:33.005206	2017-11-07 20:35:33.005206
6	415	Decidim::Proposals::Proposal	257	2017-11-15 15:38:57.27986	2017-11-15 15:38:57.27986
7	414	Decidim::Proposals::Proposal	256	2017-11-15 15:59:20.893297	2017-11-15 15:59:20.893297
8	424	Decidim::Proposals::Proposal	341	2017-12-05 19:35:06.485048	2017-12-05 19:35:06.485048
9	415	Decidim::Proposals::Proposal	366	2017-12-15 13:56:17.961951	2017-12-15 13:56:17.961951
10	415	Decidim::Proposals::Proposal	381	2017-12-20 20:26:34.599528	2017-12-20 20:26:34.599528
\.


--
-- Data for Name: decidim_identities; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_identities (id, provider, uid, decidim_user_id, created_at, updated_at, decidim_organization_id) FROM stdin;
\.


--
-- Data for Name: decidim_impersonation_logs; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_impersonation_logs (id, decidim_admin_id, decidim_user_id, started_at, ended_at, expired_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_meetings_meetings; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_meetings_meetings (id, title, description, start_time, end_time, address, location, location_hints, decidim_feature_id, decidim_author_id, decidim_scope_id, created_at, updated_at, closing_report, attendees_count, contributions_count, attending_organizations, closed_at, latitude, longitude, reference, registrations_enabled, available_slots, registration_terms) FROM stdin;
1	{"ca": "Quidem vel quia.", "en": "Sed quaerat optio quod.", "es": "Praesentium error."}	{"ca": "<p>Rerum fugiat est explicabo quae eaque neque commodi. Dolorem totam aut et consequatur facere nam sunt. Distinctio qui atque.</p>", "en": "<p>Sit asperiores voluptatem non quo sequi similique. Earum quia id rem adipisci autem. Omnis voluptas qui. Quod consequatur non error.</p>", "es": "<p>Nemo praesentium minus autem dolore. Impedit earum cupiditate. In ut blanditiis necessitatibus ducimus. Labore corrupti eos at. Sed enim laborum voluptas voluptates voluptatem dolor.</p>"}	2017-10-04 12:47:18.674473	2017-10-04 16:47:18.674613	814 Wehner Ports 93456 Milesmouth	{"ca": "Dolorum eveniet non non.", "en": "Accusamus iste et accusantium labore odio tempore quo.", "es": "Pariatur deserunt mollitia ut sunt distinctio."}	{"ca": "Quos ut assumenda et id officia debitis quo.", "en": "Rerum odio repellat suscipit assumenda consequatur voluptatem.", "es": "Aperiam illo numquam velit quia ullam aut."}	2	\N	15	2017-09-13 12:47:18.777902	2017-09-13 12:47:18.794599	\N	\N	\N	\N	\N	62.4566949613887914	83.2060551808763762	Jr.-MEET-2017-09-1	f	40	{"ca": "<p>Ut aut corporis placeat nam perspiciatis velit doloribus. Consequatur ut omnis maiores. Soluta a non quaerat autem.</p>", "en": "<p>Deserunt voluptates voluptas quo error amet et. Sit excepturi ad omnis nesciunt. Qui dolorem ut harum laboriosam blanditiis repellat aspernatur.</p>", "es": "<p>Fugit nesciunt dolore. Qui facere ut ipsa eveniet et. Amet et architecto. Consequatur rem non quasi.</p>"}
2	{"ca": "Sint ut distinctio voluptatem dolores et.", "en": "Est magni fuga.", "es": "Commodi in ipsam ut."}	{"ca": "<p>Modi doloremque cumque natus et. Ducimus nulla in deleniti. Ea aut at sed facere veritatis quia. Ea libero quod perspiciatis explicabo aut quo.</p>", "en": "<p>Dolor deserunt voluptas autem quod. Doloribus nesciunt architecto qui non. Atque et dolor nam asperiores. Sunt qui voluptas pariatur magni sit impedit.</p>", "es": "<p>Voluptatem at et aperiam vitae enim qui et. Quia dolorem qui est suscipit laborum repudiandae illo. Corrupti ea ad culpa aut dolores. Maxime cum esse impedit sapiente porro sequi. Fuga nihil molestiae nisi quibusdam neque ipsam.</p>"}	2017-10-04 12:47:21.148242	2017-10-04 16:47:21.148433	2339 Abbey Well 81532 Tillmanside	{"ca": "Et ipsam autem quibusdam ullam illum.", "en": "Sequi sit minus unde tempore nam molestiae ducimus.", "es": "Nemo vel inventore cum eos numquam."}	{"ca": "Est ipsam ea repudiandae corporis laboriosam architecto veritatis.", "en": "Qui est ut nihil ad dolorum.", "es": "Sunt sit ipsam sapiente a voluptate laborum ad."}	2	\N	15	2017-09-13 12:47:21.158402	2017-09-13 12:47:21.176296	\N	\N	\N	\N	\N	-38.5476383402738705	-176.108227527926942	Jr.-MEET-2017-09-2	f	30	{"ca": "<p>Excepturi quo iste impedit at et. Qui mollitia rerum eaque nihil adipisci ut. Cupiditate aut pariatur. Beatae ea accusamus qui debitis error nihil. Nobis placeat ducimus repudiandae optio earum asperiores cumque.</p>", "en": "<p>Id non quia cupiditate. Tenetur ad libero voluptate nostrum. Asperiores et cumque sed nam dolorem.</p>", "es": "<p>Et soluta cumque. Ut doloribus laboriosam ad eveniet sit illo. Quidem qui ipsam nisi explicabo dicta doloribus id.</p>"}
3	{"ca": "Labore fuga repudiandae nostrum tempora occaecati autem.", "en": "Perferendis totam harum quidem ipsa.", "es": "Ut quia maxime impedit esse aut rerum."}	{"ca": "<p>Reiciendis aut rerum laudantium reprehenderit ratione porro aut. Voluptate et rerum. Voluptas ut harum ut officiis hic. Numquam est eos. Mollitia dolores ipsam quisquam omnis hic nesciunt quo.</p>", "en": "<p>Quaerat enim possimus dolore sit sint et illo. Nulla perspiciatis odio aut perferendis iste tempore. Molestiae rem consectetur nulla. Quibusdam adipisci doloremque autem fuga fugit. Rem dolores laboriosam.</p>", "es": "<p>Fuga et qui. Sint ab voluptatem excepturi quia mollitia. Ullam doloribus sequi enim aut autem impedit et.</p>"}	2017-10-04 12:47:23.40886	2017-10-04 16:47:23.408979	472 Hickle Station 13492 Hyattfurt	{"ca": "Est temporibus et alias.", "en": "Rem nulla non enim.", "es": "Ratione quos est quia sint cupiditate."}	{"ca": "Sunt eos quo earum error alias voluptatem nihil facilis.", "en": "Quia iusto inventore reiciendis esse.", "es": "Aliquam molestiae ut debitis itaque."}	2	\N	15	2017-09-13 12:47:23.416491	2017-09-13 12:47:23.429391	\N	\N	\N	\N	\N	23.9093145977898018	91.0989762175689179	Jr.-MEET-2017-09-3	f	10	{"ca": "<p>Eligendi expedita molestias. Voluptas nobis reiciendis quae. Sed debitis consectetur reprehenderit aut perferendis occaecati. Cupiditate nihil dolores soluta ullam ea corrupti. Ipsum harum quas atque sint porro est.</p>", "en": "<p>Sint dolorem est recusandae est voluptas ut. Provident eaque sunt illo. Commodi sit odio deleniti enim dolorem velit.</p>", "es": "<p>Enim error iusto pariatur omnis. Rerum aperiam consequatur facilis. Ea rerum aut dolorum modi accusamus velit.</p>"}
4	{"ca": "Modi placeat vel.", "en": "Dolor asperiores rem saepe.", "es": "Reiciendis accusamus eveniet."}	{"ca": "<p>Debitis voluptatum hic. Eius incidunt explicabo quibusdam deleniti voluptatem. Odio dolorum illum eos consequatur omnis deserunt nihil. Corrupti maiores totam. Omnis et deserunt et expedita ipsum et.</p>", "en": "<p>Nobis quas omnis blanditiis odio fuga quidem. Illum fuga itaque architecto esse sed unde. Eligendi maiores voluptas ut cupiditate.</p>", "es": "<p>Ratione et iure cupiditate voluptatem laborum sed qui. Ad nostrum est temporibus corporis. Quas provident et placeat optio dolorem in. Officia nostrum ut repellendus sequi. Saepe fuga beatae qui.</p>"}	2017-10-04 12:47:34.932513	2017-10-04 16:47:34.932641	6688 Haag Court 61277 North Jonathanburgh	{"ca": "Eius officia voluptatem molestiae beatae qui.", "en": "Nesciunt quibusdam adipisci suscipit voluptatem voluptas deserunt reprehenderit.", "es": "Modi sed nisi vitae exercitationem aliquid cum architecto ut."}	{"ca": "Voluptates porro adipisci odit dolorem.", "en": "Consequatur non quibusdam accusamus.", "es": "Quos natus ea facilis ipsum omnis nam ex ut."}	8	\N	12	2017-09-13 12:47:34.941287	2017-09-13 12:47:34.96709	\N	\N	\N	\N	\N	28.8657916090755577	82.1383108014433674	Jr.-MEET-2017-09-4	t	50	{"ca": "<p>Occaecati fuga rerum dolorum. Tenetur aut quo veritatis eveniet occaecati. Eius quae porro qui.</p>", "en": "<p>Expedita molestiae quo ut. Id ipsa odio expedita aperiam ratione voluptate quia. Nisi aut aut qui. Repellat aspernatur sint.</p>", "es": "<p>Ut delectus magnam ratione quod quia. Reiciendis voluptatibus debitis. Ipsum culpa aut fugiat ut nihil. Aut debitis assumenda porro consectetur sapiente est dicta. Sint nemo labore autem omnis ea earum nobis.</p>"}
5	{"ca": "Magni unde at nisi.", "en": "Excepturi ut deleniti suscipit.", "es": "Debitis omnis veniam rerum."}	{"ca": "<p>Pariatur harum quia aliquid. Velit consectetur rem tempora quam. Tempore ad consequatur perferendis tenetur. Error repellat fugiat laboriosam. Quia et aliquid non voluptatem quo numquam cum.</p>", "en": "<p>Quasi debitis excepturi sed velit repudiandae ducimus a. Exercitationem explicabo numquam et culpa beatae est totam. Minima esse et consectetur et id facere repudiandae. Omnis facere fuga aliquid id.</p>", "es": "<p>Unde est pariatur omnis voluptate aut. Quae ab placeat adipisci dolore dolorem vitae. Non et maxime et similique expedita. Perspiciatis et natus nobis sapiente unde animi ipsa.</p>"}	2017-10-04 12:47:37.320315	2017-10-04 16:47:37.320451	920 Ulises Corners 35194 Watersview	{"ca": "Quibusdam reprehenderit sint qui.", "en": "Sed et itaque nihil fugit rerum esse.", "es": "Iusto error sit aut."}	{"ca": "Repellat aliquid mollitia iure pariatur.", "en": "Minima rerum aliquam accusamus ipsa sit ut.", "es": "Ea ullam iusto pariatur qui repellat corrupti deleniti."}	8	\N	12	2017-09-13 12:47:37.328118	2017-09-13 12:47:37.346613	\N	\N	\N	\N	\N	76.680868737818713	69.6008699726440909	Jr.-MEET-2017-09-5	t	30	{"ca": "<p>Est ut recusandae impedit voluptas laborum quaerat tempora. Veritatis facere illum. Corporis sunt et et.</p>", "en": "<p>Consequatur nihil ut. Neque ab rerum est est. Voluptas sit rerum est vero qui.</p>", "es": "<p>Harum laborum voluptatem. Ea qui aspernatur. Perspiciatis dolor eius exercitationem totam laborum qui quia.</p>"}
6	{"ca": "Unde eius reiciendis.", "en": "Aut dolores ratione.", "es": "Facere sint tenetur ratione corporis et."}	{"ca": "<p>Occaecati debitis quaerat assumenda vero nesciunt sit. Veniam nostrum nulla laborum non est possimus rem. Veniam distinctio nihil dolor rem. Nobis praesentium eum facilis repellendus eligendi et tempore.</p>", "en": "<p>Omnis laudantium dolores. Distinctio aut porro ullam atque. Doloribus quo reiciendis doloremque officiis ipsum.</p>", "es": "<p>Ipsum libero veniam atque nostrum. Ut sit non explicabo veniam nemo. Nobis autem doloremque dicta accusamus. Sit est impedit dignissimos ea.</p>"}	2017-10-04 12:47:39.731033	2017-10-04 16:47:39.731169	80643 Greenfelder Coves 86867 Aimeeland	{"ca": "Vel odit culpa iste.", "en": "Consectetur hic harum et optio quasi aut deleniti.", "es": "Eaque vel incidunt dolorem rerum."}	{"ca": "Facere animi rerum amet hic dolores consectetur.", "en": "Consequuntur suscipit ut quasi vel.", "es": "Nesciunt quam natus non ea dolorem incidunt saepe voluptas."}	8	\N	12	2017-09-13 12:47:39.739983	2017-09-13 12:47:39.757188	\N	\N	\N	\N	\N	16.7515397183641284	-63.2482235800438843	Jr.-MEET-2017-09-6	f	50	{"ca": "<p>Possimus esse neque. Quasi dolorem necessitatibus qui rerum sit sint cupiditate. Quae amet accusantium laboriosam voluptate eaque.</p>", "en": "<p>Nobis quibusdam consequatur doloremque cupiditate autem ut alias. Fugit commodi dicta eos id. Placeat quisquam vel. Cumque eligendi autem quo sed. Impedit quae ratione.</p>", "es": "<p>Animi unde delectus soluta impedit porro. Et voluptatum aperiam et ut laborum autem qui. Dolor atque ut facilis.</p>"}
7	{"ca": "Et fuga doloribus magnam adipisci officia aliquam.", "en": "Quis doloremque aut incidunt et.", "es": "Et ut fugiat itaque nulla."}	{"ca": "<p>Id ea error vitae. Et odio fuga sunt. Quidem dolor unde praesentium.</p>", "en": "<p>Voluptatibus dicta perferendis. Dolor esse delectus fugit rerum nobis repellendus. Incidunt et fuga maiores aspernatur. Consequatur repudiandae in optio porro ut provident.</p>", "es": "<p>Eos eaque voluptate blanditiis ab. Voluptatum totam neque. Aspernatur et architecto est ipsa molestias ea ducimus. Consectetur sed quia illum inventore fugit. Modi voluptates deleniti eum quasi fugiat.</p>"}	2017-10-04 12:47:51.591274	2017-10-04 16:47:51.591391	2433 Langworth Haven 51537 Zenaside	{"ca": "Minus omnis in illo a.", "en": "Corporis odit eligendi quisquam ab.", "es": "Totam odit aut dolores aut deleniti rerum."}	{"ca": "Aut tenetur sit saepe quo ipsam accusantium.", "en": "Rerum quae qui ipsam.", "es": "Iusto sunt recusandae veniam ratione voluptatem eaque esse ea."}	14	\N	5	2017-09-13 12:47:51.598538	2017-09-13 12:47:51.611063	\N	\N	\N	\N	\N	12.4927071804343797	174.17840931274111	Jr.-MEET-2017-09-7	t	50	{"ca": "<p>Impedit rerum velit quos culpa enim quo. Cum modi aliquam. Debitis assumenda autem sed deserunt voluptatum. Occaecati laborum dolores ratione eveniet quis facilis. Ex aut porro inventore eveniet.</p>", "en": "<p>Quis dolor est. Soluta occaecati accusamus repudiandae qui perspiciatis repellendus ut. Atque et consequatur nesciunt dolorem.</p>", "es": "<p>Ea quia accusantium architecto laudantium magni est qui. Magnam suscipit aut aut fugit. Rerum ex assumenda adipisci. Vel nihil tempore.</p>"}
8	{"ca": "Optio aut exercitationem atque suscipit omnis quae.", "en": "Quia non et atque nostrum qui quos.", "es": "Esse voluptas autem alias molestiae in aliquid."}	{"ca": "<p>Architecto error ipsam fuga et laborum. Numquam eius minus maxime molestias. Ut mollitia saepe illo.</p>", "en": "<p>Hic itaque aut consequatur suscipit rerum aut veritatis. Ex placeat eaque fuga quis ut amet. Sed doloribus est non occaecati praesentium et. Non doloremque sequi nemo qui necessitatibus adipisci ipsa.</p>", "es": "<p>Dolorum voluptatem quaerat voluptatibus quod qui suscipit. Voluptatem rerum modi ea sequi ab quidem repudiandae. Enim quis dolorum eum praesentium laudantium qui aut. Inventore maiores iste sunt dolore possimus.</p>"}	2017-10-04 12:47:53.883625	2017-10-04 16:47:53.883736	284 Prince Curve 61137 North Nettie	{"ca": "Aut et qui iusto.", "en": "Nesciunt aut occaecati aut asperiores id doloribus dolor consequatur.", "es": "Magnam aperiam aspernatur nesciunt molestias est quisquam beatae."}	{"ca": "Accusantium voluptas voluptatem qui ratione et.", "en": "A animi ut rerum id neque nihil in et.", "es": "Quis quia saepe et aut voluptas."}	14	\N	\N	2017-09-13 12:47:53.889696	2017-09-13 12:47:53.901124	\N	\N	\N	\N	\N	-32.3870808615687835	-152.526390648670713	Jr.-MEET-2017-09-8	f	20	{"ca": "<p>Qui laudantium dolorem voluptas vero quam sit. Eaque minus quia et doloribus rerum repellat quibusdam. Minus ipsa quia qui. Velit repellendus facilis molestiae aut provident harum.</p>", "en": "<p>Natus quia dolorem recusandae harum est magnam. Reiciendis architecto commodi rerum dolor pariatur. Quis beatae in soluta et error quia. Nulla cumque aut. Atque maxime ut et occaecati laborum tenetur nihil.</p>", "es": "<p>Veniam id eaque fuga delectus. Dolore facere quod ut et iure omnis. Laudantium exercitationem rerum veritatis maiores commodi similique voluptatem.</p>"}
9	{"ca": "Qui aut debitis corrupti.", "en": "Sed voluptatibus quam qui corporis consequatur ipsam.", "es": "Reprehenderit animi suscipit architecto sint omnis velit."}	{"ca": "<p>Quos et provident eum sequi. Eum quia fuga quo harum ipsam saepe ipsum. Distinctio cumque soluta et vel possimus.</p>", "en": "<p>Omnis dolorem saepe doloremque maxime quidem minima. Recusandae quam aut. Est ut corrupti corporis ducimus quasi deserunt aut.</p>", "es": "<p>Pariatur ipsa et aliquam qui eveniet. Aut suscipit qui velit sequi inventore ea fuga. Accusamus impedit repudiandae illo. Temporibus eius et est. Ut qui impedit eveniet quas incidunt reprehenderit.</p>"}	2017-10-04 12:47:56.219798	2017-10-04 16:47:56.219915	132 Huels Walks 88887-4957 Mullerberg	{"ca": "Nisi sit perferendis necessitatibus nihil qui in enim.", "en": "Deleniti rerum incidunt blanditiis.", "es": "Ad voluptatibus dolorum at magni."}	{"ca": "Fugiat nihil ut ut perferendis quo repudiandae eligendi sequi.", "en": "Qui quis sint ut.", "es": "Sapiente commodi quia debitis aspernatur sed culpa voluptatem."}	14	\N	\N	2017-09-13 12:47:56.226567	2017-09-13 12:47:56.239611	\N	\N	\N	\N	\N	-47.9074876320514562	6.87293919519868268	Jr.-MEET-2017-09-9	t	10	{"ca": "<p>Id veniam hic dicta. Deleniti magnam incidunt. Enim molestiae praesentium magnam minus placeat tenetur earum. Modi itaque non voluptate exercitationem. Reprehenderit iure alias.</p>", "en": "<p>Ut eligendi laboriosam voluptatem. Dicta incidunt et cupiditate. Aliquam quod voluptatem quia quidem porro. Minima alias tenetur quis.</p>", "es": "<p>Non alias ut cum dolores ut sit dignissimos. Reprehenderit neque impedit ut minima. Dignissimos modi eaque est et similique et eligendi. Molestias possimus qui quo itaque. Ut ea odio enim hic voluptates nihil dolorem.</p>"}
10	{"ca": "Veritatis neque corporis odio.", "en": "Id dicta quibusdam.", "es": "Placeat soluta et omnis autem."}	{"ca": "<p>Atque quidem perspiciatis eaque qui incidunt dicta. Ducimus qui perferendis. Est autem suscipit id doloribus reprehenderit quisquam. Nesciunt dolorem praesentium qui. Soluta sed consequatur dolor veritatis quaerat consequatur quo.</p>", "en": "<p>Rerum quis dolor numquam consequatur voluptatem. Deleniti corporis sed eius vel vel. Facilis quia sit consequatur officiis deleniti.</p>", "es": "<p>Provident qui quam qui. Accusamus aut aut vel natus voluptatum. Autem sed id quam laudantium.</p>"}	2017-10-04 12:48:09.827075	2017-10-04 16:48:09.827327	979 Ankunding Tunnel 40831 New Lelia	{"ca": "Nihil possimus odio doloremque.", "en": "Iusto laborum quo eveniet quibusdam.", "es": "Laudantium eos aut id."}	{"ca": "Eos iste delectus magni qui sint nihil cupiditate exercitationem.", "en": "Vero aut corporis voluptatem nemo dicta.", "es": "Quam aperiam qui ipsam vero numquam."}	20	\N	\N	2017-09-13 12:48:09.836178	2017-09-13 12:48:09.85772	\N	\N	\N	\N	\N	42.3694576877067561	149.269991260619577	Jr.-MEET-2017-09-10	t	30	{"ca": "<p>Autem non animi neque et omnis dolorem quia. Aliquam nemo cum. Dolor esse qui molestiae voluptatum voluptatem vero modi.</p>", "en": "<p>Officia rerum reiciendis dolore ad ab exercitationem consequatur. Et ad voluptas rerum fugiat commodi. Iusto in ratione saepe accusamus. Laborum aut cum. Aliquam accusantium repellendus unde enim mollitia.</p>", "es": "<p>Repellendus eum ut eum ex. Nisi perspiciatis repudiandae consequatur facilis. Quia quae ut. Sit temporibus provident sunt vitae vel tempora dolorem.</p>"}
11	{"ca": "Ex ducimus similique.", "en": "Non quaerat ut omnis magni illo.", "es": "Voluptas eum dignissimos quisquam veniam temporibus nesciunt."}	{"ca": "<p>Doloremque dolore provident. Totam rerum iste sed. Tenetur eos ut porro quia. Ut quo et facere beatae non dolor consectetur.</p>", "en": "<p>Necessitatibus iste autem molestias. Vel voluptatibus et consequatur. Perspiciatis commodi porro voluptate voluptatibus et sint. Dolor officia voluptatum. Eos quaerat quas ullam minima.</p>", "es": "<p>Quisquam consequuntur vel quia eligendi autem et. Qui corporis est repellat quaerat saepe id. Dignissimos et facere voluptas. Praesentium illo iste iure possimus quo tempore officiis.</p>"}	2017-10-04 12:48:12.428326	2017-10-04 16:48:12.428463	1669 Jane Burgs 23269 Jessborough	{"ca": "Natus atque voluptatem aut necessitatibus quidem.", "en": "Dolor enim sit rerum id quia.", "es": "Ipsum beatae ipsam veritatis vel magni culpa laboriosam quos."}	{"ca": "Dolores iusto quam maxime itaque.", "en": "Et sed et recusandae.", "es": "Cumque veritatis est consequatur voluptatem voluptas."}	20	\N	17	2017-09-13 12:48:12.439581	2017-09-13 12:48:12.462001	\N	\N	\N	\N	\N	-79.2009857043925933	-179.219430825593435	Jr.-MEET-2017-09-11	t	20	{"ca": "<p>Eius voluptatem ut neque et. Recusandae eos voluptas quisquam dolor aperiam error sed. Et totam temporibus odio vel eum aliquam. Saepe ut sequi blanditiis neque sapiente ad ut.</p>", "en": "<p>Vitae doloribus ipsam nesciunt dolore sit. Hic consequatur corporis. Nesciunt sed molestiae adipisci doloribus. Nostrum vel pariatur eaque harum vero mollitia laudantium.</p>", "es": "<p>Quaerat voluptatem officia nobis quis nisi et modi. Unde consequatur repellat id. Alias voluptatem sunt. Temporibus facere eum totam harum distinctio fugit. Reprehenderit quidem voluptates qui asperiores et sunt nihil.</p>"}
12	{"ca": "Neque est accusantium mollitia voluptatem quos.", "en": "Possimus omnis similique est animi sed sint.", "es": "Sit dolorum modi quis ut architecto in."}	{"ca": "<p>Aliquam numquam quas ea eveniet ab accusantium exercitationem. Sed doloribus assumenda quibusdam aut iusto sed. Aut ipsam cupiditate et. Est est saepe natus cumque unde. Aperiam similique minima sunt sit non voluptatem odit.</p>", "en": "<p>Commodi et sint suscipit autem ut nihil. Vel ratione est autem non qui est. Dicta dolor assumenda nisi. Quis est cumque omnis quo accusamus officiis. Assumenda est sint.</p>", "es": "<p>Sed harum ducimus. Esse quod cupiditate harum. Omnis similique eveniet cum voluptas omnis deleniti accusamus.</p>"}	2017-10-04 12:48:14.836782	2017-10-04 16:48:14.836942	6320 Christiansen Lodge 95860 New Kristy	{"ca": "Nobis quo amet natus illum est.", "en": "Qui voluptatem a deserunt voluptatum.", "es": "Necessitatibus debitis quis aut iste pariatur quis dolorem atque."}	{"ca": "Alias aliquam qui assumenda nihil officia ipsa.", "en": "Rerum totam et ad.", "es": "Dignissimos eum similique odit perferendis maxime aut suscipit."}	20	\N	3	2017-09-13 12:48:14.845497	2017-09-13 12:48:14.860423	\N	\N	\N	\N	\N	62.3534355986014361	-107.362772945025824	Jr.-MEET-2017-09-12	f	30	{"ca": "<p>Et adipisci beatae. Architecto harum ut ducimus dolorem id aliquid. Vitae quo facere debitis voluptates. Sit minima dolores necessitatibus eos eum animi.</p>", "en": "<p>Quis tempora ea. Aut reiciendis quo. Accusamus neque laborum non et quod distinctio reiciendis.</p>", "es": "<p>Iure ea a. Eligendi libero odio ut repellat molestiae. Saepe voluptatem autem quo.</p>"}
13	{"ca": "Reprehenderit eius dolores natus hic consequatur ex.", "en": "Dolore dolor sed doloribus totam rerum.", "es": "Iure consequatur et et alias suscipit."}	{"ca": "<p>Sint est similique. Necessitatibus ipsam quos soluta provident libero et illum. Veritatis optio et incidunt quod ut et. Ut culpa labore et ipsum.</p>", "en": "<p>Alias in quis illo quis voluptatem. Consequatur dolorum tempora. Molestiae voluptatem qui est quasi consequatur optio. Voluptatem enim enim laboriosam excepturi aut beatae velit.</p>", "es": "<p>Sint nobis dolore officia rem consequuntur id. Consequuntur magni earum. Iste tempore voluptatem quia nihil deleniti nobis. Saepe amet officiis recusandae vel id minima. Expedita cum vitae iure numquam et in blanditiis.</p>"}	2017-10-04 12:48:24.996071	2017-10-04 16:48:24.996211	65574 George Mount 78678-2859 East Chandler	{"ca": "Tempora veritatis assumenda ut cupiditate animi.", "en": "Ut enim et nemo iusto provident voluptas et.", "es": "Mollitia totam cumque non velit quia."}	{"ca": "Expedita eum at repudiandae blanditiis a suscipit et deserunt.", "en": "Iure minima quia tenetur excepturi animi ducimus et.", "es": "Veritatis laborum animi recusandae omnis dicta tenetur officiis."}	26	\N	13	2017-09-13 12:48:25.006251	2017-09-13 12:48:25.020294	\N	\N	\N	\N	\N	-24.2518465813172668	138.282867022160758	Jr.-MEET-2017-09-13	f	40	{"ca": "<p>Sint rerum voluptatem et. Placeat rem eos cumque vel velit. Laudantium eos quos et quae fugit sunt sint. Dolorem non eos aut.</p>", "en": "<p>Voluptas unde quisquam laudantium pariatur sit ullam. Dolores repellendus et voluptas a ex voluptatem. Mollitia aliquam sit ipsam. Voluptas tenetur aut. Eius esse molestiae error id labore provident maxime.</p>", "es": "<p>Repellat saepe architecto ipsam rerum quam provident consequatur. Sint sunt quia qui. Nihil quia dicta et ut aut doloribus. Nesciunt maxime ratione sunt aut dolor quibusdam. Aut quibusdam rerum soluta et quod tempore totam.</p>"}
14	{"ca": "Sequi ea consequatur qui ipsam sit sed.", "en": "Enim ea dicta voluptatem.", "es": "Fuga aut qui."}	{"ca": "<p>Perferendis neque consequatur autem suscipit. Impedit sit tempore. Ab nesciunt dolores possimus eveniet.</p>", "en": "<p>Fugiat asperiores earum officia aut dolorem velit. In ea animi quod nisi. Aliquid ea nisi optio. Dicta voluptas blanditiis.</p>", "es": "<p>Aliquam autem in culpa debitis accusamus quo eum. Vitae perferendis laboriosam minima et porro. Error voluptatem corrupti est aut non magnam repellat. Atque magnam id et.</p>"}	2017-10-04 12:48:27.407838	2017-10-04 16:48:27.408015	18820 Lily Rapids 98259-7108 Sabinaton	{"ca": "Voluptas aut laudantium ut.", "en": "Ut culpa non ullam impedit amet pariatur quidem qui.", "es": "Enim velit odio nihil recusandae tenetur."}	{"ca": "Quia alias repudiandae corporis expedita similique autem non incidunt.", "en": "Aliquid perspiciatis quia excepturi quam unde sint quia perferendis.", "es": "Dolore quis et aperiam animi aut ex."}	26	\N	13	2017-09-13 12:48:27.415947	2017-09-13 12:48:27.430153	\N	\N	\N	\N	\N	77.4869523300321532	-99.2148085839430962	Jr.-MEET-2017-09-14	t	40	{"ca": "<p>Alias quo earum accusantium quidem. Aut id qui in laudantium molestias. Ut et inventore voluptates quis quis eligendi quisquam. Voluptatem aut molestiae hic est eveniet ullam earum. Doloremque atque quia molestias tempore tenetur distinctio.</p>", "en": "<p>Quo fuga in non doloremque recusandae voluptatibus. Sint nihil minima. Ea dolores sunt dolorem.</p>", "es": "<p>Molestiae id et magnam deserunt. Quam fuga exercitationem quia ullam repellendus suscipit omnis. Iusto sint unde perspiciatis modi cumque quae. At ut asperiores harum qui nisi aperiam inventore.</p>"}
15	{"ca": "Accusantium aliquid adipisci nostrum.", "en": "Pariatur ab amet quidem earum soluta.", "es": "Ut dolorum odio nihil animi quaerat."}	{"ca": "<p>Consequatur sint a voluptatem. Sunt quo ipsum veritatis. Voluptatem accusantium sunt ipsam atque fugiat.</p>", "en": "<p>Aut ipsum optio hic nihil labore ullam laborum. Ut consequatur architecto. Minus repellendus qui. Hic corrupti consequatur illum est.</p>", "es": "<p>Et praesentium est earum et repudiandae. Quaerat dolores quia ratione sed expedita vel. Facilis nulla amet. Similique eius voluptatem iusto necessitatibus.</p>"}	2017-10-04 12:48:29.730709	2017-10-04 16:48:29.730823	178 Rempel Port 63274 Shannyland	{"ca": "Quia et quod facilis.", "en": "Est inventore aut numquam vel sed autem.", "es": "Neque cumque reprehenderit ab perferendis commodi."}	{"ca": "Ea fuga soluta optio.", "en": "Quia dolores facilis illo doloribus amet aut.", "es": "Numquam et iste ut nobis laboriosam sit veniam accusamus."}	26	\N	13	2017-09-13 12:48:29.73808	2017-09-13 12:48:29.750543	\N	\N	\N	\N	\N	-84.2607454586812139	31.4319206439772358	Jr.-MEET-2017-09-15	t	40	{"ca": "<p>Voluptas ut ad. Autem quo laudantium. Sed laudantium at aut velit.</p>", "en": "<p>Placeat quia dolorem excepturi. Autem et enim voluptatibus dicta et aut nesciunt. Non ab et. Rem reprehenderit sit sit. Recusandae ut necessitatibus ducimus qui eveniet reiciendis.</p>", "es": "<p>Ipsa non et eius nihil nostrum quas. Qui ab quaerat dolor ut veniam. Explicabo nihil quia repellendus sed in facilis.</p>"}
16	{"ca": "A nostrum.", "en": "Architecto qui dolorum voluptas similique accusantium.", "es": "Fuga repellendus earum soluta ipsum unde eligendi."}	{"ca": "<p>Et hic reprehenderit rerum ut. Et sapiente enim. Illum molestiae libero blanditiis atque. Nostrum perspiciatis placeat.</p>", "en": "<p>Nulla qui impedit a accusantium sunt. Dolores molestiae laboriosam cupiditate sed. Eos amet labore velit adipisci. Ratione ipsam aliquam non harum totam. Enim assumenda rerum molestias vitae.</p>", "es": "<p>Perspiciatis officia sunt et. Est sed possimus omnis error animi aut. Hic et soluta voluptate.</p>"}	2017-10-04 12:48:41.298532	2017-10-04 16:48:41.29869	495 Schuppe Dale 74366-4390 Parkerton	{"ca": "Est corrupti ab soluta alias at saepe sint asperiores.", "en": "Ut voluptas minus unde.", "es": "Fugit tempora atque voluptatum aliquid illum."}	{"ca": "Eum nobis tempora non fugit maiores.", "en": "Et quia consectetur dolor repellat.", "es": "Sed odio sapiente qui neque repellat officiis facere."}	32	\N	\N	2017-09-13 12:48:41.305868	2017-09-13 12:48:41.321084	\N	\N	\N	\N	\N	-51.122670108441298	109.765461217787163	Jr.-MEET-2017-09-16	t	50	{"ca": "<p>Omnis autem aut quia corrupti deserunt. Repellendus odit aut nostrum omnis ducimus ratione eum. Dolores inventore veniam similique harum alias.</p>", "en": "<p>Quasi perferendis velit eveniet totam fugiat voluptatem ullam. Autem sapiente est temporibus aliquam id quibusdam. Repellat consequatur quia. Ab explicabo consequatur.</p>", "es": "<p>Nulla eos cumque. Aut sed tempora reiciendis quibusdam non quas autem. Nisi aspernatur velit officiis nesciunt officia hic. Perspiciatis iste dolorum. Laborum voluptates rem.</p>"}
17	{"ca": "Aut magni libero.", "en": "Neque qui delectus enim et.", "es": "Totam doloribus consequatur ut."}	{"ca": "<p>Qui qui dolorem possimus itaque consequatur sit eius. Nam adipisci suscipit. Quia voluptatem voluptatem fuga rerum. Asperiores beatae earum enim eum laudantium.</p>", "en": "<p>Odit minus et. Dignissimos sit fuga. Qui laudantium recusandae similique molestias sapiente et ad. Corrupti natus ullam dolor quasi quo.</p>", "es": "<p>Impedit dolores deserunt. Ut exercitationem voluptatem ea dolorum ad qui et. Commodi velit sed voluptatibus culpa minima. Voluptas et quo modi tempore commodi nihil ab. Molestiae corrupti molestiae quo.</p>"}	2017-10-04 12:48:43.583928	2017-10-04 16:48:43.584043	211 Heaney Turnpike 30735 West Gisselle	{"ca": "Itaque amet quis aut nemo quia modi.", "en": "Beatae distinctio nemo nam illum sint enim voluptas.", "es": "Facilis provident omnis ipsam molestias occaecati tenetur."}	{"ca": "Voluptatibus dolor quis quia rerum.", "en": "Illum repudiandae dolorum autem.", "es": "Esse est mollitia omnis et et eos."}	32	\N	\N	2017-09-13 12:48:43.590924	2017-09-13 12:48:43.601831	\N	\N	\N	\N	\N	-21.7708188427035907	-45.6826630813937129	Jr.-MEET-2017-09-17	t	50	{"ca": "<p>Eaque distinctio omnis vel. Quaerat veritatis ad officiis aut unde dolorum. Consequatur beatae aut est natus facilis nihil dolore.</p>", "en": "<p>Iure qui necessitatibus accusamus nobis quidem. Rerum ipsam voluptas explicabo. Modi soluta molestias et et rerum. Et deleniti consequatur autem.</p>", "es": "<p>Facilis eaque et. Incidunt natus provident eaque. Saepe ut nulla id. Reiciendis suscipit a provident iusto.</p>"}
18	{"ca": "Magnam eaque nisi maiores aut sit.", "en": "Aut asperiores enim.", "es": "Et earum eaque ut et at."}	{"ca": "<p>Id et et eaque minima debitis blanditiis eos. Ad ut est. Laboriosam voluptatum aut ad sunt quis quam. Maiores voluptas sed nesciunt porro. Sapiente ut eveniet assumenda a.</p>", "en": "<p>Et nostrum asperiores. Corrupti dolores est praesentium dolore vel dolorem accusantium. Voluptas magnam ducimus in recusandae sint.</p>", "es": "<p>Dolore aliquid ullam iste est dolores nisi officia. Minima voluptas ut. Laboriosam perspiciatis quasi vel. Sint qui ipsam provident et aut. Qui quia odit et.</p>"}	2017-10-04 12:48:45.861163	2017-10-04 16:48:45.861274	630 Vernie Highway 17006-4826 North Jaydaton	{"ca": "Quis et ea nihil id impedit enim.", "en": "Quis saepe harum esse et ea.", "es": "Quas sequi aliquam eum magni est eius qui aut."}	{"ca": "Pariatur reprehenderit omnis qui enim laudantium culpa.", "en": "Ut magni atque quo aut.", "es": "Provident non quo omnis est doloribus."}	32	\N	\N	2017-09-13 12:48:45.867496	2017-09-13 12:48:45.879315	\N	\N	\N	\N	\N	70.0207025727536347	-113.022268985332715	Jr.-MEET-2017-09-18	t	10	{"ca": "<p>Ullam at eum dicta odit aperiam provident velit. Reiciendis animi ipsa minus. Sunt assumenda vel. A quam in est vel. Et exercitationem consequatur perspiciatis qui aut dignissimos.</p>", "en": "<p>Voluptatibus modi magni explicabo sint. Natus accusantium eius qui est. Magni ea pariatur cupiditate quae ipsum officiis. Consequuntur amet et occaecati harum magni eveniet.</p>", "es": "<p>Sed qui quidem natus. Et est deleniti aliquid. Recusandae iusto eligendi repellendus. Quia eveniet hic.</p>"}
19	{"fr": "La journée préparatoire au débat"}	{"fr": "<p>Le Grand Port Maritime de Dunkerque (GPMD) a pour projet d'étendre de façon un de ses bassins dans le but de pouvoir accueillir un plus grand nombre de navires porte-conteneurs.</p><p>Compte tenu des impacts de ce projet dans le le Dunkerquois et la région Hauts-de-France, notamment en termes d'emplois, d'aménagement du territoire et d'environnement, la Commission nationale du débat public (CNDP) a décidé d'organiser un grand débat ouvert à toute la population, de septembre à décembre 2017.</p><p>Une commission neutre et indépendante est chargée de l'animer.</p><p>Pour identifier ensemble les enjeux entourant ce projet et pour définir les modalités de cette très grande concertation, la commission vous invite à une journée participative.</p><p><strong>ATTENTION</strong></p><p>L'inscription est obligatoire en répondant à cette adresse : <a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\">portdedunkerque@debat-cndp.fr</a></p><p>Merci d'indiquer le nombre de participants, de repas, et de choix de tables rondes pour des questions logistiques</p>"}	2017-09-19 09:00:00	2017-09-19 17:30:00	Escale à Dunkerque	{"fr": "351, Avenue des Bancs de Flandres"}	{"fr": ""}	37	\N	\N	2017-09-13 16:46:05.655684	2017-09-13 16:46:05.694402	\N	\N	\N	\N	\N	\N	\N	cndp-MEET-2017-09-19	f	0	\N
20	{"fr": "Réunion publique d'ouverture "}	{"fr": "<p>Assistez à la réunion publique d'ouverture du débat public sur le projet du Port de Dunkerque. Venez rencontrer le maître d'ouvrage et les membres de la commission particulière chargée d'animer le débat !</p>"}	2017-09-28 18:30:00	2017-09-28 23:00:00	512 Avenue de l'Université, Dunkerque 	{"fr": "Chambre de commerce et d'industrie "}	{"fr": ""}	37	\N	\N	2017-09-14 09:19:28.041997	2017-09-14 09:39:17.204857	\N	\N	\N	\N	\N	\N	\N	cndp-MEET-2017-09-20	f	0	\N
21	{"fr": "Journée préparatoire du débat"}	{"fr": "<p>Une journée préparatoire aura lieu le&nbsp;<strong>Mardi 19 septembre</strong>, nous y déterminerons ensemble les enjeux et les modalités de ce débat !</p><p><strong>Pour vous y préinscrire</strong>, adresser un mail à l'adresse suivante :&nbsp;<a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\">portdedunkerque@debat-cndp.fr</a>&nbsp;(attention, nombre de places limité)</p>"}	2017-09-19 09:00:00	2017-09-19 17:30:00	 Quartier du Grand Large - 351 Avenue des Bancs de Flandres - 59140 Dunkerque	{"fr": "Auberge de jeunesse L'Escale"}	{"fr": ""}	44	\N	\N	2017-09-15 13:50:14.717788	2017-09-15 13:50:14.849403	\N	\N	\N	\N	\N	\N	\N	cndp-MEET-2017-09-21	f	0	\N
\.


--
-- Data for Name: decidim_meetings_registrations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_meetings_registrations (id, decidim_user_id, decidim_meeting_id, created_at, updated_at) FROM stdin;
1	6	1	2017-09-13 12:47:19.0461	2017-09-13 12:47:19.0461
2	7	1	2017-09-13 12:47:19.267193	2017-09-13 12:47:19.267193
3	8	1	2017-09-13 12:47:19.484785	2017-09-13 12:47:19.484785
4	9	1	2017-09-13 12:47:19.703656	2017-09-13 12:47:19.703656
5	10	1	2017-09-13 12:47:19.920045	2017-09-13 12:47:19.920045
6	11	1	2017-09-13 12:47:20.128865	2017-09-13 12:47:20.128865
7	12	1	2017-09-13 12:47:20.349495	2017-09-13 12:47:20.349495
8	13	1	2017-09-13 12:47:20.556834	2017-09-13 12:47:20.556834
9	14	1	2017-09-13 12:47:20.767297	2017-09-13 12:47:20.767297
10	15	1	2017-09-13 12:47:20.981269	2017-09-13 12:47:20.981269
11	16	2	2017-09-13 12:47:21.403497	2017-09-13 12:47:21.403497
12	17	2	2017-09-13 12:47:21.609122	2017-09-13 12:47:21.609122
13	18	2	2017-09-13 12:47:21.817641	2017-09-13 12:47:21.817641
14	19	2	2017-09-13 12:47:22.023547	2017-09-13 12:47:22.023547
15	20	2	2017-09-13 12:47:22.233325	2017-09-13 12:47:22.233325
16	21	2	2017-09-13 12:47:22.443817	2017-09-13 12:47:22.443817
17	22	2	2017-09-13 12:47:22.649218	2017-09-13 12:47:22.649218
18	23	2	2017-09-13 12:47:22.85525	2017-09-13 12:47:22.85525
19	24	2	2017-09-13 12:47:23.061499	2017-09-13 12:47:23.061499
20	25	2	2017-09-13 12:47:23.271879	2017-09-13 12:47:23.271879
21	26	3	2017-09-13 12:47:23.659592	2017-09-13 12:47:23.659592
22	27	3	2017-09-13 12:47:23.875088	2017-09-13 12:47:23.875088
23	28	3	2017-09-13 12:47:24.085766	2017-09-13 12:47:24.085766
24	29	3	2017-09-13 12:47:24.293371	2017-09-13 12:47:24.293371
25	30	3	2017-09-13 12:47:24.500672	2017-09-13 12:47:24.500672
26	31	3	2017-09-13 12:47:24.711685	2017-09-13 12:47:24.711685
27	32	3	2017-09-13 12:47:24.922898	2017-09-13 12:47:24.922898
28	33	3	2017-09-13 12:47:25.131943	2017-09-13 12:47:25.131943
29	34	3	2017-09-13 12:47:25.351702	2017-09-13 12:47:25.351702
30	35	3	2017-09-13 12:47:25.563691	2017-09-13 12:47:25.563691
31	62	4	2017-09-13 12:47:35.189515	2017-09-13 12:47:35.189515
32	63	4	2017-09-13 12:47:35.396894	2017-09-13 12:47:35.396894
33	64	4	2017-09-13 12:47:35.614009	2017-09-13 12:47:35.614009
34	65	4	2017-09-13 12:47:35.832411	2017-09-13 12:47:35.832411
35	66	4	2017-09-13 12:47:36.050777	2017-09-13 12:47:36.050777
36	67	4	2017-09-13 12:47:36.264534	2017-09-13 12:47:36.264534
37	68	4	2017-09-13 12:47:36.478239	2017-09-13 12:47:36.478239
38	69	4	2017-09-13 12:47:36.687044	2017-09-13 12:47:36.687044
39	70	4	2017-09-13 12:47:36.952051	2017-09-13 12:47:36.952051
40	71	4	2017-09-13 12:47:37.178415	2017-09-13 12:47:37.178415
41	72	5	2017-09-13 12:47:37.577417	2017-09-13 12:47:37.577417
42	73	5	2017-09-13 12:47:37.806852	2017-09-13 12:47:37.806852
43	74	5	2017-09-13 12:47:38.030906	2017-09-13 12:47:38.030906
44	75	5	2017-09-13 12:47:38.24825	2017-09-13 12:47:38.24825
45	76	5	2017-09-13 12:47:38.458387	2017-09-13 12:47:38.458387
46	77	5	2017-09-13 12:47:38.670455	2017-09-13 12:47:38.670455
47	78	5	2017-09-13 12:47:38.907262	2017-09-13 12:47:38.907262
48	79	5	2017-09-13 12:47:39.146709	2017-09-13 12:47:39.146709
49	80	5	2017-09-13 12:47:39.370982	2017-09-13 12:47:39.370982
50	81	5	2017-09-13 12:47:39.581307	2017-09-13 12:47:39.581307
51	82	6	2017-09-13 12:47:39.971933	2017-09-13 12:47:39.971933
52	83	6	2017-09-13 12:47:40.199813	2017-09-13 12:47:40.199813
53	84	6	2017-09-13 12:47:40.419676	2017-09-13 12:47:40.419676
54	85	6	2017-09-13 12:47:40.635383	2017-09-13 12:47:40.635383
55	86	6	2017-09-13 12:47:40.850183	2017-09-13 12:47:40.850183
56	87	6	2017-09-13 12:47:41.100458	2017-09-13 12:47:41.100458
57	88	6	2017-09-13 12:47:41.348287	2017-09-13 12:47:41.348287
58	89	6	2017-09-13 12:47:41.590372	2017-09-13 12:47:41.590372
59	90	6	2017-09-13 12:47:41.802782	2017-09-13 12:47:41.802782
60	91	6	2017-09-13 12:47:42.015754	2017-09-13 12:47:42.015754
61	120	7	2017-09-13 12:47:51.820302	2017-09-13 12:47:51.820302
62	121	7	2017-09-13 12:47:52.026412	2017-09-13 12:47:52.026412
63	122	7	2017-09-13 12:47:52.241193	2017-09-13 12:47:52.241193
64	123	7	2017-09-13 12:47:52.454315	2017-09-13 12:47:52.454315
65	124	7	2017-09-13 12:47:52.670974	2017-09-13 12:47:52.670974
66	125	7	2017-09-13 12:47:52.876666	2017-09-13 12:47:52.876666
67	126	7	2017-09-13 12:47:53.082548	2017-09-13 12:47:53.082548
68	127	7	2017-09-13 12:47:53.308295	2017-09-13 12:47:53.308295
69	128	7	2017-09-13 12:47:53.516056	2017-09-13 12:47:53.516056
70	129	7	2017-09-13 12:47:53.726945	2017-09-13 12:47:53.726945
71	130	8	2017-09-13 12:47:54.115779	2017-09-13 12:47:54.115779
72	131	8	2017-09-13 12:47:54.32233	2017-09-13 12:47:54.32233
73	132	8	2017-09-13 12:47:54.532193	2017-09-13 12:47:54.532193
74	133	8	2017-09-13 12:47:54.787515	2017-09-13 12:47:54.787515
75	134	8	2017-09-13 12:47:55.000222	2017-09-13 12:47:55.000222
76	135	8	2017-09-13 12:47:55.217618	2017-09-13 12:47:55.217618
77	136	8	2017-09-13 12:47:55.427929	2017-09-13 12:47:55.427929
78	137	8	2017-09-13 12:47:55.649992	2017-09-13 12:47:55.649992
79	138	8	2017-09-13 12:47:55.861968	2017-09-13 12:47:55.861968
80	139	8	2017-09-13 12:47:56.077722	2017-09-13 12:47:56.077722
81	140	9	2017-09-13 12:47:56.455523	2017-09-13 12:47:56.455523
82	141	9	2017-09-13 12:47:56.672589	2017-09-13 12:47:56.672589
83	142	9	2017-09-13 12:47:56.892054	2017-09-13 12:47:56.892054
84	143	9	2017-09-13 12:47:57.10367	2017-09-13 12:47:57.10367
85	144	9	2017-09-13 12:47:57.312758	2017-09-13 12:47:57.312758
86	145	9	2017-09-13 12:47:57.524395	2017-09-13 12:47:57.524395
87	146	9	2017-09-13 12:47:57.752917	2017-09-13 12:47:57.752917
88	147	9	2017-09-13 12:47:58.016556	2017-09-13 12:47:58.016556
89	148	9	2017-09-13 12:47:58.25282	2017-09-13 12:47:58.25282
90	149	9	2017-09-13 12:47:58.484027	2017-09-13 12:47:58.484027
91	175	10	2017-09-13 12:48:10.122051	2017-09-13 12:48:10.122051
92	176	10	2017-09-13 12:48:10.370943	2017-09-13 12:48:10.370943
93	177	10	2017-09-13 12:48:10.584253	2017-09-13 12:48:10.584253
94	178	10	2017-09-13 12:48:10.835612	2017-09-13 12:48:10.835612
95	179	10	2017-09-13 12:48:11.075402	2017-09-13 12:48:11.075402
96	180	10	2017-09-13 12:48:11.312424	2017-09-13 12:48:11.312424
97	181	10	2017-09-13 12:48:11.542258	2017-09-13 12:48:11.542258
98	182	10	2017-09-13 12:48:11.771482	2017-09-13 12:48:11.771482
99	183	10	2017-09-13 12:48:12.002556	2017-09-13 12:48:12.002556
100	184	10	2017-09-13 12:48:12.246286	2017-09-13 12:48:12.246286
101	185	11	2017-09-13 12:48:12.707594	2017-09-13 12:48:12.707594
102	186	11	2017-09-13 12:48:12.940306	2017-09-13 12:48:12.940306
103	187	11	2017-09-13 12:48:13.180636	2017-09-13 12:48:13.180636
104	188	11	2017-09-13 12:48:13.404894	2017-09-13 12:48:13.404894
105	189	11	2017-09-13 12:48:13.623136	2017-09-13 12:48:13.623136
106	190	11	2017-09-13 12:48:13.831101	2017-09-13 12:48:13.831101
107	191	11	2017-09-13 12:48:14.079333	2017-09-13 12:48:14.079333
108	192	11	2017-09-13 12:48:14.286304	2017-09-13 12:48:14.286304
109	193	11	2017-09-13 12:48:14.492606	2017-09-13 12:48:14.492606
110	194	11	2017-09-13 12:48:14.7026	2017-09-13 12:48:14.7026
111	195	12	2017-09-13 12:48:15.073015	2017-09-13 12:48:15.073015
112	196	12	2017-09-13 12:48:15.290593	2017-09-13 12:48:15.290593
113	197	12	2017-09-13 12:48:15.496534	2017-09-13 12:48:15.496534
114	198	12	2017-09-13 12:48:15.703142	2017-09-13 12:48:15.703142
115	199	12	2017-09-13 12:48:15.90997	2017-09-13 12:48:15.90997
116	200	12	2017-09-13 12:48:16.118679	2017-09-13 12:48:16.118679
117	201	12	2017-09-13 12:48:16.332605	2017-09-13 12:48:16.332605
118	202	12	2017-09-13 12:48:16.558683	2017-09-13 12:48:16.558683
119	203	12	2017-09-13 12:48:16.764773	2017-09-13 12:48:16.764773
120	204	12	2017-09-13 12:48:16.971335	2017-09-13 12:48:16.971335
121	226	13	2017-09-13 12:48:25.267107	2017-09-13 12:48:25.267107
122	227	13	2017-09-13 12:48:25.494096	2017-09-13 12:48:25.494096
123	228	13	2017-09-13 12:48:25.704215	2017-09-13 12:48:25.704215
124	229	13	2017-09-13 12:48:25.92003	2017-09-13 12:48:25.92003
125	230	13	2017-09-13 12:48:26.160939	2017-09-13 12:48:26.160939
126	231	13	2017-09-13 12:48:26.402217	2017-09-13 12:48:26.402217
127	232	13	2017-09-13 12:48:26.627912	2017-09-13 12:48:26.627912
128	233	13	2017-09-13 12:48:26.842048	2017-09-13 12:48:26.842048
129	234	13	2017-09-13 12:48:27.050688	2017-09-13 12:48:27.050688
130	235	13	2017-09-13 12:48:27.261353	2017-09-13 12:48:27.261353
131	236	14	2017-09-13 12:48:27.648379	2017-09-13 12:48:27.648379
132	237	14	2017-09-13 12:48:27.863209	2017-09-13 12:48:27.863209
133	238	14	2017-09-13 12:48:28.079385	2017-09-13 12:48:28.079385
134	239	14	2017-09-13 12:48:28.287961	2017-09-13 12:48:28.287961
135	240	14	2017-09-13 12:48:28.498933	2017-09-13 12:48:28.498933
136	241	14	2017-09-13 12:48:28.713841	2017-09-13 12:48:28.713841
137	242	14	2017-09-13 12:48:28.92698	2017-09-13 12:48:28.92698
138	243	14	2017-09-13 12:48:29.139094	2017-09-13 12:48:29.139094
139	244	14	2017-09-13 12:48:29.366587	2017-09-13 12:48:29.366587
140	245	14	2017-09-13 12:48:29.592651	2017-09-13 12:48:29.592651
141	246	15	2017-09-13 12:48:29.965179	2017-09-13 12:48:29.965179
142	247	15	2017-09-13 12:48:30.177951	2017-09-13 12:48:30.177951
143	248	15	2017-09-13 12:48:30.388289	2017-09-13 12:48:30.388289
144	249	15	2017-09-13 12:48:30.596974	2017-09-13 12:48:30.596974
145	250	15	2017-09-13 12:48:30.811601	2017-09-13 12:48:30.811601
146	251	15	2017-09-13 12:48:31.026669	2017-09-13 12:48:31.026669
147	252	15	2017-09-13 12:48:31.245765	2017-09-13 12:48:31.245765
148	253	15	2017-09-13 12:48:31.476939	2017-09-13 12:48:31.476939
149	254	15	2017-09-13 12:48:31.687543	2017-09-13 12:48:31.687543
150	255	15	2017-09-13 12:48:31.896757	2017-09-13 12:48:31.896757
151	279	16	2017-09-13 12:48:41.539589	2017-09-13 12:48:41.539589
152	280	16	2017-09-13 12:48:41.753148	2017-09-13 12:48:41.753148
153	281	16	2017-09-13 12:48:41.964178	2017-09-13 12:48:41.964178
154	282	16	2017-09-13 12:48:42.1707	2017-09-13 12:48:42.1707
155	283	16	2017-09-13 12:48:42.38701	2017-09-13 12:48:42.38701
156	284	16	2017-09-13 12:48:42.594417	2017-09-13 12:48:42.594417
157	285	16	2017-09-13 12:48:42.80824	2017-09-13 12:48:42.80824
158	286	16	2017-09-13 12:48:43.025376	2017-09-13 12:48:43.025376
159	287	16	2017-09-13 12:48:43.238206	2017-09-13 12:48:43.238206
160	288	16	2017-09-13 12:48:43.456186	2017-09-13 12:48:43.456186
161	289	17	2017-09-13 12:48:43.810589	2017-09-13 12:48:43.810589
162	290	17	2017-09-13 12:48:44.024933	2017-09-13 12:48:44.024933
163	291	17	2017-09-13 12:48:44.235232	2017-09-13 12:48:44.235232
164	292	17	2017-09-13 12:48:44.446083	2017-09-13 12:48:44.446083
165	293	17	2017-09-13 12:48:44.656237	2017-09-13 12:48:44.656237
166	294	17	2017-09-13 12:48:44.877689	2017-09-13 12:48:44.877689
167	295	17	2017-09-13 12:48:45.087222	2017-09-13 12:48:45.087222
168	296	17	2017-09-13 12:48:45.303069	2017-09-13 12:48:45.303069
169	297	17	2017-09-13 12:48:45.518834	2017-09-13 12:48:45.518834
170	298	17	2017-09-13 12:48:45.735927	2017-09-13 12:48:45.735927
171	299	18	2017-09-13 12:48:46.090986	2017-09-13 12:48:46.090986
172	300	18	2017-09-13 12:48:46.301444	2017-09-13 12:48:46.301444
173	301	18	2017-09-13 12:48:46.526987	2017-09-13 12:48:46.526987
174	302	18	2017-09-13 12:48:46.745644	2017-09-13 12:48:46.745644
175	303	18	2017-09-13 12:48:46.954522	2017-09-13 12:48:46.954522
176	304	18	2017-09-13 12:48:47.163354	2017-09-13 12:48:47.163354
177	305	18	2017-09-13 12:48:47.397174	2017-09-13 12:48:47.397174
178	306	18	2017-09-13 12:48:47.608088	2017-09-13 12:48:47.608088
179	307	18	2017-09-13 12:48:47.819667	2017-09-13 12:48:47.819667
180	308	18	2017-09-13 12:48:48.035625	2017-09-13 12:48:48.035625
\.


--
-- Data for Name: decidim_messaging_conversations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_messaging_conversations (id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_messaging_messages; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_messaging_messages (id, decidim_conversation_id, decidim_sender_id, body, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_messaging_participations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_messaging_participations (id, decidim_conversation_id, decidim_participant_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_messaging_receipts; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_messaging_receipts (id, decidim_message_id, decidim_recipient_id, read_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: decidim_moderations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_moderations (id, decidim_participatory_space_id, decidim_reportable_type, decidim_reportable_id, report_count, hidden_at, created_at, updated_at, decidim_participatory_space_type, upstream_moderation) FROM stdin;
1	5	Decidim::Proposals::Proposal	131	1	2017-09-21 14:11:24.568734	2017-09-21 14:10:44.502482	2018-02-21 22:16:13.888702	Decidim::ParticipatoryProcess	authorized
2	6	Decidim::Proposals::Proposal	135	1	2017-09-22 09:17:40.362393	2017-09-22 09:17:07.984098	2018-02-21 22:16:13.893195	Decidim::ParticipatoryProcess	authorized
3	7	Decidim::Proposals::Proposal	166	1	\N	2017-10-14 10:42:01.094785	2018-02-21 22:16:13.896557	Decidim::ParticipatoryProcess	authorized
4	6	Decidim::Proposals::Proposal	187	1	2017-10-17 09:13:20.877945	2017-10-17 09:12:54.804954	2018-02-21 22:16:13.900206	Decidim::ParticipatoryProcess	authorized
5	6	Decidim::Proposals::Proposal	137	1	2017-10-17 10:03:59.560336	2017-10-17 10:02:07.918652	2018-02-21 22:16:13.903679	Decidim::ParticipatoryProcess	authorized
6	6	Decidim::Proposals::Proposal	139	1	2017-10-17 10:10:45.550835	2017-10-17 10:03:22.005551	2018-02-21 22:16:13.907102	Decidim::ParticipatoryProcess	authorized
7	6	Decidim::Proposals::Proposal	182	1	2017-10-18 10:23:58.948756	2017-10-18 08:27:18.306484	2018-02-21 22:16:13.910386	Decidim::ParticipatoryProcess	authorized
8	6	Decidim::Proposals::Proposal	210	1	2017-10-27 08:15:46.79034	2017-10-27 08:15:18.211096	2018-02-21 22:16:13.913806	Decidim::ParticipatoryProcess	authorized
9	6	Decidim::Proposals::Proposal	326	1	2017-11-24 10:07:40.559568	2017-11-24 10:07:13.779231	2018-02-21 22:16:13.916829	Decidim::ParticipatoryProcess	authorized
11	6	Decidim::Proposals::Proposal	309	1	2017-12-13 10:59:24.972199	2017-12-13 10:57:21.980137	2018-02-21 22:16:13.920273	Decidim::ParticipatoryProcess	authorized
12	6	Decidim::Proposals::Proposal	364	1	2017-12-15 11:42:39.50572	2017-12-15 11:13:43.834402	2018-02-21 22:16:13.932419	Decidim::ParticipatoryProcess	authorized
\.


--
-- Data for Name: decidim_navbar_links; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_navbar_links (id, decidim_organization_id, title, link, target, weight) FROM stdin;
\.


--
-- Data for Name: decidim_newsletters; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_newsletters (id, subject, body, organization_id, author_id, total_recipients, total_deliveries, sent_at, created_at, updated_at) FROM stdin;
1	{"fr": "Newsletter 1"}	{"fr": "<p>%{name}, </p><p><br></p><p>Test.</p>"}	2	331	2	2	2017-09-13 17:31:04.496828	2017-09-13 17:30:37.992663	2017-09-13 17:31:04.507373
\.


--
-- Data for Name: decidim_notifications; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_notifications (id, decidim_user_id, decidim_resource_type, decidim_resource_id, event_name, event_class, created_at, updated_at, extra) FROM stdin;
1	358	Decidim::Proposals::Proposal	151	decidim.events.comments.comment_created	Decidim::Comments::CommentCreatedEvent	2017-10-12 08:13:18.058543	2017-10-12 08:13:18.058543	{"comment_id": 491}
2	397	Decidim::Proposals::Proposal	230	decidim.events.comments.comment_created	Decidim::Comments::CommentCreatedEvent	2017-11-25 13:32:42.88471	2017-11-25 13:32:42.88471	{"comment_id": 505}
3	414	Decidim::Proposals::Proposal	256	decidim.events.comments.comment_created	Decidim::Comments::CommentCreatedEvent	2017-11-26 13:31:02.106284	2017-11-26 13:31:02.106284	{"comment_id": 512}
4	397	Decidim::Proposals::Proposal	230	decidim.events.comments.comment_created	Decidim::Comments::CommentCreatedEvent	2017-11-26 22:20:08.581275	2017-11-26 22:20:08.581275	{"comment_id": 514}
\.


--
-- Data for Name: decidim_organizations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_organizations (id, name, host, default_locale, available_locales, welcome_text, homepage_image, created_at, updated_at, description, logo, twitter_handler, show_statistics, favicon, instagram_handler, facebook_handler, youtube_handler, github_handler, official_img_header, official_img_footer, official_url, reference_prefix, secondary_hosts, available_authorizations, header_snippets, cta_button_text, cta_button_path) FROM stdin;
1	Skiles-Schiller	localhost	en	{en,ca,es}	{"ca": "Est iste quis accusamus totam facere ut quo inventore odio.", "en": "Quis quo exercitationem accusamus minus est natus et nihil.", "es": "Quae aut suscipit qui repudiandae ex eos illo."}	homepage_image.jpg	2017-09-13 12:47:14.497121	2018-02-01 21:07:41.519913	{"ca": "<p>Reprehenderit vel modi omnis dolor necessitatibus ut velit quia aut mollitia repellat dicta amet et est.</p>", "en": "<p>Nisi maiores ut non odio ut est et dolore quam dolorum vel harum impedit esse natus perspiciatis.</p>", "es": "<p>Assumenda eveniet rerum sit aperiam placeat molestias laudantium quod similique voluptatem eum veniam voluptatum at vel illo harum.</p>"}	\N	vice	t	\N	plaid	freegan	YOLO	mixtape	\N	\N	\N	Jr.	{}	{dummy_authorization_handler}	\N	\N	\N
3	Test CNDP	cndp.test.opensourcepolitics.eu	fr	{fr}	{"fr": ""}	\N	2017-09-22 12:06:42.938694	2018-02-01 21:07:41.526591	{"fr": ""}	\N		t	\N					\N	\N		cndp	{}	{dummy_authorization_handler}	<style type="text/css" media="screen">\r\n  .title-bar {\r\n      background: #FFF;\r\n  }\r\n  .logo-wrapper  span {\r\n    color: #000 !important;\r\n  }\r\n  .logo-wrapper  {\r\n    border-left: \r\n      border-left-width: 4px;\r\n      border-left-style: solid;\r\n      border-left-color: #000;\r\n  }\r\n  .topbar__menu button {\r\n      color: #000;\r\n  }\r\n  .topbar__user__login a {\r\n  color: #000;\r\n  }\r\n  .topbar__dropmenu .dropdown>li>a {\r\n  color:#000;\r\n  }\r\n  .topbar__dropmenu>ul>li>a:after {\r\n  border-top-color: #000 !important;\r\n  }\r\n  .process-header__main:after {\r\n      background-color: transparent;\r\n  }\r\n  .wrapper {\r\n      padding-top: 1rem;\r\n  }\r\nnav.main-nav li:nth-child(3) {\r\ndisplay: none;\r\n}\r\nspan.title-action__action button small hollow disabled {\r\ndisplay: none;\r\n}\r\n.definition-data {\r\ndisplay: none;}\r\n</style>	\N	\N
2	CNDP	participons.debatpublic.fr	fr	{fr}	{"fr": "Bienvenue sur la plateforme participative de la CNDP"}	Barcamp-02.jpg	2017-09-13 13:06:02.317743	2018-02-07 11:50:57.032463	{"fr": "<p>Participez à des rencontres, débattez et échangez sur les projets, plans et programmes qui font l'objet d'un débat public organisé par la Commission nationale du débat public (CNDP).</p>"}	medium_logocndpbulles-rvb-20cm.jpg	CNDPDebatPublic	t	\N		debatpublic			\N	LogoCNDPbulles-Blanc.png	https://www.debatpublic.fr/	cndp	{cndp.opensourcepolitics.eu}	{}	<!-- Global Site Tag (gtag.js) - Google Analytics -->\r\n<script async src="https://www.googletagmanager.com/gtag/js?id=UA-50988870-18"></script>\r\n<script>\r\n  window.dataLayer = window.dataLayer || [];\r\n  function gtag(){dataLayer.push(arguments)};\r\n  gtag('js', new Date());\r\n\r\n  gtag('config', 'UA-50988870-18');\r\n</script>\r\n<!-- Piwik -->\r\n<script type="text/javascript">\r\n  var _paq = _paq || [];\r\n  /* tracker methods like "setCustomDimension" should be called before "trackPageView" */\r\n  _paq.push(['trackPageView']);\r\n  _paq.push(['enableLinkTracking']);\r\n  (function() {\r\n    var u="//piwik.osp.cat/";\r\n    _paq.push(['setTrackerUrl', u+'piwik.php']);\r\n    _paq.push(['setSiteId', '2']);\r\n    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];\r\n    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);\r\n  })();\r\n</script>\r\n<!-- End Piwik Code -->\r\n<style type="text/css" media="screen">\r\n.title-bar {\r\n    background: #FFF;\r\n}\r\n.logo-wrapper  span {\r\n    color: #000 !important;\r\n  }\r\n.topbar__menu button {\r\n    color: #000;\r\n}\r\n.topbar__user__login a {\r\ncolor: #000;\r\n}\r\n.topbar__dropmenu .dropdown>li>a {\r\ncolor:#000;\r\n}\r\n.topbar__dropmenu>ul>li>a:after {\r\nborder-top-color: #000 !important;\r\n}\r\n.process-header__main:after {\r\n    background-color: transparent;\r\n}\r\n.wrapper {\r\n    padding-top: 1rem;\r\n}\r\n.topbar__notifications .icon {\r\nfill: #000;\r\n}\r\n/* Cacher formulaire Auteurs */\r\nform.new_filter div.filters__section:nth-child(3) {\r\n\tdisplay:none;\r\n}\r\n/* couleur du texte du hashtag dans le bandeau du processus */\r\n.process-header__hashtag a {\r\n\tcolor:#FFF;\r\n}\r\n</style>	{"fr": ""}	
\.


--
-- Data for Name: decidim_pages_pages; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_pages_pages (id, body, decidim_feature_id, created_at, updated_at) FROM stdin;
1	{"ca": "<p>Sequi labore dolores veritatis harum iure dolores. Molestiae neque blanditiis est harum. Cum dolores at numquam assumenda autem. Iste deleniti provident aut quia ut.</p>", "en": "<p>Modi facere dicta sunt animi expedita consectetur est. Placeat ratione odit in consectetur. Dolorem sed non.</p>", "es": "<p>Voluptas quos earum nesciunt atque. Similique alias soluta. Quis voluptas neque facilis aut nobis quisquam.</p>"}	1	2017-09-13 12:47:18.329008	2017-09-13 12:47:18.329008
2	{"ca": "<p>Magni consequatur quae aperiam architecto perspiciatis ut nobis. Qui et et. Voluptatem nihil vero vel eaque officiis sed.</p>", "en": "<p>Nisi et debitis eos dolor vel. Libero sequi est quisquam omnis animi. Unde quisquam id quidem nihil dolor. Cum non sed et velit in.</p>", "es": "<p>Sint commodi et omnis dolorem id amet. Excepturi reiciendis id laudantium. Vitae et aut.</p>"}	7	2017-09-13 12:47:34.895743	2017-09-13 12:47:34.895743
3	{"ca": "<p>Illum et consequatur. Sit magni nisi deleniti et. Consequuntur id et maxime est voluptatibus. Laborum ut quo.</p>", "en": "<p>Et molestiae dolores et vitae unde at aut. Rerum consequuntur omnis omnis nisi ducimus. Quisquam facere et minus temporibus non voluptas qui. Necessitatibus voluptate voluptas provident. Temporibus reprehenderit a maiores laudantium vel.</p>", "es": "<p>Est sit aut veniam enim. Nisi est eaque omnis. Laborum quis saepe atque quidem et.</p>"}	13	2017-09-13 12:47:51.557462	2017-09-13 12:47:51.557462
4	{"ca": "<p>Sunt perspiciatis omnis. Fugit aut eaque maiores. Iure et quod molestiae sit minima.</p>", "en": "<p>Rem nostrum inventore. Ut nulla excepturi est distinctio. Excepturi in voluptas ullam eligendi.</p>", "es": "<p>Autem dolores id quo quibusdam earum atque. Assumenda iste eos. Consectetur tempora natus fuga dicta corrupti. Qui voluptatem non molestiae eveniet deleniti. Temporibus nihil corporis voluptate illum ut.</p>"}	19	2017-09-13 12:48:09.698736	2017-09-13 12:48:09.698736
5	{"ca": "<p>Ut recusandae id sunt eos. Aut autem beatae nemo veritatis. Excepturi cum distinctio. Tempora ut voluptatem vitae rem fuga nesciunt.</p>", "en": "<p>Ut eum magnam aliquam. Eligendi velit voluptatem veritatis dolorem in. Fuga maiores autem fugit qui. Consequuntur sit et ut hic quibusdam commodi architecto. Cumque iure possimus sed voluptatem mollitia ullam.</p>", "es": "<p>Tenetur iure quidem earum error cumque dolorem cum. Et tempore ullam reprehenderit consequatur natus aut. Recusandae quibusdam odio ad est animi rem.</p>"}	25	2017-09-13 12:48:24.945724	2017-09-13 12:48:24.945724
6	{"ca": "<p>Est molestiae officiis dolores similique quo sit. Unde ex consectetur qui voluptatibus nulla. Nisi occaecati vero ut. Molestiae a iusto ipsam sunt. Alias rerum non expedita adipisci voluptatibus eos facilis.</p>", "en": "<p>Vel voluptas amet nisi eveniet. Illum aut repellendus et facere non. Aperiam itaque officiis nihil facilis earum.</p>", "es": "<p>Non sit facere debitis. Et totam quia sit quibusdam iste ut culpa. Velit laborum nulla voluptatem repellendus quaerat asperiores. Possimus pariatur dolorem explicabo qui voluptas repudiandae asperiores.</p>"}	31	2017-09-13 12:48:41.176128	2017-09-13 12:48:41.176128
7	\N	57	2017-10-16 15:11:28.975956	2017-10-16 15:11:28.975956
8	{"fr": "<p>Contenu de la page de test. Du texte...</p><p>Et une vidéo ? Arg, ça ne marche pas avec Dailymotion ! Youtube oui :</p><p><br></p><iframe class=\\"ql-video\\" allowfullscreen=\\"true\\" src=\\"https://www.youtube.com/embed/vNeU0--e4k4?showinfo=0\\" frameborder=\\"0\\"></iframe><p><br></p>"}	58	2017-11-14 11:54:54.529799	2017-11-14 12:00:16.244492
\.


--
-- Data for Name: decidim_participatory_process_groups; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_participatory_process_groups (id, name, description, hero_image, decidim_organization_id, created_at, updated_at) FROM stdin;
1	{"ca": "Ab quae laborum unde.", "en": "Tempora occaecati recusandae perspiciatis beatae rerum architecto unde.", "es": "Soluta eligendi et."}	{"ca": "<p>Qui deleniti nobis. Unde est cupiditate expedita explicabo ut. Voluptates aspernatur aut quos voluptatum qui. Ipsam vitae et totam tempore consequatur tempora. Modi maxime aspernatur harum nihil deserunt sed.</p>", "en": "<p>Temporibus veritatis quis odio. Quasi temporibus nihil perferendis esse impedit. Provident ullam cupiditate mollitia ducimus id.</p>", "es": "<p>Laudantium esse optio harum quas qui. Ab accusamus rerum et ullam neque voluptate. Omnis odit aperiam.</p>"}	city.jpeg	1	2017-09-13 12:47:16.262043	2017-09-13 12:47:16.262043
2	{"ca": "Excepturi et est iste quo nobis.", "en": "Sunt ut et minus voluptate nobis.", "es": "Sit sed libero sit."}	{"ca": "<p>Est omnis beatae quis accusantium et totam suscipit. Qui ea possimus occaecati consequuntur qui ipsam aspernatur. Qui sit rem blanditiis consequatur officiis.</p>", "en": "<p>Ex animi vero a adipisci fugit dolorum eum. Non nisi fuga pariatur dolor mollitia quisquam aperiam. Ratione velit sapiente eum qui. Laborum libero ut maiores vitae.</p>", "es": "<p>Placeat rerum possimus rem quo mollitia. Nobis blanditiis quos modi in. Qui nihil distinctio sed. Distinctio blanditiis dolorem voluptas libero ea molestias ut.</p>"}	city.jpeg	1	2017-09-13 12:47:16.354649	2017-09-13 12:47:16.354649
3	{"ca": "Pariatur voluptates et.", "en": "Facilis aperiam facere laborum.", "es": "Qui itaque quidem."}	{"ca": "<p>Libero non et voluptas adipisci delectus rerum dolor. Iure quisquam deserunt molestiae. Asperiores est ut neque.</p>", "en": "<p>Quia est ipsum itaque quia accusamus. Dolorum dignissimos qui animi in rerum. Unde quia velit. Consequatur optio voluptatem illo in dolor officia.</p>", "es": "<p>Nisi qui minus molestiae qui nesciunt tenetur et. Commodi hic id mollitia voluptates laborum perspiciatis. Quibusdam pariatur voluptates quia eius qui explicabo nihil. Quo ab libero.</p>"}	city.jpeg	1	2017-09-13 12:47:16.436267	2017-09-13 12:47:16.436267
\.


--
-- Data for Name: decidim_participatory_process_steps; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_participatory_process_steps (id, title, description, start_date, end_date, decidim_participatory_process_id, created_at, updated_at, active, "position") FROM stdin;
1	{"ca": "Placeat.", "en": "Quia sunt.", "es": "Sed."}	{"ca": "<p>Distinctio dignissimos non eum quia placeat omnis tempore. Provident rerum doloribus qui. Aspernatur vel dicta atque et nihil molestias. Ipsa in fuga.</p>", "en": "<p>Voluptas corrupti quo incidunt laboriosam dolores fuga vel. Et iusto officiis illum et ab. Asperiores non doloremque. Sit quia qui voluptate eligendi cupiditate. Facilis dolorem omnis.</p>", "es": "<p>Libero facilis quia. Possimus ut corrupti suscipit consequatur quo. Dolorem aliquam neque quia blanditiis libero dignissimos est. Illo voluptatem corrupti error dolorem. Et qui fugiat ipsam ut qui culpa.</p>"}	2017-08-13	2017-11-13	1	2017-09-13 12:47:17.220213	2017-09-13 12:47:17.220213	t	0
2	{"ca": "Debitis.", "en": "Ea.", "es": "Ipsam sed."}	{"ca": "<p>Soluta corrupti consectetur id odit nam. Unde architecto corrupti iusto est itaque aperiam aut. Repellat maiores excepturi.</p>", "en": "<p>Quia aut qui. Eius tenetur incidunt. Atque beatae quia molestias. Velit consectetur nisi corrupti incidunt. Tempore voluptates officia quo et quaerat ad et.</p>", "es": "<p>Velit perferendis delectus at voluptatum eos neque. Nam omnis enim. Dolore et qui sequi deleniti dolorum. Impedit vel beatae cupiditate ut exercitationem. Sapiente nobis qui nemo et.</p>"}	2017-08-13	2017-11-13	2	2017-09-13 12:47:33.994602	2017-09-13 12:47:33.994602	t	0
3	{"ca": "Nesciunt vel.", "en": "Officiis accusamus.", "es": "Omnis."}	{"ca": "<p>Qui quisquam ea velit reiciendis corrupti. Voluptatibus dolores aperiam sunt pariatur rerum. Et incidunt corporis est quia cupiditate rem totam. Ea vero mollitia. Pariatur itaque qui perferendis dicta voluptates numquam quasi.</p>", "en": "<p>Expedita nobis voluptatem impedit. Ex aspernatur sed eum. Libero maiores ut possimus. Aut labore deserunt. Aliquam deleniti mollitia excepturi suscipit nihil.</p>", "es": "<p>Placeat non voluptas id quibusdam voluptas. Porro est sint qui aut maxime explicabo accusamus. Sapiente et enim et nihil.</p>"}	2017-08-13	2017-11-13	3	2017-09-13 12:47:50.757021	2017-09-13 12:47:50.757021	t	0
4	{"fr": "Préparation du débat"}	{"fr": "<ul><li>Identification des enjeux</li><li>Préparation des documents avec la maîtrise d'ouvrage</li><li>Planification des rencontres</li></ul><p><br></p>"}	2017-06-01	2017-09-17	4	2017-09-13 15:08:43.519813	2017-09-13 15:11:24.260987	f	0
5	{"fr": "Débat public"}	{"fr": "<p>Récolte des avis des différentes parties prenantes sous 4 modalités</p><ul><li>Questions - Réponses</li><li>Avis</li><li>Forum ouvert</li><li>Cahiers d'acteurs</li></ul>"}	2017-09-18	2017-12-22	4	2017-09-13 15:12:01.861891	2017-09-15 08:52:31.046158	t	1
6	{"fr": "Synthèse et archivage"}	{"fr": "<ul><li>Fin de la période de contribution</li><li>Synthèse des contributions faites par les différents acteurs ayant pris part au débat.</li></ul>"}	2017-12-22	2018-01-31	4	2017-09-13 15:12:41.929869	2017-09-15 08:52:46.913601	f	2
9	{"fr": "Synthèse et archivage"}	{"fr": "<ul><li>Fin de la période de contribution</li><li>Synthèse des contributions faites par les différents acteurs ayant pris part au débat.</li></ul>"}	2017-12-22	2018-01-31	5	2017-09-15 12:31:23.543053	2017-09-15 12:31:23.543053	f	2
7	{"fr": "Préparation du débat"}	{"fr": "<ul><li>Identification des enjeux</li><li>Préparation des documents avec la maîtrise d'ouvrage</li><li>Planification des rencontres</li></ul><p><br></p>"}	2017-06-01	2017-09-17	5	2017-09-15 12:31:23.53468	2017-09-15 15:14:35.18879	f	0
8	{"fr": "Débat public"}	{"fr": "<p>Récolte des avis des différentes parties prenantes sous 4 modalités</p><ul><li>Questions - Réponses</li><li>Avis</li><li>Forum ouvert</li><li>Cahiers d'acteurs</li></ul>"}	2017-09-18	2017-12-22	5	2017-09-15 12:31:23.539752	2017-09-17 15:43:27.622073	t	1
10	{"fr": "Préparation du débat"}	{"fr": "<ul><li>Identification des enjeux</li><li>Préparation des documents avec la maîtrise d'ouvrage</li><li>Planification des rencontres</li></ul><p><br></p>"}	2017-06-01	2017-09-17	6	2017-09-17 15:57:11.271881	2017-09-17 15:57:11.271881	f	0
14	{"fr": "Restitution jeux de rôles "}	{"fr": "<p>L'objectif de cette étape est de vous permettre d'identifier les différentes recommandations issues des jeux de rôles. Prenez connaissance de chaque étape et votez pour celles qui vous paraissent plus pertinentes. </p><p><br></p>"}	2017-10-17	2017-10-18	8	2017-10-13 14:38:00.118369	2017-10-13 15:13:00.394488	t	0
15	{"fr": "Bilan"}	{"fr": "<p>Suite à la restitution, retrouvez le bilan final et voyez quelle recommandation a obtenu le plus de votes. </p>"}	2017-10-20	2017-10-27	8	2017-10-13 15:10:57.531854	2017-10-13 15:13:27.804166	f	1
16	{"fr": "Restitution des jeux de rôles "}	{"fr": "<p><strong>Prenez connaissance</strong> des différentes recommandations qui ont été faites à l'issue des jeux de rôles organisés pendant le séminaire de formation des garants des 16 et 17 octobre 2017. <strong>Votez pour soutenir celles qui vous paraissent être les plus pertinentes. </strong></p>"}	2017-10-17	2017-10-22	9	2017-10-16 15:00:24.992832	2017-10-16 15:06:29.29789	t	0
17	{"fr": "Bilan"}	{"fr": "<p>Cet espace vous permettra de retrouver le bilan de l'étape de priorisation des recommandations. </p>"}	2017-10-22	2017-10-28	9	2017-10-16 15:08:18.170608	2017-10-16 15:08:18.170608	f	1
18	{"fr": "Consultation avant débat"}	{"fr": ""}	2017-11-01	2017-11-11	7	2017-11-14 11:14:03.078085	2017-11-14 11:15:15.952917	f	0
13	{"fr": "Débat en cours"}	{"fr": ""}	2017-11-12	2018-03-31	7	2017-09-22 14:43:27.811314	2017-11-14 11:15:15.957807	t	1
11	{"fr": "Débat public"}	{"fr": "<p>Récolte des avis des différentes parties prenantes sous 4 modalités</p><ul><li>Questions - Réponses</li><li>Avis</li><li>Forum ouvert</li><li>Cahiers d'acteurs</li></ul>"}	2017-09-18	2017-12-22	6	2017-09-17 15:57:11.280605	2017-09-17 15:57:11.280605	f	1
12	{"fr": "Synthèse et archivage"}	{"fr": "<ul><li>Fin de la période de contribution</li><li>Synthèse des contributions faites par les différents acteurs ayant pris part au débat.</li></ul>"}	2017-12-22	2018-01-31	6	2017-09-17 15:57:11.285408	2017-12-22 20:52:10.561875	t	2
19	{"fr": "Introduction"}	\N	\N	\N	10	2018-01-25 15:59:32.821305	2018-01-25 15:59:32.821305	t	0
\.


--
-- Data for Name: decidim_participatory_process_user_roles; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_participatory_process_user_roles (id, decidim_user_id, decidim_participatory_process_id, role, created_at, updated_at) FROM stdin;
1	3	1	admin	2017-09-13 12:47:17.502732	2017-09-13 12:47:17.502732
2	4	1	collaborator	2017-09-13 12:47:17.742176	2017-09-13 12:47:17.742176
3	5	1	moderator	2017-09-13 12:47:17.950586	2017-09-13 12:47:17.950586
4	59	2	admin	2017-09-13 12:47:34.27401	2017-09-13 12:47:34.27401
5	60	2	collaborator	2017-09-13 12:47:34.524619	2017-09-13 12:47:34.524619
6	61	2	moderator	2017-09-13 12:47:34.748621	2017-09-13 12:47:34.748621
7	117	3	admin	2017-09-13 12:47:50.973552	2017-09-13 12:47:50.973552
8	118	3	collaborator	2017-09-13 12:47:51.18975	2017-09-13 12:47:51.18975
9	119	3	moderator	2017-09-13 12:47:51.413889	2017-09-13 12:47:51.413889
10	331	4	admin	2017-09-13 15:13:12.692798	2017-09-13 15:13:12.692798
11	340	4	admin	2017-09-15 08:47:09.61058	2017-09-15 08:47:09.61058
12	341	4	collaborator	2017-09-15 08:48:37.582767	2017-09-15 08:48:37.582767
13	342	4	moderator	2017-09-15 08:50:26.694395	2017-09-15 08:50:26.694395
14	340	5	admin	2017-09-15 14:10:54.221723	2017-09-15 14:10:54.221723
15	341	5	collaborator	2017-09-15 14:11:13.151999	2017-09-15 14:11:13.151999
16	342	5	moderator	2017-09-15 14:11:29.331937	2017-09-15 14:11:29.331937
19	345	5	moderator	2017-09-15 14:20:03.411142	2017-09-15 14:20:03.411142
22	365	7	admin	2017-09-22 14:44:00.795615	2017-09-22 14:44:00.795615
23	340	6	admin	2017-09-22 16:08:56.405893	2017-09-22 16:08:56.405893
24	341	6	admin	2017-10-05 09:57:17.96221	2017-10-05 09:57:17.96221
25	359	7	moderator	2017-10-06 08:55:50.110677	2017-10-06 08:55:50.110677
26	381	7	moderator	2017-10-06 08:57:33.182341	2017-10-06 08:57:33.182341
27	375	6	admin	2017-10-09 07:22:32.799541	2017-10-09 07:22:32.799541
28	400	7	admin	2017-11-08 09:09:17.844614	2017-11-08 09:09:17.844614
29	401	7	admin	2017-11-08 09:09:47.9493	2017-11-08 09:09:47.9493
30	402	7	admin	2017-11-08 09:10:07.220244	2017-11-08 09:10:07.220244
31	443	6	collaborator	2018-02-17 11:52:58.997488	2018-02-17 11:52:58.997488
32	444	6	moderator	2018-02-17 11:55:08.715572	2018-02-17 11:55:08.715572
33	444	10	moderator	2018-02-17 12:13:58.019063	2018-02-17 12:13:58.019063
\.


--
-- Data for Name: decidim_participatory_processes; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_participatory_processes (id, slug, hashtag, decidim_organization_id, created_at, updated_at, title, subtitle, short_description, description, hero_image, banner_image, promoted, published_at, developer_group, end_date, meta_scope, local_area, target, participatory_scope, participatory_structure, decidim_scope_id, decidim_participatory_process_group_id, show_statistics, announcement, scopes_enabled, start_date) FROM stdin;
1	voluptatem-aut	#autem	1	2017-09-13 12:47:16.743172	2017-09-13 12:47:16.743172	{"ca": "Id est debitis quaerat possimus ipsum ut non reiciendis.", "en": "Omnis sunt deleniti at ullam voluptas iusto quisquam dolorum aut.", "es": "Dolorum molestias vel aut deserunt quis ut et aut ut."}	{"ca": "Reprehenderit voluptatem consequuntur omnis autem quis.", "en": "Quo rerum vitae.", "es": "Rem est omnis molestiae perferendis dolorem."}	{"ca": "<p>Ut sunt itaque quasi quo aliquid quas placeat.</p>", "en": "<p>Nesciunt quasi ea excepturi sequi.</p>", "es": "<p>Adipisci qui repellendus laborum non voluptatem tempora.</p>"}	{"ca": "<p>At laborum quis dolorum quasi. Molestiae dolorum omnis nulla. Blanditiis ut consequatur quisquam sint pariatur voluptas dolor.</p>", "en": "<p>Voluptas sed qui sed saepe ratione. In rem molestias sint non eum nam nihil. Eum quam eos nesciunt voluptas reprehenderit est maiores.</p>", "es": "<p>Maxime ut inventore. Unde omnis perferendis veritatis quia totam ut cupiditate. Voluptatum sit asperiores ad placeat enim. Laudantium hic possimus quos et in. Aspernatur possimus eos at.</p>"}	city.jpeg	city2.jpeg	t	2017-08-30 12:47:16.469493	{"ca": "Nihil tenetur ut sunt explicabo.", "en": "Possimus labore sed.", "es": "Enim."}	2017-11-13	{"ca": "aliquid", "en": "voluptatum", "es": "modi"}	{"ca": "Nam et aut.", "en": "Magni veritatis pariatur error molestias repellat.", "es": "Et et non et quasi."}	{"ca": "Reiciendis explicabo et dolorum occaecati voluptatibus cum itaque.", "en": "Et aut sed voluptates.", "es": "Iste est nam dolorem assumenda perspiciatis nobis vitae."}	{"ca": "Voluptatum ducimus ut voluptate iste et.", "en": "Impedit quo et.", "es": "Quia modi voluptatibus ipsum est."}	{"ca": "Rerum illo voluptate est amet molestiae.", "en": "Ut et doloribus inventore.", "es": "Repellendus doloribus est."}	15	3	t	\N	t	2017-09-13
2	dolor-iusto	#quia	1	2017-09-13 12:47:16.93253	2017-09-13 12:47:16.93253	{"ca": "Illum qui qui qui voluptatibus quisquam sunt culpa.", "en": "Consectetur aut ea sed qui veniam autem voluptatem molestias.", "es": "Ut commodi vero sapiente asperiores omnis consectetur dolorum eaque doloremque."}	{"ca": "Culpa quas illo similique recusandae.", "en": "Non tempora et aliquid non.", "es": "Velit quo cum."}	{"ca": "<p>Sint et exercitationem veniam dolore.</p>", "en": "<p>Quia eveniet harum repudiandae quis corporis doloremque a.</p>", "es": "<p>Adipisci magnam quisquam ea.</p>"}	{"ca": "<p>Non occaecati ipsam. Quis molestiae dignissimos eos alias ut dolorem. Ab cumque ratione ex dolore voluptates.</p>", "en": "<p>Nostrum nemo ad molestiae dignissimos debitis totam asperiores. Sequi dolores nisi. Occaecati delectus ut et quis veniam excepturi et.</p>", "es": "<p>Dicta quisquam consequatur illo. Ea consequatur sequi sed molestiae tempore. Id eius odit dignissimos. Et magni ipsum. Ex possimus quo eum tempore commodi.</p>"}	city.jpeg	city2.jpeg	t	2017-08-30 12:47:16.760807	{"ca": "Quidem cumque.", "en": "Rerum sed est earum sit.", "es": "Et est qui sint ex suscipit."}	2017-11-13	{"ca": "sint", "en": "et", "es": "laudantium"}	{"ca": "Porro commodi ea delectus.", "en": "Sed error voluptatibus qui libero.", "es": "Tempore earum in voluptatum."}	{"ca": "Itaque ut libero quas dolores.", "en": "Modi laborum repellendus nulla.", "es": "Aut ut et expedita velit et corrupti."}	{"ca": "Culpa.", "en": "Aut quia soluta consequatur.", "es": "Qui quasi consequatur."}	{"ca": "Voluptatem veniam neque saepe dolores ab.", "en": "Ex rerum at reprehenderit.", "es": "Ab optio dolor nisi modi veritatis."}	12	3	t	\N	t	2017-09-13
3	velit-quos	#placeat	1	2017-09-13 12:47:17.143749	2017-09-13 12:47:17.143749	{"ca": "Quis et vitae id sit.", "en": "Debitis fugit facere quia officiis earum rerum eum dolorem.", "es": "Ut est dolor dignissimos accusantium."}	{"ca": "Doloremque non quia nemo cupiditate nihil saepe.", "en": "Facere dolor numquam ut molestiae unde.", "es": "Quos id eos."}	{"ca": "<p>Sit quia impedit ipsam sint quis.</p>", "en": "<p>Vitae aperiam laborum unde sed nesciunt similique a.</p>", "es": "<p>Laudantium qui optio quis quo.</p>"}	{"ca": "<p>Quidem voluptatem commodi. Aspernatur quas harum quis. Deserunt sit vel aut. Vitae repellendus neque accusamus.</p>", "en": "<p>Ex officiis deserunt in qui libero. Excepturi qui voluptate. Est voluptatum voluptatem aspernatur sunt dolorem.</p>", "es": "<p>Corrupti consequuntur ad incidunt. Pariatur ducimus ipsa provident. Error nisi corporis sequi ut. Et rem voluptatem repellendus omnis accusamus.</p>"}	city.jpeg	city2.jpeg	t	2017-08-30 12:47:16.942508	{"ca": "Itaque sunt ut quis inventore aut.", "en": "Officia quis.", "es": "Error quae."}	2017-11-13	{"ca": "in", "en": "totam", "es": "harum"}	{"ca": "Exercitationem est nulla.", "en": "Reprehenderit quia rem officiis aut accusantium.", "es": "Ut error."}	{"ca": "Neque libero tempore voluptas porro.", "en": "Ipsa omnis quod est qui reiciendis.", "es": "Itaque quis aliquam."}	{"ca": "Ea.", "en": "Aut.", "es": "Natus enim."}	{"ca": "Non nihil.", "en": "Voluptas sunt nulla non.", "es": "Sint nobis."}	\N	1	t	\N	t	2017-09-13
4	port-de-dunkerque-test		2	2017-09-13 15:08:43.487264	2017-09-18 06:00:08.522915	{"fr": "Sandbox Débat Public - Port de Dunkerque "}	{"fr": "Du 18 septembre au 22 décembre 2017 "}	{"fr": "<h4>Le port de Dunkerque envisage de développer ses insfrastructures pour accueillir un plus grand nombre de conteneurs.</h4>"}	{"fr": "<iframe class=\\"ql-video\\" allowfullscreen=\\"true\\" src=\\"https://www.youtube.com/embed/qA6LMB64uTs?showinfo=0\\" frameborder=\\"0\\"></iframe><h1>Le débat se prépare, avec vous !</h1><p>\\"La mise en ligne aujourd’hui du <a href=\\"https://portdedunkerque.debatpublic.fr/actualites/28-tout-savoir-sur-le-projet-du-port\\" target=\\"_blank\\"><strong>Dossier du Maître d’Ouvrage</strong> </a>sur le projet d’extension du port de Dunkerque donne le coup d’envoi de la phase préparatoire du débat public,&nbsp;prévu <strong>du 18 septembre 2017 au 22 décembre 2017.</strong>Vous trouverez dans ce<strong> </strong><a href=\\"https://portdedunkerque.debatpublic.fr/images/pdf/dmo.pdf\\" target=\\"_blank\\"><strong>document</strong></a> et <a href=\\"https://portdedunkerque.debatpublic.fr/images/pdf/dmo-synthese.pdf\\" target=\\"_blank\\">la <strong>synthèse</strong></a> qui l’accompagne, les éléments expliquant le pourquoi et le comment du choix envisagé par le port.&nbsp;Ce que sont les apports&nbsp;du projet au <strong>développement du dunkerquois et de la région</strong>, ses effets attendus, en positif ou en négatif. La question de l’emploi local sera notamment au cœur de ce projet.</p><p>A partir de maintenant, chacun disposera d’environ deux mois pour se préparer, pour réfléchir <strong>aux questions</strong> qu’il voudra poser, <strong>aux interpellations</strong> qu'il souhaitera formuler.</p><p>Chacun pourra affûter ses <strong>arguments</strong>, réfléchir à sa <strong>contribution</strong> à l'occasion d’une des <strong>70 initiatives prévues</strong> au dernier trimestre de 2017 : réunions publiques, focus groupes (ateliers thématiques), débats mobiles de proximité, réunions en entreprises et universités, cahiers d’acteurs, forum en ligne, audition d’experts...</p><p>Prochain rendez-vous : <a href=\\"https://portdedunkerque.debatpublic.fr/actualites/34-la-journee-preparatoire-programme\\" target=\\"_blank\\"><strong>la journée préparatoire du mardi 19 septembre à l’Escale</strong></a>, où plus d'une centaine de participants du territoire sont attendus pour bien définir les thèmes principaux du débat.\\"</p><p><br></p><p>Bon été et à bientôt,</p><p><strong>Jacques Archimbaud</strong></p><p>Président de la Commission particulière du débat public sur le Port de Dunkerque</p><p>&nbsp;La boutique du débat : 7 rue David D'Angers - 59140 Dunkerque.</p>"}	logo-cpdp-dunkerque.jpg	dunkerque_banner.png	f	\N	{"fr": "Grand port maritime de Dunkerque "}	2017-12-22	{"fr": ""}	{"fr": "Port de Dunkerque"}	{"fr": "Habitants, entreprises et associations implantés dans la région de Dunkerque"}	{"fr": "Permettre à tous de participer à l'élaboration du projet."}	{"fr": "Associations, entreprises, habitants la zone portuaire."}	\N	\N	t	{"fr": "<p>Le débat public sera lancé le 18 septembre.</p>"}	t	2017-09-18
5	port-de-dunkerque-0		2	2017-09-15 12:31:23.490717	2017-09-18 03:33:45.338129	{"fr": "Débat Public - Port de Dunkerque "}	{"fr": "Du 18 septembre au 22 décembre 2017 "}	{"fr": "<h4>Le port de Dunkerque envisage de développer ses insfrastructures pour accueillir un plus grand nombre de conteneurs.</h4>"}	{"fr": "<iframe class=\\"ql-video\\" allowfullscreen=\\"true\\" src=\\"https://www.youtube.com/embed/qA6LMB64uTs?showinfo=0\\" frameborder=\\"0\\"></iframe><h1>Le débat se prépare, avec vous !</h1><p>\\"La mise en ligne aujourd’hui du <a href=\\"https://portdedunkerque.debatpublic.fr/actualites/28-tout-savoir-sur-le-projet-du-port\\" target=\\"_blank\\"><strong>Dossier du Maître d’Ouvrage</strong> </a>sur le projet d’extension du port de Dunkerque donne le coup d’envoi de la phase préparatoire du débat public,&nbsp;prévu <strong>du 18 septembre 2017 au 22 décembre 2017.</strong>Vous trouverez dans ce<strong> </strong><a href=\\"https://portdedunkerque.debatpublic.fr/images/pdf/dmo.pdf\\" target=\\"_blank\\"><strong>document</strong></a> et <a href=\\"https://portdedunkerque.debatpublic.fr/images/pdf/dmo-synthese.pdf\\" target=\\"_blank\\">la <strong>synthèse</strong></a> qui l’accompagne, les éléments expliquant le pourquoi et le comment du choix envisagé par le port.&nbsp;Ce que sont les apports&nbsp;du projet au <strong>développement du dunkerquois et de la région</strong>, ses effets attendus, en positif ou en négatif. La question de l’emploi local sera notamment au cœur de ce projet.</p><p>A partir de maintenant, chacun disposera d’environ deux mois pour se préparer, pour réfléchir <strong>aux questions</strong> qu’il voudra poser, <strong>aux interpellations</strong> qu'il souhaitera formuler.</p><p>Chacun pourra affûter ses <strong>arguments</strong>, réfléchir à sa <strong>contribution</strong> à l'occasion d’une des <strong>70 initiatives prévues</strong> au dernier trimestre de 2017 : réunions publiques, focus groupes (ateliers thématiques), débats mobiles de proximité, réunions en entreprises et universités, cahiers d’acteurs, forum en ligne, audition d’experts...</p><p>Prochain rendez-vous : <a href=\\"https://portdedunkerque.debatpublic.fr/actualites/34-la-journee-preparatoire-programme\\" target=\\"_blank\\"><strong>la journée préparatoire du mardi 19 septembre à l’Escale</strong></a>, où plus d'une centaine de participants du territoire sont attendus pour bien définir les thèmes principaux du débat.\\"</p><p><br></p><p>Bon été et à bientôt,</p><p><strong>Jacques Archimbaud</strong></p><p>Président de la Commission particulière du débat public sur le Port de Dunkerque</p><p>&nbsp;La boutique du débat : 7 rue David D'Angers - 59140 Dunkerque.</p>"}	logo-cpdp-dunkerque.jpg	dunkerque_banner.png	f	\N	{"fr": "Grand port maritime de Dunkerque "}	2017-12-22	{"fr": ""}	{"fr": "Port de Dunkerque"}	{"fr": "Habitants, entreprises et associations implantés dans la région de Dunkerque"}	{"fr": "Permettre à tous de participer à l'élaboration du projet."}	{"fr": "Associations, entreprises, habitants la zone portuaire."}	\N	\N	t	{"fr": ""}	t	2017-09-18
7	test		3	2017-09-22 14:43:27.78594	2017-11-14 12:26:28.194157	{"fr": "Processus test"}	{"fr": "Un processus = un débat"}	{"fr": "<p>Texte d'accroche</p>"}	{"fr": "<p>Texte détaillé</p>"}	Vig_Vidéo_Le_débat_VFCEA.PNG	dunkerque_banner.png	f	2017-09-22 14:43:40.670299	{"fr": ""}	2018-03-31	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	\N	\N	t	{"fr": ""}	f	2017-11-01
10	geraniums		2	2018-01-25 15:59:32.623839	2018-02-17 11:26:46.523841	{"fr": "Route des géraniums - Réunion"}	{"fr": "Débat public"}	{"fr": "<p>Le projet de route des géraniums, porté par la Région Réunion, est soumis à un débat public qui se déroulera au cours du premier semestre 2018. Le débat est organisé par une commission, neutre et indépendante, nommée par la Commission Nationale du Débat Public.</p>"}	{"fr": "<p>Le projet de « Route des Géraniums » consiste à créer une liaison routière entre le col de Bellevue et Saint-Pierre, afin de fluidifier la circulation dans le Sud de l’île de la Réunion, au niveau des communes de Saint-Pierre et du Tampon, et améliorer ainsi l’accès à certains lieux touristiques.</p><p>Six variantes de tracé (ouest, est-ouest, est) sont soumises au débat.</p><p>Le coût du projet est estimé entre 360 et 583 millions d’euros, selon les variantes</p>"}	\N	\N	f	\N	{"fr": ""}	\N	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	\N	\N	t	{"fr": ""}	f	\N
8	formation	garantCNDP	3	2017-10-13 14:38:00.051774	2017-10-13 14:41:14.478997	{"fr": "Séminaire de formation des garants"}	{"fr": "16 et 17 octobre 2017"}	{"fr": "<p>Restitution des jeux de rôles </p>"}	{"fr": "<p>Pendant le séminaire de formation, vous avez été amenés à jouer 3 jeux de rôles :</p><ul><li>Jeu 1</li><li>Jeu 2</li><li>Jeu 3</li></ul><p>Lors des moments de débriefing qui ont suivi chaque jeux, vous avez identifié des recommandations concernant le rôle du garant... </p>"}	Atelier.jpg	Formation-kits.jpg	f	2017-10-13 14:41:14.476827	{"fr": ""}	2017-10-17	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": "Permettre d'identifier les principales recommandations à donner aux garants "}	{"fr": ""}	\N	\N	f	{"fr": ""}	f	2017-10-16
9	formation1	garantsCNDP	2	2017-10-16 15:00:24.958901	2017-10-16 15:12:40.511063	{"fr": "Séminaire de formation des garants "}	{"fr": "Restitution des jeux de rôles "}	{"fr": "<p>Lors du séminaire de formation des garants de la concertation qui composent la première liste nationale gérée par la CNDP, vous avez été amené à participer à trois jeux de rôles : </p><ol><li>Jeu n°1 </li><li>Jeu n°2 </li><li>Jeu n°3 </li></ol><p><br></p>"}	{"fr": "<p>Chaque jeu a été suivi par un moment de débrifieng pendant lequel vous avez pu formuler un certain nombre de recommandations concernant le rôle du garant. Cet espace en ligne vous permettra de retrouver toutes les recommandations formulées pendant la journée. Vous pouvez toutes les parcourir et voter pour celles qui vous semblent être les plus pertinentes. </p>"}	Atelier.jpg	Formation-kits.jpg	f	\N	{"fr": ""}	2017-10-28	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	{"fr": ""}	\N	\N	t	{"fr": ""}	f	2017-10-16
6	port-de-dunkerque	DebatDkq	2	2017-09-17 15:57:11.158552	2017-12-22 20:30:27.702833	{"fr": "Débat Public - Port de Dunkerque "}	{"fr": "Du 18 septembre au 22 décembre 2017 "}	{"fr": "<p>Le port de Dunkerque envisage de développer ses infrastructures pour accueillir un plus grand nombre de conteneurs. Le projet nécessite un débat public.</p><p><br></p><p><strong>Par sécurité et pour éviter un incident technique éventuel, la plateforme participative ferme dans le courant de la soirée du 22 décembre.</strong></p><p><br></p><p><strong>Si vous voulez déposer votre avis ou contribution, vous avez jusque 23h59 ce vendredi 22 décembre, en envoyant un email à portdedunkerque@debat-public.fr</strong></p><p><strong>Un accusé-réception vous sera fait prochainement. Merci de votre compréhension.</strong></p>"}	{"fr": "<iframe class=\\"ql-video\\" allowfullscreen=\\"true\\" src=\\"https://www.youtube.com/embed/XnIs3kUZMZA?showinfo=0\\" frameborder=\\"0\\"></iframe><p><br></p><p>Pour le débat public sur le projet du Port de Dunkerque, la commission particulière (CPDP) a souhaité articuler au <a href=\\"https://portdedunkerque.debatpublic.fr/\\" target=\\"_blank\\">site du débat</a>, une plateforme numérique. Elle s'adresse aux citoyens et aux parties prenantes et permet de prolonger l’espace d’information et de participation du public.</p><p><strong>Elle doit permettre l’implication de tous les publics</strong>, et particulièrement de ceux qui ne peuvent se rendre aux rencontres publiques. Elle a donc vocation à développer et à enrichir la qualité des échanges et nourrir le débat public.</p><p>Toute personne physique ou morale inscrite sur la plateforme peut participer aux différents espaces de participation en ligne. Vous pouvez trouver, au sein du processus participatif, <strong>différents espaces de participation avec des objectifs et des caractéristiques bien précises&nbsp;</strong>:</p><p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Participez au forum&nbsp;!</p><p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Déposez un avis argumenté&nbsp;!</p><p>Il est possible de naviguer librement et de façon anonyme à travers la plateforme. En revanche, pour participer à une discussion ou poser une question, vous devez vous inscrire.&nbsp;</p><p><br></p><p><strong>Pour poser une question</strong>, <a href=\\"https://portdedunkerque.debatpublic.fr/question\\" target=\\"_blank\\"><strong><u>c'est par ici</u></strong></a> !! </p><p><br></p><p>Pour nous contacter : <a href=\\"mailto:portdedunkerque@debat-cndp.fr\\" target=\\"_blank\\">portdedunkerque@debat-cndp.fr</a> </p>"}	CNDP_RVB_WEB.jpg	participons.dunkerque.png	f	2017-09-17 15:58:45.352976	{"fr": " Commission particulière du débat public présidée par Jacques Archimbaud"}	2017-12-22	{"fr": ""}	{"fr": "Région de Dunkerque"}	{"fr": "Habitants, entreprises et associations implantés dans la région de Dunkerque"}	{"fr": "Permettre à tous de participer à l'élaboration du projet."}	{"fr": "Associations, entreprises, habitants, usagers du territoire."}	\N	\N	t	{"fr": ""}	t	2017-09-18
\.


--
-- Data for Name: decidim_proposals_proposal_votes; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_proposals_proposal_votes (id, decidim_proposal_id, decidim_author_id, created_at, updated_at) FROM stdin;
1	1	36	2017-09-13 12:47:26.089957	2017-09-13 12:47:26.089957
2	2	37	2017-09-13 12:47:26.407178	2017-09-13 12:47:26.407178
3	2	38	2017-09-13 12:47:26.617275	2017-09-13 12:47:26.617275
4	3	39	2017-09-13 12:47:26.892745	2017-09-13 12:47:26.892745
5	3	40	2017-09-13 12:47:27.103571	2017-09-13 12:47:27.103571
6	4	41	2017-09-13 12:47:27.435995	2017-09-13 12:47:27.435995
7	4	42	2017-09-13 12:47:27.672971	2017-09-13 12:47:27.672971
8	5	43	2017-09-13 12:47:27.999105	2017-09-13 12:47:27.999105
9	6	44	2017-09-13 12:47:28.368558	2017-09-13 12:47:28.368558
10	7	45	2017-09-13 12:47:28.734766	2017-09-13 12:47:28.734766
11	7	46	2017-09-13 12:47:28.983234	2017-09-13 12:47:28.983234
12	8	47	2017-09-13 12:47:29.320961	2017-09-13 12:47:29.320961
13	9	48	2017-09-13 12:47:29.641796	2017-09-13 12:47:29.641796
14	9	49	2017-09-13 12:47:29.867919	2017-09-13 12:47:29.867919
15	10	50	2017-09-13 12:47:30.210356	2017-09-13 12:47:30.210356
16	11	51	2017-09-13 12:47:30.476246	2017-09-13 12:47:30.476246
17	14	52	2017-09-13 12:47:30.87087	2017-09-13 12:47:30.87087
18	15	53	2017-09-13 12:47:31.210717	2017-09-13 12:47:31.210717
19	15	54	2017-09-13 12:47:31.429893	2017-09-13 12:47:31.429893
20	16	55	2017-09-13 12:47:31.752328	2017-09-13 12:47:31.752328
21	16	56	2017-09-13 12:47:31.962979	2017-09-13 12:47:31.962979
22	19	57	2017-09-13 12:47:32.380672	2017-09-13 12:47:32.380672
23	20	58	2017-09-13 12:47:32.689523	2017-09-13 12:47:32.689523
24	23	92	2017-09-13 12:47:42.656254	2017-09-13 12:47:42.656254
25	23	93	2017-09-13 12:47:42.872291	2017-09-13 12:47:42.872291
26	24	94	2017-09-13 12:47:43.172081	2017-09-13 12:47:43.172081
27	24	95	2017-09-13 12:47:43.399229	2017-09-13 12:47:43.399229
28	25	96	2017-09-13 12:47:43.699981	2017-09-13 12:47:43.699981
29	25	97	2017-09-13 12:47:43.921699	2017-09-13 12:47:43.921699
30	26	98	2017-09-13 12:47:44.196625	2017-09-13 12:47:44.196625
31	26	99	2017-09-13 12:47:44.414771	2017-09-13 12:47:44.414771
32	27	100	2017-09-13 12:47:44.723064	2017-09-13 12:47:44.723064
33	27	101	2017-09-13 12:47:44.938484	2017-09-13 12:47:44.938484
34	28	102	2017-09-13 12:47:45.30196	2017-09-13 12:47:45.30196
35	30	103	2017-09-13 12:47:45.713861	2017-09-13 12:47:45.713861
36	30	104	2017-09-13 12:47:45.92637	2017-09-13 12:47:45.92637
37	31	105	2017-09-13 12:47:46.186294	2017-09-13 12:47:46.186294
38	33	106	2017-09-13 12:47:46.712815	2017-09-13 12:47:46.712815
39	33	107	2017-09-13 12:47:46.952761	2017-09-13 12:47:46.952761
40	34	108	2017-09-13 12:47:47.305995	2017-09-13 12:47:47.305995
41	34	109	2017-09-13 12:47:47.53177	2017-09-13 12:47:47.53177
42	35	110	2017-09-13 12:47:47.829123	2017-09-13 12:47:47.829123
43	36	111	2017-09-13 12:47:48.139821	2017-09-13 12:47:48.139821
44	36	112	2017-09-13 12:47:48.368114	2017-09-13 12:47:48.368114
45	37	113	2017-09-13 12:47:48.660015	2017-09-13 12:47:48.660015
46	38	114	2017-09-13 12:47:48.983944	2017-09-13 12:47:48.983944
47	39	115	2017-09-13 12:47:49.302785	2017-09-13 12:47:49.302785
48	40	116	2017-09-13 12:47:49.653386	2017-09-13 12:47:49.653386
49	41	150	2017-09-13 12:47:58.976851	2017-09-13 12:47:58.976851
50	41	151	2017-09-13 12:47:59.200736	2017-09-13 12:47:59.200736
51	42	152	2017-09-13 12:47:59.526591	2017-09-13 12:47:59.526591
52	44	153	2017-09-13 12:47:59.996351	2017-09-13 12:47:59.996351
53	45	154	2017-09-13 12:48:00.359023	2017-09-13 12:48:00.359023
54	45	155	2017-09-13 12:48:00.592491	2017-09-13 12:48:00.592491
55	46	156	2017-09-13 12:48:00.957037	2017-09-13 12:48:00.957037
56	47	157	2017-09-13 12:48:01.306341	2017-09-13 12:48:01.306341
57	49	158	2017-09-13 12:48:01.783993	2017-09-13 12:48:01.783993
58	50	159	2017-09-13 12:48:02.225805	2017-09-13 12:48:02.225805
59	50	160	2017-09-13 12:48:02.46711	2017-09-13 12:48:02.46711
60	51	161	2017-09-13 12:48:02.868535	2017-09-13 12:48:02.868535
61	51	162	2017-09-13 12:48:03.12569	2017-09-13 12:48:03.12569
62	52	163	2017-09-13 12:48:03.489168	2017-09-13 12:48:03.489168
63	53	164	2017-09-13 12:48:03.788062	2017-09-13 12:48:03.788062
64	53	165	2017-09-13 12:48:04.031846	2017-09-13 12:48:04.031846
65	54	166	2017-09-13 12:48:04.350297	2017-09-13 12:48:04.350297
66	54	167	2017-09-13 12:48:04.591474	2017-09-13 12:48:04.591474
67	55	168	2017-09-13 12:48:05.004433	2017-09-13 12:48:05.004433
68	55	169	2017-09-13 12:48:05.263994	2017-09-13 12:48:05.263994
69	56	170	2017-09-13 12:48:05.716937	2017-09-13 12:48:05.716937
70	57	171	2017-09-13 12:48:06.188367	2017-09-13 12:48:06.188367
71	59	172	2017-09-13 12:48:06.76895	2017-09-13 12:48:06.76895
72	60	173	2017-09-13 12:48:07.116034	2017-09-13 12:48:07.116034
73	60	174	2017-09-13 12:48:07.35531	2017-09-13 12:48:07.35531
74	61	205	2017-09-13 12:48:17.356371	2017-09-13 12:48:17.356371
75	61	206	2017-09-13 12:48:17.578787	2017-09-13 12:48:17.578787
76	63	207	2017-09-13 12:48:18.052865	2017-09-13 12:48:18.052865
77	64	208	2017-09-13 12:48:18.37394	2017-09-13 12:48:18.37394
78	64	209	2017-09-13 12:48:18.581542	2017-09-13 12:48:18.581542
79	66	210	2017-09-13 12:48:18.927035	2017-09-13 12:48:18.927035
80	67	211	2017-09-13 12:48:19.233979	2017-09-13 12:48:19.233979
81	69	212	2017-09-13 12:48:19.603938	2017-09-13 12:48:19.603938
82	70	213	2017-09-13 12:48:19.91599	2017-09-13 12:48:19.91599
83	71	214	2017-09-13 12:48:20.261679	2017-09-13 12:48:20.261679
84	71	215	2017-09-13 12:48:20.480614	2017-09-13 12:48:20.480614
85	72	216	2017-09-13 12:48:20.763182	2017-09-13 12:48:20.763182
86	73	217	2017-09-13 12:48:21.117692	2017-09-13 12:48:21.117692
87	74	218	2017-09-13 12:48:21.449526	2017-09-13 12:48:21.449526
88	74	219	2017-09-13 12:48:21.667995	2017-09-13 12:48:21.667995
89	75	220	2017-09-13 12:48:21.970627	2017-09-13 12:48:21.970627
90	76	221	2017-09-13 12:48:22.303105	2017-09-13 12:48:22.303105
91	77	222	2017-09-13 12:48:22.609963	2017-09-13 12:48:22.609963
92	77	223	2017-09-13 12:48:22.826022	2017-09-13 12:48:22.826022
93	78	224	2017-09-13 12:48:23.245225	2017-09-13 12:48:23.245225
94	80	225	2017-09-13 12:48:23.746499	2017-09-13 12:48:23.746499
95	81	256	2017-09-13 12:48:32.301807	2017-09-13 12:48:32.301807
96	82	257	2017-09-13 12:48:32.683305	2017-09-13 12:48:32.683305
97	83	258	2017-09-13 12:48:32.998498	2017-09-13 12:48:32.998498
98	84	259	2017-09-13 12:48:33.375729	2017-09-13 12:48:33.375729
99	85	260	2017-09-13 12:48:33.719742	2017-09-13 12:48:33.719742
100	88	261	2017-09-13 12:48:34.436815	2017-09-13 12:48:34.436815
101	88	262	2017-09-13 12:48:34.655186	2017-09-13 12:48:34.655186
102	89	263	2017-09-13 12:48:34.990694	2017-09-13 12:48:34.990694
103	89	264	2017-09-13 12:48:35.206354	2017-09-13 12:48:35.206354
104	90	265	2017-09-13 12:48:35.595951	2017-09-13 12:48:35.595951
105	90	266	2017-09-13 12:48:35.864886	2017-09-13 12:48:35.864886
106	91	267	2017-09-13 12:48:36.171269	2017-09-13 12:48:36.171269
107	91	268	2017-09-13 12:48:36.382744	2017-09-13 12:48:36.382744
108	93	269	2017-09-13 12:48:36.833139	2017-09-13 12:48:36.833139
109	93	270	2017-09-13 12:48:37.04193	2017-09-13 12:48:37.04193
110	94	271	2017-09-13 12:48:37.332225	2017-09-13 12:48:37.332225
111	94	272	2017-09-13 12:48:37.559966	2017-09-13 12:48:37.559966
112	95	273	2017-09-13 12:48:37.946091	2017-09-13 12:48:37.946091
113	95	274	2017-09-13 12:48:38.170124	2017-09-13 12:48:38.170124
114	98	275	2017-09-13 12:48:38.608921	2017-09-13 12:48:38.608921
115	99	276	2017-09-13 12:48:38.990634	2017-09-13 12:48:38.990634
116	99	277	2017-09-13 12:48:39.215689	2017-09-13 12:48:39.215689
117	100	278	2017-09-13 12:48:39.676456	2017-09-13 12:48:39.676456
118	102	309	2017-09-13 12:48:48.481779	2017-09-13 12:48:48.481779
119	103	310	2017-09-13 12:48:48.787975	2017-09-13 12:48:48.787975
120	103	311	2017-09-13 12:48:48.995532	2017-09-13 12:48:48.995532
121	104	312	2017-09-13 12:48:49.420656	2017-09-13 12:48:49.420656
122	105	313	2017-09-13 12:48:49.788208	2017-09-13 12:48:49.788208
123	107	314	2017-09-13 12:48:50.388737	2017-09-13 12:48:50.388737
124	107	315	2017-09-13 12:48:50.608555	2017-09-13 12:48:50.608555
125	108	316	2017-09-13 12:48:50.954222	2017-09-13 12:48:50.954222
126	109	317	2017-09-13 12:48:51.306305	2017-09-13 12:48:51.306305
127	113	318	2017-09-13 12:48:52.159178	2017-09-13 12:48:52.159178
128	114	319	2017-09-13 12:48:52.443931	2017-09-13 12:48:52.443931
129	114	320	2017-09-13 12:48:52.654885	2017-09-13 12:48:52.654885
130	115	321	2017-09-13 12:48:53.020345	2017-09-13 12:48:53.020345
131	116	322	2017-09-13 12:48:53.385156	2017-09-13 12:48:53.385156
132	116	323	2017-09-13 12:48:53.610551	2017-09-13 12:48:53.610551
133	117	324	2017-09-13 12:48:53.92066	2017-09-13 12:48:53.92066
134	117	325	2017-09-13 12:48:54.128331	2017-09-13 12:48:54.128331
135	118	326	2017-09-13 12:48:54.440343	2017-09-13 12:48:54.440343
136	118	327	2017-09-13 12:48:54.65192	2017-09-13 12:48:54.65192
137	119	328	2017-09-13 12:48:54.966176	2017-09-13 12:48:54.966176
138	120	329	2017-09-13 12:48:55.290583	2017-09-13 12:48:55.290583
139	162	385	2017-10-13 15:05:40.011587	2017-10-13 15:05:40.011587
\.


--
-- Data for Name: decidim_proposals_proposals; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_proposals_proposals (id, title, body, decidim_feature_id, decidim_author_id, decidim_scope_id, created_at, updated_at, proposal_votes_count, decidim_user_group_id, state, answered_at, answer, reference, address, latitude, longitude) FROM stdin;
1	In aliquid cum ducimus possimus.	Nam ut sunt. Laboriosam qui dolores. Assumenda dignissimos nulla architecto aut sed. Debitis at soluta harum ut quis corporis. Iusto rerum velit quibusdam eligendi.\nQui harum modi commodi. Est harum fugit ea fugiat est aperiam. Sit rerum quia. Et distinctio qui.	3	27	15	2017-09-13 12:47:25.812999	2017-09-13 12:47:25.827748	1	\N	\N	2017-09-13 12:47:25.744943	\N	Jr.-PROP-2017-09-1	\N	\N	\N
131	Nouveau Forum	Ceci est un forum pour test	46	\N	\N	2017-09-15 14:49:42.413565	2017-09-15 14:49:42.513368	0	\N	\N	\N	\N	cndp-PROP-2017-09-131	\N	\N	\N
6	Consectetur culpa.	Dolorum praesentium similique. Molestias atque corrupti sit aut ea maxime dolores. Beatae voluptates a consectetur et. Tenetur minus ullam expedita distinctio. Et ut rem qui omnis quis.\nSuscipit velit ex laborum nihil quia necessitatibus eos. Cupiditate dolores architecto porro corrupti aut consequatur esse. Aperiam rerum omnis ea.	3	7	15	2017-09-13 12:47:28.114171	2017-09-13 12:47:28.125668	1	\N	\N	2017-09-13 12:47:28.098772	\N	Jr.-PROP-2017-09-6	\N	\N	\N
2	Cupiditate blanditiis vitae rerum consequatur.	Est in et. Dolores vel qui unde. Deleniti assumenda ut autem ipsam qui non et. Tempora autem aut.\nIn error similique et qui neque. Quia dolore ipsam reiciendis provident et. Atque iusto sed.	3	1	15	2017-09-13 12:47:26.152365	2017-09-13 12:47:26.168368	2	2	\N	2017-09-13 12:47:26.131407	\N	Jr.-PROP-2017-09-2	\N	\N	\N
132	Test de contribution avec categorie	Test de contribution avec categorie Test de contribution avec categorie	42	343	\N	2017-09-17 14:54:27.585649	2017-09-17 14:54:27.704105	0	\N	\N	\N	\N	cndp-PROP-2017-09-132	\N	\N	\N
3	Ullam atque.	Vel eos reiciendis praesentium porro ea debitis exercitationem. Necessitatibus molestiae voluptas provident ipsum quas earum. Maiores quis aut animi omnis quia nemo qui. Deleniti voluptatem quisquam consequatur. Dolor sit vel consequatur molestias harum cum.\nNihil sit cum eum provident quaerat. Aut impedit quis. Tenetur non sit voluptatem dolorem. Qui aut inventore et.	3	16	15	2017-09-13 12:47:26.673501	2017-09-13 12:47:26.683816	2	\N	\N	2017-09-13 12:47:26.666214	\N	Jr.-PROP-2017-09-3	\N	\N	\N
9	Et et aut mollitia.	Voluptatum maiores et suscipit rerum assumenda cupiditate. Sed incidunt et sit qui quisquam vero. Et voluptatem aut. Magni molestias delectus exercitationem quia.\nSimilique eius exercitationem adipisci rerum repellendus inventore debitis. Nulla facere sed autem illo est quasi illum. Rem tempora consequatur. Aut consequatur id. Incidunt earum aut.	3	28	15	2017-09-13 12:47:29.419361	2017-09-13 12:47:29.43108	2	\N	evaluating	2017-09-13 12:47:29.407702	\N	Jr.-PROP-2017-09-9	\N	\N	\N
4	Omnis molestias.	Velit est voluptates quas alias totam eius. Deleniti quam doloremque distinctio earum qui et in. Nihil qui quia hic excepturi cupiditate.\nQuae molestias omnis nemo. Qui omnis impedit doloremque consequuntur praesentium. Qui vero et et velit ipsam quo doloribus. Et vero ipsam minima repellendus.	3	27	15	2017-09-13 12:47:27.175834	2017-09-13 12:47:27.189187	2	\N	\N	2017-09-13 12:47:27.168571	\N	Jr.-PROP-2017-09-4	\N	\N	\N
5	Nostrum distinctio explicabo et.	Libero commodi iusto asperiores soluta vero qui. Itaque est qui nam enim. Omnis et voluptatum quo sint eveniet.\nIste iusto totam. Vel voluptatem architecto. Aliquam rerum magni. Facilis dicta dolorum provident occaecati eius et quia. Quaerat quo illum impedit numquam facilis ut perferendis.	3	15	15	2017-09-13 12:47:27.743707	2017-09-13 12:47:27.757659	1	\N	\N	2017-09-13 12:47:27.734354	\N	Jr.-PROP-2017-09-5	\N	\N	\N
7	Et non ipsam placeat aliquid.	Pariatur qui doloremque quae optio. Reiciendis voluptas earum eum odit velit sunt. Suscipit reiciendis voluptatem et nisi. Minus natus veniam recusandae.\nError labore architecto porro voluptatem. Expedita enim sed sed vel. Distinctio pariatur ipsa. Eos facilis rerum totam. Odit vitae iure.	3	31	15	2017-09-13 12:47:28.468898	2017-09-13 12:47:28.483246	2	\N	\N	2017-09-13 12:47:28.448177	\N	Jr.-PROP-2017-09-7	\N	\N	\N
8	Nemo dolorem consequatur harum sit odit omnis.	Corporis officia repudiandae quasi accusamus ut est. Quam et exercitationem qui sed aut. Rerum ut placeat minus in tempora est. Itaque pariatur quis odio nihil ut nesciunt. Inventore omnis a molestiae et praesentium illo debitis.\nMinus blanditiis autem. Distinctio recusandae maxime est iste dolor eum. Aut dolorum vitae molestias. Qui magni nihil nulla velit nesciunt.	3	37	15	2017-09-13 12:47:29.082744	2017-09-13 12:47:29.093663	1	\N	evaluating	2017-09-13 12:47:29.074913	\N	Jr.-PROP-2017-09-8	\N	\N	\N
12	Voluptatem dicta sunt minima.	Vero eos dolorem sed id debitis dolores enim. Voluptatem dolore mollitia earum a illum dolores fuga. Labore fuga vel itaque impedit nam non quas. Incidunt voluptatem dignissimos deserunt maiores nihil ut id. Perferendis dolore voluptates sapiente aut consectetur non.\nInventore fugiat vel enim aut. Et quibusdam quae. Repudiandae dolorum enim dolor voluptatem omnis. Voluptatem et enim labore unde occaecati quo amet. Quia blanditiis voluptatem earum minus.	3	32	15	2017-09-13 12:47:30.55887	2017-09-13 12:47:30.579732	0	\N	rejected	2017-09-13 12:47:30.551819	\N	Jr.-PROP-2017-09-12	\N	\N	\N
10	Quam et distinctio impedit.	Non quasi nemo. Ullam ut vero et. Dolorem sunt quisquam. Possimus sunt incidunt autem. Vitae ullam possimus sunt aut quis.\nEum vel ex nihil aut. Accusamus laboriosam expedita est rerum dolorem. Dolor distinctio dolorem suscipit et repudiandae.	3	20	15	2017-09-13 12:47:29.967468	2017-09-13 12:47:29.979589	1	\N	evaluating	2017-09-13 12:47:29.95418	\N	Jr.-PROP-2017-09-10	\N	\N	\N
13	Eos error velit non.	Voluptatem officia placeat dolor cumque et iste. Sapiente illo ut incidunt explicabo libero nisi. Veniam totam et aliquam facilis placeat enim itaque. Doloribus cumque ut sit voluptatem.\nQuia fuga voluptatem. Est qui iusto molestias quam animi ea minus. Maiores quis id ex blanditiis. Error aut at voluptatum minima amet.	3	18	15	2017-09-13 12:47:30.612709	2017-09-13 12:47:30.623468	0	\N	rejected	2017-09-13 12:47:30.604045	\N	Jr.-PROP-2017-09-13	\N	\N	\N
11	Ab non est velit nobis.	Ducimus porro culpa. Exercitationem sit vel. Officia dolorem quo. Neque alias vitae maxime molestias voluptas quos.\nDucimus molestiae repudiandae inventore magnam architecto assumenda quis. In rem accusamus officiis eos. Dolorem sunt dolores.	3	23	15	2017-09-13 12:47:30.248428	2017-09-13 12:47:30.269637	1	\N	rejected	2017-09-13 12:47:30.24148	\N	Jr.-PROP-2017-09-11	\N	\N	\N
15	Est est similique ex officia.	Et voluptatibus voluptatem vel qui architecto omnis distinctio. Laboriosam consectetur dolor perferendis. Qui voluptatum et labore officia debitis perferendis. Quae enim repellat autem illo praesentium. Deserunt laborum illum.\nDolores magnam facere iusto ea laborum. Odio aliquam voluptas aut eos vero. Voluptas omnis quia. Et temporibus ullam ipsa.	3	25	15	2017-09-13 12:47:30.971432	2017-09-13 12:47:30.986286	2	\N	rejected	2017-09-13 12:47:30.963288	\N	Jr.-PROP-2017-09-15	\N	\N	\N
14	Perferendis blanditiis.	Sint ea ratione praesentium nemo doloremque nobis. Accusamus non dolores at provident et perspiciatis. Dignissimos voluptatem quaerat quisquam magnam quo.\nLaborum dicta aut minus vero. Omnis incidunt earum. Veniam exercitationem aspernatur expedita. Voluptatem omnis doloremque. Unde ab ut molestias sint sint.	3	5	15	2017-09-13 12:47:30.652775	2017-09-13 12:47:30.663117	1	\N	rejected	2017-09-13 12:47:30.645827	\N	Jr.-PROP-2017-09-14	\N	\N	\N
16	Est quia tempora repellat similique distinctio.	Id velit sapiente dolor. Vel dicta aut magni maiores fugit ipsa. Voluptatem cum dolorem voluptatum esse natus aut eos.\nEa iure voluptatem consequatur. Optio placeat esse atque ipsum et quidem delectus. Eveniet quia vero qui aperiam dignissimos quo ipsum. Debitis nisi recusandae aspernatur eaque id ab. Illo rerum quia officiis saepe.	3	48	15	2017-09-13 12:47:31.531437	2017-09-13 12:47:31.542657	2	\N	rejected	2017-09-13 12:47:31.524283	\N	Jr.-PROP-2017-09-16	\N	\N	\N
108	Ut iusto animi ut.	Et minima iste qui voluptas eius. Culpa qui quae nulla sunt. Possimus sit recusandae. Optio eius repellat. Rerum sint id sequi sed.\nNam molestias in illum. Tenetur nobis quasi explicabo. Accusantium sed voluptate error vitae id. Quia quia ut.	33	290	\N	2017-09-13 12:48:50.736283	2017-09-13 12:48:50.746746	1	\N	evaluating	2017-09-13 12:48:50.730353	\N	Jr.-PROP-2017-09-108	\N	\N	\N
17	Quia assumenda doloremque nemo.	In ad dolorem occaecati. Aut aliquam error ut nobis non quos. Aut iure qui aliquam aut. Aut explicabo provident nihil quas eaque. Voluptatem consequatur eos natus quos quibusdam iusto dolores.\nReprehenderit impedit quod. Possimus eum autem facilis. Quibusdam nostrum ea.	3	15	15	2017-09-13 12:47:32.008919	2017-09-13 12:47:32.019963	0	\N	accepted	2017-09-13 12:47:32.001679	{"ca": "Earum odio esse veritatis quia voluptas ipsa accusantium et iure unde est.", "en": "Suscipit veniam dolores eum voluptas aperiam dolores blanditiis enim odio sed.", "es": "Illo est soluta aliquid sint pariatur ad voluptate et asperiores."}	Jr.-PROP-2017-09-17	\N	\N	\N
18	Deserunt ut possimus quos dolore asperiores.	A temporibus alias laboriosam excepturi autem. Aut omnis consequatur eius. Et tenetur sint possimus necessitatibus reiciendis. Laboriosam architecto impedit. Dolor tenetur aliquid vero hic.\nMolestiae consequatur architecto. Qui molestias corporis non dolorem alias neque placeat. Ipsam et consectetur quia voluptatibus facere.	3	47	15	2017-09-13 12:47:32.061383	2017-09-13 12:47:32.073476	0	\N	accepted	2017-09-13 12:47:32.053646	{"ca": "Voluptatem qui velit iste ea vel culpa voluptas quo vel.", "en": "Odio nam eum labore velit reiciendis tempore soluta doloremque esse nobis.", "es": "Veniam dolorem enim qui eos amet qui tempora natus repellendus ratione est sit."}	Jr.-PROP-2017-09-18	\N	\N	\N
22	Eum nihil in iure et illo debitis.	Sint placeat reiciendis. Mollitia quae labore laudantium deleniti. Error rerum velit ipsa.\nSed qui voluptatem consequatur perferendis. Repellat eligendi ut pariatur accusamus quas. Quia non doloribus. Dolorem voluptatibus est itaque omnis exercitationem.	9	48	12	2017-09-13 12:47:42.321045	2017-09-13 12:47:42.334467	0	\N	\N	2017-09-13 12:47:42.311151	\N	Jr.-PROP-2017-09-22	\N	\N	\N
19	Et et veritatis est.	Eum officia voluptas eos. Voluptates accusamus sint molestiae. Rerum eaque ullam.\nIncidunt dolor perspiciatis. Dolor autem ut. Inventore vitae corrupti sed.	3	25	15	2017-09-13 12:47:32.131723	2017-09-13 12:47:32.144942	1	\N	accepted	2017-09-13 12:47:32.122554	{"ca": "Est velit quidem impedit eum similique aut molestiae optio numquam quia.", "en": "Enim eos ut iste commodi nam eius quia impedit mollitia voluptates.", "es": "Recusandae dicta vel architecto pariatur cum tempora officia sed maxime id commodi nihil beatae."}	Jr.-PROP-2017-09-19	\N	\N	\N
133	Test de test par catégorie	Test de test par catégorie	42	331	\N	2017-09-18 05:45:30.917918	2017-09-18 05:45:31.107935	0	\N	\N	\N	\N	cndp-PROP-2017-09-133	\N	\N	\N
20	Velit ullam beatae ut.	Expedita incidunt autem est quo temporibus corporis qui. Quia sit aut quia porro consequatur. Aut doloremque eum voluptate ducimus quas expedita. Nobis inventore in.\nUt accusantium quia nihil dolorem sunt. Vel perferendis et labore delectus dolorem. Minima iure officiis.	3	42	15	2017-09-13 12:47:32.449176	2017-09-13 12:47:32.463873	1	\N	accepted	2017-09-13 12:47:32.441869	{"ca": "Rerum tempore autem itaque aspernatur quis omnis est totam perferendis.", "en": "Cum mollitia tempora voluptatem amet est quo enim aut labore accusamus eveniet nesciunt quam facilis.", "es": "Omnis eaque et sunt et tempore eos aliquid alias earum voluptatibus reprehenderit incidunt consequatur omnis."}	Jr.-PROP-2017-09-20	\N	\N	\N
21	Voluptatem illo ex animi eligendi.	Nostrum incidunt nemo commodi. Saepe autem voluptate ut quibusdam aliquid. Quo eum ipsa omnis perspiciatis. Totam et aliquid beatae perferendis nobis.\nSed esse vero est laborum commodi. Inventore architecto voluptatibus totam a minus. Rerum eaque qui. Tenetur reprehenderit non nobis. Et dolores aliquid maiores libero.	9	81	12	2017-09-13 12:47:42.212606	2017-09-13 12:47:42.225839	0	\N	\N	2017-09-13 12:47:42.203361	\N	Jr.-PROP-2017-09-21	\N	\N	\N
26	Aut non blanditiis consequatur corporis doloremque pariatur.	Eum enim repellat inventore ut in iste. Earum distinctio recusandae consequatur non consequatur. Eligendi consequatur ipsa esse quod eius vel.\nIure laudantium blanditiis hic consequatur dolores dolorem. Dignissimos illum quos repellendus alias non. Distinctio voluptas sed non quod praesentium. Id voluptatem adipisci. Illo veniam excepturi est dicta expedita.	9	51	12	2017-09-13 12:47:43.97127	2017-09-13 12:47:43.982229	2	\N	\N	2017-09-13 12:47:43.964192	\N	Jr.-PROP-2017-09-26	\N	\N	\N
23	Quia ipsum.	Rerum aut inventore officiis corporis eum. Et consequatur est. Exercitationem aspernatur sed minus. Deleniti eum possimus fuga fugit corporis blanditiis.\nPraesentium velit iure. A consequatur itaque et autem ea laboriosam numquam. Et doloribus adipisci dolorum dolores aliquid. Dolor reiciendis voluptas eos velit temporibus veritatis.	9	69	12	2017-09-13 12:47:42.435727	2017-09-13 12:47:42.446718	2	\N	\N	2017-09-13 12:47:42.428311	\N	Jr.-PROP-2017-09-23	\N	\N	\N
204	Test de test parce que test	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque iaculis erat a lobortis faucibus. Proin eleifend eleifend urna, vel auctor sapien aliquam sit amet. Vestibulum faucibus dictum orci, quis pulvinar nulla ultricies ut. Fusce eget feugiat sapien. Maecenas faucibus, odio eget molestie vestibulum, arcu velit accumsan ligula, quis blandit nisi neque nec leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius, metus id venenatis feugiat, est lacus ultrices ex, vel iaculis neque dolor non nisl. Curabitur lectus augue, vulputate a cursus nec, fringilla sit amet augue.\r\n\r\nNam ex enim, varius id velit vitae, iaculis consectetur felis. Phasellus sit amet vehicula massa. Curabitur quam lorem, auctor ut vulputate eget, dignissim ut odio. Suspendisse tincidunt semper eros id hendrerit. Phasellus id eros scelerisque, consequat libero eu, egestas orci. Quisque vestibulum diam ut sodales tristique. In aliquet metus dolor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Maecenas imperdiet odio sed ex viverra, ac maximus mi mollis. Pellentesque quis mauris nulla. Aenean id semper arcu. Vestibulum at lacus ut leo facilisis volutpat non quis purus. Maecenas dolor diam, pulvinar id metus eu, faucibus interdum mi.\r\n\r\nDuis placerat ultricies odio et condimentum. Aenean in dolor eget diam cursus sodales. Phasellus tempus pulvinar libero, a suscipit magna. Vestibulum eleifend felis a metus dignissim rhoncus. Donec vitae purus eget tortor ornare ultrices ac in eros. Mauris accumsan, ante eget iaculis vehicula, quam nisl aliquet mi, eget finibus metus purus et odio. Donec vel dapibus ligula. Cras mollis, metus et scelerisque viverra, tellus nisi iaculis justo, et molestie lacus ante sed purus. Fusce sit amet urna nec tortor pharetra dictum. Integer tempor blandit orci sit amet pellentesque. Praesent semper justo id ligula venenatis mollis. Proin aliquam orci diam, vel blandit ante pellentesque in. Nulla commodo dignissim tellus, vitae elementum metus vestibulum non. Etiam molestie elit vel leo consequat, et dignissim neque tristique. Mauris in rhoncus arcu. Ut porta leo quis bibendum vestibulum.\r\n\r\nNunc ultricies lacus eget urna iaculis, sed interdum nulla sollicitudin. Cras ultricies neque urna, sit amet rhoncus ante laoreet ut. Donec rutrum, sem eget finibus accumsan, purus arcu laoreet dui, sed tincidunt nunc elit eu enim. Praesent ac dui suscipit, vestibulum libero eget, finibus ligula. Quisque finibus elit sit amet ante blandit vehicula. Mauris aliquam enim nec rutrum euismod. Sed id lectus in augue consequat imperdiet ut at quam. Donec condimentum urna vitae est tincidunt, porta fermentum est vestibulum. Proin lobortis quam sed nunc fermentum, suscipit vestibulum ligula fermentum. Aliquam lacus nibh, dignissim non nunc at, dapibus accumsan orci. Nullam vel massa ut turpis porta fringilla.\r\n\r\nSuspendisse finibus, nisl at iaculis hendrerit, erat libero pulvinar nisl, in congue felis turpis eu nisl. Nulla facilisi. Duis ac mi sed turpis tempor rutrum. Nulla velit diam, iaculis eget eros eget, scelerisque iaculis quam. Sed feugiat consequat venenatis. Praesent at lobortis sapien. Morbi ut pharetra leo. Vivamus dapibus ante quis nulla fringilla bibendum. Integer ut felis euismod, eleifend neque in, euismod lacus.\r\n\r\nDonec blandit aliquet lectus sed cursus. Vestibulum ultricies, mauris sed tincidunt eleifend, erat nisl porttitor ex, nec finibus purus lorem ut libero. Phasellus elit tellus, facilisis ullamcorper nisi tincidunt, egestas rutrum libero. Suspendisse tempus mauris id leo gravida, eu rhoncus augue fermentum. Nunc massa nulla, imperdiet eget lorem sed, ornare consectetur enim. Aenean efficitur, est quis luctus luctus, arcu turpis congue nulla, eget varius sem arcu dapibus augue. Nulla nunc odio, sollicitudin sit amet finibus ut, faucibus at ipsum. Nulla tempor libero et metus pharetra tincidunt.\r\n\r\nDonec et erat non augue ultricies pretium. Duis sed tortor nisl. Aenean quis neque sed eros laoreet porttitor tincidunt quis ipsum. Nunc euismod auctor mauris, sed finibus nunc fermentum nec. Morbi sagittis quam in eleifend lacinia. Vivamus tristique leo eget felis consectetur accumsan. Cras aliquam, nulla nec hendrerit luctus, neque purus pellentesque nisi, vel volutpat dui diam sit amet lorem. Maecenas ut sollicitudin mauris. Nam faucibus faucibus scelerisque. Suspendisse ullamcorper at leo in aliquet. Cras id velit suscipit felis vulputate imperdiet nec sed nisi. Proin eleifend eget nisi ut rutrum.\r\n\r\nPhasellus posuere condimentum suscipit. Maecenas tristique dictum commodo. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque non eros eu sapien facilisis consequat et eu nisi. Donec molestie dignissim rutrum. Maecenas vestibulum elit euismod ipsum bibendum eleifend. Integer ultrices convallis enim, vel fringilla lectus sodales imperdiet. Aenean sed orci ultrices quam bibendum eleifend. Nulla lacinia vehicula est, vel ornare magna aliquam in.\r\n\r\nMaecenas iaculis orci aliquam vulputate porta. Etiam vulputate nulla nisl, vel finibus nunc porta vel. Integer pretium risus quis fermentum cursus. Donec sit amet quam vehicula, tristique lacus condimentum, vestibulum sapien. Sed vestibulum sapien nec finibus imperdiet. Duis tempor, orci volutpat euismod porta, urna magna interdum quam, et faucibus leo turpis eu nisl. Ut faucibus elit metus, eget rhoncus lorem laoreet ac. Pellentesque finibus, nisl eget consectetur egestas, nibh felis commodo ante, non ullamcorper mauris urna non nunc. Aenean eu mauris augue. Nullam eu ligula auctor nulla dignissim fermentum. Donec auctor, dolor nec rutrum tristique, quam magna posuere velit, et blandit odio libero vitae ipsum. Morbi erat turpis, cursus sit amet ultricies eu, pulvinar in ante. Nunc vel cras amet.	52	358	\N	2017-10-24 16:30:09.52723	2017-10-24 16:30:09.724681	0	\N	\N	\N	\N	cndp-PROP-2017-10-204	\N	\N	\N
249	Ceci est une question	Ceci est une question, peut-on la publier dans les Q/R ?	52	402	\N	2017-11-14 09:03:45.147234	2017-11-14 09:03:45.260168	0	\N	\N	\N	\N	cndp-PROP-2017-11-249	\N	\N	\N
24	At velit voluptatem.	Minus saepe labore quasi et cupiditate. Exercitationem et dignissimos earum veritatis. Ut sequi sit cupiditate saepe voluptate.\nNon nesciunt odit. Officia itaque quae voluptate. Est eum nemo nesciunt amet. Aut possimus ducimus illo vitae tempora.	9	32	12	2017-09-13 12:47:42.943381	2017-09-13 12:47:42.953459	2	\N	\N	2017-09-13 12:47:42.936419	\N	Jr.-PROP-2017-09-24	\N	\N	\N
25	Ratione sed ex ut minus.	Praesentium in ut excepturi. Ad consequuntur minima. Exercitationem quidem minima in nam debitis. Fugiat facilis enim eum iste et. Itaque adipisci repellendus architecto ut.\nMolestias modi facilis aut. Id aut quo et. Repellendus debitis non neque.	9	43	12	2017-09-13 12:47:43.466272	2017-09-13 12:47:43.477473	2	\N	\N	2017-09-13 12:47:43.458496	\N	Jr.-PROP-2017-09-25	\N	\N	\N
29	Dolores dolores ducimus magni odit voluptatem occaecati.	Nemo dolorum cum nesciunt. Asperiores quo labore. Quod minima doloribus dignissimos veritatis fugit praesentium. Et qui quae. Ducimus commodi harum omnis tempore possimus.\nSimilique ad dolore animi in tenetur et. Neque at quae. Repudiandae a molestiae ut qui et consequatur vel. Illo explicabo vel ducimus amet. Eos est quia nihil totam qui voluptas vitae.	9	69	12	2017-09-13 12:47:45.406888	2017-09-13 12:47:45.419523	0	\N	evaluating	2017-09-13 12:47:45.39875	\N	Jr.-PROP-2017-09-29	\N	\N	\N
27	Adipisci libero nesciunt eos.	Dolores ullam aut. Sapiente quis laborum culpa dolor. Eum et alias. Commodi autem aperiam totam dolorem omnis quas.\nNeque et voluptas consectetur quia cupiditate. In quos omnis dolor ut. Blanditiis distinctio suscipit aperiam cupiditate et odio.	9	67	12	2017-09-13 12:47:44.50017	2017-09-13 12:47:44.510551	2	\N	\N	2017-09-13 12:47:44.492854	\N	Jr.-PROP-2017-09-27	\N	\N	\N
28	Fugiat voluptate nam molestiae.	Temporibus illum consectetur velit. Autem nihil voluptatum rem unde aut ullam. Ad ipsum tempore. Consequuntur eveniet non voluptatibus voluptatem vel id. Ratione ipsa natus accusantium quis eligendi molestias.\nAperiam et et dolor. Doloremque neque repellendus fugiat et. Architecto aspernatur quas vitae.	9	58	12	2017-09-13 12:47:45.057844	2017-09-13 12:47:45.070063	1	\N	evaluating	2017-09-13 12:47:45.049334	\N	Jr.-PROP-2017-09-28	\N	\N	\N
30	Harum corrupti sunt at.	Blanditiis sed autem enim magnam neque a dolor. Magnam aliquam ut ipsa qui sequi repudiandae. Pariatur deserunt at quam nihil. Totam officiis ipsa aliquam quo.\nNam molestiae deleniti tempore excepturi est. Nam est rem. Et est ipsa eum repudiandae quis.	9	66	12	2017-09-13 12:47:45.478182	2017-09-13 12:47:45.492816	2	\N	evaluating	2017-09-13 12:47:45.463815	\N	Jr.-PROP-2017-09-30	\N	\N	\N
72	Aut quia quia.	Aut nulla consequuntur expedita temporibus. Deleniti vel tempore eos voluptatum ab. Non numquam eius.\nConsequatur ipsam quo sed dolor et dolores tempora. Dolores deserunt nesciunt animi unde rerum. Rerum dolore numquam vel tenetur.	21	181	12	2017-09-13 12:48:20.530299	2017-09-13 12:48:20.541669	1	\N	rejected	2017-09-13 12:48:20.522911	\N	Jr.-PROP-2017-09-72	\N	\N	\N
31	Non omnis excepturi vel.	Excepturi pariatur molestias ipsam ipsa praesentium magnam. Sint est quibusdam voluptates. Dolor reprehenderit nihil minus ut. Aut cumque ut repellat quo ullam quasi. Ratione perferendis iure ipsam voluptatem est harum.\nEt natus nihil voluptates qui iure autem suscipit. Expedita odio hic dolore ut fugiat alias fuga. Omnis ipsum debitis dolores architecto quae dolorem.	9	52	12	2017-09-13 12:47:45.961535	2017-09-13 12:47:45.971826	1	\N	rejected	2017-09-13 12:47:45.954581	\N	Jr.-PROP-2017-09-31	\N	\N	\N
32	Veniam quam perferendis officia cupiditate.	Autem earum porro dolores. Eius quasi ullam placeat dolore perspiciatis delectus expedita. Inventore consectetur commodi itaque eligendi non repudiandae. Minus sed eveniet vero ducimus et sed.\nDoloremque numquam debitis voluptatum perspiciatis error modi. Velit aspernatur dolorem voluptates voluptas. Nulla dolores sequi est deleniti fugiat repellat.	9	61	12	2017-09-13 12:47:46.343709	2017-09-13 12:47:46.371675	0	\N	rejected	2017-09-13 12:47:46.329453	\N	Jr.-PROP-2017-09-32	\N	\N	\N
39	Quasi molestiae quo at.	Officiis iste vero necessitatibus vitae quod velit provident. Enim dignissimos qui sit voluptatem est et eius. Voluptatem sit quas harum quia. Quibusdam ipsa ut dignissimos laborum.\nRepellat accusamus esse et autem deserunt. Dolor nihil est illum iusto ut ratione. Asperiores nam sint odio modi. Provident expedita aut ratione quidem. Earum doloribus non mollitia.	9	62	12	2017-09-13 12:47:49.059983	2017-09-13 12:47:49.073827	1	\N	accepted	2017-09-13 12:47:49.051899	{"ca": "Repellendus eius similique consequatur corrupti expedita commodi quia consectetur nesciunt quisquam sint.", "en": "Quaerat iusto suscipit perferendis est occaecati aut consequuntur eos nobis vitae iste reiciendis.", "es": "Ullam dolores exercitationem sed a consectetur possimus velit qui doloribus et laudantium itaque in enim."}	Jr.-PROP-2017-09-39	\N	\N	\N
33	Sed sit.	Et rerum qui dolorem. Aliquid inventore praesentium. Optio non et eveniet adipisci. Eligendi qui corrupti beatae non inventore. Praesentium et repellat quidem sapiente sequi est dolor.\nConsequuntur commodi consequatur ex debitis quae magni. Officia sint facere molestias. Itaque maiores ullam.	9	3	12	2017-09-13 12:47:46.43195	2017-09-13 12:47:46.451198	2	\N	rejected	2017-09-13 12:47:46.417363	\N	Jr.-PROP-2017-09-33	\N	\N	\N
34	Sit aspernatur.	Voluptas et sint voluptatem error est. Ratione aut ducimus totam eius quis est. Expedita et et dicta fugit. Id non in ut aspernatur perferendis sapiente accusantium. Dicta veniam molestias fugit ut deserunt non eaque.\nVoluptatem consequatur vero fuga. Qui qui sed. Quos pariatur occaecati. Earum unde amet.	9	37	12	2017-09-13 12:47:47.067383	2017-09-13 12:47:47.078985	2	\N	rejected	2017-09-13 12:47:47.059174	\N	Jr.-PROP-2017-09-34	\N	\N	\N
36	Maxime ipsa esse voluptatem ad.	Eveniet rerum distinctio quo. Est magni accusamus enim. Dolores voluptate quia laborum. Accusantium modi dolorum numquam quam velit cumque. Mollitia omnis totam quam est sit quaerat sint.\nRecusandae perspiciatis rem. Aliquam hic earum dolorem nisi nulla officiis eius. In exercitationem consequatur est non eos. Harum quos nesciunt amet ea voluptate ut dolorem.	9	88	12	2017-09-13 12:47:47.917547	2017-09-13 12:47:47.928261	2	\N	rejected	2017-09-13 12:47:47.910626	\N	Jr.-PROP-2017-09-36	\N	\N	\N
35	Dolor ipsa ut excepturi quo provident.	Nihil nostrum blanditiis magnam ut maxime omnis aut. Qui et reprehenderit dolores veniam magni. Soluta expedita aliquam magnam quaerat. Molestias dignissimos et. Doloribus corporis in rerum quidem.\nRerum non voluptatem quia ab magni molestiae. Error vel ducimus. Minima vitae laudantium ex esse suscipit.	9	49	12	2017-09-13 12:47:47.606207	2017-09-13 12:47:47.616999	1	\N	rejected	2017-09-13 12:47:47.596102	\N	Jr.-PROP-2017-09-35	\N	\N	\N
38	Repudiandae atque dicta delectus.	Laborum cupiditate numquam et impedit. Ab quas autem beatae aut natus. Reprehenderit laboriosam quis consectetur aspernatur incidunt et dolor.\nId veniam sit fugiat iure et vel ut. Qui dolorem ad quia quos ipsam voluptatum voluptas. Voluptatum eos dignissimos et doloribus voluptate. Et ut vel ut ipsum necessitatibus laboriosam. Eos officiis repellat.	9	33	12	2017-09-13 12:47:48.743444	2017-09-13 12:47:48.75547	1	\N	accepted	2017-09-13 12:47:48.73524	{"ca": "Nemo accusantium dolores veniam qui est sunt quos eaque facilis iure quo.", "en": "Pariatur tenetur et unde enim qui est quae vel id doloribus architecto dolore.", "es": "Optio nulla eaque a quos iste dolores occaecati maiores consectetur."}	Jr.-PROP-2017-09-38	\N	\N	\N
37	Sequi deleniti.	Eveniet quos dignissimos qui magni voluptates. Facere qui asperiores et enim tenetur. Quia sit nulla dolore sed distinctio laudantium. Tenetur aliquid et aut magni.\nEt sit ducimus provident. Delectus autem voluptatem. Modi facilis qui aspernatur assumenda. Eos sed nisi illo provident consectetur cupiditate maiores.	9	39	12	2017-09-13 12:47:48.411136	2017-09-13 12:47:48.423972	1	\N	accepted	2017-09-13 12:47:48.40309	{"ca": "Nihil numquam provident ratione tempora nisi et dolores sed mollitia sunt facilis iste.", "en": "Quasi magnam commodi aut doloribus eos ut voluptatem quis quas non veniam.", "es": "Hic est quia dignissimos pariatur molestias saepe cumque dolorem qui qui rerum sed et voluptatibus."}	Jr.-PROP-2017-09-37	\N	\N	\N
40	Molestiae illo debitis commodi voluptas.	Quis laborum iusto possimus omnis. Et tenetur et fugit voluptatum labore possimus. Impedit molestiae et sed id. Corporis nihil optio velit. Similique quis officiis.\nPariatur recusandae non voluptates praesentium hic deleniti ut. Hic enim suscipit accusamus eum ipsam est. Qui dolore dolorem fugit illo necessitatibus qui. Ullam dolore distinctio in. Quas in doloribus officiis ad quis voluptatem.	9	54	12	2017-09-13 12:47:49.422147	2017-09-13 12:47:49.440259	1	\N	accepted	2017-09-13 12:47:49.409842	{"ca": "Corporis ab nihil culpa velit accusamus deserunt dicta reiciendis numquam aut in ea omnis itaque.", "en": "Possimus qui maxime sed aut voluptatem deleniti excepturi sit modi fugiat dolor unde.", "es": "Non sit nam voluptatibus omnis enim molestias exercitationem aut ipsa et."}	Jr.-PROP-2017-09-40	\N	\N	\N
41	Itaque ipsum inventore quidem et asperiores.	Quam tenetur quia repellendus ut sint molestiae delectus. Dolores magni voluptatum. Consequatur reprehenderit dolores et. Et ipsam atque architecto at.\nNumquam quibusdam eum sit aut adipisci aliquid. Accusantium esse eligendi illum inventore impedit ratione. Reprehenderit saepe est voluptatem sint. Nostrum voluptas architecto voluptate porro.	15	74	13	2017-09-13 12:47:58.725839	2017-09-13 12:47:58.739818	2	\N	\N	2017-09-13 12:47:58.718093	\N	Jr.-PROP-2017-09-41	\N	\N	\N
43	Ullam illo vel tempora cum.	Error ipsa optio perspiciatis. Adipisci eveniet ut. Fuga aliquam et itaque tempora fugit accusamus laborum. Doloremque delectus fugiat quo ipsam est velit. In non et libero cum neque ut amet.\nEveniet voluptas facilis. Sint non numquam. Quisquam temporibus excepturi cupiditate sint et numquam modi.	15	33	16	2017-09-13 12:47:59.632736	2017-09-13 12:47:59.649871	0	\N	\N	2017-09-13 12:47:59.621448	\N	Jr.-PROP-2017-09-43	\N	\N	\N
42	Quas et dolores vel voluptas.	Culpa ducimus nulla aut. Tempora nihil sed omnis. Illum veniam consequatur quidem. Et corporis doloremque suscipit. Autem fuga impedit quo commodi voluptas.\nEst dignissimos sit omnis. Aliquam in sequi et explicabo. Veritatis velit nisi est sunt minus dignissimos. Eos possimus tempore. Modi minima vero accusantium nihil est sapiente.	15	105	7	2017-09-13 12:47:59.253118	2017-09-13 12:47:59.26563	1	\N	\N	2017-09-13 12:47:59.243728	\N	Jr.-PROP-2017-09-42	\N	\N	\N
55	Rem magnam quas sunt saepe sit possimus.	Reprehenderit quia sed eaque. Aut voluptatibus dolores vel neque omnis et. Odit quae qui amet. Ratione aspernatur rerum quia. Veritatis at et.\nEos et ipsam voluptate in quaerat consequuntur similique. Vel maxime vero dolorum. Sit dolor sequi eveniet assumenda ad eaque nihil. Facere aut possimus provident est dolores rerum.	15	104	\N	2017-09-13 12:48:04.743225	2017-09-13 12:48:04.755688	2	\N	rejected	2017-09-13 12:48:04.734203	\N	Jr.-PROP-2017-09-55	\N	\N	\N
44	Quia nemo temporibus.	Adipisci voluptatem incidunt in. Quis possimus et omnis est ut praesentium. Quia quidem in qui iste. Autem amet ab eum sint et. Quia corrupti reprehenderit facilis ut.\nRerum enim dolores velit eaque. Quis rerum cumque soluta dolorem et fugiat. Cumque minus laboriosam maiores expedita quisquam distinctio nostrum.	15	9	14	2017-09-13 12:47:59.759137	2017-09-13 12:47:59.771882	1	\N	\N	2017-09-13 12:47:59.749859	\N	Jr.-PROP-2017-09-44	\N	\N	\N
49	Nemo nihil omnis.	Odio magni nemo quam eos non commodi. Dolores omnis eos nihil. A est quo consequuntur consequatur. Et mollitia possimus voluptatem ab dolores. Sed non nulla.\nQuibusdam non debitis omnis sint. Numquam eveniet harum ut similique reprehenderit est. Optio numquam omnis alias et culpa rem est. Magnam est voluptas minus soluta quia eius amet. Nesciunt perferendis ut porro.	15	54	\N	2017-09-13 12:48:01.515888	2017-09-13 12:48:01.532405	1	\N	evaluating	2017-09-13 12:48:01.505489	\N	Jr.-PROP-2017-09-49	\N	\N	\N
109	Non magnam laudantium.	Voluptas deserunt aperiam harum. Est consequatur quidem vero aliquid nemo eius illo. Et qui ea aspernatur velit.\nIn ducimus illum nesciunt. Blanditiis expedita eligendi qui fuga doloremque eos nostrum. Et ratione est dicta occaecati ut. Corporis iure omnis.	33	137	3	2017-09-13 12:48:51.068066	2017-09-13 12:48:51.088884	1	\N	evaluating	2017-09-13 12:48:51.060639	\N	Jr.-PROP-2017-09-109	\N	\N	\N
45	Voluptates sit voluptas exercitationem ad.	Dolorem non quibusdam omnis ea numquam. Sunt et ea incidunt in est quidem. Sed consequuntur porro.\nSit aut voluptas eaque non assumenda officiis. Eum maxime officiis animi ut. Suscipit expedita veritatis nihil. Eveniet et porro doloremque. Pariatur accusantium praesentium.	15	72	\N	2017-09-13 12:48:00.103577	2017-09-13 12:48:00.112577	2	\N	\N	2017-09-13 12:48:00.097403	\N	Jr.-PROP-2017-09-45	\N	\N	\N
46	Accusantium ducimus veniam et nisi inventore ad.	Placeat itaque quia est aspernatur quod. Voluptas expedita laboriosam qui. Corrupti hic aut et quidem asperiores. Laborum quia qui eum. Culpa velit quo est.\nFacere necessitatibus sapiente in ea corrupti nihil sunt. Eveniet temporibus odio aspernatur quidem assumenda veritatis. Commodi voluptatibus blanditiis. Consequuntur dolores vel. Dolorum itaque expedita.	15	138	\N	2017-09-13 12:48:00.685812	2017-09-13 12:48:00.696434	1	\N	\N	2017-09-13 12:48:00.677491	\N	Jr.-PROP-2017-09-46	\N	\N	\N
52	Et commodi minus.	Possimus fugit et recusandae quia modi. Id non aut deserunt dolore. Tempore possimus excepturi qui dolores sed sit. Omnis et sint. Et eum nemo.\nEius voluptatum expedita tempore. Nobis voluptatum amet unde omnis eveniet. Aut et labore. Et doloribus corrupti quasi modi sunt.	15	22	\N	2017-09-13 12:48:03.206774	2017-09-13 12:48:03.22199	1	\N	rejected	2017-09-13 12:48:03.198573	\N	Jr.-PROP-2017-09-52	\N	\N	\N
47	Officia et.	Quisquam sapiente maxime dolor. Quia at unde sed. Magnam et qui. Rem quia in sunt vel. Eos id ipsum magni voluptatem ullam repudiandae.\nVoluptate nulla debitis eius alias qui maiores. Quaerat omnis veritatis sunt. Sit tempora fugiat adipisci in quod cupiditate dolor. Voluptas laborum et debitis. At sint sed reiciendis eius tempora.	15	154	1	2017-09-13 12:48:01.039588	2017-09-13 12:48:01.061541	1	\N	\N	2017-09-13 12:48:01.030674	\N	Jr.-PROP-2017-09-47	\N	\N	\N
48	Qui optio et.	Ut error qui quia et. Qui tenetur sed dicta eos. Ab velit dolorem deserunt occaecati quasi quia ratione. Maxime maiores inventore. Accusantium deserunt modi.\nMaiores ea eligendi minus. Laboriosam illum reiciendis. Deleniti dolor enim. Ducimus reiciendis cupiditate dolores id expedita aliquid id. Ut laudantium ipsa ea reiciendis dolor error exercitationem.	15	148	\N	2017-09-13 12:48:01.361848	2017-09-13 12:48:01.37558	0	\N	evaluating	2017-09-13 12:48:01.353199	\N	Jr.-PROP-2017-09-48	\N	\N	\N
50	Repellendus illum tempora quia.	Sequi velit cupiditate quia est autem. In et atque ut cum odit autem. Optio id minima officiis. Impedit atque in pariatur provident autem veritatis et.\nQuia omnis minus consequatur. Id non repudiandae eos similique porro nulla. Vero excepturi ea cumque consequatur.	15	158	9	2017-09-13 12:48:01.976492	2017-09-13 12:48:01.991834	2	\N	evaluating	2017-09-13 12:48:01.968144	\N	Jr.-PROP-2017-09-50	\N	\N	\N
51	Tempora ducimus nisi ex et.	Ut omnis enim perspiciatis blanditiis. Et quia et possimus facilis. Beatae voluptatibus eius maiores quia aperiam. Tenetur praesentium soluta et libero tempora.\nBeatae voluptas repudiandae quo ut est. Inventore voluptas magnam nesciunt molestiae. Sunt suscipit temporibus aut et deleniti. Libero aut qui aut non. Dolor totam eum accusantium aut tempore.	15	94	\N	2017-09-13 12:48:02.599418	2017-09-13 12:48:02.611221	2	\N	rejected	2017-09-13 12:48:02.587725	\N	Jr.-PROP-2017-09-51	\N	\N	\N
53	Ut pariatur dolorum sunt reiciendis dolore.	Quas assumenda voluptas. Ea esse enim eligendi autem consequatur. Aut dolorem natus omnis ut. Omnis natus eligendi praesentium hic. Non tempora debitis ullam aperiam.\nAut et veritatis dolorem magnam officia. Alias aliquam mollitia doloremque error sit vero. Nostrum est id culpa. Ut necessitatibus accusamus mollitia iste. Earum nam alias voluptatem.	15	138	2	2017-09-13 12:48:03.542821	2017-09-13 12:48:03.558866	2	\N	rejected	2017-09-13 12:48:03.53387	\N	Jr.-PROP-2017-09-53	\N	\N	\N
54	Quas veritatis sunt excepturi.	Est voluptatem similique ut libero vel qui quod. Aut incidunt at veniam. Esse error optio.\nLaborum voluptates aut ipsam adipisci ut. Velit molestiae ipsam eos alias occaecati ut. Quo et atque.	15	26	\N	2017-09-13 12:48:04.096533	2017-09-13 12:48:04.110887	2	\N	rejected	2017-09-13 12:48:04.089082	\N	Jr.-PROP-2017-09-54	\N	\N	\N
56	Soluta ut.	Cumque mollitia sunt consequuntur. Et mollitia sed sapiente delectus id aut. Amet dolore velit deleniti quia. Optio ut facere sit ducimus est.\nVeritatis atque quia accusamus qui culpa. Saepe et accusantium dolores. Voluptatem quas alias voluptatem nihil eum. Deserunt esse nulla.	15	102	14	2017-09-13 12:48:05.425106	2017-09-13 12:48:05.439333	1	\N	rejected	2017-09-13 12:48:05.414558	\N	Jr.-PROP-2017-09-56	\N	\N	\N
57	In fugiat.	Est et voluptatem deserunt. Quaerat corrupti aut vel velit reiciendis aliquid. Vel mollitia iste aut aut nam ea. Ex quis quo.\nDolor ut et esse delectus. Voluptas sequi rerum sint autem dignissimos deserunt blanditiis. Optio rerum quasi vel explicabo. Dolorem eos similique enim.	15	85	\N	2017-09-13 12:48:05.914628	2017-09-13 12:48:05.938262	1	\N	accepted	2017-09-13 12:48:05.896388	{"ca": "Voluptatem dolores in ipsam sit architecto quas dolores eius quod voluptas.", "en": "Ut ducimus sed commodi quo reiciendis sapiente velit suscipit voluptas.", "es": "Enim dignissimos itaque fuga sint et ut est ad qui quia dicta assumenda deleniti rerum."}	Jr.-PROP-2017-09-57	\N	\N	\N
73	Soluta et dignissimos aliquid eos.	Rerum repellat tempora odit. Labore laudantium est repudiandae atque voluptatem aut. Fugiat et consectetur enim est. Dolor debitis et cupiditate qui nobis ducimus enim. Fuga blanditiis et consequatur nulla error ut ut.\nModi et et tempore blanditiis consequatur. Quis tenetur adipisci. Quisquam animi quis aut voluptatem voluptas tenetur. Beatae eius voluptate perferendis at.	21	168	12	2017-09-13 12:48:20.888269	2017-09-13 12:48:20.899032	1	\N	rejected	2017-09-13 12:48:20.88125	\N	Jr.-PROP-2017-09-73	\N	\N	\N
58	Quia commodi voluptatibus.	Sit blanditiis sed mollitia velit. Nesciunt architecto aliquid pariatur eveniet quibusdam. Sit omnis voluptatem dolores ut possimus blanditiis quia. Voluptate hic doloribus unde. Aut vitae repellat dolore et ut earum.\nAlias amet eveniet dignissimos ad deserunt. Sint eos architecto non et omnis. Ut autem qui.	15	100	16	2017-09-13 12:48:06.381986	2017-09-13 12:48:06.394744	0	\N	accepted	2017-09-13 12:48:06.371468	{"ca": "Voluptas sit sed dolorum placeat ad eos magni omnis molestiae perferendis odit modi odio.", "en": "Repudiandae cumque dolores et et ut qui tenetur ducimus impedit nemo natus error eum pariatur.", "es": "Hic earum tempore voluptatem id dolor aut et sapiente est sint."}	Jr.-PROP-2017-09-58	\N	\N	\N
334	Mise en garde : Débat public de l’aménagement du Grand Port Maritime de Dunkerque : des contradictions en nombre	En cette fin 2017 se déroule un débat public sur un projet d’extension du port maritime de Dunkerque. Bien que la genèse du projet est très ancienne (années 60-70), le projet se doit de s’adapter au contexte actuel.\r\n\r\nAinsi un choix entre deux projets est présenté. Mais ce choix est-il encore bien à faire étant donné que de nombreux travaux ont déjà été menés et ne vont principalement que dans le sens du projet dit « Atlantique » ?\r\n\r\nN’existe-t-il pas une 3ème voie qui est de dire que le contexte géopolitique international ne permet pas de conclure dès aujourd’hui à un projet d’une telle ampleur mais plutôt à une extension limitée, mesurée et phasée permettant de limiter ainsi les nombreux impacts.\r\n\r\nLa question est de savoir quel héritage allons-nous laisser à notre zone littorale.\r\n\r\nNos élus se battent avec pugnacité en faveur de ce projet, mais ont-ils regardé l’impact à long terme, dans 20, 30 ou 40 ans quand les flux logistiques mondiaux auront grandement évolués et qu’il n’y en aura peut-être quasiment plus sur des longues distances. Quoique les spécialistes en disent, l’histoire et notamment l’histoire récente nous ont montrés qu’il très difficile, voire impossible de mettre une date en face des évolutions. Que ce soit les chocs pétroliers, ou la crise plus récente de 2008-2009, personne ne les avait prédits ni estimé une durée correcte. Aujourd’hui l’Asie tire son épingle du jeu, demain surement l’Amérique du sud et l’Afrique tout en revenant en même temps sur des productions plus locales avec les évolutions sociétales et environnementales. Est-ce que laisser des friches en nombres dans plusieurs décennies justifie un intérêt économique sur la décennie à venir ?\r\n\r\nQuels enjeux, il s’agit bien de cette question ? Un enjeu économique certains mais pour quelle durée et avec quels impacts pour le bassin dunkerquois ? Un nombre d’emploi direct et indirect non négligeable mais avec une proportion locale limitée. Il suffit de regarder les plaques des camions sur les routes pour se rendre compte que cela ne profite que très partiellement aux entreprises françaises. Autre point, le réseau routier et en particulier l’autoroute dite « l’Européenne » (A16) déjà saturée aujourd’hui – il suffit de voir les kilomètres de bouchons se formant en quelques minutes lors d’une neutralisation ne serait-ce que d’une seule voie pour travaux ou accident – et l’on veut encore augmenter radicalement le trafic ?\r\n\r\nSans compter la pollution atmosphérique qui ne fera qu’augmenter dans un bassin déjà très impacté et en particulier par la pollution industrielle. Même si nous avons la mer pour évacuer cette pollution, Dunkerque est déjà dans le haut du tableau sur les cas de nombreux cancers. Peut-être que sa position dans les différents classements n’est pas encore assez haute ?\r\n\r\nCôté industrie, Dunkerque comporte une concentration d’installations à risques (nucléaire, Seveso, installations classées, …). Indépendamment l’une de l’autre cela est maitrisé. Mais qu’en est-il de l’effet domino pouvant se produire lors d’incidents majeurs (pas forcément d’origine industrielle mais par exemple en cas d’attentat). Aucune étude publique ne reprend ce sujet. Faut-il encore densifier les zones à risques et en augmentant encore éventuellement ces risques ? Prions qu’un incident majeur n’arrive jamais.\r\n\r\nCôté environnement et biodiversité, outre les hectares pris à la nature, l’impact est loin d’être négligeable. Mais il est surement vrai que les espèces (oiseaux, petits mammifères et autres) connaissent à l’avance les projets du GPMD et se sont naturellement déplacées avant l’élaboration des études : Quasiment aucune espèce sensible n’a été recensée sur l’implantation du projet « Atlantique » mais pas contre il y en a bien tout autour ! La majorité des études de grande ampleur sur la biodiversité tire la sonnette d’alarme concernant l’impact de l’homme et l’avenir de ces espèces. En voici encore un bel futur exemple.\r\n\r\nBien qu’il s’agisse d’un débat, rien ne sert de poursuivre cette énumération puisque le choix semble déjà réalisé.\r\n\r\nMessieurs les décideurs, porteurs de projets, élus, c’est à vous de maitriser l’avenir de notre territoire, mais il faut le faire intelligemment et ne pas fuir ses responsabilités dans le futur.\r\n\r\nOui à une extension limitée et mesurée, non à extension de masse.\r\n\r\nFlorent L., loonois	52	358	\N	2017-11-24 11:23:06.635641	2017-11-24 11:23:07.177574	0	\N	\N	\N	\N	cndp-PROP-2017-11-334	\N	\N	\N
59	Doloribus fuga.	Velit consequatur perspiciatis labore assumenda. Eligendi necessitatibus asperiores. Sed placeat officiis perferendis et aspernatur et iusto. Eveniet modi voluptatem eligendi eos. Laboriosam dolor consequatur exercitationem debitis.\nVitae eaque repudiandae et non consectetur occaecati aliquam. Vitae doloremque itaque quia provident dolore ex. Omnis autem modi vero autem exercitationem expedita esse. Qui eveniet quis dolorem et itaque eos. Magni ad rem veniam voluptatibus ab aliquid.	15	49	\N	2017-09-13 12:48:06.518043	2017-09-13 12:48:06.531719	1	\N	accepted	2017-09-13 12:48:06.51091	{"ca": "Pariatur quasi dolore suscipit explicabo eos nulla sit ducimus aut qui itaque qui reiciendis quia.", "en": "Nesciunt quis sit in consequatur ab blanditiis expedita dolorem quia similique in excepturi aperiam.", "es": "Aut sit sed facere temporibus dolores esse tempore cumque repudiandae rerum."}	Jr.-PROP-2017-09-59	\N	\N	\N
61	Alias inventore et molestias rerum sunt.	Qui aut nostrum voluptatem tenetur. Minus nostrum ullam et. Delectus odio dolorem enim. Magni vero provident fuga aut ad.\nFuga et placeat aut. Nisi quis ratione pariatur. Adipisci sunt et repellendus voluptatem natus. Fugiat deleniti vero ducimus esse eum officiis.	21	82	12	2017-09-13 12:48:17.130369	2017-09-13 12:48:17.141726	2	\N	\N	2017-09-13 12:48:17.123049	\N	Jr.-PROP-2017-09-61	\N	\N	\N
60	Recusandae aut omnis ut doloremque.	Et dolorem facere repudiandae. Dolore quisquam dolores consequatur facilis. Quis tempora ratione suscipit praesentium reprehenderit. Blanditiis minima incidunt deleniti. Sit ullam maxime consequatur dolor.\nEt nam enim cupiditate nobis dolores molestiae harum. Voluptas facere sit doloribus harum eos. Omnis modi in. Consequatur iusto facilis deleniti deserunt.	15	32	7	2017-09-13 12:48:06.83941	2017-09-13 12:48:06.86497	2	\N	accepted	2017-09-13 12:48:06.826692	{"ca": "Suscipit magnam eligendi totam voluptatibus voluptatem eaque quo libero voluptates ipsum perspiciatis cupiditate tempore.", "en": "Dolore neque fugiat tempora laborum deserunt eaque non suscipit incidunt aut quas molestiae.", "es": "Possimus deserunt non quia temporibus mollitia aut necessitatibus rerum fuga tenetur neque."}	Jr.-PROP-2017-09-60	\N	\N	\N
64	Enim voluptas quis aut voluptatem quo.	Ex nisi maxime eligendi alias. Qui id aut. Omnis voluptatem et. Dolores quidem aut eum dolorem sit ea. Aut sint reiciendis non.\nImpedit et illo. Neque quo velit. Quae et aut eum porro. Qui et ut ex et pariatur non. Deserunt ea sed perspiciatis.	21	63	\N	2017-09-13 12:48:18.158201	2017-09-13 12:48:18.16716	2	\N	\N	2017-09-13 12:48:18.152465	\N	Jr.-PROP-2017-09-64	\N	\N	\N
62	Repudiandae amet sapiente.	Voluptas beatae iusto est est saepe. Ut quia quo pariatur consectetur fuga eos omnis. Tempore ut corrupti vitae sunt nesciunt. Facere quibusdam assumenda ratione distinctio qui. Ea et qui aliquam commodi qui omnis soluta.\nAmet explicabo recusandae id qui dolorem aperiam. Voluptatem sequi aspernatur corporis. Non vero ea est voluptatem excepturi omnis reprehenderit. At voluptas neque. Error minus est soluta ea eaque et cum.	21	178	\N	2017-09-13 12:48:17.749244	2017-09-13 12:48:17.766241	0	\N	\N	2017-09-13 12:48:17.742277	\N	Jr.-PROP-2017-09-62	\N	\N	\N
63	Inventore voluptatem repellendus rerum et dolores quo.	Sint et officia excepturi perferendis. Dolorem incidunt delectus voluptatem. Omnis enim voluptatem quas velit dolores facere.\nPraesentium sunt at est quaerat. Consequatur sit accusantium quod rem delectus reiciendis. Ab id incidunt nobis. Quo atque quidem eaque repellat eum numquam aut. Nam qui natus harum non nemo ducimus enim.	21	87	\N	2017-09-13 12:48:17.825259	2017-09-13 12:48:17.835499	1	\N	\N	2017-09-13 12:48:17.817734	\N	Jr.-PROP-2017-09-63	\N	\N	\N
65	Qui dolor soluta autem aliquam corporis.	Provident tenetur ipsam molestiae qui maxime temporibus sed. Unde laboriosam cum culpa reprehenderit amet. Ut ex non libero. Necessitatibus ex accusantium quo.\nVoluptas consequatur maxime ut ipsum. Eius quos placeat exercitationem id deserunt odio. Voluptas quasi dolores laboriosam ipsam. Commodi velit recusandae vero est.	21	112	\N	2017-09-13 12:48:18.625588	2017-09-13 12:48:18.635227	0	\N	\N	2017-09-13 12:48:18.619612	\N	Jr.-PROP-2017-09-65	\N	\N	\N
71	Sed debitis error at consequatur quibusdam numquam.	Sit id error alias et quidem. Laborum minus aut saepe amet modi. Ea rerum qui. Fugit iusto perspiciatis doloribus et aut nesciunt. Amet unde totam dolor praesentium vero ut.\nCorporis quidem rerum. Distinctio ea voluptatibus sed. Voluptatem nihil vel corporis fugit. Suscipit ab enim.	21	152	\N	2017-09-13 12:48:20.02522	2017-09-13 12:48:20.03436	2	\N	rejected	2017-09-13 12:48:20.019413	\N	Jr.-PROP-2017-09-71	\N	\N	\N
66	Occaecati commodi quae libero nulla ea.	Molestiae cumque voluptatem est quia corporis consequatur asperiores. Voluptatem natus eligendi voluptate. Facere officia asperiores. Inventore et quam autem architecto et debitis voluptatem.\nFacere ipsum laborum et molestiae expedita enim mollitia. Non id optio ut tempora aperiam est. Repellendus laborum hic a quisquam rem.	21	53	\N	2017-09-13 12:48:18.702677	2017-09-13 12:48:18.712894	1	\N	\N	2017-09-13 12:48:18.697086	\N	Jr.-PROP-2017-09-66	\N	\N	\N
67	Ut aspernatur optio earum suscipit beatae.	Earum repudiandae perferendis voluptatibus consequuntur fuga consectetur soluta. Est molestiae eum. Dolor vel temporibus voluptas sed quod voluptatem sit.\nBlanditiis sed cumque. Dolor harum tempore quidem. Aut mollitia est nam ut eligendi aliquid assumenda.	21	19	3	2017-09-13 12:48:18.987448	2017-09-13 12:48:18.998702	1	\N	\N	2017-09-13 12:48:18.979715	\N	Jr.-PROP-2017-09-67	\N	\N	\N
68	Voluptatem est dolorem sunt sed.	Harum rem laboriosam sed ab quia error atque. Nihil fuga dolorem voluptatem. Maiores quaerat ex impedit.\nVoluptates distinctio facere qui reprehenderit provident ullam. Doloremque quibusdam non aut aut cum inventore mollitia. Occaecati quo provident est.	21	137	\N	2017-09-13 12:48:19.3273	2017-09-13 12:48:19.336363	0	\N	evaluating	2017-09-13 12:48:19.321268	\N	Jr.-PROP-2017-09-68	\N	\N	\N
69	Voluptatem officiis qui aut ratione veniam quibusdam.	Sed id et. Aut ea modi beatae vel vero similique nostrum. Natus id quos dolorem. Architecto voluptas nihil similique corporis.\nVoluptatem nam quasi esse unde. Quod esse dolores adipisci sunt. Quo totam cumque minus esse laborum non. Rerum nihil voluptatibus soluta fugit vel consequatur aut.	21	61	\N	2017-09-13 12:48:19.384677	2017-09-13 12:48:19.396586	1	\N	evaluating	2017-09-13 12:48:19.373196	\N	Jr.-PROP-2017-09-69	\N	\N	\N
70	Nobis doloribus a velit in excepturi.	Sed placeat et veniam aut possimus laboriosam. Debitis qui sed voluptatem. Eos quis ducimus similique facilis sunt suscipit. Quo aspernatur provident ut veniam ipsa adipisci. Ab aut quia corrupti deleniti.\nQuaerat modi vel ullam a recusandae. Quia asperiores dolores sit excepturi quae quis. Nesciunt et sed. Dolore quam dolorum dolorem.	21	146	8	2017-09-13 12:48:19.695837	2017-09-13 12:48:19.70618	1	\N	evaluating	2017-09-13 12:48:19.688728	\N	Jr.-PROP-2017-09-70	\N	\N	\N
110	Id tempora omnis voluptatem.	Accusamus doloribus nesciunt. Dignissimos totam quam ab a omnis et. Labore beatae voluptas deleniti aliquam sit.\nCommodi vitae occaecati ut. Maxime esse pariatur ut non quos beatae. Autem veritatis illum soluta facilis nostrum fugiat rerum. Repudiandae odio architecto quo.	33	273	\N	2017-09-13 12:48:51.389985	2017-09-13 12:48:51.399502	0	\N	evaluating	2017-09-13 12:48:51.384123	\N	Jr.-PROP-2017-09-110	\N	\N	\N
74	Explicabo rerum dolores consequatur.	Sed repudiandae necessitatibus consequatur maxime enim. Quo laudantium minima tenetur rerum ipsa est enim. Provident cum alias officia et molestiae quidem.\nAssumenda unde voluptatem pariatur ipsa perferendis. Et sunt nostrum. Pariatur cum neque sint ea. Nemo praesentium laborum odit dolore natus.	21	20	\N	2017-09-13 12:48:21.215497	2017-09-13 12:48:21.229327	2	\N	rejected	2017-09-13 12:48:21.209314	\N	Jr.-PROP-2017-09-74	\N	\N	\N
111	Iure dolorem error.	Modi amet nisi. Ut in ipsum beatae libero quos. Voluptas quia dicta quam. Voluptatum labore repudiandae.\nQuia id rerum deserunt. Ut et sed ipsam. Ad dolores minima. Qui non autem.	33	116	\N	2017-09-13 12:48:51.560032	2017-09-13 12:48:51.570144	0	\N	rejected	2017-09-13 12:48:51.553232	\N	Jr.-PROP-2017-09-111	\N	\N	\N
92	Fugit nihil qui tempora iure nam.	Aliquam possimus optio reprehenderit est sit incidunt. Dolore et et impedit ipsa dolorem ipsam. Cum et reiciendis. Magnam repellat maxime quae laudantium. Voluptatibus maxime dolor asperiores labore eius dolorum mollitia.\nAssumenda rerum nam quia accusantium. Nobis maxime illo qui maiores consequatur aperiam sint. Enim voluptates labore. Tempore ut dolorum.	27	202	17	2017-09-13 12:48:36.5195	2017-09-13 12:48:36.538836	0	\N	rejected	2017-09-13 12:48:36.50975	\N	Jr.-PROP-2017-09-92	\N	\N	\N
75	Consequuntur et iure et voluptatem.	Soluta ut libero nostrum. Dolores ad cupiditate magnam qui. Nesciunt aut dolorem. Quo consectetur quis et debitis.\nDistinctio temporibus consequuntur beatae a. Blanditiis soluta aut. Similique ab explicabo. Expedita maiores quod nihil tempora cumque non. Molestiae non perferendis sint.	21	68	\N	2017-09-13 12:48:21.730552	2017-09-13 12:48:21.747614	1	\N	rejected	2017-09-13 12:48:21.721642	\N	Jr.-PROP-2017-09-75	\N	\N	\N
112	Est aut dolor.	Vel commodi aut quia voluptate aut. Esse incidunt eum nemo reprehenderit soluta et. Ut ea repellendus et quo voluptas. Repellendus accusamus perspiciatis qui cum at quam recusandae.\nQui libero ut iste aut. Non beatae fuga aut in. Consequatur et sint illo quos quo est vel. Id vitae quia ducimus occaecati error itaque. Ducimus optio suscipit vitae aliquid.	33	87	\N	2017-09-13 12:48:51.762284	2017-09-13 12:48:51.772671	0	\N	rejected	2017-09-13 12:48:51.755947	\N	Jr.-PROP-2017-09-112	\N	\N	\N
76	Rerum consequuntur.	Eum a voluptatem magni magnam. Voluptas quod excepturi dolor in est voluptate maiores. Harum veniam nemo veritatis asperiores.\nMaxime quis explicabo beatae modi. Labore id sunt atque. Et voluptatibus consequatur illo autem omnis.	21	204	\N	2017-09-13 12:48:22.080646	2017-09-13 12:48:22.089834	1	\N	rejected	2017-09-13 12:48:22.074932	\N	Jr.-PROP-2017-09-76	\N	\N	\N
129	Exemple de contribution 8	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	42	338	\N	2017-09-14 09:02:25.760767	2017-09-14 09:02:25.902958	0	\N	\N	\N	\N	cndp-PROP-2017-09-129	\N	\N	\N
77	Voluptatem repudiandae rerum facilis architecto non perspiciatis.	Exercitationem enim officiis possimus dolores aliquam cum. Molestiae consequuntur consequatur aspernatur enim. Est accusantium voluptatem atque totam et. Illo eius consequatur quo corrupti aperiam fugit.\nEst neque voluptate quia eaque qui impedit. Mollitia quidem id libero blanditiis aut laudantium et. Assumenda sed quae sit et et. Voluptas ullam odit sint. Delectus at doloremque voluptatem et amet.	21	43	4	2017-09-13 12:48:22.383791	2017-09-13 12:48:22.396311	2	\N	accepted	2017-09-13 12:48:22.374569	{"ca": "Maiores ipsum neque dolorum ea fuga tenetur assumenda nesciunt consequatur et sint suscipit tempora id.", "en": "Ratione aut perferendis minima in aliquid sed odit ab vero.", "es": "Et vel enim ut sint doloremque ab est explicabo quibusdam aut."}	Jr.-PROP-2017-09-77	\N	\N	\N
134	Test de test avec une catégorie	Test de test avec une catégorie	42	330	\N	2017-09-18 05:47:50.258311	2017-09-18 05:47:50.268771	0	\N	\N	\N	\N	cndp-PROP-2017-09-134	\N	\N	\N
93	Pariatur eum unde ut.	Dolor distinctio vitae accusantium maiores. Minus deleniti cum earum nihil nam aspernatur. Repellat quasi eius.\nQui officiis aut. Recusandae natus voluptatem. Autem sit quia quam pariatur nemo non. Necessitatibus molestiae natus cum accusamus.	27	222	14	2017-09-13 12:48:36.613033	2017-09-13 12:48:36.623867	2	\N	rejected	2017-09-13 12:48:36.60552	\N	Jr.-PROP-2017-09-93	\N	\N	\N
95	Odit sit eos.	Ut deleniti libero neque nesciunt tenetur fugiat quasi. Id explicabo facere illo. Vitae eligendi fugiat expedita quae et.\nSapiente impedit facere magnam. Ut unde omnis similique. Ea sit accusantium culpa debitis perspiciatis. Qui consequatur dignissimos laborum.	27	248	13	2017-09-13 12:48:37.702742	2017-09-13 12:48:37.721735	2	\N	rejected	2017-09-13 12:48:37.695459	\N	Jr.-PROP-2017-09-95	\N	\N	\N
335	Test d'une proposition 2	En cette fin 2017 se déroule un débat public sur un projet d’extension du port maritime de Dunkerque. Bien que la genèse du projet est très ancienne (années 60-70), le projet se doit de s’adapter au contexte actuel.\r\n\r\nAinsi un choix entre deux projets est présenté. Mais ce choix est-il encore bien à faire étant donné que de nombreux travaux ont déjà été menés et ne vont principalement que dans le sens du projet dit « Atlantique » ?\r\n\r\nN’existe-t-il pas une 3ème voie qui est de dire que le contexte géopolitique international ne permet pas de conclure dès aujourd’hui à un projet d’une telle ampleur mais plutôt à une extension limitée, mesurée et phasée permettant de limiter ainsi les nombreux impacts.\r\n\r\nLa question est de savoir quel héritage allons-nous laisser à notre zone littorale.\r\n\r\nNos élus se battent avec pugnacité en faveur de ce projet, mais ont-ils regardé l’impact à long terme, dans 20, 30 ou 40 ans quand les flux logistiques mondiaux auront grandement évolués et qu’il n’y en aura peut-être quasiment plus sur des longues distances. Quoique les spécialistes en disent, l’histoire et notamment l’histoire récente nous ont montrés qu’il très difficile, voire impossible de mettre une date en face des évolutions. Que ce soit les chocs pétroliers, ou la crise plus récente de 2008-2009, personne ne les avait prédits ni estimé une durée correcte. Aujourd’hui l’Asie tire son épingle du jeu, demain surement l’Amérique du sud et l’Afrique tout en revenant en même temps sur des productions plus locales avec les évolutions sociétales et environnementales. Est-ce que laisser des friches en nombres dans plusieurs décennies justifie un intérêt économique sur la décennie à venir ?\r\n\r\nQuels enjeux, il s’agit bien de cette question ? Un enjeu économique certains mais pour quelle durée et avec quels impacts pour le bassin dunkerquois ? Un nombre d’emploi direct et indirect non négligeable mais avec une proportion locale limitée. Il suffit de regarder les plaques des camions sur les routes pour se rendre compte que cela ne profite que très partiellement aux entreprises françaises. Autre point, le réseau routier et en particulier l’autoroute dite « l’Européenne » (A16) déjà saturée aujourd’hui – il suffit de voir les kilomètres de bouchons se formant en quelques minutes lors d’une neutralisation ne serait-ce que d’une seule voie pour travaux ou accident – et l’on veut encore augmenter radicalement le trafic ?\r\n\r\nSans compter la pollution atmosphérique qui ne fera qu’augmenter dans un bassin déjà très impacté et en particulier par la pollution industrielle. Même si nous avons la mer pour évacuer cette pollution, Dunkerque est déjà dans le haut du tableau sur les cas de nombreux cancers. Peut-être que sa position dans les différents classements n’est pas encore assez haute ?\r\n\r\nCôté industrie, Dunkerque comporte une concentration d’installations à risques (nucléaire, Seveso, installations classées, …). Indépendamment l’une de l’autre cela est maitrisé. Mais qu’en est-il de l’effet domino pouvant se produire lors d’incidents majeurs (pas forcément d’origine industrielle mais par exemple en cas d’attentat). Aucune étude publique ne reprend ce sujet. Faut-il encore densifier les zones à risques et en augmentant encore éventuellement ces risques ? Prions qu’un incident majeur n’arrive jamais.\r\n\r\nCôté environnement et biodiversité, outre les hectares pris à la nature, l’impact est loin d’être négligeable. Mais il est surement vrai que les espèces (oiseaux, petits mammifères et autres) connaissent à l’avance les projets du GPMD et se sont naturellement déplacées avant l’élaboration des études : Quasiment aucune espèce sensible n’a été recensée sur l’implantation du projet « Atlantique » mais pas contre il y en a bien tout autour ! La majorité des études de grande ampleur sur la biodiversité tire la sonnette d’alarme concernant l’impact de l’homme et l’avenir de ces espèces. En voici encore un bel futur exemple.\r\n\r\nBien qu’il s’agisse d’un débat, rien ne sert de poursuivre cette énumération puisque le choix semble déjà réalisé.\r\n\r\nMessieurs les décideurs, porteurs de projets, élus, c’est à vous de maitriser l’avenir de notre territoire, mais il faut le faire intelligemment et ne pas fuir ses responsabilités dans le futur.\r\n\r\nOui à une extension limitée et mesurée, non à extension de masse.\r\n\r\nFlorent L., loonois	52	358	\N	2017-11-24 12:20:24.478803	2018-01-04 11:06:17.394695	0	\N	evaluating	2018-01-04 11:06:17.383213	{"fr": "<p>Test de réponse</p>"}	cndp-PROP-2017-11-335	\N	\N	\N
94	Eos aliquid.	Nesciunt officiis perspiciatis ab accusamus odio dolor iure. Sequi et voluptatem consequatur aspernatur. Veritatis incidunt quo dolorem. Et fuga aspernatur sed. In ex aut provident repellat.\nVoluptate ratione sed voluptatem provident et molestias. Quia non dolor nostrum aut qui. Hic sit deleniti fugiat mollitia quia beatae. Et sunt beatae. Id temporibus vero eligendi dolorem facere ut.	27	234	14	2017-09-13 12:48:37.102831	2017-09-13 12:48:37.113751	2	\N	rejected	2017-09-13 12:48:37.095101	\N	Jr.-PROP-2017-09-94	\N	\N	\N
96	Aut asperiores enim recusandae accusantium molestias fuga.	Quidem sapiente iste ut. Repellendus molestiae laborum inventore quaerat quam praesentium qui. Repellendus quae magnam omnis voluptas omnis. A facilis ducimus dignissimos voluptatem ut veritatis.\nEnim amet aperiam placeat odit dolore eligendi. Laudantium aut libero voluptatem. Velit dolorum dicta id sit harum.	27	173	13	2017-09-13 12:48:38.226443	2017-09-13 12:48:38.237334	0	\N	rejected	2017-09-13 12:48:38.218872	\N	Jr.-PROP-2017-09-96	\N	\N	\N
97	Doloribus molestiae officiis ea dolor sed.	Quidem consequuntur aliquam aspernatur et. Veritatis odio et. Qui et quia dolore fuga provident voluptates quo.\nUt veritatis similique aut aut qui ducimus facere. Saepe earum eveniet iste eos. Sit cum atque sit cupiditate.	27	22	15	2017-09-13 12:48:38.296063	2017-09-13 12:48:38.307592	0	\N	accepted	2017-09-13 12:48:38.286859	{"ca": "Ut molestiae eius voluptatem et et ipsum numquam aut quia asperiores magni.", "en": "Labore ut assumenda accusantium ut voluptatem sequi quasi mollitia vitae.", "es": "Quisquam similique et quaerat in error at quia maiores sit fugiat quo deleniti sapiente quia."}	Jr.-PROP-2017-09-97	\N	\N	\N
98	Est placeat iste aut excepturi repudiandae.	Voluptas nihil dolor alias vel ipsum quos. Earum mollitia aspernatur maxime alias deserunt sunt. Perferendis optio accusantium cum. Iusto et delectus.\nEt omnis quaerat molestiae quisquam et. Magni est maxime. Ex quae dolores in aut voluptas qui. Ad soluta non minus dignissimos nemo reprehenderit aut.	27	110	13	2017-09-13 12:48:38.386079	2017-09-13 12:48:38.397625	1	\N	accepted	2017-09-13 12:48:38.378506	{"ca": "Officiis fugiat repellendus quis aut sunt sint qui voluptatem qui deleniti aspernatur iure voluptatem hic.", "en": "Saepe quibusdam praesentium et consectetur molestiae in necessitatibus commodi rerum eos quo quasi.", "es": "Consequatur aspernatur nihil explicabo illum aliquam iste quod ad voluptas soluta est numquam amet."}	Jr.-PROP-2017-09-98	\N	\N	\N
113	Accusamus qui animi amet sequi porro ex.	Aut mollitia nemo omnis distinctio sapiente dolorum qui. Itaque iusto rerum voluptas. Est delectus optio sit consequuntur qui aut. Eligendi rerum temporibus nobis.\nRepellat id quo quibusdam culpa voluptate. Et quia sapiente qui perspiciatis in nam. Quo beatae quisquam sequi rerum. Voluptates corporis consequuntur.	33	58	\N	2017-09-13 12:48:51.939545	2017-09-13 12:48:51.949027	1	\N	rejected	2017-09-13 12:48:51.933597	\N	Jr.-PROP-2017-09-113	\N	\N	\N
86	Adipisci mollitia.	Totam consectetur illum alias aut quos eligendi. Error tenetur voluptates voluptatem. Qui dolorum adipisci qui. Et qui laboriosam voluptas ullam quasi. Molestias ea corrupti pariatur inventore sequi omnis in.\nQuas necessitatibus neque assumenda ut sed aut voluptatem. Voluptas dolorem illo omnis omnis. Quas ut alias deleniti.	27	6	18	2017-09-13 12:48:33.837407	2017-09-13 12:48:33.849884	0	\N	\N	2017-09-13 12:48:33.829282	\N	Jr.-PROP-2017-09-86	\N	\N	\N
169	Avis de Bernard V - débat mobile Dunkerque	STRATÉGIE PORTUAIRE\r\n\r\nLe développement du port est une meilleure option que le canal Seine-Nord, qui va favoriser le développement des ports d’Anvers et Rotterdam. Quitte à investir, autant le faire pour le développement des ports et non au profit de la concurrence étrangère.\r\n	49	375	\N	2017-10-15 15:45:15.829644	2017-10-15 15:45:15.916452	0	\N	\N	\N	\N	cndp-PROP-2017-10-169	\N	\N	\N
78	Magnam distinctio ipsam aut quia ex.	Optio tempora est dolor vel. Vel labore autem iure. Expedita fugit alias.\nAb amet possimus facilis dolore dolorem adipisci et. Officiis excepturi et sed sed. Modi est et. Numquam vero neque impedit aut quia modi.	21	96	15	2017-09-13 12:48:22.987945	2017-09-13 12:48:23.00767	1	\N	accepted	2017-09-13 12:48:22.979946	{"ca": "Omnis autem quia omnis omnis eum accusantium magnam non sunt sapiente suscipit.", "en": "Cupiditate aliquam optio ullam repellat similique iste minus ut facilis quos voluptas.", "es": "Reiciendis quos necessitatibus facere ipsam aut quam est id deserunt omnis ratione consequuntur."}	Jr.-PROP-2017-09-78	\N	\N	\N
79	Dolores rem itaque distinctio maiores qui.	Incidunt quibusdam molestiae doloremque ad vero delectus et. Dicta debitis dolores voluptatum iste labore. Voluptates rem qui. Doloremque itaque id voluptatem. Minima tempore placeat aut ipsa nobis.\nEsse perspiciatis eum possimus id a. Dolores voluptatem voluptate adipisci qui ipsum in. Et voluptatem quidem facilis. Ut aut cupiditate et.	21	49	\N	2017-09-13 12:48:23.414159	2017-09-13 12:48:23.426578	0	\N	accepted	2017-09-13 12:48:23.406954	{"ca": "Odit repudiandae commodi nesciunt nobis et rerum ratione omnis illo excepturi consectetur.", "en": "Laudantium dolor vel repellat magni et quia consequatur reprehenderit in tenetur nisi.", "es": "Saepe rerum minus porro eos quo distinctio nam et temporibus sed exercitationem."}	Jr.-PROP-2017-09-79	\N	\N	\N
82	Eaque asperiores ducimus neque.	Sit magni ut fugit voluptas. Tempora voluptatibus facilis qui placeat vero libero. Sapiente suscipit atque est nihil. Vel et et.\nQuod non officia modi qui. Sit corrupti perspiciatis aut veniam. Aut sed fuga et necessitatibus. Aut in placeat neque consequuntur recusandae optio. Aspernatur et ullam.	27	66	13	2017-09-13 12:48:32.448124	2017-09-13 12:48:32.459886	1	\N	\N	2017-09-13 12:48:32.438203	\N	Jr.-PROP-2017-09-82	\N	\N	\N
80	Iure ipsum aut sunt saepe harum voluptas.	Illum quia pariatur distinctio saepe porro nemo et. Aut quas voluptas qui aspernatur necessitatibus. Omnis voluptatem sunt laudantium autem delectus necessitatibus odit. Laboriosam est et.\nAd voluptatem officiis suscipit temporibus fugiat commodi a. Vel molestiae recusandae. Beatae quis sed voluptate aliquam quia necessitatibus officiis. Occaecati ut eius quod veritatis aliquid velit repellat. Mollitia id quisquam sit non tenetur accusamus rerum.	21	95	\N	2017-09-13 12:48:23.520736	2017-09-13 12:48:23.530783	1	\N	accepted	2017-09-13 12:48:23.514244	{"ca": "Quo rerum rerum fugit et et asperiores numquam sequi optio.", "en": "Sequi quo quos omnis dolores tenetur ex dolore consequatur quia consequatur.", "es": "Temporibus atque molestiae molestiae expedita aut tempore quas debitis non deleniti facilis."}	Jr.-PROP-2017-09-80	\N	\N	\N
81	Exercitationem officia et.	Voluptas tempore rerum veniam. Quibusdam accusamus beatae earum voluptas placeat sapiente. Id voluptatum deserunt tempora voluptas quaerat. Quidem accusantium sit sint voluptas tempore.\nDebitis sint harum tempora id facilis non delectus. Est dolorem accusantium quo. Soluta consequatur necessitatibus. Maiores dolorum autem voluptatum expedita.	27	117	13	2017-09-13 12:48:32.067033	2017-09-13 12:48:32.078694	1	\N	\N	2017-09-13 12:48:32.059268	\N	Jr.-PROP-2017-09-81	\N	\N	\N
83	Ad nobis reiciendis.	Et voluptatibus rem natus sint laudantium et. Dicta dolores earum. Distinctio quia culpa dolorum qui iste asperiores.\nAut maxime qui praesentium non enim ipsam. Pariatur maxime vero quia dolores. Quis ipsa laudantium ea non. Quos pariatur incidunt in accusamus a earum cumque.	27	46	15	2017-09-13 12:48:32.753858	2017-09-13 12:48:32.771432	1	\N	\N	2017-09-13 12:48:32.741403	\N	Jr.-PROP-2017-09-83	\N	\N	\N
87	Velit cum minus magni voluptatibus.	Reprehenderit sit adipisci exercitationem nisi odio accusamus mollitia. Est numquam temporibus enim aut reprehenderit suscipit. Aut nihil ducimus voluptates ut ut accusantium. Dolores molestias iure et et quia harum. Fugit dolorem odio excepturi.\nNecessitatibus sapiente accusamus et nisi. Voluptatem culpa quae vel est ipsam. Tenetur voluptatem quo minus.	27	71	16	2017-09-13 12:48:34.030064	2017-09-13 12:48:34.04289	0	\N	\N	2017-09-13 12:48:34.021685	\N	Jr.-PROP-2017-09-87	\N	\N	\N
84	Iusto temporibus dolore est.	Sunt hic rerum qui. Neque consequatur nemo. Saepe velit similique nulla officia dolorem.\nUt ut omnis sed dignissimos inventore. Iusto accusantium tempore incidunt repellendus esse voluptatem dolorum. Quia dolore ipsam voluptate quaerat ullam. Fuga ut nulla veritatis ab.	27	160	13	2017-09-13 12:48:33.131273	2017-09-13 12:48:33.141952	1	\N	\N	2017-09-13 12:48:33.123407	\N	Jr.-PROP-2017-09-84	\N	\N	\N
85	Ut recusandae.	Qui suscipit incidunt pariatur est dolor voluptates labore. Odit assumenda in eaque reiciendis dolores sed et. Sapiente ipsam ullam. Facere aut sint eum.\nDolores aut suscipit aliquid quas et et. Est expedita culpa. Qui eos laborum soluta consequuntur.	27	28	16	2017-09-13 12:48:33.486573	2017-09-13 12:48:33.497775	1	\N	\N	2017-09-13 12:48:33.479188	\N	Jr.-PROP-2017-09-85	\N	\N	\N
89	Doloribus alias facilis.	Rerum dolorem dolorem cupiditate ducimus veritatis exercitationem. Ea harum perspiciatis atque illo enim. Tempora reiciendis minima vel odio distinctio. Fugiat voluptatem nemo. Fuga quis neque quia esse ex.\nIusto enim quo quo dolorum doloremque. Adipisci eum perspiciatis temporibus. Maiores ab id necessitatibus. Vel et error beatae illum ab in. Nemo rerum quia officia accusantium eum omnis dolorem.	27	199	13	2017-09-13 12:48:34.76425	2017-09-13 12:48:34.777892	2	\N	evaluating	2017-09-13 12:48:34.755344	\N	Jr.-PROP-2017-09-89	\N	\N	\N
88	Voluptatem id quis quaerat et rerum.	Qui repellat dolor fuga. Accusamus consequatur iure. Excepturi repudiandae voluptatibus consequatur voluptas repellendus vel sit. Vero esse nemo vitae odio fugiat consequatur quam.\nEt voluptas quis veniam quaerat non ex. Laudantium voluptates voluptas consequuntur ut odit. Enim aspernatur error. Praesentium corrupti consequatur iste esse sapiente deleniti repellendus. Voluptates et provident.	27	123	13	2017-09-13 12:48:34.191255	2017-09-13 12:48:34.206344	2	\N	evaluating	2017-09-13 12:48:34.182616	\N	Jr.-PROP-2017-09-88	\N	\N	\N
90	Debitis autem.	Asperiores et placeat. Reprehenderit dolore eos dolor dicta in repudiandae fuga. Accusantium repellendus placeat. Quos quia error alias aliquid quam.\nRerum iste magni iusto facere doloremque alias est. Voluptatem repellendus sunt quisquam vel voluptatem. Sit velit consequuntur inventore omnis rerum temporibus. Et repellendus numquam. Qui repudiandae error vitae inventore et.	27	242	13	2017-09-13 12:48:35.367623	2017-09-13 12:48:35.378072	2	\N	evaluating	2017-09-13 12:48:35.359716	\N	Jr.-PROP-2017-09-90	\N	\N	\N
91	Non velit.	Ratione qui optio. Dolor labore possimus ad fugiat qui et. Et consectetur voluptatem aut in reiciendis quia.\nSuscipit aperiam quia perferendis delectus veritatis ad. Quas ducimus molestiae sed et quo. Distinctio quae ut quos. Fuga quod eveniet sed. Eligendi odio molestiae id et est.	27	198	16	2017-09-13 12:48:35.94487	2017-09-13 12:48:35.955962	2	\N	rejected	2017-09-13 12:48:35.937392	\N	Jr.-PROP-2017-09-91	\N	\N	\N
336	Mise en garde : Débat public de l’aménagement du Grand Port Maritime de Dunkerque : des contradictions en nombre	En cette fin 2017 se déroule un débat public sur un projet d’extension du port maritime de Dunkerque. Bien que la genèse du projet est très ancienne (années 60-70), le projet se doit de s’adapter au contexte actuel.\r\nAinsi un choix entre deux projets est présenté. Mais ce choix est-il encore bien à faire étant donné que de nombreux travaux ont déjà été menés et ne vont principalement que dans le sens du projet dit « Atlantique » ?\r\nN’existe-t-il pas une 3ème voie qui est de dire que le contexte géopolitique international ne permet pas de conclure dès aujourd’hui à un projet d’une telle ampleur mais plutôt à une extension limitée,  mesurée et phasée permettant de limiter ainsi les nombreux impacts.\r\nLa question est de savoir quel héritage allons-nous laisser à notre zone littorale.\r\nNos élus se battent avec pugnacité en faveur de ce projet, mais  ont-ils regardé l’impact à long terme, dans 20, 30 ou 40 ans quand les flux logistiques mondiaux auront grandement évolués et qu’il n’y en aura peut-être quasiment plus sur des longues distances.  Quoique les spécialistes en disent, l’histoire et notamment l’histoire récente nous ont montrés qu’il très difficile, voire impossible de mettre une date en face des évolutions. Que ce soit les chocs pétroliers, ou la crise plus récente de 2008-2009, personne ne les avait prédits ni estimé une durée correcte. Aujourd’hui l’Asie tire son épingle du jeu, demain surement l’Amérique du sud  et l’Afrique tout en revenant en même temps sur des productions plus locales avec  les évolutions sociétales et environnementales. Est-ce que laisser des friches en nombres dans plusieurs décennies justifie un intérêt économique sur la décennie à venir ?\r\nQuels enjeux, il s’agit bien de cette question ? Un enjeu économique certains mais pour quelle durée et avec quels impacts pour le bassin dunkerquois ? Un nombre d’emploi direct et indirect non négligeable mais avec une proportion locale limitée. Il suffit de regarder les plaques des camions sur les routes pour se rendre compte que cela ne profite que très partiellement aux entreprises françaises. Autre point, le réseau routier et en particulier l’autoroute dite « l’Européenne » (A16) déjà saturée aujourd’hui – il suffit de voir les kilomètres de bouchons se formant en quelques minutes lors d’une neutralisation ne serait-ce que d’une seule voie pour travaux ou accident – et l’on veut encore augmenter radicalement le trafic ?\r\nSans compter la pollution atmosphérique qui ne fera qu’augmenter dans un bassin déjà très impacté et en particulier par la pollution industrielle. Même si nous avons la mer pour évacuer cette pollution, Dunkerque est déjà dans le haut du tableau sur les cas de nombreux cancers. Peut-être que sa position dans les différents classements n’est pas encore assez haute ?\r\nCôté industrie, Dunkerque comporte une concentration d’installations à risques (nucléaire, Seveso, installations classées, …). Indépendamment l’une de l’autre cela est maitrisé. Mais qu’en est-il de l’effet domino pouvant se produire lors d’incidents majeurs (pas forcément d’origine industrielle mais par exemple en cas d’attentat). Aucune étude publique ne reprend ce sujet. Faut-il encore densifier les zones à risques et en augmentant encore éventuellement ces risques ? Prions qu’un incident majeur n’arrive jamais.\r\nCôté environnement et biodiversité, outre les hectares pris à la nature, l’impact est loin d’être négligeable. Mais il est surement vrai que les espèces (oiseaux, petits mammifères et autres) connaissent à l’avance les projets du GPMD et se sont naturellement déplacées avant l’élaboration des études : Quasiment aucune espèce sensible n’a été recensée sur l’implantation du projet « Atlantique » mais pas contre il y en a bien tout autour ! La majorité des études de grande ampleur sur la biodiversité tire la sonnette d’alarme concernant l’impact de l’homme et l’avenir de ces espèces. En voici encore un bel futur exemple.\r\nBien qu’il s’agisse d’un débat, rien ne sert de poursuivre cette énumération puisque le choix semble déjà réalisé. \r\nMessieurs les décideurs, porteurs de projets, élus, c’est à vous de maitriser l’avenir de notre territoire, mais il faut le faire intelligemment et ne pas fuir ses responsabilités dans le futur.\r\nOui  à une extension limitée et mesurée, non à extension de masse.\r\n\r\nFlorent L., loonois\r\n	49	419	\N	2017-11-24 20:29:55.119831	2017-11-24 20:29:55.28461	0	\N	\N	\N	\N	cndp-PROP-2017-11-336	\N	\N	\N
116	Illo pariatur.	Est possimus labore excepturi non sequi rerum est. Quo commodi vel est quae. Voluptatem delectus porro tenetur labore atque qui iusto. Voluptatem libero cumque at.\nQui inventore ab sit iste qui architecto aut. Voluptatem itaque laborum magni. Quas rerum voluptas rem molestiae. Autem occaecati sapiente ipsum. Minima qui molestiae facere id ipsa.	33	108	1	2017-09-13 12:48:53.157827	2017-09-13 12:48:53.170261	2	\N	rejected	2017-09-13 12:48:53.150068	\N	Jr.-PROP-2017-09-116	\N	\N	\N
107	Vero est.	Ea expedita veniam quae dolorum et. Quam voluptas in. Voluptas ut ea minus sit quia.\nQuia itaque sed. Consequatur quis laborum. Dicta provident non et non facilis at. Dolor recusandae dolor minima minus ut. Sit rerum quo inventore et rem magni.	33	81	\N	2017-09-13 12:48:50.115991	2017-09-13 12:48:50.131661	2	\N	\N	2017-09-13 12:48:50.106906	\N	Jr.-PROP-2017-09-107	\N	\N	\N
99	Expedita consequatur necessitatibus.	Maxime fuga temporibus eos sint aliquid est. Sit enim quia quis. Dolor ut esse recusandae ratione inventore repellat. In voluptatem ut debitis.\nEt voluptas nisi voluptatem est. Consequuntur sequi totam ad. Veniam aut dolorem.	27	230	13	2017-09-13 12:48:38.757788	2017-09-13 12:48:38.778489	2	\N	accepted	2017-09-13 12:48:38.750267	{"ca": "Dolores laudantium tempora magnam quis fugit nostrum voluptatem architecto voluptatem.", "en": "Voluptas reprehenderit voluptatem aut qui temporibus blanditiis et quos molestias itaque mollitia aut libero pariatur.", "es": "Officiis voluptatibus ipsa eum quia esse illo harum iure neque eum cumque aliquam."}	Jr.-PROP-2017-09-99	\N	\N	\N
115	Consectetur fugit omnis.	Nam distinctio laborum enim illum doloremque. Culpa velit placeat at quo. Omnis vitae autem quo.\nDolores qui beatae. Quia animi sit. Expedita voluptatem quo aliquam enim eaque odio libero. Cum impedit praesentium et eveniet nobis provident aut. Repellendus ipsam omnis qui.	33	191	\N	2017-09-13 12:48:52.790516	2017-09-13 12:48:52.801066	1	\N	rejected	2017-09-13 12:48:52.78439	\N	Jr.-PROP-2017-09-115	\N	\N	\N
100	Nobis praesentium quis recusandae perspiciatis.	Impedit ex adipisci distinctio sapiente eligendi. Assumenda porro tenetur amet eligendi omnis saepe pariatur. Quidem molestias in quo voluptatibus soluta dolorem.\nNam beatae numquam. Labore nulla cumque officia inventore exercitationem. Nostrum necessitatibus numquam ratione quia sit voluptas.	27	260	13	2017-09-13 12:48:39.415136	2017-09-13 12:48:39.436005	1	\N	accepted	2017-09-13 12:48:39.393314	{"ca": "Est modi iusto saepe consequatur veritatis debitis quod ea sit.", "en": "Est dolorem non explicabo aut exercitationem et atque sapiente est quam eius facere.", "es": "Odit eum beatae omnis dolores sed sequi consequatur iste amet numquam."}	Jr.-PROP-2017-09-100	\N	\N	\N
101	Corporis ut sint facilis ex mollitia.	Veritatis earum porro ipsum excepturi sit itaque laborum. Dolores unde laudantium. Ut quia quod. Odio ut et incidunt dolore illo sit exercitationem.\nAt iure aut accusamus accusantium nemo perferendis quo. Velit facilis dignissimos. Error totam in magni.	33	10	16	2017-09-13 12:48:48.197573	2017-09-13 12:48:48.208379	0	\N	\N	2017-09-13 12:48:48.190157	\N	Jr.-PROP-2017-09-101	\N	\N	\N
103	Eaque in et quia sequi consequatur.	Maiores excepturi eos suscipit aut. Itaque consectetur molestias. Aut facere quae qui adipisci qui.\nEt amet et harum. Repudiandae magnam omnis quis libero laboriosam fugiat. Similique voluptates ut repellat natus reiciendis qui earum.	33	127	2	2017-09-13 12:48:48.570006	2017-09-13 12:48:48.580835	2	\N	\N	2017-09-13 12:48:48.562973	\N	Jr.-PROP-2017-09-103	\N	\N	\N
102	Qui tenetur aut alias ipsa laudantium minus.	Omnis quod molestiae sapiente iusto ut enim. Qui dolorum iusto eaque. Saepe quia animi tempore excepturi est. Quidem velit quibusdam ut ipsum voluptatem atque quae.\nEsse qui dolore. Ab quod qui ex et. Dolor rerum ut tempore quas quasi. Perspiciatis consequatur hic. Ullam est voluptatem hic rerum dolorem.	33	11	\N	2017-09-13 12:48:48.263808	2017-09-13 12:48:48.274071	1	\N	\N	2017-09-13 12:48:48.258106	\N	Jr.-PROP-2017-09-102	\N	\N	\N
114	Ut deserunt a nihil omnis.	Quia veniam numquam eveniet officia quas soluta. Quia inventore nam eum voluptatem deserunt alias omnis. Doloremque cupiditate et ut recusandae eligendi quis. Explicabo hic et vel esse saepe qui. Laudantium sint eaque enim rem est dolorum iusto.\nSed maiores sapiente rerum perspiciatis reprehenderit. Repellendus fugit voluptas dicta beatae. Enim dignissimos quo. Doloribus omnis aspernatur ullam officia nisi repellendus optio. Eos fugiat rerum animi.	33	287	9	2017-09-13 12:48:52.223748	2017-09-13 12:48:52.234975	2	\N	rejected	2017-09-13 12:48:52.215122	\N	Jr.-PROP-2017-09-114	\N	\N	\N
104	Beatae pariatur dignissimos rerum cum consequuntur.	Omnis voluptatem ab pariatur necessitatibus aut. Ut quas sint delectus expedita quia quisquam provident. Qui id consequatur numquam quia.\nUt asperiores qui nemo quisquam sequi dignissimos minima. Necessitatibus perferendis autem facilis distinctio. Autem magnam culpa ipsam est ad at. Ut voluptatem numquam ex ea non.	33	290	\N	2017-09-13 12:48:49.182862	2017-09-13 12:48:49.195283	1	\N	\N	2017-09-13 12:48:49.175155	\N	Jr.-PROP-2017-09-104	\N	\N	\N
105	Non consequatur doloribus eos.	Non beatae aut consequatur. Dolorum accusamus ut aut consectetur optio. Dolorum expedita repellendus et quos atque.\nEarum dolores sit sed est facilis a. Est error dolorem facilis accusantium ipsa. Qui excepturi ipsum eum occaecati. Et dolorum tempore voluptatem eum fuga ducimus eius. Sit et non error nisi praesentium mollitia enim.	33	265	1	2017-09-13 12:48:49.567237	2017-09-13 12:48:49.577879	1	\N	\N	2017-09-13 12:48:49.559976	\N	Jr.-PROP-2017-09-105	\N	\N	\N
106	In neque temporibus eos vel eius est.	Et repellat debitis ut id sit harum. Quae accusantium aperiam quod non quo. Quam neque dolor molestiae. Repudiandae assumenda eos est. Iure et et.\nSed qui recusandae sed laboriosam iure non. Eius similique illo aperiam ut. Et maxime facilis commodi. Molestiae omnis similique.	33	110	\N	2017-09-13 12:48:49.980675	2017-09-13 12:48:49.989723	0	\N	\N	2017-09-13 12:48:49.97487	\N	Jr.-PROP-2017-09-106	\N	\N	\N
117	Omnis voluptate.	Voluptatum omnis consequatur necessitatibus. Facilis illum ratione in magni. Voluptates debitis cupiditate quod neque earum a et.\nNumquam ex alias quibusdam temporibus consequatur culpa ratione. Id unde sed asperiores distinctio et optio aut. Dolores recusandae veniam perspiciatis delectus magnam. Sit hic iste consequatur doloremque cumque.	33	158	7	2017-09-13 12:48:53.700835	2017-09-13 12:48:53.712044	2	\N	accepted	2017-09-13 12:48:53.693763	{"ca": "Ipsum natus odit cupiditate dolorem consequuntur sapiente qui molestiae porro.", "en": "Consequuntur molestias voluptas qui laudantium odio dolorum nihil reiciendis tempore vel suscipit.", "es": "Doloremque vel debitis repellendus corrupti quo eveniet ut vel velit."}	Jr.-PROP-2017-09-117	\N	\N	\N
127	Cahier d'acteur d'OSP	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	39	334	\N	2017-09-13 17:18:56.288738	2017-09-13 17:18:56.369219	0	\N	\N	\N	\N	cndp-PROP-2017-09-127	\N	\N	\N
135	Test peinture rose	Peut-on repeindre en rose bonbon tous les quais existants à chaque mois d'octobre?	51	339	\N	2017-09-21 11:51:26.138895	2017-09-25 12:41:04.577552	0	\N	rejected	2017-09-25 12:41:04.559032	{"fr": "<p>Test</p>"}	cndp-PROP-2017-09-135	\N	\N	\N
126	Exemple de contribution 1	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	42	334	\N	2017-09-13 17:14:04.256644	2017-09-13 17:14:04.274111	0	5	\N	\N	\N	cndp-PROP-2017-09-126	\N	\N	\N
170	Avis de Stéphane T. - Débat Mobile Dunkerque	" Baltique ? OK si on ne supprime pas le terrain de moto-cross. Mon petit frère est docker depuis 3 ans. Je pense à sa famille, je suis pour ce projet d’extension. "	49	375	\N	2017-10-15 15:49:25.293747	2017-10-15 15:49:25.328681	0	\N	\N	\N	\N	cndp-PROP-2017-10-170	\N	\N	\N
175	Avis de Jabcyn - Débat Mobile Dunkerque	"Ce projet est de trop grande envergure. On pourrait rénover. 16 000 emplois ? Mais pour combien de temps ? Je l’espère de tout cœur mais je doute."\r\n	49	375	\N	2017-10-15 16:01:42.594279	2017-10-15 16:01:42.649616	0	\N	\N	\N	\N	cndp-PROP-2017-10-175	\N	\N	\N
118	Quibusdam quaerat accusantium quia cupiditate.	Similique in est aut. Soluta ea et non et facere odit asperiores. Ipsum veniam ut libero. Maiores animi libero omnis magni. Numquam nostrum quo sapiente sint perferendis.\nEst rem dolorum laboriosam natus. Aut sapiente libero ducimus illo. Aspernatur error sint dignissimos. Vero repellendus omnis autem et. Quas aut quam iusto nihil aut nesciunt qui.	33	102	9	2017-09-13 12:48:54.209822	2017-09-13 12:48:54.222405	2	\N	accepted	2017-09-13 12:48:54.202377	{"ca": "In repudiandae voluptate est corrupti cum et dolore repellat et nihil non perferendis sint repellendus.", "en": "Nemo officia est ea temporibus et natus blanditiis minima sit et error facere quisquam.", "es": "Earum quos eos minus quis numquam eos molestiae qui velit voluptatem laborum unde esse."}	Jr.-PROP-2017-09-118	\N	\N	\N
119	Non beatae.	Quas iste porro enim velit aliquam unde harum. Eligendi architecto fugit ut culpa rerum quia. Delectus sed soluta debitis nihil sunt ut similique.\nUt velit dolorem voluptatem iste occaecati. Cumque et quos dolores. Placeat autem corporis officiis sit in sint.	33	249	13	2017-09-13 12:48:54.742666	2017-09-13 12:48:54.753948	1	\N	accepted	2017-09-13 12:48:54.735339	{"ca": "Laboriosam qui nam voluptatem maxime omnis suscipit quisquam reiciendis aperiam pariatur maiores eos.", "en": "Et ipsam praesentium id provident sed qui unde in est nisi.", "es": "Ab quos consequatur sit iure sint distinctio quis autem itaque eos at."}	Jr.-PROP-2017-09-119	\N	\N	\N
128	Nombre de création d'emplois	Lorem ipsum dolorem. Lorem ipsum dolorem. Lorem ipsum dolorem. Lorem ipsum dolorem.	43	338	\N	2017-09-14 09:00:26.808176	2017-09-14 09:00:27.079318	0	\N	\N	\N	\N	cndp-PROP-2017-09-128	\N	\N	\N
120	Hic qui.	Non perspiciatis omnis autem non. Laborum labore accusantium nulla. Et explicabo amet magni.\nEsse nihil quibusdam. Ipsum ea magni vero. Aliquid placeat iste voluptas quis cum rerum. Aut et mollitia et molestiae cupiditate. Tenetur expedita dolores in.	33	164	13	2017-09-13 12:48:55.065066	2017-09-13 12:48:55.076591	1	\N	accepted	2017-09-13 12:48:55.057512	{"ca": "Id velit dolore corporis illum voluptatibus itaque earum consectetur corrupti mollitia est nisi voluptas.", "en": "Animi aut quos sint facere repellat vel fugit harum esse aut magnam odit.", "es": "Aperiam dolorem dignissimos aut vel non veritatis cupiditate culpa sit dolor et."}	Jr.-PROP-2017-09-120	\N	\N	\N
130	Cahier d'acteur de la cndp	Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.\r\nInteger laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.\r\nInteger laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	39	338	\N	2017-09-14 09:08:45.196181	2017-09-14 09:08:45.622521	0	\N	\N	\N	\N	cndp-PROP-2017-09-130	\N	\N	\N
136	Amélioration de l’évacuation des crues de l’Aa et de la Lys	Bonjour\r\nIl est possible qu’une sortie supplémentaire des eaux intérieures de la Flandre maritime vers la mer soit nécessaire en plus de plus de Tixier et de l’écluse de Mardyck  (sous réserve de la dégradation de la salinité de l’eau du port).\r\nCe nouvel exutoire pourrait communiquer avec l’allongement du bassin de l’Atlantique. \r\nLes plans masses actuellement diffusés ne font mention de cette problématique, si elle existe.\r\nCordialement \r\n	51	366	\N	2017-09-23 10:25:58.996802	2017-09-23 10:25:59.047568	0	\N	\N	\N	\N	cndp-PROP-2017-09-136	\N	\N	\N
137	Pollution locale	Bonjour\r\nAvec l'augmentation du nbre de camions, que faites vous pour la pollution engendrée sur les habitants des communes proches ? sans parler de la pollution visuelle (containers, grues et autres engins ne sont pas des plus agréables à regarder) ... \r\nQue croyez-vous que cet aménagement va amener sur le prix de l'immobilier des villes comme Gravelines ou Loon-Plage ?\r\nPar ailleurs, l'autoroute A25 est déjà surchargée, comment allez-vous réguler le trafic qui ne va qu'augmenter ? merci	50	368	\N	2017-09-25 09:20:23.730855	2017-09-25 09:20:23.7912	0	\N	\N	\N	\N	cndp-PROP-2017-09-137	\N	\N	\N
138	Flux entrants et sortants	Vous annoncez un redéploiement des réseaux ferroviaire et routier INTERNES au port.\r\nMais aussi pas moins de 2.000 à 2.800 poids lourds supplémentaires par jour sur les autoroutes.\r\nSachant la saturation de nos autoroutes, comment comptez-vous faire absorber les flux ENTRANTS et SORTANTS du port par l'ensemble de la chaine de transport?\r\n- quid du canal Seine-Nord?\r\n- développement du fret ferroviaire / ferroutage?\r\n- péage sur autoroutes?\r\n- autre?\r\n 	51	372	\N	2017-09-26 13:59:59.002885	2017-09-26 13:59:59.03653	0	\N	\N	\N	\N	cndp-PROP-2017-09-138	\N	\N	\N
139	Le canal Seine/Nord	Quel est l influence que vous avez sur la décision de réalisation du canal Seine/Nord  ?\r\nQuelles actions ? 	50	373	\N	2017-09-28 06:43:26.764243	2017-09-28 06:43:26.802566	0	\N	\N	\N	\N	cndp-PROP-2017-09-139	\N	\N	\N
140	Dunkerque sous les eaux à la fin siècle	Formidable occasion de débattre de ce que nous souhaitons possible et désirable pour nous et nos enfants. Nous ne serons pas d'accord sur tout. C'est tant mieux. Nous aurons toutefois l'impérieuse nécessité de nous accorder sur des trajectoires lourdes qui impacterons l'avenir. Je n'ai pas l'esprit partisan,  mais ce type de projet industrialo-portuaire , coeur de l'identité même de ce territoire, sur jouera autant sur l'affect que sur le rationnel. 	49	374	\N	2017-09-29 15:48:07.665863	2017-09-29 15:48:07.74829	0	\N	\N	\N	\N	cndp-PROP-2017-09-140	\N	\N	\N
141	Limites de la représentation démocratique.	Puisqu'au final seuls les élus avaliseront ou non ce projet et sachant que la quasi majorité d'entre eux y est favorable pourquoi ce débat ?  	49	374	\N	2017-10-01 09:13:23.502715	2017-10-01 09:13:23.538954	0	\N	\N	\N	\N	cndp-PROP-2017-10-141	\N	\N	\N
142	Territoire riche, polulation pauvre.	A travers ce projet ambitieux, c'est aussi une plus juste répartition de la richesse créée qui se pose. Que gagne concrètement le citoyen lambda dans cette affaire ?	49	374	\N	2017-10-01 12:31:37.478386	2017-10-01 12:31:37.522585	0	\N	\N	\N	\N	cndp-PROP-2017-10-142	\N	\N	\N
143	Les intérêts industriels supérieurs à la santé publique ...	L'impact environnemental sera fort malgré les compensations. L'effet cocktail n'est jamais évoqué. Quels types d'attractivités voulons-nous ?\r\nLe tourisme et l'industrie lourde sont-ils solubles ? ( 16 usines SEVESO, 1 centrale nucléaire ). Ne pensez-vous pas que les populations ont assez donné pour le pays ? Quels coûts sommes-nous prêt à payer ?	49	374	\N	2017-10-01 12:39:01.287645	2017-10-01 12:39:01.347407	0	\N	\N	\N	\N	cndp-PROP-2017-10-143	\N	\N	\N
145	Le canal Seine/Nord  Default (Question de lucas  28/09/2017) 	Quel est l influence que vous avez sur la décision de réalisation du canal Seine/Nord ? \r\nQuelles actions ?	51	375	\N	2017-10-02 14:45:40.10549	2017-10-02 14:45:40.219493	0	\N	\N	\N	\N	cndp-PROP-2017-10-145	\N	\N	\N
125	Exemple de contribution 2	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	42	334	\N	2017-09-13 17:12:34.976935	2017-09-13 17:12:34.991586	0	\N	\N	\N	\N	cndp-PROP-2017-09-125	\N	\N	\N
177	Avis de Patrick M. - Débat mobile Dunkerque	"16 000 emplois c’est bien, mais c’est toujours les mêmes qui ont du taf. Je me rends dans les boîtes d’intérim tous les matins mais il n’y a rien. C’est toujours pareil, on embauche à la tête du client. Donnons plutôt la chance à ceux qui ne sont pas favorisés."	49	375	\N	2017-10-15 16:04:40.942813	2017-10-15 16:04:40.995808	0	\N	\N	\N	\N	cndp-PROP-2017-10-177	\N	\N	\N
121	Exemple de question	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt. Cras sit amet mi vel turpis egestas scelerisque eget eu dui. Donec cursus tortor a erat ullamcorper, non cursus justo gravida. Aenean metus ligula, mattis eget ipsum et, commodo semper nibh. Proin nisi dui, laoreet at magna ac, faucibus malesuada diam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. 	43	\N	\N	2017-09-13 16:36:36.067759	2017-09-13 16:37:04.766467	0	\N	accepted	2017-09-13 16:37:04.751211	{"fr": "<p><strong>Expemple de réponse officielle : </strong></p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt. Cras sit amet mi vel turpis egestas scelerisque eget eu dui. Donec cursus tortor a erat ullamcorper, non cursus justo gravida. Aenean metus ligula, mattis eget ipsum et, commodo semper nibh. Proin nisi dui, laoreet at magna ac, faucibus malesuada diam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>"}	cndp-PROP-2017-09-121	\N	\N	\N
122	Exemple de contribution 3	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	42	333	\N	2017-09-13 16:53:12.266359	2017-09-13 16:53:12.282221	0	\N	\N	\N	\N	cndp-PROP-2017-09-122	\N	\N	\N
123	Conteneurs biodégradables	La mise en ligne aujourd’hui du Dossier du Maître d’Ouvrage sur le projet d’extension du port de Dunkerque donne le coup d’envoi de la phase préparatoire du débat public, prévu du 18 septembre 2017 au 22 décembre 2017.	42	333	\N	2017-09-13 17:00:48.299154	2017-09-13 17:00:48.31139	0	\N	\N	\N	\N	cndp-PROP-2017-09-123	\N	\N	\N
124	Exemple de contribution par une organisation	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis arcu risus, congue vitae pellentesque at, consequat at diam. Donec varius, quam in lacinia rhoncus, sapien ante fermentum sem, non tristique sapien enim ut orci. Sed a quam sed nulla ullamcorper volutpat. Etiam non enim elit. Nunc eu magna est. Morbi cursus nibh vitae lacus blandit suscipit. Integer laoreet bibendum mollis. Curabitur dapibus aliquam lorem a dapibus. Cras faucibus quam et libero varius, a aliquam eros tincidunt.	42	334	\N	2017-09-13 17:10:54.619341	2017-09-13 17:10:54.639987	0	5	\N	\N	\N	cndp-PROP-2017-09-124	\N	\N	\N
337	Vie quotidienne 	Je suis habitant de la commune de Loon Plage et Je suis contre le projet Atlantique, pourquoi faire une telle réalisation qui nuira à tous les loonois ( pollution visuelle, sonore, de l’air, le trafic routier amplifié) alors que la variante Baltique est beaucoup moins contraignante pour la population. Encore une fois, on pense business plutôt qu’au bien des gens. \r\nJe connais déjà plusieurs habitants de la commune qui cherche à mettre leur maison en vente, je pense que Loon Plage se videra de sa population, nous pourrons dire adieux au parc galame, adieux à piscine naturelle, adieux à tous ce qui fait de la ville une ville agréable.	49	421	\N	2017-11-25 13:11:50.332713	2017-11-25 13:11:50.65248	0	\N	\N	\N	\N	cndp-PROP-2017-11-337	\N	\N	\N
342	Elisabeth - Débat Mobile - Marché de Bourbourg - 05/12/2017	Si ça donne toujours du boulot pour les routiers, je ne peux être que demandeur. L’emploi avant tout !\r\n	49	375	\N	2017-12-08 17:33:20.827768	2017-12-08 17:33:20.992078	0	\N	\N	\N	\N	cndp-PROP-2017-12-342	\N	\N	\N
343	Yves D. - Débat Mobile - Marché de Bourbourg - 05/12/2017	La première chose qui m’interpelle, c’est l’incapacité à digérer les flux autoroutiers car j’ai l’impression que c’est déjà très congestionné. Il ne faut pas créer des no man’s land uniquement réservés à l’industrie.	49	375	\N	2017-12-08 17:38:09.426487	2017-12-08 17:38:09.603097	0	\N	\N	\N	\N	cndp-PROP-2017-12-343	\N	\N	\N
345	Jean-Pierre Marshall - Débat Mobile - Marché de Bourbourg - 05/12/2017	Il y a longtemps que l’agrandissement du port est prévu. Faites en sorte que ce projet soit l’occasion de lutter contre le risque de submersion marine. Je trouve que l’idée de se servir des gravas pour renforcer notre digue de côte et appréciable. Reste le problème des SEVESO.	49	375	\N	2017-12-08 18:38:27.846635	2017-12-08 18:38:27.962972	0	\N	\N	\N	\N	cndp-PROP-2017-12-345	\N	\N	\N
346	Claire M. - Débat Mobile - Marché de Bourbourg - 05/12/2017	J’habite Brouckerque, j’ai regardé la réunion récente de Loon-Plage sur Internet. Je déplore qu’il n’y ait pas eu de représentants de l’Etat ni des voies fluviales pour discuter des routes alors que l’enjeu pour Loon-Plage se situe notamment dans les impacts sur la circulation. Il faudrait plutôt penser le projet comme un écosystème, alors que nous avons l’impression qu’il est uniquement présenté comme un système financier avec cet argument facile : l’emploi et l’économie. 14 sites SEVESO : y’en a marre. Quand les gens quittent le territoire, ça n’est pas pour le manque d’emplois, mais à cause de la dégradation de la qualité de vie. Il y a par ailleurs des soucis avec les nappes phréatiques : or on creuse, on creuse, on creuse.	49	375	\N	2017-12-08 18:38:59.341228	2017-12-08 18:38:59.454518	0	\N	\N	\N	\N	cndp-PROP-2017-12-346	\N	\N	\N
347	François - Débat Mobile - Marché de Bourbourg - 05/12/2017	Tant que cela peut aider à concurrencer la Belgique et le Havre… Allons-y ! On a aussi notre mot à dire !	49	375	\N	2017-12-08 18:39:22.189247	2017-12-08 18:39:22.2029	0	\N	\N	\N	\N	cndp-PROP-2017-12-347	\N	\N	\N
144	Pollution locale (Question de abclocal  25/09/2017)	Bonjour \r\nAvec l'augmentation du nbre de camions, que faites vous pour la pollution engendrée sur les habitants des communes proches ? sans parler de la pollution visuelle (containers, grues et autres engins ne sont pas des plus agréables à regarder) ... \r\nQue croyez-vous que cet aménagement va amener sur le prix de l'immobilier des villes comme Gravelines ou Loon-Plage ? \r\nPar ailleurs, l'autoroute A25 est déjà surchargée, comment allez-vous réguler le trafic qui ne va qu'augmenter ? merci	51	375	\N	2017-10-02 14:44:04.40726	2017-10-02 14:44:04.487175	0	\N	\N	\N	\N	cndp-PROP-2017-10-144	\N	\N	\N
146	Combien et quand?	(question écrite lors de la réunion publique du 28/09)\r\n\r\nCela va coûter combien?\r\nQuand ce projet verra le jour?	51	375	\N	2017-10-02 15:12:09.695467	2017-10-02 15:12:09.736535	0	\N	\N	\N	\N	cndp-PROP-2017-10-146	\N	\N	\N
147	Outil d'analyse des impacts	(question écrite lors de la réunion publique du 28/09)\r\n\r\nL'ensemble du projet a beaucoup de projections optimistes sur les effets sur l'emploi et l'économie, ainsi que beaucoup de promesses sur la multimodalité.\r\nAvez-vous prévu un outil d'analyse a posteriori des impacts du projet?\r\nSi non, pouvez-vous vous engager sur un tel outil?	51	375	\N	2017-10-02 15:15:15.77205	2017-10-02 15:15:15.822482	0	\N	\N	\N	\N	cndp-PROP-2017-10-147	\N	\N	\N
338	Alerte au citoyens 	Habitant de loon plage et plus particulièrement à moins de 500 mètres de se monstrueux projet je dis non à se projet Atlantique. Pour diverses raisons. La première nous parlons partout de la montée des eaux du au réchauffement climatique et vous voulez nous ramener la mer à 2 pas de nos habitations. Ensuite la ville de loon plage sera complètement enclaver.sans compter de la valeur mobilière de nos habitations qui se verra automatiquement chuter. Qui voudrais habitez à côté de se gigantisme projet.  Imaginez un peu le bruit permanent qui va subsister de jour comme de nuit. Ce projet n est pas adapté et de trop grande ampleur. Même si pas pour non plus mais le projet baltique me parais déjà plus raisonnable.  Pourquoi agrandir le port alors que celui présent est casiment toujours vide. Voyant les grue de mon jardin je peu l affirmer.  Autre choses les habitants de gravelines n iront plus faire leurs achats sur la zone de grande synthe en vue de la déviation annoncé donc vous parlez de création d emploi mais vous éliminerai très certainement des emploi sur cette zone . Les habitants de loon plage qui travaillent  à gravelines se verront multiplier par 2 leurs temps de route et risquer un peu plus leurs vie sur la route avec un nombre incessant de camion. Ne parlons pas de l autoroute A16 déjà saturer à l heure actuelle. Un point encore très négatif  la pollution atmosphèrique qui s'élèvera encore plus que actuellement. Il n y a que des points négatif du point de vue des habitants et des usagers des routes du dunkerquois. Ce projet avez étais penser au temps du général de Gaulle mais celui ci est dépasser à l heure actuelle. Monsieur dé Gaulle ne savais pas qu'il y aurai de plus en plus de catastrophe naturelle et de Summersion marine du a la pollution. Donc non à se projet d un autre temps invraisemblable. Derniere grande réunion publique à gravelines sportica  le 14 décembre. Venez nombreux pour dire stop à ce monstre de projet. 	49	422	\N	2017-11-26 22:06:17.216589	2017-11-26 22:06:17.424586	0	\N	\N	\N	\N	cndp-PROP-2017-11-338	\N	\N	\N
341	Oui au Projet Baltique	Le projet atlantique favorise le trafic conteneurs. \r\nEn revanche le projet baltique est accès à la fois sur le conteneur, et sur le vrac afin de pérenniser les relations avec les usines tels que Arcelor Mittal. \r\nCe dernier à effectué des investissements considérables sur le site dunkerquois. Il faut lui  apporter les moyens nécessaires de décharger les navires d’un seul tenant afin de limiter les coûts et qu’Arcelor continue de faire confiance à notre port. \r\nCe qui serait favorable pour pérenniser les emplois existant et en créer de nouveaux grâce à l’augmentation des trafics, l’augmentation de la compétitivité de notre port sur son hinterland et sa capacité à attiré de nouveaux marchés. \r\nOUI au projet baltique!	49	424	\N	2017-12-05 19:34:55.498399	2017-12-05 19:34:55.65835	0	\N	\N	\N	\N	cndp-PROP-2017-12-341	\N	\N	\N
148	Nombre d'emplois réellemnt créés après travaux ?	16 000 emplois directs et indirects sur l'ensemble de la région des Hauts de France. Sachant que l'impact environnemental sera conséquent sur le littoral, que l'automatisation de la chaîne logistique ne sera pas neutre en terme d'emplois , sur combien d'emplois réels pouvons-nous tabler ?	49	374	\N	2017-10-04 15:00:03.319192	2017-10-04 15:00:03.38146	0	\N	\N	\N	\N	cndp-PROP-2017-10-148	\N	\N	\N
149	Qualité de l'air, des sols et des eaux.	Les derniers rapports de la DREAL sont préoccupants. Nos cours d'eaux ont une qualité très mauvaise. L'artificialisation des sols malgré un PLUHD un peu plus contraignant ainsi que le lessivage dû aux précipitations plus intensives font craindre que la sécurité sanitaire des populations n'est pas correctement assurée. Quant à la qualité de l'air, tout se passe de commentaire malgré des capteurs un peu plus nombreux mais qui n'ont pour fonction que l 'étude et on la réduction à la source. 	49	374	\N	2017-10-04 15:08:02.70486	2017-10-04 15:08:02.736381	0	\N	\N	\N	\N	cndp-PROP-2017-10-149	\N	\N	\N
151	Test de test par catégorie 1	Test de test par catégorie 1	52	358	\N	2017-10-12 08:11:21.442327	2017-10-12 08:11:21.48543	0	\N	\N	\N	\N	cndp-PROP-2017-10-151	\N	\N	\N
153	Avis de Gilbert M. - débat mobile Grande-Synthe	"Il ne faut pas qu'on perde nos emplois. Nous avons entendu parler de ce projet depuis X années. J'aurais été plus favorable à la version Baltique car il faut tout mettre en oeuvre pour maintenir Usinor"	49	375	\N	2017-10-12 15:45:00.65395	2017-10-12 15:45:00.712134	0	\N	\N	\N	\N	cndp-PROP-2017-10-153	\N	\N	\N
154	Avis de Thomas S. - débat mobile Grande-Synthe	"Oui au port mais il faut garantir la destination de ces emplois pour les habitants et non pour des travailleurs détachés. Nous devons tous gagner notre pain.\r\nOui à l'industrie, mais il faut aussi favoriser et préserver  les activités de loisirs en offrant un accès au littoral."	49	375	\N	2017-10-12 15:52:52.733292	2017-10-12 15:52:52.788489	0	\N	\N	\N	\N	cndp-PROP-2017-10-154	\N	\N	\N
156	Avis de Martine D. - débat mobile Grande-Synthe	" Je suis favorable pour des raisons d'emplois. Par contre, mes points de vigilance, c'est que les travaux n'affectent pas l'écosystème du littoral. Attention de ne pas uniquement se concentrer sur des orientations industrielles. Notre territoire a aussi une belle côte qui peut recevoir des activités touristiques. C'est aussi une économie!"	49	375	\N	2017-10-12 16:02:43.570033	2017-10-12 16:02:43.6261	0	\N	\N	\N	\N	cndp-PROP-2017-10-156	\N	\N	\N
158	Avis de Amine T. - débat mobile Grande-Synthe	"Depuis des décennies, les consultations sont des moyens de se donner bonne conscience. Une fois que c'est fait, on boit un coup. On dépense beaucoup d'argent public pour la pub. \r\nAujourd'hui, le pouvoir est dans les mains des industriels.\r\nLe méthanier, on a obtenu la maison de la nature. C'était une blague. Les associations ont manifesté, mais on n'en a pas tenu compte."	49	375	\N	2017-10-12 16:10:29.740551	2017-10-12 16:10:29.808993	0	\N	\N	\N	\N	cndp-PROP-2017-10-158	\N	\N	\N
339	Pollution lumineuse impact le territoire	La lumière artificielle peut avoir des effets néfastes sur notre environnement, surtout la nuit. C'est pour cela qu'il est question de pollution lumineuse. Une publication récente montre que cette pollution s'accroît un peu partout dans le monde.\r\n\r\nLes étonnantes images de la Terre éclairée par les lumières humaines  Saisies par le satellite Suomi NPP, de la NOAA et de la Nasa, ces images sont les premières depuis 2012 à montrer la planète entière de nuit. \r\n\r\nEn octobre dernier, Nicolas Hulot, ministre de la transition écologique et solidaire, annonçait la prochaine mise en œuvre de mesures pour protéger le ciel et l'écosystème nocturnes des méfaits de la pollution lumineuse. Il faut dire qu'il y a urgence : la surface du globe artificiellement éclairée la nuit a augmenté de 2,2 % chaque année entre 2012 et 2016. Et l'intensité de l'éclairage artificiel a progressé de 1,8 % par an sur la même période. Ce sont les conclusions d'une étude menée par des chercheurs du centre GFZ de recherche géophysique de Potsdam (Allemagne) à partir d'images satellite.\r\nRappelons que si l'on parle de pollution lumineuse, c'est que, la nuit notamment, la lumière artificielle peut avoir des effets néfastes sur notre environnement. Elle en a aussi sur notre santé. Ainsi, elle peut perturber notre cycle circadien et notre horloge biologique. Elle peut également perturber la dormance des végétaux.\r\n\r\nEt comme le port, sera à la porte de la ville, et que celui-ci fonctionnera 24h/24 7j/7, les habitants loonois seront les plus impactés encore une fois.\r\n\r\n\r\n\r\n	49	389	\N	2017-11-27 09:41:47.638034	2017-11-27 09:41:47.957603	0	\N	\N	\N	\N	cndp-PROP-2017-11-339	\N	\N	\N
178	Avis de Christelle C - Débat Mobile Dunkerque	"Oui pour le projet à condition de faire attention à l’environnement et au développement social de Dunkerque. Il y a déjà des usines qui dégagent des fumées toxiques. Ne refaisons pas les mêmes erreurs, pensons à la santé publique."	49	375	\N	2017-10-15 16:06:19.956386	2017-10-15 16:06:19.978313	0	\N	\N	\N	\N	cndp-PROP-2017-10-178	\N	\N	\N
179	Avis de Sylvie A. - débat mobile Grande-Synthe	"Nous sommes favorables au projet, pour l’emploi. Dommage qu’il n’y ait pas d’emploi pour les filles et les femmes."	49	375	\N	2017-10-15 16:08:35.625228	2017-10-15 16:08:35.635051	0	\N	\N	\N	\N	cndp-PROP-2017-10-179	\N	\N	\N
150	Limites de la représentation démocratique.	Question posée par Pascal le  01/10/2017   ( https://participons.debatpublic.fr/processes/6/f/49/proposals/141 )\r\n\r\n \r\nPuisqu'au final seuls les élus avaliseront ou non ce projet et sachant que la quasi majorité d'entre eux y est favorable pourquoi ce débat ?	51	375	\N	2017-10-11 07:54:33.811187	2017-10-11 07:55:27.653724	0	\N	accepted	2017-10-11 07:55:27.632702	{"fr": "<p>Ce ne sont pas les élus du dunkerquois qui décideront de la suite à donner au projet soumis au débat mais bien les instances dirigeantes du port. Rappelons que celui-ci est un établissement public de l’Etat placé sous une double tutelle ministérielle et donc dépendante des autorités gouvernementales.</p><p>Le débat servira à faire connaître à ces instances et à ces autorités les points de vue des participants tels qu'ils s’exprimeront après une présentation large du projet &nbsp;et au terme d’un échange approfondi d’arguments. </p><p>Trop souvent, nos concitoyens déplorent que les décisions soient prises sans qu’ils ne soient consultés. Cela aboutit parfois axe mauvaises décisions ou à des décisions incomplètes qui du coup font l’objet de contestations.</p><p>Cela ne sera pas le cas avec le projet du port de Dunkerque qui sera soumis à un examen systématique à l’occasion des quelques 70 rendez-vous du débat. En février, la commission rapportera les positions des uns et des autres, listera les arguments entendus, fera les recommandations nécessaires au maître d’ouvrage. &nbsp;Après lecture de ce rapport, les instances du port, toutes les institutions ( Région, Etat, Europe ) appelées à financer le projet, auront des éléments pour prendre les décisions en toute connaissance des opinions exprimées. Elles diront au printemps 2018 si elles poursuivent le projet ou non, si elles le modifient et dans quelle mesure, comment le cas échéant si elles entendent l’améliorer.</p><p>Si vous même à la lecture du dossier du maître d’ouvrage, vous avez une opinion et des observations à &nbsp;faire entendre, vous pouvez vous exprimer librement. Soit en posant une question, soit en déposant un avis , soit en participant au forum de discussion. Vous serez le bienvenu aux rencontres publiques ou &nbsp;lors des débats mobiles, vous en trouverez le calendrier en page d’accueil. </p><p> </p><p><strong>Jacques Archimbaud </strong></p><p>Président de la Commission du débat</p>"}	cndp-PROP-2017-10-150	\N	\N	\N
152	Et notre santé dans tout ça?	J'ai une proposition : Mettez nos moyens économiques plutôt au service de notre qualité de vie, à de vraies analyses de la qualité de l'air, à un déploiement de médecins généralistes et spécialisés ...plutôt que de venir rajouter une couche aux nuisances actuelles. Quel est votre intérêt  dans ce projet qui nous glace d'effroi sur les nuisances à venir ? 	50	384	\N	2017-10-12 11:36:52.399049	2017-10-12 11:36:52.460022	0	\N	\N	\N	\N	cndp-PROP-2017-10-152	\N	\N	\N
155	Avis d' Hélène D. - débat mobile Grande-Synthe	"Je suis concernée, surtout pour le bruit! J'entends les hauts-parleurs depuis ma fenêtre, j'habite à côté, à Petite-Synthe.\r\nLes emplois? Mon voisin est docker. Normal, Dunkerque, c'est Dunkerque"	49	375	\N	2017-10-12 15:57:52.519701	2017-10-12 15:57:52.585909	0	\N	\N	\N	\N	cndp-PROP-2017-10-155	\N	\N	\N
157	Avis de Afdal L. - débat mobile Grande-Synthe	"Je suis favorable car l'avenir n'est plus dans le nucléaire, donc il faut renforcer l'activité portuaire. Bien entendu, il faut encourager l'emploi pour nos enfants. L'emploi est difficile. Il faut mettre l'accent sur la formation et arrêter le piston. De l'emploi, oui. Mais de l'emploi pour tous.\r\nMa fille a 16 ans, je l'invite à se mettre à l'informatique pour en trouver dans la logistique."	49	375	\N	2017-10-12 16:05:57.032344	2017-10-12 16:05:57.089358	0	\N	\N	\N	\N	cndp-PROP-2017-10-157	\N	\N	\N
340	La charrue avant les boeufs	Ayant participé à plusieurs réunions publiques, je m'aperçois et regrette que le GPMD semble ne prendre aucune garantie à ce que l'augmentation du flux de conteneurs puise se faire autrement que par camion.\r\nLe réseau fluvial actuel n'est pas adapté. la mise aux normes des écluses n'est pas à l'ordre du jour pour VNF. \r\nLe réseau ferré n'est pas apte actuellement à absorber un afflux de conteneurs, la problème du nœud ferroviaire d'Hazebrouck n'a pas été étudié. Si Pourra-t-on atteindre un pourcentage de trafic de conteneurs souhaitable par voie ferrée compatible avec le trafic voyageur actuel au départ de Dunkerque ?\r\nEnfin, l'augmentation du trafic par camion est inacceptable vis à vis de la saturation des autoroutes A 16 et A 25 et de la D 300, sans parler des nombreux problèmes environnementaux et de santé publiques engendrés.\r\nNe mettons pas la charrue avant les bœufs. Les travaux d’agrandissement du quai de Flandre qui ont lieu en ce moment devraient servir de test pour décider ou non dans les années futures de lancer un nouveau projet d'expansion.\r\nNe prenons pas de risques si hasardeux pour notre territoire. 	49	423	\N	2017-12-04 20:58:07.647243	2017-12-04 20:58:07.920527	0	\N	\N	\N	\N	cndp-PROP-2017-12-340	\N	\N	\N
344	Stéphane R. - Débat Mobile - Marché de Bourbourg - 05/12/2017	Dans mon coin, à Craywick, quand tu manges dehors, tu n’as pas besoin de poivrer tellement on nous crache de la poussière 	49	375	\N	2017-12-08 17:39:02.89449	2017-12-08 17:39:02.96751	0	\N	\N	\N	\N	cndp-PROP-2017-12-344	\N	\N	\N
351	Paul M. – Débat Mobile - Gare de Dunkerque – 07/12/2017	Il n’y a pas de temps à perdre ! Ce projet aurait dû être fait il y a 40 ans. On a le terrain, la logistique doit être bien pensée. La richesse d’un port, c’est d’avoir des lignes qui tournent à plein régime. Faisons l’Atlantique, le Baltique ou le Pacifique. Mais cela devient urgent ! Le problème des gens c’est qu’ils n’ont pas la vue sur le port. Il faut que la population se réapproprie cette vision. 	49	375	\N	2017-12-09 17:28:59.426982	2017-12-09 17:28:59.485707	0	\N	\N	\N	\N	cndp-PROP-2017-12-351	\N	\N	\N
159	Avis de Alfredo S. - débat mobile Grande-Synthe	" Ils ont fermé Dunkerque à cause des bas salaires et des grèves. Du coup, les salariés sont allés voir ailleurs ou sont au chômage. Ce projet, c'est bénéfique; ce qui veut dire plus d'emploi pour les jeunes."	49	375	\N	2017-10-12 16:13:25.513734	2017-10-12 16:13:25.606323	0	\N	\N	\N	\N	cndp-PROP-2017-10-159	\N	\N	\N
160	Avis de Bernard S. - débat mobile Grande-Synthe	" Plus de conteneurs, ça sera plus de camions, donc plus de CO² dans l'atmosphère.\r\nIls disent, mais souvent n'agissent pas.\r\nArrêtons de se raconter des histoires. Notre activité passera aussi par le tourisme. Le film sur Dunkerque en témoigne."	49	375	\N	2017-10-12 16:16:41.935253	2017-10-12 16:16:41.989866	0	\N	\N	\N	\N	cndp-PROP-2017-10-160	\N	\N	\N
161	Avis de Frédéric L. - débat mobile Grande-Synthe	"Le port, on ne le voit pas, mais on l'entend et on le sent. Il y a deux solutions, mais ce sera la solution Atlantique et pas le Baltique, j'habite à côté.\r\nLes conteneurs, je les connais, on les achemine, on les empile, ça fait du bruit, de jour comme de nuit."	49	375	\N	2017-10-12 16:18:47.115514	2017-10-12 16:18:47.165287	0	\N	\N	\N	\N	cndp-PROP-2017-10-161	\N	\N	\N
162	Recommandation 1	Voici la première recommandation 	54	385	\N	2017-10-13 15:05:32.413077	2017-10-13 15:05:32.456328	1	\N	\N	\N	\N	cndp-PROP-2017-10-162	\N	\N	\N
163	Recommandation 2	2e recommandation 	54	385	\N	2017-10-13 15:14:54.193747	2017-10-13 15:14:54.233628	0	\N	\N	\N	\N	cndp-PROP-2017-10-163	\N	\N	\N
164	Test à modérer Test à modérer Test à modérer Test à modérer 	Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer Test à modérer 	52	387	\N	2017-10-14 10:33:20.60854	2017-10-14 10:33:20.643846	0	\N	\N	\N	\N	cndp-PROP-2017-10-164	\N	\N	\N
165	Titre - Quelle longueur pour éviter "trop court" ?	Texte - Quelle longueur pour éviter "trop court" ?	52	387	\N	2017-10-14 10:34:33.102122	2017-10-14 10:34:33.140549	0	\N	\N	\N	\N	cndp-PROP-2017-10-165	\N	\N	\N
166	A234567890A234567890	A234567890A234567890	52	387	\N	2017-10-14 10:38:52.10413	2017-10-14 10:38:52.111662	0	\N	\N	\N	\N	cndp-PROP-2017-10-166	\N	\N	\N
167	A234567890A2345678	A234567890A2345678	52	387	\N	2017-10-14 10:39:59.548897	2017-10-14 10:39:59.573049	0	\N	\N	\N	\N	cndp-PROP-2017-10-167	\N	\N	\N
168	A234567890A23456	A234567890A23456	52	387	\N	2017-10-14 10:40:39.135708	2017-10-14 10:40:39.14187	0	\N	\N	\N	\N	cndp-PROP-2017-10-168	\N	\N	\N
180	Avis de Jacques P. - Débat Mobile Grande-Synthe	"Le port est mort, tout est automatique. Qu’ils fassent le projet, mais il ne créera pas tous les emplois annoncés."	49	375	\N	2017-10-15 16:09:56.4773	2017-10-15 16:09:56.537602	0	\N	\N	\N	\N	cndp-PROP-2017-10-180	\N	\N	\N
181	Avis de Bernard Viaud - débat mobile Dunkerque	"Le développement du port est une meilleure option que le Canal Seine-Nord qui va favoriser le développement des ports d'Anvers, Rotterdam. On va leur créer un boulevard. Quitte à investir, autant le faire pour le développement des ports et non au profit de la concurrence étrangère."	49	375	\N	2017-10-17 08:24:19.183025	2017-10-17 08:24:19.274801	0	\N	\N	\N	\N	cndp-PROP-2017-10-181	\N	\N	\N
182	Stéphane T. - Débat Mobile Dunkerque	"Baltique ? Ok si on ne supprime pas le terrain de moto-cross. Mon petit frère est docker depuis 3 ans. Je pense à la famille, je suis pour ce projet d'extension."	49	375	\N	2017-10-17 08:45:31.774862	2017-10-17 08:45:31.870806	0	\N	\N	\N	\N	cndp-PROP-2017-10-182	\N	\N	\N
183	Maxence Fasquez - débat mobile Dunkerque	"Il est important de mettre l'accent sur l'emploi. Le projet Baltique concilie industrie et commerce et qualité de vie et est à mes yeux plus logique et rentable."	49	375	\N	2017-10-17 08:47:00.674614	2017-10-17 08:47:00.704309	0	\N	\N	\N	\N	cndp-PROP-2017-10-183	\N	\N	\N
184	Isabelle G. - débat mobile Dunkerque	"On est déjà suffisamment pollué par les usines. C'est pas suffisamment surveillé. Ne me faites pas croire qu'ils mettent des filtres. Un port plus grand ? C'est plus de camions, de transports donc plus de pollution. Quand on voit les impôts qu'on paye pour la qualité de vie qu'on a. il faut faire taxer les industries. il faut faire un port durable. Pour la jeunesse c'est une économie d'avenir."	49	375	\N	2017-10-17 08:50:53.641626	2017-10-17 08:50:53.753057	0	\N	\N	\N	\N	cndp-PROP-2017-10-184	\N	\N	\N
185	Sébastien P. - débat mobile Dunkerque	"Pensons aux générations futures ! Il faut de l'emploi. Le port est un moteur pour tout le reste : emploi, commerce, tout est lié. Le projet va se faire. La Baltique ? c'est l'Atlantique qui va se faire, c'est dommage pour ArcelorMittal."	49	375	\N	2017-10-17 08:54:18.87923	2017-10-17 08:54:18.888155	0	\N	\N	\N	\N	cndp-PROP-2017-10-185	\N	\N	\N
188	Patrick M. - débat mobile Dunkerque	"16000 emplois c'est bien mais c'est toujours les mêmes qui ont du travail. Je vais aux boîtes d’intérim mais rien! C'est toujours pareil, on embauche à la tête du client! Inversons la tendance! Donnons la chance à ceux qui ne sont pas favorisés. Il faut faire le tri."	49	375	\N	2017-10-17 09:15:00.069412	2017-10-17 09:15:00.155736	0	\N	\N	\N	\N	cndp-PROP-2017-10-188	\N	\N	\N
192	Marie-Claude Shakeshaft - débat mobile Rosendaël	"Dunkerque bouge ! L'extension du port ne sera que plus bénéfique pour le territoire. Faisons de Dunkerque un territoire vivant pour les 100 prochaines années."	49	375	\N	2017-10-17 09:58:03.573477	2017-10-17 09:58:03.665556	0	\N	\N	\N	\N	cndp-PROP-2017-10-192	\N	\N	\N
171	Avis de Maxence F. - Débat Mobile Dunkerque	"Important de mettre l’accent sur l’emploi. Le projet Baltique concilie industrie, commerce et qualité de vie et est à mes yeux plus logique et rentable."	49	375	\N	2017-10-15 15:50:36.12503	2017-10-15 15:50:36.225358	0	\N	\N	\N	\N	cndp-PROP-2017-10-171	\N	\N	\N
172	Avis d'Isabelle G. - Débat mobile Dunkerque	"On est déjà suffisamment pollués par les usines. Ce n’est pas suffisamment surveillé, ne me faites pas croire qu’ils mettent des filtres ! Un port plus grand, c’est plus de camions donc plus de pollution. Il faudrait taxer les industries pour faire du port un port durable. Pour la jeunesse, c’est l’économie de l’avenir."\r\n\r\n\r\n	49	375	\N	2017-10-15 15:52:43.111266	2017-10-15 15:52:43.143429	0	\N	\N	\N	\N	cndp-PROP-2017-10-172	\N	\N	\N
173	Avis de Christian L. - Débat Mobile Dunkerque	"J’ai connu le port à l’âge de 9 ans. Il marchait de plein feu. Aujourd’hui, c’est triste, l’activité n’a plus rien à voir depuis que les dockers sont partis. Avant, il y avait du contact, de l’humain. J’espère que cette extension permettra de retrouver cet univers. Mes enfants sont à Marseille et à Paris. Pouvoir travailler à Dunkerque serait une aubaine."	49	375	\N	2017-10-15 15:54:07.205458	2017-10-15 15:54:07.256221	0	\N	\N	\N	\N	cndp-PROP-2017-10-173	\N	\N	\N
174	Avis de Sébastien P. - Débat Mobile Dunkerque	"Il faut de l’emploi pour les générations futures. Le port est un moteur pour l’emploi, le commerce, tout est lié. Si c’est Atlantique qui se fait, ce sera dommage pour Arcelor."	49	375	\N	2017-10-15 15:58:34.011878	2017-10-15 15:58:34.045698	0	\N	\N	\N	\N	cndp-PROP-2017-10-174	\N	\N	\N
176	Bertrand F. - Débat Mobile Dunkerque	"C’est positif pour l’emploi et en changeant ainsi de dimension, nous gagnerons en attractivité sur le plan économique. Mais le problème, c’est que le projet risque de défigurer le paysage."\r\n	49	375	\N	2017-10-15 16:03:06.643001	2017-10-15 16:03:06.664221	0	\N	\N	\N	\N	cndp-PROP-2017-10-176	\N	\N	\N
186	Bertrand F. - débat mobile Dunkerque	"Le projet est positif pour l'emploi mais son problème c'est le risque de défigurer le paysage. Autre avantage : Nous entrons dans une autre dimensions. Nous gagnerons en activité sur le plan économique."	49	375	\N	2017-10-17 08:59:26.094512	2017-10-17 08:59:26.162457	0	\N	\N	\N	\N	cndp-PROP-2017-10-186	\N	\N	\N
190	Sylvain A. - débat mobile Dunkerque	"Favorable au projet par l'emploi. Dommage qu'il n'y ait pas d'emplois pour les filles et les femmes."	49	375	\N	2017-10-17 09:18:24.69844	2017-10-17 09:18:24.723658	0	\N	\N	\N	\N	cndp-PROP-2017-10-190	\N	\N	\N
348	Jean-Jacques - Débat Mobile - Marché de Bourbourg - 05/12/2017	Les camions, on n’en veut plus ! Il y en a trop ! Le samedi, c’est un véritable défilé pour aller à Lille. De toute façon, ce ne sont que des étrangers. Des chauffeurs locaux, je n’y crois pas. Qu’on fasse le canal Seine-Nord avant de faire ce projet.	49	375	\N	2017-12-08 18:39:48.357973	2017-12-08 18:39:48.373435	0	\N	\N	\N	\N	cndp-PROP-2017-12-348	\N	\N	\N
349	Francis Rubbens - Débat Mobile - Marché de Bourbourg - 05/12/2017	La voie ferrée devrait commencer à la Belgique. Les camions embarqueraient à la frontière et non à Calais. Privilégier le ferroutage et non faire une 3ème voie sur l’A16. L’autoroute est nocive. Faites une enquête sur le taux de cancers dans la région, vous serez surpris. J’en ai un... Le combat contre la pollution reste un enjeu primordial pour vivre sur un territoire.	49	375	\N	2017-12-08 18:40:11.386799	2017-12-08 18:40:11.396396	0	\N	\N	\N	\N	cndp-PROP-2017-12-349	\N	\N	\N
350	Carl Leroy - Débat Mobile - Marché de Bourbourg - 05/12/2017	Comment on fait pour nourrir le peuple ? Vous êtes en train de supprimer les terres agricoles. Vous les avez achetées pour une bouchée de pain. Et l’argument de l’emploi, ce n’est pas juste !\r\n	49	375	\N	2017-12-08 18:40:38.429148	2017-12-08 18:40:38.592807	0	\N	\N	\N	\N	cndp-PROP-2017-12-350	\N	\N	\N
356	Delphine Vandenkoornhuyse - Débat Mobile - Salon de l’Etudiant - 08/12/2017	Je suis conseiller-développeur dans un CFA. La formation est au cœur de mon métier. Je suis favorable à ce projet car il va permettre de générer du travail notamment pour les personnes peu qualifiées.	49	375	\N	2017-12-09 17:33:33.574547	2017-12-09 17:33:33.626788	0	\N	\N	\N	\N	cndp-PROP-2017-12-356	\N	\N	\N
187	Fabien Cyn - débat mobile Dunkerque	"Ça coûte de l'argent. Ils vont avoir plein de commerces mais beaucoup d'autres vont fermer. A t-on encore besoin d'un port dans un pays pauvre ? Il y a beaucoup de pauvreté. Pourquoi fermer une école maternelle pour ouvrir un commerce ? Le projet est de trop grande envergure : On peut rénover. 16000 emplois ? Mais pour combien de temps ? Je l’espère de tout cœur mais je doute ! Les conteneurs est-ce qu'on peut dire que c'est raffiné pour un projet moderne ?"	49	375	\N	2017-10-17 09:03:44.383266	2017-10-17 09:03:44.435387	0	\N	\N	\N	\N	cndp-PROP-2017-10-187	\N	\N	\N
352	Guillaume Senane - Débat Mobile - Salon de l’Etudiant - 08/12/2017	Mes commentaires à propos du questionnaire de la commission : \r\n\r\nConcernant la question n°2 : Non, je n’approuve pas l’orientation du port qui vise à développer la filière conteneur. Je pense qu’il faut relocaliser la production et éviter le transport (voie maritime, voie routière : polluante et destructrice). \r\n\r\nConcernant la question n°3 et l’objectif de multiplier par 7 le nombre de conteneurs traités, le port n’est pas une entité hors-sol. Le projet doit être mis en cohérence avec son environnement. Les conteneurs vont sortir du périmètre portuaire. Où vont-ils alors se retrouver ? Sur l’A16 qui est déjà saturée. Le port va-t-il financer l’élargissement de l’A16, l’entretien des routes qui vont être très dégradées par le passage incessant de camions lourdement chargés, financer les dépenses de santé que les habitants vont devoir engager pour pallier la pollution de l’air qu’ils vont subir… Il y a une grande externalisation des coûts.\r\nLe port est un établissement public au service de l’intérêt général. Tout ne doit pas être sacrifié sur l’autel du sacro-saint « emploi ». Il y a d’autres choses à faire qui permettraient d’offrir des emplois de meilleure qualité, de préserver notre qualité de vie, notre santé, notre cadre de vie. On peut comparer ce projet, dont la vision est de courte vue, aux projets de Notre Dame de Landes, Sivens…	49	375	\N	2017-12-09 17:30:13.324746	2017-12-09 17:30:13.365076	0	\N	\N	\N	\N	cndp-PROP-2017-12-352	\N	\N	\N
353	Jean-Yves S. – Débat Mobile - Salon de l’Etudiant - 08/12/2017	Attention : On marche sur la tête. Cette histoire me fait penser à l’implantation du centre de tri de La Poste. Ils se sont posé la question des flux après s’être installés, générant des problèmes de sécurité. C’est le même problème avec le port qui me donne l’impression de se poser la question de la desserte seulement après. Il faut que le port arrête de se croire seul au monde. Ils sont un peu dans une bulle.	49	375	\N	2017-12-09 17:31:26.514425	2017-12-09 17:31:26.5817	0	\N	\N	\N	\N	cndp-PROP-2017-12-353	\N	\N	\N
354	Anne-Sophie Sagnier – Débat Mobile - Salon de l’Etudiant - 08/12/2017	J’habite à Watten, au dessus de Bourbourg. Je travaille à Dunkerque. Aujourd’hui, pour me rendre au travail, je ne prends plus l’A16. Les conditions de circulation sont trop aléatoires. Je préfère prendre les routes de campagne plus fiables et confortables. Je m’interroge donc sur la capacité du réseau à supporter cet afflux de camion. 	49	375	\N	2017-12-09 17:31:58.062538	2017-12-09 17:31:58.081481	0	\N	\N	\N	\N	cndp-PROP-2017-12-354	\N	\N	\N
189	Christelle L. - débat mobile Dunkerque	"Oui pour le port à condition de faire attention à l'environnement et au développement social de Dunkerque et ses environs. Il y a déjà des usines qui dégageaient des fumées toxiques. Ne refaisons pas les mêmes erreurs. Pensons à la santé publique."	49	375	\N	2017-10-17 09:17:20.637786	2017-10-17 09:17:20.693331	0	\N	\N	\N	\N	cndp-PROP-2017-10-189	\N	\N	\N
191	Jean-Jacques P. - débat mobile Dunkerque	"Le port est mort. Tout est automatique. Qu'il fasse mais le projet ne créera pas les emplois annoncés, quelques uns c'est tout."	49	375	\N	2017-10-17 09:20:25.440237	2017-10-17 09:20:25.48265	0	\N	\N	\N	\N	cndp-PROP-2017-10-191	\N	\N	\N
355	Emmanuel Mathieu - Débat Mobile - Salon de l’Etudiant - 08/12/2017	Je suis favorable à ce projet, sinon Dunkerque va faire du surplace. Par contre j’ai entendu récemment que Dunkerque faisait peur au Havre. Ça témoigne que nous sommes sur une dynamique. Il faut poursuivre mais préserver notre qualité de vie. Dunkerque est un carrefour multimodal mais il faut préserver la fluidité des voitures. L’A16 est déjà saturée. 	49	375	\N	2017-12-09 17:32:48.839064	2017-12-09 17:32:48.924992	0	\N	\N	\N	\N	cndp-PROP-2017-12-355	\N	\N	\N
193	Jean-Pierre - débat mobile Rosendaël	"L'argument de l'emploi, c'est de l'attrape pigeon ! Dunkerque va bouffer Anvers en raison de notre positionnement stratégique et géographique."	49	375	\N	2017-10-17 10:02:16.284052	2017-10-17 10:02:16.340215	0	\N	\N	\N	\N	cndp-PROP-2017-10-193	\N	\N	\N
194	Stéphane - débat mobile Rosendaël	"Tertiaire, dockers, extension des voies routières... Ce projet va permettre de restructurer et de simplifier le réseau routier, les locaux qui auront trouvé un emploi grâce au projet se déplaceront plus facilement en véhicule ou en transport en commun."	49	375	\N	2017-10-17 10:05:12.675469	2017-10-17 10:05:12.697956	0	\N	\N	\N	\N	cndp-PROP-2017-10-194	\N	\N	\N
195	Mariette - débat mobile Rosendaël	"Écologiquement il est intéressant de reconstituer une plage arrière selon le modèle actuel ! La configuration actuelle au fur et à mesure de la réalisation des phases engage l'accompagnement de ces phases."	49	375	\N	2017-10-17 10:07:50.378526	2017-10-17 10:07:50.425058	0	\N	\N	\N	\N	cndp-PROP-2017-10-195	\N	\N	\N
196	Valentine - débat mobile Rosendaël	"C'est un projet gigantesque. Dunkerque n'a pas d'avenir, c'est trop tard. Personne ne veut vivre à Dunkerque."	49	375	\N	2017-10-17 10:09:30.5044	2017-10-17 10:09:30.529707	0	\N	\N	\N	\N	cndp-PROP-2017-10-196	\N	\N	\N
197	Lucien - débat mobile Rosendaël	"Avant il y avait des remorques en nombre et de la vie à Dunkerque. Je suis marin, retraité : j'ai bien vu ! J'ai du chagrin de voir ce port vide, sans mouvement. Qu'ils y remettent de l'activité, ça fera du boulot."	49	375	\N	2017-10-17 10:13:09.811564	2017-10-17 10:13:09.86157	0	\N	\N	\N	\N	cndp-PROP-2017-10-197	\N	\N	\N
198	Jean-Luc - débat mobile Rosendaël	"J'ai un avis favorable pour le projet Baltique à cause de l'effet de coupure d'Atlantique qui implique une réorganisation du trafic. Notamment concernant la circulation sur l'A16. Il y a une nécessite de mettre en application l'écotaxe qui existe en Belgique. L'argent récupéré irait au développement des infrastructures routières et de leur entretien. 9a n'est pas à la région de payer pour les travailleurs expatriés (roumains, polonais etc.)"	49	375	\N	2017-10-17 10:17:34.36907	2017-10-17 10:17:34.411583	0	\N	\N	\N	\N	cndp-PROP-2017-10-198	\N	\N	\N
199	Christophe D. - débat mobile Rosendaël	"Ce qu'il faut à Dunkerque, c'est retrouver le dynamisme du port. Le port, c'est notre cœur. On a le port dans nos tripes."	49	375	\N	2017-10-17 10:24:17.280042	2017-10-17 10:24:17.332809	0	\N	\N	\N	\N	cndp-PROP-2017-10-199	\N	\N	\N
201	Hervé X - débat mobile Rosendaël	"Je ne suis pas contre ces projets mais c'est 10 fois trop long. La chance nous sourit ! Faisons-le !"	49	375	\N	2017-10-17 10:27:51.550981	2017-10-17 10:27:51.566215	0	\N	\N	\N	\N	cndp-PROP-2017-10-201	\N	\N	\N
202	Gérard L. - Débat Mobile Malo-les-Bains	Ce projet est le produit de la mondialisation. Dans ces boites, rien n'est produit en France. Bilan, nous risquons d'asphyxier nos petits commerces et de tuer nos petites entreprises. Malheureusement, nous sommes dans l'engrenage. Avons-nous le choix ?	49	375	\N	2017-10-23 08:29:33.613584	2017-10-23 08:29:33.845635	0	\N	\N	\N	\N	cndp-PROP-2017-10-202	\N	\N	\N
203	Rosalie R. - Débat Mobile Rosendaël 	Dunkerque, c'est le carrefour de l'Europe. Il doit obligatoirement prendre une expansion européenne voire internationale. Les études doivent être réalistes. Si c'est pour 4 porte-conteneurs, à voir. Beaucoup d'ambition. C'est beau de nous mettre des chiffres, je ne suis pas encore convaincue.	49	375	\N	2017-10-23 08:48:16.540999	2017-10-23 08:48:16.610076	0	\N	\N	\N	\N	cndp-PROP-2017-10-203	\N	\N	\N
357	Avis de  Yves-Marie Bonnaillie, Gravelines Les Huttes	Je suis opposé au projet Atlantique, de plus il n'y a pas de politique pour le ferroutage.	49	375	\N	2017-12-11 09:04:26.036919	2017-12-11 09:04:26.547552	0	\N	\N	\N	\N	cndp-PROP-2017-12-357	\N	\N	\N
225	Serge M. - Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"Je suis dans l’immobilier, le projet est bien pour la ville, il y aura un effet domino pour le commerce."	49	375	\N	2017-10-31 14:25:04.091422	2017-10-31 14:25:04.16101	0	\N	\N	\N	\N	cndp-PROP-2017-10-225	\N	\N	\N
367	Baltique plutôt que Atlantique !	Le projet Atlantique serait :\r\n- une grave atteinte au cadre de vie des habitants environnants :\r\n=> notamment parce que les loonois se retrouveraient isolés\r\n=> les gravelinois devraient faire un contournement énorme pour aller vers loon plage, engendrant un grand changement dans la circulation. En effet tout le trafic, notamment aux heures de pointe, entre gravelines et le reste de la CUD serait basculé vers bourbourg, au lieu d'être équilibré entre bourbourg et loon-plage. Un pont dans ces cas-là ?\r\n=> Les gravelinois et loonois sont déjà suffisamment entourés d'usines. Des nouveaux Fort-Mardyck en perspective ?\r\n\r\nLe projet baltique serait :\r\n- Sur des terres déjà industrialisées, au coeur des entreprises nécessitant un accès facile au port.\r\n\r\nLes arguments contre le projet baltique serait :\r\n=> un coût plus important de déblaiement. Quel est le coût pour le cadre de vie des habitants ? comment sera-il chiffré ? Aucun projet industriel lourd n'a jamais amélioré le cadre de vie. (cf Fort Mardyck ?)\r\n=> une perte des compensations écologiques du terminal méthanier, eh bien utilisons la zone du projet atlantique pour créer un vaste espace "poumon vert" entre le PAarc de l'AA et le parc galamé de loon plage ! Voilà qui améliorera le cadre de vie des habitants !\r\n\r\nDe plus, soyons réalistes, l'emploi ne peut être un argument valable. Surtout dans le cadre d'un port de conteneurs, l'avenir est à l'automatisation. De plus, la concurrence des Pays-Bas, au plein cœur du poumon économique de l'Europe, fait que les objectifs de conteneurs seront parfaitement irréalistes.\r\n\r\nLe projet Atlantique aurait dû être fait il y a 30 ans, comme imaginé au départ. Désormais, l'étendue de Loon-Plage fait de cette ville la première sacrifiée.\r\n\r\nPour toutes ces raisons, le choix ne peut être que Baltique.\r\n	49	433	\N	2017-12-16 06:40:13.271465	2017-12-16 06:40:13.472591	0	\N	\N	\N	\N	cndp-PROP-2017-12-367	\N	\N	\N
369	Impacts sur les filières locales	Quels impacts ce projet aura-t-il pour les industries locales, les agriculteurs et les artisans de la région ? L'extension du port facilitera l'entrée massive de produits concurrentiels pour les filières locales. \r\n\r\nA combien s'élèvent les prévisions de fermeture de PME et entreprises individuelles locales ?\r\n\r\nMerci	49	434	\N	2017-12-17 23:21:44.680569	2017-12-17 23:21:44.742527	0	\N	\N	\N	\N	cndp-PROP-2017-12-369	\N	\N	\N
380	Contribution de Total - Etablissement des Flandres	L'Etablissement des Flandres - Total - Raffinage-Chimie a adressé ce courrier contributif, au GPMD et à la CPDP.	49	375	\N	2017-12-19 10:41:36.585807	2017-12-19 10:41:36.798058	0	\N	\N	\N	\N	cndp-PROP-2017-12-380	\N	\N	\N
385	Avis de la commune de Bourbourg	Le maire de Bourbourg dépose ce courrier comme avis sur le projet du Port de Dunkerque	49	375	\N	2017-12-22 19:24:25.429459	2017-12-22 19:24:25.610898	0	\N	\N	\N	\N	cndp-PROP-2017-12-385	\N	\N	\N
200	Jean-Marie L. - débat mobile Rosendaël	"Avec ce projet, il y en a un qui va faire la tête, c'est le 1er ministre car cela va nous permettre d'être plus compétitif vis-à-vis du Havre."	49	375	\N	2017-10-17 10:26:25.108313	2017-10-17 10:26:25.170293	0	\N	\N	\N	\N	cndp-PROP-2017-10-200	\N	\N	\N
358	Impacts sur le cadre de vie   	\r\nDifficile de juger de l' opportunité  du projet .\r\n\r\n Par contre , s'il se réalise , on peut être très inquiet concernant l'aspect environnemental ,  et l'impact sur notre cadre de vie.\r\n \r\nDeux options de projet nous ont été  présentées, comme étant réalisables :\r\n         - Le projet Baltique et le projet Atlantique.\r\n\r\nOr , à priori le projet Atlantique récolte toutes les faveurs .\r\n \r\nSauf par les habitants de GRAVELINES et de LOON PLAGE , qui,  du coup, en sont encore  plus inquiets.\r\n\r\nLa proximité de ce port géant aux portes de nos deux villes  ,ne peut que nous interpeller .\r\n\r\nNous devrions subir ,c'est certain , une forte augmentation de la pollution de l' air et de la pollution sonore.\r\nSans compter , l'impact sur le visuel. et les désagrément d'un enclavement.\r\n\r\nIl est admis \r\n- Que les portes conteneurs émettent énormément de soufre .\r\n- La concentration en particules extra  fines à proximité des ports est  fortement avérée .\r\n- Que les  moteurs des bateaux tournent même à quai ( on nous dit que cela devrait changer ,mais cela    n' est pas pour maintenant ... ) \r\n- Effet nocif  des vapeurs provenant du traitement par fumigation des conteneurs\r\n\r\nPasser de 300 camions  par jour à 1200 camions aura un impact certain et évident en terme de nuisances et  notamment  sonores ( défilé de camions et engins de manutention..)\r\n\r\nEn fait , nous pouvons  partager , en tout point ,  les inquiétudes exprimées par les élus de Gravelines  , dans le Cahier d' Acteur qu'ils ont publiés dans  le cadre du débat public.\r\n\r\nIls soumettent au maître d'ouvrage 13 impératifs nécessaires .( cf Cahier d' acteur n°4 Nov 2017)\r\n\r\nMais on ne peut pas partager , du tout , leur optimisme .et leur seule réflexion sur le projet Atlantique.\r\n\r\nIl n 'y aura aucune garantie que tous ces impératifs soit respectés., une fois le projet réalisé.\r\nEt particulièrement l'impératif n°3  " Réduire au maximum l'impact environnemental " \r\n\r\nAussi en la matière , si la décision d' extension du port est prise, et puisque deux options nous sont proposées , essayons d'en limiter les impacts et appliquons le principe de prudence . \r\n\r\n A priori,  une partie de ces inquiétudes pourrait être levées , voire pour certaines , en totalité en\r\n  ADOPTANT LE PROJET BALTIQUE. \r\n\r\nLe projet Baltique , donnant plus  sur la mer, et dans une zone plus appropriée pourrait limiter les impacts sur le cadre de vie des deux villes les plus concernées  \r\n  	49	429	\N	2017-12-13 09:46:40.286683	2017-12-13 09:46:40.44506	0	\N	\N	\N	\N	cndp-PROP-2017-12-358	\N	\N	\N
360	Contribution du Medef Côte d'Opale	Contribution du Medef Côte d'Opale	52	358	\N	2017-12-14 10:37:59.778129	2017-12-14 10:37:59.877376	0	\N	\N	\N	\N	cndp-PROP-2017-12-360	\N	\N	\N
361	Contribution du Medef Côte d’Opale	\r\nMonsieur le Président,\r\n \r\nLe MEDEF Côte d’Opale prend une part active au débat public concernant le projet de création de nouveaux bassins portuaires « CAP 2020 » par le Grand Port Maritime de Dunkerque.\r\n \r\nNous avons énoncé des positions et formulé des propositions dans le Cahier d’Acteur que nous avons proposé à la Commission Particulière.\r\n \r\nCes positions et affirmations sont développées dans une contribution que nous versons au débat.\r\n \r\nNous sommes à la disposition de la Commission pour apporter toutes précisions utiles.\r\n \r\nVeuillez agréer, Monsieur le Président, l’expression de notre considération distinguée.\r\n \r\n \r\nPatrick GHEERARDYN,\r\nDélégué Général.\r\n 	49	375	\N	2017-12-14 10:45:27.674549	2017-12-14 10:45:27.741437	0	\N	\N	\N	\N	cndp-PROP-2017-12-361	\N	\N	\N
365	Contribution de la commune de Loon-Plage	A l'issue de la réunion publique qui s'est tenue dans sa ville, la municipalité de Loon-Plage acte son positionnement sur le projet CAP 2020 par le dépôt de cette contribution.	49	375	\N	2017-12-15 11:14:01.151404	2017-12-15 11:14:01.18153	0	\N	\N	\N	\N	cndp-PROP-2017-12-365	\N	\N	\N
366	Loon-Plage et ses habitants sacrifiés!!	J'ai suivi et participé aux différents débats, aussi peu utiles soient-ils dans la mesure où les choses sont actées et les travaux commencé. On fait croire à la démocratie participative? Il n'en est rien. Je vis à Loon-Plage et depuis 1 mois nous avons un échantillon tous les jours (jusque 23h minimum) des nuisances qui nous attendent. Un tapage métallique régulier et insoutenable!! Ensuite viendra le temps des poids lourds, de la pollution...Je voudrai dire aux habitants de Dunkerque centre, Rosendaël... que si le projet les intéresse tant, ils peuvent le prendre car leurs maisons ne vont pas dévaluer comme les notres, et leur vie n'en sera pas changée!\r\nLoon-Plage et ses habitants vont être sacrifiés comme l'a été Mardyck dont on ne parle plus aujourd'hui!\r\nVOUS travaillez pour développer le port et accessoirement les emplois, nous travaillons pour payer nos maisons qui ne vaudront plus rien, nous qui sommes venus à Loon-Plage pour son cadre de vie! J'espère que M.Rommel et la municipalité s'opposeront à ce projet qui ne tiendra pas ses promesses, comme le Terminal Méthanier!\r\nOn investit dans une aire de baignade écolo, une maison de la Nature... pour se donner bonne conscience alors qu'à même pas 1 km, on détruit l'environnement et pollue toute une ville!\r\nJ'en profite également pour revenir sur un point qu'a donné M.Raison pour rassurer les riverains: les poids lourds rouleront à l'électrique!\r\nSachez que je regardais les Bisounours étant enfant et que ces arguments ne font que renforcer le fait qu'on nous prend pour des idiots!\r\nBref, comme je l'ai déjà dit, développer le port, OUI, mais pas en sacrifiant des villes et leurs habitants! Je mets au défis les dunkerquois, rosendaeliens et maloins de supporter ce que nous supportons à Loon-Plage!\r\nSoyons nombreux le 19/12/17 à l'Escale pour contester ce projet qui ne présente aucune garantie!!	49	415	\N	2017-12-15 13:51:47.221819	2017-12-15 13:51:47.427526	0	\N	\N	\N	\N	cndp-PROP-2017-12-366	\N	\N	\N
370	Didier S. – Débat Mobile – Marché de noël de Gravelines – 09/12/2017	Notre côte est en train de devenir un gruyère. Mais où va-t-on a faire des trous partout ? Le risque de montée des eaux ne va rien arranger !	49	375	\N	2017-12-19 09:23:26.359756	2017-12-19 09:23:26.595813	0	\N	\N	\N	\N	cndp-PROP-2017-12-370	\N	\N	\N
371	Jean-Marc C. - Débat Mobile – Marché de noël de Gravelines – 09/12/2017	Je suis ingénieur, chef de projet à la centrale nucléaire. Je suis contre le souhait du Port de développer la filière conteneurs. Ils vont créer de la dépendance à terme. Il va y avoir de la croissance dans les dix prochaines années c’est sûr, mais ils vont surtout générer du chômage sur le long terme. Je suis pour une croissance locale et très progressive. Il faut ralentir la cadence de développement des bassins et d’activité.	49	375	\N	2017-12-19 09:25:00.659962	2017-12-19 09:25:00.790888	0	\N	\N	\N	\N	cndp-PROP-2017-12-371	\N	\N	\N
372	Béatrice K. - Débat Mobile – Marché de noël de Gravelines – 09/12/2017	Je ne suis pas favorable au projet du Port car nous allons enclaver Gravelines. Imaginez qu’il y ait un accident à la centrale nucléaire. Si toutes les routes sont encombrées, comment va-t-on faire venir les secours ? Je suis donc favorable au projet Baltique car Gravelines serait ainsi moins enclavée.	49	375	\N	2017-12-19 09:25:32.79443	2017-12-19 09:25:32.827311	0	\N	\N	\N	\N	cndp-PROP-2017-12-372	\N	\N	\N
373	Marc R. – Débat Mobile – Marché de noël de Gravelines – 09/12/2017	Ce projet pharaonique est plus complexe qu’il n’y parait. Les études devraient être plus que précises. A-t-on pensé à la montée des eaux d’ici 50 ans ? Certes, le sol va être remblayé, mais qu’en est-il des usines voisines ? Si la centrale pète, on aura un effet de réaction en chaîne. Quelles évolutions du port dans 5 décennies ? Comment accompagner les risques de submersion ?	49	375	\N	2017-12-19 09:26:04.096445	2017-12-19 09:26:04.135123	0	\N	\N	\N	\N	cndp-PROP-2017-12-373	\N	\N	\N
205	Claire T. - Débat Mobile Rosendaël	"Il faut faire ce projet pour faire revivre Dunkerque. Ce territoire est mort aujourd'hui ! Mais avec tous les camions qui vont sortir, ça va être le bordel."	49	375	\N	2017-10-25 09:14:36.617641	2017-10-25 09:14:36.713042	0	\N	\N	\N	\N	cndp-PROP-2017-10-205	\N	\N	\N
206	Danès Annie - Débat Mobile Malo-les-Bains	"Je trouve que vous devriez faire quelque chose pour la population de Dunkerque. Extinction de voix, mal de gorge quand il y a dégazage. Pourquoi ne pas mettre des filtres voitures fenêtres noires."	49	375	\N	2017-10-25 09:26:19.622669	2017-10-25 09:26:19.681828	0	\N	\N	\N	\N	cndp-PROP-2017-10-206	\N	\N	\N
207	Benjamin - Débat Mobile Malo-les-Bains	"Le port autonome a été tué par les grèves à répétition des dockers. Aujourd'hui, le port est parti s'installer à Anvers, à Bruges etc. C'est un système pernicieux. Si on veut que le profit marche, il faut changer le système ! Pensons à nos enfants, vive la liberté !"	49	375	\N	2017-10-25 09:34:38.183312	2017-10-25 09:34:38.234576	0	\N	\N	\N	\N	cndp-PROP-2017-10-207	\N	\N	\N
208	Clément P. - Débat Mobile Malo-les-Bains	"Aujourd'hui, le port Est est à l'arrêt. C'est triste. Les bruits nous manquent. J'aime le bruit des sirènes. C'est la mélodie de Dunkerque. Depuis notre ville sonne faux."	49	375	\N	2017-10-25 09:37:54.665418	2017-10-25 09:37:54.711664	0	\N	\N	\N	\N	cndp-PROP-2017-10-208	\N	\N	\N
209	Madame Courtelet - Débat Mobile Malo-les-Bains 	A part les emplois, qu’est-ce qui va être positif ? Le réseau routier va être infernal. Ça va attirer les migrants et on n’a aucune solution. En containers, tout va être automatisé. Les emplois, les emplois, mais quels emplois ? C’est 16000 emplois, quoi ? Ces emplois viennent de l’Est. Faut pas nous raconter n’importe quoi ! Les polonais ont trouvés la parade pour contourner les taxes. Ils viennent en camionnettes et rechargent sur des semi-remorques sur les airs d’autoroute. Faut déjà régler ce problème ! 3000 emplois en local c’est trop peu.	49	375	\N	2017-10-26 08:00:27.989291	2017-10-26 08:00:28.070977	0	\N	\N	\N	\N	cndp-PROP-2017-10-209	\N	\N	\N
210	Test de publication	\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla efficitur orci at leo venenatis, eu imperdiet nisl efficitur. Aenean sed quam eget tellus scelerisque tincidunt ac in est. Sed condimentum ligula purus, in aliquet lectus vestibulum eget. Mauris non ligula nec turpis dignissim posuere sit amet vitae nisi. Donec pretium lorem ut diam posuere efficitur. Suspendisse eleifend viverra iaculis. Integer malesuada arcu quis erat interdum, vel dapibus felis efficitur. Suspendisse potenti. Sed placerat sagittis justo nec eleifend. Vivamus eget varius orci. Nulla eleifend ut lectus vitae egestas. Integer vitae sodales justo. Nullam id metus aliquet est sollicitudin convallis congue eu ex. Aliquam risus augue, maximus id posuere ultrices, mattis quis quam.\r\n\r\nVivamus vestibulum metus sit amet eros imperdiet, ut iaculis turpis placerat. Cras aliquam, felis at aliquet efficitur, risus elit venenatis nunc, mattis bibendum nunc tortor at leo. Nulla sagittis feugiat velit. Quisque est ligula, viverra sit amet egestas quis, consectetur sit amet justo. Nullam at ipsum vel nisi luctus placerat. Praesent pellentesque lorem turpis. Nam laoreet elit quis lacus sagittis tempus. Pellentesque a purus maximus, suscipit quam a, lobortis urna. In sed massa nec augue varius tempor.\r\n\r\nNullam a feugiat sapien. Vestibulum iaculis ac neque et accumsan. Sed hendrerit tortor eget lacus luctus volutpat. Quisque nec lorem id magna imperdiet suscipit quis sit amet sem. Morbi eros felis, auctor ac hendrerit ut, eleifend ut ex. Mauris luctus suscipit tellus, rhoncus cursus erat maximus non. Nunc eu laoreet augue, et suscipit odio.\r\n\r\nUt lorem est, molestie ac blandit ac, bibendum a erat. Curabitur scelerisque enim ipsum, quis porttitor mi luctus ac. Cras ut convallis sem. Nunc rutrum orci nec malesuada placerat. Proin accumsan, justo ac sodales volutpat, velit elit scelerisque metus, vel porta diam dui at ipsum. Quisque rutrum est dolor, non rhoncus diam vestibulum eget. Aenean congue eget mauris sit amet sollicitudin. Sed vel tincidunt lorem, at consectetur est. Nullam consectetur tincidunt sodales.\r\n\r\nCurabitur ut tellus fringilla, rhoncus magna nec, congue lorem. Ut aliquam magna facilisis, egestas turpis at, lacinia turpis. Integer felis sapien, sodales id eros eu, eleifend mollis tortor. Donec sit amet ante at mi fringilla imperdiet sit amet sed est. Maecenas sit amet ante fermentum, mollis neque a, tristique enim. Curabitur tincidunt tellus faucibus augue ultricies, eu efficitur mauris euismod. Duis ornare elit ultrices, condimentum velit in, scelerisque felis. Praesent vitae lacus accumsan, consequat mi a, posuere metus. Vestibulum efficitur sodales dolor ac pellentesque. Integer convallis volutpat mi, vel venenatis quam ultricies eu. Suspendisse viverra eros eu elit viverra placerat. Cras ligula augue, sollicitudin in elit at, fermentum cursus turpis. Pellentesque a mauris eros. Fusce eget ipsum felis.\r\n\r\nIn non elit vel felis porta faucibus. Phasellus porta rhoncus nisl, vehicula convallis dui condimentum imperdiet. Phasellus molestie imperdiet elit et imperdiet. Nam eu nunc sed metus laoreet bibendum at vel felis. Nulla nec rhoncus magna. Mauris laoreet ullamcorper lobortis. Sed a tincidunt justo. Duis viverra libero quam, vel tempus turpis efficitur nec.\r\n\r\nAliquam erat volutpat. Phasellus ultricies diam eu dui lacinia sodales. Vivamus consequat magna in metus maximus, ut fringilla libero posuere. Suspendisse sed rutrum elit, ut varius dui. Etiam ante orci, laoreet quis maximus at, facilisis sit amet nisi. Nullam tincidunt ante a diam placerat, ut rutrum risus faucibus. Cras cursus condimentum justo, vitae lobortis ligula maximus quis. Cras tortor tortor, aliquet non elementum ac, mattis at orci. Quisque nec porta leo. Vestibulum vestibulum blandit erat at feugiat. Etiam eleifend lorem in efficitur dapibus. Curabitur pulvinar gravida dui, in maximus odio suscipit eget.\r\n\r\nSuspendisse orci metus, facilisis facilisis accumsan laoreet, porttitor eget nulla. Curabitur dictum lectus nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur ut porttitor nibh, ut aliquet ipsum. Fusce consectetur diam vitae dolor hendrerit maximus. Nulla enim sem, scelerisque sit amet arcu vel, pulvinar scelerisque eros. Aenean pulvinar euismod felis sit amet dictum. Aenean vel bibendum odio, sed pellentesque nunc. Ut eget erat eget diam molestie lacinia et ac tellus. Proin et dignissim ligula, vitae tempor justo. Ut lobortis, risus sed hendrerit ultrices, magna lorem sollicitudin tortor, eget hendrerit tellus dolor nec justo. Nullam vitae nulla sit amet massa consectetur gravida vitae id sapien. Aliquam at velit non risus sodales scelerisque eu et dui. In euismod nisl tincidunt arcu lacinia, tempus tempor neque maximus.\r\n\r\nAliquam tempus est non ornare mollis. Mauris venenatis rutrum est. Nam posuere ipsum iaculis ipsum lacinia fermentum. Cras vestibulum semper hendrerit. Duis imperdiet ex sagittis augue vulputate, non semper tortor congue. Vivamus sit metus. 	49	335	\N	2017-10-27 08:15:04.543269	2017-10-27 08:15:04.728406	0	\N	\N	\N	\N	cndp-PROP-2017-10-210	\N	\N	\N
211	Jean R. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017 	"La branche Atlantique va couper Gravelines du reste de l’agglomération. La Baltique semble mieux car elle passe à l’arrière des usines."\r\n	49	375	\N	2017-10-31 09:57:06.4889	2017-10-31 09:57:06.874991	0	\N	\N	\N	\N	cndp-PROP-2017-10-211	\N	\N	\N
212	Lise Leroy - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017 	"Pourquoi réfléchir à l’échelle de France ? Réfléchissons à l’échelle européenne. Des outils comme le port de Rotterdam existent. Le Port s’étend sur des dizaines de kilomètres, il est entièrement automatisé donc peu créateur d’emploi. Il augmente les nuisances pour les habitants (circulation, accaparement des terres agricoles). Bien loin de l’image écologique que notre monde pourrait vivre. Le Port de Marseille qui s’est développé ne fonctionne pas. Merci pour la planète de ne pas réaliser ce projet. Nous trouverons d’autres alternatives, il suffit de laisser s’exprimer les citoyens."	49	375	\N	2017-10-31 09:58:20.43997	2017-10-31 09:58:20.498281	0	\N	\N	\N	\N	cndp-PROP-2017-10-212	\N	\N	\N
213	Christophe et Emilie - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"Le Port c’est la ressource de Dunkerque depuis toujours, il faut le préserver."	49	375	\N	2017-10-31 10:00:29.542018	2017-10-31 10:00:29.56989	0	\N	\N	\N	\N	cndp-PROP-2017-10-213	\N	\N	\N
214	Laurent T. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"L’impact écologique est évident mais l’important est l’emploi."	49	375	\N	2017-10-31 10:02:01.369245	2017-10-31 10:02:01.59426	0	\N	\N	\N	\N	cndp-PROP-2017-10-214	\N	\N	\N
215	Patricia D. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"Ça peut faire du bien à Dunkerque pour l’emploi ! Il serait inadmissible de favoriser le Havre et Marseille contre Dunkerque."	49	375	\N	2017-10-31 10:02:48.766259	2017-10-31 10:02:48.79959	0	\N	\N	\N	\N	cndp-PROP-2017-10-215	\N	\N	\N
216	Isabelle S. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"Ça développe l’économie, c’est un beau projet."	49	375	\N	2017-10-31 10:03:33.15499	2017-10-31 10:03:33.202787	0	\N	\N	\N	\N	cndp-PROP-2017-10-216	\N	\N	\N
217	Dany et Amarande - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"A partir du moment où il existe des emplois à la clef, pas de problème, le reste est accessoire."	49	375	\N	2017-10-31 10:04:09.418809	2017-10-31 10:04:09.464831	0	\N	\N	\N	\N	cndp-PROP-2017-10-217	\N	\N	\N
218	Jean-Luc A. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"Un projet intéressant qui doit être positif pour la ville."	49	375	\N	2017-10-31 10:05:11.361989	2017-10-31 10:05:11.514846	0	\N	\N	\N	\N	cndp-PROP-2017-10-218	\N	\N	\N
219	Sylvine P.  et Nacia B. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"C’est bien, il était temps qu’il se passe quelque chose à Dunkerque. Le port était triste. C’est le 3ème Port de France. Le seul problème reste la vue !"                                              	49	375	\N	2017-10-31 10:07:04.908013	2017-10-31 10:07:05.034191	0	\N	\N	\N	\N	cndp-PROP-2017-10-219	\N	\N	\N
220	Ghislaine B. – Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"Je trouve surprenant que nous ne prenions pas plus soin de nos terres agricoles alors que la population mondiale augmente, ce qui implique plus de monde à nourrir. Comment le port peut-il dépasser ces contradictions ?"\r\n	49	375	\N	2017-10-31 10:08:05.665934	2017-10-31 10:08:05.715197	0	\N	\N	\N	\N	cndp-PROP-2017-10-220	\N	\N	\N
221	Philippe et Evelyne M. - Débat mobile Centre commercial Marine - Dunkerque - 28/10/2017	"Il faut que ça évolue, que ça vive. C’est bien pour nos enfants et pour les garder dans la région. Il était temps !"	49	375	\N	2017-10-31 10:09:13.101645	2017-10-31 10:09:13.140991	0	\N	\N	\N	\N	cndp-PROP-2017-10-221	\N	\N	\N
222	François Cornet de Wormhout - Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	 "Agriculteurs : la Terre ne coûte pas cher au du port ! Ça va donner du travail à la région ça va redonner de la valeur à notre patrimoine !"\r\n	49	375	\N	2017-10-31 13:55:30.429488	2017-10-31 13:55:30.653469	0	\N	\N	\N	\N	cndp-PROP-2017-10-222	\N	\N	\N
223	Jean-Pierre Manard de Paris – Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"Je travaille à la SNCF. Aujourd’hui, l’État aide davantage la route que le rail. Nous étions favorables aux portiques pour amortir les frais interdits au passage de camions. Le problème de la route c’est que c’est gratuit pour les camions."\r\n	49	375	\N	2017-10-31 14:23:28.093947	2017-10-31 14:23:28.177059	0	\N	\N	\N	\N	cndp-PROP-2017-10-223	\N	\N	\N
224	Sophia Vire 26 ans Gravelines - Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"L’A16 va devenir de plus en plus dangereuse. Avec la pollution en plus, je me demande si on va rester là. Et puis le projet va enfermer Gravelines. On est mis à part. La seule chose bien, c’est l’emploi mais il n’y a pas que ça dans la vie."	49	375	\N	2017-10-31 14:24:15.503312	2017-10-31 14:24:15.51634	0	\N	\N	\N	\N	cndp-PROP-2017-10-224	\N	\N	\N
226	Léna D. 23 ans - Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"C’est un bon projet pour Dunkerque. Je veux revenir y travailler."	49	375	\N	2017-10-31 14:25:29.062598	2017-10-31 14:25:29.14538	0	\N	\N	\N	\N	cndp-PROP-2017-10-226	\N	\N	\N
227	Romuald Meesenaecker Teteghem - Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"Mon sentiment, c’est que le projet tourne le dos à l’activité originelle du Port qui était au service de l’industrie. Il faut du boulot pour tous même si la diversification est nécessaire !"	49	375	\N	2017-10-31 14:26:03.450379	2017-10-31 14:26:03.493391	0	\N	\N	\N	\N	cndp-PROP-2017-10-227	\N	\N	\N
228	  David L. Craywick - Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"On peut porter atteinte au littoral à condition que cela apporte des emplois."	49	375	\N	2017-10-31 14:26:48.625709	2017-10-31 14:26:48.790996	0	\N	\N	\N	\N	cndp-PROP-2017-10-228	\N	\N	\N
229	Marcel Voos 68 ans Spycker – Salon du vin, de la bière et des produits régionaux - Dunkerque 29/10/2017	"Porte-conteneurs, ça me fait peur ! Combien tombent à l’eau à chaque voyage ?"	49	375	\N	2017-10-31 14:27:17.544977	2017-10-31 14:27:17.5562	0	\N	\N	\N	\N	cndp-PROP-2017-10-229	\N	\N	\N
230	Contre le projet	Qui va respirer les odeurs des échappements de bateaux ?\r\nQui verra des migrants arrivés en masse en ville ?\r\nQui verra des grue depuis son jardin ?\r\nQui aura les nuisances sonores ?\r\nQui sera embêté par le défilement de camions ?\r\nQui ne verra pas ces impôts diminuer malgré tous ça ? \r\nQui verra la valeurs immobilière descendre en flèche pour les propriétaires ?\r\n\r\nRéponse : Les Loonois. \r\nPas les dunkerquois qui sont forcement d'accord puisque c'est assez éloigné de leurs habitations.	49	389	\N	2017-11-01 15:37:05.690517	2017-11-01 15:37:05.920506	0	\N	\N	\N	\N	cndp-PROP-2017-11-230	\N	\N	\N
231	Dunkerque versus Le Havre ? Donnez votre avis !	Christian Hutin, Paul Christophe et Jean-Pierre Decool, parlementaires du Nord, viennent d'écrire à Edouard Philippe, Premier Ministre.\r\nIls entendent réagir à une lettre adressée il y a quelques jours par Agnès Firmin Le Bodo, députée du Havre, à Jacques Mézard, ministre de la Cohésion des territoires.\r\nLe journal Paris Normandie rapporte que la députée de Seine-Maritime questionnait ainsi la stratégie nationale portuaire et l'opportunité du projet porté par le Port de Dunkerque : "La politique maritime de la France ne peut supporter l'éparpillement des efforts, elle doit faire émerger et conforter les deux ports les mieux placés dans ce contexte : Le Havre et Marseille."\r\nLes parlementaires du Nord estiment "qu'une clarification urgente est aujourd'hui indispensable après ces annonces alors qu'au même moment vient de commencer sur le littoral le grand débat public concernant ces enjeux qui sont cruciaux pour l'avenir du territoire et de ses habitants."\r\n\r\nA votre tour, donnez votre avis sur cet espace. Pensez-vous qu'il faut-il concentrer les investissements sur Le Havre et Marseille ? Ou pensez-vous au contraire que Dunkerque doit également bénéficier d'investissements importants ?\r\nQuelle place doit prendre Dunkerque au sein du dispositif portuaire français ? Dunkerque et Le Havre : complémentaires ou concurrents ?	50	375	\N	2017-11-02 08:40:56.74606	2017-11-02 08:40:56.939111	0	\N	\N	\N	\N	cndp-PROP-2017-11-231	\N	\N	\N
232	Contribution de Michel Nicolet	Conseiller municipal et maire honoraire de Bourbourg, Michel Nicolet a déposé sa contribution à la boutique du débat.\r\n\r\nVous la trouverez ci jointe.\r\n\r\n	49	375	\N	2017-11-06 15:17:22.545823	2017-11-06 15:17:22.827715	0	\N	\N	\N	\N	cndp-PROP-2017-11-232	\N	\N	\N
233	Test de proposition avec ponctuation débordante	Voici un test avec beaucoup de ponctuation ????!!!?	52	358	\N	2017-11-08 13:50:07.937775	2017-11-08 13:50:08.350388	0	\N	\N	\N	\N	cndp-PROP-2017-11-233	\N	\N	\N
234	Sandrine - Débat mobile - Grande-Synthe	« Nous avons besoin de faire connaître Dunkerque. Oui au port et oui à sa promotion par le tourisme industriel. La ville et son port sont morts. Il faut ouvrir les ports. »	49	375	\N	2017-11-09 16:42:26.253244	2017-11-09 16:42:26.461619	0	\N	\N	\N	\N	cndp-PROP-2017-11-234	\N	\N	\N
235	Sabine - Débat mobile - Grande-Synthe	« 5000 emplois dans le dunkerquois, encore des travailleurs détachés qui vont en bénéficier ! »	49	375	\N	2017-11-09 16:43:23.154505	2017-11-09 16:43:23.188784	0	\N	\N	\N	\N	cndp-PROP-2017-11-235	\N	\N	\N
236	Jacques - Débat mobile - Grande-Synthe	« Le container est-il vraiment une filière d’avenir ? Les chiffres sont-ils en hausse ? Je vois bien le décroit du container dans les ports concurrents (Chine…) qu’on ne viennent pas dire qu’il faut miser là-dessus. Poussez les études ! »	49	375	\N	2017-11-09 16:44:39.061424	2017-11-09 16:44:39.165623	0	\N	\N	\N	\N	cndp-PROP-2017-11-236	\N	\N	\N
237	Yves - Débat mobile - Grande-Synthe	« C’est bien beau d’agrandir le port, mais encore faut-il que les infrastructures routières suivent. »	49	375	\N	2017-11-09 16:45:21.08768	2017-11-09 16:45:21.113097	0	\N	\N	\N	\N	cndp-PROP-2017-11-237	\N	\N	\N
238	Julien - Débat mobile - Grande-Synthe	« Arrêtez de mentir. Je ne crois pas que nos impôts ne vont pas augmenter ! »	49	375	\N	2017-11-09 16:46:05.429417	2017-11-09 16:46:05.44214	0	\N	\N	\N	\N	cndp-PROP-2017-11-238	\N	\N	\N
239	Rachid - Débat mobile - Grande-Synthe	« Pour le commun des mortels, c’est quand même ambiguë cette histoire. Creuser une nouvelle darse alors qu’à Dunkerque c’est mort. On se pose des questions. 16000 emplois. Je vais dire trop optimiste juste pour que vous ayez à vous justifier. »	49	375	\N	2017-11-09 16:47:34.112362	2017-11-09 16:47:34.121675	0	\N	\N	\N	\N	cndp-PROP-2017-11-239	\N	\N	\N
240	Christophe - Débat mobile - Grande-Synthe	« Entre les deux projets, je suis plus pour le Baltique car plus portuaire. L’Atlantique s’insère dans la vie locale et risque de perturber le cadre de vie. »	49	375	\N	2017-11-09 16:48:24.331331	2017-11-09 16:48:24.399547	0	\N	\N	\N	\N	cndp-PROP-2017-11-240	\N	\N	\N
241	Jamal -  Débat mobile - Grande-Synthe	« 2.5 millions de containers en plus ! Dur de gérer tout ça sur les routes. La circulation sur l’A16 va empirer. Il faut faire quelque chose. Une 3ème voie pourquoi pas ? Deux bassins de 2km supplémentaires. Ça va en faire du kilomètre carré déplacé ! Pour chaque kilomètre déplacé, 1km de relocalisation et de réinvestissement. »	49	375	\N	2017-11-09 16:49:50.632995	2017-11-09 16:49:50.807296	0	\N	\N	\N	\N	cndp-PROP-2017-11-241	\N	\N	\N
242	Thierry - Débat mobile - Grande-Synthe	« Il faut ce projet ! Le progrès permet d’avancer ! »	49	375	\N	2017-11-09 16:56:57.899137	2017-11-09 16:56:58.223051	0	\N	\N	\N	\N	cndp-PROP-2017-11-242	\N	\N	\N
243	Bernard -  Débat mobile - Grande-Synthe	« Je suis pour l’Atlantique et non le Baltique. Gardons la plage et l’image balnéaire du territoire aussi bien pour s’y promener que de préserver faune et flore. »	49	375	\N	2017-11-09 16:59:26.914998	2017-11-09 16:59:27.202898	0	\N	\N	\N	\N	cndp-PROP-2017-11-243	\N	\N	\N
244	David -  Débat mobile - Grande-Synthe	« J’imagine que cette extension va faire venir les industries et accroître le bassin industriel du littoral ! »\r\n	49	375	\N	2017-11-09 17:00:25.214407	2017-11-09 17:00:25.231343	0	\N	\N	\N	\N	cndp-PROP-2017-11-244	\N	\N	\N
245	Jimmy -  Débat mobile - Grande-Synthe	« J’aimerai pouvoir travailler comme docker même si c’est un système fêlé. »	49	375	\N	2017-11-09 17:00:52.934892	2017-11-09 17:00:52.956393	0	\N	\N	\N	\N	cndp-PROP-2017-11-245	\N	\N	\N
246	Damien -  Débat mobile - Grande-Synthe	« Nous avons des cartes de logistiques, des manutentionnaires pour les entrepôts. »	49	375	\N	2017-11-09 17:22:55.061393	2017-11-09 17:22:55.16351	0	\N	\N	\N	\N	cndp-PROP-2017-11-246	\N	\N	\N
283	Pierre-André G. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Si Le Havre ne l’empêche pas, il faut ce projet. La seule question qui me pose problème, c’est la coupure de la route. Mais si ce projet ne se fait pas, c’est la mort de Dunkerque.	49	375	\N	2017-11-21 12:17:57.510928	2017-11-21 12:17:57.62384	0	\N	\N	\N	\N	cndp-PROP-2017-11-283	\N	\N	\N
247	Baltique de préférence	Vous nous sortez des cartons un projet vieux de quarante cinq ans 1972 création du NAPO PROJET ATLANTIQUE prévu sur les plans. Valable à cette époque nous aurions pu concurrencer Anvers. Aujourd'hui il est mort dans l'oeuf avec le gigantisme qui nous attend, c'est  pourquoi le projet Baltique est plus viable accès direct à la mer avec possibilité d'une emprise sur celle ci,gain de temps et d'argent pour les navires avec un accès direct. Je vois mal un gros porte conteneur entré dans les terres, coût de remorquage et évitage exorbitant qui incitera les navires à faire escales à Anvers et Rotterdam. 	50	408	\N	2017-11-12 09:34:04.610149	2017-11-12 09:34:04.931923	0	\N	\N	\N	\N	cndp-PROP-2017-11-247	\N	\N	\N
359	Jacques P. - Débat Mobile – Marché de Loon-Plage - 12/11/2017	C’est de la fumisterie ! Les usines devraient empêcher la diffusion des particules en utilisant des camions à eau. Une belle promesse. Résultat, on nous a bien eus.	49	\N	\N	2017-12-13 11:00:13.194908	2017-12-13 11:00:13.362139	0	\N	\N	\N	\N	cndp-PROP-2017-12-359	\N	\N	\N
374	Didier – Débat Mobile – Grand-Fort-Philippe – 06/12/2017	C’est quoi cette déviation ? A mon avis, il faut inverser les 2 voies. Celle qui longe le port devrait être pour les poids lourds et celle prévue pour les poids lourds devrait être dédiée aux véhicules légers. Sinon les poids lourds vont emprunter la voie des voitures légères, c’est plus court pour longer le port. Il faut un carrefour giratoire pour fluidifier les arrivées de l’Ouest (Calais) et de l’Est (Dunkerque).	49	375	\N	2017-12-19 09:26:51.219716	2017-12-19 09:26:51.372054	0	\N	\N	\N	\N	cndp-PROP-2017-12-374	\N	\N	\N
375	Franck N. – Débat Mobile – Grand-Fort-Philippe – 06/12/2017	Je suis pêcheur. Je suis favorable au projet, car le port, c’est vital économiquement, mais il faut nous laisser un accès pour pêcher. Aujourd’hui, je suis bloqué par les postes de garde au Clipon. Si jamais je me fais contrôler dans un site interdit, je prends 750 euros d’amende. Ouvrir à l’international oui ! Mais ouvrir des digues aux pêcheurs, ce serait curieux !	49	375	\N	2017-12-19 09:27:29.507079	2017-12-19 09:27:29.5916	0	\N	\N	\N	\N	cndp-PROP-2017-12-375	\N	\N	\N
248	Ceci est un avis à publier (Test SA)	Bonjour, \r\nCeci est un avis à publier sur le site du débat	52	402	\N	2017-11-13 09:47:30.724252	2017-11-14 08:59:29.22352	0	\N	accepted	2017-11-14 08:59:29.205826	{"fr": "<p>Bonjour, </p><p>La commission particulière du débat public vous invite à consulter les avis n°19 et 12 qui portent sur des sujets similaires.</p><p><br></p>"}	cndp-PROP-2017-11-248	\N	\N	\N
250	Sécurité de nos axes routiers	Plutôt que dépenser une fortune pur détruire encore un peu plus notre qualité de vie, nous imposer des nuisances sonores et visuelles, surcharger les axes routiers, pourquoi ne pas utiliser cet argent pour sécuriser l'axe Calais - Dunkerque déjà un des plus accidentogènes de la France ? 	50	368	\N	2017-11-14 13:46:29.535552	2017-11-14 13:46:29.683205	0	\N	\N	\N	\N	cndp-PROP-2017-11-250	\N	\N	\N
258	Des nuisances sonores qui impact notre quotidien	Voila ce que nous subissons chaque jour avec la transformation du quai de flandres, nous savons qu'il en sera de mm lors de la phase 1 et 2 du projet atlantique ou baltique. Actuellement nous entendons ce bruit qui ce trouve a environ selon ou l'on ce trouve dans la commune entre 1 et 3km. Nous ne voulons pas subir ce cela avec le projet atlantique ou baltique. A savoir que nous l'entendons dès 6h du matin jusqu'a 23h30 les 1ères semaines mais maintenant ce bruit doit être stoppé à 20h. Hier nous parlons de nuisance ou pollution sonore lors du débat. Celle-ci peut avoir un effet néfaste sur notre santé mentale. Imaginez vous vivre à coté de ce bruit plusieurs jours et entendre à intervalles régulier ce bruit du matin au soir.\r\nCertes le son n'est pas très fort puisqu'il est pris avec un téléphone portable. Mais je vous invite à venir constater par votre même ainsi qu'à l'intérieur de nos habitations. Je vous invite à écouter cette vidéo ( en lien ) avec un casque audio tout de même.\r\n\r\nVoici le lien : https://www.youtube.com/watch?v=cAVVxEkPr_8	49	389	\N	2017-11-17 14:38:19.168139	2017-11-17 14:38:19.706589	0	\N	\N	\N	\N	cndp-PROP-2017-11-258	\N	\N	\N
376	Stéphane P. – Débat Mobile – Grand-Fort-Philippe – 06/12/2017	Avant, nous étions un village maritime. Regardez derrière la rue, nous avions 15 cafés. Aujourd’hui, plus rien ! Nous devons également avoir des retombées pour réactiver le tissu économique. J’ai le sentiment que nous sommes un angle mort du territoire.	49	375	\N	2017-12-19 09:28:00.150916	2017-12-19 09:28:00.176546	0	\N	\N	\N	\N	cndp-PROP-2017-12-376	\N	\N	\N
251	Le fluvial et ses possibilités.	En lisant les contributions je trouve que l'on parle beaucoup trop du transport routier et de ses nuisances, pas assez du fluvial qui me semble l'avenir.\r\nPeut-on insister sur ce thème ?\r\nMerci. 	49	393	\N	2017-11-15 08:50:07.956562	2017-11-15 08:50:08.170838	0	\N	\N	\N	\N	cndp-PROP-2017-11-251	\N	\N	\N
252	Représentativité de la commission	Bonjour,\r\nJ'ai participé à l'ouverture de la commission de débat public et j'ai apprécié la conduite du débat par le président de la commission, même si, rodé à l'exercice les Maitre d’œuvre ne prenaient qu'un bout des questions posées pour amener des réponses parcellaires sur les vrais problème. Je m'apprête à participer à d'autres débats. toutefois je m'interroge sur le résultat de ce débat face aux peu de réponses postées sur ce site.	49	412	\N	2017-11-15 10:17:20.445341	2017-11-15 10:17:20.776361	0	\N	\N	\N	\N	cndp-PROP-2017-11-252	\N	\N	\N
253	Droit d'expression	Je prie la commission de bien vouloir peser la valeur des questions et des réponses. Ayant participé aux débats on s'aperçoit d'un strict temps de réponse aux questions. Cependant les interventions publiques de certains Pro-projet ressemblent bien à du bourrage de crânes pris sur le temps d'expression de tous ceux qui aimeraient entendre poser leurs questions. et surtout se savoir entendu. 	49	412	\N	2017-11-15 10:22:12.657309	2017-11-15 10:22:12.868785	0	\N	\N	\N	\N	cndp-PROP-2017-11-253	\N	\N	\N
254	Blocage facilité	Nous avons vécu il y a peu de véritable blocage des villes à l'ouest de Dunkerque par des actions assez modeste de filtrages routier. d'où en peu de temps blocage de Loon plage, Gravelines, Grande synthe, bourbourg, ferry et l'A16 ... par des camions à l'arrêt sur les routes et une remise en marche lente du trafic. L'augmentation du trafic, sa concentration, la suppression d'axes routier rendra la chose beaucoup plus aisées encore ...\r\nPrévu ? ou pas prévu ?\r\n	49	412	\N	2017-11-15 10:27:57.615092	2017-11-15 10:27:57.693846	0	\N	\N	\N	\N	cndp-PROP-2017-11-254	\N	\N	\N
255	Coexistence de circulations routier + riverains	WE à Loon plage les camions stationnent sur les bretelles, les parking et la ville.... jusqu'à Gravelines Saint Folquin.\r\nEn semaine les trafics des riverains et transporteurs se côtoient, se croisent, s'imbriquent avec de vrais ralentissement et ce malgré la mise en place de voies, ponts ... privilégiant le transport vers le port sans croisement circulation locale. Demain le projet prévoit le partage des mêmes axes pour tous sans distinction et même le rapprochement des routes au long de l'autoroute sur 5 Km pour contourner les bassins et au final se retrouver tous sur les même routes !? Gageons que certains prendront la route pour un autoroute. Fin des déplacements lents, vélos et familial.\r\n	49	412	\N	2017-11-15 10:35:21.86288	2017-11-15 10:35:22.019966	0	\N	\N	\N	\N	cndp-PROP-2017-11-255	\N	\N	\N
279	Didier - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Ça va encore créer un beau bazar. Pourquoi faire une voie dédiée aux camions pour le détournement de la D601 ? Ça fait 70 ans que je suis là et j’ai rarement vu des camions sur cette route. Les routiers prennent l’autoroute. 	49	375	\N	2017-11-21 11:33:59.364221	2017-11-21 11:33:59.469871	0	\N	\N	\N	\N	cndp-PROP-2017-11-279	\N	\N	\N
256	Loon Plage -DébatPublic	La ville de Loon Plage deviendra t'elle, le Mardyck de demain? \r\nUne ville cernée par les industries, un port qui ne cesse de s'étendre jusqu'à  l'isoler des villes voisines ? (Pour Gravelines c'est bien parti...)\r\n\r\n1er sujet: L'emploi\r\n\r\nJ'ai pu suivre le débat à distance et le 1er argument qui revient à chaque fois c'est l'emploi. 16.000 on annonce!\r\n\r\nImpossible de confirmer s'il s'agira d'emploi direct, de sous traitance, intérim, de départ en retraite ou de mutation issu du Havre.\r\n\r\nVous annoncez 3x plus de camions sur la route soit environ 1500. (Donc 1500 emplois sur 8h de travail hebdomadaire donc 4500 emplois liés au transport routiers pour un roulement de 24h). Je ne pense pas que ces 4500 routiers seront du secteur Dunkerquois mais vous les prenez dans vos chiffres à destination des personnes en précarité qui soutiendront le projet sans y regarder le fond.\r\n\r\nOn ne peut pas créer 16000 emplois sans en supprimer ou délocaliser du Havre, ce dernier ne sera pas partenaire mais concurrent direct. Le Havre futur sinistré en terme d'emploi ? Fortes probabilités.\r\n\r\n2e sujet: L'environnement \r\n\r\nOn ne parle pas de la faune, de la flore? Qu'en sera t'il? Nuisances sonores, pollution lumineuse et atmosphèrique,  présence de sels lié au vent qui atteindra les terres à 500M à la ronde.\r\n\r\nTriplement du nombre de camions + Porte conteneurs +vent d'Ouest, la pollution ira droit sur Loon. Sans parler que l'A16 qui est déjà saturé en camion le sera 3x plus. Que les véhicules de GS traverseront le centre ville de Loon pour se rendre par le nouveau raccourci pour aller sur Gravelines. (Un GPS prend toujours le trajet le plus court)\r\n\r\nLe bruit ? On entend déjà la torchere à 4km de la ville, j'appréhende les conteneurs à 500M, sans parler du réseau routiers saturés. \r\nVoir le forage du bassin ! \r\n\r\n3e sujet: la santé\r\n \r\nDunkerque se classe parmi les villes les plus pollué de France, même avant Lille. Le nombre de cancer par voie respiratoire a doublé, avec la pollution engendré on quadruple, non ?\r\n\r\nLes vibrations dans le sol ? Vous comptez creuser, mettre des renforts sur le bassin, faire rouler des camions chargés, des grues et autres véhicules lourd.\r\n\r\nLa valeur immobilière des habitations du coup. De 10 à 40% de baisse ?\r\n\r\nJe vais arrêter là car je pourrais écrire un roman sur le sujet.\r\n\r\nCordialement,\r\nUn citoyen Loonois.	49	414	\N	2017-11-15 15:24:35.880239	2017-11-15 15:24:36.108456	0	\N	\N	\N	\N	cndp-PROP-2017-11-256	\N	\N	\N
257	Dans le respect!	Développement? OUI mais pas n'importe comment\r\nDes emplois? OUI mais respecter les engagements et en faire profiter nos jeunes\r\nEnvironnement? Respecter les communes qui vont subir les impacts directs et indirects! A l'heure actuelle, le Dunkerque Security Truckstop a pour effets: blocage de la circulation par les routiers, nuisances sonores, alcoolémie, dangerosité des stationnements lorsqu'ils n'ont pas de place (sur 250 pourtant), qualité de l'air à proximité des habitations, multitude de déchets (sacs poubelle, bouteilles d'urine...) jetés par les routiers...\r\nA lors 7 fois plus?\r\nIl n'y a même pas 1 km entre les logements (pourtant récents) et la zone que vous souhaitez développer!\r\nQuels impacts sur la santé des riverains?\r\nLoon-Plage va-t-il devenir le futur Mardyck dont on ne parle plus?\r\nAlors un développement économique oui, mais pas au détriment de tout!\r\n	49	415	\N	2017-11-15 15:37:45.015821	2017-11-15 15:37:45.305573	0	\N	\N	\N	\N	cndp-PROP-2017-11-257	\N	\N	\N
259	Mur anti-bruit à loon-plage	On m'a dit qu'un mur anti-bruit ( une bute de terre ) sera mise tout du long de loon coté Atlantique. Celle-ci sera arboré .\r\nAujourd'hui, nous connaissons un flux migratoire important, des migrants voulant rejoindre l'Angleterre. \r\nCertes ils ne sont pas intéressés par les conteneurs mais le ferry lui est tout proche. \r\nJe suis certains que de plus en plus de migrants arriveront dans la commune pour s'y installé et se caché dans cette bute de terre au milieu des arbres comme des le cas près du Puythouck ou à calais près du port également. Ces derniers comme nous avons pu le voir souvent à la tv ou sur les réseaux sociaux jetés des branches d'arbres sur la route pour stopper les camions afin de montés à l'intérieur.	49	389	\N	2017-11-17 14:53:41.38937	2017-11-17 14:53:41.630628	0	\N	\N	\N	\N	cndp-PROP-2017-11-259	\N	\N	\N
281	Yvonne L. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	J’ai connu le port avant, c’était chouette. Grèves des marins il y a 20 ans contre l’hovercraft. Le grand manque, c’est que Dunkerque n’a pas de liaison directe vers l’Angleterre.	49	375	\N	2017-11-21 12:16:30.936483	2017-11-21 12:16:31.001746	0	\N	\N	\N	\N	cndp-PROP-2017-11-281	\N	\N	\N
285	Anne - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Le projet colle bien à l’image de Dunkerque. Pour le boulot c’est top !	49	375	\N	2017-11-21 12:19:26.590447	2017-11-21 12:19:26.61136	0	\N	\N	\N	\N	cndp-PROP-2017-11-285	\N	\N	\N
288	Richard D. - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	La route de Bourbourg est déjà surchargée ! Le rond point de « Maison blanche » ne viendra pas.	49	375	\N	2017-11-21 12:23:28.63226	2017-11-21 12:23:28.677652	0	\N	\N	\N	\N	cndp-PROP-2017-11-288	\N	\N	\N
265	Le conteneur est ce vraiment l'avenir	Ce matin je suis tombé sur un article de la voix du nord qui parle de décathlon qui fera parvenir ces marchandises en train depuis la chine. \r\nParce que plus écologique que l'avion mais certainement aussi plus que les navires.\r\nEncore une fois je ne crois pas du tout aux conteneurs, décathlon à la fibre écologique et mm si leur produit vient de Chine, décathlon adopte les bons réflexe.\r\nQuand au débat public, le maitre d'ouvrage parle de camion électrique, je ne dis pas que c'est impossible, mais l'autonomie des moteurs électrique ne permet pas encore de faire de longue distance.\r\nL'électrique c'est super à l'usage sur nos route effectivement il n'y aucune pollution mais plus il y a aura de véhicule électrique est plus il faudra produire de l'électricité et c'est la production d'électricité qui pollue aussi.\r\nEn France nous avons les centrales nucléaire avec leurs qualités et défauts mais en Allemagne il y a le charbon en plus polluant.\r\n	49	389	\N	2017-11-21 07:33:42.835835	2017-11-21 07:33:42.979028	0	\N	\N	\N	\N	cndp-PROP-2017-11-265	\N	\N	\N
362	Extension du port, pourquoi pas mais pas à n'importe quel prix !	CONTRE... Habitants Gravelines, nous allons être enclavés... Quel détour devrons-nous faire pour aller sur Dunkerque ? J'y vais tous les jours... Et tout ça pour avoir encore plus de camions : merci bien... Et ces camions, seront-ils encore stationnés sur la bande d'arrêt d'urgence en toute impunité et menaçant les automobilistes qui circulent sur cet accès à l'A16 ? Il faut arrêter de nous prendre pour des ânes... L'emploi c'est bien mais pour qui : des polonais, roumains, italiens comme cela s'est passé pour le terminal méthanier (je les voyais les camionnettes amenant les ouvriers...). L'économie, l'emploi sont, bien sûr, des mots qui touchent notre société mais à quel prix !!!! Et après, nos élus vont nous embêter avec notre voiture diesel qui pollue... Et tous ces camions quotidiens et à venir avec cette extension, ne vont-ils pas polluer ??? Et le projet du canal Seine-Nord, où en est-il ? Là, cela polluerait moins.  Il faut penser au bien être des habitants avant toute chose et au site de Gravelines. Mon quotidien devient un enfer routier pour aller travailler. Je me sens bien à Gravelines, je n'ai pas l'intention de bouger et pourquoi le ferais-je ? Merci de prendre en compte mon avis	49	431	\N	2017-12-15 08:56:13.03778	2017-12-15 08:56:13.265606	0	\N	\N	\N	\N	cndp-PROP-2017-12-362	\N	\N	\N
364	Contribution de la commune de Loon-Plage	A l'issue de la réunion publique qui s'est tenue dans sa ville, la municipalité de Loon-Plage acte son positionnement sur le projet CAP 2020 par le dépôt de cette contribution.	49	375	\N	2017-12-15 11:13:28.648174	2017-12-15 11:13:28.682508	0	\N	\N	\N	\N	cndp-PROP-2017-12-364	\N	\N	\N
280	Vincent Courcot - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Y aura-t-il des créneaux de dépassement sur le contournement de la RD601 ?	49	375	\N	2017-11-21 11:45:30.613066	2017-11-21 11:45:30.709928	0	\N	\N	\N	\N	cndp-PROP-2017-11-280	\N	\N	\N
282	Brigitte C. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Pourvu que ce projet donne du travail à tous nos jeunes.	49	375	\N	2017-11-21 12:17:20.283083	2017-11-21 12:17:20.304084	0	\N	\N	\N	\N	cndp-PROP-2017-11-282	\N	\N	\N
368	Compensations environnementales	Bonjour,\r\nJe travaille depuis peu dans la région, auprès d'entreprises rattachées aux secteurs agricole, de l'artisanat et du commerce. Je dois beaucoup me déplacer, et j'observe que l'état des routes est déjà difficiles : travaux fréquents, embouteillages, pollutions, accidents... et le projet du GPMD impliquera davantage de camions sur les routes. Outre cet aspect qui m'impacte personnellement, je me pose des questions quant aux impacts environnementaux de ce projet :\r\n\r\nLa situation de notre planète n'est méconnue de personne, et nous savons qu'il faut agir aujourd'hui pour minimiser les impacts de demain. Quel bilan carbone ce projet aura-t-il ? Quelles compensation le projet prévoit-il ?\r\nPrévoyez-vous l'utilisation d'une électricité verte pour le fonctionnement du port ? De matériaux de construction naturels ? D'une réglementation sanitaire et environnementale stricte afin de minimisée la pollution de la mer, du sol et de l'air ? etc.\r\n\r\nCes impacts sont l'affaire de tous, nous partageons le même air et la même mer.\r\nMerci	49	434	\N	2017-12-17 23:11:26.220375	2017-12-17 23:11:26.278693	0	\N	\N	\N	\N	cndp-PROP-2017-12-368	\N	\N	\N
266	Laurent Dubus - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	L’emploi n’excuse pas tout. C’est une fausse vitrine. Les directeurs du port ne sont pas d’ici, l’encadrement général n’est pas local. Les chiffres sont mauvais, sur une affiche on a une promesse de 10000 emplois et sur l’autre 16000.\r\nLe port a dénaturé le littoral. Il est impossible de se balader à l’ouest dans la mesure où il faut faire 20km pour atteindre un peu de verdure. De même, côté Est où il faut faire 10km pour atteindre les dunes. Il faut un peu de verdure au paysage. J’ai pourtant connu les dunes.\r\nIl y a l’histoire du méthanier où on nous avait annoncé beaucoup d’emplois fixes. Le maire de Grande-Synthe, Damien Carême, a raison sur la question de la future usine de chlore.\r\nQuand à Calais il y a des grèves, celles-ci s’étendent sur 40km avec des camions à la chaîne. Après on se demande pourquoi il y a des cancers de l’œsophage. Qui dit conteneurs dit transports, dit circulation et donc pollution par camion diesel. La seule chose à faire c’est de développer les voies ferroviaires et limiter les camions sur Dunkerque.	49	375	\N	2017-11-21 11:17:29.497054	2017-11-21 11:17:29.813194	0	\N	\N	\N	\N	cndp-PROP-2017-11-266	\N	\N	\N
267	Patrick Dehumau - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Attention à la circulation routière type A16 avec ces morts à répétition. Ils ont déjà baissé la vitesse et les camions roulent déjà en continue. A l’heure de pointe, habitant à Gravelines pour conduire une petite-fille à l’école, ça ne passe pas ! Comment faire ?	49	375	\N	2017-11-21 11:20:46.478886	2017-11-21 11:20:46.734896	0	\N	\N	\N	\N	cndp-PROP-2017-11-267	\N	\N	\N
268	Alexandre V. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	La formation doit aussi concerner les quadragénaires qui se retrouvent au chômage aujourd’hui. Concernant le projet, je ne suis pas contre mais pas chez moi et je vois d’ailleurs que Baltique ne pose problème à personne.	49	375	\N	2017-11-21 11:22:36.05746	2017-11-21 11:22:36.167805	0	\N	\N	\N	\N	cndp-PROP-2017-11-268	\N	\N	\N
269	François M. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Le projet, c’est du pipo. On est dans un jeu capitaliste. C’est la côte d’Opale, c’est la côte Seveso. C’est de la cuisine toxique et le port est le cuisinier. On nous enfume depuis longtemps. Prenez le terminal méthanier. L’intérêt privé a toujours pris le pas sur le public. Le capitaliste est là pour faire du pognon et non pour apporter un plus à l’humain.	49	375	\N	2017-11-21 11:24:07.447401	2017-11-21 11:24:07.563168	0	\N	\N	\N	\N	cndp-PROP-2017-11-269	\N	\N	\N
270	Jean-Pierre Bogaert - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Ce projet doit être associé à une politique de formation réellement opérationnelle afin que l’école puisse être adossée au port.	49	375	\N	2017-11-21 11:25:08.933255	2017-11-21 11:25:08.988753	0	\N	\N	\N	\N	cndp-PROP-2017-11-270	\N	\N	\N
271	Sylvie D. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Entre le projet Calais 2015 et le projet Dunkerque 2030, je n’ai qu’une chose à dire : Laissez-nous les plages !	49	375	\N	2017-11-21 11:25:48.659316	2017-11-21 11:25:48.733574	0	\N	\N	\N	\N	cndp-PROP-2017-11-271	\N	\N	\N
272	Marc S. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	C’est un projet qui aurait dû se faire il y a 50 ans. Je suis à Arcelor depuis ce temps-là. Nous étions 11000 salariés, aujourd’hui nous ne sommes plus que 3000. Ce port ne va pas apporter plus d’emplois. J’ai travaillé dans les différentes boîtes du coin. Le boulot était toujours plafonné. Et puis tous ces camions finiront par bloquer les routes. C’est la raison pour laquelle il faut le canal Seine-Nord en plus. Ils auraient dû le faire dans les années 80. Je n’y crois plus maintenant, à cause de la Belgique et des autres ports technologiquement avancés. On sera toujours à la ramasse.	49	375	\N	2017-11-21 11:27:25.965411	2017-11-21 11:27:25.97819	0	\N	\N	\N	\N	cndp-PROP-2017-11-272	\N	\N	\N
273	David F. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Ça va ramener de la vie. C’est mort ici. Je vais en Belgique pour bosser. Je suis tuyauteur, il n’y a pas de boulot à Dunkerque.	49	375	\N	2017-11-21 11:27:48.527869	2017-11-21 11:27:48.551257	0	\N	\N	\N	\N	cndp-PROP-2017-11-273	\N	\N	\N
274	Jean-Pierre G. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Gravelines n’est pas une poubelle même si on crée des emplois.	49	375	\N	2017-11-21 11:29:00.891874	2017-11-21 11:29:01.012705	0	\N	\N	\N	\N	cndp-PROP-2017-11-274	\N	\N	\N
275	Francis Fournier - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Comment voulez-vous que les habitants des villes limitrophes au projet puissent encore faire confiance à leurs élus quand on voit que le quai à pondéreux continue à nous polluer ? De plus les impôts locaux sont très lourds malgré les retombées économiques. On a tendance dans notre ville de Gravelines à tout masquer par l’emploi avec un excès d’employés municipaux et la venue en excès d’artistes. C’est une minorité qui casque tout en devant supporter la pollution. C’est du constat et il faut que ça change.	49	375	\N	2017-11-21 11:29:33.676751	2017-11-21 11:29:33.839084	0	\N	\N	\N	\N	cndp-PROP-2017-11-275	\N	\N	\N
276	Jean-Pierre Vielorog - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Dans les années 70, il y avait environ 17000 emplois alors que depuis 15 ans il n’y a que 5000.	49	375	\N	2017-11-21 11:30:30.474207	2017-11-21 11:30:30.564197	0	\N	\N	\N	\N	cndp-PROP-2017-11-276	\N	\N	\N
277	Thierry R. - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Aujourd’hui, si on ne met pas plus de moyens pour gérer le flux routier, on va droit dans le mur. Je suis routier, je le vois bien. On attend 4 heures à la guette, c’est pas 2 engins qui vont permettre de drainer 300 camions. Un bassin en plus et plus de containers, ça n’a rien arrangé. Un portique ou plus, j’attends de voir. 	49	375	\N	2017-11-21 11:31:23.888407	2017-11-21 11:31:23.936742	0	\N	\N	\N	\N	cndp-PROP-2017-11-277	\N	\N	\N
278	Stéphane Louchez - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	Je viens de Calais, ils font le port le long de la côte. Attention aux modifications paysagères et aux modifications de l’écosystème. De telles infrastructures influent sur les courants marins sur le long terme. Je reste pour une insertion du port dans les terres et non en mer. Question pollution, le ferroviaire ne fait pas tout pour réduire les consommations routières. Certes le GIN va être un plus mais pensons aux infrastructures de développement d’approvisionnement. C’est un investissement lourd pour les porte-conteneurs et les poids lourds. 	49	375	\N	2017-11-21 11:33:32.821215	2017-11-21 11:33:32.839835	0	\N	\N	\N	\N	cndp-PROP-2017-11-278	\N	\N	\N
286	David Frau - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	J’habite Loon-Plage. Je travaille à la centrale, le seul problème c’est le détour !	49	375	\N	2017-11-21 12:22:43.07102	2017-11-21 12:22:43.142177	0	\N	\N	\N	\N	cndp-PROP-2017-11-286	\N	\N	\N
292	Jules P. - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	Nous habitons Loon-Plage. Nous avons l’impression de vivre sur une île. Nous sommes entourés soit par l’eau, soit par l’autoroute. Nous avons perdu le Clipon et avons l’impression d’être enclavé ! Comment se projet contribue à nous libérer plutôt que nous enfermer ? Pourquoi abandonner Baltique ? 	49	375	\N	2017-11-21 12:50:10.960908	2017-11-21 12:50:11.09978	0	\N	\N	\N	\N	cndp-PROP-2017-11-292	\N	\N	\N
294	Nadine R. - Débat Mobile – Marché de Bergues - 13/11/2017	J’aimerai que le Dunkerquois soit reconnu en France et en Europe, que le port qui représente le territoire s’élargisse et face grandir la région qui en a besoin.	49	375	\N	2017-11-21 12:53:06.938059	2017-11-21 12:53:06.950061	0	\N	\N	\N	\N	cndp-PROP-2017-11-294	\N	\N	\N
296	Bruno Crochte - Débat Mobile – Marché de Bergues - 13/11/2017	Dunkerque doit se réveiller ! Le port est tombé en descente dans les années 80.	49	375	\N	2017-11-21 12:54:12.743209	2017-11-21 12:54:12.992992	0	\N	\N	\N	\N	cndp-PROP-2017-11-296	\N	\N	\N
298	Patrick B. - Débat Mobile – Marché de Bergues - 13/11/2017	Le projet oui, mais seulement si les employés sont des français et résidant de la région dunkerquoise et non du personnel qui vient d’autres régions avec des promesses mensongères et des formations bidons. 	49	375	\N	2017-11-21 13:11:01.757385	2017-11-21 13:11:01.984435	0	\N	\N	\N	\N	cndp-PROP-2017-11-298	\N	\N	\N
300	Yves B. - Débat Mobile – Marché de Bergues - 13/11/2017	Ils auraient dû faire les grèves avant. Les belges ont tout compris, les américains les ont approché et ils ont bossé avec eux. Avec un syndicat pareil (port autonome), on ne fera jamais rien de bon. Changeons de politique pour changer de comportement. 	49	375	\N	2017-11-21 13:12:12.895461	2017-11-21 13:12:12.913768	0	\N	\N	\N	\N	cndp-PROP-2017-11-300	\N	\N	\N
304	Emmannuel D. - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Je suis partagé. Je trouve que cette fracture dans la terre est une véritable blessure pour le territoire. Comme pour le méthanier ! On y peut rien ! C’est politique !	49	375	\N	2017-11-21 13:16:48.896514	2017-11-21 13:16:48.953726	0	\N	\N	\N	\N	cndp-PROP-2017-11-304	\N	\N	\N
363	Risques technologiques : probablement pas encore assez important !	Notre littoral Dunkerquois possède 15 sites Seveso (et bientôt encore plus), 1 installation nucléaire et de nombreux autres sites à risques classés (ICPE et autres). L’activité portuaire tend à développer le nombre de sites à risques et apporte également un risque lié à la manutention et au transport de matières dangereuses.\r\nUn peu d’histoire sur quelques accidents et catastrophes. Rappelez-vous en 1978, un camion chargé de propylène explose en Espagne à proximité d’un camping suite à un accident. Plus de 215 morts et de 200 grands brulés. Le Dunkerquois possède des réservoirs de polypropylène avec des capacités dépassant très largement le chargement d’un seul camion, même si ces réservoirs ne sont pas à proximité de population directe. Aujourd’hui, on considère bien souvent que les périmètres de risques sont inclus dans les propriétés des entreprises ou dépassent de très peu. C’était malheureusement également le cas pour l’usine AZF à Toulouse où les dégâts ont très largement dépassé les périmètres connus. La question est aussi de savoir quels risques sont pris en compte. Quand on voit que dans l’étude de risques du terminal méthanier (présenté lors de l’enquête d’utilité publique) le plus grand risque est l’explosion d’une canalisation de petite section (avec seulement une détonation audible à quelques kilomètres) mais jamais un dommage majeur sur l’une des grandes cuves ou un bateau, on peut donc être très inquiet ! Dans cette même étude, était cité pour la première fois un point sur « l’effet domino ». Malheureusement en raison des risques considérés, ce point est resté vide. Il est vrai que les périmètres de risques ne dépassent que très peu les enceintes des entreprises…\r\nLes citoyens ont peur mais également les autorités. Preuve en est, début 2009, une explosion a eu lieu à la Raffinerie des Flandres (limité au site), avec malheureusement le décès d’une personne et 3 blessés graves. Total a déclenché un POI faisant appel aux secours extérieurs. En moins d’une heure, les 2 hélicoptères de secours de la région se sont rendus sur place et des places jusque dans les hôpitaux belges et parisiens avaient été préparées.\r\nDepuis quelques années un nouveau risque apparaît comme majeur : celui d’un attentat sur des installations industrielles. Ce risque n’est pris en compte nulle part et peut être amplificateur sur l’effet domino avec des attaques simultanées. Mais c'est vrai ce risque n'a pas lieu d'être.\r\n\r\nLe port, en temps qu’acteur du développement, l’état mais également les élus locaux doivent prendre leurs responsabilités sur ces sujets majeurs. Les emplois ne justifient pas d’avoir un jour une catastrophe d’ampleur inégalée sur le littoral Dunkerquois. \r\nLe développement doit donc se faire de manière sélective et réfléchie.\r\n	49	419	\N	2017-12-15 09:23:15.721576	2017-12-15 09:23:15.914872	0	\N	\N	\N	\N	cndp-PROP-2017-12-363	\N	\N	\N
377	Pascal C. – Débat mobile – Marché de Cappelle-la-Grande – 09/12/2017	Ce projet est à la fois grandiose et effrayant, néanmoins il faut identifier et mesurer les impacts, notamment sur les plans démographiques et au niveau de l’habitat, de la santé publique et de l’environnement. En raison du trafic, il faut prévoir des itinéraires de délestage pour les poids lourds uniquement. Nous pourrions construire une route le long du littoral. A l’entrée de la France, en venant de Belgique, ils ont transformé la route en supprimant une voie. Ça devient du délire.	49	375	\N	2017-12-19 09:28:51.280128	2017-12-19 09:28:51.459859	0	\N	\N	\N	\N	cndp-PROP-2017-12-377	\N	\N	\N
378	Sylvie C. – Débat mobile – Marché de Cappelle-la-Grande – 09/12/2017	Boulogne-sur-mer est le premier port de pêche, Calais est le premier port de voyageurs et Dunkerque est le premier port industriel. Pourquoi sont-ils en concurrence ? Je ne comprends pas. Il faut savoir partager et ne plus être égoïste. Cela ferait davantage de travail pour les trois villes.	49	375	\N	2017-12-19 09:29:14.765534	2017-12-19 09:29:14.776908	0	\N	\N	\N	\N	cndp-PROP-2017-12-378	\N	\N	\N
379	Jeanne D. - Débat mobile – Marché de Cappelle-la-Grande – 09/12/2017	Monsieur Gouvard, ancien maire de Cappelle-la-Grande, a été une figure historique des dockers. Ce maire est une institution. Tous ce qui fait la grandeur de Cappelle : c’est lui.	49	375	\N	2017-12-19 09:29:36.950589	2017-12-19 09:29:37.05412	0	\N	\N	\N	\N	cndp-PROP-2017-12-379	\N	\N	\N
386	Avis de Roland Pattyn - reçu par email le 22/12/2017	Bonjour,\r\nOriginaire de Dunkerque, j'y retourne régulièrement.\r\nCe qui est désolant, c'est de voir le "vide" de bateaux dans l'ancien port (hormis peut-être le quai minéralier).\r\nA voir votre projet rien n'est prévu quant à la réhabilitation de cet ancien port et à son avenir...\r\nMerci de tenir compte de cet avis,\r\nCordialement\r\nRoland PATTYN	49	375	\N	2017-12-22 19:52:48.330343	2017-12-22 19:52:48.415363	0	\N	\N	\N	\N	cndp-PROP-2017-12-386	\N	\N	\N
284	Bruno Pessette - Débat Mobile - Espace Sportica - Gravelines - 11/11/2017	On a l’impression d’avoir affaire à un mur qui nous sépare de Dunkerque. Il ne faut pas qu’ils nous compliquent la vie pour aller à Dunkerque. Si ça se passe comme ça, autant aller à Calais, nous, Gravelinois. Nous ne sommes pas forcément contre le projet. Pas de travail sans chargement. Ça peut sortir Gravelines du « bourg ». Pourquoi ne pas appeler ce port, le port de Gravelines ou de Loon-plage d’ailleurs. Autre point, où va-t-on se loger avec tous les sites SEVESO ? Ils ont un périmètre de sécurité. Vous les jeunes où allez-vous trouver les sous pour travailler à proximité d’un bien qui aura pris du foncier ?	49	375	\N	2017-11-21 12:18:58.607297	2017-11-21 12:18:58.792899	0	\N	\N	\N	\N	cndp-PROP-2017-11-284	\N	\N	\N
287	Jonathan Barré - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	Ma femme est inscrite sur le réseau « alerte pollution ». L’été, nous recevons beaucoup d’alertes sms. Pensons aux petits bambins pour préserver leur santé ! Comment pouvez-vous nous garantir que les camions ne contribueront pas à polluer davantage notre territoire sachant que nous avons peu d’emprise sur la normalisation et la régulation des poids lourds étrangers ? 	49	375	\N	2017-11-21 12:23:05.817986	2017-11-21 12:23:05.893811	0	\N	\N	\N	\N	cndp-PROP-2017-11-287	\N	\N	\N
291	Gaetan S. - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	Il faut voir qui investit. Il ne faut pas que l’investissement revient à ceux qui mettent dans le pot mais aussi pour le territoire. Attention aux intérêts privés des communes. Tout ne doit pas revenir à Dunkerque. 	49	375	\N	2017-11-21 12:47:46.189714	2017-11-21 12:47:46.288924	0	\N	\N	\N	\N	cndp-PROP-2017-11-291	\N	\N	\N
301	Jean-Marie Bisstes - Débat Mobile – Marché de Loon-Plage - 12/11/2017	On ne cherche pas à nous miner le moral mais quand même quand on apprends que la Belgique va débarquer à Loon-Plage afin d’installer une usine de retraitement de déchets toxiques, on pense forcément au rejet de la fumée et au dégagement. Si ça continue, on va nous faire subir la même chose qu’à Mardyck et nous faire partir. Le village existait avant les usines, si ça continue, il nous arrivera la même chose. On est déjà nostalgique.	49	375	\N	2017-11-21 13:14:45.44767	2017-11-21 13:14:45.522958	0	\N	\N	\N	\N	cndp-PROP-2017-11-301	\N	\N	\N
305	Christine Bisstes - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Je suis sous traitement antiallergique, c’est systématiquement lié à la pollution, on a les yeux qui pleurent et le nez qui coule. Les fumées d’ArcelorMittal en fonction du vent nous frappent de plein fouet. Les jours de fortes chaleur, impossible de respirer et de profiter de sa terrasse. Notre piscine est noire, pour la nettoyer, on est obligé d’utiliser du chlore. 	49	375	\N	2017-11-21 13:17:13.173941	2017-11-21 13:17:13.200276	0	\N	\N	\N	\N	cndp-PROP-2017-11-305	\N	\N	\N
381	“En démocratie, vous dites ce que vous voulez, et vous faites ce qu'on vous dit.”De Gérard Barry	J'ai participé au débat à Loon-Plage ainsi qu'à la réunion synthèse d'hier à l'Escale.\r\nIl y aurait dû y avoir une distinction entre industriels et habitants car les préoccupations ne sont pas les mêmes et doivent pour autant toutes deux être considérées.\r\nJe trouve qu'il y a encore beaucoup trop d'incertitudes pour tirer des conclusions, même si in fine, le GPMD décidera.\r\nComment peut-on tirer des conclusions de 1300 questionnaires remplis seulement sur une agglomération de 203 800 habitants (en 2013) et dire en plus que 47 % ne connaissaient pas le projet mais que pour autant  78 % des sondés soient favorables? Le problème est qu'on ne retiendra que ce dernier chiffre qui, à mon sens, est faussé car potentiellement basé sur l'avis de 0.64 % de la population CUD!!Est-ce un élément exploitable?\r\nEnfin, je regrette pour ma part que la ville de Loon-Plage, pourtant directement impactée, n'ait eu aucun représentant hier, hormis une petite poignée d'habitants peu considérée dans une assemblée en grande partie composée d'industriels.\r\nSi la démocratie fait partie du projet, alors prenez en compte les préoccupations des habitants.	49	415	\N	2017-12-20 20:24:25.22938	2017-12-20 20:24:25.460112	0	\N	\N	\N	\N	cndp-PROP-2017-12-381	\N	\N	\N
382	Dunkerque Cap 2020. Le bon sens : la décroissance du trafic maritime	Bonjour,\r\nVous trouverez en pièce-joint la contribution intitulée "Dunkerque Cap 2020. Le bon sens : la décroissance du trafic maritime".\r\n\r\nRespectueuses salutations.\r\n\r\nThierry Brulavoine 06 77 89 09 35\r\nPorte-parole de la Maison commune de la décroissance\r\n\r\n\r\n\r\n	49	437	\N	2017-12-22 16:03:45.048235	2017-12-22 16:03:45.20203	0	\N	\N	\N	\N	cndp-PROP-2017-12-382	\N	\N	\N
289	Patrick et Thérèse H. - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	Franchement je plains les habitants de Loon-Plage qui vont connaître des nuisances sonores insupportables. Ce projet est un projet de pirate. Il crée une balafre sur le territoire. Le projet Baltique offre un respect, une ambiance paysagère plus cohérente et respectueuse. Concernant l’orientation des verts, auparavant ils dominaient.	49	375	\N	2017-11-21 12:45:39.538163	2017-11-21 12:45:39.801011	0	\N	\N	\N	\N	cndp-PROP-2017-11-289	\N	\N	\N
383	Quels dangers pour le milieu marin et la qualité des eaux côtières ?	Chargée de mission au sein de l’instance professionnelle du Comité Régional de la Conchyliculture, je souhaitais pouvoir exprimer l’inquiétude de la profession conchylicole sur ce projet. Elevant des moules au large de Dunkerque sans aucun intrant, la profession est totalement dépendante de la production primaire et de la bonne santé des écosystèmes marins. Ce projet nous pose des questions sur ses impacts potentiels pour la qualité des masses d’eaux côtières. Dans un premier temps, nous nous interrogeons sur la dispersion dans le milieu marin de matière terrestre. Des études ont-elles été déjà menées sur les contaminations éventuelles (bactériologiques, chimiques, présence de métaux lourds) sur les terres qui seront prélevées ? Des estimations sur la quantité de matière terrestre pouvant être remise à la mer ont-elles été réalisées ? Des mesures d’évitement peuvent-elles être mises en place pour retenir ces matériaux ? Dans un second temps, se pose la question sur la phase d’exploitation de cette partie du port. A long terme et au vu des profils proposés de l’extension, les quantités de sédiments dragués dans le port et clappés chaque année au large de Dunkerque risquent de s’accroître. Des analyses seront-elles mises en place ? Quel sera le devenir de ces sédiments s’ils montrent des signes de contamination ? Les études d’impacts dans ce projet, s’il se concrétise, devront pouvoir répondre à toutes ces questions et proposer des mesures ERC effectives et efficaces pour limiter les conséquences sur le milieu marin, source de richesse de plus en plus fragilisée. 	49	439	\N	2017-12-22 17:23:29.345742	2017-12-22 17:23:29.432351	0	\N	\N	\N	\N	cndp-PROP-2017-12-383	\N	\N	\N
290	Marc et Sylvie R. - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	Je suis défavorable au projet. Je vis à Saint-Georges, un village avec une ambiance villageoise. Aujourd’hui, j’ai le sentiment que mon village va devenir un hub logistique. La zone de grande industrie peut être comparée à l’installation d’un centre commercial XXL. Il faudrait utiliser l’argent pour construire des digues contre la montée des eaux. Nous sommes entrain de construire une zone sinistrée. 	49	375	\N	2017-11-21 12:46:19.556908	2017-11-21 12:46:19.612855	0	\N	\N	\N	\N	cndp-PROP-2017-11-290	\N	\N	\N
293	Alain Jeorge - Débat Mobile - Espace Sportica - Gravelines - 12/11/2017	Ce projet est un chantage à l’emploi et à la concurrence (Le Havre, Anvers). Il est présenté pour ne plus pouvoir dire que nous sommes contre. 	49	375	\N	2017-11-21 12:50:34.164427	2017-11-21 12:50:34.1981	0	\N	\N	\N	\N	cndp-PROP-2017-11-293	\N	\N	\N
295	Pierre Alain G. - Débat Mobile – Marché de Bergues - 13/11/2017	Les 16000 emplois, je n’y crois pas ! Surtout avec les industries et les logistiques qui vont venir, je vais être obligé de partir. Saint-Georges va disparaître c’est certain.	49	375	\N	2017-11-21 12:53:41.396177	2017-11-21 12:53:41.422788	0	\N	\N	\N	\N	cndp-PROP-2017-11-295	\N	\N	\N
297	Claude G. - Débat Mobile – Marché de Bergues - 13/11/2017	C’est un beau projet, il faut le fané, il faut aussi que ça marche ! Le problème c’est la mer, les marchands de poisson, il n’y en a plus ! Pour les petits pêcheurs, c’est impossible. Il faudrait redonner l’accès au port ! 	49	375	\N	2017-11-21 12:54:48.435217	2017-11-21 12:54:48.524207	0	\N	\N	\N	\N	cndp-PROP-2017-11-297	\N	\N	\N
299	Lucile Depecker - Débat Mobile – Marché de Bergues - 13/11/2017	Le conteneur, je ne suis pas favorable, c’est la mondialisation. On est envahit d’objets made in china. La voie sera-t-elle meilleure ? Les chiffres sont trop importants, c’est irréel ! Ce ne n’est pas le quotidien des gens. Clipon était un petit paradis. Des gens simples y allaient. Les dunes ont disparus. 	49	375	\N	2017-11-21 13:11:44.041392	2017-11-21 13:11:44.050666	0	\N	\N	\N	\N	cndp-PROP-2017-11-299	\N	\N	\N
302	Phillipe L. - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Pour le méthanier, ils nous ont promis des emplois. Ce sont de beaux parleurs. Au bout, cela produit de la richesse pour les riches. Pour les pauvres, nous avons gagné plus de cancers.	49	375	\N	2017-11-21 13:15:07.702541	2017-11-21 13:15:07.72394	0	\N	\N	\N	\N	cndp-PROP-2017-11-302	\N	\N	\N
303	Elianne Evrart - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Nous avons un souci avec le bruit, la poussière, mais pour la qualité de l’air c’est pire. On entend décharger les bateaux, on ne peut plus laisser les fenêtres ouvertes. Pour la question de la santé, je ne sais pas vers où on va. Gravelines va devenir invivable, un entonnoir. Si j’étais plus jeune, je partirai. Depuis que la centrale s’est installée, tout le monde ferme et s’en va ! Pechiney, la centrale, on nous a menti, on ne nous écoute plus, on arrive plus à se défendre. Ça donne des emplois pour des personnes qui font 100km pour venir travailler alors que Gravelines est pleine de chômeurs. 	49	375	\N	2017-11-21 13:16:17.883475	2017-11-21 13:16:17.900785	0	\N	\N	\N	\N	cndp-PROP-2017-11-303	\N	\N	\N
384	Capacité de Dunkerque à se développer	A l'encontre des avis défaitistes, le port de Dunkerque est capable de gagner des marchés face à Anvers et consorts.\r\nAinsi Mc Cain fait transiter ses frites par Dunkerque et non plus par le port belge.\r\nEn plus de l'emploi pour le dunkerquois cela est un atout pour les usines du fabricant dans le Pas-de-Calais, et cela sécurise aussi un débouché pour les agriculteurs, producteurs de pommes de terre en l’occurrence, de la région.\r\nC'est donc tout bénéf pour la région, dans la diversité de ses activités.\r\nS'agissant de conteneurs frigorifiques, le marché à une valeur ajoutée non négligeable, et favorise les emplois de maintenance et logistique dans un domaine où Dunkerque sait cultiver les formations et compétences.\r\n\r\nLe développement par les conteneurs permet au port d'améliorer sa compétitivité globale, et donc également celle de la partie vrac/minéralier.\r\nLa compétitivité du secteur minéralier, qui reste complémentaire à celui des conteneurs, est un atout pour la sidérurgie: usine à proximité immédiate ainsi que pour toute la filière avec,par exemple, les importants sites de production automobile et ferroviaire de la région.\r\n\r\nEn résumé, nous avons des atouts déjà reconnus, et oui, nous pouvons gagner face à nos gros concurrents. Le projet est bénéfique pour le dunkerquois, les Hauts-deFrance et le pays, pour une très large palette de métiers industriels, agro-alimentaires, agricoles ou de service.\r\n	50	372	\N	2017-12-22 18:15:57.201604	2017-12-22 18:15:57.295332	0	\N	\N	\N	\N	cndp-PROP-2017-12-384	\N	\N	\N
306	Marie-Hélène L. - Débat Mobile – Marché de Loon-Plage - 12/11/2017	J’organise des randonnées. Pour les membres, je les invite à ne pas circuler à la demie des heures impaires en raison du passage des ferrys. C’est de la folie, je ne me rendais pas compte des impacts. 	49	375	\N	2017-11-21 13:17:44.975139	2017-11-21 13:17:44.989342	0	\N	\N	\N	\N	cndp-PROP-2017-11-306	\N	\N	\N
307	Janine Guivarch - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Quel impact environnemental en lien avec les sites SEVESO existants et ceux en cours de développement. Le traitement des déchets est très dangereux. Quel impact par rapport à la circulation des poids lourds aux abords de Loon-Plage sachant que le trafic est déjà saturé sur l’A16 et à la sortie de la commune. Quel impact sur l’immobilier existant. Très sceptique a priori sur la création de l’emploi. Nous en avons fait les frais historiquement notamment sur le projet du terminal méthanier. Quantité, qualité, adéquation avec les profils du territoire.	49	375	\N	2017-11-21 13:18:07.795376	2017-11-21 13:18:07.847101	0	\N	\N	\N	\N	cndp-PROP-2017-11-307	\N	\N	\N
308	Christian Creton - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Le projet Baltique n’implique pas de coupure de route et donc moins de consommation d’essence.	49	375	\N	2017-11-21 13:18:28.520486	2017-11-21 13:18:28.542186	0	\N	\N	\N	\N	cndp-PROP-2017-11-308	\N	\N	\N
309	Jacques P. - Débat Mobile – Marché de Loon-Plage - 12/11/2017	C’est de la fumisterie ! Les usines devraient empêcher la diffusion des particules en utilisant des camions à eau. Une belle promesse. Résultat, on nous a bien entubés.	49	375	\N	2017-11-21 13:18:54.920635	2017-11-21 13:18:54.950997	0	\N	\N	\N	\N	cndp-PROP-2017-11-309	\N	\N	\N
310	Yvan Le Forestier - Débat Mobile – Marché de Loon-Plage - 12/11/2017	La version Atlantique sera à 500m de chez moi. Il y aura encore plus de bruit et de nuisances liées au transbordement : l’arrivée des bateaux et le chargement, le déchargement, les départs et les arrivées des camions. Du bruit en continue, ça n’est pas acceptable. Entre les travaux et la mise en marche du projet, il va y avoir beaucoup trop de temps. J’entends du bruit jusque 23h donc un arrêt promis pour 20h, laissez moi rire. On les entend même avant 6h réglementaires. Faites quelque chose aujourd’hui. Bing, bang, boom, ça ne s’arrête pas !	49	375	\N	2017-11-21 13:19:22.005423	2017-11-21 13:19:22.035174	0	\N	\N	\N	\N	cndp-PROP-2017-11-310	\N	\N	\N
311	Véronique Bricout - Débat Mobile – Marché de Loon-Plage - 12/11/2017	J’ai des vérandas. 5 baies en façade situé en plein nord. Il me faut 5 sceaux d’eau bien chaude pour nettoyer. La toiture on peut la faire tous les deux mois. Posons-nous des questions. Quand je vois que mes petits-enfants son atteints de bronchites et d’allergies à répétition !	49	375	\N	2017-11-21 13:19:45.440676	2017-11-21 13:19:45.481968	0	\N	\N	\N	\N	cndp-PROP-2017-11-311	\N	\N	\N
312	Odyle Bentounsi - Débat Mobile – Marché de Loon-Plage - 12/11/2017	Depuis que la filière conteneur est arrivée, nous avons de nouvelles bestioles et des plantes qui affectent notre écosystème. Nous le constatons dans nos jardins. Qu’est-ce qui sera fait pour éviter cette détérioration de la nature ? 	49	375	\N	2017-11-21 13:20:09.453038	2017-11-21 13:20:09.518632	0	\N	\N	\N	\N	cndp-PROP-2017-11-312	\N	\N	\N
313	Thomas Bernard - Débat Mobile – Marché de Loon-Plage - 12/11/2017	C’est déjà le bordel aujourd’hui. Nous sommes totalement congestionnés et je dois faire des détours. Concernant la valeur locative de ma maison, est-ce que vous pouvez nous donner des informations précises et fiables ? 	49	375	\N	2017-11-21 13:20:51.594572	2017-11-21 13:20:51.628498	0	\N	\N	\N	\N	cndp-PROP-2017-11-313	\N	\N	\N
314	Jacky Hennebert  - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	Ancien docker, je suis favorable à l’option Baltique notamment en raison de la proximité avec l’usine de gaz qui aurait servit à charger la cuve des bateaux avec du gaz. De plus, on sort du contexte historique. Nous sommes entrain de tourner le dos à notre histoire. Pour le stockage, l’option Baltique permet d’optimiser l’optimisation du vrac.	49	375	\N	2017-11-21 13:22:09.27442	2017-11-21 13:22:09.302673	0	\N	\N	\N	\N	cndp-PROP-2017-11-314	\N	\N	\N
315	Patrick \tV. - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	Le projet Atlantique est « petit joueur », il n’est pas nouveau. Baltique est un meilleur projet car il permet de diversifier le conteneur et le vrac. C’est le choix des pilotes. Il ne faut pas mégoter sur 1 ou 2 millions (même 300 millions). Ils prennent le plus rapide à faire pour partir ensuite et s’occuper de leur carrière. Mais le plus important dans tout ça, c’est les postes en plus !	49	375	\N	2017-11-21 13:22:30.158498	2017-11-21 13:22:30.188003	0	\N	\N	\N	\N	cndp-PROP-2017-11-315	\N	\N	\N
316	Olivier M. - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	Entre les retombées économiques et la transformation du paysage, il faut être pragmatique, l’économie est plus importante. Ce projet est pérenne. Il n’est pas là que pour 20 ans. C’est un mal nécessaire. 	49	375	\N	2017-11-21 13:22:50.8846	2017-11-21 13:22:50.894213	0	\N	\N	\N	\N	cndp-PROP-2017-11-316	\N	\N	\N
317	Jean Titeca  - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	Les belges sont moins idiots. Ils ont interdit aux poids lourds de doubler ! Aujourd’hui, sur la A16, nous sommes limité à 90km. Les poids lourds nous doublent ! L’A16  c’est bien simple. Quand j’ai un rendez-vous important, je l’évite.	49	375	\N	2017-11-21 13:23:10.894793	2017-11-21 13:23:10.907423	0	\N	\N	\N	\N	cndp-PROP-2017-11-317	\N	\N	\N
318	Lucien R. - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	La Belgique nous a tout pris. Pour le maïs venant d’Amérique, ils avaient investi pour une suceuse pompant directement de la péniche. Ils savent s’adapter au marché mondial. Prenons exemple pour développer notre économie et redorer notre image. 	49	375	\N	2017-11-21 13:23:33.948222	2017-11-21 13:23:34.022022	0	\N	\N	\N	\N	cndp-PROP-2017-11-318	\N	\N	\N
319	Thierry S. - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	Depuis Louis XIV nous n’avons plus de politique maritime. Il est temps qu’ils se réveillent même si nous auront toujours un temps de retard. 	49	375	\N	2017-11-21 13:23:51.363377	2017-11-21 13:23:51.516611	0	\N	\N	\N	\N	cndp-PROP-2017-11-319	\N	\N	\N
320	Rémi Fournier  - Débat Mobile – Marché de Malo-les-Bains - 14/11/2017	Ce projet est bien. Il ramènera de l’emploi. Mais profitons de l’occasion pour rouvrir le pont de l’écluse De Gaulle. Ça fait 3 ans que ça dure. A cause de ça, les gens ne peuvent plus sortir pour promener leur chien, pêcher, chasser. Je suis remorqueur, on fait 1h le matin et 1h le soir pour longer la digue en partant du port Est et arriver au canal des dunes. On teste depuis peu des postes fixes pour éviter les allers-retours.	49	375	\N	2017-11-21 13:24:16.099854	2017-11-21 13:24:16.118802	0	\N	\N	\N	\N	cndp-PROP-2017-11-320	\N	\N	\N
326	Contribution test OSP 1	Test avis stratégie portuaire	49	337	\N	2017-11-24 10:06:34.267472	2017-11-24 10:06:34.443726	0	\N	\N	\N	\N	cndp-PROP-2017-11-326	\N	\N	\N
327	Test d'une proposition 	Test d'une proposition  Test d'une proposition  Test d'une proposition 	52	358	\N	2017-11-24 10:07:58.272699	2017-11-24 10:07:58.323778	0	\N	\N	\N	\N	cndp-PROP-2017-11-327	\N	\N	\N
321	Courrier de Daniel Thoor au président de la CPDP	Dunkerque le 14 novembre 2017\r\n\r\nMonsieur le Président,\r\n\r\nSensible à votre invitation, j’ai assisté à deux réunions mises en place afin de présenter et expliquer le projet d’extension du Port de Dunkerque. Conscients que ce projet est vital pour Dunkerque, chacun était attentif et participatif tout en appréciant la qualité des intervenants et les précisions contenues dans la plaquette remise à cet effet.\r\nNous avons bien noté que la série de 70 réunions se terminait fin décembre et que vous vous donniez jusqu’à Mars 2018 pour rassembler les avis et arguments présentés par tout un chacun et que trois mois après, nous connaîtrons la décision du Maître d’ouvrage.\r\nOr, il se trouve que parallèlement, la députée LR Agnès Firmin-le Bodo qui a succédé en juin, à Edouard Philippe, ancien Maire du Havre, a adressé au Ministre de la Cohésion des Territoires, un courrier fustigeant ce « plan de 450 millions » nécessaires au Port de Dunkerque, au prétexte qu’ils seraient plus utiles au Havre ou à Marseille.\r\nCela rappelle aux Dunkerquois, un bien triste souvenir : en 1986, le maire de l’époque, Claude Prouvoyeur, avait rendu visite au ministre de l’Industrie Alain Madelin, qui lui avait donné tout apaisement quand au sort réservé aux Chantiers Navals de Dunkerque. Fort de cette certitude, il avait menacé de démissionner si les Chantiers étaient condamnés ! Le gouvernement prenait ensuite la décision de maintenir les chantiers navals de la Ciotat et de Saint Nazaire ! Ce qui provoqua, en 1987, la fermeture des Chantiers Navals de Dunkerque, qui avaient vu naitre 327 navires.\r\nIl convient d’être particulièrement vigilants quand à l’engagement de nos politiques, responsables à 200% du devenir du Port de Dunkerque.\r\nDes courriers à la presse locale seront appréciés, mais les vrais décisions seront prises dans les Ministères et c’est dès maintenant qu’il faudra y être et faire preuve de la plus grande fermeté. Pas quand il sera trop tard…\r\n\r\nComptant sur vous pour faire passer le message, veuillez agréer Monsieur Le Président, l’expression de mes très cordiales salutations, \r\nDaniel Thoor	49	375	\N	2017-11-23 16:35:03.719091	2017-11-23 16:35:04.146705	0	\N	\N	\N	\N	cndp-PROP-2017-11-321	\N	\N	\N
328	Mise en garde : Débat public de l’aménagement du Grand Port Maritime de Dunkerque : des contradictions en nombre	Mise en garde : Débat public de l’aménagement du Grand Port Maritime de Dunkerque : des contradictions en nombreed	52	358	\N	2017-11-24 10:13:39.440452	2017-11-24 10:13:39.543366	0	\N	\N	\N	\N	cndp-PROP-2017-11-328	\N	\N	\N
\.


--
-- Data for Name: decidim_reports; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_reports (id, decidim_moderation_id, decidim_user_id, reason, details, created_at, updated_at) FROM stdin;
1	1	335	spam		2017-09-21 14:10:44.528665	2017-09-21 14:10:44.528665
2	2	335	spam		2017-09-22 09:17:07.990587	2017-09-22 09:17:07.990587
3	3	387	does_not_belong	à supprimer	2017-10-14 10:42:01.120126	2017-10-14 10:42:01.120126
4	4	341	spam		2017-10-17 09:12:54.816481	2017-10-17 09:12:54.816481
5	5	341	spam		2017-10-17 10:02:07.926567	2017-10-17 10:02:07.926567
6	6	341	spam		2017-10-17 10:03:22.033872	2017-10-17 10:03:22.033872
7	6	346	spam		2017-10-17 10:10:16.215104	2017-10-17 10:10:16.215104
8	7	375	spam		2017-10-18 08:27:18.343297	2017-10-18 08:27:18.343297
9	8	335	spam		2017-10-27 08:15:18.340012	2017-10-27 08:15:18.340012
10	9	337	spam	Proposition test que je supprime immédiatement	2017-11-24 10:07:13.93013	2017-11-24 10:07:13.93013
11	11	341	offensive		2017-12-13 10:57:22.026444	2017-12-13 10:57:22.026444
12	12	375	spam		2017-12-15 11:13:43.843245	2017-12-15 11:13:43.843245
\.


--
-- Data for Name: decidim_resource_links; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_resource_links (id, from_type, from_id, to_type, to_id, name, data) FROM stdin;
\.


--
-- Data for Name: decidim_scope_types; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_scope_types (id, decidim_organization_id, name, plural) FROM stdin;
1	1	{"ca": "province", "en": "province", "es": "province"}	{"ca": "provinces", "en": "provinces", "es": "provinces"}
2	1	{"ca": "municipality", "en": "municipality", "es": "municipality"}	{"ca": "municipalities", "en": "municipalities", "es": "municipalities"}
\.


--
-- Data for Name: decidim_scopes; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_scopes (id, decidim_organization_id, created_at, updated_at, name, scope_type_id, parent_id, code, part_of) FROM stdin;
1	1	2017-09-13 12:47:14.676485	2017-09-13 12:47:14.707114	{"ca": "North Carolina", "en": "North Carolina", "es": "North Carolina"}	1	\N	FR	{1}
2	1	2017-09-13 12:47:14.714587	2017-09-13 12:47:14.728323	{"ca": "Kesslerberg", "en": "Kesslerberg", "es": "Kesslerberg"}	2	1	FR-IL	{2,1}
3	1	2017-09-13 12:47:14.736867	2017-09-13 12:47:14.746224	{"ca": "Schmelermouth", "en": "Schmelermouth", "es": "Schmelermouth"}	2	1	FR-VA	{3,1}
4	1	2017-09-13 12:47:14.752816	2017-09-13 12:47:14.761857	{"ca": "New Elody", "en": "New Elody", "es": "New Elody"}	2	1	FR-GA	{4,1}
5	1	2017-09-13 12:47:14.76937	2017-09-13 12:47:14.776122	{"ca": "Schneiderfort", "en": "Schneiderfort", "es": "Schneiderfort"}	2	1	FR-MT	{5,1}
6	1	2017-09-13 12:47:14.783118	2017-09-13 12:47:14.790031	{"ca": "South Carlotta", "en": "South Carlotta", "es": "South Carlotta"}	2	1	FR-DE	{6,1}
7	1	2017-09-13 12:47:14.795867	2017-09-13 12:47:14.800496	{"ca": "Pennsylvania", "en": "Pennsylvania", "es": "Pennsylvania"}	1	\N	KI	{7}
8	1	2017-09-13 12:47:14.806936	2017-09-13 12:47:14.81326	{"ca": "New Mortimerhaven", "en": "New Mortimerhaven", "es": "New Mortimerhaven"}	2	7	KI-HI	{8,7}
9	1	2017-09-13 12:47:14.820086	2017-09-13 12:47:14.826595	{"ca": "Port Harley", "en": "Port Harley", "es": "Port Harley"}	2	7	KI-ME	{9,7}
10	1	2017-09-13 12:47:14.832363	2017-09-13 12:47:14.838753	{"ca": "Wilkinsonbury", "en": "Wilkinsonbury", "es": "Wilkinsonbury"}	2	7	KI-VT	{10,7}
11	1	2017-09-13 12:47:14.844551	2017-09-13 12:47:14.851011	{"ca": "Durwardfort", "en": "Durwardfort", "es": "Durwardfort"}	2	7	KI-MD	{11,7}
12	1	2017-09-13 12:47:14.856604	2017-09-13 12:47:14.86283	{"ca": "Lurlineport", "en": "Lurlineport", "es": "Lurlineport"}	2	7	KI-NC	{12,7}
13	1	2017-09-13 12:47:14.86829	2017-09-13 12:47:14.87259	{"ca": "Maine", "en": "Maine", "es": "Maine"}	1	\N	JE	{13}
14	1	2017-09-13 12:47:14.877205	2017-09-13 12:47:14.883593	{"ca": "Handport", "en": "Handport", "es": "Handport"}	2	13	JE-NJ	{14,13}
15	1	2017-09-13 12:47:14.889057	2017-09-13 12:47:14.895414	{"ca": "South Kellen", "en": "South Kellen", "es": "South Kellen"}	2	13	JE-CA	{15,13}
16	1	2017-09-13 12:47:14.901044	2017-09-13 12:47:14.907198	{"ca": "Lake Jazmyne", "en": "Lake Jazmyne", "es": "Lake Jazmyne"}	2	13	JE-OR	{16,13}
17	1	2017-09-13 12:47:14.913036	2017-09-13 12:47:14.919471	{"ca": "South Carlichester", "en": "South Carlichester", "es": "South Carlichester"}	2	13	JE-PA	{17,13}
18	1	2017-09-13 12:47:14.925772	2017-09-13 12:47:14.932306	{"ca": "Lamontton", "en": "Lamontton", "es": "Lamontton"}	2	13	JE-SC	{18,13}
\.


--
-- Data for Name: decidim_static_pages; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_static_pages (id, title, slug, content, decidim_organization_id, created_at, updated_at) FROM stdin;
1	{"ca": "Títol predeterminat per faq", "en": "Default title for faq", "es": "Título predeterminado para faq"}	faq	{"ca": "Si us plau afegir contingut significatiu a la pàgina estàtica de faq en el quadre de comandament d'admin.", "en": "Please add meaningful content to the faq static page on the admin dashboard.", "es": "Agrega contenido significativo a la página estática de faq en el panel de admin."}	1	2017-09-13 12:47:16.074596	2017-09-13 12:47:16.074596
2	{"ca": "Títol predeterminat per terms-and-conditions", "en": "Default title for terms-and-conditions", "es": "Título predeterminado para terms-and-conditions"}	terms-and-conditions	{"ca": "Si us plau afegir contingut significatiu a la pàgina estàtica de terms-and-conditions en el quadre de comandament d'admin.", "en": "Please add meaningful content to the terms-and-conditions static page on the admin dashboard.", "es": "Agrega contenido significativo a la página estática de terms-and-conditions en el panel de admin."}	1	2017-09-13 12:47:16.085166	2017-09-13 12:47:16.085166
3	{"ca": "Títol predeterminat per accessibility", "en": "Default title for accessibility", "es": "Título predeterminado para accessibility"}	accessibility	{"ca": "Si us plau afegir contingut significatiu a la pàgina estàtica de accessibility en el quadre de comandament d'admin.", "en": "Please add meaningful content to the accessibility static page on the admin dashboard.", "es": "Agrega contenido significativo a la página estática de accessibility en el panel de admin."}	1	2017-09-13 12:47:16.09339	2017-09-13 12:47:16.09339
8	{"fr": "Page test"}	101	{"fr": "<p>Les pages statiques sont en dehors des processus (autrement dit en dehors des débats). Pas possible d'avoir des infos à l'intérieur des processus sur cette plateforme apparemment.</p><p>Test encapsulation vidéo Dailymotion : ne marche pas </p><p><br></p><iframe class=\\"ql-video\\" allowfullscreen=\\"true\\" src=\\"https://www.dailymotion.com/video/x5aojfg?collectionXid=x4t5yc\\" frameborder=\\"0\\"></iframe><p><br></p>"}	3	2017-11-14 07:57:18.2213	2017-11-14 09:24:58.077775
9	{"fr": "Page de niveau 2"}	102	{"fr": "<p>page de niveau 2 (test) pour la rubrique infos</p>"}	3	2017-11-14 12:23:56.515371	2017-11-14 12:23:56.515371
5	{"fr": "Conditions générales d'utilisation"}	conditions-utilisation	{"fr": "<p>Ces conditions d’utilisation présentent les principales caractéristiques de la plateforme de participation en ligne de la Commission nationale du débat public (CNDP), <u>participons.debatpublic.fr.</u> Cette plateforme vise à permettre la participation des citoyens dans les différents processus de participation (débats publics et concertations) organisés par la CNDP. </p><p>La plateforme <u>participons.debatpublic.fr</u> est administrée par la CNDP. Les différents processus participatifs ouverts à la participation des citoyens (débats publics et concertations) sont quant à eux modérés par les équipes qui les organisent (commissions particulières et garants). </p><p>En accédant à cette plateforme, vous vous engagez à lire et accepter les présentes conditions d’utilisation. </p><p><br></p><h2><strong><u>1 - Domaine d’application des conditions d’utilisation</u></strong></h2><p>&nbsp;</p><p>Les conditions d’utilisation concernent toutes les personnes physiques et morales qui participent sur cette plateforme. Lors de votre inscription sur <u>participons.debatpublic.fr</u> vous serez amené à accepter les présentes conditions d’utilisation. </p><p>La CNDP se réserve le droit de modifier les présentes conditions d’utilisation et s’engage à publier les versions actualisées ici-même. </p><p>&nbsp;</p><h2><strong><u>2 - Objectifs de la plateforme participons.debatpublic.fr</u></strong></h2><p>&nbsp;</p><p>À travers cette plateforme, la CNDP souhaite inciter les citoyens à prendre part aux processus de prise de décision concernant les projets, plans et programmes qui font l’objet d’une saisine de la Commission. </p><p>L’objectif de <u>participons.debatpublic.fr</u> est également de permettre l’inclusion de tous les publics, notamment de ceux qui n’ont pas l’habitude ou la possibilité de se déplacer dans les rencontres publiques. En proposant une plateforme de participation en ligne, la CNDP donne aux participants la possibilité de participer sans leur imposer une contrainte temporelle et physique. Vous pouvez participer d’où vous voulez au moment qui vous convient le mieux. </p><p>&nbsp;</p><h2><strong><u>3 - Présentation des moyens de participation sur la plateforme</u></strong></h2><p>&nbsp;</p><p>Toute personne physique ou morale inscrite sur la plateforme peut participer aux différents espaces de participation en ligne mis en place par la CNDP. Vous pourrez trouver, au sein d’un processus participatif, différents espaces de participation avec des objectifs et des caractéristiques bien précises. </p><p>Voici le descriptif détaillé de chaque espace de participation&nbsp;: </p><p><strong>Rencontres&nbsp;:</strong> cet espace rappelle les évènements prévus et passés dans le cadre du débat public ou de la concertation. Vous pouvez donc y retrouver des informations pratiques les concernant&nbsp;: le type de rencontre (réunion publique, atelier, débat mobile, <em>focus group</em>, rencontre en entreprise ou dans les établissements scolaires, etc.)&nbsp;; son déroulement et les modalités de participation du public ; les thèmes qu’y seront abordés&nbsp;; et la date, l’heure et le lieu de la rencontre. </p><p><strong>Questions / Réponses&nbsp;:</strong> cette modalité est réservée aux questions que vous souhaitez poser&nbsp;: </p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation. </li></ol><p>Vos questions concernent&nbsp;: </p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation). </li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions. </p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication &nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p><p><strong>Forum&nbsp;: </strong>il s’agit ici d’un espace ouvert où vous pouvez contribuer en proposant des sujets de discussion ou bien réagissant aux contributions d’autres participants. Vous pouvez ainsi proposer des thématiques de discussion en lien avec le sujet du débat public ou de la concertation, ou bien participer à des discussions qui sont déjà en cours.</p><p>Les animateurs des processus participatifs peuvent eux aussi proposer des sujets de discussion sur le forum. </p><p><strong>Avis&nbsp;: </strong>cette modalité est réservée à la publication d’un avis construit et argumenté concernant le projet, plan ou programme qui fait l’objet d’un processus de participation organisé par la CNDP. Les avis peuvent prendre deux formes&nbsp;: un simple avis, que vous pouvez publier directement sur la plateforme, ou un cahier d’acteur qui concerne spécifiquement les projets, plans ou programmes qui font l’objet d’un débat public et qui doivent être validés et mis en page par la CPDP avant d’être mis en ligne. &nbsp;</p><ol><li><strong>Avis&nbsp;:</strong> toute personne physique ou morale inscrite a le droit de publier un avis directement sur la plateforme. Cet avis doit être en lien avec le projet, plan ou programme soumis au débat public ou en lien avec le processus de participation (débat public ou concertation). Si votre avis est hors sujet, il sera dépublié. </li><li><strong>Cahier d’acteur&nbsp;: </strong>document publié selon un modèle préétabli et qui fait l’objet d’une validation par la commission particulière avant sa publication sur le site internet du débat (nomduprojet.debatpublic.fr). Il est réservé aux personnes morales (collectivité territoriale, association, chambre consulaire, syndicat, organisme public, organisme privé, etc.). Chaque structure ne peut déposer qu’un seul cahier d’acteur. Si votre proposition de cahier d’acteur semble incomplète ou n’est pas pertinente, la CPDP se réserve le droit de revenir vers vous pour vous demander d’effectuer des modifications. Si la proposition ne respecte pas les principes du débat, si elle n’apporte pas suffisamment d’enrichissement au débat, si elle n’a pas de rapport avec l’objet du débat public, si elle comporte des propos injurieux ou diffamatoires concernant des personnes ou des institutions, la CPDP pourra refuser sa publication. Vous pouvez d’ailleurs solliciter les conseils de la CPDP dans la rédaction de votre cahier d’acteur. </li></ol><p>Pour proposer un cahier d’acteur vous devez adresser le document comportant les textes et les illustrations au format numérique par voie électronique à l’adresse contact de la CPDP. Votre texte ne doit pas dépasser les 13&nbsp;000 signes (caractères espaces compris) et doit être rédigé en utilisant la police Calibri, 11 points. Il doit contenir les éléments suivants et être structuré de la manière suivante&nbsp;: </p><ul><li>Titre</li><li>Nom de la structure </li><li>Logo </li><li>Coordonnées&nbsp;: nom de la personne responsable, site internet, adresse.</li><li>Texte de présentation de la structure (400 signes)&nbsp;: statut, membres, objectifs et missions. </li><li>Un édito&nbsp;: présentation générale de votre propos (1&nbsp;400 signes).</li><li>Un texte où vous développez vos arguments (entre 7&nbsp;000 et 10&nbsp;000 signes) qui peut contenir des encadrés qui apportent des précisions ou mettent en exergue un argument en particulier.</li><li>Une conclusion / synthèse&nbsp;: il faut que le lecteur puisse y retrouver vos principaux arguments (1&nbsp;200 signes). </li><li>Illustrations&nbsp;avec une légende précisant la source et les droits d’auteur (notamment pour les photos).</li><li>Une synthèse de votre cahier d’acteur qui sera utilisée pour le présenter sur l’espace dédié au téléchargement des cahiers d’acteurs sur le site internet du débat public. Si vous ne fournissez pas de synthèse, la CPDP utilisera l’édito de votre cahier d’acteur à cette fin.</li></ul><p>Une fois réceptionné par la CPDP, vous devrez compter une dizaine de jours avant que votre cahier d’acteur ne soit validé, mis en forme et publié. Ce document sera également imprimé et pourra être distribué pendant des rencontres publiques. </p><p>Chaque processus participatif est particulier et a sa propre stratégie de participation en ligne. Les espaces et modalités décrits ci-dessus ne seront donc pas accessibles sur tous les processus participatifs mis en place par la CNDP. </p><p>&nbsp;</p><h2><strong><u>4 - Fonctionnement de la plateforme</u></strong></h2><p>&nbsp;</p><p><strong>Participation sur la plateforme </strong></p><p>Il est possible de naviguer librement et de façon anonyme à travers la plateforme. En revanche, pour participer à une discussion ou poser une question, il est impératif de s’inscrire sur la plateforme. Pour cela, il faut fournir une adresse électronique personnelle valide. Cette adresse n’est pas publiée sur le site, ni communiquée à un tiers (sauf accord de l’intéressé), son usage est strictement réservé à la CNDP. La CNDP s’autorise toutefois à utiliser cette adresse dans les cas où elle l’estime pertinent, par exemple pour informer son propriétaire de l’ouverture d’un nouveau processus participatif dans sa région et/ou sur une thématique sur laquelle il s’est déjà exprimé. </p><p>Les espaces dédiés aux différents processus de participation sont indexés par les moteurs de recherche courants (Google, Yahoo, etc.). Les participants sont donc susceptibles d’apparaître lors d’une recherche de leur nom. Afin de limiter cette exposition, la CNDP s’engage à rendre anonymes les espaces d’expression des différents sites de débat dans les mois qui suivent leur clôture. </p><p>Chaque message fait l’objet d’une modération qui permet de vérifier s’il respecte la charte de modération. Le rôle du modérateur est de préserver et garantir la qualité des discussions. Il veille en particulier à ne pas publier les messages jugés inappropriés ou qui ne respectent pas la législation en vigueur. Cela concerne notamment les contributions sur le forum, les questions, les avis et tout autre message publié sur la plateforme&nbsp;: </p><ul><li>qui n’est pas en relation avec les questions traitées dans le cadre du processus participatif (hors-sujet)&nbsp;;</li><li>comportant des attaques, insinuations ou insultes à l’égard d’une organisation ou d’une personne, en particulier si elles sont basées sur la race, les croyances, les origines ethniques ou l’orientation sexuelle&nbsp;;</li><li>incluant des propos agressifs, méprisants, obscènes ou à caractère pornographique&nbsp;; </li><li>poursuivant des fins commerciales ou publicitaires&nbsp;;</li><li>mentionnant des données personnelles (adresses, numéros de téléphone)&nbsp;; </li><li>contraires aux droits d'auteurs, au respect de la vie privée, au droit à l'image&nbsp;;</li><li>qui ne sont pas suffisamment argumentées&nbsp;; </li><li>reproduisant un contenu déjà publié (copier-coller, répétition).</li></ul><p>Le modérateur se réserve également le droit de ne pas publier une contribution si cela ne respecte pas les conditions présentées ci-dessus. </p><p><strong>Comptes d’utilisateurs </strong></p><p>Tout&nbsp;internaute&nbsp;désireux&nbsp;de participer sur cette plateforme doit&nbsp;créer&nbsp;un&nbsp;compte d’utilisateur. En tant qu’individu, lors de votre inscription sur la plateforme vous devrez fournir les informations suivantes&nbsp;: nom d’utilisateur (cette information sera rendue publique lors de vos publications, vous pouvez utiliser votre nom ou bien un pseudonyme si vous préférez préserver votre anonymat), adresse électronique personnelle valide et choisir un mot de passe. Vous devrez également accepter les conditions d’utilisation de la plateforme. À&nbsp;l’issue&nbsp;de&nbsp;la&nbsp;procédure&nbsp;d’inscription,&nbsp;le&nbsp;compte&nbsp;utilisateur&nbsp;est&nbsp;créé&nbsp;et l’internaute reçoit par email une confirmation de sa création qui lui permettra de valider son inscription. &nbsp;&nbsp;</p><p>Si vous représentez une structure (association, chambre consulaire, collectivité, etc.), lors de votre inscription sur la plateforme vous devrez fournir les informations suivantes&nbsp;: nom de l’organisation, nom de la personne responsable, adresse électronique valide, numéro de téléphone et choisir un mot de passe. Vous devrez également accepter les conditions d’utilisation de la plateforme. À&nbsp;l’issue&nbsp;de&nbsp;la&nbsp;procédure&nbsp;d’inscription,&nbsp;le&nbsp;compte&nbsp;utilisateur&nbsp;est&nbsp;créé&nbsp;et l’internaute reçoit par email une confirmation de sa création qui lui permettra de valider son inscription. &nbsp;&nbsp;</p><p>&nbsp;</p><h2><strong><u>5 - Protection des données personnelles</u></strong></h2><p>&nbsp;</p><p>Conformément à l’article 27 de la loi «&nbsp;informatique et libertés&nbsp;» du 6 janvier 1978 modifiée en 2004, vous bénéficiez d’un droit d’accès, de modification, de rectification et de suppression des informations qui vous concernent. Vous pouvez exercer ce droit en vous adressant à <a href=\\"mailto:contact@debatpublic.fr\\" target=\\"_blank\\">contact@debatpublic.fr</a> </p><p>La Commission nationale du débat public s’engage à ne pas transmettre vos informations personnelles à des tiers. </p>"}	2	2017-09-13 15:53:01.524709	2017-10-03 11:41:07.478292
7	{"fr": "Conditions d'utilisation"}	terms-and-conditions	{"fr": "<p>Ces conditions d’utilisation présentent les principales caractéristiques de la plateforme de participation en ligne de la Commission nationale du débat public (CNDP), <u>participons.debatpublic.fr.</u> Cette plateforme vise à permettre la participation des citoyens dans les différents processus de participation (débats publics et concertations) organisés par la CNDP.</p><p>La plateforme <u>participons.debatpublic.fr</u> est administrée par la CNDP. Les différents processus participatifs ouverts à la participation des citoyens (débats publics et concertations) sont quant à eux modérés par les équipes qui les organisent (commissions particulières et garants).</p><p>En accédant à cette plateforme, vous vous engagez à lire et accepter les présentes conditions d’utilisation.</p><p><br></p><h2><strong><u>1 - Domaine d’application des conditions d’utilisation</u></strong></h2><p>&nbsp;</p><p>Les conditions d’utilisation concernent toutes les personnes physiques et morales qui participent sur cette plateforme. Lors de votre inscription sur <u>participons.debatpublic.fr</u> vous serez amené à accepter les présentes conditions d’utilisation.</p><p>La CNDP se réserve le droit de modifier les présentes conditions d’utilisation et s’engage à publier les versions actualisées ici-même.</p><p>&nbsp;</p><h2><strong><u>2 - Objectifs de la plateforme participons.debatpublic.fr</u></strong></h2><p>&nbsp;</p><p>À travers cette plateforme, la CNDP souhaite inciter les citoyens à prendre part aux processus de prise de décision concernant les projets, plans et programmes qui font l’objet d’une saisine de la Commission.</p><p>L’objectif de <u>participons.debatpublic.fr</u> est également de permettre l’inclusion de tous les publics, notamment de ceux qui n’ont pas l’habitude ou la possibilité de se déplacer dans les rencontres publiques. En proposant une plateforme de participation en ligne, la CNDP donne aux participants la possibilité de participer sans leur imposer une contrainte temporelle et physique. Vous pouvez participer d’où vous voulez au moment qui vous convient le mieux.</p><p>&nbsp;</p><h2><strong><u>3 - Présentation des moyens de participation sur la plateforme</u></strong></h2><p>&nbsp;</p><p>Toute personne physique ou morale inscrite sur la plateforme peut participer aux différents espaces de participation en ligne mis en place par la CNDP. Vous pourrez trouver, au sein d’un processus participatif, différents espaces de participation avec des objectifs et des caractéristiques bien précises.</p><p>Voici le descriptif détaillé de chaque espace de participation&nbsp;:</p><p><strong>Rencontres&nbsp;:</strong> cet espace rappelle les évènements prévus et passés dans le cadre du débat public ou de la concertation. Vous pouvez donc y retrouver des informations pratiques les concernant&nbsp;: le type de rencontre (réunion publique, atelier, débat mobile, <em>focus group</em>, rencontre en entreprise ou dans les établissements scolaires, etc.)&nbsp;; son déroulement et les modalités de participation du public ; les thèmes qu’y seront abordés&nbsp;; et la date, l’heure et le lieu de la rencontre.</p><p><strong>Questions / Réponses&nbsp;:</strong> cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au maître d’ouvrage d’un projet ou à la personne publique responsable d’un plan ou programme.</li><li>Aux membres de la commission particulière (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le projet, plan ou programme qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le déroulement du processus de participation (débat public ou concertation).</li></ol><p>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p><p><strong>Forum&nbsp;: </strong>il s’agit ici d’un espace ouvert où vous pouvez contribuer en proposant des sujets de discussion ou bien réagissant aux contributions d’autres participants. Vous pouvez ainsi proposer des thématiques de discussion en lien avec le sujet du débat public ou de la concertation, ou bien participer à des discussions qui sont déjà en cours.</p><p>Les animateurs des processus participatifs peuvent eux aussi proposer des sujets de discussion sur le forum.</p><p><strong>Avis&nbsp;: </strong>cette modalité est réservée à la publication d’un avis construit et argumenté concernant le projet, plan ou programme qui fait l’objet d’un processus de participation organisé par la CNDP. Les avis peuvent prendre deux formes&nbsp;: un simple avis, que vous pouvez publier directement sur la plateforme, ou un cahier d’acteur qui concerne spécifiquement les projets, plans ou programmes qui font l’objet d’un débat public et qui doivent être validés et mis en page par la CPDP avant d’être mis en ligne.&nbsp;</p><ol><li><strong>Avis&nbsp;:</strong> toute personne physique ou morale inscrite a le droit de publier un avis directement sur la plateforme. Cet avis doit être en lien avec le projet, plan ou programme soumis au débat public ou en lien avec le processus de participation (débat public ou concertation). Si votre avis est hors sujet, il sera dépublié.</li><li><strong>Cahier d’acteur&nbsp;: </strong>document publié selon un modèle préétabli et qui fait l’objet d’une validation par la commission particulière avant sa publication sur le site internet du débat (nomduprojet.debatpublic.fr). Il est réservé aux personnes morales (collectivité territoriale, association, chambre consulaire, syndicat, organisme public, organisme privé, etc.). Chaque structure ne peut déposer qu’un seul cahier d’acteur. Si votre proposition de cahier d’acteur semble incomplète ou n’est pas pertinente, la CPDP se réserve le droit de revenir vers vous pour vous demander d’effectuer des modifications. Si la proposition ne respecte pas les principes du débat, si elle n’apporte pas suffisamment d’enrichissement au débat, si elle n’a pas de rapport avec l’objet du débat public, si elle comporte des propos injurieux ou diffamatoires concernant des personnes ou des institutions, la CPDP pourra refuser sa publication. Vous pouvez d’ailleurs solliciter les conseils de la CPDP dans la rédaction de votre cahier d’acteur.</li></ol><p>Pour proposer un cahier d’acteur vous devez adresser le document comportant les textes et les illustrations au format numérique par voie électronique à l’adresse contact de la CPDP. Votre texte ne doit pas dépasser les 13&nbsp;000 signes (caractères espaces compris) et doit être rédigé en utilisant la police Calibri, 11 points. Il doit contenir les éléments suivants et être structuré de la manière suivante&nbsp;:</p><ul><li>Titre</li><li>Nom de la structure</li><li>Logo</li><li>Coordonnées&nbsp;: nom de la personne responsable, site internet, adresse.</li><li>Texte de présentation de la structure (400 signes)&nbsp;: statut, membres, objectifs et missions.</li><li>Un édito&nbsp;: présentation générale de votre propos (1&nbsp;400 signes).</li><li>Un texte où vous développez vos arguments (entre 7&nbsp;000 et 10&nbsp;000 signes) qui peut contenir des encadrés qui apportent des précisions ou mettent en exergue un argument en particulier.</li><li>Une conclusion / synthèse&nbsp;: il faut que le lecteur puisse y retrouver vos principaux arguments (1&nbsp;200 signes).</li><li>Illustrations&nbsp;avec une légende précisant la source et les droits d’auteur (notamment pour les photos).</li><li>Une synthèse de votre cahier d’acteur qui sera utilisée pour le présenter sur l’espace dédié au téléchargement des cahiers d’acteurs sur le site internet du débat public. Si vous ne fournissez pas de synthèse, la CPDP utilisera l’édito de votre cahier d’acteur à cette fin.</li></ul><p>Une fois réceptionné par la CPDP, vous devrez compter une dizaine de jours avant que votre cahier d’acteur ne soit validé, mis en forme et publié. Ce document sera également imprimé et pourra être distribué pendant des rencontres publiques.</p><p>Chaque processus participatif est particulier et a sa propre stratégie de participation en ligne. Les espaces et modalités décrits ci-dessus ne seront donc pas accessibles sur tous les processus participatifs mis en place par la CNDP.</p><p>&nbsp;</p><h2><strong><u>4 - Fonctionnement de la plateforme</u></strong></h2><p>&nbsp;</p><p><strong>Participation sur la plateforme </strong></p><p>Il est possible de naviguer librement et de façon anonyme à travers la plateforme. En revanche, pour participer à une discussion ou poser une question, il est impératif de s’inscrire sur la plateforme. Pour cela, il faut fournir une adresse électronique personnelle valide. Cette adresse n’est pas publiée sur le site, ni communiquée à un tiers (sauf accord de l’intéressé), son usage est strictement réservé à la CNDP. La CNDP s’autorise toutefois à utiliser cette adresse dans les cas où elle l’estime pertinent, par exemple pour informer son propriétaire de l’ouverture d’un nouveau processus participatif dans sa région et/ou sur une thématique sur laquelle il s’est déjà exprimé.</p><p>Les espaces dédiés aux différents processus de participation sont indexés par les moteurs de recherche courants (Google, Yahoo, etc.). Les participants sont donc susceptibles d’apparaître lors d’une recherche de leur nom. Afin de limiter cette exposition, la CNDP s’engage à rendre anonymes les espaces d’expression des différents sites de débat dans les mois qui suivent leur clôture.</p><p>Chaque message fait l’objet d’une modération qui permet de vérifier s’il respecte la charte de modération. Le rôle du modérateur est de préserver et garantir la qualité des discussions. Il veille en particulier à ne pas publier les messages jugés inappropriés ou qui ne respectent pas la législation en vigueur. Cela concerne notamment les contributions sur le forum, les questions, les avis et tout autre message publié sur la plateforme&nbsp;:</p><ul><li>qui n’est pas en relation avec les questions traitées dans le cadre du processus participatif (hors-sujet)&nbsp;;</li><li>comportant des attaques, insinuations ou insultes à l’égard d’une organisation ou d’une personne, en particulier si elles sont basées sur la race, les croyances, les origines ethniques ou l’orientation sexuelle&nbsp;;</li><li>incluant des propos agressifs, méprisants, obscènes ou à caractère pornographique&nbsp;;</li><li>poursuivant des fins commerciales ou publicitaires&nbsp;;</li><li>mentionnant des données personnelles (adresses, numéros de téléphone)&nbsp;;</li><li>contraires aux droits d'auteurs, au respect de la vie privée, au droit à l'image&nbsp;;</li><li>qui ne sont pas suffisamment argumentées&nbsp;;</li><li>reproduisant un contenu déjà publié (copier-coller, répétition).</li></ul><p>Le modérateur se réserve également le droit de ne pas publier une contribution si cela ne respecte pas les conditions présentées ci-dessus.</p><p><strong>Comptes d’utilisateurs </strong></p><p>Tout&nbsp;internaute&nbsp;désireux&nbsp;de participer sur cette plateforme doit&nbsp;créer&nbsp;un&nbsp;compte d’utilisateur. En tant qu’individu, lors de votre inscription sur la plateforme vous devrez fournir les informations suivantes&nbsp;: nom d’utilisateur (cette information sera rendue publique lors de vos publications, vous pouvez utiliser votre nom ou bien un pseudonyme si vous préférez préserver votre anonymat), adresse électronique personnelle valide et choisir un mot de passe. Vous devrez également accepter les conditions d’utilisation de la plateforme. À&nbsp;l’issue&nbsp;de&nbsp;la&nbsp;procédure&nbsp;d’inscription,&nbsp;le&nbsp;compte&nbsp;utilisateur&nbsp;est&nbsp;créé&nbsp;et l’internaute reçoit par email une confirmation de sa création qui lui permettra de valider son inscription.&nbsp;&nbsp;</p><p>Si vous représentez une structure (association, chambre consulaire, collectivité, etc.), lors de votre inscription sur la plateforme vous devrez fournir les informations suivantes&nbsp;: nom de l’organisation, nom de la personne responsable, adresse électronique valide, numéro de téléphone et choisir un mot de passe. Vous devrez également accepter les conditions d’utilisation de la plateforme. À&nbsp;l’issue&nbsp;de&nbsp;la&nbsp;procédure&nbsp;d’inscription,&nbsp;le&nbsp;compte&nbsp;utilisateur&nbsp;est&nbsp;créé&nbsp;et l’internaute reçoit par email une confirmation de sa création qui lui permettra de valider son inscription.&nbsp;&nbsp;</p><p>&nbsp;</p><h2><strong><u>5 - Protection des données personnelles</u></strong></h2><p>&nbsp;</p><p>Conformément à l’article 27 de la loi «&nbsp;informatique et libertés&nbsp;» du 6 janvier 1978 modifiée en 2004, vous bénéficiez d’un droit d’accès, de modification, de rectification et de suppression des informations qui vous concernent. Vous pouvez exercer ce droit en vous adressant à <a href=\\"mailto:contact@debatpublic.fr\\" target=\\"_blank\\">contact@debatpublic.fr</a></p><p>La Commission nationale du débat public s’engage à ne pas transmettre vos informations personnelles à des tiers.</p>"}	2	2017-09-22 09:28:41.350742	2017-10-03 11:41:20.574777
6	{"fr": "FAQ"}	faq	{"fr": "<h2><strong>Modalités et espaces de participation </strong></h2><p><br></p><h3><strong>Rencontres</strong></h3><p>Cet espace rappelle les évènements prévus et passés dans le cadre du débat public ou de la concertation. Vous pouvez donc y retrouver des informations pratiques les concernant&nbsp;: le type de rencontre (réunion publique, atelier, débat mobile, <em>focus group</em>, rencontre en entreprise ou dans les établissements scolaires, etc.)&nbsp;; son déroulement et les modalités de participation du public ; les thèmes qu’y seront abordés&nbsp;; et la date, l’heure et le lieu de la rencontre.</p><p><br></p><h3><strong>Questions / Réponses</strong></h3><p>Cette modalité est réservée aux questions que vous souhaitez poser&nbsp;:</p><ol><li>Au <strong>maître d’ouvrage</strong> d’un projet ou à la <strong>personne publique responsable</strong> d’un plan ou programme.</li><li>Aux <strong>membres de la commission particulière</strong> (CPDP) chargée de l’animation du débat ou au garant chargé du suivi de la concertation.</li></ol><p>Vos questions concernent&nbsp;:</p><ol><li>Le <strong>projet, plan ou programme</strong> qui fait l’objet d’un processus de participation (débat public ou concertation).</li><li>Le <strong>déroulement du processus de participation</strong> (débat public ou concertation).</li></ol><p><strong>Seuls le maître d’ouvrage, la personne publique responsable, la commission particulière ou le garant peuvent répondre à vos questions.</strong></p><p>Une réponse sera apportée à votre question dans un délai de 15 jours à partir de la date de publication&nbsp;sur la plateforme. Si votre question n’est pas pertinente ou hors sujet, les modérateurs se réserveront le droit de la republier dans le forum.</p><p><br></p><h3><strong>Forum</strong></h3><p>Il s’agit ici d’un espace ouvert où vous pouvez contribuer en proposant des sujets de discussion ou bien réagissant aux contributions d’autres participants. Vous pouvez ainsi proposer des thématiques de discussion en lien avec le sujet du débat public ou de la concertation, ou bien participer à des discussions qui sont déjà en cours.</p><p>Les animateurs des processus participatifs peuvent eux aussi proposer des sujets de discussion sur le forum.</p><p><br></p><h3><strong>Avis &amp; cahier d'acteur</strong></h3><p><strong>C</strong>ette modalité est réservée à la publication d’un avis construit et argumenté concernant le projet, plan ou programme qui fait l’objet d’un processus de participation organisé par la CNDP. Les avis peuvent prendre deux formes&nbsp;: un simple avis, que vous pouvez publier directement sur la plateforme, ou un cahier d’acteur qui concerne spécifiquement les projets, plans ou programmes qui font l’objet d’un débat public et qui doivent être validés et mis en page par la CPDP avant d’être mis en ligne.&nbsp;</p><ol><li><strong>Avis&nbsp;:</strong> toute personne physique ou morale inscrite a le droit de publier un avis directement sur la plateforme. Cet avis doit être en lien avec le projet, plan ou programme soumis au débat public ou en lien avec le processus de participation (débat public ou concertation). Si votre avis est hors sujet, il sera dépublié.</li><li><strong>Cahier d’acteur&nbsp;: </strong>document publié selon un modèle préétabli et qui fait l’objet d’une validation par la commission particulière avant sa publication sur le site internet du débat (nomduprojet.debatpublic.fr). Il est réservé aux personnes morales (collectivité territoriale, association, chambre consulaire, syndicat, organisme public, organisme privé, etc.). Chaque structure ne peut déposer qu’un seul cahier d’acteur. Si votre proposition de cahier d’acteur semble incomplète ou n’est pas pertinente, la CPDP se réserve le droit de revenir vers vous pour vous demander d’effectuer des modifications. Si la proposition ne respecte pas les principes du débat, si elle n’apporte pas suffisamment d’enrichissement au débat, si elle n’a pas de rapport avec l’objet du débat public, si elle comporte des propos injurieux ou diffamatoires concernant des personnes ou des institutions, la CPDP pourra refuser sa publication. Vous pouvez d’ailleurs solliciter les conseils de la CPDP dans la rédaction de votre cahier d’acteur.</li></ol><p>Pour proposer un cahier d’acteur vous devez adresser le document comportant les textes et les illustrations au format numérique par voie électronique à l’adresse contact de la CPDP. Votre texte ne doit pas dépasser les 13&nbsp;000 signes (caractères espaces compris) et doit être rédigé en utilisant la police Calibri, 11 points. Il doit contenir les éléments suivants et être structuré de la manière suivante&nbsp;:</p><ul><li>Titre</li><li>Nom de la structure</li><li>Logo</li><li>Coordonnées&nbsp;: nom de la personne responsable, site internet, adresse.</li><li>Texte de présentation de la structure (400 signes)&nbsp;: statut, membres, objectifs et missions.</li><li>Un édito&nbsp;: présentation générale de votre propos (1&nbsp;400 signes).</li><li>Un texte où vous développez vos arguments (entre 7&nbsp;000 et 10&nbsp;000 signes) qui peut contenir des encadrés qui apportent des précisions ou mettent en exergue un argument en particulier.</li><li>Une conclusion / synthèse&nbsp;: il faut que le lecteur puisse y retrouver vos principaux arguments (1&nbsp;200 signes).</li><li>Illustrations&nbsp;avec une légende précisant la source et les droits d’auteur (notamment pour les photos).</li><li>Une synthèse de votre cahier d’acteur qui sera utilisée pour le présenter sur l’espace dédié au téléchargement des cahiers d’acteurs sur le site internet du débat public. Si vous ne fournissez pas de synthèse, la CPDP utilisera l’édito de votre cahier d’acteur à cette fin.</li></ul><p>Une fois réceptionné par la CPDP, vous devrez compter une dizaine de jours avant que votre cahier d’acteur ne soit validé, mis en forme et publié. Ce document sera également imprimé et pourra être distribué pendant des rencontres publiques.</p>"}	2	2017-09-15 15:26:22.822078	2017-10-03 11:41:32.011701
\.


--
-- Data for Name: decidim_surveys_survey_answers; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_surveys_survey_answers (id, body, decidim_user_id, decidim_survey_id, decidim_survey_question_id, created_at, updated_at) FROM stdin;
1	["Test"]	358	9	22	2018-02-02 07:07:14.096478	2018-02-02 07:07:14.096478
2	["Test"]	358	9	23	2018-02-02 07:07:14.329288	2018-02-02 07:07:14.329288
3	["Test"]	358	9	24	2018-02-02 07:07:14.358026	2018-02-02 07:07:14.358026
4	["Test"]	358	9	25	2018-02-02 07:07:14.370082	2018-02-02 07:07:14.370082
\.


--
-- Data for Name: decidim_surveys_survey_questions; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_surveys_survey_questions (id, body, decidim_survey_id, created_at, updated_at, "position", mandatory, question_type, answer_options) FROM stdin;
1	{"ca": "Asperiores unde aut soluta impedit odit voluptas. Sint blanditiis est. Quibusdam voluptatibus voluptas at magni animi quasi. Voluptates cupiditate amet debitis. Et itaque doloribus voluptatem porro sit.", "en": "Et beatae aliquam dolor fugiat praesentium eum facere. Quasi porro sapiente quae minima accusamus. Optio quae ducimus commodi officiis aut odio.", "es": "Ipsam ullam magnam ut quia. Corporis et modi. Ex dolor delectus minima sunt corrupti. Deleniti quos aut magni. Expedita aut odio."}	1	2017-09-13 12:47:33.945421	2017-09-13 12:47:33.945421	\N	\N	short_answer	[]
2	{"ca": "Ducimus explicabo accusantium eos ea voluptates asperiores voluptatem. Minus et aut omnis sit. Porro quis voluptatem exercitationem perferendis dolore sequi sed.", "en": "Velit atque consequatur ullam totam. Repudiandae eligendi nihil nulla. Aperiam non cum esse sunt ipsa. Aut quia autem. Amet corrupti possimus et.", "es": "Eaque consequatur numquam itaque quae aut excepturi sit. Et non eum quaerat impedit ut itaque voluptas. Assumenda eius beatae dolores aut voluptatum est totam."}	1	2017-09-13 12:47:33.96856	2017-09-13 12:47:33.96856	\N	\N	short_answer	[]
3	{"ca": "Consequatur vel quos. Possimus ad nesciunt. Et sunt rerum aliquam.", "en": "Facere necessitatibus non distinctio maiores. Pariatur eum non dolorem quisquam aspernatur. Sint dolor quod dolorem. Nihil aperiam eius incidunt ea a maxime. Quis doloribus voluptatem.", "es": "Quibusdam hic consequatur debitis beatae dolor. Consectetur voluptatem culpa dolorem. Unde non eveniet impedit iusto."}	1	2017-09-13 12:47:33.976419	2017-09-13 12:47:33.976419	\N	\N	short_answer	[]
4	{"ca": "Sit odit est provident rem. Placeat et at dolorum officiis et. Est voluptates minus ratione ut excepturi. Dolorem et culpa fugit iure sequi similique saepe.", "en": "Dignissimos beatae maiores. Nostrum similique aliquam doloremque deleniti impedit voluptas qui. Voluptatem possimus minus necessitatibus veniam asperiores rerum nostrum. Libero ut accusamus nihil placeat hic nemo consequatur. Provident quibusdam facilis veniam enim earum laboriosam aut.", "es": "Cum beatae earum est ad nam enim. Perspiciatis error et aut est qui adipisci. Illo voluptatem sed eum ad explicabo veritatis excepturi. Aliquam optio dolor beatae."}	2	2017-09-13 12:47:50.735321	2017-09-13 12:47:50.735321	\N	\N	short_answer	[]
5	{"ca": "Velit tempore sit vero ut aliquam magnam. Cumque nulla voluptates laborum saepe non delectus. Delectus ut debitis et velit. Optio repudiandae nesciunt eaque. Ut ut aut quasi eum est.", "en": "Repellat enim et id. Voluptatem labore minima at voluptates placeat earum praesentium. Dolor dolorum ut.", "es": "Rerum nesciunt delectus. Molestias quibusdam omnis veniam. Sit temporibus officia."}	2	2017-09-13 12:47:50.741679	2017-09-13 12:47:50.741679	\N	\N	short_answer	[]
6	{"ca": "Iure et aut in ut. Voluptatum minima quaerat sunt cumque non harum. Repellendus assumenda ut ab et. Ipsa eos alias consequatur molestias itaque est ut. Amet id voluptatem ut facilis.", "en": "In amet ut magni recusandae sit cumque quia. Eos impedit ut. Deserunt maiores nihil et est unde ut. Esse dolorem nesciunt perspiciatis et harum accusamus.", "es": "Dolorem sint aut assumenda nihil amet. Enim asperiores blanditiis odio rerum recusandae quae. Eum ut voluptatum placeat sapiente odit nobis recusandae. Voluptatibus voluptas tempora est magnam exercitationem. Nihil adipisci voluptates."}	2	2017-09-13 12:47:50.746905	2017-09-13 12:47:50.746905	\N	\N	short_answer	[]
7	{"ca": "Qui debitis nihil dolores repellendus consequatur nemo dignissimos. Ut explicabo officiis corporis natus omnis itaque. Non quia earum laboriosam at ducimus sint. Fugiat quo sit et quia aspernatur sequi ex. Suscipit dignissimos et culpa et eos doloribus.", "en": "Autem sequi doloribus. Et et rem odio deserunt sapiente. Et ad sed libero rerum culpa consectetur. Ex dignissimos quia sapiente nostrum. Amet molestias repellat rerum.", "es": "Vero repellat optio eius eaque quidem omnis. Pariatur iure recusandae voluptatem est. Eos maxime ut dicta asperiores facere qui. Nemo dignissimos mollitia praesentium ipsam. Aut facere officiis est et odio voluptatem aperiam."}	3	2017-09-13 12:48:08.635202	2017-09-13 12:48:08.635202	\N	\N	short_answer	[]
8	{"ca": "Porro ducimus cum qui vitae velit possimus consectetur. Voluptas minima nisi sed quia. Adipisci eligendi accusamus voluptates quos. Laudantium consequatur sit.", "en": "Dolorum nihil non similique omnis occaecati dignissimos explicabo. Iure incidunt provident temporibus. Aut est ducimus omnis dolores dicta provident qui. Amet id sunt quisquam ullam quod.", "es": "Sapiente et qui et eos. Sunt doloribus distinctio omnis. Adipisci voluptate laborum a. Eos ipsum eos numquam at dolorum officiis."}	3	2017-09-13 12:48:08.642001	2017-09-13 12:48:08.642001	\N	\N	short_answer	[]
9	{"ca": "Iste cumque sint dolorem doloremque. Et rerum provident adipisci nulla qui ipsa. Eum aut occaecati eum quia non aut quae. Dolor exercitationem vel et quasi.", "en": "Dicta nostrum quia minima sint voluptatum sequi sit. Veniam consequuntur molestiae qui. Minus sit rerum hic doloremque dolores exercitationem.", "es": "Beatae consectetur vel porro dolores. Omnis nisi illum unde accusamus cum. Quasi cupiditate voluptatem officiis praesentium quis. Sequi illum minima est quod."}	3	2017-09-13 12:48:08.650049	2017-09-13 12:48:08.650049	\N	\N	short_answer	[]
10	{"ca": "Quod impedit nisi totam voluptas dolorum. Nihil quaerat possimus repudiandae. Est sequi similique dolorum doloremque illum consequatur nihil. Labore eum mollitia dolorum ducimus quia.", "en": "Commodi qui error ipsa voluptatem vel ut quia. Quisquam labore est repellendus adipisci voluptatibus atque. Eveniet reprehenderit quidem. Neque iste omnis quis facilis ex provident ullam. Nulla qui ex dolor nesciunt voluptas.", "es": "Ipsum eos consequatur recusandae qui distinctio. Qui et ea impedit quia qui laboriosam. Facere magni omnis quis sit."}	4	2017-09-13 12:48:24.757886	2017-09-13 12:48:24.757886	\N	\N	short_answer	[]
11	{"ca": "Quod repellendus perferendis nesciunt odio. Delectus sit facere quidem doloremque. Dolorem deleniti asperiores porro fugiat et nobis. Dicta molestiae ducimus. Voluptas fugit optio quis velit a.", "en": "Et exercitationem minima eligendi ut est odio. Enim ut similique quasi. Qui consectetur assumenda. Architecto et velit est itaque. Rerum alias dicta.", "es": "Aut id corrupti molestiae. Qui doloremque explicabo quidem et adipisci nobis. Officiis placeat eveniet. Aut aut possimus."}	4	2017-09-13 12:48:24.762356	2017-09-13 12:48:24.762356	\N	\N	short_answer	[]
12	{"ca": "Quam beatae eos omnis. Soluta est labore optio autem architecto sed. Illo quia aut commodi. Quam quo minima. Odio et sed suscipit tempora cupiditate voluptas provident.", "en": "Commodi ut quia possimus laboriosam sint praesentium. Error amet quia. Et voluptatem qui in animi.", "es": "Perspiciatis aut autem et. Qui qui cum. Et quo voluptas ducimus culpa vel reiciendis tempora. Assumenda saepe autem. Qui rerum dolor magnam earum."}	4	2017-09-13 12:48:24.766773	2017-09-13 12:48:24.766773	\N	\N	short_answer	[]
13	{"ca": "Nesciunt autem omnis corporis non aut qui rerum. Voluptas occaecati ex numquam. Molestias sapiente maxime sunt nihil.", "en": "Commodi quasi et voluptatem. Aut modi aut iusto dolores. Et est sit dolorem ducimus.", "es": "Eaque praesentium dolores maxime tempora animi voluptates veritatis. Et consequatur laudantium qui itaque. Et odio omnis accusamus consequatur quo praesentium voluptas. Cupiditate corporis deserunt quia soluta fuga."}	5	2017-09-13 12:48:41.012125	2017-09-13 12:48:41.012125	\N	\N	short_answer	[]
14	{"ca": "Modi possimus rerum. Vel aperiam praesentium. Asperiores ullam dolor harum minus qui dolorum.", "en": "Et sint qui assumenda aliquid. Rem amet praesentium nihil cupiditate. Nulla qui hic repellendus fuga et. Molestiae aliquid tenetur aut cumque neque ipsa voluptatem. Quasi laborum exercitationem officiis molestias aut veniam.", "es": "Ducimus ullam sint magni adipisci esse rem ut. Voluptas quo est est unde eligendi molestiae enim. Rerum aut voluptates et labore quos. Reprehenderit eaque ad quia corrupti ex. Quas veritatis deserunt assumenda velit ut."}	5	2017-09-13 12:48:41.016797	2017-09-13 12:48:41.016797	\N	\N	short_answer	[]
15	{"ca": "In eaque distinctio. Fugit ducimus omnis porro aut sit. Aspernatur ab ut error nihil. Adipisci fuga dignissimos repellat ea hic ut.", "en": "Consequatur nam sed vero eveniet corporis. Laborum mollitia autem. Omnis nihil molestias quia ipsa sit sit. Id culpa voluptate recusandae aut. Et veritatis eaque soluta sequi.", "es": "In nobis qui eius. Expedita et magni ducimus quibusdam ipsum fugit officiis. Veniam quia rerum vero alias sit. Delectus aut repudiandae laboriosam. Voluptates reiciendis ducimus vero."}	5	2017-09-13 12:48:41.026235	2017-09-13 12:48:41.026235	\N	\N	short_answer	[]
16	{"ca": "Aspernatur placeat consectetur. Ea fugit ratione quis et repellat. Similique rem eos est doloribus qui sed vitae.", "en": "Qui laudantium ut rem sed aut quisquam. Ea minima unde et molestias voluptas. Est temporibus autem alias non.", "es": "Facilis cumque veritatis possimus quos odio. Similique quis perspiciatis autem inventore hic. Dicta rerum quis. Rerum aut nemo suscipit in deserunt dolorem omnis."}	6	2017-09-13 12:48:56.419467	2017-09-13 12:48:56.419467	\N	\N	short_answer	[]
17	{"ca": "Tempore ipsam velit molestiae harum accusamus ut et. Delectus officiis blanditiis nostrum laboriosam vero. Eos est alias temporibus ducimus odit.", "en": "Quasi labore beatae pariatur asperiores blanditiis. Dolorem voluptatem rerum dolore et voluptatum enim et. Ea aut aut est ea. Esse doloribus voluptas rerum.", "es": "Numquam aut aperiam voluptas recusandae beatae. Nihil error rerum voluptate et vel et maxime. Provident quis vitae numquam."}	6	2017-09-13 12:48:56.424274	2017-09-13 12:48:56.424274	\N	\N	short_answer	[]
18	{"ca": "Eaque quo earum est eos autem. Quaerat magni sit. Velit ad aut ut consequatur corporis vel ab. Harum voluptates ipsa maxime nostrum laboriosam. Recusandae quam velit ut ipsum quia rerum.", "en": "Natus esse rerum. Vitae tempora eum quia facilis ratione unde pariatur. Excepturi nesciunt quis dolores. Error atque amet ducimus ea animi quidem qui.", "es": "Necessitatibus animi praesentium soluta nobis laboriosam. Ipsum nostrum iusto optio incidunt et assumenda. Et blanditiis consequuntur laboriosam cum delectus quia numquam."}	6	2017-09-13 12:48:56.428719	2017-09-13 12:48:56.428719	\N	\N	short_answer	[]
19	{}	7	2018-01-25 16:01:54.040252	2018-01-25 16:04:47.280433	0	t	single_option	[]
20	{}	7	2018-01-25 16:04:47.293	2018-01-25 16:04:47.293	1	t	single_option	[]
21	{}	8	2018-01-25 16:40:35.995028	2018-01-25 16:40:35.995028	0	f	short_answer	[]
22	{"fr": "Test"}	9	2018-02-02 07:00:04.969634	2018-02-02 07:00:04.969634	0	t	short_answer	[]
23	{"fr": "Test"}	9	2018-02-02 07:00:05.100335	2018-02-02 07:00:05.100335	1	t	long_answer	[]
24	{"fr": "Test"}	9	2018-02-02 07:00:05.118794	2018-02-02 07:00:05.118794	2	f	single_option	[{"body": {"fr": "Test"}}, {"body": {"fr": "Test"}}]
25	{"fr": "Test"}	9	2018-02-02 07:00:05.140028	2018-02-02 07:00:05.140028	3	f	multiple_option	[{"body": {"fr": "Test"}}, {"body": {"fr": "Test"}}]
\.


--
-- Data for Name: decidim_surveys_surveys; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_surveys_surveys (id, title, description, tos, decidim_feature_id, published_at, created_at, updated_at) FROM stdin;
1	{"ca": "Itaque esse enim ut eum placeat. Fuga maiores ut enim incidunt ab omnis. Ea labore ad quo nam. Numquam nemo repudiandae.", "en": "Omnis vero repudiandae non quis consequatur. Alias dolorum quam incidunt blanditiis. Quia est qui et iste alias.", "es": "Consequatur qui reiciendis. Nobis laboriosam esse. Soluta et dolores sed saepe fuga officiis rerum. Quia sit recusandae quidem sint dolor et."}	{"ca": "<p>Voluptatum quidem repellat in alias ipsum sint fugit. Veritatis quis blanditiis et doloremque. Mollitia fugit voluptas alias.</p>", "en": "<p>Illo laboriosam est voluptatem itaque error. Maxime eos laborum eveniet ipsam iste vel. Dolor ea atque excepturi cupiditate expedita enim officiis. Illo dolorem sint et a aut excepturi. Nisi similique sint et facere.</p>", "es": "<p>Dolor molestiae sed quasi at est facere. Aut placeat dolores saepe sint voluptatem. Nesciunt est mollitia.</p>"}	{"ca": "<p>Harum facere voluptatem enim. Voluptatem dolor voluptas velit mollitia distinctio. Pariatur ad ut sit itaque eum blanditiis deleniti. Quam at dolorem qui.</p>", "en": "<p>Laboriosam voluptates quia. Nulla consequuntur minima deleniti qui reprehenderit vel velit. Ex enim ad aut consequuntur error aliquid.</p>", "es": "<p>Saepe rerum nulla quaerat perferendis corporis exercitationem voluptatem. Omnis quis molestiae sint. Libero eum autem aut facilis est ducimus. Corrupti et pariatur nisi ad porro fugiat.</p>"}	6	\N	2017-09-13 12:47:33.890508	2017-09-13 12:47:33.890508
2	{"ca": "Explicabo voluptatibus eius. Perferendis error rerum consequatur magni. Nobis numquam sed a sed est. Repellat saepe hic ut et. Ut occaecati perspiciatis ducimus.", "en": "Sint et mollitia. Fugiat laborum molestiae amet voluptatibus quo ut. Cumque sunt facere quia nulla provident. Quibusdam omnis asperiores vel voluptas qui. Hic totam numquam odio veniam quo distinctio.", "es": "Itaque ex at sapiente voluptas iste sequi. Consequatur nulla similique a minima. Aut pariatur autem velit. Et facilis quidem voluptas voluptatem sit deleniti et."}	{"ca": "<p>Nesciunt id inventore. Nobis ut laboriosam cumque maxime ea eum. Soluta illum labore voluptatem autem iste saepe. Corporis eligendi distinctio sint ea.</p>", "en": "<p>Non recusandae quam culpa iusto magnam alias ipsum. Vero eos ipsa facere quasi molestiae reprehenderit a. Quisquam maiores sed. Earum ut et laboriosam temporibus id doloribus saepe. Dolor in soluta autem nisi est facere.</p>", "es": "<p>Illum illo est esse fuga sunt delectus. Dolorum voluptate qui perferendis placeat corporis in aut. Adipisci et nihil impedit quos repellendus sint et. Dolorem cupiditate et.</p>"}	{"ca": "<p>Voluptas eum sit deserunt sunt expedita. Quibusdam voluptates est ipsam incidunt dolorum est. Et aliquam placeat debitis molestias. Odit ad qui sint quis laudantium cum ut.</p>", "en": "<p>Id accusantium odio sit et. At eos sed hic.</p>", "es": "<p>Inventore aspernatur officiis quaerat similique. Aut exercitationem voluptatem magni architecto voluptas dolor.</p>"}	12	\N	2017-09-13 12:47:50.729262	2017-09-13 12:47:50.729262
3	{"ca": "Eligendi explicabo aut et molestiae quia quo voluptas. Voluptatem consequatur et et quam eveniet. Sint tempora non.", "en": "Accusamus maxime delectus quis aspernatur eum. Sapiente dolor animi quo asperiores fugit. Ea et et. Voluptatibus praesentium consequatur qui iusto laboriosam. Quisquam consequatur iusto atque exercitationem assumenda non officiis.", "es": "Pariatur reiciendis sapiente minima excepturi illo enim odio. Odit cumque voluptatibus architecto. Corporis optio quasi doloribus repudiandae. In sunt odit."}	{"ca": "<p>Recusandae hic accusamus est illum. Alias et ut reiciendis non laudantium sed praesentium. Adipisci optio ea rerum asperiores. Incidunt beatae voluptatibus sit minima.</p>", "en": "<p>Cum voluptates vero occaecati ratione. Sit enim libero dolor. Exercitationem numquam quis. Voluptas et possimus accusamus ducimus magnam. Nisi sit iste sit consectetur voluptatem sed rerum.</p>", "es": "<p>Corporis quas sed. Et sint dolores itaque at. Id quia et natus. Deleniti assumenda adipisci. Quia repudiandae eum perspiciatis.</p>"}	{"ca": "<p>Omnis et accusantium a quae cum accusamus laborum. Ut voluptatem non neque tenetur officia qui eligendi. Explicabo ut non aut vero quod autem. Quae reprehenderit expedita.</p>", "en": "<p>Nesciunt voluptatem in accusamus et. Nesciunt deleniti ab et.</p>", "es": "<p>Accusantium sit id voluptas eveniet quas maiores voluptatem. Sunt qui consequatur. Facilis quo quod ut.</p>"}	18	\N	2017-09-13 12:48:08.626618	2017-09-13 12:48:08.626618
4	{"ca": "Est numquam autem architecto amet voluptatem nam. Unde porro rerum vero. Ullam facilis qui provident molestiae. Mollitia fugit aut.", "en": "Quia voluptas error. Commodi vel quis quia earum et reprehenderit. Laboriosam consequatur rerum vitae tempora in ea et. Qui unde fugit eaque fuga.", "es": "Sunt odio voluptas. Minus incidunt ex itaque. Exercitationem fuga est atque id libero."}	{"ca": "<p>Tenetur qui deleniti. Quia quo harum temporibus dolor. Ratione similique vero magnam. Qui esse alias ab.</p>", "en": "<p>Quam in quia quaerat. Debitis natus accusantium. Quis consequatur nostrum et fugit qui. Voluptatum expedita voluptas tempore itaque. Vel rem numquam quisquam culpa autem.</p>", "es": "<p>Consequatur quod odio. Recusandae est doloremque explicabo. Voluptates minus tempora molestias impedit et quidem harum. Dolorem voluptas sed minima enim debitis. Libero reiciendis quos ad voluptas enim ipsa velit.</p>"}	{"ca": "<p>Odio unde quis aut ipsum. Aut architecto quia dolores fugiat non.</p>", "en": "<p>Quibusdam autem et et dolores. Amet deserunt ut vel facere culpa et.</p>", "es": "<p>Ab doloribus facere qui dolores. Aperiam quas eum exercitationem nulla.</p>"}	24	\N	2017-09-13 12:48:24.752438	2017-09-13 12:48:24.752438
5	{"ca": "Quae hic molestiae dicta corporis earum et saepe. Vero fuga ad rerum velit sint reiciendis. Nemo ad quis nobis qui. Repellat quos autem.", "en": "Qui eos quisquam beatae dolor voluptatem nemo facere. Unde architecto est et quia rerum. Rem aliquid reiciendis dolorem ea suscipit temporibus.", "es": "Recusandae commodi minima fuga nihil ut dolore. Aut non optio id illo amet. Quibusdam debitis labore corrupti totam enim fuga. Laborum ratione ipsam odit omnis reprehenderit adipisci."}	{"ca": "<p>Ut minima ut ut aliquam necessitatibus sit quidem. Sunt voluptates qui. Quia est dolorem. Eum voluptatem in non suscipit. Voluptas rerum et.</p>", "en": "<p>Aliquid praesentium blanditiis enim dignissimos occaecati. Dignissimos ut eum qui quasi tenetur asperiores. Id et culpa.</p>", "es": "<p>Voluptatem aliquam qui. Similique natus amet et velit aut fugiat minima. Facilis enim aut omnis. Porro voluptatem quam iste nulla fugiat consequatur ut.</p>"}	{"ca": "<p>Fugit quam voluptatem eaque odio et et. Id veniam officiis ut consectetur sapiente qui laborum.</p>", "en": "<p>Vero quaerat neque ut blanditiis rem eos. Cumque ea reprehenderit aliquam eveniet dignissimos harum illum.</p>", "es": "<p>Ipsam omnis dolorem aut corporis. Quod ipsum voluptates delectus quos molestiae.</p>"}	30	\N	2017-09-13 12:48:41.004175	2017-09-13 12:48:41.004175
6	{"ca": "Ipsa sint quibusdam sint. Et consequuntur nisi qui cumque et. Libero consequatur perspiciatis quo dolorum molestiae. Porro esse harum.", "en": "Quo nihil aliquam omnis. Consequatur ab libero impedit autem quidem. Eius dicta est omnis.", "es": "Quas quis fuga ipsa. Facere impedit numquam. Et molestiae quos possimus illo est sit voluptatem. Ut reiciendis omnis dolores quia sed modi."}	{"ca": "<p>Quibusdam deleniti aspernatur dolor ut perspiciatis reiciendis quia. Sed impedit voluptas amet. Et facere quia nihil quod.</p>", "en": "<p>Recusandae ab velit eos sed maiores consequuntur. Doloremque et quia labore accusantium aperiam ipsa. Ratione nisi nihil facilis.</p>", "es": "<p>Exercitationem molestiae pariatur doloribus recusandae nostrum incidunt. Laborum vel ut voluptas. Tempore ut voluptas maxime omnis nostrum quia.</p>"}	{"ca": "<p>Quas ratione atque nobis. Eius qui aliquid totam. Eius non eos voluptas et temporibus alias. Perspiciatis quasi distinctio.</p>", "en": "<p>Voluptatem blanditiis omnis eum libero rerum quam. Dolorem sed aut.</p>", "es": "<p>Harum numquam odit vitae est omnis. Commodi enim repellat nam laudantium.</p>"}	36	\N	2017-09-13 12:48:56.394347	2017-09-13 12:48:56.394347
7	{"fr": ""}	{"fr": ""}	{"fr": ""}	59	\N	2018-01-25 16:00:27.199909	2018-01-25 16:01:54.224183
8	{"fr": "Titre"}	{"fr": "<p>Titre</p>"}	{"fr": "<p>Titre</p>"}	60	\N	2018-01-25 16:39:48.915685	2018-01-25 16:40:36.030811
9	{"fr": "Test"}	{"fr": "<p>Test</p>"}	{"fr": "<p>Test</p>"}	61	\N	2018-02-02 06:58:59.989005	2018-02-02 07:00:05.157289
\.


--
-- Data for Name: decidim_system_admins; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_system_admins (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, failed_attempts, unlock_token, locked_at, created_at, updated_at) FROM stdin;
2	mako@osp.cat	$2a$11$29NCak/dqxLsJ3RA0HCXFuKeXr83B4eQIN0tLdglAGFvhc5AR88Ke	\N	\N	2017-09-28 15:33:49.576212	0	\N	\N	2017-09-13 12:57:37.245815	2017-09-28 15:33:49.577375
\.


--
-- Data for Name: decidim_user_group_memberships; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_user_group_memberships (id, decidim_user_id, decidim_user_group_id, created_at, updated_at) FROM stdin;
1	1	1	2017-09-13 12:47:15.688091	2017-09-13 12:47:15.688091
2	1	2	2017-09-13 12:47:15.724687	2017-09-13 12:47:15.724687
3	2	3	2017-09-13 12:47:15.736195	2017-09-13 12:47:15.736195
4	2	4	2017-09-13 12:47:15.74843	2017-09-13 12:47:15.74843
5	334	5	2017-09-13 17:03:25.134871	2017-09-13 17:03:25.134871
6	382	6	2017-10-11 09:29:46.918175	2017-10-11 09:29:46.918175
7	396	7	2017-11-05 19:48:35.376284	2017-11-05 19:48:35.376284
8	418	8	2017-11-17 16:30:51.654852	2017-11-17 16:30:51.654852
9	437	9	2017-12-22 11:33:48.598955	2017-12-22 11:33:48.598955
10	438	10	2017-12-22 15:33:08.861391	2017-12-22 15:33:08.861391
11	446	11	2018-02-17 12:30:06.798983	2018-02-17 12:30:06.798983
\.


--
-- Data for Name: decidim_user_groups; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_user_groups (id, name, document_number, phone, created_at, updated_at, avatar, rejected_at, decidim_organization_id, verified_at) FROM stdin;
1	Collier and Sons	1606762209	905.704.9852 x73507	2017-09-13 12:47:15.605608	2017-09-13 12:47:15.605608	\N	\N	1	\N
2	McCullough-Erdman	5905784942	344.595.3011 x789	2017-09-13 12:47:15.720953	2017-09-13 12:47:15.720953	\N	\N	1	2017-09-13 12:47:15.546701
3	Mitchell-Doyle	2333888876	312-363-5109 x889	2017-09-13 12:47:15.732803	2017-09-13 12:47:15.732803	\N	\N	1	\N
4	Morissette-Satterfield	7651654906	1-116-653-7813	2017-09-13 12:47:15.742875	2017-09-13 12:47:15.742875	\N	\N	1	2017-09-13 12:47:15.726622
5	OSP	DNI345667	+33779090970	2017-09-13 17:03:25.132283	2017-09-13 17:09:39.82815	\N	\N	2	2017-09-13 17:09:39.824096
6	EDESS - test F.Rougerie	123456789	0699887766	2017-10-11 09:29:46.915885	2017-10-11 09:29:46.915885	\N	\N	3	\N
7	Medef Cote d'Opale	1	03 21 85 51 71	2017-11-05 19:48:35.34641	2017-11-05 19:48:35.34641	\N	\N	2	\N
8	bourbourg formation 	06 12 98 46 14	06 12 98 46  14	2017-11-17 16:30:51.49589	2017-11-17 16:30:51.49589	\N	\N	2	\N
9	Maison commune de la décroissance	N°-1	06 77 89 09 35	2017-12-22 11:33:48.590954	2017-12-22 11:33:48.590954	\N	\N	2	\N
10	Paris Seine Normandie	PSN2017	01 55 65 36 13	2017-12-22 15:33:08.810121	2017-12-22 15:33:08.810121	\N	\N	2	\N
11	Association EDESS	W751106247	0620685941	2018-02-17 12:30:06.79025	2018-02-18 10:44:13.315026	\N	\N	2	2018-02-18 10:44:13.306756
\.


--
-- Data for Name: decidim_users; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY decidim_users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at, invitation_token, invitation_created_at, invitation_sent_at, invitation_accepted_at, invitation_limit, invited_by_type, invited_by_id, invitations_count, decidim_organization_id, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email, name, locale, avatar, newsletter_notifications, delete_reason, deleted_at, admin, managed, roles, email_on_notification, nickname, officialized_at, officialized_as) FROM stdin;
1	admin@example.org	$2a$11$U5PuXYSqaq8DZ3e5mubncuU8.Yx4zcK2O9XvIVvA5qKS7sMyvGye6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:15.303197	2018-02-21 22:16:12.63247	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:15.037338	\N	\N	Samantha Turner	en	\N	f	\N	\N	t	f	{}	f	samantha_turner	\N	\N
2	user@example.org	$2a$11$TLaHqe.T6WBSlbRUBIzJbeOaxCyo8K782bb0ep3TaXm8LXt3LJRlW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:15.541114	2018-02-21 22:16:12.636258	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:15.339504	\N	\N	Nellie Carter	en	\N	f	\N	\N	f	f	{}	f	nellie_carter	\N	\N
3	participatory_process_1_admin@example.org	$2a$11$O7HPUBpWhev0UraI7UFpO.uAnq45iJKpOt60U/KHDPhsmsFZZHMoC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:17.465435	2018-02-21 22:16:12.642656	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:17.263993	\N	\N	Mr. Odessa Russel	en	\N	f	\N	\N	f	f	{}	f	mr_odessa_russel	\N	\N
4	participatory_process_1_collaborator@example.org	$2a$11$3PsOtDOPq3XmFkxUzs6StexEMM1sy3FMD1bi9imERPNhLOKg1eKlu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:17.734364	2018-02-21 22:16:12.645618	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:17.522036	\N	\N	Craig Bogisich	en	\N	f	\N	\N	f	f	{}	f	craig_bogisich	\N	\N
5	participatory_process_1_moderator@example.org	$2a$11$KEo38FWHW6/49.77xC/Yc.6tdzcsfzvFtVEPM9pwp780AewjRA6oW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:17.942962	2018-02-21 22:16:12.647867	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:17.74635	\N	\N	Kacie Koelpin	en	\N	f	\N	\N	f	f	{}	f	kacie_koelpin	\N	\N
6	meeting-registered-user-1-0@example.org	$2a$11$bsY35T6YlRolVxtVV7MC6OYACli9Zq/NIuXDz3V5CQ16hB5hOX4vO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:19.005151	2018-02-21 22:16:12.649915	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:18.800699	\N	\N	Mrs. Amy Stiedemann 1 0	\N	\N	f	\N	\N	f	f	{}	f	mrs_amy_stiedemann_1	\N	\N
7	meeting-registered-user-1-1@example.org	$2a$11$4VuV./YMmZfWB4hiBAo/DO3WXeNSGqymGRRR6r96xoksCsDkpzvBS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:19.259192	2018-02-21 22:16:12.652812	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:19.050571	\N	\N	Freddy Dickinson PhD 1 1	\N	\N	f	\N	\N	f	f	{}	f	freddy_dickinson_phd	\N	\N
8	meeting-registered-user-1-2@example.org	$2a$11$ViFkHma0t16aE27x0rHTz..1vhBFpBi1U0U9GYEnNZZfbUr.MRH.K	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:19.478977	2018-02-21 22:16:12.655137	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:19.271562	\N	\N	Lenore Turcotte 1 2	\N	\N	f	\N	\N	f	f	{}	f	lenore_turcotte_1_2	\N	\N
9	meeting-registered-user-1-3@example.org	$2a$11$1Zwnp96.uW3l9nudSeGDmeussVPCfXR9LxJTktJRMQjM4kowoThKO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:19.695002	2018-02-21 22:16:12.657235	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:19.488833	\N	\N	Miss Julia Lesch 1 3	\N	\N	f	\N	\N	f	f	{}	f	miss_julia_lesch_1_3	\N	\N
10	meeting-registered-user-1-4@example.org	$2a$11$XbasoGgXW78rkyQAaEvqiOfDPZpH1R60Jn2ajrkUbsjUwXAdG7hP.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:19.912255	2018-02-21 22:16:12.6593	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:19.709236	\N	\N	Madge Rodriguez 1 4	\N	\N	f	\N	\N	f	f	{}	f	madge_rodriguez_1_4	\N	\N
11	meeting-registered-user-1-5@example.org	$2a$11$ShEXYmgVWRNe1m8UXQVNoeafQvQdRkv8j41chM4oP76Y0aRjZ1O06	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:20.123007	2018-02-21 22:16:12.661947	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:19.924227	\N	\N	Alaina Leuschke 1 5	\N	\N	f	\N	\N	f	f	{}	f	alaina_leuschke_1_5	\N	\N
12	meeting-registered-user-1-6@example.org	$2a$11$YOavanEcqT9fhbxOt.LUwOyTRj46Tfgjgxw3wnUWRo7.xOCUxalNq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:20.343579	2018-02-21 22:16:12.664434	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:20.133343	\N	\N	Monserrat Carter III 1 6	\N	\N	f	\N	\N	f	f	{}	f	monserrat_carter_iii	\N	\N
13	meeting-registered-user-1-7@example.org	$2a$11$8xhDBxpELOVE3J92OMCDuuMA7mhki6GYlRXRDcIBDBXuMZeNjyMLu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:20.550925	2018-02-21 22:16:12.666681	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:20.353404	\N	\N	Bradford Nicolas DVM 1 7	\N	\N	f	\N	\N	f	f	{}	f	bradford_nicolas_dvm	\N	\N
14	meeting-registered-user-1-8@example.org	$2a$11$TptghpdLw05aqIOt1Ppy3OUuWc4A.C2Pjn6KeIXXeixFz.ihDcoAe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:20.761488	2018-02-21 22:16:12.668811	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:20.560551	\N	\N	Jerrod Sanford 1 8	\N	\N	f	\N	\N	f	f	{}	f	jerrod_sanford_1_8	\N	\N
15	meeting-registered-user-1-9@example.org	$2a$11$TtF9k54CLmK8kpV92gonLuQnimXjcJcUD8Av6lKqyu2MIAto5sDNS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:20.974377	2018-02-21 22:16:12.670989	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:20.771162	\N	\N	Alyce Schaefer 1 9	\N	\N	f	\N	\N	f	f	{}	f	alyce_schaefer_1_9	\N	\N
16	meeting-registered-user-2-0@example.org	$2a$11$ot6hb.jSImzQxPkZ9z1lquo8iRfxZ1ZwuDI8ZOcqdYxXjRr3kkw4K	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:21.397698	2018-02-21 22:16:12.673187	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:21.185656	\N	\N	Kyler Marks 2 0	\N	\N	f	\N	\N	f	f	{}	f	kyler_marks_2_0	\N	\N
17	meeting-registered-user-2-1@example.org	$2a$11$UUK7wxGV4xcmfmoQJIn0Eurt4uTGjC0XwbfveoIjYaa41o6QGYp7m	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:21.603448	2018-02-21 22:16:12.675447	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:21.407398	\N	\N	Mr. Cornelius Bernier 2 1	\N	\N	f	\N	\N	f	f	{}	f	mr_cornelius_bernier	\N	\N
18	meeting-registered-user-2-2@example.org	$2a$11$V1ti5flaDIJqbginGv2xvOKlr42EMy5wSyCZG5Lh0H8VDHyZ/vcLe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:21.811767	2018-02-21 22:16:12.677472	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:21.612791	\N	\N	Emory Effertz 2 2	\N	\N	f	\N	\N	f	f	{}	f	emory_effertz_2_2	\N	\N
19	meeting-registered-user-2-3@example.org	$2a$11$XkSxcBevGUZYsZn9dDVeEuWJBzBmuJ6Rs73ZOWdI.qgJo1VvHqZUm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:22.017774	2018-02-21 22:16:12.680154	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:21.821774	\N	\N	Emil Jacobi 2 3	\N	\N	f	\N	\N	f	f	{}	f	emil_jacobi_2_3	\N	\N
20	meeting-registered-user-2-4@example.org	$2a$11$c78F6/tqQJBEoGFMC/ldtuR8S2Kl/44nk3Rq8cqBANa4.uficAHZa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:22.226772	2018-02-21 22:16:12.682714	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:22.027254	\N	\N	Gus Lockman II 2 4	\N	\N	f	\N	\N	f	f	{}	f	gus_lockman_ii_2_4	\N	\N
21	meeting-registered-user-2-5@example.org	$2a$11$GX772K/1BwupJsFzpohcVuOJcX7OWdp2z84F34WqorPpxDzLq/ubq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:22.438065	2018-02-21 22:16:12.685119	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:22.238862	\N	\N	Laurianne Conroy 2 5	\N	\N	f	\N	\N	f	f	{}	f	laurianne_conroy_2_5	\N	\N
22	meeting-registered-user-2-6@example.org	$2a$11$eUBbuVRXd4Q4E7WRhFLd6urE4EeAbqdxYHolUrc4z/2WnSbbglULO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:22.643486	2018-02-21 22:16:12.687393	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:22.447451	\N	\N	Arvid Simonis 2 6	\N	\N	f	\N	\N	f	f	{}	f	arvid_simonis_2_6	\N	\N
23	meeting-registered-user-2-7@example.org	$2a$11$6PS/3T3xJkmsoQVH0eWiQeI/mWueI258GDGisAHkyGOWetYsOrpoe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:22.849403	2018-02-21 22:16:12.689532	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:22.652871	\N	\N	Furman Koch 2 7	\N	\N	f	\N	\N	f	f	{}	f	furman_koch_2_7	\N	\N
24	meeting-registered-user-2-8@example.org	$2a$11$iYBp2VvAHy0QZwoBUNn17uAbTIyeCcx3T7RUuf6J8mZYt5hFFALsi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:23.054621	2018-02-21 22:16:12.691549	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:22.858841	\N	\N	Rose Leannon 2 8	\N	\N	f	\N	\N	f	f	{}	f	rose_leannon_2_8	\N	\N
25	meeting-registered-user-2-9@example.org	$2a$11$WKbiMbgr6ToWNMsIn6chi.ibhzvIlm6kyCmrq1WM0GaxolPqQnQi6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:23.265083	2018-02-21 22:16:12.69351	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:23.065194	\N	\N	Claudine Purdy 2 9	\N	\N	f	\N	\N	f	f	{}	f	claudine_purdy_2_9	\N	\N
26	meeting-registered-user-3-0@example.org	$2a$11$VYOrqNV61eYw1jEWPt.84etepvVC07L8/ZWq9gQdf3gHd7te6lPza	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:23.649763	2018-02-21 22:16:12.69592	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:23.434857	\N	\N	Charley Collier 3 0	\N	\N	f	\N	\N	f	f	{}	f	charley_collier_3_0	\N	\N
27	meeting-registered-user-3-1@example.org	$2a$11$akEWn8uSpv/Bh6cae7KD0uV6v08l5XfTwC918grCHN2xl0y5BpD7K	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:23.869006	2018-02-21 22:16:12.698294	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:23.665608	\N	\N	Courtney Marquardt 3 1	\N	\N	f	\N	\N	f	f	{}	f	courtney_marquardt_3	\N	\N
28	meeting-registered-user-3-2@example.org	$2a$11$hhMJWXaHLRlrczWowjRCZu39jxRxDKjAdJwFuevVRm/30jITnYnqK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:24.079775	2018-02-21 22:16:12.700532	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:23.878878	\N	\N	Lilla Crona DDS 3 2	\N	\N	f	\N	\N	f	f	{}	f	lilla_crona_dds_3_2	\N	\N
29	meeting-registered-user-3-3@example.org	$2a$11$c2uvocIqjj//uyaglN41cOAGCli41OAiOcwHvA1S9Dleua6RNeEvm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:24.287417	2018-02-21 22:16:12.703085	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:24.089511	\N	\N	Kali Klein IV 3 3	\N	\N	f	\N	\N	f	f	{}	f	kali_klein_iv_3_3	\N	\N
30	meeting-registered-user-3-4@example.org	$2a$11$yeqXY2iYxB6SZi0.TiTaIe7/myovLUvfkf6dgxZjvdXr5BXBLHF06	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:24.494964	2018-02-21 22:16:12.705294	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:24.297139	\N	\N	Modesto Swift V 3 4	\N	\N	f	\N	\N	f	f	{}	f	modesto_swift_v_3_4	\N	\N
31	meeting-registered-user-3-5@example.org	$2a$11$P0ZrKcrq.wQTIu0YDYJK7ePD/pohDaWvPQ75pXtvti.WAFmJ6Ewke	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:24.703813	2018-02-21 22:16:12.710623	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:24.504369	\N	\N	Evelyn Feeney 3 5	\N	\N	f	\N	\N	f	f	{}	f	evelyn_feeney_3_5	\N	\N
32	meeting-registered-user-3-6@example.org	$2a$11$cgt/iJeAuw7d80KlplpzQOIQhcsSokJzVA.D88v3NPTGKv24DLww.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:24.917079	2018-02-21 22:16:12.713782	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:24.71619	\N	\N	Juwan Rodriguez 3 6	\N	\N	f	\N	\N	f	f	{}	f	juwan_rodriguez_3_6	\N	\N
33	meeting-registered-user-3-7@example.org	$2a$11$YsOkvEqLzrLLnf7JR/ATpO5.pRir13cXy8TDbm9LMJkQAycs6Ux4O	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:25.125068	2018-02-21 22:16:12.71626	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:24.926577	\N	\N	Dorothea D'Amore IV 3 7	\N	\N	f	\N	\N	f	f	{}	f	dorothea_d_amore_iv_	\N	\N
34	meeting-registered-user-3-8@example.org	$2a$11$ID/c/H2Z3SNLkSaxvSWqte0y.pcDZ9x9NSz9DBM3bEG3X2mIzclhi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:25.344926	2018-02-21 22:16:12.718441	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:25.136302	\N	\N	Kristopher Beahan 3 8	\N	\N	f	\N	\N	f	f	{}	f	kristopher_beahan_3_	\N	\N
35	meeting-registered-user-3-9@example.org	$2a$11$ViYJt56wSSfjx81qypn3.u40bsbU./74hvriPityH7rz6N7g5qQPS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:25.557537	2018-02-21 22:16:12.720741	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:25.356634	\N	\N	Toy Glover 3 9	\N	\N	f	\N	\N	f	f	{}	f	toy_glover_3_9	\N	\N
36	vote-author-participatory_process-1-0-0@example.org	$2a$11$GwYN59jnwlhvGjJS32Dl2.KsX4ucj5tQOIzf4OiAo2PItBA2vZyD.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:26.038663	2018-02-21 22:16:12.723051	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:25.833305	\N	\N	Julien Mante I 1 0 0	\N	\N	f	\N	\N	f	f	{}	f	julien_mante_i_1_0_0	\N	\N
37	vote-author-participatory_process-1-1-0@example.org	$2a$11$0VResZxlBtB38j1TxZdAS.PtUmw/KeT/4E92orvWRm4KiUU5TRA8O	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:26.390119	2018-02-21 22:16:12.725082	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:26.176024	\N	\N	Ashtyn Torp 1 1 0	\N	\N	f	\N	\N	f	f	{}	f	ashtyn_torp_1_1_0	\N	\N
38	vote-author-participatory_process-1-1-1@example.org	$2a$11$xU.yRzcXnWCcVmr2E8j3O.fiI8BThHwblu5rvde7g9QZzJU5W1hPy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:26.610862	2018-02-21 22:16:12.727219	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:26.412665	\N	\N	Salvador Lind 1 1 1	\N	\N	f	\N	\N	f	f	{}	f	salvador_lind_1_1_1	\N	\N
39	vote-author-participatory_process-1-2-0@example.org	$2a$11$u9yERTK9l8PVp4cVR1LChOAcxVkqnDkIH6GDbHIQZnxWm4RiG8Eha	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:26.886221	2018-02-21 22:16:12.729526	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:26.688313	\N	\N	Rylan Dickens 1 2 0	\N	\N	f	\N	\N	f	f	{}	f	rylan_dickens_1_2_0	\N	\N
40	vote-author-participatory_process-1-2-1@example.org	$2a$11$FJ2ycq.h15IYgKDjR8IBIeEh/iwD27N9R5QmNLET3DOesm9wUjSPW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:27.09502	2018-02-21 22:16:12.731691	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:26.898097	\N	\N	Miss Hank Kessler 1 2 1	\N	\N	f	\N	\N	f	f	{}	f	miss_hank_kessler_1_	\N	\N
41	vote-author-participatory_process-1-3-0@example.org	$2a$11$4elzWlGxyl1mYLnShcX9oeKqWMGKD5/Fle/pZBqMz3vb04D04.Biu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:27.426744	2018-02-21 22:16:12.73383	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:27.19551	\N	\N	Daron Casper 1 3 0	\N	\N	f	\N	\N	f	f	{}	f	daron_casper_1_3_0	\N	\N
42	vote-author-participatory_process-1-3-1@example.org	$2a$11$0qipvHZHjIvQKKcRWcSuv.ZcT4A98.DS4BHNqP4TjOaRsn5ovNScy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:27.661259	2018-02-21 22:16:12.736071	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:27.442039	\N	\N	Ms. Stefan Effertz 1 3 1	\N	\N	f	\N	\N	f	f	{}	f	ms_stefan_effertz_1_	\N	\N
43	vote-author-participatory_process-1-4-0@example.org	$2a$11$20Ayx7s10b6gBFgD9PV2u.TPa0uTwPPofe8/UiCNsx/941azLlzCu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:27.990502	2018-02-21 22:16:12.740724	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:27.763533	\N	\N	Mathias O'Reilly 1 4 0	\N	\N	f	\N	\N	f	f	{}	f	mathias_o_reilly_1_4	\N	\N
44	vote-author-participatory_process-1-5-0@example.org	$2a$11$Lmryg3FQ6DsX9rX0GSYSKO0aGq2J/C9NMbYNp3L/kt6zVtqfhAk8W	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:28.359082	2018-02-21 22:16:12.743536	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:28.130641	\N	\N	Arlene Kuhlman 1 5 0	\N	\N	f	\N	\N	f	f	{}	f	arlene_kuhlman_1_5_0	\N	\N
45	vote-author-participatory_process-1-6-0@example.org	$2a$11$hz2o3U/y0MUgWAfFb6V4..kQz1UxN1s78VlM5vpm.nvToF1SYOzlC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:28.721726	2018-02-21 22:16:12.746491	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:28.488674	\N	\N	Deven Robel 1 6 0	\N	\N	f	\N	\N	f	f	{}	f	deven_robel_1_6_0	\N	\N
46	vote-author-participatory_process-1-6-1@example.org	$2a$11$TK6hYFPJNCMe7XB6q46uV.J5rRGXJquMmebyoNfOM.e8XVGv3egm2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:28.974256	2018-02-21 22:16:12.749036	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:28.745365	\N	\N	Alexanne Daugherty 1 6 1	\N	\N	f	\N	\N	f	f	{}	f	alexanne_daugherty_1	\N	\N
47	vote-author-participatory_process-1-7-0@example.org	$2a$11$ACJzGlg5DX5qeNOpUnJuQOo4iF0aw1Crx0zIoT4vgJ7YNZe81rfNi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:29.304688	2018-02-21 22:16:12.751377	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:29.099111	\N	\N	Enrico Baumbach 1 7 0	\N	\N	f	\N	\N	f	f	{}	f	enrico_baumbach_1_7_	\N	\N
48	vote-author-participatory_process-1-8-0@example.org	$2a$11$HolpIqVK9mcik8khxXCuP.YxsYkHyudIyBIp4DLDwRxSP/bPTbseK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:29.635313	2018-02-21 22:16:12.753584	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:29.436	\N	\N	Leo Krajcik 1 8 0	\N	\N	f	\N	\N	f	f	{}	f	leo_krajcik_1_8_0	\N	\N
49	vote-author-participatory_process-1-8-1@example.org	$2a$11$S9nSAGqok3xKweNOZ1t9xevmempPun4h8OfwDaKR8NVmYKaZFng6y	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:29.857588	2018-02-21 22:16:12.755747	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:29.647189	\N	\N	Zelda Baumbach 1 8 1	\N	\N	f	\N	\N	f	f	{}	f	zelda_baumbach_1_8_1	\N	\N
50	vote-author-participatory_process-1-9-0@example.org	$2a$11$vNjyeBLbtJCiy5MwUXVHeOJQMbzb3KTdothiFsNTZJz1Szl./DZ5.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:30.200064	2018-02-21 22:16:12.757816	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:29.985818	\N	\N	Kendall Towne 1 9 0	\N	\N	f	\N	\N	f	f	{}	f	kendall_towne_1_9_0	\N	\N
51	vote-author-participatory_process-1-10-0@example.org	$2a$11$8koXyHHaaSfaynEWv52dau.b4iih0j5FEl.ueOGkYhbBJBT6tXKOG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:30.470143	2018-02-21 22:16:12.759992	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:30.274095	\N	\N	Lourdes Bruen 1 10 0	\N	\N	f	\N	\N	f	f	{}	f	lourdes_bruen_1_10_0	\N	\N
52	vote-author-participatory_process-1-13-0@example.org	$2a$11$X0UuQeYlOJ6tlQ.PRCWNS.Ixc9qxcNX7aqOVCgnfdRY7tObsmDqca	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:30.86458	2018-02-21 22:16:12.762335	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:30.66776	\N	\N	Bart Pollich 1 13 0	\N	\N	f	\N	\N	f	f	{}	f	bart_pollich_1_13_0	\N	\N
53	vote-author-participatory_process-1-14-0@example.org	$2a$11$OiqgCj8DcK3cM7SpFsSCs.SqSWgU7A6RRRXdTKLny3cTjS4k7Vho2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:31.197919	2018-02-21 22:16:12.764488	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:30.992326	\N	\N	Marge Lemke 1 14 0	\N	\N	f	\N	\N	f	f	{}	f	marge_lemke_1_14_0	\N	\N
54	vote-author-participatory_process-1-14-1@example.org	$2a$11$ssWIepk6T6sZPGO4HjEu8eboLjKe9FqUi8UXIT0FJtJblfKhH13I.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:31.421801	2018-02-21 22:16:12.766722	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:31.221826	\N	\N	Madisyn Ebert 1 14 1	\N	\N	f	\N	\N	f	f	{}	f	madisyn_ebert_1_14_1	\N	\N
55	vote-author-participatory_process-1-15-0@example.org	$2a$11$pImNhGTdmotPuwTj4kYm1.ZTtnVtMlc46x4TW/I8h96z7r4utvrtS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:31.745997	2018-02-21 22:16:12.76893	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:31.547368	\N	\N	Hosea Collins 1 15 0	\N	\N	f	\N	\N	f	f	{}	f	hosea_collins_1_15_0	\N	\N
56	vote-author-participatory_process-1-15-1@example.org	$2a$11$Fe5XhSNAVvkJeIrKTnpm1OTu7Sw4caO4ZU1rHj2OLT7BwSMBrltQ2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:31.956399	2018-02-21 22:16:12.770977	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:31.757911	\N	\N	Bryana Fadel I 1 15 1	\N	\N	f	\N	\N	f	f	{}	f	bryana_fadel_i_1_15_	\N	\N
57	vote-author-participatory_process-1-18-0@example.org	$2a$11$segUsdFcC3Rx60pz9Dmazua.pt.cafONXOCfQrkcveLtqznD3b5yi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:32.367313	2018-02-21 22:16:12.773671	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:32.150832	\N	\N	Corbin Prohaska 1 18 0	\N	\N	f	\N	\N	f	f	{}	f	corbin_prohaska_1_18	\N	\N
58	vote-author-participatory_process-1-19-0@example.org	$2a$11$C4z0zGdRG7I9OM3w/BHYUuQ8Qq1qbYe7mRb4JLEwjjOqyDfmhJGR6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:32.680169	2018-02-21 22:16:12.776264	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:32.470862	\N	\N	Garret Gorczany DVM 1 19 0	\N	\N	f	\N	\N	f	f	{}	f	garret_gorczany_dvm_	\N	\N
59	participatory_process_2_admin@example.org	$2a$11$wEVfQSX/G4.l4WgLUoAvP.SRAMP.pW68J.whl07p/.AC8zcQ6csEm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:34.261221	2018-02-21 22:16:12.778543	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:34.008307	\N	\N	Angeline Okuneva DVM	en	\N	f	\N	\N	f	f	{}	f	angeline_okuneva_dvm	\N	\N
60	participatory_process_2_collaborator@example.org	$2a$11$EUHN9y.ikEebzxE7yArRw.rRx1BHLxFuqjeboYysJlKSxuc84E/CC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:34.512568	2018-02-21 22:16:12.781194	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:34.280549	\N	\N	Ms. Gwen Pfeffer	en	\N	f	\N	\N	f	f	{}	f	ms_gwen_pfeffer	\N	\N
61	participatory_process_2_moderator@example.org	$2a$11$AS6ZOvdRR6.Pr0VJf8MmOeSOkFKr0WT.unh/U1F7Jl6kgiQrZr7xu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:34.741345	2018-02-21 22:16:12.783605	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:34.531273	\N	\N	Louvenia McDermott MD	en	\N	f	\N	\N	f	f	{}	f	louvenia_mcdermott_m	\N	\N
62	meeting-registered-user-4-0@example.org	$2a$11$aY5m8VoVXQxt3mg4yfzSiOsI1ryjhJ0kZsNQXx2p8QNGGyivD00Te	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:35.182916	2018-02-21 22:16:12.786571	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:34.972492	\N	\N	Burnice Ledner DVM 4 0	\N	\N	f	\N	\N	f	f	{}	f	burnice_ledner_dvm_4	\N	\N
63	meeting-registered-user-4-1@example.org	$2a$11$H2Ybq83R0vWCifcRYnlL1.59h2ItZeJ1Esth9hxoJX5F27Xfq2qXS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:35.390889	2018-02-21 22:16:12.789243	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:35.193391	\N	\N	Ransom Pacocha 4 1	\N	\N	f	\N	\N	f	f	{}	f	ransom_pacocha_4_1	\N	\N
64	meeting-registered-user-4-2@example.org	$2a$11$FGZO/sntd4nDsj3sBtvasuSgBRGHLc/QZjajLE6QsX06AhxFkygIi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:35.604095	2018-02-21 22:16:12.791585	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:35.40068	\N	\N	Vada Balistreri 4 2	\N	\N	f	\N	\N	f	f	{}	f	vada_balistreri_4_2	\N	\N
65	meeting-registered-user-4-3@example.org	$2a$11$iKhpgakWOYx511P0Tr.bTuhnn1sEq8X2JK04XtNsL53ZdOpMcpe7q	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:35.823842	2018-02-21 22:16:12.794128	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:35.620444	\N	\N	Santino Morar 4 3	\N	\N	f	\N	\N	f	f	{}	f	santino_morar_4_3	\N	\N
66	meeting-registered-user-4-4@example.org	$2a$11$DGUVpjXqZPpTxUHfenyhl.cmkb19WSodBs.YPoGs8tHx2hd5WqyN2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:36.044695	2018-02-21 22:16:12.796805	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:35.837277	\N	\N	Lucy Stamm 4 4	\N	\N	f	\N	\N	f	f	{}	f	lucy_stamm_4_4	\N	\N
67	meeting-registered-user-4-5@example.org	$2a$11$ICD8alLkiGYzPy35ulVAwOAoH11p6Kas4bHltZYidZwvIZShrNWPO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:36.258645	2018-02-21 22:16:12.798941	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:36.054395	\N	\N	Tomasa Mills 4 5	\N	\N	f	\N	\N	f	f	{}	f	tomasa_mills_4_5	\N	\N
68	meeting-registered-user-4-6@example.org	$2a$11$JJ5u5snizMQNkfqptYRsuehVi0F9SBFtYSFlZr8aUNOuYARdKRWWO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:36.470554	2018-02-21 22:16:12.80109	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:36.268556	\N	\N	Jamir Altenwerth IV 4 6	\N	\N	f	\N	\N	f	f	{}	f	jamir_altenwerth_iv_	\N	\N
69	meeting-registered-user-4-7@example.org	$2a$11$NAtz/7/GV9F.l8uDrWv1OO0cccFoHNZ1islvPz9X/RmQvysSMj3I.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:36.68126	2018-02-21 22:16:12.80354	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:36.482349	\N	\N	Jovan Marquardt 4 7	\N	\N	f	\N	\N	f	f	{}	f	jovan_marquardt_4_7	\N	\N
70	meeting-registered-user-4-8@example.org	$2a$11$JdiW3H68mK6bm.s0oiMhWejlzm6JcR6R541X0cuGwB5iu3992WDZ6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:36.895042	2018-02-21 22:16:12.806075	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:36.690863	\N	\N	Miss Demarcus Hauck 4 8	\N	\N	f	\N	\N	f	f	{}	f	miss_demarcus_hauck_	\N	\N
71	meeting-registered-user-4-9@example.org	$2a$11$bU5XXwzhUoriX2DZC3uwJOCNy98LUg7AlJOgit5YCS7Np7BXoHeEW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:37.17165	2018-02-21 22:16:12.808164	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:36.956235	\N	\N	Lisandro Langworth IV 4 9	\N	\N	f	\N	\N	f	f	{}	f	lisandro_langworth_i	\N	\N
72	meeting-registered-user-5-0@example.org	$2a$11$YtHE3fVZT3Vb8LR1UjNXbec5.WIBaqCRvfwAqie1U//UyNyDz8FP6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:37.570464	2018-02-21 22:16:12.810213	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:37.352812	\N	\N	Ms. Tressie Hickle 5 0	\N	\N	f	\N	\N	f	f	{}	f	ms_tressie_hickle_5_	\N	\N
73	meeting-registered-user-5-1@example.org	$2a$11$HJaJ3jObicnRAmNzYVNJBeX6gQj4TsRyr/7G/pBegval7RBzZqgb6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:37.801087	2018-02-21 22:16:12.812671	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:37.583007	\N	\N	Mrs. Martin Kling 5 1	\N	\N	f	\N	\N	f	f	{}	f	mrs_martin_kling_5_1	\N	\N
74	meeting-registered-user-5-2@example.org	$2a$11$ILnoZD/sN8caw3lOAqr1S.ZsDfVg8z7cToEHzQGavM7Wgn5hOkiri	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:38.025034	2018-02-21 22:16:12.81513	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:37.811598	\N	\N	Libby Mosciski 5 2	\N	\N	f	\N	\N	f	f	{}	f	libby_mosciski_5_2	\N	\N
75	meeting-registered-user-5-3@example.org	$2a$11$4I50a9xM4Mxzy.qFxAs9Au40quKz7YnovMfJTT80TUoByRilAS0jC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:38.242302	2018-02-21 22:16:12.817498	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:38.034948	\N	\N	Ms. Maximus Funk 5 3	\N	\N	f	\N	\N	f	f	{}	f	ms_maximus_funk_5_3	\N	\N
76	meeting-registered-user-5-4@example.org	$2a$11$Loro77/lb0asLImHxSZHtOLbP/5OtbM2H8u1beCctGw9j0Ji8VBI6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:38.45203	2018-02-21 22:16:12.819798	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:38.251964	\N	\N	Eleazar Kerluke 5 4	\N	\N	f	\N	\N	f	f	{}	f	eleazar_kerluke_5_4	\N	\N
77	meeting-registered-user-5-5@example.org	$2a$11$s0ByoElGvRJbK1a.dLNBaOmSpFUXqjsA7Hedn1b2LAoT8Hr8F5Zoq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:38.664102	2018-02-21 22:16:12.821955	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:38.462404	\N	\N	Corrine Boyle 5 5	\N	\N	f	\N	\N	f	f	{}	f	corrine_boyle_5_5	\N	\N
78	meeting-registered-user-5-6@example.org	$2a$11$lS2Is85nnSvNTkJNIPK/senUPU4KM2SzaivhXNlphfAW4ZYEnkeMO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:38.899576	2018-02-21 22:16:12.824002	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:38.675652	\N	\N	Prudence Sawayn 5 6	\N	\N	f	\N	\N	f	f	{}	f	prudence_sawayn_5_6	\N	\N
79	meeting-registered-user-5-7@example.org	$2a$11$7gJ/moPuKSpcRzEiRLKMfuZM4tB1UeOsMFRIoHtAr6MNQAts5.Qp.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:39.140914	2018-02-21 22:16:12.826061	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:38.912516	\N	\N	Susana Goldner 5 7	\N	\N	f	\N	\N	f	f	{}	f	susana_goldner_5_7	\N	\N
80	meeting-registered-user-5-8@example.org	$2a$11$jhCyv0QJLJOHBry40OgvkuNZGrbaoHmnT/XNbLgauunQdNXozjuZm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:39.365007	2018-02-21 22:16:12.828455	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:39.1506	\N	\N	Freeman Gaylord 5 8	\N	\N	f	\N	\N	f	f	{}	f	freeman_gaylord_5_8	\N	\N
81	meeting-registered-user-5-9@example.org	$2a$11$chHY9xm6PpR/e99ew3lZruPzOrYbBsR5SdrgtjPIf8gQZo2fbHRRy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:39.574017	2018-02-21 22:16:12.831133	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:39.37473	\N	\N	Sunny Lueilwitz 5 9	\N	\N	f	\N	\N	f	f	{}	f	sunny_lueilwitz_5_9	\N	\N
82	meeting-registered-user-6-0@example.org	$2a$11$0viey1rqCXL6K3ZPhUKNYOg5bvUA18PLn4QiF1LoyntrOZau6nqcm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:39.9659	2018-02-21 22:16:12.833643	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:39.763658	\N	\N	Bria Mueller PhD 6 0	\N	\N	f	\N	\N	f	f	{}	f	bria_mueller_phd_6_0	\N	\N
83	meeting-registered-user-6-1@example.org	$2a$11$KQMMdgpTcyim.oNrwqQTh.SmwxZeqBAVH/EArq7t38H0mky4G38n.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:40.191155	2018-02-21 22:16:12.835924	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:39.975731	\N	\N	Laurine Feeney IV 6 1	\N	\N	f	\N	\N	f	f	{}	f	laurine_feeney_iv_6_	\N	\N
84	meeting-registered-user-6-2@example.org	$2a$11$WAeYJ/Uc3Bw8.uVF2b8WmeLgA8Tce6T7PhOFm8snbK0lsCFJHDbW2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:40.412679	2018-02-21 22:16:12.838079	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:40.20568	\N	\N	Damian Nikolaus 6 2	\N	\N	f	\N	\N	f	f	{}	f	damian_nikolaus_6_2	\N	\N
85	meeting-registered-user-6-3@example.org	$2a$11$9TcKBo8iL6kegR1VCwzfnecPDyKn4wGErdPHuV3wGEWsQSv2d2rDe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:40.625457	2018-02-21 22:16:12.840431	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:40.423767	\N	\N	Rhoda Braun IV 6 3	\N	\N	f	\N	\N	f	f	{}	f	rhoda_braun_iv_6_3	\N	\N
86	meeting-registered-user-6-4@example.org	$2a$11$ePdHcsTdoH5r6Jwwr7SVBe2zekjOYYtGJK9NIexV9slgwQw5LXn0q	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:40.844268	2018-02-21 22:16:12.84276	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:40.64063	\N	\N	Russ Mante DVM 6 4	\N	\N	f	\N	\N	f	f	{}	f	russ_mante_dvm_6_4	\N	\N
87	meeting-registered-user-6-5@example.org	$2a$11$0L1IgvysCFwlUKSGFeXA9efB5vNCiAK3WI4GB6R3HZQ7EAzBEu1Zy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:41.091878	2018-02-21 22:16:12.844826	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:40.856399	\N	\N	Jimmie Gleichner PhD 6 5	\N	\N	f	\N	\N	f	f	{}	f	jimmie_gleichner_phd	\N	\N
88	meeting-registered-user-6-6@example.org	$2a$11$hPOfBya/qJozDC84OpJnS.QK8aHBTYi1YyNlFeAAHZ1RICp1NbZnC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:41.339331	2018-02-21 22:16:12.84751	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:41.104987	\N	\N	Margarett Champlin 6 6	\N	\N	f	\N	\N	f	f	{}	f	margarett_champlin_6	\N	\N
89	meeting-registered-user-6-7@example.org	$2a$11$Xl2PttnSa4oOZsFGxyaRQOhWMBNSjYUSrdbrQ1FD.EB1H/IzY2P0S	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:41.584591	2018-02-21 22:16:12.849749	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:41.355126	\N	\N	Bert Turcotte Sr. 6 7	\N	\N	f	\N	\N	f	f	{}	f	bert_turcotte_sr_6_7	\N	\N
90	meeting-registered-user-6-8@example.org	$2a$11$R04hBBlyB7iXsR/2bzjviuuA3wc/v6vsI8UDebsyPNnC6DNXO/yMq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:41.796299	2018-02-21 22:16:12.851855	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:41.594168	\N	\N	Blanca Kilback 6 8	\N	\N	f	\N	\N	f	f	{}	f	blanca_kilback_6_8	\N	\N
91	meeting-registered-user-6-9@example.org	$2a$11$FxOhj.OeHtzYffaypG3Pz.tOKhZSAQ4W7Bq.OodfMGssVOtnu0Juu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:42.008785	2018-02-21 22:16:12.853904	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:41.806619	\N	\N	Immanuel Robel 6 9	\N	\N	f	\N	\N	f	f	{}	f	immanuel_robel_6_9	\N	\N
92	vote-author-participatory_process-2-2-0@example.org	$2a$11$/lSGukHIWiWM4Pw0.kvmzuswADahn/EWDZMD0I6xfwrRD5BEipfim	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:42.650113	2018-02-21 22:16:12.855954	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:42.451315	\N	\N	Dr. Myrtis Kuhn 2 2 0	\N	\N	f	\N	\N	f	f	{}	f	dr_myrtis_kuhn_2_2_0	\N	\N
93	vote-author-participatory_process-2-2-1@example.org	$2a$11$W7fy5T7NOeWyHx83aR8RJOEZ/L9dC17Xt3lCKjEd.1BIhTL5JTZAe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:42.865007	2018-02-21 22:16:12.858114	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:42.661662	\N	\N	Declan Schamberger 2 2 1	\N	\N	f	\N	\N	f	f	{}	f	declan_schamberger_2	\N	\N
94	vote-author-participatory_process-2-3-0@example.org	$2a$11$1xVGPyUXAXiHybjBR.TZ7egWm4UcKzel0yxAOHqADk4NjeHgzlsm6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:43.164356	2018-02-21 22:16:12.860206	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:42.960317	\N	\N	Esperanza O'Reilly DVM 2 3 0	\N	\N	f	\N	\N	f	f	{}	f	esperanza_o_reilly_d	\N	\N
95	vote-author-participatory_process-2-3-1@example.org	$2a$11$j70259kM0xEWiSbWfwj.VO1SLx1.RuKN46N2AazsmskBjOU7I92nu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:43.391214	2018-02-21 22:16:12.862689	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:43.178033	\N	\N	Rollin Moen I 2 3 1	\N	\N	f	\N	\N	f	f	{}	f	rollin_moen_i_2_3_1	\N	\N
96	vote-author-participatory_process-2-4-0@example.org	$2a$11$1Gw9Z/yYFQtv/datiSnC9eFDNgyFECa4kygLQ2MQRIc.MgcHp/Ipe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:43.692381	2018-02-21 22:16:12.86503	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:43.482155	\N	\N	Reyes King V 2 4 0	\N	\N	f	\N	\N	f	f	{}	f	reyes_king_v_2_4_0	\N	\N
97	vote-author-participatory_process-2-4-1@example.org	$2a$11$xy75WGbuGMyw1F/GeOTTluzOtoaS0ktHE0sMlNcXaN3tLmUkxyWZW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:43.91524	2018-02-21 22:16:12.86725	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:43.706155	\N	\N	Dr. Jensen Emmerich 2 4 1	\N	\N	f	\N	\N	f	f	{}	f	dr_jensen_emmerich_2	\N	\N
98	vote-author-participatory_process-2-5-0@example.org	$2a$11$CMsV.xezbIzp2oLgObZ.w.gHAGQA1g2E8Tv4rX2B4L7Megq1bRG.u	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:44.190364	2018-02-21 22:16:12.869467	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:43.986789	\N	\N	Ms. Hillard McCullough 2 5 0	\N	\N	f	\N	\N	f	f	{}	f	ms_hillard_mcculloug	\N	\N
99	vote-author-participatory_process-2-5-1@example.org	$2a$11$01NP1Ip5bJB7xzR8AgaEYeFmRi/qnPLLgWmp2tPDsq73iRXa5ozMq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:44.407916	2018-02-21 22:16:12.871711	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:44.202024	\N	\N	Anthony Rolfson 2 5 1	\N	\N	f	\N	\N	f	f	{}	f	anthony_rolfson_2_5_	\N	\N
100	vote-author-participatory_process-2-6-0@example.org	$2a$11$xp/m12b99IZHehSsnpvNVuQgusvT0X4nPhkHx7NQGTWHyGmlXjQaC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:44.716293	2018-02-21 22:16:12.873884	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:44.515383	\N	\N	Ms. Nigel Crona 2 6 0	\N	\N	f	\N	\N	f	f	{}	f	ms_nigel_crona_2_6_0	\N	\N
101	vote-author-participatory_process-2-6-1@example.org	$2a$11$YfthW5SiM1LlKbXEj0MRO.i9e1FXl/HMDaIOEqeQEAZjPJtrrEz6W	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:44.930853	2018-02-21 22:16:12.876039	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:44.728431	\N	\N	Jean Wiegand 2 6 1	\N	\N	f	\N	\N	f	f	{}	f	jean_wiegand_2_6_1	\N	\N
102	vote-author-participatory_process-2-7-0@example.org	$2a$11$PPqJe7RPcBfaliw8/lLvyu.qo0GRKI8pcYEkVIkfTbD8D8pA6RlQe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:45.292834	2018-02-21 22:16:12.878238	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:45.076429	\N	\N	Mrs. Edgar Smith 2 7 0	\N	\N	f	\N	\N	f	f	{}	f	mrs_edgar_smith_2_7_	\N	\N
103	vote-author-participatory_process-2-9-0@example.org	$2a$11$.pFVHvqqBdrrgBLkE1Y1G.R1bKVscDZrAbgV2E8uJyt77TlAJi58K	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:45.707774	2018-02-21 22:16:12.880719	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:45.499878	\N	\N	Marilie Kovacek 2 9 0	\N	\N	f	\N	\N	f	f	{}	f	marilie_kovacek_2_9_	\N	\N
104	vote-author-participatory_process-2-9-1@example.org	$2a$11$OEKThS6Xoz0jutARNkvq2e3EtC/yUDEQ6N3JuxGDnZyH8lz3Iy.dm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:45.920149	2018-02-21 22:16:12.882859	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:45.719258	\N	\N	Dylan Bosco 2 9 1	\N	\N	f	\N	\N	f	f	{}	f	dylan_bosco_2_9_1	\N	\N
105	vote-author-participatory_process-2-10-0@example.org	$2a$11$RX/3YgsLGdo97aXW9DGhaOj/kVp63eKjo4uT1IvDGIPNXD2Ni5.pm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:46.179006	2018-02-21 22:16:12.884999	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:45.976615	\N	\N	Leone Lebsack 2 10 0	\N	\N	f	\N	\N	f	f	{}	f	leone_lebsack_2_10_0	\N	\N
106	vote-author-participatory_process-2-12-0@example.org	$2a$11$5hLXJlwgQLl8iaNUwhW7SOQ4vqXJb.c/NjEYbuVEqawxnWT9woP7.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:46.706523	2018-02-21 22:16:12.887203	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:46.460092	\N	\N	Brigitte O'Connell 2 12 0	\N	\N	f	\N	\N	f	f	{}	f	brigitte_o_connell_2	\N	\N
107	vote-author-participatory_process-2-12-1@example.org	$2a$11$D17oWIpmsVILtgmkgaHH5eD7AFaXuHJJexkIxPGfM.YP82W7MKNv.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:46.944086	2018-02-21 22:16:12.889293	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:46.718001	\N	\N	Coy McKenzie 2 12 1	\N	\N	f	\N	\N	f	f	{}	f	coy_mckenzie_2_12_1	\N	\N
108	vote-author-participatory_process-2-13-0@example.org	$2a$11$EcZZ/wmmiGxMQxpd7i2Rb.LPsraPKP315x/Sr.SLru4tiHuh5IvN6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:47.297056	2018-02-21 22:16:12.891343	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:47.08394	\N	\N	Dr. Kane Collins 2 13 0	\N	\N	f	\N	\N	f	f	{}	f	dr_kane_collins_2_13	\N	\N
109	vote-author-participatory_process-2-13-1@example.org	$2a$11$Zajw86ctRJtXyXLZdfSK4.baJF0OLQUP/yw3/PP/cB13M9FY9rV8a	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:47.521641	2018-02-21 22:16:12.893638	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:47.312729	\N	\N	Chet Bernier 2 13 1	\N	\N	f	\N	\N	f	f	{}	f	chet_bernier_2_13_1	\N	\N
110	vote-author-participatory_process-2-14-0@example.org	$2a$11$yupcSoMNPt0ajIENBEjYJeXnd4zdEdNTJfYphr272yOm.UmMKjiWi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:47.821197	2018-02-21 22:16:12.896789	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:47.621605	\N	\N	Christop Ward 2 14 0	\N	\N	f	\N	\N	f	f	{}	f	christop_ward_2_14_0	\N	\N
111	vote-author-participatory_process-2-15-0@example.org	$2a$11$MCgxp8oNJOZr5.kSRPJLkuCTp3m4VpsfkDjjHAtqLvpgiPd1IaTxG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:48.132965	2018-02-21 22:16:12.899234	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:47.932968	\N	\N	Dr. Kelsi Durgan 2 15 0	\N	\N	f	\N	\N	f	f	{}	f	dr_kelsi_durgan_2_15	\N	\N
112	vote-author-participatory_process-2-15-1@example.org	$2a$11$wqR6IguFMUZ9ebb8gHnSQewP2SxMVY0oJ7yHjj.D1/6722TUBy.s2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:48.35797	2018-02-21 22:16:12.901581	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:48.145359	\N	\N	Geraldine Volkman 2 15 1	\N	\N	f	\N	\N	f	f	{}	f	geraldine_volkman_2_	\N	\N
113	vote-author-participatory_process-2-16-0@example.org	$2a$11$kFgGAXhuCK9autQCx2fp7uGT0I71IwNqaYX4Q4VgMM96SRQ/XEgHW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:48.65053	2018-02-21 22:16:12.90375	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:48.429789	\N	\N	Juvenal Wehner 2 16 0	\N	\N	f	\N	\N	f	f	{}	f	juvenal_wehner_2_16_	\N	\N
114	vote-author-participatory_process-2-17-0@example.org	$2a$11$X5VZy.2Gj9u4Ib/XstmxEuK6mdZTZ3pMO13thyJVMP1jbfO.GBIIy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:48.977644	2018-02-21 22:16:12.905892	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:48.762078	\N	\N	Shanel Harvey 2 17 0	\N	\N	f	\N	\N	f	f	{}	f	shanel_harvey_2_17_0	\N	\N
115	vote-author-participatory_process-2-18-0@example.org	$2a$11$w2747lMLoMEuSk2coF.dLez74bPo2BeZIhxIjVOwB4I3ZzlGUaddq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:49.295284	2018-02-21 22:16:12.908071	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:49.079914	\N	\N	Tito Abernathy 2 18 0	\N	\N	f	\N	\N	f	f	{}	f	tito_abernathy_2_18_	\N	\N
116	vote-author-participatory_process-2-19-0@example.org	$2a$11$NrXeVVk4lUQDOuH7vFKhrOMY823g2T6Qw1U.kHLQlg7qVOBz3dtUK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:49.646616	2018-02-21 22:16:12.910277	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:49.445213	\N	\N	Marlon Donnelly III 2 19 0	\N	\N	f	\N	\N	f	f	{}	f	marlon_donnelly_iii_	\N	\N
117	participatory_process_3_admin@example.org	$2a$11$hFxJ.SeBDr/i2AEzSPve.eBRSCXj5IgBDjabwhETY8QUpm9uiJnHy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:50.964242	2018-02-21 22:16:12.912473	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:50.765191	\N	\N	Laurianne Marquardt	en	\N	f	\N	\N	f	f	{}	f	laurianne_marquardt	\N	\N
118	participatory_process_3_collaborator@example.org	$2a$11$ZB/f8lvica2PTBEQO7MTeOiBf0BXBFoosCxEO/2bFXFuRNr.s9lw.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:51.179075	2018-02-21 22:16:12.914684	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:50.977822	\N	\N	Mrs. Mohammad Kohler	en	\N	f	\N	\N	f	f	{}	f	mrs_mohammad_kohler	\N	\N
119	participatory_process_3_moderator@example.org	$2a$11$3NwOEh6av4fRtqTv86dUSe1PYT3fSvMEzY33NVqQZOGucnTEQ1yo2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:51.406612	2018-02-21 22:16:12.916833	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:51.197257	\N	\N	Kiel Hirthe Sr.	en	\N	f	\N	\N	f	f	{}	f	kiel_hirthe_sr	\N	\N
120	meeting-registered-user-7-0@example.org	$2a$11$bdkn8Hx8YdzeyqTD8cVsmeyBrX9k4r3LLDpyssM.c3JK75gOSngbW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:51.813702	2018-02-21 22:16:12.919142	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:51.616198	\N	\N	Harley Greenholt 7 0	\N	\N	f	\N	\N	f	f	{}	f	harley_greenholt_7_0	\N	\N
121	meeting-registered-user-7-1@example.org	$2a$11$pSsE0h/OJi52DGZq8TVhVeymCCVo3m.ZSEGJugvWkGw7cBA0cyq12	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:52.020527	2018-02-21 22:16:12.921815	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:51.824492	\N	\N	Adalberto Rowe 7 1	\N	\N	f	\N	\N	f	f	{}	f	adalberto_rowe_7_1	\N	\N
122	meeting-registered-user-7-2@example.org	$2a$11$L/kwgxXHf6pnj40I6MEaLOs00D6CNtycnE08FJQU9IFnESfNw1sBq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:52.234739	2018-02-21 22:16:12.924212	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:52.030321	\N	\N	Francesca Boehm 7 2	\N	\N	f	\N	\N	f	f	{}	f	francesca_boehm_7_2	\N	\N
123	meeting-registered-user-7-3@example.org	$2a$11$nTJnuAnSfuv27Mylqr7P9eiLVigQ3kQC6Sz3nPqRrCoiLOvZX1YtK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:52.448546	2018-02-21 22:16:12.926435	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:52.245115	\N	\N	Rachelle Parker 7 3	\N	\N	f	\N	\N	f	f	{}	f	rachelle_parker_7_3	\N	\N
124	meeting-registered-user-7-4@example.org	$2a$11$YyjLjqr2Hfagia23bwCy3.WDqNPgNnIbd2YS248JJd4wdopuYFEB.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:52.665183	2018-02-21 22:16:12.928726	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:52.458929	\N	\N	Wendell Schaefer DDS 7 4	\N	\N	f	\N	\N	f	f	{}	f	wendell_schaefer_dds	\N	\N
125	meeting-registered-user-7-5@example.org	$2a$11$f9NpYWhEsu3RlBhsCgf1V.NMbTrnLJ2ZO6.IdHKhemPWQhhy8SV9G	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:52.870633	2018-02-21 22:16:12.931657	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:52.674668	\N	\N	Dr. Augustine Veum 7 5	\N	\N	f	\N	\N	f	f	{}	f	dr_augustine_veum_7_	\N	\N
126	meeting-registered-user-7-6@example.org	$2a$11$4CUUrIYegML41AKzZpw6UOzRxl4KwPiWDLDRGAkLr29E0fTIg520e	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:53.076677	2018-02-21 22:16:12.93428	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:52.880624	\N	\N	Mr. Gus Wolf 7 6	\N	\N	f	\N	\N	f	f	{}	f	mr_gus_wolf_7_6	\N	\N
127	meeting-registered-user-7-7@example.org	$2a$11$JCHNtYUArxxp4UOZQEOnd.mEbEL7F1mL7YjG4xxnP0tKb7he3IHMW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:53.302014	2018-02-21 22:16:12.936863	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:53.086362	\N	\N	Mr. Billie Murazik 7 7	\N	\N	f	\N	\N	f	f	{}	f	mr_billie_murazik_7_	\N	\N
128	meeting-registered-user-7-8@example.org	$2a$11$Y.ZVg1ti2YDpGVHGoRhdYeqTpAQrP1dy7KeE8DQ2R7TOOcfWBV2P6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:53.51	2018-02-21 22:16:12.939135	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:53.312348	\N	\N	Miss Kara Corwin 7 8	\N	\N	f	\N	\N	f	f	{}	f	miss_kara_corwin_7_8	\N	\N
129	meeting-registered-user-7-9@example.org	$2a$11$Y.qVXcWGjFrTvvI7x5vQgeV7gQSaFBD56a/Og9W4pf6i/W7Wsn3Gy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:53.720378	2018-02-21 22:16:12.941338	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:53.519911	\N	\N	Aleen Bradtke 7 9	\N	\N	f	\N	\N	f	f	{}	f	aleen_bradtke_7_9	\N	\N
130	meeting-registered-user-8-0@example.org	$2a$11$dOC4dgFyAIDn2Gw9.aSMx.mQqWweJh4CKLNG.u.WDl1UbNM9YZ7fu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:54.109257	2018-02-21 22:16:12.94358	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:53.907608	\N	\N	Fredy Botsford 8 0	\N	\N	f	\N	\N	f	f	{}	f	fredy_botsford_8_0	\N	\N
131	meeting-registered-user-8-1@example.org	$2a$11$w46cQJBbHCWtmvqfQ8tNHOi1lh5kjc78SZJW/ZNAL0Qi/j/LrgSGS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:54.316556	2018-02-21 22:16:12.94587	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:54.119988	\N	\N	Emilia Murphy 8 1	\N	\N	f	\N	\N	f	f	{}	f	emilia_murphy_8_1	\N	\N
132	meeting-registered-user-8-2@example.org	$2a$11$bmTNCmr3CMz73MU5i3B7A.CeB/zKWeIHqaetH.Yg9kiD/XBq79xGS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:54.525495	2018-02-21 22:16:12.94817	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:54.326061	\N	\N	Luella Goldner 8 2	\N	\N	f	\N	\N	f	f	{}	f	luella_goldner_8_2	\N	\N
133	meeting-registered-user-8-3@example.org	$2a$11$qJH0P6my61JggjZu4CJeaOkp627JaNwe4cNHrPYI6n8k3oIYpFfr2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:54.781222	2018-02-21 22:16:12.950357	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:54.583046	\N	\N	Alexane Gerlach I 8 3	\N	\N	f	\N	\N	f	f	{}	f	alexane_gerlach_i_8_	\N	\N
134	meeting-registered-user-8-4@example.org	$2a$11$xm5oW7d0/AXye7fMLluoTe6CS.AlkREpuhs14DDfA8lcNEr6.9kya	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:54.994471	2018-02-21 22:16:12.952582	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:54.792174	\N	\N	Kathleen Pouros 8 4	\N	\N	f	\N	\N	f	f	{}	f	kathleen_pouros_8_4	\N	\N
135	meeting-registered-user-8-5@example.org	$2a$11$CS6s3cfCDwyeY9NetsITMOERwCO6UHYKy6xwndi90E//XofFIQOHK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:55.210833	2018-02-21 22:16:12.954961	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:55.004092	\N	\N	Jasmin McLaughlin 8 5	\N	\N	f	\N	\N	f	f	{}	f	jasmin_mclaughlin_8_	\N	\N
136	meeting-registered-user-8-6@example.org	$2a$11$SCaFgLo4YEsmDcOoi6xtXuCnbbgZ314C4p7jUELepXfWh1Z6aIR2y	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:55.420604	2018-02-21 22:16:12.95726	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:55.222765	\N	\N	Gilberto Jacobs 8 6	\N	\N	f	\N	\N	f	f	{}	f	gilberto_jacobs_8_6	\N	\N
137	meeting-registered-user-8-7@example.org	$2a$11$QcNFauIV1AtPNDaw8ozw6eicPrlAyaMYEhBBusrMnQO3r/QVAZ8kK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:55.644159	2018-02-21 22:16:12.95948	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:55.433017	\N	\N	Justina Friesen 8 7	\N	\N	f	\N	\N	f	f	{}	f	justina_friesen_8_7	\N	\N
138	meeting-registered-user-8-8@example.org	$2a$11$hz3iS1HGI4YqCHj1SEPZRutlB2zn90Eibsg3QJO8Zc3BA6Ko6oOhi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:55.8534	2018-02-21 22:16:12.962004	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:55.65417	\N	\N	Daisha Runolfsdottir 8 8	\N	\N	f	\N	\N	f	f	{}	f	daisha_runolfsdottir	\N	\N
139	meeting-registered-user-8-9@example.org	$2a$11$ROBUi/7Qr8BDLUZJV2CXQedrowCgtZozy8gefM6pL38BeIQteYkBG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:56.070017	2018-02-21 22:16:12.964361	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:55.866069	\N	\N	Dolores Schumm 8 9	\N	\N	f	\N	\N	f	f	{}	f	dolores_schumm_8_9	\N	\N
140	meeting-registered-user-9-0@example.org	$2a$11$lt7i3ta1U33qL.0UjZWCwOGiq9UKpGl8r0k3qZKEny25SZzexMYOm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:56.447734	2018-02-21 22:16:12.96668	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:56.246297	\N	\N	Roxanne Koss 9 0	\N	\N	f	\N	\N	f	f	{}	f	roxanne_koss_9_0	\N	\N
141	meeting-registered-user-9-1@example.org	$2a$11$JpGCjDmtrP5U367J6P1znuUcJYKuNh3RNVsBeowyq7MMXyOMwhiCy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:56.665017	2018-02-21 22:16:12.968828	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:56.460854	\N	\N	Clemens Herman III 9 1	\N	\N	f	\N	\N	f	f	{}	f	clemens_herman_iii_9	\N	\N
142	meeting-registered-user-9-2@example.org	$2a$11$VUfM7rQ2OOehPceY7guu0ukCy4SOdksGWIRKTLyKyh9EdAvSKS7d6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:56.885454	2018-02-21 22:16:12.971024	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:56.676966	\N	\N	Pinkie Collier 9 2	\N	\N	f	\N	\N	f	f	{}	f	pinkie_collier_9_2	\N	\N
143	meeting-registered-user-9-3@example.org	$2a$11$Q5qZl6splWA1WDvS1eKluOaAZlSkKCWg4xFC.MRtIhMrVB..wob/y	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:57.095612	2018-02-21 22:16:12.973414	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:56.896628	\N	\N	Mr. Larry Leannon 9 3	\N	\N	f	\N	\N	f	f	{}	f	mr_larry_leannon_9_3	\N	\N
144	meeting-registered-user-9-4@example.org	$2a$11$YeZsjq6bqYbSp6hZtRbo6umSqpqxMNTb25OZdbkzjQJX0I3Qi85oW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:57.306459	2018-02-21 22:16:12.975649	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:57.109365	\N	\N	Kole Friesen 9 4	\N	\N	f	\N	\N	f	f	{}	f	kole_friesen_9_4	\N	\N
145	meeting-registered-user-9-5@example.org	$2a$11$6rCIwCDQ1lfXY5D7Pw7uK.J9NSGsHb3GII80PZzhLKigFDxXY5bjW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:57.518007	2018-02-21 22:16:12.977892	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:57.316636	\N	\N	Alberta Franecki Sr. 9 5	\N	\N	f	\N	\N	f	f	{}	f	alberta_franecki_sr_	\N	\N
146	meeting-registered-user-9-6@example.org	$2a$11$ct6bCRQ/H9R.etc.BmabLuF2/E2fQdMoPWHeUrfrShJn2q1JkLgq.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:57.74576	2018-02-21 22:16:12.980092	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:57.529733	\N	\N	Lorenz Swift 9 6	\N	\N	f	\N	\N	f	f	{}	f	lorenz_swift_9_6	\N	\N
147	meeting-registered-user-9-7@example.org	$2a$11$ME8c8q7E5BloW4o6bdrPn..WWlC.8ua81IsJqEezAsIJeqLETNdRi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:58.007488	2018-02-21 22:16:12.982251	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:57.757683	\N	\N	Dovie Koch 9 7	\N	\N	f	\N	\N	f	f	{}	f	dovie_koch_9_7	\N	\N
148	meeting-registered-user-9-8@example.org	$2a$11$.2iNFdUW8OZ09tZy0gRRfe5YYFYCnHZUUd4W3jWOtn8UO1uBGw1f2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:58.24483	2018-02-21 22:16:12.984542	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:58.026784	\N	\N	Dr. Frankie Bosco 9 8	\N	\N	f	\N	\N	f	f	{}	f	dr_frankie_bosco_9_8	\N	\N
149	meeting-registered-user-9-9@example.org	$2a$11$2S8sx5dW5PAUgTisBQCwV.YrAhXhialI38GgH4D4.Jg.tykTePFjS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:58.474742	2018-02-21 22:16:12.986692	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:58.257048	\N	\N	Ahmad Olson MD 9 9	\N	\N	f	\N	\N	f	f	{}	f	ahmad_olson_md_9_9	\N	\N
150	vote-author-participatory_process-3-0-0@example.org	$2a$11$F9a7F0vI1pu2fJXHWvA7jOZLRUgYUegbyoTd9A5g2UrP5Q9PUSbsa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:58.969509	2018-02-21 22:16:12.988922	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:58.746131	\N	\N	Brannon Fisher 3 0 0	\N	\N	f	\N	\N	f	f	{}	f	brannon_fisher_3_0_0	\N	\N
151	vote-author-participatory_process-3-0-1@example.org	$2a$11$16EMFEixGtg9tjiswv8jWOwr81milkgRxysSheU7/WCHChkxzgNVy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:59.192818	2018-02-21 22:16:12.991015	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:58.982581	\N	\N	Una Ledner 3 0 1	\N	\N	f	\N	\N	f	f	{}	f	una_ledner_3_0_1	\N	\N
152	vote-author-participatory_process-3-1-0@example.org	$2a$11$1Fmo4093r4dRipMX21hxdOzvH3eT9nQBS7A0tMI.O68R4gZXV/KXO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:59.51951	2018-02-21 22:16:12.993202	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:59.272328	\N	\N	Gino Champlin III 3 1 0	\N	\N	f	\N	\N	f	f	{}	f	gino_champlin_iii_3_	\N	\N
153	vote-author-participatory_process-3-3-0@example.org	$2a$11$mqUkO5Yn2g1rBlB60eqd/.5kVgrPEKZ2HVIVqnACBCI.py407tDuO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:47:59.988522	2018-02-21 22:16:12.995505	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:47:59.778166	\N	\N	Kiel Lockman 3 3 0	\N	\N	f	\N	\N	f	f	{}	f	kiel_lockman_3_3_0	\N	\N
154	vote-author-participatory_process-3-4-0@example.org	$2a$11$pHdnTJQevN64dVayd4u6n.ezBlWjIFZdnkXMsgyoOKJzEF7dw4QXK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:00.349155	2018-02-21 22:16:12.997972	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:00.118897	\N	\N	Pierre Auer 3 4 0	\N	\N	f	\N	\N	f	f	{}	f	pierre_auer_3_4_0	\N	\N
155	vote-author-participatory_process-3-4-1@example.org	$2a$11$avg/TmLiDp7eTrrM6GCQbO6MtbN8nP49ebT.K9ySLLSHGl.V/ZwJ.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:00.584467	2018-02-21 22:16:13.000242	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:00.366252	\N	\N	Meaghan Mohr II 3 4 1	\N	\N	f	\N	\N	f	f	{}	f	meaghan_mohr_ii_3_4_	\N	\N
156	vote-author-participatory_process-3-5-0@example.org	$2a$11$fg5ACtkREzYKQvyfe6.YU.LoSKLlqrSfbCwLoJJUbLTQxwJ..Xc86	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:00.949919	2018-02-21 22:16:13.002718	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:00.703164	\N	\N	Kyla Roberts I 3 5 0	\N	\N	f	\N	\N	f	f	{}	f	kyla_roberts_i_3_5_0	\N	\N
157	vote-author-participatory_process-3-6-0@example.org	$2a$11$j9hMS2kOSuHQVpv/6N3omeXwXUzs49cVE1KBKGzUAfOyYihy/wh5e	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:01.299398	2018-02-21 22:16:13.005579	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:01.068459	\N	\N	Gretchen Grady 3 6 0	\N	\N	f	\N	\N	f	f	{}	f	gretchen_grady_3_6_0	\N	\N
158	vote-author-participatory_process-3-8-0@example.org	$2a$11$thC0MSYCxqMobCWzQU5XQeDjuXB9ko/LOSva0YfVtfEmeYx5xRq4q	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:01.773452	2018-02-21 22:16:13.008086	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:01.541022	\N	\N	Nelson Kiehn DDS 3 8 0	\N	\N	f	\N	\N	f	f	{}	f	nelson_kiehn_dds_3_8	\N	\N
159	vote-author-participatory_process-3-9-0@example.org	$2a$11$UBrgqZRiJ6KOXnVufd/8lOP/KsRzvmXMn3l2hPKF8nX.m8SAxA53.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:02.216297	2018-02-21 22:16:13.01047	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:01.999411	\N	\N	Chanel Kihn 3 9 0	\N	\N	f	\N	\N	f	f	{}	f	chanel_kihn_3_9_0	\N	\N
160	vote-author-participatory_process-3-9-1@example.org	$2a$11$IEIKAKnHksLal4qiFZQ6COYawHRaqO/MZmLOUJctyWykTkzkbdX9C	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:02.459616	2018-02-21 22:16:13.012866	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:02.232102	\N	\N	Camilla Lebsack 3 9 1	\N	\N	f	\N	\N	f	f	{}	f	camilla_lebsack_3_9_	\N	\N
161	vote-author-participatory_process-3-10-0@example.org	$2a$11$mKrbXu8oMaxXsYuvX8u0pOmY33dAdo8KD6g57UNo..DWs45hUdSkC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:02.858234	2018-02-21 22:16:13.015394	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:02.619767	\N	\N	Ms. Reyes Wolf 3 10 0	\N	\N	f	\N	\N	f	f	{}	f	ms_reyes_wolf_3_10_0	\N	\N
162	vote-author-participatory_process-3-10-1@example.org	$2a$11$tOheuGbGWkANXrsQdIx3u.rhTJGCulG5DhFY8yMLToLzV1cCxMIp6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:03.114778	2018-02-21 22:16:13.017858	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:02.876179	\N	\N	Chet Kunde 3 10 1	\N	\N	f	\N	\N	f	f	{}	f	chet_kunde_3_10_1	\N	\N
163	vote-author-participatory_process-3-11-0@example.org	$2a$11$6OozQJffoHNCb3QC2lPHEOnZmv/EPvu3ChGbW/JeoBoZoNkcPT0Wu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:03.478226	2018-02-21 22:16:13.020838	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:03.228723	\N	\N	Reva Cole 3 11 0	\N	\N	f	\N	\N	f	f	{}	f	reva_cole_3_11_0	\N	\N
164	vote-author-participatory_process-3-12-0@example.org	$2a$11$x1delRBPG8glj6DpLvxNvun0TH4gLFKCcnPj/C74POHXWi5S27zl2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:03.780083	2018-02-21 22:16:13.023726	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:03.565142	\N	\N	Miss Dorian Ziemann 3 12 0	\N	\N	f	\N	\N	f	f	{}	f	miss_dorian_ziemann_	\N	\N
165	vote-author-participatory_process-3-12-1@example.org	$2a$11$w4aJoVzKAr5cRilhvFzBNO17pBFRH.O7bizUu5GA8xNbVkNxPAMYa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:04.022661	2018-02-21 22:16:13.026279	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:03.795206	\N	\N	Patrick Nolan IV 3 12 1	\N	\N	f	\N	\N	f	f	{}	f	patrick_nolan_iv_3_1	\N	\N
166	vote-author-participatory_process-3-13-0@example.org	$2a$11$fyoYn7gnXJWIOoFk9N9zvevZsIEUWqN4yrapQ2cISzt07uhUZmLHK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:04.342013	2018-02-21 22:16:13.028753	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:04.116677	\N	\N	Mr. Olin Casper 3 13 0	\N	\N	f	\N	\N	f	f	{}	f	mr_olin_casper_3_13_	\N	\N
167	vote-author-participatory_process-3-13-1@example.org	$2a$11$0VDJawWdOhfVTg7jJBUKq.pCYJwRSRE00hwWwLyaatCj1.OnWYX9W	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:04.581451	2018-02-21 22:16:13.030926	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:04.356564	\N	\N	Delmer Krajcik 3 13 1	\N	\N	f	\N	\N	f	f	{}	f	delmer_krajcik_3_13_	\N	\N
168	vote-author-participatory_process-3-14-0@example.org	$2a$11$43zMk3tCW.xmuayit8xVvOP2YfQDbtggQIBFQeK7MJd4DpEbAQLpG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:04.996078	2018-02-21 22:16:13.033095	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:04.761231	\N	\N	Dashawn Mertz IV 3 14 0	\N	\N	f	\N	\N	f	f	{}	f	dashawn_mertz_iv_3_1	\N	\N
169	vote-author-participatory_process-3-14-1@example.org	$2a$11$dm.8n.PPaiWrSmolYcUrUenpI1UAN.UbaHlxri5/11LcfY4d66E5S	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:05.254375	2018-02-21 22:16:13.035318	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:05.010955	\N	\N	Mr. Marlen Crist 3 14 1	\N	\N	f	\N	\N	f	f	{}	f	mr_marlen_crist_3_14	\N	\N
170	vote-author-participatory_process-3-15-0@example.org	$2a$11$d/ZGJXGcLDyI5qp1YudMSuk26CzZkLn8PAEySHpvzD3VV8falY8zu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:05.701856	2018-02-21 22:16:13.037528	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:05.444642	\N	\N	Cory Hahn MD 3 15 0	\N	\N	f	\N	\N	f	f	{}	f	cory_hahn_md_3_15_0	\N	\N
171	vote-author-participatory_process-3-16-0@example.org	$2a$11$/ONOKBqlYGR65BdELPUuVOa/Oc2BdjGvknfbFYNZ17aQ7c3bUYtKa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:06.180262	2018-02-21 22:16:13.039658	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:05.950107	\N	\N	Kyler Pollich 3 16 0	\N	\N	f	\N	\N	f	f	{}	f	kyler_pollich_3_16_0	\N	\N
172	vote-author-participatory_process-3-18-0@example.org	$2a$11$dijymBnKbLDWmiAeCPv54.B7sm1ANYrCT6kgzucMFNKEaKRpslJmq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:06.756623	2018-02-21 22:16:13.041896	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:06.537393	\N	\N	Wilson Reinger 3 18 0	\N	\N	f	\N	\N	f	f	{}	f	wilson_reinger_3_18_	\N	\N
173	vote-author-participatory_process-3-19-0@example.org	$2a$11$KTdSyclDIYJNArCU5WYsweOSaWa/ACTJwIIEbWYVQDDZu87iYGhb.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:07.104445	2018-02-21 22:16:13.044584	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:06.870619	\N	\N	Andreanne Kulas 3 19 0	\N	\N	f	\N	\N	f	f	{}	f	andreanne_kulas_3_19	\N	\N
174	vote-author-participatory_process-3-19-1@example.org	$2a$11$tLIVshEI75iaFaKVKs2mSe4ZKkuz/6emT/nB3eBKYWAKtusbTkchu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:07.346356	2018-02-21 22:16:13.047152	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:07.1259	\N	\N	Mrs. Gust Pacocha 3 19 1	\N	\N	f	\N	\N	f	f	{}	f	mrs_gust_pacocha_3_1	\N	\N
175	meeting-registered-user-10-0@example.org	$2a$11$t3rR/54Tb9dQTXsqsB/5aeleSPYe6LdYX8MTX1XQzDO797AQVh/yS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:10.103629	2018-02-21 22:16:13.049553	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:09.868	\N	\N	Ms. Alf Ledner 10 0	\N	\N	f	\N	\N	f	f	{}	f	ms_alf_ledner_10_0	\N	\N
176	meeting-registered-user-10-1@example.org	$2a$11$pTm77m3/sVm5WTIH1wblCeQG3SThoCu41pne25eZh.HwiRyVjyiVC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:10.364853	2018-02-21 22:16:13.051996	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:10.129427	\N	\N	Tyrell Flatley 10 1	\N	\N	f	\N	\N	f	f	{}	f	tyrell_flatley_10_1	\N	\N
177	meeting-registered-user-10-2@example.org	$2a$11$JfQTtiuouQJLaltA8pHH4.icmtTju0gUUQ0gxG0mRhO2DNgONCNqG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:10.578209	2018-02-21 22:16:13.054229	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:10.374895	\N	\N	Cyrus Bashirian 10 2	\N	\N	f	\N	\N	f	f	{}	f	cyrus_bashirian_10_2	\N	\N
178	meeting-registered-user-10-3@example.org	$2a$11$XYCLAidztn6T9vYOCseN8ecKjqI9oh5VGJ2f/wV0dNbaalhQSBYOu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:10.817931	2018-02-21 22:16:13.056623	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:10.588983	\N	\N	Daniella Hintz 10 3	\N	\N	f	\N	\N	f	f	{}	f	daniella_hintz_10_3	\N	\N
179	meeting-registered-user-10-4@example.org	$2a$11$BaJV0pukRGFEhdXCYeiFr.SBY.79q3Rug38Mc4w.UWhbyhV20wdAe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:11.067264	2018-02-21 22:16:13.058827	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:10.846199	\N	\N	Mrs. Herminia Willms 10 4	\N	\N	f	\N	\N	f	f	{}	f	mrs_herminia_willms_	\N	\N
180	meeting-registered-user-10-5@example.org	$2a$11$g4ZrIk7ECfFIJGAH1TbuLOVl.Vo.VGkEsglvbRu7YctOAKgHVyi.G	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:11.298377	2018-02-21 22:16:13.061248	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:11.079421	\N	\N	Andreane Zboncak I 10 5	\N	\N	f	\N	\N	f	f	{}	f	andreane_zboncak_i_1	\N	\N
181	meeting-registered-user-10-6@example.org	$2a$11$bZk7Bhk..8tHmQu0Es4TUOHTcedluTPBa0l6W1DBW2CQ391q6n.T2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:11.536149	2018-02-21 22:16:13.06363	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:11.318936	\N	\N	Samanta Pfannerstill III 10 6	\N	\N	f	\N	\N	f	f	{}	f	samanta_pfannerstill	\N	\N
182	meeting-registered-user-10-7@example.org	$2a$11$N2ebE9TaY2rcFZ5MzhhsYuynEwD2k25QAGN9fPDpkKJi95/8HSNFq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:11.764474	2018-02-21 22:16:13.06591	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:11.546524	\N	\N	Abbigail Towne PhD 10 7	\N	\N	f	\N	\N	f	f	{}	f	abbigail_towne_phd_1	\N	\N
183	meeting-registered-user-10-8@example.org	$2a$11$vJW4QfqTDl778SCK4MlriusStIWrhjMfUk7KBVliTTF4encU7wf8a	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:11.994311	2018-02-21 22:16:13.068197	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:11.775574	\N	\N	Obie Schumm 10 8	\N	\N	f	\N	\N	f	f	{}	f	obie_schumm_10_8	\N	\N
184	meeting-registered-user-10-9@example.org	$2a$11$GWCNBcF0Tr90VjwPlD3BMeg4QWJdzznKmJpE0L8yK08B48Zz3O0wW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:12.239622	2018-02-21 22:16:13.070429	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:12.008493	\N	\N	Oma Gleichner 10 9	\N	\N	f	\N	\N	f	f	{}	f	oma_gleichner_10_9	\N	\N
185	meeting-registered-user-11-0@example.org	$2a$11$KBcw.A45XKrxdki1lA.7P.3aHHVgfMq0KqJ9trRA5au2p/kYL1FxS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:12.698562	2018-02-21 22:16:13.072834	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:12.471732	\N	\N	Akeem Beier 11 0	\N	\N	f	\N	\N	f	f	{}	f	akeem_beier_11_0	\N	\N
186	meeting-registered-user-11-1@example.org	$2a$11$F/T6CorM7.cfvqp/j5smwu.ZAsWtiVp9.aUc0SQ607KMd0pcjfT/W	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:12.930629	2018-02-21 22:16:13.07525	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:12.712812	\N	\N	Lilly Ferry PhD 11 1	\N	\N	f	\N	\N	f	f	{}	f	lilly_ferry_phd_11_1	\N	\N
187	meeting-registered-user-11-2@example.org	$2a$11$DhaX.lzN36Vt2YdkebQFxe6ooMGsXqJ8ntmt1i5m2IvKl8QIctV3W	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:13.168611	2018-02-21 22:16:13.077644	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:12.945229	\N	\N	Porter Doyle 11 2	\N	\N	f	\N	\N	f	f	{}	f	porter_doyle_11_2	\N	\N
188	meeting-registered-user-11-3@example.org	$2a$11$ZhpiCTayaHp4sgRK2/NOmeFt7PBMAecAI8wNEROP16IJMxCmzBuIK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:13.397832	2018-02-21 22:16:13.080222	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:13.190379	\N	\N	Maximillian Stiedemann 11 3	\N	\N	f	\N	\N	f	f	{}	f	maximillian_stiedema	\N	\N
189	meeting-registered-user-11-4@example.org	$2a$11$3p1.hqbyCy4PXsc3XHIHsO4GpBOakxIEjUbXv8va9fSWVGVYYXvEu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:13.614939	2018-02-21 22:16:13.082685	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:13.411234	\N	\N	Lawrence Rodriguez 11 4	\N	\N	f	\N	\N	f	f	{}	f	lawrence_rodriguez_1	\N	\N
190	meeting-registered-user-11-5@example.org	$2a$11$3Tmt6xzAq9rtr2f.nNVeB.0DJekvHMO6NyvkYk/n3FGV7fnvkfcxG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:13.824615	2018-02-21 22:16:13.084949	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:13.62771	\N	\N	Miss Gladys Kerluke 11 5	\N	\N	f	\N	\N	f	f	{}	f	miss_gladys_kerluke_	\N	\N
191	meeting-registered-user-11-6@example.org	$2a$11$1.jn1fJBDaa7MsQLs5ueuu9hn3sEm.dNyzwk72Ut1bzMZnUdI8NaW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:14.072769	2018-02-21 22:16:13.087285	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:13.83645	\N	\N	Damaris Rice 11 6	\N	\N	f	\N	\N	f	f	{}	f	damaris_rice_11_6	\N	\N
192	meeting-registered-user-11-7@example.org	$2a$11$RaA7cncuO8PlzmAzLJmWAeJvMcWvkF6CsPNYTUlfJpMfGRK1iHsOy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:14.279298	2018-02-21 22:16:13.08966	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:14.083418	\N	\N	Ms. Diamond Denesik 11 7	\N	\N	f	\N	\N	f	f	{}	f	ms_diamond_denesik_1	\N	\N
193	meeting-registered-user-11-8@example.org	$2a$11$87ZPpr2ilW6i9DTBQARC4OO8nttax3BV4t0GzUxN06uFa8j68vqfK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:14.48624	2018-02-21 22:16:13.092063	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:14.290021	\N	\N	Claude Goldner 11 8	\N	\N	f	\N	\N	f	f	{}	f	claude_goldner_11_8	\N	\N
194	meeting-registered-user-11-9@example.org	$2a$11$2FOHKligHGPmGqxznEGl7ui5LeqhMo7cXJnp7BjRG2sjxwKIPM.dy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:14.695562	2018-02-21 22:16:13.094436	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:14.498181	\N	\N	Cristal Marquardt 11 9	\N	\N	f	\N	\N	f	f	{}	f	cristal_marquardt_11	\N	\N
195	meeting-registered-user-12-0@example.org	$2a$11$kJ/ZC1.6TudeOaaf9VAaNui3zSedt6hgokJtDgBUl5sNpkkNbnkoi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:15.06552	2018-02-21 22:16:13.097013	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:14.866189	\N	\N	Miss Vidal Wunsch 12 0	\N	\N	f	\N	\N	f	f	{}	f	miss_vidal_wunsch_12	\N	\N
196	meeting-registered-user-12-1@example.org	$2a$11$aENtIxc3Hl/ytsHCPN28XO01bfoGTqQXXKza636jrOyGBW4Grr5fC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:15.282403	2018-02-21 22:16:13.099585	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:15.077318	\N	\N	Ms. Rollin Murray 12 1	\N	\N	f	\N	\N	f	f	{}	f	ms_rollin_murray_12_	\N	\N
197	meeting-registered-user-12-2@example.org	$2a$11$tbf4JOHBOw1WTlAzZwP4EOxaZ3M1IVJULxyeN1jRelOdMreB7vR2G	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:15.490649	2018-02-21 22:16:13.101972	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:15.29455	\N	\N	Ford Christiansen 12 2	\N	\N	f	\N	\N	f	f	{}	f	ford_christiansen_12	\N	\N
198	meeting-registered-user-12-3@example.org	$2a$11$/Ydtinv1X76w9fckppA0qul7H6hEawkW.5QsbRo.cWMh1hYiAqtMG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:15.697033	2018-02-21 22:16:13.104479	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:15.500224	\N	\N	Rodrigo Padberg 12 3	\N	\N	f	\N	\N	f	f	{}	f	rodrigo_padberg_12_3	\N	\N
199	meeting-registered-user-12-4@example.org	$2a$11$N1dfravV5UAQwEhxYASGhOZybvEwz4NsWYDgCnw74gCXlSK07FKgq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:15.903383	2018-02-21 22:16:13.106819	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:15.707453	\N	\N	Victor Legros 12 4	\N	\N	f	\N	\N	f	f	{}	f	victor_legros_12_4	\N	\N
200	meeting-registered-user-12-5@example.org	$2a$11$1QvNVvN6lsCCeG7dQPNlxOWeGHnzSt8Vnb4zf7lI8y22.oBxLoLum	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:16.112756	2018-02-21 22:16:13.109073	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:15.915136	\N	\N	Lily Gleason 12 5	\N	\N	f	\N	\N	f	f	{}	f	lily_gleason_12_5	\N	\N
201	meeting-registered-user-12-6@example.org	$2a$11$h.NzQKSixCMzRyyg25qJJ.M574drL1syLIdRsAdJTjQb0TzaqrWve	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:16.325344	2018-02-21 22:16:13.111379	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:16.125342	\N	\N	Korbin Dietrich PhD 12 6	\N	\N	f	\N	\N	f	f	{}	f	korbin_dietrich_phd_	\N	\N
202	meeting-registered-user-12-7@example.org	$2a$11$Qg6SWLRr8GvzQTu6aAyBrOoBpq/Zb3ScgVTiIJI7h3VAepuvslawm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:16.55292	2018-02-21 22:16:13.114045	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:16.337177	\N	\N	Christa Raynor 12 7	\N	\N	f	\N	\N	f	f	{}	f	christa_raynor_12_7	\N	\N
203	meeting-registered-user-12-8@example.org	$2a$11$UH5mASodoNPTH0xkGnDJIu5mrJ6VIEYeRCSCKTF0sY91aatJABm2q	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:16.758378	2018-02-21 22:16:13.116749	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:16.562461	\N	\N	Angeline Schaefer 12 8	\N	\N	f	\N	\N	f	f	{}	f	angeline_schaefer_12	\N	\N
204	meeting-registered-user-12-9@example.org	$2a$11$DubhvpIuoL3g0z6XYB.Yk.ONIzYI1duYSbYYNY7HVWISnVEVhdQrG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:16.965196	2018-02-21 22:16:13.119422	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:16.768614	\N	\N	Alivia Kohler 12 9	\N	\N	f	\N	\N	f	f	{}	f	alivia_kohler_12_9	\N	\N
205	vote-author-assembly-1-0-0@example.org	$2a$11$FTTDQUK1MTdu62QnIvEB4eytBkl9Ak8IyhB8wkzAuKhv3sK40vA9e	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:17.349907	2018-02-21 22:16:13.122593	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:17.14708	\N	\N	Heber McClure 1 0 0	\N	\N	f	\N	\N	f	f	{}	f	heber_mcclure_1_0_0	\N	\N
206	vote-author-assembly-1-0-1@example.org	$2a$11$f.3a45FMNIvY.QyVVfVGe.wfApqhG1Kj3xIbeDMWwNMddP5ExZxEC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:17.569731	2018-02-21 22:16:13.125183	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:17.362366	\N	\N	Silas Jerde 1 0 1	\N	\N	f	\N	\N	f	f	{}	f	silas_jerde_1_0_1	\N	\N
207	vote-author-assembly-1-2-0@example.org	$2a$11$ca3eoNiVbKibY3RcCcDaquGSilFiXq9sZOubX3Kuk2KktV0Iu3FIC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:18.045274	2018-02-21 22:16:13.127538	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:17.842587	\N	\N	Alfreda Veum 1 2 0	\N	\N	f	\N	\N	f	f	{}	f	alfreda_veum_1_2_0	\N	\N
208	vote-author-assembly-1-3-0@example.org	$2a$11$gNHMGhd9q5B.u9JYKwlqp.gCyZ8DKatB0.EF4yCOL/UAA0VTg3eSm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:18.367679	2018-02-21 22:16:13.130089	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:18.171487	\N	\N	Geoffrey Quigley 1 3 0	\N	\N	f	\N	\N	f	f	{}	f	geoffrey_quigley_1_3	\N	\N
209	vote-author-assembly-1-3-1@example.org	$2a$11$bVKQFuN/lKso3hOIKklgQO.H3KBKL9TPsrhF..1kAeM2ynqEY8r3a	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:18.575384	2018-02-21 22:16:13.132495	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:18.379483	\N	\N	Connor Beer 1 3 1	\N	\N	f	\N	\N	f	f	{}	f	connor_beer_1_3_1	\N	\N
210	vote-author-assembly-1-5-0@example.org	$2a$11$BEv7CuRVhnMZW/BXVu0jnOYlj.thgrgBkpQmbq0ey7J90UnzooRJK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:18.916758	2018-02-21 22:16:13.135141	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:18.717472	\N	\N	Paolo Weissnat 1 5 0	\N	\N	f	\N	\N	f	f	{}	f	paolo_weissnat_1_5_0	\N	\N
211	vote-author-assembly-1-6-0@example.org	$2a$11$nran3VRwJuO681SijVlMgOEPySGzu93UHOgwz8z2nzfc1NSOpujIG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:19.225113	2018-02-21 22:16:13.137559	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:19.003821	\N	\N	Lempi Mills 1 6 0	\N	\N	f	\N	\N	f	f	{}	f	lempi_mills_1_6_0	\N	\N
212	vote-author-assembly-1-8-0@example.org	$2a$11$HP36Y5YSadOhJ7gzDIFlo.spGiIOKA0E5s6pAhmEbr9E3SNxvnWOC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:19.597623	2018-02-21 22:16:13.139964	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:19.401748	\N	\N	Reyna McDermott 1 8 0	\N	\N	f	\N	\N	f	f	{}	f	reyna_mcdermott_1_8_	\N	\N
213	vote-author-assembly-1-9-0@example.org	$2a$11$V7HuDrZEwAUIHP1wg.NBC./Fy81pQB3x13r0skO4h.yOddO56hmXW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:19.909166	2018-02-21 22:16:13.142571	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:19.710784	\N	\N	Lucinda Mitchell 1 9 0	\N	\N	f	\N	\N	f	f	{}	f	lucinda_mitchell_1_9	\N	\N
214	vote-author-assembly-1-10-0@example.org	$2a$11$gLaiw3A94C5IGo4nPhbWQOiN/pUfkNJUfwXz6Kx84pR0lL9ZElCYC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:20.254508	2018-02-21 22:16:13.145139	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:20.039571	\N	\N	Ines Kunze 1 10 0	\N	\N	f	\N	\N	f	f	{}	f	ines_kunze_1_10_0	\N	\N
215	vote-author-assembly-1-10-1@example.org	$2a$11$yI3FbTCo6fAKwDSPt0ueD.xs3ufL67v8z/xEROQ9cs9hqlkO2FpRm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:20.472829	2018-02-21 22:16:13.14808	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:20.267065	\N	\N	Justus Mayer 1 10 1	\N	\N	f	\N	\N	f	f	{}	f	justus_mayer_1_10_1	\N	\N
216	vote-author-assembly-1-11-0@example.org	$2a$11$Ld8RsRgntlGJGo0mfKGZZ.Iz4C1.R.ia4/AxSfOxxYuO5eEZs0dcG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:20.756794	2018-02-21 22:16:13.150874	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:20.550482	\N	\N	Eldridge Stiedemann PhD 1 11 0	\N	\N	f	\N	\N	f	f	{}	f	eldridge_stiedemann_	\N	\N
217	vote-author-assembly-1-12-0@example.org	$2a$11$l3nOc7mwsDUp3N24DHtjo.hsT8DMKJIYYtkRuCXJbLe8uvAaHAGki	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:21.110369	2018-02-21 22:16:13.153064	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:20.904045	\N	\N	Winona Bode 1 12 0	\N	\N	f	\N	\N	f	f	{}	f	winona_bode_1_12_0	\N	\N
218	vote-author-assembly-1-13-0@example.org	$2a$11$Cqq82bFs33USbRt3pLcqTuNdeMY6kSY4IxFK0XY8zTwd4Ly7TbyXC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:21.443315	2018-02-21 22:16:13.155202	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:21.236332	\N	\N	Ms. Garrick Ritchie 1 13 0	\N	\N	f	\N	\N	f	f	{}	f	ms_garrick_ritchie_1	\N	\N
219	vote-author-assembly-1-13-1@example.org	$2a$11$IiHIKQAT4.Efe54rrw8TTeaNB/udmSZTrkdp54mdR98MKtl7GaHym	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:21.657824	2018-02-21 22:16:13.157357	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:21.454744	\N	\N	Brando Grant 1 13 1	\N	\N	f	\N	\N	f	f	{}	f	brando_grant_1_13_1	\N	\N
220	vote-author-assembly-1-14-0@example.org	$2a$11$Elb/BFP9CvISGXKlsxleq.bw5qdoqMS/99EveHodzZ1OqOGsdwBxa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:21.963295	2018-02-21 22:16:13.159464	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:21.755754	\N	\N	Mabelle Bernier 1 14 0	\N	\N	f	\N	\N	f	f	{}	f	mabelle_bernier_1_14	\N	\N
221	vote-author-assembly-1-15-0@example.org	$2a$11$S4WG1kBqTIKKfvsETmj44.G7Zg1R0H8gLGX0JZkdJgWAWV9hmq2A6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:22.296322	2018-02-21 22:16:13.161659	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:22.09694	\N	\N	Alexzander Strosin III 1 15 0	\N	\N	f	\N	\N	f	f	{}	f	alexzander_strosin_i	\N	\N
222	vote-author-assembly-1-16-0@example.org	$2a$11$394ZzYnRxuIov3V5q.ChY.mobMKjEZVCWxBPqO/eDfs5ppbLlHC2G	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:22.598417	2018-02-21 22:16:13.163854	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:22.40175	\N	\N	Mrs. Gertrude Williamson 1 16 0	\N	\N	f	\N	\N	f	f	{}	f	mrs_gertrude_william	\N	\N
223	vote-author-assembly-1-16-1@example.org	$2a$11$9A/bV77oDedyz3bZlS7WmOd0pfdZAM6Zyr4lqiqSl1Cj7mxrR/MZO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:22.819965	2018-02-21 22:16:13.166096	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:22.622193	\N	\N	Ms. Anita Ryan 1 16 1	\N	\N	f	\N	\N	f	f	{}	f	ms_anita_ryan_1_16_1	\N	\N
224	vote-author-assembly-1-17-0@example.org	$2a$11$qPyNX2p/VtA2u1RePjrfoeFuMsx6itUcydC6IZrfm0QQOzzAW3gf6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:23.238631	2018-02-21 22:16:13.168352	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:23.016091	\N	\N	Pasquale Feest 1 17 0	\N	\N	f	\N	\N	f	f	{}	f	pasquale_feest_1_17_	\N	\N
225	vote-author-assembly-1-19-0@example.org	$2a$11$OMWFqHLOQNxpRlrC5p.Ql.Pxc185yaxfVIPW5avK37aup5.i8NnHu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:23.73902	2018-02-21 22:16:13.170564	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:23.535927	\N	\N	Vaughn Macejkovic 1 19 0	\N	\N	f	\N	\N	f	f	{}	f	vaughn_macejkovic_1_	\N	\N
226	meeting-registered-user-13-0@example.org	$2a$11$DyYMorOmMQQ8u5.JCXd8.uj0i0AXEZuw5o19s1hkzv19ocfqY.4ia	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:25.258581	2018-02-21 22:16:13.172977	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:25.026303	\N	\N	Elaina Leannon 13 0	\N	\N	f	\N	\N	f	f	{}	f	elaina_leannon_13_0	\N	\N
227	meeting-registered-user-13-1@example.org	$2a$11$Yr2g0DpiFSHfK1hOwqQxz.0OQrDA4xrvw3QX0uEyHzhEeRO57Ggo.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:25.487593	2018-02-21 22:16:13.175263	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:25.273232	\N	\N	Simeon Buckridge 13 1	\N	\N	f	\N	\N	f	f	{}	f	simeon_buckridge_13_	\N	\N
228	meeting-registered-user-13-2@example.org	$2a$11$CCunXn3IGXDSC0c0IBuGUu7hHu6.29WZtQ5QIqGGYTEtWh28DxXey	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:25.697755	2018-02-21 22:16:13.177529	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:25.49857	\N	\N	Marcia Ledner 13 2	\N	\N	f	\N	\N	f	f	{}	f	marcia_ledner_13_2	\N	\N
229	meeting-registered-user-13-3@example.org	$2a$11$hj08rjnINw31r/ukdudl5eQeMq5wswUEhY/1EwQ0qRoTwVN/5qunK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:25.913497	2018-02-21 22:16:13.180092	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:25.708789	\N	\N	Vergie Mueller DVM 13 3	\N	\N	f	\N	\N	f	f	{}	f	vergie_mueller_dvm_1	\N	\N
230	meeting-registered-user-13-4@example.org	$2a$11$nwkHrPLqhjTVkmB.t9EeTu79LkNs82C9t4ffW5ZwysrrXAusVK6m.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:26.149576	2018-02-21 22:16:13.182596	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:25.923743	\N	\N	Bernhard Corwin 13 4	\N	\N	f	\N	\N	f	f	{}	f	bernhard_corwin_13_4	\N	\N
231	meeting-registered-user-13-5@example.org	$2a$11$HnOIbLwWslmX8Ro4Qa.SVO9dBiY.ukKYfWrVj74B6kEgrTKCgz8IW	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:26.391405	2018-02-21 22:16:13.184719	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:26.16868	\N	\N	Orpha Klocko 13 5	\N	\N	f	\N	\N	f	f	{}	f	orpha_klocko_13_5	\N	\N
232	meeting-registered-user-13-6@example.org	$2a$11$weTgL49tr2uLWlZvvvu0MOEeeK95QBlNtSIVPD4l23yPMN4BbkoLu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:26.621957	2018-02-21 22:16:13.186891	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:26.409565	\N	\N	Isidro Marvin 13 6	\N	\N	f	\N	\N	f	f	{}	f	isidro_marvin_13_6	\N	\N
233	meeting-registered-user-13-7@example.org	$2a$11$1cP.EdgQTYNNXIXcLuVjWOU4d6mY/86BEnFNr3BH3o6HuNJQO2a6C	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:26.833507	2018-02-21 22:16:13.189058	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:26.632316	\N	\N	Miss Scottie Davis 13 7	\N	\N	f	\N	\N	f	f	{}	f	miss_scottie_davis_1	\N	\N
234	meeting-registered-user-13-8@example.org	$2a$11$Ob3fGoCNFfdrXlzYa7Z/eu02/PVbPaM8h2zeKftGhJCXrNbqvx68S	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:27.04403	2018-02-21 22:16:13.191234	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:26.846762	\N	\N	Gregoria Feeney 13 8	\N	\N	f	\N	\N	f	f	{}	f	gregoria_feeney_13_8	\N	\N
235	meeting-registered-user-13-9@example.org	$2a$11$G.ZPtihL5Q8UrWqjIvmaDeG0E3SBsyjT4.sbvQf8qf2goUZSWCzJi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:27.254826	2018-02-21 22:16:13.193513	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:27.054908	\N	\N	Ara Bartoletti 13 9	\N	\N	f	\N	\N	f	f	{}	f	ara_bartoletti_13_9	\N	\N
236	meeting-registered-user-14-0@example.org	$2a$11$j//2Fx70mAulvU2yLIdW2eHZ6S4KXgarGZ4/z9fZp34N11IpW.DPa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:27.642105	2018-02-21 22:16:13.196144	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:27.436459	\N	\N	Joshuah Fay 14 0	\N	\N	f	\N	\N	f	f	{}	f	joshuah_fay_14_0	\N	\N
237	meeting-registered-user-14-1@example.org	$2a$11$lWjNDwCwsRQ366n.FmZMJOjlm/dn1tM2uwu1dLTl4mHd9qHgem.9i	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:27.857256	2018-02-21 22:16:13.198965	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:27.652363	\N	\N	Lilla Bernier 14 1	\N	\N	f	\N	\N	f	f	{}	f	lilla_bernier_14_1	\N	\N
238	meeting-registered-user-14-2@example.org	$2a$11$gYznjjdPg3QRAVb9txruouE17Ib7ZPKdOl3/4wF5FclHpxpTxDzoe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:28.073278	2018-02-21 22:16:13.201431	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:27.867541	\N	\N	Demarcus Zemlak Jr. 14 2	\N	\N	f	\N	\N	f	f	{}	f	demarcus_zemlak_jr_1	\N	\N
239	meeting-registered-user-14-3@example.org	$2a$11$2Z4dJ07pbtPHfPJpFzbWzelZywLFYIWOUTokTn7vFDweIUNfegCTi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:28.281435	2018-02-21 22:16:13.203893	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:28.083321	\N	\N	Delpha Schmitt 14 3	\N	\N	f	\N	\N	f	f	{}	f	delpha_schmitt_14_3	\N	\N
240	meeting-registered-user-14-4@example.org	$2a$11$mE.DOE.aqpycQe7u3TI9DeNHSCoFm5mt0NbWIbAibUeMdrCrH.xPe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:28.491831	2018-02-21 22:16:13.206222	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:28.292266	\N	\N	Mr. Jenifer Bosco 14 4	\N	\N	f	\N	\N	f	f	{}	f	mr_jenifer_bosco_14_	\N	\N
241	meeting-registered-user-14-5@example.org	$2a$11$BgYwC9EWZJI.y2lG3uyYs.NSjAghEuXu3OXGRkJivfQ5XW98VGWmG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:28.705872	2018-02-21 22:16:13.218785	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:28.504728	\N	\N	Marcelo Rice 14 5	\N	\N	f	\N	\N	f	f	{}	f	marcelo_rice_14_5	\N	\N
242	meeting-registered-user-14-6@example.org	$2a$11$LNpM1Wh9ZTb6YXQN03vS3eHzWNksLo5qjNWbGzWNYQlrc2FGfOAR.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:28.921052	2018-02-21 22:16:13.221538	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:28.718638	\N	\N	Adrien Kirlin 14 6	\N	\N	f	\N	\N	f	f	{}	f	adrien_kirlin_14_6	\N	\N
243	meeting-registered-user-14-7@example.org	$2a$11$qzm8141YusdW484aKngcy.1rCgLKGePGRWOPYpelJBGmU5sE9UHjG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:29.131191	2018-02-21 22:16:13.223967	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:28.930955	\N	\N	Johanna Harvey 14 7	\N	\N	f	\N	\N	f	f	{}	f	johanna_harvey_14_7	\N	\N
244	meeting-registered-user-14-8@example.org	$2a$11$UvXDAOnGt4rd/0vVN/8Ng.7eeo6d8TZioin1m2JEmy8aeyjV0K0C2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:29.360049	2018-02-21 22:16:13.22655	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:29.144871	\N	\N	Aniya Reichel 14 8	\N	\N	f	\N	\N	f	f	{}	f	aniya_reichel_14_8	\N	\N
245	meeting-registered-user-14-9@example.org	$2a$11$VE6dS5z0Al95lJp1Ts.FVOxrkai9CmCZX9dT/0b1tdj0l7BZHJknK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:29.584268	2018-02-21 22:16:13.229062	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:29.370584	\N	\N	Tremayne Wilderman 14 9	\N	\N	f	\N	\N	f	f	{}	f	tremayne_wilderman_1	\N	\N
246	meeting-registered-user-15-0@example.org	$2a$11$R9bQVQDzYHWNpdrzqXw3fOFLCqpSUVTkUHjoQK.E7UdHmgbKKQogS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:29.959192	2018-02-21 22:16:13.231613	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:29.756943	\N	\N	Lorine Crona IV 15 0	\N	\N	f	\N	\N	f	f	{}	f	lorine_crona_iv_15_0	\N	\N
247	meeting-registered-user-15-1@example.org	$2a$11$h2Ux.8KftEE1sq1BxSgcPuzVaZAKkwewAF6pdI4MGg8PCTm8OkfsO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:30.171508	2018-02-21 22:16:13.233887	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:29.969288	\N	\N	Constance Altenwerth 15 1	\N	\N	f	\N	\N	f	f	{}	f	constance_altenwerth	\N	\N
248	meeting-registered-user-15-2@example.org	$2a$11$0p0YwFeVVILLac/FfveJeOcO52ytNFozydpPqBwjhqgmDM01cEF4i	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:30.382183	2018-02-21 22:16:13.236134	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:30.182072	\N	\N	Clovis Rutherford PhD 15 2	\N	\N	f	\N	\N	f	f	{}	f	clovis_rutherford_ph	\N	\N
249	meeting-registered-user-15-3@example.org	$2a$11$DyUKCPQzZnDJ5RRMFteHruDE6vRLEmOGtVFtpBgkxG6.DNgeYEuDq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:30.589235	2018-02-21 22:16:13.238319	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:30.392716	\N	\N	Telly Huels Sr. 15 3	\N	\N	f	\N	\N	f	f	{}	f	telly_huels_sr_15_3	\N	\N
250	meeting-registered-user-15-4@example.org	$2a$11$AkZekb6eoMJuNo1rT5F4uu3byZlGCnUXOkErA1GtXkCAlN8WFyc6K	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:30.804403	2018-02-21 22:16:13.240459	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:30.60201	\N	\N	Bethany Boehm 15 4	\N	\N	f	\N	\N	f	f	{}	f	bethany_boehm_15_4	\N	\N
251	meeting-registered-user-15-5@example.org	$2a$11$3hZmCY/kSUX3Zvxn0SuXben1Im7oTxGAcfagJ5rr/Hd6mf0vtRlYS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:31.020111	2018-02-21 22:16:13.242626	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:30.816448	\N	\N	Ms. Reece Gerlach 15 5	\N	\N	f	\N	\N	f	f	{}	f	ms_reece_gerlach_15_	\N	\N
252	meeting-registered-user-15-6@example.org	$2a$11$MnN2JP1GvFMmyG0hBwxZv.dQkHQpkjWYmYEaUH5YXhEsoHyXHiGsO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:31.235529	2018-02-21 22:16:13.244894	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:31.03058	\N	\N	Hiram Emmerich 15 6	\N	\N	f	\N	\N	f	f	{}	f	hiram_emmerich_15_6	\N	\N
253	meeting-registered-user-15-7@example.org	$2a$11$TEaw3JCfb0j6.Y86xVzDg.u1OzlqJVwPBa3bS7CGkTJDP4yn6bXUe	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:31.468409	2018-02-21 22:16:13.247232	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:31.252519	\N	\N	Gregory Rolfson III 15 7	\N	\N	f	\N	\N	f	f	{}	f	gregory_rolfson_iii_	\N	\N
254	meeting-registered-user-15-8@example.org	$2a$11$tFhac0tquZ657BxiVCox7.bIXieLbr6xYZd5p8m2hlGoOW87.rXcK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:31.680487	2018-02-21 22:16:13.249498	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:31.481731	\N	\N	Miss Mazie Stiedemann 15 8	\N	\N	f	\N	\N	f	f	{}	f	miss_mazie_stiedeman	\N	\N
255	meeting-registered-user-15-9@example.org	$2a$11$bFW8rmZVVntxDMPNuzuGIeass5Su9/aRyvYF4pGsaYe7mOcleaT5.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:31.890545	2018-02-21 22:16:13.251617	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:31.692922	\N	\N	Mrs. Linnea Ritchie 15 9	\N	\N	f	\N	\N	f	f	{}	f	mrs_linnea_ritchie_1	\N	\N
256	vote-author-assembly-2-0-0@example.org	$2a$11$yJ3cp1CsmfngOSVQMhEAw.GRqd6avQRFVAMcnuHPrOCuKjT9vwzeO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:32.294605	2018-02-21 22:16:13.25384	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:32.083975	\N	\N	Katlyn Steuber DDS 2 0 0	\N	\N	f	\N	\N	f	f	{}	f	katlyn_steuber_dds_2	\N	\N
257	vote-author-assembly-2-1-0@example.org	$2a$11$wQd.FhJuF3bBwFgCemfV3edPgSVk6agQBfvAMUR3cIaPYNSaamdc2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:32.673091	2018-02-21 22:16:13.256226	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:32.464568	\N	\N	Dr. Mikayla Blanda 2 1 0	\N	\N	f	\N	\N	f	f	{}	f	dr_mikayla_blanda_2_	\N	\N
258	vote-author-assembly-2-2-0@example.org	$2a$11$guSgCy7GCcmHkAdavaiu0.zSE9OvlqG/1o8HMJPCIgykh6u0eEoxm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:32.99074	2018-02-21 22:16:13.258527	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:32.779831	\N	\N	Tanner Flatley 2 2 0	\N	\N	f	\N	\N	f	f	{}	f	tanner_flatley_2_2_0	\N	\N
259	vote-author-assembly-2-3-0@example.org	$2a$11$qT9Dfb.ZfLj.XIbw.oPaiueo/1ZVZxYlk2CrGk/DAmla2W11eAome	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:33.364977	2018-02-21 22:16:13.260845	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:33.146684	\N	\N	Devin Abbott 2 3 0	\N	\N	f	\N	\N	f	f	{}	f	devin_abbott_2_3_0	\N	\N
260	vote-author-assembly-2-4-0@example.org	$2a$11$.f.1pyKFHp2tGHk9ZCiLLOcyxOdjN7m6w46NqvYGD1uU67Rq1B5cO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:33.713392	2018-02-21 22:16:13.263239	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:33.502556	\N	\N	Mrs. Virgie Johns 2 4 0	\N	\N	f	\N	\N	f	f	{}	f	mrs_virgie_johns_2_4	\N	\N
261	vote-author-assembly-2-7-0@example.org	$2a$11$KL5GseHKfxQr8452sj3KlOAVL8IhSIPCyxll7UjijEwpP73NtmEQa	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:34.425976	2018-02-21 22:16:13.265475	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:34.216238	\N	\N	Leda Hagenes 2 7 0	\N	\N	f	\N	\N	f	f	{}	f	leda_hagenes_2_7_0	\N	\N
262	vote-author-assembly-2-7-1@example.org	$2a$11$NlcZE2Xr.w4SHhTUo0baHOWMRHw4zS3GYaDyUGCiYMQbdaYdNGWL2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:34.648157	2018-02-21 22:16:13.267775	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:34.446813	\N	\N	Jamison Mohr 2 7 1	\N	\N	f	\N	\N	f	f	{}	f	jamison_mohr_2_7_1	\N	\N
263	vote-author-assembly-2-8-0@example.org	$2a$11$gC35xoTpkQIqxg2ewDFIvOH8cVRp3s5gcozWh.FXA3ugkYOObAoPy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:34.982899	2018-02-21 22:16:13.270087	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:34.784489	\N	\N	Kenna Marvin 2 8 0	\N	\N	f	\N	\N	f	f	{}	f	kenna_marvin_2_8_0	\N	\N
264	vote-author-assembly-2-8-1@example.org	$2a$11$YYAVxwlEXg2n0gpR9d9y5.tURdxxgMuzz.3lFEYLNkbVZun1jD9Fi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:35.199778	2018-02-21 22:16:13.272607	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:34.996933	\N	\N	Jamie Hartmann 2 8 1	\N	\N	f	\N	\N	f	f	{}	f	jamie_hartmann_2_8_1	\N	\N
265	vote-author-assembly-2-9-0@example.org	$2a$11$6y0h8YEy9pQA24RY/FXIzedKx98UU35gYKxMjlPD6dU9YkqIkkt96	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:35.58535	2018-02-21 22:16:13.274832	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:35.383378	\N	\N	Rogelio Weimann MD 2 9 0	\N	\N	f	\N	\N	f	f	{}	f	rogelio_weimann_md_2	\N	\N
266	vote-author-assembly-2-9-1@example.org	$2a$11$/aHjmE1fq5GmDjdqBkIqyeZxnn3nYAoqJ8a1hdccqPoaLrsoKROya	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:35.858106	2018-02-21 22:16:13.277084	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:35.654627	\N	\N	Jeramie Koepp 2 9 1	\N	\N	f	\N	\N	f	f	{}	f	jeramie_koepp_2_9_1	\N	\N
267	vote-author-assembly-2-10-0@example.org	$2a$11$mBTzOhOYlfITYdzK2dqXcO909t/x7RvzKLnN8psFL/GUi.0Jgt1Ii	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:36.163801	2018-02-21 22:16:13.279497	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:35.960702	\N	\N	Charlene Ferry 2 10 0	\N	\N	f	\N	\N	f	f	{}	f	charlene_ferry_2_10_	\N	\N
268	vote-author-assembly-2-10-1@example.org	$2a$11$AZR4m6/PCGthJ7qOmLKfj.tWRjnzl6OsouuEGb2cHy76kCDWV8ZiG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:36.376508	2018-02-21 22:16:13.281765	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:36.176763	\N	\N	Rosalyn Pfannerstill I 2 10 1	\N	\N	f	\N	\N	f	f	{}	f	rosalyn_pfannerstill	\N	\N
269	vote-author-assembly-2-12-0@example.org	$2a$11$lQ5a0gZ7m.FyHqV7dT3ja.xzw5OeldpoeGhCBquWgsAP1khQjMau2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:36.82695	2018-02-21 22:16:13.284096	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:36.628571	\N	\N	Tomasa Jast 2 12 0	\N	\N	f	\N	\N	f	f	{}	f	tomasa_jast_2_12_0	\N	\N
270	vote-author-assembly-2-12-1@example.org	$2a$11$bGQ.vM0Y1BY5Chb8vb7r3Oq838cv5rB/3vMWAj2yfAoAX6FdtPXI6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:37.035292	2018-02-21 22:16:13.286386	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:36.838786	\N	\N	Marcelina Denesik IV 2 12 1	\N	\N	f	\N	\N	f	f	{}	f	marcelina_denesik_iv	\N	\N
271	vote-author-assembly-2-13-0@example.org	$2a$11$liHdkneP5U7Ne/han8ZfZ.9/1iPwf7iZfVe3RNzmCIfJx2zCNpc3a	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:37.325661	2018-02-21 22:16:13.288629	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:37.118464	\N	\N	Justen Ferry 2 13 0	\N	\N	f	\N	\N	f	f	{}	f	justen_ferry_2_13_0	\N	\N
272	vote-author-assembly-2-13-1@example.org	$2a$11$3sZwrMNHzdMDZ4a2g.Gp4emcfvojMlBuDBqWzAa1duBNMIXG76MZ6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:37.553418	2018-02-21 22:16:13.290825	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:37.337837	\N	\N	Kennedy Kerluke 2 13 1	\N	\N	f	\N	\N	f	f	{}	f	kennedy_kerluke_2_13	\N	\N
273	vote-author-assembly-2-14-0@example.org	$2a$11$kwlw4qtzi35kV5Y/xbVSe.Lu2w4.B/eLJaQWbx7EddqiwQrjB/Twy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:37.938912	2018-02-21 22:16:13.293108	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:37.727522	\N	\N	Luisa Mante II 2 14 0	\N	\N	f	\N	\N	f	f	{}	f	luisa_mante_ii_2_14_	\N	\N
274	vote-author-assembly-2-14-1@example.org	$2a$11$KZyHo4DJ8lNFQJRXHbSvwOgROSqd0LV4Pw/2svIbIIJhg8btleX4e	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:38.163613	2018-02-21 22:16:13.295444	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:37.952873	\N	\N	Ocie Denesik 2 14 1	\N	\N	f	\N	\N	f	f	{}	f	ocie_denesik_2_14_1	\N	\N
275	vote-author-assembly-2-17-0@example.org	$2a$11$7dMcAi7aAluftiT1H6wpSu2xdhlq7fLq2obNH.qIlNF.z3m0fJM8a	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:38.602163	2018-02-21 22:16:13.298107	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:38.402632	\N	\N	Heath Zemlak MD 2 17 0	\N	\N	f	\N	\N	f	f	{}	f	heath_zemlak_md_2_17	\N	\N
276	vote-author-assembly-2-18-0@example.org	$2a$11$uw7y7mCoxqmdc2giTW6OLejYbx5RpJEZ/9.Ubl9me6P9ePKqjhsPi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:38.98336	2018-02-21 22:16:13.300246	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:38.784196	\N	\N	Theron Grant 2 18 0	\N	\N	f	\N	\N	f	f	{}	f	theron_grant_2_18_0	\N	\N
277	vote-author-assembly-2-18-1@example.org	$2a$11$5gHAMbXFckFCG/JzdpqRZOHZQtayfnZxJu7TBWdI58xd/Fx4CvKzi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:39.208915	2018-02-21 22:16:13.302421	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:38.996626	\N	\N	Ima Schamberger 2 18 1	\N	\N	f	\N	\N	f	f	{}	f	ima_schamberger_2_18	\N	\N
278	vote-author-assembly-2-19-0@example.org	$2a$11$8ZskX9IBcwCg4Z.SfVlwIuYNaxFu1BJCzd0UoLOpP7j0bkuiEKxY.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:39.666128	2018-02-21 22:16:13.30464	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:39.442758	\N	\N	Dr. Armani Kerluke 2 19 0	\N	\N	f	\N	\N	f	f	{}	f	dr_armani_kerluke_2_	\N	\N
279	meeting-registered-user-16-0@example.org	$2a$11$VE.tS6tyfEHRfg14uCzGROZMdHpo8yCOAlhf0f8U9OguYziYs3lWG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:41.532766	2018-02-21 22:16:13.306857	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:41.328242	\N	\N	Miguel Ullrich MD 16 0	\N	\N	f	\N	\N	f	f	{}	f	miguel_ullrich_md_16	\N	\N
280	meeting-registered-user-16-1@example.org	$2a$11$hbcelpVYPd7Ovl1CahOSnOR9YZg8MlX/3Oy5QFPwgsGGXmsU4mpcm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:41.74577	2018-02-21 22:16:13.308987	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:41.544046	\N	\N	Maribel Reynolds 16 1	\N	\N	f	\N	\N	f	f	{}	f	maribel_reynolds_16_	\N	\N
281	meeting-registered-user-16-2@example.org	$2a$11$1G6oxzEdObHPrFH8Fs9OwORBQoReJGesqjYb8Eg4Z./Vw84/F6WOu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:41.957991	2018-02-21 22:16:13.311227	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:41.757765	\N	\N	Soledad Hettinger 16 2	\N	\N	f	\N	\N	f	f	{}	f	soledad_hettinger_16	\N	\N
282	meeting-registered-user-16-3@example.org	$2a$11$V.eQYVDdZNi1LslJN0TxDuBYHprZHUYpiXUt5kyvKIvnZdpZTWuR2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:42.163946	2018-02-21 22:16:13.31362	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:41.967902	\N	\N	Adella Heller 16 3	\N	\N	f	\N	\N	f	f	{}	f	adella_heller_16_3	\N	\N
283	meeting-registered-user-16-4@example.org	$2a$11$eYJ9dfEtaP.cnmvY/D0eouVoQXuy7jJff.4yxpBsHtMszpyNUKsuu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:42.370793	2018-02-21 22:16:13.315949	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:42.174619	\N	\N	Shawna Graham II 16 4	\N	\N	f	\N	\N	f	f	{}	f	shawna_graham_ii_16_	\N	\N
284	meeting-registered-user-16-5@example.org	$2a$11$d5NStabIHHU5HxtHGkLXiOyYzC0wXUJ87QocDwBRuhn/26MeymIpG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:42.587414	2018-02-21 22:16:13.318278	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:42.390843	\N	\N	Remington Jacobs V 16 5	\N	\N	f	\N	\N	f	f	{}	f	remington_jacobs_v_1	\N	\N
285	meeting-registered-user-16-6@example.org	$2a$11$FJiY0XWPxASCt9USHXN2wORg2BRuaJkgoWTSrN6EUqlmbnz3kyv16	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:42.802145	2018-02-21 22:16:13.320538	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:42.598419	\N	\N	Mr. Selina Sipes 16 6	\N	\N	f	\N	\N	f	f	{}	f	mr_selina_sipes_16_6	\N	\N
286	meeting-registered-user-16-7@example.org	$2a$11$/Re2A13/JPHuumHwUtjbMuzgQC9gKOy2dPflUW2FXpf9BA13BnMim	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:43.013288	2018-02-21 22:16:13.323235	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:42.812502	\N	\N	Dorcas Daniel 16 7	\N	\N	f	\N	\N	f	f	{}	f	dorcas_daniel_16_7	\N	\N
287	meeting-registered-user-16-8@example.org	$2a$11$o5EfZbRKCOnNVaUne7V2DOy2bzv7RPM8//RNWHu6X3Ta2SOVfnjyO	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:43.229646	2018-02-21 22:16:13.325727	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:43.030355	\N	\N	Agustina Gerlach 16 8	\N	\N	f	\N	\N	f	f	{}	f	agustina_gerlach_16_	\N	\N
288	meeting-registered-user-16-9@example.org	$2a$11$cmhCrjqkfd7FHH7TAlC7g.SX4kzg7xpV1nHTw.0drg4JLG12yx4cG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:43.449931	2018-02-21 22:16:13.328118	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:43.247593	\N	\N	Mr. Audie Schulist 16 9	\N	\N	f	\N	\N	f	f	{}	f	mr_audie_schulist_16	\N	\N
289	meeting-registered-user-17-0@example.org	$2a$11$Fps43SFHsFfHQaM..VU5RuHYMvXR4C5i.pwckG4D3afgsoUGFt7VC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:43.80385	2018-02-21 22:16:13.330401	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:43.606893	\N	\N	Evalyn Lueilwitz 17 0	\N	\N	f	\N	\N	f	f	{}	f	evalyn_lueilwitz_17_	\N	\N
290	meeting-registered-user-17-1@example.org	$2a$11$OOlifhQfdhx5DHIgOWhVG.YTY7fucHy9oHXPjCnmhkhplMidTPq3.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:44.013522	2018-02-21 22:16:13.332624	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:43.815978	\N	\N	Connie Kilback DVM 17 1	\N	\N	f	\N	\N	f	f	{}	f	connie_kilback_dvm_1	\N	\N
291	meeting-registered-user-17-2@example.org	$2a$11$UTrsEFVepB4yEqPNBYNXSuHr1u394RF3N2KPXpMwDQXzml51l3jni	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:44.22739	2018-02-21 22:16:13.334795	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:44.028772	\N	\N	Ms. Adelle Beatty 17 2	\N	\N	f	\N	\N	f	f	{}	f	ms_adelle_beatty_17_	\N	\N
292	meeting-registered-user-17-3@example.org	$2a$11$WYTiTLPCuEiILcdYIrljROdWHHmn3ms7G./JoRdsGoao0.9ZLlZSC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:44.439321	2018-02-21 22:16:13.337131	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:44.240913	\N	\N	Adaline Moen MD 17 3	\N	\N	f	\N	\N	f	f	{}	f	adaline_moen_md_17_3	\N	\N
293	meeting-registered-user-17-4@example.org	$2a$11$kbKzAAk.FsRTojpj9JRsqepWHKpek3bfkNno.uQ.PFoOV/LX4ve..	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:44.649668	2018-02-21 22:16:13.339289	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:44.451908	\N	\N	Carlotta Auer MD 17 4	\N	\N	f	\N	\N	f	f	{}	f	carlotta_auer_md_17_	\N	\N
294	meeting-registered-user-17-5@example.org	$2a$11$a33hnJRpSShLWf5Au1rYBewYM9VGUG7E7S8XOIS9JXxz8nLw9oVIy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:44.86931	2018-02-21 22:16:13.341511	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:44.660798	\N	\N	Buck Klein 17 5	\N	\N	f	\N	\N	f	f	{}	f	buck_klein_17_5	\N	\N
295	meeting-registered-user-17-6@example.org	$2a$11$OV5W1.khffUw0jSqtg62FuXLnnJbvC1Hlt3Y.GsVMwUQj2dKnmWZS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:45.081016	2018-02-21 22:16:13.343848	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:44.882992	\N	\N	Dr. Annalise Dare 17 6	\N	\N	f	\N	\N	f	f	{}	f	dr_annalise_dare_17_	\N	\N
296	meeting-registered-user-17-7@example.org	$2a$11$aC171kW4KBFO2istUF/ba.GeJquYFrsDcvwDQsYie1A52cXbefMHS	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:45.295161	2018-02-21 22:16:13.346584	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:45.091024	\N	\N	Malvina Koepp IV 17 7	\N	\N	f	\N	\N	f	f	{}	f	malvina_koepp_iv_17_	\N	\N
297	meeting-registered-user-17-8@example.org	$2a$11$nm8axU6HqbLFLWlCB81.teYeVSVuDraGEpFhJu5azwFIFN6yHWVFu	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:45.511045	2018-02-21 22:16:13.349322	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:45.30938	\N	\N	Octavia Ebert 17 8	\N	\N	f	\N	\N	f	f	{}	f	octavia_ebert_17_8	\N	\N
298	meeting-registered-user-17-9@example.org	$2a$11$6V4S3nLtJLZzhlKbJvHcmOHrZr0HKje6O9XFaATwws3ux.SLqXKwG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:45.729498	2018-02-21 22:16:13.351711	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:45.523791	\N	\N	Janet Rodriguez 17 9	\N	\N	f	\N	\N	f	f	{}	f	janet_rodriguez_17_9	\N	\N
299	meeting-registered-user-18-0@example.org	$2a$11$yJb.5Kxc9vvSg6cuTXqjf.t2vFxrkCAYj8pnKB1j2xTAv20lxGew.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:46.084486	2018-02-21 22:16:13.354206	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:45.887333	\N	\N	Ms. Raymundo Feil 18 0	\N	\N	f	\N	\N	f	f	{}	f	ms_raymundo_feil_18_	\N	\N
300	meeting-registered-user-18-1@example.org	$2a$11$sI9OhsmR4k8W3FRbUGc3/OQ3DXMuIy0tHebwXySR45qfcLWZLpI5a	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:46.292091	2018-02-21 22:16:13.356574	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:46.094882	\N	\N	Kiana Emard 18 1	\N	\N	f	\N	\N	f	f	{}	f	kiana_emard_18_1	\N	\N
301	meeting-registered-user-18-2@example.org	$2a$11$LsUGM903WYWpkK.vVs38qOLWx6lsBNH9M2hurjJ0Imr.wwBFGUIe2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:46.520974	2018-02-21 22:16:13.358917	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:46.305721	\N	\N	Myrtice Bergstrom 18 2	\N	\N	f	\N	\N	f	f	{}	f	myrtice_bergstrom_18	\N	\N
302	meeting-registered-user-18-3@example.org	$2a$11$mKd3AD6cxTNHGlt7YuiS1uhxWxV.hg8T5ZJnT3pvOLnLKN4sXjFiG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:46.738702	2018-02-21 22:16:13.361236	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:46.530834	\N	\N	Kelvin Miller Sr. 18 3	\N	\N	f	\N	\N	f	f	{}	f	kelvin_miller_sr_18_	\N	\N
303	meeting-registered-user-18-4@example.org	$2a$11$Gu6Fq0/GxNVIz2aHXSG7GOuVSpTbWYZYhO.cMjakpz3roWmyP33Ke	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:46.948628	2018-02-21 22:16:13.363477	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:46.751046	\N	\N	Jordy Kertzmann 18 4	\N	\N	f	\N	\N	f	f	{}	f	jordy_kertzmann_18_4	\N	\N
304	meeting-registered-user-18-5@example.org	$2a$11$VcvKe69Jq1sbKzuP.QjzkOMuZCK1rgls0hgHdCgmLlOkCjKF/58l.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:47.15637	2018-02-21 22:16:13.365578	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:46.960372	\N	\N	Nina D'Amore 18 5	\N	\N	f	\N	\N	f	f	{}	f	nina_d_amore_18_5	\N	\N
305	meeting-registered-user-18-6@example.org	$2a$11$iFwVjQfXLLW1MFP109Ls9O8drJLPMsG3Lbt8kPGHKKgSVZBNUd1hK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:47.387491	2018-02-21 22:16:13.367702	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:47.167547	\N	\N	Trace Thiel 18 6	\N	\N	f	\N	\N	f	f	{}	f	trace_thiel_18_6	\N	\N
306	meeting-registered-user-18-7@example.org	$2a$11$fkEN816bc9pMR5AzsICyi./mP2.X/dpO/dnIXI6d3.KdoC5NLGoW.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:47.602051	2018-02-21 22:16:13.369985	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:47.403442	\N	\N	Shaun Howe 18 7	\N	\N	f	\N	\N	f	f	{}	f	shaun_howe_18_7	\N	\N
307	meeting-registered-user-18-8@example.org	$2a$11$mvH5o4123894.2bwI9Ad8.I7MgvRR5bYcbyAWETBWFLJfhdhj0TSq	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:47.812921	2018-02-21 22:16:13.372467	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:47.61182	\N	\N	Rickie Donnelly DVM 18 8	\N	\N	f	\N	\N	f	f	{}	f	rickie_donnelly_dvm_	\N	\N
308	meeting-registered-user-18-9@example.org	$2a$11$SqMH6H41XEMLx95rhCe7C.YFCwVNH1imXLRc/zMoELSL9QLjiPNam	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:48.027609	2018-02-21 22:16:13.374899	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:47.824087	\N	\N	Elouise Pollich MD 18 9	\N	\N	f	\N	\N	f	f	{}	f	elouise_pollich_md_1	\N	\N
309	vote-author-assembly-3-1-0@example.org	$2a$11$eE4i2oIAdUQcZod34bpafe4AHqrWmLlm/PFyKAlrh.vQz4sRVu0U2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:48.475495	2018-02-21 22:16:13.377302	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:48.279446	\N	\N	Miss Greta Rolfson 3 1 0	\N	\N	f	\N	\N	f	f	{}	f	miss_greta_rolfson_3	\N	\N
310	vote-author-assembly-3-2-0@example.org	$2a$11$EBYWRZMe2dfSOcBIio134OBlIU5ftel71pDvFBm5QvU9jhwLP6W5.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:48.781538	2018-02-21 22:16:13.379752	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:48.58546	\N	\N	Eden Zboncak 3 2 0	\N	\N	f	\N	\N	f	f	{}	f	eden_zboncak_3_2_0	\N	\N
311	vote-author-assembly-3-2-1@example.org	$2a$11$VscChBNnKmAId3nDVEc4tukKW74xxzERQgZNwjC9Pjdk/7XSqtQZ6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:48.989374	2018-02-21 22:16:13.382038	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:48.79323	\N	\N	Mr. Myrtie McGlynn 3 2 1	\N	\N	f	\N	\N	f	f	{}	f	mr_myrtie_mcglynn_3_	\N	\N
312	vote-author-assembly-3-3-0@example.org	$2a$11$Jh4cPPlREFGjrv2KNoRsreDNmghN.cHytbtKglBBri6Wzg5DOfHI2	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:49.413792	2018-02-21 22:16:13.384237	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:49.201121	\N	\N	Jordan Fritsch 3 3 0	\N	\N	f	\N	\N	f	f	{}	f	jordan_fritsch_3_3_0	\N	\N
313	vote-author-assembly-3-4-0@example.org	$2a$11$59N2wlVe2GfnjbDcQ2Epse5oNF5WRjljz6cXKxWbbxf9CUdc3pnu.	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:49.781867	2018-02-21 22:16:13.386478	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:49.582714	\N	\N	Archibald Doyle 3 4 0	\N	\N	f	\N	\N	f	f	{}	f	archibald_doyle_3_4_	\N	\N
314	vote-author-assembly-3-6-0@example.org	$2a$11$WGgo21QnoQTxOsbrLKWkouvpxr9XJyEXGBcW4Ei1ygP1B0lmU8x16	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:50.379326	2018-02-21 22:16:13.389396	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:50.139862	\N	\N	Zackary Lind 3 6 0	\N	\N	f	\N	\N	f	f	{}	f	zackary_lind_3_6_0	\N	\N
315	vote-author-assembly-3-6-1@example.org	$2a$11$NxDzbKD2TGa/vdTjMPpyt.arhjd.tyEqB3aI7EmbW1yG8nYZKjra6	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:50.601637	2018-02-21 22:16:13.391624	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:50.395543	\N	\N	Adela Schulist 3 6 1	\N	\N	f	\N	\N	f	f	{}	f	adela_schulist_3_6_1	\N	\N
316	vote-author-assembly-3-7-0@example.org	$2a$11$EMrhGdwAn2KUV5aCEQW9Fu7cocb89Gw1GDTeDRzO.wi6lHcj4ZYci	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:50.947536	2018-02-21 22:16:13.393868	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:50.751537	\N	\N	Gonzalo Senger 3 7 0	\N	\N	f	\N	\N	f	f	{}	f	gonzalo_senger_3_7_0	\N	\N
317	vote-author-assembly-3-8-0@example.org	$2a$11$GFu0VT0e8YVA5KH/G6xXKuamfUwkhSJgO3Dqo8wYJ1TM5YYVpvjve	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:51.299871	2018-02-21 22:16:13.396201	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:51.093623	\N	\N	Vidal Willms I 3 8 0	\N	\N	f	\N	\N	f	f	{}	f	vidal_willms_i_3_8_0	\N	\N
318	vote-author-assembly-3-12-0@example.org	$2a$11$UFhxFSFaDWcB/Ko3FcicUe/qp.s8YOJYRn0zbg/BOaiaoG/37onwi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:52.151907	2018-02-21 22:16:13.398564	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:51.953505	\N	\N	Anderson Hand 3 12 0	\N	\N	f	\N	\N	f	f	{}	f	anderson_hand_3_12_0	\N	\N
319	vote-author-assembly-3-13-0@example.org	$2a$11$dP4inyIG.a5HdhQ.p3cRKeUTkDFxT38eQAcDJVGjszK/r/o5DCTWm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:52.437595	2018-02-21 22:16:13.400976	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:52.239689	\N	\N	Malachi Wunsch III 3 13 0	\N	\N	f	\N	\N	f	f	{}	f	malachi_wunsch_iii_3	\N	\N
320	vote-author-assembly-3-13-1@example.org	$2a$11$gizvEe7YXDRlPQ9ctUxdQujcIju2yQ/mX8/qAF.cYlKydUNsDrNZG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:52.648772	2018-02-21 22:16:13.403473	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:52.449317	\N	\N	Myrna Emard 3 13 1	\N	\N	f	\N	\N	f	f	{}	f	myrna_emard_3_13_1	\N	\N
321	vote-author-assembly-3-14-0@example.org	$2a$11$6.LlIn6elaurJSp2rX9ojOrHTOJ9wQi.AfNyUHAGqMqKk6/TB9L06	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:53.009094	2018-02-21 22:16:13.405878	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:52.806113	\N	\N	Arnulfo Mayer V 3 14 0	\N	\N	f	\N	\N	f	f	{}	f	arnulfo_mayer_v_3_14	\N	\N
322	vote-author-assembly-3-15-0@example.org	$2a$11$yrsKQYF2NjW1C0b9ohWd1Oq7M1LggQgmHPxDYxxPBycC8.ksr7FvC	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:53.376844	2018-02-21 22:16:13.408178	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:53.17587	\N	\N	Kenton Romaguera 3 15 0	\N	\N	f	\N	\N	f	f	{}	f	kenton_romaguera_3_1	\N	\N
323	vote-author-assembly-3-15-1@example.org	$2a$11$qQ0SfHIM2nPiLXNnxwdqR.o.5fFNuOWrEhDrhOf2scDf34hMaGzje	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:53.60383	2018-02-21 22:16:13.410359	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:53.391151	\N	\N	Liza Windler 3 15 1	\N	\N	f	\N	\N	f	f	{}	f	liza_windler_3_15_1	\N	\N
324	vote-author-assembly-3-16-0@example.org	$2a$11$F4TUXJ2/NuO4Pr0hagq6MuTooZHAoP9ox.V3HaaKg7QWihwe25KlK	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:53.914245	2018-02-21 22:16:13.412764	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:53.71664	\N	\N	Sierra Schulist 3 16 0	\N	\N	f	\N	\N	f	f	{}	f	sierra_schulist_3_16	\N	\N
325	vote-author-assembly-3-16-1@example.org	$2a$11$wnrFwbJkcX/qrKTB44Dimemt0MRxa5e1GwrT8cf2j88846yc88qhm	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:54.12181	2018-02-21 22:16:13.415302	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:53.925903	\N	\N	Dorthy Schroeder 3 16 1	\N	\N	f	\N	\N	f	f	{}	f	dorthy_schroeder_3_1	\N	\N
326	vote-author-assembly-3-17-0@example.org	$2a$11$B9eRA7HwWHtjLXohGy0vAuuBN9/PyQrkTATb8S9fwJOH.nnyy3bvi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:54.430741	2018-02-21 22:16:13.41772	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:54.22804	\N	\N	Dr. Don McKenzie 3 17 0	\N	\N	f	\N	\N	f	f	{}	f	dr_don_mckenzie_3_17	\N	\N
327	vote-author-assembly-3-17-1@example.org	$2a$11$5/zRIvoJCMxv3Qox8sQbH.2uVqmoy.yvUq7PUbb.czOha.yQY8AVi	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:54.645133	2018-02-21 22:16:13.419976	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:54.447926	\N	\N	Leola Osinski 3 17 1	\N	\N	f	\N	\N	f	f	{}	f	leola_osinski_3_17_1	\N	\N
328	vote-author-assembly-3-18-0@example.org	$2a$11$w9LvhUAXp52AtcNiB/i0quhJfWdgyDRM9N.R8egPEHMdUyyJgg99S	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:54.959683	2018-02-21 22:16:13.42228	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:54.759307	\N	\N	Dion McLaughlin 3 18 0	\N	\N	f	\N	\N	f	f	{}	f	dion_mclaughlin_3_18	\N	\N
329	vote-author-assembly-3-19-0@example.org	$2a$11$Y./JO4YobUtupvA23eo0xuV5RQOqXcEvZ8mf7O9vwF7ejfmSEnrmG	\N	\N	\N	0	\N	\N	\N	\N	2017-09-13 12:48:55.282514	2018-02-21 22:16:13.424521	\N	\N	\N	\N	\N	\N	\N	0	1	\N	2017-09-13 12:48:55.082866	\N	\N	Odell Mosciski 3 19 0	\N	\N	f	\N	\N	f	f	{}	f	odell_mosciski_3_19_	\N	\N
330	mako@osp.cat	$2a$11$eV/yMh9z2K4b14daIAdf2OGgDG79ANhLhZl8aRNYemMj1dljNvf6.	645479afeda7a4e3cadc91afb6cfd0edb09f065e45425536ad820d12c8caf96e	2017-09-18 08:06:55.308876	2018-02-01 22:43:50.177771	37	2018-02-07 11:49:21.173184	2018-02-05 09:48:27.819277	91.200.204.227	81.66.244.181	2017-09-13 13:06:02.942997	2018-02-21 22:16:13.426803	\N	2017-09-13 13:06:02.942076	2017-09-13 13:06:02.942076	2017-09-13 13:07:07.456294	\N	\N	\N	0	2	\N	2017-09-13 13:07:07.456294	\N	\N	mako	\N	\N	f	\N	\N	t	f	{}	f	mako	\N	\N
331	virgile@opensourcepolitics.eu	$2a$11$Chhos3/abPFTLyVZBh2QNe2yvPjj8okS3yZGOEmW95xY0nJwMfeU2	\N	\N	\N	15	2017-10-03 13:44:11.809875	2017-10-03 07:32:22.872469	193.248.44.109	109.2.139.6	2017-09-13 15:13:12.660985	2018-02-21 22:16:13.429178	\N	2017-09-13 15:13:12.6571	2017-09-13 15:13:12.6571	2017-09-13 15:26:39.044581	\N	Decidim::User	330	0	2	\N	2017-09-13 15:26:39.044581	\N	\N	Virgile Deville	\N	\N	f	\N	\N	t	f	{}	f	virgile_deville	\N	\N
332	alain@opensourcepolitics.eu	$2a$11$XYeyPi6T62C3ej52TfUau.RkheacuS6pS50HTfmeQ7EAHFFcA4hNi	\N	\N	\N	1	2017-09-13 15:18:41.344465	2017-09-13 15:18:41.344465	36.224.225.20	36.224.225.20	2017-09-13 15:17:40.847245	2018-02-21 22:16:13.431732	\N	2017-09-13 15:17:40.846393	2017-09-13 15:17:40.846393	2017-09-13 15:18:41.33058	\N	Decidim::User	330	0	2	\N	2017-09-13 15:18:41.33058	\N	\N	Alain Buchotte	\N	\N	f	\N	\N	t	f	{}	f	alain_buchotte	\N	\N
333	vir@democracy.earth	$2a$11$7FBz0f1ZqSUfzQ0GQ87iVuq5Y.g2NBMq8zk6F/6nSq50avOTaYheS	\N	\N	\N	1	2017-09-13 16:51:57.704148	2017-09-13 16:51:57.704148	36.224.225.20	36.224.225.20	2017-09-13 16:47:51.912186	2018-02-21 22:16:13.434317	\N	\N	\N	\N	\N	\N	\N	0	2	r9xXx1kp8JcQC_u79Pej	2017-09-13 16:51:41.108155	2017-09-13 16:47:51.912341	\N	Ali	\N	\N	t	\N	\N	f	f	{}	f	ali	\N	\N
334	virgile+1@opensourcepolitics.eu	$2a$11$kLQtdyTTsehuUB3WHHUI/.zq6KrKflBN24vwz9shnKbLLOG1VkhAS	\N	\N	\N	1	2017-09-13 17:04:18.260906	2017-09-13 17:04:18.260906	36.224.225.20	36.224.225.20	2017-09-13 17:03:25.058887	2018-02-21 22:16:13.437721	\N	\N	\N	\N	\N	\N	\N	0	2	9iQGqZHuyvic4m_9H-GT	2017-09-13 17:03:56.734816	2017-09-13 17:03:25.059041	\N	Virgile Deville	\N	\N	t	\N	\N	f	f	{}	f	virgile_deville_2	\N	\N
335	jean-yves.creusot@debatpublic.fr	$2a$11$4YeurdUUHFTAN363LB/WQOENO9yNziuddgJj7ftxt8tE./h6pJsQC	\N	\N	\N	38	2018-02-16 14:07:38.158673	2018-02-16 13:38:20.800521	109.2.139.6	185.24.184.194	2017-09-13 17:52:34.243556	2018-02-21 22:16:13.440112	\N	2017-09-13 17:52:34.242181	2017-09-13 17:52:34.242181	2017-09-14 06:21:29.530359	\N	Decidim::User	331	0	2	\N	2017-09-14 06:21:29.530359	\N	\N	Jean-Yves Creusot	\N	\N	f	\N	\N	t	f	{}	f	jean-yves_creusot	\N	\N
336	danae.moyano-rodriguez@debatpublic.fr	$2a$11$JTKxzPcMNdyjeokB3N1/3OohbSswv.e3vB3FzJTkK0Q3T2WlHApFq	\N	\N	\N	14	2017-10-21 19:29:19.794522	2017-10-16 14:53:19.215405	86.247.51.36	92.184.96.108	2017-09-13 17:54:23.013064	2018-02-21 22:16:13.442873	\N	2017-09-13 17:54:23.012135	2017-09-13 17:54:23.012135	2017-09-13 18:00:47.899503	\N	Decidim::User	331	0	2	\N	2017-09-13 18:00:47.899503	\N	\N	Danae Moyano Rodriguez	\N	\N	f	\N	\N	t	f	{}	f	danae_moyano_rodrigu	\N	\N
337	valentin@opensourcepolitics.eu	$2a$11$.vJxUxUOkJ.8jJwOeFiMLOs0dBnTPdmaU0Y21iZdUYtam2nWErD1e	\N	\N	\N	3	2018-02-01 08:40:38.139262	2017-11-02 15:20:01.037199	89.157.132.58	91.200.204.227	2017-09-13 17:55:01.78308	2018-02-21 22:16:13.445875	\N	2017-09-13 17:55:01.782013	2017-09-13 17:55:01.782013	2017-09-13 17:55:27.185479	\N	Decidim::User	331	0	2	\N	2017-09-13 17:55:27.185479	\N	\N	Valentin Chaput	\N	\N	f	\N	\N	t	f	{}	f	valentin_chaput	\N	\N
338	creusot@gmail.com	$2a$11$.ny534fM6Eaj/k/meJyWZuU2ngqqmCmR.6o4rKF24v83EsTwIAOU6	\N	\N	\N	1	2017-09-14 08:57:02.780823	2017-09-14 08:57:02.780823	109.2.139.6	109.2.139.6	2017-09-14 07:55:03.185673	2018-02-21 22:16:13.448445	\N	\N	\N	\N	\N	\N	\N	0	2	e_UFqhbskoWNHX812WXm	2017-09-14 08:11:40.046971	2017-09-14 07:55:03.18594	\N	jcreusot	\N	\N	f	\N	\N	f	f	{}	f	jcreusot	\N	\N
339	priscilla.cassez@gmail.com	$2a$11$TiJSzAxc3udTz3vzLvLkE.S7BXuFpMfDOsfFPKi5sJ.mbPB31NVzq	\N	\N	\N	5	2017-10-17 10:06:23.250665	2017-09-22 12:38:16.410961	195.101.4.101	195.101.4.101	2017-09-14 09:19:38.575545	2018-02-21 22:16:13.450638	\N	\N	\N	\N	\N	\N	\N	0	2	nqyExP38ZssSEbZBxGnX	2017-09-14 09:50:34.9036	2017-09-14 09:19:38.575687	\N	priscilla	\N	\N	f	\N	\N	f	f	{}	t	priscilla	\N	\N
340	jim.scheers@debat-cndp.fr	$2a$11$Xj4xxr5pfOmFjBpHvFsEpuzSscoL0nCJcaIOJOh9RPWvTVHI4lCbO	\N	\N	\N	8	2017-11-02 15:22:32.021392	2017-10-18 10:44:52.934668	80.12.37.172	195.101.4.101	2017-09-15 08:47:09.416234	2018-02-21 22:16:13.452818	\N	2017-09-15 08:47:09.414905	2017-09-15 08:47:09.414905	2017-09-22 16:13:15.517338	\N	Decidim::User	335	0	2	\N	2017-09-22 16:13:15.517338	\N	\N	Jim Scheers	\N	\N	t	\N	\N	f	f	{}	t	jim_scheers	\N	\N
341	priscilla.cassez@debat-cndp.fr	$2a$11$o1A88zgjp4dStrjnV/S7Xuxm/9xPEifKgie7kNfL71Q2Kj7JzeGQW	\N	\N	\N	25	2018-02-15 10:41:04.410941	2018-02-02 17:07:07.617488	90.110.174.184	109.28.135.92	2017-09-15 08:48:37.530546	2018-02-21 22:16:13.455064	\N	2017-09-15 08:48:37.529957	2017-09-15 08:48:37.529957	2017-09-29 11:42:16.555486	\N	Decidim::User	335	0	2	HdiY5VeSh77EQz_RyDam	2017-09-29 11:42:16.555486	2017-09-22 14:00:32.299894	\N	Priscilla Cassez	\N	\N	t	\N	\N	f	f	{}	t	priscilla_cassez	\N	\N
342	marie-claire.eustache@debat-cndp.fr		\N	\N	\N	0	\N	\N	\N	\N	2017-09-15 08:50:26.649902	2018-02-21 22:16:13.457436	6239fc4c047e0a80a4d0a02838a9238c75b52f1ab824b30320f46d55c59a3d53	2017-09-15 08:50:26.649241	2017-09-15 08:50:26.649241	\N	\N	Decidim::User	335	0	2	\N	\N	\N	\N	Marie-Claire Eustache	\N	\N	f	\N	\N	f	f	{}	f	marie-claire_eustach	\N	\N
343	virgile+2@opensourcepolitics.eu	$2a$11$O9KnAcAMfZPQ75LYPWSOd.3kecntpshCVikClkLkzpQMpepmBx8Jy	\N	\N	\N	4	2017-09-17 14:53:41.397353	2017-09-17 14:50:34.976981	87.89.239.21	87.89.239.21	2017-09-15 11:55:24.077115	2018-02-21 22:16:13.459812	\N	\N	\N	\N	\N	\N	\N	0	2	m3WsSRWJLE1aZpe9Tqu-	2017-09-15 11:56:35.671704	2017-09-15 11:55:24.07729	\N	OSP	\N	\N	t	\N	\N	f	f	{}	f	osp	\N	\N
344	informatique.cndp@debeloppement-durable.gouv.fr		\N	\N	\N	0	\N	\N	\N	\N	2017-09-15 14:18:15.377574	2018-02-21 22:16:13.462238	52571609fe6e5ab79bdc167641ce36c57410ba3fc3863a1d043232896ba26b88	2017-09-15 14:18:15.376867	2017-09-15 14:18:15.376867	\N	\N	Decidim::User	335	0	2	\N	\N	\N	\N	J-Yves Creusot	\N	\N	f	\N	\N	f	f	{}	f	j-yves_creusot	\N	\N
345	informatique.cndp@developpement-durable.gouv.fr		\N	\N	\N	0	\N	\N	\N	\N	2017-09-15 14:20:03.310682	2018-02-21 22:16:13.465546	30b97e64b4070c07b6e3e5b755812a3cd9a18ed0be950eb5293620980ef72ba7	2017-09-15 14:20:03.308996	2017-09-15 14:20:03.308996	\N	\N	Decidim::User	335	0	2	\N	\N	\N	\N	J-Yves Creusot	\N	\N	f	\N	\N	f	f	{}	f	j-yves_creusot_2	\N	\N
346	jimscheers@gmail.com	$2a$11$MEWDFyDioGKAEv0kMou9vuLB3aM4pWYul6hz5Nz.0z.IC1nl7INH6	\N	\N	\N	7	2017-10-18 10:44:12.551055	2017-10-17 10:09:46.831813	195.101.4.101	195.101.4.101	2017-09-16 09:53:27.790802	2018-02-21 22:16:13.467883	\N	\N	\N	\N	\N	\N	\N	0	2	4rJcSJWrRxxx9wnBAqte	2017-09-16 09:53:41.264044	2017-09-16 09:53:27.791063	\N	JS_CPDP	\N	\N	t	\N	\N	f	f	{}	f	js_cpdp	\N	\N
347	valentin.chaput@gmail.com	$2a$11$kX5lLwqEB/Pr1lYV/g2kD.ovWNNFDEkNtXGiy2iFT2ez7i9SwwHmG	\N	\N	\N	1	2017-09-17 15:18:05.54362	2017-09-17 15:18:05.54362	80.12.27.84	80.12.27.84	2017-09-17 15:16:00.131138	2018-02-21 22:16:13.471028	\N	\N	\N	\N	\N	\N	\N	0	2	mUsMTpXwhHHPZYST6c1i	2017-09-17 15:16:24.752427	2017-09-17 15:16:00.131356	\N	Valentin Chaput	\N	\N	t	\N	\N	f	f	{}	f	valentin_chaput_2	\N	\N
348	barthelemyhugo@gmail.com	$2a$11$069Wi4lbTnRAHD8m25741OTcQAHuIiXgJFcXq5PFNvn5hIlgB2V3e	\N	\N	\N	1	2017-09-17 15:35:30.371826	2017-09-17 15:35:30.371826	82.251.41.53	82.251.41.53	2017-09-17 15:34:48.185341	2018-02-21 22:16:13.473537	\N	\N	\N	\N	\N	\N	\N	0	2	saB1axWvypW_6_rGNg9i	2017-09-17 15:35:25.672295	2017-09-17 15:34:48.185467	\N	Hugo	\N	\N	t	\N	\N	f	f	{}	f	hugo	\N	\N
349	mariana.dovalo@gmail.com	$2a$11$lqx7dc8GXGz1y98NifqUdenrQOIFdu87MWOCaFy8X.C0yqAaX/m52	\N	\N	\N	1	2017-09-17 15:46:32.491932	2017-09-17 15:46:32.491932	87.89.239.21	87.89.239.21	2017-09-17 15:44:29.75054	2018-02-21 22:16:13.475831	\N	\N	\N	\N	\N	\N	\N	0	2	Vz36PqMt1s4A2FXHC6zA	2017-09-17 15:45:09.092191	2017-09-17 15:44:29.750854	\N	mariana	\N	\N	f	\N	\N	f	f	{}	f	mariana	\N	\N
350	virgile+5@opensourcepolitics.eu	$2a$11$OUsuiaZaOpccSDFy44fsZ.lxXsKrq4BzCDwhPubs/YboiLr4OPMoy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-18 06:01:53.695933	2018-02-21 22:16:13.478348	\N	\N	\N	\N	\N	\N	\N	0	2	3msoSoDyArRFJd3ZJ-Cs	\N	2017-09-18 06:01:53.696168	\N	Vir 10	\N	\N	t	\N	\N	f	f	{}	f	vir_10	\N	\N
351	olivier.belmontant@gmail.com	$2a$11$M4JYPN6xJLH2RmNV.35QXuHhIDKQHRRldoIdDPiIcFwqEs1AfEGq6	\N	\N	\N	2	2017-09-20 07:28:06.111785	2017-09-18 06:05:02.186488	85.169.92.197	217.128.46.201	2017-09-18 06:04:24.533445	2018-02-21 22:16:13.481008	\N	\N	\N	\N	\N	\N	\N	0	2	K91PjeQkZz1LS4uozoJ3	2017-09-18 06:04:53.361665	2017-09-18 06:04:24.533634	\N	Olivier Belmontant	\N	\N	f	\N	\N	f	f	{}	f	olivier_belmontant	\N	\N
352	virgile+8@opensourcepolitics.eu	$2a$11$UzZLIlMm7YkZSN4Vs9xB7.gPlcWFUeTpC575PBAenxGaMg892gKJy	\N	\N	\N	0	\N	\N	\N	\N	2017-09-18 09:00:33.714096	2018-02-21 22:16:13.48337	\N	\N	\N	\N	\N	\N	\N	0	2	x4oyysUrzEDhGjNdq2EU	\N	2017-09-18 09:00:33.714309	\N	Vir gile	\N	\N	t	\N	\N	f	f	{}	f	vir_gile	\N	\N
353	a.fatine.1992@gmail.com	$2a$11$snjQ9nouKntQd3CC0J1CIunYTf5CoXIp.l4kORKA8b/RCgcU67Qum	\N	\N	\N	2	2017-09-25 10:36:51.388341	2017-09-20 16:04:08.748972	195.101.4.101	195.101.4.101	2017-09-20 16:02:19.761835	2018-02-21 22:16:13.485748	\N	\N	\N	\N	\N	\N	\N	0	2	YNnSZ2RSsi_Hf4Rz4t4Q	2017-09-20 16:03:26.647413	2017-09-20 16:02:19.762004	\N	Fatine AHMADOUCHI	\N	\N	t	\N	\N	f	f	{}	f	fatine_ahmadouchi	\N	\N
354	guy.grenier@ocpm.qc.ca	$2a$11$oIeNuH6WQwKM5U/fNlKN.OC.0fRYfmGst/IbB7vSod7vwT4UAa5/m	\N	\N	2017-09-21 14:15:25.237578	2	2017-09-27 14:26:15.390518	2017-09-21 14:15:25.246026	207.134.192.146	207.134.192.146	2017-09-21 13:44:09.051059	2018-02-21 22:16:13.488199	\N	\N	\N	\N	\N	\N	\N	0	2	FybypMfsBbBBDsEcssEG	2017-09-21 14:15:08.242085	2017-09-21 13:44:09.051232	\N	Guy Grenier	\N	\N	t	\N	\N	f	f	{}	f	guy_grenier	\N	\N
355	virgile+3@opensourcepolitics.eu	$2a$11$O7E9wiL4SH8moUHguWTsGehFcs0knfehIsMmOC1Sc2vSSdw0rE9l2	\N	\N	\N	1	2017-09-21 13:57:34.728588	2017-09-21 13:57:34.728588	193.248.44.109	193.248.44.109	2017-09-21 13:56:08.487704	2018-02-21 22:16:13.490399	\N	2017-09-21 13:56:08.486833	2017-09-21 13:56:08.486833	2017-09-21 13:57:34.710602	\N	Decidim::User	331	0	2	\N	2017-09-21 13:57:34.710602	\N	\N	Virgile Test	\N	\N	f	\N	\N	f	f	{}	f	virgile_test	\N	\N
356	virgile+9@opensourcepolitics.eu		\N	\N	\N	0	\N	\N	\N	\N	2017-09-21 15:35:26.139907	2018-02-21 22:16:13.492625	8c16237bf6a90c45ba51205de151a6ff157870ed6a8f14dbd2fa8a96510770c0	2017-09-21 15:35:26.138587	2017-09-21 15:35:26.138587	\N	\N	Decidim::User	331	0	2	\N	\N	\N	\N	Virgile Test 2	\N	\N	f	\N	\N	f	f	{user_manager}	f	virgile_test_2	\N	\N
357	gregmiret@gmail.com	$2a$11$95AQS1bIjgjXqY6fFGxZh.mILir0Z4Q3Bt3r6oX1j.zx2kNPkSAbe	\N	\N	2017-11-17 19:40:13.250634	3	2017-11-17 19:40:13.258718	2017-11-17 19:39:45.000172	78.192.166.167	78.192.166.167	2017-09-21 17:41:07.540296	2018-02-21 22:16:13.494963	\N	\N	\N	\N	\N	\N	\N	0	2	zazY6z2yTs118ub3Hssr	2017-09-21 17:59:50.22042	2017-09-21 17:41:07.540499	\N	Gregoire MIRET	\N	\N	f	\N	\N	f	f	{}	f	gregoire_miret	\N	\N
358	mako@osp.cat	$2a$11$yNHZpeW1DcMMWfhuB8eW.uZNmZtA99BJiEKbuMOeYMImSRGUaAkVe	\N	\N	2017-11-24 11:23:35.369868	29	2018-02-05 08:05:03.282414	2018-02-02 06:48:48.37096	81.66.244.181	87.89.239.21	2017-09-22 12:06:42.968877	2018-02-21 22:16:13.498212	\N	2017-09-22 12:06:42.968284	2017-09-22 12:06:42.968284	2017-09-22 12:25:18.41144	\N	Decidim::User	331	0	3	\N	2017-09-22 12:25:18.41144	\N	\N	mako	\N	\N	t	\N	\N	t	f	{}	t	mako_2	\N	\N
359	virgile@opensourcepolitics.eu	$2a$11$L/bQQOuHnmP/K.cDkD3JTOBYLzaoZSGUVUDY66H9ZQllyu4NIJZF.	\N	\N	\N	3	2017-10-12 08:11:51.854087	2017-10-06 08:56:24.012969	91.200.204.227	91.200.204.227	2017-09-22 12:54:12.174284	2018-02-21 22:16:13.500399	\N	2017-09-22 12:54:12.172966	2017-09-22 12:54:12.172966	2017-09-22 13:00:08.470995	\N	Decidim::User	358	0	3	\N	2017-09-22 13:00:08.470995	\N	\N	Test 2	\N	\N	f	\N	\N	t	f	{}	f	test_2	\N	\N
360	virgile+1@opensourcepolitics.eu	$2a$11$9Gm5STJCckbDjvQZ/KY9WeHtNsBPPWlKKsDcZrrKM.wdgnwp2Soz.	\N	\N	\N	2	2017-09-22 14:29:28.781535	2017-09-22 12:59:03.20096	185.113.160.52	185.113.160.52	2017-09-22 12:54:39.876364	2018-02-21 22:16:13.502668	\N	2017-09-22 12:54:39.875509	2017-09-22 12:54:39.875509	2017-09-22 12:59:03.18071	\N	Decidim::User	358	0	3	\N	2017-09-22 12:59:03.18071	\N	\N	Test rep	\N	\N	f	\N	\N	f	f	{user_manager}	f	test_rep	\N	\N
361	virgile+10@opensourcepolitics.eu	$2a$11$vcPsTiMWNRxANIckdGqItuBzqjY62RELQjjSLD5yrrF9B0NR6SULe	\N	\N	\N	1	2017-09-22 13:19:02.616512	2017-09-22 13:19:02.616512	185.113.160.52	185.113.160.52	2017-09-22 13:17:57.320989	2018-02-21 22:16:13.504875	\N	2017-09-22 13:17:57.31979	2017-09-22 13:17:57.31979	2017-09-22 13:19:02.60496	\N	Decidim::User	355	0	2	\N	2017-09-22 13:19:02.60496	\N	\N	Virgile Test 3	\N	\N	f	\N	\N	f	f	{}	f	virgile_test_3	\N	\N
362	virgile+12@opensourcepolitics.eu	$2a$11$BXfsmDss9RGylN2VG9CCXusDJivYWmcEEOUuzTXhyGAHuS5DIefYq	\N	\N	\N	1	2017-09-22 13:22:59.259017	2017-09-22 13:22:59.259017	185.113.160.52	185.113.160.52	2017-09-22 13:22:17.705093	2018-02-21 22:16:13.507113	\N	\N	\N	\N	\N	\N	\N	0	2	R34ynGxm1FWkdWn_EUG_	2017-09-22 13:22:46.239287	2017-09-22 13:22:17.705267	\N	Virgile D	\N	\N	t	\N	\N	f	f	{}	f	virgile_d	\N	\N
363	moustachu@gmail.com		\N	\N	\N	0	\N	\N	\N	\N	2017-09-22 13:38:05.855323	2018-02-21 22:16:13.509304	680264ec21f41f393b5c7b43cb8961ea4f56a03cf32fc3cefec462fda29656e6	2017-09-22 13:38:05.854357	2017-09-22 13:38:05.854357	\N	\N	Decidim::User	330	0	2	\N	\N	\N	\N	moustachu	\N	\N	f	\N	\N	f	f	{}	f	moustachu	\N	\N
364	virgile+3@opensourcepolitics.eu	$2a$11$DQ3rB6KLq82h79Pj01.7hOzpahgoEUk7T5luzwwVMhVfq3FAHmtfO	\N	\N	\N	1	2017-09-22 14:36:22.530159	2017-09-22 14:36:22.530159	185.113.160.52	185.113.160.52	2017-09-22 14:35:34.962318	2018-02-21 22:16:13.511521	\N	2017-09-22 14:35:34.961315	2017-09-22 14:35:34.961315	2017-09-22 14:36:22.505348	\N	Decidim::User	358	0	3	\N	2017-09-22 14:36:22.505348	\N	\N	Vir REP	\N	\N	f	\N	\N	f	f	{user_manager}	f	vir_rep	\N	\N
365	virgile+7@opensourcepolitics.eu	$2a$11$Jf7OQPP.BrRyO5JSVcHhLOSOXA9GdWTu2KfXVv4kNnDREO90GYCfW	\N	\N	\N	3	2017-09-22 14:44:29.007096	2017-09-22 14:39:47.864307	185.113.160.52	185.113.160.52	2017-09-22 14:37:12.195919	2018-02-21 22:16:13.513869	\N	\N	\N	\N	\N	\N	\N	0	3	FoSFbzUJyEX1iUrsQkA6	2017-09-22 14:37:30.682698	2017-09-22 14:37:12.196065	\N	Vir TEST 2	\N	\N	t	\N	\N	f	f	{user_manager}	f	vir_test_2	\N	\N
366	gvermeulen@club.fr	$2a$11$/O.KLVwij/.z6U6rf3Rfxe4PDc7GPTqWODY.dit9eOuPQB5YBoyem	\N	\N	2017-09-23 10:22:21.781093	1	2017-09-23 10:22:21.790892	2017-09-23 10:22:21.790892	84.98.234.111	84.98.234.111	2017-09-23 10:15:19.91287	2018-02-21 22:16:13.516092	\N	\N	\N	\N	\N	\N	\N	0	2	bGSEf_L6DeEZDcfZ8fVp	2017-09-23 10:21:50.697624	2017-09-23 10:15:19.913008	\N	DELAPLAGE 	\N	\N	t	\N	\N	f	f	{}	f	delaplage	\N	\N
367	christopheleikine@gmail.com	$2a$11$d9abviXB5IeGXLbQXy9h2.EWsx6aMjpMfCC1w4OkWVmRVEvcjrFT.	\N	\N	2017-09-24 18:35:06.039239	6	2017-09-27 16:24:00.559699	2017-09-27 11:48:28.978248	195.101.4.101	195.101.4.101	2017-09-24 18:21:42.272805	2018-02-21 22:16:13.518356	\N	\N	\N	\N	\N	\N	\N	0	2	3ECT_L1nCf7kKQWsnvB_	2017-09-24 18:34:53.409202	2017-09-24 18:21:42.272944	\N	Christophe Leikine	\N	\N	f	\N	\N	f	f	{}	f	christophe_leikine	\N	\N
368	cdl59820@laposte.net	$2a$11$y9txNjLgUpG8tvNV2xkL6.BEsJ42jk.C83ramevZ416zRVCzO4ZAe	\N	\N	\N	2	2017-11-14 13:43:49.97563	2017-09-25 09:13:43.686386	109.24.182.71	109.24.182.71	2017-09-25 09:11:13.079677	2018-02-21 22:16:13.520877	\N	\N	\N	\N	\N	\N	\N	0	2	fSNTJJBDVrGX3zTJmhzd	2017-09-25 09:13:20.541022	2017-09-25 09:11:13.07988	\N	abclocal	\N	\N	f	\N	\N	f	f	{}	f	abclocal	\N	\N
369	jcreusot@free.fr	$2a$11$NTvJyRXaUNtvB9OYVkj7IeuphX4udQkXPFAgM2mR6WNk7GKXdpkVu	\N	\N	\N	1	2017-09-25 12:57:20.219542	2017-09-25 12:57:20.219542	109.2.139.6	109.2.139.6	2017-09-25 12:56:41.661909	2018-02-21 22:16:13.523544	\N	\N	\N	\N	\N	\N	\N	0	2	FEVzvxfqPwX2LihDxhE9	2017-09-25 12:57:01.984798	2017-09-25 12:56:41.662067	\N	JY Creusot	\N	\N	f	\N	\N	f	f	{}	f	jy_creusot	\N	\N
370	jyc01@debatpublic.ovh	$2a$11$VbD7s/Zpxfkos50f0pohyOrKyFtpfNPzHmIsUsAJVKgwnb.RbCPfO	\N	\N	\N	1	2017-09-25 13:05:39.568375	2017-09-25 13:05:39.568375	185.24.184.194	185.24.184.194	2017-09-25 12:59:35.098627	2018-02-21 22:16:13.526672	\N	\N	\N	\N	\N	\N	\N	0	2	ohgxPrT5LfMd28Vrwade	2017-09-25 13:02:34.120542	2017-09-25 12:59:35.098871	\N	JY Creusot	\N	\N	t	\N	\N	f	f	{}	f	jy_creusot_2	\N	\N
371	jean-yves.creusot@debatpublic.fr	$2a$11$RAhHkSmJO3Yy1oPEcaVBuubKp8W6CzkxGcby7UHV5Cu2fj5FUyuRu	\N	\N	\N	7	2017-11-13 07:51:37.549248	2017-11-10 08:43:07.782023	185.24.184.194	185.24.184.194	2017-09-25 16:33:29.241409	2018-02-21 22:16:13.529954	\N	2017-09-25 16:33:29.240417	2017-09-25 16:33:29.240417	2017-09-26 06:46:22.711058	\N	Decidim::User	358	0	3	\N	2017-09-26 06:46:22.711058	\N	\N	Jean-Yves Creusot	\N	\N	f	\N	\N	t	f	{}	f	jean-yves_creusot_2	\N	\N
372	patrickboidin@yahoo.fr	$2a$11$4xg21nsfwqxfn94UFTX59eDItQ1kVxOPz9Otdw0B5g8mrDcGoUkkS	\N	\N	\N	3	2017-12-22 17:51:11.783747	2017-11-05 20:42:18.872982	82.247.204.3	82.247.204.3	2017-09-26 13:44:17.304099	2018-02-21 22:16:13.532419	\N	\N	\N	\N	\N	\N	\N	0	2	ajLXHR4LoYUxGkRZW81z	2017-09-26 13:48:11.609525	2017-09-26 13:44:17.304318	\N	P.BOIDIN	\N	\N	t	\N	\N	f	f	{}	f	p_boidin	\N	\N
373	lucasguy59@gmail.com	$2a$11$08GtvKRuqMg45XsxjbUWmOHEyddLwBcv2pLB.C5IYFBHUD0b83lEy	\N	\N	\N	1	2017-09-28 06:35:48.044803	2017-09-28 06:35:48.044803	81.254.49.211	81.254.49.211	2017-09-28 06:30:06.596938	2018-02-21 22:16:13.534633	\N	\N	\N	\N	\N	\N	\N	0	2	vcmEdnF8-Q9fK85RgXwx	2017-09-28 06:35:09.509335	2017-09-28 06:30:06.597178	\N	lucas	\N	\N	t	\N	\N	f	f	{}	f	lucas	\N	\N
374	didier.bykoff@hotmail.fr	$2a$11$CM26tR6Esug/ZFAZE5ypyucyKGcHWr5ZWAHiRLnzZFTr2gWyXwjxi	\N	\N	2017-10-02 10:25:05.726074	6	2017-10-13 10:03:20.333844	2017-10-04 14:51:15.271311	78.220.177.2	78.220.177.2	2017-09-29 15:20:52.444967	2018-02-21 22:16:13.536884	\N	\N	\N	\N	\N	\N	\N	0	2	5muMki2z14wfhMeMqSmH	2017-09-29 15:34:07.905475	2017-09-29 15:20:52.445139	\N	pascal	\N	\N	t	\N	\N	f	f	{}	f	pascal	\N	\N
375	portdedunkerque@debat-cndp.fr	$2a$11$cMaywUzJxe8JRrZMT67L0.3lTOOp0tXHYvQtn6Tz.A1kXQKlKphhW	\N	\N	\N	29	2017-12-22 18:35:17.289378	2017-12-19 10:36:23.81077	77.203.140.172	195.101.4.101	2017-10-02 14:28:07.483198	2018-02-21 22:16:13.53914	\N	\N	\N	\N	\N	\N	\N	0	2	SeUNsqP_cSvUZzGqybL6	2017-10-02 14:39:09.474071	2017-10-02 14:28:07.48334	\N	Commission particulière du débat public	\N	logo750x385.png	f	\N	\N	f	f	{}	t	commission_particuli	\N	\N
376	francois.rougerie@alternative2.net	$2a$11$9k0wP11DmFIy30BXoRRgB.EBDDQ99AWwUoAwc0l25WREktFkmNELi	\N	\N	\N	10	2018-02-18 11:19:34.371621	2018-02-18 11:06:09.302303	90.92.215.211	90.92.215.211	2017-10-02 15:53:38.774429	2018-02-21 22:16:13.541371	\N	\N	\N	\N	\N	\N	\N	0	2	jJ3zX9Yry_yLSdFGxtup	2017-10-02 17:33:42.490909	2017-10-02 15:53:38.774565	\N	Francois ROUGERIE	\N	\N	f	\N	\N	t	f	{}	f	francois_rougerie	\N	\N
377	cris.a@me.com	$2a$11$RdLtOFHPlv0zD27AO1l5teeAu1lCuao/bbirWYVJmaygHZKH8wp8e	\N	\N	\N	0	\N	\N	\N	\N	2017-10-03 14:27:40.729711	2018-02-21 22:16:13.543627	\N	\N	\N	\N	\N	\N	\N	0	2	i_1YaKwn-Gmk7sN13pGQ	\N	2017-10-03 14:27:40.729832	\N	Christine	\N	\N	t	\N	\N	f	f	{}	f	christine	\N	\N
378	vilain.xavier@orange.fr	$2a$11$Ah2nW2eJjAnYx9G1eKW1V.WPM4iBuJYZOhWro3Rz5At8NI9/h9Uxu	\N	\N	\N	5	2017-11-03 10:55:13.647372	2017-11-02 14:23:53.30977	93.174.144.105	93.174.144.114	2017-10-04 12:03:50.830368	2018-02-21 22:16:13.545822	\N	\N	\N	\N	\N	\N	\N	0	2	pUbsn1_kzAemCB8NSt6o	2017-10-04 12:06:17.322098	2017-10-04 12:03:50.830484	\N	Xavier VILAIN	\N	\N	f	\N	\N	f	f	{}	f	xavier_vilain	\N	\N
379	jyc02@debatpublic.ovh	$2a$11$W3XuGbWdJ5T4bw7ml76FqOgrqMFOZyAvztUUo/u714hNhbe7okf.y	\N	\N	\N	0	\N	\N	\N	\N	2017-10-04 14:32:15.017333	2018-02-21 22:16:13.548318	\N	\N	\N	\N	\N	\N	\N	0	2	DxW7bbn-Zea6VmdMSRmZ	\N	2017-10-04 14:32:15.017449	\N	jyc	\N	\N	f	\N	\N	f	f	{}	f	jyc	\N	\N
380	inmame4@gmail.com	$2a$11$RCNlQos/m69YNtk7A0PZ1uy3iz8sdQAEPS4FyOKKvgsRHGZm0j.se	\N	\N	\N	1	2017-10-05 19:18:58.388853	2017-10-05 19:18:58.388853	79.156.3.240	79.156.3.240	2017-10-05 19:18:00.569464	2018-02-21 22:16:13.55069	\N	\N	\N	\N	\N	\N	\N	0	2	wim-_P9oz-UQCwqwa6Ty	2017-10-05 19:18:43.338212	2017-10-05 19:18:00.569601	\N	Ada	\N	\N	t	\N	\N	f	f	{}	f	ada	\N	\N
381	virgile+4@opensourcepolitics.eu		\N	\N	\N	0	\N	\N	\N	\N	2017-10-06 08:57:33.118981	2018-02-21 22:16:13.553176	33b79bdc8aecda496c8144473fad78241247f6065d65c7e393d241b9ba60cf3f	2017-10-06 08:57:33.1184	2017-10-06 08:57:33.1184	\N	\N	Decidim::User	358	0	3	\N	\N	\N	\N	Vir OSP 4	\N	\N	f	\N	\N	f	f	{}	f	vir_osp_4	\N	\N
382	delegue@edess.org	$2a$11$/sTOyKkpDPt0TVI9uT4VWOzt4cy0HPV.1A9Qpbcaia9bSAr2mQXAC	\N	\N	\N	2	2017-10-14 10:17:03.037817	2017-10-11 09:42:03.648519	86.247.236.64	86.247.236.64	2017-10-11 09:29:46.843211	2018-02-21 22:16:13.555646	\N	\N	\N	\N	\N	\N	\N	0	3	ocAWz4xMgFUXvt-A6_yP	2017-10-11 09:41:49.181676	2017-10-11 09:29:46.84344	\N	délégué général EDESS	\N	\N	f	\N	\N	f	f	{}	f	delegue_general_edes	\N	\N
383	francois.rougerie@alternative2.net	$2a$11$zD/dua7crV5QY4Oz8yU5ye5tzzPuyx9dGbc8Ttd9GjQ3/.bQlaMqm	\N	\N	\N	4	2017-10-15 11:19:00.266898	2017-10-15 09:59:54.706728	86.247.236.64	86.247.236.64	2017-10-11 09:52:10.047147	2018-02-21 22:16:13.558894	\N	\N	\N	\N	\N	\N	\N	0	3	D_pF7MUaZbacZ8CE8pVv	2017-10-11 09:54:26.301604	2017-10-11 09:52:10.047289	\N	François ROUGERIE	\N	\N	f	\N	\N	t	f	{}	f	francois_rougerie_2	\N	\N
384	brunodjango@laposte.net	$2a$11$2w4.fBWzjkSMLX.NY/MU6.DV8XOdpQdGM2Z/6dtdlsBKAWut.Ljeu	\N	\N	\N	1	2017-10-12 11:24:50.627231	2017-10-12 11:24:50.627231	109.24.182.71	109.24.182.71	2017-10-12 11:21:18.164349	2018-02-21 22:16:13.561367	\N	\N	\N	\N	\N	\N	\N	0	2	mvsvsMQxp2yDfDGj4LyZ	2017-10-12 11:24:42.019997	2017-10-12 11:21:18.164581	\N	caudal	\N	\N	f	\N	\N	f	f	{}	f	caudal	\N	\N
385	danae.moyano-rodriguez@debatpublic.fr	$2a$11$vX.FH1Jpl9sUQ1dn.HF79OyrPJr.Jgm0F/qnWWYXvdkVdWdPzWSdy	\N	\N	\N	2	2017-10-16 16:09:10.800914	2017-10-13 14:27:33.513984	80.12.43.189	185.24.184.194	2017-10-13 07:48:11.871745	2018-02-21 22:16:13.564023	\N	2017-10-13 07:48:11.870241	2017-10-13 07:48:11.870241	2017-10-13 14:27:33.476376	\N	Decidim::User	371	0	3	\N	2017-10-13 14:27:33.476376	\N	\N	Danaé Moyano-Rodriguez	\N	\N	f	\N	\N	t	f	{}	f	danae_moyano-rodrigu	\N	\N
386	atcollet@wanadoo.fr	$2a$11$D8n70Rk6ftle8fh6G4gnAOiffn8yRC2q2PpVOwfQuKc.zMfiyg6U6	\N	\N	2017-10-13 16:12:18.666839	1	2017-10-13 16:12:18.672338	2017-10-13 16:12:18.672338	176.152.191.117	176.152.191.117	2017-10-13 16:09:39.424817	2018-02-21 22:16:13.566412	\N	\N	\N	\N	\N	\N	\N	0	2	FQw41Y_JmsUGzizGiuus	2017-10-13 16:12:09.790589	2017-10-13 16:09:39.424969	\N	COLLET	\N	\N	t	\N	\N	f	f	{}	f	collet	\N	\N
387	contact@alternative2.net	$2a$11$bW.4PodzZW4V9x7fhKJC..i8l6EJgWsHzKHLYGieETVnELYlcHlxu	\N	\N	\N	1	2017-10-14 10:25:58.67959	2017-10-14 10:25:58.67959	86.247.236.64	86.247.236.64	2017-10-14 10:23:07.242769	2018-02-21 22:16:13.568692	\N	\N	\N	\N	\N	\N	\N	0	3	s5ajVG3GNZ4Aa7QcBSgm	2017-10-14 10:25:47.873844	2017-10-14 10:23:07.24289	\N	Alternative2	\N	\N	f	\N	\N	f	f	{}	f	alternative2	\N	\N
388	claire.lm@gmx.com	$2a$11$zKBKhPdZl265C8TFt9Bp4ORgrDLaHnKUEITgKcpcZSQJe5m8Wc1T2	\N	\N	\N	1	2017-10-18 07:48:04.509875	2017-10-18 07:48:04.509875	185.24.184.194	185.24.184.194	2017-10-18 07:46:50.471668	2018-02-21 22:16:13.570861	\N	\N	\N	\N	\N	\N	\N	0	2	Na4rzuCRpLSavXh8BuRq	2017-10-18 07:48:02.108111	2017-10-18 07:46:50.471815	\N	Le Meur	\N	\N	f	\N	\N	f	f	{}	f	le_meur	\N	\N
389	alben59dk@gmail.com	$2a$11$akPwy2cX9my/jdvuNEskvOQMeihkofOfnqcj4W9DfvSMBlrIwp0I.	\N	\N	2017-11-01 15:19:22.624707	4	2017-12-22 10:49:46.744619	2017-11-21 07:23:45.060793	90.45.191.252	90.110.180.99	2017-11-01 15:18:43.901803	2018-02-21 22:16:13.573108	\N	\N	\N	\N	\N	\N	\N	0	2	dGEsEvQAaYeZYfQ5N6VF	2017-11-01 15:19:16.776757	2017-11-01 15:18:43.902002	\N	Alex	\N	\N	t	\N	\N	f	f	{}	t	alex	\N	\N
390	virgile+20@opensourcepolitics.eu	$2a$11$0OSxfzx/tQ3W/Gpgu2V5/.kbTJ70nYfYUqSbc6w2nc2pbxod1KvMK	\N	\N	\N	1	2017-11-02 16:00:00.041194	2017-11-02 16:00:00.041194	91.200.204.227	91.200.204.227	2017-11-02 15:59:21.313552	2018-02-21 22:16:13.575326	\N	\N	\N	\N	\N	\N	\N	0	2	s7gzQs8rsQYLZMnc3jzY	2017-11-02 15:59:40.336719	2017-11-02 15:59:21.313695	\N	Vir test	\N	\N	f	\N	\N	f	f	{}	f	vir_test	\N	\N
391	frhars@gmail.com	$2a$11$f83AokmvfQ0YypNpHzXAl./CvzQw4oulspmafwJQFnEXQWArsf2VO	\N	\N	\N	1	2017-11-04 14:48:02.465309	2017-11-04 14:48:02.465309	80.12.33.2	80.12.33.2	2017-11-04 14:44:33.553833	2018-02-21 22:16:13.577646	\N	\N	\N	\N	\N	\N	\N	0	2	sfgjoBJzpFCXrT3rG_iB	2017-11-04 14:46:35.95076	2017-11-04 14:44:33.554004	\N	François h	\N	\N	f	\N	\N	f	f	{}	f	francois_h	\N	\N
392	priscillaclio@gmail.com	$2a$11$VqbNVlikzIMaMIisPc62POCZIQs6s0A/4aHGuSNHHryDTENFFdGPi	\N	\N	\N	1	2017-11-04 18:00:04.117253	2017-11-04 18:00:04.117253	79.89.51.140	79.89.51.140	2017-11-04 17:59:31.631664	2018-02-21 22:16:13.579955	\N	\N	\N	\N	\N	\N	\N	0	2	Xi_ztCbGsBifhnWTx1Nq	2017-11-04 17:59:46.670517	2017-11-04 17:59:31.631781	\N	Clio	\N	\N	f	\N	\N	f	f	{}	f	clio	\N	\N
393	michel.heluwaert@gmail.com	$2a$11$CedMYyrKV.Oqxxj7nLHF4.jilGL0Iuycg8ajnBxv80BME6FwF4.O2	\N	\N	\N	3	2017-11-15 08:45:55.994218	2017-11-10 09:47:52.160771	82.251.230.24	82.251.230.24	2017-11-05 08:03:02.377766	2018-02-21 22:16:13.582288	\N	\N	\N	\N	\N	\N	\N	0	2	Tw-cfhUqVQ-Hzya-F-1D	2017-11-05 08:28:39.011254	2017-11-05 08:03:02.37792	\N	Héluwaert	\N	\N	t	\N	\N	f	f	{}	f	heluwaert	\N	\N
394	president@umcdk.com	$2a$11$m5Rho5f7reHBmh573xTB9u4sG/PKF.UqdALVNG1vymzz3CFkUn392	\N	\N	\N	1	2017-11-05 11:23:44.518668	2017-11-05 11:23:44.518668	82.241.165.128	82.241.165.128	2017-11-05 11:20:17.137185	2018-02-21 22:16:13.584731	\N	\N	\N	\N	\N	\N	\N	0	2	4vEEza3_9uWQvexxSFve	2017-11-05 11:23:10.536001	2017-11-05 11:20:17.137301	\N	LE GALL	\N	\N	t	\N	\N	f	f	{}	f	le_gall	\N	\N
395	pffasquelle@gmail.com	$2a$11$k0bnqQLnO9zH0kog7uspFuKv5/XE3lAbpj23ya.ux5.hh2iBFKhY.	\N	\N	\N	0	\N	\N	\N	\N	2017-11-05 18:17:28.420804	2018-02-21 22:16:13.587057	\N	\N	\N	\N	\N	\N	\N	0	2	a55qsZ_9ycU88TvwoBkg	\N	2017-11-05 18:17:28.420949	\N	FASQUELLE	\N	\N	t	\N	\N	f	f	{}	f	fasquelle	\N	\N
396	patrick.gheerardyn@medef-cote-opale.com	$2a$11$U172dDDcEWlcGvYKR5iTYupTIf29SuanNeZ1Oyb.d1cQ5m6y2Xzmi	\N	\N	\N	5	2017-12-27 13:37:19.642695	2017-12-09 17:20:48.56082	164.177.110.51	90.1.218.39	2017-11-05 19:48:34.451313	2018-02-21 22:16:13.589272	\N	\N	\N	\N	\N	\N	\N	0	2	2uxciPsrk-AhW2Lt-DxD	2017-11-06 05:46:13.520755	2017-11-05 19:48:34.451442	\N	Patrick Gheerardyn	\N	\N	t	\N	\N	f	f	{}	f	patrick_gheerardyn	\N	\N
397	pierre.dubrunfaut@numericable.fr	$2a$11$nlmlV6EBdBfNP4zHGeEZQeneLGiBceqLCTLWNhoflbQq13IaITEJa	\N	\N	\N	10	2017-12-22 11:45:27.670812	2017-12-15 11:13:31.299087	81.49.97.107	81.49.97.107	2017-11-07 19:56:38.02325	2018-02-21 22:16:13.592216	\N	\N	\N	\N	\N	\N	\N	0	2	zZtyyrsuzJnqsG3NrbPV	2017-11-07 19:57:54.788111	2017-11-07 19:56:38.023462	\N	Pierrot	\N	\N	f	\N	\N	f	f	{}	f	pierrot	\N	\N
398	emr.dujardin@orange.fr	$2a$11$ODmLu2KA0mHb58aLFkhYfuyX6WsTT0FlAwMGYfmxeiG3S9e1gwo52	\N	\N	\N	0	\N	\N	\N	\N	2017-11-08 07:51:15.607168	2018-02-21 22:16:13.594829	\N	\N	\N	\N	\N	\N	\N	0	2	geE24sy7HboEX9SZAxsJ	2017-11-08 07:53:30.65527	2017-11-08 07:51:15.607421	\N	Eric DUJARDIN	\N	\N	f	\N	\N	f	f	{}	f	eric_dujardin	\N	\N
399	e.ofthegarden@gmail.com	$2a$11$RC68kLsu9AlELiKQsnz29OYpMkv3J2bCeqp7L1AZCjVTVdEXuviji	\N	\N	\N	2	2017-11-08 21:12:20.912484	2017-11-08 07:57:10.71669	90.110.180.228	2.5.237.17	2017-11-08 07:56:40.059517	2018-02-21 22:16:13.598299	\N	\N	\N	\N	\N	\N	\N	0	2	z3Yu1qY43WUX2SqnP869	2017-11-08 07:57:01.551984	2017-11-08 07:56:40.059631	\N	Eric DUJARDIN	\N	\N	f	\N	\N	f	f	{}	f	eric_dujardin_2	\N	\N
400	philippe.bourlitio@gmail.com	$2a$11$jCG2Emu/RYidKLOafJ538.ONrzH0tBpoCc50XKmXzoAq5.On1XP/i	\N	\N	\N	1	2017-11-13 07:56:37.83774	2017-11-13 07:56:37.83774	82.66.113.218	82.66.113.218	2017-11-08 09:09:17.697801	2018-02-21 22:16:13.600776	\N	2017-11-08 09:09:17.696382	2017-11-08 09:09:17.696382	2017-11-13 07:56:37.696721	\N	Decidim::User	371	0	3	grCxunb5nA1TctxACSSw	2017-11-13 07:56:37.696721	2017-11-11 11:02:27.224504	\N	Philippe	\N	\N	f	\N	\N	t	f	{user_manager}	f	philippe	\N	\N
401	david@eclectic-experience.net	$2a$11$kNyMbcZHjmfc6nyjpwNav.qiCO4sb04J7RXmV0iU3jElJExPMqJoK	\N	\N	\N	1	2017-11-10 17:16:30.709311	2017-11-10 17:16:30.709311	82.240.64.249	82.240.64.249	2017-11-08 09:09:47.798917	2018-02-21 22:16:13.603236	\N	2017-11-08 09:09:47.797818	2017-11-08 09:09:47.797818	2017-11-10 17:16:30.512619	\N	Decidim::User	371	0	3	\N	2017-11-10 17:16:30.512619	\N	\N	David Prothais	\N	\N	f	\N	\N	t	f	{user_manager}	f	david_prothais	\N	\N
402	sofia@eclectic-experience.net	$2a$11$zS/vRKhrSYk7FTM3BxsKMO22d5obangqwGtzJ1I8fV54lvTCMfci6	\N	\N	\N	4	2017-11-14 08:57:09.615138	2017-11-13 09:46:35.429724	82.240.239.133	82.240.239.133	2017-11-08 09:10:07.202992	2018-02-21 22:16:13.605598	\N	2017-11-08 09:10:07.202029	2017-11-08 09:10:07.202029	2017-11-10 16:43:36.190682	\N	Decidim::User	371	0	3	JFe_K3xnupcsBhXsRoGW	2017-11-10 16:43:36.190682	2017-11-08 10:01:44.037042	\N	Sofia Aliamet	\N	\N	f	\N	\N	t	f	{user_manager}	f	sofia_aliamet	\N	\N
403	franck.gonsse@cntpa.org	$2a$11$suiUBml8i/JvoSOd6.4.ze8WBd616U2qyHx/vaJlcUZo3NKy0JN.6	\N	\N	\N	1	2017-11-08 15:02:46.84186	2017-11-08 15:02:46.84186	90.7.110.100	90.7.110.100	2017-11-08 14:57:30.064998	2018-02-21 22:16:13.60804	\N	\N	\N	\N	\N	\N	\N	0	2	bZBnMmMo-B3EFigGKaGQ	2017-11-08 14:59:14.228462	2017-11-08 14:57:30.065449	\N	Franck GONSSE	\N	\N	f	\N	\N	f	f	{}	f	franck_gonsse	\N	\N
404	bogaert.jeremie@cnj-group.com	$2a$11$q27nZlrTtrG5w3FbH1Z7lu./03jML4o12hs9pZcWf/TuBlg1Mg79.	\N	\N	\N	1	2017-11-08 15:25:05.574375	2017-11-08 15:25:05.574375	194.51.92.25	194.51.92.25	2017-11-08 15:23:43.224772	2018-02-21 22:16:13.610435	\N	\N	\N	\N	\N	\N	\N	0	2	dX2KsnTaDJz1x-JQyJHS	2017-11-08 15:24:50.931169	2017-11-08 15:23:43.2249	\N	Bogaert Jérémie	\N	\N	t	\N	\N	f	f	{}	f	bogaert_jeremie	\N	\N
405	neche.berto@gmail.com	$2a$11$KypvJjZdOIofVcBgfk2WW.Det3dBqx4P1iJaitqVd2SV/C.n4bZlK	\N	\N	\N	0	\N	\N	\N	\N	2017-11-09 08:20:32.511357	2018-02-21 22:16:13.612897	\N	\N	\N	\N	\N	\N	\N	0	2	aoasMs681nZxpzWXDPXi	2017-11-09 08:22:38.49205	2017-11-09 08:20:32.511833	\N	BERTONECHE	\N	\N	f	\N	\N	f	f	{}	f	bertoneche	\N	\N
406	demo@osp.cat	$2a$11$Ch0YlXs9UTaGB/FYdiy8selX40SgHD.ZqP8arPpeYzClIhFFbBoKy	\N	\N	\N	2	2017-11-10 16:33:23.107913	2017-11-10 16:32:54.153066	81.66.244.181	81.66.244.181	2017-11-10 16:28:11.098576	2018-02-21 22:16:13.615262	\N	2017-11-10 16:28:11.09756	2017-11-10 16:28:11.09756	2017-11-10 16:32:54.145264	\N	Decidim::User	358	0	3	\N	2017-11-10 16:32:54.145264	\N	\N	demo@osp.cat	\N	\N	f	\N	\N	t	f	{}	f	demo_osp_cat	\N	\N
407	philippe.bourlitio@free.fr	$2a$11$3/WYZqgbkOyGV.mrPsTHveLWP4L4rsBU.Sgqs4hKqQvqRlVuqFLpO	\N	\N	\N	1	2017-11-11 10:44:23.83	2017-11-11 10:44:23.83	109.8.147.48	109.8.147.48	2017-11-11 10:42:39.881136	2018-02-21 22:16:13.618506	\N	\N	\N	\N	\N	\N	\N	0	3	pVTxvg7SPzdfXJdPVEtS	2017-11-11 10:43:32.558376	2017-11-11 10:42:39.881265	\N	Philippe	\N	\N	f	\N	\N	f	f	{}	f	philippe_2	\N	\N
408	marcel.pickaert@sfr.fr	$2a$11$Gj.N5HN4v2VL1BLeYpC7Du/ll1g3TqYMM2.GXtYrkCXc8OkeR.F1a	\N	\N	\N	1	2017-11-12 09:15:16.396358	2017-11-12 09:15:16.396358	109.10.165.208	109.10.165.208	2017-11-12 09:10:22.655015	2018-02-21 22:16:13.621188	\N	\N	\N	\N	\N	\N	\N	0	2	6YxGoqwNbNrU6y1NWWNd	2017-11-12 09:14:57.143906	2017-11-12 09:10:22.655138	\N	PICKAERT Marcel	\N	\N	t	\N	\N	f	f	{}	f	pickaert_marcel	\N	\N
410	r@roger.pro	$2a$11$7vG43vjQZwfP7/.XJyna9eB1JgFJ98N2dLlvBnYNoLH6fHBS3QMp2	\N	\N	\N	1	2017-11-12 19:57:08.857951	2017-11-12 19:57:08.857951	81.33.217.229	81.33.217.229	2017-11-12 19:56:35.185864	2018-02-21 22:16:13.623851	\N	\N	\N	\N	\N	\N	\N	0	2	CvPzVsDhQxPkRf8eikJ9	2017-11-12 19:56:49.464218	2017-11-12 19:56:35.186009	\N	Roger	\N	\N	t	\N	\N	f	f	{}	f	roger	\N	\N
411	plannoeye@icloud.com	$2a$11$cHA8wlOBNdstYlvGCLQt3.w13d1tO5WpYzbCDX9CjnAb5YP.DjKvO	\N	\N	\N	1	2017-11-15 09:14:54.693122	2017-11-15 09:14:54.693122	90.1.94.174	90.1.94.174	2017-11-15 09:12:55.911326	2018-02-21 22:16:13.626487	\N	\N	\N	\N	\N	\N	\N	0	2	mfgyoAnd1zQn3LorMvP-	2017-11-15 09:14:42.693099	2017-11-15 09:12:55.911523	\N	LANNOEYE PHILIPPE	\N	\N	f	\N	\N	f	f	{}	f	lannoeye_philippe	\N	\N
412	antoine.herlez@orange.fr	$2a$11$Xz5qMd5t0Puvu1B1alJsSeQaFMaoOpgwT3nD.fajQcwRNJ0ZF4rUu	\N	\N	\N	1	2017-11-15 10:12:59.505752	2017-11-15 10:12:59.505752	192.196.142.90	192.196.142.90	2017-11-15 10:10:35.879718	2018-02-21 22:16:13.628951	\N	\N	\N	\N	\N	\N	\N	0	2	W7Mmr6TY42U6wmurtxch	2017-11-15 10:12:00.643351	2017-11-15 10:10:35.880014	\N	Cartouche	\N	\N	t	\N	\N	f	f	{}	f	cartouche	\N	\N
413	laurent@colonval.fr	$2a$11$em/k3VRyTpHTd/TcOPOveeiOkg/Z.UBZDVpel9SoVCOFZFLbuDLOO	\N	\N	\N	3	2017-11-29 11:40:18.395609	2017-11-29 08:11:54.607704	78.230.238.103	78.230.238.103	2017-11-15 11:07:37.536624	2018-02-21 22:16:13.631292	\N	\N	\N	\N	\N	\N	\N	0	2	s2T364AGhYgBPL9qaJzs	2017-11-15 11:08:04.409154	2017-11-15 11:07:37.536981	\N	colonval 	\N	\N	t	\N	\N	f	f	{}	f	colonval	\N	\N
414	treut59279@gmail.com	$2a$11$gfk3Dn/IsyxScKrx2JA/huD0JsU4xCWLx3RKcWXAYKuuHM7flktM6	\N	\N	2017-11-15 14:49:43.748656	2	2017-11-15 15:38:22.176717	2017-11-15 14:49:43.755166	37.168.36.229	37.168.36.229	2017-11-15 14:47:34.924247	2018-02-21 22:16:13.633523	\N	\N	\N	\N	\N	\N	\N	0	2	uc2PAQ7Gqf9iJQcE1Gs4	2017-11-15 14:47:52.287938	2017-11-15 14:47:34.924432	\N	AnthonyT	\N	\N	f	\N	\N	f	f	{}	f	anthonyt	\N	\N
415	steph.evrard@yahoo.fr	$2a$11$/GTkdf.J9UwE3kKFfGFp/OksdOioqLIUh2.6JlRKupIzGXcL.tM5i	\N	\N	\N	4	2017-12-20 19:52:30.957589	2017-12-15 16:47:00.882407	78.230.236.109	78.230.236.109	2017-11-15 15:23:53.422757	2018-02-21 22:16:13.636046	\N	\N	\N	\N	\N	\N	\N	0	2	piMFNoCXQgFRPWCEKBVk	2017-11-15 15:25:25.828447	2017-11-15 15:23:53.422877	\N	Habitant de la Faisanderie à Loon-Plage	\N	\N	t	\N	\N	f	f	{}	t	habitant_de_la_faisa	\N	\N
416	bqueuniez@barra-snm.fr	$2a$11$qn.h2HlzgDqJ1FceE7i5Q.dphwQ0VMOnc5/gwkAXjvOrBx8voeE9O	\N	\N	\N	1	2017-11-16 14:17:50.50378	2017-11-16 14:17:50.50378	79.141.207.153	79.141.207.153	2017-11-16 14:15:54.209588	2018-02-21 22:16:13.638409	\N	\N	\N	\N	\N	\N	\N	0	2	Vk6xYW6iMqGYnCtpo7KU	2017-11-16 14:17:35.577482	2017-11-16 14:15:54.20976	\N	BQU	\N	\N	t	\N	\N	f	f	{}	f	bqu	\N	\N
417	philippegaudry@hotmail.fr	$2a$11$6e0flooTdDLH0oDq5/DpRub6NBA8kPWPrCcjyhr51qTPf2xx/4ol2	\N	\N	\N	0	\N	\N	\N	\N	2017-11-17 12:19:07.718878	2018-02-21 22:16:13.641385	\N	\N	\N	\N	\N	\N	\N	0	2	kC3ubG5XT6dX2wpy8Xzz	2017-11-17 12:20:47.288208	2017-11-17 12:19:07.718992	\N	Gaudry Philippe	\N	\N	t	\N	\N	f	f	{}	f	gaudry_philippe	\N	\N
418	herve.delplace@lyceedecoulogne.fr	$2a$11$bZYZB/biBGWcQ/qEq3GNSeJlOmcAilSmYlIZnKvpXFG0ZL/GUWxda	\N	\N	\N	0	\N	\N	\N	\N	2017-11-17 16:30:51.153383	2018-02-21 22:16:13.64435	\N	\N	\N	\N	\N	\N	\N	0	2	zy6nRoCu3w46HhiLyP3o	2017-11-18 07:36:04.906162	2017-11-17 16:30:51.153554	\N	DELPLACE HERVE	\N	\N	t	\N	\N	f	f	{}	f	delplace_herve	\N	\N
419	floon_pilou@hotmail.fr	$2a$11$r0A5506EHCd820lPiJ8cZOjoKkY35eBHC6qOT5E.P.plggARl7wYe	\N	\N	\N	5	2017-12-15 09:19:15.345438	2017-12-03 13:30:20.23327	78.230.236.61	78.230.236.61	2017-11-19 18:41:48.478478	2018-02-21 22:16:13.647325	\N	\N	\N	\N	\N	\N	\N	0	2	nWzJ5mkUdEUbgg1e7Soy	2017-11-19 18:52:20.519582	2017-11-19 18:41:48.478776	\N	Florent L.	\N	\N	f	\N	\N	f	f	{}	f	florent_l	\N	\N
420	bteza@orange.fr	$2a$11$muGmDtKYggAtu6.Qx6pAM.kj3SF8gSuNc4PDCRm2bSMJJy4m9riy6	\N	\N	\N	0	\N	\N	\N	\N	2017-11-20 21:07:51.707949	2018-02-21 22:16:13.649947	\N	\N	\N	\N	\N	\N	\N	0	2	x5b22tCx7edV5RnfDMi_	2017-11-20 21:11:04.213922	2017-11-20 21:07:51.708148	\N	EVE P	\N	\N	f	\N	\N	f	f	{}	f	eve_p	\N	\N
421	benetdidi@free.fr	$2a$11$bQ2tqAzwTObXvbYEAfuufOZI8kKJoO.uRv12t.FuuVgp9L0tZkWNe	\N	\N	\N	2	2017-11-26 12:43:46.05075	2017-11-25 12:58:31.622595	78.230.237.101	78.230.237.101	2017-11-25 12:57:53.328766	2018-02-21 22:16:13.652326	\N	\N	\N	\N	\N	\N	\N	0	2	soL6NLxxpT3MaDoMoewv	2017-11-25 12:58:14.594038	2017-11-25 12:57:53.328894	\N	Dereeper benoit	\N	\N	f	\N	\N	f	f	{}	f	dereeper_benoit	\N	\N
422	remydiocourt@outlook.fr	$2a$11$LQEBP47XKDSaRlaIRF6O5u./ptIctRdzi2hSGWm5G/hfIDEp1Ci3a	\N	\N	\N	7	2017-12-21 09:36:28.977868	2017-12-16 09:37:50.612509	192.196.142.92	93.6.58.9	2017-11-26 20:03:53.745487	2018-02-21 22:16:13.654624	\N	\N	\N	\N	\N	\N	\N	0	2	YKk5JbVQzqc6R31F5kno	2017-11-26 20:36:22.835308	2017-11-26 20:03:53.74563	\N	Remy	\N	\N	f	\N	\N	f	f	{}	t	remy	\N	\N
423	ryckelynckthierry@gmail.com	$2a$11$i/aYjfHedNYOReWTFn/9/OvPgtCZhzgPV4CTJPQOdH6BHxujhMJaW	\N	\N	\N	1	2017-12-04 20:39:21.238263	2017-12-04 20:39:21.238263	77.198.188.47	77.198.188.47	2017-12-04 20:32:54.695364	2018-02-21 22:16:13.656887	\N	\N	\N	\N	\N	\N	\N	0	2	psFgG5PcoGUfrziSsXbH	2017-12-04 20:39:15.504417	2017-12-04 20:32:54.695723	\N	ryckelynck	\N	\N	f	\N	\N	f	f	{}	f	ryckelynck	\N	\N
424	ryckman.benoit@gmail.com	$2a$11$Tp/XKF7/CPJBRZJ4LwR.i.J1rLevVqAv/4mxEy5FPxKA1sWIubKTG	\N	\N	\N	1	2017-12-05 19:15:26.821895	2017-12-05 19:15:26.821895	93.28.55.44	93.28.55.44	2017-12-05 19:13:34.872363	2018-02-21 22:16:13.659071	\N	\N	\N	\N	\N	\N	\N	0	2	GztHzowy3oSzxd4CW7xh	2017-12-05 19:14:29.798188	2017-12-05 19:13:34.872501	\N	Benoit R	\N	\N	f	\N	\N	f	f	{}	f	benoit_r	\N	\N
425	bonaillie.yvesmarie@neuf.fr	$2a$11$RgGniMG/lJogqU0.ihwptu.fB8D4ZGFu4ZZGS8ExAhLpShYftPUB6	\N	\N	\N	0	\N	\N	\N	\N	2017-12-06 20:06:44.685436	2018-02-21 22:16:13.66155	\N	\N	\N	\N	\N	\N	\N	0	2	DXzG2-qJLQcdyyZxSxgx	\N	2017-12-06 20:06:44.685572	\N	bonnaillie	\N	\N	f	\N	\N	f	f	{}	f	bonnaillie	\N	\N
426	cousyn_celine@yahoo.fr	$2a$11$J.DMcPkvvfWtwkhqsAz/QuNZv1Y19xoC1ZjMFur1/LrAkfvnnVy2C	\N	\N	\N	0	\N	\N	\N	\N	2017-12-07 21:28:00.070793	2018-02-21 22:16:13.663985	\N	\N	\N	\N	\N	\N	\N	0	2	AMssXkf6cdL7mAj2_peP	\N	2017-12-07 21:28:00.071121	\N	Celine	\N	\N	f	\N	\N	f	f	{}	f	celine	\N	\N
427	castiersoek@wanadoo.fr	$2a$11$mcVa/mbBXF9LuCYRLnT4LeT6Z9OADlcXdcpR/hT0UeLxczM5KIjaS	\N	\N	\N	0	\N	\N	\N	\N	2017-12-11 13:57:21.499086	2018-02-21 22:16:13.666341	\N	\N	\N	\N	\N	\N	\N	0	2	rwFAPmg1fzwnQ8n7x58C	\N	2017-12-11 13:57:21.499257	\N	CASTIER	\N	\N	t	\N	\N	f	f	{}	f	castier	\N	\N
428	philoudk@hotmail.fr	$2a$11$cC1S1w.iYaJqLqbrFfQtL.Lmvz3w4qAgKvOEzs7btCyv.t.aX6xPy	\N	\N	\N	0	\N	\N	\N	\N	2017-12-12 12:36:00.525672	2018-02-21 22:16:13.668727	\N	\N	\N	\N	\N	\N	\N	0	2	xcgcbfSfxUPxjgCt_HET	\N	2017-12-12 12:36:00.525815	\N	gaudry	\N	\N	t	\N	\N	f	f	{}	f	gaudry	\N	\N
429	michel.agez@gmail.com	$2a$11$2rLZ1obSax0W4tI2k/Z76.pJ7qNZ99X6o.RCR2..gplI8Zvulxmqy	\N	\N	\N	1	2017-12-13 08:57:51.437588	2017-12-13 08:57:51.437588	82.237.7.80	82.237.7.80	2017-12-13 08:01:53.122271	2018-02-21 22:16:13.671124	\N	\N	\N	\N	\N	\N	\N	0	2	PCGcahCYYQDFqVdZsef-	2017-12-13 08:57:31.977185	2017-12-13 08:01:53.12256	\N	Agez  Michel	\N	\N	f	\N	\N	f	f	{}	f	agez_michel	\N	\N
430	perso.manu3@orange.fr	$2a$11$t6UpDRKJ4UO/1VgR/Yo7/eoLn7ZfkzdXbVgw8/zDp5VozhBpfUKrK	\N	\N	\N	0	\N	\N	\N	\N	2017-12-15 06:04:04.611452	2018-02-21 22:16:13.673725	\N	\N	\N	\N	\N	\N	\N	0	2	WZSVMporUiUwbyf9JxNP	\N	2017-12-15 06:04:04.611663	\N	VERRIELE	\N	\N	t	\N	\N	f	f	{}	f	verriele	\N	\N
431	christinegour@hotmail.fr	$2a$11$hEQPFCOVxA4nYAdUvieNwuAC71cXMe6dOEtWuIIBrdi81yCECYR/2	\N	\N	\N	1	2017-12-15 08:50:20.183428	2017-12-15 08:50:20.183428	193.49.203.93	193.49.203.93	2017-12-15 08:48:53.207956	2018-02-21 22:16:13.676074	\N	\N	\N	\N	\N	\N	\N	0	2	edsuhXiM5ssePN79GHNa	2017-12-15 08:50:10.170207	2017-12-15 08:48:53.208094	\N	GOUR	\N	\N	f	\N	\N	f	f	{}	f	gour	\N	\N
432	sebpann@yahoo.fr	$2a$11$ehJTtCN2EJFtY2rh1K0sY.1gu0R/Xh1JYEjlJHY3bGOqVh2ijD7qG	\N	\N	\N	0	\N	\N	\N	\N	2017-12-15 14:05:45.462386	2018-02-21 22:16:13.678552	\N	\N	\N	\N	\N	\N	\N	0	2	Kvz9oqsgpzCz3qJzyRUY	\N	2017-12-15 14:05:45.46262	\N	Habitant de Loon plage 	\N	\N	t	\N	\N	f	f	{}	f	habitant_de_loon_pla	\N	\N
433	benoit.courco@gmail.com	$2a$11$xNVywBreqf0InrOy8vcKnOgnuiua9KHMyP4Z48bIXVYbOIazCuETu	\N	\N	2017-12-16 06:20:23.688381	1	2017-12-16 06:20:23.695925	2017-12-16 06:20:23.695925	93.31.149.119	93.31.149.119	2017-12-16 06:18:45.976972	2018-02-21 22:16:13.681654	\N	\N	\N	\N	\N	\N	\N	0	2	jkpEKEa8X-z8-cy-zxFn	2017-12-16 06:20:12.282184	2017-12-16 06:18:45.977102	\N	Benoît Courco	\N	\N	t	\N	\N	f	f	{}	f	benoit_courco	\N	\N
434	ro.thomas@istom.net	$2a$11$i2rjwf0QvL.O8ZaVGcSMme.HW6RDoBPAG1Iw1rAdPyVS7YTCOvxEm	\N	\N	\N	1	2017-12-17 22:52:54.179289	2017-12-17 22:52:54.179289	92.93.121.43	92.93.121.43	2017-12-17 22:50:49.448748	2018-02-21 22:16:13.684386	\N	\N	\N	\N	\N	\N	\N	0	2	kxgMboD9ByyKySfk5DxP	2017-12-17 22:52:49.93814	2017-12-17 22:50:49.449009	\N	Rose	\N	\N	f	\N	\N	f	f	{}	f	rose	\N	\N
435	philippe.fasquelle@bollore.com	$2a$11$qeruLkI8RMiRepMJTmTesOP7zCCGgLRALOudi6KEig79Z2snNdO3C	\N	\N	\N	1	2017-12-18 15:09:27.488374	2017-12-18 15:09:27.488374	195.101.158.127	195.101.158.127	2017-12-18 15:08:01.775806	2018-02-21 22:16:13.687708	\N	\N	\N	\N	\N	\N	\N	0	2	JQeh5zwRoz8wFytE9NcL	2017-12-18 15:09:02.687381	2017-12-18 15:08:01.776798	\N	FASQUELLE	\N	\N	f	\N	\N	f	f	{}	f	fasquelle_2	\N	\N
436	bcourbot@sogetra.fr	$2a$11$ads0UVl80jsj4RqVZGBjVuZMQLNZ3KTlYi6q1/fTmMybeCII4IeGC	\N	\N	\N	0	\N	\N	\N	\N	2017-12-19 15:37:44.596547	2018-02-21 22:16:13.690199	\N	\N	\N	\N	\N	\N	\N	0	2	3KQTB4Dzvky3mmfisUpx	2017-12-19 15:39:07.307156	2017-12-19 15:37:44.596742	\N	SOGETRA	\N	\N	f	\N	\N	f	f	{}	f	sogetra	\N	\N
437	brulavoinethierry@orange.fr	$2a$11$ES75GiNEHk4Y4JFzIg8uuOvQfTXXkWMinUZDR8iqNDnubN20HQkbG	\N	\N	\N	1	2017-12-22 11:36:12.48338	2017-12-22 11:36:12.48338	83.205.6.142	83.205.6.142	2017-12-22 11:33:48.437203	2018-02-21 22:16:13.692629	\N	\N	\N	\N	\N	\N	\N	0	2	T6fqashM_CS4J5ZR7Nrp	2017-12-22 11:36:09.063823	2017-12-22 11:33:48.437406	\N	Thierry Brulavoine	\N	\N	t	\N	\N	f	f	{}	f	thierry_brulavoine	\N	\N
438	flr@paris-seine-normandie.fr	$2a$11$cMgtU8C3eNB5x5F3XTXbAeKVp.C.n8k6vN5Uv3ZbFBQzw7YRhyJxu	\N	\N	\N	1	2017-12-22 15:39:15.555083	2017-12-22 15:39:15.555083	109.218.122.5	109.218.122.5	2017-12-22 15:33:08.738221	2018-02-21 22:16:13.695198	\N	\N	\N	\N	\N	\N	\N	0	2	w8eBni1C_z6sHgq-H5Tb	2017-12-22 15:38:04.07959	2017-12-22 15:33:08.738372	\N	Paris Seine Normandie	\N	\N	t	\N	\N	f	f	{}	f	paris_seine_normandi	\N	\N
439	clemence.gariglietti@orange.fr	$2a$11$eaeqPIe2MvkttQ2HrjKRsuPYoVse.MlGOvA9XSR70eo0g5WVa4.KW	\N	\N	\N	1	2017-12-22 17:05:46.931044	2017-12-22 17:05:46.931044	176.180.65.221	176.180.65.221	2017-12-22 17:04:27.798883	2018-02-21 22:16:13.698073	\N	\N	\N	\N	\N	\N	\N	0	2	sWYHd5xUWPyYvaQyhK2A	2017-12-22 17:05:37.721199	2017-12-22 17:04:27.799044	\N	Clémence Gariglietti	\N	\N	f	\N	\N	f	f	{}	f	clemence_gariglietti	\N	\N
440	virgile+50@opensourcepolitics.eu	$2a$11$L1xD4gjWDWLQ49MsCrphkOqKw/rW3yJgOtadlA.qd8YK9Azxu4fi.	\N	\N	\N	0	\N	\N	\N	\N	2017-12-27 09:42:56.003019	2018-02-21 22:16:13.700574	\N	\N	\N	\N	\N	\N	\N	0	3	iwFG5RDPqYc6pXYuUDbz	\N	2017-12-27 09:42:56.003163	\N	vir	\N	\N	t	\N	\N	f	f	{}	f	vir	\N	\N
441	virgile+50@opensourcepolitics.eu	$2a$11$K13SddraKJgTWgX7.6kiROUMtqOXwtMTL8mzGVviag9JG5OvJkjbq	\N	\N	\N	0	\N	\N	\N	\N	2017-12-27 09:43:59.261481	2018-02-21 22:16:13.704474	\N	\N	\N	\N	\N	\N	\N	0	2	yFp7dyEQdLK4FeuTmikh	\N	2017-12-27 09:43:59.261709	\N	vir	\N	\N	t	\N	\N	f	f	{}	f	vir_2	\N	\N
442	mariette.gerber@sfr.fr	$2a$11$Nwjhhoypy/.Oz.FdhDLwM.wPa9puDqe0/Xd6VaYi65irTVS4sBkFG	\N	\N	\N	0	\N	\N	\N	\N	2018-01-28 17:26:59.187479	2018-02-21 22:16:13.707447	\N	\N	\N	\N	\N	\N	\N	0	2	eP-4yyyV2i-sX5PGthMy	\N	2018-01-28 17:26:59.187646	\N	Mariette Gerber	\N	\N	t	\N	\N	f	f	{}	f	mariette_gerber	\N	\N
443	redacteur_mo@alternative2.net	$2a$11$sERHkovzLLyeUYh0XoVeLuas7JEypSpE5UnPrs4kUl/5AiKdp3Qgm	\N	\N	\N	2	2018-02-17 11:40:54.59993	2018-02-17 11:17:27.609622	90.92.215.211	90.92.215.211	2018-02-17 11:12:41.710143	2018-02-21 22:16:13.709875	\N	\N	\N	\N	\N	\N	\N	0	2	R_SmEz6r8ndJHkPss_wf	2018-02-17 11:17:17.995205	2018-02-17 11:12:41.710641	\N	test_fro_moa	\N	\N	f	\N	\N	f	f	{}	f	test_fro_moa	\N	\N
444	moderateur_cpdp@alternative2.net	$2a$11$gpZPYAkprcJSW6aSspFeKeOD4ejWW1759DmzR8a2vZy5tEovqEusy	\N	\N	\N	3	2018-02-18 10:39:06.065917	2018-02-17 12:12:26.22966	90.92.215.211	90.92.215.211	2018-02-17 11:55:08.636203	2018-02-21 22:16:13.712315	\N	2018-02-17 11:55:08.634946	2018-02-17 11:55:08.634946	2018-02-17 12:09:20.447812	\N	Decidim::User	376	0	2	\N	2018-02-17 12:09:20.447812	\N	\N	test_FRO_moderateur	\N	\N	f	\N	\N	f	f	{}	f	test_fro_moderateur	\N	\N
445	contact@alternative2.net	$2a$11$6Qagwj/buWzWemz8kdWwxe0PO7RS7YE8T0iUgiJlzj8PaYULYBUfS	\N	\N	\N	1	2018-02-17 12:57:47.557934	2018-02-17 12:57:47.557934	90.92.215.211	90.92.215.211	2018-02-17 12:25:10.27179	2018-02-21 22:16:13.714789	\N	\N	\N	\N	\N	\N	\N	0	2	aXzMty-aNGyF-1yTubAC	2018-02-17 12:57:13.771474	2018-02-17 12:25:10.272002	\N	test_FRO_internaute	\N	\N	f	\N	\N	f	f	{}	f	test_fro_internaute	\N	\N
446	delegue@edess.org	$2a$11$vzUmWLe4lLSlmnfz5xsybefkYBUoY.rv1iw7OL446PzoPgOA5o9iu	\N	\N	\N	0	\N	\N	\N	\N	2018-02-17 12:30:06.766943	2018-02-21 22:16:13.717173	\N	\N	\N	\N	\N	\N	\N	0	2	qiUj3RmP_WtCcGqK9Ywq	2018-02-17 16:06:01.859081	2018-02-17 12:30:06.76708	\N	EDESS	\N	\N	f	\N	\N	f	f	{}	f	edess	\N	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY schema_migrations (version) FROM stdin;
20170913124621
20170913124622
20170913124623
20170913124624
20170913124625
20170913124626
20170913124627
20170913124628
20170913124629
20170913124630
20170913124631
20170913124632
20170913124633
20170913124634
20170913124635
20170913124636
20170913124637
20170913124638
20170913124639
20170913124640
20170913124641
20170913124642
20170913124643
20170913124644
20170913124645
20170913124646
20170913124647
20170913124648
20170913124649
20170913124650
20170913124651
20170913124652
20170913124653
20170913124654
20170913124655
20170913124656
20170913124657
20170913124658
20170913124659
20170913124660
20170913124661
20170913124662
20170913124663
20170913124664
20170913124665
20170913124666
20170913124667
20170913124668
20170913124669
20170913124670
20170913124671
20170913124672
20170913124673
20170913124674
20170913124675
20170913124676
20170913124677
20170913124678
20170913124679
20170913124680
20170913124681
20170913124682
20170913124683
20170913124684
20170913124685
20170913124686
20170913124687
20170913124688
20170913124689
20170913124690
20170913124691
20170913124692
20170913124693
20170913124694
20170913124695
20170913124696
20170913124697
20170913124698
20170913124699
20170913124700
20170913124701
20170913124702
20170913124703
20170913124704
20170913124705
20170913124706
20170913124707
20170913124708
20170913124709
20170913124710
20170913124711
20170913124712
20170913124713
20170913124714
20170913124715
20170913124716
20170913124717
20170913124718
20170913124719
20170913124720
20170913124721
20170913124722
20170913124723
20170913124724
20170913124725
20170913124726
20170913124727
20170913124728
20170913124729
20170913124730
20170913124731
20170913124732
20170913124733
20170913124734
20170913124735
20170913124736
20170913124737
20170913124738
20170913124739
20170913124740
20170913124741
20170913124742
20170913124743
20170913124744
20170913124745
20170913124746
20170913124747
20170913124748
20170913124749
20170913124750
20170913124751
20170913124752
20170913124753
20170913124754
20170913124755
20170913124756
20170913124757
20170913124758
20170913124759
20170913124760
20170913124761
20170913124762
20170913124763
20170913124764
20170913124765
20170913124766
20170913124767
20170913124768
20170913124769
20170913124770
20170913124771
20170913124772
20170913124773
20170915143036
20170915143037
20180201205007
20180201205008
20180201205009
20180201205010
20180201205011
20180201205012
20180201205013
20180201205014
20180201205015
20180201205016
20180201205017
20180201205018
20180201205019
20180201205020
20180201205021
20180201205022
20180110203200
20180110203201
20180205085031
20180205085032
20180205085033
20180205085034
20180205085035
20180201205023
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: moustachu
--

COPY versions (id, item_type, item_id, event, whodunnit, object, created_at, object_changes) FROM stdin;
\.


--
-- Name: decidim_accountability_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_accountability_results_id_seq', 1, false);


--
-- Name: decidim_accountability_statuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_accountability_statuses_id_seq', 1, false);


--
-- Name: decidim_accountability_timeline_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_accountability_timeline_entries_id_seq', 1, false);


--
-- Name: decidim_assemblies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_assemblies_id_seq', 4, true);


--
-- Name: decidim_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_attachments_id_seq', 96, true);


--
-- Name: decidim_authorizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_authorizations_id_seq', 1, false);


--
-- Name: decidim_budgets_line_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_budgets_line_items_id_seq', 1, false);


--
-- Name: decidim_budgets_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_budgets_orders_id_seq', 1, false);


--
-- Name: decidim_budgets_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_budgets_projects_id_seq', 18, true);


--
-- Name: decidim_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_categories_id_seq', 42, true);


--
-- Name: decidim_categorizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_categorizations_id_seq', 401, true);


--
-- Name: decidim_comments_comment_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_comments_comment_votes_id_seq', 11, true);


--
-- Name: decidim_comments_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_comments_comments_id_seq', 531, true);


--
-- Name: decidim_features_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_features_id_seq', 61, true);


--
-- Name: decidim_follows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_follows_id_seq', 10, true);


--
-- Name: decidim_identities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_identities_id_seq', 1, false);


--
-- Name: decidim_impersonation_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_impersonation_logs_id_seq', 1, false);


--
-- Name: decidim_meetings_meetings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_meetings_meetings_id_seq', 21, true);


--
-- Name: decidim_meetings_registrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_meetings_registrations_id_seq', 180, true);


--
-- Name: decidim_messaging_conversations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_messaging_conversations_id_seq', 1, false);


--
-- Name: decidim_messaging_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_messaging_messages_id_seq', 1, false);


--
-- Name: decidim_messaging_participations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_messaging_participations_id_seq', 1, false);


--
-- Name: decidim_messaging_receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_messaging_receipts_id_seq', 1, false);


--
-- Name: decidim_moderations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_moderations_id_seq', 138, true);


--
-- Name: decidim_navbar_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_navbar_links_id_seq', 1, false);


--
-- Name: decidim_newsletters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_newsletters_id_seq', 1, true);


--
-- Name: decidim_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_notifications_id_seq', 4, true);


--
-- Name: decidim_organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_organizations_id_seq', 3, true);


--
-- Name: decidim_pages_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_pages_pages_id_seq', 8, true);


--
-- Name: decidim_participatory_process_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_participatory_process_groups_id_seq', 3, true);


--
-- Name: decidim_participatory_process_steps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_participatory_process_steps_id_seq', 19, true);


--
-- Name: decidim_participatory_process_user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_participatory_process_user_roles_id_seq', 33, true);


--
-- Name: decidim_participatory_processes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_participatory_processes_id_seq', 10, true);


--
-- Name: decidim_proposals_proposal_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_proposals_proposal_votes_id_seq', 139, true);


--
-- Name: decidim_proposals_proposals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_proposals_proposals_id_seq', 386, true);


--
-- Name: decidim_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_reports_id_seq', 12, true);


--
-- Name: decidim_resource_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_resource_links_id_seq', 1, false);


--
-- Name: decidim_scope_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_scope_types_id_seq', 2, true);


--
-- Name: decidim_scopes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_scopes_id_seq', 18, true);


--
-- Name: decidim_static_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_static_pages_id_seq', 9, true);


--
-- Name: decidim_surveys_survey_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_surveys_survey_answers_id_seq', 4, true);


--
-- Name: decidim_surveys_survey_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_surveys_survey_questions_id_seq', 25, true);


--
-- Name: decidim_surveys_surveys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_surveys_surveys_id_seq', 9, true);


--
-- Name: decidim_system_admins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_system_admins_id_seq', 2, true);


--
-- Name: decidim_user_group_memberships_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_user_group_memberships_id_seq', 11, true);


--
-- Name: decidim_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_user_groups_id_seq', 11, true);


--
-- Name: decidim_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('decidim_users_id_seq', 446, true);


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: moustachu
--

SELECT pg_catalog.setval('versions_id_seq', 1, false);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: decidim_accountability_results decidim_accountability_results_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_accountability_results
    ADD CONSTRAINT decidim_accountability_results_pkey PRIMARY KEY (id);


--
-- Name: decidim_accountability_statuses decidim_accountability_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_accountability_statuses
    ADD CONSTRAINT decidim_accountability_statuses_pkey PRIMARY KEY (id);


--
-- Name: decidim_accountability_timeline_entries decidim_accountability_timeline_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_accountability_timeline_entries
    ADD CONSTRAINT decidim_accountability_timeline_entries_pkey PRIMARY KEY (id);


--
-- Name: decidim_assemblies decidim_assemblies_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_assemblies
    ADD CONSTRAINT decidim_assemblies_pkey PRIMARY KEY (id);


--
-- Name: decidim_attachments decidim_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_attachments
    ADD CONSTRAINT decidim_attachments_pkey PRIMARY KEY (id);


--
-- Name: decidim_authorizations decidim_authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_authorizations
    ADD CONSTRAINT decidim_authorizations_pkey PRIMARY KEY (id);


--
-- Name: decidim_budgets_line_items decidim_budgets_line_items_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_budgets_line_items
    ADD CONSTRAINT decidim_budgets_line_items_pkey PRIMARY KEY (id);


--
-- Name: decidim_budgets_orders decidim_budgets_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_budgets_orders
    ADD CONSTRAINT decidim_budgets_orders_pkey PRIMARY KEY (id);


--
-- Name: decidim_budgets_projects decidim_budgets_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_budgets_projects
    ADD CONSTRAINT decidim_budgets_projects_pkey PRIMARY KEY (id);


--
-- Name: decidim_categories decidim_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_categories
    ADD CONSTRAINT decidim_categories_pkey PRIMARY KEY (id);


--
-- Name: decidim_categorizations decidim_categorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_categorizations
    ADD CONSTRAINT decidim_categorizations_pkey PRIMARY KEY (id);


--
-- Name: decidim_comments_comment_votes decidim_comments_comment_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_comments_comment_votes
    ADD CONSTRAINT decidim_comments_comment_votes_pkey PRIMARY KEY (id);


--
-- Name: decidim_comments_comments decidim_comments_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_comments_comments
    ADD CONSTRAINT decidim_comments_comments_pkey PRIMARY KEY (id);


--
-- Name: decidim_features decidim_features_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_features
    ADD CONSTRAINT decidim_features_pkey PRIMARY KEY (id);


--
-- Name: decidim_follows decidim_follows_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_follows
    ADD CONSTRAINT decidim_follows_pkey PRIMARY KEY (id);


--
-- Name: decidim_identities decidim_identities_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_identities
    ADD CONSTRAINT decidim_identities_pkey PRIMARY KEY (id);


--
-- Name: decidim_impersonation_logs decidim_impersonation_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_impersonation_logs
    ADD CONSTRAINT decidim_impersonation_logs_pkey PRIMARY KEY (id);


--
-- Name: decidim_meetings_meetings decidim_meetings_meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_meetings_meetings
    ADD CONSTRAINT decidim_meetings_meetings_pkey PRIMARY KEY (id);


--
-- Name: decidim_meetings_registrations decidim_meetings_registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_meetings_registrations
    ADD CONSTRAINT decidim_meetings_registrations_pkey PRIMARY KEY (id);


--
-- Name: decidim_messaging_conversations decidim_messaging_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_conversations
    ADD CONSTRAINT decidim_messaging_conversations_pkey PRIMARY KEY (id);


--
-- Name: decidim_messaging_messages decidim_messaging_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_messages
    ADD CONSTRAINT decidim_messaging_messages_pkey PRIMARY KEY (id);


--
-- Name: decidim_messaging_participations decidim_messaging_participations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_participations
    ADD CONSTRAINT decidim_messaging_participations_pkey PRIMARY KEY (id);


--
-- Name: decidim_messaging_receipts decidim_messaging_receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_messaging_receipts
    ADD CONSTRAINT decidim_messaging_receipts_pkey PRIMARY KEY (id);


--
-- Name: decidim_moderations decidim_moderations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_moderations
    ADD CONSTRAINT decidim_moderations_pkey PRIMARY KEY (id);


--
-- Name: decidim_navbar_links decidim_navbar_links_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_navbar_links
    ADD CONSTRAINT decidim_navbar_links_pkey PRIMARY KEY (id);


--
-- Name: decidim_newsletters decidim_newsletters_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_newsletters
    ADD CONSTRAINT decidim_newsletters_pkey PRIMARY KEY (id);


--
-- Name: decidim_notifications decidim_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_notifications
    ADD CONSTRAINT decidim_notifications_pkey PRIMARY KEY (id);


--
-- Name: decidim_organizations decidim_organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_organizations
    ADD CONSTRAINT decidim_organizations_pkey PRIMARY KEY (id);


--
-- Name: decidim_pages_pages decidim_pages_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_pages_pages
    ADD CONSTRAINT decidim_pages_pages_pkey PRIMARY KEY (id);


--
-- Name: decidim_participatory_process_groups decidim_participatory_process_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_groups
    ADD CONSTRAINT decidim_participatory_process_groups_pkey PRIMARY KEY (id);


--
-- Name: decidim_participatory_process_steps decidim_participatory_process_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_steps
    ADD CONSTRAINT decidim_participatory_process_steps_pkey PRIMARY KEY (id);


--
-- Name: decidim_participatory_process_user_roles decidim_participatory_process_user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_user_roles
    ADD CONSTRAINT decidim_participatory_process_user_roles_pkey PRIMARY KEY (id);


--
-- Name: decidim_participatory_processes decidim_participatory_processes_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_processes
    ADD CONSTRAINT decidim_participatory_processes_pkey PRIMARY KEY (id);


--
-- Name: decidim_proposals_proposal_votes decidim_proposals_proposal_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_proposals_proposal_votes
    ADD CONSTRAINT decidim_proposals_proposal_votes_pkey PRIMARY KEY (id);


--
-- Name: decidim_proposals_proposals decidim_proposals_proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_proposals_proposals
    ADD CONSTRAINT decidim_proposals_proposals_pkey PRIMARY KEY (id);


--
-- Name: decidim_reports decidim_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_reports
    ADD CONSTRAINT decidim_reports_pkey PRIMARY KEY (id);


--
-- Name: decidim_resource_links decidim_resource_links_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_resource_links
    ADD CONSTRAINT decidim_resource_links_pkey PRIMARY KEY (id);


--
-- Name: decidim_scope_types decidim_scope_types_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scope_types
    ADD CONSTRAINT decidim_scope_types_pkey PRIMARY KEY (id);


--
-- Name: decidim_scopes decidim_scopes_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scopes
    ADD CONSTRAINT decidim_scopes_pkey PRIMARY KEY (id);


--
-- Name: decidim_static_pages decidim_static_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_static_pages
    ADD CONSTRAINT decidim_static_pages_pkey PRIMARY KEY (id);


--
-- Name: decidim_surveys_survey_answers decidim_surveys_survey_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_surveys_survey_answers
    ADD CONSTRAINT decidim_surveys_survey_answers_pkey PRIMARY KEY (id);


--
-- Name: decidim_surveys_survey_questions decidim_surveys_survey_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_surveys_survey_questions
    ADD CONSTRAINT decidim_surveys_survey_questions_pkey PRIMARY KEY (id);


--
-- Name: decidim_surveys_surveys decidim_surveys_surveys_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_surveys_surveys
    ADD CONSTRAINT decidim_surveys_surveys_pkey PRIMARY KEY (id);


--
-- Name: decidim_system_admins decidim_system_admins_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_system_admins
    ADD CONSTRAINT decidim_system_admins_pkey PRIMARY KEY (id);


--
-- Name: decidim_user_group_memberships decidim_user_group_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_user_group_memberships
    ADD CONSTRAINT decidim_user_group_memberships_pkey PRIMARY KEY (id);


--
-- Name: decidim_user_groups decidim_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_user_groups
    ADD CONSTRAINT decidim_user_groups_pkey PRIMARY KEY (id);


--
-- Name: decidim_users decidim_users_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_users
    ADD CONSTRAINT decidim_users_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: decidim_accountability_results_on_parent_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_accountability_results_on_parent_id ON decidim_accountability_results USING btree (parent_id);


--
-- Name: decidim_accountability_results_on_status_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_accountability_results_on_status_id ON decidim_accountability_results USING btree (decidim_accountability_status_id);


--
-- Name: decidim_budgets_line_items_order_project_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_budgets_line_items_order_project_unique ON decidim_budgets_line_items USING btree (decidim_order_id, decidim_project_id);


--
-- Name: decidim_budgets_order_user_feature_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_budgets_order_user_feature_unique ON decidim_budgets_orders USING btree (decidim_user_id, decidim_feature_id);


--
-- Name: decidim_categorizations_categorizable_id_and_type; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_categorizations_categorizable_id_and_type ON decidim_categorizations USING btree (categorizable_type, categorizable_id);


--
-- Name: decidim_comments_comment_author; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_comments_comment_author ON decidim_comments_comments USING btree (decidim_author_id);


--
-- Name: decidim_comments_comment_commentable; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_comments_comment_commentable ON decidim_comments_comments USING btree (decidim_commentable_type, decidim_commentable_id);


--
-- Name: decidim_comments_comment_root_commentable; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_comments_comment_root_commentable ON decidim_comments_comments USING btree (decidim_root_commentable_type, decidim_root_commentable_id);


--
-- Name: decidim_comments_comment_vote_author; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_comments_comment_vote_author ON decidim_comments_comment_votes USING btree (decidim_author_id);


--
-- Name: decidim_comments_comment_vote_comment; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_comments_comment_vote_comment ON decidim_comments_comment_votes USING btree (decidim_comment_id);


--
-- Name: decidim_comments_comment_vote_comment_author_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_comments_comment_vote_comment_author_unique ON decidim_comments_comment_votes USING btree (decidim_comment_id, decidim_author_id);


--
-- Name: decidim_identities_provider_uid_organization_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_identities_provider_uid_organization_unique ON decidim_identities USING btree (provider, uid, decidim_organization_id);


--
-- Name: decidim_meetings_registrations_user_meeting_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_meetings_registrations_user_meeting_unique ON decidim_meetings_registrations USING btree (decidim_user_id, decidim_meeting_id);


--
-- Name: decidim_moderations_hidden_at; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_moderations_hidden_at ON decidim_moderations USING btree (hidden_at);


--
-- Name: decidim_moderations_participatory_space; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_moderations_participatory_space ON decidim_moderations USING btree (decidim_participatory_space_id, decidim_participatory_space_type);


--
-- Name: decidim_moderations_report_count; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_moderations_report_count ON decidim_moderations USING btree (report_count);


--
-- Name: decidim_moderations_reportable; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_moderations_reportable ON decidim_moderations USING btree (decidim_reportable_type, decidim_reportable_id);


--
-- Name: decidim_participatory_process_group_organization; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_participatory_process_group_organization ON decidim_participatory_process_groups USING btree (decidim_organization_id);


--
-- Name: decidim_proposals_proposal_body_search; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_proposals_proposal_body_search ON decidim_proposals_proposals USING btree (md5(body));


--
-- Name: decidim_proposals_proposal_title_search; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_proposals_proposal_title_search ON decidim_proposals_proposals USING btree (title);


--
-- Name: decidim_proposals_proposal_vote_author; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_proposals_proposal_vote_author ON decidim_proposals_proposal_votes USING btree (decidim_author_id);


--
-- Name: decidim_proposals_proposal_vote_proposal; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_proposals_proposal_vote_proposal ON decidim_proposals_proposal_votes USING btree (decidim_proposal_id);


--
-- Name: decidim_proposals_proposal_vote_proposal_author_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_proposals_proposal_vote_proposal_author_unique ON decidim_proposals_proposal_votes USING btree (decidim_proposal_id, decidim_author_id);


--
-- Name: decidim_reports_moderation; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_reports_moderation ON decidim_reports USING btree (decidim_moderation_id);


--
-- Name: decidim_reports_moderation_user_unique; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_reports_moderation_user_unique ON decidim_reports USING btree (decidim_moderation_id, decidim_user_id);


--
-- Name: decidim_reports_user; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX decidim_reports_user ON decidim_reports USING btree (decidim_user_id);


--
-- Name: decidim_user_group_memberships_unique_user_and_group_ids; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX decidim_user_group_memberships_unique_user_and_group_ids ON decidim_user_group_memberships USING btree (decidim_user_id, decidim_user_group_id);


--
-- Name: index_conversation_participations_on_conversation_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_conversation_participations_on_conversation_id ON decidim_messaging_participations USING btree (decidim_conversation_id);


--
-- Name: index_conversation_participations_on_participant_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_conversation_participations_on_participant_id ON decidim_messaging_participations USING btree (decidim_participant_id);


--
-- Name: index_decidim_accountability_results_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_accountability_results_on_decidim_feature_id ON decidim_accountability_results USING btree (decidim_feature_id);


--
-- Name: index_decidim_accountability_results_on_decidim_scope_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_accountability_results_on_decidim_scope_id ON decidim_accountability_results USING btree (decidim_scope_id);


--
-- Name: index_decidim_accountability_statuses_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_accountability_statuses_on_decidim_feature_id ON decidim_accountability_statuses USING btree (decidim_feature_id);


--
-- Name: index_decidim_accountability_timeline_entries_on_entry_date; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_accountability_timeline_entries_on_entry_date ON decidim_accountability_timeline_entries USING btree (entry_date);


--
-- Name: index_decidim_accountability_timeline_entries_on_results_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_accountability_timeline_entries_on_results_id ON decidim_accountability_timeline_entries USING btree (decidim_accountability_result_id);


--
-- Name: index_decidim_assemblies_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_assemblies_on_decidim_organization_id ON decidim_assemblies USING btree (decidim_organization_id);


--
-- Name: index_decidim_attachments_on_attached_to; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_attachments_on_attached_to ON decidim_attachments USING btree (attached_to_id, attached_to_type);


--
-- Name: index_decidim_authorizations_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_authorizations_on_decidim_user_id ON decidim_authorizations USING btree (decidim_user_id);


--
-- Name: index_decidim_authorizations_on_decidim_user_id_and_name; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_authorizations_on_decidim_user_id_and_name ON decidim_authorizations USING btree (decidim_user_id, name);


--
-- Name: index_decidim_budgets_line_items_on_decidim_order_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_budgets_line_items_on_decidim_order_id ON decidim_budgets_line_items USING btree (decidim_order_id);


--
-- Name: index_decidim_budgets_line_items_on_decidim_project_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_budgets_line_items_on_decidim_project_id ON decidim_budgets_line_items USING btree (decidim_project_id);


--
-- Name: index_decidim_budgets_orders_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_budgets_orders_on_decidim_feature_id ON decidim_budgets_orders USING btree (decidim_feature_id);


--
-- Name: index_decidim_budgets_orders_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_budgets_orders_on_decidim_user_id ON decidim_budgets_orders USING btree (decidim_user_id);


--
-- Name: index_decidim_budgets_projects_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_budgets_projects_on_decidim_feature_id ON decidim_budgets_projects USING btree (decidim_feature_id);


--
-- Name: index_decidim_budgets_projects_on_decidim_scope_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_budgets_projects_on_decidim_scope_id ON decidim_budgets_projects USING btree (decidim_scope_id);


--
-- Name: index_decidim_categories_on_decidim_participatory_space; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_categories_on_decidim_participatory_space ON decidim_categories USING btree (decidim_participatory_space_id, decidim_participatory_space_type);


--
-- Name: index_decidim_categories_on_parent_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_categories_on_parent_id ON decidim_categories USING btree (parent_id);


--
-- Name: index_decidim_categorizations_on_decidim_category_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_categorizations_on_decidim_category_id ON decidim_categorizations USING btree (decidim_category_id);


--
-- Name: index_decidim_comments_comments_on_created_at; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_comments_comments_on_created_at ON decidim_comments_comments USING btree (created_at);


--
-- Name: index_decidim_features_on_decidim_participatory_space; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_features_on_decidim_participatory_space ON decidim_features USING btree (participatory_space_id, participatory_space_type);


--
-- Name: index_decidim_follows_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_follows_on_decidim_user_id ON decidim_follows USING btree (decidim_user_id);


--
-- Name: index_decidim_identities_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_identities_on_decidim_organization_id ON decidim_identities USING btree (decidim_organization_id);


--
-- Name: index_decidim_identities_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_identities_on_decidim_user_id ON decidim_identities USING btree (decidim_user_id);


--
-- Name: index_decidim_impersonation_logs_on_decidim_admin_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_impersonation_logs_on_decidim_admin_id ON decidim_impersonation_logs USING btree (decidim_admin_id);


--
-- Name: index_decidim_impersonation_logs_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_impersonation_logs_on_decidim_user_id ON decidim_impersonation_logs USING btree (decidim_user_id);


--
-- Name: index_decidim_meetings_meetings_on_decidim_author_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_meetings_meetings_on_decidim_author_id ON decidim_meetings_meetings USING btree (decidim_author_id);


--
-- Name: index_decidim_meetings_meetings_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_meetings_meetings_on_decidim_feature_id ON decidim_meetings_meetings USING btree (decidim_feature_id);


--
-- Name: index_decidim_meetings_meetings_on_decidim_scope_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_meetings_meetings_on_decidim_scope_id ON decidim_meetings_meetings USING btree (decidim_scope_id);


--
-- Name: index_decidim_meetings_registrations_on_decidim_meeting_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_meetings_registrations_on_decidim_meeting_id ON decidim_meetings_registrations USING btree (decidim_meeting_id);


--
-- Name: index_decidim_meetings_registrations_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_meetings_registrations_on_decidim_user_id ON decidim_meetings_registrations USING btree (decidim_user_id);


--
-- Name: index_decidim_messaging_messages_on_decidim_conversation_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_messaging_messages_on_decidim_conversation_id ON decidim_messaging_messages USING btree (decidim_conversation_id);


--
-- Name: index_decidim_messaging_messages_on_decidim_sender_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_messaging_messages_on_decidim_sender_id ON decidim_messaging_messages USING btree (decidim_sender_id);


--
-- Name: index_decidim_messaging_receipts_on_decidim_message_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_messaging_receipts_on_decidim_message_id ON decidim_messaging_receipts USING btree (decidim_message_id);


--
-- Name: index_decidim_messaging_receipts_on_decidim_recipient_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_messaging_receipts_on_decidim_recipient_id ON decidim_messaging_receipts USING btree (decidim_recipient_id);


--
-- Name: index_decidim_navbar_links_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_navbar_links_on_decidim_organization_id ON decidim_navbar_links USING btree (decidim_organization_id);


--
-- Name: index_decidim_newsletters_on_author_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_newsletters_on_author_id ON decidim_newsletters USING btree (author_id);


--
-- Name: index_decidim_newsletters_on_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_newsletters_on_organization_id ON decidim_newsletters USING btree (organization_id);


--
-- Name: index_decidim_notifications_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_notifications_on_decidim_user_id ON decidim_notifications USING btree (decidim_user_id);


--
-- Name: index_decidim_organizations_on_host; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_organizations_on_host ON decidim_organizations USING btree (host);


--
-- Name: index_decidim_organizations_on_name; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_organizations_on_name ON decidim_organizations USING btree (name);


--
-- Name: index_decidim_pages_pages_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_pages_pages_on_decidim_feature_id ON decidim_pages_pages USING btree (decidim_feature_id);


--
-- Name: index_decidim_processes_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_processes_on_decidim_organization_id ON decidim_participatory_processes USING btree (decidim_organization_id);


--
-- Name: index_decidim_processes_steps__on_decidim_process_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_processes_steps__on_decidim_process_id ON decidim_participatory_process_steps USING btree (decidim_participatory_process_id);


--
-- Name: index_decidim_proposals_proposals_on_created_at; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_proposals_proposals_on_created_at ON decidim_proposals_proposals USING btree (created_at);


--
-- Name: index_decidim_proposals_proposals_on_decidim_author_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_proposals_proposals_on_decidim_author_id ON decidim_proposals_proposals USING btree (decidim_author_id);


--
-- Name: index_decidim_proposals_proposals_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_proposals_proposals_on_decidim_feature_id ON decidim_proposals_proposals USING btree (decidim_feature_id);


--
-- Name: index_decidim_proposals_proposals_on_decidim_scope_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_proposals_proposals_on_decidim_scope_id ON decidim_proposals_proposals USING btree (decidim_scope_id);


--
-- Name: index_decidim_proposals_proposals_on_proposal_votes_count; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_proposals_proposals_on_proposal_votes_count ON decidim_proposals_proposals USING btree (proposal_votes_count);


--
-- Name: index_decidim_proposals_proposals_on_state; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_proposals_proposals_on_state ON decidim_proposals_proposals USING btree (state);


--
-- Name: index_decidim_resource_links_on_from_type_and_from_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_resource_links_on_from_type_and_from_id ON decidim_resource_links USING btree (from_type, from_id);


--
-- Name: index_decidim_resource_links_on_name; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_resource_links_on_name ON decidim_resource_links USING btree (name);


--
-- Name: index_decidim_resource_links_on_to_type_and_to_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_resource_links_on_to_type_and_to_id ON decidim_resource_links USING btree (to_type, to_id);


--
-- Name: index_decidim_scope_types_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_scope_types_on_decidim_organization_id ON decidim_scope_types USING btree (decidim_organization_id);


--
-- Name: index_decidim_scopes_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_scopes_on_decidim_organization_id ON decidim_scopes USING btree (decidim_organization_id);


--
-- Name: index_decidim_scopes_on_decidim_organization_id_and_code; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_scopes_on_decidim_organization_id_and_code ON decidim_scopes USING btree (decidim_organization_id, code);


--
-- Name: index_decidim_scopes_on_parent_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_scopes_on_parent_id ON decidim_scopes USING btree (parent_id);


--
-- Name: index_decidim_scopes_on_part_of; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_scopes_on_part_of ON decidim_scopes USING gin (part_of);


--
-- Name: index_decidim_scopes_on_scope_type_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_scopes_on_scope_type_id ON decidim_scopes USING btree (scope_type_id);


--
-- Name: index_decidim_static_pages_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_static_pages_on_decidim_organization_id ON decidim_static_pages USING btree (decidim_organization_id);


--
-- Name: index_decidim_surveys_answers_question_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_surveys_answers_question_id ON decidim_surveys_survey_answers USING btree (decidim_survey_question_id);


--
-- Name: index_decidim_surveys_survey_answers_on_decidim_survey_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_surveys_survey_answers_on_decidim_survey_id ON decidim_surveys_survey_answers USING btree (decidim_survey_id);


--
-- Name: index_decidim_surveys_survey_answers_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_surveys_survey_answers_on_decidim_user_id ON decidim_surveys_survey_answers USING btree (decidim_user_id);


--
-- Name: index_decidim_surveys_survey_questions_on_decidim_survey_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_surveys_survey_questions_on_decidim_survey_id ON decidim_surveys_survey_questions USING btree (decidim_survey_id);


--
-- Name: index_decidim_surveys_surveys_on_decidim_feature_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_surveys_surveys_on_decidim_feature_id ON decidim_surveys_surveys USING btree (decidim_feature_id);


--
-- Name: index_decidim_system_admins_on_email; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_system_admins_on_email ON decidim_system_admins USING btree (email);


--
-- Name: index_decidim_system_admins_on_reset_password_token; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_system_admins_on_reset_password_token ON decidim_system_admins USING btree (reset_password_token);


--
-- Name: index_decidim_user_group_memberships_on_decidim_user_group_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_user_group_memberships_on_decidim_user_group_id ON decidim_user_group_memberships USING btree (decidim_user_group_id);


--
-- Name: index_decidim_user_group_memberships_on_decidim_user_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_user_group_memberships_on_decidim_user_id ON decidim_user_group_memberships USING btree (decidim_user_id);


--
-- Name: index_decidim_user_groups_document_number_on_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_user_groups_document_number_on_organization_id ON decidim_user_groups USING btree (decidim_organization_id, document_number);


--
-- Name: index_decidim_user_groups_names_on_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_user_groups_names_on_organization_id ON decidim_user_groups USING btree (decidim_organization_id, name);


--
-- Name: index_decidim_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_users_on_confirmation_token ON decidim_users USING btree (confirmation_token);


--
-- Name: index_decidim_users_on_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_users_on_decidim_organization_id ON decidim_users USING btree (decidim_organization_id);


--
-- Name: index_decidim_users_on_email_and_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_users_on_email_and_decidim_organization_id ON decidim_users USING btree (email, decidim_organization_id) WHERE ((deleted_at IS NULL) AND (managed = false));


--
-- Name: index_decidim_users_on_invitation_token; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_users_on_invitation_token ON decidim_users USING btree (invitation_token);


--
-- Name: index_decidim_users_on_invitations_count; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_users_on_invitations_count ON decidim_users USING btree (invitations_count);


--
-- Name: index_decidim_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_users_on_invited_by_id ON decidim_users USING btree (invited_by_id);


--
-- Name: index_decidim_users_on_nickame_and_decidim_organization_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_users_on_nickame_and_decidim_organization_id ON decidim_users USING btree (nickname, decidim_organization_id) WHERE ((deleted_at IS NULL) AND (managed = false));


--
-- Name: index_decidim_users_on_officialized_at; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_decidim_users_on_officialized_at ON decidim_users USING btree (officialized_at);


--
-- Name: index_decidim_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_decidim_users_on_reset_password_token ON decidim_users USING btree (reset_password_token);


--
-- Name: index_order_by_position_for_steps; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_order_by_position_for_steps ON decidim_participatory_process_steps USING btree ("position");


--
-- Name: index_uniq_on_follows_user_and_followable; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_uniq_on_follows_user_and_followable ON decidim_follows USING btree (decidim_user_id, decidim_followable_id, decidim_followable_type);


--
-- Name: index_unique_assembly_slug_and_organization; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_unique_assembly_slug_and_organization ON decidim_assemblies USING btree (decidim_organization_id, slug);


--
-- Name: index_unique_position_for_process; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_unique_position_for_process ON decidim_participatory_process_steps USING btree (decidim_participatory_process_id, "position");


--
-- Name: index_unique_process_slug_and_organization; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_unique_process_slug_and_organization ON decidim_participatory_processes USING btree (decidim_organization_id, slug);


--
-- Name: index_unique_user_and_process_role; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX index_unique_user_and_process_role ON decidim_participatory_process_user_roles USING btree (decidim_participatory_process_id, decidim_user_id, role);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: unique_index_to_avoid_duplicate_active_steps; Type: INDEX; Schema: public; Owner: moustachu
--

CREATE UNIQUE INDEX unique_index_to_avoid_duplicate_active_steps ON decidim_participatory_process_steps USING btree (decidim_participatory_process_id, active) WHERE (active = true);


--
-- Name: decidim_participatory_processes fk_rails_29fec61528; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_processes
    ADD CONSTRAINT fk_rails_29fec61528 FOREIGN KEY (decidim_organization_id) REFERENCES decidim_organizations(id);


--
-- Name: decidim_static_pages fk_rails_3bf12569d2; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_static_pages
    ADD CONSTRAINT fk_rails_3bf12569d2 FOREIGN KEY (decidim_organization_id) REFERENCES decidim_organizations(id);


--
-- Name: decidim_users fk_rails_6189fc3943; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_users
    ADD CONSTRAINT fk_rails_6189fc3943 FOREIGN KEY (decidim_organization_id) REFERENCES decidim_organizations(id);


--
-- Name: decidim_scope_types fk_rails_652d83a2b0; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scope_types
    ADD CONSTRAINT fk_rails_652d83a2b0 FOREIGN KEY (decidim_organization_id) REFERENCES decidim_organizations(id);


--
-- Name: decidim_scopes fk_rails_7439b45e19; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scopes
    ADD CONSTRAINT fk_rails_7439b45e19 FOREIGN KEY (decidim_organization_id) REFERENCES decidim_organizations(id);


--
-- Name: decidim_scopes fk_rails_9c3ff1b1f2; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scopes
    ADD CONSTRAINT fk_rails_9c3ff1b1f2 FOREIGN KEY (parent_id) REFERENCES decidim_scopes(id);


--
-- Name: decidim_scopes fk_rails_9f5e09f78a; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_scopes
    ADD CONSTRAINT fk_rails_9f5e09f78a FOREIGN KEY (scope_type_id) REFERENCES decidim_scope_types(id);


--
-- Name: decidim_authorizations fk_rails_b91fb4e4a2; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_authorizations
    ADD CONSTRAINT fk_rails_b91fb4e4a2 FOREIGN KEY (decidim_user_id) REFERENCES decidim_users(id);


--
-- Name: decidim_identities fk_rails_d098abe7b4; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_identities
    ADD CONSTRAINT fk_rails_d098abe7b4 FOREIGN KEY (decidim_organization_id) REFERENCES decidim_organizations(id);


--
-- Name: decidim_participatory_process_steps fk_rails_d3df776226; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_participatory_process_steps
    ADD CONSTRAINT fk_rails_d3df776226 FOREIGN KEY (decidim_participatory_process_id) REFERENCES decidim_participatory_processes(id);


--
-- Name: decidim_categorizations fk_rails_f4b8873d6e; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_categorizations
    ADD CONSTRAINT fk_rails_f4b8873d6e FOREIGN KEY (decidim_category_id) REFERENCES decidim_categories(id);


--
-- Name: decidim_newsletters fk_rails_fad1d5e21d; Type: FK CONSTRAINT; Schema: public; Owner: moustachu
--

ALTER TABLE ONLY decidim_newsletters
    ADD CONSTRAINT fk_rails_fad1d5e21d FOREIGN KEY (author_id) REFERENCES decidim_users(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: moustachu
--

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

