# Framework d'audit d'accessibilité neurocognitive

Ce document explique l'implémentation du framework d'audit d'accessibilité spécialisé pour les utilisateurs neurodivergents (TSA et TDAH), basé sur le prompt `.github/prompts/code-a11y-review.prompt.md`.

## Fichiers générés

### 1. `accessibility-audit.json`
Audit structuré au format JSON contenant :
- **Metadata** : Informations sur l'audit (date, méthodologie, scope)
- **Findings** : 7 problèmes identifiés avec structure complète
- **Métriques** : Scores actuels et cibles
- **Roadmap** : Plan d'implémentation en 4 sprints

### 2. `accessibility-audit-report.md`
Rapport détaillé en français incluant :
- Résumé exécutif orienté neurodiversité
- Tableau synthétique des findings
- Analyse par domaine d'audit (20 domaines du prompt)
- Roadmap d'implémentation par sprints
- Métriques de validation
- Scripts d'automatisation
- Annexes (glossaire, référentiels, outils)

### 3. `scripts/accessibility-audit.sh`
Script automatisé d'audit en temps réel qui vérifie :
- Hiérarchie des titres (H1 unique, niveaux cohérents)
- Mélange linguistique français/anglais
- Longueur des paragraphes (limite neurocognitive 3-4 phrases)
- Présence de navigation interne
- Mécanismes de feedback dans workflows

## Méthodologie d'audit

### Bases neurocognitives intégrées

#### TSA (Troubles du Spectre Autistique)
- **Intégration multi-sensorielle** : Difficulté traitement stimuli multiples
- **Sensibilité accrue** : Surcharge visuelle/auditive/motion  
- **Prévisibilité vs changements** : Besoin routines, difficultés changements implicites
- **Traitement en détail** : Importance repères hiérarchiques clairs
- **Charge d'exécution** : Fatigue cognitive transitions contextuelles

#### TDAH (Trouble Déficit de l'Attention/Hyperactivité)
- **Vulnérabilité distraction** : Difficultés filtrage stimuli externes/internes
- **Maintien de but** : Perte focus sous charge visuelle/interactionnelle
- **Feedback immédiat** : Besoin retour rapide pour maintien attention
- **Fragmentation attentionnelle** : Navigation/changements d'état silencieux problématiques
- **Mémoire de travail limitée** : Éléments persistants et agrégation nécessaires

### Référentiels appliqués

1. **WCAG 2.2** : Critères spécifiques (2.4.x, 1.3.x, 3.2.x, 2.2.x, 3.3.x, 2.5.x, 2.4.13)
2. **Design inclusif** : Microsoft Inclusive Design, Curb-cut principle
3. **Cognitive Load Theory** : Réduction charge extrinsèque, stabilisation ressources
4. **ARIA Authoring Practices** : Patterns menus, navigation, validation formulaires
5. **Interaction principles** : Prévisibilité, affordance, feedback, visibilité état

### Domaines d'audit (20 domaines)

1. **Structure & Landmarks** : Sémantique HTML, divisions logiques
2. **Navigation & Orientation** : Focus order, skip links, fil d'Ariane
3. **Hiérarchie & Titres** : H1 unique, niveaux cohérents, densité
4. **Chargements & États** : aria-busy, skeleton, prévisibilité
5. **Formulaires & Validation** : Groupements, inline + résumé, erreurs persistantes
6. **Composants dynamiques** : Modals, menus, toasts, live regions
7. **Interaction Clavier & Focus** : Tab order, focus visible, retour focus
8. **Feedback & Notifications** : Temps de vie, priorité, désactivables, aria-live
9. **Personnalisation Cognitive** : Mode faible stimulation, mode focus
10. **Densité visuelle & Lisibilité** : Espacements, line-height, contrastes
11. **Gestion Changement de Contexte** : Redirection auto, navigation implicite
12. **Micro-interactions & Mouvement** : Scroll auto, transitions, auto-refresh
13. **Charge Mémoire & Persistance** : Historique actions, rappel contexte
14. **Cohérence Multi-plateforme** : Web, client, mobile
15. **Accessibilité Données & Tableaux** : Groupements, summary, colonnes fixes
16. **Chat / Agents / Assistants** : Modalités intrusives vs pull, gestion focus
17. **Architecture & State Management** : Événements silencieux, polling, batching
18. **Performance perçue & Latence** : Précharge, skeleton, éviter rupture attention
19. **Internationalisation & Clarté** : Terminologie stable, éviter jargon
20. **Sécurité cognitive** : Prévenir perte données, confirmations non intrusives

## Structure des findings

Chaque finding suit la structure exacte demandée dans le prompt :

```json
{
  "id": "A11Y-XXX",
  "categorie": "Domaine d'audit",
  "probleme_detecte": "Description factuelle observable",
  "impact_tsa": "Mécanisme cognitif/sensoriel affecté",
  "impact_tdah": "Impact attention/mémoire/inhibition",
  "normes_liees": "WCAG x.x.x + principe design",
  "gravite": "Haute/Moyenne/Basse + justification",
  "exemple_concret": "Fichier, ligne, pattern",
  "risque_cumulatif": "Faible/Modéré/Élevé",
  "suggestion_remediation": "Action technique précise",
  "alternative_progressive": "Quick win",
  "remediation_complete": "Refonte complète",
  "indicateur_validation": "Metric mesurable",
  "effort_estime": "S/M/L",
  "priorite": "P1/P2/P3",
  "statut": "Backlog/En cours/Implémenté",
  "tags": ["structure", "focus", "feedback", etc.]
}
```

## Métriques de validation

### Initiales (état actuel)
- Conformité WCAG 2.2: 40%
- Score charge cognitive: 6/10
- Barrières spécifiques TSA: 5
- Barrières spécifiques TDAH: 4
- Efficacité navigation: 3/10

### Cibles (objectifs)
- Conformité WCAG 2.2: 95%
- Score charge cognitive: 9/10
- Barrières spécifiques TSA: 0
- Barrières spécifiques TDAH: 0
- Efficacité navigation: 9/10

## Utilisation des scripts

### Audit automatisé
```bash
# Exécuter audit complet
./scripts/accessibility-audit.sh

# Surveiller améliorations
git hook post-commit: ./scripts/accessibility-audit.sh
```

### Validation continue
```bash
# Intégration CI/CD
- name: Audit accessibilité
  run: ./scripts/accessibility-audit.sh
```

## Implémentation recommandée

### Phase 1 : Fondations (Semaine 1)
- Restructuration README.md avec hiérarchie claire
- Ajout table des matières et navigation

### Phase 2 : Cohérence (Semaine 2)  
- Uniformisation linguistique française
- Documentation architecture

### Phase 3 : Enrichissement (Semaines 3-4)
- Ajout exemples concrets HTML/CSS
- Amélioration feedback workflows

### Phase 4 : Optimisation (Semaine 5)
- Finalisation lisibilité
- Validation métriques

## Extensibilité

Ce framework peut être étendu pour :
- Applications web Blazor/SPA
- Interfaces conversationnelles
- Applications mobiles
- APIs et services

La structure JSON permet intégration avec outils CI/CD, dashboards et systèmes de suivi qualité.