# chainlink-external-adapter-chart

This Helm chart can be used for deploying a chainlink external-adapter.

## Usage

The chart is not supposed to be deployed
with the default values contained in the `values.yaml`.

It is recommended to use this chart alongside the
[chainlink-ocr-client](../chainlink-ocr-client/README.md) chart.

### Using Helmfile

[Helmfile](https://github.com/helmfile/helmfile)
is a declarative spec for deploying Helm Charts.
It can be used to simplify the commands for rendering and deploying the Helm Chart.

External adapters should be placed in one helmfile together with the chainlink-ocr-client
for easier and complete deployment.

```yaml
---
repositories:
  - name: "chainlink-external-adapter"
    url: "https://telekom-mms.github.io/web3-helm-charts"

releases:
  - name: "awesome-adapter"
    chart: "chainlink-external-adapter/chainlink-external-adapter"
    version: "1.0.0"
    namespace: "chainlink"
    values:
      - "./awesome-adapter-values.yaml"
      - env.AWESOME_ENV_VARIABLE: "awesome"
      - secrets.API_KEY: {{ requiredEnv "API_KEY" }}
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

-<!-- markdownlint-disable MD013 -->

## Parameters

### Environment parameters

| Name            | Description                                                   | Value   |
| --------------- | ------------------------------------------------------------- | ------- |
| `env.LOG_LEVEL` | Log level for the external adapter (debug, info, warn, error) | `debug` |

### Cache parameters

| Name                         | Description                                                               | Value   |
| ---------------------------- | ------------------------------------------------------------------------- | ------- |
| `cache.enabled`              | Enable caching for the external adapter                                   | `true`  |
| `cache.cacheKeyGroup`        | Cache key group for Redis cache, set to the name of the respective bridge | `""`    |
| `cache.cacheType`            | Type of cache to use (redis, local)                                       | `redis` |
| `cache.cacheRedisHost`       | Redis host for caching                                                    | `""`    |
| `cache.cacheMaxAge`          | Maximum cache age in milliseconds                                         | `60000` |
| `cache.cacheKeyIgnoredProps` | Properties to ignore in cache key generation                              | `meta`  |

### Secrets parameters

| Name      | Description                                                                          | Value |
| --------- | ------------------------------------------------------------------------------------ | ----- |
| `secrets` | Secret values such as private keys, API keys, etc. provided as environment variables | `{}`  |

### Deployment parameters

| Name           | Description                                   | Value |
| -------------- | --------------------------------------------- | ----- |
| `replicaCount` | Number of External Adapter replicas to deploy | `1`   |

### Image parameters

| Name               | Description                                          | Value          |
| ------------------ | ---------------------------------------------------- | -------------- |
| `image.registry`   | The Docker registry for the External Adapter image   | `""`           |
| `image.repository` | The Docker repository for the External Adapter image | `""`           |
| `image.pullPolicy` | The image pull policy                                | `IfNotPresent` |
| `image.tag`        | The Docker image tag                                 | `""`           |

### Image pull secrets

| Name               | Description                                            | Value |
| ------------------ | ------------------------------------------------------ | ----- |
| `imagePullSecrets` | The secrets for pulling images from a private registry | `[]`  |

### Name override parameters

| Name               | Description                                            | Value |
| ------------------ | ------------------------------------------------------ | ----- |
| `nameOverride`     | String to partially override external-adapter.fullname | `""`  |
| `fullnameOverride` | String to fully override external-adapter.fullname     | `""`  |

### Pod Annotations parameters

| Name             | Description                   | Value |
| ---------------- | ----------------------------- | ----- |
| `podAnnotations` | Annotations to add to the pod | `{}`  |

### Pod Security Context parameters

| Name                 | Description                        | Value |
| -------------------- | ---------------------------------- | ----- |
| `podSecurityContext` | Pod security context configuration | `{}`  |

### Security Context parameters

| Name                                     | Description                          | Value   |
| ---------------------------------------- | ------------------------------------ | ------- |
| `securityContext.readOnlyRootFilesystem` | Set the root filesystem to read-only | `false` |
| `securityContext.runAsNonRoot`           | Run container as non-root user       | `true`  |
| `securityContext.runAsUser`              | User ID to run the container         | `1000`  |

### Service parameters

| Name           | Description                                         | Value       |
| -------------- | --------------------------------------------------- | ----------- |
| `service.type` | Kubernetes service type                             | `ClusterIP` |
| `service.port` | Service port for the External Adapter HTTP endpoint | `80`        |

### Resource parameters

| Name                        | Description              | Value   |
| --------------------------- | ------------------------ | ------- |
| `resources.requests.cpu`    | CPU resource requests    | `50m`   |
| `resources.requests.memory` | Memory resource requests | `64Mi`  |
| `resources.limits.cpu`      | CPU resource limits      | `200m`  |
| `resources.limits.memory`   | Memory resource limits   | `256Mi` |

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
