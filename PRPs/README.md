# PRP System Documentation

## Overview

Product Requirements Prompts (PRPs) is a structured documentation system for organizing development knowledge, tasks, and features using a DTF (Domains-Tasks-Features) framework.

## Directory Structure

```text
PRPs/
├── Domains/          # Knowledge and context files
├── Tasks/           # Action items with severity and status tracking  
├── Features/        # Development efforts with energy classification
├── Templates/       # File templates for each type
└── README.md        # This documentation
```

## Como Usar esta Estrutura?

O sistema PRP implementa um pipeline de Context Engineering que transforma especificações gerais em documentação distribuída e depois reassembla contexto dinamicamente para implementação por IA. O workflow principal consiste em duas fases: `generate-prp` para decompor especificações em Features/Tasks/Domains com links apropriados, e `execute-prp` para montar contexto completo seguindo as relações do frontmatter e executar implementações autônomas.

Para entender completamente a arquitetura, fluxo de trabalho e regras de context assembly, consulte [[Domains/System Architecture.md]] que detalha como o sistema funciona internamente e como usar os comandos de forma efetiva.

## File Naming Conventions

### Domains

**Format**: `{Title}.md`
**Purpose**: Store reusable knowledge and context patterns
**Examples**:

```text
Authentication Backend.md
State Management Frontend.md  
Database Migrations.md
API Error Handling.md
Docker Deployment Setup.md
```

### Tasks  

**Format**: `{severity_emoji} Task {NN} - {Verb} {Short Description}.md`
**Purpose**: Track specific action items with visual severity indication
**Examples**:

```text
🔴 Task 01 - Fix Major Bug in Credits Page.md
🟡 Task 02 - Implement JWT Middleware.md
🟢 Task 03 - Review Auth Documentation.md
🟠 Task 04 - Setup Database Migration.md
```

**Severity Emojis**:

- 🔴 `critical` - System breaking, security vulnerabilities, data loss risk
- 🟠 `major` - Significant functionality impact, user experience degradation
- 🟡 `medium` - Standard bug fixes, feature enhancements
- 🟢 `minor` - Polish, refactoring, documentation updates

### Features

**Format**: `{Short Description} {Subject}.md`
**Purpose**: Define development efforts and feature scope
**Examples**:

```text
Auth System Feature.md
Auth System Architecture.md  
Auth System Initial Setup.md
Payment Integration Feature.md
Real Time Notifications.md
```

## Frontmatter Structure

### Required Fields (All Types)

```yaml
type: domain|task|feature
tags: [technology, priority, category]
created: 2025-01-20
updated: 2025-01-20
status: active|draft|archived|deprecated
up: "[[Parent Context.md]]"
related: "[[Other File.md]]"
```

### Type-Specific Fields

**Domain**: No additional required fields

**Task**:

```yaml
status: todo|in-progress|review|done|blocked
severity: 🔴 critical|🟠 major|🟡 medium|🟢 minor
feature: "[[Feature Name.md]]"
```

**Feature**:

```yaml
status: planning|development|testing|done
dependencies: "[[Required Context.md]]"
```

## Task Status Management

**Status Values**:

- `todo` - Not yet started
- `in-progress` - Currently being worked on
- `review` - Awaiting review or approval
- `done` - Completed successfully
- `blocked` - Cannot proceed due to dependencies

**Status Tracking**: Status is managed entirely through frontmatter `status` field. File names remain stable to preserve link integrity.

## Severity Classification

**Severity Levels** (with visual indicators):

- 🔴 `critical` - Emergency response required, system breaking issues
- 🟠 `major` - Important but not emergency, significant impact
- 🟡 `medium` - Standard development work, moderate impact
- 🟢 `minor` - Low priority, cosmetic or optimization tasks

**Severity Usage**: Displayed in filename for immediate visual identification and stored in frontmatter for querying and filtering.

## Linking Strategy

### Hierarchical Navigation

Use `up` field to define parent-child relationships:

```yaml
up: "[[Authentication Backend.md]]"  # Points to parent context
```

### Cross-References  

Use `related` field for lateral connections:

```yaml
related: "[[JWT Implementation.md]]"  # Points to related content
```

### Dependencies

Use `dependencies` field for required prerequisites:

```yaml
dependencies: "[[Database Schema.md]]"  # Must exist before this
```

## Templates

File templates for each type are available in `PRPs/Templates/`:

- `domain-template.md` - Structure for domain files
- `task-template.md` - Structure for task files  
- `feature-template.md` - Structure for feature files

Copy the appropriate template when creating new files to ensure consistent structure.

## Usage Instructions

### Creating New Files

1. Determine type (Domain/Task/Feature)
2. Copy appropriate template from `PRPs/Templates/`
3. Follow naming convention exactly
4. Add required frontmatter fields
5. Link to parent using `up` field
6. Tag appropriately for discoverability

### Updating Task Status

**Status Changes**: Update `status` field in frontmatter only. Do not modify filename.
**Severity Changes**: Update both filename emoji and frontmatter `severity` field if needed.

### Linking Context

Use wiki-style links `[[Filename.md]]` in:

- Frontmatter fields (quoted)
- Content body (unquoted)
- Cross-references between files

### Context Assembly

Reference multiple domains using link depth:

```text
Follow links from [[Authentication Backend.md]] to depth 2 levels
Include all connected patterns and examples
```

## Tag Taxonomy

- Technology Tags: `backend`, `frontend`, `database`, `api`, `security`, `devops`, `testing`
- Priority Tags: `urgent`, `high`, `medium`, `low`, `critical`
- Scope Tags: `mvp`, `enhancement`, `refactor`, `bug`, `feature`, `spike`
- Domain Tags: `auth`, `payment`, `user-management`, `notification`, `analytics`

## Best Practices

### File Naming

- Use Title Case for readability
- Keep descriptions concise but specific
- Include severity emoji in task names for immediate visual priority
- Maintain consistent formatting across all file types

### Content Quality

- Provide concrete examples over abstract descriptions
- Include validation criteria for all tasks
- Link related concepts explicitly
- Update timestamps when modifying content

### Context Linking

- Establish clear hierarchies using `up` relationships
- Create lateral connections with `related` fields  
- Define explicit dependencies for features
- Enable context discovery through comprehensive tagging

### Maintenance

- Archive completed tasks rather than deleting
- Update related files when dependencies change
- Maintain consistent tagging across all files
- Regular review of `status` field accuracy
- Keep severity indicators synchronized between filename and frontmatter
