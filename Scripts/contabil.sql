--
-- PostgreSQL database dump
--

\restrict nwLZqduvgxStGigdxRDtAAQ6Dsgyas7B5ItmRUTOnEkfXgFkZWbXgsgN0deCo7E

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-09-30 15:42:51

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
-- TOC entry 7 (class 2615 OID 25112)
-- Name: contabil; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA contabil;


ALTER SCHEMA contabil OWNER TO postgres;

--
-- TOC entry 865 (class 1247 OID 25115)
-- Name: forma; Type: TYPE; Schema: contabil; Owner: postgres
--

CREATE TYPE contabil.forma AS ENUM (
    'PIX',
    'BOLETO',
    'CARTAO',
    'A_VISTA'
);


ALTER TYPE contabil.forma OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 25165)
-- Name: pagamentos; Type: TABLE; Schema: contabil; Owner: postgres
--

CREATE TABLE contabil.pagamentos (
    id_pagamentos integer NOT NULL,
    data_pagamento date NOT NULL,
    forma contabil.forma,
    id_reserva integer NOT NULL
);


ALTER TABLE contabil.pagamentos OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25164)
-- Name: pagamentos_id_pagamentos_seq; Type: SEQUENCE; Schema: contabil; Owner: postgres
--

CREATE SEQUENCE contabil.pagamentos_id_pagamentos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabil.pagamentos_id_pagamentos_seq OWNER TO postgres;

--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 228
-- Name: pagamentos_id_pagamentos_seq; Type: SEQUENCE OWNED BY; Schema: contabil; Owner: postgres
--

ALTER SEQUENCE contabil.pagamentos_id_pagamentos_seq OWNED BY contabil.pagamentos.id_pagamentos;


--
-- TOC entry 232 (class 1259 OID 25200)
-- Name: vw_relatorio_financeiro; Type: VIEW; Schema: contabil; Owner: postgres
--

CREATE VIEW contabil.vw_relatorio_financeiro AS
 SELECT p.id_pagamentos,
    p.data_pagamento,
    p.forma,
    r.status AS status_reserva,
    pac.preco AS valor_recebido
   FROM ((contabil.pagamentos p
     JOIN site.reservas r ON ((p.id_reserva = r.id_reserva)))
     JOIN site.pacotes pac ON ((r.fk_local = pac.id_pacotes)));


ALTER VIEW contabil.vw_relatorio_financeiro OWNER TO postgres;

--
-- TOC entry 4884 (class 2604 OID 25168)
-- Name: pagamentos id_pagamentos; Type: DEFAULT; Schema: contabil; Owner: postgres
--

ALTER TABLE ONLY contabil.pagamentos ALTER COLUMN id_pagamentos SET DEFAULT nextval('contabil.pagamentos_id_pagamentos_seq'::regclass);


--
-- TOC entry 5039 (class 0 OID 25165)
-- Dependencies: 229
-- Data for Name: pagamentos; Type: TABLE DATA; Schema: contabil; Owner: postgres
--



--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 228
-- Name: pagamentos_id_pagamentos_seq; Type: SEQUENCE SET; Schema: contabil; Owner: postgres
--

SELECT pg_catalog.setval('contabil.pagamentos_id_pagamentos_seq', 1, false);


--
-- TOC entry 4886 (class 2606 OID 25173)
-- Name: pagamentos pagamentos_pkey; Type: CONSTRAINT; Schema: contabil; Owner: postgres
--

ALTER TABLE ONLY contabil.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (id_pagamentos);


--
-- TOC entry 4887 (class 2606 OID 25187)
-- Name: pagamentos fk_pagamento_reserva; Type: FK CONSTRAINT; Schema: contabil; Owner: postgres
--

ALTER TABLE ONLY contabil.pagamentos
    ADD CONSTRAINT fk_pagamento_reserva FOREIGN KEY (id_reserva) REFERENCES site.reservas(id_reserva) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-09-30 15:42:52

--
-- PostgreSQL database dump complete
--

\unrestrict nwLZqduvgxStGigdxRDtAAQ6Dsgyas7B5ItmRUTOnEkfXgFkZWbXgsgN0deCo7E

