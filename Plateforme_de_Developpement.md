## Configuration initiale :

* Système serveur : Ubuntu Server 26.04 LTS -> Environnement Linux de référence
* Ce serveur Ubuntu est adapté à l’hébergement web.
* Serveur web : Apache HTTP Server 2.4 -> Reçoit les requêtes du navigateur
* Langage serveur : PHP 8.5 -> Exécute la logique de l'application.
Il permet de traiter les recherches de films en interrogeant les base de données et fait aussi des pages dynamiques.
* Base de données : PostgresSQL 18.7 -> Stocke les films, personnes, séries.
* Interface web : Bootstrap 5.3 -> Mise en forme responsive du site
* JavaScript : jQuery 3.7 -> Interactions complémentaires
* Accès à la base : Extension PHP PDO_PGSQL -> Permet à PHP de communiquer avec PostgresSQL
* Environnement de développement : Docker Desktop 29.8.2 et Docker Compose 5.6.0 -> Reproduit l'environnement sur les postes Windows au lieu qu'on ait une machine virtuelle
* Gestion du code : Git et GitHub -> Partage et suivi des modifications
