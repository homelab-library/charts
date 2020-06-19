{{ define "lib.service" }}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}
  namespace: "{{ .Values.namespace }}"
  {{- template "lib.labels" . }}
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
      name: http
  selector:
    id.proctor.service: {{ .Release.Name }}
{{ end }}
