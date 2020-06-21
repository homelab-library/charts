{{ define "lib.curl" }}
{{ $curl := .Values.curl }}
{{ if $curl.enabled }}

apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{ include "lib.rel_name" . | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
spec:
  schedule: {{ $curl.schedule | quote }}
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: {{ print "curl-" (include "lib.rel_name" .) }}
            image: lucashalbert/curl
            args:
              - {{ $curl.url | quote }}
          restartPolicy: OnFailure

{{ end }}
{{ end }}
