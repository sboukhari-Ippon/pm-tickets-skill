# Gabarit du ticket

Un ticket = un besoin livrable, compréhensible par un développeur qui n'a pas participé à la discussion, et vérifiable sans interprétation. Il décrit le problème et le résultat attendu, pas la solution technique. Une contrainte technique n'apparaît que si elle est réellement imposée (ex. « doit rester compatible avec l'API v3 »).

## Sections, dans cet ordre

1. **Résumé** : une phrase, 100 caractères au plus, à l'infinitif ou nominale, sans préfixe de type.
2. **Contexte** : 2 à 4 puces : qui est concerné, situation actuelle, impact. Pas de paragraphe.
3. **User story** : une phrase : « En tant que <persona>, je veux <capacité>, afin de <bénéfice>. »
4. **Périmètre** : 3 à 6 puces, verbes d'action, sans redire le contexte.
5. **Critères d'acceptation** : 3 à 6 critères, Gherkin français, une ligne par critère : `Étant donné … , quand … , alors …`. Cas nominal d'abord, puis cas limite ou erreur. Chacun observable et testable : jamais « fonctionne bien », « rapide » ou « etc. ».
6. **Hors périmètre** : puces. Section omise si elle est vide.
7. **Risques et dépendances** : puces : tickets liés, équipes, contraintes. Section omise si elle est vide.
8. **Notes** : puces : liens, maquettes, module concerné, hypothèses, questions ouvertes. Section omise si elle est vide.

Les sections 6 à 8 sont les seules facultatives : une section vide est une faute, son absence n'en est pas une. Pas de « Definition of Done » séparée : ce qui reste utile va dans une puce de Notes.

Après le ticket, hors description :
- `Type proposé : Story` (ou Task, ou Bug, selon les types du projet) ;
- `Priorité proposée : <valeur Jira>`, justifiée en une phrase.

## Concision

- Aucune phrase d'introduction, aucune reformulation de la demande, aucun résumé final, aucune redite entre sections.
- Une idée = une puce = une ligne ; jamais plus de deux lignes par puce.
- Budget : description de 1 500 caractères au plus, hors logigramme. Si ça dépasse, coupe dans le hors-périmètre et les notes, jamais dans les critères.
- Pas d'adjectif creux (« robuste », « optimal »), pas de « etc. », pas de « TBD ».
- Jamais de secret, de jeton ni de donnée personnelle sensible.

Le logigramme n'est pas une section de la description : il est présenté après le ticket et déposé en commentaire (`references/logigramme.md`).
