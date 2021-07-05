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
| `limesurvey.publicUrl`                 | LimeSurvey Public URL for public scripts        | `nil` |
| `limesurvey.baseUrl`                   | LimeSurvey Application Base URL                 | `nil` |
| `limesurvey.urlFormat`                 | LimeSurvey URL Format (path|get)                | `nil` |
| `limesurvey.showScriptName`            | LimeSurvey Script name in URL (true|false)      | `true` |
| `limesurvey.debug`                     | LimeSurvey Debug level (0, 1, 2)                | `0` |
| `limesurvey.debugSql`                  | LimeSurvey SQL Debug level (0, 1, 2)            | `0` |
| `limesurvey.encrypt.keypair`           | LimeSurvey Data encryption keypair              | `nil` |
| `limesurvey.encrypt.publicKey`         | LimeSurvey Data encryption public key           | `nil` |
| `limesurvey.encrypt.secretKey`         | LimeSurvey Data encryption secret key           | `nil` |

### Persistence Parameters

### Database Parameters

### External database support

You may want to have LimeSurvey connect to an external database rather than installing one inside your cluster.

```
mariadb.enabled=false
externalDatabase.host=database-host
externalDatabase.user=limesurvey
externalDatabase.password=secure-password
externalDatabase.database=limesurvey
externalDatabase.port=3306
```
