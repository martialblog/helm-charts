{{/*
Expand the name of the chart.
*/}}
{{- define "ejabberd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ejabberd.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ejabberd.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ejabberd.labels" -}}
helm.sh/chart: {{ include "ejabberd.chart" . }}
{{ include "ejabberd.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ejabberd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ejabberd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ejabberd.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ejabberd.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the secret that will hold the certificate
*/}}
{{- define "ejabberd.certificateSecretName" -}}
{{- if .Values.certificate.secretName }}
{{- printf "%s" .Values.certificate.secretName }}
{{- else }}
{{- printf "%s-cert" (include "ejabberd.fullname" .) }}
{{- end }}
{{- end }}


{{/*
The name of the PVC to use for persistence
*/}}
{{- define "ejabberd.pvcName" -}}
{{- if .Values.persistence.enabled }}
{{- default (printf "%s-data" (include "ejabberd.fullname" .)) .Values.persistence.claimName }}
{{- end }}
{{- end }}


{{/*
The name of the Secret used for the configuration files
*/}}
{{- define "ejabberd.configSecretName" -}}
{{- default (printf "%s-config" (include "ejabberd.fullname" .)) .Values.configSecretName }}
{{- end }}

{{/*
Supplementary scripts used by the Helm chart
*/}}
{{- define "ejabberd.scriptsConfigmapName" -}}
{{- printf "%s-scripts" (include "ejabberd.fullname" .) }}
{{- end }}
