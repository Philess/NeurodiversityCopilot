# GitHub Issues Templates for Accessibility Recommendations

This document contains formatted GitHub issue templates for each accessibility recommendation found in the audit. Each template can be copied directly to create a new GitHub issue.

---

## Issue 1: Fix README.md semantic structure and heading hierarchy

**Labels:** `accessibility`, `documentation`, `P1`, `structure`

**Priority:** P1 (High)

**Assignee:** @copilot

**Title:** [A11Y-001] Fix README.md semantic structure and heading hierarchy

**Description:**

### Problem
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
**Sprint:** Sprint 1 - Structural Foundations

---

## Issue 2: Establish consistent language policy (French/English)

**Labels:** `accessibility`, `documentation`, `P2`, `consistency`

**Priority:** P2 (Medium)

**Assignee:** @copilot

**Title:** [A11Y-002] Establish consistent language policy and fix French/English mixing

**Description:**

### Problem
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
**Sprint:** Sprint 2 - Consistency and Clarity

---

## Issue 3: Add structured navigation and table of contents

**Labels:** `accessibility`, `navigation`, `P2`, `UX`

**Priority:** P2 (Medium)

**Assignee:** @copilot

**Title:** [A11Y-003] Add structured navigation and table of contents to README

**Description:**

### Problem
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
**Sprint:** Sprint 1 - Structural Foundations

---

## Issue 4: Improve visual density and readability of test content

**Labels:** `accessibility`, `content`, `P3`, `readability`

**Priority:** P3 (Low)

**Assignee:** @copilot

**Title:** [A11Y-004] Improve visual density and readability of test content

**Description:**

### Problem
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
**Sprint:** Sprint 4 - Final Optimizations

---

## Issue 5: Add visual feedback for GitHub workflows

**Labels:** `accessibility`, `workflow`, `P2`, `feedback`

**Priority:** P2 (Medium)

**Assignee:** @copilot

**Title:** [A11Y-005] Add visual feedback and status indicators for GitHub workflows

**Description:**

### Problem
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
**Sprint:** Sprint 3 - Content Enrichment

---

## Issue 6: Add concrete examples to documentation

**Labels:** `accessibility`, `documentation`, `P1`, `examples`

**Priority:** P1 (High)

**Assignee:** @copilot

**Title:** [A11Y-006] Add concrete examples and practical use cases to documentation

**Description:**

### Problem
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
**Sprint:** Sprint 3 - Content Enrichment

---

## Issue 7: Document folder structure and architecture

**Labels:** `accessibility`, `architecture`, `P3`, `documentation`

**Priority:** P3 (Low)

**Assignee:** @copilot

**Title:** [A11Y-007] Create architecture documentation for folder structure

**Description:**

### Problem
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
**Sprint:** Sprint 2 - Consistency and Clarity

---

## Summary

**Total Issues:** 7  
**Priority P1:** 2 issues  
**Priority P2:** 3 issues  
**Priority P3:** 2 issues  

**Estimated Timeline:** 4 sprints (5 weeks total)

Each issue should be created with the corresponding labels, priority, and assignee as specified above. The issues follow the accessibility audit findings and maintain the neurodiversity-focused approach of the original audit.