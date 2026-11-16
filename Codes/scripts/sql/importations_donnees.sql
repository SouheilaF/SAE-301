/* IMPORTATION DES DONNEES DEPUIS LES TABLES INTERMEDIAIRES */
\timing on

/*1. PERSONNES */
\! echo "[1/15] Importation des données de la table PERSONNES"
INSERT INTO PERSONNES (id_personne, nom_complet, naissance, deces)
SELECT t.nconst         AS id_personne, 
       t.primaryName    AS nom_complet, 
       t.birthYear   :: INTEGER AS naissance, 
       t.deathYear   :: INTEGER AS deces
FROM t_name_basics t;
\! echo "Importation des données de la table PERSONNES terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_name_basics"
DROP TABLE IF EXISTS t_name_basics;


\! echo ""
/*2. PROFESSION_CATEGORIES */
\! echo "[2/15] Importation des données de la table CATEGORIES"
INSERT INTO PROFESSION_CATEGORIES (id_profession, nom_profession)
SELECT t.id_profession :: INTEGER,
       t.nom_profession
FROM t_profession t;
\! echo "Importation des données de la table CATEGORIES terminée"


\! echo ""
/*3. JOB */
\! echo "[3/15] Importation des données de la table JOB"
INSERT INTO JOB (id_job, nom_job)
SELECT t.id_job :: INTEGER,
       t.nom_job
FROM t_job t;
\! echo "Importation des données de la table JOB terminée"


\! echo ""
/*4. GENRE */
\! echo "[4/15] Importation des données de la table GENRE"
INSERT INTO GENRE (id_genre, nom_genre)
SELECT t.id_genre :: INTEGER,
       t.nom_genre
FROM t_genre t;
\! echo "Importation des données de la table GENRE terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_genre"
DROP TABLE IF EXISTS t_genre;


\! echo ""
/*5. TYPE_OEUVRE */
\! echo "[5/15] Importation des données de la table TYPE_OEUVRE"
INSERT INTO TYPE_OEUVRE (nom_type)
SELECT DISTINCT t.titletype  AS nom_type
FROM t_title_basics t;
\! echo "Importation des données de la table TYPE_OEUVRE terminée"


\! echo ""
/*6. PAYS */
\! echo "[6/15] Importation des données de la table PAYS"
INSERT INTO PAYS (id_pays, nom_pays)
SELECT DISTINCT      t.region     AS id_pays, 
                     p.nom_pays   AS nom_pays
FROM t_title_akas t 
LEFT JOIN t_pays p ON t.region = p.code_pays
WHERE t.region IS NOT NULL AND t.region <> '';
\! echo "Importation des données de la table PAYS terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_pays"
DROP TABLE IF EXISTS t_pays;


\! echo ""
/*7. LANGUES */
\! echo "[7/15] Importation des données de la table LANGUES"
INSERT INTO LANGUES (id_langue, nom_langue)
SELECT DISTINCT      t.language       AS id_langue, 
                     l.nom_langue     AS nom_langue
FROM t_title_akas t
LEFT JOIN t_langues l ON t.language = l.code_langue
WHERE t.language IS NOT NULL AND t.language <> '';
\! echo "Importation des données de la table LANGUES terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_langues"
DROP TABLE IF EXISTS t_langues;


\! echo ""
/*8. OEUVRE */
\! echo "[8/15] Importation des données de la table OEUVRE"
INSERT INTO OEUVRE (id_titre, titre_original, id_type, date_sortie, date_fin, est_adulte, duree)
SELECT t.tconst                      AS id_titre, 
       t.originaltitle               AS titre_original, 
       t_o.id_type        :: INTEGER AS id_type, 
       t.startyear        :: INTEGER AS date_sortie, 
       t.endyear          :: INTEGER AS date_fin, 
       t.isadult          :: BOOLEAN AS est_adulte, 
       t.runtimeminutes   :: INTEGER AS duree
FROM t_title_basics t
LEFT JOIN TYPE_OEUVRE t_o ON t.titletype = t_o.nom_type;
\! echo "Importation des données de la table OEUVRE terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_title_basics"
DROP TABLE IF EXISTS t_title_basics;


