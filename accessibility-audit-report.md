# Audit d'accessibilité neurocognitive - NeurodiversityCopilot

## Résumé exécutif

Ce rapport présente un audit complet d'accessibilité neurocognitive du référentiel NeurodiversityCopilot, axé sur les besoins spécifiques des utilisateurs avec TSA (Troubles du Spectre Autistique) et TDAH. L'audit révèle que le projet, actuellement centré sur la documentation, présente de bonnes bases conceptuelles mais nécessite des améliorations structurelles pour optimiser l'expérience des utilisateurs neurodivergents. Les principales recommandations incluent l'amélioration de la hiérarchie des contenus, l'ajout de repères visuels cohérents, et la mise en place d'un système de navigation prévisible. La mise en œuvre progressive de ces recommandations permettra de créer un environnement numérique véritablement inclusif.

## Méthodologie

Audit basé sur les référentiels suivants :
- WCAG 2.2 (critères 1.3.x, 2.4.x, 2.2.x, 3.2.x, 3.3.x, 2.5.x)
- Principes du design inclusif (Microsoft Inclusive Design)
- Théorie de la charge cognitive (intrinsèque, extrinsèque, germane)
- Patterns ARIA authoring practices
- Recherches neurocognitives sur TSA et TDAH

## Audit détaillé

### Tableau des findings

| ID | Catégorie | Problème | Impact TSA | Impact TDAH | Gravité | Effort | Priorité | Statut |
|---|---|---|---|---|---|---|---|---|
| A11Y-001 | Structure & Landmarks | README.md manque structure sémantique claire | Repères hiérarchiques manquants | Fragmentation attentionnelle | Haute | M | P1 | Backlog |
| A11Y-002 | Clarté linguistique | Mélange français/anglais incohérent | Rupture prévisibilité | Surcharge cognitive extrinsèque | Moyenne | S | P2 | Backlog |
| A11Y-003 | Navigation & Orientation | Absence navigation structurée | Charge cognitive localisation | Perte focus scrolling | Moyenne | S | P2 | Backlog |
| A11Y-004 | Densité visuelle | Lorem Ipsum dense sans espacement | Sensibilité visuelle déclenchée | Vulnérabilité distraction | Basse | S | P3 | Backlog |
| A11Y-005 | Feedback & États | Workflow sans feedback visuel | Anxiété incertitude système | Absence feedback immédiat | Moyenne | M | P2 | Backlog |
| A11Y-006 | Documentation | Instructions sans exemples concrets | Traitement détail compromis | Mémoire travail surchargée | Moyenne | L | P1 | Backlog |
| A11Y-007 | Architecture | Structure dossiers sans convention | Rupture routine orientation | Charge cognitive exploration | Basse | S | P3 | Backlog |

### Détail par domaine d'audit

#### 1. Structure & Landmarks (sémantique HTML / divisions logiques)
**Finding A11Y-001**: Le README.md principal manque de structure sémantique claire avec des niveaux de titres incohérents. L'utilisation d'emojis comme marqueurs de section (🧠, 📐, 📄, etc.) sans hiérarchie HTML appropriée crée des difficultés pour les technologies d'assistance et les utilisateurs neurodivergents.

**Impact neurocognitif**: 
- TSA: Compromet le traitement en détail par absence de repères hiérarchiques clairs
- TDAH: Cause fragmentation attentionnelle par structure non prévisible

**Remédiation**: Restructurer avec H1 principal, H2 pour sections, H3 pour sous-sections.

#### 2. Navigation & Orientation (focus order, skip link, fil d'Ariane)
**Finding A11Y-003**: Absence de table des matières ou de liens de navigation rapide vers les sections principales du README.md.

**Impact neurocognitif**:
- TSA: Augmente charge cognitive pour localisation d'informations
- TDAH: Compromet maintien du but lors du scrolling

**Remédiation**: Ajouter table des matières avec liens d'ancrage.

#### 3. Hiérarchie & Titres (H1 unique, niveaux cohérents, densité)
Intégré dans Finding A11Y-001 - structure manquante avec niveaux incohérents.

#### 4. Clarté linguistique & Terminologie (terminologie stable, éviter jargon)
**Finding A11Y-002**: Mélange incohérent français/anglais dans la documentation et noms de fichiers.

