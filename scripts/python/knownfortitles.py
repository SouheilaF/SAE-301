import csv
import gzip


tab_titre_connue = [] #initialisation du tableau de titre connue qui contiendra un tableau de personne associée à un titre auquel il a joué


f = gzip.open("data/sources/name.basics.tsv.gz", "rt", encoding="utf-8") #lecture du fichier name.basics.tsv.gz en texte après dézippage

ligne = f.readline() #lecture première ligne pour l'en-tête
ligne = f.readline() #lecture première ligne des données

while ligne != '' : #tant qu'on a pas atteint la fin du fichier
    ligne = ligne.strip().split('\t') #transformation de la ligne en tableau avec comme délimiteur la tabulation et suppression des espaces
    personne = ligne[0] #récupération de nconst qui représente la clé primaire 
    colonne = ligne[5].split(',')
    for titre in colonne :
        if titre != '\\N' :
            tab_titre_connue.append([personne, titre])
    ligne = f.readline()
f.close()


TITRE = open("data/locales/titres_connues.csv", 'w') #création du fichier qui contient les id de personne et de titre
nouvelle_ligne = csv.writer(TITRE, delimiter=';') #initialisation de l'écriture dans le fichier
nouvelle_ligne.writerow(["id_personne", "id_titre"]) #écriture de l'en-tête
for titre in tab_titre_connue : 
    nouvelle_ligne.writerow(titre) #écriture de chaque ligne à partir du tableau tab_titre_connue
TITRE.close()
