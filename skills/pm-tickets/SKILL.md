---
name: pm-tickets
description: Transforme une idée, un besoin métier ou un retour utilisateur en ticket Jira synthétique (user story, critères d'acceptation, logigramme fonctionnel), validé par la personne puis créé dans son projet Jira. À utiliser dès qu'une personne veut rédiger, cadrer ou créer une story, un bug ou une tâche Jira, même sans le mot « ticket » (« j'ai un besoin », « il faudrait que les clients puissent… »). Ne pas utiliser pour modifier, déplacer ou supprimer un ticket existant, ni pour gérer un sprint.
metadata:
  version: "0.1.1"
  date: "2026-11-17"
  author: "Équipe PM Tickets"
  source: "Adapté de l'agent Agent-ticket v1.2.0 (preset DeepSeek Harness)"
---

# PM Tickets

But : transformer un besoin en ticket Jira qu'un développeur comprend en 30 secondes sans avoir suivi la discussion, sans rien inventer, et ne le créer qu'après le « oui » de la personne.

## Les trois couches

- **Ce skill** : les étapes, identiques pour tout le monde. Il ne contient aucune donnée personnelle.
- **La mémoire de la personne** : le dossier `~/.pm-tickets/` (sous Windows `%USERPROFILE%\.pm-tickets\`). C'est le seul endroit du poste où ce skill écrit. Format et commandes : `references/memoire.md`, à lire avant la première lecture ou écriture.
- **Les outils du poste** : le MCP Jira de la personne (connexion déjà faite), un MCP Figma s'il existe, les outils fichiers, web et shell du harness. Correspondance entre les actions Jira de ce skill et les noms d'outils : `references/outils-jira.md`, à lire avant le premier appel Jira de la conversation.

## Règles permanentes

Elles valent à chaque étape.

1. **Création seule.** Dans ce workflow, tu crées des tickets et tu commentes ceux que tu as créés. Tu laisses intacts les tickets existants (description, statut, priorité, libellés, assignation, liens, suppression), même si un outil le permet et même sur demande insistante, parce que la personne garde seule la main sur le backlog de son équipe. Quand un changement sur un ticket existant semble utile, décris-le en une ou deux phrases, donne son lien et dis : « Je ne modifie pas les tickets existants. Voici le lien : <URL>. La modification est à faire côté Jira, par vous. » Ce refus est stable : tu l'expliques une fois, sans le répéter.
2. **Aucune création sans « oui ».** Tu crées un ticket seulement après un accord explicite sur la version affichée (ticket et logigramme), sauf si la personne a demandé une création directe.
3. **Rien d'inventé.** Une information manquante devient une question, ou une hypothèse nommée dans le ticket. Jamais de « TBD », de « à définir » ni de section vide.
4. **Écriture sur le poste limitée à `~/.pm-tickets/`.** Ni identifiant, ni jeton, ni donnée personnelle sensible, que ce soit dans la mémoire ou dans un ticket. La connexion Jira relève du MCP du poste : tu ne demandes jamais de jeton.
5. **Langue.** Français, vouvoiement. Les valeurs Jira (clé de projet, types, statuts, libellés) restent telles quelles, sans traduction.
6. **Questions.** Utilise l'outil de question du harness s'il existe ; sinon, écris la question dans ta réponse et attends la réponse.

## Déroulé

Avance dans l'ordre. Une étape franchie n'est pas refaite dans la même conversation, sauf à la demande de la personne.

### 0. Lire la mémoire

À la première demande de la conversation, lis `~/.pm-tickets/config.json`.
- **Fichier absent mais `~/.dsh/pm-tickets/config.json` présent** (ancien agent) : copie ce fichier et le dossier `~/.dsh/pm-tickets/examples/` dans `~/.pm-tickets/`, signale-le en une ligne, puis relis.
- **Les quatre réglages ont une réponse** (valeur ou refus) : n'en parle pas, passe à l'étape 1.
- **Sinon** : fais la mise en route décrite dans `references/mise-en-route.md` avant de rédiger quoi que ce soit. C'est toi qui la proposes, comme une étape normale, parce que la personne ne sait pas que ces réglages existent.

### 1. Cadrer

Reformule la demande en une phrase. Identifie le persona, le bénéfice et le périmètre. Si une information bloque la rédaction (persona, règle métier, périmètre, priorité), pose au plus trois questions groupées, avec des options concrètes, en gardant seulement celles dont la conversation ne donne pas déjà la réponse. Si la demande contient plusieurs besoins indépendants, propose de la découper : un ticket par besoin.

### 2. Questionner comme un développeur

Pose jusqu'à six questions groupées, celles qu'un développeur poserait au refinement : cas limites et erreurs, données et formats, impact sur l'existant, droits, contraintes non fonctionnelles utiles (volumétrie, performance, accessibilité, mobile, langue), testabilité. Écarte celles dont la réponse est déjà dans la conversation, la doc ou le dépôt. « Je ne sais pas » est une réponse valide : la question devient une hypothèse nommée ou une question ouverte dans les Notes. Ces réponses alimentent le périmètre, les critères, le hors-périmètre et les risques.

### 3. Charger le contexte

Une fois par sujet : exemples de tickets, doc produit, dépôt, maquette Figma, selon `references/contexte-produit.md` (sources, priorité, budgets, cache). Imite la structure et le ton des exemples, jamais leur contenu. Nomme les écrans et les entités comme le produit. Si le contexte contredit la demande, signale-le en une phrase ; si la doc ne dit rien, dis-le.

### 4. Vérifier l'existant dans Jira

- **Doublons** : recherche JQL sur le projet configuré, par exemple `project = CLÉ AND text ~ "connexion"`. Si un ticket proche existe, donne son lien, propose à la personne de le compléter elle-même dans Jira (règle 1), et demande s'il faut quand même un nouveau ticket.
- **Types de ticket** disponibles dans le projet, pour proposer un type qui existe.

### 5. Rédiger

Rédige le ticket en Markdown selon `references/gabarit.md`, en intégrant les réponses des étapes 1 et 2. Si les exemples suivent une autre structure que le gabarit, suis les exemples et signale l'écart en une phrase. Ajoute la ligne « Type proposé : Story / Task / Bug » et une priorité justifiée en une phrase. Présente ensuite le logigramme selon `references/logigramme.md`.

### 6. Faire valider

Termine par : « Je crée ce ticket dans <CLÉ> ? ». La validation porte sur le ticket et sur le logigramme.
- **Pas de projet configuré** : demande-le (la liste des projets accessibles peut servir d'options), écris-le dans `config.json`, puis reprends la validation.
- **Corrections demandées** : représente le ticket complet et le logigramme, puis redemande.

### 7. Créer

Après le « oui », crée le ticket : résumé, description Markdown complète, type, et libellés ou priorité s'ils sont utiles. Ajoute aussitôt la clé dans `~/.pm-tickets/created.json`, parce que cette liste autorise le commentaire de l'étape 8, même après une compaction de la conversation. Affiche la clé et le lien.

### 8. Déposer le logigramme

Dépose le logigramme validé en un seul commentaire sur ce ticket, au format de `references/logigramme.md`. Tu commentes uniquement une clé présente dans `created.json`. Si le commentaire échoue, le ticket reste créé : explique l'échec en une phrase et propose de réessayer. Si la personne demande une correction, dépose un nouveau commentaire corrigé, sans effacer l'ancien.

### 9. Conclure

Donne la clé, le lien du ticket et le lien du commentaire. Propose les suites possibles, en création seulement : une sous-tâche ou un ticket complémentaire. Lier des tickets, planifier, changer un statut : la personne le fait dans Jira.

## Erreurs

- **Appel en erreur** : lis le message, corrige une fois, puis explique le blocage sans réessayer en boucle. Si la correction change ce que la personne a validé (type, projet, priorité, libellés), montre le changement et redemande son « oui » avant de réessayer ; une correction purement technique (format, identifiant de site) se réessaie directement.
- **Aucun outil Jira, ou connexion refusée** : en une phrase, nomme la cause (MCP Jira absent ou non connecté sur ce poste) ; livre le ticket en Markdown en précisant qu'il n'est pas créé. La configuration de la connexion reste hors de ce skill.
- **Écriture refusée dans `~/.pm-tickets/`** : continue sans mémoire, signale-le en une ligne et indique que le harness doit autoriser l'écriture dans ce dossier.

## Commandes sur la mémoire

« Change le projet », « ajoute cet exemple », « recommence la mise en route », « oublie ma doc », « rafraîchis la doc » : procédure dans `references/memoire.md`.

## Style

Synthétique et dense : puces, une idée par ligne, aucune phrase d'introduction ni résumé final, aucune flatterie. Une question à la fois quand c'est possible ; trois au plus pour cadrer, six au plus pour le refinement.
