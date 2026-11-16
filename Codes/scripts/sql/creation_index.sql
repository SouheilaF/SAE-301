CREATE INDEX ind_personnes_nom          ON PERSONNES (nom_complet);
CREATE INDEX ind_personnes_naissance    ON PERSONNES (naissance);
CREATE INDEX ind_personnes_deces        ON PERSONNES (deces) WHERE deces IS NOT NULL;


CREATE INDEX ind_id_type                ON OEUVRE (id_type);
CREATE INDEX ind_date_sortie            ON OEUVRE (date_sortie);
CREATE INDEX ind_date_fin               ON OEUVRE (date_fin);
CREATE INDEX ind_id_genre               ON OEUVRE_GENRE (id_genre);



CREATE INDEX ind_episode_serie          ON EPISODE (id_serie);



CREATE INDEX ind_participation_titre    ON PARTICIPATION_OEUVRE (id_titre);
CREATE INDEX ind_participation_personne ON PARTICIPATION_OEUVRE (id_personne);
CREATE INDEX ind_profession_job         ON PARTICIPATION_OEUVRE (id_profession, id_job);



CREATE INDEX ind_pays                   ON ADAPTATION_INTERNATIONAL (id_pays);
CREATE INDEX ind_langue                 ON ADAPTATION_INTERNATIONAL (id_langue);
CREATE INDEX ind_titre_pays_langue      ON ADAPTATION_INTERNATIONAL (id_titre, id_pays, id_langue);


ANALYZE;