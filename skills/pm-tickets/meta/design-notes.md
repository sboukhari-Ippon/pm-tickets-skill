# Notes de conception : pm-tickets

Hors exécution : à lire en audit ou en maintenance.

## Origine

Portage en skill de l'agent PM Tickets d'origine (dépôt Agent-ticket v1.2.0, preset DeepSeek Harness) : `cordis.patch.yml` (prompt de 21 550 caractères) et `mcp/jira-mcp.mjs` (10 outils). Le comportement du prompt est repris ; la plomberie propre à DeepSeek Harness (preset, `index.js`, outils fichiers et shell déclarés par le preset) est retirée.

## Type

Technique (procédure en 10 étapes), avec deux règles de discipline : création seule (règle 1) et aucune création sans « oui » (règle 2). Registre ferme et argumenté pour ces deux règles, positif ailleurs.

## Répartition

- Les 10 outils d'origine : 7 actions Jira déléguées au MCP Jira du poste (`references/outils-jira.md`), 3 outils de configuration et de contexte remplacés par des lectures et écritures dans `~/.pm-tickets/` (`references/memoire.md`, `references/contexte-produit.md`).
- Le format de `config.json` reprend celui de l'ancien agent, pour une reprise par simple copie.

## Écarts assumés par rapport à l'outil d'origine

- **Commentaire** : autorisé sur toute clé de `created.json`, et plus seulement sur le ticket créé dans la conversation en cours. Raison : la liste persiste après une compaction ; le garde-fou « jamais le ticket de quelqu'un d'autre » est conservé.
- **Cache** : réutilisé le jour même, au lieu de 10 minutes en mémoire du processus, parce que le cache est désormais un fichier.
- **Budgets** : exemples 12 000 caractères (40 000 avant), doc 12 000, dépôt 12 000 ; plafonds fixes au lieu d'un paramètre laissé au modèle (audit de contexte du 17/11/2026).
- **Dépôt** : le skill peut lire un ou deux fichiers en plus du README.
- **Figma** : étape ajoutée (lecture d'une maquette liée), absente de l'outil d'origine.
- **Création seule** : dans l'outil d'origine, garantie par le code (aucun outil de modification exposé). Ici, garantie par la règle 1 du skill, et par le blocage des outils dans la config du harness quand il est appliqué (README). Un skill ne peut pas l'empêcher seul.
- **Description** : exclut les demandes de modification d'un ticket existant. Le skill ne joue donc pas le rôle de l'agent qui refusait toute modification ; ce refus reste porté par la règle 1 pendant le workflow et par le blocage d'outils.

## Évaluation

Non menée à la version 0.1.0 : ni test de déclenchement, ni comparaison avec et sans le skill, ni essai dans les quatre harness. À faire avant une diffusion large (5 à 8 cas : story, bug, demande multi-besoins, doublon, demande de modification refusée, Jira indisponible, première mise en route, reprise d'une config DeepSeek Harness).
