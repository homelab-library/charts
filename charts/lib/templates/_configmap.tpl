{{ define "lib.configmap" }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "lib.rel_name" . | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
{{- include "lib.labels" . | indent 2 }}
data:
  application: {{ include "lib.rel_name" . | quote }}
{{ end }}
