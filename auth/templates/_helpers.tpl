{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "charts.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "charts.labels" -}}
{{ include "charts.selectorLabels" . }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "charts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "charts.name" . }}
{{- end -}}

{{- define "charts.env" -}}
- name: POSTGRES_USER
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.postgres.secret }}
      key: user
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.postgres.secret }}
      key: password
{{- end -}}
