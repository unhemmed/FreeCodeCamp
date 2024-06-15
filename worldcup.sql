--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL,
    round character varying(30) NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (33, 2018, 112, 113, 4, 2, 'Final');
INSERT INTO public.games VALUES (34, 2018, 114, 115, 2, 0, 'Third Place');
INSERT INTO public.games VALUES (35, 2018, 113, 115, 2, 1, 'Semi-Final');
INSERT INTO public.games VALUES (36, 2018, 112, 114, 1, 0, 'Semi-Final');
INSERT INTO public.games VALUES (37, 2018, 113, 116, 3, 2, 'Quarter-Final');
INSERT INTO public.games VALUES (38, 2018, 115, 117, 2, 0, 'Quarter-Final');
INSERT INTO public.games VALUES (39, 2018, 114, 118, 2, 1, 'Quarter-Final');
INSERT INTO public.games VALUES (40, 2018, 112, 119, 2, 0, 'Quarter-Final');
INSERT INTO public.games VALUES (41, 2018, 115, 120, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (42, 2018, 117, 121, 1, 0, 'Eighth-Final');
INSERT INTO public.games VALUES (43, 2018, 114, 122, 3, 2, 'Eighth-Final');
INSERT INTO public.games VALUES (44, 2018, 118, 123, 2, 0, 'Eighth-Final');
INSERT INTO public.games VALUES (45, 2018, 113, 124, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (46, 2018, 116, 125, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (47, 2018, 119, 126, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (48, 2018, 112, 127, 4, 3, 'Eighth-Final');
INSERT INTO public.games VALUES (49, 2014, 128, 127, 1, 0, 'Final');
INSERT INTO public.games VALUES (50, 2014, 129, 118, 3, 0, 'Third Place');
INSERT INTO public.games VALUES (51, 2014, 127, 129, 1, 0, 'Semi-Final');
INSERT INTO public.games VALUES (52, 2014, 128, 118, 7, 1, 'Semi-Final');
INSERT INTO public.games VALUES (53, 2014, 129, 130, 1, 0, 'Quarter-Final');
INSERT INTO public.games VALUES (54, 2014, 127, 114, 1, 0, 'Quarter-Final');
INSERT INTO public.games VALUES (55, 2014, 118, 120, 2, 1, 'Quarter-Final');
INSERT INTO public.games VALUES (56, 2014, 128, 112, 1, 0, 'Quarter-Final');
INSERT INTO public.games VALUES (57, 2014, 118, 131, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (58, 2014, 120, 119, 2, 0, 'Eighth-Final');
INSERT INTO public.games VALUES (59, 2014, 112, 132, 2, 0, 'Eighth-Final');
INSERT INTO public.games VALUES (60, 2014, 128, 133, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (61, 2014, 129, 123, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (62, 2014, 130, 134, 2, 1, 'Eighth-Final');
INSERT INTO public.games VALUES (63, 2014, 127, 121, 1, 0, 'Eighth-Final');
INSERT INTO public.games VALUES (64, 2014, 114, 135, 2, 1, 'Eighth-Final');


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (112, 'France');
INSERT INTO public.teams VALUES (113, 'Croatia');
INSERT INTO public.teams VALUES (114, 'Belgium');
INSERT INTO public.teams VALUES (115, 'England');
INSERT INTO public.teams VALUES (116, 'Russia');
INSERT INTO public.teams VALUES (117, 'Sweden');
INSERT INTO public.teams VALUES (118, 'Brazil');
INSERT INTO public.teams VALUES (119, 'Uruguay');
INSERT INTO public.teams VALUES (120, 'Colombia');
INSERT INTO public.teams VALUES (121, 'Switzerland');
INSERT INTO public.teams VALUES (122, 'Japan');
INSERT INTO public.teams VALUES (123, 'Mexico');
INSERT INTO public.teams VALUES (124, 'Denmark');
INSERT INTO public.teams VALUES (125, 'Spain');
INSERT INTO public.teams VALUES (126, 'Portugal');
INSERT INTO public.teams VALUES (127, 'Argentina');
INSERT INTO public.teams VALUES (128, 'Germany');
INSERT INTO public.teams VALUES (129, 'Netherlands');
INSERT INTO public.teams VALUES (130, 'Costa Rica');
INSERT INTO public.teams VALUES (131, 'Chile');
INSERT INTO public.teams VALUES (132, 'Nigeria');
INSERT INTO public.teams VALUES (133, 'Algeria');
INSERT INTO public.teams VALUES (134, 'Greece');
INSERT INTO public.teams VALUES (135, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 64, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 135, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

