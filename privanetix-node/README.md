# Deploy privasea acceleration-node

Official documentation: https://www.privasea.ai/privanetix-node

Deploying a node: https://privasea.gitbook.io/user-node-usage-documentation/comprehensive-guide-to-privanetix-node-acceleration-node-and-workheart-node-setup-and-operation/privanetix-node

### NOTE
This node is configured for Level 1 configuration. update `spheron.yaml` resources section according to required level.

Steps:
1. Generate keystore as per [Deploying a node](https://privasea.gitbook.io/user-node-usage-documentation/comprehensive-guide-to-privanetix-node-acceleration-node-and-workheart-node-setup-and-operation/privanetix-node) guide

2. Update envs in `spheron.yaml`:
- set `wallet_keystore` json content to `KEYSTORE_CONTENT` variable. to print `cat $HOME/privasea/config/wallet_keystore`
- set `keystore password` to `KEYSTORE_PASSWORD` variable

3. Deploy using sphnctl:
```bash
$ sphnctl deployment create spheron.yml
```

### NOTE: Follow instructions in `Deploying a node` documentation for queries
