{{ define "lib.ingress" }}

{{ $ingress := .Values.ingress }}
{{ if $ingress.enabled }}
{{ $hostname := .Values.ingress.hostname }}
{{ $service := .Values.service }}

apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: {{ include "lib.rel_name" . | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
{{- include "lib.labels" . | indent 2 }}
  annotations:
{{ $ingress.annotations | toYaml | indent 4 }}
spec:
  rules:
  - host: {{ $hostname | quote }}
    http:
      paths:
      - path: /
        backend:
          serviceName: {{ include "lib.rel_name" . | quote }}
          servicePort: {{ $service.port }}

{{ end }}
{{ end }}
