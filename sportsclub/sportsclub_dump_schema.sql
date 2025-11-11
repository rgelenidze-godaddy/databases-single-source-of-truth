--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2024-11-12 09:52:01

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
-- TOC entry 849 (class 1247 OID 43465)
-- Name: gender; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.gender AS ENUM (
    'f',
    'm',
    'd'
);


ALTER TYPE public.gender OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 43471)
-- Name: area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area (
    area character(10) NOT NULL,
    description character varying(80),
    manager character varying(20)
);


ALTER TABLE public.area OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 43474)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    course_id integer NOT NULL,
    course_name character varying NOT NULL,
    targetgroup character(3) NOT NULL,
    area character(10),
    trainer character varying(20) NOT NULL
);


ALTER TABLE public.course OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 43479)
-- Name: course_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.course_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_course_id_seq OWNER TO postgres;

--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 217
-- Name: course_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.course_course_id_seq OWNED BY public.course.course_id;


--
-- TOC entry 218 (class 1259 OID 43480)
-- Name: device; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device (
    device_id integer NOT NULL,
    description character varying(50) NOT NULL
);


ALTER TABLE public.device OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 43483)
-- Name: device_device_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.device_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.device_device_id_seq OWNER TO postgres;

--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 219
-- Name: device_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.device_device_id_seq OWNED BY public.device.device_id;


--
-- TOC entry 220 (class 1259 OID 43490)
-- Name: enrollment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment (
    memname character varying(20) NOT NULL,
    course_id integer NOT NULL
);


ALTER TABLE public.enrollment OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 43493)
-- Name: member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member (
    memname character varying(20) NOT NULL,
    is_trainer boolean DEFAULT false NOT NULL,
    email character varying(50) NOT NULL,
    postalcode integer NOT NULL,
    birthday date,
    gender public.gender NOT NULL,
    entry_date date,
    parent character varying(20)
);


ALTER TABLE public.member OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 43497)
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    memname character varying(20) NOT NULL,
    timeslot timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    device_id integer NOT NULL
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 43504)
-- Name: targetgroup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.targetgroup (
    targetgroup character(3) NOT NULL,
    description character varying(60)
);


ALTER TABLE public.targetgroup OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 43507)
-- Name: trainer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trainer (
    tname character varying(20) NOT NULL,
    license boolean DEFAULT false,
    start_date date
);


ALTER TABLE public.trainer OWNER TO postgres;

--
-- TOC entry 4720 (class 2604 OID 43511)
-- Name: course course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course ALTER COLUMN course_id SET DEFAULT nextval('public.course_course_id_seq'::regclass);


--
-- TOC entry 4721 (class 2604 OID 43512)
-- Name: device device_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device ALTER COLUMN device_id SET DEFAULT nextval('public.device_device_id_seq'::regclass);


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 217
-- Name: course_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.course_course_id_seq', 15, true);


--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 219
-- Name: device_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.device_device_id_seq', 1, false);


--
-- TOC entry 4726 (class 2606 OID 43514)
-- Name: area area_manager_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_manager_key UNIQUE (manager);


--
-- TOC entry 4728 (class 2606 OID 43516)
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (area);


--
-- TOC entry 4730 (class 2606 OID 43518)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- TOC entry 4732 (class 2606 OID 43522)
-- Name: device device_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device
    ADD CONSTRAINT device_pkey PRIMARY KEY (device_id);


--
-- TOC entry 4734 (class 2606 OID 43526)
-- Name: enrollment enrollment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_pkey PRIMARY KEY (memname, course_id);


--
-- TOC entry 4736 (class 2606 OID 43528)
-- Name: member mem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT mem_pkey PRIMARY KEY (memname);


--
-- TOC entry 4738 (class 2606 OID 43532)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (memname, timeslot);


--
-- TOC entry 4740 (class 2606 OID 43534)
-- Name: reservation reservation_timeslot_device_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_timeslot_device_id_key UNIQUE (timeslot, device_id);


--
-- TOC entry 4742 (class 2606 OID 43536)
-- Name: targetgroup targetgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.targetgroup
    ADD CONSTRAINT targetgroup_pkey PRIMARY KEY (targetgroup);


--
-- TOC entry 4744 (class 2606 OID 43538)
-- Name: trainer trainer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainer
    ADD CONSTRAINT trainer_pkey PRIMARY KEY (tname);


--
-- TOC entry 4745 (class 2606 OID 43539)
-- Name: area area_manager_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_manager_fkey FOREIGN KEY (manager) REFERENCES public.trainer(tname) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;


--
-- TOC entry 4746 (class 2606 OID 43544)
-- Name: course course_area_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_area_fkey FOREIGN KEY (area) REFERENCES public.area(area) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;


--
-- TOC entry 4747 (class 2606 OID 43549)
-- Name: course course_targetgroup_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_targetgroup_fkey FOREIGN KEY (targetgroup) REFERENCES public.targetgroup(targetgroup);


--
-- TOC entry 4748 (class 2606 OID 43554)
-- Name: course course_trainer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_trainer_fkey FOREIGN KEY (trainer) REFERENCES public.trainer(tname);


--
-- TOC entry 4749 (class 2606 OID 43564)
-- Name: enrollment enrollment_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id);


--
-- TOC entry 4750 (class 2606 OID 43569)
-- Name: enrollment enrollment_memname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment
    ADD CONSTRAINT enrollment_memname_fkey FOREIGN KEY (memname) REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4751 (class 2606 OID 43574)
-- Name: member member_parent_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member
    ADD CONSTRAINT member_parent_fkey FOREIGN KEY (parent) REFERENCES public.member(memname) ON UPDATE CASCADE NOT VALID;


--
-- TOC entry 4752 (class 2606 OID 43589)
-- Name: reservation reservation_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.device(device_id);


--
-- TOC entry 4753 (class 2606 OID 43594)
-- Name: reservation reservation_memname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_memname_fkey FOREIGN KEY (memname) REFERENCES public.member(memname) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 4754 (class 2606 OID 43599)
-- Name: trainer trainer_tname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trainer
    ADD CONSTRAINT trainer_tname_fkey FOREIGN KEY (tname) REFERENCES public.member(memname) NOT VALID;


-- Completed on 2024-11-12 09:52:01

--
-- PostgreSQL database dump complete
--

