{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-connect.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "kafka-connect.build.imageStream" -}}
{{- if .Values.build.imageStreamOverride }}
{{- .Values.build.imageStreamOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" $name "build" }}
{{- end }}
{{- end }}