\! echo ""
/*9. OEUVRE_GENRE */
\! echo "[9/15] Importation des données de la table OEUVRE_GENRE"
INSERT INTO OEUVRE_GENRE (id_titre, id_genre)
SELECT t.id_titre,
       t.id_genre :: INTEGER
FROM t_oeuvre_genre t;
\! echo "Importation des données de la table OEUVRE_GENRE terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_oeuvre_genre"
DROP TABLE IF EXISTS t_oeuvre_genre;


\! echo ""
/*10. EPISODE */
\! echo "[10/15] Importation des données de la table EPISODE"
INSERT INTO EPISODE (id_episode, id_serie, numero_saison, numero_episode)
SELECT t.tconst                      AS id_episode,
       t.parenttconst                AS id_serie,
       t.seasonnumber     :: INTEGER AS numero_saison,
       t.episodenumber    :: INTEGER AS numero_episode
FROM t_title_episode t;
\! echo "Importation des données de la table EPISODE terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_title_episode"
DROP TABLE IF EXISTS t_title_episode;


\! echo ""
/*11. PERSONNES_PROFESSION */
\! echo "[11/15] Importation des données de la table PERSONNES_PROFESSION"
INSERT INTO PERSONNE_PROFESSION (id_personne, id_profession)
SELECT t.id_personne,
       t.id_profession :: INTEGER
FROM t_personne_profession t;
\! echo "Importation des données de la table PERSONNES_PROFESSION terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_personne_profession"
DROP TABLE IF EXISTS t_personne_profession;


\! echo ""
/*12. PERSONNES_OEUVRE */
\! echo "[12/15] Importation des données de la table PERSONNES_OEUVRE"
INSERT INTO PERSONNE_OEUVRE (id_personne, id_titre)
SELECT t.id_personne,
       t.id_titre
FROM t_personne_titres_connues t;
\! echo "Importation des données de la table PERSONNES_OEUVRE terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_personne_titres_connues"
DROP TABLE IF EXISTS t_personne_titres_connues;


\! echo ""
/*13. PARTICIPATION_OEUVRE */
\! echo "[13/15] Importation des données de la table PARTICIPATION_OEUVRE"
INSERT INTO PARTICIPATION_OEUVRE (id_titre, ordre, id_personne, id_profession, id_job, personnage_joue)
SELECT t.id_titre,
       t.ordre          :: INTEGER,
       t.id_personne,
       t.id_profession  :: INTEGER,
       t.id_job         :: INTEGER,
       t.personnage_joue
FROM t_participation_oeuvre t;
\! echo "Importation des données de la table PARTICIPATION_OEUVRE terminée"
\! echo ""
\! echo "Suppression des tables intermédiaires t_participation_oeuvre, t_job et t_profession"
DROP TABLE IF EXISTS t_participation_oeuvre, t_job, t_profession;


\! echo ""
/*14. EVALUATION */
\! echo "[14/15] Importation des données de la table EVALUATION"
INSERT INTO EVALUATION (id_titre, moyenne_evaluation, nb_votes)
SELECT t.tconst                         AS id_titre,
       t.averagerating :: NUMERIC (3,1) AS moyenne_evaluation,
       t.numvotes      :: INTEGER       AS nb_votes
FROM t_title_ratings t;
\! echo "Importation des données de la table EVALUATION terminée"
\! echo ""
\! echo "Suppression de la table intermédiaire t_title_ratings"
DROP TABLE IF EXISTS t_title_ratings;


\! echo ""
/*15. ADAPTATION_INTERNATIONAL */
\! echo "[15/15] Importation des données de la table ADAPTATION_INTERNATIONAL "
INSERT INTO ADAPTATION_INTERNATIONAL (id_titre, titre_adapte, id_pays, id_langue)
SELECT t.titleid        AS id_titre,
       t.title          AS titre_adapte,
       t.region         AS id_pays,
       t.language       AS id_langue
FROM t_title_akas t;
\! echo "Importation des données de la table ADAPTATION_INTERNATIONAL terminée"
\! echo ""
\! echo "Suppression des tables intermédiaires t_title_akas"
DROP TABLE IF EXISTS t_title_akas;
