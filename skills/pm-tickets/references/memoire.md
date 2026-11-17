# Mémoire de la personne : `~/.pm-tickets/`

Le dossier appartient à la personne. Une mise à jour du skill ne le touche jamais, et le skill n'écrit nulle part ailleurs sur le poste.

| Système | Chemin |
|---|---|
| macOS, Linux | `~/.pm-tickets/` |
| Windows | `%USERPROFILE%\.pm-tickets\` |

```
~/.pm-tickets/
├── config.json     # les quatre réglages et les préférences
├── created.json    # tickets créés par ce skill
├── examples/       # tickets types de la personne
└── cache/          # doc produit et README du dépôt, déjà téléchargés
```

Crée le dossier et ses sous-dossiers s'ils manquent.

## Écrire sans abîmer

- Lis le fichier, change seulement le champ concerné, réécris un JSON valide complet, puis mets `updatedAt` à la date et l'heure courantes (ISO 8601). Une réécriture de mémoire faite de tête efface des champs.
- Un champ sans valeur est retiré, jamais laissé vide.
- Jamais d'identifiant, de jeton ni de mot de passe dans ce dossier.

## `config.json`

Même format et mêmes noms de champs que l'ancien agent DeepSeek Harness (`~/.dsh/pm-tickets/config.json`), ce qui permet de le reprendre par simple copie. Une clé de projet reprise de l'ancien fichier compte comme vérifiée.

```json
{
  "jira": { "key": "BOUTIQUE", "name": "Boutique en ligne", "baseUrl": "https://exemple.atlassian.net", "cloudId": "…" },
  "examplesDir": "/Users/prenom/Documents/tickets-types",
  "docs": { "url": "https://exemple.notion.site/produit" },
  "repo": { "url": "https://github.com/org/boutique", "ref": "main" },
  "productName": "Boutique",
  "notes": "Vocabulaire : on dit « commande », jamais « achat ».",
  "updatedAt": "2026-11-17T10:42:00Z"
}
```

| Réglage | Réponse : valeur | Réponse : refus |
|---|---|---|
| Projet Jira | `jira.key` (+ `jira.name`) | `jira.skipped: true` |
| Tickets types | `examplesDir`, ou fichiers dans `examples/` | `examplesSkipped: true` |
| Documentation | `docs.url` ou `docs.path` | `docs.skipped: true` |
| Dépôt | `repo.url` (+ `repo.ref`) | `repo.skipped: true` |

- `jira.baseUrl` : adresse du site Jira, pour écrire le lien d'un ticket (`<baseUrl>/browse/<CLÉ>`). Relève-la dans la première réponse Jira qui contient une URL.
- `jira.cloudId` : seulement pour un MCP Jira qui l'exige (`references/outils-jira.md`).
- `productName`, `notes` : facultatifs ; `notes` garde le vocabulaire, les contraintes ou les préférences que la personne demande de retenir.
- Une valeur enregistrée retire le refus correspondant, et inversement.

## `created.json`

Liste des tickets créés par ce skill. Ajoute une entrée juste après chaque création :

```json
[
  { "key": "BOUTIQUE-124", "url": "https://exemple.atlassian.net/browse/BOUTIQUE-124", "summary": "Suivre l'avancement de sa commande", "createdAt": "2026-11-17T10:55:00Z" }
]
```

Le commentaire du logigramme n'est autorisé que sur une clé de cette liste.

## `examples/`

Un fichier `.md` par ticket : `story-<sujet>.md`, `bug-<sujet>.md`, `task-<sujet>.md`. Ordre de lecture et budget : `references/contexte-produit.md`.

## `cache/`

- `cache/docs.md` et `cache/repo.md`. Première ligne : `<!-- source : <URL ou chemin> · récupéré le AAAA-MM-JJ -->`.
- Réutilise le cache s'il date du jour et que sa source correspond au réglage actuel ; sinon, télécharge à nouveau et remplace.

## Commandes de la personne

| Demande | Action |
|---|---|
| « Change le projet » | Même traitement que la question 1 de `references/mise-en-route.md`, puis mise à jour de `jira` |
| « Ajoute cet exemple » | Copie le fichier ou le ticket collé dans `examples/` sous le nom `<type>-<sujet>.md`, puis liste le contenu du dossier |
| « Recommence la mise en route » | Renomme `config.json` en `config.backup-AAAAMMJJ-HHMMSS.json`, dis où il est, puis lance la mise en route |
| « Oublie ma doc » / « oublie mon dépôt » | Retire `docs` ou `repo` de `config.json` et supprime le fichier de cache correspondant |
| « Rafraîchis la doc » | Télécharge à nouveau la doc et le README, et remplace le cache |
| « Retiens que… » | Ajoute la phrase à `notes` |

## Si l'écriture est refusée

Certains harness limitent l'écriture à l'espace de travail ou demandent une autorisation pour écrire hors de lui. Si l'écriture dans `~/.pm-tickets/` est refusée, continue sans mémoire, signale-le en une ligne et dis à la personne d'autoriser ce dossier dans les réglages de son harness (procédure dans le README du skill).
