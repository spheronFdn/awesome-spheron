# Deploying the PrivaSea Acceleration Node

**Official Documentation:**  
- [PrivaSea Website](https://www.privasea.ai/privanetix-node)  
- [Comprehensive Deployment Guide](https://privasea.gitbook.io/user-node-usage-documentation/comprehensive-guide-to-privanetix-node-acceleration-node-and-workheart-node-setup-and-operation/privanetix-node)

This node is configured for **Level 1** by default. If you need a different configuration level, please update the `resources` section of your `spheron.yaml` accordingly.

## Steps to Deploy

### 1. Generate a Keystore
Follow the instructions in the [Deploying a Node guide](https://privasea.gitbook.io/user-node-usage-documentation/comprehensive-guide-to-privanetix-node-acceleration-node-and-workheart-node-setup-and-operation/privanetix-node) to create your keystore. Once generated, you will have a `wallet_keystore` file and a corresponding **keystore password**.

### 2. Update `spheron.yaml` Environment Variables

You can deploy the acceleration node in **two modes**:

#### **A) KEYSTORE_CONTENT Mode** (Recommended for Spheron CLI Users)
1. Copy the contents of your `wallet_keystore` file and assign it to `KEYSTORE_CONTENT`.  
   \- To confirm what to copy, run:  
   ```bash
   cat $HOME/privasea/config/wallet_keystore
   ```
2. Set the keystore’s password in `KEYSTORE_PASSWORD`.

#### **B) PRIVATE_KEY Mode** (Recommended for SuperNoderz Users)
If you want to generate the keystore **inside** the container rather than passing the entire keystore content, specify these environment variables in `spheron.yaml`:

```yaml
- API_URL=<API_HOST>
- API_KEY=<API_KEY>
- PRIVATE_KEY=<PRIVATE_KEY>
- KEYSTORE_PASSWORD=<KEYSTORE_PASSWORD>
```

In this mode:
- The keystore is generated automatically from your private key and desired password.  
- You do **not** store or pass the full keystore JSON in the YAML file, which is more secure.  
- You can deploy this node using the [SuperNoderz platform](https://www.supernoderz.com/).

### 3. Deploy with `sphnctl`

Once your `spheron.yaml` is properly configured, run:

```bash
sphnctl deployment create spheron.yml
```

## Further Help

For detailed instructions and troubleshooting, see the [official node deployment guide](https://privasea.gitbook.io/user-node-usage-documentation/comprehensive-guide-to-privanetix-node-acceleration-node-and-workheart-node-setup-and-operation/privanetix-node). If you have additional questions, refer to the [PrivaSea documentation](https://www.privasea.ai/privanetix-node).