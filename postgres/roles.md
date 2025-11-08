Roles:
- own database objects
- have privileges
- granted privileges to database objects
- can possibly grant privileges to other roles

Postgres has different type of roles: users and groups.
1. users - allow to log in
2. group - doesn't allow to log in 

Unless othervise set, new roles can INHERIT privileges from other roles and have
unlimited connections.

Postgres has superuser, which bypasses all privilege checks, except LOGIN

PUBLIC role is a role which all roles are granted implicit membership of.
- it cannot be deleted
- granted `CONNECT`, `USAGE`, `TEMPORARY` and `EXECUTE` by default
- has access to `public`

**Privilages**
- The set of access rights to database and database objects
- Can be granted and revoked by a role with authority
- Explicit grant or revoke only impacts existing objects(for example grant access to table)

**Inheritance**
- Roles can be granted membership into another role
- If role has `INHERIT` set, then all members automatically have usage of privileges
- It's preferred way to create group privileges

Roles are not about access to specific rows, to define access rules to rows, the `POLICY` must be used
