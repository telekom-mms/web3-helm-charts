# chainlink-ocr-client-chart

This Helm chart can be used for deploying the chainlink ocr-client.

## Usage

The chart is not supposed to be deployed
with the default values contained in the `values.yaml`.

### Using Helmfile

[Helmfile](https://github.com/helmfile/helmfile)
is a declarative spec for deploying Helm Charts.
It can be used to simplify the commands for rendering and deploying the Helm Chart.

```yaml
---
repositories:
  - name: "chainlink-ocr-client"
    url: "https://telekom-mms.github.io/web3-helm-charts"

releases:
  - name: "chainlink-ocr-client"
    chart: "chainlink-ocr-client/chainlink-ocr-client"
    version: "1.0.0"
    namespace: "chainlink"
    values:
      - "./values.yaml"
      - postgres.password: {{ requiredEnv "PG_PASSWORD" }}
      - ocr.credentials.api.password: {{ requiredEnv "API_PASSWORD" }}
      - keystorePassword: {{ requiredEnv "KEYSTORE_PASSWORD" }}
...
```

### Installing the Chart

To install the chart with the release name `chainlink-ocr-client`:

#### Helm

```shell
helm repo add web3-helm-charts https://telekom-mms.github.io/web3-helm-charts
helm install chainlink-ocr-client web3-helm-charts/chainlink-ocr-client
```

#### Helmfile

```shell
helmfile apply -f ./helmfile.yaml
```

## Parameters

### Global parameters

| Name                                        | Description                                | Value  |
| ------------------------------------------- | ------------------------------------------ | ------ |
| `global.readinessProbe.enabled`             | Enable global readiness probe              | `true` |
| `global.readinessProbe.initialDelaySeconds` | Initial delay for global readiness probe   | `1`    |
| `global.readinessProbe.periodSeconds`       | Period for global readiness probe          | `5`    |
| `global.livenessProbe.enabled`              | Enable global liveness probe               | `true` |
| `global.livenessProbe.initialDelaySeconds`  | Initial delay for global liveness probe    | `1`    |
| `global.livenessProbe.periodSeconds`        | Period for global liveness probe           | `5`    |
| `global.startupProbe.enabled`               | Enable global startup probe                | `true` |
| `global.startupProbe.initialDelaySeconds`   | Initial delay for global startup probe     | `15`   |
| `global.startupProbe.periodSeconds`         | Period for global startup probe            | `5`    |
| `global.startupProbe.failureThreshold`      | Failure threshold for global startup probe | `20`   |

### Chainlink Feature parameters

| Name                   | Description                    | Value  |
| ---------------------- | ------------------------------ | ------ |
| `feature.feedsManager` | Enable Chainlink feeds manager | `true` |
| `feature.logPoller`    | Enable Chainlink log poller    | `true` |

### Chainlink Log parameters

| Name              | Description                          | Value   |
| ----------------- | ------------------------------------ | ------- |
| `log.level`       | Log level (debug, info, warn, error) | `info`  |
| `log.jsonConsole` | Enable JSON console logging          | `false` |

### Chainlink Web Server parameters

| Name                       | Description                   | Value   |
| -------------------------- | ----------------------------- | ------- |
| `webServer.secureCookies`  | Enable secure cookies         | `false` |
| `webServer.allowOrigins`   | CORS allowed origins          | `*`     |
| `webServer.tls.httpsPort`  | HTTPS port for the web server | `6689`  |
| `webServer.bridgeCacheTTL` | Bridge cache TTL duration     | `""`    |

### Chainlink OCR parameters

| Name                           | Description                      | Value   |
| ------------------------------ | -------------------------------- | ------- |
| `ocr.enabled`                  | Enable OCR (Off-Chain Reporting) | `false` |
| `ocr.keyBundleId`              | OCR key bundle identifier        | `""`    |
| `ocr.transmitterAddress`       | OCR transmitter address          | `""`    |
| `ocr.credentials.api.user`     | OCR API username                 | `""`    |
| `ocr.credentials.api.password` | OCR API password                 | `""`    |

### Chainlink OCR2 parameters

| Name                      | Description                          | Value   |
| ------------------------- | ------------------------------------ | ------- |
| `ocr2.enabled`            | Enable OCR2 (Off-Chain Reporting v2) | `false` |
| `ocr2.keyBundleId`        | OCR2 key bundle identifier           | `""`    |
| `ocr2.captureEATelemetry` | Enable EA telemetry capture for OCR2 | `false` |

### Chainlink P2P parameters

| Name                          | Description                                               | Value   |
| ----------------------------- | --------------------------------------------------------- | ------- |
| `p2p.peerId`                  | P2P peer identifier                                       | `""`    |
| `p2p.traceLogging`            | Enable P2P trace logging                                  | `false` |
| `p2p.v2.enabled`              | Enable P2P v2                                             | `true`  |
| `p2p.v2.announceAddresses`    | P2P v2 announce addresses with port from service.p2p.port | `[]`    |
| `p2p.v2.listenAddresses`      | P2P v2 listen addresses with port from service.p2p.port   | `[]`    |
| `p2p.v2.defaultBootstrappers` | Default bootstrap nodes for P2P v2                        | `[]`    |

### Chainlink EVM parameters

| Name                                                  | Description                                                        | Value                               |
| ----------------------------------------------------- | ------------------------------------------------------------------ | ----------------------------------- |
| `evm.chainId`                                         | EVM chain ID                                                       | `1`                                 |
| `evm.finalityDepth`                                   | Number of blocks to wait for finality                              | `50`                                |
| `evm.minIncomingConfirmations`                        | Minimum incoming confirmations required                            | `3`                                 |
| `evm.minContractPayment`                              | Minimum contract payment amount                                    | `0.1 link`                          |
| `evm.gasEstimator.limitDefault`                       | Default gas limit for transactions                                 | `500_000`                           |
| `evm.gasEstimator.bumpMin`                            | Minimum gas price bump                                             | `5 gwei`                            |
| `evm.gasEstimator.bumpThreshold`                      | Gas price bump threshold in blocks                                 | `6`                                 |
| `evm.headTracker.historyDepth`                        | Number of blocks to track in history                               | `100`                               |
| `evm.headTracker.maxBufferSize`                       | Maximum buffer size for head tracker                               | `3`                                 |
| `evm.transactions.forwardsEnabled`                    | Enable transaction forwarding                                      | `true`                              |
| `evm.transactions.transactionManagerV2.enabled`       | Enable transaction manager v2                                      | `true`                              |
| `evm.transactions.transactionManagerV2.blockTime`     | Expected block time                                                | `11s`                               |
| `evm.transactions.transactionManagerV2.customURL`     | Custom RPC URL for transaction manager                             | `https://rpc.flashbots.net/fast`    |
| `evm.transactions.transactionManagerV2.dualBroadcast` | Enable dual broadcast                                              | `true`                              |
| `evm.transactions.autoPurge.enabled`                  | Enable automatic transaction purge                                 | `true`                              |
| `evm.transactions.autoPurge.threshold`                | Purge threshold value                                              | `5`                                 |
| `evm.transactions.autoPurge.minAttempts`              | Minimum attempts before purge                                      | `10000`                             |
| `evm.transactions.autoPurge.detectionApiUrl`          | Detection API URL for transaction purge                            | `https://protect.flashbots.net/tx/` |
| `evm.nodes`                                           | Array of EVM node objects with name, wsurl, and httpUrl properties | `[]`                                |

### Chainlink Database parameters

| Name                  | Description                   | Value   |
| --------------------- | ----------------------------- | ------- |
| `database.logQueries` | Enable database query logging | `false` |

### PostgreSQL parameters

| Name                | Description                                                    | Value       |
| ------------------- | -------------------------------------------------------------- | ----------- |
| `postgres.host`     | PostgreSQL database host                                       | `""`        |
| `postgres.port`     | PostgreSQL database port                                       | `5432`      |
| `postgres.user`     | PostgreSQL database user                                       | `postgres`  |
| `postgres.password` | PostgreSQL database password                                   | `""`        |
| `postgres.database` | PostgreSQL database name                                       | `chainlink` |
| `postgres.sslmode`  | PostgreSQL SSL mode (disable, require, verify-ca, verify-full) | `disable`   |

### Keystore parameters

| Name               | Description                        | Value |
| ------------------ | ---------------------------------- | ----- |
| `keystorePassword` | Base64 encoded keystore passphrase | `""`  |

### Telemetry parameters

| Name                     | Description                             | Value   |
| ------------------------ | --------------------------------------- | ------- |
| `telemetry.enabled`      | Enable telemetry reporting to Chainlink | `false` |
| `telemetry.url`          | OTI telemetry URL                       | `""`    |
| `telemetry.serverPubKey` | OTI server public key                   | `""`    |
| `telemetry.logging`      | Enable telemetry logging                | `false` |
| `telemetry.bufferSize`   | Telemetry buffer size                   | `100`   |
| `telemetry.network`      | Network identifier for telemetry        | `EVM`   |
| `telemetry.chainId`      | Chain ID for telemetry                  | `1`     |
| `telemetry.nodeId`       | Node identifier for OTEL collector      | `""`    |

### Development parameters

| Name           | Description                                                                           | Value   |
| -------------- | ------------------------------------------------------------------------------------- | ------- |
| `chainlinkDev` | Enable development mode (allows webhook jobs creation, set to "false" for production) | `false` |

### Deployment parameters

| Name           | Description                            | Value |
| -------------- | -------------------------------------- | ----- |
| `replicaCount` | Number of Chainlink replicas to deploy | `1`   |

### Image parameters

| Name               | Description                                   | Value                     |
| ------------------ | --------------------------------------------- | ------------------------- |
| `image.registry`   | The Docker registry for the Chainlink image   | `docker.io`               |
| `image.repository` | The Docker repository for the Chainlink image | `smartcontract/chainlink` |
| `image.pullPolicy` | The image pull policy                         | `IfNotPresent`            |
| `image.tag`        | The Docker image tag                          | `2.30.1`                  |

### OTEL Collector parameters

| Name                                                   | Description                                        | Value                                   |
| ------------------------------------------------------ | -------------------------------------------------- | --------------------------------------- |
| `otelCollector.image.registry`                         | The Docker registry for the OTEL Collector image   | `docker.io`                             |
| `otelCollector.image.repository`                       | The Docker repository for the OTEL Collector image | `otel/opentelemetry-collector-contrib`  |
| `otelCollector.image.pullPolicy`                       | The OTEL Collector image pull policy               | `IfNotPresent`                          |
| `otelCollector.image.tag`                              | The OTEL Collector Docker image tag                | `0.140.1`                               |
| `otelCollector.resources.requests.cpu`                 | CPU resource requests for OTEL Collector           | `100m`                                  |
| `otelCollector.resources.requests.memory`              | Memory resource requests for OTEL Collector        | `128Mi`                                 |
| `otelCollector.resources.limits.cpu`                   | CPU resource limits for OTEL Collector             | `100m`                                  |
| `otelCollector.resources.limits.memory`                | Memory resource limits for OTEL Collector          | `128Mi`                                 |
| `otelCollector.securityContext.readOnlyRootFilesystem` | Set OTEL Collector root filesystem to read-only    | `true`                                  |
| `otelCollector.securityContext.runAsNonRoot`           | Run OTEL Collector as non-root user                | `true`                                  |
| `otelCollector.securityContext.runAsUser`              | User ID to run the OTEL Collector container        | `10001`                                 |
| `otelCollector.securityContext.runAsGroup`             | Group ID to run the OTEL Collector container       | `10001`                                 |
| `otelCollector.securityContext.fsGroup`                | Filesystem group ID for OTEL Collector             | `10001`                                 |
| `otelCollector.config.exporters.httpEndpoint`          | HTTP endpoint for OTEL Collector exporters         | `https://prod.telemetry.chain.link:443` |

### Image pull secrets

| Name               | Description                                            | Value |
| ------------------ | ------------------------------------------------------ | ----- |
| `imagePullSecrets` | The secrets for pulling images from a private registry | `[]`  |

### Name override parameters

| Name               | Description                                     | Value |
| ------------------ | ----------------------------------------------- | ----- |
| `nameOverride`     | String to partially override chainlink.fullname | `""`  |
| `fullnameOverride` | String to fully override chainlink.fullname     | `""`  |

### Service parameters

| Name                   | Description                               | Value          |
| ---------------------- | ----------------------------------------- | -------------- |
| `service.web.name`     | Name for the web service port             | `web-port`     |
| `service.web.type`     | Kubernetes service type for web interface | `ClusterIP`    |
| `service.web.port`     | Service port for web interface            | `6688`         |
| `service.p2p.name`     | Name for the p2p service port             | `p2p-v2-tcp`   |
| `service.p2p.type`     | Kubernetes service type for p2p interface | `LoadBalancer` |
| `service.p2p.port`     | Service port for P2P communication        | `7990`         |
| `service.p2p.nodePort` | Service port for P2P communication        | `30001`        |

### Pod Security Context parameters

| Name                 | Description                        | Value |
| -------------------- | ---------------------------------- | ----- |
| `podSecurityContext` | Pod security context configuration | `{}`  |

### Security Context parameters

| Name                                     | Description                          | Value   |
| ---------------------------------------- | ------------------------------------ | ------- |
| `securityContext.readOnlyRootFilesystem` | Set the root filesystem to read-only | `false` |
| `securityContext.runAsNonRoot`           | Run container as non-root user       | `true`  |
| `securityContext.runAsUser`              | User ID to run the container         | `14933` |

### Resource parameters

| Name                        | Description              | Value    |
| --------------------------- | ------------------------ | -------- |
| `resources.requests.cpu`    | CPU resource requests    | `350m`   |
| `resources.requests.memory` | Memory resource requests | `1024Mi` |
| `resources.limits.cpu`      | CPU resource limits      | `350m`   |
| `resources.limits.memory`   | Memory resource limits   | `1024Mi` |

### Metrics parameters

| Name                              | Description                         | Value   |
| --------------------------------- | ----------------------------------- | ------- |
| `metrics.enabled`                 | Enable Prometheus metrics           | `false` |
| `metrics.serviceMonitor.enabled`  | Enable Prometheus Service Monitor   | `false` |
| `metrics.serviceMonitor.interval` | Scrape interval for Service Monitor | `30s`   |
| `metrics.prometheusRule.enabled`  | Enable Prometheus rules             | `false` |
| `metrics.prometheusRule.rules`    | Prometheus rule definitions         | `[]`    |

### Ingress parameters

| Name                  | Description                                  | Value   |
| --------------------- | -------------------------------------------- | ------- |
| `ingress.enabled`     | Enable ingress controller resource           | `false` |
| `ingress.className`   | Ingress class name                           | `nginx` |
| `ingress.annotations` | Annotations for the Ingress resource         | `{}`    |
| `ingress.hosts`       | Hosts configuration for the Ingress resource | `[]`    |
| `ingress.tls`         | TLS configuration for the Ingress resource   | `[]`    |

### Pod Annotations parameters

| Name             | Description                   | Value |
| ---------------- | ----------------------------- | ----- |
| `podAnnotations` | Annotations to add to the pod | `{}`  |

### Node selector parameters

| Name           | Description                    | Value |
| -------------- | ------------------------------ | ----- |
| `nodeSelector` | Node labels for pod assignment | `{}`  |

### Tolerations parameters

| Name          | Description                    | Value |
| ------------- | ------------------------------ | ----- |
| `tolerations` | Tolerations for pod assignment | `[]`  |

### Affinity parameters

| Name       | Description                 | Value |
| ---------- | --------------------------- | ----- |
| `affinity` | Affinity for pod assignment | `{}`  |
