{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-connect.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka-connect.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "kafka-connect.build.imageStream" -}}
{{- if .Values.build.imageStreamOverride }}
{{- .Values.build.imageStreamOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" $name "build" }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kafka-connect.labels" -}}
helm.sh/chart: {{ include "kafka-connect.chart" . }}
{{ include "kafka-connect.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: retail-connectors
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kafka-connect.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kafka-connect.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Annotations
*/}}
{{- define "kafka-connect.annotations" -}}
strimzi.io/use-connector-resources: 'true'
{{- if .Values.argocd }}
{{- if and (.Values.argocd.syncwave) (.Values.argocd.enabled) }}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.syncwave }}"
{{- end }}
{{- end }}
{{- end }}

{/*
ArgoCD Syncwave
*/}}
{{- define "kafka-connect.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}
