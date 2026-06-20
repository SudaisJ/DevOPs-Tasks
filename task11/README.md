# Week 11: Secrets Management (HashiCorp Vault)

## Architecture Flow
1. **Storage:** Secrets are encrypted at rest inside HashiCorp Vault’s Key-Value (`kv`) engine.
2. **Authentication:** The application pod boots up with a custom Vault Agent sidecar container. The sidecar uses the cluster's internal JWT token to authenticate against Vault via the `kubernetes` auth method.
3. **Authorization:** Vault verifies the token against the `opsforge-app` role and checks the `opsforge-db-policy` to ensure the app is only allowed to read its specific path.
4. **Injection:** Upon validation, the Vault Agent fetches the credentials and mounts them as a local virtual file at `/vault/secrets/database` inside the app container's shared memory space, keeping sensitive keys completely out of the static application images.
