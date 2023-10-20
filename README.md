# DataViz Séries temporelles

## Auteur

| Nom   | Prénom  |
| ----- | ------- |
| RIKAB | EL ARBI |

## Sujet

Les séries temporelles sont un type d'ensemble de données parmi les plus courants. Elles décrivent comment une caractéristique donnée évolue dans le temps, par exemple la population, les températures, le nombre de produits vendus, les fans de Douglas Adams.
De part leur utilisation répandue, les séries temporelles sont un bon point de départ pour apprendre à visualiser les données. Nous verrons :

- Charger une table de données à partir d'un fichier texte.

- Analyser le contenu de cette table sous une forme structurée.

- Calculer les bornes de ces données pour faciliter leur représentation.

- Trouver une représentation appropriée et considérer des alternatives.

- Affiner la représentation en considérant : le placement, les types, l'épaisseur des lignes et la couleur.

- Fournir un moyen d'interagir avec les données de façon à qu'il soit aisé de comparer les variables les unes avec les autres ou avec une moyenne de l'ensemble des données.

De plus en plus de portails "open data" s'ouvrent sur Internet, et récupérer des données de ce type est assez facile. Pour ce cours, nous utiliserons un ensemble de données indiquant l'évolution de la consommation de lait, de thé et de café entre 1910 et 2004. Le fichier suivant :

[Fichier de données ](/data/lait-the-cafe.tsv).

Notre objectif est de créer une application de traitement de données qui permet de visualiser les informations contenues dans le fichier mentionné ci-dessus. Il est important de pouvoir naviguer entre les différentes courbes avec une transition fluide. Nous devons également fournir la possibilité de sélectionner le mode d'affichage des données (ligne, histogramme ou aire) en appuyant sur n'importe quelle touche du clavier.

## Application

![Series Temporelles animation ](/data/animation.gif).

## Fonctionnement

| Touches                  | Actions                     |
| ------------------------ | --------------------------- |
| ESPACE                   | Changer les données         |
| N'importe quelle touches | changer le mode d'affichage |
