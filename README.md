# pm-tickets : le skill

Version 0.1.1 · 17/11/2026 · adapté de l'agent Agent-ticket v1.2.0 (DeepSeek Harness)

Transforme un besoin en ticket Jira synthétique (user story, critères d'acceptation, logigramme), validé par la personne puis créé avec le MCP Jira de son poste. Même workflow que l'agent d'origine, sous forme de skill lisible par Claude Code, Codex, OpenCode et DeepSeek Harness.

## Contenu

```
skillification/
├── .claude-plugin/plugin.json      # manifeste lu par le catalogue Claude Code de LiteLLM
├── skills/pm-tickets/
│   ├── SKILL.md                    # les étapes, identiques pour tout le monde
│   ├── references/                 # mise en route, mémoire, contexte, gabarit, logigramme, outils Jira, exemples
│   └── meta/design-notes.md        # choix de conception et écarts (hors exécution)
└── install/
    ├── install.sh                  # macOS, Linux
    └── install.ps1                 # Windows
```

La mémoire de chaque personne vit dans `~/.pm-tickets/`, hors du skill : une mise à jour du skill ne la touche jamais.

## 1. Publier sur LiteLLM

1. Mettre ce dossier dans un dépôt Git lisible par les personnes visées, ou le zipper sur un serveur HTTPS.
2. LiteLLM › **Skills** › **Add Skill** :
   - **Source URL** : l'URL du dépôt (ou du zip) ;
   - **Subfolder path** : le chemin du dossier qui contient `.claude-plugin/` (vide si ce dossier est la racine du dépôt) ;
   - **Skill Name** : `pm-tickets`.
3. Vérifier que le plugin apparaît dans `https://<litellm>/claude-code/marketplace.json`.

Sur l'instance actuelle (v1.106.6), LiteLLM ne distribue qu'à Claude Code. Les autres harness passent par le script d'installation, jusqu'à une version de LiteLLM qui contient le « Skills Hub ».

## 2. Installer sur un poste

**Claude Code**, depuis LiteLLM :

```bash
claude plugin marketplace add https://<adresse-de-votre-litellm>/claude-code/marketplace.json
```

```bash
claude plugin install pm-tickets@litellm
```

**Codex, OpenCode, DeepSeek Harness** (et Claude Code sans le catalogue), depuis une copie du dossier :

```bash
bash install/install.sh
```

```powershell
powershell -ExecutionPolicy Bypass -File install\install.ps1
```

Le script copie le skill dans `~/.agents/skills/` (Codex, OpenCode), `~/.claude/skills/` (Claude Code, OpenCode) et `~/.dsh/skills/` si DeepSeek Harness est présent. Il crée `~/.pm-tickets/` et reprend les réglages et exemples de l'ancien agent (`~/.dsh/pm-tickets/`) s'ils existent.

## 3. Prérequis sur chaque poste

1. **Un MCP Jira connecté** dans le harness : celui de l'outil d'origine (`jira-mcp.mjs`) ou le MCP Atlassian officiel.
2. **Les outils de modification du MCP Jira bloqués.** Un skill ne peut pas empêcher un appel d'outil ; seul le harness le peut. Le MCP de l'outil d'origine n'en a aucun. Pour le MCP Atlassian, bloquer au minimum `editJiraIssue`, `transitionJiraIssue`, `addWorklogToJiraIssue` et `createIssueLink` :

   | Harness | Où bloquer |
   |---|---|
   | Claude Code | `permissions.deny` dans `~/.claude/settings.json`, par exemple `"mcp__atlassian__editJiraIssue"` (le préfixe suit le nom donné au serveur) |
   | Codex | `disabled_tools` sous `[mcp_servers.<nom>]` dans `~/.codex/config.toml` (à vérifier) |
   | OpenCode | permission `deny` sur `<serveur>_<outil>` dans `opencode.json` (syntaxe selon la version) |
   | DeepSeek Harness | à vérifier dans la doc du harness |

3. **L'écriture autorisée dans `~/.pm-tickets/`** : Claude Code demande une autorisation la première fois ; Codex et DeepSeek Harness limitent l'écriture à l'espace de travail par défaut et peuvent demander de déclarer ce dossier.
4. **Un modèle via LiteLLM** : une clé virtuelle par personne ou par équipe, configurée dans le harness.

## Ce qui a été vérifié, ce qui ne l'a pas été

- Vérifié : format du skill et du manifeste (outils de contrôle), script `install.sh` sur un dossier personnel de test, installation dans Claude Code depuis le catalogue LiteLLM.
- Non vérifié : `install.ps1` (pas de PowerShell sur la machine de test) ; découverte du skill dans Codex, OpenCode et DeepSeek Harness ; rendu du Markdown par le MCP Atlassian ; comportement du skill sur des cas réels (aucune évaluation menée).

**Source HTTPS obligatoire dans LiteLLM.** Déclaré comme dépôt GitHub (`"source": "github"`), le plugin est cloné en SSH, port 22, souvent bloqué sur les réseaux d'entreprise. Il est donc déclaré en URL Git HTTPS : `{"source": "url", "url": "https://github.com/sboukhari-Ippon/pm-tickets-skill.git"}` (API `PUT /claude-code/plugins/pm-tickets`, le formulaire ne propose pas ce choix).
