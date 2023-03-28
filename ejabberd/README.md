# ejabberd Helm chart

A [Helm chart](https://helm.sh/docs/intro/quickstart/) for deploying the [ejabberd messaging server](https://www.ejabberd.im/) based on the [official container image](https://github.com/processone/ejabberd/blob/master/CONTAINER.md).

> ejabberd XMPP Server is a Rock Solid, Massively Scalable, Infinitely Extensible Realtime Platform

## TL;DR

```
# generate self-signed ceritifcate
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365 -nodes -subj '/CN=localhost'
# inject into cluster
kubectl create secret tls ejabberd-cert --cert=cert.pem --key=key.pem
# add Helm repository
helm repo add martialblog https://martialblog.github.io/helm-charts
# install Helm chart
helm install ejabberd martialblog/ejabberd
# check the logs
kubectl logs deploy/ejabberd
```

## Checklist

* [x] Deployment and Services
* [x] Security: minimal privileges for ejabberd (separate ServiceAccount and restricted SecurityContext)
* [x] Persistence: PVC (optional)
* [x] Certificates: [cert-manager](https://cert-manager.io/docs/) integration (optional)
* [x] Configuration: specify custom overrides for [ejabberd.yml](https://docs.ejabberd.im/admin/configuration/)
* [ ] [Clustering](https://github.com/processone/docker-ejabberd/tree/master/ecs#clustering): scale the deployment to multiple replicas
* [ ] [Reload at runtime](https://docs.ejabberd.im/admin/configuration/file-format/#reload-at-runtime): apply configuration changes without restarting the server
* [ ] Unit tests for Helm chart

## Values

To explore all configuration parameters, please visit the [values.yaml](./values.yaml) file.
It is well commented and explains all the options.

## FAQ

### How to change the ejabberd configuration?

https://github.com/processone/ejabberd/blob/master/ejabberd.yml.example

### How to use an external database?

By default, ejabberd uses its built-in [Mnesia database](https://www.erlang.org/doc/apps/mnesia/mnesia_overview) for storing messages, users accounts etc., which is an in-process local database (the same principal as SQLite).
The size of this database is limited however and it is general not recommended for production setups.

An external database can be configured with the following parameters:

```yaml

config:
  default_db: "sql"
  sql_type: "mysql"
  sql_server: "mariadb.namespace.svc.cluster.local"
  sql_port: 3306
  sql_database: "ejabberd"
  sql_username: "ejabberd"
  sql_password: "hunter2"
```

Several database types are supported, see <https://docs.ejabberd.im/admin/configuration/database/>.

### How to use a certificate?

Most XMPP clients require a TLS encrypted connection, ideally with a certificate signed by trusted root CA.
If you have the [cert-manager stack](https://cert-manager.io/docs/) installed in your Kubernetes cluster, you can create a certificate and signing request automatically like this:

```yaml
config:
  hosts:
    - example.com
  certfiles:
    - /opt/ejabberd/cert/tls.crt
    - /opt/ejabberd/cert/tls.key

certificate:
  create: true
  issuerRef:
    group: cert-manager.io
    kind: ClusterIssuer
    name: "letsencrypt-production"
```

Alternatively, with a custom certificate:

```sh
kubectl create secret tls my-ejabberd-certificate --cert=cert.pem --key=key.pem
```

```yaml
config:
  hosts:
    - example.com
  certfiles:
    - /opt/ejabberd/cert/tls.crt
    - /opt/ejabberd/cert/tls.key

certificate:
  secretName: my-ejabberd-certificate
```

## License

This Helm chart is licensed under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0) - see [LICENSE](./LICENSE).
