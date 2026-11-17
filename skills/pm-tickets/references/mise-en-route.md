# Mise en route : les quatre réglages

À faire quand `~/.pm-tickets/config.json` n'a pas de réponse pour chacun des quatre réglages. Une réponse est une valeur ou un refus (« je n'en ai pas », « je ne sais pas encore »).

## Déroulé

- Une question à la fois, dans l'ordre ci-dessous, en sautant les réglages qui ont déjà une réponse.
- Reprends la question et son détail, en adaptant les mots au contexte. Présente-la comme une étape normale, parce que la personne ne sait pas que ces réglages existent : jamais « voulez-vous configurer l'agent ? », jamais comme une option.
- Après chaque réponse, écris-la aussitôt dans `config.json` (format : `references/memoire.md`), puis passe à la question suivante. Enregistrer une réponse ne termine pas la mise en route : continue tant qu'un réglage n'a pas de réponse.
- Aucune de ces questions ne porte sur les identifiants Jira : la connexion relève du MCP du poste.
- Pendant les questions, enregistre les réponses sans lire les sources. Leur lecture a lieu à la fin de la mise en route, avec le chargement du contexte, qui signale une seule fois par conversation une source illisible (lien privé, 404, quota) et propose une alternative.
- **Fin** : quand les quatre réglages ont une réponse, charge le contexte (`references/contexte-produit.md`), résume en trois lignes au plus ce que tu as compris du produit et du code, puis reprends la demande initiale. Ne bloque jamais la rédaction parce qu'une source est indisponible.

## 1. Projet Jira

> **Dans quel projet Jira dois-je créer vos tickets ?**
> La clé du projet (ex. BOUTIQUE), son nom ou l'URL d'un ticket ou du projet suffit. Si vous ne la connaissez pas, je peux lister vos projets accessibles. Répondez « je ne sais pas encore » si vous préférez choisir au moment de créer le premier ticket.

- **URL** : extrais la clé (`/browse/CLÉ-123`, `/projects/CLÉ`).
- **Nom seul ou clé inconnue** : liste les projets accessibles et propose-les comme options.
- **Vérification** : lis le projet dans Jira avant d'écrire. S'il existe, enregistre la clé et le nom exacts renvoyés par Jira. Si la vérification échoue, enregistre quand même et signale « projet enregistré mais non vérifié » avec la cause.
- Une clé valide est en majuscules, commence par une lettre et ne contient que des lettres et des chiffres.
- **« Je ne sais pas encore »** : enregistre `jira.skipped: true`. Le projet sera demandé à l'étape 6.

## 2. Tickets types

> **Où sont vos tickets types ?**
> Vous pouvez me donner le dossier ou les fichiers Markdown qui contiennent vos tickets habituels, ou répondre « je n'en ai pas ». Ces exemples m'apprennent votre nomenclature : ordre des sections, vocabulaire, format des critères.

- **Dossier** : enregistre son chemin dans `examplesDir`.
- **Fichiers isolés ou ticket collé** : copie-les dans `~/.pm-tickets/examples/`, nommés `story-<sujet>.md`, `bug-<sujet>.md` ou `task-<sujet>.md`.
- **« Je n'en ai pas »** : enregistre `examplesSkipped: true` et signale qu'elle pourra en déposer plus tard dans `~/.pm-tickets/examples/`.

## 3. Documentation produit

> **Avez-vous de la documentation produit ?**
> Un lien suffit : Notion, Confluence, un site, un Google Doc partagé, ou le chemin d'un fichier ou dossier Markdown sur votre ordinateur. Cela m'évite d'inventer le vocabulaire et les règles métier. Répondez « pas de documentation » si vous n'en avez pas.

- **Lien** : `docs.url`, en http(s) uniquement.
- **Chemin local** : `docs.path`.
- **PDF, Word, tableur** : illisibles tels quels ; demande un lien ou un export Markdown ou texte.
- **« Pas de documentation »** : `docs.skipped: true`.

## 4. Dépôt de code

> **Où vit le code, sur GitHub ?**
> Collez l'URL du dépôt, ou sa forme courte organisation/dépôt. Cela me permet de situer chaque ticket dans le bon module. Répondez « pas de dépôt » si le code n'est pas sur GitHub.

- **URL ou `org/depot`** : `repo.url`, sous la forme `https://github.com/org/depot`. Une branche ou un tag précisé va dans `repo.ref`.
- **Dépôt privé** : il se lit seulement si le poste a un accès GitHub (`gh` connecté ou variable `GITHUB_TOKEN`). Sinon, enregistre l'URL et signale la limite.
- **« Pas de dépôt »** : `repo.skipped: true`.
