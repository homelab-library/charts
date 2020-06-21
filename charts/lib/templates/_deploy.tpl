{{ define "lib.deployment" }}

{{ $image := .Values.image }}
{{ $replicas := .Values.replicaCount }}
{{ $pvc_mount_path := .Values.volume.path }}
{{ $resources := .Values.resources }}
{{ $arch := $resources.arch }}
{{ $limits := $resources.limits }}
{{ $requests := $resources.requests }}
{{ $data_name := print .Release.Name "-data" }}

apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "lib.rel_name" . | quote }}
  namespace: {{ include "lib.namespace" . | quote }}
{{- include "lib.labels" . | indent 2 }}
spec:
  replicas: {{ $replicas }}
  selector:
    matchLabels:
      selfhosted.appname: {{ include "lib.rel_name" . | quote }}
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        selfhosted.appname: {{ include "lib.rel_name" . | quote }}
    spec:
      nodeSelector:
        {{- if $arch }}
        kubernetes.io/arch: {{ $arch | quote }}
        {{- end }}
      containers:
        - image: {{ $image.repository | quote }}
          name: {{ include "lib.rel_name" . | quote }}
          imagePullPolicy: "{{ $image.pullPolicy }}"
          resources:
            limits:
{{ $limits | toYaml | indent 14 }}
            requests:
{{ $requests | toYaml | indent 14 }}
          volumeMounts:
            - name: {{ $data_name | quote }}
              mountPath: {{ $pvc_mount_path | quote }}
          ports:
            - containerPort: {{ $image.port }}
      volumes:
        - name: {{ $data_name | quote }}
          persistentVolumeClaim:
            claimName: {{ include "lib.pvc_name" . | quote }}
      restartPolicy: Always

{{ end }}
