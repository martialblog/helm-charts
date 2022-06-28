# LimeSurvey

[LimeSurvey](https://limesurvey.org/) is the number one open-source survey software.

## TL;DR

```console
helm repo add martialblog https://martialblog.github.io/helm-charts
helm repo update

helm install my-release \
  --set mariadb.enabled=true \
  --set mariadb.auth.rootPassword=CHANGE-ME \
  --set mariadb.auth.password=CHANGE-ME \
  martialblog/limesurvey
```

## Introduction

This chart bootstraps LimeSurvey deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It also packages the [Bitnami MariaDB chart](https://artifacthub.io/packages/helm/bitnami/mariadb) which is required for bootstrapping a MariaDB deployment for the database requirements of the application. You can also provide your own database instance.

## Prerequisites

- Kubernetes 1.13+
- Helm 3+
- PV provisioner support in the underlying infrastructure

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `nil` |

### LimeSurvey Image parameters

| Name                | Description                                          | Value                 |
| ------------------- | ---------------------------------------------------- | --------------------- |
| `image.registry`    | LimeSurvey image registry                            | `docker.io`           |
| `image.repository`  | LimeSurvey image repository                           | `martialblog/limesurvey`   |
| `image.tag`         | LimeSurvey image tag (immutable tags are recommended) | `5-apache` |
| `image.pullPolicy`  | LimeSurvey image pull policy                          | `IfNotPresent`        |
| `image.pullSecrets` | LimeSurvey image pull secrets                         | `[]`                  |

### LimeSurvey Configuration parameters

| Name                                   | Description                                     | Value               |
| -------------------------------------- | ----------------------------------------------- | ------------------  |
| `limesurvey.admin.user`                | LimeSurvey initial Admin Username               | `admin`             |
| `limesurvey.admin.password`            | LimeSurvey initial Admin Password               | `nil`               |
| `limesurvey.admin.name`                | LimeSurvey initial Admin Full Name              | `Administrator`     |
| `limesurvey.admin.email`               | LimeSurvey initial Admin Email                  | `admin@example.com` |
| `limesurvey.listenPort`                | LimeSurvey Container port for webserver         | `8080` |
| `limesurvey.publicUrl`                 | LimeSurvey Public URL for public scripts        | `nil` |
| `limesurvey.baseUrl`                   | LimeSurvey Application Base URL                 | `nil` |
| `limesurvey.mysqlEngine`               | MySQL engine used for survey tables (MyISAM or InnoDB)       | `MyISAM` |
| `limesurvey.urlFormat`                 | LimeSurvey URL Format (path|get)                | `nil` |
| `limesurvey.showScriptName`            | LimeSurvey Script name in URL (true|false)      | `true` |
| `limesurvey.tablePrefix`               | LimeSurvey Database table prefix; set this to a single whitespace if you don't want a table prefix. | `lime_` |
| `limesurvey.tableSession`              | LimeSurvey Table sessions; For storing sessions in the database  | `false` |
| `limesurvey.debug`                     | LimeSurvey Debug level (0, 1, 2)                | `0` |
| `limesurvey.debugSql`                  | LimeSurvey SQL Debug level (0, 1, 2)            | `0` |
| `limesurvey.encrypt.keypair`           | LimeSurvey Data encryption keypair              | `nil` |
| `limesurvey.encrypt.publicKey`         | LimeSurvey Data encryption public key           | `nil` |
| `limesurvey.encrypt.secretKey`         | LimeSurvey Data encryption secret key           | `nil` |
| `limesurvey.encrypt.nonce`             | LimeSurvey Data encryption nonce                | `nil` |
| `limesurvey.encrypt.secretBoxKey`      | LimeSurvey Data encryption secret box key       | `nil` |

### Persistence Parameters

| Name                                          | Description                                                                                     | Value                   |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------- |
| `persistence.enabled`                         | Enable persistence using Persistent Volume Claims                                               | `true`                  |
| `persistence.accessModes`                     | Persistent Volume access modes                                                                  | `[ReadWriteOnce]`       |
| `persistence.size`                            | Persistent Volume size                                                                          | `5Gi`                   |
| `persistence.storageClassName`                | Persistent Volume storage class name                                                            | `nil`                   |
| `persistence.subPath`                         | Persistent Volume sub path                                                                      | `nil`                   |
| `persistence.finalizers`                      | Persistent Volume finalizers                                                                    | `[kubernetes.io/pvc-protection]` |
| `persistence.selectorLabels`                  | Persistent Volume selector labels                                                               | `{}`                    |
| `persistence.annotations`                     | persistent volume claim annotations                                                             | `{}`                    |
| `persistence.existingClaim`                   | The name of an existing PVC to use for persistence                                              | `nil`                   |

### Traffic Exposure Parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `service.type`        | LimeSurvey service type                             | `ClusterIP` |
| `service.port`        | LimeSurvey service port                             | `80` |
| `ingress.enabled`     | Enable ingress record generation for LimeSurvey     | `false` |
| `ingress.className`   | IngressClass that will be be used to implement the Ingress | `""` |
| `ingress.hosts`       | An array with hosts for the Ingress                 | `limesurvey.local` |
| `ingress.annotations` | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}` |
| `ingress.tls`         | Enable TLS configuration for the host defined at `ingress.hostname` parameter | `false` |

### Other parameters

| Name                      | Description                                      | Value |
| ------------------------- | ------------------------------------------------ | ----- |
| `imagePullSecrets`        | Docker registry secret names as an array         | `[]`  |
| `nameOverride`            | String to override the Chart Name                | `nil` |
| `fullnameOverride`        | String to fully override the Chart Name          | `nil` |
| `extraVolumeMounts`       | Additional volumes as an array                   | `[]`  |
| `extraEmptyDirMounts`     | Additional emptyDir volumes as an array          | `[]`  |
| `nodeSelector`            | Node labels for pod assignment                   | `{}`  |
| `tolerations`             | Tolerations for pod assignment                   | `{}`  |
| `affinity`                | Affinity for pod assignment                      | `{}`  |
| `podAnnotations`          | Annotations for LimeSurvey pods                  | `[]`  |
| `updateStrategy.type`     | Deployment strategy type                         | `RollingUpdate` |
| `updateStrategy.rollingUpdate` | Deployment rolling update configuration parameters | `{}` |
| `replicaCount`            | Number of LimeSurvey replicas to deploy          | `1`   |
| `autoscaling.enabled`     | Enable Horizontal POD autoscaling for LimeSurvey | `false` |
| `autoscaling.minReplicas` | Minimum number of LimeSurvey replicas            | `1`   |
| `autoscaling.maxReplicas` | Maximum number of LimeSurvey replicas            | `11`  |
| `autoscaling.targetCPUUtilizationPercentage`   | Target CPU utilization percentage    | `80`   |
| `podSecurityContext.fsGroup`    | Set LimeSurvey pod's Security Context fsGroup       | `33`   |
| `podSecurityContext.runAsUser`  | Set LimeSurvey pod's Security Context runAsUser     | `33`   |
| `podSecurityContext.runAsGroup` | Set LimeSurvey pod's Security Context runAsGroup    | `33`   |
| `containerSecurityContext.enabled`   | Enable LimeSurvey containers' Security Context | `true` |
| `containerSecurityContext.allowPrivilegeEscalation` | Default LimeSurvey containers' Security Context | `true` |

### Database Parameters

LimeSurvey requires a [MySQL- or PostgreSQL-compatible database](https://manual.limesurvey.org/Installation_-_LimeSurvey_CE#Create_a_database_user).

You can either provide your own:
```yaml
externalDatabase:
  host: hostname.example
  database: limesurvey-db
  username: limesurvey
  password: "your-super-secret-password"
```

or you can let the Helm chart provision one for you (based on [Bitnami MariaDB Helm chart](https://artifacthub.io/packages/helm/bitnami/mariadb)):
```yaml
mariadb:
  enabled: true
  auth:
    rootPassword: "please-change-me"
    database: limesurvey
    username: limesurvey
    password: "please-change-me"
```

In both cases the application will automatically be configured to use these credentials.
Please refer to the [values.yaml](./values.yaml) for all possible configuration values.

## Configuration and installation details

### LimeSurvey Administrator Password

If the initial Admin Password `limesurvey.admin.password` is not provided it will be set to a random string. You can extract the password from the Secret:

```bash
kubectl get secrets --template={{.data.limesurvey-admin-password}} | base64 -d
```

## Upgrading

### To 0.6.0

This release bumps the Bitnami MariaDB to 10.6. Follow the official instructions [official instructions](https://mariadb.com/kb/en/upgrading-from-mariadb-105-to-mariadb-106/).

## Testing

This Helm chart is tested with [helm unittest](https://github.com/quintush/helm-unittest) ([test format spec](https://github.com/quintush/helm-unittest/blob/master/DOCUMENT.md)).
You can find the test specifications in the `./tests/` directory.
Tests are automatically run in CI.

To run the tests locally, use the following command:

```
# Required for pulling the MariaDB chart
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency build

podman run --rm -v "${PWD}:/apps" docker.io/quintush/helm-unittest:3.7.1-0.2.8 --helm3 .
````
