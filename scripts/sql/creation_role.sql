-- Schéma du projet
CREATE SCHEMA projet;

-- Rôles de groupe
CREATE ROLE projet_admin NOLOGIN;   -- propriétaire : SELECT, INSERT, UPDATE, DELETE, TRUNCATE, ALTER, DROP
CREATE ROLE projet_membre NOLOGIN;  -- SELECT, INSERT, UPDATE, DELETE

-- Le groupe admin possède le schéma (et donc peut ALTER/DROP)
ALTER SCHEMA projet OWNER TO projet_admin;

-- Accès de base
GRANT CONNECT ON DATABASE cinetrackers TO projet_admin, projet_membre;
GRANT USAGE ON SCHEMA projet TO projet_membre;

-- Droits des membres standard sur les tables existantes
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA projet TO projet_membre;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA projet TO projet_membre;

-- Droits automatiques sur les futures tables créées par projet_admin
ALTER DEFAULT PRIVILEGES FOR ROLE projet_admin IN SCHEMA projet
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO projet_membre;
ALTER DEFAULT PRIVILEGES FOR ROLE projet_admin IN SCHEMA projet
  GRANT USAGE, SELECT ON SEQUENCES TO projet_membre;

-- Utilisateurs : 2 admins
CREATE ROLE admin1 LOGIN PASSWORD '*{ADMIN1_PASSWORD}';
CREATE ROLE admin2 LOGIN PASSWORD '*{ADMIN2_PASSWORD}';
GRANT projet_admin TO admin1, admin2;

-- Utilisateurs : 4 membres standard
CREATE ROLE membre1 LOGIN PASSWORD '*{MEMBRE1_PASSWORD}';
CREATE ROLE membre2 LOGIN PASSWORD '*{MEMBRE2_PASSWORD}';
CREATE ROLE membre3 LOGIN PASSWORD '*{MEMBRE3_PASSWORD}';
CREATE ROLE membre4 LOGIN PASSWORD '*{MEMBRE4_PASSWORD}';
GRANT projet_membre TO membre1, membre2, membre3, membre4;