#!/bin/bash

# Script to create GitHub issues from accessibility audit findings
# Usage: ./scripts/create-accessibility-issues.sh
# Requires: gh CLI tool installed and authenticated

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if gh CLI is available
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed or not in PATH${NC}"
    echo "Please install gh CLI: https://cli.github.com/"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${RED}Error: Not authenticated with GitHub CLI${NC}"
    echo "Please run: gh auth login"
    exit 1
fi

echo -e "${GREEN}Creating accessibility issues from audit findings...${NC}"

# Array of issue data (title|body|labels|assignee)
declare -a issues=(
    "[A11Y-001] Fix README.md semantic structure and heading hierarchy|### Problem
README.md lacks clear semantic structure with inconsistent heading levels (missing H1, jumping from H1 to emoji/text). This creates difficulties for assistive technologies and neurodivergent users.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** Compromises detailed processing due to lack of clear hierarchical landmarks
- **ADHD:** Causes attention fragmentation due to unpredictable structure for mental navigation

### Standards Compliance
- WCAG 2.4.6 (Headings and Labels)
- WCAG 1.3.1 (Info and Relationships)
- Inclusive Design - visual hierarchy

### Specific Example
README.md lines 3-6: using emojis as section markers without H2/H3 structure

### Suggested Remediation
Restructure README.md with:
- H1 main heading
- H2 for main sections (Objective, Structure, Clarity, etc.)
- H3 for subsections

### Progressive Alternative
Add at minimum an H1 'NeurodiversityCopilot' at line 1

### Validation Criteria
- [ ] 100% of sections have appropriate heading level (H1-H6)
- [ ] Verifiable by HTML validator or automated script
- [ ] Navigation structure is logically consistent

**Effort Estimate:** Medium  
**Sprint:** Sprint 1 - Structural Foundations|accessibility,documentation,P1,structure|copilot"

    "[A11Y-002] Establish consistent language policy and fix French/English mixing|### Problem
Inconsistent French/English mixing in README.md and file names (e.g., 'my-super-test.md') creates linguistic inconsistency that disrupts cognitive flow.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** Breaks predictability and increases execution load for contextual transitions between languages
- **ADHD:** Extrinsic cognitive overload from implicit linguistic context changes

### Standards Compliance
- WCAG 3.1.1 (Language of Page)
- WCAG 3.1.2 (Language of Parts)
- Inclusive Design - consistency

### Specific Example
test/my-super-test.md vs French documentation in README.md

### Suggested Remediation
- Establish clear language policy (French priority)
- Rename files according to consistent convention
- Add lang attributes where appropriate

### Progressive Alternative
Add lang='fr' attributes to French content, lang='en' to English content

### Validation Criteria
- [ ] 100% of content has appropriate lang attribute
- [ ] 0 language mixing within same context
- [ ] Consistent file naming convention

**Effort Estimate:** Small  
**Sprint:** Sprint 2 - Consistency and Clarity|accessibility,documentation,P2,consistency|copilot"

    "[A11Y-003] Add structured navigation and table of contents to README|### Problem
Absence of structured navigation and 'skip to content' links for rapid access to main sections.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** Increases cognitive load for locating specific information, disrupts navigation routines
- **ADHD:** Loss of focus and difficulty maintaining goal under visual load during scrolling

### Standards Compliance
- WCAG 2.4.1 (Bypass Blocks)
- WCAG 2.4.3 (Focus Order)
- WCAG 2.4.13 (Page Break Navigation)

### Specific Example
README.md without table of contents or internal navigation links

### Suggested Remediation
Add table of contents with anchor links to each main section

### Progressive Alternative
Simple links to existing sections

### Validation Criteria
- [ ] Average access time to a section < 5 seconds
- [ ] Functional keyboard navigation
- [ ] Table of contents with working anchor links

**Effort Estimate:** Small  
**Sprint:** Sprint 1 - Structural Foundations|accessibility,navigation,P2,UX|copilot"

    "[A11Y-004] Improve visual density and readability of test content|### Problem
test/my-super-test.md contains dense Lorem Ipsum without spacing, creating visual overload.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** Heightened visual sensitivity triggered by high textual density without pause landmarks
- **ADHD:** External distraction vulnerability amplified by unstructured text

### Standards Compliance
- WCAG 1.4.8 (Visual Presentation)
- Inclusive Design - spacing
- Progressive Disclosure patterns

### Specific Example
test/my-super-test.md lines 3-11: continuous text block without short paragraphs

### Suggested Remediation
Replace Lorem Ipsum with structured test content with short sections (3-4 sentences max)

### Progressive Alternative
Add spacing between existing paragraphs

### Validation Criteria
- [ ] Average paragraph length < 4 sentences
- [ ] Visual spacing >= 1.5x
- [ ] Structured content with clear breaks

**Effort Estimate:** Small  
**Sprint:** Sprint 4 - Final Optimizations|accessibility,content,P3,readability|copilot"

    "[A11Y-005] Add visual feedback and status indicators for GitHub workflows|### Problem
Complex GitHub workflow (.github/workflows/pr-to-issue.yml) without visual progress feedback for users.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** System state uncertainty increases anxiety and breaks interaction predictability
- **ADHD:** Absence of immediate feedback compromises attention maintenance on task

### Standards Compliance
- WCAG 3.2.1 (On Focus)
- WCAG 3.2.2 (On Input)
- Inclusive Design - system state visibility

### Specific Example
.github/workflows/pr-to-issue.yml: Copilot assignment process without visual state indicators

### Suggested Remediation
Add status badges and informative comments detailing each process step

### Progressive Alternative
Improve feedback messages in GitHub comments

### Validation Criteria
- [ ] 100% of automated actions produce visible feedback < 2 seconds
- [ ] Clear status indicators for workflow progress
- [ ] User-friendly error messages

**Effort Estimate:** Medium  
**Sprint:** Sprint 3 - Content Enrichment|accessibility,workflow,P2,feedback|copilot"

    "[A11Y-006] Add concrete examples and practical use cases to documentation|### Problem
Instructions in README.md lack concrete examples and practical use cases.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** Detailed processing compromised by abstract instructions without contextual anchoring
- **ADHD:** Limited working memory overloaded by non-exemplified instructions

### Standards Compliance
- WCAG 3.3.2 (Labels or Instructions)
- Inclusive Design - contextual clarity

### Specific Example
README.md sections 2-5: principles stated without concrete HTML/CSS examples

### Suggested Remediation
Add HTML/CSS code examples for each stated principle

### Progressive Alternative
Add at least one example per main section

### Validation Criteria
- [ ] Each principle accompanied by at least 1 concrete example
- [ ] Understanding time < 30 seconds per example
- [ ] Interactive examples where possible

**Effort Estimate:** Large  
**Sprint:** Sprint 3 - Content Enrichment|accessibility,documentation,P1,examples|copilot"

    "[A11Y-007] Create architecture documentation for folder structure|### Problem
Mixed folder structure (.github, test) without clear convention or architecture documentation.

### Impact on Neurodivergent Users
- **TSA (Autism Spectrum):** Routine disruption and difficulty orienting in information organization
- **ADHD:** Increased extrinsic cognitive load from unguided structure exploration

### Standards Compliance
- Inclusive Design - consistency
- Information Architecture - findability

### Specific Example
Folders: .github/prompts/, .github/workflows/, test/ without structure documentation

### Suggested Remediation
Create ARCHITECTURE.md documenting folder organization and naming conventions

### Progressive Alternative
Add comments in README.md explaining current structure

### Validation Criteria
- [ ] 100% of folders documented
- [ ] File location time < 15 seconds
- [ ] Clear naming conventions established

**Effort Estimate:** Small  
**Sprint:** Sprint 2 - Consistency and Clarity|accessibility,architecture,P3,documentation|copilot"
)