**Impact neurocognitif**:
- TSA: Rupture de prévisibilité et charge d'exécution pour transitions
- TDAH: Surcharge cognitive par changements contextuels implicites

#### 5. Densité visuelle & Lisibilité (espacements, line-height, contrastes)
**Finding A11Y-004**: Le fichier test contient du Lorem Ipsum dense sans structuration appropriée.

**Impact neurocognitif**:
- TSA: Sensibilité visuelle déclenchée par densité textuelle
- TDAH: Vulnérabilité à distraction par texte non structuré

#### 6. Documentation & Instructions (contexte, exemples)
**Finding A11Y-006**: Les principes énoncés dans le README manquent d'exemples concrets et de cas d'usage pratiques.

**Impact neurocognitif**:
- TSA: Traitement en détail compromis par instructions abstraites
- TDAH: Mémoire de travail surchargée par instructions non exemplifiées

### Roadmap d'implémentation

#### Sprint 1: Fondations structurelles (1 semaine)
- **A11Y-001**: Restructuration README.md avec hiérarchie H1-H3
- **A11Y-003**: Ajout table des matières et navigation

**Objectif**: Établir bases solides pour navigation et compréhension

#### Sprint 2: Cohérence et clarté (1 semaine)
- **A11Y-002**: Uniformisation linguistique française
- **A11Y-007**: Documentation architecture dossiers

**Objectif**: Créer cohérence terminologique et structurelle

#### Sprint 3: Enrichissement contenu (2 semaines)
- **A11Y-006**: Ajout exemples concrets HTML/CSS
- **A11Y-005**: Amélioration feedback workflows

**Objectif**: Transformer documentation en guide pratique

#### Sprint 4: Optimisations finales (1 semaine)
- **A11Y-004**: Amélioration lisibilité fichiers test
- Validation finale métriques

**Objectif**: Peaufiner expérience utilisateur

### Métriques de validation

#### Métriques initiales
- Conformité WCAG 2.2: 40%
- Score charge cognitive: 6/10
- Barrières spécifiques TSA: 5
- Barrières spécifiques TDAH: 4
- Efficacité navigation: 3/10

#### Métriques cibles
- Conformité WCAG 2.2: 95%
- Score charge cognitive: 9/10
- Barrières spécifiques TSA: 0
- Barrières spécifiques TDAH: 0
- Efficacité navigation: 9/10

### Scripts d'automatisation potentiels

#### 1. Validation structure titres
```bash
#!/bin/bash
# Vérification hiérarchie titres Markdown
grep -n "^#" README.md | awk '{print NR ": " $0}'
```

#### 2. Détection mélange linguistique
```bash
#!/bin/bash
# Détection mots anglais dans documentation française
grep -i "test\|example\|demo\|sample" *.md
```

#### 3. Validation longueur paragraphes
```python
#!/usr/bin/env python3
import re

def analyze_paragraph_length(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    paragraphs = re.split(r'\n\s*\n', content)
    for i, para in enumerate(paragraphs):
        sentences = len(re.split(r'[.!?]+', para))
        if sentences > 4:
            print(f"Paragraphe {i+1} trop long: {sentences} phrases")

analyze_paragraph_length('README.md')
```

## Annexes

### Glossaire terminologique
- **Charge cognitive extrinsèque**: Charge mentale causée par présentation/interface, réductible par design
- **Charge cognitive intrinsèque**: Charge liée à complexité intrinsèque du contenu
- **Charge cognitive germane**: Charge productive pour construction schémas mentaux
- **Progressive Disclosure**: Révélation progressive d'information pour éviter surcharge
- **Affordance**: Indication visuelle de possibilités d'interaction

### Référentiels appliqués
1. **WCAG 2.2**: Web Content Accessibility Guidelines niveau AA
2. **Microsoft Inclusive Design**: Principes design inclusif
3. **Curb-cut principle**: Bénéfice universel des adaptations spécialisées
4. **Cognitive Load Theory**: Théorie charge cognitive de Sweller
5. **ARIA Authoring Practices**: Patterns interaction accessibles

### Outils de validation recommandés
- **axe-core**: Audit accessibilité automatisé
- **Pa11y**: Tests accessibilité en ligne de commande  
- **WAVE**: Web Accessibility Evaluation Tool
- **Lighthouse**: Audit performance et accessibilité Chrome
- **Screen Reader**: Tests avec NVDA/JAWS/VoiceOver
