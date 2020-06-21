{{ define "lib.configmap" }}

apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{ include "lib.rel_name" . | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
spec:
  schedule: {{ .Values.cron.schedule | quote }}
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: {{ print "curl-" include "lib.rel_name" . }}
            image: lucashalbert/curl
            args:
              - {{ .Values.cron.url | quote }}
          restartPolicy: OnFailure

{{ end }}
