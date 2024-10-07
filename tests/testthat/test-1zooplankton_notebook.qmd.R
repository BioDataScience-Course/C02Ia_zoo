# Vérifications de zooplankton_notebook.qmd
zoo <- parse_rmd("../../zooplankton_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("zooplankton_notebook.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("zooplankton_notebook.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Résultats", "Feature engineering",
    "Phase d'apprentissage et optimisation des trois classifieurs",
    "K plus proches voisins", "Partitionnement récursif", "Forêt aléatoire",
    "Discussion et conclusion", "Bibliographie")
    %in% (rmd_node_sections(zoo) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import", "desc", "desccomment", "attrib",
    "select", "acp", "acpcomment", "acpvars", "acpvarscomment",
    "knn", "knn_confusion", "knn_metrics",
    "rpart", "rpart_plot", "rpart_confusion", "rpart_metrics",
    "rforest", "rf_plot", "rf_confusion", "rf_metrics")
    %in% rmd_node_label(zoo)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(zoo))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(zoo[[1]]$author != "___")
  expect_true(!grepl("__", zoo[[1]]$author))
  expect_true(grepl("^[^_]....+", zoo[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", zoo[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", zoo[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("L'introduction et le matériel et méthodes sont-ils complétés ?", {
  expect_true((rmd_select(zoo, by_section("Introduction et but")) |>
    as_document() |> grepl(get_word("ztexN"), x = _, fixed = TRUE) |> any()))
  expect_true((rmd_select(zoo, by_section("Matériel et méthodes")) |>
    as_document() |> grepl(get_word("yDx2P:A"), x = _, fixed = TRUE) |> any()))
  expect_true((rmd_select(zoo, by_section("Matériel et méthodes")) |>
    as_document() |> grepl(get_word("7%9E]>]{G"), x = _, fixed = TRUE) |> any()))
  # Un ou plusieurs champs manquants n'ont pas été complétés correctement
  # Lisez bien les articles cités (en particulier l'abstract, l'introduction et
  # le matériel et méthodes) et retrouvez les trois mots manquants que vous
  # indiquez dans le texte du document Quarto à la place des ___.
})

test_that("Chunk 'import' : importation des données", {
  expect_true(is_identical_to_ref("import", "names"))
  # Les colonnes dans le tableau `zoo` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'import'.

  expect_true(is_identical_to_ref("import", "classes"))
  # La nature des variables (classe) dans le tableau `zoo` est incorrecte
  # Vérifiez le chunk d'importation des données `import`.

  expect_true(is_identical_to_ref("import", "nrow"))
  # Le nombre de lignes dans le tableau `zoo` est incorrect
  # Vérifiez l'importation des données dans le chunk d'importation `import` et
  # réexécutez-le pour corriger le problème.
})

test_that("Chunks 'desc' & 'desccomment' : description des données", {
  expect_true(is_identical_to_ref("desc"))
  # La description produite par le chunk 'desc' n'est pas celle attendue
  # Lisez bien la consigne et corrigez l'erreur. Si le test précédent
  # d'importation est incorrect, celui-ci l'est aussi automatiquement. Sinon,
  # vérifiez le code du chunk et corrigez-le.

  expect_true(is_identical_to_ref("desccomment"))
  # L'interprétation de la description des données est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("La section feature engineering (équations) est-elle complétée ?", {
  expect_true((rmd_select(zoo, by_section("Feature engineering")) |>
      as_document() |> grepl(get_word("8D?<r@A"), x = _, fixed = TRUE) |> any()))
  expect_true((rmd_select(zoo, by_section("Feature engineering")) |>
      as_document() |> grepl(get_word("/O$Jt@H18!XGB"), x = _, fixed = TRUE) |> any()))
  expect_true((rmd_select(zoo, by_section("Feature engineering")) |>
      as_document() |> grepl(get_word("gzmfY"), x = _, fixed = TRUE) |> any()))
  # Un ou plusieurs champs manquants n'ont pas été complétés correctement
  # Lisez bien le document biblio/quivy_master_thesis_appendix3.pdf et retrouvez
  # les trois mots manquants que vous indiquez dans les équations aux
  # emplacements marqués par ___.
})
  
test_that("Chunks 'attrib' et 'select' : la feature engineering est-elle correcte ?", {
  expect_true(is_identical_to_ref("attrib", "names"))
  # Les colonnes dans le tableau `zoo` remanié ne sont pas celles attendues
  # Vérifiez vos calculs dans le chunk 'attrib'. Calculez les variables dans le
  # même ordre que ci-dessus et avec le même nom.
  
  expect_true(is_identical_to_ref("attrib", "classes"))
  # La nature des variables (classe) dans le tableau `zoo` remanié est
  # incorrecte
  # Vérifiez le chunk `attrib` de création de variables calculées. Il doit y
  # avoir une erreur dans votre code à ce niveau-là
  
  expect_true(is_identical_to_ref("attrib", "nrow"))
  # Le nombre de lignes dans le tableau `zoo` est incorrect après remaniement
  # des données
  # Si les tests précédents ont réussi, vérifiez les instructions que vous avez
  # rentrées dans le chunk `attrib` et refaites un rendu du document pour
  # corriger le problème.
  
  expect_true(is_identical_to_ref("select", "names"))
  # Les colonnes dans le tableau `zoo2` avec variables sélectionnées ne sont pas
  # celles attendues
  # Vérifiez votre instruction dans le chunk 'select', ainsi que la liste des
  # variables à éliminer ou à conserver. Vous devriez obtenir 29 variables au
  # final dans le jeu de données.
  
  expect_true(is_identical_to_ref("select", "classes"))
  # La nature des variables (classe) dans le tableau `zoo2` final est incorrecte
  # Vérifiez le chunk `select` de création de variables calculées. Il doit y
  # avoir une erreur dans votre code à ce niveau-là
  
  expect_true(is_identical_to_ref("select", "nrow"))
  # Le nombre de lignes dans le tableau `zoo2` est incorrect après remaniement
  # des données
  # Si les tests précédents ont réussi, vérifiez les instructions que vous avez
  # rentrées dans le chunk `select`. Vous devez sélectionner les variables
  # (colonnes) à conserver, mais sans altérer le nombre d'items (lignes) du
  #tableau. Refaites un rendu du document une fois l'erreur corrigée.
})

test_that("Chunks 'acp', 'acpcomment' : ACP première partie", {
  expect_true(is_identical_to_ref("acp"))
  # L'analyse en composantes principales n'est pas réalisée ou est incorrecte
  # Relisez les consignes et vérifiez votre code concernant cette analyse.
  # Réfléchissez bien : faut-il mettre à l'échelle les variables ou non ?
  
  expect_true(is_identical_to_ref("acpcomment"))
  # L'interprétation du graphique des éboulis de l'ACP est (partiellement)
  # fausse
  # Normalement, on regarde si les premières variables capturent ou non une part
  # importante de la variance totale. Ceci indique si la représentation des
  # variables et des individus sera plus ou moins fidèle aux données ensuite.
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'acpvars', 'acpvarscomment' : ACP seconde partie", {
  expect_true(is_identical_to_ref("acpvars"))
  # Le graphique des l'ACP (espace des variables) n'est pas réalisé ou est
  # incorrect
  # Relisez les consignes et vérifiez votre code concernant ce graphique.
  # Au besoin, revoyez la section concernant l'ACP dans le chapitre 7 du cours 2
  # pour vous rappeler comment réaliser un tel graphique.
  # Naturellement, si les tests ACP première partie échouent, il est normal que
  # ceux-ci ne réussisent pas non plus. Corrigez d'abord le chunk `acp` alors.
  
  expect_true(is_identical_to_ref("acpvarscomment"))
  # L'interprétation du graphique de l'ACP dans l'espace des variables est
  # (partiellement) fausse
  # Ce graphique n'est pas facile à lire parce que les vecterurs sont petits,
  # nombreux et superposés. Il y a quand même moyen de voir des tendances se
  # dessiner. À partir de là, quelques phrases font sens dans les choix offerts.
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'knn', `knn_confusion' & 'knn_metrics' : k plus proches voisins", {
  expect_true(is_identical_to_ref("knn"))
  # Le classifieur k plus proches voisins n'est pas réalisé ou est différent de 
  # celui considéré comme optimal par vos enseignants (cela peut se produire, il
  # n'y a pas qu'une seule "vérité" absolue ici). Si vous êtes confiant•e dans
  # votre travail, alors gardez le classifieur que vous avez réalisé. Sinon,
  # discutez-en avec vos enseignants pour vous assurer d'être dans le bon.
  
  expect_true(is_identical_to_ref("knn_confusion"))
  # Vous n'avez pas obtenu la même matrice de confusion pour le classifieur k
  # plus proches voisins que vos enseignants, ou vous ne l'avez pas calculée
  # Si votre classifieur est différent (test précédent), c'est normal. Sinon,
  # vérifiez vos calculs. N'oubliez pas que l'on vous demande de calculer cette
  # matrice de confusion à l'aide de la validation croisée dix fois.
  
  expect_true(is_identical_to_ref("knn_metrics"))
  # Le calcul des métriques de performance pour votre classifieur k plus proches
  # voisins n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Quel que soit le résultat des deux tests précédents (donc, même si vous avez
  # un classifieur différent de la solution de référence), ce test doit passer.
  # Si ce n'est pas le cas, relisez bien les consignes et corrigez votre code
  # avant de refaire un rendu du document Quarto pour revérifier.
  
  expect_true(!(rmd_select(zoo, by_section("K plus proches voisins")) |>
    as_document() |> grepl("...explication de votre optimisation ici...",
      x = _, fixed = TRUE) |> any()))
  # L'explication sur l'optimisation du classifieur k plus proches voisins
  # n'est pas faite
  # Remplacez "...explication de votre optimisation ici..." par vos phrases de
  # commentaires libres.
})

test_that("Chunks 'rpart', `rpart_confusion' & 'rpart_metrics' : partitionnement récursif", {
  expect_true(is_identical_to_ref("rpart"))
  # Le classifieur par partitionnement récursif n'est pas réalisé ou est
  # différent de celui considéré comme optimal par vos enseignants (cela peut se
  # produire, il n'y a pas qu'une seule "vérité" absolue ici). Si vous êtes
  # confiant•e dans votre travail, alors gardez le classifieur que vous avez
  # réalisé. Sinon, discutez-en avec vos enseignants pour vous assurer d'être
  # dans le bon. Cet algorithme admets beaucoup de paramètres différents, mais
  # nous n'avons rien détaillé dans le cours. Ne passez pas trop de temps à
  # essayer d'optimiser ce classifieur-ci et passez rapidement au suivant (mais
  # vous pouvez quand même tester quelque chose en vous basant sur
  # ?rapart::rpart).
  
  expect_true(is_identical_to_ref("rpart_confusion"))
  # Vous n'avez pas obtenu la même matrice de confusion pour le classifieur par
  # partitionnement récursif que vos enseignants, ou vous ne l'avez pas calculée
  # Si votre classifieur est différent (test précédent), c'est normal. Sinon,
  # vérifiez vos calculs. N'oubliez pas que l'on vous demande de calculer cette
  # matrice de confusion à l'aide de la validation croisée dix fois.
  
  expect_true(is_identical_to_ref("rpart_metrics"))
  # Le calcul des métriques de performance pour votre classifieur par
  # partitionnement récursif n'est pas fait, ou n'est pas conforme
  # Quel que soit le résultat des deux tests précédents (donc, même si vous avez
  # un classifieur différent de la solution de référence), ce test doit passer.
  # Si ce n'est pas le cas, relisez bien les consignes et corrigez votre code
  # avant de refaire un rendu du document Quarto pour revérifier.
  
  expect_true(!(rmd_select(zoo, by_section("Partitionnement récursif")) |>
    as_document() |> grepl("...explication de votre optimisation ici...",
      x = _, fixed = TRUE) |> any()))
  # L'explication sur l'optimisation du classifieur par partitionnement récursif
  # n'est pas faite
  # Remplacez "...explication de votre optimisation ici..." par vos phrases de
  # commentaires libres.
})

test_that("Chunks 'rforest', `rf_confusion' & 'rf_metrics' : forêt aléatoire", {
  expect_true(is_identical_to_ref("rforest"))
  # Le classifieur forêt aléatoire n'est pas réalisé ou est différent de 
  # celui considéré comme optimal par vos enseignants (cela peut se produire, il
  # n'y a pas qu'une seule "vérité" absolue ici). Si vous êtes confiant•e dans
  # votre travail, alors gardez le classifieur que vous avez réalisé. Sinon,
  # discutez-en avec vos enseignants pour vous assurer d'être dans le bon.
  
  # For unknown reasons, the test of the confusion matrix fails, while the
  # next test for metrics (rf_metrics) passes. This is why we skip this test.
  #expect_true(is_identical_to_ref("rf_confusion"))
  # Vous n'avez pas obtenu la même matrice de confusion pour le classifieur
  # forêt aléatoire que vos enseignants, ou vous ne l'avez pas calculée
  # Si votre classifieur est différent (test précédent), c'est normal. Sinon,
  # vérifiez vos calculs. N'oubliez pas que l'on vous demande de calculer cette
  # matrice de confusion à l'aide de la validation croisée dix fois.
  
  expect_true(is_identical_to_ref("rf_metrics"))
  # Le calcul des métriques de performance pour votre classifieur forêt
  # aléatoire n'est pas fait, ou n'est pas conforme à ce qui est attendu
  # Quel que soit le résultat des deux tests précédents (donc, même si vous avez
  # un classifieur différent de la solution de référence), ce test doit passer.
  # Si ce n'est pas le cas, relisez bien les consignes et corrigez votre code
  # avant de refaire un rendu du document Quarto pour revérifier.
  
  expect_true(!(rmd_select(zoo, by_section("Forêt aléatoire")) |>
      as_document() |> grepl("...explication de votre optimisation ici...",
        x = _, fixed = TRUE) |> any()))
  # L'explication sur l'optimisation du classifieur forêt aléatoire
  # n'est pas faite
  # Remplacez "...explication de votre optimisation ici..." par vos phrases de
  # commentaires libres.
  
  expect_true(!(rmd_select(zoo, by_section("Forêt aléatoire")) |>
      as_document() |> grepl("...choix des métriques ici...",
        x = _, fixed = TRUE) |> any()))
  # L'explication sur le choix des métriques et les critères de choix du
  # meilleur classifieur n'est pas faite
  # Remplacez "...choix des métriques ici..." par vos phrases de commentaires
  # libres.
})

test_that("La partie discussion et conclusion est-elle remplie ?", {
  expect_true(!(rmd_select(zoo, by_section("Discussion et conclusion")) |>
    as_document() |> grepl("...votre discussion ici...", x = _,
      fixed = TRUE) |> any()))
  # La discussion et la conclusion ne sont pas faites
  # Remplacez "...votre discussion ici..." par vos phrases de commentaires
  # libres (à noter que le contenu de cette section n'est pas évalué
  # automatiquement, mais il le sera par vos enseignants).
})
