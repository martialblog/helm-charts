# LimeSurvey

[LimeSurvey](https://limesurvey.org/) is the number one open-source survey software.

## TL;DR

```console
helm repo add martialblog https://martialblog.github.io/helm-charts
helm repo update
helm install my-release martialblog/limesurvey
```

## Introduction

This chart bootstraps LimeSurvey deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.13+
- Helm 3+
- PV provisioner support in the underlying infrastructure

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `nil` |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |
| `global.storageClass`     | Global StorageClass for Persistent Volume(s)    | `nil` |

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

## Testing

This Helm chart is tested with [helm unittest](https://github.com/quintush/helm-unittest) ([test format spec](https://github.com/quintush/helm-unittest/blob/master/DOCUMENT.md)).
You can find the test specifications in the `./tests/` directory.
Tests are automatically run in CI.
To run the tests locally, use the following command:

```
# Required for pulling the MariaDB chart
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency build

podman run --rm -v "${PWD}:/apps" docker.io/quintush/helm-unittest:3.6.3-0.2.7 --helm3 .
````
