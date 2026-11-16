import csv
import gzip
 
 
tab_personne_profession = set()
tab_nom_profession = {}
cle_primaire = 1
 
PERSONNE_PROFESSION = open("data/locales/personnes_professions.csv", 'w')
nouvelle_ligne = csv.writer(PERSONNE_PROFESSION, delimiter=';')
nouvelle_ligne.writerow(["id_personne", "id_profession"])
 
 
f = gzip.open("data/sources/name.basics.tsv.gz", "rt", encoding="utf-8")
 
ligne = f.readline()
ligne = f.readline()
 
while ligne != '' :
    ligne = ligne.strip().split('\t')
    personne = ligne[0]
    profession = ligne[4].split(',')
    tab_personne_profession.clear()
 
    for elem in profession :
        if elem != '\\N' and elem != '' :
            if elem not in tab_nom_profession.keys() :
                tab_nom_profession[elem] = cle_primaire
                cle_primaire += 1
 
            ensemble = (personne, tab_nom_profession[elem])
 
            if ensemble not in tab_personne_profession :
                tab_personne_profession.add(ensemble)
                nouvelle_ligne.writerow([personne, tab_nom_profession[elem]])
 
    ligne = f.readline()
 
f.close()
 
 
g = gzip.open("data/sources/title.principals.tsv.gz", "rt", encoding="utf-8")
 
ligne = g.readline()
ligne = g.readline()
 
while ligne != '' :
    profession = ligne.split('\t')[3]
 
    if profession != '\\N' :
        if profession not in tab_nom_profession.keys() :
            tab_nom_profession[profession] = cle_primaire
            cle_primaire += 1
 
    ligne = g.readline()
 
g.close()
PERSONNE_PROFESSION.close()
 
 
PROFESSION = open("data/locales/professions.csv", 'w')
nouvelle_ligne = csv.writer(PROFESSION, delimiter=';')
nouvelle_ligne.writerow(["id_profession", "nom_profession"])
for elem in tab_nom_profession :
    nouvelle_ligne.writerow([tab_nom_profession[elem], elem])
PROFESSION.close()