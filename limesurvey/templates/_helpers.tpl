{{/*
Expand the name of the chart.
*/}}
{{- define "limesurvey.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "limesurvey.fullname" -}}
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

{{- define "limesurvey.mariadb.fullname" -}}
{{- printf "%s-mariadb" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "limesurvey.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "limesurvey.labels" -}}
helm.sh/chart: {{ include "limesurvey.chart" . }}
{{ include "limesurvey.selectorLabels" . }}
app.kubernetes.io/version: {{ coalesce .Values.image.tag .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "limesurvey.selectorLabels" -}}
app.kubernetes.io/name: {{ include "limesurvey.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "limesurvey.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "limesurvey.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the MariaDB Secret Name
*/}}
{{- define "limesurvey.databaseSecretName" -}}
{{- if .Values.mariadb.enabled }}
    {{- if .Values.mariadb.auth.existingSecret -}}
        {{- printf "%s" .Values.mariadb.auth.existingSecret -}}
    {{- else -}}
        {{- printf "%s" (include "limesurvey.mariadb.fullname" .) -}}
    {{- end -}}
{{- else if .Values.externalDatabase.existingSecret -}}
    {{- printf "%s" .Values.externalDatabase.existingSecret -}}
{{- else -}}
    {{- printf "%s-db-secrets" (include "limesurvey.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the LimeSurvey Secret Name
*/}}
{{- define "limesurvey.secretName" -}}
{{- if .Values.existingSecret }}
    {{- printf "%s" .Values.existingSecret -}}
{{- else -}}
    {{- printf "%s-app-secrets" (include "limesurvey.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the full URL of the LimeSurvey image (including registry, image and tag)
*/}}
{{- define "limesurvey.imageUrl" }}
{{- $registry := .Values.global.imageRegistry | default .Values.image.registry }}
{{- $registry = trimSuffix "/" $registry }}
{{- $image := .Values.image.repository }}
{{- $tag := .Values.image.tag | default .Chart.AppVersion }}
{{- if eq $registry "" -}}
    {{/* useful when you want to use a locally built image */}}
    {{- printf "%s:%s" $image $tag -}}
{{- else -}}
    {{- printf "%s/%s:%s" $registry $image $tag -}}
{{- end -}}
{{- end }}
