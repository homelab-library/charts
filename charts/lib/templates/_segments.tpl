{{- define "lib.labels" }}
labels:
  date: {{ now | htmlDate | quote }}
  chart: {{ .Chart.Name | quote }}
  version: {{ .Chart.Version | quote }}
{{- end }}

{{ define "lib.rel_name" -}}
{{ .Release.Name }}
{{- end }}

{{ define "lib.namespace" -}}
{{ .Values.namespace }}
{{- end }}
