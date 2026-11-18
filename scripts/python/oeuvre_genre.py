import csv
import gzip


nom_genre = {} #intialisation du dictionnaire ayant pour clé les genres existants et pour valeur leurs id qu'on leur a attribué
cle_primaire = 1 
tab_oeuvre_genre = []


f = gzip.open("data/sources/title.basics.tsv.gz", "rt", encoding="utf-8")

ligne = f.readline()
ligne = f.readline()

while ligne != '' :
    ligne = ligne.strip().split('\t')
    titre = ligne[0]
    genres = ligne[8].split(',')
    for elem in genres :
        if elem != '\\N' :
            if elem not in nom_genre.keys() :
                nom_genre[elem] = cle_primaire
                cle_primaire += 1

            tab_oeuvre_genre.append([titre, nom_genre[elem]])
    ligne = f.readline()

f.close()


GENRE = open("data/locales/genres.csv", 'w')
nouvelle_ligne = csv.writer(GENRE, delimiter=';')
nouvelle_ligne.writerow(["id_genre", "nom_genre"])
for elem in nom_genre : 
    nouvelle_ligne.writerow([nom_genre[elem], elem])
GENRE.close()



OEUVRE_GENRE = open("data/locales/oeuvres_genres.csv", 'w')
nouvelle_ligne = csv.writer(OEUVRE_GENRE, delimiter=';')
nouvelle_ligne.writerow(["id_titre", "id_genre"])
for elem in tab_oeuvre_genre : 
    nouvelle_ligne.writerow(elem)
OEUVRE_GENRE.close()