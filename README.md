# Classification supervisée d'organismes zooplanctoniques

# Avant-propos

Ce projet nécessite d'avoir assimilé l'ensemble des notions des premier et second modules du cours de science des données biologiques 3. Il correspond au dépôt GitHub <https://github.com/BioDataScience-Course/C02Ia_zoo>.

# Objectifs

Ce projet est un projet **individuel** et **cadré**. Vous devrez :

-   Optimiser les attributs utilisés pour la classification d'un jeu de données
-   Entraîner et optimiser trois classifieurs différents
-   Comparer les classifieurs et choisir le meilleur d'entre eux

# Consignes

Dans le carnet de notes `zooplankton_notebook.qmd`, vous allez créer le classifieur le plus performant pour classer du zooplancton sur base d'attributs obtenus par analyse d'image. Vous ne séparerez pas le jeu de données initial en set d'apprentissage et de test, mais vous utiliserez la validation croisée dix fois que vous venez d'apprendre dans le module 2 du cours pour évaluer les performances de vos classifieurs que vous entraînerez par ailleurs sur l'ensemble des données (réduites de celles qui contiennent éventuellement des valeurs manquantes).

Trois étapes sont importantes ici :

-   la sélection des attributs et le calcul éventuel de nouveaux attributs dérivés par feature engineering (temps estimé à 2h)

-   l'entraînement de trois classifieurs avec les méthodes k plus proches voisins, partitionnement récursif et forêt aléatoire, ainsi que l'optimisation de chacun d'eux (temps estimé à 2-3h max)

-   le choix du meilleur classifieur pour classer automatiquement un échantillon de plancton et la justification de votre choix dans les conclusions (y compris la ou les métriques que vous avez utilisées et pourquoi) (30min - 1h finalisation du projet comprise).

# Informations sur les données

Ces données ont été employées dans le cadre de la publication suivante :

[Fullgrabe, Lovina, Philippe Grosjean, Sylvie Gobert, Pierre Lejeune, Michèle Leduc, Guyliann Engels, Patrick Dauby, Pierre Boissery, and Jonathan Richir. 2020. "Zooplankton dynamics in a changing environment: A 13-year survey in the northwestern Mediterranean Sea." Marine Environmental Research 159: 104962.](https://doi.org/10.1016/j.marenvres.2020.104962)

L'article suivant propose des explications détaillées sur l'identification d'organismes planctoniques grâce au ZOOSCAN :

[Philippe Grosjean, Marc Picheral, Caroline Warembourg, Gabriel Gorsky, Enumeration, measurement, and identification of net zooplankton samples using the ZOOSCAN digital imaging system, ICES Journal of Marine Science, Volume 61, Issue 4, 2004, Pages 518--525](https://doi.org/10.1016/j.icesjms.2004.03.012)

Un guide pratique d'identification en français est à également à votre disposition : [Guide d'identification des organismes mésozooplanctoniques de la Mer Ligurienne](https://econum.github.io/zooimage_mesozooplankton_guide1/)
