# System Architecture

```yaml
---
type: domain
tags: [system, architecture, workflow]
created: 2025-01-20
updated: 2025-01-20
status: active
up: "[[../README.md]]"
---
```

## Context Assembly Rules

### generate-prp Processing

**Input**: `INITIAL.md` specification file
**Output**: Network of linked atomic documents

**Required Actions**:

1. **Parse** INITIAL.md for distinct features and requirements
2. **Create** one feature file per distinct functionality using `feature-template.md`
3. **Create** task files for implementation steps using severity emojis
4. **Create** domain files for reusable patterns and knowledge
5. **Link** all files via frontmatter relationships

**Frontmatter Linking Rules**:

```yaml
# Feature files MUST link to:
up: "[[Primary Domain.md]]"           # Parent domain containing this feature
dependencies: "[[Required Context.md]]"  # Domain knowledge needed for implementation
related: "[[Similar Feature.md]]"     # Optional lateral connections

# Task files MUST link to:
up: "[[Primary Domain.md]]"           # Domain containing implementation patterns  
feature: "[[Parent Feature.md]]"      # Feature this task implements
related: "[[Related Task.md]]"        # Optional task dependencies

# Domain files MUST link to:
up: "[[Parent Domain.md]]"            # Higher-level domain (if applicable)
related: "[[Related Domain.md]]"      # Cross-cutting concerns
```

### execute-prp Processing

**Input**: Single task file (e.g., `🔴 Task 01 - Implement Auth.md`)
**Output**: Complete implementation with full context

**Context Assembly Algorithm**:

1. **Start** with target task file
2. **Extract** frontmatter links: `up`, `feature`, `dependencies`, `related`
3. **Follow** each link and extract their frontmatter links
4. **Continue** recursively to depth 3 maximum
5. **Resolve** dependency order: dependencies first, then up chain, then related
6. **Load** complete content of all linked files
7. **Provide** assembled context to implementation AI

**Link Traversal Depth**:

- `dependencies`: Follow to depth 3
- `up`: Follow complete chain to root
- `related`: Follow to depth 1 only
- `feature`: Always include complete content

## File Creation Specifications

### Feature File Requirements

**Naming**: `{Short Description} {Subject}.md`
**Content**: Use `PRPs/Templates/feature-template.md`
**Required Frontmatter**:

```yaml
type: feature
up: "[[Domain.md]]"              # REQUIRED: Primary domain
dependencies: "[[Context.md]]"   # REQUIRED: Implementation context needed
related: "[[Feature.md]]"        # OPTIONAL: Related features
```

### Task File Requirements

**Naming**: `{emoji} Task {NN} - {Verb} {Description}.md`
**Content**: Use `PRPs/Templates/task-template.md`
**Required Frontmatter**:

```yaml
type: task
severity: 🔴 critical|🟠 major|🟡 medium|🟢 minor
up: "[[Domain.md]]"              # REQUIRED: Implementation patterns domain
feature: "[[Feature.md]]"        # REQUIRED: Parent feature
related: "[[Task.md]]"           # OPTIONAL: Related tasks
```

### Domain File Requirements

**Naming**: `{Title}.md`
**Content**: Use `PRPs/Templates/domain-template.md`
**Required Frontmatter**:

```yaml
type: domain
up: "[[Parent Domain.md]]"       # OPTIONAL: Parent domain
related: "[[Domain.md]]"         # OPTIONAL: Related domains
```

## Context Assembly Examples

### Example 1: Simple Task Execution

**Target**: `🟡 Task 05 - Add User Validation.md`

**Frontmatter**:
```yaml
up: "[[Authentication Backend.md]]"
feature: "[[User Registration Feature.md]]"
related: "[[🟢 Task 03 - Setup Database.md]]"
```

**Assembly Result**:
1. Load `🟡 Task 05 - Add User Validation.md` (target)
2. Load `[[User Registration Feature.md]]` (feature context)
3. Load `[[Authentication Backend.md]]` (implementation patterns)
4. Load `🟢 Task 03 - Setup Database.md` (related context)
5. Follow `[[User Registration Feature.md]]` dependencies (depth 1)
6. Follow `[[Authentication Backend.md]]` up chain (to root)

### Example 2: Complex Dependency Chain

**Target**: `🔴 Task 01 - Implement JWT Middleware.md`

**Context Chain**:
```text
🔴 Task 01 - Implement JWT Middleware.md
├── feature: [[Auth System Feature.md]]
│   ├── up: [[Authentication Backend.md]]
│   │   ├── up: [[Backend Architecture.md]]
│   │   └── related: [[Security Patterns.md]]
│   └── dependencies: [[Database Schema.md]]
│       └── up: [[Database Architecture.md]]
└── up: [[Authentication Backend.md]] (already loaded)
```

**Assembly Order**:
1. `[[Database Schema.md]]` (deepest dependency)
2. `[[Database Architecture.md]]` (dependency parent)
3. `[[Authentication Backend.md]]` (implementation patterns)
4. `[[Backend Architecture.md]]` (architecture parent)
5. `[[Security Patterns.md]]` (related context)
6. `[[Auth System Feature.md]]` (feature context)
7. `🔴 Task 01 - Implement JWT Middleware.md` (target)

## Processing Instructions

### For generate-prp Command

**When analyzing INITIAL.md**:

1. **Identify Features**: Look for distinct functionality blocks
2. **Extract Tasks**: Break features into executable steps
3. **Discover Domains**: Identify reusable knowledge areas
4. **Create Links**: Establish dependency relationships
5. **Validate**: Ensure all files have proper frontmatter links

**Feature Detection Pattern**:
- Each noun phrase describing functionality = potential feature
- Each verb phrase describing action = potential task
- Each knowledge area mentioned = potential domain

### For execute-prp Command

**When processing target task**:

1. **Parse**: Extract frontmatter from target file
2. **Traverse**: Follow all link types per depth rules
3. **Deduplicate**: Remove duplicate files from context
4. **Order**: Arrange by dependency hierarchy
5. **Assemble**: Concatenate all content in dependency order
6. **Execute**: Implement using complete assembled context

**Context Validation**:
- Verify all linked files exist
- Check for circular dependencies
- Ensure required frontmatter fields present
- Validate link depth limits respected

## Error Handling

### Missing Links

```yaml
# If linked file doesn't exist:
up: "[[Missing Domain.md]]"  # ERROR: File not found
```

**Action**: Create placeholder file or skip link with warning

### Circular Dependencies

```yaml
# File A links to File B, File B links to File A
# DETECTED: Circular dependency
```

**Action**: Break cycle at detection point, include both files once

### Depth Limit Exceeded

```text
Link chain exceeds depth 3
```

**Action**: Truncate at depth limit, include warning in context

## Implementation Success Criteria

### generate-prp Success

- [ ] All features from INITIAL.md have corresponding feature files
- [ ] All tasks have proper severity classification and numbering
- [ ] All domains contain reusable knowledge patterns
- [ ] All frontmatter links resolve to existing files
- [ ] Dependency graph is acyclic and complete

### execute-prp Success

- [ ] Target task context fully assembled
- [ ] All dependencies loaded in correct order
- [ ] Implementation follows patterns from linked domains
- [ ] Task acceptance criteria met
- [ ] No broken links or missing context
