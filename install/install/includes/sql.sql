--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-2)
-- Dumped by pg_dump version 15.2 (Debian 15.2-2)

-- Started on 2023-05-20 13:05:57 CEST

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
SET timezone = 'UTC';

--
-- TOC entry 3812 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- TOC entry 215 (class 1259 OID 23333)
-- Name: audit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."audit" (
    "id" integer NOT NULL,
    "user" integer NOT NULL,
    "page" character varying(255) NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "ip" "inet" NOT NULL,
    "viewed" boolean NOT NULL
);


--
-- TOC entry 214 (class 1259 OID 23332)
-- Name: audit_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."audit_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3813 (class 0 OID 0)
-- Dependencies: 214
-- Name: audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."audit_id_seq" OWNED BY "public"."audit"."id";


--
-- TOC entry 217 (class 1259 OID 23343)
-- Name: crons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."crons" (
    "id" integer NOT NULL,
    "active" smallint DEFAULT 1 NOT NULL,
    "sort" smallint NOT NULL,
    "name" "text" NOT NULL,
    "file" "text" NOT NULL,
    "createdby" integer NOT NULL,
    "created" timestamp without time zone,
    "modified" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 23342)
-- Name: crons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."crons_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3814 (class 0 OID 0)
-- Dependencies: 216
-- Name: crons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."crons_id_seq" OWNED BY "public"."crons"."id";


--
-- TOC entry 219 (class 1259 OID 23354)
-- Name: crons_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."crons_logs" (
    "id" integer NOT NULL,
    "cron_id" integer NOT NULL,
    "datetime" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "user_id" integer NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 23353)
-- Name: crons_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."crons_logs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3815 (class 0 OID 0)
-- Dependencies: 218
-- Name: crons_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."crons_logs_id_seq" OWNED BY "public"."crons_logs"."id";


--
-- TOC entry 221 (class 1259 OID 23362)
-- Name: email; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."email" (
    "id" integer NOT NULL,
    "website_name" character varying(100) NOT NULL,
    "smtp_server" character varying(100) NOT NULL,
    "smtp_port" integer NOT NULL,
    "email_login" character varying(150) NOT NULL,
    "email_pass" character varying(100) NOT NULL,
    "from_name" character varying(100) NOT NULL,
    "from_email" character varying(150) NOT NULL,
    "transport" character varying(255) NOT NULL,
    "verify_url" character varying(255) NOT NULL,
    "email_act" integer NOT NULL,
    "debug_level" integer DEFAULT 0 NOT NULL,
    "isSMTP" integer DEFAULT 0 NOT NULL,
    "isHTML" character varying(5) DEFAULT 'true'::character varying NOT NULL,
    "useSMTPauth" character varying(6) DEFAULT 'true'::character varying NOT NULL,
    "authtype" character varying(50) DEFAULT 'CRAM-MD5'::character varying
);


--
-- TOC entry 220 (class 1259 OID 23361)
-- Name: email_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."email_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3816 (class 0 OID 0)
-- Dependencies: 220
-- Name: email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."email_id_seq" OWNED BY "public"."email"."id";


--
-- TOC entry 223 (class 1259 OID 23376)
-- Name: groups_menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."groups_menus" (
    "id" integer NOT NULL,
    "group_id" integer NOT NULL,
    "menu_id" integer NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 23375)
-- Name: groups_menus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."groups_menus_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3817 (class 0 OID 0)
-- Dependencies: 222
-- Name: groups_menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."groups_menus_id_seq" OWNED BY "public"."groups_menus"."id";


--
-- TOC entry 225 (class 1259 OID 23383)
-- Name: keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."keys" (
    "id" integer NOT NULL,
    "stripe_ts" character varying(255) NOT NULL,
    "stripe_tp" character varying(255) NOT NULL,
    "stripe_ls" character varying(255) NOT NULL,
    "stripe_lp" character varying(255) NOT NULL,
    "recap_pub" character varying(100) NOT NULL,
    "recap_pri" character varying(100) NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 23382)
-- Name: keys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."keys_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3818 (class 0 OID 0)
-- Dependencies: 224
-- Name: keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."keys_id_seq" OWNED BY "public"."keys"."id";


--
-- TOC entry 227 (class 1259 OID 23392)
-- Name: logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."logs" (
    "id" integer NOT NULL,
    "user_id" integer DEFAULT 0 NOT NULL,
    "logdate" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "logtype" character varying(25) NOT NULL,
    "lognote" "text" NOT NULL,
    "ip" character varying(75) DEFAULT NULL::character varying,
    "metadata" "bytea"
);


--
-- TOC entry 226 (class 1259 OID 23391)
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."logs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3819 (class 0 OID 0)
-- Dependencies: 226
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."logs_id_seq" OWNED BY "public"."logs"."id";


--
-- TOC entry 229 (class 1259 OID 23404)
-- Name: menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."menus" (
    "id" integer NOT NULL,
    "menu_title" character varying(255) NOT NULL,
    "parent" integer NOT NULL,
    "dropdown" smallint NOT NULL,
    "logged_in" smallint NOT NULL,
    "display_order" integer NOT NULL,
    "label" character varying(255) NOT NULL,
    "link" character varying(255) NOT NULL,
    "icon_class" character varying(255) NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 23403)
-- Name: menus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."menus_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3820 (class 0 OID 0)
-- Dependencies: 228
-- Name: menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."menus_id_seq" OWNED BY "public"."menus"."id";


--
-- TOC entry 233 (class 1259 OID 23422)
-- Name: message_threads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."message_threads" (
    "id" integer NOT NULL,
    "msg_to" integer NOT NULL,
    "msg_from" integer NOT NULL,
    "msg_subject" character varying(255) NOT NULL,
    "last_update" timestamp without time zone NOT NULL,
    "last_update_by" integer NOT NULL,
    "archive_from" smallint DEFAULT 0 NOT NULL,
    "archive_to" smallint DEFAULT 0 NOT NULL,
    "hidden_from" smallint DEFAULT 0 NOT NULL,
    "hidden_to" smallint DEFAULT 0 NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 23421)
-- Name: message_threads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."message_threads_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3821 (class 0 OID 0)
-- Dependencies: 232
-- Name: message_threads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."message_threads_id_seq" OWNED BY "public"."message_threads"."id";


--
-- TOC entry 231 (class 1259 OID 23413)
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."messages" (
    "id" integer NOT NULL,
    "msg_from" integer NOT NULL,
    "msg_to" integer NOT NULL,
    "msg_body" "text" NOT NULL,
    "msg_read" integer NOT NULL,
    "msg_thread" integer NOT NULL,
    "deleted" integer NOT NULL,
    "sent_on" timestamp without time zone NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 23412)
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."messages_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3822 (class 0 OID 0)
-- Dependencies: 230
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."messages_id_seq" OWNED BY "public"."messages"."id";


--
-- TOC entry 235 (class 1259 OID 23433)
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."notifications" (
    "id" integer NOT NULL,
    "user_id" integer NOT NULL,
    "message" "text" NOT NULL,
    "is_read" smallint NOT NULL,
    "is_archived" smallint DEFAULT 0,
    "date_created" timestamp with time zone,
    "date_read" timestamp with time zone,
    "last_updated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "class" character varying(100) DEFAULT NULL::character varying
);


--
-- TOC entry 234 (class 1259 OID 23432)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."notifications_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3823 (class 0 OID 0)
-- Dependencies: 234
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."notifications_id_seq" OWNED BY "public"."notifications"."id";


--
-- TOC entry 237 (class 1259 OID 23445)
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."pages" (
    "id" integer NOT NULL,
    "page" character varying(255) DEFAULT NULL::character varying,
    "title" character varying(255) DEFAULT NULL::character varying,
    "private" integer DEFAULT 0 NOT NULL,
    "re_auth" integer DEFAULT 0 NOT NULL,
    "core" integer DEFAULT 0
);


--
-- TOC entry 236 (class 1259 OID 23444)
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."pages_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3824 (class 0 OID 0)
-- Dependencies: 236
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."pages_id_seq" OWNED BY "public"."pages"."id";


--
-- TOC entry 241 (class 1259 OID 23466)
-- Name: permission_page_matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."permission_page_matches" (
    "id" integer NOT NULL,
    "permission_id" integer,
    "page_id" integer
);


--
-- TOC entry 240 (class 1259 OID 23465)
-- Name: permission_page_matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."permission_page_matches_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3825 (class 0 OID 0)
-- Dependencies: 240
-- Name: permission_page_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."permission_page_matches_id_seq" OWNED BY "public"."permission_page_matches"."id";


--
-- TOC entry 239 (class 1259 OID 23459)
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."permissions" (
    "id" integer NOT NULL,
    "name" character varying(150) NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 23458)
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."permissions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3826 (class 0 OID 0)
-- Dependencies: 238
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."permissions_id_seq" OWNED BY "public"."permissions"."id";


--
-- TOC entry 243 (class 1259 OID 23473)
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."profiles" (
    "id" integer NOT NULL,
    "user_id" integer NOT NULL,
    "bio" "text" NOT NULL
);


--
-- TOC entry 242 (class 1259 OID 23472)
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."profiles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3827 (class 0 OID 0)
-- Dependencies: 242
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."profiles_id_seq" OWNED BY "public"."profiles"."id";


