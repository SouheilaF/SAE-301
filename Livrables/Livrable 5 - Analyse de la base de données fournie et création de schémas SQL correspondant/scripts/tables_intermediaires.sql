-- Suppression des anciennes tables intermédiaires pour pouvoir relancer l'import proprement.
DROP TABLE IF EXISTS t_name_basics;
DROP TABLE IF EXISTS t_title_akas;
DROP TABLE IF EXISTS t_title_basics;
DROP TABLE IF EXISTS t_title_crew;
DROP TABLE IF EXISTS t_title_episode;
DROP TABLE IF EXISTS t_title_principals;
DROP TABLE IF EXISTS t_title_ratings;

-- Toutes les colonnes sont en TEXT pour éviter les erreurs pendant l'import des.

-- Table intermédiaire contenant les informations sur les personnes.
CREATE TABLE t_name_basics (
    nconst 		TEXT,
    primaryName 	TEXT, 
    birthYear 		TEXT, 
    deathYear 		TEXT,
    primaryProfession 	TEXT,
    knownForTitles 	TEXT
);

-- Table intermédiaire contenant les titres alternatifs des films et séries, avec leurs régions, langues et attributs.
CREATE TABLE t_title_akas (
    titleId 		TEXT,
    ordering 		TEXT,
    title 		TEXT,
    region 		TEXT,
    language 		TEXT,
    types 		TEXT,
    attributes 		TEXT,
    isOriginalTitle 	TEXT
);

-- Table intermédiaire contenant les informations générales sur les films et séries.
CREATE TABLE t_title_basics (
    tconst 		TEXT,
    titleType 		TEXT,
    primaryTitle 	TEXT,
    originalTitle 	TEXT,
    isAdult 		TEXT,
    startYear 		TEXT,
    endYear 		TEXT,
    runtimeMinutes 	TEXT,
    genres 		TEXT
);

-- Table intermédiaire contenant les réalisateurs et scénaristes des œuvres.
CREATE TABLE t_title_crew (
    tconst 		TEXT,
    directors 	TEXT,
    writers 	TEXT
);

-- Table intermédiaire contenant les informations sur les épisodes.
CREATE TABLE t_title_episode (
    tconst 		    TEXT,
    parentTconst 	TEXT,
    seasonNumber 	TEXT,
    episodeNumber 	TEXT
);

-- Table intermédiaire contenant les participants principaux aux œuvres.
CREATE TABLE t_title_principals (
    tconst 	    TEXT,
    ordering 	TEXT,
    nconst 	    TEXT,
    category 	TEXT,
    job 	    TEXT,
    characters 	TEXT
);

-- Table intermédiaire contenant les notes moyennes et nombres de votes des œuvres.
CREATE TABLE t_title_ratings (
    tconst 		    TEXT,
    averageRating 	TEXT,
    numVotes 		TEXT
);



-- Import des fichiers dans leur table intermédiaire.

\copy t_name_basics             FROM 'data/name.basics.tsv'         WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
\copy t_title_akas              FROM 'data/title.akas.tsv'          WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
\copy t_title_basics            FROM 'data/title.basics.tsv'        WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
\copy t_title_crew              FROM 'data/title.crew.tsv'          WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
\copy t_title_episode           FROM 'data/title.episode.tsv'       WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
\copy t_title_principals        FROM 'data/title.principals.tsv'    WITH (FORMAT csv, DELIMITER E'\t', HEADER true);
\copy t_title_ratings           FROM 'data/title.ratings.tsv'       WITH (FORMAT csv, DELIMITER E'\t', HEADER true);