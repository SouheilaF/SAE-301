#!/bin/bash

mkdir -p data/locales data/sources 
cd data/sources

echo ""
echo "=================================================="
echo "          RÉCUPÉRATION DES DONNÉES IMDb"
echo "=================================================="
echo ""

echo "[1/2] Téléchargement des fichiers IMDb..."

wget -N https://datasets.imdbws.com/name.basics.tsv.gz
wget -N https://datasets.imdbws.com/title.akas.tsv.gz
wget -N https://datasets.imdbws.com/title.basics.tsv.gz
wget -N https://datasets.imdbws.com/title.crew.tsv.gz
wget -N https://datasets.imdbws.com/title.episode.tsv.gz
wget -N https://datasets.imdbws.com/title.principals.tsv.gz
wget -N https://datasets.imdbws.com/title.ratings.tsv.gz


echo ""
echo "[2/2] Récupération des données sur les langues..."

wget -N https://www.loc.gov/standards/iso639-2/ISO-639-2_utf-8.txt
mv -f ISO-639-2_utf-8.txt langues.txt

echo ""
echo "=================================================="
echo "       RÉCUPÉRATION TERMINÉE AVEC SUCCÈS"
echo "=================================================="
echo ""

cd ../..
