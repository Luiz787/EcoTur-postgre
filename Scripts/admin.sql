--
-- PostgreSQL database dump
--

\restrict IJF9PkIVmsWPDb5OCtILhELm2WKItE7jmKag99FZdG2ALag62xyZ8dxf6XIrV3Z

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-09-30 15:42:23

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

--
-- TOC entry 6 (class 2615 OID 25111)
-- Name: admin; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA admin;


ALTER SCHEMA admin OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 25124)
-- Name: usuarios; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.usuarios (
    id_usuarios integer NOT NULL,
    usuario character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(20) NOT NULL,
    permissao character varying(20) DEFAULT 'usuario'::character varying NOT NULL,
    CONSTRAINT chk_cpf_valido CHECK (((cpf)::text ~ '^[0-9]{11}$'::text))
);


ALTER TABLE admin.usuarios OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25123)
-- Name: usuarios_id_usuarios_seq; Type: SEQUENCE; Schema: admin; Owner: postgres
--

CREATE SEQUENCE admin.usuarios_id_usuarios_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE admin.usuarios_id_usuarios_seq OWNER TO postgres;

--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_usuarios_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: postgres
--

ALTER SEQUENCE admin.usuarios_id_usuarios_seq OWNED BY admin.usuarios.id_usuarios;


--
-- TOC entry 4882 (class 2604 OID 25127)
-- Name: usuarios id_usuarios; Type: DEFAULT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.usuarios ALTER COLUMN id_usuarios SET DEFAULT nextval('admin.usuarios_id_usuarios_seq'::regclass);


--
-- TOC entry 5038 (class 0 OID 25124)
-- Dependencies: 223
-- Data for Name: usuarios; Type: TABLE DATA; Schema: admin; Owner: postgres
--

INSERT INTO admin.usuarios VALUES (1, 'Luiz', '1234', '32988555433', '11111111111', 'admin');
INSERT INTO admin.usuarios VALUES (2, 'James', '4444', '3289771213', '22222222222', 'usuario');


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_usuarios_seq; Type: SEQUENCE SET; Schema: admin; Owner: postgres
--

SELECT pg_catalog.setval('admin.usuarios_id_usuarios_seq', 2, true);


--
-- TOC entry 4886 (class 2606 OID 25138)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuarios);


-- Completed on 2026-09-30 15:42:30

--
-- PostgreSQL database dump complete
--

\unrestrict IJF9PkIVmsWPDb5OCtILhELm2WKItE7jmKag99FZdG2ALag62xyZ8dxf6XIrV3Z

