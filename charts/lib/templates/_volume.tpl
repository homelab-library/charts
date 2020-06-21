{{ define "lib.volume" }}

{{ $pvc_name := print .Release.Name "-claim" }}
{{ $storage_class := .Values.volume.class }}
{{ $volume_requests := .Values.volume.requests }}

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ $pvc_name | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
{{- include "lib.labels" . | indent 2 }}
spec:
  accessModes:
    - {{ .Values.volume.accessMode }}
  volumeMode: Filesystem
  resources:
    requests:
{{ $volume_requests | toYaml | indent 6 }}
  storageClassName: {{ $storage_class | quote }}

{{ end }}