# Counter for created issues
created_count=0
total_count=${#issues[@]}

echo -e "${YELLOW}Total issues to create: $total_count${NC}"
echo ""

# Create each issue
for issue_data in "${issues[@]}"; do
    IFS='|' read -r title body labels assignee <<< "$issue_data"
    
    echo -e "${YELLOW}Creating issue: $title${NC}"
    
    # Create the issue
    if gh issue create \
        --title "$title" \
        --body "$body" \
        --label "$labels" \
        --assignee "$assignee"; then
        
        ((created_count++))
        echo -e "${GREEN}✓ Issue created successfully${NC}"
    else
        echo -e "${RED}✗ Failed to create issue: $title${NC}"
    fi
    
    echo ""
done

echo -e "${GREEN}Accessibility issues creation completed!${NC}"
echo -e "${GREEN}Created: $created_count/$total_count issues${NC}"

if [ $created_count -eq $total_count ]; then
    echo -e "${GREEN}All accessibility audit recommendations have been converted to GitHub issues.${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Review the created issues in the GitHub repository"
    echo "2. Start with P1 (high priority) issues first"
    echo "3. Follow the sprint roadmap defined in the accessibility audit"
    echo "4. Use the validation criteria in each issue to verify completion"
else
    echo -e "${YELLOW}Some issues failed to create. Please check the errors above and retry if needed.${NC}"
fi