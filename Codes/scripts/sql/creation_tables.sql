DROP TABLE IF EXISTS    PERSONNES, 
                        PROFESSION_CATEGORIES, 
                        JOB,
                        GENRE, 
                        TYPE_OEUVRE, 
                        PAYS, 
                        LANGUES, 
                        OEUVRE, 
                        OEUVRE_GENRE,
                        EPISODE, 
                        PERSONNE_PROFESSION,
                        PERSONNE_OEUVRE,
                        PARTICIPATION_OEUVRE,
                        EVALUATION, 
                        ADAPTATION_INTERNATIONAL CASCADE;



CREATE TABLE PERSONNES (
    id_personne VARCHAR,
    nom_complet VARCHAR,
    naissance   INTEGER,
    deces       INTEGER
);

CREATE TABLE PROFESSION_CATEGORIES (
    id_profession   INTEGER PRIMARY KEY,
    nom_profession  VARCHAR UNIQUE NOT NULL
);

CREATE TABLE JOB (
    id_job  INTEGER PRIMARY KEY,
    nom_job VARCHAR UNIQUE NOT NULL
);

CREATE TABLE GENRE(
    id_genre    INTEGER PRIMARY KEY,
    nom_genre   VARCHAR UNIQUE NOT NULL
);


CREATE TABLE TYPE_OEUVRE (
    id_type     SERIAL PRIMARY KEY,
    nom_type    VARCHAR UNIQUE NOT NULL
);

CREATE TABLE PAYS (
    id_pays   VARCHAR PRIMARY KEY,
    nom_pays  VARCHAR
);

CREATE TABLE LANGUES (
    id_langue   VARCHAR PRIMARY KEY,
    nom_langue  VARCHAR
);

CREATE TABLE OEUVRE (
    id_titre        VARCHAR,
    titre_original  VARCHAR NOT NULL,
    id_type         INTEGER,
    date_sortie     INTEGER,
    date_fin        INTEGER, 
    est_adulte      BOOLEAN NOT NULL,
    duree           INTEGER
);

CREATE TABLE OEUVRE_GENRE (
    id_titre    VARCHAR,
    id_genre    INTEGER
);

CREATE TABLE EPISODE (
    id_episode      VARCHAR,
    id_serie        VARCHAR NOT NULL, 
    numero_saison   INTEGER,
    numero_episode  INTEGER
);

CREATE TABLE PERSONNE_PROFESSION (
    id_personne     VARCHAR NOT NULL,
    id_profession   INTEGER NOT NULL
);

CREATE TABLE PERSONNE_OEUVRE (
    id_personne     VARCHAR NOT NULL,
    id_titre        VARCHAR NOT NULL
);

CREATE TABLE PARTICIPATION_OEUVRE (
    id_participation    SERIAL,
    id_titre            VARCHAR NOT NULL,
    ordre               INTEGER,
    id_personne         VARCHAR NOT NULL,
    id_profession       INTEGER,
    id_job              INTEGER,
    personnage_joue     VARCHAR
);

CREATE TABLE EVALUATION (
    id_evaluation       SERIAL PRIMARY KEY,
    id_titre            VARCHAR UNIQUE,
    moyenne_evaluation  NUMERIC(3,1) NOT NULL CHECK (moyenne_evaluation BETWEEN 0 AND 10),
    nb_votes            INTEGER NOT NULL CHECK (nb_votes >= 0)
);

CREATE TABLE ADAPTATION_INTERNATIONAL (
    id_adaptation   SERIAL,
    id_titre        VARCHAR NOT NULL,
    titre_adapte    VARCHAR NOT NULL,
    id_pays         VARCHAR,
    id_langue       VARCHAR
);