--
-- TOC entry 245 (class 1259 OID 23482)
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."settings" (
    "id" integer NOT NULL,
    "recaptcha" integer DEFAULT 0 NOT NULL,
    "force_ssl" integer NOT NULL,
    "css_sample" integer NOT NULL,
    "site_name" character varying(100) NOT NULL,
    "language" character varying(255) NOT NULL,
    "site_offline" integer NOT NULL,
    "force_pr" integer NOT NULL,
    "glogin" integer DEFAULT 0 NOT NULL,
    "fblogin" integer NOT NULL,
    "gid" character varying(255) NOT NULL,
    "gsecret" character varying(255) NOT NULL,
    "gredirect" character varying(255) NOT NULL,
    "ghome" character varying(255) NOT NULL,
    "fbid" character varying(255) NOT NULL,
    "fbsecret" character varying(255) NOT NULL,
    "fbcallback" character varying(255) NOT NULL,
    "graph_ver" character varying(255) NOT NULL,
    "finalredir" character varying(255) NOT NULL,
    "req_cap" integer NOT NULL,
    "req_num" integer NOT NULL,
    "min_pw" integer NOT NULL,
    "max_pw" integer NOT NULL,
    "min_un" integer NOT NULL,
    "max_un" integer NOT NULL,
    "messaging" integer NOT NULL,
    "snooping" integer NOT NULL,
    "echouser" integer NOT NULL,
    "wys" integer NOT NULL,
    "change_un" integer NOT NULL,
    "backup_dest" character varying(255) NOT NULL,
    "backup_source" character varying(255) NOT NULL,
    "backup_table" character varying(255) NOT NULL,
    "msg_notification" integer NOT NULL,
    "permission_restriction" integer NOT NULL,
    "auto_assign_un" integer NOT NULL,
    "page_permission_restriction" integer NOT NULL,
    "msg_blocked_users" integer NOT NULL,
    "msg_default_to" integer NOT NULL,
    "notifications" integer NOT NULL,
    "notif_daylimit" integer NOT NULL,
    "recap_public" character varying(100) NOT NULL,
    "recap_private" character varying(100) NOT NULL,
    "page_default_private" integer NOT NULL,
    "navigation_type" smallint NOT NULL,
    "copyright" character varying(255) NOT NULL,
    "custom_settings" integer NOT NULL,
    "system_announcement" character varying(255) NOT NULL,
    "twofa" integer DEFAULT 0,
    "force_notif" smallint,
    "cron_ip" character varying(255) DEFAULT NULL::character varying,
    "registration" smallint,
    "join_vericode_expiry" integer NOT NULL,
    "reset_vericode_expiry" integer NOT NULL,
    "admin_verify" smallint NOT NULL,
    "admin_verify_timeout" integer NOT NULL,
    "session_manager" smallint NOT NULL,
    "template" character varying(255) DEFAULT 'standard'::character varying,
    "saas" smallint,
    "redirect_uri_after_login" "text",
    "show_tos" smallint DEFAULT 1,
    "default_language" character varying(11) DEFAULT NULL::character varying,
    "allow_language" smallint,
    "spice_api" character varying(75) DEFAULT NULL::character varying,
    "announce" timestamp without time zone,
    "bleeding_edge" smallint DEFAULT 0,
    "err_time" integer DEFAULT 15,
    "container_open_class" character varying(255) DEFAULT 'container-fluid'::character varying,
    "debug" smallint DEFAULT 0,
    "widgets" "text"
);


--
-- TOC entry 244 (class 1259 OID 23481)
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."settings_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3828 (class 0 OID 0)
-- Dependencies: 244
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."settings_id_seq" OWNED BY "public"."settings"."id";


--
-- TOC entry 247 (class 1259 OID 23503)
-- Name: updates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."updates" (
    "id" integer NOT NULL,
    "migration" character varying(15) NOT NULL,
    "applied_on" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "update_skipped" smallint
);


--
-- TOC entry 246 (class 1259 OID 23502)
-- Name: updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."updates_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3829 (class 0 OID 0)
-- Dependencies: 246
-- Name: updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."updates_id_seq" OWNED BY "public"."updates"."id";


--
-- TOC entry 256 (class 1259 OID 23564)
-- Name: us_announcements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_announcements" (
    "id" integer NOT NULL,
    "dismissed" integer NOT NULL,
    "link" character varying(255) DEFAULT NULL::character varying,
    "title" character varying(255) DEFAULT NULL::character varying,
    "message" character varying(255) DEFAULT NULL::character varying,
    "ignore" character varying(50) DEFAULT NULL::character varying,
    "class" character varying(50) DEFAULT NULL::character varying
);


--
-- TOC entry 255 (class 1259 OID 23563)
-- Name: us_announcements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_announcements_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3830 (class 0 OID 0)
-- Dependencies: 255
-- Name: us_announcements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_announcements_id_seq" OWNED BY "public"."us_announcements"."id";


--
-- TOC entry 260 (class 1259 OID 23586)
-- Name: us_fingerprint_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_fingerprint_assets" (
    "id" integer NOT NULL,
    "fkFingerprintID" integer NOT NULL,
    "IP_Address" character varying(255) NOT NULL,
    "User_Browser" character varying(255) NOT NULL,
    "User_OS" character varying(255) NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 23585)
-- Name: us_fingerprint_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_fingerprint_assets_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3831 (class 0 OID 0)
-- Dependencies: 259
-- Name: us_fingerprint_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_fingerprint_assets_id_seq" OWNED BY "public"."us_fingerprint_assets"."id";


--
-- TOC entry 258 (class 1259 OID 23578)
-- Name: us_fingerprints; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_fingerprints" (
    "id" integer NOT NULL,
    "fkUserID" integer NOT NULL,
    "Fingerprint" character varying(32) NOT NULL,
    "Fingerprint_Expiry" timestamp without time zone NOT NULL,
    "Fingerprint_Added" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 23577)
-- Name: us_fingerprints_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_fingerprints_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3832 (class 0 OID 0)
-- Dependencies: 257
-- Name: us_fingerprints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_fingerprints_id_seq" OWNED BY "public"."us_fingerprints"."id";


--
-- TOC entry 264 (class 1259 OID 23602)
-- Name: us_form_validation; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_form_validation" (
    "id" integer NOT NULL,
    "value" character varying(255) NOT NULL,
    "description" character varying(255) NOT NULL,
    "params" character varying(255) NOT NULL
);


--
-- TOC entry 263 (class 1259 OID 23601)
-- Name: us_form_validation_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_form_validation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3833 (class 0 OID 0)
-- Dependencies: 263
-- Name: us_form_validation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_form_validation_id_seq" OWNED BY "public"."us_form_validation"."id";


--
-- TOC entry 266 (class 1259 OID 23611)
-- Name: us_form_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_form_views" (
    "id" integer NOT NULL,
    "form_name" character varying(255) NOT NULL,
    "view_name" character varying(255) NOT NULL,
    "fields" "text" NOT NULL
);


--
-- TOC entry 265 (class 1259 OID 23610)
-- Name: us_form_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_form_views_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3834 (class 0 OID 0)
-- Dependencies: 265
-- Name: us_form_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_form_views_id_seq" OWNED BY "public"."us_form_views"."id";


--
-- TOC entry 262 (class 1259 OID 23595)
-- Name: us_forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_forms" (
    "id" integer NOT NULL,
    "form" character varying(255) NOT NULL
);


--
-- TOC entry 261 (class 1259 OID 23594)
-- Name: us_forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_forms_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3835 (class 0 OID 0)
-- Dependencies: 261
-- Name: us_forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_forms_id_seq" OWNED BY "public"."us_forms"."id";


--
-- TOC entry 268 (class 1259 OID 23620)
-- Name: us_ip_blacklist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_ip_blacklist" (
    "id" integer NOT NULL,
    "ip" character varying(50) NOT NULL,
    "last_user" integer DEFAULT 0 NOT NULL,
    "reason" integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 23619)
-- Name: us_ip_blacklist_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_ip_blacklist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3836 (class 0 OID 0)
-- Dependencies: 267
-- Name: us_ip_blacklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_ip_blacklist_id_seq" OWNED BY "public"."us_ip_blacklist"."id";


--
-- TOC entry 270 (class 1259 OID 23629)
-- Name: us_ip_list; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_ip_list" (
    "id" integer NOT NULL,
    "ip" character varying(50) NOT NULL,
    "user_id" integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 269 (class 1259 OID 23628)
-- Name: us_ip_list_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_ip_list_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3837 (class 0 OID 0)
-- Dependencies: 269
-- Name: us_ip_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_ip_list_id_seq" OWNED BY "public"."us_ip_list"."id";


--
-- TOC entry 272 (class 1259 OID 23637)
-- Name: us_ip_whitelist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_ip_whitelist" (
    "id" integer NOT NULL,
    "ip" character varying(50) NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 23636)
-- Name: us_ip_whitelist_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_ip_whitelist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3838 (class 0 OID 0)
-- Dependencies: 271
-- Name: us_ip_whitelist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_ip_whitelist_id_seq" OWNED BY "public"."us_ip_whitelist"."id";


--
-- TOC entry 274 (class 1259 OID 23644)
-- Name: us_management; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_management" (
    "id" integer NOT NULL,
    "page" character varying(255) NOT NULL,
    "view" character varying(255) NOT NULL,
    "feature" character varying(255) NOT NULL,
    "access" character varying(255) NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 23643)
-- Name: us_management_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_management_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3839 (class 0 OID 0)
-- Dependencies: 273
-- Name: us_management_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_management_id_seq" OWNED BY "public"."us_management"."id";


