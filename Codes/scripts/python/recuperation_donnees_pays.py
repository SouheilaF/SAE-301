import requests
import csv

tab_pays = []
offset = 0
limit = 100

while True:
    response = requests.get(
        "https://api.restcountries.com/countries/v5",
        params={
            "limit": limit,
            "offset": offset
        },
        headers={
            "Authorization": "Bearer rc_live_91d4735c3862448aadd09fd5a5458ae4"
        }
    )

    data = response.json()

    for elem in data['data']['objects']:
        tab_pays.append([elem['codes']['alpha_2'],elem['names']['common']])

    if not data['data']['meta']['more']:
        break

    offset += limit

# L'API limite chaque requête à 100 résultats maximum.
# Pour récupérer tous les pays, on utilise une pagination :
# - limit définit le nombre de résultats récupérés par requête.
# - offset indique à partir de quel résultat commencer.
# À chaque requête, offset augmente de 100 pour récupérer les résultats suivants.
# La boucle s'arrête lorsque l'API indique qu'il n'y a plus de résultats.
# Les pays récupérés sont ajoutés au tableau tab_pays.



PAYS = open("data/locales/pays.csv", "w")
nouvelle_ligne = csv.writer(PAYS, delimiter=';')
nouvelle_ligne.writerow(["code_pays", "nom_pays"])
nouvelle_ligne.writerows(tab_pays)
PAYS.close()