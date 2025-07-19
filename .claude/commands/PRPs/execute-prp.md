# Execute DTF Task

Implement a task using the DTF task file and its assembled context.

**REQUIRED READING BEFORE STARTING:**

- Read `PRPs/Domains/System Architecture.md` to understand context assembly rules and link traversal
- Read `PRPs/README.md` to understand file structure and conventions

## Task File: $ARGUMENTS

## Execution Process

1. **Load Task Context**
   - Read the specified task file
   - Follow frontmatter links (`up`, `feature`, `dependencies`, `related`) to assemble complete context
   - Understand all context and requirements from task and linked domains/features
   - Follow all instructions and extend the research if needed
   - Ensure you have all needed context to implement the task fully
   - Do more web searches and codebase exploration as needed

2. **ULTRATHINK**
   - Think hard before you execute the plan. Create a comprehensive plan addressing all requirements.
   - Break down complex tasks into smaller, manageable steps using your todos tools.
   - Use the TodoWrite tool to create and track your implementation plan.
   - Identify implementation patterns from existing code and linked domains to follow.

3. **Execute the plan**
   - Execute the task implementation
   - Implement all the code

4. **Validate**
   - Run each validation command from task file
   - Fix any failures
   - Re-run until all pass

5. **Complete**
   - Ensure all acceptance criteria done
   - Run final validation suite
   - Report completion status
   - Read the task file again to ensure you have implemented everything

6. **Reference the Context**
   - You can always reference the task file and linked domains again if needed

Note: If validation fails, use error patterns from linked domains and task acceptance criteria to fix and retry.