--
-- TOC entry 278 (class 1259 OID 23668)
-- Name: us_menu_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_menu_items" (
    "id" integer NOT NULL,
    "menu" integer NOT NULL,
    "type" character varying(50) DEFAULT NULL::character varying,
    "label" character varying(255) DEFAULT NULL::character varying,
    "link" "text",
    "icon_class" character varying(255) DEFAULT NULL::character varying,
    "li_class" character varying(255) DEFAULT NULL::character varying,
    "a_class" character varying(255) DEFAULT NULL::character varying,
    "link_target" character varying(50) DEFAULT NULL::character varying,
    "parent" integer,
    "display_order" integer,
    "disabled" smallint DEFAULT 0,
    "permissions" character varying(1000) DEFAULT NULL::character varying
);


--
-- TOC entry 277 (class 1259 OID 23667)
-- Name: us_menu_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_menu_items_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3840 (class 0 OID 0)
-- Dependencies: 277
-- Name: us_menu_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_menu_items_id_seq" OWNED BY "public"."us_menu_items"."id";


--
-- TOC entry 276 (class 1259 OID 23653)
-- Name: us_menus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_menus" (
    "id" integer NOT NULL,
    "menu_name" character varying(255) DEFAULT NULL::character varying,
    "type" character varying(75) DEFAULT NULL::character varying,
    "nav_class" character varying(255) DEFAULT NULL::character varying,
    "theme" character varying(25) DEFAULT NULL::character varying,
    "z_index" integer,
    "brand_html" "text",
    "disabled" smallint DEFAULT 0,
    "justify" character varying(10) DEFAULT 'right'::character varying
);


--
-- TOC entry 275 (class 1259 OID 23652)
-- Name: us_menus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_menus_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3841 (class 0 OID 0)
-- Dependencies: 275
-- Name: us_menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_menus_id_seq" OWNED BY "public"."us_menus"."id";


--
-- TOC entry 282 (class 1259 OID 23697)
-- Name: us_plugin_hooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_plugin_hooks" (
    "id" integer NOT NULL,
    "page" character varying(255) NOT NULL,
    "folder" character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    "hook" character varying(255) NOT NULL,
    "disabled" smallint DEFAULT 0
);


--
-- TOC entry 281 (class 1259 OID 23696)
-- Name: us_plugin_hooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_plugin_hooks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3842 (class 0 OID 0)
-- Dependencies: 281
-- Name: us_plugin_hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_plugin_hooks_id_seq" OWNED BY "public"."us_plugin_hooks"."id";


--
-- TOC entry 280 (class 1259 OID 23685)
-- Name: us_plugins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_plugins" (
    "id" integer NOT NULL,
    "plugin" character varying(255) DEFAULT NULL::character varying,
    "status" character varying(255) DEFAULT NULL::character varying,
    "updates" "text",
    "last_check" timestamp with time zone DEFAULT '2020-01-01 01:00:00+01'::timestamp with time zone
);


--
-- TOC entry 279 (class 1259 OID 23684)
-- Name: us_plugins_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_plugins_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3843 (class 0 OID 0)
-- Dependencies: 279
-- Name: us_plugins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_plugins_id_seq" OWNED BY "public"."us_plugins"."id";


--
-- TOC entry 284 (class 1259 OID 23707)
-- Name: us_saas_levels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_saas_levels" (
    "id" integer NOT NULL,
    "level" character varying(255) NOT NULL,
    "users" integer NOT NULL,
    "details" "text" NOT NULL
);


--
-- TOC entry 283 (class 1259 OID 23706)
-- Name: us_saas_levels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_saas_levels_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3844 (class 0 OID 0)
-- Dependencies: 283
-- Name: us_saas_levels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_saas_levels_id_seq" OWNED BY "public"."us_saas_levels"."id";


--
-- TOC entry 286 (class 1259 OID 23716)
-- Name: us_saas_orgs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_saas_orgs" (
    "id" integer NOT NULL,
    "org" character varying(255) NOT NULL,
    "owner" integer NOT NULL,
    "level" integer NOT NULL,
    "active" integer DEFAULT 1 NOT NULL
);


--
-- TOC entry 285 (class 1259 OID 23715)
-- Name: us_saas_orgs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_saas_orgs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3845 (class 0 OID 0)
-- Dependencies: 285
-- Name: us_saas_orgs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_saas_orgs_id_seq" OWNED BY "public"."us_saas_orgs"."id";


--
-- TOC entry 288 (class 1259 OID 23724)
-- Name: us_user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."us_user_sessions" (
    "id" integer NOT NULL,
    "fkUserID" integer NOT NULL,
    "UserFingerprint" character varying(255) NOT NULL,
    "UserSessionIP" character varying(255) NOT NULL,
    "UserSessionOS" character varying(255) NOT NULL,
    "UserSessionBrowser" character varying(255) NOT NULL,
    "UserSessionStarted" timestamp without time zone NOT NULL,
    "UserSessionLastUsed" timestamp without time zone,
    "UserSessionLastPage" character varying(255) NOT NULL,
    "UserSessionEnded" smallint DEFAULT 0 NOT NULL,
    "UserSessionEnded_Time" timestamp without time zone
);


--
-- TOC entry 287 (class 1259 OID 23723)
-- Name: us_user_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."us_user_sessions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3846 (class 0 OID 0)
-- Dependencies: 287
-- Name: us_user_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."us_user_sessions_id_seq" OWNED BY "public"."us_user_sessions"."id";


--
-- TOC entry 254 (class 1259 OID 23557)
-- Name: user_permission_matches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."user_permission_matches" (
    "id" integer NOT NULL,
    "user_id" integer NOT NULL,
    "permission_id" integer NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 23556)
-- Name: user_permission_matches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."user_permission_matches_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3847 (class 0 OID 0)
-- Dependencies: 253
-- Name: user_permission_matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."user_permission_matches_id_seq" OWNED BY "public"."user_permission_matches"."id";


--
-- TOC entry 249 (class 1259 OID 23511)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users" (
    "id" integer NOT NULL,
    "permissions" smallint NOT NULL,
    "email" character varying(155) NOT NULL,
    "email_new" character varying(155) DEFAULT NULL::character varying,
    "username" character varying(255) NOT NULL,
    "password" character varying(255) DEFAULT NULL::character varying,
    "pin" character varying(255) DEFAULT NULL::character varying,
    "fname" character varying(255) NOT NULL,
    "lname" character varying(255) NOT NULL,
    "language" character varying(255) DEFAULT 'en-US'::character varying,
    "email_verified" smallint DEFAULT 0 NOT NULL,
    "vericode" character varying(15) DEFAULT NULL::character varying,
    "vericode_expiry" timestamp without time zone,
    "oauth_provider" character varying(255) DEFAULT NULL::character varying,
    "oauth_uid" character varying(255) DEFAULT NULL::character varying,
    "gender" character varying(10) NOT NULL,
    "locale" character varying(10) NOT NULL,
    "gpluslink" character varying(255) DEFAULT NULL::character varying,
    "account_owner" smallint DEFAULT 1 NOT NULL,
    "account_id" integer DEFAULT 0 NOT NULL,
    "account_mgr" integer DEFAULT 0 NOT NULL,
    "fb_uid" character varying(255) DEFAULT NULL::character varying,
    "picture" character varying(255) DEFAULT NULL::character varying,
    "created" timestamp without time zone NOT NULL,
    "protected" smallint DEFAULT 0 NOT NULL,
    "msg_exempt" smallint DEFAULT 0 NOT NULL,
    "dev_user" smallint DEFAULT 0 NOT NULL,
    "msg_notification" smallint DEFAULT 1 NOT NULL,
    "cloak_allowed" smallint DEFAULT 0 NOT NULL,
    "oauth_tos_accepted" smallint,
    "un_changed" smallint DEFAULT 0 NOT NULL,
    "force_pr" smallint DEFAULT 0 NOT NULL,
    "logins" integer DEFAULT 0 NOT NULL,
    "last_login" timestamp without time zone,
    "join_date" timestamp without time zone,
    "modified" timestamp without time zone,
    "active" smallint DEFAULT 1
);


--
-- TOC entry 248 (class 1259 OID 23510)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."users_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3848 (class 0 OID 0)
-- Dependencies: 248
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."users_id_seq" OWNED BY "public"."users"."id";


--
-- TOC entry 250 (class 1259 OID 23542)
-- Name: users_online; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users_online" (
    "id" integer NOT NULL,
    "ip" character varying(15) NOT NULL,
    "timestamp" character varying(15) NOT NULL,
    "user_id" integer,
    "session" character varying(50) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 23548)
-- Name: users_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."users_session" (
    "id" integer NOT NULL,
    "user_id" integer NOT NULL,
    "hash" character varying(255) NOT NULL,
    "uagent" "text"
);


--
-- TOC entry 251 (class 1259 OID 23547)
-- Name: users_session_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."users_session_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3849 (class 0 OID 0)
-- Dependencies: 251
-- Name: users_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."users_session_id_seq" OWNED BY "public"."users_session"."id";


--
-- TOC entry 3385 (class 2604 OID 23336)
-- Name: audit id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."audit" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."audit_id_seq"'::"regclass");


--
-- TOC entry 3387 (class 2604 OID 23346)
-- Name: crons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."crons" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."crons_id_seq"'::"regclass");


--
-- TOC entry 3390 (class 2604 OID 23357)
-- Name: crons_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."crons_logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."crons_logs_id_seq"'::"regclass");


