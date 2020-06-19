{{ define "lib.file_map" }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: "{{ .Release.Name }}-configmap"
  namespace: "{{ .Values.namespace }}"
  {{- template "lib.labels" . }}
data:
  application: "{{ .Release.Name }}"
{{ end }}
