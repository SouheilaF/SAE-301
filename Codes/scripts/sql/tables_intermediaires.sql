-- Suppression des anciennes tables intermédiaires pour pouvoir relancer l'import proprement.
 DROP TABLE IF EXISTS   t_name_basics, 
                        t_title_akas,
                        t_title_basics,
                        t_title_episode,
                        t_title_ratings,
                        t_personne_titres_connues,
                        t_pays, 
                        t_langues, 
                        t_genre, 
                        t_oeuvre_genre,
                        t_profession, 
                        t_personne_profession, 
                        t_job, 
                        t_participation_oeuvre;

-- Toutes les colonnes sont en VARCHAR pour éviter les erreurs pendant l'import des données.

-- Table intermédiaire contenant les informations sur les personnes.
CREATE TABLE t_name_basics (
    nconst 		        VARCHAR,
    primaryname 	    VARCHAR, 
    birthyear 		    VARCHAR, 
    deathyear 		    VARCHAR,
    primaryprofession 	VARCHAR,
    knownfortitles 	    VARCHAR
);

-- Table intermédiaire contenant les titres alternatifs des films et séries, avec leurs régions, langues et attributs.
CREATE TABLE t_title_akas (
    titleid 		VARCHAR,
    ordering 		VARCHAR,
    title 		    VARCHAR,
    region 		    VARCHAR,
    language 		VARCHAR,
    types 		    VARCHAR,
    attributes 		VARCHAR,
    isoriginaltitle	VARCHAR
);

-- Table intermédiaire contenant les informations générales sur les films et séries.
CREATE TABLE t_title_basics (
    tconst 		    VARCHAR,
    titletype 		VARCHAR,
    primarytitle 	VARCHAR,
    originaltitle 	VARCHAR,
    isadult 		VARCHAR,
    startyear 		VARCHAR,
    endyear 		VARCHAR,
    runtimeminutes 	VARCHAR,
    genres 		    VARCHAR
);

-- Table intermédiaire contenant les informations sur les épisodes.
CREATE TABLE t_title_episode (
    tconst 		    VARCHAR,
    parenttconst 	VARCHAR,
    seasonnumber 	VARCHAR,
    episodenumber 	VARCHAR
);

-- Table intermédiaire contenant les notes moyennes et nombres de votes des œuvres.
CREATE TABLE t_title_ratings (
    tconst 		    VARCHAR,
    averagerating 	VARCHAR,
    numvotes 		VARCHAR
);

-- Table intermédiaire contenant les titres connus des personnes.
CREATE TABLE t_personne_titres_connues (
    id_personne 	    VARCHAR,
    id_titre 	        VARCHAR
);

-- Table intermédiaire contenant les noms des pays et leur code ISO.
CREATE TABLE t_pays (
    code_pays   VARCHAR,
    nom_pays    VARCHAR
);

-- Table intermédiaire contenant les noms des langues et leur code ISO. 
CREATE TABLE t_langues (
    code_langue VARCHAR,
    nom_langue  VARCHAR
);

-- Table intermédiaire contenant les genres.
CREATE TABLE t_genre (
    id_genre    VARCHAR,
    nom_genre   VARCHAR
);

-- Table intermédiaire contenant les genres des œuvres.
CREATE TABLE t_oeuvre_genre (
    id_titre    VARCHAR,
    id_genre    VARCHAR
);

-- Table intermédiaire contenant les professions.
CREATE TABLE t_profession (
    id_profession   VARCHAR,
    nom_profession  VARCHAR
);

-- Table intermédiaire contenant les professions des personnes.
CREATE TABLE t_personne_profession (
    id_personne     VARCHAR,
    id_profession   VARCHAR
);

-- Table intermédiaire contenant les jobs.
CREATE TABLE t_job (
    id_job      VARCHAR,
    nom_job     VARCHAR
);

-- Table intermédiaire contenant les participations des personnes aux œuvres.
CREATE TABLE t_participation_oeuvre (
    id_titre        VARCHAR,
    ordre           VARCHAR,
    id_personne     VARCHAR,
    id_profession   VARCHAR,
    id_job          VARCHAR,
    personnage_joue VARCHAR
);



-- Import des fichiers dans leur table intermédiaire.
\! echo "Importation t_name_basics"
\copy t_name_basics             FROM PROGRAM 'gunzip -c data/sources/name.basics.tsv.gz'            WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', NULL '\N', HEADER true);



\! echo "Importation t_title_akas"
\copy t_title_akas              FROM PROGRAM 'gunzip -c data/sources/title.akas.tsv.gz'             WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', NULL '\N', HEADER true);



\! echo "Importation t_title_basics"
\copy t_title_basics            FROM PROGRAM 'gunzip -c data/sources/title.basics.tsv.gz'           WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', NULL '\N', HEADER true);



\! echo "Importation t_title_episode"
\copy t_title_episode           FROM PROGRAM 'gunzip -c data/sources/title.episode.tsv.gz'          WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', NULL '\N', HEADER true);



\! echo "Importation t_title_ratings"
\copy t_title_ratings           FROM PROGRAM 'gunzip -c data/sources/title.ratings.tsv.gz'          WITH (FORMAT csv, DELIMITER E'\t', QUOTE E'\b', NULL '\N', HEADER true);



\! echo "Importation t_personne_titres_connues"
\copy t_personne_titres_connues FROM 'data/locales/titres_connues.csv'                           WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_pays"
\copy t_pays                    FROM 'data/locales/pays.csv'                                     WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_langues"
\copy t_langues                 FROM 'data/locales/langues.csv'                                 WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_genre"
\copy t_genre                   FROM 'data/locales/genres.csv'                                  WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_oeuvre_genre"
\copy t_oeuvre_genre            FROM 'data/locales/oeuvres_genres.csv'                          WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_profession"
\copy t_profession              FROM 'data/locales/professions.csv'                             WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_personne_profession"
\copy t_personne_profession     FROM 'data/locales/personnes_professions.csv'                   WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_job"
\copy t_job                     FROM 'data/locales/jobs.csv'                                    WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);



\! echo "Importation t_participation_oeuvre"
\copy t_participation_oeuvre    FROM 'data/locales/participations_oeuvres.csv'                  WITH (FORMAT csv, DELIMITER ';', NULL '\N', HEADER true);
