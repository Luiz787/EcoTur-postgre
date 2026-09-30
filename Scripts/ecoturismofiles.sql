--
-- PostgreSQL database dump
--

\restrict W0dgZKUzzfcxJkF7uqAcN0XZJGuQUnSFeSEvGffzrla9PhERZVlXWJFYqBfWBDI

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-09-29 17:35:04

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

--
-- TOC entry 7 (class 2615 OID 25112)
-- Name: contabil; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA contabil;


ALTER SCHEMA contabil OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 25113)
-- Name: site; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA site;


ALTER SCHEMA site OWNER TO postgres;

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
-- TOC entry 5071 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_usuarios_seq; Type: SEQUENCE OWNED BY; Schema: admin; Owner: postgres
--

ALTER SEQUENCE admin.usuarios_id_usuarios_seq OWNED BY admin.usuarios.id_usuarios;


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
-- TOC entry 5072 (class 0 OID 0)
-- Dependencies: 228
-- Name: pagamentos_id_pagamentos_seq; Type: SEQUENCE OWNED BY; Schema: contabil; Owner: postgres
--

ALTER SEQUENCE contabil.pagamentos_id_pagamentos_seq OWNED BY contabil.pagamentos.id_pagamentos;


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
-- TOC entry 5073 (class 0 OID 0)
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
-- TOC entry 5074 (class 0 OID 0)
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
-- TOC entry 4889 (class 2604 OID 25127)
-- Name: usuarios id_usuarios; Type: DEFAULT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.usuarios ALTER COLUMN id_usuarios SET DEFAULT nextval('admin.usuarios_id_usuarios_seq'::regclass);


--
-- TOC entry 4893 (class 2604 OID 25168)
-- Name: pagamentos id_pagamentos; Type: DEFAULT; Schema: contabil; Owner: postgres
--

ALTER TABLE ONLY contabil.pagamentos ALTER COLUMN id_pagamentos SET DEFAULT nextval('contabil.pagamentos_id_pagamentos_seq'::regclass);


--
-- TOC entry 4891 (class 2604 OID 25143)
-- Name: pacotes id_pacotes; Type: DEFAULT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.pacotes ALTER COLUMN id_pacotes SET DEFAULT nextval('site.pacotes_id_pacotes_seq'::regclass);


--
-- TOC entry 4892 (class 2604 OID 25156)
-- Name: reservas id_reserva; Type: DEFAULT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas ALTER COLUMN id_reserva SET DEFAULT nextval('site.reservas_id_reserva_seq'::regclass);


--
-- TOC entry 5059 (class 0 OID 25124)
-- Dependencies: 223
-- Data for Name: usuarios; Type: TABLE DATA; Schema: admin; Owner: postgres
--

INSERT INTO admin.usuarios (id_usuarios, usuario, senha, telefone, cpf, permissao) VALUES (1, 'Luiz', '1234', '32988555433', '11111111111', 'admin');
INSERT INTO admin.usuarios (id_usuarios, usuario, senha, telefone, cpf, permissao) VALUES (2, 'James', '4444', '3289771213', '22222222222', 'usuario');


--
-- TOC entry 5065 (class 0 OID 25165)
-- Dependencies: 229
-- Data for Name: pagamentos; Type: TABLE DATA; Schema: contabil; Owner: postgres
--



--
-- TOC entry 5061 (class 0 OID 25140)
-- Dependencies: 225
-- Data for Name: pacotes; Type: TABLE DATA; Schema: site; Owner: postgres
--

INSERT INTO site.pacotes (id_pacotes, nome, destino, preco) VALUES (1, 'Praia', 'RJ', 130.90);
INSERT INTO site.pacotes (id_pacotes, nome, destino, preco) VALUES (2, 'Trilha', 'SP', 500.00);


--
-- TOC entry 5063 (class 0 OID 25153)
-- Dependencies: 227
-- Data for Name: reservas; Type: TABLE DATA; Schema: site; Owner: postgres
--

INSERT INTO site.reservas (id_reserva, data_reserva, status, fk_usuario, fk_local) VALUES (1, '2026-09-29', 'Pendente', 2, 1);
INSERT INTO site.reservas (id_reserva, data_reserva, status, fk_usuario, fk_local) VALUES (2, '2026-09-30', 'Confirmada', 1, 2);


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_usuarios_seq; Type: SEQUENCE SET; Schema: admin; Owner: postgres
--

SELECT pg_catalog.setval('admin.usuarios_id_usuarios_seq', 2, true);


--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 228
-- Name: pagamentos_id_pagamentos_seq; Type: SEQUENCE SET; Schema: contabil; Owner: postgres
--

SELECT pg_catalog.setval('contabil.pagamentos_id_pagamentos_seq', 1, false);


--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 224
-- Name: pacotes_id_pacotes_seq; Type: SEQUENCE SET; Schema: site; Owner: postgres
--

SELECT pg_catalog.setval('site.pacotes_id_pacotes_seq', 2, true);


--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 226
-- Name: reservas_id_reserva_seq; Type: SEQUENCE SET; Schema: site; Owner: postgres
--

SELECT pg_catalog.setval('site.reservas_id_reserva_seq', 2, true);


--
-- TOC entry 4898 (class 2606 OID 25138)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuarios);


--
-- TOC entry 4904 (class 2606 OID 25173)
-- Name: pagamentos pagamentos_pkey; Type: CONSTRAINT; Schema: contabil; Owner: postgres
--

ALTER TABLE ONLY contabil.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (id_pagamentos);


--
-- TOC entry 4900 (class 2606 OID 25151)
-- Name: pacotes pacotes_pkey; Type: CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.pacotes
    ADD CONSTRAINT pacotes_pkey PRIMARY KEY (id_pacotes);


--
-- TOC entry 4902 (class 2606 OID 25163)
-- Name: reservas reservas_pkey; Type: CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas
    ADD CONSTRAINT reservas_pkey PRIMARY KEY (id_reserva);


--
-- TOC entry 4907 (class 2606 OID 25187)
-- Name: pagamentos fk_pagamento_reserva; Type: FK CONSTRAINT; Schema: contabil; Owner: postgres
--

ALTER TABLE ONLY contabil.pagamentos
    ADD CONSTRAINT fk_pagamento_reserva FOREIGN KEY (id_reserva) REFERENCES site.reservas(id_reserva) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4905 (class 2606 OID 25182)
-- Name: reservas fk_local; Type: FK CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas
    ADD CONSTRAINT fk_local FOREIGN KEY (fk_local) REFERENCES site.pacotes(id_pacotes) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4906 (class 2606 OID 25177)
-- Name: reservas fk_usuario; Type: FK CONSTRAINT; Schema: site; Owner: postgres
--

ALTER TABLE ONLY site.reservas
    ADD CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES admin.usuarios(id_usuarios) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-09-29 17:35:05

--
-- PostgreSQL database dump complete
--

\unrestrict W0dgZKUzzfcxJkF7uqAcN0XZJGuQUnSFeSEvGffzrla9PhERZVlXWJFYqBfWBDI

