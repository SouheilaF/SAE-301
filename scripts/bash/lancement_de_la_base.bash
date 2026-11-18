
#!/bin/bash

debut=$SECONDS

# Mesure le temps de chaque étape
temps() {
    nom="$1"
    shift

    echo ""
    echo "=== $nom ==="

    /usr/bin/time -f "%e secondes" "$@"
}

echo ""
echo "=================================================="
echo "          INITIALISATION DE CINETRACKERS"
echo "=================================================="
echo ""

echo "[1/13] Suppression et création de la base de données..."
sudo -u postgres dropdb --force cinetrackers
sudo -u postgres createdb cinetrackers


echo ""
echo "[2/13] Récupération des données IMDb..."
temps "Récupération IMDb" bash scripts/bash/script_recuperation_donnees.bash

echo ""
echo "[3/13] Récupération des données sur les langues..."
temps "Langues" python3 scripts/python/recuperation_donnees_langues.py

echo ""
echo "[4/13] Récupération des données sur les pays..."
temps "Pays" python3 scripts/python/recuperation_donnees_pays.py

echo ""
echo "[5/13] Préparation des genres des œuvres..."
temps "Genres" python3 scripts/python/oeuvre_genre.py

echo ""
echo "[6/13] Récupération des titres connus des personnes..."
temps "Titres connus" python3 scripts/python/knownfortitles.py

echo "[7/13] Récupération des professions des personnes..."
temps "Professions" python3 scripts/python/primaryprofession.py

echo "[8/13] Préparation des participations aux œuvres..."
temps "Participations" python3 scripts/python/participation_oeuvre.py

echo ""
echo "[9/13] Création et remplissage des tables intermédiaires..."
temps "Tables intermédiaires" sudo -u postgres psql -d cinetrackers -f scripts/sql/tables_intermediaires.sql

echo ""
echo "[10/13] Création des tables définitives..."
temps "Tables définitives" sudo -u postgres psql -d cinetrackers -f scripts/sql/creation_tables.sql

echo ""
echo "[11/13] Importation des données dans les tables définitives..."
temps "Importation" sudo -u postgres psql -d cinetrackers -f scripts/sql/importations_donnees.sql

echo ""
echo "[12/13] Ajout des contraintes sur les tables définitives..."
temps "Contraintes" sudo -u postgres psql -d cinetrackers -f scripts/sql/contraintes.sql

echo ""
echo "[13/13] Création des indexs sur les tables définitives..."
temps "Indexs" sudo -u postgres psql -d cinetrackers -f scripts/sql/creation_index.sql

echo ""
echo "=================================================="
echo "       INITIALISATION TERMINÉE AVEC SUCCÈS"
echo "=================================================="
echo ""

echo "Durée totale : $((SECONDS - debut)) secondes"
echo "Script terminé à $(date '+%H:%M:%S')"
