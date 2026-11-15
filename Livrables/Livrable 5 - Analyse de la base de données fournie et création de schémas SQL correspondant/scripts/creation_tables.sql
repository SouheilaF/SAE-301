DROP TABLE IF EXISTS PERSONNES, 
                     PROFESSION_CATEGORIES, 
                     JOB,
                     GENRE, 
                     TYPE_OEUVRE, 
                     REGION, 
                     LANGUE, 
                     OEUVRE, 
                     OEUVRE_GENRE,
                     EPISODE, 
                     PARTICIPATION_OEUVRE,
                     EVALUATION, 
                     ADAPTATION_INTERNATIONAL CASCADE;



CREATE TABLE PERSONNES (
    id_personne VARCHAR PRIMARY KEY,
    nom         VARCHAR NOT NULL,
    prenom      VARCHAR NOT NULL,
    naissance   INT,
    deces       INT
);

CREATE TABLE PROFESSION_CATEGORIES (
    id_profession   SERIAL PRIMARY KEY,
    nom             VARCHAR NOT NULL
);

CREATE TABLE JOB (
    id_job  SERIAL PRIMARY KEY,
    nom     VARCHAR NOT NULL
);

CREATE TABLE GENRE(
    id_genre    SERIAL PRIMARY KEY,
    nom_genre   VARCHAR NOT NULL
);


CREATE TABLE TYPE_OEUVRE (
    id_type     SERIAL PRIMARY KEY,
    nom_type    VARCHAR NOT NULL
);

CREATE TABLE REGION (
    id_region   VARCHAR PRIMARY KEY,
    nom_region  VARCHAR
);

CREATE TABLE LANGUE (
    id_langue   VARCHAR PRIMARY KEY,
    nom_langue  VARCHAR
);

CREATE TABLE OEUVRE (
    id_titre        VARCHAR PRIMARY KEY,
    titre_original  VARCHAR NOT NULL,
    id_type         INT REFERENCES TYPE_OEUVRE (id_type),
    date_sortie     INT,
    date_fin        INT,
    est_adulte      BOOLEAN NOT NULL,
    duree           INT 
);

CREATE TABLE OEUVRE_GENRE (
    id_genre    INT REFERENCES GENRE (id_genre),
    id_titre    VARCHAR REFERENCES OEUVRE (id_titre),
    PRIMARY KEY (id_genre, id_titre)
);

CREATE TABLE EPISODE (
    id_episode      VARCHAR PRIMARY KEY REFERENCES OEUVRE (id_titre),
    id_serie        VARCHAR REFERENCES OEUVRE (id_titre),
    numero_saison   INT NOT NULL,
    numero_episode  INT NOT NULL
);

CREATE TABLE PARTICIPATION_OEUVRE (
    id_participation    SERIAL PRIMARY KEY,
    ordre               INT NOT NULL,
    id_titre            VARCHAR REFERENCES OEUVRE (id_titre),
    id_personne         VARCHAR REFERENCES PERSONNES (id_personne),
    id_profession       INT REFERENCES PROFESSION_CATEGORIES (id_profession)
    id_job              INT REFERENCES JOB (id_job),
    personnage_joue     VARCHAR, 
);

CREATE TABLE EVALUATION (
    id_titre            VARCHAR PRIMARY KEY REFERENCES OEUVRE (id_titre),
    moyenne_evaluation  FLOAT NOT NULL,
    nb_votes            INT NOT NULL
);

CREATE TABLE ADAPTATION_INTERNATIONAL (
    id_adaptation   SERIAL PRIMARY KEY,
    id_titre        VARCHAR REFERENCES OEUVRE (id_titre),
    titre_adapte    VARCHAR NOT NULL,
    id_region       VARCHAR REFERENCES REGION (id_region),
    id_langue       VARCHAR REFERENCES LANGUE (id_langue) 
);



