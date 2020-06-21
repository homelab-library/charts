{{ define "lib.service" }}

{{ $service := .Values.service }}
{{ $image := .Values.image }}

apiVersion: v1
kind: Service
metadata:
  name: {{ include "lib.rel_name" . | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
{{- include "lib.labels" . | indent 2 }}
spec:
  type: {{ $service.kind | quote }}
  ports:
    - port: {{ $service.port }}
      targetPort: {{ $image.port }}
      protocol: {{ $service.protocol }}
      name: {{ $service.name }}
  selector:
    selfhosted.appname: {{ include "lib.rel_name" . | quote }}

{{ end }}
