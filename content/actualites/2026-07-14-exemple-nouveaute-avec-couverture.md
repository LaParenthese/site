---
title: "Exemple — Une nouveauté avec couverture"
date: 2026-07-14
summary: "Le modèle à recopier pour présenter un livre avec sa couverture."
tags: ["nouveautés"]
---

*Ceci est un billet d'exemple, à recopier puis remplacer.*

{{< livre src="/images/couvertures/exemple-couverture.svg"
          titre="Titre du livre"
          auteur="Nom de l'auteur"
          editeur="Éditeur"
          prix="21 €" >}}
La chronique du livre s'écrit ici, à côté de la couverture : quelques
lignes sur l'histoire, ce qui nous a plu, à qui on a envie de le
conseiller.

On peut écrire plusieurs paragraphes — le texte habille la couverture
automatiquement.
{{< /livre >}}

**Mode d'emploi** (à supprimer dans un vrai billet) :

1. Déposer la photo de la couverture dans `static/images/couvertures/`
   (par ex. `mon-livre.jpg`) ;
2. Copier ce fichier, changer le titre, la date et le résumé en haut ;
3. Dans la balise `livre`, remplacer `src` par le chemin de l'image
   (`/images/couvertures/mon-livre.jpg`), puis le titre, l'auteur,
   l'éditeur et le prix ;
4. Écrire la chronique entre la balise ouvrante et la balise fermante.

On peut enchaîner plusieurs blocs `livre` dans le même billet pour
présenter plusieurs nouveautés d'un coup.
