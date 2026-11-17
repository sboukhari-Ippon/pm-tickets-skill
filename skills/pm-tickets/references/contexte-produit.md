# Charger le contexte : exemples, doc, dépôt, maquette

Une fois par sujet dans la conversation, parce que chaque lecture coûte de la place dans la fenêtre de contexte. Budget total visé : environ 36 000 caractères (12 000 par source).

## Exemples de tickets

Ordre de priorité, le premier l'emporte :
1. un ticket type collé dans la conversation ;
2. les fichiers de `examplesDir` (si configuré), puis de `~/.pm-tickets/examples/` ;
3. les exemples livrés avec ce skill, dans `references/examples/`.

- À nom de fichier identique, l'exemple de la personne remplace l'exemple livré.
- Fichiers lus : `.md`, `.markdown`, `.txt`. Ignorés : noms commençant par `_` ou `.`, et `readme`, `nomenclature`, `index`.
- Budget : 12 000 caractères en tout. Ordre de lecture : les exemples du type visé (`story-`, `bug-`, `task-`), ceux dont le nom touche le sujet en premier, puis par ordre alphabétique ; ensuite les fichiers sans préfixe de type. Un fichier qui ferait dépasser le budget est sauté, jamais coupé.
- `story-template-us.md` (livré) est un gabarit vide : il montre la structure, pas un exemple de contenu.
- Ce que tu imites : ordre et intitulés des sections, vocabulaire métier, format des critères, niveau de détail, types et libellés réellement utilisés. Jamais le contenu.
- Aucun exemple disponible : applique `references/gabarit.md` et signale que la personne peut en déposer dans `~/.pm-tickets/examples/`.

## Documentation produit

Réglage `docs` de `config.json`. Regarde d'abord `cache/docs.md` (`references/memoire.md`).

- **Fichier local** : lis-le.
- **Dossier local** : liste les `.md`, `.mdx` et `.txt` ; lis en priorité ceux dont le nom touche le sujet, dans la limite de 12 000 caractères.
- **URL** : outil web du harness ; à défaut, le shell (`curl -sL <url>` ou `Invoke-WebRequest <url>`), en ne gardant que le texte.
- **Page vide, page de connexion, 401 ou 404** : la doc est privée ou générée par JavaScript (fréquent avec Notion, Confluence, Google Docs). Dis-le en une phrase, propose un lien public ou un export Markdown, et continue sans.
- Garde ce qui sert au ticket : vocabulaire, écrans, règles métier. Écris le texte retenu dans `cache/docs.md`.

## Dépôt GitHub

Réglage `repo` de `config.json`. Regarde d'abord `cache/repo.md`.

- **Avec `gh` connecté** : `gh repo view org/depot` (description, README) et `gh api repos/org/depot/contents` (racine).
- **Sinon** : `https://api.github.com/repos/org/depot`, `…/readme` et `…/contents/`, avec l'outil web ou le shell.
- **404** : dépôt introuvable, ou privé sans accès. **403** : quota GitHub atteint (60 requêtes par heure sans jeton). Dis-le en une phrase et continue sans.
- Retiens la description, le langage, la racine et le README (12 000 caractères au plus) dans `cache/repo.md`. Tu peux lire un ou deux fichiers de plus si le ticket doit nommer un module précis.
- Usage : citer le module concerné dans les Notes. Jamais de solution technique imposée.

## Maquette Figma

Seulement si la demande contient un lien Figma.

- **Outil Figma disponible** : lis l'écran visé (structure, textes, états) pour nommer les écrans, les champs et les messages comme la maquette. Mets le lien dans les Notes.
- **Pas d'outil Figma** : mets le lien dans les Notes et signale que la maquette n'a pas été lue.
- Une règle métier absente de la maquette reste une question : la maquette montre un écran, elle ne prouve pas une règle.
