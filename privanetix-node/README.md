# Deploy privasea acceleration-node

Official documentation: https://www.privasea.ai/privanetix-node
Deploying a node: https://privasea.gitbook.io/user-node-usage-documentation/comprehensive-guide-to-privanetix-node-acceleration-node-and-workheart-node-setup-and-operation/privanetix-node

### NOTE
This node is configured for Level 1 configuration. update `spheron.yaml` according to required level.

Prerequisite steps:
1. Deploy using sphnctl:
```bash
$ sphnctl deployment create spheron.yml
```

2. Shell into deployment

```bash
$ sphnctl deployment shell privasea-node /bin/sh --lid 44 --stdin --tty 
```

2. Generate the keystore file
```bash
$ ./node-calc new_keystore
```
After successful creation of the wallet, the program will display information similar to the following:
```bash
node address: 0xf07c3eF23ae7BEb8CD8bA5fF546E35Fd4b332B34
# This is the node address you generated, used for linking in the dashboard 
node filename: keystore:///app/config/UTC--2025-01-06T06-11-07.485797065Z--f07c3ef23ae7beb8cd8ba5ff546e35fd4b332b34
```
3. Rename keystore
cd config && ls

- Rename the keystore file you noted in the previous step:
```bash
mv ./UTC--2025-01-06T06-11-07.485797065Z--f07c3ef23ae7beb8cd8ba5ff546e35fd4b332b34  ./wallet_keystore 
ls 
```
- Replace UTC--2025-01-06T06-11-07.485797065Z--f07c3ef23ae7beb8cd8ba5ff546e35fd4b332b34 with the name of the keystore file you found.

- Check that the wallet_keystore file in the /privasea/config folder was modified correctly:

4. Run node
```bash
$ export KEYSTORE_PASSWORD=<PASSWORD>
$ ./node-calc
```

### NOTE: Follow instructions in `Deploying a node` documentation for more queries
