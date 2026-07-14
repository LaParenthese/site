# La Parenthèse — Café & Librairie

Site vitrine de la librairie-café **La Parenthèse** (47 rue des Martyrs,
77920 Samois-sur-Seine — 01 64 70 68 93).

Site statique généré avec [Hugo](https://gohugo.io/) et le thème
[Ananke](https://github.com/theNewDynamic/gohugo-theme-ananke) (copié dans
`themes/ananke`, aucune dépendance externe à installer).

## Publier une actualité

1. Créer un fichier dans `content/actualites/`, par exemple
   `2026-09-01-rentree-litteraire.md` :

   ```markdown
   ---
   title: "La rentrée littéraire est arrivée"
   date: 2026-09-01
   summary: "Une phrase de résumé affichée dans la liste."
   ---

   Le texte du billet, en Markdown.
   ```

2. Enregistrer, puis pousser sur la branche `main` (ou éditer le fichier
   directement sur GitHub → bouton *Commit changes*). Le site se
   reconstruit et se met en ligne automatiquement en ~1 minute.

Même principe pour un événement : fichier dans `content/agenda/`.

En local, on peut aussi utiliser : `hugo new content actualites/mon-billet.md`

## Prévisualiser en local

[Installer Hugo](https://gohugo.io/installation/) (version « extended »,
un seul exécutable), puis :

```sh
hugo server
```

et ouvrir http://localhost:1313 — la page se rafraîchit à chaque
modification de fichier.

## Déploiement (Cloudflare Pages)

1. Pousser ce dépôt sur GitHub (compte de la librairie).
2. Dans le tableau de bord Cloudflare : **Workers & Pages → Create →
   Pages → Connect to Git**, choisir le dépôt.
3. Réglages de build :
   - Framework preset : **Hugo**
   - Build command : `hugo --minify`
   - Build output directory : `public`
   - Variable d'environnement : `HUGO_VERSION` = `0.164.0`
4. Une fois le domaine enregistré, l'ajouter dans **Custom domains**,
   puis mettre à jour `baseURL` dans `hugo.toml`.

## Personnalisation

- **Couleurs** : tout est dans `assets/ananke/css/custom.css` (bloc
  `:root` en tête de fichier). Si le logo change, c'est le seul
  endroit à modifier.
- **Menu, titre** : `hugo.toml`.
- **Pied de page** (adresse, horaires, e-mail) :
  `layouts/_partials/site-footer.html`.
- **Horaires / e-mail / coordonnées GPS pour Google** : marqués `TODO`
  dans `layouts/_partials/head-additions.html`, `content/contact.md`
  et le pied de page.

## Reste à faire

- [ ] Renseigner les vrais horaires (contact.md, pied de page, head-additions.html)
- [ ] Remplacer les billets d'exemple dans `content/actualites/` et `content/agenda/`
- [ ] Compléter la page `content/la-librairie.md`
- [ ] Ajouter des photos (devanture, intérieur) dans `static/images/`

