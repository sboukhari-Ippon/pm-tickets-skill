# Actions Jira et noms d'outils

Ce skill nomme les actions, pas les outils, parce que chaque MCP Jira les nomme à sa façon. Trouve l'outil qui fait l'action dans la liste de ton harness ; son nom peut y porter un préfixe (`mcp__jira__`, `jira_`, `atlassian_`…).

## Avant le premier appel Jira de la conversation

1. Reconnais le MCP à ses noms d'outils (colonnes du tableau ci-dessous).
2. MCP Atlassian officiel : obtiens le `cloudId` s'il n'est pas déjà dans `config.json` (paragraphe suivant le tableau).
3. Relève l'adresse du site Jira (`jira.baseUrl`) si elle manque dans `config.json`.

Ces trois points précèdent toute lecture Jira, y compris la vérification du projet pendant la mise en route.

## Actions utilisées par le workflow

| Action | MCP de l'outil d'origine (`jira-mcp.mjs`) | MCP Atlassian officiel | Étape |
|---|---|---|---|
| Lister les projets accessibles | `jira_projects` | `getVisibleJiraProjects` | 0, 6 |
| Lire un projet (vérifier la clé) | `jira_projects` ou `jira_create_meta` | `getVisibleJiraProjects` | 0 |
| Rechercher en JQL (doublons) | `jira_search` | `searchJiraIssuesUsingJql` | 4 |
| Lire un ticket | `jira_get_issue` | `getJiraIssue` | 4 |
| Lister les types de ticket du projet | `jira_create_meta` | `getJiraProjectIssueTypesMetadata` | 4 |
| Créer un ticket | `jira_create_issue` | `createJiraIssue` | 7 |
| Commenter un ticket | `jira_add_comment` | `addCommentToJiraIssue` | 8 |

**MCP Atlassian officiel** : ses outils demandent un `cloudId`. Obtiens-le une fois avec l'outil des ressources accessibles (`getAccessibleAtlassianResources`), puis garde-le dans `config.json` (`jira.cloudId`). S'il propose un guide ou un paramètre de format de contenu, choisis le Markdown.

**Autre MCP Jira** : cherche l'outil qui fait l'action ; si aucun ne la fait, dis-le et livre le ticket en Markdown.

## Description et commentaire

- Envoie la description et le commentaire en Markdown. Le MCP de l'outil d'origine les convertit au format Atlassian ; un autre MCP peut demander un paramètre de format.
- Après la première création de la conversation, vérifie dans la réponse que la description n'est pas restée en Markdown brut ; si c'est le cas, signale-le et adapte le format pour la suite.

## Actions hors workflow

Tu n'appelles pas les outils qui modifient ou suppriment, même quand le MCP les propose (règle 1 du skill). Par exemple, dans le MCP Atlassian : `editJiraIssue`, `transitionJiraIssue`, `addWorklogToJiraIssue`, `createIssueLink`, ainsi que les outils qui créent ou modifient des pages Confluence ou des composants Compass. Le MCP de l'outil d'origine n'en expose aucun.
