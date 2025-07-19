# Generate DTF Structure

Generate comprehensive DTF (Domains-Tasks-Features) documentation from initial specification with thorough research and context engineering.

**REQUIRED READING BEFORE STARTING:**

- Read `PRPs/Domains/System Architecture.md` to understand DTF framework and context assembly rules
- Read `PRPs/README.md` to understand file naming conventions and structure
- Review templates in `PRPs/Templates/` for proper formatting

## Initial File: $ARGUMENTS

## Generation Process

Read the specification file ($ARGUMENTS) first to understand what needs to be created, which domains are involved, and what features/tasks need to be implemented. The implementing AI will only get the context you create in the DTF files and their frontmatter links. Assume the AI has access to the codebase and websearch capabilities, so include URLs to documentation and examples where relevant.

### Research Phase

- Explore existing codebase for patterns and conventions
- Search for relevant documentation and best practices for mentioned technologies  
- Identify reusable knowledge patterns for domains
- Find implementation examples and reference code
- Review existing PRPs structure for similar features

***** CRITICAL AFTER YOU ARE DONE RESEARCHING AND EXPLORING THE CODEBASE *****
***** ULTRATHINK ABOUT THE DTF STRUCTURE AND PLAN YOUR APPROACH *****

Plan the complete DTF structure:

- Map all domains needed and their relationships
- Identify each distinct feature with clear scope  
- Break features into atomic, executable tasks
- Plan frontmatter linking for context assembly
- Identify examples to create in Features/Examples/

### Generation Phase

Create the DTF files following the exact structure and conventions:

1. **Domain Files** in `PRPs/Domains/` using `domain-template.md`
   - Follow naming pattern: `{Title}.md`
   - Include comprehensive conceptual overview
   - List and link all features belonging to this domain
   - Set proper frontmatter with `up`, `related` links

2. **Feature Files** in `PRPs/Features/` using `feature-template.md`  
   - Follow naming pattern: `{Short Description} {Subject}.md`
   - Include complete implementation context and examples
   - Create examples in `PRPs/Features/Examples/` as needed
   - Set proper frontmatter with `up`, `dependencies`, `related` links

3. **Task Files** in `PRPs/Tasks/` using `task-template.md`
   - Follow naming pattern: `{severity_emoji} Task {NN} - {Verb} {Description}.md`
   - Assign appropriate severity: 🔴 🟠 🟡 🟢  
   - Include specific implementation steps and acceptance criteria
   - Set proper frontmatter with `up`, `feature`, `related` links

### Validation

- Ensure all frontmatter links resolve correctly
- Verify context assembly paths provide complete implementation context
- Confirm all specification requirements are covered by generated files
- Validate naming conventions and template usage