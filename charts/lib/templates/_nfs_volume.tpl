{{ define "lib.nfs_volume" }}
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ .Release.Name }}-volume
  namespace: "{{ .Values.namespace }}"
  {{- template "selfhosted.labels" . }}
spec:
  capacity:
    storage: 50Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: {{ .Release.Name }}-class
  nfs:
    path: /nfs/{{ .Release.Name }}
    server: {{ .Values.nfsHost }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-claim
  namespace: "{{ .Values.namespace }}"
  {{- template "lib.labels" . }}
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 50Gi
  storageClassName: {{ .Release.Name }}-class
{{ end }}