--
-- TOC entry 3392 (class 2604 OID 23365)
-- Name: email id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."email" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."email_id_seq"'::"regclass");


--
-- TOC entry 3398 (class 2604 OID 23379)
-- Name: groups_menus id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."groups_menus" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."groups_menus_id_seq"'::"regclass");


--
-- TOC entry 3399 (class 2604 OID 23386)
-- Name: keys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."keys" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."keys_id_seq"'::"regclass");


--
-- TOC entry 3400 (class 2604 OID 23395)
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."logs_id_seq"'::"regclass");


--
-- TOC entry 3404 (class 2604 OID 23407)
-- Name: menus id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."menus" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."menus_id_seq"'::"regclass");


--
-- TOC entry 3406 (class 2604 OID 23425)
-- Name: message_threads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."message_threads" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."message_threads_id_seq"'::"regclass");


--
-- TOC entry 3405 (class 2604 OID 23416)
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."messages" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."messages_id_seq"'::"regclass");


--
-- TOC entry 3411 (class 2604 OID 23436)
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."notifications" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."notifications_id_seq"'::"regclass");


--
-- TOC entry 3415 (class 2604 OID 23448)
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."pages" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."pages_id_seq"'::"regclass");


--
-- TOC entry 3422 (class 2604 OID 23469)
-- Name: permission_page_matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permission_page_matches" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."permission_page_matches_id_seq"'::"regclass");


--
-- TOC entry 3421 (class 2604 OID 23462)
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permissions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."permissions_id_seq"'::"regclass");


--
-- TOC entry 3423 (class 2604 OID 23476)
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."profiles" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."profiles_id_seq"'::"regclass");


--
-- TOC entry 3424 (class 2604 OID 23485)
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."settings" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."settings_id_seq"'::"regclass");


--
-- TOC entry 3437 (class 2604 OID 23506)
-- Name: updates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."updates" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."updates_id_seq"'::"regclass");


--
-- TOC entry 3465 (class 2604 OID 23567)
-- Name: us_announcements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_announcements" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_announcements_id_seq"'::"regclass");


--
-- TOC entry 3473 (class 2604 OID 23589)
-- Name: us_fingerprint_assets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_fingerprint_assets" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_fingerprint_assets_id_seq"'::"regclass");


--
-- TOC entry 3471 (class 2604 OID 23581)
-- Name: us_fingerprints id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_fingerprints" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_fingerprints_id_seq"'::"regclass");


--
-- TOC entry 3475 (class 2604 OID 23605)
-- Name: us_form_validation id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_form_validation" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_form_validation_id_seq"'::"regclass");


--
-- TOC entry 3476 (class 2604 OID 23614)
-- Name: us_form_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_form_views" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_form_views_id_seq"'::"regclass");


--
-- TOC entry 3474 (class 2604 OID 23598)
-- Name: us_forms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_forms" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_forms_id_seq"'::"regclass");


--
-- TOC entry 3477 (class 2604 OID 23623)
-- Name: us_ip_blacklist id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_ip_blacklist" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_ip_blacklist_id_seq"'::"regclass");


--
-- TOC entry 3480 (class 2604 OID 23632)
-- Name: us_ip_list id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_ip_list" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_ip_list_id_seq"'::"regclass");


--
-- TOC entry 3482 (class 2604 OID 23640)
-- Name: us_ip_whitelist id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_ip_whitelist" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_ip_whitelist_id_seq"'::"regclass");


--
-- TOC entry 3483 (class 2604 OID 23647)
-- Name: us_management id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_management" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_management_id_seq"'::"regclass");


--
-- TOC entry 3491 (class 2604 OID 23671)
-- Name: us_menu_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_menu_items" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_menu_items_id_seq"'::"regclass");


--
-- TOC entry 3484 (class 2604 OID 23656)
-- Name: us_menus id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_menus" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_menus_id_seq"'::"regclass");


--
-- TOC entry 3504 (class 2604 OID 23700)
-- Name: us_plugin_hooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_plugin_hooks" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_plugin_hooks_id_seq"'::"regclass");


--
-- TOC entry 3500 (class 2604 OID 23688)
-- Name: us_plugins id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_plugins" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_plugins_id_seq"'::"regclass");


--
-- TOC entry 3506 (class 2604 OID 23710)
-- Name: us_saas_levels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_saas_levels" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_saas_levels_id_seq"'::"regclass");


--
-- TOC entry 3507 (class 2604 OID 23719)
-- Name: us_saas_orgs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_saas_orgs" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_saas_orgs_id_seq"'::"regclass");


--
-- TOC entry 3509 (class 2604 OID 23727)
-- Name: us_user_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_user_sessions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."us_user_sessions_id_seq"'::"regclass");


--
-- TOC entry 3464 (class 2604 OID 23560)
-- Name: user_permission_matches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."user_permission_matches" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."user_permission_matches_id_seq"'::"regclass");


--
-- TOC entry 3439 (class 2604 OID 23514)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."users_id_seq"'::"regclass");


--
-- TOC entry 3463 (class 2604 OID 23551)
-- Name: users_session id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_session" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."users_session_id_seq"'::"regclass");


--
-- TOC entry 3733 (class 0 OID 23333)
-- Dependencies: 215
-- Data for Name: audit; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3735 (class 0 OID 23343)
-- Dependencies: 217
-- Data for Name: crons; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."crons" VALUES (1, 0, 100, 'Auto-Backup', 'backup.php', 1, '2017-09-16 07:49:22', '2017-11-11 20:15:36');


--
-- TOC entry 3737 (class 0 OID 23354)
-- Dependencies: 219
-- Data for Name: crons_logs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3739 (class 0 OID 23362)
-- Dependencies: 221
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."email" VALUES (1, 'User Spice', 'smtp.gmail.com', 587, 'yourEmail@gmail.com', '1234', 'User Spice', 'yourEmail@gmail.com', 'tls', 'http://localhost/userspice', 0, 0, 0, 'true', 'true', 'CRAM-MD5');


--
-- TOC entry 3741 (class 0 OID 23376)
-- Dependencies: 223
-- Data for Name: groups_menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."groups_menus" VALUES (5, 0, 3);
INSERT INTO "public"."groups_menus" VALUES (6, 0, 1);
INSERT INTO "public"."groups_menus" VALUES (7, 0, 2);
INSERT INTO "public"."groups_menus" VALUES (8, 0, 51);
INSERT INTO "public"."groups_menus" VALUES (9, 0, 52);
INSERT INTO "public"."groups_menus" VALUES (10, 0, 37);
INSERT INTO "public"."groups_menus" VALUES (11, 0, 38);
INSERT INTO "public"."groups_menus" VALUES (12, 2, 39);
INSERT INTO "public"."groups_menus" VALUES (13, 2, 40);
INSERT INTO "public"."groups_menus" VALUES (14, 2, 41);
INSERT INTO "public"."groups_menus" VALUES (15, 2, 42);
INSERT INTO "public"."groups_menus" VALUES (16, 2, 43);
INSERT INTO "public"."groups_menus" VALUES (17, 2, 44);
INSERT INTO "public"."groups_menus" VALUES (18, 2, 45);
INSERT INTO "public"."groups_menus" VALUES (19, 0, 46);
INSERT INTO "public"."groups_menus" VALUES (20, 0, 47);
INSERT INTO "public"."groups_menus" VALUES (21, 0, 49);
INSERT INTO "public"."groups_menus" VALUES (25, 0, 18);
INSERT INTO "public"."groups_menus" VALUES (26, 0, 20);
INSERT INTO "public"."groups_menus" VALUES (27, 0, 21);
INSERT INTO "public"."groups_menus" VALUES (28, 0, 7);
INSERT INTO "public"."groups_menus" VALUES (29, 0, 8);
INSERT INTO "public"."groups_menus" VALUES (30, 2, 9);
INSERT INTO "public"."groups_menus" VALUES (31, 2, 10);
INSERT INTO "public"."groups_menus" VALUES (32, 2, 11);
INSERT INTO "public"."groups_menus" VALUES (33, 2, 12);
INSERT INTO "public"."groups_menus" VALUES (34, 2, 13);
INSERT INTO "public"."groups_menus" VALUES (35, 2, 14);
INSERT INTO "public"."groups_menus" VALUES (36, 2, 15);
INSERT INTO "public"."groups_menus" VALUES (37, 0, 16);
INSERT INTO "public"."groups_menus" VALUES (38, 1, 15);


