import csv


tab_langues = []


f = open("data/sources/langues.txt", "r", encoding='utf-8-sig')

ligne = f.readline()

while ligne != '' :
    ligne = ligne.strip().split('|')
    if ligne[0] != '' :
        tab_langues.append([ligne[0], ligne[4]])
    if ligne[2] != '' :
        tab_langues.append([ligne[2], ligne[4]])
    ligne = f.readline()

f.close()


LANGUES = open("data/locales/langues.csv", 'w')
nouvelle_ligne = csv.writer(LANGUES, delimiter=';')
nouvelle_ligne.writerow(["code_langue", "nom_langue"])
nouvelle_ligne.writerows(tab_langues)
LANGUES.close()