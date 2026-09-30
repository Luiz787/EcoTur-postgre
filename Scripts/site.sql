--
-- PostgreSQL database dump
--

\restrict hFrLywqMWkItb3w2akL2q2n3FH3GUpiM7YMnMn7tPevB2GYcQtPxApCfMUveU57

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-09-30 15:43:20

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
-- TOC entry 8 (class 2615 OID 25113)
-- Name: site; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA site;


ALTER SCHEMA site OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 225 (class 1259 OID 25140)
-- Name: pacotes; Type: TABLE; Schema: site; Owner: postgres
--

CREATE TABLE site.pacotes (
    id_pacotes integer NOT NULL,
    nome character varying(255) NOT NULL,
    destino character varying(255) NOT NULL,
    preco numeric(13,2) NOT NULL,
    CONSTRAINT chk_preco_positivo CHECK ((preco > (0)::numeric))
);


ALTER TABLE site.pacotes OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25153)
-- Name: reservas; Type: TABLE; Schema: site; Owner: postgres
--

CREATE TABLE site.reservas (
    id_reserva integer NOT NULL,
    data_reserva date NOT NULL,
    status character varying(255) NOT NULL,
    fk_usuario integer NOT NULL,
    fk_local integer NOT NULL,
    CONSTRAINT chk_status_reserva CHECK (((status)::text = ANY ((ARRAY['Pendente'::character varying, 'Confirmada'::character varying, 'Cancelada'::character varying, 'Concluida'::character varying])::text[])))
);


ALTER TABLE site.reservas OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25139)
-- Name: pacotes_id_pacotes_seq; Type: SEQUENCE; Schema: site; Owner: postgres
--

CREATE SEQUENCE site.pacotes_id_pacotes_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE site.pacotes_id_pacotes_seq OWNER TO postgres;

--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 224
-- Name: pacotes_id_pacotes_seq; Type: SEQUENCE OWNED BY; Schema: site; Owner: postgres
--

ALTER SEQUENCE site.pacotes_id_pacotes_seq OWNED BY site.pacotes.id_pacotes;


--
-- TOC entry 226 (class 1259 OID 25152)
-- Name: reservas_id_reserva_seq; Type: SEQUENCE; Schema: site; Owner: postgres
--

CREATE SEQUENCE site.reservas_id_reserva_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE site.reservas_id_reserva_seq OWNER TO postgres;

--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 226
-- Name: reservas_id_reserva_seq; Type: SEQUENCE OWNED BY; Schema: site; Owner: postgres
--

ALTER SEQUENCE site.reservas_id_reserva_seq OWNED BY site.reservas.id_reserva;


--
-- TOC entry 230 (class 1259 OID 25192)
-- Name: vw_catalogo_pacotes; Type: VIEW; Schema: site; Owner: postgres
--

CREATE VIEW site.vw_catalogo_pacotes AS
 SELECT id_pacotes,
    nome,
    destino,
    preco AS preco_reais
   FROM site.pacotes
  ORDER BY preco;


ALTER VIEW site.vw_catalogo_pacotes OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25196)
-- Name: vw_detalhes_reserva; Type: VIEW; Schema: site; Owner: postgres
--

CREATE VIEW site.vw_detalhes_reserva AS
 SELECT r.id_reserva,
    r.data_reserva,
    r.status,
    u.usuario AS nome_cliente,
    p.nome AS pacote_escolhido
   FROM ((site.reservas r
     JOIN admin.usuarios u ON ((r.fk_usuario = u.id_usuarios)))
     JOIN site.pacotes p ON ((r.fk_local = p.id_pacotes)));


ALTER VIEW site.vw_detalhes_reserva OWNER TO postgres;

--
-- TOC entry 4885 (class 2604 OID 25143)
-- Name: pacotes id_pacotes; Type: DEFAULT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.pacotes ALTER COLUMN id_pacotes SET DEFAULT nextval('site.pacotes_id_pacotes_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 25156)
-- Name: reservas id_reserva; Type: DEFAULT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas ALTER COLUMN id_reserva SET DEFAULT nextval('site.reservas_id_reserva_seq'::regclass);


--
-- TOC entry 5046 (class 0 OID 25140)
-- Dependencies: 225
-- Data for Name: pacotes; Type: TABLE DATA; Schema: site; Owner: postgres
--

COPY site.pacotes (id_pacotes, nome, destino, preco) FROM stdin;
1	Praia	RJ	130.90
2	Trilha	SP	500.00
\.


--
-- TOC entry 5048 (class 0 OID 25153)
-- Dependencies: 227
-- Data for Name: reservas; Type: TABLE DATA; Schema: site; Owner: postgres
--

COPY site.reservas (id_reserva, data_reserva, status, fk_usuario, fk_local) FROM stdin;
1	2026-09-29	Pendente	2	1
2	2026-09-30	Confirmada	1	2
\.


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 224
-- Name: pacotes_id_pacotes_seq; Type: SEQUENCE SET; Schema: site; Owner: postgres
--

SELECT pg_catalog.setval('site.pacotes_id_pacotes_seq', 2, true);


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 226
-- Name: reservas_id_reserva_seq; Type: SEQUENCE SET; Schema: site; Owner: postgres
--

SELECT pg_catalog.setval('site.reservas_id_reserva_seq', 2, true);


--
-- TOC entry 4890 (class 2606 OID 25151)
-- Name: pacotes pacotes_pkey; Type: CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.pacotes
    ADD CONSTRAINT pacotes_pkey PRIMARY KEY (id_pacotes);


--
-- TOC entry 4892 (class 2606 OID 25163)
-- Name: reservas reservas_pkey; Type: CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas
    ADD CONSTRAINT reservas_pkey PRIMARY KEY (id_reserva);


--
-- TOC entry 4893 (class 2606 OID 25182)
-- Name: reservas fk_local; Type: FK CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas
    ADD CONSTRAINT fk_local FOREIGN KEY (fk_local) REFERENCES site.pacotes(id_pacotes) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4894 (class 2606 OID 25177)
-- Name: reservas fk_usuario; Type: FK CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas
    ADD CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES admin.usuarios(id_usuarios) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-09-30 15:43:20

--
-- PostgreSQL database dump complete
--

\unrestrict hFrLywqMWkItb3w2akL2q2n3FH3GUpiM7YMnMn7tPevB2GYcQtPxApCfMUveU57

