import csv
import gzip

tab_principals = set()
tab_job = {}
cle_primaire = 1


tab_profession = {}

PROFESSION = open("data/locales/professions.csv", "r")

p_ligne = PROFESSION.readline()
p_ligne = PROFESSION.readline()

while p_ligne != '' :
    p_donnees = p_ligne.strip().split(';')
    tab_profession[p_donnees[1]] = p_donnees[0]

    p_ligne = PROFESSION.readline()

PROFESSION.close()

id_director = tab_profession['director']
id_writer = tab_profession['writer']



PARTICIPATION_OEUVRE = open("data/locales/participations_oeuvres.csv", "w")
nouvelle_ligne = csv.writer(PARTICIPATION_OEUVRE, delimiter=';')
nouvelle_ligne.writerow(['titre', 'ordering' ,'personne', 'id_profession', 'id_job', 'characters'])

g = gzip.open("data/sources/title.principals.tsv.gz", "rt", encoding="utf-8")
f = gzip.open("data/sources/title.crew.tsv.gz", "rt", encoding="utf-8")


g_ligne = g.readline()
g_ligne = g.readline()

f_ligne = f.readline()
f_ligne = f.readline()

while g_ligne != '' or f_ligne != '' :

    if f_ligne == '' or (g_ligne != '' and g_ligne.split('\t')[0] < f_ligne.split('\t')[0]) :
        titre = g_ligne.split('\t')[0]
        tab_principals.clear()

        while g_ligne != '' and g_ligne.split('\t')[0] == titre :
            g_donnees = g_ligne.strip().split('\t')
            g_titre = g_donnees[0]
            g_ordering = g_donnees[1]
            g_personne = g_donnees[2]
            g_profession = g_donnees[3]
            g_job = g_donnees[4]
            g_characters = g_donnees[5]

            if g_job not in tab_job.keys() :
                if g_job != '\\N' :
                    tab_job[g_job] = cle_primaire
                    cle_primaire += 1

            ensemble = (g_titre, g_personne, g_profession)

            if ensemble not in tab_principals :
                tab_principals.add(ensemble)

                if g_profession == '\\N' :
                    id_profession = '\\N'
                else :
                    id_profession = tab_profession[g_profession]

                if g_job == '\\N' :
                    id_job = '\\N'
                else :
                    id_job = tab_job[g_job]

                nouvelle_ligne.writerow([g_titre, g_ordering, g_personne, id_profession, id_job, g_characters])


            g_ligne = g.readline()

    elif g_ligne == '' or f_ligne.split('\t')[0] < g_ligne.split('\t')[0] :
        titre = f_ligne.split('\t')[0]
        tab_principals.clear()

        while f_ligne != '' and f_ligne.split('\t')[0] == titre :
            f_donnees = f_ligne.strip().split('\t')
            f_personne_director = f_donnees[1]
            f_personne_writer = f_donnees[2]

            if f_personne_director != '\\N' :
                for personne in f_personne_director.split(',') :
                    ensemble = (titre, personne, 'director')

                    if ensemble not in tab_principals :
                        tab_principals.add(ensemble)
                        nouvelle_ligne.writerow([titre, '\\N', personne, id_director, '\\N', '\\N'])



            if f_personne_writer != '\\N' :
                for personne in f_personne_writer.split(',') :
                    ensemble = (titre, personne, 'writer')

                    if ensemble not in tab_principals :
                        tab_principals.add(ensemble)
                        nouvelle_ligne.writerow([titre, '\\N', personne, id_writer, '\\N', '\\N'])

            f_ligne = f.readline()

    else :

        titre = g_ligne.split('\t')[0]
        tab_principals.clear()


        while g_ligne != '' and g_ligne.split('\t')[0] == titre :
            g_donnees = g_ligne.strip().split('\t')
            g_titre = g_donnees[0]
            g_ordering = g_donnees[1]
            g_personne = g_donnees[2]
            g_profession = g_donnees[3]
            g_job = g_donnees[4]
            g_characters = g_donnees[5]

            if g_job not in tab_job.keys() :
                if g_job != '\\N' :
                    tab_job[g_job] = cle_primaire
                    cle_primaire += 1

            ensemble = (g_titre, g_personne, g_profession)

            if ensemble not in tab_principals :
                tab_principals.add(ensemble)

                if g_profession == '\\N' :
                    id_profession = '\\N'
                else :
                    id_profession = tab_profession[g_profession]

                if g_job == '\\N' :
                    id_job = '\\N'
                else :
                    id_job = tab_job[g_job]

                nouvelle_ligne.writerow([g_titre, g_ordering, g_personne, id_profession, id_job, g_characters])


            g_ligne = g.readline()


        while f_ligne != '' and f_ligne.split('\t')[0] == titre :
            f_donnees = f_ligne.strip().split('\t')
            f_personne_director = f_donnees[1]
            f_personne_writer = f_donnees[2]

            if f_personne_director != '\\N' :
                for personne in f_personne_director.split(',') :
                    ensemble = (titre, personne, 'director')

                    if ensemble not in tab_principals :
                        tab_principals.add(ensemble)
                        nouvelle_ligne.writerow([titre, '\\N', personne, id_director, '\\N', '\\N'])



            if f_personne_writer != '\\N' :
                for personne in f_personne_writer.split(',') :
                    ensemble = (titre, personne, 'writer')

                    if ensemble not in tab_principals :
                        tab_principals.add(ensemble)
                        nouvelle_ligne.writerow([titre, '\\N', personne, id_writer, '\\N', '\\N'])

            f_ligne = f.readline()


g.close()
f.close()
PARTICIPATION_OEUVRE.close()


JOB = open("data/locales/jobs.csv", "w")
nouvelle_ligne = csv.writer(JOB, delimiter=';')
nouvelle_ligne.writerow(["id_job", "nom_job"])
for elem in tab_job :
    nouvelle_ligne.writerow([tab_job[elem], elem])
JOB.close()