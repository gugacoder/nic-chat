# MCP Tools System

```yaml
---
type: feature
tags: [mcp, tools, automation, protocol]
created: 2025-01-20
updated: 2025-01-20
status: planning
up: "[[MCP Tools Architecture.md]]"
related: "[[Corporate Chat Interface.md]]"
dependencies: "[[MCP Tools Architecture.md]]"
---
```

## Purpose

The MCP Tools System implements the Model Context Protocol to enable NIC LLM to interact directly with corporate systems and tools, transforming conversations from passive information exchange into active business process automation. This system provides secure, controlled access to enterprise tools while maintaining audit trails and proper authorization boundaries.

## Scope

- Complete MCP protocol implementation with tool discovery and capability negotiation
- Secure tool execution environment with sandbox isolation and permission management
- Dynamic tool registry supporting both static configuration and runtime discovery
- Real-time tool execution with progress tracking and result processing
- Integration with corporate systems including GitLab, databases, and external APIs
- Comprehensive audit logging and monitoring for all tool interactions
- Tool versioning and compatibility management for reliable operations
- Error handling and fallback mechanisms for robust tool execution

## User Flow

1. User mentions task requiring tool execution in conversation with NIC LLM
2. AI analyzes request and identifies appropriate tools from available registry
3. System validates user permissions and tool requirements before execution
4. Tool execution begins with real-time progress feedback in chat interface
5. Results are processed, validated, and formatted for presentation to user
6. Audit log captures complete execution history with inputs, outputs, and metadata
7. User can review results, request modifications, or chain additional tool operations
8. Tool execution context is preserved for follow-up questions and related tasks

**Success State**: Users can seamlessly execute complex business processes through natural conversation with appropriate security and audit controls

**Error Handling**: Clear error messages with actionable suggestions, automatic retry for transient failures, and escalation paths for authorization issues

## Data Models

```yaml
# MCP Protocol Models
Tool:
  name: string
  description: string
  parameters: JSONSchema
  required_permissions: string[]
  execution_context: 'sandbox' | 'system' | 'external'
  timeout: number
  
ToolExecution:
  id: string
  toolName: string
  userId: string
  conversationId: string
  parameters: object
  status: 'pending' | 'running' | 'completed' | 'failed' | 'cancelled'
  startTime: timestamp
  endTime?: timestamp
  result?: ToolResult
  error?: ErrorInfo
  
ToolResult:
  output: any
  metadata: object
  artifacts?: Artifact[]
  followUpSuggestions?: string[]

MCPMessage:
  type: 'request' | 'response' | 'notification'
  method: string
  params?: object
  result?: object
  error?: ErrorObject
```

## API Specification

```yaml
# MCP Tools API
POST /api/v1/tools/execute:
  description: Execute tool with specified parameters
  body: { toolName: string, parameters: object, conversationId: string }
  response: { executionId: string, status: string }

GET /api/v1/tools:
  description: List available tools for current user
  response: { tools: Tool[], capabilities: string[] }

WebSocket /api/v1/tools/stream/{executionId}:
  description: Real-time tool execution monitoring
  events:
    - progress: { percentage: number, message: string }
    - output: { data: any, type: 'stdout' | 'stderr' | 'result' }
    - complete: { result: ToolResult }
    - error: { error: ErrorObject }

POST /api/v1/tools/cancel/{executionId}:
  description: Cancel running tool execution
  response: { cancelled: boolean, reason?: string }
```

## Technical Implementation

### Core Components

- **MCPProtocol.py**: `backend/open_webui/services/mcp/protocol.py` - MCP protocol handler and message processing
- **ToolRegistry.py**: `backend/open_webui/services/mcp/registry.py` - Tool discovery, registration, and capability management
- **ExecutionEngine.py**: `backend/open_webui/services/mcp/executor.py` - Secure tool execution with sandbox isolation
- **ToolInterface.svelte**: `src/lib/components/tools/ToolInterface.svelte` - Frontend tool execution UI
- **SecurityManager.py**: `backend/open_webui/services/mcp/security.py` - Permission validation and audit logging

### Integration Points

- **NIC LLM Integration**: Tool calling coordination and result processing within AI conversations
- **Authentication System**: User permission validation and role-based tool access control
- **Corporate Chat Interface**: Real-time execution feedback and result presentation
- **GitLab Integration**: Specialized tools for documentation and repository management

### Implementation Patterns

- **Sandbox Isolation**: Containerized execution environment for security and resource management
- **Permission Framework**: Role-based access control with granular tool permissions
- **Event Sourcing**: Complete audit trail with event replay capabilities for debugging
- **Circuit Breaker**: Automatic protection against tool failures and resource exhaustion

## Examples

### Implementation References

- **[mcp-protocol-example/](Examples/mcp-protocol-example/)** - Complete MCP protocol implementation with sample tools
- **[tool-registry.py](Examples/tool-registry.py)** - Dynamic tool discovery and registration system
- **[sandbox-executor.py](Examples/sandbox-executor.py)** - Secure tool execution environment with Docker isolation
- **[tool-ui-components/](Examples/tool-ui-components/)** - Frontend components for tool interaction and result display

### Example Content Guidelines

When creating examples in Examples/ folder:
- Implement complete MCP protocol handlers that can be tested with real tools
- Include security examples with permission validation and sandbox configuration
- Provide sample tools for common enterprise operations (file management, API calls)
- Demonstrate error handling and recovery patterns for production reliability
- Include monitoring and logging examples for operational visibility

## Error Scenarios

- **Permission Denied**: User lacks required permissions for tool → Display permission requirements → Provide request access workflow
- **Tool Timeout**: Execution exceeds configured time limit → Cancel gracefully → Save partial results and explain timeout
- **Sandbox Failure**: Execution environment becomes unavailable → Queue for retry → Notify administrators of infrastructure issue
- **Parameter Validation**: Invalid tool parameters provided → Highlight specific errors → Provide parameter documentation and examples

## Acceptance Criteria

- [ ] MCP protocol correctly implements tool discovery and capability negotiation
- [ ] Tool execution provides real-time progress updates and maintains security boundaries
- [ ] Permission system enforces role-based access control with audit logging
- [ ] Tool registry supports dynamic registration and versioning of available tools
- [ ] Sandbox isolation prevents tool execution from affecting system security
- [ ] Error handling provides clear feedback and recovery options for all failure modes
- [ ] Integration with chat interface enables seamless tool execution within conversations
- [ ] Performance supports concurrent tool execution without resource conflicts

## Validation

### Testing Strategy

- **Unit Tests**: MCP protocol handlers, tool registration, and execution engine components
- **Security Tests**: Permission validation, sandbox isolation, and audit logging verification
- **Integration Tests**: End-to-end tool execution flows with real corporate systems

### Verification Commands

```bash
# Test MCP protocol implementation
python -m pytest tests/test_mcp_protocol.py

# Validate tool execution security
python -m pytest tests/test_tool_security.py::test_sandbox_isolation

# Test concurrent tool execution
python scripts/test_concurrent_tools.py

# Verify audit logging completeness
python -m pytest tests/test_audit.py::test_complete_trail
```

### Success Metrics

- **Execution Success**: >99% tool execution completion rate without system errors
- **Security Compliance**: 100% permission validation with complete audit trails
- **Performance**: Tool execution begins within 1 second with real-time progress updates
- **Availability**: Tool system maintains 99.9% uptime with automatic error recovery