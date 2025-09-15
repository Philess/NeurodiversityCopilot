#!/bin/bash
# Script d'audit automatisé d'accessibilité neurocognitive
# Basé sur .github/prompts/code-a11y-review.prompt.md

echo "🧠 Audit d'accessibilité neurocognitive - NeurodiversityCopilot"
echo "=================================================="

# 1. Validation structure titres
echo "📐 1. Vérification hiérarchie des titres"
echo "----------------------------------------"
if [ -f "README.md" ]; then
    echo "Structure des titres dans README.md:"
    grep -n "^#" README.md | while read line; do
        level=$(echo "$line" | grep -o "^[0-9]*:#*" | grep -o "#*" | wc -c)
        level=$((level-1))
        echo "  Ligne $(echo "$line" | cut -d: -f1): Niveau H$level - $(echo "$line" | cut -d: -f2-)"
    done
    
    # Vérification H1 unique
    h1_count=$(grep -c "^# " README.md)
    if [ $h1_count -eq 0 ]; then
        echo "❌ ERREUR: Aucun titre H1 trouvé"
    elif [ $h1_count -gt 1 ]; then
        echo "❌ ERREUR: Plusieurs titres H1 trouvés ($h1_count)"
    else
        echo "✅ Titre H1 unique trouvé"
    fi
else
    echo "❌ README.md non trouvé"
fi

echo ""

# 2. Détection mélange linguistique  
echo "🌐 2. Détection mélange linguistique"
echo "------------------------------------"
echo "Mots anglais détectés dans documentation française:"
find . -name "*.md" -exec grep -l "test\|example\|demo\|sample\|fix\|issue\|bug" {} \; | while read file; do
    echo "  📄 $file:"
    grep -n "test\|example\|demo\|sample\|fix\|issue\|bug" "$file" | head -3
done

echo ""

# 3. Validation longueur paragraphes
echo "📄 3. Analyse longueur paragraphes"
echo "----------------------------------"
if command -v python3 >/dev/null 2>&1; then
    python3 << 'EOF'
import re
import os

def analyze_paragraph_length(file_path):
    if not os.path.exists(file_path):
        print(f"❌ {file_path} non trouvé")
        return
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Supprimer métadonnées et code
    content = re.sub(r'```.*?```', '', content, flags=re.DOTALL)
    content = re.sub(r'`[^`]+`', '', content)
    
    paragraphs = re.split(r'\n\s*\n', content)
    long_paragraphs = 0
    
    for i, para in enumerate(paragraphs):
        para = para.strip()
        if len(para) < 20:  # Ignorer paragraphes très courts
            continue
            
        sentences = len([s for s in re.split(r'[.!?]+', para) if s.strip()])
        if sentences > 4:
            long_paragraphs += 1
            print(f"  ⚠️  Paragraphe {i+1}: {sentences} phrases (recommandé: 3-4 max)")
    
    if long_paragraphs == 0:
        print("  ✅ Tous les paragraphes respectent la limite de 4 phrases")
    else:
        print(f"  ❌ {long_paragraphs} paragraphe(s) trop long(s)")

for md_file in ['README.md', 'test/my-super-test.md']:
    if os.path.exists(md_file):
        print(f"Analyse de {md_file}:")
        analyze_paragraph_length(md_file)
        print()
EOF
else
    echo "❌ Python3 non disponible pour analyse paragraphes"
fi

# 4. Vérification navigation et liens
echo "🧭 4. Vérification navigation"
echo "-----------------------------"
if [ -f "README.md" ]; then
    toc_links=$(grep -c "\[.*\](#.*)" README.md)
    if [ $toc_links -eq 0 ]; then
        echo "❌ Aucun lien de navigation interne trouvé"
        echo "   Recommandation: Ajouter table des matières avec ancres"
    else
        echo "✅ $toc_links lien(s) de navigation trouvé(s)"
    fi
fi

# 5. Analyse accessibilité workflow
echo "⚙️  5. Analyse workflows GitHub"
echo "-------------------------------"
if [ -d ".github/workflows" ]; then
    echo "Workflows trouvés:"
    find .github/workflows -name "*.yml" -o -name "*.yaml" | while read workflow; do
        echo "  📋 $workflow"
        # Vérifier présence de feedback utilisateur
        if grep -q "comment\|feedback\|status" "$workflow"; then
            echo "    ✅ Contient mécanismes de feedback"
        else
            echo "    ❌ Manque feedback utilisateur visible"
        fi
    done
fi

echo ""
echo "📊 Résumé de l'audit"
echo "==================="
echo "Cet audit automatisé identifie les problèmes de base."
echo "Consultez accessibility-audit.json pour l'analyse complète."
echo ""
echo "Prochaines étapes recommandées:"
echo "1. Corriger structure titres (A11Y-001)"  
echo "2. Ajouter table des matières (A11Y-003)"
echo "3. Uniformiser terminologie (A11Y-002)"
echo "4. Consulter roadmap dans accessibility-audit-report.md"