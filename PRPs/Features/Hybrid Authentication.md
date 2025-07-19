# Hybrid Authentication

```yaml
---
type: feature
tags: [authentication, security, ldap, enterprise]
created: 2025-01-20
updated: 2025-01-20
status: planning
up: "[[Authentication System.md]]"
related: "[[Corporate Chat Interface.md]]"
dependencies: "[[Authentication System.md]]"
---
```

## Purpose

Hybrid Authentication provides a flexible enterprise authentication system supporting both administrative root password access and corporate LDAP integration. This dual approach ensures system accessibility for administrative operations while enabling seamless integration with existing organizational directory services for regular user authentication and authorization.

## Scope

- Root password authentication for administrative system access and emergency operations
- LDAP integration supporting Active Directory, OpenLDAP, and other directory services
- Automatic user provisioning and profile synchronization from LDAP attributes
- Role-based access control with mapping from LDAP groups to internal permissions
- Session management with secure token handling and automatic refresh capabilities
- Multi-factor authentication support for enhanced security requirements
- Comprehensive audit logging for all authentication events and security monitoring
- Graceful fallback mechanisms for LDAP service interruptions

## User Flow

1. User accesses NIC Chat login interface with corporate branding and authentication options
2. System presents appropriate authentication method based on user type and configuration
3. Regular users authenticate through LDAP with automatic profile creation or update
4. Administrative users access system through root password for elevated operations
5. Successful authentication generates secure session tokens with appropriate role assignments
6. System maintains session state with automatic token refresh and security validation
7. LDAP group memberships are synchronized and mapped to internal role permissions
8. Audit system logs all authentication events with detailed security information
9. Session expiration or logout properly cleans up authentication state and tokens

**Success State**: Seamless authentication experience for all user types with appropriate security controls and enterprise integration

**Error Handling**: Clear error messages without revealing security information, automatic fallback for LDAP failures, and comprehensive logging for security monitoring

## Data Models

```yaml
# Authentication Models
User:
  id: string
  username: string
  email: string
  displayName: string
  authMethod: 'root' | 'ldap'
  roles: string[]
  ldapDN?: string
  lastLogin: timestamp
  isActive: boolean
  
AuthSession:
  id: string
  userId: string
  token: string
  refreshToken: string
  expiresAt: timestamp
  lastActivity: timestamp
  ipAddress: string
  userAgent: string
  
LDAPConfig:
  server: string
  port: number
  useTLS: boolean
  bindDN: string
  bindPassword: string
  baseDN: string
  userSearchFilter: string
  groupSearchFilter: string
  attributeMapping: AttributeMapping
  
AuthEvent:
  id: string
  userId?: string
  username: string
  eventType: 'login_success' | 'login_failure' | 'logout' | 'token_refresh'
  ipAddress: string
  userAgent: string
  timestamp: timestamp
  details: object
```

## API Specification

```yaml
# Authentication API
POST /api/v1/auth/login:
  description: Authenticate user with credentials
  body: { username: string, password: string, authMethod?: 'root' | 'ldap' }
  response: { token: string, refreshToken: string, user: User, expiresAt: timestamp }

POST /api/v1/auth/refresh:
  description: Refresh authentication token
  body: { refreshToken: string }
  response: { token: string, expiresAt: timestamp }

POST /api/v1/auth/logout:
  description: Invalidate current session
  headers: { Authorization: Bearer {token} }
  response: { success: boolean }

GET /api/v1/auth/profile:
  description: Retrieve current user profile
  headers: { Authorization: Bearer {token} }
  response: { user: User, permissions: string[] }

POST /api/v1/auth/ldap/sync:
  description: Trigger LDAP user synchronization (admin only)
  response: { syncId: string, usersProcessed: number }
```

## Technical Implementation

### Core Components

- **AuthService.py**: `backend/open_webui/services/auth/service.py` - Central authentication orchestration
- **LDAPClient.py**: `backend/open_webui/services/auth/ldap.py` - LDAP integration and user synchronization
- **TokenManager.py**: `backend/open_webui/services/auth/tokens.py` - JWT token generation and validation
- **LoginForm.svelte**: `src/lib/components/auth/LoginForm.svelte` - Authentication interface
- **SessionManager.py**: `backend/open_webui/services/auth/sessions.py` - Session state and lifecycle management

### Integration Points

- **Corporate Chat Interface**: Authentication state management and user session integration
- **Database Architecture**: User account storage and authentication event logging
- **System Monitoring**: Authentication metrics and security event tracking
- **MCP Tools System**: Permission validation for tool access authorization

### Implementation Patterns

- **Adapter Pattern**: Unified authentication interface supporting multiple authentication methods
- **Strategy Pattern**: Configurable authentication strategies with runtime selection
- **Circuit Breaker**: LDAP service protection with automatic fallback to cached credentials
- **Event Sourcing**: Complete audit trail with immutable authentication event logging

## Examples

### Implementation References

- **[hybrid-auth-example/](Examples/hybrid-auth-example/)** - Complete authentication system with LDAP and root password support
- **[ldap-integration.py](Examples/ldap-integration.py)** - LDAP client implementation with connection pooling and error handling
- **[token-manager.py](Examples/token-manager.py)** - JWT token handling with refresh and validation logic
- **[auth-components/](Examples/auth-components/)** - Frontend authentication components and forms

## Error Scenarios

- **LDAP Server Unavailable**: Directory service connection fails → Use cached credentials if available → Fall back to root authentication for admins
- **Invalid Credentials**: Wrong username or password provided → Log security event → Return generic error without revealing authentication method
- **Token Expired**: Session token exceeds validity period → Attempt automatic refresh → Redirect to login if refresh fails
- **Permission Denied**: User lacks required role for requested operation → Log access attempt → Return clear permission requirements

## Acceptance Criteria

- [ ] Root password authentication provides immediate administrative access with proper session management
- [ ] LDAP integration authenticates users against corporate directory with automatic profile synchronization
- [ ] Role mapping correctly assigns permissions based on LDAP group membership
- [ ] Session tokens remain valid for configured duration with automatic refresh capability
- [ ] Authentication failures are logged with appropriate security event details
- [ ] System gracefully handles LDAP service interruptions without blocking critical operations
- [ ] Multi-factor authentication integration supports enterprise security requirements
- [ ] Audit logging captures all authentication events with sufficient detail for security monitoring

## Validation

### Testing Strategy

- **Unit Tests**: Authentication logic, token management, and LDAP client functionality
- **Integration Tests**: End-to-end authentication flows with test LDAP server
- **Security Tests**: Authorization boundary testing and session management validation

### Verification Commands

```bash
# Test LDAP authentication and synchronization
python -m pytest tests/test_ldap_auth.py::test_user_authentication

# Validate token security and lifecycle
python -m pytest tests/test_token_manager.py::test_token_security

# Test session management and cleanup
python -m pytest tests/test_sessions.py::test_session_lifecycle

# Verify audit logging completeness
python scripts/test_auth_audit.py --verify-events
```

### Success Metrics

- **Authentication Success Rate**: >99.5% successful authentication for valid credentials
- **LDAP Response Time**: Directory queries complete within 2 seconds under normal load
- **Security Compliance**: 100% authentication events logged with complete audit trails
- **Session Management**: Token refresh success rate >99% with graceful error handling