--
-- TOC entry 3743 (class 0 OID 23383)
-- Dependencies: 225
-- Data for Name: keys; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3745 (class 0 OID 23392)
-- Dependencies: 227
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."logs" VALUES (1, 1, '2022-12-23 12:05:38', 'System Updates', 'Update 2022-05-04a successfully deployed.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (2, 1, '2022-12-23 12:05:43', 'login', 'User logged in.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (3, 1, '2022-12-23 12:06:38', 'System Updates', 'Update 2022-11-06a successfully deployed.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (4, 1, '2022-12-23 12:06:38', 'System Updates', 'Update 2022-11-20a successfully deployed.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (5, 1, '2022-12-23 12:06:38', 'System Updates', 'Update 2022-12-04a successfully deployed.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (6, 1, '2022-12-23 12:06:38', 'System Updates', 'Update 2022-12-22a successfully deployed.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (7, 1, '2022-12-23 12:06:38', 'System Updates', 'Update 2022-12-23a successfully deployed.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (8, 1, '2022-12-23 12:16:27', 'login', 'User logged in.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (9, 1, '2023-05-20 12:24:29', 'login', 'User logged in.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (10, 1, '2023-05-20 12:25:09', 'Email Settings', 'Updated isSMTP from  to 0.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (11, 1, '2023-05-20 12:25:09', 'Email Settings', 'Updated isHTML from  to true.', '::1', NULL);
INSERT INTO "public"."logs" VALUES (12, 1, '2023-05-20 12:25:09', 'Email Settings', 'Updated useSMTPauth from  to true.', '::1', NULL);


--
-- TOC entry 3747 (class 0 OID 23404)
-- Dependencies: 229
-- Data for Name: menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."menus" VALUES (1, 'main', 2, 0, 1, 1, '{{home}}', '', 'fa fa-fw fa-home');
INSERT INTO "public"."menus" VALUES (2, 'main', -1, 1, 1, 14, '', '', 'fa fa-fw fa-cogs');
INSERT INTO "public"."menus" VALUES (3, 'main', -1, 0, 1, 11, '{{username}}', 'users/account.php', 'fa fa-fw fa-user');
INSERT INTO "public"."menus" VALUES (4, 'main', -1, 1, 0, 3, '{{help}}', '', 'fa fa-fw fa-life-ring');
INSERT INTO "public"."menus" VALUES (5, 'main', -1, 0, 0, 2, '{{register}}', 'users/join.php', 'fa fa-fw fa-plus-square');
INSERT INTO "public"."menus" VALUES (6, 'main', -1, 0, 0, 1, '{{login}}', 'users/login.php', 'fa fa-fw fa-sign-in');
INSERT INTO "public"."menus" VALUES (7, 'main', 2, 0, 1, 2, '{{account}}', 'users/account.php', 'fa fa-fw fa-user');
INSERT INTO "public"."menus" VALUES (8, 'main', 2, 0, 1, 3, '{{hr}}', '', '');
INSERT INTO "public"."menus" VALUES (9, 'main', 2, 0, 1, 4, '{{dashboard}}', 'users/admin.php', 'fa fa-fw fa-cogs');
INSERT INTO "public"."menus" VALUES (10, 'main', 2, 0, 1, 5, '{{users}}', 'users/admin.php?view=users', 'fa fa-fw fa-user');
INSERT INTO "public"."menus" VALUES (11, 'main', 2, 0, 1, 6, '{{perms}}', 'users/admin.php?view=permissions', 'fa fa-fw fa-lock');
INSERT INTO "public"."menus" VALUES (12, 'main', 2, 0, 1, 7, '{{pages}}', 'users/admin.php?view=pages', 'fa fa-fw fa-wrench');
INSERT INTO "public"."menus" VALUES (13, 'main', 2, 0, 1, 9, '{{logs}}', 'users/admin.php?view=logs', 'fa fa-fw fa-search');
INSERT INTO "public"."menus" VALUES (14, 'main', 2, 0, 1, 10, '{{hr}}', '', '');
INSERT INTO "public"."menus" VALUES (15, 'main', 2, 0, 1, 11, '{{logout}}', 'users/logout.php', 'fa fa-fw fa-sign-out');
INSERT INTO "public"."menus" VALUES (16, 'main', -1, 0, 0, 0, '{{home}}', '', 'fa fa-fw fa-home');
INSERT INTO "public"."menus" VALUES (17, 'main', -1, 0, 1, 10, '{{home}}', '', 'fa fa-fw fa-home');
INSERT INTO "public"."menus" VALUES (18, 'main', 4, 0, 0, 1, '{{forgot}}', 'users/forgot_password.php', 'fa fa-fw fa-wrench');
INSERT INTO "public"."menus" VALUES (20, 'main', 4, 0, 0, 99999, '{{resend}}', 'users/verify_resend.php', 'fa fa-exclamation-triangle');


--
-- TOC entry 3751 (class 0 OID 23422)
-- Dependencies: 233
-- Data for Name: message_threads; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3749 (class 0 OID 23413)
-- Dependencies: 231
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3753 (class 0 OID 23433)
-- Dependencies: 235
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3755 (class 0 OID 23445)
-- Dependencies: 237
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."pages" VALUES (1, 'index.php', 'Home', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (2, 'z_us_root.php', '', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (3, 'users/account.php', 'Account Dashboard', 1, 0, 1);
INSERT INTO "public"."pages" VALUES (4, 'users/admin.php', 'Admin Dashboard', 1, 0, 1);
INSERT INTO "public"."pages" VALUES (14, 'users/forgot_password.php', 'Forgotten Password', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (15, 'users/forgot_password_reset.php', 'Reset Forgotten Password', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (16, 'users/index.php', 'Home', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (17, 'users/init.php', '', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (18, 'users/join.php', 'Join', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (20, 'users/login.php', 'Login', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (21, 'users/logout.php', 'Logout', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (24, 'users/user_settings.php', 'User Settings', 1, 0, 1);
INSERT INTO "public"."pages" VALUES (25, 'users/verify.php', 'Account Verification', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (26, 'users/verify_resend.php', 'Account Verification', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (45, 'users/maintenance.php', 'Maintenance', 0, 0, 1);
INSERT INTO "public"."pages" VALUES (68, 'users/update.php', 'Update Manager', 1, 0, 1);
INSERT INTO "public"."pages" VALUES (81, 'users/admin_pin.php', 'Verification PIN Set', 1, 0, 1);
INSERT INTO "public"."pages" VALUES (90, 'users/complete.php', NULL, 1, 0, 0);


--
-- TOC entry 3759 (class 0 OID 23466)
-- Dependencies: 241
-- Data for Name: permission_page_matches; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."permission_page_matches" VALUES (3, 1, 24);
INSERT INTO "public"."permission_page_matches" VALUES (14, 2, 4);
INSERT INTO "public"."permission_page_matches" VALUES (15, 1, 3);
INSERT INTO "public"."permission_page_matches" VALUES (38, 2, 68);
INSERT INTO "public"."permission_page_matches" VALUES (54, 1, 81);


--
-- TOC entry 3757 (class 0 OID 23459)
-- Dependencies: 239
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."permissions" VALUES (1, 'User');
INSERT INTO "public"."permissions" VALUES (2, 'Administrator');


--
-- TOC entry 3761 (class 0 OID 23473)
-- Dependencies: 243
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."profiles" VALUES (1, 1, '&lt;h1&gt;This is the Admin&#039;s bio.&lt;/h1&gt;');
INSERT INTO "public"."profiles" VALUES (2, 2, 'This is your bio');


--
-- TOC entry 3763 (class 0 OID 23482)
-- Dependencies: 245
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."settings" VALUES (1, 0, 0, 0, 'UserSpice', 'en', 0, 0, 0, 0, '', '', '', '', '', '', '', '', '', 0, 0, 6, 150, 4, 30, 0, 1, 0, 1, 0, '/', 'everything', '', 0, 0, 0, 0, 0, 1, 0, 7, '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI', '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe', 1, 1, 'UserSpice', 1, '', 0, 0, 'off', 1, 24, 15, 1, 120, 0, 'bs5', NULL, NULL, 1, 'en-US', 0, NULL, '2023-05-20 12:24:29', 0, 15, 'container-fluid', 0, 'settings,misc,tools,plugins,snapshot,active_users,active-users');


--
-- TOC entry 3765 (class 0 OID 23503)
-- Dependencies: 247
-- Data for Name: updates; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."updates" VALUES (15, '1XdrInkjV86F', '2018-02-18 22:33:24', NULL);
INSERT INTO "public"."updates" VALUES (16, '3GJYaKcqUtw7', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (17, '3GJYaKcqUtz8', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (18, '69qa8h6E1bzG', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (19, '2XQjsKYJAfn1', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (20, '549DLFeHMNw7', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (21, '4Dgt2XVjgz2x', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (22, 'VLBp32gTWvEo', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (23, 'Q3KlhjdtxE5X', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (24, 'ug5D3pVrNvfS', '2018-04-25 16:51:08', NULL);
INSERT INTO "public"."updates" VALUES (25, '69FbVbv4Jtrz', '2018-04-25 16:51:09', NULL);
INSERT INTO "public"."updates" VALUES (26, '4A6BdJHyvP4a', '2018-04-25 16:51:09', NULL);
INSERT INTO "public"."updates" VALUES (27, '37wvsb5BzymK', '2018-04-25 16:51:09', NULL);
INSERT INTO "public"."updates" VALUES (28, 'c7tZQf926zKq', '2018-04-25 16:51:09', NULL);
INSERT INTO "public"."updates" VALUES (29, 'ockrg4eU33GP', '2018-04-25 16:51:09', NULL);
INSERT INTO "public"."updates" VALUES (30, 'XX4zArPs4tor', '2018-04-25 16:51:09', NULL);
INSERT INTO "public"."updates" VALUES (31, 'pv7r2EHbVvhD', '2018-04-26 00:00:00', NULL);
INSERT INTO "public"."updates" VALUES (32, 'uNT7NpgcBDFD', '2018-04-26 00:00:00', NULL);
INSERT INTO "public"."updates" VALUES (33, 'mS5VtQCZjyJs', '2018-12-11 14:19:16', NULL);
INSERT INTO "public"."updates" VALUES (34, '23rqAv5elJ3G', '2018-12-11 14:19:51', NULL);
INSERT INTO "public"."updates" VALUES (35, 'qPEARSh49fob', '2019-01-01 12:01:01', NULL);
INSERT INTO "public"."updates" VALUES (36, 'FyMYJ2oeGCTX', '2019-01-01 12:01:01', NULL);
INSERT INTO "public"."updates" VALUES (37, 'iit5tHSLatiS', '2019-01-01 12:01:01', NULL);
INSERT INTO "public"."updates" VALUES (38, 'hcA5B3PLhq6E', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (39, 'VNEno3E4zaNz', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (40, '2ZB9mg1l0JXe', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (41, 'B9t6He7qmFXa', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (42, '86FkFVV4TGRg', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (43, 'y4A1Y0u9n2Rt', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (44, 'Tm5xY22MM8eC', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (45, '0YXdrInkjV86F', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (46, '99plgnkjV86', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (47, '0DaShInkjV86', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (48, '0DaShInkjVz1', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (49, 'y4A1Y0u9n2SS', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (50, '0DaShInkjV87', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (51, '0DaShInkjV88', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (52, '2019-09-04a', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (53, '2019-09-05a', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (54, '2019-09-26a', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (55, '2019-11-19a', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (56, '2019-12-28a', '2020-07-16 11:27:53', NULL);
INSERT INTO "public"."updates" VALUES (57, '2020-01-21a', '2020-07-16 11:27:54', NULL);
INSERT INTO "public"."updates" VALUES (58, '2020-03-26a', '2020-07-16 11:27:54', NULL);
INSERT INTO "public"."updates" VALUES (59, '2020-04-17a', '2020-07-16 11:27:54', NULL);
INSERT INTO "public"."updates" VALUES (60, '2020-06-06a', '2020-07-16 11:27:54', NULL);
INSERT INTO "public"."updates" VALUES (61, '2020-06-30a', '2020-07-16 11:27:54', NULL);
INSERT INTO "public"."updates" VALUES (62, '2020-07-01a', '2020-07-16 11:27:54', NULL);
INSERT INTO "public"."updates" VALUES (63, '2020-07-16a', '2020-10-08 01:26:22', NULL);
INSERT INTO "public"."updates" VALUES (64, '2020-07-30a', '2020-10-08 01:26:22', NULL);
INSERT INTO "public"."updates" VALUES (65, '2020-10-06a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (66, '2020-11-03a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (67, '2020-11-08a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (68, '2020-11-10a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (69, '2020-11-10b', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (70, '2020-12-17a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (71, '2020-12-28a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (72, '2021-01-20a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (73, '2021-02-16a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (74, '2021-04-14a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (75, '2021-04-15a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (76, '2021-05-20a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (77, '2021-07-11a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (78, '2021-08-22a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (79, '2021-08-24a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (80, '2021-09-25a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (81, '2021-12-26a', '2022-04-15 17:37:11', NULL);
INSERT INTO "public"."updates" VALUES (82, '2022-05-04a', '2022-12-23 12:05:38', NULL);
INSERT INTO "public"."updates" VALUES (83, '2022-11-06a', '2022-12-23 12:06:38', NULL);
INSERT INTO "public"."updates" VALUES (84, '2022-11-20a', '2022-12-23 12:06:38', NULL);
INSERT INTO "public"."updates" VALUES (85, '2022-12-04a', '2022-12-23 12:06:38', NULL);
INSERT INTO "public"."updates" VALUES (86, '2022-12-22a', '2022-12-23 12:06:38', NULL);
INSERT INTO "public"."updates" VALUES (87, '2022-12-23a', '2022-12-23 12:06:38', NULL);


--
-- TOC entry 3774 (class 0 OID 23564)
-- Dependencies: 256
-- Data for Name: us_announcements; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3778 (class 0 OID 23586)
-- Dependencies: 260
-- Data for Name: us_fingerprint_assets; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3776 (class 0 OID 23578)
-- Dependencies: 258
-- Data for Name: us_fingerprints; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3782 (class 0 OID 23602)
-- Dependencies: 264
-- Data for Name: us_form_validation; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."us_form_validation" VALUES (1, 'min', 'Minimum # of Characters', 'number');
INSERT INTO "public"."us_form_validation" VALUES (2, 'max', 'Maximum # of Characters', 'number');
INSERT INTO "public"."us_form_validation" VALUES (3, 'is_numeric', 'Must be a number', 'true');
INSERT INTO "public"."us_form_validation" VALUES (4, 'valid_email', 'Must be a valid email address', 'true');
INSERT INTO "public"."us_form_validation" VALUES (5, '<', 'Must be a number less than', 'number');
INSERT INTO "public"."us_form_validation" VALUES (6, '>', 'Must be a number greater than', 'number');
INSERT INTO "public"."us_form_validation" VALUES (7, '<=', 'Must be a number less than or equal to', 'number');
INSERT INTO "public"."us_form_validation" VALUES (8, '>=', 'Must be a number greater than or equal to', 'number');
INSERT INTO "public"."us_form_validation" VALUES (9, '!=', 'Must not be equal to', 'text');
INSERT INTO "public"."us_form_validation" VALUES (10, '==', 'Must be equal to', 'text');
INSERT INTO "public"."us_form_validation" VALUES (11, 'is_integer', 'Must be an integer', 'true');
INSERT INTO "public"."us_form_validation" VALUES (12, 'is_timezone', 'Must be a valid timezone name', 'true');
INSERT INTO "public"."us_form_validation" VALUES (13, 'is_datetime', 'Must be a valid DateTime', 'true');


--
-- TOC entry 3784 (class 0 OID 23611)
-- Dependencies: 266
-- Data for Name: us_form_views; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3780 (class 0 OID 23595)
-- Dependencies: 262
-- Data for Name: us_forms; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3786 (class 0 OID 23620)
-- Dependencies: 268
-- Data for Name: us_ip_blacklist; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3788 (class 0 OID 23629)
-- Dependencies: 270
-- Data for Name: us_ip_list; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."us_ip_list" VALUES (2, '::1', 1, '2022-12-23 12:05:43');


--
-- TOC entry 3790 (class 0 OID 23637)
-- Dependencies: 272
-- Data for Name: us_ip_whitelist; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3792 (class 0 OID 23644)
-- Dependencies: 274
-- Data for Name: us_management; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."us_management" VALUES (1, '_admin_manage_ip.php', 'ip', 'IP Whitelist/Blacklist', '');
INSERT INTO "public"."us_management" VALUES (2, '_admin_nav.php', 'nav', 'Navigation [List/Add/Delete]', '');
INSERT INTO "public"."us_management" VALUES (3, '_admin_nav_item.php', 'nav_item', 'Navigation [View/Edit]', '');
INSERT INTO "public"."us_management" VALUES (4, '_admin_pages.php', 'pages', 'Page Management [List]', '');
INSERT INTO "public"."us_management" VALUES (5, '_admin_page.php', 'page', 'Page Management [View/Edit]', '');
INSERT INTO "public"."us_management" VALUES (6, '_admin_security_logs.php', 'security_logs', 'Security Logs', '');
INSERT INTO "public"."us_management" VALUES (7, '_admin_templates.php', 'templates', 'Templates', '');
INSERT INTO "public"."us_management" VALUES (8, '_admin_tools_check_updates.php', 'updates', 'Check Updates', '');
INSERT INTO "public"."us_management" VALUES (16, '_admin_menus.php', 'menus', 'Manage UltraMenu', '');
INSERT INTO "public"."us_management" VALUES (17, '_admin_logs.php', 'logs', 'System Logs', '');


--
-- TOC entry 3796 (class 0 OID 23668)
-- Dependencies: 278
-- Data for Name: us_menu_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."us_menu_items" VALUES (1, 1, 'dropdown', '', '', 'fa fa-cogs', NULL, NULL, '_self', 0, 14, 0, '[1]');
INSERT INTO "public"."us_menu_items" VALUES (2, 1, 'link', '{{LOGGED_IN_USERNAME}}', 'users/account.php', 'fa fa-user', NULL, NULL, '_self', 0, 11, 0, '[1]');
INSERT INTO "public"."us_menu_items" VALUES (3, 1, 'dropdown', '{{MENU_HELP}}', '', 'fa fa-life-ring', NULL, NULL, '_self', 0, 3, 0, '[0]');
INSERT INTO "public"."us_menu_items" VALUES (4, 1, 'link', '{{SIGNUP_TEXT}}', 'users/join.php', 'fa fa-plus-square', NULL, NULL, '_self', 0, 2, 0, '[0]');
INSERT INTO "public"."us_menu_items" VALUES (5, 1, 'link', '{{SIGNIN_BUTTONTEXT}}', 'users/login.php', 'fa fa-sign-in', NULL, NULL, '_self', 0, 1, 0, '[0]');
INSERT INTO "public"."us_menu_items" VALUES (6, 1, 'link', '{{MENU_HOME}}', '', 'fa fa-home', NULL, NULL, '_self', 0, 0, 0, '[0]');
INSERT INTO "public"."us_menu_items" VALUES (7, 1, 'link', '{{MENU_HOME}}', '', 'fa fa-home', NULL, NULL, '_self', 0, 10, 0, '[]');
INSERT INTO "public"."us_menu_items" VALUES (8, 1, 'link', '{{MENU_HOME}}', '', 'fa fa-home', NULL, NULL, '_self', 1, 1, 0, '[1]');
INSERT INTO "public"."us_menu_items" VALUES (9, 1, 'link', '{{MENU_ACCOUNT}}', 'users/account.php', 'fa fa-user', NULL, NULL, '_self', 1, 2, 0, '[1]');
INSERT INTO "public"."us_menu_items" VALUES (10, 1, 'separator', '', '', '', NULL, NULL, '_self', 1, 3, 0, '[1]');
INSERT INTO "public"."us_menu_items" VALUES (11, 1, 'link', '{{MENU_DASH}}', 'users/admin.php', 'fa fa-cogs', NULL, NULL, '_self', 1, 4, 0, '[2]');
INSERT INTO "public"."us_menu_items" VALUES (12, 1, 'link', '{{MENU_USER_MGR}}', 'users/admin.php?view=users', 'fa fa-user', NULL, NULL, '_self', 1, 5, 0, '[2]');
INSERT INTO "public"."us_menu_items" VALUES (13, 1, 'link', '{{MENU_PERM_MGR}}', 'users/admin.php?view=permissions', 'fa fa-lock', NULL, NULL, '_self', 1, 6, 0, '[2]');
INSERT INTO "public"."us_menu_items" VALUES (14, 1, 'link', '{{MENU_PAGE_MGR}}', 'users/admin.php?view=pages', 'fa fa-wrench', NULL, NULL, '_self', 1, 7, 0, '[2]');
INSERT INTO "public"."us_menu_items" VALUES (15, 1, 'link', '{{MENU_LOGS_MGR}}', 'users/admin.php?view=logs', 'fa fa-search', NULL, NULL, '_self', 1, 9, 0, '[2]');
INSERT INTO "public"."us_menu_items" VALUES (16, 1, 'separator', '', '', '', NULL, NULL, '_self', 1, 10, 0, '[2]');
INSERT INTO "public"."us_menu_items" VALUES (17, 1, 'link', '{{MENU_LOGOUT}}', 'users/logout.php', 'fa fa-sign-out', NULL, NULL, '_self', 1, 11, 0, '[2,1]');
INSERT INTO "public"."us_menu_items" VALUES (18, 1, 'link', '{{SIGNIN_FORGOTPASS}}', 'users/forgot_password.php', 'fa fa-wrench', NULL, NULL, '_self', 3, 1, 0, '[0]');
INSERT INTO "public"."us_menu_items" VALUES (19, 1, 'link', '{{VER_RESEND}}', 'users/verify_resend.php', 'fa fa-exclamation-triangle', NULL, NULL, '_self', 3, 99999, 0, '[0]');
INSERT INTO "public"."us_menu_items" VALUES (20, 2, 'link', 'User Manager', 'users/admin.php?view=users', 'fa fa-user', '', '', '_self', 26, 1, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (21, 2, 'link', 'Spice Shaker', 'users/admin.php?view=spice', 'fa fa-user-secret', '', '', '_self', 0, 2, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (22, 2, 'dropdown', 'Tools', '', 'fa fa-wrench', '', '', '_self', 0, 3, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (23, 2, 'link', 'Bug Report', 'users/admin.php?view=bugs', 'fa fa-bug', '', '', '_self', 26, 2, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (24, 2, 'link', 'IP Manager', 'users/admin.php?view=ip', 'fa fa-warning', '', '', '_self', 26, 3, 0, '["0"]');
INSERT INTO "public"."us_menu_items" VALUES (25, 2, 'link', 'Cron Jobs', 'users/admin.php?view=cron', 'fa fa-terminal', '', '', '_self', 26, 4, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (26, 2, 'link', 'Security Logs', 'users/admin.php?view=security_logs', 'fa fa-lock', '', '', '_self', 26, 5, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (27, 2, 'link', 'System Logs', 'users/admin.php?view=logs', 'fa fa-list-ol', '', '', '_self', 26, 6, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (28, 2, 'link', 'Templates', 'users/admin.php?view=templates', 'fa fa-eye', '', '', '_self', 26, 7, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (29, 2, 'link', 'Updates', 'users/admin.php?view=updates', 'fa fa-arrow-circle-o-up', '', '', '_self', 26, 8, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (30, 2, 'dropdown', 'Settings', '', 'fa fa-gear', '', '', '_self', 0, 4, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (31, 2, 'link', 'General', 'users/admin.php?view=general', 'fa fa-check', '', '', '_self', 34, 2, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (32, 2, 'link', 'Registration', 'admin.php?view=reg', 'fa fa-users', '', '', '_self', 34, 3, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (33, 2, 'link', 'Email', 'users/admin.php?view=email', 'fa fa-envelope', '', '', '_self', 34, 4, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (34, 2, 'link', 'Navigation (Classic)', 'users/admin.php?view=nav', 'fa fa-list-alt', '', '', '_self', 34, 5, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (35, 2, 'link', 'UltraMenu', 'users/admin.php?view=menus', 'fa fa-rocket', '', '', '_self', 34, 6, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (36, 2, 'link', 'Dashboard Access', 'users/admin.php?view=access', 'fa fa-file-code-o', '', '', '_self', 34, 7, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (37, 2, 'link', 'Page Manager', 'users/admin.php?view=pages', 'fa fa-file', '', '', '_self', 26, 9, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (38, 2, 'link', 'Permissions', 'users/admin.php?view=permissions', 'fa fa-unlock-alt', '', '', '_self', 26, 10, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (39, 2, 'dropdown', 'Plugins', '#', 'fa fa-plug', '', '', '_self', 0, 5, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (40, 2, 'snippet', 'All Plugins', 'users/includes/menu_hooks/plugins.php', '', '', '', '_self', 43, 2, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (41, 2, 'link', 'Plugin Manager', 'users/admin.php?view=plugins', 'fa fa-puzzle-piece', '', '', '_self', 43, 1, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (42, 2, 'link', 'Home', '#', 'fa fa-home', '', '', '_self', 0, 1, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (43, 2, 'link', 'Admin Dashboard', 'users/admin.php', 'fa fa-cogs', '', '', '_self', 34, 1, 0, '["2"]');
INSERT INTO "public"."us_menu_items" VALUES (44, 2, 'link', 'Dashboard', 'users/admin.php', 'fa-solid fa-desktop', '', '', '_self', 0, 1, 0, '["2"]');


--
-- TOC entry 3794 (class 0 OID 23653)
-- Dependencies: 276
-- Data for Name: us_menus; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."us_menus" VALUES (1, 'Main Menu', 'horizontal', '', 'dark', 50, '&lt;a href=&quot;{{root}}&quot; &gt;&lt;img src=&quot;{{root}}users/images/logo.png&quot; /&gt;', 0, 'right');
INSERT INTO "public"."us_menus" VALUES (2, 'Dashboard Menu', 'horizontal', NULL, 'dark', 55, '&lt;a href=&quot;{{root}}&quot; title=&quot;Home Page&quot;&gt;&lt;img src=&quot;{{root}}users/images/logo.png&quot; alt=&quot;Main logo&quot; /&gt;&lt;/a&gt;', 0, 'right');


--
-- TOC entry 3800 (class 0 OID 23697)
-- Dependencies: 282
-- Data for Name: us_plugin_hooks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3798 (class 0 OID 23685)
-- Dependencies: 280
-- Data for Name: us_plugins; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3802 (class 0 OID 23707)
-- Dependencies: 284
-- Data for Name: us_saas_levels; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3804 (class 0 OID 23716)
-- Dependencies: 286
-- Data for Name: us_saas_orgs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3806 (class 0 OID 23724)
-- Dependencies: 288
-- Data for Name: us_user_sessions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3772 (class 0 OID 23557)
-- Dependencies: 254
-- Data for Name: user_permission_matches; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."user_permission_matches" VALUES (100, 1, 1);
INSERT INTO "public"."user_permission_matches" VALUES (101, 1, 2);


--
-- TOC entry 3767 (class 0 OID 23511)
-- Dependencies: 249
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO "public"."users" VALUES (1, 1, 'userspicephp@userspice.com', NULL, 'admin', '$2y$12$1v06jm2KMOXuuo3qP7erTuTIJFOnzhpds1Moa8BadnUUeX0RV3ex.', NULL, 'The', 'Admin', 'en-US', 1, 'nlPsJDtyeqFWsS', NULL, '', '', '', '', '', 1, 0, 0, '', '', '2015-01-01 00:00:00', 1, 1, 0, 1, 1, NULL, 0, 0, 1, '2023-05-20 12:24:29', '2022-12-25 00:00:00', '2016-01-01 00:00:00', 1);


--
-- TOC entry 3768 (class 0 OID 23542)
-- Dependencies: 250
-- Data for Name: users_online; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3770 (class 0 OID 23548)
-- Dependencies: 252
-- Data for Name: users_session; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3850 (class 0 OID 0)
-- Dependencies: 214
-- Name: audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."audit_id_seq"', 1, false);


--
-- TOC entry 3851 (class 0 OID 0)
-- Dependencies: 216
-- Name: crons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."crons_id_seq"', 2, false);


--
-- TOC entry 3852 (class 0 OID 0)
-- Dependencies: 218
-- Name: crons_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."crons_logs_id_seq"', 1, false);


--
-- TOC entry 3853 (class 0 OID 0)
-- Dependencies: 220
-- Name: email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."email_id_seq"', 2, false);


--
-- TOC entry 3854 (class 0 OID 0)
-- Dependencies: 222
-- Name: groups_menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."groups_menus_id_seq"', 39, false);


--
-- TOC entry 3855 (class 0 OID 0)
-- Dependencies: 224
-- Name: keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."keys_id_seq"', 1, false);


--
-- TOC entry 3856 (class 0 OID 0)
-- Dependencies: 226
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."logs_id_seq"', 12, true);


--
-- TOC entry 3857 (class 0 OID 0)
-- Dependencies: 228
-- Name: menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."menus_id_seq"', 23, false);


--
-- TOC entry 3858 (class 0 OID 0)
-- Dependencies: 232
-- Name: message_threads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."message_threads_id_seq"', 1, false);


--
-- TOC entry 3859 (class 0 OID 0)
-- Dependencies: 230
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."messages_id_seq"', 1, false);


--
-- TOC entry 3860 (class 0 OID 0)
-- Dependencies: 234
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."notifications_id_seq"', 1, false);


--
-- TOC entry 3861 (class 0 OID 0)
-- Dependencies: 236
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."pages_id_seq"', 91, false);


--
-- TOC entry 3862 (class 0 OID 0)
-- Dependencies: 240
-- Name: permission_page_matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."permission_page_matches_id_seq"', 58, false);


--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 238
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."permissions_id_seq"', 3, false);


--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 242
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."profiles_id_seq"', 11, false);


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 244
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."settings_id_seq"', 2, false);


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 246
-- Name: updates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."updates_id_seq"', 88, false);


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 255
-- Name: us_announcements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_announcements_id_seq"', 1, false);


--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 259
-- Name: us_fingerprint_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_fingerprint_assets_id_seq"', 1, false);


--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 257
-- Name: us_fingerprints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_fingerprints_id_seq"', 1, false);


--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 263
-- Name: us_form_validation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_form_validation_id_seq"', 14, false);


--
-- TOC entry 3871 (class 0 OID 0)
-- Dependencies: 265
-- Name: us_form_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_form_views_id_seq"', 1, false);


--
-- TOC entry 3872 (class 0 OID 0)
-- Dependencies: 261
-- Name: us_forms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_forms_id_seq"', 1, false);


--
-- TOC entry 3873 (class 0 OID 0)
-- Dependencies: 267
-- Name: us_ip_blacklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_ip_blacklist_id_seq"', 11, false);


--
-- TOC entry 3874 (class 0 OID 0)
-- Dependencies: 269
-- Name: us_ip_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_ip_list_id_seq"', 3, false);


--
-- TOC entry 3875 (class 0 OID 0)
-- Dependencies: 271
-- Name: us_ip_whitelist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_ip_whitelist_id_seq"', 7, false);


--
-- TOC entry 3876 (class 0 OID 0)
-- Dependencies: 273
-- Name: us_management_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_management_id_seq"', 18, false);


--
-- TOC entry 3877 (class 0 OID 0)
-- Dependencies: 277
-- Name: us_menu_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_menu_items_id_seq"', 45, false);


--
-- TOC entry 3878 (class 0 OID 0)
-- Dependencies: 275
-- Name: us_menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_menus_id_seq"', 3, false);


--
-- TOC entry 3879 (class 0 OID 0)
-- Dependencies: 281
-- Name: us_plugin_hooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_plugin_hooks_id_seq"', 1, false);


--
-- TOC entry 3880 (class 0 OID 0)
-- Dependencies: 279
-- Name: us_plugins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_plugins_id_seq"', 1, false);


--
-- TOC entry 3881 (class 0 OID 0)
-- Dependencies: 283
-- Name: us_saas_levels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_saas_levels_id_seq"', 1, false);


--
-- TOC entry 3882 (class 0 OID 0)
-- Dependencies: 285
-- Name: us_saas_orgs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_saas_orgs_id_seq"', 1, false);


--
-- TOC entry 3883 (class 0 OID 0)
-- Dependencies: 287
-- Name: us_user_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."us_user_sessions_id_seq"', 2, false);


--
-- TOC entry 3884 (class 0 OID 0)
-- Dependencies: 253
-- Name: user_permission_matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."user_permission_matches_id_seq"', 111, false);


--
-- TOC entry 3885 (class 0 OID 0)
-- Dependencies: 248
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."users_id_seq"', 3, false);


--
-- TOC entry 3886 (class 0 OID 0)
-- Dependencies: 251
-- Name: users_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."users_session_id_seq"', 1, false);


--
-- TOC entry 3512 (class 2606 OID 23341)
-- Name: audit audit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."audit"
    ADD CONSTRAINT "audit_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3516 (class 2606 OID 23360)
-- Name: crons_logs crons_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."crons_logs"
    ADD CONSTRAINT "crons_logs_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3514 (class 2606 OID 23352)
-- Name: crons crons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."crons"
    ADD CONSTRAINT "crons_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3518 (class 2606 OID 23374)
-- Name: email email_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."email"
    ADD CONSTRAINT "email_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3521 (class 2606 OID 23381)
-- Name: groups_menus groups_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."groups_menus"
    ADD CONSTRAINT "groups_menus_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3524 (class 2606 OID 23390)
-- Name: keys keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."keys"
    ADD CONSTRAINT "keys_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3526 (class 2606 OID 23402)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."logs"
    ADD CONSTRAINT "logs_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3528 (class 2606 OID 23411)
-- Name: menus menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."menus"
    ADD CONSTRAINT "menus_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3532 (class 2606 OID 23431)
-- Name: message_threads message_threads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."message_threads"
    ADD CONSTRAINT "message_threads_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3530 (class 2606 OID 23420)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3534 (class 2606 OID 23443)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."notifications"
    ADD CONSTRAINT "notifications_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3536 (class 2606 OID 23457)
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."pages"
    ADD CONSTRAINT "pages_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3540 (class 2606 OID 23471)
-- Name: permission_page_matches permission_page_matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permission_page_matches"
    ADD CONSTRAINT "permission_page_matches_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3538 (class 2606 OID 23464)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."permissions"
    ADD CONSTRAINT "permissions_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3542 (class 2606 OID 23480)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3544 (class 2606 OID 23501)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "settings_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3546 (class 2606 OID 23509)
-- Name: updates updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."updates"
    ADD CONSTRAINT "updates_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3557 (class 2606 OID 23576)
-- Name: us_announcements us_announcements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_announcements"
    ADD CONSTRAINT "us_announcements_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3561 (class 2606 OID 23593)
-- Name: us_fingerprint_assets us_fingerprint_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_fingerprint_assets"
    ADD CONSTRAINT "us_fingerprint_assets_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3559 (class 2606 OID 23584)
-- Name: us_fingerprints us_fingerprints_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_fingerprints"
    ADD CONSTRAINT "us_fingerprints_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3565 (class 2606 OID 23609)
-- Name: us_form_validation us_form_validation_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_form_validation"
    ADD CONSTRAINT "us_form_validation_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3567 (class 2606 OID 23618)
-- Name: us_form_views us_form_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_form_views"
    ADD CONSTRAINT "us_form_views_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3563 (class 2606 OID 23600)
-- Name: us_forms us_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_forms"
    ADD CONSTRAINT "us_forms_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3569 (class 2606 OID 23627)
-- Name: us_ip_blacklist us_ip_blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_ip_blacklist"
    ADD CONSTRAINT "us_ip_blacklist_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3571 (class 2606 OID 23635)
-- Name: us_ip_list us_ip_list_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_ip_list"
    ADD CONSTRAINT "us_ip_list_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3573 (class 2606 OID 23642)
-- Name: us_ip_whitelist us_ip_whitelist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_ip_whitelist"
    ADD CONSTRAINT "us_ip_whitelist_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3575 (class 2606 OID 23651)
-- Name: us_management us_management_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_management"
    ADD CONSTRAINT "us_management_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3579 (class 2606 OID 23683)
-- Name: us_menu_items us_menu_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_menu_items"
    ADD CONSTRAINT "us_menu_items_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3577 (class 2606 OID 23666)
-- Name: us_menus us_menus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_menus"
    ADD CONSTRAINT "us_menus_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3583 (class 2606 OID 23705)
-- Name: us_plugin_hooks us_plugin_hooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_plugin_hooks"
    ADD CONSTRAINT "us_plugin_hooks_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3581 (class 2606 OID 23695)
-- Name: us_plugins us_plugins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_plugins"
    ADD CONSTRAINT "us_plugins_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3585 (class 2606 OID 23714)
-- Name: us_saas_levels us_saas_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_saas_levels"
    ADD CONSTRAINT "us_saas_levels_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3587 (class 2606 OID 23722)
-- Name: us_saas_orgs us_saas_orgs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_saas_orgs"
    ADD CONSTRAINT "us_saas_orgs_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3589 (class 2606 OID 23732)
-- Name: us_user_sessions us_user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."us_user_sessions"
    ADD CONSTRAINT "us_user_sessions_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3555 (class 2606 OID 23562)
-- Name: user_permission_matches user_permission_matches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."user_permission_matches"
    ADD CONSTRAINT "user_permission_matches_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3551 (class 2606 OID 23546)
-- Name: users_online users_online_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_online"
    ADD CONSTRAINT "users_online_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3549 (class 2606 OID 23541)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3553 (class 2606 OID 23555)
-- Name: users_session users_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."users_session"
    ADD CONSTRAINT "users_session_pkey" PRIMARY KEY ("id");


--
-- TOC entry 3547 (class 1259 OID 23735)
-- Name: email_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "email_idx" ON "public"."users" USING "btree" ("email");


--
-- TOC entry 3519 (class 1259 OID 23733)
-- Name: group_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "group_idx" ON "public"."groups_menus" USING "btree" ("group_id");


--
-- TOC entry 3522 (class 1259 OID 23734)
-- Name: menu_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "menu_idx" ON "public"."groups_menus" USING "btree" ("menu_id");


-- Completed on 2023-05-20 13:05:57 CEST

--
-- PostgreSQL database dump complete
--
