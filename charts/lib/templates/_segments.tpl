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
{{ .Release.Namespace }}
{{- end }}

{{ define "lib.pvc_name" -}}
{{- if not .Values.volume.claim -}}
{{ print .Release.Name "-claim" }}
{{- else -}}
{{ .Values.volume.claim }}
{{- end -}}
{{- end }}
